---
layout: post
title: >-
  Google 的 AI 写下整数分解论文，密码学界却在发抖 — HN 讨论摘要
date: 2026-11-26
hn_id: 50642086
categories: [articles]
excerpt: >-
  Google 的多智能体框架 Cogentic 一次交出十篇论文：整数分解跑到 L_N[1/3, 105]，
  离散对数跑到 (pn)^{o(log n)}，每篇都带完整 Lean 形式化，作者栏里没有人类。
  241 分的主帖下面，同一批人却在算 10^2572 次运算，以及一条 reddit 传闻。
tagline: >-
  AI 交卷，人类传谣，密码学界待命。
---

> 来源：HN 讨论主帖 [Google Releases Cogentic Papers on Integer Factorization, Discrete Logs and More](https://news.ycombinator.com/item?id=50642086)（241 分，203 条评论），指向 google-research 仓库里的 `cogentic_research_papers` 目录。关联帖：[Rumors swirling that labs might have cracked Factoring in P](https://news.ycombinator.com/item?id=50643065)（145 分，78 条评论），原文是 reddit r/singularity 的传闻帖。本篇为 cluster 模式，论文发布为 thread 1，reddit 传闻为 thread 2。两帖分别于 2026-11-25 13:33 UTC 与 15:08 UTC 提交，归档快照 2026-11-25 16:54 UTC：thread 1 原始 203 条评论、入库 100 条，thread 2 入库 78 条。归档分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文按归档评论原文截取，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。

## 原文概要

2026 年 11 月 25 日，google-research 仓库里多出一个目录 `cogentic_research_papers`。README 第一句写着：“This directory holds research papers that were produced by Cogentic.” 目录下十个子目录、十篇论文，分四批投放：11 月 25 日六篇、11 月 23 日两篇、11 月 18 日一篇、10 月 30 日一篇。

Cogentic 这个名字来自一篇 9 月 30 日投稿、10 月 1 日修订的 arXiv 预印本《Cogentic: Multi-Agent Orchestration for Automated Proof Discovery》，作者是 Yang Cai、Vineet Gupta、Yanchen Jiang、Christopher Liaw、Aranyak Mehta、Grigoris Velegkas、Di Wang（Google Research 与 Google DeepMind）。摘要里的机制描述很具体：一个迭代的 prove-verify 循环，编排器把一个独立 prover 的种群分配到不同的证明方向上，交给若干专门组件做对抗式验证，被确认的中间结果写进一个持久化的 verified ledger，后面的轮次在它之上继续。底模是 Gemini 3.1 Pro 或早期版本的 Gemini 4 Argon，产出落在在线学习、拍卖理论与机制设计三个方向，每篇都由领域专家独立验证。

11 月 25 日这批里最扎眼的是两篇数论。第一篇《Unconditional Integer Factorization in Time L_N[1/3, O(1)]》给出一个无条件、零误差的 Las Vegas 算法：在单台固定的统一经典多带图灵机上计算任意 N ≥ 2 的完整素因数分解，最坏情况期望时间 L_N[1/3, 105]，确定性工作空间 L_N[1/3, 40]，其中 L_x(α, c) := exp(c (ln x)^α (ln ln x)^{1−α})。输出里的每一个素因子都由 AKS 素性测试加直接相乘做确定性验证，不依赖任何未经证明的数论假设。完整的无条件 Mathlib-only Lean 4（v4.35.0）形式化已经完成，将以配套投稿发布。

第二篇《Unconditional Deterministic Subexponential Integer Factoring and Quadratic Nonresidue Construction》给出显式、无参数的确定性算法：`algFactor` 在最坏情况位运算复杂度 O(exp(3 (ln N)^{3/4})) = L_N[3/4, o(1)] 内输出任意合数 N ≥ 4 的非平凡因子；`algQnr` 用 exp(O((ln p)^{1/2} ln ln p)) = L_p[1/2, O(1)] 构造奇素数模下的二次非剩余；`algExp` 做确定性的 (p−1) 次幂湮灭，复杂度 O(exp(3 (ln N)^{3/4}))，产出满足 ln M̃ ≤ exp((ln N)^{0.65}) 的指数。Lean 4（v4.33.0）形式化同样完成。

同批还有一篇离散对数：《Discrete Logarithms in Finite Fields of Fixed Characteristic in Sub-Quasi-Polynomial Time》，在任意固定小特征有限域 F_{p^n}^× 的乘法群上给出无条件经典零误差 Las Vegas 算法，最坏情况期望位复杂度 exp((2+o(1))/(ln ln ln n) · (ln n)²) = (pn)^{o(log n)}。另外两篇分别把多项式时间近似的门槛从 1/3 + δ 压到 1/5（《An Exact Polynomial-Time Algorithm for 1/5-Approximate Nash Equilibria in Bimatrix Games》），以及把 Lovász–Saks log-rank 猜想的上界从 Lovett 的 O(√r log r) 改到 r^{1/2−ε}（《Breaking the Square-Root Barrier for the Log-Rank Conjecture》）。

而每个子目录 README 的最后一段都是同一句话：这篇论文连同它的 Lean 形式化，全部由 Cogentic 使用 Gemini 4 生成，除了最初那句让 Cogentic 写出完整证明与形式化的提示词之外，没有任何人参与。

## 讨论焦点

### 一、同一天的两件事：论文放出来，传闻已经在跑

主帖 241 分，203 条评论，指向的是一个 GitHub 目录而不是一篇论文。最早认出它是什么的评论者把框架的形状说清楚了。

> "Cogentic appears to be a specialized harness for existing LLMs to collaborate together to solve mathematical conjectures, using a central orchestrator and a shared database of intermediate proofs." — david-gpu [c:50642161]
> （译文：Cogentic 看起来是一个专用的框架，让现有的 LLM 协作起来解决数学猜想，用一个中心编排器加一个存放中间证明的共享数据库。）

> "And with just that, using Gemini 4 Argon, they have already obtained a number of interesting results? Math is going through its own version of the industrial revolution." — david-gpu [c:50642161]
> （译文：就靠这些，用 Gemini 4 Argon，他们已经拿到了一批有意思的结果？数学正在经历它自己那版工业革命。）

背景链接也很快被补上——Cogentic 那篇 arXiv 预印本本身。

> "Context: &quot;Cogentic: Multi-Agent Orchestration for Automated Proof Discovery&quot; (2026)" — schleck8 [c:50642439]
> （译文：背景：《Cogentic: Multi-Agent Orchestration for Automated Proof Discovery》（2026））

评论区里也有人把论文原文摘了出来，引的是 log-rank 那篇的定理 3.1。这段文字和仓库 README 里的表述一致，所以论文本身不是随手拼出来的产物。

> "The proof reduces monochromatic rectangle density via Gaussian hyperplane rounding and box-constrained biasing to refuting the existence of biased Kullback–Leibler-stable sign matrices S ∈ −1, 1^(X×Y) of rank at most r + 1 above R_0 := ⌈e^(4×10^6)⌉ (Theorem 3.1)." — fwlr [c:50642430]
> （译文：证明通过高斯超平面取整与箱约束偏置来约化单色矩形密度，从而反驳存在秩至多 r + 1 的偏置 Kullback–Leibler 稳定符号矩阵 S ∈ −1, 1^(X×Y)、且 R_0 := ⌈e^(4×10^6)⌉ 的情形（定理 3.1）。）

> "Ah yes, of course, I have often wondered about that." — fwlr [c:50642430]
> （译文：啊，那当然了，我以前就常琢磨过这个问题。）

讽刺归讽刺，把定理原文贴出来，本身就是一种验证：这批论文至少是可以对着读的东西。

### 二、RSA 破了吗：三个数字决定一切

严谨派的计算全部落在指数上。最先给出直观量级的是一位读者。

> "The factorization is O(exp(105 × (ln n)^(1&#x2F;3) × (ln ln n)^(2&#x2F;3))); plug in n=10 (i.e. factoring 10 to 2×5), you get a number larger than the number of atoms on earth. So still a bit to go." — dzaima [c:50642757]
> （译文：这个分解是 O(exp(105 × (ln n)^(1/3) × (ln ln n)^(2/3)))；把它代进 n = 10（也就是把 10 分解成 2×5），得到的数比地球上的原子总数还大。所以还差一点。）

另一位读者把新旧两种算法放到同一把密钥上对比。

> "GNFS would take 10^47 operations while this takes 10^2572 for a 4096 bit rsa key. The only improvement here is that this is guaranteed to work for arbitrary numbers." — vlovich123 [c:50642765]
> （译文：对 4096 位 RSA 密钥，GNFS 需要 10^47 次运算，而这个需要 10^2572 次。这次唯一的改进是，它对任意数字都保证能用。）

第二篇论文的数字也被算了出来。

> "oh, there is a second paper with O(exp(3 × (ln N)^(3&#x2F;4)); for a 4096-bit input (i.e. RSA-4096), that&#x27;s still 10^506, as opposed to 10^2572 for the first one. Still infeasible though." — dzaima [c:50644362]
> （译文：哦，还有第二篇论文，是 O(exp(3 × (ln N)^(3/4))；对 4096 位输入（也就是 RSA-4096），那仍然是 10^506，而第一篇是 10^2572。依然不可行。）

还有一位读者顺手纠正了参数含义上的一个常见误会。

> "n is generally the size of the input, i.e. the number of digits input, not the number to factor." — martincmartin [c:50643792]
> （译文：n 一般是输入的规模，也就是输入的位数，不是那个要被分解的数本身。）

结论其实相当一致：新算法指数更差，但换来了无条件。

> "The integer factorisation method has a much worse exponent than the general number field sieve, our best known classical algorithm." — Starlevel004 [c:50642702]
> （译文：这个整数分解方法的指数比通用数域筛——我们已知最好的经典算法——要差得多。）

一位以加密货币为业的评论者把恐慌的来源点破了。

> "No. These results do not invalidate public-key cryptography." — alchemist1e9 [c:50642966]
> （译文：不。这些结果没有让公钥密码学失效。）

> "The recent AI math results don’t break Bitcoin’s cryptography, they either go in the hardness direction or improve classical algorithms that Bitcoin doesn’t rely on, with constants that still leave them impractical. There is a lot of FUD floating around trying to push crypto prices lower." — alchemist1e9 [c:50642966]
> （译文：最近这批 AI 数学结果并没有搞坏 Bitcoin 的密码学，它们要么是往更难的方向走，要么是改进了 Bitcoin 根本不依赖的经典算法，而常数仍然让它们不实用。周围飘着大量想压低币价的 FUD。）

### 三、Factoring in P 不是 P = NP

传闻帖的评论区里，第一个被纠正的概念就是这个。理论上最干净的一次澄清来自一位把复杂性类讲清楚了的人。

> "Integer factoring is in NP and coNP so, unless P=NP, factoring is not NP-Complete [0]." — abetusk [c:50644452] [thread 2]
> （译文：整数分解属于 NP 也属于 coNP，所以除非 P=NP，分解就不是 NP 完全的。）

> "If P=NP, then integer factoring is in P trivially, because the polynomial hierarchy collapses, but the other way doesn&#x27;t hold. To be clear, I think there&#x27;s essentially no chance P=NP." — abetusk [c:50644452] [thread 2]
> （译文：如果 P=NP，整数分解当然就在 P 里，因为多项式层级会坍缩，但反过来不成立。说清楚点，我觉得 P=NP 基本没戏。）

一句更短的版本来自另一位评论者。

> "This isn&#x27;t that. It&#x27;s about factoring large numbers, not P=NP." — titzer [c:50644310] [thread 2]
> （译文：那不是这回事。这说的是分解大数，不是 P=NP。）

而后量子密码的边界，也被顺带厘清了。

> "&quot;Post quantum&quot; really just means &quot;doesn&#x27;t rely on integer factorization&quot;." — cogman10 [c:50642575]
> （译文：「后量子」其实只是指「不依赖整数分解」。）

> "Post-quantum schemes don&#x27;t survive N = NP either." — sodacanner [c:50644010] [thread 2]
> （译文：后量子方案也扛不住 N = NP。）

椭圆曲线会不会被一并带走的判断，则分成了两派。一派认为分解和离散对数本质上是同一个问题。

> "Very likely elliptical curves as well. Factoring and logarithms are effectively same problem and you can also see it in i.e. Pollards Rho being developed for factoring and then bent for logarithms." — Geof25 [c:50643890] [thread 2]
> （译文：椭圆曲线很可能也一样。分解和离散对数基本上是同一个问题，这也能从 Pollard rho 先被发展出来做分解、然后被掰过来做离散对数看得出来。）

另一派指出这两件事用的是不同机制。

> "Elliptic curve cryptography already uses a different mechanism that isn’t susceptible to factorization improvements." — vlovich123 [c:50642765]
> （译文：椭圆曲线密码学用的是另一套机制，不受分解改进的影响。）

### 四、传闻本身：一张截图、三个链接、一轮又一轮

reddit 那条帖子的内容几乎全部来自一张截图。截图里的出处最后被追溯到 Scott Aaronson 的博客，以及两条 X 上的转推。

> "Scott Aaronson in a comment on his own blog: &quot;I’ve now heard many, many rumors that one or both labs are sitting on Factoring in P. I don’t know how much to credit this. While I’m virtually certain that the labs are, indeed, sitting on one or more bombshells for cryptography, it’s possible that the exact nature of those bombshells has gotten distorted via a game of Telephone.&quot;" — jerf [c:50643250] [thread 2]
> （译文：Scott Aaronson 在他自己博客的评论里说：「我已经听到过非常非常多传闻，说一到两家实验室手上有 Factoring in P。我不知道该给它多少信任。虽然我几乎可以肯定这些实验室手上确实有一到多个对密码学而言的重磅炸弹，但这些炸弹的确切性质有可能在传话游戏里被扭曲了。」）

> "Andrew Curran on X, quote tweet: &quot;Scott Aaronson on his blog [referring to the post above, includes screenshot]. I have also heard this. In fact, this rumor has persisted for about ten days, about both Anthropic and OpenAI.  Considering how closely their recent math results have mirrored each other, if one has it, they probably both do. This would crack RSA.&quot;" — jerf [c:50643250] [thread 2]
> （译文：Andrew Curran 在 X 上的转推说：「Scott Aaronson 在他博客上（指的是上面那篇帖子，附了截图）。我也听说了。事实上这个传闻已经持续了大约十天，说的是 Anthropic 和 OpenAI 两家。考虑到他们近期的数学结果如此镜像，如果一家有，那两家大概都有。这会破掉 RSA。」）

还有一条更让人不安的联想，来自梳理这些来源的评论者本人。

> "This tracks suspiciously with the governments suggesting a week or two back that we get ready for some downtime." — jerf [c:50643250] [thread 2]
> （译文：这和各国政府在一两周前暗示我们「准备好一段停摆期」这件事可疑地吻合。）

被问到这条传闻的成色时，评论者的反应出奇一致：它是一个关于传闻的传闻。

> "Literally just a screenshot of an HN comment I myself saw a few hours ago." — titzer [c:50644333] [thread 2]
> （译文：就是几小时前我自己看到的一条 HN 评论的截图。）

> "Rumors about rumors." — titzer [c:50644333] [thread 2]
> （译文：传闻中的传闻。）

另有评论者把那张截图的性质描述得更清楚。

> "It&#x27;s a link to a Reddit thread with the subject above, showing a screen shot from some forum with a comment supposedly from Scott Aaronson saying that big labs are &quot;sitting on&quot; some result they discovered relating to factoring complexity." — dboreham [c:50643280] [thread 2]
> （译文：它就是一个 reddit 帖子的链接，标题如上，里面是某个论坛的截图，评论据说是 Scott Aaronson 说的，说那些大实验室手上有某个跟分解复杂度有关的结果。）

传闻为什么在那个时点出现，也有人给出了完全不需要阴谋论的解释。

> "This reddit rumor was posted <i>exactly</i> when ANT was in freefall at $75. It then recovered to $80." — xsrqe [c:50644283] [thread 2]
> （译文：这个 reddit 传闻发帖的时间点，正好是某个加密货币从 75 美元自由落体的时候，然后它又涨回了 80 美元。）

> "Rumors are swirling that this might be market manipulation." — xsrqe [c:50644283] [thread 2]
> （译文：传闻四起，可能这就是市场操纵。）

而更早的、可以被验证的版本，其实一直存在：有人几个月前就在分解真实的 RSA 密钥，用的还是老方法。

> "Anthropic factored RSA-896 a couple of months ago" — Cakez0r [c:50643289] [thread 2]
> （译文：Anthropic 几个月前分解了 RSA-896。）

> "They used existing methods and stressed that they didn&#x27;t find a more efficient approach to factoring (maybe true, maybe not...). It does show however that they are at least looking at the problem and willing to throw substantial computing power at it. Perhaps they have had a breakthrough." — Cakez0r [c:50643289] [thread 2]
> （译文：他们用的是已有方法，并且强调自己并没有找到更高效的分解办法（可能是真的，也可能不是）。但这至少说明他们在看这个问题，也愿意砸大量算力进去。也许他们真的有了突破。）

最后有人试图给这场讨论本身画个地图。

> "can we stuff this entire scene into the high school cafeteria it resembles and then launch it into fucking space? discussions about reddit posts about blog comments about rumors" — jordemort [c:50644357] [thread 2]
> （译文：我们能不能把这整场戏塞进它看起来的那个高中食堂里，然后发射进太空？关于 reddit 帖子、关于博客评论、关于传闻的讨论。）

### 五、末日剧本与市场反应

传闻之所以能长成恐慌，是因为它接上了一套现成的剧本。有人把剧本完整念了一遍。

> "If factoring is practical <i>and easy</i>... very important phrase, this rather alarmist paragraph is contingent on this being <i>easy</i>... this will be a literally all hands on deck situation. The entire global economy will be at stake and all governments will effectively be in a war situation." — jerf [c:50643777] [thread 2]
> （译文：如果分解变得实用，而且容易——这个短语很重要，这段吓人的论述完全取决于它「容易」——那就会是字面意义上的全总动员。整个全球经济都会押在桌上，所有政府都会进入战争状态。）

而熟悉密码学实务的人给出的判断要平淡得多。

> "I really don&#x27;t think any crisis would occur. Hundreds of millions of dollars that wouldn&#x27;t have otherwise been spent would go to a transition; and, it&#x27;d be a stimulus for some sectors of the technology industry. That&#x27;s about it." — tptacek [c:50644385] [thread 2]
> （译文：我真不认为会发生什么危机。那几亿本来不会花出去的钱会流向迁移，这也会成为科技行业某些板块的刺激。就这些。）

市场上已经有人在报价了。

> "Satoshi&#x27;s wallet will fall in the next year" — Kuyawa [c:50643765] [thread 2]
> （译文：Satoshi 的钱包一年内会崩。）

> "Bitcoin turning worthless would matter, perhaps in a different way." — hyperpape [c:50644082] [thread 2]
> （译文：比特币变得一文不值这件事会有影响，只是影响方式可能不太一样。）

至于「那要多久才能全部换掉」，答案比末日剧本实际得多。

> "More like 3 weeks if you are running Ubuntu…." — voakbasda [c:50644220] [thread 2]
> （译文：如果你跑的是 Ubuntu，那是三周左右。）

> "More seriously, this will not get rolled out universally in three days.  Embedded systems cannot be upgraded on a whim, if at all.  This stuff is everywhere and cannot be trivially patched to add post-quantum algorithms." — voakbasda [c:50644220] [thread 2]
> （译文：更认真地说，不可能在三天之内全球铺开。嵌入式系统不是想升级就能升级的，有些根本升不动。这东西无处不在，不可能靠打个补丁就加上后量子算法。）

### 六、Lean 里到底有没有幻觉

论文的另一面是形式化。而形式化恰恰是这场争论里最热闹的地方。一派认为几百万行 Lean 代码里不可能没有一处幻觉。

> "It is highly unlikely in the millions of lines of Lean code that there is not a single hallucination." — BatchJob [c:50643056]
> （译文：在那几百万行 Lean 代码里，不存在一处幻觉的可能性非常低。）

> "Human reductions of the proof will ignore the hallucinations and attempt to cover for the LLM and likely will not be provable." — BatchJob [c:50643056]
> （译文：人类对证明做的归约会忽略这些幻觉，试图替 LLM 遮掩，结果很可能根本不可证。）

> "We think it proves <i>something</i> in Lean.  But its doubtful it proves what it was asked to prove." — BatchJob [c:50643056]
> （译文：我们以为它在 Lean 里证明了<i>某个东西</i>。但它证明的是不是被要求的那个东西，很可疑。）

反驳者的第一句话就把问题的前提拆了。

> "Your argument misunderstands how Lean works. We know that the theorem statement is correct because we wrote it. Lean only accepts correct proofs of that theorem statement. So we are certain that it proves what it was asked to prove. If there was a hallucination in the code that broke the proof, Lean would find it." — gregdeon [c:50643114]
> （译文：你的论证误解了 Lean 是怎么工作的。我们知道定理陈述是对的，因为那是我们自己写的。Lean 只接受该定理陈述的正确证明。所以我们确定它证明了被要求它证明的东西。如果代码里的幻觉破坏了证明，Lean 会把它找出来。）

被追问「那会不会是 Lean 本身的 bug」时，答案不是回避，而是把检查器生态搬出来。

> "Right, if there is a cheat in the proof it would have to rely on a bug in Lean." — erikpukinskis [c:50643303]
> （译文：对，如果证明里存在作弊，那它只能依赖 Lean 的一个 bug。）

> "Which, is not implausible, is it? That’s what manual verification will seek to uncover." — erikpukinskis [c:50643303]
> （译文：这并非不可能，不是吗？这正是人工验证要去挖出来的。）

> "It&#x27;s not implausible a priori. But the Lean community has doubled down on this lately, independently reimplementing Lean (so that it&#x27;s unlikely both kernels have the same bug) and developing proofs that their kernels are bug-free." — gregdeon [c:50643385]
> （译文：先验上并非不可能。但 Lean 社区最近在这上面下了双保险：独立重新实现 Lean（这样两个内核不太可能同时有同一个 bug），并且在开发他们的内核无 bug 的形式化证明。）

当然，也有人认为形式化只保证「它证明了它被要求证明的东西」，不保证那东西是好看的。

> "They could still go for more elegant and understandable proofs than the behemoths that these LLMs are churning out." — _1 [c:50642622]
> （译文：他们仍然可以给出比这些 LLM 现在批量生产的巨型证明更优雅、更易读的证明。）

而最尖的一刀来自一位要求看资历的评论者。

> "Interesting theory. Can you provide the credentials that make you more of a subject matter expert than Alpöge and the team that verified his work, who seem to believe that this is actually a proof of the RH?" — topicalSoup [c:50643099]
> （译文：有意思的理论。那能不能提供你的资历，证明你比 Alpöge 和那个验证了他的工作的团队更懂这个领域？他们似乎认为这就是黎曼猜想的一个证明。）

### 七、博士生、天花板，和那条下滑的申请曲线

讨论后半程的争吵跟数学无关，跟人有关。最先提出这个问题的是一位正在带学生的人。

> "Students doing their Ph.Ds in Math and Computer Scientists on more theory-related thesis are having a tough time. You never know if your thesis is going to be the next OpenAI&#x2F;Anthropic and now Google trophy paper." — edumucelli [c:50642537]
> （译文：那些在读数学博士、或者做偏理论方向论文的学生，日子不好过了。你永远不知道自己的论文会不会成为下一个 OpenAI／Anthropic，现在又加上 Google 的奖杯论文。）

然后是一个被反复引用的数字。

> "Number of undergrad applicants to CS programs in the US have dropped by nearly 50% over the last two years." — krastanov [c:50643330]
> （译文：美国 CS 专业的本科申请人数在过去两年里下降了将近 50%。）

但反对把「有趣」和「就业」混为一谈的提醒同样被反复提起。

> "Being exciting and being a career that is a credible field of employment are two very different things. People are discouraged about the latter, for extremely rational, metric-based reasons." — llm_nerd [c:50642869]
> （译文：有趣，和它是一条有信誉的就业路径，是两件非常不同的事。人们对后者的气馁，是出于极其理性的、基于指标的理由。）

> "A lot of computer science is going to continue to happen, but I suspect by an increasingly smaller and smaller number of people." — llm_nerd [c:50642869]
> （译文：计算机科学还会继续发生很多事，但我怀疑做这件事的人会越来越少。）

一个来自 arXiv 调查的数据被用来给这场情绪背书。

> "has shown that the recent flurry of AI-results is exceptionally discouraging. Of the 260 or so participants, 76.5% of them said for instance that AI has demotivated them to work on research." — bemtevi [c:50642929]
> （译文：……显示最近这波 AI 成果极其令人沮丧。在大约 260 名参与者中，有 76.5% 的人表示，比如，AI 让他们失去了做研究的动力。）

而真正卡住新人的不是动力，是钱。

> "One issue is funding. Theoretically, grants support work towards results. If using LLMs gets better results, it’s going to be very hard to even be in the top 25% when you’re not using AI. That means you won’t get funded." — fn-mote [c:50642997]
> （译文：有一个问题是经费。理论上，资助是支持产出成果的。如果用 LLM 能拿到更好的成果，那么当你不用 AI 的时候，要进入前 25% 都会非常难。这意味着你拿不到经费。）

反驳的一方则认为，博士本来就不该把自己绑在一个大问题上。

> "Can a PhD in math or theoretical CS not be about using models and agents to more efficiently explore ideas? That seems like an extremely valuable path that also benefits from domain specific reasoning and goals." — brandonpelfrey [c:50642972]
> （译文：这在我看来是个奇怪的反驳。数学或者理论 CS 的博士难道不能就是关于如何用模型和 agent 更高效地探索想法吗？这看起来是一条极有价值、又能受益于领域特定推理和目标的路。）

> "I don’t think a PhD needs to be about one grand problem. How to utilize these tools is immensely important and not at risk of being scooped." — brandonpelfrey [c:50642972]
> （译文：我不认为博士论文得是关于某个大问题的。如何使用这些工具极其重要，而且不会被别人抢发。）

但有人指出这条反驳在资源上根本不成立。

> "The previous comment wasn&#x27;t about simply &quot;using AI&quot;, but about the enormous imbalance in research power that these AI labs have." — wasabi991011 [c:50643824]
> （译文：上一条评论说的不是简单地「用 AI」，而是这些 AI 实验室之间巨大的研究力量不平衡。）

> "And in that context, no, Math and TCS PhDs can&#x27;t &quot;just use AI models too&quot;. They don&#x27;t have access to the same models that these companies do, nor the same amount of tokens available to throw at the problem (by orders of magnitude)." — wasabi991011 [c:50643824]
> （译文：在那种语境下，不行，数学和理论 CS 的博士没法「也用上 AI 模型」。他们拿不到这些公司用的模型，也拿不到同样多的 token 去砸这个问题（差着好几个数量级）。）

把这件事讲得最形象的是一位讨论「居家烘焙与工业烘焙」的评论者。

> "The bigger problem is that everyone can cook at home but few get the privilege of running a factory." — uw_rob [c:50643118]
> （译文：更大的问题是，每个人都能在家做饭，但很少有人有资格开工厂。）

> "I don’t think you can play along at home though - public SOTA models are far too expensive to run in swarms for “what ifs” and the private SOTA models are one step ahead." — uw_rob [c:50643118]
> （译文：但我觉得在家玩不转。公开的 SOTA 模型太贵了，跑不起成群的「如果……会怎样」，而私有的 SOTA 模型又领先一步。）

而最冷的那条判断是：计算机科学会变成一个有趣但经济上无用处的领域。

> "Software engineering and computer science will become exactly that: a field for people who find it interesting but are completely useless economically." — xdennis [c:50643127]
> （译文：软件工程和计算机科学会变成完全一样的样子：一个对找到它的人来说有趣、但在经济上完全没用的领域。）

对此最有力的回应来自另一条线：不带偏见的人从来没停止在家烘焙。

> "People didn&#x27;t stop baking at home because of industrial baking." — robrenaud [c:50643348]
> （译文：人们并没有因为工业烘焙的存在就不在家做面包。）

> "People didn&#x27;t stop playing chess because they were worse than computers at chess." — robrenaud [c:50643348]
> （译文：人们也没有因为电脑下棋比自己强就不下棋了。）

### 八、数学是不是现实的最好模型

最后一场争论回到了这次突破本身的意义。一派把数学视为现实的最好模型。

> "Given that math is, for better or worse, the best tool we have to accurately represent and build models of our reality, what will this mean for our understanding of ultimate reality?" — abixb [c:50642416]
> （译文：不管怎么说，数学是我们用来准确表示和构建现实模型的最佳工具，这会让我们对终极现实的理解意味着什么？）

另一派当场反驳：真正贴近现实的是物理，数学反而是不受约束的那一半。

> "Math is unrestrained and unconstrained. Set various axioms and you can build complex worlds very different from our current universe." — sidkshatriya [c:50642501]
> （译文：数学是不受约束、没有枷锁的。设定不同的公理，你可以构造出与我们当前宇宙非常不同的复杂世界。）

> "So I would say the best tool is Physics to represent and build models of our reality. Physics is like a subset of Math which is actually the ground truth in our universe." — sidkshatriya [c:50642501]
> （译文：所以我会说，代表和构建我们现实的最好工具是物理。物理像是数学的一个子集，它才是我们宇宙里真正的 ground truth。）

还有一位评论者认为这一切根本不意外，因为同样的剧本在围棋上已经演过一遍。

> "I don&#x27;t think the recent spate of math discoveries should be very surprising." — martythemaniak [c:50642700]
> （译文：我不认为最近这波数学发现应该让人感到意外。）

> "So it really shouldn&#x27;t be surprising that the space-searchers found something people either missed or was too big&#x2F;far away to be accessible (that is, it is unknown whether the current RH proof can be simplified and&#x2F;or understood like classical human proofs)" — martythemaniak [c:50642700]
> （译文：所以，那些在搜索空间里找到东西的「空间搜索者」发现了人们要么漏掉了、要么大到／远到无法触及的东西，这真的不该让人意外（也就是说，目前还不知道现存的 RH 证明能不能被化简、能不能像人类经典证明那样被理解）。）

而更激进的看法是：连「现存形式体系」本身都未必是唯一选项。

> "I may be wrong here, but I don&#x27;t think there&#x27;s a mathematical theorem saying that our current formalisms are the only ones admissible." — dsign [c:50643456]
> （译文：我可能错了，但我不认为存在某个数学定理，规定我们现在的形式体系是唯一可接受的形式。）

于是话题滑向了两家实验室会不会先藏一手。

> "I imagine they would not disclose their results if it could hurt modern cryptography infrastructure." — ducktective [c:50642711]
> （译文：我猜如果披露结果会伤害现代密码基础设施，他们是不会披露的。）

以及那条从模型竞争角度出发的判断。

> "is it really? Chinese models are at most (if even) half a year away from this point." — selfmodruntime [c:50643407]
> （译文：真的吗？中国的模型离这一步最多（如果真能到的话也就）还有半年。）

最后一个问题把整场讨论拉回最虚也最实在的一层。

> "Is there any assumption that now these things are able to bring concepts together (not gracefully) from vastly different fields, that they will hit a wall - that if they are unable to get to relativity from 1901 data - then they cannot get to unified gravity etc because we have not got there ?" — lifeisstillgood [c:50642665]
> （译文：那么有没有这样的假设：既然这些东西现在能把来自完全不同领域的概念拼到一起（虽然拼得很不优雅），它们会不会撞墙——比如，如果它们拿着 1901 年的数据也走不到相对论，那它们是不是也走不到统一引力场，因为我们还没走到那里？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 这是真的论文，不是 AI 幻觉 | fwlr / topicalSoup | 定理原文与 README 一致，但读不读得懂是另一回事 |
| 新算法指数更差 | Starlevel004 / dzaima / vlovich123 | 无条件换来更差的指数，4096 位密钥还要 10^2572 次运算 |
| 公钥密码学没被破坏 | alchemist1e9 / vlovich123 | Bitcoin 不依赖这条路，椭圆曲线用另一套机制 |
| Factoring in P ≠ P = NP | abetusk / titzer / sodacanner | 分解在 NP ∩ coNP 里，撞不塌多项式层级 |
| 传闻本身是传闻中的传闻 | titzer / dboreham / jordemort | 一张截图、三个链接，谁都在传 |
| 传闻可能只是市场操纵 | xsrqe | 发帖时间点正好撞上币价自由落体 |
| 早就有过公开的尝试 | Cakez0r | 几个月前分解 RSA-896，用的还是老方法 |
| 不会发生密码学末日 | tptacek / voakbasda | 迁移会花掉几亿，但嵌入式系统拖得住 |
| 形式化挡住了幻觉 | gregdeon / erikpukinskis | 幻觉不成立，但可能靠 Lean 的 bug 作弊 |
| 形式化只保证「证明了被要求的」 | _1 / topicalSoup | 优雅和可读没人保证，资历也不能免检 |
| 博士可以转做「怎么用 AI」 | brandonpelfrey | 工具怎么用，没人抢发，风险在别处 |
| 博士用不起同样的模型 | wasabi991011 / uw_rob | 差着好几个数量级，家里的模型跑不成群的 what-if |
| CS 会变得有趣但没用 | xdennis / llm_nerd | 就业是指标问题，不是兴趣问题 |
| 居家烘焙不会输给工业烘焙 | robrenaud / bemtevi | 兴趣和自我探索的价值不会因为规模化消失 |
| 数学不是现实的最好模型 | sidkshatriya / dsign / martythemaniak | 物理才是 ground truth，Lean 是验证器 |

## 总体情绪

这场讨论最微妙的地方，是两拨人其实在说两件事，而且都没说错。算指数的那一派给出的是 10^47、10^506、10^2572 这样的具体数字，结论清楚：拿 10^47 对 10^2572 来看，RSA-4096 还要多花两千多个数量级的时间，而新的无条件算法指数比通用数域筛还差。传传闻的那一派给的是另一套账：一条循环了十天的说法、一张 reddit 截图、两条 X 转推。没有人声称 RSA 已被破解，但几乎所有人都在替「万一」预留预算，包括已经算清楚「万一」代价的那些人。

真正被这批论文改写的，是讨论后半段那些关于「谁还有位置」的争吵。形式化保证了这些证明确实证明了被要求证明的东西——这一点反方的回答干净利落——但没人保证那份证明人类读得下去，也没人保证在它面前的研究生还有位置。一条下降近 50% 的申请曲线、一份 260 人里 76.5% 表示被劝退的调查、一个「经费只发给用 AI 的人」的现实，共同构成了另一场危机：不是证明错了，而是做证明的人开始消失。

这一天唯一没有争议的数字是 10^2572。证明可以是真的，恐慌也可以是假的，而密码学真正要等的，是那个至今没人能算出来的 10^47。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Google Releases Cogentic Papers on Integer Factorization, Discrete Logs and More（HN 主帖） | <https://news.ycombinator.com/item?id=50642086> |
| 2 | cogentic_research_papers（google-research 论文目录） | <https://github.com/google-research/google-research/tree/master/cogentic_research_papers> |
| 3 | Unconditional Integer Factorization in Time L_N[1/3, O(1)]（论文 PDF） | <https://github.com/google-research/google-research/blob/master/cogentic_research_papers/integer_factorization/paper.pdf> |
| 4 | Cogentic: Multi-Agent Orchestration for Automated Proof Discovery（arXiv:2609.40324） | <https://arxiv.org/abs/2609.40324> |
| 5 | Rumors swirling that labs might have cracked Factoring in P（HN 关联帖） | <https://news.ycombinator.com/item?id=50643065> |
| 6 | reddit r/singularity 传闻原帖 | <https://www.reddit.com/r/singularity/comments/1y59ef1/rumor_that_openai_or_anthropic_found_a_way_to/> |
| 7 | Scott Aaronson 博客（传闻源头之一） | <https://scottaaronson.blog/?p=10362#comment-2044495> |
| 8 | Lean 社区：Riemann Hypothesis（形式化核验说明） | <https://leanprover-community.github.io/blog/posts/riemann-hypothesis/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 241 分、203 条评论，归档快照 2026-11-25 16:54 UTC，入库 100 条；关联帖 145 分、78 条评论，入库 78 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，截取的段落均为归档评论中的连续片段，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

论文信息（`cogentic_research_papers` 的目录结构与十篇论文的标题、投放日期、L_N[α, c] 的定义、各算法的复杂度、AKS 素性验证、Lean 4 v4.33.0 与 v4.35.0 的形式化声明，以及「全部由 Cogentic 使用 Gemini 4 生成、除初始提示词外无人类参与」的说明）与 google-research 仓库内各论文目录的 README 一致；Cogentic 框架的机制、底模与作者名单与 arXiv:2609.40324 的摘要一致。

评论者给出的第三方数据与主张（包括「美国 CS 本科申请两年下降近 50%」「一份 arXiv 调查的约 260 名参与者中 76.5% 表示被劝退」「Anthropic 几个月前分解了 RSA-896」「各国政府暗示要准备好一段停摆期」「传闻发布时点与某个加密货币价格波动同步」等）由评论者自行给出，本文未核实。文中所有判断与立场均属于原文评论者，归纳与判断由本文完成。

⚠ 本篇引文涉及中美模型能力对比与政府信息披露的话题。相关表述为 HN 评论者个人观点，未经核实，不代表本站立场。建议复核后发布（Review recommended）。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
