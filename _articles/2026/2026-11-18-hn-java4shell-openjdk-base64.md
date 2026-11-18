---
layout: post
title: >-
  Java4Shell：Base64 解码器里的堆越界写，Java 的内存安全神话栽在手写汇编上 — HN 讨论摘要
date: 2026-11-18
hn_id: 50538240
categories: [articles]
excerpt: >-
  64 个 A 加一个等号，就能在 OpenJDK 的堆上越界写 62 字节。这漏洞是 AI 找出来的，一小时发现，
  总 token 成本不到 200 美元。硬件门槛只挡住 ARM 和老 CPU，评论区真正吵起来的却是另一件事：
  「内存破坏是互联网上最常见的漏洞类别」这句话，到底该怎么读。
tagline: >-
  Java 号称内存安全，漏洞却长在它自己手写的汇编里。
---

> 来源：HN 热门榜 (/best) 主帖 [Java4Shell: RCE in OpenJDK when processing Base64](https://news.ycombinator.com/item?id=50538240)（归档快照 570 分、149 条评论），原文指向 Calif Research [Java4Shell: Write once, RCE everywhere](https://calif.io/java4shell/)；关联帖 [Java4Shell: pre-auth RCE flaw in Java 17 puts servers at risk (CVE-2026-114938)](https://news.ycombinator.com/item?id=50532118)（149 分、28 条评论，2026-11-17 上线），指向 Aikido Security 的漏洞分析。归档快照入库主帖评论 100 条、关联帖评论 28 条，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

2026 年 11 月 17 日下午 1 点（太平洋时间），OpenJDK 发布安全公告、Oracle 推送补丁，一个编号 CVE-2026-114938 的漏洞同时公开。Calif（Calif.io）在自家站点上给它取名 Java4Shell，标题叫 "Write once, RCE everywhere"，故事署名《纽约时报》。漏洞的位置很反常：不在 Java 代码里，而在 OpenJDK HotSpot 的 x86-64 Base64 intrinsic——一段为了加速解码而手写的汇编。CVSS 4.0 打分 9.2，定级 CRITICAL。

触发条件短到可以背下来：64 个大写 A 加一个等号（`"A"×64 + "="`）。在更老的 OpenJDK 17 上要 128 个 A 加等号，因为进入那条代码路径的长度门槛更高。机制是这样的：OpenJDK 在解码前按 `(ceil(输入长度/4) * 3) - padding` 计算目标缓冲区大小，65 字节的输入得到一个 50 字节的数组；而 intrinsic 里的 `bzhiq` 掩码在处理尾部填充时把 `output_len` 算成了 -1，下溢成全 1 的 `output_mask`，`evmovdqub` 于是照着这个掩码写出完整 64 字节，起始偏移 48，越过数组末尾 62 字节。Java 最终会抛 `IllegalArgumentException` 拒绝这次输入，但相邻对象已经被改写了。

越界写是定值的：缓冲区里第 1 字节有 4 bit 可控，第 2 到 63 字节不可控，其中偏移 48 到 63 的值恒为 `0x9a`。Calif 的解法借了 JavaScript 引擎的经典原语——改写一个数组的长度字段，把「定值写」升级成「长度固定但值可选」的线性写；再改写另一个数组的长度、并让它的数据随响应回显出来，就得到堆信息泄露原语，作者给它取名 JavaBleed。剩下的链条是：修复被破坏的对象让 JVM 继续活着，对应用逻辑发起纯数据攻击，把受限写升级成任意写，最后落到 Code Cache 和 JVM hook 上执行代码。

这个链条并不是一把梭。原文写得很清楚：没有通用 payload，每个目标都要单独做一份 profile——需要一条解码路径、一个活的 writer、一个能把数据回传的 reader、一套堆布局，以及一个具体的应用动作。堆布局靠 Remote Heap Feng Shui 调，用 TCP ACK 的到达时机控制请求分片投放，堆上靠「spray and pray」反复试；为了让网络时延稳定，他们干脆在目标同区另租了一台 VM。攻击清单分两档：预认证 RCE 覆盖 Keycloak、Atlassian Jira、Atlassian Confluence、JFrog Artifactory、Jenkins、PingFederate；需要登录的覆盖 Apache Kafka Broker、Apache Solr、Elasticsearch、Gerrit、Spinnaker。Struts、Spring Boot 的示例应用同样被证实可打。samczsun 还贡献了一个客户端链：Java 程序只要连上一个恶意 TLS 服务器就会被攻破，哪怕它自己不对外提供任何服务。

发现过程是这次公告里最有意思的一段。研究者 Quang Luong 先在做另一个 0 点击利用链，审计 Android Runtime 时得到一条经验：跨边界的复杂系统很难写对，但复杂也正是让难利用的 bug 变得好利用的原因。于是他把 OpenJDK HotSpot 拉下来，把审计范围指定为 JIT 编译器、intrinsics、广泛可达的 API 和密码学——具体操作是把 Codex 指到这些区域，像 2026 年的严肃安全研究员那样干。最初 Codex 带回来的大半是 slop（不可达，或者利用前提完全不现实），直到他「更用力地提示」，Codex 才报出 Base64 解码器里的内存破坏。发现用时一小时，写出第一个可用的 exploit 又两小时，总 token 成本不到 200 美元。原文把这称为「半人马黑客」：人提供上下文，AI 提供马力。同一篇文章还提了两个同门——PHP2Shell，以及藏在 Squid 代理 FTP 模块里、从 1997 年活到今年的 Squidbleed。

## 讨论焦点

### 一、漏洞本体：一个等号，62 字节越界写

先被质疑的不是影响面，而是这个漏洞的形态：主流模块里居然藏着这么朴素的逻辑错误。

> "The fact that mainstream modules have such trivial bugs in logic that can be fully covered by testing is staggering. It is about time software developers will have proper test coverage for their code, at least for basic &quot;unit&quot; modules. Maybe we can even name a testing philosophy to match it." — eyalitki [c:50538534]
> （译文：主流模块里居然有这么朴素的逻辑错误，而且完全可以被测试覆盖，这事离谱到了极点。是时候让开发者为自己的代码配上真正的测试覆盖率了，至少给那些基本「单元」模块配上。甚至我们可以给这套测试哲学起个名字。）

争议的焦点随即落在「为什么这段代码要手写汇编」上。一条回复说得很直接：

> "Why would anyone write the scalar part of a SIMD&#x27;d function in assembly code!?" — secondcoming [c:50538805]
> （译文：为什么要把一个 SIMD 函数的标量部分用汇编写出来！？）

另一位则承认手写汇编的 SIMD 有其道理，但看得脊背发凉：

> "I realize that speeding up Java&#x27;s base64 w&#x2F; SIMD probably has a measurable impact on a significant proportion of all webservers everywhere. But at the same time, implementing the entire thing in ASM, by hand, looks ... rough." — 12_throw_away [c:50540329]
> （译文：我意识到用 SIMD 加速 Java 的 Base64，大概对全世界相当一部分 web 服务器都有可测量的性能提升。但同时，整套东西用手写 ASM 实现，看起来确实很……粗糙。）

> "Wow. That JIT stub generation code is freaking terrifying: <a href="https:&#x2F;&#x2F;github.com&#x2F;openjdk&#x2F;jdk&#x2F;blob&#x2F;5177a70b385c16f26ede191fdac7aaba0bed0f8b&#x2F;src&#x2F;hotspot&#x2F;cpu&#x2F;x86&#x2F;stubGenerator_x86_64.cpp" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;openjdk&#x2F;jdk&#x2F;blob&#x2F;5177a70b385c16f26ede191f...</a><p>I suspect it&#x27;s not the only issue they&#x27;re going to find there." — cyberax [c:50539656]
> （译文：哇。这段 JIT stub 生成代码真是吓人得一批。我怀疑他们还会在那儿挖出别的问题。）

### 二、影响面：AVX-512 是门槛，门槛比想象中低

漏洞只影响带 AVX-512 VBMI 的 x86-64 机器，ARM64 不受影响。这条限制一开始让不少人松了口气：

> "AFAICT: No.<p>Edit: If I understood the article correctly, the machine needs to have <i>all</i> the four of these flags in order to be exploitable: avx512f, avx512bw, avx512vbmi, bmi2" — cpach [c:50538803]
> （译文：据我所知：不会。<p>补充：如果我理解文章没错的话，机器必须同时具备这四个标志位才可被利用：avx512f、avx512bw、avx512vbmi、bmi2。）

但紧接着就有人把现实摊开：

> "Pretty much any Intel server and most AMD servers are going to support AVX512 and conversely most VMs running in the cloud will have access to it." — formerly_proven [c:50538981]
> （译文：几乎所有 Intel 服务器和大多数 AMD 服务器都会支持 AVX-512，反过来说，云上跑的多数虚拟机也都能拿到这个能力。）

关联帖里也有人提出同样的顾虑，认为这漏洞的「通用性」不够让人放心：

> "It&#x27;s only on specific architectures though, so it kinda falls apart.  It would be impressive if the bug was so portable it let you RCE on sub-AVX512 machines and ARM and whatever too.  Maybe with the new vector API we&#x27;ll see such portable vulnerabilities." — marginalia_nu [c:50538568] [thread 2]
> （译文：不过它只在特定架构上生效，所以有点站不住脚。要是这 bug 足够通用，能在不带 AVX-512 的机器和 ARM 上都能 RCE，那才叫了不起。也许随着新的向量 API 出现，我们会看到这种可移植的漏洞。）

AMD 一侧给出了具体的年份：

> "At least on the AMD Epyc side you need a CPU that&#x27;s no older than 2023 to be vulnerable.  Naples, Rome and Milan are all AVX2-only." — marginalia_nu [c:50538850] [thread 2]
> （译文：至少在 AMD EPYC 这边，你需要 2023 年以后的 CPU 才中招。Naples、Rome、Milan 都只有 AVX2。）

发行版这一层的答案更不统一。Azul 的两条产品线命运不同：

> "Azul Core definitely is - it uses upstream HotSpot.<p>Azul Platform Prime (formerly Zing) may or may not be depending on whether they touched the base64 intrinsic. Since it is closed-source there is no way to verify via code, which is how our research team investigates ecosystem events like this." — kaboberg [c:50539883]
> （译文：Azul Core 肯定中招——它用的是上游 HotSpot。Azul Platform Prime（原 Zing）则可能中招也可能不招，取决于他们有没有动过 Base64 的 intrinsic。由于是闭源，没法通过代码验证，而我们的研究团队调查这类生态事件就是这么做的。）

Java 8 是否也在射程内，也被从原文里抠了出来：

> "The write-up itself matches your version assumption, however it also says:<p>&gt; According to Oracle, the following Oracle Java SE versions are vulnerable: 8u511b33-perf, 17.0.21.0.3, 21.0.13.0.3, 25.0.5.0.3, 27.0.1.0.3. We thank Oracle for providing this information ahead of publication time.<p>So according to Oracle at least, JRE8 versions are affected as well." — bikezen [c:50539305]
> （译文：原文确实和你的版本假设一致，但它还说了：据 Oracle 官方说法，以下 Oracle Java SE 版本受影响：8u511b33-perf、17.0.21.0.3、21.0.13.0.3、25.0.5.0.3、27.0.1.0.3。Oracle 感谢我们在发布前提供这些信息。所以至少按 Oracle 的说法，JRE 8 版本同样受影响。）

真正被低估的一层是云。有运维在排查暴露面时发现了新情况：

> "We’re using a second-tier cloud provider’s managed Kubernetes offering, and in investigating our level of exposure to this, I just learned that there is variance within a node pool on whether AVX-512 is available." — xmodem [c:50539846]
> （译文：我们用的是某二线云厂商的托管 Kubernetes。排查自己暴露程度的时候我才了解到，同一个节点池内部，有没有 AVX-512 是不一样的。）

但也有人认为这恰恰不会成为问题：

> "Question is if they expose it to the guest. Many (most?) cloud platforms will make the guest see the lowest common denominator, specifically to avoid angry customers when their working setup suddenly breaks.<p>In the case of transparent migration, I think it&#x27;s basically a must. No JIT (or even libc probably) is going to support CPU features changing at runtime." — PhilipRoman [c:50540131]
> （译文：关键在于云平台会不会把它暴露给客户实例。大多数云平台都会让客户看到「最小公分母」，正是为了避免客户的工作环境突然就崩了——那种愤怒客户。<p>在透明迁移这件事上，我觉得这基本是必须的。没有任何 JIT（大概连 libc 都不会）会支持 CPU 特性在运行时发生变化。）

### 三、止血：两条参数，和一个更大的组织问题

技术上的缓解手段其实只有两条参数，但评论区很快发现「用哪条」比「用不用」更危险：

> "You can also mitigate Java4Shell by starting OpenJDK with either:<p>-XX:-UseBASE64Intrinsics to disable hardware-accelerated Base64 encoding and decoding, or<p>-XX:UseAVX=2 to disable AVX-512. Apply this flag only on x86-64 hosts. OpenJDK on ARM doesn&#x27;t recognize it and will fail to start." — mzs [c:50538403]
> （译文：也可以通过启动参数缓解 Java4Shell，二选一：`-XX:-UseBASE64Intrinsics`，关闭硬件加速的 Base64 编解码；或者 `-XX:UseAVX=2`，关闭 AVX-512。这个参数只用在 x86-64 主机上——ARM 上的 OpenJDK 不认识它，会直接启动失败。）

> "This isn&#x27;t the best flag to mitigate, since it will fail on systems that don&#x27;t support AVX2.<p>I recommend -XX:-UseBASE64Intrinsics instead." — _msw_ [c:50538884]
> （译文：这其实不是最好的缓解参数，因为在不支持 AVX2 的系统上它会导致启动失败。我建议用 `-XX:-UseBASE64Intrinsics`。）

还有人说自己去年为别的理由设的参数刚好救了命：

> "We set UseAVX=2 on all our jdk hosts last year for unrelated thermal issues, turns out that saved us here" — Sigmazero60 [c:50538494]
> （译文：我们去年因为散热问题在所有 JDK 主机上都设了 UseAVX=2，结果这次居然正好救了我们。）

而最乐观的一条来自代理层——不过作者本人也立刻加了限定：

> "Before you keep your security team up all night, it looks like proxies save the day here. Might not be a complete fix, obviously a real patch should be applied as soon as possible.<p>&gt; Request streaming. Some current grooming profiles need partial request bodies to reach the application. A proxy that waits for the complete body removes their release timing. nginx buffers request bodies by default.<p><a href="https:&#x2F;&#x2F;calif.io&#x2F;java4shell&#x2F;#limitations" rel="nofollow">https:&#x2F;&#x2F;calif.io&#x2F;java4shell&#x2F;#limitations</a>" — yabones [c:50538586]
> （译文：在让你的安全团队通宵加班之前，看起来代理这一层能救命。可能不是完整的修复——显然真正的补丁还是得尽快打上。<p>原文的限制条件里写着：请求流式传输。有些堆布局方案需要请求体分段到达应用层，而一个等到完整 body 才放行的代理会破坏它们的释放时机。nginx 默认会缓冲请求体。）

参数之外是更大的那道坎：很多组织不是不知道，而是动不了。

> "A lot of organizations we sitting on internal bugs for years because they thought they were impossible to exploit, and now their red team can break them in hours.<p>Most businesses are stuck in a trap now. They know the software is exploitable, but they are organizationally slow in testing and rollout. They have to start moving fast with security and IT organizations that are cut to the bone, yet at the same time contain to much box checking deadweight." — pixl97 [c:50539212]
> （译文：很多组织内部压了好几年的 bug，因为以为根本不可能被利用；现在红队几小时就能打穿。<p>大多数企业现在陷在一个陷阱里：他们知道软件可被利用，但组织上的测试和发布流程太慢。他们必须快速动起来，而安全和 IT 团队已经被砍到骨头，同时还要应付大量走流程的官僚负担。）

更麻烦的是「今天安全不代表明天安全」：

> "&gt; Or, do running machines often have their CPU changed from under them without much notice?<p>I dunno about other cloud providers, but I know AWS can move your EC2 VM from one system to another transparently.  There is a server ID you can get from the metadata, but unless you&#x27;re checking it frequently, you can be moved without ever being aware." — Sohcahtoa82 [c:50539816]
> （译文：也就是说，正在运行的机器会不会在你不注意的时候被换掉 CPU？别的云厂商我不知道，但 AWS 可以把你的 EC2 实例在后台透明地迁到另一台机器上。metadata 里有个 server ID 可查，除非你频繁检查，否则你可能压根不知道自己被搬过家。）

### 四、比 Log4Shell 轻，还是比 Log4Shell 重？

这是主帖里最被反复触碰的问题，而答案分成了两派。

tptacek 的回答被很多人当成定调：

> "The Log4j comparison is always a little frustrating, because it sets the bar somewhere in the neighborhood of &quot;apocalyptic&quot;. If you&#x27;re someone who believes our response to serious vulnerabilities is inadequate, you can see how Log4Shell gives a lot of cover to companies.<p>It is <i>wild</i> to find a generalizable (if platform-specific) memory corruption vulnerability in Java core Base64 handling; the tornado sirens should clearly be going off. But yes, it&#x27;s not <i>as bad</i> as Log4Shell." — tptacek [c:50539246]
> （译文：跟 Log4j 的比较总让人有点窝火，因为那把标尺定在了「末日级」附近。如果你相信我们对严重漏洞的响应不够格，那你也看得出来 Log4Shell 给了多少公司遮羞布。<p>在 Java 核心的 Base64 处理里找到一个可泛化的（虽然平台相关）的内存破坏漏洞，这事本身就很离谱，警报当然该拉响。但没错，它没有 Log4Shell 那么严重。）

另一派则盯着「多久会出事」：

> "It feels like we’re living in interesting times. How long will it take for a bad actor to seriously compromise critical infrastructure? My bet is within six months.<p>The upside is that it’ll force legacy institutions and organizations with sub-par security to get good at security and modernize their legacy stacks. That, or get pwned in short order." — leca [c:50538337]
> （译文：感觉我们正活在一个「有意思的时代」。要过多久，坏人才会真正攻陷关键基础设施？我赌半年之内。<p>好的一面是，这会逼着那些安全水平拉胯的老牌机构和组织把安全能力提上来，把老旧技术栈现代化。要么这样，要么被迅速拿下。）

> "That’s the thing - it’s not a proverb, it’s a curse my guy" — loloquwowndueo [c:50540534]
> （译文：老兄，问题是这不是一句祝福语，这是一句诅咒。）

> "&gt; My bet is within six months<p>My bet is it already happened two months ago and there&#x27;s a whole secret scrum we only vaguely know about happening right now." — ctoth [c:50538921]
> （译文：>> 我赌半年之内。我的赌法是：这事两个月前就已经发生了，现在正有一整个我们只隐约听说过的秘密小队在处理。）

关于「已经发生了」的警告，有一条举了现实案例：

> "We&#x27;ve already seen an attack on transfusion blood storage.<p>I wouldn&#x27;t minimize the impact of the ones on supermaket freezers either. It was technically dumb and somewhat laughable, but we&#x27;re talking food. The affected chains had stores in very rural areas with elder people living in remote places,  these supermakets would be the only purveyor of long conservation food.<p>I&#x27;d argue we&#x27;re already there, albeit at small scale yet." — makeitdouble [c:50540216]
> （译文：我们已经见过针对输血冷藏库的攻击了。<p>超市冷柜的那些我也不会不当回事。技术上那事挺蠢、也挺可笑的，但那是食物。涉事的连锁超市门店分布在很偏远的农村，那里的老人住得远，那些超市是当地唯一能买到长期保存食品的地方。<p>我会说，我们其实已经到那一步了，只是规模还小。）

### 五、半人马黑客：200 美元，和「这写得太像 LLM 了」

Calif 那句「AI 提供马力、人提供上下文」在评论区引发了两股相反的反应：一股是兴奋，另一股是警惕。

兴奋的一侧先点出了资金背景：

> "Calif is an OpenAI funded shop.." — testtestmetest [c:50540335]
> （译文：Calif 是一家 OpenAI 出资的公司……）

有人立刻纠正这个说法的方向：

> "Oracle owns Java and Oracle is &quot;OpenAI funded&quot; in the sense that Oracle&#x27;s data center buildouts are being done using OpenAI as a consumer.<p>The circular financing continues!<p>But seriously, the funding here doesn&#x27;t matter any more than Project Zero&#x27;s funding comes from Google. Big companies are trying to improve security for the common software substrates of our industries &#x2F; governments." — thephyber [c:50540521]
> （译文：Oracle 拥有 Java，而 Oracle 之所以算「OpenAI 出资」，是因为 Oracle 的数据中心扩建是以 OpenAI 作为客户来做的。循环融资还在继续！<p>但说真的，这里的资金来源无关紧要，就像 Project Zero 的钱来自 Google 一样。大公司是在努力提升我们这些产业和政府共用的软件底座的安全性。）

警惕的一侧则盯着文本本身的味道：

> "This looks like Claudese - may be kind to write such things yourself if you intend for humans to read them. (For example, “ HotSpot VM: any OpenJDK build, Oracle JDK, or GraalVM JDK. Only HotSpot generates the stub. OpenJ9 and GCJ are OK. Azul Prime (Zing), which replaces C2 with its own JIT, and any VM name not recognized as HotSpot are [?], never [!].” — I tried parsing at least five times before realizing you’re asking me to decipher LLM talk)" — bonsai_spool [c:50539270]
> （译文：这读起来像是「Claude 语」——如果你是打算给人看的，或许可以自己写一写。（比如那段：“HotSpot VM: any OpenJDK build, Oracle JDK, or GraalVM JDK. Only HotSpot generates the stub. OpenJ9 and GCJ are OK. Azul Prime (Zing), which replaces C2 with its own JIT, and any VM name not recognized as HotSpot are [?], never [!].”——我至少读了五遍才意识到，你是在让我破译 LLM 黑话。））

至于这类 bug 到底是怎么被找到的，一位读者给出了他自己的答案路径：

> "Finding these kind of bugs would have required fuzzing and some kind of bound checking canaries. Not sure all bound checkers work on the hand-optimized assembly.<p>Or as it turns out an LLM! Not clear whether their agent spawned any classic tools..." — ajasmin [c:50538825]
> （译文：找到这类 bug 本来需要 fuzzing，还需要某种边界检查金丝雀。我不确定那些检查器对手工优化的汇编都管用。<p>或者说，正如结果所示，一个 LLM！不清楚他们的 agent 有没有调用经典工具……）

而真正动手复现的人，给出了一个冷静得多的判断：

> "Turning this into a reliable exploit probably still requires some expertise. It&#x27;s going to depend on heap layout at the time of the overflow. Targets won&#x27;t be auto-selecting themselves like they did for Log4Shell." — fweimer [c:50539150]
> （译文：把它变成一个可靠的 exploit，大概还是需要真本事。它取决于溢出发生那一刻的堆布局。目标不会像 Log4Shell 那样自己跳出来排队等着被利用。）

顺带一提，那位 fweimer 用 GLM 5.3 写了个金丝雀 PoC 复现出了越界写——canary 的长度字段被改成了 -1700370022。

至于「这是不是 AI 写的烂代码导致的」这种甩锅，评论区也给了回击：

> "I don&#x27;t think AI slop code is the proximal cause for most of this. It is, however, the most common meme for blame.<p>My suspicion is (1) company execs are being told to expect company extinction if they don&#x27;t force faster velocity and (2) we are increasingly building more and more complex systems, so neither AI nor humans can find all of the issues before they cause outages." — thephyber [c:50540705]
> （译文：我不认为 AI 写的垃圾代码是这类问题的主要近因，但它确实是最常见的甩锅话术。<p>我的猜测是：（1）公司高管被告知，不加速就会公司消亡；（2）我们正在构建越来越复杂的系统，所以不管是 AI 还是人类，都无法在问题引发故障前找出全部问题。）

### 六、一场关于措辞的战争：「内存破坏是最常见的漏洞类别」

关联帖那边，Calif 原文里的一句半话引爆了另一场争论。那句是：内存破坏是互联网上最常见的漏洞类别。

> "What a horribly written and misleading article. They just make things up to make themselves look good, for example &quot;Memory corruption is the most common class of vulnerability on the Internet&quot;." — iLoveOncall [c:50538774] [thread 2]
> （译文：这是一篇写得极其糟糕、极其误导的文章。他们为了让自己显得好看就随口编，比如「内存破坏是互联网上最常见的漏洞类别」这句。）

tptacek 的回击被引用得最多：

> "I like the idea that you&#x27;re just going to sort of shout down Calif on a point like this. Have you looked at their roster lately?<p>If you any part of your identity is based on the idea that firms like this aren&#x27;t finding insane vulnerabilities right now, I think after they find <i>the RCE in OpenJDK&#x27;s core Base64 processing</i> you&#x27;re going to have to consider sucking it up, taking the L, and adjusting your priors." — tptacek [c:50538788] [thread 2]
> （译文：我很喜欢「你随便挑一个点就把 Calif 批一顿」这个想法。你最近看过他们的团队名单吗？<p>如果你有任何一部分自我认同是建立在「这类公司现在根本找不到什么疯狂的漏洞」这个信念上的，那么当他们找出「OpenJDK 核心 Base64 处理里的 RCE」之后，我觉得你得考虑吞下这口气、认这个栽，然后修正自己的先验。）

另一边有人直接拿 CWE 排名说事：

> "The tone wasn&#x27;t great, but hard to argue on the facts:<p>==<p>Top 10 CWEs (2025 Ranking)<p>Rank ID Weakness Name Score<p>1 CWE-79 Cross-site Scripting (XSS) 60.38<p>2 CWE-89 SQL Injection 28.72<p>3 CWE-352 Cross-Site Request Forgery (CSRF) 13.64<p>4 CWE-862 Missing Authorization 13.28<p>5 CWE-787 Out-of-bounds Write 12.68" — cjbprime [c:50539322] [thread 2]
> （译文：语气不怎么样，但事实没法反驳：<p>==<p>2025 年 CWE 排名前十：<p>排名 编号 弱点名称 分数<p>1 CWE-79 跨站脚本（XSS）60.38<p>2 CWE-89 SQL 注入 28.72<p>3 CWE-352 跨站请求伪造（CSRF）13.64<p>4 CWE-862 授权缺失 13.28<p>5 CWE-787 越界写 12.68）

tptacek 指出这是范畴错误：

> "It&#x27;s just a category error comparison. SQLI is a web pest vulnerability†; memory corruption RCE is a vulnerability research vulnerability. They&#x27;re different disciplines. Web SQLI vulnerabilities are usually application-code-specific (not just &quot;application specific&quot;, but with a specific origin in a mistake made in application code). Big ticket vulnerability research publications are generally platform vulnerabilities; one specific coding mistake impacting thousands or millions of installs." — tptacek [c:50539885] [thread 2]
> （译文：这只是一个范畴错误的比较。SQL 注入是网络世界的害虫型漏洞†；内存破坏 RCE 是漏洞研究型漏洞。它们是两种不同的行当。Web 上的 SQL 注入通常和应用代码绑死（不只是「和应用相关」，而是有明确的来源：应用代码里的某个具体错误）。重量级的漏洞研究成果一般针对的是平台：某一个具体编码错误，影响成千上万乃至数百万个安装。）

> "These are just vulnerability researchers talking like vulnerability researchers.<p>Here&#x27;s another way to put it: well over 90% of all vulnerabilities with a market value are rooted in memory corruption." — tptacek [c:50539885] [thread 2]
> （译文：这两拨人只是在用漏洞研究者的方式说话而已。<p>换个说法：所有有市场价值的漏洞中，超过九成根植于内存破坏。）

thephyber 则把这当成一个「统计口径」问题，并顺便吐槽这场抬杠：

> "What most people are missing here is that the article didn&#x27;t need to restrict the memory corruption &quot;to the internet&quot;. If you include all of the embedded devices that are not internet enabled and that run on C code, it&#x27;s much more likely to be a true statement.<p>Also, the pedantry in this thread is boring." — thephyber [c:50540032] [thread 2]
> （译文：大多数人漏掉的是，这篇文章根本没必要把内存破坏限定在「互联网上」。如果把所有不上网、但跑着 C 代码的嵌入式设备也算进去，这句话就靠谱得多。<p>另外，这楼里的抠字眼很无聊。）

真正把这事变成人身攻击的，是另两条：

> "I have seen their comments across this site for a very long time. Unfortunately I do not respect or put any stock in what they say, because of how unbelievably rude and dogmatic they are, and always have been.<p>&quot;As a rule, strong feelings about issues do not emerge from deep understanding.&quot;" — ranger_danger [c:50540147] [thread 2]
> （译文：我很久以来一直在站内看他们的评论。遗憾的是，我不尊重也不看重他们说的话，因为他们始终鲁莽得离谱、又教条得离谱。<p>「一般来说，对某个问题强烈的情绪不会来自深刻的理解。」）

> "&gt; Have you looked at their roster lately?<p>Yeah, aren&#x27;t they the ones that jumped the gun on the PHP vuln and published their weird anime PoC video before the embargo expired?<p>No one&#x27;s questioning their technical abilities.<p>Their communication skills are dogshit, however." — mitchweaver [c:50539388] [thread 2]
> （译文：>> 你最近看过他们的团队名单吗？<p>对啊，他们不就是那个在 PHP 漏洞上抢跑、在禁运期还没结束就放出了奇葩二次元 PoC 视频的团队吗？<p>没人质疑他们的技术水平。<p>不过他们的沟通水平是真的烂。）

而最后一条把这场争论收了个尾——原来发言者自己就是 Calif 的人：

> "Not so much that I&#x27;m above criticism, I&#x27;m clearly not, so much as how funny it is to suggest &quot;coworker of Thai Duong, Tavis Ormandy, Michal Zalewski, Dion Blazakis, and Stefan Esser&quot; is a dunk." — tptacek [c:50540019] [thread 2]
> （译文：倒不是说我高人一到不接受批评，显然不是；只是「Thai Duong、Tavis Ormandy、Michal Zalewski、Dion Blazakis 和 Stefan Esser 的同事」这种说法有多好笑。）

### 七、删掉不需要的代码：vibe-uncoding 与 Tony Hoare

原文最后抛出的主张比漏洞本身更大胆：安全上真正该问的问题不是「我们能修什么」，而是「我们能不能删掉」。

> "Tony Hoare we miss you already.<p>There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies and the other way is to make it so complicated that there are no obvious deficiencies." — hinkley [c:50540968]
> （译文：Tony Hoare，我们已经很想念他了。<p>构造软件设计只有两种方式：一种是做得足够简单，明显没有缺陷；另一种是做得足够复杂，看不出明显缺陷。）

> "&quot;vibe-uncoding&quot; -- have actually been doing quite a bit of that in my older projects." — dboreham [c:50538760]
> （译文：「vibe-uncoding」——我在自己早年的项目里其实已经干了不少这种事。）

有人把这条原则推到了检查逻辑本身上：

> "Especially since that check might have further problems.  The simpler you can make your code (and still solve the problem) the better." — eru [c:50540003]
> （译文：尤其是这个检查本身可能还有别的问题。你能把代码做得越简单（同时仍然解决问题），就越好。）

而抽象层带来的代价，被算得更清楚：

> "I don&#x27;t know if I&#x27;d count paving over the reality of what you&#x27;re running with an abstraction layer as something simpler.  If anything it demonstrably makes addressing issues like these harder." — marginalia_nu [c:50540084]
> （译文：我不知道把「你实际跑的是什么」用抽象层糊过去，算不算变简单。恰恰相反，它明显让这类问题更难处理。）

最后那条把「删代码」的账单摆到了桌面上：

> "The biggest thing I have worked on recently had TWO proxies, but the second was due to process per CPU spiciness and a JVM wouldn&#x27;t benefit in the least from that. Which still leaves Conway&#x27;s Law, segregating rules and policies between two teams who manage things on their own basis. Always annoying to punch new headers through on such systems though." — hinkley [c:50540993]
> （译文：我最近做的最大的那个系统有两层代理，但第二层是因为「每 CPU 一个进程」的资源隔离，对 JVM 来说毫无意义。这还是留下了康威定律：规则和策略被分割在两个各自为政的团队手里。不过在这种系统里打通新的请求头，永远是件烦人的事。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 主流模块里的逻辑错误本该被测试覆盖 | eyalitki | 离谱到该给测试哲学起个名字 |
| 为什么标量部分要手写汇编 | secondcoming | 为什么要用汇编写 SIMD 函数的标量部分 |
| 手写 ASM 的 SIMD 实现「看起来很粗糙」 | 12_throw_away | 性能提升是真的，粗糙也是真的 |
| JIT stub 生成代码看着就吓人 | cyberax | 怀疑那儿还埋着别的问题 |
| 需要同时具备四个 CPU 标志位 | cpach | 据我所知：不会 |
| 几乎所有 Intel 服务器都支持 AVX-512 | formerly_proven | 云上虚拟机基本都能拿到 |
| 漏洞不够通用，AMD 要 2023 年后的 CPU | marginalia_nu [thread 2] | Naples、Rome、Milan 都只有 AVX2 |
| Azul Core 肯定中招，Prime 不确定 | kaboberg | 闭源，没法用代码验证 |
| JRE 8 版本同样受影响 | bikezen | Oracle 自己的清单里写着 |
| 同一节点池里 AVX-512 并不一致 | xmodem | 排查暴露面时才发现 |
| 云平台只会暴露最小公分母 | PhilipRoman | JIT 不支持 CPU 特性运行时变化 |
| 两条缓解参数，但只能在 x86-64 上用 | mzs | ARM 上会直接启动失败 |
| `-XX:UseAVX=2` 在无 AVX2 的机器上会挂 | _msw_ | 建议改用 `-XX:-UseBASE64Intrinsics` |
| 去年为散热设的参数救了命 | Sigmazero60 | UseAVX=2 无心插柳 |
| 代理层能挡一手，但不是完整修复 | yabones | nginx 默认缓冲请求体 |
| 知道可利用，却动不了 | pixl97 | 组织上的测试和发布太慢 |
| AWS 会透明迁移你的实例 | Sohcahtoa82 | 不查 metadata 你不会知道 |
| 「不是 Log4Shell 那个级别」 | tptacek | 该拉警报，但没到那一步 |
| 半年内关键基础设施会出事 | leca | 要么被迫现代化，要么被拿下 |
| 这不是祝福，是诅咒 | loloquwowndueo | 活在一个有意思的时代 |
| 也许两个月前就已被利用 | ctoth | 正在某个秘密小队手里 |
| 输血冷藏与超市冷柜都已被攻击 | makeitdouble | 那是在谈食物 |
| Calif 是 OpenAI 出资的公司 | testtestmetest | 资金来源被摆上台面 |
| 资金来源不重要，Project Zero 也是 | thephyber | 大公司在修共用底座 |
| 那段检测条件读起来像 LLM 黑话 | bonsai_spool | 我读了五遍才看懂 |
| 本来该靠 fuzzing 和边界金丝雀 | ajasmin | 或者，如结果所示，一个 LLM |
| 可靠的 exploit 仍然需要真本事 | fweimer | 目标不会自己排队等着被利用 |
| AI 垃圾代码不是主要近因 | thephyber | 但它是最常见的甩锅话术 |
| Calif 的文章写得一塌糊涂 | iLoveOncall [thread 2] | 「内存破坏最常见」这句站不住 |
| 该修正自己的先验 | tptacek [thread 2] | 他们刚拿下 OpenJDK 核心 Base64 的 RCE |
| 拿 CWE 排名说话 | cjbprime [thread 2] | 越界写只排第五 |
| 这是范畴错误，不是频次之争 | tptacek [thread 2] | 网络害虫与漏洞研究是两行当 |
| 九成有市场价值的漏洞源于内存破坏 | tptacek [thread 2] | 所有有市场价值的漏洞里超过九成 |
| 原文不必把范围限定在互联网 | thephyber [thread 2] | 把嵌入式设备算进去就成立了 |
| 抠字眼很无聊 | thephyber [thread 2] | 理解意图就不会有这楼 |
| 强烈的情绪不来自深刻的理解 | ranger_danger [thread 2] | 顺带把人的信誉也一起否掉了 |
| 技术水平没人质疑，沟通水平是 | mitchweaver [thread 2] | PHP 漏洞那次的抢跑 |
| 发言者把自己的身份扯了进来 | tptacek [thread 2] | 「现在我倒有点想当 Calif.io 的员工」 |
| Tony Hoare 的两种构造方式 | hinkley | 简单到没有缺陷，或复杂到看不出缺陷 |
| vibe-uncoding 早就在做了 | dboreham | 我老项目里就干了不少 |
| 抽象层让这类问题更难处理 | marginalia_nu | 糊掉现实不算变简单 |
| 两层代理的代价 | hinkley | 康威定律 + 请求头永远难打通 |

## 总体情绪

这帖表面在讨论一个 CVE，实际分成两个几乎不搭界的战场。技术战场上的共识来得很快：漏洞是真的，但门槛也真的存在——AVX-512、x86-64、HotSpot、JIT 编译到 C2 层级，四道条件叠起来，ARM 机器和 2023 年前的 AMD EPYC 都不在内。评论者迅速把它翻译成可执行的清单：`-XX:-UseBASE64Intrinsics` 是更安全的那条缓解参数，`-XX:UseAVX=2` 在没有 AVX2 的机器上会让 JVM 起不来，而云厂商节点池、Azul 的两条产品线这些地方，都留着「你不确定自己跑的是什么」的洞。所以技术讨论的结论是冷静的：先打补丁，别在这上面掉以轻心。

真正的裂缝出现在两个别处。一个是量级：这到底算不算另一个 Log4Shell。tptacek 那句「拉响警报，但没到 Log4Shell 那个级别」几乎成了共识，可另一批人算的是另一笔账——半年、两个月、「已经开始」。两边其实在谈不同的东西：一边谈的是「有多少系统会在明天被打到」，另一边谈的是「有多少人已经在动手」。另一半裂缝则完全出乎技术范畴：原文那句「内存破坏是互联网上最常见的漏洞类别」，被拆成了措辞、统计口径和人身攻击三层，最后连发言者自己也被卷了进来——tptacek 那句「现在我倒有点想当 Calif.io 的员工」，把火线引向了他自己。

而这两场争论背后其实共享同一个判断——评论者对「漏洞」二字的耐心正在耗尽。他们不再关心这个 CVE 怎么修，转而关心一个更根本的问题：为什么一台号称内存安全的运行时，要为了加速几百字节的解码，手写一段没人读得懂的汇编；为什么一台云主机会把「你到底跑在什么 CPU 上」这个问题，包装成客户自己都不清楚的抽象层。最能代表这种情绪的，是那句没人反驳的收尾：真正该问的不是「我们能建什么」，而是「我们能删什么」。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Java4Shell: RCE in OpenJDK when processing Base64（HN 主帖） | <https://news.ycombinator.com/item?id=50538240> |
| 2 | Calif Research：Java4Shell: Write once, RCE everywhere（原文） | <https://calif.io/java4shell/> |
| 3 | Java4Shell: pre-auth RCE flaw in Java 17 puts servers at risk (CVE-2026-114938)（HN 关联帖） | <https://news.ycombinator.com/item?id=50532118> |
| 4 | Aikido Security：Java4Shell 漏洞分析（关联帖原文） | <https://www.aikido.dev/blog/java-17-rce-vulnerability-cve-2026-114938> |
| 5 | OpenJDK 安全修复提交（stubGenerator_x86_64.cpp） | <https://github.com/openjdk/jdk/commit/5177a70b385c16f26ede191fdac7aaba0bed0f8b> |
| 6 | Semgrep 免费检测脚本（CVE-2026-114938，评论区引用） | <https://github.com/semgrep/detection-scripts/tree/main/CVE-2026-114938> |
| 7 | CIRCL 漏洞 sightings 追踪页（评论区引用） | <https://vulnerability.circl.lu/vuln/CVE-2026-114938#sightingsCorrelations> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 50538240 归档快照 570 分、149 条评论，入库 100 条；关联帖 50532118 为 149 分、28 条评论，入库 28 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。带 `[thread 2]` 的引文来自关联帖。

漏洞技术细节（CVE-2026-114938、CVSS 4.0 评分 9.2、触发输入、50 字节缓冲区与 64 字节写入、JavaBleed 命名、受影响产品清单、受影响版本与发行版列表、CPU 标志位要求、缓解参数、披露时间与补丁时间）均转述自 Calif Research 原文，该文全文已读到，与归档快照（截断于 8000 字符抓取上限）部分内容一致。

`canary.length = -1700370022` 一项转述自评论区成员 fweimer 贴出的金丝雀 PoC 输出，属其自述复现结果，本文未独立验证。原文提到的 Keycloak、Jira、Confluence、Artifactory、Jenkins、PingFederate、Kafka、Solr、Elasticsearch、Gerrit、Spinnaker 等产品可被 RCE、以及 ARM64 不受影响、OpenJDK 17.0.6 以上受影响等结论，均为 Calif 官方披露的实测结果，原文亦声明攻击链尚未公开、产品级利用链在所有人升级前保持私有。

「内存破坏是最常见的漏洞类别」一句的原文表述、CWE 2025 排名（XSS 60.38、SQL 注入 28.72、CSRF 13.64、授权缺失 13.28、越界写 12.68）、以及「九成有市场价值的漏洞源于内存破坏」等说法分别为原文、评论区与 tptacek 的个人判断，本文按发言者立场转述，不作事实认定。Debian/Ubuntu 是否已打补丁在评论区存在直接冲突的描述（nikanj 称 Debian 已修、cpach 找不到 Debian advisory、mitchweaver 称 Debian 尚未修），本文按原帖并列呈现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
