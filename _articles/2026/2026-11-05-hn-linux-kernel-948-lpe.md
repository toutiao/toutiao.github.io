---
layout: post
title: >-
  OpenAI 流水线扫出 948 个 Linux 内核提权漏洞，API 成本 120 万美元 — HN 讨论摘要
date: 2026-11-05
hn_id: 50372929
categories: [articles]
excerpt: >-
  五阶段 agent 流水线扫过 280 万行内核代码，产出 2308 个候选、复现 1724 个、
  做成 948 个提权漏洞补丁，账单 120 万美元。评论区争的不是能不能找到，
  是还剩多少，以及谁来付钱。
tagline: >-
  他们没让内核变安全，他们只是把「我们不知道有多少」换成了「至少 948 个」。
---

> 来源：HN 讨论主帖 [A thousand fewer paths to root](https://news.ycombinator.com/item?id=50372929)，提交者 dangelosaurus，343 分，243 条评论。原文：[A thousand fewer paths to root — OpenAI](https://openai.com/index/a-thousand-fewer-paths-to-root/)（2026-11-04 发布）。本篇为单帖模式。归档快照 2026-11-05 10:27 UTC，本地归档抓到 100 条评论（主帖共 243 条），文中引文均出自这 100 条。

## 原文概要

2026 年 11 月 4 日，OpenAI 在官方博客发布《A thousand fewer paths to root》，来自 Cyber 团队，主体是一套自主的漏洞发现、验证、利用性评估与补丁生成流水线，核心是一个尚未公布名称的网络安全模型。文章给出的运行结果：一次运行中确认并生成补丁的 Linux 内核本地提权（LPE）漏洞 948 个，API 成本 120 万美元。同一篇里还提到，6 月的「Patch the Planet」计划中，GPT-5.5 Cyber 已经找出过 24 个 LPE，这次是把单点尝试扩成流水线。

流水线分五段：漏洞发现、动态验证、利用性评估、补丁生成、人工复核。发现阶段先由 Scout agent 通读目录和文件，按「低权限用户可达」和「安全相关性」挑出 5034 个审计目标，合计约 280 万行代码，约占 4000 多万行内核的 7%，这一段花了 3426 美元；随后 Analyst agent 按 Codex Security 插件的思路逐个分析，12 小时内产出 2308 个去重后的候选发现，花了 316,549 美元。

验证阶段是整条流水线最吃成本也最吃工程的一段。系统只对满足三个条件的候选动手：低权限用户可达、不需要特殊 capability、能观测到内存破坏的可测量证据。每个候选由 triage agent 生成 PoC，在开着 KASAN 的隔离虚拟机里反复跑，直到复现或者触发方式穷尽。30 小时内复现 1724 个，约占候选的 74.7%；没复现的多数不是误报，而是需要更高权限，或撞上难复现的竞态、依赖特定触发条件（比如某一行的一次分配失败），或验证本身太耗时（引用计数回绕）。模型自己分析错、报告了不可能成立条件的比例只有 3.1%。这一段花了 73,330 美元。

最终产物不是一个概念验证，而是四件套：根因分析、最小崩溃 PoC、候选补丁、完整可用的 exploit，供人类研究员判断严重程度并报给内核维护者。文章说流程从关键漏洞起步，正与 Patch the Planet 的伙伴一起推进后续报告和补丁。成本段落里 OpenAI 特意声明这次的重点是方法与能力测量而非成本，并称更好的 harness 工程能明显压低各段开销，报告出的数字应视为上界。

## 讨论焦点

### 一、内核里怎么会有 1000 个提权漏洞

抛出问题的是 Plasmoid：

> "How did we get to the point where there are a thousand privilege escalation exploits in the kernel?" — Plasmoid [c:50373228]

> （我们是怎么走到内核里有一千个提权 exploit 这一步的？）

被顶上来的回答是一句玩笑：

> "We developed AIs that can find them." — antonvs [c:50373269]

> （我们自己造了 AI 来找到它们。）

玩笑底下是共识。rubinlinux 一句话把时间线拉回上世纪：

> "This has been true for DECADES." — rubinlinux [c:50373333]

> （这事已经成立几十年了。）

p-e-w 把原因摊在代码量上：

> "How can it be surprising that a software made from 40+ million lines of memory-unsafe code has hundreds of critical bugs?" — p-e-w [c:50373319]

> （一个 4000 多万行、内存不安全的软件里有几百个严重 bug，有什么好惊讶的？）

真正给出解释的是 pianopatrick，他把技术问题翻译成了预算问题：

> "Because the large corporations that fund Linux development and use Linux value speed over security." — pianopatrick [c:50373883]

> （因为资助 Linux 开发、又使用 Linux 的大公司，更看重速度而不是安全。）

> "It's a business tradeoff between cost of servers vs cost of getting hacked, and cost of servers wins." — pianopatrick [c:50373883]

> （这是服务器成本和被黑成本之间的商业取舍，而服务器成本赢了。）

这两条把整场讨论的基调定了下来：内核里的提权漏洞不是 AI 造成的，也不是什么新事实，AI 只是第一次让这件事有了规模、有了报价单。

### 二、120 万美元：谁付得起，以及能买什么

最常见的羡慕来自 zahlman：

> "Imagine if open-source organizations other than the Linux Foundation (and Mozilla I guess) could throw $1.2M of API-rate LLM usage at security." — zahlman [c:50373126]

> （想象一下，如果 Linux 基金会（还有 Mozilla 吧）之外的开源组织也能砸 120 万美元的 API 额度来做安全。）

azan_ 的算法完全相反，他把 AI 当成持续性工具而不是一次性项目：

> "And also it costs me 200$ now to find these bugs. I don’t think I could hire software engineer for that much." — azan_ [c:50374597]

> （而且现在我花 200 美元就能找到这些漏洞，这点钱请不起一个软件工程师。）

两种算法之间差的不是观点，是计价口径：120 万是「一次跑完一个内核」的价格，200 美元是「一个目标」的价格。评论区没人为此达成共识，因为文章本身只公布了前者的账单。

真正被忽略的是下游的人力。konaraddi 指出报告数量与复核速度之间的落差：

> "948 results is a high number to review in a timely manner unless your team is very large or spending several months combing through the results" — konaraddi [c:50373188]

> （948 条结果，除非团队很大、或者花上几个月逐条过，否则很难及时看完。）

于是读者要的就不是那个总数了，而是一份能照着修的清单：

> "I wish these blog posts included statistics on the categories of deficiencies that cause these vulnerabilities, and proposed measures to avoid them" — farisght [c:50373145]

> （我希望这类博客能附上导致这些漏洞的缺陷类别统计，以及对应的避免措施。）

没有分布，948 就只是一个吓人的数字；有了分布，它才是可以被排期的工作。

### 三、团队答了什么，又没答什么

真正在评论区里回答问题的是 ky1ebot1337，他自述是这条流水线的作者，刚注册账号来答疑。他先澄清了「948」到底怎么数：

> "These are distinct vulnerabilities counted by the number of patches. The patch generation system performs variant analysis. So, each patch can potentially stop multiple exploits." — ky1ebot1337 [c:50373607]

> （这些是按补丁数量计的不同漏洞。补丁生成系统会做变体分析，所以一个补丁有可能同时堵住多个 exploit。）

> "These vulns are all kernel specific. Userspace software running as root was not in scope of the analysis." — ky1ebot1337 [c:50373607]

> （这些漏洞全部属于内核本身，以 root 运行的用户态软件不在分析范围内。）

被追问「以前为什么找不到」时，antonvs 的回答很直接：

> "Why do you think we didn’t find these 948 vulnerabilities before now?" — antonvs [c:50374199]

> （你觉得我们为什么以前找不到这 948 个漏洞？）

ky1ebot1337 也给出了自己的方向：

> "My goal is to work towards a vuln-free Internet. What I observed is that stronger models can find many more vulnerabilities that weaker models cannot." — ky1ebot1337 [c:50373313]

> （我的目标是奔着没有漏洞的互联网去。我观察到的是，更强的模型能找出弱模型找不到的更多漏洞。）

但整场最被诟病的地方在于答案的分层：技术细节有人答，规模、评测方法、后续节奏没人答。而且连承诺都没留下——

> "...and then proceeds to never answer a single question. Classic." — kleiba2 [c:50376939]

> （……然后就再也没回答过任何一个问题。老套路了。）

怀疑态度最重的一条把动机本身算进去了：

> "Why would they review the results? They want to publish flashy metrics, this is a marketing team not an actual cyber dept." — lifeisloving [c:50376525]

> （他们为什么要复核结果？他们要的是好看的指标，这是市场部，不是真正的网络安全部门。）

这条是评论区的推测，没有证据支撑，但恰好点到了这套发布流程最脆弱的地方：文章自报 74.7% 复现率、3.1% 误判率，这些数字全部出自被质疑的那一方。

### 四、OpenBSD：更安全的系统，还是只是没人测

支持 OpenBSD 的一方，理由不是语言，是设计：

> "The reason is the code. Linux was not designed to be secure. OpenBSD was. It's that simple." — 0xbadcafebee [c:50375076]

> （原因是代码本身。Linux 从来不是为安全而设计的，OpenBSD 是。就这么简单。）

务实的一方立刻把这句话翻过来：

> "OpenBSD has plenty of security vulnerabilities. It’s just that nobody cares, so OpenAI doesn’t dedicate resources to finding them." — 7e [c:50375554]

> （OpenBSD 的安全漏洞多得很，只是没人在乎，所以 OpenAI 不会为它投资源。）

> "Is anyone spending millions of dollars on checking OpenBSD?" — cyberax [c:50373498]

> （有没有谁花几百万美元检查过 OpenBSD？）

wormius 问的是同一个方法论问题：

> "Has this been tested via the same means as these new Linux exploits?" — wormius [c:50374415]

> （OpenBSD 有没有用跟这些新的 Linux exploit 相同的方法测过？）

而 wahern 把战线从口水缩小到了代码量：

> "Core kernel code for any particular architecture is less than 10 million" — wahern [c:50373529]

> （对某个具体架构来说，核心内核代码不到 1000 万行。）

前面那条「服务器成本赢了」在这里有具体版本：OpenBSD 支持的硬件少一大截，换来更小的攻击面，但慢 10% 左右，大厂不会为此多买服务器。两边其实都没错——只是「更安全」和「更少被人钻」在这个世界里不是同一件事。

### 五、Rust 重写之争，夹着一场信任危机

Rust 派的论点是 est31 最经典的那版：

> "Had Linux been written in Rust, and I strongly recommend a rewrite, it would still have bugs, and thus would still have vulnerabilities. But they'd be way less." — est31 [c:50373480]

> （如果 Linux 是用 Rust 写的——我强烈建议重写——它照样会有 bug，照样会有漏洞，但会少得多。）

anonymous908213 的反问毫不客气：

> "Oh, you strongly recommend rewriting tens of millions of lines of code? Why don't you do it yourself? Just a prompt away, right?" — anonymous908213 [c:50373661]

> （哦，你强烈建议重写几千万行代码？那你自己动手啊，不就一个提示词的事吗？）

est31 的回帖把「一个提示词」这句接了下去：

> "Humans manually typing out the bytes of source code has been an outdated method, since around a year. It simply doesn't scale as much as those same humans directing agentic teams. So yes, it would be about prompts." — est31 [c:50374019]

> （人类手敲源码这件事大约从一年前就过时了，它远不如同一批人去指挥 agent 团队那样有扩展性。所以对，大概就是提示词的事。）

争议的真正焦点不是 Rust 好不好，而是「重写」这个动作在 AI 出现之后变便宜了还是变贵了。有人提出反方向的问题：

> "Won't AI's ability to discover these bugs reduce the need to rewrite things in rust?" — shoobiedoo [c:50373891]

> （AI 能发现这些 bug，会不会反而降低了用 Rust 重写的必要性？）

Gigachad 给出的答案最实际：

> "It would be cheaper to rewrite the kernel in Rust, subsystem and driver by driver at a time." — Gigachad [c:50374077]

> （按子系统、按驱动一个一个来，用 Rust 重写内核会更便宜。）

这场争论在 pgrust 这条支线上被推到了另一个层面。有人提到 particleDB 那个用 Rust 重写 Postgres 的项目此前刚被 Jepsen 指出基准造假、跑不了基准之外的基本查询，anonymous908213 的回帖毫不退让：

> "I don't consider a cheater downplaying their cheating to resolve the fact that they cheated, no." — anonymous908213 [c:50374219]

> （我不认为一个作弊者淡化自己的作弊就能了结他作弊这件事，不行。）

est31 则认为这场争议本身可以翻篇：

> "I think the pgrust controversy should be resolved now?" — est31 [c:50374154]

> （我觉得 pgrust 那场争议现在应该可以了结了？）

把它放回 OpenAI 这篇的语境，风险就具体了：948 个 LPE 里混进假货，后果是补丁进内核之后被打脸；一个 Rust 重写的内核里混进假货，后果是整个内存安全的承诺是假的。后者贵得多。

### 六、还剩多少：一个算不出来的余数

最关键的一个问题没人能答：

> "Have you given thought on how you can use this info to estimate how many vulnerabilities there are?" — Lerc [c:50374282]

> （你们有没有想过用这些信息去估计一共有多少漏洞？）

团队成员的回答是全场最诚实、也最要命的一句：

> "In our first scan when we found 166 vulnerabilities, we wouldn't be able to guess there were 900+ more vulns to find in the code base." — ky1ebot1337 [c:50376320]

> （我们第一次扫描找到 166 个漏洞的时候，并不能猜到代码库里还有 900 多个可找。）

换成今天就是同一个陷阱：扫出 900 多个之后，还剩 0 个、1000 个，还是更多，没人知道。ky1ebot1337 顺手提了一个把问题变成可测量的办法：

> "I think it'd be an interesting benchmark problem if we can have a formally proved safe, large program as the ground truth, inject synthetic vulnerabilities to it, then ask the model to exhaustively find vulns, and use that as a benchmark results." — ky1ebot1337 [c:50376320]

> （如果能拿一个形式化证明安全的大型程序当基准真相，往里面注入合成漏洞，再让模型去穷尽式地找，那会是个有意思的基准问题。）

换句话说：现在有的是分母的一小截，没有分母。没有分母，「漏洞还剩多少」就只能靠感觉，而感觉恰恰是过去四十年这个领域一直没解决的问题。

### 七、低权限账号约等于 root，以及明年的模型

直接被这篇报告改变的是运维和安全团队的实际判断：

> "For the near and medium term, having access to a low-privileged account on an operating system, that isn’t up-to-date on its latest available patches should be considered functionally equivalent to root access for a well-resourced threat actor." — getcrunk [c:50373161]

> （在中短期内，在一个没打上最新补丁的操作系统上拥有一个低权限账号，对一个资源充足的攻击者来说，应当被视为等同于 root 权限。）

kccqzy 说的是这个判断早就在实践中成型了：

> "LPEs are frequent enough that people no longer use low-privilege user accounts to sandbox potentially malicious software." — kccqzy [c:50373636]

> （提权漏洞频繁到人们已经不再用低权限账号来隔离可能恶意的软件了。）

而做过内核安全报告受理的人给出了专业侧注，amluto 说自己见过不少 juicy 的提权漏洞：

> "I’ve found plenty of interesting kernel bugs, including some juicy LPEs, and almost none were memory safety errors :)" — amluto [c:50375361]

> （我见过很多有意思的内核 bug，包括一些相当有料的提权漏洞，但几乎没一个是内存安全错误。）

这条值得单独拎出来：948 个 LPE 里如果多数不是内存安全错误，那么用 Rust 重写这条最贵的路，解决不了主要的那部分。

最后一层是防守方自己的焦虑：

> "There exists now something that is able to find 948 kernel LPE vulnerabilities. How, exactly, will humans be able to control and contain, say, next year's models for a nonzero amount of time?" — mofeien [c:50375426]

> （现在已经存在某种东西能找出 948 个内核提权漏洞了。那么，人类究竟要怎么控制和约束——比如明年那代模型——哪怕有限的一段时间？）

clivedup 的回帖带着点苦笑：

> "We might end up with a secure kernel, and you want them to stop?" — clivedup [c:50376203]

> （我们可能会得到一个安全的内核，而你希望他们停手？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 内核里一直如此 | rubinlinux | 提权漏洞在内核里存在几十年了 |
| 是我们造的 AI 挖出来的 | antonvs | 我们自己造了 AI 来找到它们 |
| 数量不奇怪，代码量决定的 | p-e-w | 4000 多万行内存不安全代码里有几百个严重 bug 不奇怪 |
| 安全输给性能 | pianopatrick | 服务器成本赢了被黑成本 |
| AI 把漏洞成本打下来了 | azan_ | 现在 200 美元就能找，这点钱请不起工程师 |
| 120 万美元只有大厂玩得起 | zahlman | 希望别的开源组织也砸得起这笔 API 费用 |
| 948 条根本审不完 | konaraddi | 除非团队很大，或者花几个月逐条过 |
| 想要的是分布不是总数 | farisght | 想知道缺陷类别，以及对应的避免措施 |
| OpenBSD 证明可以不要 | 0xbadcafebee | Linux 不是为安全设计的，OpenBSD 是 |
| OpenBSD 只是没被测过 | 7e | 它漏洞也多，只是没人在乎，没人投钱去测 |
| Rust 重写更彻底 | est31 | Rust 不会消灭 bug，但会少得多 |
| AI 让重写变便宜 | Gigachad | 按子系统、按驱动逐个重写更划算 |
| AI 找到就够了，不必重写 | shoobiedoo | 能发现漏洞，是否就不必再重写 |
| 打补丁不等于修好 | ahsillyme | 问题是结构性修好，还是这次打完补丁就算 |
| 没有分母 | Lerc、ky1ebot1337 | 团队自己承认估不出还剩多少漏洞 |

## 总体情绪

这场讨论的表层是玩笑和惊吓：最好的回复是那句「我们自己造了 AI 来找到它们」；中层是四十年的旧账被重新标价——内核里的提权漏洞从来不是新闻，只是第一次有人用一条流水线给它们编号、算价、配好补丁，还标出 120 万美元的发票。

底下那层是一种工程学上的诚实：他们交出的是一次体检报告，不是一张安全保证。报告里的 74.7% 复现率、3.1% 误判率、12 小时加 30 小时的机器时间都可核对；但报告没有分母，团队自己承认第一次扫到 166 个时猜不到后面还有 900 多个。防守方能拿到的只有一句坏消息，和一件比以前便宜得多的工具。

OpenAI 没有让 Linux 更安全，它只是把「内核里到底有多少条通往 root 的路」从修辞变成了一个待除的数；除不尽的那个余数，才是下一轮 120 万美元账单要回答的问题。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | A thousand fewer paths to root（HN 主帖，343 分，243 条评论） | https://news.ycombinator.com/item?id=50372929 |
| 2 | 原文：A thousand fewer paths to root — OpenAI（2026-11-04） | https://openai.com/index/a-thousand-fewer-paths-to-root/ |
| 3 | 评论区引用的前一轮讨论：HN item 49705794（spartanatreyu 提到「AI 之前就能找到」） | https://news.ycombinator.com/item?id=49705794 |
| 4 | 评论区引用的 pgrust 争议讨论：HN item 50209450（est31 提到） | https://news.ycombinator.com/item?id=50209450 |
| 5 | 评论区引用的 Jepsen 分析：particledb 1.1.4（anonymous908213 提到 pgrust 基准造假） | https://jepsen.io/analyses/particledb-1.1.4 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中数据（2308 个候选发现、1724 个复现漏洞、948 个 LPE 补丁、5034 个审计目标、约 280 万行代码、复现率 74.7%、模型分析错误比例 3.1%、3426 / 316549 / 73330 美元的分段 API 成本、120 万美元总成本、12 小时与 30 小时两段耗时）来自 OpenAI 官方博客《A thousand fewer paths to root》，本文未做独立复核。原文正文在本地归档中被截断至 8000 字符，成本分析之后的章节未能取到，文中叙述以归档内容为准。主帖共 243 条评论，本地归档快照（2026-11-05 10:27 UTC）抓到 100 条，文中引文均出自这 100 条；归档未写入评论分数，引文选取依据内容而非分数。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
