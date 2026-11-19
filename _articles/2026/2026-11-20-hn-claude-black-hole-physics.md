---
layout: post
title: >-
  Claude 解开黑洞物理的两个开放问题：22 个候选、6 周自主研究，与一场关于署名的争论 — HN 讨论摘要
date: 2026-11-20
hn_id: 50563148
categories: [articles]
excerpt: >-
  Anthropic 说 Claude Fable 5.2 解决了黑洞物理的两个开放问题，其中一个此前用 61 次并行尝试全部失败。
  讨论区的争议不在数学，而在署名栏：整篇论文除了 Claude，没有人类作者。
tagline: >-
  论文里没有人类作者，只有一行 Claude。
---

> 来源：HN 讨论主帖 [Claude solves two open problems in the physics of black holes](https://news.ycombinator.com/item?id=50563148)（201 分，58 条评论），原文指向 Anthropic 官方博客 [Claude Fable 5.2 solves two open problems in the physics of black holes](https://www.anthropic.com/research/claude-black-hole-physics)。归档快照 2026-11-19 20:06 UTC，入库 58 条评论（未触及抓取上限），评论分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值。引文中的 HTML 实体按 HN 页面显示形式还原，文字与作者逐条与归档评论比对。

## 原文概要

Anthropic 在官方博客上宣布，Claude Fable 5.2 解决了理论物理中的两个开放问题，两个都跟黑洞和量子引力有关。第一个是全息对偶框架下的霍金-佩奇（Hawking-Page）相变：把一个理论宇宙加热，低温时里面充满粒子气体，超过某个温度就形成黑洞；1983 年 Hawking 和 Page 证明这个转变是突发的，像水在 100°C 突然沸腾。1999 年有人在更小的尺度上找到了同一个转变，但不知道它是否同样突发；2003 年，一组物理学家把能判定这件事的计算写了出来（arXiv hep-th/0310285），此后二十多年没人做完。Claude 用一个「由自己的若干副本组成的小型研究小组」把它算完了，结论是：相变确实是突发的。

第二个问题在模块 bootstrap：一个只有两个空间维度的简化宇宙，至今没有完整的量子引力理论，于是物理学家反着做——用 bootstrapping 这种方法给最轻黑洞的质量设上限，超过上限的理论一律排除，每压低一次上限就缩小一次搜索空间。2009 年以来这个方法一直在用，数值计算暗示存在一个更好的上限，但数值只能暗示、证明不了，已证明的上限离数值暗示的位置还差得远。Claude Fable 5.2 从数值结果里看出了物理学家漏掉的一个模式，又从别的数学和物理领域借来一个方法，把精确上限算了出来，并证明这个上限不能再降。它没有给出正确的理论，但给出了一个方向。

过程本身比结论更值得看。8 月，Anthropic 研究员 Hongbin Chen 让 Claude 列一份理论物理开放问题清单，限定在黑洞和 bootstrap 方向，Claude 几小时后交回 22 个候选；他给每个候选配了独立 agent，agent 之间能互相读到进展帖、遇到相关问题还能协作，后台跑了大约六周。模块 bootstrap 的答案来自接力：一个 agent 在翻 bootstrap 文献时看出数值结果里的模式，另一个正在做高维球堆积相关问题的 agent 把这个模式变成方法；这个方法刚好复现了一个近期由 OpenAI 模型证明的球堆积结论，再套到 bootstrap 问题上——而更早一个 Claude agent 用 61 次并行尝试攻过同一个问题，全部失败。另有两个 agent 独立得到同一答案。最终证明的一半沿用了 OpenAI 那个证明的策略。9 月，结果在 Lean 里被形式化验证；论文由 Claude 在很少的指导下写成，一位物理学家逐条核对了每一个主要结果。

官方博客自己先泼了冷水：两个结果都不直接描述我们的宇宙，也都没有实际应用价值，只是为「理解量子力学与相对论如何相互衔接」这个长期努力添一块砖。预印本挂在 hexagonmath.org 上（2611.00175v1 与 2611.00174v1）。技术铺垫部分用了一张曼哈顿中城地图：从 Penn Station 到 High Line 的两条路线。

## 讨论焦点

### 一、这条新闻的分量：一个 bullet point

> "It tickled me that this was a bullet point in the Fable 5.2 announcement." — simonw [c:50563474]
> （译文）让我觉得有意思的是，这事在 Fable 5.2 的发布公告里只是众多条目中的一条。

Simon Willison 的反应点不在物理，而在体量：一行 bullet point 就够了——「模型顺手解决了两个黑洞物理开放问题」。他紧接着补了一句更复杂的判断，这类成果现在已经普通到能出现在发布公告里。

> "For a moment, I got drawn back into the pre-singularity world -- I even checked a stock ticker!" — bbor [c:50563480]
> （译文）有那么一会儿，我被拉回了奇点之前的那个世界——我甚至去看了一眼股票行情。

一个还记得奇点之前的读者，看到新闻的第一反应是去查股价。帖子发布在 Anthropic 上市首日之后，这个细节让整条讨论带上了两重时间感。

> "I have strong, complicated feelings about it, and I understand you may not feel the same way" — kragen [c:50564775]
> （译文）我对此有强烈而复杂的感受，我理解你可能不是这样。

三个人给出三种反应：轻描淡写、时代错位、情绪复杂。讨论区真正在意的显然不是结论本身。

### 二、署名栏里只有 Claude

> "Apart from Claude/Anthropic no attribution whatsoever - neither on the Hexagon entry nor in the PDF. Isn't this a novelty, even for papers that are 100% the product of AI?" — steinwinde [c:50563841]
> （译文）除了 Claude/Anthropic 之外没有任何署名——Hexagon 的条目页上没有，PDF 里也没有。一篇百分之百由 AI 产出的论文连一个作者都没有，这算不算奇闻。

预印本托管方 hexagonmath.org 的条目页和 PDF 都只有 Claude 一个署名。这在 AI 之前不存在：作者栏本来是一个责任字段，现在被一个模型占满了。

> "Having a person on there would make the Machine God look bad." — Ampersander [c:50564723]
> （译文）上面写个人名，会让机器神显得没那么厉害。

这句玩笑大概是整条讨论里最锋利的一刀：人类作者的存在原本用来给错误担责，如今成了机器声望的减分项。

> "First I've heard of Hexagon math ... backed by heavy hitters, no peer review:" — themgt [c:50564752]
> （译文）Hexagon math 我还是第一次听说……有大厂背书，但没有同行评审：

同一个人还贴出了托管方页面上的一段说明：

> "The main result was first obtained autonomously by an internal Claude research model. The publicly available Claude Opus 5.5 later obtained the same result independently. Claude then wrote this paper, following brief guidance from a physicist, who also checked every main result." — themgt [c:50564752]
> （译文）主要结果最早由一个内部 Claude 研究模型自主得到。之后公开可用的 Claude Opus 5.5 又独立得到了同一个结果。论文由 Claude 撰写，只在一位物理学家给出简要指引之后完成，那位物理学家核对了每一个主要结果。

这段把「验证」的层次摊开了：内部研究模型先拿到结果，公开模型独立复现，论文有物理学家逐条核对。但「同行评审」这一环仍然是缺的。

> "I credit an entity with work that is largely AI. Soon it will just be people credited, everyone will just assume AI was used." — dodger-dog [c:50565446]
> （译文）我给一个大部分工作由 AI 完成的实体记了一功。以后署名会只剩下人名，大家默认背后都用了 AI 就完事了。

### 三、这算不算「物理学家的成果」

> "The first result is cool (but basically a complex error-prone calculation), the second is much much cooler, Claude proved the upper limit for the mass of a black-hole which is consistent with a given central charge." — chunky1994 [c:50563740]
> （译文）第一个结果很酷（本质上是一大堆容易出错的复杂计算），第二个酷得多：Claude 证明了黑洞质量的上限，这个上限对应一个给定的中心荷。

读这条讨论的人里，看得懂论文的是少数，但其中一位把两个结果的性质分开了：第一个是算，第二个是证明。

> "Proved it in a 2d universe." — dguest [c:50564278]
> （译文）它是在一个二维宇宙里证明的。

> "You start with the simpler universes and move up from there." — chunky1994 [c:50564316]
> （译文）现代量子引力的进展都是这么做的：先从更简单的宇宙做起，再往上走。

这句接住了「二维宇宙有什么用」的质疑：二维模型不是取巧，是这条路线几十年的标准做法。

> "Such a theory could be inconsistent for other reasons shown by other methods." — cvoss [c:50564831]
> （译文）这样的理论仍然可能因为别的方法揭示出的其他原因而不自洽。

有人当场纠正了评论区里流传的一句总结（原话说的是「这就成了一个自洽的量子引力理论」）。被纠正者本人回了一句：

> "Agreed on the correction." — chunky1994 [c:50565258]
> （译文）同意这个更正。

### 四、我们的宇宙不适用

> "Neither result describes our own universe directly, and neither has practical applications, but both contribute to a long-running theoretical effort to understand how quantum mechanics and relativity fit together." — Merrill [c:50563604]
> （译文）两个结果都不直接描述我们的宇宙，也都没有实际应用，但都为「理解量子力学与相对论如何契合」这个长期努力添了贡献。

这句官方免责声明被整段贴了出来，因为它正是分歧的起点。

> "I think this is due to the unrelatedness to our universe." — byteknight [c:50563650]
> （译文）我觉得这跟它跟我们的宇宙没关系有关。

> "This sounds pretty normal for theoretical physics, like when models make assumptions about symmetries or homogeneity." — nisegami [c:50563662]
> （译文）这在理论物理里听起来挺正常的，就像模型去假设对称性或者均匀性那样。

物理学家的反应比外界想象的平淡：他们把「与我们的宇宙无关」当成这类工作的常规属性，而不是缺陷。

真正的技术细节落在 Schwarzschild 解上。有人指出，这个经典解假定黑洞一直存在，而不是某天塌缩出来的：

> "For example the famous Schwarzschild solution (that predicts black holes) doesn't apply to our universe, because it assumes a black hole that's been there forever, not one that formed." — eru [c:50563810]
> （译文）比如那个预言了黑洞的著名 Schwarzschild 解，并不适用于我们的宇宙，因为它假定黑洞从一开始就存在，而不是后来形成的。

> "Doesn't GPS model Earth's gravity using Schwarzschild?" — curt15 [c:50564356]
> （译文）GPS 不是也用 Schwarzschild 建模地球引力吗？

> "It also assumes zero angular momentum, which we know is essentially impossible in our universe. And rotating black holes (the Kerr metric) are much stranger beasts." — Sharlin [c:50564444]
> （译文）它还假定角动量为零，而在我们这个宇宙里这几乎不可能。自转的黑洞（Kerr 度规）是更古怪的东西。

> "Schwarzschild allows you to still calculate a whole bunch of things outside the event horizon. The part where it changes from our universe is the physics inside the black hole and their formation" — chunky1994 [c:50565325]
> （译文）Schwarzschild 仍然让你能算出视界外一大堆东西。跟我们的宇宙真正不同的地方，是黑洞内部以及黑洞形成过程的物理。

这四条串起来是本帖最硬的一段技术讨论：模型解的是「永恒黑洞」的数学，而现实里的黑洞有生有死。

### 五、读者的第一反应

> "Stopped reading right here. It took one. Maybe you don't know which one it took but things can't be in two places at once." — physicsgoat [c:50565437]
> （译文）我读到这儿就停了。它选了一条。也许你不知道它选的是哪条，但东西不可能同时在两个地方。

> "How does this make my life easier or better?" — 2OEH8eoCRo0 [c:50565441]
> （译文）这怎么让我的生活变得更轻松或更好？

> "Ok so the ultimate test is throwing mice in a black hole I guess" — raverbashing [c:50563940]
> （译文）那么终极测试就是往黑洞里扔老鼠吧，我猜。

> "Though you need to start by throwing mice from another universe into a black hole in our universe." — 4ndrewl [c:50564768]
> （译文）不过你得先把另一个宇宙里的老鼠扔进我们这个宇宙的黑洞。

关于「在小鼠身上做实验」那个类比，后来被接力玩坏了，连跨宇宙版本都出来了。这类回复把严肃的基础物理讨论拉回了评论区日常的节奏。

### 六、优先权焦虑：是不是拿了别人的活

> "Now let's wait so we find if it stole someone's work." — motbus3 [c:50563542]
> （译文）那我们等着看，它是不是拿了别人的成果。

> "Lately people claim victory too early" — motbus3 [c:50563542]
> （译文）最近大家过早宣布胜利的事太多了。

> "AI + humans solving it within days compared to decades of humans only solving is what should be commended." — CaptWorld [c:50564454]
> （译文）AI 加人类在几天内解出来，而人类单独花了几十年才解出来——这才是该被称道的事。

反方把「人类几十年」和「AI 加速」算成一笔账，认为这值得庆祝而不是怀疑。同一段话里他还提到，相关的解题思路从 2023 年起就有雏形，更早的时候也有研究者借助 AI 拿到过相似结果。

> "What are the odds it stole from some random researcher that used the chatbot to do exploratory research?" — Qem [c:50565275]
> （译文）它从一个用聊天机器人做探索性研究的普通研究者那里偷来的概率有多大？

这可能是整条讨论里最实质的一个质疑：模型把许多研究者的未发表想法连起来，最后由模型所有者发布。

> "They do but we've seen enough solutions by now that surely one of these researchers would come forward to point it out?" — AlecSchueler [c:50565483]
> （译文）人们确实把机器人当成可信的同伴来用，但到现在解出来的东西也够多了，真有人被抢了，总该站出来指认吧。

质疑与反驳都停在推测层面——没有人拿出被抢的证据，也没有人能排除这种可能。

### 七、物理学家的数学与 Lean 证明

「9 月在 Lean 里被形式化验证了最终证明的一半」这件事本身，引出了另一个方向的问题：能被机器检查的那部分，和物理学真正使用的那部分，是不是同一套东西。

> "I agree, but it is the kind of math done the physicists' way (which I found recently asserted that AI cannot do) and not the kind which is formalizable in Lean." — bananaflag [c:50564358]
> （译文）我同意，但这是物理学家的那种数学（我最近还看到有人断言 AI 做不了这种数学），而不是能在 Lean 里形式化的那种。

> "I took grad level physics courses, and this drove me bonkers. I was accustomed to the comfort mathematics provided me." — BeetleB [c:50564639]
> （译文）我上过研究生阶段的物理课，这把我逼疯了。我习惯了数学给我的那种踏实感。

问题在于，物理学长期使用的一批「数学技巧」，很多并没有被证明是合法的。

> "If you attempt to formalize math involving such assumptions, one expects to encounter a proliferation of contradictions." — boothby [c:50564916]
> （译文）如果你试着把涉及这类假设的数学形式化，就得预期会冒出一大堆矛盾。

他举的例子是物理学家眼中的「自然数之和等于 -1/12」。

> "Why would it not be formalizable in Lean? People are formalizing parts of linguistics in Lean." — suddenlybananas [c:50564505]
> （译文）为什么就不能形式化到 Lean 里？人们连语言学的部分内容都在 Lean 里形式化。

> "It doesn’t seem to be making testable predictions (but maybe I missed those)." — layer8 [c:50564623]
> （译文）我看不出它在证明「可以称为数学定理」之外还做了什么。它似乎没有给出可检验的预测（也可能是我漏了）。

> "Can you declare theorems in Lean for those techniques." — ape4 [c:50565230]
> （译文）那些技巧，你能在 Lean 里声明成定理吗。

反方要求的不是更多结论，而是把物理学家的那套操作翻译成可机器检查的形式。

### 八、实证研究才是真正的战场

> "Is it really, though? It's still a heavily mathematical domain, rather than one involving empirical research, where AI still struggles." — pizza234 [c:50563889]
> （译文）真的是这样吗？这依然是一个高度数学化的领域，而不是需要实证研究、AI 还在挣扎的那类领域。

> "In empirical research, getting the right data represents the bulk of the intellectual effort. Designing the right experiment and collecting good data is painstaking, backbreaking work." — glitchc [c:50565310]
> （译文）在实证研究里，拿到对的数据就占了智力工作量的大头。设计实验、收集好数据是极其费力的苦活。

而实际用过模型的人给出的是另一份答卷：

> "It is very good at understanding research goals, identifying appropriate datasets to work with, doing data wrangling and data science, determining appropriate metrics, running simulations, analyzing results, writing up reports with charts and tables, and proposing follow ups or “high potential next steps” which show a surprising amount of judgment" — keeda [c:50564642]
> （译文）它很擅长理解研究目标、找出合适的数据集、做数据清洗和数据科学、确定合适的指标、跑模拟、分析结果、写带图表的报告，还能提出后续方向或者「高潜力的下一步」，显示出令人意外的判断力。

> "I don’t think we’re at Recursive Self Improvement yet, but I don’t doubt for a minute that this is behind the insane pace of development at Anthropic and OpenAI." — keeda [c:50564642]
> （译文）我不认为我们已经到了递归自我改进这一步，但在 Anthropic 和 OpenAI 那种疯狂的发展速度背后是它，这一点我毫不怀疑。

连反对意见也很有代表性：

> "We used to joke in my physics undergrad that they didn’t need a math department because we were doing all the stuff they were doing but with actual applications. Then the mechanical engineers said the same thing about us!" — ModernMech [c:50564320]
> （译文）我们物理本科的时候开玩笑说，物理系不需要数学系，因为我们做的事他们都在做，而且还有实际应用。后来机械系也对我们说了同样的话。

> "One of the most efficient ways to torture a pure mathematician is to force him to watch how physicists treat math." — Sharlin [c:50564401]
> （译文）折磨纯数学家最高效的方式之一，就是强迫他看物理学家是怎么对待数学的。

物理学家自己内部就分不清「纯数学」和「实证」这两头怎么算，这套分工让「模型到底替人做了什么」更难说清。

### 九、上市当天的语气

> "Barely done the IPO, solved two Black Holes already." — aanet [c:50565397]
> （译文）上市才刚完成，已经解开两个黑洞了。

> "The biggest mystery to solve is if their IPO is in itself a black hole" — pelagicAustral [c:50563756]
> （译文）最大的谜题是，他们的 IPO 本身是不是一个黑洞。

> "Given the date, more IPO-fodder or substantial?" — mentalgear [c:50564370]
> （译文）看看这个日期，是更多上市饲料，还是实打实的东西？

> "Impressive. Now, can they ask Claude how to run a profitable company?" — totalforge [c:50564666]
> （译文）厉害。那么现在能让 Claude 运营一家赚钱的公司了吗？

> "The new currency is hype and cult of personality" — claaams [c:50564840]
> （译文）新的货币是炒作和个人崇拜。

> "A lot of us are willing and today have already taken the bet that a model or system that can solve hard problems across math, physics, biology is genuine intelligence." — ironborn123 [c:50565156]
> （译文）我们当中有很多人今天已经押上了：能在数学、物理、生物三个方向上解出难题的模型或系统，就是货真价实的智能。

IPO 开完之后第二天，帖子里的语气明显分成了两半：一半在玩梗，一半已经把「解出开放问题」当成智能的判据下注。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 新闻分量 | simonw | 「解开黑洞物理两个开放问题」已经是模型发布公告里的一条 bullet point |
| 时代错位 | bbor | 看到消息反射性地回去查股票行情 |
| 冷静派 | Merrill | 两个结果都不描述我们的宇宙，也没有实际应用 |
| 物理学内行 | nisegami | 这在理论物理里是常规操作，模型做假设而已 |
| 学术把关 | cvoss | bootstrap 只能证明「不被 bootstrap 排除」，一致性能被别的方法证伪 |
| 署名质疑 | steinwinde | 论文里除了 Claude/Anthropic 没有任何署名 |
| 反署名 | Ampersander | 写上人名会让机器神显得没那么厉害 |
| 托管方存疑 | themgt | Hexagon math 没有同行评审，主结果先由内部模型拿到 |
| 未来署名 | dodger-dog | 以后只剩人名，默认背后用了 AI |
| 优先权焦虑 | Qem | 模型可能把几百个研究者的未发表想法连起来 |
| 反优先权焦虑 | AlecSchueler | 真被抢了总该有人站出来指认 |
| 形式化之争 | bananaflag | 这是物理学家的数学，不是能在 Lean 里形式化的那种 |
| 形式化要求 | ape4 | 那就把那些技巧在 Lean 里声明成定理 |
| 实证分歧 | pizza234 | 高度数学化的领域 AI 已经能做了，实证那侧还在挣扎 |
| 实证乐观 | keeda | 数据处理、指标、模拟、判断力，模型做得比预期好 |
| 只关心实用 | 2OEH8eoCRo0 | 这怎么让我的生活变得更轻松或更好 |
| 智能赌注 | ironborn123 | 能解数学、物理、生物难题的系统就是真智能 |

## 总体情绪

分歧极大，但所有人都盯着同一件事：这两个结果算不算数。有意思的是，讨论区没有停在「AI 能不能做科研」这种大命题上，而是卡在两个很具体的点上——署名和适用性。前者是制度问题：一篇没有任何人类作者的论文要怎么进入学术评价体系，评审人是谁，出错了谁负责。后者是物理共同体内部的常识：不描述我们这个宇宙的解，本身就不构成新闻，只有在「能不能被复现、能不能被形式化」这一层才值得讨论。

而验证这条线索确实存在：内部研究模型先拿到结果，公开的 Opus 5.5 独立复现，Lean 验证了最终证明的一半，论文有物理学家逐条核对。争议不在于有没有人检查，而在于这些检查是不是「同行评审」。同一批评论者因此分裂成两种说法：一边说算得漂亮但没法形式化、跟我们无关；另一边说我们自己宇宙又不是理论物理的最终标准，先从简单宇宙做起一向如此。

真正的分水岭不是它解出了什么，而是解完之后，署名栏还空着。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Claude solves two open problems in the physics of black holes（HN 主帖） | <https://news.ycombinator.com/item?id=50563148> |
| 2 | Claude Fable 5.2 solves two open problems in the physics of black holes（Anthropic 官方博客） | <https://www.anthropic.com/research/claude-black-hole-physics> |
| 3 | 2003 年的 Hawking-Page 相变计算（arXiv hep-th/0310285） | <https://arxiv.org/abs/hep-th/0310285> |
| 4 | Hawking-Page 相变预印本（Hexagon math） | <https://hexagonmath.org/2611.00175v1> |
| 5 | 模块 bootstrap 上限预印本（Hexagon math） | <https://hexagonmath.org/2611.00174v1> |
| 6 | OpenAI 高维球堆积证明（PDF，博客中被引用） | <https://cdn.openai.com/pdf/ten-proofs-oai.pdf> |
| 7 | Hexagon math（预印本托管方） | <https://hexagonmath.org/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 201 分、58 条评论，归档快照 2026-11-19 20:06 UTC，入库 58 条，未触及抓取上限）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

Anthropic 官方博客正文抓取成功但截断在 8000 字符处，本文「原文概要」中的事实（两个问题的内容、1983/1999/2003 的时间线、22 个候选、六周自主研究、61 次并行尝试、Lean 验证、OpenAI 球堆积证明、预印本编号、曼哈顿地图类比）均来自该博客前 8000 字符，即引言、方法说明与两个问题的概述部分；其后的技术细节章节未完整取得。评论中出现的「一个粒子可以同时走两条路」一语，是用户 physicsgoat 转述博客后文的内容，未在已归档正文中出现，未经独立核实。

「22 个候选、6 周、61 次并行尝试」「内部研究模型先得到结果、Opus 5.5 独立复现」「9 月在 Lean 中形式化验证」「一位物理学家逐条核对每个主要结果」等均为 Anthropic 官方博客的自述，本摘要按官方口径转述，未做独立核实。「Hexagon math 由大厂背书、没有同行评审」「代表 AI 实验室可申请验证账号」等说法来自评论者 themgt 转述的该站点内容，本摘要未访问该站点确认。Schwarzschild 解、Kerr 度规、GPS 引力建模等物理学陈述为评论区发言内容，同样未经独立核实。

引文中关于「是否窃取他人成果」「是否达到通用智能」「AI 在实证研究中的实际能力」「机器神与人类署名」等均为评论区个人判断或推测，本文按发言者立场转述，不作事实认定。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
