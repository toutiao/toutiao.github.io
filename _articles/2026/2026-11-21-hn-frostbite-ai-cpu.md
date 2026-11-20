---
layout: post
title: >-
  Frostbite：一颗由 AI 从零设计的通用 CPU，4.59 倍每瓦性能，与一场关于「对照组是谁」的争论 — HN 讨论摘要
date: 2026-11-21
hn_id: 50572503
categories: [articles]
excerpt: >-
  architectlabs.com 说他们的 AI 系统自主迭代了编译器、ISA、架构、微架构、RTL 与验证，做出一颗全新指令集的通用 CPU
  Frostbite：25 个工作负载（其中 15 个留到最终评测才启用）上，每瓦性能是现代双发射顺序执行超标量核的 4.59 倍。
  评论区真正拆的不是这些数字，而是分母——对照组是一颗顺序核，而「芯片造出来了吗」没有人能回答。
tagline: >-
  4.59 倍的分母是一颗顺序核，而芯片还在纸上。
---

> 来源：HN 讨论主帖 [Frostbite: A new CPU architecture discovered, designed and verified by AI](https://news.ycombinator.com/item?id=50572503)（535 分，285 条评论），页面指向 architectlabs.com 的博客文章。归档快照 2026-11-20 19:42 UTC，入库 100 条评论（触及抓取上限 100；Algolia 未返回评论分，分数字段均为 0），引文选择依据为内容本身与讨论价值。引文中的 HTML 实体按 HN 页面显示形式还原，文字与作者逐条与归档评论比对。

## 原文概要

上 HN 的这篇文章来自 architectlabs.com，标题把三件事并列：发现、设计、验证——都由 AI 完成。核心产品叫 Frostbite，一颗从零开始设计指令集的通用 CPU，作者团队称自己的 AI 系统自主迭代过编译器、ISA、架构、微架构、RTL、验证，直到最终 GDS。

摘要里给出的数字是：在一组 25 个工作负载上（其中 15 个留到最终评测才启用），对比一颗「现代的、已被硅片验证过的超标量（双发射、顺序执行）CPU 核」，取得了 4.59 倍的每瓦性能。评论区后来从页面上引出的另一组数字是每面积 8.77 倍——一个 Frostbite quad（2×2 的 tile 网格）配四个 L3 节点占 0.792 mm²，被比的那颗核在同样工艺下是 0.895 mm²。这篇文章是同一系列的前作 Redwood 的后续：那次他们展示的是给定架构后，AI 系统能实现、验证并交付一颗推理加速器。

技术路线的关键词是 interaction nets（交互网）。文章给出的理由是三个性质：每一步都是局部的、每个依赖都是显式的、每个值恰好只有一个所有者。主流编程语言编译到通用 CPU 时会隐藏部件之间的依赖——任何代码都能读写任何变量——于是硬件只能按最坏情况假设，在运行时重新发现哪些指令彼此依赖。文章接着给出这段停滞史：单核性能自 2000 年代初就基本停摆，于是大家转向 Xeon、Zen、Vera 这类多核 CPU；多核又要求所有核心看到同一份内存的幻觉，维持这个幻觉需要深层缓存层次与一致性协议，代价是面积和功耗，并且扩展性差。

交互网是另一种模型：程序是节点构成的图，计算是对端口相连的节点对做重写。每次重写只触及一小块局部图形；因为每个节点只有一个主端口，两对活跃节点永不重叠，重写可以按任意顺序进行，甚至同时进行，结果总是一样。它是线性的——每个值恰好被用一次——因此硬件不需要守护任何共享可变状态。配套语言 Vine 能把看起来普通的程序直接编译成交互网。

流程部分写得很具体。工作负载先按「同时展开很多独立部分」「一轮轮并行」「长顺序链」「数据相关分支」「递归」五类组织，搜索集与保留评测集分开；FFT、radixsort、LU 沿用 SPLASH-2 的实现，但尺寸缩到 1/64，因为常规尺寸不适合探索阶段；另外补了五个更贴近实际的保留工作负载：卡尔曼滤波、PCA、有限元分析、LU 求解、LZ4 解压。AI 系统先合成研究论文与既有基准，用 Python 模型在高层次架构想法之间做权衡，最后收敛出一份 141 页的 PDF，覆盖编程模型、运行时与芯片的高层模块——第一次 RTL 迭代完成后它被删掉了，因为里面的数字离物理可实现太远。

系统建模阶段用了一套自研的规范语言 ASL，芯片的系统模型 Arcmodel 就写在 ASL 里：RTL、系统模型、UVM、SVA 之间可以做机器可检的翻译与精化，功耗与性能估计误差在 1–5% 内，速度约为 RTL 仿真的 200 倍，并且可以通过「契约」做形式化验证。文章给出的直观例子是五皇后问题：C++ 程序一次走一步搜索树；同一搜索写成交互网后是 3,183 次交互，关键路径只有 262 步，且每一步平均有大约 12 次交互可以同时跑。

作者列出两条理论优势：多线程「免费」——不需要线程、锁与竞态，也不需要乱序执行那套机制去把并行从程序里挖出来；数据可以住在离使用点很近的小容量本地存储里，从而省掉大缓存子系统的面积与功耗，也省掉系统层面的缓存一致性复杂度。

## 讨论焦点

### 一、4.59 倍的分母是一颗顺序核

最先被拆开的是对照组。

> "I'm quite skeptical; their baseline is a in-order CPU, instead of a modern out-of-order design, and they're testing a small amount of programs." — pizza234 [c:50572930]
> （译文）我很怀疑；他们的基线是一颗顺序执行 CPU，而不是现代的乱序执行设计，而且他们测的程序数量很少。

> "They're claiming better performance per watt, not better absolute performance, and out-of-order does worse on that metric than the superscalar in-order design they say they beat by 4.59×." — kragen [c:50573236]
> （译文）他们主张的是更好的每瓦性能，不是更好的绝对性能；而在这项指标上，乱序执行反而比他们声称超过 4.59 倍的那颗超标量顺序核更差。

这正是文章摘要里的原话结构：4.59 倍比较的对象是「一颗现代的、已被硅片验证过的超标量（双发射、顺序执行）CPU 核」。讨论者抓住了「顺序执行」这四个字——今天被视为保守对照的那类核，在每瓦指标上恰恰有天然优势。

> "Isn't this more about work-per-joule than about throughput? At least that benchmark graph is in performance-per-watt." — amelius [c:50573229]
> （译文）这说的更多是每焦耳能做多少功，而不是吞吐吧？至少那张基准图给的是每瓦性能。

有人把这条指标的性质讲得更白：

> "The performance per watt of very slow CPUs is always very good, so that alone is not impressive unless much more data is provided to prove that is really better than what is typical." — adrian_b [c:50574465]
> （译文）很慢的 CPU 每瓦性能总是很好，所以单看这一点并不惊人，除非提供更多数据来证明它确实比典型水平更好。

还有人对「绝对数字」的缺席不满意：

> "Their claims would be a lot more interesting if they provided some kind of absolute numbers to compare against." — kragen [c:50574493]
> （译文）如果他们给出某种可以对照的绝对数字，这些主张会有意思得多。

### 二、每面积 8.77 倍：算术与工艺

评论者把页面上另一组数字拿出来算了一遍。

> "It got 8.77x performance per area, and was 88% of the area, so that's 7.76x actual performance, right?" — csande17 [c:50573371]
> （译文）它在面积上做到了 8.77 倍性能每面积，而面积是对方的 88%，也就是 7.76 倍的实际性能，对吧？

同一位评论者还注意到，文章没有说明被对比的那颗单核处理器是谁——出于法律原因。另一位则从工艺与面积的角度推了一轮：

> "They say that the ISA will be published. At that time it will be easier to appreciate whether this CPU architecture is really innovative." — adrian_b [c:50574465]
> （译文）他们说 ISA 会公开。到那时再判断这套 CPU 架构是否真的创新会容易得多。

他的完整分析指出：被对比的「传统」CPU 面积只比 Cortex-A720 略大，而 Cortex-A720 是在密度高近一倍的 CMOS 工艺上做的、4 路超标量乱序核；如果两者工艺相同，被对比核的面积应当是 Cortex-A720 的一半多一点，但性能要差上几倍——两边的面积都比各自的性能应有值大。此外，顺序执行 CPU 的性能对基准选择非常敏感：FFT、LU 分解这类规整循环能跑得很好，换成分支难以预测的编译器基准就未必。

比较方法本身也被质疑：

> "They also compare their architecture simulation language to RTL, instead of comparing it to existing arcitecture sim languages." — petra [c:50572979]
> （译文）他们把自己的架构仿真语言跟 RTL 比，而不是跟已有的架构仿真语言比。

还有人对跨工艺的能耗数字提出警告：

> "The fairest comparison is between chips from major vendors in the same year." — tlb [c:50578364]
> （译文）最公平的比较，是同年同代各大厂商的芯片之间的比较。

### 三、还没流片的那 90%

另一条线不问数字，只问物理现实。

> "I don't see any indication that they got their chips fabricated, which is the "last 90%" of the work." — fwip [c:50574502]
> （译文）我没看到任何迹象表明他们把芯片投片了，而那是最后 90% 的工作量。

> "I'm always on the fence and I only believe it when I see such a CPU manufactured and running crysis with better metrics (energy, performance, thermals, stability) than a regular off the shelf cpu as we know it." — mawadev [c:50573761]
> （译文）我一直半信半疑，只有当我看到这样一颗 CPU 被造出来、跑着孤岛危机，而且各项指标（能耗、性能、散热、稳定性）都优于我们熟悉的现成 CPU 时，我才会相信。

制造环节的物理约束则被反复强调：

> "Modern chip fabrication occurs on a microscopic scale. It requires extreme precision and thus must be done in a highly sterile environment. The slightest speck of dust is enough to ruin the output." — jqpabc123 [c:50573103]
> （译文）现代芯片制造在微观尺度上进行，需要极端的精度，因此必须在高度洁净的环境里完成。一点点灰尘就足以毁掉产出。

同一位评论者的结论更直接：这种环境在家里几乎不可能实现，至少短期内绝无可能——给家里封装一台核反应堆大概还容易些。

最干脆的一句来自评论区：

> "A new architecture discovered, designed, verified, tested, used, enjoyed, glazed, and eventually forgotten solely by their LLM." — einpoklum [c:50572803]
> （译文）一颗由他们的 LLM 独自发现、设计、验证、测试、使用、享用、上釉，并最终被遗忘的新架构。

> "When they actually make a CPU and offer it for use, then we'll talk about their magic LLM-designed CPU." — einpoklum [c:50572803]
> （译文）等他们真的造出一颗 CPU 并开放使用，我们再来谈他们那颗魔法般的 LLM 设计 CPU。

### 四、是新的架构，还是新的包装

interaction nets 本身不是新东西。

> "They are using _interaction nets_. Interaction nets date back to the 1990s, they are a fundamentally different programming paradigm which is parallelisable by their nature (graph rewriting that can be done locally in any order)." — shioyama [c:50574579]
> （译文）他们用的是交互网。交互网可以追溯到 1990 年代，它是一种本质上就天然可并行的、根本不同的编程范式（图重写可以在局部以任意顺序进行）。

> "We will continue to invent Transputer-shaped things forever, it seems." — rossng [c:50572735]
> （译文）看来我们会永远继续发明 Transputer 形状的东西。

> "Also, I'm not an expert in CPUs, but the underlying idea doesn't seem entirely novel - WaveScalar explored dataflow-based architecture 20+ years ago." — pizza234 [c:50572930]
> （译文）另外我不是 CPU 专家，但底层思路看起来并不全新——WaveScalar 在二十多年前就探索过数据流架构。

技术层面的追问则集中在「并行到底从哪来」：

> "Instruction nets sound intriguing, but it looks like execution is based on rewrite rules. Does it need a lot of copying and marshalling to get work done?" — pshc [c:50572966]
> （译文）指令网听起来很有意思，但看起来执行是基于重写规则的。它需要大量拷贝和数据搬运才能把事情做完吗？

> "You need either the compiler or the programmer to do the parallelization, and in practice the communication costs between cores can be large enough for the parallelization to not be worth it for simple programs." — Tuna-Fish [c:50573198]
> （译文）并行化要么得靠编译器，要么得靠程序员；而实践中核间通信开销可能大到让并行化对简单程序不划算。

> "Wouldn't a SIMD/SIMT architecture achieve similar speedups? There are many ways to parallelise programs. What am I missing?" — WithinReason [c:50572987]
> （译文）SIMD/SIMT 架构不也能拿到类似的加速吗？并行化程序有很多种方法，我漏掉了什么？

也有人不把 tile 网格当新东西：

> "The frostbite tiles and their work-stealing is reminiscent of a 2d-grid of basic blocks from compiler design." — dapperdrake [c:50572973]
> （译文）Frostbite 的 tile 和它们的 work-stealing，让人想起编译器设计里的二维基本块网格。

### 五、怎么分辨「AI 写的突破」和「AI 写的疯话」

这条支线独立于技术，直接指向这份材料本身。

> "Absolutely breathtaking number of claims, and impossible to find the seam between human endeavour and spambot output." — ytxm [c:50572755]
> （译文）数量惊人的主张，而且很难在人类努力和垃圾机器人产出之间找到那条缝。

> "One of the worst things about the llm era is that it's very hard to tell the difference between ai-written breakthroughs and ai-written schizoposts." — xyzsparetimexyz [c:50572932]
> （译文）LLM 时代最糟糕的一件事之一，就是很难分辨 AI 写的突破和 AI 写的胡言乱语。

> "It's slop. Token spend that doesn't accomplish anything because the prompter doesn't know what they're doing." — smolder [c:50573622]
> （译文）这就是垃圾内容。烧掉的 token 什么也没做成，因为写提示词的人自己也不知道自己在干什么。

> "We used to say ‘show me the code’, we need a bit more proof today." — sph [c:50573007]
> （译文）我们以前会说「把代码拿出来」，今天我们需要多一点证据。

还有一层是关于动机的猜测：

> "it's pretty obvious their goal is to get aqui-hired by a big lab to work on their chips" — dist-epoch [c:50572863]
> （译文）他们的目标显然是被大实验室招去研究自己的芯片。

> "So far this thread is a little breathless about AI." — FrustratedMonky [c:50572923]
> （译文）到目前为止，这个帖子对 AI 的口气有点过于激动。

### 六、真正的分歧在编程模型：全球内存是不是神话

讨论后半段绕回了文章的理论动机，也埋着一条更长的支线。

> "The assumption of a single global memory is what doomed C. It's the 21th century. Computers don't have global memories anymore, they pretend they do." — imtringued [c:50572919]
> （译文）正是「只有一份全局内存」这个假设毁了 C。现在是 21 世纪，机器早就不拥有全局内存了，它们只是假装有。

> "I agree, I've always viewed C as a sort of domain specific language for Von Neumann architectures." — ModernMech [c:50576595]
> （译文）我同意，我一直把 C 看成某种冯·诺依曼架构的领域专用语言。

反对意见同样具体：

> "Breaking down things in terms of tasks is not hard. The hard part is discovering that those parts need to communicate." — skydhash [c:50573732]
> （译文）把事情拆成任务并不难，难的是发现这些部分之间需要通信。

> "I'm with you, but I don't see a clear path from "here" (illusion of the same memory) to "there" (each processor has its own memory, I guess)." — actionfromafar [c:50572998]
> （译文）我同意你的看法，但我不清楚从「这里」（共享内存的幻觉）到「那里」（我猜是每个处理器有自己的内存）之间有什么清晰路径。

而少数人看到的收益不在速度，在可读性：

> "What I see as the more promising side of this type of development is a tighter coherence, and thus more transparency in expected runtime performance, between the software above the ISA and the hardware below it." — jkhdigital [c:50575008]
> （译文）在我看来，这类开发更有希望的一面，是 ISA 之上的软件与 ISA 之下的硬件之间咬合得更紧，因此运行时间的可预期性也更透明。

### 七、钱会往哪里流：设计变便宜之后

最热的一条支线不谈 CPU，谈产业链。

> "If AI makes it so that it takes 2 months to design a chip instead of 2 years, then there will way more chips designed to accelerate applications that previously weren't viable economically." — aurareturn [c:50572564]
> （译文）如果 AI 让设计一颗芯片从两年变成两个月，那么会有远多得多的芯片被设计出来，去加速那些此前在经济上不划算的应用。

接下来的问题是谁更值钱。一种看法是代工厂：

> "Fabs follow Rock's law. The cost of a fab doubles every 4 years." — aurareturn [c:50572909]
> （译文）晶圆厂遵循 Rock 定律：一座厂的成本每四年翻一倍。

> "Right now, it costs $20b - $40b to create one fab." — aurareturn [c:50572909]
> （译文）现在建一座晶圆厂要 200 亿到 400 亿美元。

反方向的看法则认为定制芯片的真正瓶颈 AI 降不下来：

> "Right now, the cost that limits doing small custom chips is not designing the chip, it's the cost of making the mask sets for the chips and other foundry NRE, which is well above $50M for a single leading edge chip these days." — Tuna-Fish [c:50573222]
> （译文）如今限制小规模定制芯片的成本不是设计芯片，而是做掩模版和晶圆厂其他非经常性工程费用，对一颗最先进工艺的芯片来说，这笔钱远高于 5000 万美元。

> "This money is generally not spent on things that AI can easily make cheaper." — Tuna-Fish [c:50573222]
> （译文）这笔钱通常花在 AI 很难压低成本的地方。

> "It's just a guess, but given that it takes 20 years to take a chip manufacturing idea to market, ideas are not the bottleneck, but working in the physical world is." — petra [c:50574707]
> （译文）只是猜测，但既然一个芯片制造想法要 20 年才能走上市，那么瓶颈就不是想法，而是在物理世界里干活。

至于 TSMC 会不会因此贬值，评论直接分成两派：

> "I’d say TSMC becomes less valuable because there will be multiple fabs trying to meet demand." — dlisboa [c:50572871]
> （译文）我会说 TSMC 会变得不那么值钱，因为会有多家晶圆厂来满足需求。

> "All non-technical overhead also gets reduced; what a 10-person company can do today assuming they can run their agents 24/7 makes the situation from just 10 years ago look medieval." — edg5000 [c:50573172]
> （译文）所有非技术性的开销也会跟着下降；今天一家十个人的公司、只要能让 agent 24 小时不停歇能干的事，跟十年前比像是中世纪。

乐观派干脆把整条链画成了全自动：

> "End to end AI - Ask to solve a problem, AI designs the chips, fab delivers it, AI writes the software in a completely custom language." — s08148692 [c:50572802]
> （译文）端到端的 AI——提出一个要解决的问题，AI 设计芯片，晶圆厂交付，AI 用一门完全定制的语言写出软件。

而与之配套的，是一条从《星际迷航》里来的老忧虑：

> "Isn’t there an old episode of Star Trek where they visit a planet with a population that has become utterly dependent on a supercomputer?" — bentobean [c:50572861]
> （译文）《星际迷航》里不是有一集，讲他们造访一个星球，那里的居民已经彻底依赖一台超级计算机了吗？

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 基线可疑 | pizza234 | 基线是一颗顺序核，测的程序也很少 |
| 指标错位 | kragen | 主张的是每瓦性能，不是绝对性能 |
| 慢核省电 | adrian_b | 很慢的 CPU 每瓦性能总是好 |
| 要绝对数字 | kragen | 给出可对照的绝对数字才有意思 |
| 面积算术 | csande17 | 每面积 8.77 倍、面积 88%，实际约 7.76 倍 |
| 工艺不对等 | tlb | 最公平是比较同年同代厂商的芯片 |
| 还没流片 | fwip | 投片是最后 90% 的工作 |
| 要看到实物 | mawadev | 造出来、跑起来、指标更好，我才会信 |
| 物理世界是瓶颈 | petra | 瓶颈不在想法，在物理世界里干活 |
| 掩模与 NRE | Tuna-Fish | 5000 万美元级的掩模与厂务费用，AI 难压 |
| 不是新东西 | shioyama | 交互网可以追溯到 1990 年代 |
| 前人已有 | pizza234 | WaveScalar 二十多年前就探索过数据流架构 |
| 并行归谁 | Tuna-Fish | 并行化要么靠编译器，要么靠程序员 |
| 指标口径 | amelius | 说的是每焦耳能做多少功，不是吞吐 |
| SIMD 就够了？ | WithinReason | SIMD/SIMT 不也能拿到类似加速 |
| 边界难辨 | xyzsparetimexyz | 难分辨 AI 写的突破和 AI 写的疯话 |
| 判定为 slop | smolder | 烧掉的 token 什么也没做成 |
| 要更多证据 | sph | 我们以前说「把代码拿出来」 |
| 全球内存是神话 | imtringued | 机器早就不拥有全局内存，只是假装有 |
| 拆分不是难点 | skydhash | 难的是发现这些部分之间需要通信 |
| 收益在透明 | jkhdigital | 软件与硬件之间咬合更紧，性能更可预期 |
| 设计变便宜 | aurareturn | 设计从两年到两个月，定制芯片会暴增 |
| 厂更值钱 | aurareturn | Rock 定律：建厂成本每四年翻倍 |
| TSMC 贬值派 | dlisboa | 多家晶圆厂分食需求，TSMC 不那么值钱 |
| 小公司红利 | edg5000 | 十人公司 24 小时跑 agent，今天能做的事像十年前的中世纪 |

## 总体情绪

这是一场技术判断与身份判断缠在一起的讨论。技术一侧并不怀疑工作量——写 ISA、写成千上万行 RTL、做形式化验证、跑通仿真，这些都是实打实完成的；被怀疑的是比较基准、流片状态和「4.59 倍」这个倍数的分母。也正因为怀疑集中在测量方法上，那些提出「缺少绝对数字」「对比对象是顺序核」「没看到投片」的评论，反而比赞美者更有信息量。

另一侧怀疑的是材料本身。当一份文档同时给出新指令集、新微架构、新形式化工具链和新基准，而产品还没有一颗硅片时，读者最容易滑向的那个问题就是「这是不是模型写出来的」。评论区里那句「很难在人类努力和垃圾机器人产出之间找到那条缝」，与其说是贬低，不如说是描述了一种新的阅读成本。

最后一条支线把话题推到了产业链：如果设计周期真的从两年压到两个月，那么稀缺的不再是设计，而是掩模、厂务、电力和材料。有人因此更看好晶圆厂，有人因此更看空晶圆厂，也有人泼了盆冷水说瓶颈根本不在想法上。三方都同意的只有一件事——这整件事目前还停在纸上，而纸上没有一颗硅片。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Frostbite: A new CPU architecture discovered, designed and verified by AI（HN 主帖） | <https://news.ycombinator.com/item?id=50572503> |
| 2 | Frostbite（原文页面，architectlabs.com） | <https://architectlabs.com/blog/frostbite> |
| 3 | Interaction nets（Wikipedia，评论区引用） | <https://en.wikipedia.org/wiki/Interaction_nets> |
| 4 | Moore's second law（Wikipedia，评论区引用 Rock 定律） | <https://en.wikipedia.org/wiki/Moore%27s_second_law> |
| 5 | Transmeta Crusoe（Wikipedia，评论区引用） | <https://en.wikipedia.org/wiki/Transmeta_Crusoe> |
| 6 | Seastar（评论区引用的架构参考） | <https://seastar.io/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 535 分、285 条评论，归档快照 2026-11-20 19:42 UTC，入库 100 条，触及抓取上限 100，未取到全量评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文抓取成功，但正文截断在 8000 字符处，截断点落在「形式化契约与系统建模」一节中途；「原文概要」中的事实（4.59 倍每瓦性能、25 个工作负载与 15 个保留负载、interaction nets 的三条性质、141 页 PDF、ASL 与 Arcmodel 的 1–5% 误差与约 200 倍于 RTL 仿真的速度、五皇后 3183 次交互与 262 步关键路径、SPLASH-2 缩至 1/64 等）均来自该截断前的正文，其后的章节（验证结果、最终架构细节、绝对性能数字、GDS 的定义等）未完整取得。

每面积 8.77 倍、0.792 mm² 与 0.895 mm² 这组数字来自评论者 csande17 对页面的引用，不在本次取得的正文范围内，本文未独立核实；对被对比 CPU 身份、是否已投片、性能绝对值等事项的判断，均为评论区个人看法。

文中关于晶圆厂成本、Rock 定律、掩模与 NRE 费用、产业链价值转移的引述均为评论者个人观点，不代表事实认定；涉及未上市研究与未流片设计的信息以原文与评论原文为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
