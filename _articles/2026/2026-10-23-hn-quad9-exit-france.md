---
layout: post
title: >-
  Quad9 退出法国：日罚金砍到 1000 欧元，他还是走了
date: 2026-10-23
hn_id: 50195959
categories: [articles]
excerpt: >-
  法国法院要求 Quad9 屏蔽 beIN 认定的体育盗播域名，判决把日罚金从 58 万欧元砍到 1000 欧元，
  算下来到 11 月 14 日只有 2.4 万。Quad9 依然选择 11 月 24 日退出法国——缺的不是钱，是一份"谁住在哪里"的名单。
tagline: >-
  电话簿公司被判登记罪犯的号码，Quad9 把整本电话簿带走了。
---

## 原文概要

2026 年 10 月 21 日，法国法院对 Quad9 做出一份对互联网基础设施影响不小的判决。原告是 beIN——一家在法国设有办公室的卡塔尔公司，主张一批域名参与了其体育赛事转播权的盗播，要求 Quad9 在递归 DNS 解析层面屏蔽这些域名。Quad9 与这些域名、与其运营方都没有任何关系，但判决认定它必须在 11 月 14 日之前执行屏蔽，否则按日罚款。

Quad9 的公告里有两处数字值得单独拎出来。一是罚金本身：法院把罚金从 58 万欧元降到**每天 1000 欧元**，从判决到 11 月 14 日合计 2.4 万欧元，还不含律师费。二是尚未发生的账：Quad9 说目前还有**另外 20 起同类案件在审**，未来可能更多，而它"承受不了这些罚款的累积"。

宣布退出的是一家瑞士公益基金会，免费、不注册、不收集用户档案。它给出的四条理由链条非常具体：

1. **技术上无法按国籍分发服务**。递归解析器只看到一个 IP，服务不收费、不要求注册、不验证身份，"没有任何可靠方法判断用户属于哪个法域"。
2. **全球封锁等于域外效力**。技术上确实可以把这些域名加进恶意域名库（`9.9.9.9` 及其备用解析器使用的那个单一大库），这样判决就满足了——但法国法院的判决会因此适用于全世界用户。Quad9 说如果别的国家也想定法国的主权，整个互联网会立刻反弹。
3. **geoIP 在德国已经失败过**。2021 到 2023 年面对 Sony Music 的诉讼时，Quad9 曾用 geoIP 封禁当作过渡手段，结果原告干脆用 VPN 从德国境内绕过，法庭采纳了 Sony 的"未合规"主张，Quad9 被罚以藐视法庭。这场官司最终是 Quad9 赢了，但花了几年时间和六位数的成本。
4. **拒绝撒谎**。公告里的原话是：递归解析是被动中立的义务，Quad9"断然拒绝以违背你预期的方式篡改或隐瞒你收到的 DNS 响应"。

结论：**11 月 24 日（周二），Quad9 在法国全面停服**。公告里还有一句没被解决的抱怨：读者问"退出"在技术上究竟怎么执行——是从法国境内停止响应，还是只改服务条款，公告里没写。

## 讨论焦点

### 罚金已经小到没法当理由了

> "€365K a year is roughly the fully loaded total comp cost of a high-senior to low staff level software engineer or a mid level ML engineer at a frontier lab in Cali." — Onavo [c:50196503]
> （译文：一年 36.5 万欧元，大致相当于前沿实验室里一位资深到初级软件工程师、或中级 ML 工程师的全成本总薪酬。）

这条评论把讨论的方向掰了一下：如果按每天 1000 欧元算，一年才 36.5 万欧元，跟硅谷一个普通工程师的年成本同量级。有人立刻指出这是按"每次违规"计的，而 Quad9 自己说了还有 20 起同类案件在排队。

> "Quad9 is not Cloudflare nor Google.  It's a nonprofit, in case you blinked right at the sentence that mentioned this." — HackerThemAll [c:50198560]
> （译文：Quad9 不是 Cloudflare，也不是 Google。它是一家非营利机构——如果你眨眼跳过了那句话里提到的这一点。）

两位读者实际上在说同一件事：这是一家用捐款和志愿劳动撑起来的机构，判决拿它开刀不是因为这笔钱有多重，而是因为它刚好是链条上唯一一个能被点名、又不属于 Google 那种量级的目标。另一条评论把这层意思说得更直白：Quad9 被挑上不是因为逻辑说得通，而是因为它没有大金主撑腰。

### DNS 解析器到底算不算中立第三方

留言区最经典的类比在第一条：

> "Punishing the DNS resolver is weird. Would you punish the phone book company for having the number of a criminal listed?" — babarock [c:50196497]
> （译文：惩罚 DNS 解析器这事很奇怪。你会因为电话簿里登了一个罪犯的号码，就去罚电话簿公司吗？）

回复把类比拆了：

> "Attacking the people doing the actual bad things is hard, attacking a single unified organization is easy." — pixl97 [c:50196701]
> （译文：打真正在做坏事的人很难，打一个统一的组织很容易。）

这个区分是整场讨论的骨架。版权方要的不是正义，是可执行的目标，而公共递归解析器在工程上恰好是唯一一个"既能点名、又不真正生产内容"的环节。有评论把它跟 DMCA 拆锁的罚款量级并列——禁掉一台 Amazon 买的电子书上的数字锁，罚 25 万美元加五年监禁，理由同样不是道德，而是"这是能拿到结果的唯一合法 API"。

另一条评论试图划出法律上的界线：

> "It's one thing to say that you can't CNC machine guns for customers of your CNC-on-demand service, it's another to say you can't sell CNC machines because someone might use them to make guns." — gpm [c:50199253]
> （译文：说"你不能为 CNC 按需服务的客户加工枪管"，是一回事；说"你不能卖 CNC 机床，因为有人可能拿它造枪"，是另一回事。）

这个区分正好对应 Quad9 公告里的自我辩护：解析服务不是发工具，是自己就在做那件事；法院要求的不是"不许把工具给会用的人"，而是"不许把人导向这些站点"。

### 责任链的终点在哪：下一个该被起诉的是谁

有人顺着电话簿类比一路问下去，问到评论区炸开：

> "Where does this line of reasoning end though? Shouldn't the browser makers be blocking the sites too? What about curl? What about the OS and local DNS resolvers (unbound etc)? Maybe Ethernet and wifi cards should contain blocking logic? At some point you have to draw a line!" — iamnothere [c:50197342]
> （译文：可是这条推理的尽头在哪？浏览器厂商不是也该拦吗？`curl` 呢？操作系统和本地 DNS 解析器（比如 `unbound`）呢？难不成以太网卡和 Wi-Fi 卡里也该塞进封锁逻辑？总得在某个地方画一条线吧。）

给出的答案没有一个能让人安心：

> "The line is drawn wherever a particular judge decides it's drawn, and each judge has a different ability to understand the broader implications of the line being drawn on any individual case." — iAMkenough [c:50198463]
> （译文：线画在哪里，取决于某位法官认为它画在哪里；而每位法官对"这条线会带来什么后果"的判断力都不一样。）

也有人补了法国的实际做法作为参照：法国早先要求主要 ISP 封锁站点，发现第三方 DNS 能绕开之后才转向解析器；浏览器、网卡这些环节因为不自带 VPN 或第三方 DNS 而暂时没被波及。但立刻有人反驳 Tor 浏览器、自定义 DNS、很多系统自带 VPN 客户端这些现实——"这条责任理论让链条上每一步都要为终端用户的任何行为负责。"被问到"那这些环节什么时候也上被告席"的读者回了一句："只要没被法院审过，上面这些全都算。"

还有读者换了个司法辖区做压力测试：

> "Your framework implies that every social website needs to make a decision on whether or not users are allowed to insult the Thai monarch[0]" — iamnothere [c:50198606]
> （译文：按你这个框架推下去，每个社交网站都得先决定"允不允许用户辱骂泰国国王"，然后据此决定要不要屏蔽泰国用户。）

> "We are aware of this lawsuit. Under the Online Safety Act, any service that has links with the UK now has duties to protect UK users, no matter where in the world it is based." — logifail [c:50199880]
> （译文：我们知道这场诉讼。根据《在线安全法》，任何与英国有联系的服务都有保护英国用户的义务，无论它总部在世界的哪个角落。）

这一段的实际含义是：域外效力不是 Quad9 的一面镜子，它已经是常态。法国判决如果被接受，"某国法律 + DNS 封锁"就是一条可复制的模板。

### 德国 Sony 案的旧账：照做还可能被判藐视法庭

Quad9 公告里主动交代了 2021–2023 年那场德国官司，评论区最集中的情绪在这里：

> "Imagine doing everything possible to stop something.  They then circumvent your protections with yet another service, and you get fined." — nadermx [c:50196525]
> （译文：设想你竭尽所能去阻止某件事。他们转头用另一个服务绕开了你的防护，然后你被罚了款。）

> "And for <i>contempt of court</i> nonetheless.  That's meant for when you blatantly don't do the thing the court told you to do, not when you did it but it didn't work how the court wanted." — mitxela [c:50196978]
> （译文：而且还是以藐视法庭的罪名。那条罪名是给"公然不做法院要求的事"用的，不是给"你做了，但它没按法院期望的方式生效"用的。）

这条区分是技术上最硬的一块砖：geoIP 封锁在法律文书上无法证明"德国用户访问不到"，因为原告方自己就是绕过它的那个变量。Quad9 的教训被总结成一句——"从历史证据看，用 geoIP 的结果是被罚款。"于是法国这次连 geoIP 都不做了，直接走停服。

顺带一提，有读者澄清了原文和评论的错位：公告反复讲的是 Sony，但真正把 Quad9 告上法国法庭的是 beIN；Sony 是德国那次的原告。而 Sony 在评论区又吃了一轮"反派剧本"的评价，包括 2005 年 rootkit 旧账——"Sony 曾经是一家很棒的公司，硬件一流，服务一流。然后他们变成了一个媒体帝国。"

### 技术上根本做不到"只拦法国人"

Quad9 给出的第一条理由被评论区当作纯技术问题讨论，结论偏向"确实做不到"：

> "A recursive DNS resolver is identified just by an IP address for your system level DNS resolver to use (eg. in /etc/resolv.conf).  Even  if you assigned a random, secret IPv6 address for every individual user, they could simply share that with anyone else too. In IPv4, pretty much impossible." — necovek [c:50199025]
> （译文：递归解析器在你的系统级解析器看来就是一个 IP 地址（比如写在 `/etc/resolv.conf` 里）。就算你给每个用户分配一个随机的、保密的 IPv6 地址，他也照样可以把它分享给别人。IPv4 的话，基本没戏。）

有人追问得更具体：如果按"注册 + 居住证明"来做，用户在哪、请求从哪来怎么证明？被回以"把这个证明责任推给 IP 的合法使用者就行"。另有人指出这条路本身和 Quad9 的使命冲突——大规模用户跟踪既是对用户的隐私灾难，也会让德国那类判决顺理成章地继续往下走。

至于"退出"到底怎么落地，一位读者的判断是：

> "They don't have to. Despite Europe's best efforts, national laws are not enforceable outside the borders without lots of cooperation, and tech regulation is not an area where people are collaborating." — burnte [c:50196938]
> （译文：他们不需要那么做。尽管欧洲已经尽力了，国家法律在没有大量协作的情况下无法在边界之外执行，而技术监管恰恰不是一个人们会协作的领域。）

也有读者对公告本身提出质疑：德国那次是 geoIP 封禁，这次是"退出服务"，两者的技术动作未必相同，公告却只把德国案例当反面教材，没有解释退出究竟怎么做。这条提问在评论区没有得到回答。

### 读者的反击方案：停止解析原告的域名

这是全场情绪最直接的一支，分寸拿捏得很有意思：

> "DNS resolvers getting sued should stop resolving domains/properties of the companies suing them too when they are forced to take these kinds of actions/steps off the back of a legal decision like this." — JokerDan [c:50196742]
> （译文：被起诉的 DNS 解析器，在因为这类法律判决被迫采取行动时，也应该停止解析那些起诉它的公司的域名和资产。）

立刻有人给了一个具体到可以照着做的版本：

> "Keep resolving, but instead of resolving multiple A records, resolve just one. Fuck that one server in particular." — drdexebtjl [c:50196930]
> （译文：照常解析，但别返回多条 A 记录，只返回一条。就专门让那一台服务器难受。）

这一支被称为"照章办事式罢工"（work-to-rule），还有人补了一句更脏的实现：直接解析到黄色网站上去。真正值得注意的是反对意见——这种做法让 Quad9 没法再宣称自己是中立服务。有人给出了折中版：

> "Fair point.  I'd say "We're neutral, unless you attack us, in which case we stop being neutral about you, in  particular".  I'd still use them if this were the policy." — rpdillon [c:50197899]
> （译文：说得有道理。我会说这样一句话："我们是中立的，除非你攻击我们；那样的话，我们就不再对你中立。"如果政策是这样，我还是会用。）

然后一句话把这条路堵死：

> "Yeah, until your kid wants to use the PlayStation." — vanviegen [c:50198628]
> （译文：是啊，直到你家小孩想用 PlayStation 的时候。）

### 版权本身跑到了审判席上

讨论从 DNS 一路滑到版权制度的存废，这一段引文密度比技术段还高。

他随后把这套制度整个判为过时——它诞生于大规模复制需要工业级能力的年代，那个前提早已不存在，"我们不需要'改革'版权，需要造一套反映当代技术的新制度"。

> "You're throwing the baby out with the bathwater." — 10111001 [c:50199603]
> （译文：你这是把洗澡水和孩子一起泼掉了。）

反对方的论证集中在"排他性"这件事，而且给了一个比"作者该不该拿钱"更硬的角度：

> "They absolutely are, because an apartment building is a _rival_ good, as are all physical goods, meaning that you and somebody else cannot both own and use it at the same time. Intellectual property is a non-rival good, meaning if somebody else copies your song or story, you still have that song/story!" — logicchains [c:50198381]
> （译文：他们当然有资格，因为公寓楼是一份**竞争性**商品，所有实体商品都是如此——你和别人无法同时拥有并使用同一栋楼。知识产权是非竞争性商品，别人复制你的歌或你的故事时，你手里那份歌或故事还在！）

版权保护的是复制权，不是因为复制容易，而是因为不给你排他权，别人复制了你就一无所有。另一条更细的反驳指出"版权早于科学论文存在"这个前提本身是错的：最早的科学期刊 1665 年出版，英国的《安妮法令》1710 年才出台。

这场分支最终也没有收敛，但它暴露了一件事：在这个线程里，"谁该为侵权负责"从来不是一个技术问题，而是一个关于制度设计的问题。Quad9 的公告里那句"盗版问题该在源头解决——在内容被发布的地方"放到这条分支里，几乎是原句复述。

### 判决本身有多荒唐：DNS TTL 与球赛时长

有一位读者把判决的时间尺度算了出来：

> "...I'm dumbfounded at the idea of using real-life courts to enforce real-life sporting events' streaming rights by getting rapid injunctions against DNS providers as the means of striking at a multiply-redundant head of a piracy hydra when DNS TTLs are often longer than the actual sporting event being infringed upon." — DaiPlusPlus [c:50199402]
> （译文：……我无法理解这种做法：拿现实世界的法院去执行现实世界体育赛事的转播权，通过对 DNS 解析商快速下达禁令，去打击一条多重冗余的盗版九头蛇——而 DNS 的 TTL 往往比那场赛事本身还长。）

他的类比是：因为你打的那个电话发生在五分钟前，所以命令印电话簿的那家独立印刷厂把某个号码涂黑，而下一版印刷目录要等六个月。

同一支还有来自西班牙的对照：

> "It could always be worse, like here in Spain, where they got <i>one</i> court order a few years back, and just arbitrarily block half the internet (i.e. all of Cloudflare) whenever the futbol is on..." — swiftcoder [c:50199982]
> （译文：情况随时可能更糟。几年前西班牙拿到**一份**法院命令，就在那场球赛进行期间随意封掉半个互联网（也就是所有走 Cloudflare 的站点）……）

而最不留情面的总结只有一句：

> "France is not doing anything. This is BIG SOCCER suing the hell of everyone." — prmoustache [c:50199980]
> （译文：法国政府什么也没做。是大赛足球在把所有人往死里告。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|---------|
| 解析器是被冤枉的电话簿 | babarock | 因为登了号码就罚电话簿公司，这事很奇怪 |
| 罚谁不重要，能罚到才重要 | pixl97 | 打实际干坏事的人难，打一个统一组织容易 |
| 目标是没有大金主的那个 | artooro | Quad9 被挑上不是因为逻辑通，是因为没有大金主撑腰 |
| 罚金不是重点 | Onavo | 一年 36.5 万欧，约等于一个工程师的全成本总薪酬 |
| 20 起案件才是重点 | jubilanti | 按每次违规算，还有 20 起同类在审 |
| 它真的没钱 | HackerThemAll | Quad9 不是 Cloudflare 也不是 Google，是非营利机构 |
| 解析服务 ≠ 卖工具 | gpm | 不为客户加工枪管，与不卖 CNC 机床，是两回事 |
| 责任链没有尽头 | iamnothere | 浏览器、curl、操作系统、以太网卡——下一个告谁 |
| 线由法官随手画 | iAMkenough | 每位法官对后果的判断力都不一样 |
| 未上法庭的环节暂时安全 | progval | 上面那些全都算，前提是从没被法院审过 |
| 域外效力已是常态 | logifail | 英国 Online Safety Act 管的是"与英国有联系的服务" |
| geoIP 在德国已被证明失败 | nadermx | 你竭尽所能去挡，他们换个服务绕开，然后你被罚 |
| 藐视法庭用错了地方 | mitxela | 那条罪名是给"公然不做"用的，不是给"做了没效果"用的 |
| 按国籍分发在技术上不可能 | necovek | 递归解析器就是 IP，IPv6 地址也能随手分享给别人 |
| 境外执法靠协作 | burnte | 国家法律出了边界就不好使，技术监管恰恰不协作 |
| 公告没交代怎么执行 | necovek | 读到公告最后也没找到答案 |
| 该反过来停解析 | JokerDan | 起诉我的公司，我也停解析它的域名 |
| 具体到可以照做 | drdexebtjl | 只返回一条 A 记录，就让那一台服务器难受 |
| 反击有代价 | WhyNotHugo | 这么做就再也宣称不了自己是中立服务 |
| 折中方案可接受 | rpdillon | 我们中立，除非你攻击我们 |
| 折中方案活不长 | vanviegen | 是啊，直到你家小孩想用 PlayStation |
| 时间尺度荒谬 | DaiPlusPlus | DNS TTL 常常比那场赛事本身还长 |
| 西班牙更糟 | swiftcoder | 一份命令，封锁所有走 Cloudflare 的站点 |
| 政府没有责任 | prmoustache | 这是大赛足球在把所有人往死里告 |
| 版权制度已经过时 | betterunix2 | 版权从来不是为作者存在的，现在该整个换掉 |
| 反对废除版权 | 10111001 | 你这是把洗澡水和孩子一起泼掉了 |
| 排他性才是关键 | logicchains | 公寓是竞争性商品，一首歌是非竞争性商品 |

## 总体情绪

这场讨论的分歧不在"Quad9 该不该退出"，而在"法院有没有权力把 DNS 解析器当成责任链上的一环"。支持 Quad9 的一方反复证明技术不可行——不注册、不收费、只看 IP、连 geoIP 都被前案证伪；反对的一方其实也同意技术不可行，但他们认为不可行恰好说明这类判决本身超出了技术机构的承载范围，"线画在哪里由具体法官随手决定"这句话实际上是两边共同接受的诊断。

情绪最集中的地方留给了一个不对称：法国把 beIN 的诉求执行成了全球性后果的可能先例，而 Quad9 能做的回应只是从这块地上退出去。一位读者说得最直接——被挑上不是因为逻辑说得通，而是因为它没有大金主。这个解释同时覆盖了另外一件事：为什么没有人为"法国用户 11 月 24 日之后没有免费公共 DNS 保护"发起任何抗议，因为被牺牲的这部分用户，本来就是最没有声音的那部分。

而在所有技术细节的底下，还压着一个没人愿意先回答的问题：如果递归解析器在法律上不再是中立的被动管道，那么下一个被要求"按用户所在地返回不同答案"的服务，会是邮件服务器、CDN，还是证书签发方——而这些服务连退出一个国家的自由都没有。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Quad9 (DNS Resolver) to Exit France | https://quad9.net/news/blog/au-revoir-france/ |
| 2 | Quad9 turns the Sony case around in Dresden | https://quad9.net/news/blog/quad9-turns-the-sony-case-around-in-dresden/ |

---

<div class="disclaimer">
本文根据 Hacker News 热门讨论自动整理，不代表本站观点。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>