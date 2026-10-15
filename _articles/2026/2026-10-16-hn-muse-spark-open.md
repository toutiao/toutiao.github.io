---
layout: post
title: >-
  Meta 发布 816B 开源权重模型 Muse Spark Open — HN 讨论摘要
date: 2026-10-16
hn_id: 50107379
categories: [articles]
excerpt: >-
  在 2 台 M5 Ultra Mac Studio 上跑得动的 816B 开源模型，硬件要价 3 万美元起 — 这是真正的开源，还是只卖了一组权重？
tagline: >-
  Meta 说开源新高度，HN 先把两张 M5 Ultra 的账单算清楚。
---

## 原文概要

Meta 发布 Muse Spark Open，定位是「迄今最强的美国开源权重模型」，总参数 816B（激活 42B）的 MoE 架构，原生多模态，上下文窗口 100 万 token，专注长链路任务和复杂软件工程。模型通过 Baseten、Fireworks AI、Groq、Modal、Nebius、OpenRouter、Together AI 等七家推理平台同步上线，权重同步放上 Hugging Face、Amazon SageMaker、Google Cloud Model Garden 和 Microsoft Foundry Models。

官方主推的本地运行姿势是 2 台 M5 Ultra Mac Studio（每台 512GB 统一内存），借助最新版 MLX 框架把两台机器拼成「一台带 1TB 统一内存的超级计算机」。芯片 1.2 TB/s 的内存带宽刚好够每次读一小片权重；Meta 顺手发布了配套的 Helion GPU 内核，在 SGLang 里拿到 1.03–3.95 倍的 kernel 加速，AMD MI350 上端到端再快 3%。他们演示了用 Muse Code 端到端修改开源 Mastodon 客户端 Ice Cubes 的 iOS 代码，以及驱动 DaVinci Resolve 逐帧挑素材做竖屏剪辑。

授权用的是自定的「Muse Model License」，带商业限制条款。模型卡说明 Meta 已按自家「Superintelligence Scaling Framework」做过风险评估，认为可以开源。底层推理引擎覆盖 SGLang、vLLM、TensorRT-LLM、Hugging Face Transformers、Apple MLX、llama.cpp、Unsloth，CPU 优化同时覆盖 AMD、Apple、Intel、NVIDIA。

## 讨论焦点

### 两台 M5 Ultra 的账单

HN 第一反应是「这是给普通人准备的吗？」。回帖把官方那句「桌面上的最佳方式」拆成账单：单台 256GB 内存的 M5 Ultra Mac Studio 起价 11,299 美元，512GB 版本还没上市；双机方案怎么也得 3 万美元上下，再往上的对标物是 GB300 工作站，「起步 9 万美元」。

> "Read it again. Two M5s. Wait read *that* again. Two *512GB*, unreleased model M5s. This is gonna cost like 50k to run at home." — ryanschaefer [c:50107696]

> （再读一遍。两台 M5。再读一遍。两台 512GB、还没上市的 M5。这玩意儿在家里跑起来要 5 万美元。）

> "Closer to ~$30K if I had to guess. A 256 version is $11,299.00... 4 of those would be close to $50K but the 96->256 RAM upgrade is $4K..." — joshstrange [c:50107820]

> （我猜接近 3 万美元。256GB 版 11,299 美元……4 台加起来接近 5 万，但 96→256 的内存升级是 4,000 美元。）

> "The closest equivalent to something like that is a GB300 based workstation, those go from 90K and up." — jacquesm [c:50107950]

> （对标物是 GB300 工作站，9 万美元起步。）

也有人直接吐槽 Meta 工程师的薪资滤镜：「在一起拿 25 万年薪的人里待久了，你也会觉得两台 512GB M5 是可以放桌面上的东西。」也有人跑题到了 Apple Silicon 对比 NVIDIA 的核心问题——「你去哪儿找带 256/512GB 内存的 NVIDIA GPU？」这是大模型本地化绕不开的内存墙。官方没公布推理速度，但有实测口径流出——「差不多 20 tps」。

### 开源权重，但有限制

真正的争议在授权。Meta 自定义了一个「Muse Model License」带商业限制条款，并要求大型推理服务商单独联系 Meta 拿授权才能上线。这个条款组合让一部分人直接判定它不算开源。

> "The model license requires large inference providers to contact Meta separately to obtain a license to serve the model... The usual effect of separate licensing is decreased price competition from public providers (like we saw with Kimi K3)." — popinman322 [c:50107323]

> （这个授权要求大型推理服务商单独联系 Meta 才能拿许可上线模型……单独授权的常规效果就是公共提供商的定价竞争下降，比如 Kimi K3 那波就见识过了。）

> "Then it's not open-weight. Open-weight means 'weights available under an open-source license', and licenses prohibiting commercial use are not open-source." — isityettime [c:50107499]

> （那就不是开源权重。开源权重的定义是「权重在开源许可证下提供」，禁止商业使用的许可证不算开源。）

Kimi K3 事件是 HN 用户拿来类比的前例：单独授权导致价格由 Meta 决定，推理效率的提升直接变成厂商毛利而非终端降价。回帖里有人承认这对自己不一定是坏事——「我订阅的核心驱动力本来就是更贵模型的 token 成本」——但对「开源」这个标签的语义冲击是实的。

### Meta 会赢消费者 AI 吗

一条高赞长帖把这次发布解读成 Llama 战略的胜利：智能的「租金市场」从未真正形成，Meta 会用网络效应+模型标准化赢得消费 AI。这条帖子引爆了整轮争论。

> "I think zucks original llama thesis is proving more correct by the week. The rent market on intelligence never materialized... Meta is going to win consumer AI." — swalsh [c:50107247]

> （Zuck 当年的 Llama 命题一周比一周更对。智能的租金市场从来没真正形成……Meta 会拿下消费者 AI。）

反对者指出 Muse 才发布不到两周，「占着」这个判断来得太早。

> "Seriously. Muse hasn't even been around long enough to determine if it is 'sticky' in any meaningful way, let alone in the context of competing against frontier models from competitors." — nater5000 [c:50107610]

> （讲真。Muse 上线时间还不够长，根本没法判断它在任何有意义的层面上是否「占着」，更别说跟对手的前沿模型比了。）

支持方拿出实打实的装机量数据：Muse 已经是 iOS 下载榜第一，超过 ChatGPT、TikTok、Claude。HN 圈外不讨厌 Facebook 的人正在把它当主力助手用。

> "If you're outside of the HN bubble and don't hate Facebook, Muse is an absolute winner. It's currently the top downloaded app on iOS, above ChatGPT, TikTok, and Claude." — solyin [c:50108668]

> （如果你不在 HN 气泡里，也没那么恨 Facebook，Muse 是绝对的赢家。它现在是 iOS 下载榜第一，超过 ChatGPT、TikTok 和 Claude。）

另一条反对线直接质疑「占着」这个比喻——「AI 助手没有网络效应，你朋友都用 Muse 不代表你也得用 Muse」。最尖锐的反对意见把它解读成 Meta「先捕获通信，再捕获效用」的延伸：「你不再只是无脑刷信息流，你终于在做点有用的事，还能多待 8 小时。」当然也有人泼冷水：Muse 充其量是 OpenClaw 加 Meta 皮肤，谁都能做。

### Day-one 多推理引擎是工程诚意还是营销

正面的少数派意见提到 Meta 的工程诚意：Muse Spark Open 发布当天就跑通了从 Unsloth 到 MLX 的所有推理引擎。

> "They've done considerable effort in making sure this model can run on basically every model runner, from Unsloth to MLX." — armcat [c:50107063]

> （他们下了大力气确保模型能在几乎所有推理引擎上跑，从 Unsloth 到 MLX。）

> "There are plenty of smaller less powerful open weights models if all you have to run it on is an NPU. This is a much larger more powerful model, so running it locally will not be for everyone, but you can still run it via a hosting service such as Fireworks AI." — HarHarVeryFunny [c:50108679]

> （如果你只有 NPU，市面上小一点的开放权重模型多得是。这是更大更强的模型，本地跑不适合所有人，但你可以走 Fireworks AI 这类托管服务。）

侧支讨论里还有人追问 NPU 路线——「Copilot+ PC 那波 NPU 硬件去哪儿了」——得到的标准答复是 NPU 体量比 LLM 小两到三个数量级，根本不是同一个赛道的工具。这条讨论最终落到「桌面 LLM 的现实硬件选择」：要么 Apple Silicon 大内存，要么 NVIDIA 工作站。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 看好 Meta 拿下消费者 AI | swalsh [c:50107247] | Llama 战略一周比一周更对，Meta 会赢 |
| 质疑「占着」判断 | nater5000 [c:50107610] | Muse 上线不到两周，谈不上任何意义上的「占着」 |
| 看装机量说话 | solyin [c:50108668] | iOS 下载榜第一，超过 ChatGPT、TikTok、Claude |
| Meta 没有 OS 控制权 | threatofrain [c:50107351] | Google、Apple、Microsoft 是用户体验的守门人，Meta 没有这个位置 |
| 嘲讽 Meta 工程师视角 | sorenjan [c:50108192] | 「it's one banana, Michael」——年薪 25 万的人觉得两台 M5 Ultra 算便宜 |
| 授权条款不算开源 | isityettime [c:50107499] | 限制商业使用的许可证，按定义就不算开源权重 |
| Kimi K3 前车之鉴 | popinman322 [c:50107323] | 单独授权导致公开市场价格竞争被压制 |
| Anthropic 租金仍在 | nba456\_ [c:50107505] | 「租金市场没形成」站不住，Anthropic 营收爆涨就是反证 |
| AI 助手无网络效应 | casualscience [c:50108683] | 社交网络才有网络效应，AI 助手没有，你朋友用 Muse 跟你无关 |
| Dropbox FTP 反讽 | madars [c:50108752] | 经典 HN lore：你只要搞个 FTP 账号就能自己拼出 Muse |

## 总体情绪

帖子整体情绪偏冷静，但有几条对抗性的火线——「Meta 是否会赢消费者 AI」「这到底算不算开源权重」——反复拉锯。技术规格本身没什么争议：816B/42B MoE、100 万上下文、两台 M5 Ultra 跑得起来，这些数字被反复引用且没有明显质疑。

情绪真正分裂的是两件事。一是「开源权重」的语义：Meta 显然把「weights available」当开放权重，但带商业限制+单独授权的条款组合让一部分用户直接判定它不算开源——HN 对 Kimi K3 那波还有记忆，单独授权的结果是价格被锁住，效率提升变成厂商毛利。另一件事是 Meta 的战略叙事：支持方认为 Llama 战略正在兑现，Muse 的装机曲线证明了分发优势；反对方认为「占着」是营销叙事，AI 助手没有网络效应，Apple/Google/Microsoft 把守体验入口，Meta 没有 OS 控制权。

最值得注意的是那条反讽——「Meta 先捕获了你的通信，再来捕获你的效用。你不再只是无脑刷信息流，你终于在做有用的事，还能多待 8 小时。」它把整个讨论的潜台词挑明了：消费者 AI 的胜负不取决于模型 SOTA，而取决于谁能更彻底地占据用户的时间切片。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Muse Spark Open | <https://news.ycombinator.com/item?id=50107379> |

<div class="disclaimer">

本文由 AI 辅助整理自 Hacker News 讨论原文，不代表原作者观点。引文已尽量保留原文表达，翻译仅供参考。HN 评论可能包含个人意见，请按 ID 至原帖查阅上下文。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>