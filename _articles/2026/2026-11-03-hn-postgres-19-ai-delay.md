---
layout: post
title: >-
  Postgres 19 为什么推迟到 11 月？官方说是 AI 的锅 — HN 讨论摘要
date: 2026-11-03
hn_id: 50312408
categories: [articles]
excerpt: >-
  PostgreSQL 19 从 10 月中推迟到 11 月，官方给出的解释是 LLM：找 bug 的速度超过了
  人类评审的速度。评论区最尖锐的问题也在这里——发现从来不是瓶颈，验证才是。
tagline: >-
  AI 找 bug 的速度，超过了人类修 bug 的速度。
---

> 来源：HN 讨论帖，提交者 soheilpro。帖子：[Postgres 19 is late because so many more bugs are being found now](https://news.ycombinator.com/item?id=50312408)，795 分，472 条评论（抓取时快照）。原文是 PostgreSQL 核心开发者 Robert Haas 的博客文章。

## 原文概要

PostgreSQL 19 这次要迟到了。写博客的是 PostgreSQL 核心开发者 Robert Haas，他给的说法很直接：这跟 LLM 有关。

先看节奏。过去十年，PostgreSQL 大版本的发布窗口相当固定：不早于 9 月中，不晚于 10 月中。今年这个窗口破了，19 很可能要到 11 月才发布，甚至还有继续往后推的可能。

更反常的是 beta 后期的大规模回滚。UPDATE/DELETE FOR PORTION OF、SQL 属性图查询（SQL/PGQ）、ALTER TABLE … MERGE PARTITION/SPLIT PARTITION 这三个大特性，都在 8 月 27 日到 9 月 15 日之间被撤回。feature freeze 定在 4 月 8 日，冻结之后再撤主要特性不算罕见，罕见的是三个一起撤。

Haas 用的证据是提交量。他对比了 2025 和 2026 年同一段时间（4 月 8 日到 9 月 25 日）：

| 指标 | 2025 | 2026 | 变化 |
|------|------|------|------|
| master 分支总提交 | 1037 次 | 1443 次 | +39% |
| 回补到在发的稳定分支 | 724（REL_18_STABLE） | 1169（REL_18_STABLE） | +61% |
| 回补到更早的稳定分支 | 248（REL_17_STABLE） | 433（REL_18_STABLE） | +74% |

master 的总提交量其实还涨了近四成，但 Haas 指出：如果只看 feature freeze 之后只留在 master、没有回补到稳定分支的那部分提交，它反而略有下降（1037 减 724 对 1443 减 1169）。真正暴涨的是回补量——六成、七成多。他的判断是：committer 依旧保守，但同样的一批错误，现在会被 LLM 更快地找出来。

接下来是两个后果。一是修复要花时间：LLM 能起草补丁，但补丁不一定正确，也不一定符合 PostgreSQL 的规范，仍要人来评审，而评审的人还是原来那些人。二是本该用来评审新特性的时间被抽去处理安全问题和旧分支的 bug，于是发版前「到底该撤回哪些特性」变得更难判断。

Haas 认为这不算什么大延迟，根源恰恰是项目对质量的在意。但他承认长期问题更棘手：PostgreSQL 有四十年积累的 bug，人类一直没找到，LLM 却很擅长找——「我们怎么追得上，PostgreSQL 还能不能继续创新」，他暂时给不出答案。

## 讨论焦点

### 一、争议起点：延迟到底该算在谁头上

帖子标题把矛头指向 AI，评论区第一反应是「你确定？」。

自称在 beta 阶段挖过大坑的 ltbarcly3 举了 2014 年的旧账：

> "I have found major bugs in late beta's of postgres long before AI came along. I found a bug where malformed json would segfault the entire server (a segfault in a server process forces the entire cluster to shut down by design) when using jsonb in a release candidate once. They fixed it rather than ripping the entire feature out." — ltbarcly3 [c:50331726]
> （译文：在 AI 出现之前很久，我就在 Postgres 的后期 beta 里发现过重大 bug。我曾在某个 release candidate 上遇到一个畸形 JSON 会让整个服务段错误的问题（服务端进程段错误会按设计拖垮整个集群），那次用的是 jsonb。他们的处理是把它修掉，而不是把整个特性撤掉。）

他的结论更直接，认为这里可能有别的东西在起作用：

> "It seems quite possible that someone wants to make it seem like LLMs are causing problems by over-reacting to things that could just be fixed, or delay the release slightly (or maybe waiting until late before a release to kill features they don't like?) Whatever it is, this seems like a dysfunctional process." — ltbarcly3 [c:50331726]
> （译文：很有可能有人想把事情说成是 LLM 造成的——对本来就能修掉的事情反应过度，或者把发布稍微往后拖一拖（或者干脆等到临近发布才砍掉自己不喜欢的大特性？）。不管是什么，这看起来都是一个失灵的过程。）

另一种反驳是针对「AI 写的代码」这个说法。MBCook 认为官方在延期公告里已经说清楚了，AI 只参与了评审和找 bug：

> "But it DIDNT “write that feature”. They made it extremely clear on the delay announcement the code was written without AI. AI’s only part of this was helping review things and finding bugs. More bugs, bugs that would have been found later, whatever. Postgres did not have a slop issue and it’s wrong for people to insinuate it." — MBCook [c:50331762]
> （译文：但它并没有「写那个特性」。他们在延期公告里讲得很清楚：代码不是用 AI 写的。AI 参与的部分只有协助评审和找 bug。更多的 bug，那些本来晚点也会被发现的 bug，仅此而已。Postgres 不存在代码掺水的问题，认为它掺水是在乱讲。）

也有人不纠缠归因，只问这算不算坏事：

> "This seems…good?" — CharlesW [c:50331818]
> （译文：这看起来……是好事？）

他的补充是：发布节奏被稍微打乱，相比「带着这些 bug 发一个大版本」并不是更糟的选择。

反过来坚持「报告多数有效」的人，证据就是 Haas 自己引用的那组回补提交量：

> "It’s pretty clear there are a lot of valid reports based on the large increase in backport commits cited." — jeremyjh [c:50331891]
> （译文：依据文中提到的回补提交量大幅增加，很明显有效报告不在少数。）

PostgreSQL 社区的 jmspring 则从帖子文本里读出了另一种可能：

> "The post sort of gave a read that the lower elements may be a culprit rather than triaging higher qualitu." — jmspring [c:50332173]
> （译文：这帖子读下来给的感觉是，更可能拖后腿的是低质量的那部分，而不是 triage 不力。）

### 二、瓶颈已经从「发现」挪到「验证」

被反复说到的第一句话是：找 bug 已经不稀缺了，稀缺的是人手。

> "I guess the real challenge is figuring out how to scale verification, cause discovery isn't the bottleneck anymore. Generating more bug reports doesn't necessarily translate into faster fixes if the same small group of maintainers still have to validate the reports, review fixes, etc." — droppedasbaby [c:50312516]
> （译文：我猜真正的挑战是怎么把验证规模化，因为发现已经不再是瓶颈了。报告更多不代表修得更快——还是那一小撮维护者要去验证报告、评审补丁。）

有实际接收 AI 报告经验的人给出了具体比例：

> "Certainly both. About half of AI bug reports I get are invalid. Many others are questionable. It's a huge time sink figuring it out." — 0c3ca83 [c:50332343]
> （译文：两种情况都有吧。我收到的 AI bug 报告里大约一半是无效的，还有很多可疑。分辨它们是个大坑时间的活。）

解法也被提出来了——用另一个 AI 去筛 AI：

> "It's almost never worth spending human time triaging AI reports vs having a different AI go triage them/attempt to replicate them to your standards etc. Obviously it sucks to burn opus or sol tokens on luna or sonnet slop bug reports but it sucks way more to burn human time and attention." — vikramkr [c:50333631]
> （译文：拿人的时间去 triage AI 报告，几乎永远不划算，不如让另一个 AI 去 triage、去按你的标准尝试复现。烧 opus 或 sol 的 token 去处理 luna 或 sonnet 那种掺水报告当然难受，但烧人的时间和注意力更难受。）

反方的担忧则是这样描述的：

> "That's kind of what I was afraid of. Both is really bad news. If you think of it in terms of average speed over ground, working on low quality reports is like spending a bunch of time at v=0." — 27183 [c:50331922]
> （译文：这正是我担心的。两种情况都有的话就是坏消息。如果按平均前进速度来算，处理低质量报告就像花一堆时间停在 v=0 上。）

### 三、AI 找 bug 行，写功能不一定行

「找」和「写」被反复区分开，这是评论区最清晰的一条技术分界线。

> "I feel like AI is amazing for read only “search” tasks (query this, look for bugs, find vulnerabilities) but it’s not quite as good for “write” tasks like “add this feature”. Search tasks are easily verified, code changes are much harder to verify" — hopa [c:50331711]
> （译文：我觉得 AI 在只读的「搜索」类任务上（查一下、找 bug、找漏洞）非常强，但在「写」类任务上——比如「加这个特性」——就没那么灵。搜索类任务容易验证，代码改动要难验证得多。）

Simon Willison 指出搜索任务也有自己的坑，方向相反：

> "The most common error for a search task is omission, and that's really hard to spot - how do you verify that some answer that should be there wasn't included?" — simonw [c:50331724]
> （译文：搜索任务最常见的错误是遗漏，而这非常难发现——你怎么验证某个本来该有的答案没有被漏掉？）

至于为什么两者难度不同，aleksiy123 讲的是反馈闭环：

> "The first one is easier because the feedback loop is llm to code/test and trivially scalable. The second one is llm to human which is going to be slower because it can’t read your mind. The tighter and more deterministic the loop the more llms excel." — aleksiy123 [c:50331985]
> （译文：前者更容易，因为反馈闭环是 LLM 到代码/测试，而且可以随意扩展；后者是 LLM 到人，会慢得多，因为它读不懂你的想法。闭环越紧、越确定，LLM 越强。）

还有人不接受「能力差异」这个解释，认为那是商业叙事在作祟：

> "It doesn't matter what's true, only what promises to make them the most money." — kibwen [c:50331951]
> （译文：什么是真的不重要，重要的只是什么能让它们赚到最多的钱。）

按这个逻辑，AI 实验室宣传「擅长找 bug」还是「擅长写代码」，对应的是完全不同的估值——前者是静态分析行业的市值，后者是整个软件开发人力投入的规模。

fzeindl 给出的框架更实用：让模型生成批评，而不是生成内容。

> "Maybe the problem is that it’s called “Generative AI“. It might be to use it to generate critique of content as opposed to generate the content itself." — fzeindl [c:50336429]
> （译文：也许问题就出在它被叫做「生成式 AI」。用法应该是让它生成对内容的批评，而不是让它生成内容本身。）

至于「让 AI 直接修」这条路，hopa 的判断很不客气：

> "But I also believe if the Postgres maintainers fed every 600+ bug reports into Claude or Codex and shipped whatever came out the end result would be broken." — hopa [c:50338328]
> （译文：但我同样认为，如果 Postgres 维护者把 600 多份 bug 报告一股脑喂给 Claude 或 Codex，然后不管输出什么直接发版，结果一定是坏的。）

反过来，megous 用自己的项目反驳「AI 写不了复杂东西」：

> "But personally I know AI can write absolutely insanely complex things in very short amount of time, that just work and work well." — megous [c:50335547]
> （译文：但就我个人而言，我知道 AI 能在极短时间里写出复杂到离谱的东西，而且能跑、能跑好。）

至于 AI 写出来的东西到底靠不靠谱，brink 的观察很具体：

> "In my very recent experience, it's good for routine things, but it consistently chooses the wrong sync primitives and dynamic abstractions for performance / extensibility." — brink [c:50337490]
> （译文：就我最近的经验，它做日常活儿还行，但在性能和可扩展性上会一直挑错同步原语和动态抽象。）

### 四、不是所有 bug 都值得修

另一条线争论的是优先级。一部分人认为「报告越多越好」这个前提本身有问题。

> "Signal quality... what is that even? The bugs may be valid, but they may also be obscure, irrelevant, low priority." — sverhagen [c:50331921]
> （译文：信号质量……这到底是什么东西？这些 bug 可能有效，但也可能冷僻、无关、低优先级。）

他的结论更锋利：

> "But beyond that... not every bug needs fixing; that's a trap." — sverhagen [c:50331921]
> （译文：但除此之外……不是每个 bug 都得修；认为都得修是个陷阱。）

sverhagen 还用航空业做类比：关键系统里的部件并不都关键。

> "Not every part of a critical piece system is itself critical." — sverhagen [c:50332642]
> （译文：关键系统里的每一个部件，本身并不都是关键的。）

> "Dare I say, solving every bug does not make economic sense." — sverhagen [c:50332642]
> （译文：请允许我说一句，把每个 bug 都修掉在经济上说不通。）

PostgreSQL 社区的 tibbar 讲得更细：极端边界场景的 bug，修了反而可能引入性能问题，或者要动到别的特性。

> "So it's better to not fix them." — tibbar [c:50332870]
> （译文：所以不修反而更好。）

有人不认同这种「选择性无视」：

> "Letting software accumulate even little bugs is not a good look. Yes prioritize but definitely don't leave the smaller things, they will just pile up and make next work even harder." — alexpadula [c:50332837]
> （译文：任由软件攒下哪怕小 bug 都不是什么好名声。该排优先级没问题，但千万别把小问题放着不管，它们只会堆积起来，让下一轮工作更难。）

还有一种更宽松的解读：这些 bug 可能压根没影响过终端用户，也没绊倒过维护者。

> "Seems like a lot of these bugs have not affected end-users or tripped up maintainers." — gondalez [c:50331993]
> （译文：这些 bug 里有不少似乎从没影响过终端用户，也没绊倒过维护者。）

针对「靠 LLM 找出更多 bug 就能提升质量」这个说法，noosphr 指出帖子里的证据链缺了一环：

> "It doesn't mention formal methods once." — noosphr [c:50333009]
> （译文：整篇一次都没提形式化方法。）

ltbarcly3 也给出了他对整件事的总结判断：AI 只是让同一批工作完成得更快，不会让流程本身变好。

> "So the strongest thing you might say here is that you thought LLMs would let you get a feature into shape before it was too late, and for whatever reason that was overly optimistic." — ltbarcly3 [c:50331857]
> （译文：所以这里你最多能说的是：你原以为 LLM 能让你赶在太迟之前把一个特性打磨成型，而不管出于什么原因，这个预期乐观了。）

### 五、真正的账单：安全债把特性开发挤停

Postgres 是个案例，但评论区更关心这件事的通用形态：LLM 把安全问题的发现速度拉高之后，别的事就得让路。

> "At work we have put a full halt on feature work because the number of security related tasks has become staggering and urgent." — Gigachad [c:50332447]
> （译文：我们公司已经全面暂停特性开发，因为安全相关任务的数量变得惊人又紧迫。）

有人把这件事上升到了全球生产力层面：

> "LLMs finding unpatched vulnerabilities faster than they can be reasonably patched, bringing all other software development to a halt." — jimbokun [c:50332599]
> （译文：LLM 找出未修补漏洞的速度超过了它们能被合理修补的速度，把其他所有软件开发都拖停了。）

反方则说，这要看安全算不算「生产性工作」：

> "If you consider it to be productive work, it's a massive productivity boon happening right now." — reissbaker [c:50332829]
> （译文：如果你把它算作生产性工作，那眼下正在发生的就是一次巨大的生产力红利。）

至于被翻出来的问题来自哪里，plorkyeran 给的是自己的日常观察：

> "My job is seeing a similar deluge of security work and >90% of the bugs have been in pre-2024 code, and zero of them have been bugs introduced after we were first officially allowed to use LLM codegen." — plorkyeran [c:50332990]
> （译文：我的工作就是面对类似的安全任务洪流，其中 90% 以上的 bug 都在 2024 年之前的代码里，而在我们被正式允许用 LLM 生成代码之后引入的 bug，一个都没有。）

于是有人追问了那个最扎人的问题：

> "How many of the security issues found were created by LLMs in the first place, though?" — OccamsMirror [c:50332910]
> （译文：那么，这些被找出来的安全问题里，有多少本来是 LLM 自己造出来的呢？）

adwn 的回答把方向掰了回来：

> "Frontier models have been better than the average programmer at writing secure code that follows up-to-date best-practices for some time now." — adwn [c:50332969]
> （译文：前沿模型写出符合最新最佳实践的安全代码这件事，已经有一段时间强过平均水平程序员了。）

### 六、Postgres 的护城河：替代品、生态和「谁来维护」

跑题跑得最远的一段，是「谁会取代 Postgres」。

> "I’m still amazed that with all the vibe coding, no one has created a Postgres alternative" — meow9 [c:50331811]
> （译文：都 vibe coding 到这个份上了，还是没人做出一个 Postgres 的替代品，我还是很惊讶。）

理由也很朴素：

> "Why would they? Postgres is free and does an amazing job." — nfriedly [c:50331822]
> （译文：为什么要做？Postgres 免费，而且干得极好。）

替代者的路径倒是存在——从协议层切入：

> "Many recent relational databases speak the Postgres wire protocol. For wholesale replacement, pgrust is a recent, contentious contender." — sa46 [c:50331832]
> （译文：不少新的关系数据库都讲 Postgres 的 wire protocol。要谈全面替代，pgrust 是最近那个有争议的竞争者。）

不过「有人试过」的提示立刻跟了上来，指向一份著名的分析：

> "Someone tried." — TomatoCo [c:50331850]
> （译文：有人试过。）

讨论里给出的链接是 Jepsen 对 ParticleDB 1.1.4 的分析。另一条更贴近日常的抱怨来自 pg_dump：

> "To be honest I would love for someone to work on the structuring of pg_dump for example, which is entirely driven by regexes and binary structures. It’s awful and absolutely not programmable - a real shame." — scrollaway [c:50331855]
> （译文：说实话，我很想有人去重构一下 pg_dump 之类的东西，它整个是靠正则和二进制结构驱动的。太糟糕了，而且完全不可编程——真可惜。）

生态侧的愿望则是把扩展正式化：

> "I wish they'd adopt, merge in, or give official blessings to versioned postgres extensions like citus and pgvector." — sapphire4 [c:50332018]
> （译文：我希望他们能采纳、合并，或者给 citus、pgvector 这类带版本的 Postgres 扩展一个官方认可。）

把这一段收口的是一句关于「维护」的判断：

> "You can create a project on vibes, but you cannot maintain one on vibes." — esalman [c:50331892]
> （译文：你可以靠感觉（vibes）做出一个项目，但你没法靠感觉维护一个项目。）

### 七、情绪外溢：从「卢德派」到打地鼠

帖子后半段气氛明显变了。有人把社区对 AI 的反感称为「反卢德」：

> "Exactly. There's so much negativity, it sometimes borders Luddism." — leoooodias [c:50332167]
> （译文：确实。负面情绪这么多，有时候已经近乎卢德主义了。）

也有人替卢德派翻案：

> "Luddites were actually pretty reasonable when you dig into it. Maybe shouldn't be using it as an insult?" — UpsideDownRide [c:50332841]
> （译文：深挖一下，卢德派其实挺讲道理的。也许不该拿这个词当骂人的话用？）

Marha01 的反驳把历史类比推到底：

> "Socialism movement that refused to use machines and factories would inevitably lose to capitalists that embraced them. Socialism movement that refuses to use AI will inevitably lose to capitalists that embrace it." — Marha01 [c:50333643]
> （译文：拒绝使用机器和工厂的社会主义运动，终究会输给拥抱它们的资本家。拒绝使用 AI 的社会主义运动，终究也会输给拥抱 AI 的资本家。）

而整条帖子的情绪底色，被一位读者说得很直白：

> "I'm not very positive on the social, technical, or intellectual impact of AI on software development. Actually, that's understating it. I think AI is basically cancer for the mind." — 27183 [c:50331729]
> （译文：我对 AI 在软件开发上的社会、技术、智识影响都不太乐观。其实这么说还轻了，我觉得 AI 基本就是心智上的癌症。）

对这场讨论最精准的一句总结，出自 noosphr：

> "They found a more efficient way to play Whac-A-Mole with bugs, they didn't find a way to reduce bugs." — noosphr [c:50332368]
> （译文：他们只是找到了一种更高效的打地鼠方式，并没有找到减少地鼠的办法。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| AI 之前就有 beta 期的重大 bug | ltbarcly3 | jsonb 段错误当年是修，不是砍特性 |
| 怀疑有人在夸大 AI 的锅 | ltbarcly3 | 对能修的事反应过度，就成了流程失灵 |
| 代码不是 AI 写的 | MBCook | AI 只参与评审和找 bug，Postgres 没有掺水 |
| 延迟未必是坏事 | CharlesW | 晚一点发总比带着 bug 发强 |
| 有效报告不在少数 | jeremyjh | 回补提交量涨了六成就是证据 |
| 更可能是低质量报告拖累 | jmspring | 帖子读下来像是在说 triage 不力 |
| 瓶颈是验证不是发现 | droppedasbaby | 发现已经不稀缺，稀缺的是验证人手 |
| 一半 AI 报告是无效的 | 0c3ca83 | 分辨它们就是纯耗时间 |
| 用 AI triage AI | vikramkr | 烧 token 比烧人时间便宜 |
| 低质量报告等于停在原地 | 27183 | 相当于花一堆时间跑在 v=0 上 |
| 找 bug 比写功能更适合 LLM | hopa | 搜索类任务容易验证，代码改动难验证 |
| 搜索类任务的错是遗漏 | simonw | 漏掉了答案，怎么验证你没漏？ |
| 闭环越确定，LLM 越强 | aleksiy123 | LLM 到代码/测试 vs LLM 到人 |
| 这背后是商业叙事 | kibwen | 重要的是什么能让它们赚最多钱 |
| 让模型生成批评而非内容 | fzeindl | 「生成式 AI」这个叫法本身就误导 |
| 报告直接喂给模型会坏事 | hopa | 600 多份报告直接发版，结果一定是坏的 |
| AI 能写复杂东西 | megous | 一个周末项目，RTL 到 testbench 全是 AI 写的 |
| AI 代码的抽象选得不对 | brink | 同步原语和动态抽象会一直挑错 |
| 不是每个 bug 都得修 | sverhagen | 都修是个陷阱 |
| 关键系统的部件不都关键 | sverhagen | 客舱娱乐不关键，飞机关键 |
| 极端边界场景修了更糟 | tibbar | 可能引入性能问题或牵动别的特性 |
| 小 bug 不能放着不管 | alexpadula | 不处理就会堆积，下一轮更难 |
| 有些 bug 没伤到任何人 | gondalez | 也许放着不管才是务实的 |
| 帖子没提形式化方法 | noosphr | 证据链缺了这一环 |
| 特性开发被安全债挤停 | Gigachad | 公司已经全面暂停特性开发 |
| 全球生产力可能净负 | jimbokun | 漏洞发现快过修补速度 |
| 安全是生产力红利 | reissbaker | 算作生产性工作就是巨大收益 |
| 90% 的 bug 在 2024 年前的代码 | plorkyeran | 允许 LLM 写码之后引入的 bug 是零 |
| 反问：多少漏洞是 LLM 造的 | OccamsMirror | 这个前提本身要问 |
| 前沿模型写安全代码强过平均程序员 | adwn | 已经有一段时间了 |
| 至今没人做出 Postgres 替代品 | meow9 | vibe coding 时代也没人做到 |
| Postgres 免费且优秀 | nfriedly | 为什么要做替代品 |
| 替代路径是 wire protocol | sa46 | pgrust 是那个有争议的竞争者 |
| 有人试过了 | TomatoCo | 链接指向 Jepsen 的分析 |
| pg_dump 全靠正则驱动 | scrollaway | 不可编程，实在可惜 |
| 扩展应该被官方认可 | sapphire4 | citus、pgvector 都该有正式位置 |
| 靠 vibes 维护不了项目 | esalman | 能创建，不能维护 |
| 这波负面情绪近乎卢德 | leoooodias | 说起来已经到那个程度了 |
| 卢德派其实挺讲理 | UpsideDownRide | 不该拿它当骂人话 |
| 拒绝 AI 的阵营注定输 | Marha01 | 类比拒绝机器的社会主义运动 |
| AI 是心智上的癌症 | 27183 | 这话偏激，但情绪是真的 |
| 找到更高效的打地鼠方式 | noosphr | 地鼠并没有变少 |

## 总体情绪

这场讨论表面上在争一个技术事实：Postgres 19 到底为什么延期。实际上争的是三件更大的事——AI 找 bug 的能力该不该记在账上；「修得多」和「修得对」之间怎么选；以及当发现速度跑在修复速度前面时，一个靠少数人维护的开源项目还能不能按原来的节奏往前走。

多数人最后没有站到「AI 让软件变坏」那一边。他们接受的是一个更朴素的画面：LLM 把发现问题的成本压到了接近零，维护者的工作没有减少，只是从「找 bug」换成了「筛 bug、评补丁、决定哪些 bug 值得修」。Postgres 的例子之所以刺眼，不是因为这个项目做错了什么，而是因为它的代码足够老、包袱足够重、贡献者足够少——四十年攒下来的坑，正好撞上工具变快的那个时间点。

最不留情面的一句被留在了最后：他们只是找到了一种更高效的打地鼠方式，并没有找到减少地鼠的办法。Postgres 19 只是晚了几天，而账已经记在别处了。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Postgres 19 is late because so many more bugs are being found now（HN 主帖，795 分，472 条评论） | https://news.ycombinator.com/item?id=50312408 |
| 2 | Postgres 19 is late, and it's AI's fault（Robert Haas 原博客） | http://rhaas.blogspot.com/2026/10/postgres-19-is-late-and-its-ais-fault.html |
| 3 | 同一篇文章的 Neon 版本（原始出处） | https://neon.com/blog/postgres-19-is-late-and-its-ais-fault |
| 4 | PostgreSQL 邮件列表：jsonb 畸形 JSON 触发段错误（ltbarcly3 引用，2014 年） | https://www.postgresql.org/message-id/20140818195634.2543.56277%40wrigleys.postgresql.org |
| 5 | PostgreSQL 邮件列表：极端边界场景的 bug 是否该修（tibbar 引用） | https://www.postgresql.org/message-id/flat/c22286ad6268347c6820d2f69eaa8088c98d17ea.camel%40cybertec.at |
| 6 | Jepsen：ParticleDB 1.1.4 分析（TomatoCo 贴出的「有人试过」） | https://jepsen.io/analyses/particledb-1.1.4 |
| 7 | VulnCheck：AI 报告 bug 的成色（0c3ca83 引用的数据） | https://www.vulncheck.com/blog/anthropic-glasswing-receipts |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的提交量、回补比例、特性撤回时间与延期判断，均为 Robert Haas 博客原文及 HN 讨论参与者在 2026-10-31 至 2026-11-02 期间的公开陈述，本文未做独立核实；评论区对「延期归因于 AI」这一说法本身存在明确相反意见，正文已分别列出。评论数与分数为抓取时快照，实际数值随时间变化。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
