---
layout: post
title: >-
  Android 17 把新 API 锁给 Pixel — 自 3.x 以来头一遭，GrapheneOS 公开点名
date: 2026-09-20
hn_id: 49758736
categories: [articles]
excerpt: >-
  Android 17 QPR1 的新 API 第一次先在 Pixel OS 独占，再向 AOSP 推送。GrapheneOS 认为这是 AOSP 走向封闭的关键一步。
tagline: >-
  当开源 Android 第一次把 API 当成 Pixel 的专属武器。
---

## 原文概要

GrapheneOS 在 9 月 16 日通过自家 Mastodon 账号发布了一条简短的声明：Android 17 QPR1 是自 Android Honeycomb（3.x）以来，第一次出现"先给 Pixel OS 添加新 API、暂不发布到 Android Open Source Project"的版本。新增 API 的源码和文档目前只挂在 Pixel 设备对应的 `developer.android.com/sdk/api_diff/37.1/changes` 页面上，其他 OEM 的源码树里看不到这些 API。

GrapheneOS 在声明中没有提及任何具体 API 名称，但强调了这一变化的"历史分量"——AOSP 自 2008 年开放以来一直是 Google 内部版本与上游社区同步的窗口，而 Pixel 在很长一段时间里只是"略早拿到新 API 几周到几个月"的位置。QPR1 把这段窗口直接关掉了。

这条声明在 9 月 18 日被提交到 HN 热门榜，48 小时内冲到 1018 分，成为当日榜首，原始评论数超过 660 条。讨论焦点迅速分裂为三条线：Google 是否在系统性收紧 Android 开源边界、第三方 ROM（GrapheneOS、LineageOS、postmarketOS）的生存空间、以及开源 Android 当年的"赢面"是否还在。

## 讨论焦点

### Google 是否在后悔开源 Android

> "The amount of roadblocks Google is putting up for GrapheneOS is just ridiculous. None of their decisions make any sense, from the delayed source patches upstream, to the embargos, attestation issues, etc. Google simply regrets android being open source." — wps [c:49759227]

> （译文）Google 给 GrapheneOS 设置的障碍简直离谱。从延后的源码补丁，到硬件 attestation 问题——每一步都说不通。Google 后悔让 Android 开源了。

这条评论在早期被顶到靠前位置，定下了讨论基调：Google 推动 API 独占不是孤立动作，而是一系列收紧动作中的一环。但下面的反驳者也立刻出现了：

> "It's not a regret. Android would never have been popular in the first place if it had not been open source. If phone makers had been able to anticipate how much the demons at Google would be able to lock down the Android then they would never had used the OS back in ~2009." — 7734128 [c:49759368]

> （译文）这不是后悔。如果 Android 当年没开源，它根本不会流行起来。如果手机厂商 2009 年能预见到 Google 能把 Android 锁成今天这样，他们根本不会选这个系统。

反驳点很实际——Pixel 现在有 Tensor 芯片、有硬件级安全模块，Google 完全可以只发一个闭源的 Pixel OS 让 OEM 去适配；但它没有这样做，说明 Google 自己也承认，Android 的生态护城河仍依赖"对 OEM 友好"这个标签。

### OEM 是封锁的同谋，不是受害者

讨论中一个反复出现但容易被忽略的角度是：OEM 自身也想把锁越上越紧。

> "They're happy that it is locked down. They're not happy that they're not the ones doing the locking down." — ardacinar [c:49759610]

> （译文）他们对被锁死很高兴。让他们不高兴的是：锁的钥匙不在自己手里。

这条短评被引用了多次，因为它点破了 OEM 的真实立场——他们不是反对"封闭"，而是反对"封闭的主导权不在自己手上"。再往下就是商业本质：

> "When they pitched Android as "open", they meant that carriers and device makers could load it up with all of the revenue-enhancing bloat that they wanted. In return, Google got a device that would let them hoover up all of the data they could ever want in order to build better ad service profiles for those using the devices. That is, after all, their business." — lenerdenator [c:49759735]

> （译文）当年他们说"开源"的意思是：运营商和手机厂商可以往系统里塞所有能挣钱的预装，作为交换，Google 拿到一部能替它收集任何数据、用来建更好广告用户画像的设备。说到底，广告才是它的生意。

> "For a while, this could coexist with us screwing around with a real-life tricorder. At some point, though, the free stuff turned into a revenue opportunity that had to be exploited." — lenerdenator [c:49759735]

> （译文）一段时间里，这还能跟我们折腾一台"真实版 tricorder"共存。但免费的东西总会变成必须变现的机会——于是就这样了。

"a real-life tricorder" 这句被多位用户特别提到——它精准描述了一代 Android 用户最初爱上这个平台时的想象：把口袋里的硬件当成真正的通用计算机去折腾。这个想象和"广告平台"的现实，是同一条故事线的两端。

### FBI 与执法视角

一个意料之外的角度来自 mitxela：

> "GrapheneOS does, however, register on the FBI's radar because a lot of criminals know to use it, and the FBI can't crack it." — mitxela [c:49762322]

> （译文）不过 GrapheneOS 确实上了 FBI 的雷达，因为很多犯罪分子知道要用它，而 FBI 破解不了。

这条评论把 Pixel + GrapheneOS 组合从"极客玩具"重新放回了"执法机构关注的对象"的位置。它间接解释了 Google 收紧 API 访问的另一层动机——API 独占不仅是商业策略，也可能是在规避与执法机构之间越来越复杂的张力。

### 第三方 ROM 的分裂风险

讨论延伸到非 Pixel ROM 社区后，担忧集中在兼容性的结构性威胁：

> "Google is going straight into a closed AI device." — fgonzag [c:49760504]

> （译文）Google 正在一路走向封闭的 AI 设备。

> "I'm going to start donating to a few free android distros I guess, I'm probably going to be trying them sooner rather than later, and without AOSP support the dev burden is going to be much higher, and it probably means they'll end up diverging and incompatible at some point (not in both directions, lineage will probably always have to have Android app support)" — fgonzag [c:49760504]

> （译文）我打算开始捐几个自由 Android 发行版，估计自己也很快会去试试，没有 AOSP 支持，开发负担会大幅上升，最终它们很可能会分叉并互不兼容（不是双向的，lineage 那边大概率还得继续做 Android 应用兼容）。

这是当天讨论里最具体的技术担忧：每个新版本独占的 API 一旦形成惯例，LineageOS、postmarketOS、Sailfish OS 等社区分支会各自实现一套私有"反编译 + 逆向"补丁，长期看就是分裂。GrapheneOS 因为有官方 Pixel 设备合作暂时不受影响，但其他分支的可持续性会受到直接挤压。

### GrapheneOS 团队的官方辩护

在评论里，GrapheneOS 官方账号（`grapheneos`）两次以长回复出现：

> "GrapheneOS provides drastically better usability, robustness, overall functional and app compatibility. Privacy and security are also drastically better in AOSP and especially GrapheneOS than that desktop Linux software stack ported to mobile." — grapheneos [c:49768898]

> （译文）GrapheneOS 在可用性、健壮性、整体功能和应用兼容性上都大幅领先。在隐私和安全上，AOSP 尤其是 GrapheneOS 也明显优于把桌面 Linux 软件栈搬到手机上。

这条回复针对的是"为什么不用 postmarketOS / Sailfish OS 替代"的问题。GrapheneOS 的立场是：开源不等于同质化，移动端的可用性壁垒远高于桌面端，硬件兼容性是真正决定项目生死的东西。

> "We hired 3 experienced app developers a few months ago. That's now our app development team working on overhauling these apps. They've already replaced the entire Messaging app user interface with a new modern Compose UI. Messaging v13 is currently in the Alpha channel and v14 is on the way with a bunch of additional fixes needed for it to reach Beta and Stable." — grapheneos [c:49769389]

> （译文）几个月前我们雇了 3 名资深应用开发者。这是我们现在的应用开发团队，正在全面重构这些应用。他们已经把整个 Messages 应用界面换成了新的现代 Compose UI，v13 在 Alpha 通道，v14 在路上，还需要一些额外修复才能到 Beta 和 Stable。

这条回复出现在质疑"GrapheneOS 自带应用 app 老化过时"的追问之后。它的潜台词是：Google 收紧上游的同时，GrapheneOS 必须把应用层也自己重做一遍，否则用户的体验差距会随 API 独占越拉越大。

### 历史的窗口：Android 当年是靠"现在就能用"赢的

一条最长、引用最多的回忆型评论把讨论拉回了 2009 年：

> "There were several credible competitors: WebOS, Symbian, Maemo/MeeGo, Palm OS 6, and of course Windows Mobile. But they required cooperating with a single vendor and/or a lot of work to adapt." — cyberax [c:49760324]

> （译文）当年有一堆像样的对手：WebOS、Symbian、Maemo/MeeGo、Palm OS 6，还有 Windows Mobile。但它们都需要绑死一家厂商，或者要花大量适配工作。

> "Android won because it was available "right now" and easy to hack. Vendors could get a BSP (Board Support Package) from a chip manufacturer, slap Android userspace on top of it, and ship a phone within half a year. It was a glorious mess for a while." — cyberax [c:49760324]

> （译文）Android 赢，是因为它"现在就能用"还容易改。厂商从芯片厂拿到 BSP（板级支持包），套上 Android userspace，半年就能出货。有一段时间是个辉煌的乱局。

> "Google then slowly tightened the reins and made the ecosystem more ordered." — cyberax [c:49760324]

> （译文）然后 Google 慢慢收紧缰绳，把生态整顿得井井有条。

"a glorious mess" 是对这个阶段的精炼概括——多家手机厂商能靠 Android 半年出货的时代，已经不会回来了。这条评论直接连接到 API 独占的长期含义：Google 不再需要靠"开放"来吸引 OEM，所以它有了让 API 落后于 Pixel 的空间。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Google 系统性收紧开源 | wps [c:49759227] | "Google simply regrets android being open source." |
| OEM 是同谋 | ardacinar [c:49759610] | "They're happy that it is locked down. They're not happy that they're not the ones doing the locking down." |
| Android 本质是数据生意 | lenerdenator [c:49759735] | "The free stuff turned into a revenue opportunity that had to be exploited." |
| Pixel-only API 会撕裂第三方 ROM | fgonzag [c:49760504] | "Without AOSP support the dev burden is going to be much higher." |
| 执法机构推动收紧 | mitxela [c:49762322] | "GrapheneOS does register on the FBI's radar." |
| 2009 当年的赢面不可复制 | cyberax [c:49760324] | "Android won because it was available "right now" and easy to hack." |
| GrapheneOS 重做应用层 | grapheneos [c:49769389] | "We hired 3 experienced app developers... overhauling these apps." |
| 当年开源是策略不是信仰 | 7734128 [c:49759368] | "Android would never have been popular if it had not been open source." |

## 总体情绪

讨论中没有真正的"乐观者"——即使为 Google 辩护的声音，也是说"开源 Android 当年是商业策略，现在收紧也是商业策略"，本质上是认了 Google 的掌控权。

情绪的分裂集中在两件事上：第一件是 OEM 与消费者对"封闭"的容忍度差异——OEM 早就接受了封闭，因为锁的钥匙未来可能在自己手上；消费者直到 Pixel 独占 API 这种小动作落地才真正感受到边界在动。第二件是 Pixel+GrapheneOS 组合在"极客玩具"和"执法机构目标"之间的两极定位——同一条产品线，被两类用户同时当成"最后的安全港"和"需要持续围堵的对象"。

最有信号量的一条评论其实不是技术分析，是 cyberax 长文里"a glorious mess → more ordered"这条暗线。AOSP 从来没有真正"开放"过，它只是"开放得让你能容忍"。API 独占不是突变，是这条线上一个新的刻度。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Android 17 QPR1 first since 3.x to add new APIs without releasing to the AOSP（GrapheneOS Mastodon 帖） | https://grapheneos.social/@GrapheneOS/117282080803799576 |
| 2 | HN 讨论：Android 17 is the first since 3.x to add new APIs without releasing to the AOSP | https://news.ycombinator.com/item?id=49758736 |
| 3 | Android API 差异页（37.1 / Android 17 QPR1） | https://developer.android.com/sdk/api_diff/37.1/changes |

<div class="disclaimer">

本文是对 HN 热门话题的中文摘要，所有引文均来自 HN 评论原文并标注了 comment ID。原文链接见"引用帖子"一栏。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>