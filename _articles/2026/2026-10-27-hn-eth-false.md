---
layout: post
title: >-
  ETH 塌了：OpenAI 推翻了指数时间假设 — HN 讨论摘要
date: 2026-10-27
hn_id: 50251661
categories: [articles]
excerpt: >-
  OpenAI 用一篇 67 页论文推翻了 ETH，连带 SETH、Gap-ETH、NSETH、#ETH 一起塌了。
  但 P=NP 没被证明，而评论区一半在算概率，一半在怀疑这是 AI 写的。
tagline: >-
  理论计算机科学的地基裂了一道缝，评论区在讨论要不要下注 P=NP。
---

## 原文概要

事情发生在 2026 年 10 月 26 日 21:59 UTC。HN 用户 vok 提交了一个 PDF，链接指向 `github.com/openai/math` 仓库 `preprints/` 目录下的《The Exponential Time Hypothesis Is False》。论文署名只有两个字：OPENAI。全文 67 页，页脚标着「Date: 17 October 2026, revised 25 October 2026」。提交几小时内，它拿到 410 分、150 余条评论。

ETH 是什么？它是 2001 年提出的「指数时间假设」：判定一个 n 个变量的 3-SAT 公式是否可满足，最坏情况需要 2^{Ω(n)} 时间。严格说它不是定理，而是学界默认当真的经验公理。它上面还压着一串更精细的假设：SETH、Gap-ETH、NSETH、#ETH。过去二十年的复杂度下界，大量建立在这一串假设上——参数化算法的下界、编辑距离、最长公共子序列、正则表达式匹配、图直径近似的下界，都是拿 SETH 当支柱。

论文给出的主定理是：对任意固定的 k ≥ 2，存在一个确定性算法，在 (n+m)^{O(k)}·2^{O(k·n·log log n/√log n)} 位运算、(n+m)^{O(k)} 位空间内，精确算出 k-CNF 公式的满足赋值个数 #F；而测试 #F 是否大于 0 就等价于判定可满足性。指数项的形态是 n(log n)^{1/2+o(1)} 量级。作为对照，此前的最好成绩是：确定性 3-SAT 1.32793^n（Liu, 2018），随机化 1.307031578^n（Jiang & Cai, 2026），Schöning 的局部搜索给 3-SAT 的 (4/3)^n；精确计数一侧，#3-SAT 此前是 1.637^n（Kutzkov），#2-SAT 是 1.2377^n（Wahlström）。

论文自己列了一份清场名单：Theorem 1.1 一次性推翻 ETH、SETH、Gap-ETH、NSETH，同时推翻 #ETH 以及 ETH/SETH/Gap-ETH 的有界误差随机版本。附带两个推论：一个线路下界 E^NP ⊄ SIZE(O(n))，即存在一个 E^NP 语言没有线性规模线路（沿的是 Ryan Williams 的经典论证路线）；另一个是 Max-k-SAT 的近似算法在次指数时间内能达到 Rag08 那个半正定规划保证的近似比、误差可任意小——换句话说，Max-k-SAT 的 NP 难近似性也被削掉一层。

方法上，整篇论文走的不是暴力算法，而是代数路线：把满足赋值计数写成一个多项式求和，再用多项式插值与低次替换式把全局求和拆成若干组之间的独立求和，组与组之间只通过少量「共享线性摘要」耦合；核心步骤变成「稀疏多项式方程公共零点计数」，附录 D 再用布尔张量网络收缩给出更紧的界。论文正文里也留了一句自我限制：2^{o(n)} 档的界在一般多项式归约下不传递，需要 2^{n^{o(1)}} 才行，所以结论并不蕴含一般 NP 问题有次指数算法。

## 讨论焦点

### 一、一串地基同时被拆

最先把消息性质说清楚的是 jaggederest：

> "This defeats a few hypotheses that were widely relied on." — jaggederest [c:50252503]
> （译文：这推翻了若干条被广泛依赖的假设。）

他接着列了名字：强指数时间假设 SETH，以及题目里那个 ETH 本尊。对常年做参数化算法的人来说，被拆掉的不是一条冷门猜想，而是脚手架。

被这条消息波及的范围，有人用复杂度类阶梯讲得更清楚。IsTom 的观察是，多项式时间层级 P、NP（即 Σ₁）、Σ₂……PSPACE、EXPTIME 之间，我们确知 P 严格小于 EXPTIME，其余全不知道：

> "I think the general consensus is that it's more likely that there are more inequalities than not, but the fact is that we can't even show that P is less than PSPACE so far, which would be extraordinarily surprising if it were true." — IsTom [c:50252801]
> （译文：我认为普遍共识是「不等号比等号多」更有可能，但到目前为止我们连 P 小于 PSPACE 都证明不出来——如果这居然为真，那才真是天大的意外。）

也就是说，这篇论文动的是链条靠上的位置，而链条底端 P 和 NP 之间的关系仍旧没人碰。

被推倒的地基具体是什么，lynndotpy 用一句读者最能感到痛的话说透了：

> "Every paper which assumes ETH is true might now have their conclusions be disproven." — lynndotpy [c:50252483]
> （译文：每一篇假定 ETH 成立的论文，它的结论现在都可能被推翻。）

与此同时，评论区也提醒了一个长期存在的误读。nullc 指出，ETH 这类断言常被理解成「所有实例、甚至多数实例都难」，而这个理解会直接导致糟糕的工程决策：

> "Any specific instance may be efficiently solvable (and perhaps all instances coming from your particular problem set -- a subset of all possible 3sats)." — nullc [c:50252895]
> （译文：任何一个具体实例都可能是高效可解的（也许你那个问题集里的所有实例都属于这种情况——它们只是所有可能 3SAT 实例的一个子集）。）

换句话说，被证伪的是一个最坏情况的悲观下界，而不是「SAT 问题已经解不动了」这条流传甚广的俗话。

### 二、最容易搞错的推论：ETH 为假，不等于证明了 NP ≠ EXP

这条线是全场最热闹、也最混乱的一条。先看错的方向。一条当时被大量点赞的解释这样写：

> "This proves that EXP != NP, which was a stronger claim than P != NP." — pcstl [c:50252554]
> （译文：这证明了 EXP != NP，这是一个比 P != NP 更强的结论。）

这句在评论区被反复纠正，纠正者说的其实是一件事：**归约本身会把问题规模放大**。

> "It doesn't imply NP is sub-exponential, only that 3SAT is.  Conversions to other problems can still end up exponential." — cochne [c:50252623]
> （译文：它并不蕴含 NP 是次指数的，只有 3SAT 是。转换到别的问题时仍然可能指数级。）

> "We know (via the Cook–Levin theorem) that any NP problem can be reduced to SAT in polynomial time, and we now know that solving SAT is subexponential in terms of the size of the SAT problem, but it's possible for the conversion to SAT to grow the problem enough that it's exponential in terms of the original problem." — tfpgh [c:50253213]
> （译文：我们知道（由 Cook–Levin 定理）任何 NP 问题都可以在多项式时间内归约到 SAT，现在又知道 SAT 在其自身规模上是次指数可解的，但把问题转成 SAT 的过程可能把规模撑大到相对于原问题仍是指数级。）

mswphd 给了一个具体到能算的例子：

> "practically, a poly-time reduction can increase teh size of hte problem instance. So maybe you transform a 3-color instance (graph on n vertices) into a n^2 sized SAT instance. You can then solve this in time 2^{n^2 / sqrt{log{n^2}}}, but this is not sub-exponential." — mswphd [c:50253240]
> （译文：实际上，多项式时间的归约会撑大问题实例的规模。也许你把一个三染色实例（n 个顶点的图）转成一个 n² 大小的 SAT 实例，然后能在 2^{n^2 / sqrt{log{n^2}}} 时间内解掉——但那不是次指数。）

而同一段纠正被不同 ID 反复贴出，显然它戳中了全场最常见的那个误读：

> "This is not a proof that NP != EXP. NP is poly time reduceable to 3SAT + 3SAT is sub-exponential does not imply that NP is sub-exponential -- the cost of the reduction may be enough to push the conjunction from sub-exponential to exponential." — jibalt [c:50253906]
> （译文：这不是 NP != EXP 的证明。NP 可以多项式时间归约到 3SAT，加上 3SAT 是次指数的，并不能推出 NP 是次指数的——归约的代价足以把两者相乘的结果从次指数推回指数。）

最硬的一条来自论文本身，由 cochne 直接把原文抄了出来：

> "Note that runtime bounds of the form 2^o(n) do not transfer under general polynomial-time reductions (2^n^o(1) would be needed for this), so our result does not imply that general NP problems admit subexponential time algorithms." — cochne [c:50252736]
> （译文：注意，2^{o(n)} 形式的运行时界在一般多项式时间归约下不传递（需要的是 2^{n^{o(1)}}），因此我们的结果并不蕴含一般 NP 问题存在次指数时间算法。）

这条引文也解释了评论区那些看起来矛盾的说法：ETH 假了，但「NP 里还有指数难的问题」这句话并没错——只是「最难的那个」的天花板被抬高了。

顺带说，现场还出现了一个纯技术失误加一个自我更正。caughtinthought 在解释猜想时说成：

> "3SAT can't be solved in sub-exponential time" — caughtinthought [c:50252528]
> （译文：3SAT 不能在次指数时间内求解。）

pcstl 立刻在下一层回复里改了两个字符：

> "*Can be solved" — pcstl [c:50252556]
> （译文：*可以求解。）

写给外行看的版本同样翻过车。有人申请解释时被提醒：

> "Whenever someone asks for an ELI5, there's always got to be somebody who further confuses the issue." — moishe_syzslak [c:50253282]
> （译文：每当有人要求「解释得像给五岁孩子听」，总会有个人来把问题搅得更糊。）

### 三、P=NP 的概率被上调：3% 变 5%，10% 变 20%

消息传开后最直接的生理反应是下注。mudita 转述了 Scott Aaronson 博客里的那句更新：

> "Given this news, I’ll up my personal probability of P=NP from 3% to 5%." — mudita [c:50252719]
> （译文：鉴于这条消息，我把自己认为 P=NP 的个人概率从 3% 上调到 5%。）

zeroonetwothree 给自己加得更猛：

> "I’m not as smart as Scott but for me it’s more like 10% -> 20%. Do we have a prediction market for this?" — zeroonetwothree [c:50252786]
> （译文：我不如 Scott 聪明，但对我来说更像是 10% 变成 20%。有针对这个的预测市场吗？）

立刻有人泼冷水：

> "It seems highly irrational to bet that your evaluation is more likely than Aaronson's." — jibalt [c:50253933]
> （译文：你的判断比 Aaronson 的更可能成立——押这个似乎非常不理性。）

底下是一片「所以还有戏」的欢呼：

> "but you're telling me.... there's a chance" — dnautics [c:50252779]
> （译文：但你的意思是……还有那么一点可能。）

programjames 用一种更黑的方式接住了这句：

> "put a number on your probabilities. there's a chance you have an aneurysm in the next few minutes and fail to see my comment. if so, oh well, i tried." — programjames [c:50252889]
> （译文：给你们的概率标个数吧。有那么点可能你接下来几分钟会脑溢血看不到我这条评论。要是那样，好吧，我尽力了。）

预测市场本身也被讨论了一遍，理由是这类命题没法设定期限：

> "Predictions markets are terrible mechanisms for this, because they require imposing an arbitrary time limit at which point the prediction will pay out." — kibwen [c:50253718]
> （译文：预测市场对这类事是糟糕的机制，因为它要求人为设一个到期时间，到点就结算。）

> "Why must prediction markets have a predefined end date?" — internetter [c:50253794]
> （译文：为什么预测市场必须预设一个结束日期？）

### 四、"galactic"：离工程还有多远

第二个真正的从业者出现了。自称 SAT 求解专家的 bsubs 给出的判断是：

> "SAT-solving expert here." — bsubs [c:50253117]
> （译文：SAT 求解专家在此。）

> "The main question is whether some ideas here will snowball into other ideas, one of which could eventually be very practical." — bsubs [c:50253117]
> （译文：真正的问题是这里面的某些想法会不会滚雪球滚出别的想法，其中一个最终可能非常实用。）

他用的词是「galactic」，于是有人追问这个词什么意思，于是有了这场讨论里最生动的一段科普：

> "Galactic algorithms have such huge constants they figuratively need a galaxy-sized computer and/or galaxy-sized problem, to have any advantage over the normal solutions." — yyyk [c:50253328]
> （译文：星际算法的常数大到夸张地说，它需要一个星系那么大的计算机和/或星系那么大的问题，才比常规解法有优势。）

MichaelDickens 立刻举出一个反驳，说明「galactic」不是空话：

> "32-bit integers can be sorted in O(n) using 2^32 words of memory, using bucket sort[1]." — MichaelDickens [c:50253422]
> （译文：32 位整数可以用桶排序在 O(n) 时间内排好，用 2^32 个字的内存。）

> "If objects have a maximum size of 4 GB (= 2^35 bits), then arbitrary objects can be sorted in O(n) using 2^2^35 bits of memory." — MichaelDickens [c:50253422]
> （译文：如果对象大小上限是 4 GB（即 2^35 比特），那任意对象都能用 2^2^35 比特的内存在 O(n) 时间内排序。）

也就是说，「常数大到需要一台星系计算机」的算法在真实世界里确实存在，只是没人会去用它。

至于这个突破什么时候能落到 SAT 求解器里，infamouscow 的判断是短期内不用等：

> "The data you put into a SAT solver has substantial effect on it's performance in practice. Real world inputs tend to be much nicer than pathological ones, so I don't think there's much practical application, but I also haven't read the paper yet." — infamouscow [c:50252924]
> （译文：你喂给 SAT 求解器的数据会极大影响它的实际表现。真实世界的输入通常比病态输入好看得多，所以我认为实际应用空间不大——不过我还没读这篇论文。）

> "I also haven't read ths paper but coding agents absolutely are a part of modern SAT solver coding challenges." — kingstnap [c:50253218]
> （译文：我也没读这篇论文，但写代码的 agent 绝对是现代 SAT 求解器编程挑战的一部分。）

至于「这套技术会不会溢出到别的 NP 问题」，adgjlsfhk1 给了两句乐观的：

> "OTOH, it would be surprising if this sort of technique didn't apply to other NP problems." — adgjlsfhk1 [c:50252831]
> （译文：说句题外话，如果这类技术居然不能用在别的 NP 问题上，那才奇怪。）

> "right, but anything linearly reducable to kSAT is trivially sub-exponential, and a discovery like this means that linear reductions are a whole lot more important than they used to be." — adgjlsfhk1 [c:50254469]
> （译文：没错，但凡能线性归约到 kSAT 的东西都自动是次指数的，而这样一个发现意味着线性归约比过去重要得多。）

### 五、ETH 假了，英伟达会受影响吗

这条线最有传播力。strommec 把两篇论文接到了一起：2022 年有一篇论文证明，除非 SETH 为假，否则 self-attention 的时间复杂度必然是输入长度的二次；于是他问：

> "If OpenAI's proof is correct, does that mean self-attention can be implemented in sub-quadratic time? I.e. we could eventually have all the most advanced LLMs running on cheap hardware? To put it more playfully, is ETH being false actually bearish for Nvidia?" — strommec [c:50252745]
> （译文：如果 OpenAI 的证明是对的，那是否意味着 self-attention 可以用次二次的时间实现？也就是说，最先进的 LLM 最终可能都跑在廉价硬件上？说得俏皮一点：ETH 为假对英伟达来说是利空吗？）

答案是否定的，而且理由出奇地干净——因为 SETH 是比 ETH 更强的假设，而逻辑方向是单向的：

> "SETH is a much stronger claim than ETH" — caughtinthought [c:50252805]
> （译文：SETH 是比 ETH 强得多的断言。）

> "Right, so a refutation of ETH would also refute SETH." — varyherb [c:50253918]
> （译文：对，所以推翻 ETH 也会顺带推翻 SETH。）

> "No, SETH implies quadratic time does not mean !SETH implies !quadratic time." — rokob [c:50252757]
> （译文：不是。SETH 蕴含二次时间，并不等于 !SETH 蕴含「非二次时间」。）

> "What is relevant is that the logic goes the other way: SETH implies quadratic, !SETH implies nothing." — jibalt [c:50253778]
> （译文：真正相关的是逻辑方向相反：SETH 蕴含二次，!SETH 什么都不蕴含。）

也就是说：ETH 假了，SETH 也随之假了，所以那篇 2022 年论文的前提没了——但「前提没了」不等于「结论成立」。次二次的 self-attention 至今不存在。

### 六、这篇论文到底是谁写的

论文署名只有 OPENAI 两个字，这件事点燃了另一条线。最尖锐的怀疑来自 moishe_syzslak：

> "But is this paper way too long? So long that it raises the possibility that OpenAI's staff mathematicians passed through AI's raw output as-is?" — moishe_syzslak [c:50253398]
> （译文：但这篇论文是不是太长了？长到让人怀疑 OpenAI 的数学家把 AI 的原始输出原样过了一遍？）

自称数学专业学生的 freecodeio 给出了同一条链上的另一端：

> "math major here, I can't read the paper for shit" — freecodeio [c:50252722]
> （译文：数学专业在此，我他妈读不懂这论文。）

也有人认为这恰恰是值得乐观的地方。elzbardico 说：

> "It is not a demerit, actually I think that it is a very elegant outcome how many problems could be solved by generation and this probably show us how language is a far more important thing than we ever thought it was." — elzbardico [c:50253094]
> （译文：我倒觉得这不是缺点，而是个相当优雅的结果：这么多问题居然能被「生成」解决掉，这大概说明语言比我们一直以为的重要得多。）

而这条路要成立，缺的是形式化和验证。eru 把这两步补上了：

> "And for the math proofs it's even easier, because once they are formalised into something like Lean the humans only need to understand the statement of the theorem, and a mechanical computer program can check the proof." — eru [c:50253185]
> （译文：而数学证明这条路其实更容易——一旦被形式化成 Lean 之类的东西，人类只需要理解定理的陈述，证明本身由机械程序检查。）

freecodeio 的回应把账算到了另一边：

> "Yes we can just train llms against it and it's all solved. Just a few more trillion dollars and a bunch of deforestation for datacenters bro." — freecodeio [c:50253258]
> （译文：对啊，那就对着它训 LLM，一切解决。再加几万个亿美元和一点数据中心旁边的砍伐，兄弟。）

而「人类必须理解」这个前提本身也被人接住了：

> "Actually, no - this is what controllability is all about. Humans have to understand it." — atlex2 [c:50253020]
> （译文：其实不是——这正是「可掌控性」的意义所在。人类必须理解它。）

> "Humans can understand it. Not all of them, because to understanding it, there's a lot of other things you need to understand before." — elzbardico [c:50253070]
> （译文：人类能理解它。不是所有人，因为要理解它，你得先理解另外很多东西。）

### 七、能不能读懂：一场可读性之争

讨论中途有人对论文本身发火，理由不是数学，是「可读性」：

> "Is this really as interpetable math is fundamentally. Like wtf is this accessibility? who is this for?" — whattheheckheck [c:50252558]
> （译文：这真的是「数学就是这么难以解释」吗。这个可访问性到底是怎么回事。这是写给谁的？）

vecter 的回答冷得像论文本身：

> "It's a math paper written for mathematicians." — vecter [c:50252829]
> （译文：这是一篇写给数学家的数学论文。）

> "It's not possible for someone who's not a specialist in the field to understand it (unless there are more elementary proofs, of which likely none exist)." — vecter [c:50252829]
> （译文：非本领域专家不可能理解它（除非存在更初等的证明，而那样的证明很可能不存在）。）

eru 也说了同一方向的话：

> "Even mathematicians take a long time to read math books and articles, especially if they go into the details. They don't read math like you would read a novel." — eru [c:50252995]
> （译文：即便是数学家，读数学书和论文也要花很久，尤其是涉及细节的时候。他们读数学不像读小说。）

反方也有，像 serf 那样把「门槛」和「普惠」分开算：

> "Requiring 'math50' before 'trig101' isn't gate-keeping in any moral sense, it's an effort to save everyones' time involved when the effort is futile." — serf [c:50253814]
> （译文：要求先读「math50」再读「trig101」，在任何道德意义上都不是守门，而是在努力省下每个人在这场注定徒劳的尝试上花掉的时间。）

最后有人给了一条最低成本的退出方案：

> "You don't need to have an opinion on everything." — paxy [c:50253725]
> （译文：不是所有事情你都需要有意见。）

> "Sometimes hard things are hard." — NetMageSCW [c:50252811]
> （译文：有时候难的东西就是难。）

> "OpenAI has that too - open their website and ask." — ks2048 [c:50254208]
> （译文：OpenAI 也有这个——打开他们的网站问就是了。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 一次拆掉多条假设 | jaggederest | 推翻了若干被广泛依赖的假设 |
| 我们连 P < PSPACE 都证不出 | IsTom | 动的是链条靠上的一段 |
| 原文限制：2^{o(n)} 不随归约传递 | cochne | 不蕴含一般 NP 问题有次指数算法 |
| ETH 假 ≠ 证明 NP ≠ EXP | jibalt | 归约代价足以把次指数推回指数 |
| 只有 3SAT 是次指数的 | cochne | 转换到别的问题仍可能指数级 |
| 归约会撑大规模 | mswphd | n 个顶点变 n² 大小的 SAT 实例 |
| Cook–Levin 只保证归约是多项式的 | tfpgh | 转成 SAT 可能已是指数级 |
| 常见误解：所有实例都难 | nullc | 具体实例完全可能高效可解 |
| ETH 假后难问题没那么难 | lynndotpy | 依赖 ETH 的论文结论都可能被推翻 |
| 概率从 3% 上调到 5% | mudita（引 Aaronson） | 连 Aaronson 都调了 |
| 我自己从 10% 调到 20% | zeroonetwothree | 还问有没有预测市场 |
| 押你比 Aaronson 更可能？ | jibalt | 非常不理性 |
| 还有那么一点可能 | dnautics | 欢呼 |
| 概率标个数（含脑溢血） | programjames | 黑色幽默收尾 |
| 预测市场需要到期日，不合适 | kibwen | 命题没法定期限结算 |
| 为何必须预设结束日期 | internetter | 追问机制本身 |
| SAT 专家：暂无直接应用 | bsubs | 关键在想法能否滚雪球 |
| 什么是 galactic | yyyk | 常数大到需要星系计算机 |
| 星际算法真实存在 | MichaelDickens | 桶排序 O(n) 配 2^32 字内存 |
| 真实输入没病态输入难看 | infamouscow | 实际应用空间不大 |
| 写代码的 agent 也在做 SAT | kingstnap | 编程挑战的一部分 |
| 这套技术应该能溢出到别的 NP 问题 | adgjlsfhk1 | 不奇怪 |
| 线性归约突然重要起来 | adgjlsfhk1 | 自动次指数 |
| ETH 假了 = 英伟达利空？ | strommec | 连到 self-attention 二次复杂度 |
| SETH 比 ETH 强得多 | caughtinthought | 逻辑方向是单向的 |
| !SETH 什么都不蕴含 | jibalt | SETH 蕴含二次，仅此而已 |
| 论文长到像 AI 原始输出 | moishe_syzslak | 直指作者身份 |
| 数学专业读不动 | freecodeio | 「读不懂这论文」 |
| Lean 形式化后机器可验 | eru | 人类只需理解定理陈述 |
| 生成式解决问题是优雅结果 | elzbardico | 语言比想象中重要 |
| 再训 LLM 就全解决 | freecodeio | 几万个亿美元起步 |
| 人类必须理解 | atlex2 | 这是可掌控性 |
| 数学论文就是写给数学家的 | vecter | 非专家读不了 |
| 数学家也不像读小说那样读数学 | eru | 读数学很慢 |
| 先 math50 再 trig101 不是守门 | serf | 省下徒劳的时间 |
| 不必对一切都有意见 | paxy | 允许自己划走 |
| 难的东西就是难 | NetMageSCW | 短句收尾 |

## 总体情绪

这场讨论最值得记下的，不是「ETH 倒了」这个结论本身，而是两种东西同时发生：一边是极硬的数学事实，另一边是极软的概率交易。最尖锐的一段纠错——ETH 为假推不出 NP ≠ EXP，因为归约本身会把实例规模放大——被不同的 ID 反复贴出，说明这是全场最容易被误读的地方；而最热闹的一段，是拿 Scott Aaronson 的 3% 跟别人的 20% 打赌，还顺手讨论了预测市场为什么没法给这种命题设定期限。理论上什么都没解决，账面上却多出 17 个百分点的信念。

另一条裂缝是署名。论文作者栏只有 OPENAI 两个字，评论区里连数学专业的人都承认读不动，于是「这会不会是 AI 的原始输出原样过了一遍」成了整场最尖锐的问题；支持方给的答案倒是扎实——形式化成 Lean 之后，人类只需要读懂定理陈述，剩下交给机器检查。这场争论最后落回了一个老问题上：数学家读数学也很慢，可读性从来不是数学家的 KPI。

结尾则是一个有点讽刺的事实：一篇能推翻整个领域地基的论文，配得上的公开解释，居然是 HN 评论区里几百条互相纠错的留言。而论文本身甚至没有摘要页，只有一个指向 GitHub blob 的 PDF 链接，标题栏写着 [pdf]。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | The Exponential Time Hypothesis Is False（论文 PDF，67 页） | https://github.com/openai/math/blob/main/preprints/The-Exponential-Time-Hypothesis-is-False-October-25-2026/paper.pdf |
| 2 | Scott Aaronson 博客评论（更新 P=NP 个人概率） | https://scottaaronson.blog/?p=10239#comment-2042428 |
| 3 | HN 讨论 | https://news.ycombinator.com/item?id=50251661 |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论对象是 OpenAI 于 2026 年 10 月 17 日撰写、10 月 25 日修订的预印本《The Exponential Time Hypothesis Is False》（共 67 页，托管于 `github.com/openai/math` 仓库的 `preprints/` 目录）。文中关于主定理的运行时间界 ((n+m)^{O(k)}·2^{O(k·n·log log n/√log n)} 位运算、(n+m)^{O(k)} 位空间)、此前 3-SAT 与 #SAT 计数算法的最好界（1.32793^n、1.307031578^n、(4/3)^n、1.637^n、1.2377^n）、被同时推翻的假设清单（ETH、SETH、Gap-ETH、NSETH、#ETH 及其有界误差随机版本）、附带推论（E^NP ⊄ SIZE(O(n))、Max-k-SAT 的近似保证）、以及论文正文关于 2^{o(n)} 界在一般多项式归约下不传递的自述限制，均整理自论文原文，未经独立核实，请以原始链接为准。文中关于算法实际应用前景、论文是否由 AI 生成、以及 self-attention 是否可能次二次实现等讨论，均为读者在公开论坛的个人观点，本文照录而不作事实认定。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
