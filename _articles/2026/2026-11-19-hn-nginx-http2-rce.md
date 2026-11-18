---
layout: post
title: >-
  NGINX 的 HTTP/2 曝两个未认证 RCE：五个团队同时撞上同一条 2015 年的老漏洞 — HN 讨论摘要
date: 2026-11-19
hn_id: 50547374
categories: [articles]
excerpt: >-
  CVSS 4.0 打 9.2，未认证就能在 NGINX 上执行代码，其中一条漏洞在代码里躺了十一年。
  真正吵起来的却是另一件事：补丁一小时就发出来了，Ubuntu 和 Debian 却还没打上。
tagline: >-
  漏洞在代码里藏了十年，AI 把它刨了出来，发行版的补丁还在路上。
---

> 来源：HN 讨论主帖 [Unauthenticated remote code execution in Nginx](https://news.ycombinator.com/item?id=50547374)（归档快照 678 分、266 条评论，入库 100 条），原文指向 Wiz Research [Unauthenticated Remote Code Execution in NGINX: CVE-2026-123633 and CVE-2026-123007](https://www.wiz.io/blog/nginx-http2-rce-vulnerabilities)；同日关联帖 [NGINX2Root by Xint – From Nginx visitor to root of the server host](https://news.ycombinator.com/item?id=50547423)（82 分、13 条评论，入库 13 条），指向 Xint 的独立分析 nginx2root.com。本篇为聚簇模式（2 帖）。归档评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

2026 年 11 月 18 日，安全公司 Wiz Research 公开了一对 NGINX 漏洞，标题是《Unauthenticated Remote Code Execution in NGINX》。两个编号 CVE-2026-123633 与 CVE-2026-123007，CVSS 4.0 都是 9.2，定级 Critical，都属于 HTTP/2 路径上的内存安全问题。

CVE-2026-123633 是 HTTP/2 连接上的 use-after-free。触发方式在 NGINX 的「可复用连接」列表上：先只发半截 HEADERS 帧，因为此时没有活跃请求，连接被 `ngx_http_v2_handle_connection()` 标记成可复用；等剩下的帧补齐，`ngx_http_v2_create_stream()` 建起请求流，却没有把这条连接从可复用列表里摘掉。接下来 NGINX 如果要腾出连接槽位去连上游应用，`ngx_drain_connections()` 会从这份列表里挑连接关掉——内存被释放，而那个请求还在用它。要触发关闭，先得让 NGINX 在发 GOAWAY 帧时失败，比如连接已达到内部帧上限。

CVE-2026-123007 是 HTTP/2 流控计数器 `send_window` 的整数下溢。流被取消时，`ngx_http_v2_filter_cleanup()` 把没用完的额度退还回去（`h2c->send_window += window;`），却不检查退还后的值是否越过 HTTP/2 允许的上限。等客户端在数据排队期间把额度调大，退还就会把计数器顶到上限之上。接着 `ngx_http_v2_state_window_update()` 里的边界检查用无符号整数做减法算剩余空间，一旦越界就下溢成一个巨大的正数，检查因此形同虚设。这个非法长度一路传到 `ngx_http_v2_send_chain()`，被转成有符号的 `off_t` 变成负数，再在 TLS 发送路径 `ngx_ssl_send_chain()` 上变成一次越界内存拷贝。

影响面上，两个漏洞都要求受害服务器开启 HTTP/2。Wiz 在官方 1.31.7 与 1.31.8 构建上确认了带 ASLR 绕过的远程代码执行，并指出 ASLR 这类常规缓解不构成防护，因为两条链在拿到代码执行之前都可以先做内存读取。更刺眼的是 CVE-2026-123007：Wiz 在一台只提供静态文件、既没有后端应用也没有第三方模块的 NGINX 上跑出了代码执行。NGINX 支撑着超过 2.25 亿个网站，是 w3techs 统计里使用最广的开源 Web 服务器。

修复版本同时覆盖两个漏洞：NGINX OSS 为 1.30.7 stable 与 1.31.9 mainline；NGINX Plus 从 R33 起分别是 37.0.7.1 / 37.2.0.1 与 37.0.8.1 / 37.3.0.1。漏洞的年龄差得离谱——整数下溢那条能追到 1.9.5，也就是 2015 年，在代码里躺了十一年；use-after-free 那条大约六年前才埋下。升不动的话，原文给的缓解是临时关掉 HTTP/2：NGINX 1.25.1 及以后在受影响的 server 块里写 `set http2 off;`，并把 listen 指令上的 http2 参数去掉，升级完再打开。

发现方一共五家：Wiz Research、Ikotas Labs、Metnir、Rapid7、Xint。Wiz 用自家的 AI 代码扫描工具 Wiz Atlas 找到这两个漏洞，再用 Gemini 4 Carbon 和 ChatGPT 5.6 Sol 验证影响。披露节奏跟着 F5 的安全发布走：10 月 21 日报 UAF，11 月 10 日 F5 交补丁，11 月 16 日报第二个，11 月 17 日确认，11 月 18 日发布。原文还把这件事接进了一条更大的线索——上个月是 PHP2Shell，前一天是 Calif 披露的 Java4Shell，都是内存安全漏洞，也都是多个团队独立撞上。Wiz 的结论写得很直接：复杂度这道门槛正在被 AI 拆掉，它过去既挡着发现，也挡着利用。

## 讨论焦点

### 一、五个团队同时撞车：这算 bug collision 吗

最先把这个场面点出来的是 Retr0id，他直接把原文那句「五家团队独立发现」截了出来：

> "&gt; Wiz Research, Ikotas Labs, Metnir, Rapid7, and Xint independently uncovered<p>Is this some kind of record for bug collision?" — Retr0id [c:50547678]
> （译文：>「Wiz Research、Ikotas Labs、Metnir、Rapid7 和 Xint 各自独立发现」>「这算不算 bug collision 的纪录？」）

MeetingsBrowser 问得更直接：这到底是模型更强了，还是这批人手里握着同一个模型：

> "Can I take this to mean a recent model release is able to find this bug, and these groups have access to that model?<p>What are the odds several humans independently uncovered a complex vulnerability like this simultaneously?" — MeetingsBrowser [c:50547743]
> （译文：我能理解成「最近发布的模型已经能找到这个 bug，而且这些团队都用得上这个模型」吗？几个互不相识的人同时独立发现这样一个复杂漏洞，概率能有多大？）

然后 cozzyd 给出了一个让整条讨论坐不住的猜想：

> "or maybe the model leaked the exploit from one to the other..." — cozzyd [c:50547876]
> （译文：又或者，模型把利用代码从一家泄给了另一家……）

afavour 用一句话把这个猜想收进了一个更朴素的解释里：

> "When everyone is using the same tools for the same purpose..." — afavour [c:50547943]
> （译文：当所有人用同一套工具、做同一件事的时候……）

主帖发布不到一小时，Xint 团队的人就在评论区露面，顺手还承认自己多找到了几个 bug：

> "Fun collision! We (Xint) were one of the teams and actually ended up finding a few more bugs along the way." — yerimyerimie [c:50547891]
> （译文：有趣的撞车。我们（Xint）是其中一家，顺带还找到了几个别的 bug。）

### 二、AI 把「复杂度」这道门槛拆了

ryanschaefer 说这是时代投下的一道影子：

> "It’s a reflection of the times.<p>If anyone gets a hint of the space a vulnerability occupies, just point your agent at it and you have a pretty good chance of finding something. (See java4shell and the NYT reporter who was able to replicate the problem with $200 of tokens)" — ryanschaefer [c:50547875]
> （译文：这是时代的一道影子。<p>谁要是知道一个漏洞大概待在哪个范围里，把 agent 指过去，就很有机会翻出点什么。（参见 java4shell，还有那位《纽约时报》记者，用 200 美元的 token 成本就复现了这个问题。））

baobabKoodaa 干脆说，连提示都不需要了：

> "Incredible times we live in. Do we even need a &quot;hint of the space&quot; a vulnerability occupies. I mean, recent vulns have been discovered from software like nginx and... linux... can&#x27;t one of the AI labs just fire off a thousand agents looking at all the commonly used software to discover vulns? Why do we need a &quot;hint&quot;?" — baobabKoodaa [c:50549266]
> （译文：真是了不起的时代。我们还需要「知道漏洞大概待在哪个范围」这种提示吗？最近的漏洞都是在 nginx、还有……Linux……这类软件里翻出来的。AI 实验室干脆放出一千个 agent 去扫常用软件不行吗？我们要「提示」干什么？）

chpatrick 补了一条更实际的差别：

> "The difference is that the AI doesn&#x27;t get tired so you can review everything." — chpatrick [c:50549222]
> （译文：区别在于 AI 不会累，所以你可以把所有东西都审一遍。）

而这条线索早就有人接到旧账上了。Twirrim 提到，连美国政府都在推内存安全语言：

> "Even the US federal government (CISA and NSA) have been strongly advising companies to transition to memory safe languages for a couple of years now." — Twirrim [c:50548836]
> （译文：连美国联邦政府（CISA 和 NSA）都在强烈建议企业转向内存安全语言，这话已经说了好几年。）

他给的结论比口号具体：

> "We know a large percentage of vulnerabilities in software are caused by it[1]<p>Pick a language that doesn&#x27;t have these risk factors, or pick an enforceable subset of one that makes such impossible." — Twirrim [c:50548836]
> （译文：我们知道软件里很大一部分漏洞正是由这个引起的[1]<p>那就挑一门没有这类风险的语言，或者挑一门能被强制执行子集的语言，让这种问题在语言层面就不可能发生。）

同一条评论的脚注里引了 Chromium 的数据：70% 的 Chrome 漏洞由内存安全问题引起。

### 三、补丁一小时就位，发行版的补丁还在路上

最早发现不对劲的是 sebiw，他是在原文刚贴出来时读到的：

> "Uhm, am I missing something or are the patched releases not out yet? Why disclose this level of detail when the patches are not ready yet?<p>Edit: All good. They released the new versions within 30 mins." — sebiw [c:50547577]
> （译文：呃，是我漏看什么了吗，还是带补丁的版本还没发布？补丁都还没准备好，就披露到这个细节程度？<p>更新：没事了。他们在 30 分钟内就放出了新版本。）

mjhagen 给出确切的版本号：

> "Upstream fixes are available in 1.30.7 stable and 1.31.9 mainline." — mjhagen [c:50547860]
> （译文：上游的修复已经在了：1.30.7 stable 和 1.31.9 mainline。）

真正让人不安的是发行版这一侧。derhuerst 查了一圈，结论是没打：

> "Currently, the Ubuntu [1] &amp; Debian [2] packages seem unpatched." — derhuerst [c:50547953]
> （译文：目前 Ubuntu[1] 和 Debian[2] 的软件包看起来都还没打补丁。）

kijin 说得更重，把这当成一种制度性变化：

> "Nobody seems to notify major distros before publishing their latest vulnerability anymore. Coordinated patches are a thing of the past, now we just hope that somebody at Red Hat and&#x2F;or Canonical is reading HN today." — kijin [c:50548462]
> （译文：现在发布漏洞之前，没人会通知主要发行版了。协调发布已经是过去式，剩下的只能指望 Red Hat 或者 Canonical 有人今天在刷 HN。）

baggy_trough 去 oss-security 邮件列表上确认了一遍：

> "There isn&#x27;t even a mail about this on oss-security, as of now." — baggy_trough [c:50549057]
> （译文：到现在为止，oss-security 上连一封邮件都没有。）

同帖里还有 cm2187 说 Ubuntu server 也没放出修复，dannyw 说那就干脆换到 Debian，MrDOS 回了句 Debian 同样没打。至少在这条讨论发生的时候，从上游到发行版之间那截路是断的。

### 四、关掉 HTTP/2 就能安心了吗

既然两个漏洞都要 HTTP/2，一个自然的问题是：默认配置不就没事？dboreham 是这么说的：

> "The AI gods say that http&#x2F;2 is disabled in a default installation fwiw." — dboreham [c:50548005]
> （译文：AI 大神们说，默认安装里 HTTP/2 是关着的。）

antiloper 立刻把这句话拆开——默认配置连 TLS 都没开：

> "Obviously... the default configuration also doesn&#x27;t enable TLS, which is a de-facto prerequisite for HTTP 2. How many websites do you (or your &quot;AI gods&quot;) think run nginx in its default configuration?" — antiloper [c:50548280]
> （译文：显然……默认配置里也没开 TLS，而 TLS 实际上是 HTTP/2 的前提。有多少网站（或者你那些「AI 大神」觉得有多少网站）是用 nginx 默认配置在跑？）

layer8 给了一个能落到配置文件的判据：

> "The point is that it must have been deliberately enabled. TLS will generally be enabled out of necessity, whereas the chances for HTTP&#x2F;2 are much lower, and your NGINX configuration will explicitly indicate if it’s enabled. If you don’t see “http2” in your configuration, then you know you are fine." — layer8 [c:50549732]
> （译文：关键在于它一定是被人显式打开的。TLS 通常是出于必要性才开，而 HTTP/2 的概率要低得多；你的 NGINX 配置里会明确写着它有没有开。只要在配置里看不到 “http2”，那你就没问题。）

### 五、打补丁的跑步机跑不动了

pixl97 说出了这场讨论的核心矛盾：

> "Both are true. The problem is security is a much harder job than attacking.<p>Worse patching adds instability into a system, especially when you don&#x27;t have much time to test.<p>Also in the past attackers were willing to sit on exploits longer and not do things with them, now they have to act fast before someone else finds it, leading to more events faster wearing your security and patching teams out, and making users life suck.<p>Things are going to get much worse before they get better." — pixl97 [c:50548776]
> （译文：两件事都成立。问题在于，做安全比做攻击难得多。<p>打补丁本身会给系统带来不稳定，尤其是你根本没时间测试的时候。<p>过去攻击者愿意把利用代码放着不动，现在他们必须抢在别人之前动手，结果是事件来得更密更快，把安全团队和补丁团队一起耗干，让用户的日子更难过。<p>事情会先变得更糟，然后才会好转。）

jascha_eng 给的是架构层的解法：

> "well it&#x27;s a good time to pitch tech debt and infrastructure cleanup. If you aren&#x27;t making use of least-privilege permissions, service-mesh, netpols etc. this is the time to add all of that.<p>Because clearly the patching treadmill is not sustainable, you will need a a second line of defense and reduce the blast radius of every individual vulnerability." — jascha_eng [c:50548055]
> （译文：现在正好是谈技术债和基础设施清理的好时机。如果你还没用上最小权限、service mesh、netpols 这些东西，就是现在补上的时候。<p>因为打补丁这台跑步机显然不可持续，你需要第二道防线，把每个漏洞的爆炸半径压下来。）

colechristensen 则更悲观，他给的是达尔文式的答案：

> "Survival of the fittest I&#x27;m afraid will build security here.  The teams that barely ever patch or don&#x27;t have &quot;time&quot; for maintenance are going to get burned.  The &quot;we haven&#x27;t updated in 7 years so things are stable&quot; teams can&#x27;t survive." — colechristensen [c:50548849]
> （译文：我怕最后是适者生存来替安全买单。那些几乎不打补丁、或者根本没有「时间」做维护的团队会被烧掉。那些「我们七年没更新过所以很稳定」的团队活不下来。）

最悲观的 thaumaturgy 把话题从技术推到了互联网的形态，他先说自己的处境——白天上班，晚上还得给自己托管的公共服务打补丁——然后给出了那个判断：

> "The next stable equilibrium here is <i>not</i> &quot;we get a secure and open internet&quot;. The next stable equilibrium here is, &quot;we have no open internet, and the internet is now managed by just a few companies.&quot;<p>We&#x27;re already halfway there. Google and Microsoft combined already account for somewhere around 30% to 40% of email traffic. 30% of all websites are now behind Cloudflare." — thaumaturgy [c:50549324]
> （译文：下一个稳定均衡态不是「我们拥有一个安全、开放的互联网」，而是「我们没有开放互联网，互联网由少数几家公司管着」。<p>我们已经走到一半了：Google 加 Microsoft 合计占了大概 30% 到 40% 的邮件流量，30% 的网站已经放在 Cloudflare 后面。）

### 六、AI 到底在烧互联网，还是在守互联网

同一件事，评论区给出两种相反的判断。

jacobgold 的版本偏向防守方：

> "AI is securing the internet. This is great. You should assume professional hacking gangs and state actors discovered (at least some of) these vulnerabilities months and years ago." — jacobgold [c:50548492]
> （译文：AI 在保护互联网。这是好事。你应该假定那些职业黑客团伙和国家行为者早在几个月、几年前就发现了（至少其中一部分）这些漏洞。）

fn-mote 的版本正好相反：

> "AI is burning down the internet. This is insane.<p>Are we going to discover in a year that every server online this month had a rootkit installed? There’s got to be thousands who are too small time to wipe and reinstall." — fn-mote [c:50548180]
> （译文：AI 在烧掉互联网。这太疯狂了。<p>一年之后我们会不会发现，这个月上线过的每台服务器都装了 rootkit？肯定有几千台小主机连重装都懒得做。）

baby_souffle 顺手补上了攻击者侧的具体用法：

> "An attacker will just hand this to an LLM with a &quot;ping me when this is ready to use...&quot; prompt." — baby_souffle [c:50548301]
> （译文：也就多一点点。攻击者只要把利用丢给一个 LLM，再配一句「准备好了就通知我」的提示词就行。）

而 mikepurvis 认为均衡点还远：

> "One hopes, but the models are also getting smarter and deeper too. I don&#x27;t know if anyone really has a clear vision of when the future plateau state is where equilibrium is achieved on this." — mikepurvis [c:50550757]
> （译文：希望如此吧，但模型本身也在变得更聪明、更深入。我不知道有谁真的清楚未来的平台期在哪里，也就是均衡真正出现的位置。）

### 七、C 该不该退场

K0nserv 原本是嘲讽，后来认真改了自己的口：

> "EDIT: Okay, this comment was snarky and not in good spirit. To be serious, I think we are increasingly seeing that the notion that humans can write non-trivial amounts of C correctly is false. Especially in the face of AI-assisted vulnearbility hunting these programs a crumbling. This is not an indictment of humans, it&#x27;s a sign that C is not equipped to meet this moment." — K0nserv [c:50547794]
> （译文：更新：好吧，刚才那条评论是阴阳怪气，没有善意。认真说，我越来越觉得「人类能写出大量正确的 C」这个假设本身是假的。尤其在 AI 协助漏洞挖掘面前，这些程序正在瓦解。这不是对人类的指控，而是说 C 已经配不上这个时刻。）

同一个人的技术补充更精确——下溢本身任何语言都可能发生，落到越界拷贝这一步才是 C 特有的：

> "This fixes the integer underflow for CVE-2026-123007, and it&#x27;s true that the underflow can happen in any language, notwithstanding whether it&#x27;s UB or not. The issue is what happens as a consequence of this underflow, in this case: out of bounds copy, which is specific to C." — K0nserv [c:50548278]
> （译文：这修的是 CVE-2026-123007 的整数下溢。确实，下溢在任何语言里都可能发生，不管它算不算 UB。问题出在下溢的后果上：这里是越界拷贝，这一点是 C 特有的。）

uecker 反对「这锅只甩给 C」的简单结论：

> "It is not specific to C. You could have bounds checking also in C, and you can have non-checked indexing also in many other languages, including Rust.  I would agree though that many other language make it harder to not have the bounds checking, but the bigger question is why this is not done C (and the answer that this is very hard to do is false)." — uecker [c:50550947]
> （译文：这跟 C 特有的关系不大。C 里也能做边界检查，很多别的语言（包括 Rust）也能做不检查的下标访问。我同意别的语言更难犯下不检查边界这类错误，但更大的问题是，为什么 C 里不做？（说「这非常难」这个答案是站不住的。）

stevefan1999 用枪打了比方：

> "C is like a Winchester Model 1897, not saying that it is a bad gun, it is what we call it <i>the</i> good ol&#x27; Trench gun, as it ran over the war tunnels of the Great War, and it still packs a punch today, but it only has a half-cock for some level of safety, and there is no trigger disconnector either, so you can easily slam fire it. So it is way too easy to shoot yourself in the foot.<p>Nowadays we like going for a AKM&#x2F;AK74, for something maybe more complicated but far more reliable at the same time. That&#x27;s why we want Rust." — stevefan1999 [c:50548707]
> （译文：C 就像温彻斯特 1897 型霰弹枪，不是说它不是好枪，它是所谓的经典老 trench gun，一战时在地道里跑过，今天照样有威力；但它只有半安全，扳机也没保险，一不留神就走火。所以太容易伤到自己了。<p>现在大家想要的是 AKM/AK74，更复杂一点，但同一个价位上可靠得多。这就是我们要 Rust 的原因。）

citrin_ru 把责任推给复杂度本身：

> "Not surprising given how complex HTTP&#x2F;2 is. Complexity is the enemy of security." — citrin_ru [c:50548676]
> （译文：HTTP/2 这么复杂，不奇怪。复杂度是安全的敌人。）

lostmsu 的方案最激进：

> "All system critical software must be rewritten in memory-safe languages before the end of the year." — lostmsu [c:50547836]
> （译文：所有系统级关键软件，都必须在今年年底之前重写成内存安全语言。）

### 八、关联帖：补丁到位不等于风险消失

关联帖指向 Xint 的 nginx2root.com，主帖作者之一 yerimyerimie 也在主帖里替它做了预告。里面最实用的一条评论讲的是运维细节：

> "The most useful line on the page for operators is easy to miss: after updating, `nginx -s reload` does not load the new binary, you need a restart. I&#x27;d expect a fair number of hosts to be &quot;patched&quot; on disk and still running the old worker for weeks.<p>The other one is the caveat about version strings. Distro packages and container images backport fixes without changing the version, so `nginx -v` can&#x27;t confirm exposure or safety by itself." — patryk_builds [c:50548335] [thread 2]
> （译文：页面上对运维最有用的那句话很容易被略过：更新之后，`nginx -s reload` 并不会加载新二进制，你得重启。我猜会有不少主机磁盘上「已经打好补丁」，worker 却还在跑旧的，跑上好几天。<p>另一个是版本号的坑：发行版软件包和容器镜像会回合补丁而不改版本号，所以 `nginx -v` 单靠版本号没法确认自己是否受影响。）

citrin_ru 在同帖纠正了「必须重启」这个说法：

> "I hope anyone using nginx should know that &#x27;nginx -s reload&#x27; reloads only config. And you don&#x27;t necessarily need to restart - nginx can be upgraded gracefully without breaking existing connections:" — citrin_ru [c:50550072] [thread 2]
> （译文：希望用 nginx 的人都知道，`nginx -s reload` 只重载配置。而且不一定非要重启——nginx 可以优雅升级，不打断已有连接：）

Meglis 盯着 F5 公告里一处他没看懂的地方：

> "Can someone tell me why NGF is not listed as affected here ? Am I missing something ?" — Meglis [c:50549921] [thread 2]
> （译文：有人能说说为什么 NGF 没被列进受影响范围吗？我漏看什么了吗？）

sam-cop-vimes 问的是另一个被反复问到的问题——放在 Cloudflare 后面安不安全：

> "Does anyone know whether sites behind Cloudflare are affected by this or does Cloudflare provide some protection against this?" — sam-cop-vimes [c:50549550] [thread 2]
> （译文：有人知道放在 Cloudflare 后面的站点受不受影响吗？还是说 Cloudflare 能挡掉一部分？）

（原文的说法是：任何利用都要求攻击者能直接与受害 NGINX 通信，终止 HTTP/2 的 CDN 和 WAF 可能缓解利用链的某些部分，具体取决于实现。）

jl6 的观察带着点讽刺：

> "A good vuln needs a whole branding campaign these days. The discoverers get more recognition and job offers if they are known as the hero discoverers of the famous ass2elbow rather than merely CVE-2026-2828350810639." — jl6 [c:50549875] [thread 2]
> （译文：现在一个好漏洞需要一整套品牌营销。发现者如果是以「著名漏洞的英雄发现者」身份出名的，比只挂一个 CVE-2026-2828350810639 能拿到更多曝光和工作机会。）

whalesalad 提了个更实用的想法：

> "when did it become en vogue to register a domain and host a website for a specific vuln? and could watching the cert transparency log for new names in this shape lead to heads up prior to responsible disclosure." — whalesalad [c:50549611] [thread 2]
> （译文：为某个漏洞专门注册个域名、搭个网站发布，是从什么时候开始流行的？盯一下证书透明日志里这种形状的新域名，能不能在「负责任披露」之前先收到风声？）

philipwhiuk 则对这套专门注册域名的做法很不爽：

> "I really dislike a brand new vibe-coded website claiming five vulns and &quot;responsible disclosure&quot; without an actual fix already available on <a href="https:&#x2F;&#x2F;nginx.org&#x2F;" rel="nofollow">https:&#x2F;&#x2F;nginx.org&#x2F;</a><p>Responsible my ass" — philipwhiuk [c:50547568] [thread 2]
> （译文：我很讨厌这种全新的 vibe-coded 站点，宣称自己发现了五个漏洞、还「负责任披露」，可 nginx.org 上当时根本还没有可用的修复。<p>负责个屁）

而 outloudvi 对「NGINX2Root」这个命名提出了异议——它要拿到 root，还得叠上一个几个月前才公开的 SCTP 漏洞：

> "I won&#x27;t call it NGINX2Root if it requires a vuln published a quarter ago (the SCTP one, probably CVE-2026-64564) to gain root." — outloudvi [c:50548372] [thread 2]
> （译文：要是得靠一个几个月前才公开的漏洞（SCTP 那个，大概是 CVE-2026-64564）才能拿到 root，我不会叫它 NGINX2Root。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 这可能创下 bug collision 纪录 | Retr0id | 五家团队独立撞上同一处 |
| 也许是模型之间泄了题 | cozzyd | 模型把利用代码从一家泄给另一家 |
| 大家用同一套工具就是这个结果 | afavour | 同一目的、同一批工具 |
| 有个方向就能找到 | ryanschaefer | 把 agent 指过去就行 |
| 干脆放一千个 agent 扫一遍 | baobabKoodaa | 我们为什么还需要提示 |
| AI 不累，所以能全审一遍 | chpatrick | 差别就在这里 |
| 内存安全语言该换了 | Twirrim | CISA 和 NSA 早就建议过 |
| 人类写不了多少正确的 C | K0nserv | 不是人类的问题，是 C 赶不上这一刻 |
| 下溢人人可为，越界拷贝是 C 专属 | K0nserv | 后果落在这一步 |
| 这锅不该只甩给 C | uecker | C 里也能做边界检查 |
| C 像 Winchester 1897 | stevefan1999 | 半安全，一不留神就走火 |
| 复杂度是安全的敌人 | citrin_ru | HTTP/2 本身就复杂 |
| 年底之前全部重写成内存安全语言 | lostmsu | 所有系统级关键软件 |
| 补丁半小时就位了 | sebiw | 30 分钟内就放出了新版本 |
| 发行版没跟上 | derhuerst | Ubuntu 和 Debian 看起来都还没打 |
| 协调发布已经死了 | kijin | 只能指望 Red Hat 刷 HN |
| oss-security 上连邮件都没有 | baggy_trough | 传统披露渠道失效 |
| 补丁可能早就被人捡走了 | CER10TY | 扫热门仓库找 n-day 已经成了常规 |
| 安全比攻击难做 | pixl97 | 防守方的时间不够 |
| 打补丁跑步机不可持续 | jascha_eng | 该加第二道防线了 |
| 不打补丁的团队会被烧掉 | colechristensen | 七年不更新的活不下去 |
| 互联网正在被少数公司收走 | thaumaturgy | 下一个均衡态是「没有开放互联网」 |
| AI 在守互联网 | jacobgold | 假定国家行为者早就知道了 |
| AI 在烧互联网 | fn-mote | 今年上线的服务器是不是都带了 rootkit |
| 攻击者只需把利用丢给 LLM | baby_souffle | 「准备好了就通知我」 |
| reload 不等于升级 | patryk_builds | 磁盘上打了补丁，worker 还跑着旧的 |
| 优雅升级不必重启 | citrin_ru [thread 2] | nginx 能平滑换二进制 |
| 版本号不能证明自己安全 | patryk_builds [thread 2] | 发行版和镜像都回合补丁不改版本 |
| NGF 为何不在受影响列表 | Meglis [thread 2] | 是漏了吗 |
| 漏洞需要一整套品牌营销 | jl6 [thread 2] | 英雄发现者比 CVE 编号更值钱 |
| 专用域名让披露提前泄露 | whalesalad [thread 2] | 盯证书透明日志能先收到风声 |

## 总体情绪

这条讨论有三层。技术层很快达成一致：两个漏洞都要 HTTP/2，补丁是 1.30.7 与 1.31.9，升不动就 `set http2 off;`——这部分干净利落，连「是不是 RCE」都没人再争。运维层则立刻翻车：Ubuntu 和 Debian 还没打补丁，oss-security 上连封邮件都没有，`nginx -s reload` 不加载新二进制，发行版回合补丁不改版本号所以 `nginx -v` 靠不住。这两层加起来说明一件事：漏洞从代码里被挖出来花了一个下午，从上游走到你机器上的那个 worker，却要按周计。

而最上层是这次真正的分水岭——同一件事，评论区给出两种相反的判断。jacobgold 说 AI 在保护互联网，fn-mote 说 AI 在烧互联网，thaumaturgy 则跳过这两者去讲一个更冷的事实：这种短响应窗口的漏洞每多一次，就有更多流量被推给少数几家公司，开放互联网的下一个均衡态是「没有开放互联网」。没有人能给出定论，但所有人都在同一件事上达成了一致：发现漏洞的成本塌了，而修补漏洞的成本一动没动。

这道落差正好被 pixl97 那句话说尽——防守方的时间不够。攻击者可以坐着等，也可以抢在别人之前动手，反正模型不累；防守方却要在几天内验证补丁、协调灰度、通知几千台主机。所以真正的风险不是这两个 CVE，而是「下一个 CVE」到来时的那个间隔。AI 把发现周期压到了几个小时，补丁产出周期压到了一小时，从补丁到生效的那段路还是以周计——发现的速度已经追上攻击的速度，防守那条链还没开始提速。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Unauthenticated remote code execution in Nginx（HN 主帖） | <https://news.ycombinator.com/item?id=50547374> |
| 2 | Wiz Research：Unauthenticated Remote Code Execution in NGINX（原文） | <https://www.wiz.io/blog/nginx-http2-rce-vulnerabilities> |
| 3 | NGINX2Root by Xint（HN 关联帖） | <https://news.ycombinator.com/item?id=50547423> |
| 4 | Xint：NGINX2Root（关联帖原文） | <https://nginx2root.com/> |
| 5 | F5 安全公告 K000164058（评论区引用，本站未直接读取） | <https://my.f5.com/manage/s/article/K000164058> |
| 6 | NGINX 修复提交 e27f5fa（评论区引用，本站未直接读取） | <https://github.com/nginx/nginx/commit/e27f5fa84fe6e98505e70bc543b748747dad0a3b> |
| 7 | NGINX 官方文档：control / upgrade（关联帖评论引用） | <https://nginx.org/en/docs/control.html#upgrade> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 50547374 归档快照 678 分、266 条评论，入库 100 条；关联帖 50547423 为 82 分、13 条评论，入库 13 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对（本文引用的 40 条引文全部通过逐字核验，作者名一致），保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。带 `[thread 2]` 的引文来自关联帖。

漏洞技术细节（CVE-2026-123633 与 CVE-2026-123007、CVSS 4.0 评分 9.2、reusable 连接列表与 `ngx_drain_connections()` 路径、`send_window` 退款与无符号下溢、`ngx_http_v2_state_window_update()` 边界检查失效、`ngx_http_v2_send_chain()` 转 `off_t` 变负、`ngx_ssl_send_chain()` 越界拷贝、官方 1.31.7/1.31.8 构建上的 ASLR 绕过、静态文件场景代码执行、受影响版本起点 1.9.5 与 1.19.7、修复版本 1.30.7 / 1.31.9 与 NGINX Plus 各版本、`set http2 off;` 缓解、披露时间线、五家发现方、Wiz Atlas 与 Gemini 4 Carbon / ChatGPT 5.6 Sol 的验证、超过 2.25 亿个网站）均转述自 Wiz Research 原文，该文全文已读到，与归档快照（截断于 8000 字符抓取上限）内容一致。原文声明出于客户保护暂不公开利用程序，本文不给出任何利用细节。

关联帖 nginx2root.com 的正文入库仅 212 字符（只有 CVE 编号列表），其页面上的版本占比等数字仅出现在评论区引用中，本站未直接核对该页面；关联帖评论提到的 98.9% 版本占比与 Shodan 探测口径为发言者自述。F5 公告 K000164058、NGINX 修复 commit e27f5fa、nginx.org control 文档等链接来自评论区引用，本站未直接读取。文中关于 Ubuntu 与 Debian 尚未提供修复包的描述，为发贴当时评论者的观察，可能随后变化。

「复杂度不再是可以依赖的发现与利用屏障」「内存安全语言应当成为默认选择」等判断，分别出自 Wiz 原文与评论区发言者，本文按其立场转述，不作事实认定。文中所有引文观点按原帖立场呈现，不代表本项目立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
