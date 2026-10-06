---
layout: post
title: >-
  Mistral Large 4 — 1.05T 参数的欧盟 MoE 能否撑起「主权 AI」
date: 2026-10-06
hn_id: 49977979
categories: [articles]
excerpt: >-
  Mistral 拿出 49B 激活 / 1.05T 总参的开放权重 MoE，定价 50% 折扣后与 DeepSeek Flash V4.1 持平。社区一边承认 vision 与 cyber 基准亮眼，一边质疑它只是复刻上一代预训练。
tagline: >-
  法国人把猫画胖了 21 倍，价格直接砍到对折。
---

> 来源：HN 热门榜（`/best`）。帖子：[Mistral Large 4](https://news.ycombinator.com/item?id=49977979)，481 分，233 条评论。

## 原文概要

Mistral 于 10 月 6 日公开预览版（v26.10）发布 **Mistral Large 4**，主打「granular Mixture-of-Experts」架构：单次推理激活 49B 参数，总参数规模 1.05T，附带一个独立的 1.6B vision encoder，上下文窗口 1M tokens。模型为开放权重多模态通用模型，已开放 Mistral Studio API 与 OpenRouter 渠道。

官方文档列出的定价有两种呈现：基础价 $1.36 / $4.18（输入 / 输出，每百万 tokens），以及一项 **50% 折扣促销价 $0.68 / $2.09**。模型图标被画成一只胖猫，社区随即给它取了外号 **Le Chonk**。功能列表覆盖结构化输出、Function Calling、文档问答、Prefix、Chat Completions、批处理、Agents、内置工具。

文档页右侧的「Other Models」栏并列了 `Z.ai GLM 5.3` 与 `Z.ai GLM 5.2`——直接把 Mistral Large 4 与 GLM 5.3 摆在一起对照基准。

## 讨论焦点

### 基准亮眼，但 vision 与 cyber 是真正卖点

> "Impressive vision benchmarking. If the vision model is truly as good as astra, that would make it best in the world. Also strong on cyber benchmarks (better than all chinese models), so this is a good defender model..." — prodigycorp [c:49978149]
> （译文：vision 基准很惊艳。如果它真的像 Astra 一样强，那就是全球第一。cyber 基准也很强——超过所有中国模型，这是个合格的「防御模型」……）

`prodigycorp` 的视角带有明确选型倾向：当 OpenAI/Anthropic 在某些场景（网络安全、敏感领域）不合规时，Mistral Large 4 的 vision + cyber 组合可以成为 daily driver。评论下方衍生出大量「为什么嘲讽 Mistral」的辩护，并被反问「你想嘲讽欧洲什么」，进一步延伸到美欧经济对比大讨论（见末尾延伸段落）。

### 价格对标 DeepSeek Flash V4.1，折扣后几乎对齐

> "Looks like they are doing 50% off to stay price competitive with DS Flash V4.1" — mcbuilder [c:49978114]
> （译文：看起来他们在打五折，好跟 DeepSeek Flash V4.1 保持价格竞争力。）

折扣后 $0.68 / $2.09 的输入/输出价比，与 DeepSeek Flash V4.1 的公开定价落在同一档位。`mcbuilder` 一句话点出了定价的真实参照系：**基准发布节奏由中美前沿决定，但价格带已经被中国模型压住了**。对 Mistral 而言，五折促销与其说是让利，不如说是入场券。

### 「主权 AI」定位 vs 复刻上一代预训练

> "Mistral is one of the few European AI labs. Look up \"sovereign AI\"." — esafak [c:49978475]
> （译文：Mistral 是少数几家欧洲 AI 实验室之一。查一下「主权 AI」。）

> "Does Mistral ever advance the state of the art on any dimension? And if not, why do they exist?..." — erichocean [c:49978156]
> （译文：Mistral 是否在任何一个维度上推进了前沿？如果没有，那它为什么存在？……）

> "...'Sovereign AI' is a joke, there is no substantive difference between a post-trained open weight model from an American or Chinese company and what Mistral is doing today, beyond spending 80% of their GPU hours reproducing a last-gen model's pretraining." — erichocean [c:49978156]
> （译文：「主权 AI」是个笑话。除了把 80% 的 GPU 小时花在复刻上一代模型的预训练上，它和美中后训练出来的开放权重模型没有实质区别。）

`esafak` 把 Mistral 放进欧洲 AI 主权的稀缺性框架；`erichocean` 直接拆解：开放权重 + 后训练 = 任何人都能做，80% 的算力花在了「复刻上一代预训练」上。`swiftcoder` [c:49978294] 的反驳是「在网络安全这类领域，不愿完全依赖中国或美国政府是合理诉求」，`CJefferson` [c:49978245] 反问「欧洲人想要一个不属于美国万亿巨头或中国的高质量开源模型，难道想不出任何理由？」。

这条线暴露了 Mistral 的两难：是否值得为「非美中第三选项」支付溢价，社区目前没有共识。

### 追赶距离的多种估算

> "Looks like it's about a year behind still. i.e. its intelligence is behind models from roughly a year ago." — saberience [c:49978204]
> （译文：看起来还是落后了大约一年，智能水平相当于一年前的模型。）

> "Not bad only two major releases behind top tier. Edit : checked its rather 3 generations behind . Oh well" — maxdo [c:49978197]
> （译文：还不错，只落后顶级两代。编辑：查了下其实是三代。唉。）

> "This sure is nice, but I've had less than satisfactory results with GLM5.3. I'd like Mistral to compete with Qwen3.8-Flash-Next a 120B class model that IMO is the first model that I can use for serious coding while running it locally..." — Roark66 [c:49978203]
> （译文：挺好，但 GLM5.3 我用过效果一般。我希望 Mistral 能对标 Qwen3.8-Flash-Next 这种 120B 级别模型——它是我用过的第一款能本地跑、又适合正经编程的模型……）

`vals.ai` 的指数、arena.ai 的排名、自家 GLM5.3/Qwen3.8-Flash-Next 的实测体感——三套体系给出「一年 / 两代 / 三代」三种落后估算。`Roark66` 同时点出欧洲用户的具体需求：能在本地跑的、能匹敌 Opus 4.6 的编程模型。Mistral Large 4 显然不是这类目标的答案。

> "Its quite interesting to see that at least the early days of AI so far have not been a winner-take-all runaway acceleration game where catchup is impossible..." — eigenspace [c:49978211]
> （译文：有意思的是，AI 早期并不是一个赢者通吃、追赶无望的雪球游戏……）

`eigenspace` 给出一个乐观底色：**追赶仍然可行**。`apexalpha` [c:49978256] 在同一线程补充：「DeepSeek 把遇到的每一个障碍都以论文形式公开，相当于发了说明书」——这是 Mistral 能持续更新的外部条件。

### 蒸馏与技术来源的猜测

> "Since the Chinese companies publish their research it would have been odd if Mistral didn't start catching up." — staticman2 [c:49978097]
> （译文：中国公司公开研究成果，Mistral 不开始追赶反而奇怪。）

> "It's no secret that everyone is dis-stealing from everyone else." — Tade0 [c:49978323]
> （译文：大家都在互相「互相蒸馏」，早就是公开的秘密。）

> "Is there a reason to believe why they wouldn't distill locally running open weights Chinese models?" — water-drummer [c:49978414]
> （译文：有理由相信他们不会从本地能跑的中国开放权重模型蒸馏吗？）

`aeneas_ory` [c:49978104] 调侃「基准比预期强，而且大概率没用蒸馏；）」。从评论措辞看，社区并没有指控 Mistral 直接蒸馏，但「从开源中国模型蒸馏本地权重」已经被默认成行业惯例——`drbscl` [c:49979197] 反驳说「蒸馏和直接用 Deepseek/Moonshot/Zhipu 的公开方法论是两码事」。这条线揭示的事实是：**Mistral Large 4 的训练数据与方法是黑箱，但中国开源生态提供了所有基础设施。**

### 延伸：欧洲科技滞胀的辩论（次级 thread）

主帖之下衍生出一场独立讨论。`will4274` 在 `i_love_retros` [c:49978552] 反问「你想嘲讽欧洲什么」之后抛出这个论题：

> "Europe has spent the last twenty years in stagnation - generating about half as much wealth and technology as you'd expect for its size and advanced economy. Simultaneously, Europeans are notoriously arrogant. It's a mockable combination." — will4274 [c:49978797]
> （译文：欧洲过去二十年处于滞胀——按规模和先进经济体的体量算，只产生了应有水平一半的财富和技术。同时，欧洲人以傲慢著称。这是个值得嘲讽的组合。）

`TacticalCoder` [c:49979236] 用具体数据反驳：「瑞士（欧洲但不是欧盟）在市值前 70 名公司里占两家，而整个欧盟只有 ASML 一家；欧盟最大的软件公司 SAP 排在第 71 位；ASML 现有客户里欧洲占零」；`i_love_retros` [c:49979203] 反向辩护「欧洲人更健康、更幸福、基础设施更好，钱去哪了？」；`a3w` [c:49978890] 反驳「剔除科技公司后，美国也滞胀」。这场副线把 Mistral 当作了「欧洲在 AI 上还有没有存在感」的样本。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 看好 / 选型可入 | prodigycorp | vision + cyber 双强，是合格的「防御模型」 |
| 看好 / 主权 AI 框架 | esafak | 欧洲少有的 AI 实验室，价值在于非美中选项 |
| 看好 / 追赶仍可行 | eigenspace | 早期 AI 不是赢者通吃，追赶仍有窗口 |
| 中性 / 定价对标 | mcbuilder | 50% 折扣后才与 DS Flash V4.1 持平 |
| 质疑 / 复刻型创新 | erichocean | 80% GPU 小时复刻上一代预训练，缺乏前沿推动 |
| 质疑 / 落后差距 | saberience | 智能水平大约落后一年 |
| 质疑 / 落后差距 | maxdo | 实际是三代差距 |
| 期望 / 本地编程模型 | Roark66 | 希望有可匹敌 Qwen3.8-Flash-Next 的欧洲模型 |
| 实操 / 蒸馏猜测 | water-drummer | 不蒸馏本地能跑的开源中国模型反而奇怪 |
| 副线 / 欧洲滞胀 | will4274 | 欧洲过去二十年产出只到应有规模的一半 |

## 总体情绪

分歧明显，但偏积极。社区对 Mistral Large 4 的基准表现少有强烈质疑——`prodigycorp` 的 vision/cyber 双优评价基本被接受；价格层面的 50% 折扣被解读为对 DeepSeek Flash V4.1 的直接对标，没人觉得定价偏高。

真正的分歧在于**「值不值得」**这条线。一派认为只要 Mistral 维持开放权重 + 欧盟身份，就是中美 AI 之外的合理第三选项（`esafak`、`swiftcoder`、`CJefferson`）；另一派认为开放权重后训练的边际价值很低，80% GPU 小时花在复刻上一代预训练上不如把算力留给 RL post-train（`erichocean`、`embedding-shape`、`notfromhere` 的「换座椅套」比喻 [c:49978764]）。

更大的副线把这场讨论拖向了欧洲整体科技滞胀的命题——这条线与 Mistral 关系不大，更像是 HN 用户借机吵架，但 `eigenspace` 收尾的乐观信号值得记一笔：追赶仍然可行，中国开源论文 + 开放权重生态是 Mistral 持续更新的外部燃料，欧盟的「主权 AI」命题并不需要 Mistral 立刻达到前沿，只要它能维持「**跑得动、追得上、不会突然消失**」就够了。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Mistral Large 4（官方文档） | https://docs.mistral.ai/models/mistral-large-4-0 |
| 2 | Mistral Large 4（官方博客） | https://mistral.ai/news/mistral-large-4/ |
| 3 | VentureBeat 报道 | https://venturebeat.com/technology/mistral-debuts-large-4-le-chonk-a-1-trillion-parameter-text-output-model-with-high-benchmarks-planned-for-open-weights-release |
| 4 | The Next Web 报道 | https://thenextweb.com/news/mistral-releases-large-4-a-1-trillion-parameter-open-weight-ai-model |
| 5 | vals.ai 基准指数 | https://www.vals.ai/benchmarks/vals_index |

<div class="disclaimer">

本摘要为 AI 辅助整理，仅基于 HN 公开讨论，所有引文均标注原帖评论 ID。观点不代表本站立场，引用如有偏差欢迎指正。讨论中涉及美中 AI 生态的争议属于经济与产业话题延伸，已尽量保持中立表述。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
