---
layout: post
title: >-
  Claude 解开 25 年 ECDSA 椭圆曲线 Seed 谜团：不是 NSA 阴谋，只是 1997 年的 Unix 时间戳
date: 2026-10-17
hn_id: 50122800
categories: [articles]
excerpt: >-
  Claude 在半小时内破译了 NIST P-256 等核心椭圆曲线 Seed 的生成机制，证实其仅为 1997 年 Unix 时间戳初始化的 C 语言 lrand48 随机数，彻底击碎了困扰密码学界 25 年的 NSA 后门阴谋论。
tagline: >-
  13 年的密码学阴谋论，原来只是 C 语言的 srand48(time(NULL))。
---

### 原文概要

2000 年，美国国家标准与技术研究院（NIST）在 FIPS 186-2 标准中正式采纳了 `ECDSA`（椭圆曲线数字签名算法），并列出了一系列标准椭圆曲线（如 `P-192`、`P-224`、`P-256`、`P-384`、`P-521` 等）。在这些规格说明中，曲线系数由一个 20 字节的 `seed` 参数哈希生成（例如 `P-256` 的 Seed 为 `C49D3608 86E70493 6A6678E1 139D26B7 819F7E90`）。然而，这些 Seed 当年由美国国家安全局（NSA）直接提供，却未附带任何关于其派生来源的解释，引发了密码学界长达 25 年的猜忌——很多人怀疑 NSA 在 Seed 中暗藏了特制的数学后门，以便随时破解全球的网络加密通信。社区甚至设立了 36,864 美元的破解悬赏奖金。

最流传的“官方传说”来自 NSA 资深密码学家 Jerry Solinas（已于 2023 年逝世）。他曾在 2015 年透露， Seed 是用类似于 “Give Bob and Jerry a raise”（给鲍勃和杰里加薪）这样的幽默短语通过哈希算法生成的。然而，后人针对此类短语进行了无数次穷举碰撞，始终一无所获，“幽默短语说”逐渐沦为悬案。

2026 年 10 月，Anthropic 的研究人员让内部研究模型 Claude 在没有任何提示的前提下尝试分析这一谜题。在不到半小时的时间里，Claude 彻底破译了 `P-192` 至 `P-521` 等 10 个核心素数曲线及 4 个二进制曲线 Seed 的生成全貌：它们根本不是任何复杂哈希算法或幽默短语的产物，而是 1990 年代 C 语言标准库中的伪随机数生成器 `lrand48()` 的输出，而初始化种子（`srand48`）恰恰就是 1997 年 5 月至 1998 年 4 月期间的 `Unix` 时间戳！

Claude 通过分析发现，旧版 C 语言随机数生成器的输出存在特定比特位模式（如高位清零）。利用 `LLL`（Lenstra–Lenstra–Lovász）格基规约算法，Claude 从截断的随机数状态中成功还原出了 48 比特的内部状态，并反向推导出了对应的 `Unix` 时间戳（如 `P-256` 对应 `1997-08-16 01:52:34` 的第 1842 次迭代）。不仅如此，Claude 还顺带解开了 `P-192` 等曲线基点 $G$ 的来源（来自 Arjen Lenstra 的 FreeLIP 大数库，种子为 `20000` 等小整数）。这一发现完全证实了 NIST 曲线的选型只是随手调用了当时最常见的 C 库时钟随机数，彻底排除了恶意构造后门的可能性。36,864 美元悬赏奖金将全数捐赠给互联网安全研究小组（ISRG）。

### 讨论焦点

#### 1. 困扰密码学界 25 年的“阴谋论”破灭与释怀

过去 20 多年中，无数关于 NSA 操控 NIST 曲线后门的论文、博客和阴谋论充斥着密码学社区。当揭晓答案居然只是简单的 `srand48(time(NULL))` 时，社区在震惊之余感受到了极大的讽刺与释怀。

> "This is devastating news... for an entire generation of NIST cryptography conspiracy theories." — tptacek [c:50123044]
> （译文）对于整整一代 NIST 密码学阴谋论者来说，这是一个令人绝望的消息。

> "13 years of tinfoil hats for srand48(time(NULL)" — sweis [c:50122897]
> （译文）戴了 13 年的防控制锡纸帽，最后发现只是 srand48(time(NULL))。

#### 2. 为什么 NIST 和 NSA 当年要对此保持沉默？

既然生成过程如此简单透明，为何 NIST 和 NSA 当时不直接公布时间戳，反而任由猜忌蔓延数十年？开发者们探讨了当时的时代背景与官僚体制的局限。

> "It’s perplexing that NIST chose to burn so much trust and goodwill with the independent cryptography community instead of just explaining empirically that they really had nothing up their sleeve." — nickysielicki [c:50123880]
> （译文）让人困惑的是，NIST 宁愿消耗掉与独立密码学社区之间的大量信任与好感，也不愿意实证性地解释他们其实根本没有玩任何猫腻。

> "This was the era of export cryptography, just after the Clipper Chip saga... I think people just weren't paying that much attention to cryptographic standards processes at all" — tptacek [c:50126993]
> （译文）那是出口密码学管制时期，刚经历完 Clipper 芯片事件……当时人们根本没怎么关注密码学标准制定流程。

> "I think they legitimately did not know. The person who worked on it directly, Jerry Solinas, did not remember and gave an explanation that turned out to be wrong." — sweis [c:50124125]
> （译文）我认为他们是真的不知道。直接经手人 Jerry Solinas 自己记错了，给出了错误的解释。

#### 3. Dual_EC_DRBG 的历史创伤与区块链信任重构

尽管这次证明了 `ECDSA` Seed 的清白，但社区普遍认为对 NSA 的警戒并非毫无根据——毕竟 NSA 确实曾借由 `Dual_EC_DRBG` 在椭圆曲线随机数生成器中植入过真正的后门。同时，区块链社区（如 Bitcoin 和 Ethereum）也看到了全面支持 `P-256` 曲线的曙光。

> "After Dual_EC_DRBG, there is no longer justification for any attitude towards the NSA other than suspicion and skepticism." — soulofmischief [c:50126439]
> （译文）在 Dual_EC_DRBG 事件之后，对待 NSA 除了怀疑和戒备之外，再没有任何合理的态度。

> "This is huge. It means the Bitcoin and Ethereum communities can now confidently ship the opcodes and precompiled contracts to check ECDSA signatures on P-256 in addition to K-256 curves" — EGreg [c:50123059]
> （译文）这太重大了。这意味着比特币和以太坊社区现在可以放心地发布操作码和预编译合约，在 K-256 之外支持 P-256 的 ECDSA 签名验证，不必再担心潜在的 NSA 后门。

### 典型观点一览

| 立场 | 用户 | 一句话观点 |
| --- | --- | --- |
| 历史讽刺 | `tptacek` | 这是对整整一代密码学阴谋论者的“沉重打击”。 |
| 社区解脱 | `sweis` | 戴了 13 年的防控制锡纸帽，最后发现只是 C 语言的 `srand48(time)`。 |
| 质疑沟通 | `nickysielicki` | NIST 宁可输掉整个社区的信任，也不愿公布真相，令人难以理解。 |
| 时代背景 | `tptacek` | 90 年代末处于出口加密管制和 Clipper 芯片余波中，当时根本没人重视标准化透明度。 |
| 警惕延续 | `soulofmischief` | 鉴于 `Dual_EC_DRBG` 的历史劣迹，保持对 NSA 的最高戒备依然是必要的。 |
| Web3 收益 | `EGreg` | 比特币和以太坊社区终于可以放心使用 `P-256` 预编译合约与操作码。 |

### 总体情绪

整个 Hacker News 讨论呈现出一种“惊叹、幽默与深刻反思交织”的氛围。一方面，社区对 Claude 在不到 30 分钟内运用 `LLL` 算法解决困扰顶级密码学家 25 年难题的技术突破感到震撼，这标志着 AI 模型在辅助密码分析和符号推演上的惊人潜力；另一方面，当大家发现笼罩在密码学界上空四分之一世纪的 NSA 后门阴霾，最终只是源于程序员随手写下的 `srand48(time(NULL))` 时，狂热的阴谋论瞬间被荒诞的现实击碎。

然而，这种释怀并未演变为对政府机构的盲目信任。经历过 `Dual_EC_DRBG` 真实后门事件的密码学社区依然保持着理性的审慎。这次成果最大的价值，不仅在于为 `P-256` 等广泛运用的加密标准洗清了嫌疑、为 Web3 基础设施消除了合规顾虑，更展示了在 AI 时代，依靠数学和算法工具实现“实证与透明”的力量。

### 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | Claude reveals ECDSA curve origins | https://news.ycombinator.com/item?id=50122800 |
| 2 | Anthropic Research Article | https://www.anthropic.com/research/ecdsa-curve-origins |

<div class="disclaimer">
  声明：本文由 AI 自动抓取 Hacker News 热门讨论并生成摘要，旨在帮助中文读者快速了解科技前沿与社区动态。讨论内容仅代表 HN 用户个人观点，不代表本站立场。
  <br><br><em>本摘要由 AI 模型辅助生成：google/gemini-3.5-flash</em>
</div>
