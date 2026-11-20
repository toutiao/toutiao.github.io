---
layout: post
title: >-
  同一天，两份黎曼猜想证明：25 万页的机器稿与 900 页的人工作品 — HN 讨论摘要
date: 2026-11-21
hn_id: 50579568
categories: [articles]
excerpt: >-
  Anthropic 员工 Levent Alpöge 挂出纯 Lean 的 GRH 证明，形式化拆成 14 个分卷；四小时后，斯坦福的 Ravi Vakil 从美国数学会理事会会场上发来一条仓促公告，
  说另一位数学家 Alessandro Masullo 已有一份纯人手、无 AI 的 GRH 证明，审稿人 Brian Conrad 看了几个月。评论区最激烈的部分不在数学上。
tagline: >-
  机器先交卷，25 万页；人类补交，四小时后，900 页。
---

> 来源：HN 讨论主帖 [Hurried Announcement: Alessandro Masullo GRH](https://news.ycombinator.com/item?id=50579568)（409 分，125 条评论），原文指向 Ravi Vakil 的博客 [Math 216](https://math216.wordpress.com/2026/11/20/hurried-announcement-alessandro-masullo-grh/)。本篇为 cluster 模式：相关帖两条——[Levent Alpöge claims proof of the Generalized Riemann Hypothesis](https://news.ycombinator.com/item?id=50574968)（1889 分，1254 条评论，thread 2）与 [Terence Tao 的汇总帖](https://news.ycombinator.com/item?id=50578358)（111 分，18 条评论，thread 3）。归档快照 2026-11-20 19:42 UTC，入库评论 100 / 100 / 18 条（thread 1、thread 2 未触及抓取上限，thread 3 已全量），评论分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值。引文中的 HTML 实体按 HN 页面显示形式还原，文字与作者逐条与归档评论比对。

## 原文概要

2026 年 11 月 20 日这一天，黎曼猜想方向连着出了两份互不相让的证明宣告。

第一份在下午。数学家 Levent Alpöge（普林斯顿博士，供职于 Anthropic）在自己的站点挂出一份 PDF 公告，宣布自己证明了广义黎曼猜想（GRH），附件是一套 Lean 形式化——不是一页代码，而是拆成 14 个分卷的压缩包（`lean.tar.gz.part01` 到 `part14`）。HN 帖子冲到 1889 分、1254 条评论。公告里那句被反复引用的话很克制：论证目前极其漫长，形式化已经完成，但这只是"我路上的一步"，作者打算之后把它讲明白、写漂亮。

第二份在当天傍晚。斯坦福的 Ravi Vakil 在自己的博客（用户名 ravivakil）贴出标题为《Hurried Announcement: Alessandro Masullo GRH》的帖子。他写道，自己此刻正在美国数学会执行委员会和理事会会议上，马上要主持一个小时的会议，但这件事太急，先发出来：Alessandro Masullo 有一份 GRH 的证明提案，Brian Conrad 已经盯了几个月、给了大量反馈，意见正在被吸收，目前看是靠谱的——"It is all human, with no AI"。原计划是把 Masullo 请到斯坦福待上一年，把行文打磨好、让足够多的人过一遍之后再正式宣布。现在只能先把当前草稿放出来，请大家检查、形式化、补上可能存在的小漏洞。附件 PDF 叫《The Music Of The Primes》。

两边的体量差了两个数量级。评论区看 PDF 的人报出的篇幅在 900 到 940 页之间（Alpöge 那份若按传统形式写成可读论文，会超过 25 万页，所以作者选择不发那种"slop 填充"的 PDF）。评论里另有一条被转述的事实：Masullo 这份证明已经做了 12 年，原计划还打算至少再做一年，Vakil 的"仓促公告"是被同一天 Alpöge 那篇逼出来的。

当天晚上，Terence Tao 在博客上把三件事按"消化程度"从低到高排了序：Alpöge、Buckmaster、Coiculescu 用大量 AI 辅助给出了三维不可压 Euler 方程有限时间爆破的可读证明，并在 Lean 中形式化；Alpöge 与 Buckmaster 给出不可压 Navier-Stokes 方程的有限时间爆破证明，同样有 Lean 形式化，但还需要写成一份专业的证明；最后是 Alpöge 用内部 AI 模型生成的 GRH 证明，纯 Lean 版本。Tao 写道，从最初的分析看，它"似乎动用了 Langlands 纲领和算术几何的全部现代威力"。他同时给了一个冷静的注脚：消化这些结果需要时间。

## 讨论焦点

### 一、同一个答案，两条赛道

> "Now there are two proposals to the GRH. One assisted with AI and one that is all human with ZERO AI." — rvz [c:50580210]
> （译文）现在有两份 GRH 提案。一份有 AI 协助，另一份是全人类、零 AI。

> "This one is 900 pages rather than 250K pages." — rvz [c:50580210]
> （译文）这一份是 900 页，而不是 25 万页。

这帖最要紧的信息不是数学，是这张对照表：同一天、同一猜想、两条完全不同的路线，一份用机器写出并被机器检查，一份由人写出但还没有机器背书。有人当场把提问方式换了：

> "Rather than that, instead we should wait for multiple authorities to review both of them and the one that satisfies the GRH and is verified as the correct solution is the one that we go with." — rvz [c:50580210]
> （译文）与其那样，不如等多位权威同时审两份，等那份被验证确实解出 GRH 的，我们认它。

这正是几个月前 OpenAI 与 Anthropic 那场 Navier-Stokes 争执留下的教训：别让一个署名者定输赢，让检查决定。

### 二、"全人类、零 AI"这句话有多少人信

> "I'd put everything I've got on: false." — method_capital [c:50580679]
> （译文）我把我全部身家押上去：假的。

这句赌注针对的是 Vakil 博客里那句 "It is all human, with no AI"。怀疑的理由不只是修辞：

> "Another possible reason: AI will suggest corrections to your mistakes using ideas of others. A proof will unlikely remain human-only, even if you just use AI to check for your errors." — hkmaxpro [c:50580683]
> （译文）还有一个可能的原因：AI 会用别人的想法来指出你的错误。即使只是用 AI 检查错误，一个证明也很难保持纯人类。

而反方向的辩护同样具体——纯人写的证明在历史上并不常见：

> "Sorry, most mathematicians don't want to look ridiculous by posting something that doesn't hold up careful scrutiny for something as big as RH. See the ABC conjecture and Mochizuki fiasco for example." — yewenjie [c:50580015]
> （译文）抱歉，大多数数学家不想因为发出一份经受不住仔细检验的东西而在 RH 这种量级上丢脸。看看 ABC 猜想和 Mochizuki 那场闹剧就知道了。

一位挺 AI 的人则给出行业观察：

> "Furthermore, many mathematicians have referred to the AI proofs as jumbled incomprehensible messes. Humans should continue their work unabated by the threat of some slop paper that claims a solve." — devin [c:50580127]
> （译文）而且，很多数学家把 AI 证明形容成一堆拼凑起来的、看不懂的乱码。人类应该继续自己的工作，不该被那种声称解出难题的垃圾论文吓住。

### 三、优先权的死循环

> "If this is real, and the results on all sides check out, the author made a HUGE mistake by not publishing a few months ago." — A_D_E_P_T [c:50579895]
> （译文）如果这是真的，而且各方都验证通过了，那作者几个月前不发布就是个大错误。

这段话在帖子里的后续被顶得最多，因为它把一个看似道德问题（抢发）转成了结构问题：

> "Damned if you do, damned if you don't. Keep your work secret and you'll get scooped. Make partial progress public and they'll ingest it into the model and scoop you anyway." — j2kun [c:50580296]
> （译文）做也死，不做也死。藏着不说会被抢先；公开一半进度，他们会把你的东西喂进模型，然后照样抢先。

有人指出这不只是心态问题，而是经费问题：

> "How do you expect these people to get grants if all they do is publish half solutions that machines poach?" — duplessitous [c:50580137]
> （译文）如果这些人做的全是发表一半解法、然后被机器抢走的活，你指望他们怎么拿到经费？

学术界的自我调整倒是有个更乐观的版本：

> "I hope more scholars feel compelled to get their ideas out faster now that they might be scooped, like, tomorrow by the next frontier AI model." — cximenez [c:50580024]
> （译文）我希望更多学者会因为"明天就可能被下一个前沿模型抢走"而被迫更快地把想法拿出来。

而这正是眼下发生的：Vakil 的帖子标题里那个词是 "Hurried"。

> "I don't think anything fundamentally has changed except for the tension introduced by the very real possibility that if you have been working as a human on a math proof for a long time that AI pointed toward the problem you have been working on could scoop you at any time before you get your results out." — georgemcbay [c:50580151]
> （译文）我觉得除了新增的那种压力，什么都没变——你长期在人类这边做某个证明的题目，AI 指向了它，于是你随时可能在结果出来之前被抢走，这太真实了。

更根本的问题被另一个人问了：

> "A timely announcement like this makes me wonder: was the time just "right" for this, in mathematics? What proofs would have come out without AI, in the next few years?" — JoshTriplett [c:50579918]
> （译文）这种恰逢其时的公告让我想问：数学里是不是也有"时机正好"这回事？如果没有 AI，接下来几年本来会冒出哪些证明？

### 四、可验证不等于可理解

整条讨论里最锋利的技术分歧，是两个证明的"可核查性"完全不对称。

> "Not true - the long proof is the verifiable one (because we have it in Lean), the short human solution is the one that can't be verified without a lot of extra work." — trio8453 [c:50580481]
> （译文）不对——长的那份才是可验证的（因为它在 Lean 里），短的那份人类解反而要额外做大量工作才能验证。

这句话把上一节的体量对比整个翻了过来：25 万页的机器稿能被机器逐行检查，900 页的人工作品目前只能靠人读。

> "To verify, yes. To understand and push mathematics forward, no." — gr_norm [c:50580510]
> （译文）验证？行。理解并推动数学向前？不行。

反对者从另一个角度追问 25 万页里藏了什么：

> "AI has been great at finding loopholes. And who's going to find out what loophole they used in 250k pages?" — LarsKrimi [c:50580529]
> （译文）AI 很擅长找漏洞。可 25 万页里用的是哪个漏洞，谁去查？

也有人提醒，Lean 不是免检章：

> "Just because it's in Lean, doesn't mean it's correct, or that the proof actually proves what you think it does" — troupo [c:50580639]
> （译文）可别因为它在 Lean 里就默认它正确，或者默认这个证明真证了你以为它证的东西。

至于"看得懂"这一层，Alpöge 本人的说法被反复转发——论证极长，形式化已完成，但这只是他路上的一步，之后要设法讲明白。而那 10 多个"哇"的瞬间，在公告里被记了下来：

> "In the announcement, he lays out the general approach and says that he had 10+ "WOW" moments of insights while working with the AI on it." — vecter [c:50580610]
> （译文）在公告里他给出了大致路线，并说自己与 AI 一起工作时有过十几次"哇"的顿悟时刻。

顺带把 AI 证法拉回专家工作：

> "That doesn't mean the models aren't getting very good at math, but as in every other field, an expert pilot is going to get results a novice will not." — simplyluke [c:50580526]
> （译文）这不意味着模型在数学上不够强，但和所有领域一样，专家驾驶者拿到的结果不是新手能拿到的。

### 五、LLM 说它有错：是证据还是幻觉

Alpöge 那份发布后不久，就有人转来了一条相反方向的反馈——一位前 OpenAI 数学员工称该证明存在问题。讨论立刻分成两派。

> "@AcerFur (former openai math employee on twitter) claims there are issues with this proof: https://x.com/AcerFur/status/2123853069599547786" — markasoftware [c:50580084]
> （译文）@AcerFur（前 OpenAI 数学员工）称这份证明存在问题：<https://x.com/AcerFur/status/2123853069599547786>

支持这一侧的人给出了实测：

> "Can confirm that current GPT (with no guidance) took 5 minutes to find what it claims are errors with counterexamples." — JoshTriplett [c:50580180]
> （译文）可以确认：当前的 GPT（不加任何提示）用 5 分钟就找到了它声称存在的错误，还给出了反例。

反方指出这跟"往 LLM 里粘贴一段文本让它说有问题"没有本质区别：

> "I'm not arguing that LLMs aren't useful tools for mathematicians, I'm questioning the quality of discourse that amounts to "I pasted this into the LLM and it said there are errors"." — root_axis [c:50580492]
> （译文）我不是在说 LLM 对数学家没用，我质疑的是那种"我把东西粘给 LLM，它说有错"式的讨论质量。

有人给出更冷的技术判断——没有定理证明器兜底时，模型只在读文本：

> "I would guess that LLMs are much worse at math without having a theorem prover to validate approaches with. Since this draft is not formalized, an LLM is operating purely on the text which is more tenuous." — mahogany [c:50580532]
> （译文）我猜，没有定理证明器帮它验证路径时，LLM 做数学会差很多。这份草稿没有形式化，LLM 只是在读文本，这更靠不住。

### 六、数学家们的情绪

主帖是热闹的，但真正的情绪集中在 Tao 那个只有 18 条评论的帖子里。

> "Is anyone else struggling with feelings of both excitement and terror? I haven't felt this much personal uncertainty about my career/life since I was an L1 MLE (10 years ago)." — actusual [c:50579777] [thread 3]
> （译文）还有别人在挣扎于兴奋和恐惧交织的心情吗？自从十年前当 L1 MLE 以来，我没对职业生涯和人生有过这么强烈的不确定感。

一个自称数学家的人给出了一个让人意外的反应：

> "I'm a mathematician and I feel neither. I feel apathy. It's 4CT on speed." — emil-lp [c:50579946] [thread 3]
> （译文）我是数学家，两种感觉我都没有。我只觉得无聊。这就像加速版的四色定理。

四色定理正是这条类比的历史坐标：

> "Some context for non-mathematicians (like me): the Four Color Theorem was the first major theorem to be proved with extensive computer assistance, which caused a major kerfluffle when it happened back in the 1970’s." — munchler [c:50580028] [thread 3]
> （译文）给非数学家补个背景（我就是非数学家）：四色定理是第一个大量依赖计算机辅助证明的重大定理，当年（1970 年代）它引发了很大一场风波。

而在 Alpöge 那条 1254 条评论的主帖里，最有分量的怀疑来自一位记得 Wiles 的人：

> "I'm old enough to remember when Andrew Wiles announced a proof of Fermat's Last Theorem way back in 1993 [1]. It was long and complex and took at least 2 years for the maths community to accept it. I wouldn't be surprised if this isn't similar (or worse)." — jmyeet [c:50575589] [thread 2]
> （译文）我年纪够大，还记得 1993 年 Andrew Wiles 宣布费马大定理证明的时候。那个证明又长又复杂，数学界至少花了两年才接受。这份如果类似（或者更糟）我不会惊讶。

以及一条关于优先权的老故事——Wiles 当年正是靠提前公布"占坑"才抢在 de Fermat 之前拿到认可：

> "That's basically the approach Perelman took with the Poincare conjecture." — QuesnayJr [c:50580518]
> （译文）那基本上就是 Perelman 处理 Poincaré 猜想时的做法。

对 Alpöge 本人的分量，评论区给出的是相当一致的判断：

> "This is Levent Alpöge (https://en.wikipedia.org/wiki/Levent_Alp%C3%B6ge), a supremely qualified mathematician and one of the best in the world at guiding AI towards new discoveries in mathematics." — xianshou [c:50575281] [thread 2]
> （译文）这位是 Levent Alpöge（维基百科链接），一位资历极高的数学家，也是世界上最擅长引导 AI 在数学上做出新发现的人之一。

同一个人还补了一条前情：Alpöge 正是九月那场 Navier-Stokes 风波里被 OpenAI 抢了先的当事人之一。

> "Levent was one of the two mathematicians working on Navier–Stokes when OpenAI published their work on that problem - which was produced in a rush when they heard a rumor that someone from Anthropic had promising results on a millenium prize problem." — simonw [c:50575448] [thread 2]
> （译文）OpenAI 发布他们在 Navier–Stokes 上的工作时，Levent 正是当时研究该问题的两位数学家之一——那份成果是听到"某个 Anthropic 的人在千禧年难题上有了有希望的进展"的风声后仓促赶出来的。

所以三个月前他是被抢的那一方，这次他是发布的一方；而人类数学家成了"被逼着发"的那一方。

### 七、人类的贡献会怎样被抹掉

Alpöge 那条 1254 条评论的主帖里，最尖锐的一类问题指向溯源。

> "It could also be that several mathematicians were already close (after working for decades, like this post). Then AI got its hands on the breadcrumbs, merged them into the weights, and then laundered a path to a solution without a way to trace the credit." — avaer [c:50580103]
> （译文）也可能是好几个数学家已经接近了（就像这位，做了几十年）。然后 AI 拿到那些面包屑，把它们融进权重，再洗出一条通往解法的路径，而功劳无从追溯。

有人接着说，学术界的应对方式其实很脆弱：

> "I work as a staff developer at a research institution and it boggles my mind that researchers seem to uncritically use commercial LLM services instead of locally-hosted LLMs." — clusterhacks [c:50580214]
> （译文）我在一家研究机构做开发，最让我难以置信的是，研究人员似乎在毫无批判地使用商业 LLM 服务，而不是本地部署的模型。

更远的问题在 Tao 那个帖子的末尾被提出：AI 会做证明，那新的抽象概念谁来造？

> "What I wonder: how do we create new abstractions and concepts? Like whatever “Langlands program” is?" — softwaredoug [c:50580358] [thread 3]
> （译文）我想问的是：新的抽象和概念要怎么造出来？比如那个"Langlands 纲领"之类的东西？

回答这个问题的网友顺手解释了它为什么重要：

> "Langlands is interesting because it is most conjectural (and not completely clear what the precise statements are -- hence "program" and not "conjecture"), but proving special cases turn out to be tremendously powerful. One special case implied Fermat's Last Theorem, for example." — QuesnayJr [c:50580662] [thread 3]
> （译文）Langlands 有意思的地方在于它最猜想性质（精确陈述本身都不太清楚——所以叫"纲领"而不是"猜想"），但把特例证出来威力惊人。比如其中一个特例就蕴含了费马大定理。

也就是说，如果 Alpöge 那份证明真的成立，它用的正是人类过去六十年造出来的抽象工具；而下一个这样的抽象，还不知道由谁造。至于眼前这场的收尾，一位网友给出了一个词：

> "There's a whole term for this! It's called "Multiple discovery"" — dgritsko [c:50580663]
> （译文）这有个专门的术语，叫"多重发现"。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 两案并审 | rvz | 别按名气定输赢，等多位权威验证 |
| 体量对比 | trio8453 | 25 万页那份才是可验证的，900 页那份才需要人读 |
| 可理解性 | gr_norm | 能验证不等于能推进数学 |
| 纯人类存疑 | method_capital | "全人类零 AI"？我押全部身家赌它假 |
| 学术惯例 | yewenjie | ABC 猜想和 Mochizuki 的教训在前 |
| 反对 AI 证法 | devin | 那些 AI 证明是拼凑的乱码 |
| 优先权焦虑 | A_D_E_P_T | 藏着的十年工作会被模型吃掉 |
| 死循环 | j2kun | 藏着被抢，公开也被喂进模型 |
| 经费约束 | duplessitous | 只发半成品的人怎么拿经费 |
| 学术提速 | cximenez | 抢发焦虑反而加速了成果公开 |
| 时机之问 | JoshTriplett | 没有 AI，接下来几年本来会出哪些证明 |
| LLM 找错 | JoshTriplett | GPT 5 分钟找出反例（但需要人验证） |
| 质疑工具 | root_axis | "粘给 LLM 它说有错"不构成讨论质量 |
| 无证明器 | mahogany | 没形式化时，模型只是在读文本 |
| 专家信用 | xianshou | Alpöge 说有 Riemann，那就有了 |
| 历史对照 | jmyeet | Wiles 当年也花了两年才被接受 |
| 冷静派 | emil-lp | 数学家的感觉是无聊：加速版四色定理 |
| 溯源焦虑 | avaer | 模型把碎屑合并成路径，功劳无从追溯 |
| 抽象危机 | softwaredoug | 新的抽象概念谁来造？ |

## 总体情绪

这一天最反常的地方，是两条通常不相交的赛道撞在了同一个下午：一条以"人"的名义交卷，一条以"机器"的名义交卷，而双方都无法确定对方是否算数。讨论区的火药味几乎全部来自这个不确定性——不是因为两份证明谁更漂亮，而是因为"证明"这件事的判定权正在从同一个人手里，转交给一堆彼此不信任的机制：Lean 证明器、社区审稿、声誉，以及正在训练的模型。

人类的回答分成两种姿态。一种是把标准抬高：要等多方验证，要看形式化，要记住 Wiles 和 Perelman 的历史。另一种是把节奏加快：既然藏不住，那就赶紧发，发出来至少还能争一个"最早公开"的名分。而当这两条路线在同一个作者身上重叠时，结果就是 Vakil 那篇帖子标题里的那个词——Hurried。

至于这算不算数学史上的时刻，评论区给了两种互相排斥的读法：一种认为这是"多重发现"的经典样本，人类和机器在同一天从不同方向摸到同一个答案，说明时机本身在起作用；另一种认为这正是把成果的价值和可理解性彻底分开的那一天——一份能被检查但没人读得懂，一份读得懂但还得靠人读。两种读法都指向同一个事实：此后没人再能用"我解出来了"这句话直接换到信任了。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Hurried Announcement: Alessandro Masullo GRH（HN 主帖） | <https://news.ycombinator.com/item?id=50579568> |
| 2 | Levent Alpöge claims proof of the Generalized Riemann Hypothesis（HN） | <https://news.ycombinator.com/item?id=50574968> |
| 3 | Unforced Euler singularity, unforced Navier-Stokes singularity, and the GRH（HN，Terence Tao 博客） | <https://news.ycombinator.com/item?id=50578358> |
| 4 | Ravi Vakil 博客原文（Math 216） | <https://math216.wordpress.com/2026/11/20/hurried-announcement-alessandro-masullo-grh/> |
| 5 | 《The Music Of The Primes》（Masullo 证明草稿 PDF） | <https://math216.wordpress.com/wp-content/uploads/2026/11/the-music-of-the-primes.pdf> |
| 6 | Alpöge 的公告 remark.pdf | <https://alpo.ge/remark.pdf> |
| 7 | Alpöge 的 Lean 形式化（14 分卷之一） | <https://alpo.ge/lean.tar.gz.part01> |
| 8 | Terence Tao 博文原文 | <https://terrytao.wordpress.com/2026/11/20/unforced-euler-singularity-unforced-navier-stokes-singularity-and-the-generalized-riemann-hypothesis/> |
| 9 | Lean Zulip：Alpöge 证明的验证讨论 | <https://leanprover.zulipchat.com/#narrow/channel/113488-general/topic/Discussion.3A.20Alp.C3.B6ge.20Proves.20the.20Riemann.20Hypothesis> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 409 分、125 条评论，归档 100 条；thread 2 1889 分、1254 条评论，归档 100 条；thread 3 111 分、18 条评论，全量入库；归档快照 2026-11-20 19:42 UTC）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

事实来源与限制：Vakil 博客正文抓取成功（含公告要点与 PDF 链接），Masullo 证明 PDF 正文未抓取；Alpöge 的 remark.pdf 未抓取（归档标记为 skipped），本文关于其公告的表述来自 Tao 博文与评论区引用，未经原文核实；Tao 博文抓取在 8000 字符处截断，三条结果的要点均在截断前，但后续技术细节章节未完整取得。"证明已做 12 年""原本还需至少一年""篇幅 900 至 940 页""25 万页""14 个分卷的 tar.gz""论证极其漫长、形式化已完成、只是路上的一步""10 多次顿悟"等均为博客正文或评论者转述，本摘要按来源口径转述，未做独立核实。

引文中关于"是否掺入 AI""LLM 找出的错误是否成立""人类贡献是否被抹掉""数学家该不该加快发表"等均为评论区个人判断或推测，本文按发言者立场转述，不作事实认定。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
