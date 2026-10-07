---
layout: post
title: >-
  Claude Haiku 5.5 — 把便宜模型卷到 GPT-6 Luna 同价，社区却盯着 100k 阈值与 Agent SDK 的暗坑
date: 2026-10-08
hn_id: 49996437
categories: [articles]
excerpt: >-
  Haiku 5.5 价格砍掉 90%，与 GPT-6 Luna 在 100k 输入内同价；社区一边承认基准亮眼，一边把批评集中在「百 k 阈值外 5 倍跳价」与「Anthropic 借新模型悄悄把 Agent SDK 从订阅里砍掉」。
tagline: >-
  补贴退场那天，订阅用户才发现自己其实一直在给 API 打工。
---

> 来源：HN 热门榜（`/best`）。帖子：[Claude Haiku 5.5](https://news.ycombinator.com/item?id=49996437)，452 分，214 条评论。

## 原文概要

Anthropic 于 10 月 7 日发布 **Claude Haiku 5.5**，定位为「最便宜、最快、能力最强的小模型」。官方给出的三个关键数字：相对 Haiku 4.5 输入便宜 90%、输出便宜 90%（100k 输入以内），跑大多数 agentic 工作时平均成本比 4.5 低约 75%；与 GPT-6 Luna 在 100k 输入内完全同价；自称为公司「史上最快」模型。

基准表里最显眼的是 **Terminal-Bench 4.0：39.2%**，从 Haiku 4.5 的 0.0% 直接跃升，把 GPT-6 Luna 的 16.4% 也甩在身后；Computer Use（OSWorld 2.1）72.4% vs 4.5 的 15.7%。模型首次引入 **可调 effort 设置**，让用户在「成本 vs 智能」之间连续滑动，与 Sonnet/Opus 体系对齐。

发布同步做了三件「周边」动作：**Sonnet 5.5 cache read 价格砍半**（从 $0.20 降到 $0.10/MTok，agentic 工作整体降价约 20%）；给 Max 5x / Max 20x / Team 订阅用户每月分别发 **$100 / $200 / $500 API credit**；**Claude Agent SDK（`claude -p` 形式）悄悄被划入只能用 API credit 计费**，从此订阅额度不能跑 Agent SDK。Python/TypeScript SDK 同时加入 computer use 与 browser use beta。

## 讨论焦点

### 价格是真的便宜，但 100k 阈值外跳价 5 倍

> "100k tokens is an absurdly low cutoff and it is only applicable to Haiku and not Sonnet or Opus. It's a low enough cutoff that it will be quickly exceeded if you are doing anything with Agents..." — minimaxir [c:49996502]
> （译文：100k 阈值荒唐地低，而且只适用于 Haiku，不适用于 Sonnet 或 Opus。一旦你在做 agent 相关的事，这个阈值很快就会被突破……）

> "So even at the 1.5x/2x rate luna is still half the price of this. Weird pricing strategy from Anthropic. I'm sticking with Luna if I don't need a super smart model" — tripleee [c:49997366]
> （译文：哪怕 Luna 触发了 1.5x/2x 的高段定价，仍然只有 Haiku 5.5 的一半。Anthropic 这个定价策略很怪。我不需要超强模型时还是留在 Luna。）

`minimaxir` 把 100k 阈值定为「agent 工作流的天花板」，并指出 Luna 同样在 272k 触发提价但比例更平缓。`tripleee` 进一步比较：Luna 提价后仍是 Haiku 5.5 一半，加上大部分任务不到 100k，所以「理性人选 Luna，预算敏感的选 Haiku 5.5」这种二分不成立——Haiku 5.5 的定位被自己的跳价结构挤到了非常窄的区间。

### 真实成本是 $/completed task，不是 $/token

> "You're judging purely by token cost I assume, not cost per completed task? The benchmark in the article showed it as lower per completed task than luna, but I guess we'll find out how representative that is." — usef- [c:49998303]
> （译文：我猜你只看 token 单价，不是看每个完成任务的成本？文章里的基准显示 Haiku 按完成任务计费比 Luna 还低，具体代表性还要再看。）

> "It's absolutely better than Luna. It feels closer to a \"sonnet 5.2\" if that makes sense. Of course it's not as big, and hence falls-off quicker." — dannyw [c:49996829]
> （译文：它绝对比 Luna 强。感觉更像是「Sonnet 5.2」，你懂吧。当然它模型更小，所以掉得更快。）

`usef-` 立刻指出 token 单价是错位比较，$/completed task 才是合理口径；`tripleee` [c:49998377] 自己承认「对，我应该看 $/completed task」。`dannyw` 给 Haiku 5.5 一个直觉定位——Sonnet 5.2 级别——比 Luna 强但不持久。多条评论总结同一信号：Anthropic 这轮定价明显在做「按完成任务计费」的优化，用 100k 内的低 token 价吸引短任务，再用模型自身能力把任务复杂度消化掉。

### Sonnet cache read 砍半：Sonnet 与 Opus 的关系被重写

> "Happy about the Sonnet cache read price cut." — sfkgtbor [c:49996490]
> （译文：Sonnet cache read 砍半这事很高兴。）

> "That was effectively required to match GPT-6.1 Sol (costs and caching prices are now equal). Sonnet 5.5 made zero sense to use over Opus 5.5 under the old cache prices." — minimaxir [c:49996596]
> （译文：这次砍价实质上是为了对齐 GPT-6.1 Sol 的 cache 价（两边成本和缓存价现在完全一样）。在旧 cache 价下，Sonnet 5.5 用在 Opus 5.5 之上毫无意义。）

`sfkgtbor` 一句话收下利好，`minimaxir` 把动机点破：cache 占 token 消耗大头，旧价下 Sonnet 5.5 被自家 Opus 5.5 完全挤压，砍半才能恢复其与 GPT-6.1 Sol 的可比性。**Anthropic 的价格梯度被这次发布会重新整理成了「Opus 5.5 → Sonnet 5.5 → Haiku 5.5」三层清晰结构**，每一层都对标一个外部对手。

### 订阅用户发现 Agent SDK 被悄悄划走

> "Note that this is Anthropic Trojan-Horsing the previously announced June change in with a model release, where the Claude Agent SDK can no longer be used with Claude subscriptions and is now billed with API credits only." — thepasch [c:49996942]
> （译文：注意 Anthropic 在借模型发布的机会把六月那次的改动塞进来——Claude Agent SDK 不能再用订阅额度跑，现在只能用 API credit 计费。）

> "This is a very big benefit for me. I can now ship actual ai enhanced features behind my subscription without paying extra... I do worry that this is to soften the blow for user-unfriendly changes" — charlesabarnes [c:49996757]
> （译文：这对我来说是个大福利。我终于能在订阅额度内上线真正的 AI 功能而不额外付费……但我担心这是在为不友好的改动铺路。）

`thepasch` 把这条改动叫「特洛伊木马」：六月公告时撤回了，因为社区反弹太大，这次趁模型发布一起上。`charlesabarnes` 看到 credit 福利的正面，`geek_at` [c:49996878] 立刻反向读出意图：「等你习惯了 API，他们停掉 allowance 时你会自然继续付费」。`seaal` [c:49996607] 的总结比较中肯——Anthropic 这几周做对了很多事，但这次让 OpenAI「继续掉链子」的对比多了一层讽刺。

### 中国便宜模型 vs 闭源便宜模型

> "Who in their right mind would use haiku while Mimo or GLM cost 10% of what they are charging with much smarter models?" — system2 [c:49996678]
> （译文：脑子正常的人，谁会用 Haiku，MiMo 或 GLM 只要 10% 的价却更聪明？）

> "Some people/organizations are ideologically opposed to using Chinese models. Not me, I use GLM-5.3-Flash for almost everything... Still, I use Luna for certain tasks where speed is more valuable than performance; I can see this new Haiku displacing Luna for those." — wyrdcurt [c:49997105]
> （译文：有些人或组织对使用中国模型有意识形态上的抵触。我自己用 GLM-5.3-Flash 做几乎所有事……不过对于「速度比性能更重要」的任务我仍然用 Luna，新 Haiku 在这些场景里很可能会取代 Luna。）

> "There really aren't any models at 10% of the price of Luna or Haiku." — aesthesia [c:49997360]
> （译文：根本没有哪个模型是 Luna 或 Haiku 价格的 10%。）

> "Where do you get this 10% number? Checking providers I know/respect, and GLM 5.3 flash is $0.15/m. Haiku is $0.10/m." — pkulak [c:49998363]
> （译文：你这 10% 从哪来的？我去查了我了解的几个供应商，GLM 5.3 flash 是 $0.15/m，Haiku 是 $0.10/m。）

`system2` 的「10% 价」说法被 `pkulak` 用具体数据打脸——GLM 5.3 flash 是 $0.15/m，Haiku 是 $0.10/m，差价比远不到 10 倍。但 `wyrdcurt` 指出「意识形态壁垒」是真实存在的：很多组织不愿接入中国模型 API，所以「闭源便宜模型」的市场份额比单纯按价格计算要大得多。`mrngld` [c:49997272] 补充一个被忽略的维度：中国模型虽然 token 便宜，但「单位任务 token 数更多」，综合成本未必更低。

### AI 的「摩尔定律」：成本曲线还会继续向下

> "I wonder if we have an AI LLM equivalent to Moore's Law. Like how often do we expect improvement in this technology and with what timing?" — TheAmazingRace [c:49996475]
> （译文：AI/LLM 有没有等价的摩尔定律？这种技术的改进频率和时间表是什么？）

> "According to Epoch AI: The cost of achieving a given level of AI performance has fallen about 47% per quarter since 2023, or 13× per year." — istjohn [c:49996828]
> （译文：Epoch AI 的数据：自 2023 年起，达到固定智能水平所需的成本每个季度下降约 47%，相当于每年降 13 倍。）

> "Then why are AI plans still so super expensive, and AI spending going through the roof, while all the subsidies are ending?" — FooBarWidget [c:49997110]
> （译文：那为什么 AI 订阅还这么贵，AI 支出还在飙升，所有补贴都在退场？）

> "Apart from what others said about using more intelligent models instead of cheaper ones, token usage is also increasing a lot. Classic Jevons paradox." — srdjanr [c:49998019]
> （译文：除了别人说的「用更智能的模型取代更便宜的」，token 用量本身也在大幅增加。典型的杰文斯悖论。）

> "AI gets cheaper, people use it everywhere. Google searches, for example. Now we want to crack math problems and spend weeks with unreleased models." — stephbook [c:49998723]
> （译文：AI 变便宜，人们就在更多地方用它。Google 搜索就是个例子。现在我们要去解数学题，花几周用未发布的模型。）

`TheAmazingRace` 的提问引出 `istjohn` 引用的 Epoch AI 数字——每年 13 倍的下降速度，相当于每 18 个月效率提升 90% (`onlyrealcuzzo` [c:49996697])。`FooBarWidget` 立刻追问那为什么支出曲线还在涨，`srdjanr` 给出杰文斯悖论的回答：单价降，**用量涨更快**。这条线把 Haiku 5.5 的发布放进了一个更大的框架——Anthropic 降价不是因为利润压缩，而是**配合用户用量加速上涨的必然动作**，否则会被杰文斯曲线甩在后面。

### 用户实际在拿 Haiku 做什么

> "Opus often picks it when it's doing a 'find me something' subagent. But largely it's been held back by being fully a year old at this point, and priced at a much higher price than models that are far more capable." — svachalek [c:49996651]
> （译文：Opus 跑「找东西」子任务时经常挑它。但它一直被卡在「整整一年没更新」和「价格比强得多的模型还贵」这两个问题上。）

> "I have a zsh functions that calls claude code with haiku to suggest commit messages... I use haiku for things that needs to be quick, have really clear instructions." — mariocesar [c:49996711]
> （译文：我有个 zsh 函数用 Haiku 跑 Claude Code 来生成 commit message……我用 Haiku 处理那些需要快、指令又清晰的事。）

> "I mostly use Haiku for really, really basic stuff, never for actual engaging work. I've used it for first-pass analysis to triage bugs, for example - all it does is related N bugs together to see if any potentially relate. Then I have Sonnet investigate further." — insanitybit [c:49996667]
> （译文：我主要用 Haiku 做非常基础的活，从不用它做正经工作。比如做 bug 的第一轮分类——它只负责把 N 个 bug 关联一下看有没有可能是同一类，然后交给 Sonnet 进一步调查。）

`patrickwdaly` [c:49996610] 抛出一个低门槛问题——大家都在拿 Haiku 干什么？回帖里出现三类典型用法：被 Opus 当 subagent 调用 (`svachalek`)、跑本地小工具 (`mariocesar` 的 commit message)、做 triage/分类的预处理器 (`insanitybit`)。`steve_adams_86` [c:49996658] 给了一个更体系化的答案：把 Haiku 当文档解析和低推理脏活的引擎。所有这些用法对 latency 和 cost 的敏感度都高于对智能上限的敏感度——这正是 Haiku 5.5「便宜+最快」定位的真正市场。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 质疑定价 | minimaxir | 100k 阈值荒唐地低，做 agent 必超 |
| 质疑定价 | tripleee | 提价后 Luna 还是便宜一半，定价怪 |
| 转向 | tripleee | 应该看 $/completed task，不是 $/token |
| 看好能力 | dannyw | 比 Luna 强得多，感觉像 Sonnet 5.2 |
| 肯定动作 | sfkgtbor | Sonnet cache read 砍半很爽 |
| 拆穿动机 | minimaxir | Sonnet 砍价是对齐 GPT-6.1 Sol 的必要动作 |
| 警惕订阅 | thepasch | Agent SDK 借发布悄悄划走是特洛伊木马 |
| 怀疑动机 | geek_at | credit 福利是让你习惯 API，停掉 allowance 时自然会付费 |
| 看正面 | charlesabarnes | 终于能在订阅内做正经 AI 功能 |
| 比中国模型 | system2 | GLM/MiMo 便宜 10% 还更聪明 |
| 反驳 system2 | pkulak | GLM 5.3 flash 是 $0.15/m，差价比远不到 10 倍 [c:49998363] |
| 现实壁垒 | wyrdcurt | 「不用中国模型」是真实的意识形态障碍 |
| 反论据 | mrngld | 中国模型单位任务 token 更多，综合成本未必更低 |
| 价格曲线 | istjohn | 固定智能水平的成本每年降 13 倍 |
| 杰文斯悖论 | srdjanr | 单价降，用量涨更快，总支出反而升 |
| 用法演化 | stephbook | AI 变便宜后从 Google 搜索用到解数学题 |
| 子任务定位 | svachalek | Opus 会把 Haiku 当「找东西」子任务调起来 |
| 轻量脚本 | mariocesar | 跑 zsh 函数生成 commit message |
| 分类预处理 | insanitybit | 用 Haiku 做 bug triage 的第一轮分类 |
| 文档解析 | steve_adams_86 | 让 Haiku 处理文档解析与低推理脏活 |
| 拒绝激进 | giancarlostoro | 希望 Haiku 能支持 400k 上下文，否则 Sonnet/Opus 会把它顶掉 |

## 总体情绪

偏中性偏看好，但带两根明显的硬刺。基准层面的共识比较一致——Haiku 5.5 在 agentic coding 与 computer use 上相对 4.5 是代际跳跃，Terminal-Bench 从 0% 拉到 39% 不是渐进改善。社区对「Anthropic 终于舍得把便宜模型做出竞争力」这件事普遍欢迎，`onlyrealcuzzo` 与 `dannyw` 的「比 Luna 强得多」评价基本没被反驳。

两根硬刺：**价格结构与订阅政策**。价格上 100k 阈值外跳价 5 倍被认为是为了把用户卡在「短任务便宜、长任务自动切换到 Luna 或 Sonnet」的隐形引导；订阅政策上 Agent SDK 被悄悄划走是更大的失分——`thepasch` 直接用「Trojan-Horsing」措辞，意味着六月那次撤回并未真正撤回，只是换了个时间点。`seaal` 与 `charlesabarnes` 给出了「这次发布做对了很多」的总结，但底下全是 `geek_at`、`thepasch`、`tekacs` 式的反向解读。

Anthropic 这次打的牌很清晰：用 Haiku 5.5 抢回便宜模型市场（对标 Luna），用 Sonnet 缓存砍半恢复梯度（对标 GPT-6.1 Sol），用 credit 福利让订阅用户觉得赚了（对冲 Agent SDK 划走的负面），用 OpenAI 这两周连续失分做舆论背书。模型本身的成本/能力组合是这张牌里最不需要解释的部分；**真正决定后续走势的，是订阅额度能否撑住「做产品」的承诺**——一旦 credit 也像 Agent SDK 一样被悄悄收回去，这次发布留下的最深刻记忆不会是 pelican 自行车，而是「补贴退场那天，订阅用户才发现自己其实一直在给 API 打工」。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Introducing Claude Haiku 5.5（官方） | https://www.anthropic.com/claude-haiku-5-5 |
| 2 | Claude Haiku 5.5 System Card | https://www.anthropic.com/claude-haiku-5-5-system-card |
| 3 | Epoch AI: The Plunging Price of Thought | https://epoch.ai/publications/the-plunging-price-of-thought |
| 4 | Decisions API（OpenAI 对照） | https://developers.openai.com/api/docs/guides/decisions |
| 5 | Agent SDK 订阅条款变更 | https://support.claude.com/en/articles/15036540-use-the-claude-agent-sdk-with-your-claude-plan |

<div class="disclaimer">

本摘要为 AI 辅助整理，仅基于 HN 公开讨论，所有引文均标注原帖评论 ID。观点不代表本站立场，引用如有偏差欢迎指正。讨论中涉及中美 AI 模型价格对比与订阅政策争议属于产业话题延伸，已尽量保持中立表述。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
