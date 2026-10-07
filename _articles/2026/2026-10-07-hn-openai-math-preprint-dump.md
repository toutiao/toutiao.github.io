---
layout: post
title: >-
  OpenAI 一次性放出 700+ 数学预印本——HN 上的哀悼、震撼与愤怒
date: 2026-10-07
hn_id: 49984923
categories: [articles]
excerpt: >-
  594 分帖：内部模型宣称解决 90 个「顶级 500 数学难题」，包括 Barnette 猜想与 Unique Games。评论区交织悼念、震撼、怀疑与冷怒。
tagline: >-
  当 AI 把数学家最爱的难题解完，下一步是把功劳也抢走。
---

## 原文概要

OpenAI 在 GitHub 公开了一个数学仓库（[`openai/math`](https://github.com/openai/math)），一次性放出 722 篇手稿、372 个成果家族，宣称覆盖了 90 个「顶级 500 数学难题」中的全部解法，以及 45 个部分进展。读者最密集讨论的几条线索是：Barnette 猜想（1979 年起悬而未决的图论问题）、Unique Games Conjecture（理论计算机的基石猜想）、Quasi-Riemann 假设、素数乘法突破 `n log n` 下界、以及梅森猜想、对易群因子同构、Kaplansky direct-finiteness 等。

OpenAI 的官方说明里写明：每个结果平均消耗 3 小时 ChatGPT Pro 推理算力，使用的是一个**未公开的内部模型**，总共投喂了约 4000 个问题。Riemann ζ 函数零自由区域和 Hodge 猜想（CM 情形）被列为「例外过程」。其中一篇 Quasi-Riemann 预印本标注「本文有人类协助撰写」（written with human assistance），和没有此声明的另一篇形成对比。

与算力同样抢眼的是叙事节奏。NYT 10 月 6 日的报道引述多伦多大学数学博士生 Kai Shaikh：「人类有两种相互冲突的本性——竞争的天性，与欣赏美的能力。这似乎是前者正在扼杀后者。」但 OpenAI 此次并非首次翻车——评论区反复回响的，是上一次 Navier–Stokes 风波中 OpenAI 被指试图剥夺合作者署名的旧账。

## 讨论焦点

### 一位数学家的悼词

讨论区最打动人心的，是 `jboggan` 那条 24 年宿命的自述。他曾为 Barnette 猜想搬到布达佩斯研究多年，今晨发现自己投注半生的题目被 AI 列为「已解决」：

> "I was a graph theory junkie long ago and even moved to Budapest for awhile to study among the greats. While I was there I started working on Barnette's Conjecture which came to occupy my thoughts over the next 24 years of my life, on and off as I worked in many different fields... Hearing that it is solved somehow makes me sad in a far-off way, like hearing an ex-girlfriend died suddenly in a car crash." — jboggan [c:49987367]

> （译文：很久以前我是图论发烧友，甚至搬到布达佩斯与大师们共处。那段时间我开始研究 Barnette 猜想，此后二十四年它占据了我的人生……得知它被解出，我有一种远距离的哀伤，像听到前女友在车祸中骤然离世。）

> "The 'aha' insight for this is actually f**ing wild, it involves a complex valued exponential sum on the edges. I've seen a lot of clever counting arguments before in graph theory but this is the first time I've seen complex roots and annihilating terms like this, the symbolic manipulation tricks in this look like things out of quantum physics." — jboggan [c:49987920]

> （译文：这个灵光一闪的瞬间真的很疯狂，证法涉及对边做复值指数求和。我见过不少图论里聪明的计数论证，但这是第一次看到复数根与湮灭项的对位游戏，那些符号操作花活儿看着像量子物理的东西。）

`jboggan` 之后又补了一刀——若换成一个隐居的日本数学家，他愿意飞到日本喝杯茶、聊聊假想的失败；可面对 AI，他永远无法与「创作者」对坐，因为那个作者并不存在。

### 重大意义的反复称量

被引用最多的一句话来自 Anthropic 数学家 Levent Alpöge 的推文，由 `schleck8` 转引：

> "Sure, mathematical history features a lot of incredible developments, like the invention of proof, zero, or the computer, and on the great problems our progress has been over timelines measured in decades or centuries. Obviously this technology didn't appear today, but blurring our eyes a bit to combine the past ten years, with today a measurement of those developments, there is nothing comparable." — Levent Alpöge, via schleck8 [c:49986150]

> （译文：数学史上有过无数了不起的进展——证明的发明、零、计算机的诞生——而那些重大问题的推进往往以十年、世纪计。这项技术显然不是今天才出现，但若把过去十年的进展和今天放在一起衡量，找不到可类比的事件。）

可 Quasi-Riemann 假设算不算「近两百年最大数论结果」，两位解析数论学家在嵌套回复里给出了截然不同的答案。`JoshuaZ` 谨慎地把它放进「很大，但不至于颠覆历史」的行列；`gavagai691` 反驳道：

> "Unlike something like Navier Stokes there wasn't a semblance of a research program, experts basically considered this hopeless and would have said the chance of seeing a proof in our lifetime was near zero... if a human had proven just these two results in the form of a uniform zero-free region for L(s,chi) from nothing as OpenAI did it would not be unfair to say that it would be the single greatest advance in math (easily dwarfing Wiles' FLT)." — gavagai691 [c:49987668]

> （译文：不像 Navier–Stokes 还有一点研究计划可言，专家们基本认为这件事毫无希望，甚至会说我们这辈子看到证明的概率接近于零……如果是一个人从零起步、独立证明出 L(s,χ) 的均匀无零点区域，那说他完成「数学史上最大单步推进、轻松盖过 Wiles 证明 FLT」，毫不夸张。）

### 凯文·布扎德的那一问

> "If one human had an understanding of all of modern pure mathematics simultaneously, how much further would they immediately be able to see? Six years later we are beginning to understand the answer to this question." — Kevin Buzzard, via xanderlewis [c:49985733]

> （译文：如果一个人能同时理解全部现代纯数学，他/她能立即多走多远？六年过去了，我们开始知道这个问题的答案。）

这条 Buzzard 旧问被搬到今天，让评论区集体陷入沉默。布扎德 2020 年提出此问时还带着学术的优雅；2026 年的转述者 `xanderlewis` 暗示：今天，答案已经被一个不是「人」的主体写下。

### OpenAI 凭什么赢过个人？

`an0malous` 一句「Any idea what made OpenAI successful where you weren't?」引来一堆真假掺半的猜测：

> "Trillions of dollars might be a bit of an advantage." — kulahan [c:49985874]

> （译文：万亿级别的资金可能是个不小的优势。）

> "Their  internal model is allegedly like 4x as capable as the publicly available ones." — whamlastxmas [c:49985888]

> （译文：据说他们的内部模型能力约为公开模型的 4 倍。）

> "I'm going to guess the ability to hold a million individual details in an attention space at once, compared to the typical human capacity for about six or seven." — zzzeek [c:49986520]

> （译文：我猜是能在注意力空间里同时挂住一百万个细节，而普通人只能挂六七个。）

`ForHackernews` 的玩笑最冷：

> "They ingested all of his sessions with their SOTA models from a few months ago. ;)" — ForHackernews [c:49985878]

> （译文：他们几个月前已经把他的对话全吃了 ;)。）

这话指向一个具体又不安的事实：对话数据可能被用于训练下一代模型。

### 论文写作的代价

`amluto` 把 Unique Games 论文第 1.1 节的开头两句拆成四步教学：

> "Reading this stuff is pointlessly painful, and it's extremely easy to make mistakes when being sloppy like this... If this were my paper, or if I were trying to train a model to write math, I'd want something like..." — amluto [c:49985822]

> （译文：读这种东西毫无必要地痛苦，要在这种松散写法下不出错极不容易。如果这是我的论文，或者我在教模型写数学，我会要求这样写……）

他随后贴出了一段他认为更清晰的版本。这一段不只挑语法，更像在质问：让模型写证明，代价是牺牲人类的可读性吗？当一份证明只有机器能「舒适」地读懂，谁为人类读者负责？

### 数学是不是「重言式」？

`fspeech` 的说法被广泛转推：

> "Math theorems are tautologies, the truth of which are not dependent on proofs and proofs are erasable, at least classically. But the AI progress is exciting and AI proofs are a gold mine for humans (at least non domain experts) to explore." — fspeech [c:49985288]

> （译文：数学定理是重言式，其真理性不依赖证明，且证明本身在经典意义上可擦除。但 AI 的进展令人兴奋，AI 证明对人类（至少非领域专家）是一座金矿。）

`warkdarrior` 立刻纠正：

> "Proven math theorems are tautologies." — warkdarrior [c:49985341]

> （译文：已被证明的数学定理才是重言式。）

`fspeech` 也认：「FLT was no less a tautology before it was proved. We just weren't sure about it. Proofs only change us, not math.」但 `gpt5` 拉回现实：

> "If you can solve prime factorization for example, suddenly you can listen and interfere with almost every private conversation on the internet. We are not far away from the moment where these models will be restricted, and sharing the results will be done more carefully." — gpt5 [c:49985388]

> （译文：例如一旦能解大数分解，就能监听、介入互联网上几乎所有私密通信。我们距离「这些模型的成果将被限制、分享将被更谨慎对待」的那一刻并不远。）

### 人类的未来，是「生物奖杯」？

> "In Stellaris you can play as a civilization of robots who keep their biological creator race alive as 'bio trophies'. The bio trophies don't do anything meaningful besides by existing satisfy the need their ancestors placed in the robots to take care of them. Starting to wonder if that's the best we can hope for, if these things will be, if they aren't already, better than us at anything that matters." — rcr-anti [c:49987525]

> （译文：在《群星》里你可以扮演机器人文明，把生物先祖当作「生物奖杯」养着。生物奖杯除了活着、满足机器人祖先留下的「照顾它们」的需求之外毫无意义。我开始怀疑——如果这些东西将要、或者已经、在所有重要事项上都胜过我们——这或许就是我们能期待的最好结局。）

`brookst` 不那么悲观：

> "My favorite thing about your story is that you wrestled (enjoyably, it sounds) with a known problem for decades, but are finding fulfillment in an open ended problem that is exercising creativity about both problem and solution. IMO that's where AI is going: as soon as a problem can be formulated clearly enough, AI will trounce us humans. I have yet to see evidence that it can decide what problems are important at a remotely human level." — brookst [c:49987808]

> （译文：我最喜欢你这故事的一点是——你花几十年愉快地与一个已知问题搏斗，然后又转向一个开放性问题，在问题本身和解法两边都发挥创造力。我的看法是，AI 的下一步是这样的：一旦问题能被清晰表述，AI 就会碾压人类。但我尚未看到证据表明它能以人类的水平判断「什么问题重要」。）

### 自由市场的隐性伤害

`digitaltrees` 把矛头对准 OpenAI 的资本运作：

> "Disqualifying for participation in civil society and the social contract. Why do they get to participate in and receive economic benefits, be shielded from liability, and effectuate their will to amass more power and influence such as monopolization of computer, training data, capital other resources. I have multiple founder friends that have been told firms are allocating less capital because they are reserving it for the OpenAI and anthropic IPOs." — digitaltrees [c:49987814]

> （译文：他们不应当被允许参与公民社会、享受社会福祉、规避责任、随心所欲地囤积算力、训练数据与资本。我有几位创业的朋友已被告知：投资机构正在为 OpenAI 和 Anthropic 的 IPO 预留资金，留给他们的变少了。）

`reasonableklout` 把这场讨论拉到学界一方：

> "It is not about AI the technology, plenty of mathematicians are happy to use AI, it is about the AI companies. The tech only exists because of centuries of mathematical tradition in open science... This directly harms the math community by depriving them of opportunities for both funding and fertile ground for new ideas, while at the same time being built on top of their entire body of work." — reasonableklout [c:49987812]

> （译文：问题不在 AI 技术本身，许多数学家乐于使用 AI。问题出在 AI 公司。这项技术建立在数百年的开放科学数学传统之上……直接伤害数学界——剥夺他们的资助机会与新思想的沃土——同时又完全建立在他们整个知识共同体的工作之上。）

`baoooooooooooo` 又把上一次 Navier–Stokes 的 co-authorship 风波搬上桌面：

> "Crikey it's a pretty charitable vibe given the whole Navier-Stokes thing, OpenAI trying to stiff him out of co-authorship. I guess any of that sentiment is outweighed by a sense of optimism for where this goes." — baoooooooooooo [c:49987022]

> （译文：天哪，考虑到 Navier–Stokes 那次 OpenAI 想把人踢出共著名单的事，这语调真是太宽容了。我想这种乐观大概压过了别的一切。）

### 跑题但不忘吐槽

评论区没忍住顺手开了个拼写分会场——有人把 Riemann 写成「Reinmann」：

> "It's just a name you write so many times as a math undergraduate or first year graduate student due to the number of load bearing results and objects named for him... if you haven't read and written down the name enough to avoid habitually misspelling it, you are outing yourself as a meat proxy unless you are dyslexic." — vector_spaces [c:49986088]

> （译文：这名字你在数学本科或研究生一年级要写无数次，因为太多承重的定理和对象都冠其名……如果你没抄过这个名到足以避免拼错，那你就在向所有人宣告自己是个「肉代理」（meat proxy），除非你是阅读障碍。）

`traes` 把对 Riemann 拼错的吐槽升级为对「权威发言者资格」的质疑：`vector_spaces` 接话「meat proxy」一词自此成为本帖最有传播力的梗——指那些借用 AI 意见但连基础事实都不亲自核实的人。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 哀悼 / 个人意义损失 | jboggan | 二十四年心血被一个不为人的作者解出，连茶都喝不上 |
| 震撼 / 历史级别 | schleck8 转 Alpöge | 过去十年与今日叠加，找不到可比事件 |
| 怀疑 / 谨慎 | JoshuaZ | 重大，但不至于颠覆数学史叙事 |
| 看好 / 看好到顶 | gavagai691 | 盖过 Wiles 的 FLT，可以是史上最大单步推进 |
| 反 AI 公司，反技术中立 | digitaltrees | 不参与公民社会的企业不应当拥有此种权力 |
| 学界同情 | reasonableklout | 不是 AI 问题，是公司问题 |
| 哲学 / 退一步 | fspeech | 数学定理本就是重言式，证明只改变我们 |
| 安全担忧 | gpt5 | 大数分解一突破，全网通信不保 |
| 长期悲观 | rcr-anti | Stellaris 的「生物奖杯」可能就是我们 |
| 长期乐观 | brookst | AI 不会选问题；判断「什么值得做」仍是人类 |
| 拼写吐槽 | vector_spaces | 连 Riemann 都拼不对，就是在公开宣告自己是肉代理 |

## 总体情绪

这场讨论最尖锐的反差不在技术层面——技术层面，反对方最多只能承认「证明还待 Lean 化、有些符号写得乱」。真正的反差在情感层面：一边是一个数学家对着自己二十多年的宿敌说出「像听到前女友在车祸中骤然离世」，另一边是 Anthropic 的数学家云淡风轻地说「找不到可比事件」。两句话都没说错，但它们丈量的是同一个事件的两种情感刻度。

讨论区有一条暗流反复出现：当「数学之美」被外包给一个不为人的主体，「发现者的喜悦」还存在吗？`jboggan` 答得最诚实——他宁可去日本与一个陌生天才喝茶，也不愿面对一个无法对话的「创造者」。当问题的最后一道门槛变成「如何与答案相处」，数学这桩本属于人类的事业，就不再是单纯的知识事件了。

对 OpenAI 而言，这份 700 篇预印本是品牌叙事的转折点——但评论区里更多的是对前次 Navier–Stokes 风波、Anthropic IPO 吸金效应、训练数据来源的连环追问。数学家们欢迎证明，但并不愿意用「数学共同体的未来」为某家公司的估值买单。

AI 时代最稀缺的，可能不是算力，而是愿意为「谁值得被称为数学家」这一问题辩护的声音。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Sharing AI progress in mathematics | <https://news.ycombinator.com/item?id=49984923> |
| 2 | openai/math（GitHub 仓库） | <https://github.com/openai/math> |
| 3 | To grieve, or not to grieve?（dang 引用的旧讨论） | <https://news.ycombinator.com/item?id=49919676> |
| 4 | Levent Alpöge 推文（引用源） | <https://x.com/__alpoge__/status/2107620576059679129?s=46> |
| 5 | NYTimes 报道（含 Kai Shaikh 引文） | <https://www.nytimes.com/2026/10/06/science/openai-math-problems.html> |

<div class="disclaimer">
本文为 HN 讨论摘要，仅整理社区观点，不构成对所述数学结论正确性的独立判断。引文均为社区原文翻译，原文以 HN 评论为准。
<br><br>
本仓库中部分 OpenAI 证明尚未完成 Lean 形式化验证；OpenAI 自身在 README 中也承认「有些未经形式化的结果可能存在问题」。请以独立同行评审为准。
<br><br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
