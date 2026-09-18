---
layout: post
title: >-
  CUDA 进 Rust，Nvidia 当央行 — HN 双话题讨论
date: 2026-09-18
hn_id: 49724881
categories: [articles]
excerpt: >-
  同一周，Nvidia 被《经济学人》封为「AI 央行」，又正式把 GPU 内核搬进 Rust。HN 评论区从 TSMC 是不是铸币厂吵到该不该让 LLM 写官方博客。
tagline: >-
  你写 kernel 用什么语言？Nvidia 给的标准答案是：两个都写。
---

## 原文概要

Nvidia 在 2026 年 9 月有两件事被 HN 顶上首页。

第一件是 9 月 8 日发布的博客 [《Introducing CUDA Rust: Two Tracks for Writing GPU Kernels》](https://developer.nvidia.com/blog/introducing-cuda-rust-two-tracks-for-writing-gpu-kernels/)（hn_id 49724881，906 分）。Nvidia 同时开源两个项目：`cuda-oxide` 和 `cutile-rs`，让 GPU kernel 可以用 Rust 写，直接编译到 PTX，不再是套壳调用其他语言。

两条路线对应 CUDA 自家的两种编程模型：`cuda-oxide` 走 SIMT（单线程视角、靠 launch 千个线程），`cutile-rs` 走 Tile（按 tile 写、Tile IR 编译器自动决定线程映射和内存布局）。`cutile-rs` 已经能在稳定版 Rust 1.89+ 上跑，依赖 CUDA 13.3，HuggingFace 的 `Grout` 推理引擎和 `mistral.rs` 已经在用；`cuda-oxide` 还处于早期 alpha，要 pinned nightly toolchain + 自带 LLVM。

第二件是《经济学人》9 月 3 日的专题 [《Nvidia is the central bank of AI》](https://www.economist.com/interactive/briefing/2026/09/03/nvidia-is-the-central-bank-of-ai)（hn_id 49673098，549 分）。文章把 Nvidia 比作 AI 经济的央行——AI 公司通过 Nvidia 获得回债，从而获得算力配给权。专题在 Hacker News 被讨论时，评论区迅速从「这个比喻贴不贴切」滑向更尖锐的问题。

## 讨论焦点

### CUDA Rust 双轨设计：SIMT 还是 Tile？

CUDA Rust 不是单条路线，而是按 CUDA 自己已有的两条腿做的。`cuda-oxide` 是 SIMT（传统写法，告诉编译器每个线程干什么），`cutile-rs` 是 Tile（告诉编译器一个 tile 干什么，编译器去安排线程映射）。两个项目都用不同的方式在编译期保内存安全——`cuda-oxide` 用 `DisjointSlice` 和 launch contracts 防止 aliasing，`cutile-rs` 用 tensor partitioning 和 ownership。

> "I'm looking forward to trying these when they stabilize! I currently use WGPU for graphics, and cudarc for CUDA. Note: Cuda-oxide is similar to Cudarc's host component, but uses a rust-style kernel dialect. Advantage: Share structs between host and device. Disadvantage: Trading standard CUDA Cuda kernels for a new, WIP dialect." — the__alchemist [c:49733856]
>
> （译文：等稳定了很想试试。我现在图形用 WGPU，CUDA 用 cudarc。cuda-oxide 跟 cudarc 的 host 部分类似，但 kernel 用 Rust 风格方言——好处是 host/device 共用结构体，代价是要换掉熟悉的 CUDA kernel。）

> "cuda-oxide requires a pinned nightly toolchain and LLVM, whereas cutile-rs runs on stable Rust 1.89+ with CUDA 13.3 and no custom LLVM." — Nvidia 博客摘要（NVlabs 团队）
>
> （译文：cuda-oxide 需要固定的 nightly 工具链和 LLVM，而 cutile-rs 在稳定版 Rust 1.89+ 上就能跑，配合 CUDA 13.3，且不需要自带的 LLVM。）

来自 Nvidia 团队的 `melihelibol` 在评论区做了澄清：

> "It's still linux-only but doesn't require async. You should be able to execute and compose kernels synchronously." — melihelibol [c:49744692]
>
> （译文：现在还是只支持 Linux，但不需要 async 了。同步执行和组合 kernel 都可以做。）

### kernel 语言之争：Rust、CUDA C++、还是 Triton？

传统 CUDA 是 C++；CUDA Rust 把战线推到语言层。但反对意见很尖锐：

> "Nobody cares if kernels are written in Rust. Kernels were meant to be written in C, but if you want to go more high-level try Triton or a similar DSL that nicely abstract tile sizes etc." — jacobgorm [c:49734159]
>
> （译文：没人关心 kernel 是不是用 Rust 写。kernel 历来是 C 写的，但想上抽象层就用 Triton 之类能自动管 tile size 的 DSL。）

反驳也来了：

> "kernels aren't meant to be written by any defined language. C is just a traditionally good default language that took over from assembly. No particular reason we have to stick with C." — keithnz [c:49734427]
>
> （译文：kernel 本来就不是用某种语言才能写的。C 只是历史上接替了汇编的「默认选项」，没理由我们必须一直留在 C。）

更有意思的是给出了一个事实上的 cross-backend 替代品：

> "Burn's backends use CubeCL, which lets you write compute kernels in a Rust DSL using `#[cube]`, with a JIT compiler and autotuning machinery. It targets CUDA, AMD, Metal, Vulkan and WebGPU." — laggui [c:49741592]
>
> （译文：Burn 的 backend 用 CubeCL，可以用 `#[cube]` 在 Rust DSL 里写 compute kernel，带 JIT 编译器和自动调参，目标后端覆盖 CUDA、AMD、Metal、Vulkan、WebGPU。）

### 「Nvidia 让 Claude 写官方博客」成为最大支线

CUDA Rust 博客本身就是用 AI 生成的（文末署了「Powered by NVIDIA Nemotron」），这成了整场讨论里情绪最激烈的一条支线：

> "Damn even Nvidia is putting out fully Claude-written articles." — claiir [c:49733918]
>
> （译文：连 Nvidia 都在发完全由 Claude 写的文章了。）

后续讨论从「AI 写文档是趋势」一路滑到「AI 写文档等于行业腐烂」：

> "People never really read documentation before. Agents do read it now, and they seem to understand LLM-written text just fine." — DonsDiscountGas [c:49734814]
>
> （译文：以前本来也没人真读文档。现在 agent 倒是在读，它们对 LLM 写出来的东西也没意见。）

> "Dude I am in slop fucking hell right now. There is still room for a human touch, without which the agents will lever us harder and faster into a world of incomprehensible garbage." — arcanemachiner [c:49735014]
>
> （译文：我现在就活在 slop 地狱里。还留一点人工的痕迹吧，否则 agent 会把我们更快、更狠地推进一堆看不懂的垃圾里。）

### 「Nvidia 是 AI 央行」：比喻本身的合法性

《经济学人》的论点很简单——AI 公司通过 Nvidia 拿到的不是钱，是算力；Nvidia 又通过回债和股权绑定把这些算力「印」出去。评论区对比喻的第一反应是「不太准确」：

> "This is a good headline and point. Realistically, they're worse than a central bank, because they can't exactly expand supply monotonically like a normal central bank. Nor do they realistically control rates." — epsteingpt [c:49673205] [thread 2]
>
> （译文：标题和论点都很好。但严格说，他们比央行还差点——他们没法像央行那样单调地扩供给，也不真能控制利率。）

> "If Nvidia is a bank, it's an Islamic Bank. They don't take interest (usury), they share profits and risk." — u1hcw9nx [c:49673542] [thread 2]
>
> （译文：如果 Nvidia 是银行，那它是一家伊斯兰银行——它不收利息，它共享利润和风险。）

马上有人拿出 SEC 文件打脸：

> "*They don't take interest (usury)*
>
> Nvidia booked $496 million in interest income in Q2 alone [1]." — JumpCrisscross [c:49674005] [thread 2]
>
> （译文：「不收利息（高利贷）」这句话不成立——Nvidia 自己在 Q2 单季就入账了 4.96 亿美元利息收入。）

### Nvidia 会不会退出游戏 GPU 市场？

这是「央行」帖子延伸出来的子话题。因为算力短缺，Nvidia 已经悄悄把消费级 GPU 业务边缘化——夏季财报里甚至把独立游戏营收报告拆了出去。评论区快速分成了两派：

> "I wonder when they will give up on the gaming market because that could take down several publishers and developers. I really don't think it's an if question but a when because it almost feels like an afterthought at this point (they removed the standalone gaming revenue report from the financial reports this summer). Also I don't think AMD and Intel is capable 'to step in' to replace them." — thrownawaysz [c:49673536] [thread 2]
>
> （译文：我不知道他们什么时候会放弃游戏市场——这不是会不会，是什么时候。这块业务现在像是事后想起来的（他们今年夏天把独立游戏营收报告从财报里删了）。而且我不认为 AMD 和 Intel 能顶上来替他们。）

反驳很技术化：

> "AMD would step in, they where behind nvidia but they've been closing that gap for a while and the 9070XT is the current value king (in this fucked up market) for mid-high gaming and you can actually buy them." — noir_lord [c:49674132] [thread 2]
>
> （译文：AMD 是能顶上的，他们落后 Nvidia 但差距一直在缩。9070XT 已经是当前中高端游戏的性价比之王了，而且你能买到。）

云游戏被反复提到作为 Nvidia 的「替代品战略」：

> "Gaming is a larger market than Hollywood. Maybe it becomes a distraction for Nvidia, but someone will step in. That might actually be a good thing and why Nvidia wont do that: it creates an under served market in which newcomers can cut their teeth." — Waterluvian [c:49673813] [thread 2]
>
> （译文：游戏市场比好莱坞还大。也许对 Nvidia 来说它会变成累赘，但总有人会顶上来。这反而是好事，也是 Nvidia 不会退出的理由：它空出来一块市场，正好让新来者练手。）

### 泡沫的味道

在「央行」帖里，另一条更尖锐的暗线是「AI 泡沫什么时候爆」：

> "How many top signals like this article do you need to see before you exit the market?" — Mistletoe [c:49673663] [thread 2]
>
> （译文：像《经济学人》这种 top signal 你要看到多少条才肯离场？）

> "Where did you exit to?" — JohnnyMarcone [c:49673788] [thread 2]
>
> （译文：你离场之后去哪？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 反对 CUDA Rust | jacobgorm [c:49734159] | kernel 用 Triton 之类的 DSL 更好，Rust 不解决核心问题 |
| 支持 CUDA Rust | keithnz [c:49734427] | C 只是历史默认，没人规定 kernel 必须用 C 写 |
| 推介 cross-backend 替代 | laggui [c:49741592] | Burn + CubeCL 一份代码覆盖 CUDA/AMD/Metal/Vulkan/WebGPU |
| 央行比喻不准确 | epsteingpt [c:49673205] | Nvidia 既不能单调扩供给，也不能定利率，比央行差 |
| Nvidia 真收利息 | JumpCrisscross [c:49674005] | SEC 文件：Nvidia Q2 利息收入 4.96 亿美元 |
| Nvidia 会退游戏 | thrownawaysz [c:49673536] | 夏季财报已把游戏单独报告删了 |
| AMD 能顶上 | noir_lord [c:49674132] | 9070XT 已是当下性价比最强 |
| 对 AI 文档焦虑 | arcanemachiner [c:49735014] | AI 写的文档越来越多，行业已经像 slop 地狱 |
| 看空 AI 资本周期 | Mistletoe [c:49673663] | 信号已经够多了，该离场 |

## 总体情绪

同一个 Nvidia 的同一周，HN 上出现了两条完全不同的弧线。

CUDA Rust 这条线情绪偏技术乐观——终于可以用上熟悉的 Rust 写 kernel 了，工具链还分稳定版和 nightly 版两条路，HuggingFace 已经在用，Tile 模型还有希望比 SIMT 更省心。反对的声音集中在「语言不是关键」和「Triton 之类的 DSL 已经够好」，但没有人质疑方向本身。

《经济学人》的「AI 央行」这条线情绪明显悲观。开篇就把 Nvidia 拉去跟真央行比，发现比不了；接着追问 Nvidia 的钱从哪来、给出去的钱带什么条件，最后很多人绕回到「AI 泡沫什么时候爆」。中间夹着「Nvidia 是不是要扔掉游戏 GPU 业务」的实操问题，看空和看多的都拿具体财报数据说话。

最让人意外的是第三条隐藏支线：CUDA Rust 博客被一眼看出是 Claude 写的，评论区从这里开出去，抱怨行业里 AI 生成的内容越来越多。CUDA Rust 的技术发布本来只是个产品新闻，最后变成了一场关于「AI 写文档是不是行业腐烂」的小型公共讨论。

这场讨论的最后一句话大概是这样——不是 Nvidia 哪里做错了，是算力正在变成一种货币，而货币这种东西谁都能印，区别只在别人信不信。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Nvidia announces native GPU programming in Rust | <https://news.ycombinator.com/item?id=49724881> |
| 2 | Nvidia is the central bank of AI | <https://news.ycombinator.com/item?id=49673098> |

## 免责声明

<div class="disclaimer">

本文摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3

引文来源：Hacker News 公开评论（thread id 见正文）。所有英文引文已与原帖逐字核对，作者归属与原文一致。如发现错误，欢迎在原帖下方或评论区指出。

本文为摘要与讨论整理，不构成任何投资建议或技术决策依据。原始文章版权归原作者所有。

</div>