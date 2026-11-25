---
layout: post
title: >-
  矩阵乘法的指数被钉死在 2.25 — HN 讨论摘要
date: 2026-11-25
hn_id: 50637220
categories: [articles]
excerpt: >-
  OpenAI 证明矩阵乘法指数 ω = 9/4 是精确值，把「能不能做到 O(n²)」这个悬了半个世纪
  的问题彻底关掉。248 分、96 条评论里最激烈的一仗不是数学，而是：这算 AI 的科学突破，
  还是一份不可维护的 slop？
tagline: >-
  上界十月就有了。这篇 111 页的论文，钉死的却是下界。
---

> 来源：HN 讨论主帖 [Matrix Multiplication is Θ(n^2.25)](https://news.ycombinator.com/item?id=50637220)（248 分，96 条评论），指向 OpenAI 论文 [The matrix multiplication exponent is nine fourths](https://github.com/openai/math/blob/main/preprints/The-matrix-multiplication-exponent-is-nine-fourths-November-24-2026/paper.pdf)（2026-11-24 发布，111 页）。本篇为 single post 模式：同日其他高分帖分属不同议题，不并入本篇。主帖 2026-11-25 01:19 UTC 提交，归档快照 2026-11-25 03:58 UTC（248 分 / 96 条评论），入库 96 条评论，归档分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文按归档评论原文截取，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。

## 原文概要

2026 年 11 月 24 日，OpenAI 在 `github.com/openai/math` 放出当天第二批论文，一共 9 篇手稿、两个结果族，附带部分结果的 Lean 形式化。矩阵乘法这一篇叫《The matrix multiplication exponent is nine fourths》，正文 111 页，分成四个部分、27 个编号章节、60 条参考文献。

核心结论只有一句：矩阵乘法的指数精确等于 9/4。论文的定理 1.1 写的是——在任意域 F 上，ω_F = 9/4。这里的 ω 是那个被写进教科书的符号：它是使两个 n×n 矩阵相乘能在 O(n^s) 次标量运算内完成的下确界。Strassen 在 1971 年用七乘九恒等式把它从 3 压到 log₂7 ≈ 2.807，此后半个世纪里整个领域的默认猜想是 ω = 2，也就是「二次乘法是可能的」。

这次的新东西是下界，而且是一个**精确**下界。论文说，对于每个 n ≥ 2，一个计算两个 n×n 矩阵乘积的形式算术电路，至少需要 ⌈n^{9/4}/2⌉ 个乘法或除法门，哪怕把所有线性运算都算作免费。作为推论 1.2，矩阵乘法张量 T_n 的几何边界秩至少是 n^{9/4}，精确的双线性算法在边长 n 时至少要用 ⌈n^{9/4}⌉ 个乘积。上界其实早就有了——OpenAI 先在复数域上给出，Amanov、van den Berg 与 Zuiddam 把它推到任意域（顺着 Lü 对任意特征的处理）；论文同时给出矩形的版本（推论 1.3）：a×b 乘 b×c 的几何边界秩至少是 max{ab, bc, ca, (abc)^{3/4}}，而「仍能保持指数二」的矩形宽度比例 α_F 被夹在 1/2 与 2/3 之间。

证明手法本身就是新的东西。论文的思路不是去找一个具体的算法卡住别人，而是把矩阵乘法电路看作张量网络：如果存在指数小于 9/4 的算法，那么张量网络可以被压缩到极致的程度，而这种压缩会违反另一个问题的下界——「判断若干份独立列表中的元素是否两两不同」的体积下界。两个估计夹在一起构成矛盾：定理 2.1 给出张量幂的压缩（每复制一份，网络规模节省一个 h 的幂，每个外露比特收费 h^η），定理 2.2 给出列表去重问题的体积下界 vol_k(D^⊗t_w) > t · n_w^{w^σ}。在有限域上取 0 < η < σ，固定一个大于 2/γ 的步数 J，递归 J 次之后得到的网络体积为 O(t_J · n_w^{w^η})，与定理 2.2 冲突。最后由引理 2.4（形式电路的双线性化：用了 q 个非标量乘除门则 rank_F(T_s) ≤ 2q）把有限域上的结论推广到任意域。

这不是孤立的成果。同一天放出的另外两篇分别给出了强多项式时间线性规划算法（Smale 的第九问题）和简单多面体直径的超多项式下界（否证多项式 Hirsch 猜想）；前一天放出的是《VP and VNP are different》；上个月 26 日是《The Exponential Time Hypothesis is False》。所以 11 月 24 日这一天，OpenAI 一次推翻了或解决了数学开放问题清单上的 8 个条目。评论区里有人把这个成就换算成了另一个尺度：矩阵乘法的指数不再是那个悬而未决的问号，而是一个常数——2.25。

## 讨论焦点

### 一、上界十月就有，这篇论文给的是下界

帖子标题写的是「Θ(n^2.25)」，但提交者在标题里只写了 O，这个细节立刻被抓了出来。

> "Title is incorrect (it says O(n^2.25) at the time of writing), we already knew that, and that&#x27;s not what this result describes." — orlp [c:50637425]
> （译文：标题错了（写的时候是 O(n^2.25)），那个上界我们早就知道了，而且这不是这篇结果描述的东西。）

这条提醒把整场讨论的起点摆正了：2026 年 10 月 2 日 OpenAI 就已经放出过上界 9/4 的论文，这篇 11 月 24 日的新稿是下界，两边合起来才是精确值。

> "the paper is much bigger than this. The previous things were upper bounds with the assumption (hope) that the actual lower bound was 2 and that quadratic matmul was possible. This is the <i>exact lower bound</i> (and, sadly &gt; 2)." — jcelerier [c:50637506]
> （译文：这篇论文比这个大得多。之前的那些是上界，背后的假设（或者说希望）是真正的下界是 2、二次乘法是可能的。这次是精确的下界（而且很遗憾，大于 2）。）

不过「上界已经知道」这个说法本身也有人挑刺——评论者指出，能达到的是 O(n^{2.25+ε})，对任意 ε 成立，这和精确的 O(n^{2.25}) 并不是一回事。

> "This result proves a lower bound of Omega(n^2.25); the upper bound of 2.25 was already known." — brandonb [c:50637539]
> （译文：这项结果证明的是 Ω(n^{2.25}) 的下界；2.25 的上界早就知道了。）

> "This paper only shows the lower bound, i.e. that no algorithm can do better than n^2.25." — csheehan10 [c:50637723]
> （译文：这篇论文只给出下界，也就是说没有算法能做得比 n^2.25 更好。）

> "Does it?  The description says it achieves O(n^(2.25+epsilon)) for any epsilon.  I think this is not quite the same thing." — amluto [c:50637670]
> （译文：真能吗？描述里说的是对任意 ε 都达到 O(n^(2.25+epsilon))。我觉得这跟那个不完全是一回事。）

而在维护历史的人看来，这篇论文漏掉的东西比标题更让人火大：连维基百科都还没写上他们十月的那个上界。

> "Annoyingly the wikipedia page doesn&#x27;t even mention the previous improved upper bound from their October results." — krackers [c:50637434]
> （译文：烦人的是，维基百科上甚至都没提他们十月那个改进过的上界。）

### 二、ω = 2 出局：一个悬了半个世纪的问号被钉死

> "Damn, would have been really cool if it had been 2 :&#x2F;" — anlsh [c:50637401]
> （译文：靠，要是等于 2 就太酷了。）

> "I would not have predicted omega = 2.25." — pfdietz [c:50637741]
> （译文：我没想到 ω 会是 2.25。）

对圈内人来说，这个结果的重量不在指数本身，而在它把一个信念改写成了定理。之前最好的上界是 2.371055，靠「错位提取」一点点磨下来；下界一侧此前只有 Bläser 的 (5/2)n² − 3n、Landsberg 的 3n² − o(n²)、Landsberg 与 Michałek 的 2n² − ⌈log₂n⌉ − 1 这类边界秩估计——它们的共同点是都卡在 2n² 附近，而 n^{2.25} 是超多项式的差，量级完全不同。

老 commenters 的第一反应是追溯这条曲线。

> "That bound is determined empirically as I recall. Every few years someone shaves a hundredth off of the best algorithm known at the time." — hinkley [c:50637496]
> （译文：据我回忆，那个界是经验上摸出来的。每隔几年就有人把当时最好的算法再削掉百分之一。）

> "(Inspector Clouseau voice) Not any more." — pfdietz [c:50637756]
> （译文：（用克鲁索探长的腔调）现在不是了。）

被「削掉百分之一」折磨了十几年的研究者，说到了自己的情绪。

> "How long have I been writing \omega and keeping the mystery secreted away in this symbol?  I really feel for Virginia and all of the other crew that have been working on this steadily for the past 15 years.  I wonder how she feels." — p11p [c:50638049]
> （译文：我有多久在写 ω 这个符号、把那个谜藏在这个符号里？我真的很同情 Virginia，还有过去 15 年一直在做这件事的所有人。我不知道她现在是什么感受。）

这个结果在复杂度理论里的分量也被反复提起：能对边界秩给出这么强的构造性下界，几何复杂度理论（GCT）——通往 P/NP 的传统路径之一——以及 VP/VNP（Anthropic 前一天刚给出否定结果）都会受影响。

> "this is quite an interesting result, as some constructive mechanism for showing strong lower bounds on border rank has some severe implications for GCT ( one of the traditional paths to resolving P&#x2F;NP ), as well as VP&#x2F;VNP, which Anthropic has a negative result for recently." — horseloverthin [c:50637612]
> （译文：这个结果相当有意思，因为某种能给出边界秩强下界的构造性机制，对 GCT（通往解决 P/NP 的传统路径之一）以及 VP/VNP（Anthropic 最近给出了否定结果）都有严重的影响。）

至于「以后还剩什么可做」，答案分成了两派：一派认为数学会被模型吃干，另一派认为数学会变得密到人类插不上手。

> "Is math going to be saturated, leaving nothing for humans to solve?<br>Or is math going to become so ridiculously complex and dense than no human can contribute anything meaningful to it?" — WarmWash [c:50638263]
> （译文：数学会被彻底饱和、什么都不剩给人类解决吗？还是数学会变得荒谬地复杂稠密，稠密到人类再也贡献不出任何有意义的东西？）

### 三、指数钉死了，实际速度几乎没动

最扫兴的一组评论来自做实际计算的：理论指数从「不知道是不是 2」变成「就是 2.25」，对现有代码几乎没有影响，因为已知算法的常数太大，而且真实硬件用的还是深度学习友好的分块与张量核，不是这些论文里的构造。

> "Given the constants for the known algorithms this is of little practical difference. And even if we find a practical n^2.25 algorithm one day, you would still need pretty large matrices for it to make any difference (i. e. billion rows matrices are only ~200x slower with n^2.25 than with quadratic)." — tliltocatl [c:50637613]
> （译文：考虑到已知算法的常数，这在实际层面几乎没有差别。而且就算哪天真的找到一个实用的 n^2.25 算法，你也得用非常大的矩阵才能看出差别（也就是说，十亿行的矩阵用 n^2.25 也只比二次算法慢约 200 倍）。）

> "“Only 200x slower.” Ok, I guess. Sounds bad to me, though." — fn-mote [c:50638153]
> （译文：「只慢 200 倍。」行吧，我猜。听起来还是很不妙。）

> "Someone else said there&#x27;s only one solution known that reaches this level but that it&#x27;s impractical. So while the bound is known, we are still practically around n^0.1 above the theoretical limit." — hinkley [c:50638262]
> （译文：有人说目前只有一个解达到这个水平，而且不实用。所以虽然界已经知道了，我们在实践中仍然比理论极限高出大约 n^0.1。）

那条最实际的追问来自做 GPU 的人：既然上界的构造已经在手里了，能不能直接翻成可用的 kernel。

> "curious whether the techniques behind the upper bound can be turned into practical GPU kernels. I would assume the economic implications would be enormous" — protortyp [c:50637466]
> （译文：好奇上界背后那套技术能不能变成实用的 GPU kernel。我猜经济影响会是巨大的。）

回答是别想。

> "I highly doubt it, especially at the scale that GPU math is at." — kadoban [c:50637883]
> （译文：我非常怀疑，尤其是 GPU 计算所处的那个规模上。）

### 四、非构造性证明：它只告诉你「做不到什么」

第二个集中的疑问是：这篇论文给的是下界，而且是靠「张量网络压缩会撞上另一个问题的下界」这种间接方式给的。它没有、也不能直接产出一个算法。

> "Is this proof constructive? Can we construct optimal algorithms for multiplying different sizes of matrices?" — free_bip [c:50637469]
> （译文：这个证明是构造性的吗？能不能构造出不同规模矩阵相乘的最优算法？）

读摘要的人自己推出了答案：论文的核心是「如果指数更小，张量网络就能被压缩到足以违反一个下界」——一个列表去重问题的下界。

> "Based on the abstract, it looks like no:<br>&gt; The proof shows that a smaller exponent would compress tensor networks enough to violate a lower<br>bound for testing whether the entries in each of several independent lists are distinct." — qnleigh [c:50637538]
> （译文：根据摘要，看起来不是：
> > 证明表明，更小的指数会把张量网络压缩到足以违反一个下界——那个下界说的是，要判断若干份独立列表中的元素是否两两不同，至少需要这么多代价。）

于是有人追了一句听起来很天真的问题：列表去重难道不能只是个笨办法？

> "Could that just be an inefficient way to test list equality?" — cowlevel [c:50637715]
> （译文：那会不会只是测试两个列表相等的笨办法？）

拿到答案的人把矩阵与列表之间的桥接补上了——这正是这篇论文能成立的关键直觉：n 行向量线性无关的判定，本质上就是一次矩阵求逆，而 Strassen 那套乘法优化顺手也能生成求逆算法。

> "Consider that matrix determinants are zero when the rows are linearly dependent. In fact the most efficient way to test if n rows of length n are linearly independent is to invert the matrix using variants of the famous multiplication algorithms." — scythe [c:50638172]
> （译文：想想矩阵的行列式在行线性相关时为零。事实上，判定 n 个长度为 n 的向量是否线性无关的最高效方式，就是用那些著名乘法算法的变体去求逆矩阵。）

### 五、矩形矩阵：能推广，但「补零再分块」不够

摘要只提方阵，立刻有人问矩形。

> "The abstract says this is for square matrices - does it also extend to rectangular matrices?" — vlovich123 [c:50637395]
> （译文：摘要说这是针对方阵的——能推广到矩形矩阵吗？）

第一个回答听起来很轻松。

> "Embed them in square matrices with zeroes, then subdivide. So yes." — SideQuark [c:50637510]
> （译文：把它们用零填进方阵里，再分块。所以可以。）

但同一个人后来自己把这个论证否掉了，因为「精确等式」不是「渐进上界」，补零填出来的指数对某些形状根本不精确。

> "It’s not immediately obvious to me that argument is sound since we’re talking about the exact bound. I believe the lower bound for certain rectangular sizes is less than 2.25 while 2.25 remains an upper bound for rectangular matrices." — vlovich123 [c:50637810]
> （译文：既然这里谈的是精确等式，那个论证是否成立对我来说并不显然。我认为某些矩形尺寸的下界是小于 2.25 的，而 2.25 对矩形矩阵来说仍然只是上界。）

反对派给出的是一个更简单的反例。

> "I think it’s actually obvious that this argument isn’t sound, think about multiplying a 1x5 matrix by a 5x1 matrix—this can clearly be done in linear time." — pastel8739 [c:50638040]
> （译文：我觉得这个论证显然不成立——想想把一个 1×5 矩阵乘以一个 5×1 矩阵，这显然可以在线性时间内做完。）

然后被补了一刀：你的问题里根本没有 n 这个参数。

> "Pedantry: In order for O(n) or Theta(n) to be relevant, your problem statement needs to have an “n” in it.<br>So: Multiplying a (1,n) matrix by an (n,1) matrix is linear in n." — fn-mote [c:50638130]
> （译文：吹毛求疵一下：要让 O(n) 或 Θ(n) 有意义，你的题目里得先有个 n。所以，把一个 (1,n) 矩阵乘以一个 (n,1) 矩阵，对 n 来说是线性的。）

而真正正确的说法是：补零再分块虽然行得通，但当两个维度差别很大时浪费得离谱，应该有更好的办法。

> "Obviously you can do that, but given how wasteful it is when the dimensions are very different, it seems like it should be possible to do better." — im3w1l [c:50637829]
> （译文：显然你可以这么做，但当两个维度差得很远时，这种做法浪费得太厉害，看起来应该能做得更好。）

> "This is not always optimal if m is o(n)" — scythe [c:50638129]
> （译文：如果 m 是 o(n)，这并不总是最优的。）

论文自己的推论 1.3 也承认了这一点：矩形的下界是 max{ab, bc, ca, (abc)^{3/4}}，而不是统一的 9/4。

### 六、AI 写的证明，算不算 slop

这场讨论后半程最激烈的一仗跟数学无关，跟「AI 产出的东西算不算垃圾」有关。

先把背景摆出来：这类论文不是人写的。

> "The fact that with their model they developed a new tensor geometry framework &#x2F; machinery underlying all these new proofs today is crazy. This one hits much closer to home for me than Riemann" — gyrovagueGeist [c:50637581]
> （译文：他们用模型搞出一整套新的张量几何框架／机制来支撑今天这些新证明，这事本身就疯了。这一篇比黎曼猜想更让我感到切肤之痛。）

于是有人把 AI 代码的标准搬了过来。

> "Like when you ask a coding agent to write something and, as part of the solution, it cooks up an entirely new JSON deserialization library or Paxos implementation from scratch as part of the task instead of using (and perhaps improving) a battle-tested library.<br>Yes, technically the agent succeeded at the assigned programming task.  Just like technically this agent succeeded at proving this theorem.  But unfortunately the work-product is unmaintainable slop.<br>Nobody hesitates to say &quot;yes it&#x27;s correct but it&#x27;s slop&quot; about AI code.  It&#x27;s time to apply the same rule to AI proofs." — octoberfranklin [c:50637797]
> （译文：就像你让一个写代码的 agent 干点活，它在解题过程中顺手从零造了一整套 JSON 反序列化库或者一套 Paxos 实现，而没有去用（甚至改进）那个久经考验的库。<br>是的，从技术上讲，这个 agent 完成了被指派的编程任务。就像从技术上讲，这个 agent 成功证明了这条定理。但不幸的是，产出的东西是维护不了的 slop。<br>没人会犹豫着说「对，它是正确的，但它就是 slop」来评价 AI 代码。是时候把同一条标准用到 AI 证明上了。）

这句「这看法太惊人了」在下面被单独拎出来。

> "This is an astounding take." — piloto_ciego [c:50637989]
> （译文：这看法真是惊人。）

反对方的回应是：证明乱一点有什么关系，正确就行，以后总能重排。

> "Does it truly matter if the proof is messy&#x2F;inefficient if it’s correct? It can be walked back and reordered from here." — steve_adams_86 [c:50638142]
> （译文：如果证明是乱的、效率低，但它是正确的，这真的重要吗？以后可以从这里重新走一遍、重新排序。）

然后是同一段对话里最难看的一次对撞：对方直接把「代码 slop」的标准原样还了回去。

> "Does it truly matter if the code is unreadable slop that cannot be maintained, audited, or secured?<br>I swear, the groupthink here is unreal." — octoberfranklin [c:50638254]
> （译文：那代码是无法维护、无法审计、无法审计和保障的、读不懂的 slop，这真的重要吗？我发誓，这里的群体思维真是离谱。）

第三条路则认为大突破总会自带工具链，反对者会眼看着世界从身边流走。

> "Hard disagree, most big breakthroughs come with their own tooling that can help advance adjacent endeavors. People are going to watch the world pass them by as they say “well technically this” and “well technically that”." — mym1990 [c:50638111]
> （译文：强烈不同意。大多数大突破都会带着自己的工具一起出来，这些工具能帮相邻的领域往前走。那些人会一边说「从技术上说这个」「从技术上说那个」，一边看着世界从自己身边流过去。）

还有一条更根本的诘问：人类数学的价值本来就不在最终答案上。

> "People were swearing up and down the point of human math was the journey and the sidequests and other results developed in the way, not the final result. Why did that opinion change suddenly?" — hardbass [c:50638023]
> （译文：人们以前一直信誓旦旦地说，人类数学的意义在于过程、在于支线、在于沿途发展出来的其他结果，而不在最终答案。这个看法怎么突然就变了？）

评论区还给这场争论配了一句总结。

> "What&#x27;s even crazier, though, is that solving matrix multiplication and strongly polynomial-time linear programming are both easier than writing competent and readable papers." — procedurecall [c:50638238]
> （译文：更疯狂的是，解掉矩阵乘法和强多项式线性规划这两件事，竟然都比写出一篇称职、可读的论文更容易。）

### 七、他们在藏算力吗：Opus 变笨与突破的生意逻辑

数学结果本身，被评论区当成了模型状态的读数。

> "One possibility is that OpenAI may be holding back their best models to make fundamental breakthroughs, then using those breakthroughs to build stronger models in a compounding loop. If they were playing this game, public model quality would stall as compute shifted to internal research, and occasional releases like this would provide a glimpse of  more beneath the surface." — mmaunder [c:50637720]
> （译文：一种可能是，OpenAI 在扣着最好的模型用来做基础性突破，然后用这些突破去造更强的模型，形成复利式的循环。如果他们在玩这个游戏，那么随着算力转移到内部研究，公开模型的质量就会停滞，而像这样偶尔放出来的成果，就成了水下更多东西的一个窗口。）

这条猜测在当天立刻有了「体感佐证」。

> "I&#x27;ve always discounted people saying this, and now I am the one saying it: I am 100% convinced Opus 5.5 is somehow nerfed over the last 5 days or so." — jcomp [c:50637835]
> （译文：我一向对说这种话的人不屑一顾，现在说这话的人是我了：我百分之百确信 Opus 5.5 在过去这五天左右被削弱了。）

有人搬出了数字：训练仍然占着 60% 到 70% 的算力。

> "They are still (!) using 60-70% of their compute for training. Mind-boggling at the already huge scale (multiple GW) they command today" — WanderPanda [c:50637914]
> （译文：他们现在（！）仍然把 60% 到 70% 的算力用在训练上。在他们今天已经掌握的（多个吉瓦）这种规模下，简直不可思议。）

也有人给出反向的体感信号。

> "Anecdotally I will counter-signal this. Opus has been cooking for me last few days" — demibabs [c:50638275]
> （译文：我个人体感要唱个反调。过去几天 Opus 对我来说一直在变强。）

然后是这套解释体系里最露骨的一句。

> "Fundamental breakthroughs aren&#x27;t profitable. The purpose of the fundamental breakthroughs is to induce demand for their models." — enjoyyourlife [c:50637784]
> （译文：基础性突破本身不赚钱。基础性突破的目的，是为他们的模型制造需求。）

反方则给出了一种更干净的商业解释：这些题既难到需要长思考，又容易用计算验证，恰好是理想的训练与评测素材。

> "It’s probably a good thing for them to train and eval their models on: these are very hard problems that require lots of thinking but are easy to verify computationally. That’s fairly unique." — pastel8739 [c:50638008]
> （译文：用这些题来训练和评测他们的模型大概是件好事：这些题非常难，需要大量思考，但计算上又容易验证。这相当独特。）

围绕「基础研究的钱从哪来」，还有一整条 Bell Labs 的类比：贝尔实验室当年之所以能做基础研究，是因为它寄生在 AT&T 的垄断特权和与政府达成的公共利益安排上，而 OpenAI 和 Anthropic 没有这个结构。

> "IMO there is space for a unicorn to emerge in the next few years to eat everyone&#x27;s lunch." — StableAlkyne [c:50637909]
> （译文：依我看，未来几年还有空间冒出一家独角兽，把大家的饭都吃掉。）

然后评论区内部就为「这家公司到底提供什么」吵了起来，而这场小架本身就是评论区的名场面。

> "What is this unicorn going to provide??" — fn-mote [c:50638072]
> （译文：这家独角兽到底提供什么？？）

> "I never said that. You inserted it into quote marks and then responded to your own statement." — StableAlkyne [c:50638112]
> （译文：我没说过那个话。你把它加了引号，然后自己回答了自己造出来的句子。）

### 八、数学突破，跟谁的钱包有关

情绪最分裂的一段，是关于这些成果跟普通人到底有什么关系。

最兴奋的一派，把每天醒来看到新阈值被跨过当成了日常。

> "God, I love this so much waking up every day and seeing a new previously insurmountable threshold being crossed. What a time to be alive. We live in interesting times. I don’t understand these people that are anti-AI and keep whining about their jobs. I’m probably gonna lose my job too, but this is way bigger than us." — dyauspitr [c:50637781]
> （译文：天哪，我太喜欢这种感觉了——每天醒来就看到一个原本不可逾越的阈值被跨过。这是何等伟大的时代，我们活在一个有趣的时代。我不理解那些反 AI、整天抱怨自己工作的人。我大概也会丢工作，但这比我们大得多。）

最刻薄的一句回复几乎在同一秒抵达。

> "We&#x27;ll all be living below the poverty line, but the Generalized Riemann hypothesis will keep us warm..." — dualvariable [c:50637823]
> （译文：我们都会生活在贫困线以下，但广义黎曼猜想会让我们暖和……）

认真一点的反驳则来自一个老问题：数学的价值无法用当代应用来衡量。

> "Yes, so one simple test is, if you think current pure math won&#x27;t improve the lives of most people. Pick some date, at least 200 years old, and some math field that had no applications then. Say number theory or group theory. Then eliminate every tech that ever resulted from it. Then live without those. If you found any difference in living standards, do report it." — hardbass [c:50638248]
> （译文：行，那来个简单的检验：如果你觉得当下的纯数学不会改善大多数人的生活，那就挑一个至少两百年前的日期，挑一个那时还没有任何应用的数学领域，比如数论或群论，然后把由此产生的所有技术都拿掉，然后不用这些东西生活。如果你发现生活水平有任何差别，麻烦告诉我。）

最现实的一条则来自对「这轮剧本已经演过一遍」的怀疑。

> "People also very recently spent a number of years being told they needed to adopt blockchain and nfts, that they needed to get on the metaverse before it was too late. And now the same crowd who were trying to sell them that are saying they need to use AI to not end up in the permanent underclass." — JDups [c:50638206]
> （译文：就在不久前，人们还花了好几年被告知必须拥抱区块链和 NFT，必须赶在元宇宙来不及之前上车。而现在，同一批当初在推销这些东西的人，又在说你们必须用 AI，否则就会掉进永久的无产阶层。）

> "Can you pay your rent or mortgage or groceries with OpenAI generated proofs?" — jimbokun [c:50638203]
> （译文：你能拿 OpenAI 生成的证明去付房租、房贷或者菜钱吗？）

也有评论者承认自己被打动了，但拒绝被说服。

> "Do you really not understand them? It still is not at all clear how this progress is going to improve the life of most people." — pastel8739 [c:50638026]
> （译文：你真的不理解他们吗？这些进展到底会怎样改善大多数人的生活，这一点仍然完全不清楚。）

而物理学家的视角给出了这次讨论里最平静的一句总结。

> "As a physicist, not a mathematician, this is not very impressive given recent events. It feels like the new normal.<br>And that is pretty exciting. Let the models slog through the hard work. Let the human dream and guide." — not_a_bot_4sho [c:50638196]
> （译文：作为物理学家而不是数学家，考虑到最近发生的事，这算不上多惊人。感觉这只是新的常态。不过这确实挺让人兴奋的。让模型去啃那些苦力活，让人来做梦和掌舵。）

### 九、中国开源模型：评论区里的第三条路线

有一条评论把这场数学突破拉回了模型竞争本身，并且给出了一个和西方实验室不同的路径判断。

> "I feel that there is a way to establish the near parity or even supremacy of the Chinese open source models over the western ones.<br>Other model providers, like OpenAI or Anthropic, could have thrown their best models at open math problems and score another millennium prize level problem." — nsoonhui [c:50638218]
> （译文：我感觉有办法证明中国的开源模型与西方模型接近平手，甚至占据优势。<br>其他模型提供方，比如 OpenAI 或 Anthropic，完全可以把他们最好的模型扔到开放数学问题上，再拿下一个千禧年奖级别的问题。）

这个判断呼应了同一天另一篇讨论（VP ≠ VNP）里的说法——用未发布的模型解题，再把成果公开发布，是最有效的模型能力证明，比刷榜有效得多。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题写错了，上界十月就有 | orlp / brandonb / csheehan10 | 这篇论文的价值在下界，上界是另一篇的活 |
| ω = 2 正式出局 | anlsh / pfdietz / hinkley | 悬了半个世纪的问号被钉成常数 2.25 |
| 理论定案，实际零影响 | tliltocatl / fn-mote / hinkley | 常数太大，真实规模还差着 n^0.1 |
| 构造 GPU kernel 不现实 | kadoban / protortyp | 论文里的构造离硬件太远 |
| 非构造性证明，给不出算法 | free_bip / qnleigh / cowlevel | 只钉住做不到什么，方法要靠列表去重反推 |
| 矩形推广要小心 | vlovich123 / pastel8739 / fn-mote | 补零再分块对「精确界」不成立 |
| AI 证明就是 slop | octoberfranklin | 「它是对的，但它不可维护」该同样适用于证明 |
| 证明乱一点没关系 | steve_adams_86 / mym1990 | 正确就够了，以后总能重排；大突破自带工具链 |
| 他们在扣着算力 | mmaunder / jcomp / WanderPanda | 公开模型变笨、内部模型在憋大招 |
| 基础突破是为了卖模型 | enjoyyourlife | 突破本身不赚钱，需求才是 |
| 这类题是理想的训练素材 | pastel8739 | 难到要长思考，又好验证 |
| 数学改善不了谁的生活 | JDups / hardbass / jimbokun | 区块链、NFT、元宇宙都是同一套剧本 |
| 让模型啃苦力，人来掌舵 | not_a_bot_4sho | 这是新常态，不是奇迹 |
| 中国开源模型能追平 | nsoonhui | 解一道开放题比刷榜更能证明能力 |

## 总体情绪

这场讨论最耐人寻味的地方，是几乎没有人去质疑定理本身。所有质疑都停在框架层面——标题写错了没有、上界是不是早就有了、这是不是构造性证明、矩形能不能推广、实际能快多少。没有一个人说这个证明是错的，因为没有人真读得懂那 111 页。于是讨论顺理成章地滑向了两件跟数学无关的事：AI 写出来的东西算不算 slop，以及这家公司是不是在扣着算力做不可告人的研究。前者是工程判断，后者是利益判断——两者都不需要读懂证明就能发表意见。

而少数把证明读懂了的评论者，口径高度一致：这不改变任何实际运算的速度；这不来自人类的洞察；这不过是把一个悬了半个世纪的问号换成了一个常数。连最兴奋的那几位也清楚，2.25 和此前的 2.371 之间的距离，在真实硬件上根本摸不到。真正剩下的只有两条：ω 不再是 2，也不再未知；而「模型替人类做数学」这件事，已经和「模型替人类写代码」一样，不需要再辩护。

最扎人的还是那句反问——你能不能拿 OpenAI 生成的证明去付房租。数学史上不缺这样的时刻：某个问题被解掉，然后所有人把它忘在脑后；也有一部分留了下来，靠的是下一个解它的人愿意提起。那 111 页里不会提到 GPU，也不会提到房租。但决定 2026 年还有多少人在乎 ω 这个符号的，恰恰就是这两样东西。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Matrix Multiplication is Θ(n^2.25)（HN 主帖） | <https://news.ycombinator.com/item?id=50637220> |
| 2 | The matrix multiplication exponent is nine fourths（论文 PDF，111 页） | <https://github.com/openai/math/blob/main/preprints/The-matrix-multiplication-exponent-is-nine-fourths-November-24-2026/paper.pdf> |
| 3 | Matrix Multiplication Nine-Fourths（2026-10-02 上界论文） | <https://github.com/openai/math/blob/main/preprints/Matrix-Multiplication-Nine-Fourths-October-2-2026/paper.pdf> |
| 4 | Exposition of OpenAI's Matrix Multiplication in Exponent 9/4 (and an explicit algorithm)（ECCC 2026/281） | <https://eccc.weizmann.ac.il/report/2026/281/> |
| 5 | Top 500 Open Problems in Math（评论者引用的榜单） | <https://proofatlas.ai/open-problems/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 248 分、96 条评论，归档快照 2026-11-25 03:58 UTC，入库 96 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，截取的段落均为归档评论中的连续片段，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

论文内容（定理 1.1 的 ω_F = 9/4、至少 ⌈n^{9/4}/2⌉ 个乘除门的下界、推论 1.2 的边界秩与推论 1.3 的矩形界、定理 2.1 与 2.2 的张量网络压缩与列表去重体积下界、引理 2.4 的双线性化、以及 2.371055、Bläser、Landsberg、Landsberg 与 Michałek 等历史界）与 OpenAI 公开论文 PDF 一致。2026-11-24 同批发布的另外两篇手稿（强多项式线性规划、简单多面体超多项式直径）以及前一日的《VP and VNP are different》，依据 OpenAI `openai/math` 仓库的 `history.md` 记录。

评论者给出的第三方数据与主张（包括「训练仍占算力 60-70%」「Opus 5.5 被削弱」「OpenAI 一次推翻了 Top 500 开放问题中的 8 项」等）由评论者自行给出，本文未核实。文中所有判断与立场均属于原文评论者，归纳与判断由本文完成。

⚠ 本篇引文涉及中美开源模型竞争话题。相关表述为 HN 评论者个人观点，未经核实，不代表本站立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
