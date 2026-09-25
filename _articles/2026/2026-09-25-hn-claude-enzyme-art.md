---
layout: post
title: >-
  Claude 发现 CRISPR 风格的酶系统——HN 关注的是不是这个发现
date: 2026-09-25
hn_id: 49820134
categories: [articles]
excerpt: >-
  Anthropic 宣布 Claude 在 DNA 数据库里翻出一种类似 CRISPR 的新酶系统 ART, 但 HN 的关注点很快滑向三件事: 这是不是 PR、训练数据有没有越界、生物实验室为什么比代码更难做。
tagline: >-
  950 个 agent 翻 21 小时翻出来的东西, 评论只想要一句: 这是真发现还是品牌动作。
---

## 原文概要

2026 年 9 月 23 日, Anthropic 宣布其新成立的**生命科学研究组**和湾区实验室发现了一类新酶系统, 暂命名 ART (array-associated reverse transcriptases, 阵列相关逆转录酶)。系统在噬菌体里被发现, 围绕一个“看起来奇怪”的逆转录酶 (RT) 基因, 周围是一组非编码 DNA 重复序列, 外加一个功能未知的辅助蛋白。

关键三特征:

1. **逆转录酶本体**——之前已被识别, 但没人注意到它的上下文。
2. **关联的非编码重复阵列**——这是 CRISPR 最早被发现的特征, 即一段重复序列。
3. **一个功能未知的辅助蛋白**。

按 Anthropic 文章的说法, 这三特征同时出现的系统在自然界非常罕见, 已知的几种都**可编程、可执行 DNA 的剪切 / 复制 / 粘贴**——CRISPR 是其中之一, 另有几种正在研发中。

工程上比较有意思的数字: Anthropic 给 Claude 一个高层 prompt, 让它在庞大的 DNA 数据库里找 RT 候选。**约 950 个 agent 协作, 消耗 2.1 亿 token, 跑了 21 小时**后, 一个 agent 在数据里标记出一个“DNA 重复模式紧挨着一个奇怪 RT 基因”的样本。后续湿实验在 BSL-1 / BSL-2 实验室由人类科学家完成。

MIT 与 Broad Institute 的 CRISPR 先驱**张锋 (Feng Zhang)** 在看过预印本后给出一句话评价: 这是“AI agent 如何参与生物发现的一个令人振奋的例子”。

来源: HN 热门榜 (/best), Anthropic 官方博客, 预印本 PDF 已公开。

---

## 讨论焦点

### 1. 是发现, 还是 PR?

第一条最朴素的疑问直接冲着发布节奏来。

bonsai_spool 上来就质疑**节奏**和**缺料**:

> "Very cool! However, the amazing absence of results makes me question whether they've got a Nature letter forthcoming or whether they know that another AI lab has a similar finding..." — bonsai_spool [c:49820551]
> （很酷。但缺少结果这一事实, 让我怀疑他们是不是要发 Nature letter, 或者已经知道别家实验室有类似发现。）

modeless 的怀疑更结构化, 指向 Dario 长期定位策略:

> "It’s clear Dario believes that the solution to AI’s PR problem is to cure cancer. Or invent other revolutionary medical treatments. They’re going to heavily promote every step along the way no matter how small or far away from commercialization they are, like this one." — modeless [c:49820935]
> （很明显 Dario 相信 AI 公关问题的解法是“治愈癌症”或发明其他革命性疗法。他们会大力推广每一步, 不管这一步多小、离商业化多远, 这次也一样。）

aakil 是第三种怀疑——**“生物学比代码难, Claude 这是在挑软的”**:

> "This shows why biology is so much harder a problem area for LLMs than math, finding RTs is tedious but pretty doable today, they had to scope the problem down a lot from something that would be the equivalent of Navier Stokes in biology. Glad they’re doing it though, even if it’s just marketing." — aakil [c:49820739]
> （这说明为什么生物学比数学难做太多——找 RT 麻烦但今天完全做得来, 他们把问题刻意收窄了, 远远不到生物学的 Navier Stokes 那种级别。高兴他们做这件事, 哪怕只是营销。）

三条怀疑指向同一件事的不同侧面: **节奏 (为什么这个时间点发) + 定位 (Dario 的长期叙事) + 难度 (他们挑的是容易的方向)**。

### 2. 训练数据污染: 上一轮“撞车”留下的阴影

mullingitover 把讨论拽到一个老话题上——Anthropic 是不是**看了别家的未发表工作**:

> "This is great, but I can’t help but wonder if we’re going to have another post next week with a lab complaining that they were about to publish this same finding, and they had Claude proofread their paper, and whoops how’d that get into Anthropic’s training data?" — mullingitover [c:49820654]
> （这很好。但我忍不住想, 会不会下周又有实验室发文说他们本来也要发这个, 还用 Claude 校对了论文——哎呀, 这怎么就进了 Anthropic 的训练数据。）

monospacegames 跟了一句, 提到 Alpöge 和 Buckmaster 那次事件——一个让所有 AI 科学发现的发布都被罩上阴影的时刻:

> "I wonder how long it will take for the damage Alpöge and Buckmaster have done to the perception of these AI-driven scientific developments to fade. Not saying that they were right or wrong, but that single moment sullied all AI-driven breakthroughs that came after it." — monospacegames [c:49821031]
> （不知道 Alpöge 和 Buckmaster 那次给 AI 驱动科研的观感造成的伤害多久才能消。不管他们当时对错, 那一个时刻把之后所有 AI 突破都弄脏了。）

mullingitover 接着说了一句让讨论尴尬的话: **AI 实验室应该对那些让 LLM 成为可能的人低头**:

> "I don’t think of this stuff in terms of AI anxiety, I just think that the AI labs should be falling all over themselves to display deference and humility to those who made it possible. The LLMs that make this stuff possible weren’t created by the AI labs from whole cloth." — mullingitover [c:49821330]
> （我不是从 AI 焦虑角度想这件事, 我只是觉得 AI 实验室应该抢着对那些让 LLM 成为可能的人表达敬意和谦逊。能做这件事的 LLM 不是 AI 实验室从零造出来的。）

这段把讨论从“发现本身”拉到“AI 实验室和科研社区的权力关系”——后者才是 HN 真正想吵的。

### 3. 生物学为什么比代码更难: 反馈环断了

aakil 上面已经点了题: 找 RT 比找证明容易。6thbit 把这个直觉展开成更结构化的论证:

> "It’s really a matter of iterating on the problem and validation right? Models make progress on coding and math because they can write tests and proofs to an extent. Many industries that are more ‘physical’ and require performing experiments lack that instant feedback loop. Find a way to close that loop and AI begins to look useful." — 6thbit [c:49822046]
> （本质就是迭代和验证。模型在代码和数学上能进步, 是因为它们能在一定程度上写测试、写证明。很多“物理性”更强的行业需要做实验, 缺那个即时反馈环。把环关上, AI 就有用了。）

asdff 顺着说, Anthropic 这套流程本质上就是在**自己造那个反馈环**:

> "They can’t automate the experiments since they are often bespoke towards certain goals or even feelings and assumptions based on sage technician knowledge that isn’t really taught in any one place. Instead, they tried to automate the process of searching for candidate targets to then test in downstream lab experiments." — asdff [c:49824101]
> （他们没法自动化实验——实验通常为目标定制, 甚至依赖老师傅的经验和直觉, 这些东西没写在任何一本教材里。所以他们改去自动化“找候选靶点”这一步, 后面再交给下游湿实验验证。）

所以 ART 这个发现的真正工程意义, 不是“Claude 找到了一个酶”, 而是 **Anthropic 在用 950 个 agent 模拟那个反馈环**。这一步走得通, 后面才是真问题: **如果反馈环要靠湿实验, 950 个 agent 后面还跟着 21 小时人工实验, 这套流程能跑多快**？

### 4. “这只是 next-token prediction” 这种话还有意义吗

pixl97 的反驳很直接:

> "Being an effective pattern matcher and next word predictor is like 60%+ of intelligence, maybe more. The people that say ‘It’s just a next word predictor’ might as well be saying ‘Well, it’s just a long rage nuclear missile’." — pixl97 [c:49821169]
> （有效的模式匹配和下一个词预测, 至少占智力的 60%, 可能更多。说“这只是个 next-token predictor”的人, 跟说“这只是个远程核导弹”的人一样。）

jackb4040 不买账, 把这件事拉回到“什么是 RSI”的元辩论:

> "How is this different from arguing that Microsoft Clippy was RSI? An AI tool being involved in the process of work can’t be the bar for RSI. I don’t think there can be a coherent definition of RSI unless people lay out their theory for how intelligence scales. LLM-assisted coding is great but respectfully optimizing pytorch features or whatever is not the same thing as writing the code that writes the optimizer." — jackb4040 [c:49821542]
> （这跟当年说 Microsoft Clippy 是 RSI 有什么差别？AI 工具参与工作流程, 不能作为 RSI 的门槛。我觉得没有连贯的 RSI 定义, 除非先把智能如何 scale 讲清楚。LLM 辅助编程很好, 但调优 PyTorch 跟写能写优化器的代码不是一回事。）

famouswaffles 进一步把“奇点”概念解构——先别喊 RSI:

> "Is the diminishing returns in the room with us? ... so all the labs are pivoting to specializing in particular fields like math / infosec / biology. They’re not pivoting to anything. The goal has always been creating a machine that could automate all or nearly all human work." — famouswaffles [c:49823801]
> （“收益递减”人都在现场吗？……所以所有实验室都在 pivot 到数学 / 信息安全 / 生物这种垂直领域。他们没在 pivot, 目标从来就是造一台能自动化几乎所有人类工作的机器。）

这条线的潜台词是: ART 这次发现的真正意义, 不在于 ART 本身, 而在于**它在 Anthropic 的公开叙事里补了一块拼图**——从 coding 到 math 再到 biology, AI 实验室要做的不是“一个突破”, 而是“把所有能自动化的领域都覆盖一遍”。**next-token prediction 能干到什么, 是一个统计学问题; 它怎么融入现实流程, 是一个工程问题**。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 节奏可疑 | bonsai_spool [c:49820551] | 没结果, 是不是要发 Nature 或别家有撞车 |
| Dario 公关策略 | modeless [c:49820935] | 用“治愈癌症”叙事缓解 AI 公关问题 |
| 挑软的做 | aakil [c:49820739] | 找 RT 远不到 Navier Stokes 级别 |
| 训练数据可能污染 | mullingitover [c:49820654] | 会不会有别家论文进了训练集 |
| 反馈环是关键 | 6thbit [c:49822046] | 生物比代码难做, 因为实验没即时反馈 |
| Anthropic 在造环 | asdff [c:49824101] | 实验自动化不了, 设计阶段先 scale |
| next-token 占 60%+ | pixl97 [c:49821169] | “只是 next-token prediction” 这话站不住 |
| RSI 定义没讲清 | jackb4040 [c:49821542] | Clippy 也是 AI 协助工作, RSI 门槛更高 |
| 实验室没在 pivot | famouswaffles [c:49823801] | 目标从来都是全自动化, 不是垂直化 |

## 总体情绪

这条新闻的讨论密度, 大头不在“Claude 发现新酶”本身——这一段 Anthropic 自己写得很清楚, 评论没补充什么新的生物学——而在三件**和发现无关的事**: Dario 的公关节奏、AI 实验室和科研社区的权力关系、生物实验为什么比代码难 scale。

HN 读者的怀疑不是因为 ART 不重要, 而是因为**Anthropic 这次既发了博客又发了预印本, 节奏明显示意给资本市场和监管看**。modeless 的话最尖锐——Dario 相信“AI 公关问题的解法是治愈癌症”——这句话其实跟生物学无关, 跟品牌有关。

讨论最有信息量的一段是 6thbit / asdff 的反馈环论证。**代码和数学能 scale, 是因为模型能写测试 / 证明, 形成即时验证; 生物学不行, 是因为实验是一次性的、不可批量回归的**。Anthropic 这套流程的关键不是 950 个 agent, 是它们后面那 21 小时湿实验——这个混合比例才决定能不能 scale。

最后那条“next-token prediction 占多少智力”的口水仗, 实际上把 ART 这件事推到了一个更根本的问题: **如果 next-token prediction 真能 drive 出新发现, 那它就不是一个“技术细节”, 而是关于“什么是科学发现”这件事的本体论辩论**。Anthropic 选择把这件事发出来, 等于已经押了注。

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | Claude discovers a novel enzyme system with CRISPR-like repeats | <https://news.ycombinator.com/item?id=49820134> |

## 免责声明

<div class="disclaimer">

本文为 HN 讨论摘要, 仅基于 HN 帖子 [49820134](https://news.ycombinator.com/item?id=49820134) 中的公开评论与 [Anthropic 官方博客文章](https://www.anthropic.com/news/claude-discovers-novel-enzyme-system) 及其预印本。引文逐字摘自上述来源, 翻译为本人理解; 用户署名与 `[c:id]` 严格对应原始 HN 评论。

文章中 ART 的发现细节 (950 agent、2.1 亿 token、21 小时、张锋评价、噬菌体 RT 上下文、ART 三特征) 均来自 Anthropic 博客原文, 未对预印本 PDF 独立验证。HN 评论中提及的 Alpöge 与 Buckmaster 事件细节未独立查证, 引用按原评论表述转述。

<br><br><em>本摘要由 AI 模型辅助生成: minimax-cn-coding-plan/MiniMax-M3</em>
</div>
