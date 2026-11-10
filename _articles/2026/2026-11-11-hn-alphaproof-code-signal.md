---
layout: post
title: >-
  600 万行 Lean 验完 Signal 的加密代码：形式化验证第一次落到部署级密码实现 — HN 讨论摘要
date: 2026-11-11
hn_id: 50439193
categories: [articles]
excerpt: >-
  Google DeepMind 用一整套 agent 框架把 Signal 协议的核心密码代码形式化验证了一遍：600 万行
  Lean、四周时间、只有 1% 的代码需要人复核。评论区最尖锐的问题不是能不能证，而是规格是谁写的。
tagline: >-
  证明了代码符合规格，没证明规格符合意图。
---

> 来源：HN 讨论主帖 [AlphaProof Code](https://news.ycombinator.com/item?id=50439193)（403 分，134 条评论），原文是 Google DeepMind 官方博客 Introducing AlphaProof Code；主帖由 ilreb 提交。本篇为 single post 模式。归档快照 2026-11-10 16:56 UTC，入库评论 134 条。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 11 月 10 日，Google DeepMind 发布了一套叫 AlphaProof Code 的 agent 框架，用来给代码做形式化验证——即用数学定理而不是测试用例来证明代码的行为符合规格。第一个落地项目是 Signal 协议的核心密码代码，也就是保护 Signal 和 Google Messages 里数十亿条私密对话的那部分实现。官方说法是：第一次用 AI 在这种深度上形式化验证一个已广泛部署的密码协议，也是第一次有人——不论是否借助 AI——对这个协议的代码实现做到这种程度的验证。

流程分三步。第一步，研究员和多个模型协作，把 Signal 的安全目标翻译成形式化的数学规格，每一条都经过人类专家评审。第二步，由 Gemini Carbon 驱动的 agent 承担证明工作，产出超过 600 万行 Lean——一种用代码写定理、由内核逐条检查的证明语言。第三步，agent 反过来审计这些证明，标出需要人再看一眼的区域，人工复核只占代码库的 1%，剩下的交给 Lean 自动检查。这类工作过去通常需要专家团队做上几年，这次四周做完。

关键差别在深度。多数密码协议验证停在设计层：证明协议本身没有设计缺陷。这次下沉到了设备上实际跑的编译产物。评论区里有人把技术细节抠了出来——验证对象是 libsignal-cli 的 ELF 二进制，编译假设是单线程、静态链接；Lean 侧那几百条指令的语义按 Arm 提供的 ASL 规格对齐，并与两个独立模拟器交叉比对。证明的关键性质包括：设备被临时攻破之前和之后，消息内容都保持保密。

还有一组负对照。他们把两个真实存在、后来被修掉的 bug 重新注入隔离版本的 Signal 代码，两次都让系统给出「这个版本不安全」的机器检验证明。Signal 的 CTO Ehren Kret 表态说，用 AI agent 把真实代码翻译成有效的 Lean 定理是重大突破；验证产物开源，技术论文放在 google-deepmind.github.io/code-verification。

争议也就出在这里。公告里那句「形式化验证——数学地证明代码运行正确、没有缺陷——是安全保证的最高标准」，以及它留给读者的「没找到任何 bug」这一印象，成了评论区的主战场。

## 讨论焦点

### 一、「零 bug」是公告口径，不是证明结论

排名第一的评论从标题就开始拆台：拿一段有过历史 bug 的人类代码，整体形式化验证一遍，然后声称没找到 bug——这在直觉上说不通。

> "Something seems wrong here.  They took a non-trivial piece of human-written code that has had bugs in the past, formally verified the whole library, and found zero bugs?" — hedora [c:50442002]
> （译文：这里有点不对劲。他们拿一段过去有过 bug 的人类代码，把整个库形式化验证了一遍，然后发现零个 bug？）

他给出的理由是经验性的：让 LLM 写证明这件事本身可能成立，但证明能通过不代表代码没问题。

> "I&#x27;ve had Claude formally verify crypto and data storage formats.  It wrote theorems that looked fine and the formal verification passed but the resulting code contained many, many bugs that other implementations of the same things found with ad hoc testing." — hedora [c:50442002]
> （译文：我让 Claude 形式化验证过加密和数据存储格式。它写出的定理看着都没问题，形式化验证也过了，但产出的代码里有很多很多 bug——别的实现靠临时测试就找出来了。）

同一质疑的更精确版本来自 legitronics：Signal 的安全目标本身也是模型生成的数学模型，这个链条里有三处「相信我」，而人类只完整审了其中一处。

> "They took signals security goals&#x2F;aim&#x2F;target and used models to generate a mathematical model. Which is a bit “hey trust us bro” in 3 ways but they did have human experts fully review 1 path, partially review 1 path, and the last I’m not really sure." — legitronics [c:50442881]
> （译文：他们拿 Signal 的安全目标／意图／靶子，用模型生成了一个数学模型。这在三个环节上都有点「信我就行了吧」，但他们确实让人类专家完整审了一条路径，部分审了一条路径，第三条我就不确定了。）

这引出形式验证的老问题，cortesoft 一句话讲完：

> "This is true for all formal verification systems, though. You can only formally prove that code does what a spec says, you can’t verify that a spec perfectly matches what the code is intended to do." — cortesoft [c:50442535]
> （译文：这对所有形式验证系统都成立。你只能形式化地证明代码做了规格所说的事情，没法验证规格完美地对应了代码本来的意图。）

auggierose 给出了同一件事的另一种说法：人们总在混淆证明和定理。证明可以是正确的，而定理选错了。

> "Because, people keep confusing proofs with theorems. The proof can be correct, while the theorem is the wrong one." — auggierose [c:50441664]
> （译文：因为人们总是混淆证明和定理。证明可以是正确的，而定理是错的。）

最扎心的版本来自一段亲身经历：andai 让 coding agent 重构老项目，测试全绿，实际上整个实现是反着写的。

> "Until that moment I&#x27;d been quite bullish about the potential of formal verification in the AI age. But upon seeing that mess, I realized, it might as well have written me a mathematical proof for the code it wrote, and the proof would have passed, and the code would still be wrong!" — andai [c:50441544]
> （译文：到那一刻之前，我一直挺看好 AI 时代形式化验证的潜力。但看到那摊东西之后我意识到，它完全可以给我写一份它自己那坨代码的数学证明，证明照样能过，而代码照样是错的！）

### 二、证明到底覆盖了哪一层

第二组评论关心的是覆盖面。sanderjd 读了论文，指出最难啃的部分——加密例程和系统调用——被 stub 成了契约，并发和信号处理则根本没有建模。

> "The paper notes that they stubbed out all the trickier crypto and system call routines with contracts. If those routines don&#x27;t adhere to the modeled contracts in real execution, then the proof&#x27;s guarantee won&#x27;t hold. Also things like concurrency and signal handling are intentionally not modeled." — sanderjd [c:50441564]
> （译文：论文里写了，他们把更棘手的加密例程和系统调用都用契约 stub 掉了。如果这些例程在真实运行中不遵守被建模的契约，证明的保证就不成立。另外像并发和信号处理这些东西是故意不建模的。）

同一层还有一句更朴素的提醒：验的不是 App，是协议。

> "This didn&#x27;t verify the Signal app, only the signal encryption protocol" — Gasp0de [c:50439641]
> （译文：这验的不是 Signal 应用，只是 Signal 的加密协议。）

而 Paracompact 补充的技术细节解释了为什么范围还能这么窄——目标不是 Rust 源码，而是编译后的二进制：

> "Rust need not apply, since the proof is about the libsignal-cli ELF binary, compiled under reasonable assumptions (single-threaded, statically linked, etc). The semantics of the some-hundred instructions in their language in Lean were tested to adhere to Arm-provided ASL spec, as compared to two independent emulators." — Paracompact [c:50440131]
> （译文：Rust 用不上，因为证明的对象是 libsignal-cli 的 ELF 二进制，编译假设是合理的那些（单线程、静态链接等）。他们在 Lean 里那几百条自有指令的语义，按 Arm 提供的 ASL 规格做了对齐，并与两个独立模拟器比对过。）

这套「验二进制而不是验源码」的做法也把编译器排除在信任基之外，代价是换任何一个不是逐位相同的编译产物，保证就不再成立。围绕这层还有一条通用警告：形式验证针对的是理论硬件，真实硬件是非确定性的，算法正确也可能在侧信道泄露。

> "Actual hardware is nondeterministic, and an algorithm can be correct while suffering from a side-channel." — breakwaterlabs [c:50440993]
> （译文：真实硬件是非确定性的，一个算法可以逻辑正确，却因为侧信道而遭殃。）

### 三、AI 写的 Lean 本身谁来验

既然证明是 agent 写的、被审的只有 1%，那么「谁来审 agent」就成了问题。r0ze-at-hn 正在自己拿 Lean 做实验，给出的经验是：AI 写 Lean 时很容易作弊。

> "AI Lean is not perfect and AI can easily cheat given it is writing the lean. For anyone playing around with AI Lean code at minimum you need another adversarial prompt to review the ai generated lean." — r0ze-at-hn [c:50440961]
> （译文：AI 写的 Lean 并不完美，而且既然是 AI 在写 Lean，它很容易作弊。任何玩 AI Lean 的人，至少需要再加一次对抗性的 prompt 去审查 AI 生成的 Lean。）

他的结论比「AI 不可信」更实用：

> "if you start AI converting to Lean the value will be in what assumptions it finds" — r0ze-at-hn [c:50440961]
> （译文：如果你开始用 AI 把代码转成 Lean，价值会体现在它找出了哪些假设上。）

来自另一半的回应则明显乐观：gigatexal 认为这篇公告不像 AI 公司惯常的炒作，Google 是把它当工具在用。

> "Agreed. This doesn’t read like the hype most ai firms put out. Google is using it like a tool. The human review of the 1% that matters is really smart." — gigatexal [c:50440205]
> （译文：同意。这读起来不像多数 AI 公司惯用的那套炒作。Google 是把它当工具在用。只让人复核那关键的 1%，这一手很聪明。）

还有人对验证强度提出了一个几乎无法反驳的对照实验：拿一个有已知 CVE 的版本试试，比如 OpenSSL 和 Heartbleed。

> "This seems like a trivial thing to verify though, point it at a known software version with a CVE, like OpenSSL &#x2F; Heartbleed, or some of the more recent SSL &#x2F; PHP &#x2F; Node &#x2F; HTTP issues. Then you would expect it to find the Heartbleed vulnerability quite quickly." — SamuelAdams [c:50442553]
> （译文：这 seem 应该是件挺容易验证的事：指向一个带 CVE 的已知版本，比如 OpenSSL／Heartbleed，或者近些年的 SSL／PHP／Node／HTTP 问题。你应该期待它很快就能找出 Heartbleed 漏洞。）

ctrlaltdileep 则注意到了公告里容易被跳过的一点——那两个被重新注入的历史 bug 是有意设计的对照实验，而不是运气。

> "This is pretty cool. I appreciate that they reintroduced security bugs into the implementation to confirm that their process was actually catching issues. I feel like so many &quot;look what AI did!&quot; articles these days focus on the fact that AI did something and not about whether it did it correctly or not." — ctrlaltdileep [c:50440002]
> （译文：这挺酷的。我很欣赏他们把安全 bug 重新注入实现，用来确认这套流程真的能抓到问题。我感觉现在很多「看看 AI 干了什么！」的文章只关注 AI 干了件事，而不是它干得对不对。）

### 四、能验什么，不能验什么

viraptor 把范围划得很清楚：证明「这个程序不会崩」容易，证明「这个加密是安全的」很难，GUI 程序加 SQL 数据库那种基本没戏。

> "The scope of what we can verify is still tiny. It worked well for &quot;this program won&#x27;t crash&quot;. It&#x27;s really hard for cases like &quot;this encryption is secure&quot;" — viraptor [c:50439888]
> （译文：我们能验证的范围仍然很小。对「这个程序不会崩」这类命题效果不错。但像「这个加密是安全的」这种情形就非常难。）

pmontra 提出了一个更根本的障碍：很多情况下连人类自己都不知道程序应该做什么。

> "In many cases we don&#x27;t even know ourselves what the program should do. There are many edge cases, business decisions, dark and not dark patterns, misunderstood requirements, etc." — pmontra [c:50440029]
> （译文：很多情况下我们自己都不知道程序应该做什么。里面有很多边缘情况、业务决策、暗黑与非暗黑模式、被误解的需求等等。）

joss82 把「规格可能有 bug」这件事说死了——这是形式验证工具本身抓不到的：

> "The problem with verifying real-world software is to give a clear and unambiguous definition of what &quot;correct&quot; means in context.<p>You cannot catch bugs in the specs that way." — joss82 [c:50442194]
> （译文：验证真实世界软件的难点，在于给「正确」下一个在具体语境下清晰无歧义的定义。规格里的 bug 你没法用这种方式抓出来。）

miloignis 则给出了乐观的一面：定理不需要描述整个软件，只要描述你在意的那个性质，而且往往比源码小得多。

> "The nice thing is that a theorem doesn&#x27;t have to completely describe the software, it can just describe some property you care about." — miloignis [c:50441865]
> （译文：定理的好处是它不必完整描述整个软件，只描述你在意的某个性质就行。）

sim04ful 顺着这个方向问了一个问题：既然要建模，为什么不从规格端开始写？

> "Curious question, in this case for verification they ported the software into a formal mathematical model. Why can&#x27;t software development start from the other end instead ? Start with a formal model with the properties you want, then translate it into software." — sim04ful [c:50439832]
> （译文：有个好奇的问题：这次验证是把软件移植进一个形式化数学模型。那为什么软件开发不从另一头开始呢？先有一个带有所需性质的形式化模型，再翻译成软件。）

理论边界也有人操心，但结论一致——停机问题挡不住具体证明：

> "Solving the halting problem means writing a program which can tell whether an arbitrary other program will halt or not.<p>Proving that a particular program will or won&#x27;t halt can still be easy." — sebzim4500 [c:50439452]
> （译文：解决停机问题意味着写一个能判断任意程序会不会停下来的程序。但证明某个具体程序会停或不会停，仍然可以是容易的。）

### 五、值多少钱，以后谁维护

成本是另一个焦点。jlouis 给出了形式验证的放大效应——手写 Lean 证明的成本常常是写原始程序本身的 50 到 100 倍，agent 的价值就是把这份放大量压下来。

> "Driving a lean proof manually is a lot of effort. It&#x27;s often 50x or 100x the effort of writing the initial program in the first place." — jlouis [c:50439816]
> （译文：手动驱着一个 Lean 证明往前走非常费力，常常是当初写那个程序本身所需工作量的 50 倍到 100 倍。）

后续成本则落到了 CI 上：

> "it&#x27;ll be much better once each CI run costs $10,000 for the AI to make sure you didn&#x27;t break its giant proof" — conartist6 [c:50439536]
> （译文：等每次 CI 跑动要花 10000 美元、让 AI 确认你没搞坏那个巨型证明的时候，就会好多了。）

creata 则把这次成果放在人类形式验证的历史里衡量：

> "People (humans) have been able to verify 10k-ish line programs so far. I don&#x27;t <i>think</i> AI has done better yet, but either way it&#x27;ll probably catch up soon. But getting to the millions or billions of lines of code in real software would be breaking new ground." — creata [c:50441509]
> （译文：迄今为止，人类能验证的大概是一万行左右的程序。我不认为 AI 已经做得更好，但不管怎样它很快应该会追上来。不过要拿到真实软件里百万行、千万行的规模，那就是在开新路了。）

### 六、对写代码的人意味着什么

最实际的一组评论来自日常写代码的人。s08148692 说他们公司全面转向 agent 编码之后，事故率和故障率反而明显下降。

> "Anecdotally in my company we have observed a far lower incident and outage rate since we moved to complete Agentic coding." — s08148692 [c:50439745]
> （译文：以我们公司为例：自从全面转向 agent 编码之后，我们观察到的事故率和停机率低得多。）

fercircularbuf 的态度正好相反着过来——他去年担心的正是 AI 让软件 bug 变多。

> "Awesome. I remember thinking last year that software is about to get a lot more buggy now that people are offloading more to AI, but tools like this give me hope that perhaps the future of software actually looks a lot more safe." — fercircularbuf [c:50439442]
> （译文：真不错。我记得去年我还觉得，随着更多人把活交给 AI，软件会变得 bug 满天飞，但这样的工具让我有了点希望：也许软件业的未来其实会更安全一些。）

mapcars 给出了资源分配的判断：

> "Tested is one thing, proved is another. While you need less people to do this, now it also becomes meaningful to spend resources on, instead of another new feature." — mapcars [c:50440302]
> （译文：测试是一回事，证明是另一回事。虽然做这件事需要的人少了，但现在把资源花在这上面也就变得有意义了，而不是再去做一个新功能。）

具体的落点被 m_w_ 说到了：钱相关的 API 应该被证明。

> "For example - Stripe. If I&#x27;m using the stripe API, I want it to be guaranteed to work exactly as documented in all scenarios, given that money is at stake?" — m_w_ [c:50440446]
> （译文：举个例子——Stripe。如果我在用 Stripe 的 API，既然涉及的是钱，我希望它在所有场景下都严格保证按文档描述的行为。）

也有人泼冷水，说别把密码学验证扩大化：

> "the crypto might be secure; i wouldn&#x27;t be so sure about the rest of the code." — milkshakes [c:50439457]
> （译文：加密部分可能是安全的；其余的代码我可不敢打包票。）

而关于人还留在哪个位置，评论区的问答很干脆。原文说「人类专家与 AI 一起决定要证明什么」，立刻有人追问为什么这一步不能交给 AI。

> "Why can&#x27;t ai do this too? Is this the fundamental limit of ai?" — whattheheckheck [c:50439702]
> （译文：为什么这一步 AI 不能自己做？这就是 AI 的根本局限吗？）

> "Because that’s a design question. The AI has to know what it’s actually supposed to be building." — mrtesthah [c:50441253]
> （译文：因为这是设计问题。AI 得知道自己到底该造什么。）

thibsrn 认为公告本身说得很清楚，agent 是辅助人类专家的，人类仍对数学规格负责：

> "This article is not saying that AI did the proof magically. Their statement is quite clear, the agent system <i>helped</i> human experts for the proof, going back and forth at different steps." — thibsrn [c:50439954]
> （译文：这篇公告并没有说 AI 神奇地把证明做出来了。他们的表述相当清楚：agent 系统是<i>辅助</i>人类专家做证明，在各个步骤上反复来回。）

至于下一步做什么，评论区已经有人替 Signal 操心上了：

> "Now pls do telegram to settle &quot;telegram shouldn&#x27;t have invented their own crypto&quot; debate once and for all" — nurumaik [c:50439412]
> （译文：现在请顺手把 Telegram 也做了吧，一次性了结「Telegram 不该自己发明加密」这场争论。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 怀疑「零 bug」 | hedora | 验证通过不等于没 bug，定理本身就可能是错的 |
| 规格也是模型写的 | legitronics | 三处「信我就行」，人类只完整审了其中一处 |
| 形式验证的老规矩 | cortesoft | 只能证明代码符合规格，不能证明规格符合意图 |
| 覆盖比想象的窄 | sanderjd | 最难的加密与系统调用被 stub 掉，并发未建模 |
| 验的是二进制不是源码 | Paracompact | 目标是被编译后的 libsignal-cli ELF |
| AI 写 Lean 会作弊 | r0ze-at-hn | 自己写 Lean 的 AI 需要另一次对抗性审查 |
| 这不是炒作 | gigatexal | 人只审关键的 1%，这一步很聪明 |
| 范围仍然很小 | viraptor | GUI 配 SQL 数据库那种，离验证还远 |
| 规格本身可能有 bug | joss82 | 「正确」的定义抓不到规格里的错误 |
| 成本要落到 CI | conartist6 | 每次 CI 跑动花 10000 美元才叫爽 |
| 未来会更安全 | s08148692 | 全面 agent 编码后，事故率反而低得多 |
| 钱相关的 API 该被证明 | m_w_ | Stripe 的行为应该严格保证符合文档 |

## 总体情绪

分裂得很彻底。一半人把它读成里程碑——一周时间、600 万行 Lean、人工只审 1%，这是形式验证史上第一次把规模拉到部署级密码实现；另一半人只抓住一句话不放：他们证明的是代码符合规格，而规格本身也出自模型，且只有一处被人类完整审过。

值得注意的是，两边其实都在说同一件事的不同侧面：这份工作真正稀缺的从来不是「让 AI 写证明」这一步，而是把人类的注意力从 100% 挪到 1% 的那套流程设计。争议的焦点因此从技术转向了信任的分配——谁定义要证明什么，谁来判断证明本身有没有问题。而这两件事，在这次演示里都还没有完全交出去。

机器已经把「代码写得对不对」这件事的答案压缩到了几百万行 Lean 里；「我们到底要什么」这个问题，还原封不动地留在人类这边。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AlphaProof Code（HN 主帖） | <https://news.ycombinator.com/item?id=50439193> |
| 2 | 原文：Introducing AlphaProof Code（Google DeepMind 博客） | <https://deepmind.google/blog/introducing-alphaproof-code/> |
| 3 | 技术论文与开源工件 | <https://google-deepmind.github.io/code-verification/> |
| 4 | libsignal（Signal 协议实现） | <https://github.com/signalapp/libsignal> |
| 5 | Arm ASL 规格（ARM 语义参考） | <https://developer.arm.com/documentation/101043/latest/> |
| 6 | Introducing CodeMender：AI agent for code security | <https://deepmind.google/discover/blog/introducing-codemender-an-ai-agent-for-code-security/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 403 分、134 条评论，归档快照 2026-11-10 16:56 UTC，入库 134 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与 HN 页面排序而非评论分数。文中关于 600 万行 Lean、四周工期、1% 人工复核比例、libsignal-cli ELF 二进制、Arm ASL 规格对齐等数据，均来自原文与归档评论引述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
