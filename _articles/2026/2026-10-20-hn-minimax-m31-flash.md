---
layout: post
title: >-
  MiniMax 发布 M3.1 Flash：428B MoE 架构主打 Agent 与编程，推理加速 3 倍、成本降低 70% — HN 热门讨论
date: 2026-10-20
hn_id: '50154540'
categories: [articles]
excerpt: >-
  MiniMax 官方推出 M3.1 Flash 模型（早期匿名测试代号 Space Bunny），总参数 428B（激活 23B）。DeepSWE v1.1 软件工程测试达 73.7%，CyberGym 漏洞挖掘达 82%，输出速度突破 200 TPS，百万 Token 仅需 $0.15 入 / $0.60 出。
tagline: >-
  “Flash”不再代表“小而轻”：428B 级别的 Flash 正在重新定义 Agent 的算力性价比。
---

### 原文概要

MiniMax 官方正式发布新一代模型 **MiniMax M3.1 Flash**。此前在匿名测试中处理了超过 200 万亿 Token 的模型 `Space Bunny`，即为此模型的早期版本。

作为面向下一代 `Agent`（智能体）与自动化任务的轻量级旗舰，M3.1 Flash 在复杂 `Agent` 工作流、代码开发、计算机使用（`Computer Use`）以及网络安全领域实现了跨越式提升，同时将在线推理速度提升至近 3 倍，综合使用成本降低 70%：

1. **复杂任务与自动化（Agentic Workflows）：**
   - 在 `AutomationBench-AA` 基准测试中名列前茅，能够跨 SaaS 系统完成复杂的端到端企业工作流；
   - 在 `BankerToolBench` 取得 76.2 分，擅长多步骤规划、文档一致性维护与链式工具调用。
2. **代码开发与软件工程（Coding）：**
   - 在 `DeepSWE v1.1` 软件工程基准测试中取得 73.7% 的成绩，展现出对大型代码库的自主理解、功能开发与测试验证能力。
3. **计算机使用（Computer Use）：**
   - 在 `OSWorld V2` 取得 61.7 分，在 `Agents' Last Exam (ALE)` 取得 29.6 分，在两项衡量真实环境跨应用交互的基准上均位居中国模型第一。
4. **网络安全与漏洞分析（Cybersecurity）：**
   - 在 `CyberGym` 上达到 82% 的高分，内部安全专家测试显示其在代码审计、漏洞补丁与逆向工程中具备强劲性能。

在推理效率方面，M3.1 Flash 通过更激进的稀疏化设计（`MoE`），日常输出速度可达 `200+ TPS`（Token/秒），中位数（P50）速度维持在 `170+ TPS`。定价方面保持极高的性价比：**百万 Token 统一定价为输入 $0.15 · 输出 $0.60 · 缓存输入 $0.015**。目前模型已通过 MiniMax API 及桌面客户端开放，模型权重将于稍后开源。

---

### 讨论焦点

#### “Flash”概念重塑：428B 规模下的“轻量化”新标准

社区对 MiniMax 在 M3.1 Flash 上采用的命名与参数量展开了热烈讨论。官网 FAQ 显示，该模型总参数量为 428B，激活参数量为 23B。读者注意到，“Flash”模型正从以往的“几百亿小模型”演变为数百亿激活参数的稀疏架构。

> "The FAQ on their website says Minimax 3.1 flash is 428B total, 23B active<p>Which is roughly similar to deepseek 4.1 flash.<p>I find it interesting that we’re calling these “flash” models now, even though they aren’t “small or light” and in many cases aren’t particularly that fast.<p>I suppose it’s more so that the standard for “regular models” is becoming 1T+" — penagwin [c:50155897]
> （官网 FAQ 显示 M3.1 Flash 总参数 428B，激活 23B，这与 DeepSeek V4.1 Flash 类似。有趣的是我们现在把这些模型称为“Flash”，尽管它们并不“轻小”，某些情况下也不算特别快。我想这更多是因为“常规模型”的标准正在向 `1T+` 迈进。）

> "Not really. “Flash” generally means fast or cost-efficient, not specifically MoE (Mixture of Experts)." — terhechte [c:50155786]
> （并非如此。“Flash”通常意味着快速或高性价比，并不特指 `MoE` 混合专家架构。）

> "Flash probably means single expert fits into some cost efficient GPU memory, and non flash models require more complex and cost expensive architectures." — andriy_koval [c:50157386]
> （“Flash”可能意味着单个专家可以放入高性价比的 GPU 显存中，而非 Flash 模型则需要更复杂昂贵的架构。）

#### 推理速度（TPS）与 Agentic 场景的现实折衷

社区围绕推理速度对智能体（`Agent`）编程体验的影响产生了分歧。一部分开发者认为在本地硬件上运行大型模型时，速度是最大的瓶颈；另一部分开发者则指出 `Agent` 异步工作的特性改变了对速度的敏感度。

> "Minimax has been a strong player in our tests, if they managed to solve the inference speed issue(be scared, be very scared). A decent speed is at least 13 tps in consumer hardware. Let see if it passes Hugston bench this time, we really hope so." — trilogic [c:50156021]
> （MiniMax 在我们的测试中一直表现强劲，如果他们解决了推理速度问题，那将非常可怕。在消费级硬件上达到 13 `TPS` 算合格。看看它这次能否通过测试。）

> "If all you're going to do is chat with an AI, you don't need a 400B parameter MoE model.<p>13 TPS is unusable for agentic coding, because if decode is that slow, then prefill is absolutely abysmal, and agentic work live and die by prefill speeds." — mickeyp [c:50156326]
> （如果你只是和 AI 对话，并不需要 400B 的 `MoE` 模型。13 `TPS` 在智能体编程中完全不可用，因为如果解码这么慢，预填充也会极其糟糕，而智能体工作完全取决于预填充速度。）

> "It doesn’t. Decode is by far the most dominant and expensive part of agentic tasks and once prefill hits a certain achievable speed decode dominates the time in ant agentic flows with reasoning." — bitexploder [c:50156633]
> （事实并非如此。在包含推理的智能体流程中，解码（Decode）才是最占据主导地位和成本最高的部分，一旦预填充达到一定速度，解码时间就会主导全局。）

> "I’ve been agentic coding at home with like 15 TPS on average. I don’t mind it at all. I can give my agent a big task or a list of little ones and just… do something else. Why do I need to watch it work?" — sosodev [c:50156581]
> （我一直在家用平均 15 `TPS` 的速度做智能体编程，我完全不在意。我可以给 `Agent` 一个大任务或一堆小任务，然后去干别的。为什么我需要盯着它工作？）

#### 基准图表对比争议与模型演进边际效应

发布公告中的对比图表也引发了关注。部分读者质疑为何图表中对比了 Claude Opus 5 与 5.5 的混合版本，并探讨了前沿模型演进中的算力边际递减现象。

> "Odd choice to have a mix of opus 5 and 5.5 in different graphics." — loufe [c:50155727]
> （在不同图表中混合对比 Opus 5 和 5.5 是个奇特的选择。）

> "I think it clearly points to where they expect themselves to be, Opus 5.5 and Astra or Sol 6.1 are models that shouldn't exist at those prices without the price competition." — minraws [c:50155968]
> （这清楚指出了他们的定位预期。如果不是因为价格竞争，像 Opus 5.5 以及 Astra 或 Sol 6.1 这样的模型在那种定价下本来是不可能存在的。）

---

### 典型观点一览

| 立场 | 用户 | 一句话观点 |
|---|---|---|
| 架构观察 | penagwin | “Flash”模型的概念已演变为 428B 总参数、23B 激活的稀疏架构，反映行业标准向 1T+ 移转。 |
| 硬件考量 | andriy_koval | Flash 意味着单个专家能契合高性价比 GPU 的显存容量。 |
| Agent 实践 | sosodev | 智能体编程无需实时盯盘，15 TPS 配合异步工作流已足够实用。 |
| 推理性能派 | mickeyp | 认为低 TPS 会严重影响预填充表现，导致复杂 Agent 交互体验恶化。 |
| 边际递减 | minraws | 前沿模型在增加 100 倍算力后仅带来微小性能增益，开源/性价比模型正在快速缩小差距。 |

---

### 总体情绪

社区对于 MiniMax M3.1 Flash 的发布保持了理性的技术审视与务实的期待。一方面，开发者们对 428B 规模 `MoE` 在 Agentic Workflows、代码生成与网络安全上的强劲表现表示认可，特别是百万 Token $0.15 的极低价格与高 TPS 输出给智能体落地方案带来了新的可能性。另一方面，对于发布图表中的基准测试对标基线以及实际部署中的预填充与解码效率，社区依然保持严谨的态度。

随着“Flash”概念被赋予更多稀疏化（`MoE`）与高效推理的含义，大模型行业正在从单纯追逐千亿/万亿密集参数，转向在可控算力成本下极力优化智能体长序列执行能力的实用主义阶段。

---

### 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | MiniMax M3.1 Flash: Redefining Agent Performance and Cost | https://www.minimax.io/blog/minimax-m31f |

---

<div class="disclaimer">
本文根据 Hacker News 热门讨论自动整理，不代表本站观点。
<br><br><em>本摘要由 AI 模型辅助生成：google/gemini-3.5-flash</em>
</div>
