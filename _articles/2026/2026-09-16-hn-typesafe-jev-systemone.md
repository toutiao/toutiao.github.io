---
layout: post
title: >-
  TypeSafe Jev 不生成文字 — HN 讨论：把 LLM 换成「结构化决策模型」靠谱吗
date: 2026-09-16
hn_id: 49717558
categories: [articles]
excerpt: >-
  TypeSafe 创始人 Diogo Almeida（前 OpenAI）发布 System One Model 与首个模型 Jev：不生成 token、并行采样、输出结构化概率，端到端 70-500ms，比 LLM 快 40-200 倍。
tagline: >-
  AI 在 Doom 里打恶魔，比你判断 Spam 评论还便宜。
---

## 原文概要

9 月 15 日，TypeSafe AI 在官博发文，宣布经过两年秘密研发，正式推出 System One Model 系列与首个对外模型 Jev。创始人 Diogo Almeida 是早期 OpenAI 成员，参与过 ChatGPT 背后的指令微调与对话方法研究。他在文章里抛出一个被反复讨论的命题：「模型在聊天上早就超过人类了，自动化为什么还没发生？」

Jev 与现有 LLM 的差异写在官方对比表里八个维度：

| 维度 | 现有 LLM | Jev |
|---|---|---|
| 训练方法 | RLHF / RLVR | RLCD（Reinforcement Learning for Calibrated Decisions） |
| 优化目标 | 人类偏好的字符串 / 可程序验证的奖励 | 校准过的决策（带认知诚实的概率） |
| 输入 | 强调序列化消息的非结构化数据 | 强调结构化程序状态的非结构化数据 |
| 输出 | 字符串 / 生成文本（可解析、可验证、也可能跑偏） | 预先定义的类型安全结构化值（数学上不可能出现类型错误，每条带概率与置信度） |
| 采样 | 顺序自回归，一次一个 token | 并行，单次查询同时生成所有输出 |
| 价格 | 输入 $0.20-$10 / MTok，输出约为输入的 5 倍 | 输入 $0.042 / MTok，输出免费 |
| 速度 | 端到端 3-329 秒 | 端到端 70ms-500ms，同等智能水平下快 40-200 倍 |
| 置信度 | 即使 prompt 要求输出置信度，也常常过度自信 | 每次输出都给出校准后的置信度 |

Jev 不再生成字符串，定位被官方写为「一个前沿智能级的函数调用：非结构化状态进，类型化的概率决策出」。官方推荐用例包括：AI 驱动的工作流 / 智能 if 语句、大数据上的 map-reduce、实时应用、为 LLM prompt 与推理过程打分 / 校验 / 兜底 / 反越狱。

证据部分，官方放了两块材料：一是 Doom 演示（程序状态 → 玩家控制输出，让 Jev 自己打 Doom），二是 side-by-side 对比 GPT-5.6 Terra。评测指标叫「workflow eval」，假设每个工作流都有一个「正确计算图」，拿 Astra 与 Fable 等超大模型输出的概率做参考，看各模型相对于平均参考的拟合度。官方结论是 Jev「几乎在两个数量级的范围内占住了 Pareto 前沿」。

帖子在 HN 拿到 805 分、264 条评论。

## 讨论焦点

### Doom 演示远不只是炫技：游戏 QA 可能最先被吃掉

很多人看到 Doom 演示第一反应是「玩具」，但有开发者立刻指出真正的价值在自动化测试。Jev 不接画面帧、只接程序状态，输出是离散控制动作，这跟「让 LLM 看屏幕玩游戏」完全不是一回事：

> "I'm not sure the authors realize this is way more than \"just a cool demo\": if this holds up, it's going to be huge for game QA work. Instrument your game to output properties of entities near the player and the output is the various control inputs - moment to moment gameplay gets solved." — caspar [c:49721173]

> （译文）

这把 Doom 演示翻了个面：它演示的不是「AI 会打游戏」，是「AI 可以批量替人类测试员完成一段连续博弈决策」。配合 tick 级步进与上层 LLM 推理，几乎可以把整条游戏 QA 流水线重写。

### 证据 vs 营销：质疑声浪与拒绝公开 benchmark

「Extraordinary claims require extraordinary evidence」被作者写进开头，评论区反而成了反向印证。一位用户对「RLCD」「parallel sampling」两项核心声明直接开炮：

> "This sounds good but so far all claims just sound like marketing terms. I'd love to see real proof. e.g.  \"RLCD\" and \"parallel sampling\" have nothing to back it up. also \"70-500ms vs 3-329 seconds\" are apples-to-oranges unless the LLM baseline is doing comparable work (e.g., long chain-of-thought). If Jev is skipping generation entirely for a narrow structured task, of course it's faster." — ramon156 [c:49718120]

> （译文）

更刺骨的是这句：作者在文中明确写了「故意不公开与公开 benchmark 的对比，只在产品更新时做一次性评测」，评论区立刻接住：

> "lol, I bet they would publish them if their score on those benchmarks were good." — jceg [c:49718242]

> （译文）

CEO 随后在回复中引用自家 manifesto 与 antibenchmaxxing 文章辩解说：「Jev 本质是个分类模型，公开 benchmark 没法覆盖它擅长的那类工作流，需要按场景另起评测」——但这条解释并没有压住怀疑。

### 并行采样 = 输出 token 免费：一次前向算完

对比表里最反直觉的一行是「输出 token 免费」。一位用户直接卡在这里：

> "> [others] Output tokens: ~5x more expensive than input tokens. > [them] Output tokens: FREE (too cheap to meter). I'm very confused by this." — initsecret [c:49718135]

> （译文）

楼下立刻有人用架构语言拆开：

> "They're not doing autoregression, so all the outputs are computed in one big forward pass. Very cheap." — quotemstr [c:49718317]

> （译文）

CEO 补刀确认：「我们这一列的输出 token 才免费」——也就是说，Jev 没有「逐 token 采样」的概念，所有结构化输出的概率是同一次并行前向里算完的。LLM 的输出 token 之所以贵，是因为每多生一个 token 就要再跑一遍整张网络；Jev 没有这个开销，于是输出端几乎不要钱。

### 命名 + 定位：System One = 卡尼曼的 System 1，是 LLM 的「潜意识」

「System One」这名字在文章里反复出现，但官方没解释。一位用户自己挖到了出处：

> "Why did they pick the name System One? It's not really explained what \"System One tasks\" and \"System One shaped queries\" are. Things that need a fast response?" — andai [c:49718166]

> （译文）

> "Bingo. It's a Psychology term for the part of our brain that reacts instinctively rather than thoughtfully and logically" — hunterbrooks [c:49718265]

> （译文）

对应卡尼曼《思考，快与慢》里的 System 1（快速、直觉、自动反应）。CEO 之后主动把这个类比往前推了一步：

> "I see this super interestingly as the \"subconscious\" to the llms \"conscious\" for lack of better terms." — ianbutler [c:49718692]

> （译文）

> "1. I am extremely on the same page 2. I do think that subconscious is not only much smarter than we give it credit for, but also much more robust than the \"jagged frontier\" of current LLMs" — CompleteSkeptic [c:49719116]

> （译文）

按这条思路：LLM 像 System 2，需要「想很久」，Jev 像 System 1，靠直觉返回概率与置信度，速度快、便宜、不胡说。两边不是替代关系，更像大脑里的两套系统各管各的活。

### 真要用它替换多少 LLM 调用：开发者自己估的账

抛开营销，最实在的问题是「我能拿它替掉多少现有 LLM 调用」。几位用户给出了自己的估算：

> "I'm guessing it might be able to replace maybe 40-70% of LLM calls for a given pipeline depending on the business task, cutting the API costs on those calls by an order of magnitude." — jrickert [c:49717928]

> （译文）

> "I could see this being fantastic for classification tasks. Last year I shifted from using LLMs for bulk data classification tasks (1M transcripts) to generating embeddings and categorizing based on cosine similarity. It saved a ton of costs and time, but wasn't as accurate as LLMs. This seems like it can give me Terra-level classification ability with the cost/speed I need." — jawns [c:49718267]

> （译文）

两条都用的是同一组数（替换 40-70% LLM 调用、成本省一个数量级），差别在于 jawns 是已经吃过「用 embedding 顶替 LLM 分类」亏的人，对 Jev 的「结构化输出 + 校准置信度」特别兴奋——这正好是他以前缺的那块拼图。

### 推销页面本身的吐槽：SVG 描边让人眼睛流血

技术部分之外，评论区对官网渲染也集体吐槽。一位用户甚至怀疑整页是 `<canvas>`：

> "What is it about the rendering of this page that is so... off? It almost looks like the entire thing is a `<canvas>` element." — whalesalad [c:49718137]

> （译文）

另一位的诊断更细致：

> "If you zoom in (especially on the large title), you'll see that the text is a semi-transparent gray with a black internal outline. It seems like all the typography is SVG-rendered. Actually insane. I've never seen this before. Not even the most vibeslopped websites have that." — phenomen [c:49718544]

> （译文）

字面意思——TypeSafe 的页面把所有文字都用 SVG 渲染、加了半透明灰色 + 黑色描边。视觉效果很「AI vibe」，但读起来累。对一个想用「结构化、类型安全」立人设的公司，官网的可读性被自家团队反讽了一轮。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 兴奋 / 立即能用 | jrickert [c:49717928] | 估计能替换 40-70% 的 LLM 调用，成本省一个数量级 |
| 兴奋 / 已有同类需求 | jawns [c:49718267] | 100 万条转写分类场景，Jev 的结构化输出 + 校准置信度正是缺的那块 |
| 怀疑 / 营销 | ramon156 [c:49718120] | 「RLCD」「parallel sampling」目前只有名字，没有证据；速度对比是苹果对橘子 |
| 怀疑 / 拒绝公开 benchmark | jceg [c:49718242] | 不公开 benchmark 的公司，往往是分数不好看的那种 |
| 解释 / 架构澄清 | quotemstr [c:49718317] | 不是自回归，所有输出在一次并行前向里算完，所以输出 token 便宜 |
| 解释 / 命名渊源 | hunterbrooks [c:49718265] | System One 来自卡尼曼心理学，System 1 直觉 / System 2 慢思考 |
| 类比 / 认知架构 | ianbutler [c:49718692] | Jev 是 LLM 的「潜意识」，LLM 是「意识」 |
| 实用 / Doom 引申 | caspar [c:49721173] | Doom demo 真正的价值是游戏 QA：状态进、控制出，量产能替人类测试员 |
| 吐槽 / 页面 | phenomen [c:49718544] | 官网所有文字 SVG 渲染 + 半透明灰描边，从没见过这种字体处理 |

## 总体情绪

整条讨论分成了三股力量，且没有谁压过谁。

第一股是开发者侧的实用兴奋：能替换 40-70% LLM 调用、能跑游戏 QA、能在大数据上做 map-reduce——这些不是空想，是有现成 backlog 的人听到具体数字之后的本能反应。第二股是技术怀疑：「RLCD」「parallel sampling」目前都还只是名字，速度对比挑了对自己有利的基线，且明确拒绝公开评测分数；第三股是概念兴奋：把 Jev 类比成 System 1、类比成「潜意识」，等于给整个 AI 工程界提供了一个值得反复打磨的隐喻。

帖子底下的声音像一次没结论的内部技术评审——有人已经在等下签、有人还没信、有人在帮它把话讲清楚。三股力量都没有占到上风，说明 Jev 这条路线已经被认真对待，但还没到被验证的时刻。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Introducing System One Models and Jev — TypeSafe AI Blog | https://typesafe.ai/blog/introducing-system-one-models-and-jev |
| 2 | HN 讨论页 | https://news.ycombinator.com/item?id=49717558 |
| 3 | TypeSafe Manifesto | https://typesafe.ai/manifesto |
| 4 | Anti-benchmaxxing 立场文 | https://typesafe.ai/blog/antibenchmaxxing |
| 5 | The Bitterest Lesson（CEO 个人博客） | https://www.completeskeptic.com/p/the-bitterest-lesson |
| 6 | Lies, Damned Lies, and Benchmarks（CEO 个人博客） | https://www.completeskeptic.com/p/lies-damned-lies-and-benchmarks |
| 7 | docs.typesafe.ai 概念页（System One 解释） | https://docs.typesafe.ai/concepts/system-one |
| 8 | dspy-typesafeify（社区 fork 集成示例） | https://github.com/typesafeainate/dspy-typesafeify |

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3<br><br>
引文基于 HN 评论区缓存 `_data/hn/2026/W38/49717558/comments.yaml`，逐条对照作者原文；翻译为意译。Jev 的能力声明与官方 benchmark 立场均以原博客为准，本摘要不做独立技术验证。

</div>