---
layout: post
title: >-
  小米 MiMo v2.6 发布 — HN 讨论摘要
date: 2026-09-22
hn_id: 49792730
categories: [articles]
excerpt: >-
  小米把 MoE 架构的 MiMo v2.6 (Flash 309B/15B 激活, Pro 1.02T/42B 激活) 挂上公网, 训练仪表盘同步直播。HN 焦点: 透明度能否撬动 OpenAI/Anthropic 的《减速》叙事, 工程效率能否填平算力差距。
tagline: >-
  小米把 1.02T MoE 和训练进度条一起挂公网, Anthropic 的《蒸馏论》当场失语。
---
## 原文概要

来源: [HN 热门榜](https://news.ycombinator.com/item?id=49792730) (612 分, 308 条评论)。

2026 年 9 月 21 日, 小米发布 MoE 架构的 MiMo v2.6。两个变体:

- **Flash**: 总参数 309B / 激活 15B ([HF: MiMo-V2.6-Flash-RL](https://huggingface.co/XiaomiMiMo/MiMo-V2.6-Flash-RL))
- **Pro**: 总参数 1.02T / 激活 42B ([HF: MiMo-V2.6-Pro-RL](https://huggingface.co/XiaomiMiMo/MiMo-V2.6-Pro-RL))

同时还有一个 [9B 蒸馏版](https://huggingface.co/XiaomiMiMo/MiMo-V2.6-Distill-Qwen-9B)——在 Qwen3.5-9B 上用 MiMo 自生成的数据 SFT 而来的 agentic 小模型。

这次的差异化卖点不在参数, 而在 [训练时挂出来的实时仪表盘](https://mimo.xiaomi.com/rl/)。仪表盘显示训练损失曲线、每个 checkpoint 的 benchmark 分数、运行成本估算, 还包括每次重启的原因和数据集调整记录: 比如团队曾因一个 cyber 数据集拖低编码 benchmark 而直接下架。技术报告里的方法论细节也异常详尽, 包括 on-policy RL、`partial/avg_staleness`、`train_infer_diff/new_infer/kl` 之类的训练工程指标。

MiMo 团队负责人是罗福莉, 此前在阿里和 DeepSeek 工作过。HN 上有人指出这与 DeepSeek 在技术路线和 GTM 上的相似性不是巧合。

## 讨论焦点

### 把训练过程当产品卖

最被点赞的不是模型本身, 而是训练时挂出来的实时仪表盘。

> "I know we have strong views on what a truly open model is (open weights, open training data, open training code etc.) but I really like how transparent they've been about the training of this model. The realtime dashboard they shared during training (https://mimo.xiaomi.com/rl/) was an incredible learning and teaching tool for me, and they've been unusually comprehensive in sharing details about their methodology (check out that tech report - it's got lots of clever behind the scene tricks like Google or Deepseek writeups) and benchmark scores (even the stuff they didn't do well on). If you're releasing an open model going forward, please consider offering the community more of this transparency!" — rao-v [c:49792998]
>
> （译文: 关于什么是真正开放的模型 (开放权重、开放训练数据、开放训练代码), 大家各有立场, 不过我真心喜欢小米这次对训练过程的透明度。他们训练时挂出来的实时仪表盘, 对我来说是绝佳的学习和教学工具, 方法论细节也异常详尽 (技术报告里有不少像 Google 或 DeepSeek 那种幕后技巧), benchmark 分数公开得很全 (包括表现不好的那些)。如果以后要发布开源模型, 请给社区更多这种透明度!）

被点赞的另一条支线, 把焦点从「做得有多透明」切到了「透明到什么程度」:

> "The best thing they did is being open about all the setbacks they had to deal with. They logged every restart with a reason, talked about dropping a cyber dataset after it degraded coding benchmarks. Also published real time training loss, benchmark scores after every checkpoint and running cost estimates. Really the only thing missing was dataset descriptions, the dashboard only had random IDs like 'dataset-zrso'. I guess it's their lawyers fault." — tancop [c:49793753]
>
> （译文: 他们做得最好的是把所有走过的弯路都摊开——每次重启都记了原因, 还专门讲了如何因一个 cyber 数据集拖累编码 benchmark 而下架, 同时实时发布训练损失、每个 checkpoint 的 benchmark 分数和运行成本估算。唯一缺的是数据集描述, 仪表盘上只有类似 'dataset-zrso' 的随机编号, 大概是法务不让说。）

有开发者把这份透明当产品样板, 顺手开了一个脑洞:

> "I was absolutely mind blown when I saw how they were publishing that training dashboard while US models publish 100s of pages of reports (just provide a 'copy as MD' button, folks, in the future). I was thinking about doing something similar but did not know how to show it, and this is a perfect example for someone who wants to show whatever they are training, for me it was local training on a consumer GPU. My dream is to see this like a dashboard for a model trained across distributed machines, like Bitcoin mining, where minted coins are given to people whose machines were used for training. I don't know if they are worth it, but bragging rights alone, like a tag they can put on a website or social media, will be good enough for me." — bicepjai [c:49796163]
>
> （译文: 看到他们挂训练仪表盘, 而美国模型只发上百页报告 (以后真该加个《复制为 MD》按钮), 我整个人都惊了。我本来也想做类似的事, 但不知道怎么呈现——我是在消费级 GPU 上做本地训练的, 这就是个完美范例。我的梦想是看到那种跨分布式机器训练的仪表盘, 类似于比特币挖矿, 把代币发给那些机器被征用来训练的人。我也不知道值不值, 光是炫耀权, 比如能在网站或社交媒体上挂个标签, 对我来说就够了。）

### 模型规格与蒸馏链

核心规格直接列出来:

> "Flash[1]: 309B total / 15B activated parameters. Pro [2]: 1.02T total / 42B activated parameters" — stymaar [c:49793035]
>
> （译文: Flash: 总参数 309B / 激活 15B。Pro: 总参数 1.02T / 激活 42B。）

9B 蒸馏版的来历:

> "It is a 9B agentic model developed by Xiaomi MiMo through supervised fine-tuning of Qwen3.5-9B on MiMo-generated data" — mydreamof [c:49793338]
>
> （译文: 这是一个 9B 的 agent 模型, 由小米 MiMo 用自家生成的数据对 Qwen3.5-9B 做监督微调而来。）

顺手甩到 Anthropic 脸上的, 是这条把「蒸馏论」架空的评论:

> "The RL dashboard is quite cool. I wonder if this waters down the 'distillation attack' claims by Anthropic. They have their own RL environments! I guess the caveat is that the RL datasets are still opaque, nothing is really proved." — aarondong [c:49795543]
>
> （译文: 这个 RL 仪表盘挺酷。倒想看看这会不会削弱 Anthropic 之前对《蒸馏攻击》的指控——他们自己也有 RL 环境! 当然, 缺点是 RL 数据集依然不透明, 所以什么都不能实锤。）

### 《减速》叙事的另一面

另一个高赞支线, 把 MiMo 透明度跟 OpenAI/Anthropic 最近的《减速》言论摆在一起。

> "maybe this is why Dario want to slow down AI development and all the big AI labs in the USA is singing the same song. whey they all singing the same tune. it make me question what is their real motives. they are afraid of Chinese good enough LLM model killing their margin. we already have story about US companies switch some task to use cheaper Chinese model hosted on Neoclouds." — MangoCoffee [c:49793866]
>
> （译文: 也许这就是为什么 Dario 想让 AI 发展慢下来, 美国那些大 AI 实验室全都在唱同一首歌。他们突然齐声, 让我不得不怀疑他们的真实动机——他们怕中国那些《够用就好》的模型蚕食他们的利润。我们已经看到美国公司把部分任务切到 Neocloud 上托管的更便宜的中国模型。）

> "Dario has always wanted the AI development to slow down and be more careful. Safer AI development was a core reason that Anthropic split off from OpenAI. What's different today is that now all the big LLM firms want to slow down AI development. When men like Musk and Altman (both known for habitually shooting their mouths off and saying whatever they need to whoever needs to hear it regardless of truth) suddenly agree with Amodei, that's when things start to smell off." — Pxtl [c:49794098]
>
> （译文: Dario 一直想让 AI 发展慢一点、谨慎一点——《更安全的 AI 开发》本来就是 Anthropic 从 OpenAI 独立出来的核心理由。跟以前不同的是, 现在所有大型 LLM 公司都想让 AI 发展慢下来。当 Musk 和 Altman (都出了名地嘴上没把门, 对谁都说对方想听的话, 不管真假) 突然跟 Amodei 站到一边, 那味道就不对了。）

直接点破这是《监管俘获》思路:

> "The general idea is that Anthropic/OpenAI is pushing this narrative as an attempt at 'Regulatory Capture'[1] which would allow them to make it prohibitively expensive for anyone but them to enter the market thus stifling competition." — rbjorklin [c:49794081]
>
> （译文: 大方向就是 Anthropic/OpenAI 在推《监管俘获》这套叙事, 想借此让市场进入门槛高到除了他们谁都进不来, 从而压制竞争。）

反对意见很直接——这套做法对中国本土模型其实无效:

> "it wouldn't slow down China as much as make it impossible for American companies to use non-American options, they care about their margins and don't want to be commoditized" — verdverm [c:49794146]
>
> （译文: 这套做法并不是要拖慢中国, 而是让美国公司没法用非美国模型——他们在意利润率, 不愿意被商品化。）

### 算力差距的两种叙事

也有读者认真算过中美实验室的真实算力差距, 结论是两派完全相反。

悲观测算 (Dwarkesh 节目嘉宾 Dylan Patel 的拆分):

> "In a recent Dwarkesh podcast Dylan Patel breaks down how little compute the chinese labs actually have- not even the fact that they don't have access to new Nvidia chips and they're stealing them through shell companies- just that, even if they have cheap electricity, the compute just doesn't compare. Maybe even two orders of magnitude less. They couldn't get it even if they had the money. And if you look at how much more efficient newer chips are, that cuts the effective compute in half again. The conclusion was that they are at least 2-3 years behind." — awongh [c:49795274]
>
> （译文: 最近一期 Dwarkesh 节目里, Dylan Patel 拆解了中国实验室实际拥有的算力——甚至不是没新 Nvidia 卡、靠空壳公司偷这种问题, 单纯就是算力不对等。即便电价便宜, 算力也完全没法比, 也许差两个数量级。他们有钱也买不到。再算上新芯片效率提升, 有效算力再砍一半。结论是至少落后 2-3 年。）

反驳者的乐观论点:

> "The counterpoint to that, though, is that the Chinese companies have to figure out how to be competitive, regardless of their significant compute deficit. And, as far as I can tell, they're actually doing that. They're trailing the frontiers in model effectiveness, but not by years. It's single digit months. If there is no upper bound how how these things scale with compute, and if China does really begin to catch up to Nvidia (and they're probably not going to feel encumbered by US patents for domestic AI hardware, given how important AI seems to be to the Chinese government), there will come a day when China leapfrogs the US on AI." — SwellJoe [c:49795595]
>
> （译文: 但反驳点在于, 中国公司不得不在算力严重不足的情况下找到竞争办法, 而且据我观察, 他们确实在这么做。他们的模型能力确实落后于前沿, 但不是以年计, 而是单月数。如果算力规模化没有理论上限, 而且中国真的开始追平 Nvidia (考虑到 AI 对中国政府有多重要, 他们大概率不会在意美国在本土 AI 硬件上的专利), 那总有一天中国会在 AI 上反超美国。）

### 工程师用脚投票

最后一条主轴, 是工程师为什么在真金白银地切。

> "This looks great in terms of cost and capabilities, truly pushing the frontier forward in terms of open weight light weight models." — ddxv [c:49792953]
>
> （译文: 从成本和能力看都很棒, 真正把开源轻量模型的前沿往前推了一步。）

中国 AI 市场的体量本身就在挑战《美国垄断》叙事:

> "1. China is a bigger market than the US for Ai, they are on pace to process 100Q tokens this year, roughly the same or more than the US big companies. 2. Enterprise trends are towards open weights, several routers and vendors now have more than half the volume going towards open weights" — verdverm [c:49794449]
>
> （译文: 一、中国 AI 市场比美国还大, 今年 token 处理量预计到 100Q, 跟美国大公司差不多甚至更多。二、企业趋势在朝开放权重走, 不少 router 和 vendor 现在一半以上流量都跑在开放权重模型上。）

最后一位开发者算了一笔账, 把"为什么转"压成一行:

> "Show them you can burn tokens in seven sessions day and night with comparable results to Opus with less energy and less than 10 dollars a day, per dev." — pimeys [c:49794495]
>
> （译文: 你只要让他们看到, 一个人每天连开七个 session, 烧 token 烧到天亮, 效果跟 Opus 差不多, 每天还花不到 10 美元, 用电也少。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 透明度是核心差异化 | `rao-v` [c:49792998] | 训练仪表盘比模型本身更值得抄 |
| 透明度也是合规残片 | `tancop` [c:49793753] | 唯一缺的是数据集描述, 大概是法务不让说 |
| 透明度样板应该产品化 | `bicepjai` [c:49796163] | 哪天分布式训练也能挂个仪表盘 |
| 蒸馏指控被小米仪表盘削弱 | `aarondong` [c:49795543] | Anthropic 自己也有 RL 环境, 凭什么指控中国蒸馏 |
| 减速是利润焦虑 | `MangoCoffee` [c:49793866] | 中国《够用》模型在蚕食美国利润 |
| 减速是叙事共谋 | `Pxtl` [c:49794098] | Musk 和 Altman 突然跟 Amodei 站一边, 味道不对 |
| 减速是监管俘获 | `rbjorklin` [c:49794081] | 提高门槛, 让别人进不来 |
| 监管对中国本土无效 | `verdverm` [c:49794146] | 只锁美国市场, 锁不住中国 |
| 算力差距是真的 | `awongh` [c:49795274] | 中国实验室算力差两个数量级, 落后 2-3 年 |
| 算力差距会追平 | `SwellJoe` [c:49795595] | 差距不是以年计, 是单月数 |
| 开源模型在企业落地 | `verdverm` [c:49794449] | 不少 router 一半流量跑开放权重 |
| 工程师转投中国模型 | `pimeys` [c:49794495] | 一天烧 7 session, 效果比肩 Opus, 不到 $10 |

## 总体情绪

讨论分两条主线: 一条在夸《训练仪表盘》, 一条在把这件事绑到 OpenAI/Anthropic 的《减速论》上。中间夹着对中国实验室真实算力的辩论——乐观派和悲观派引同一期 Dwarkesh 节目得出相反结论。

工程师用脚投票的部分最不废话: 真金白银切到中国模型的理由只有两个, 成本和效果门槛已经被打穿。HN 上没人再讨论《中国模型能不能用》, 只剩《什么时候切》和《切哪个》——这是和之前几轮《蒸馏论》热点的最大区别。

实时仪表盘被当成产品这件事, 可能是这次发版最被低估的影响。它顺手把 Anthropic 那套《蒸馏攻击》叙事抽掉了底座——你公开训练过程, 别人就很难再说你的数据来源不干净。如果开源阵营以后都把训练过程当产品卖, 《我们保密》就不再是默认选项。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Xiaomi MiMo v2.6 (612 分, 308 条评论) | https://news.ycombinator.com/item?id=49792730 |

## 免责声明

本文为 HN 热门话题摘要, 仅基于讨论原文整理, 不代表本站立场。引文为评论者个人观点, 与小米官方或 HN 平台无关。

<div class="disclaimer">

本摘要由 AI 模型辅助生成: minimax-cn-coding-plan/MiniMax-M3

</div>