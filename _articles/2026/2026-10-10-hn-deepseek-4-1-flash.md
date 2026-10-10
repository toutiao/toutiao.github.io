---
layout: post
title: >-
  DeepSeek 4.1 Flash 和那条被遗忘的 437 倍 — HN 讨论摘要
date: 2026-10-10
hn_id: 50000488
categories: [articles]
excerpt: >-
  KV 缓存比 V1 缩了 437 倍、$10/月 OpenCode Go 订阅近乎无限——但评论区很少在聊模型本身。
tagline: >-
  VRAM 一千六百 GB 的算术题，是谁在评论区做完又拆完。
---

## 原文概要

> 来源：HN 热门榜 (/best)

文章作者自称已经重度使用 DeepSeek 4.1 Flash 一个月，跨十多个项目，并称"不告诉我模型名我分不出是 DeepSeek 还是 Opus"——会话质量、出活速度、响应节奏都没有显著差别。他不关心 DeepSeek 没有 4.1 "Pro"，因为 Flash 的表现已经够"前沿海平线"。结论是：中国厂商可能比 Anthropic、OpenAI 落后一两个月，但这些"蒸馏"出来的中国模型能处理同样的工作负载。

核心论据有两条。第一，KV 缓存比 DeepSeek V1 缩小约 437 倍。KV 缓存是把长会话上下文驻在显存里的开销大户，把它做小是长编程会话单日成本可以压在 1 美元以下的关键——作者认为自己全天跑下来"很少超过 1 美元预期成本"。作者同时把功劳分给 Opus 5.5：那次"悄悄的效率提升"也是同一条路线。第二，作者手里有 OpenCode Go 的 10 美元/月订阅，DeepSeek 在这套订阅下"基本上无限"，让他敢于开原本会被 Anthropic 计费吓退的"无脑任务"——比如让模型整理桌面文件只花 0.003 美元而不是 1 美元。

收尾里，作者把这一代开源/开放权重的中国模型比作"原研药 vs 仿制药"——药不是一一对应，但 90% 价格砍下来也够用。结论：这些 cache 优化马上会跑在本地；想自托管省钱是省不回来的，想自托管是隐私问题；中国公司在玩另一套规则，前沿厂商的整套商业模式要重写。

## 讨论焦点

### "紧张个啥？" — 对警报论的早期反问

> "Why would we freak out? The systems we use have always gotten better, faster, cheaper with time" — verdverm [c:50001187]

> （译文："紧张个啥？我们用的系统本来就一直在变得更好、更快、更便宜。"）

> "Because GLM 5.3 Flash is even cheaper?" — booi [c:50011024]

> （译文："那 GLM 5.3 Flash 不是更便宜吗？"）

> "Nah fam, not true, also DS edges it out on coding / dev tasks." — ActionHank [c:50011243]

> （译文："不对，老兄，而且在编码和开发任务上 DS 还略胜一筹。"）

文章标题是"业界为什么不紧张"，但 top-level 评论里冒出来的第一个反问就直接质疑"紧张"本身的合理性：技术系统本来就在变便宜，这一波只是常规迭代。还有人直接把讨论拉回具体比较——更便宜的替代品（GLM 5.3 Flash）已经在那里，作者漏掉了。原帖的支持者马上反驳：在编码任务上 DeepSeek 确实更胜一筹，便宜不是唯一维度。

### VRAM 算术题：一千六百 GB 是怎么来的

> "Call me crazy but: VRAM & Memory Requirements by Precision. FP16 (Full Precision): Requires ~1,664 GB of VRAM (e.g., an 8x B300 288GB cluster). INT8 Quantization: Requires ~832 GB of VRAM (e.g., 8x H200 141GB). INT4 Quantization: Requires ~416 GB of VRAM (e.g., 8x A100 80GB). VRAM aint cheap, Sam Altman ruined the cost of memory, Nvidia doesnt make enough consumer GPUs letting the market go insane over them, I still have friends on 1070s or 1070 TIs because GPUs have been severely overpriced for too long. I remember when a gaming PC was only $1000. Even so why would anyone not sleep on a model they cannot run?" — giancarlostoro [c:50011021]

> （译文："可能我疯了，但 FP16 要 1664 GB VRAM，INT8 量化 832 GB，INT4 量化 416 GB。VRAM 不便宜，Sam Altman 毁了内存成本，Nvidia 又不放出足够多的消费级 GPU 让市场降温，我还有朋友在用 1070、1070 Ti，因为 GPU 已经高价好多年。我记得过去一台游戏 PC 才 1000 美元。但话说回来，一个跑不动的模型，有什么好失眠的呢？"）

> "Are you counting the n-gram/PLE as part of the model weights there? They can go in host memory. Would be good to show your working. Also the released weights are pre-quantised and presumably QATed, so your 'Full Precision' and INT8 are simply not a version of the model that actually exists. Edit: I went and checked for you. The LM backbone is 307.2 GB (286.1 GiB), straight from DeepSeek's upload. The n-gram table is 203.1 GB (189.1 GiB), which goes in host RAM." — wren6991 [c:50012676]

> （译文："你把 n-gram/PLE 表也算进权重里了？它们可以放在主机内存。建议你给个推算过程。再说 DeepSeek 发出来的权重本来就是预量化的（QAT），所以你那个'FP16'和'INT8'根本不是这个模型真实存在的版本。我去查了一下：LM 主干是 307.2 GB（286.1 GiB），n-gram 表 203.1 GB（189.1 GiB）放主机内存。"）

> "DeepSeek V4.1 Flash is mixed MXFP4/MXFP8 so all but the INT4 calculation is wrong here and that's still wrong because you can run it on < 400GB VRAM. The n-gram table is MXFP8, but can be offloaded to RAM or disk without too much of a performance hit. Really, you could probably cram it onto < 300GB VRAM if you're willing to apply a small quant to certain parts of the model considering how little VRAM is dedicated to kv cache." — lisplist [c:50015129]

> （译文："DeepSeek V4.1 Flash 是 MXFP4/MXFP8 混合精度，所以除了 INT4 那个以外全算错了——INT4 那个也错，因为 <400 GB VRAM 就能跑。n-gram 表是 MXFP8，可以卸载到内存或磁盘，性能损失不大。如果对模型某些部分做小幅量化，<300 GB VRAM 应该能塞下，因为分给 KV 缓存的 VRAM 极少。"）

> "In nvfp4, it's about 300 gigs once you offload n-grams, 491 without offloading, you can run it pretty well on 4x DGX Sparks, which last I checked was about $20k. So, it's definitely runnable." — ericd [c:50015167]

> （译文："NVFP4 下，卸掉 n-gram 大约 300 GB，不卸 491 GB；4 张 DGX Spark 大约 2 万美元就能跑得不错。所以它绝对不是跑不动。"）

原帖的"1664 / 832 / 416"那张表一上来就被几路回帖拆穿——他们从 DeepSeek 实际发布的权重文件倒推：LM 主干 307 GB，n-gram 表 203 GB 但可以扔到主机内存，加上预量化、KV 缓存压缩这些工程现实，真实数字更接近"300 GB NVFP4 跑得动"或者"4 张 DGX Spark 2 万美元"。讨论的真正分歧不在"它有多大"，而在"到底用什么精度 + 什么设备 + 接受多大性能损失"，参数取一组就有一个答案。

### 内存价格："政治谁来管管"

> "Seriously, if a single politician stepped forward and said 'i'll bring down ram prices' they could then shoot a puppy and call me a slur and I'd still go out and doorknock for them. Memory companies have price fixed multiple times. They've paid hundreds of millions in fines. wikipedia even has a page on it." — kristopolous [c:50011194]

> （译文："说真的，哪个政治家敢站出来说'我把内存价格打下来'，他哪怕当面开枪打死一只小狗、骂我一句脏话，我都愿意去帮他挨家挨户敲门。内存公司被多次抓到操纵价格，罚了几亿美元，维基百科都有专页。"）

> "Micron has 3 brand new fabs currently under construction, 2 Boise, 1 in New York as the first of 4 planned for a campus. Plus expanding other existing facilities. These things take ~3-5 years from breaking ground to full production. You'd have had to anticipate the current demand years before it happened in order to be bringing production on-line before 2030 or so." — phil21 [c:50011549]

> （译文："Micron 现在有 3 座新工厂在建，2 座在 Boise，1 座在纽约（整个园区规划 4 座中的一座），同时还在扩建老厂。从破土到满产要 3-5 年。要让产能在 2030 年之前上线，几年前就得预判今天的需求。"）

> "This 'blame sama for memory prices' meme is so tired. He gave demand signal so many times years ago and was mocked for it and now we have the consequences of industry not taking him seriously." — jauer [c:50012389]

> （译文："'怪 Sam'这个梗真的用烂了。他几年前就反复给过需求信号，那时大家还嘲笑他，现在整个产业没把他的话当回事，代价就来了。"）

原帖没打算谈内存价格，但评论区被一句"VRAM 不便宜"瞬间拉到政治经济学。一边是用户的怨气（"哪个政治家敢管我就投他"），另一边是产业界常识（晶圆厂从破土到满产要 3-5 年）。中间派则把锅推回 Altman——他早就警告过，大家没听。

### "本地跑得动"是不是被高估了

> "Projects like DwarfStar really lower the hardware bar a lot so Deepseek 4.1 flash and other mixture of expert models can run on consumer hardware. There are also other inference providers who make their money serving openweight models. Services like OpenRouter make it all too easy to utilize these models. Access to these models isn't hard. The hardware moat is becoming pretty easy to bridge." — mrinterweb [c:50012474]

> （译文："DwarfStar 这类项目把硬件门槛拉低了一大截，DeepSeek 4.1 Flash 等 MoE 模型已经能在消费级硬件上跑。还有专门的推理服务商靠跑开放权重模型赚钱，OpenRouter 之类让这些模型调用起来毫不费力。硬件护城河没以前那么高。"）

> "DwarfStar M5 128GB Deepseek 4.1 flash 1K tokens @ 29s, 5K tokens + reasoning @ 147s, 10k token prompt @ 463 tokens/s = 22s. Hardware buy-in USD$7K / AUD$8.5K / EUR€6.8K. At typical workloads, ROI is still poor vs. current-era subsidies, but owning hardware is good for privacy/longevity/connectivity independence." — contingencies [c:50012858]

> （译文："DwarfStar M5 128GB：DeepSeek 4.1 Flash 1K token 29 秒，5K token 加推理 147 秒，10K token 输入 463 token/s 即 22 秒。硬件投入 7000 美元 / 8500 澳元 / 6800 欧元。普通工作负载下 ROI 仍然比不上现在的云补贴，但自己拥有硬件在隐私、长寿、断网独立性上更稳。"）

> "Still gonna take 2-3 years to get DeepSeek V4.1 Flash quality at decent speeds on reasonably priced hardware. Hardware update cycles are 2-3 years even on the high end, so it's still a ways away before 'good enough' and 'local' belong in the same sentence for the average person." — onlyrealcuzzo [c:50012931]

> （译文："还要 2-3 年才能在合理价格的硬件上以可接受的速度跑 DeepSeek V4.1 Flash 这个级别。硬件更新周期本来就 2-3 年，所以对普通用户来说，'够用'和'本地'还得再等几年才能写进同一句话。"）

作者把"Cache Magic 即将跑在本地"作为结尾，但评论区把"本地跑得动"这件事拆成了三档：跑得动（7000 美元 DwarfStar）、跑得快（4 张 DGX Spark，2 万美元）、普通人跑得动（再等 2-3 年硬件周期）。这条讨论没结论，但把"自托管"这个口号拆得很细——便宜、能用、ROI 不亏——这三个标准目前只能挑一两个满足。

### 真正值得紧张的反而是隔壁

> "Having Flash Next local at 150 t/s with 250k context is a joy. It's as good as Sonnet 5. It will spaz out but it was less eager compared to DS Flash 4.1. Both are good but I find I prefer Flash Next. This and Qwen 27B are the models people should be freaking out about." — bitexploder [c:50016831]

> （译文："Flash Next 本地跑 150 token/s、25 万上下文，真爽。质量不输 Sonnet 5。它偶尔会抽风，但比 DS Flash 4.1 不那么爱主动加戏。两款都好，但我更喜欢 Flash Next。这个和 Qwen 27B 才是大家应该紧张的对象。"）

> "what they should freak out about is qwen 3.8 github.com/Niko1221/Strata, it rips with just 64 ram and a 9070xt" — nicman23 [c:50016536]

> （译文："真正该紧张的是 Qwen 3.8（github.com/Niko1221/Strata），64 GB 内存加一张 9070 XT 就能狂飙。"）

> "Look at commandcode.ai/pricing, you can have very decent volume of requests with deepseek flash v4.1 for literally $1/month" — dgellow [c:50018756]

> （译文："看看 commandcode.ai/pricing，每月 1 美元就能拿 DeepSeek Flash v4.1 跑相当可观的调用量。"）

不少回帖把"前沿海平线该紧张"的真问题指向别处：Flash Next（Qwen 3.8 Strata）在 9070 XT 加 64 GB 内存上跑得起来，CommandCode 上 DeepSeek Flash V4.1 月费 1 美元。如果"价格逼近免费 + 质量逼近前沿海平线 + 还能本地跑"在 2026 年 10 月同时成立，作者担心的不是 DeepSeek 4.1 Flash，而是它身后那一群更便宜、更紧凑、更能在玩家硬件上跑的后继者。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 别紧张 | verdverm | 系统本来就一直在变便宜 |
| 真正的替代品更便宜 | booi, ActionHank | GLM 5.3 Flash 更便宜，但 DS 在编码任务上仍胜一筹 |
| 1664 GB 算错了 | wren6991, lisplist, ericd | 真实权重更小，n-gram 可卸载，300 GB NVFP4 即可 |
| 内存价格是政治问题 | kristopolous, phil21, jauer | 厂家价格操纵 + Altman 早警告过 |
| 自托管门槛在下降 | mrinterweb, contingencies | DwarfStar 7000 美元，但 ROI 仍差 |
| "本地"还要 2-3 年 | onlyrealcuzzo | 普通用户还得等一个硬件周期 |
| 真正该紧张的是其他模型 | bitexploder, nicman23, dgellow | Flash Next / Qwen 3.8 Strata / 1 美元月费 |

## 总体情绪

评论区对作者"业界为什么不紧张"这道题的回应，几乎全部回避了题目本身，而是绕到题目底下的三个子问题：模型到底有多大（VRAM 算术题）、自托管是不是真的便宜（7000 美元 DwarfStar vs 15 美元/月订阅）、以及真正便宜的模型（Flash Next / Qwen 3.8 Strata）已经站在门口。

讨论最有信息密度的不是辩论"紧张不紧张"，而是几个工程现实被打通：DeepSeek 4.1 Flash 是 MXFP4/MXFP8 混合精度的预量化权重，n-gram 表可卸到主机内存，KV 缓存的 437 倍压缩是真功夫但需要推理引擎配合。这些具体数字让"1664 GB"这种粗略估算被现场拆掉，结论反而比原帖更乐观——4 张 DGX Spark 2 万美元就够。

最后压轴的反讽是：作者呼吁大家紧张 DeepSeek 4.1 Flash，但评论区里推荐"真正该紧张"的候选人是 Flash Next、Qwen 3.8 Strata 和 1 美元月费。一年后回头看，2026 年 10 月的 DeepSeek 4.1 Flash 可能反而是这一波里"贵的那一档"。原研药仿制药的比喻没过保质期，但仿制药里更便宜的那几片，可能才是真正的价格破坏者。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Why isn't the industry freaking out about DeepSeek 4.1 Flash? | https://www.dgt.is/blog/2026-10-07-deepseek-freek-out/ |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50000488 |

## 免责声明

<div class="disclaimer">本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。</div>

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
