---
layout: post
title: >-
  浏览器指纹才是新 cookie — HN 讨论摘要
date: 2026-10-13
hn_id: 50048642
categories: [articles]
excerpt: >-
  当 Google 在压力-转移-加速三幕剧后默认设备指纹，cookie 退场只是换了一身皮；HN 用户追问技术与法律的双重边界。
tagline: >-
  cookie 之死只是换了个名字。
---

## 原文概要

Royfish 的长文《Fingerprints are the new cookies》把浏览器指纹（browser fingerprinting）讲成一件已经发生、但被精心掩盖的"换皮"事件。文章把过去几年的故事拆成三幕：第一幕"压力"是 2019 年 Google 在 Safari 与 Firefox 已封禁三方可追踪 cookie 的舆论下，把"隐私至上"挂在嘴边；第二幕"转移"是 Privacy Sandbox 用五年时间拖延，期间争议不断，最终 Google 在 2025 年初悄悄把"设备指纹可用作广告标识"纳入产品；第三幕"加速"是默认启用指纹作为新的标识手段。

技术层面，作者用"猜猜我是谁（Akinator）"这个二十问游戏做类比：每一个看似无关的字段——语言、操作系统、屏幕分辨率、安装字体、Canvas 与 WebGL 渲染特征、CPU 时序——都是一次"是男人吗？"式提问。文章给出关键数据：邮编、出生年月、性别三者的组合已可唯一识别 60% 以上美国人；当采集维度达到约 33 bit（相当于 86 亿人之一）时，地球上每个人都可被唯一识别。iOS 本身可贡献 10–15 bit，再叠加住宅 IP 即足以在样本中剥离开个体。

浏览器对比一栏是文章的硬核部分：Chrome 与 Edge 仅止步于"隔离"（一个站点不能读其他站点数据）；Safari（尤其 iOS/macOS 26+）与 Firefox 把定义延伸到"隐私"，但仍不完整地防指纹；Brave 与 Tor 浏览器，以及新兴的 Mullvad Browser，被列为真正"隐私优先"的工具。客户端反制武器一栏列出 CanvasBlocker、uBlock Origin、JShelter、CreepJS（演示）等开源工具，但作者强调这些工具要么让浏览器"看起来更有趣"（即更罕见，反被识别），要么会触发 Cloudflare 等的反爬机制。

## 讨论焦点

### "很酷的技术 + 很可怕的隐私入侵"

讨论开篇定下基调。1a527dd5 写：

> "My reaction to this is always two fold; firstly cool tech, secondly horrifying invasion of privacy." — 1a527dd5 [c:50049135]
> （译文："我对这种技术的反应总是分两层：先是觉得这技术很酷，随即意识到它是对隐私的可怕入侵。"）

cromka 则从反面吐槽：自己使用固定 IP，被 Cloudflare 反复当作机器人拦截："无论欧盟在做什么，根本没用。" [c:50053210] 而 throawayonthe 反驳："如果你用固定 IP，那根本不需要再加指纹就够了。" [c:50049548] tobwen 顺着补一句："静态 IP 在不被多人共享时对隐私是毁灭性的。我们大学数百个用户共用一个出口 IP。" [c:50049913]——指纹与 IP 的关系成了 HN 第一段来回的核心。

### "cookie 同意横幅本来就不是关于 cookie"

多位 EU 用户指出，ePrivacy 法（以及 GDPR）下，浏览器指纹（fingerprints）实质上已经违法。crote 直接把同意横幅（consent banner）的本质挑明：

> "This is already illegal in the EU. The consent banners were never about <i>cookies</i>, they have always been about the tracking itself!" — crote [c:50049154]
> （译文："在欧盟这已经是违法行为了。同意横幅从来不是关于 cookie，它从一开始就是关于追踪本身。"）

stavrop 把法律点焊到具体条款："EDPB Guidelines 2/2023（最终版于 2024 年 10 月通过）规定，当站点的 JavaScript 指示浏览器把信息回传时，这等同于'访问'，与读取 cookie 一样（32–34 段）。WP29 在 Opinion 9/2014 已认定设备指纹在监管范围内。" [c:50052471] 这条评论把抽象担忧与具体条文挂钩，是讨论里最具操作性的一段。

buzer 则指出 ePrivacy 第 5(3) 条的措辞："reading from or writing to terminal equipment"，引文里用了 `<i>` 标签而非粗体，暗示读者关注"不是严格必要"的限定范围 [c:50049619]。zejn 直白："总有人以为'这不是 cookie 所以是漏洞'。不是漏洞，只是无知。" [c:50051867]

### 抗指纹工具的真实效用与副作用

另一条线是用户实测。eks391 自称"多年来一直用 Brave 做指纹混淆，是 5 款主流浏览器里唯一一个能让我满意做这件事的" [c:50050102]。davidjade 给出一个简单方案："Firefox + uBlock + CanvasBlocker + PiHole，每次刷新指纹都变。" [c:50050187] Guvante 顺着吐槽："私密窗口被原文专门点名会产生第二个身份。" [c:50050334]

但 hobo123 一句话点穿对抗的本质：

> "That's the thing, no web page, except for games, should ever need to know about your viewport size. So spoofing would be just fine, imho, with an override option/permission for individual sites." — hobo123 [c:50051810]
> （译文："关键在于，除了游戏，没有任何网页真的需要知道你的视口大小。所以在我看来，直接伪造就好，再给个别站点一个授权选项就行。"）

avodonosov 进一步把矛头指向浏览器厂商本身："原因是浏览器厂商本身有利益推动追踪。从技术层面阻止追踪并不复杂——加噪声、让 API 默认不可用、要用户主动授权。但他们没有这么做。" [c:50054772]——把技术问题转成了动机问题。

### 反指纹与"反 bot"是同一场军备竞赛

讨论里反复出现一组对偶："抗指纹"与"防 bot"。Terr_ 一句近乎游戏台词的提问被多人引用：

> "How do you tell the difference between a regular human trying to not have a weird creepy perma-dossier collected on them... versus a bot set up to always look like a new visitor?
> The only winning move is not to play--er, to somehow not to have this kind of game in the first place." — Terr_ [c:50050345]
> （译文："你怎么分辨一个想不被建档的普通人类，和一个永远装作新访客的机器人？唯一能赢的一招是不玩——也就是说，根本别让这种游戏存在。"）

vntok 补一句更现实的回应："你没法分。只能让两者都消耗几十亿次 CPU 周期。人类能忍受一次性的代价，机器人的主顾则不会，因为这不可规模化。" [c:50052817] wyager 一句话点掉"指纹反欺诈"的迷思："它根本不管用。" [c:50050297] 但 anthonyIPH 与 etatester 给出从业者反驳："在反欺诈里指纹不能完全阻止，但能抬高成本" [c:50050479]，"不必 100% 有效，有用就够了——每个 CAPTCHA 都在这么用。" [c:50051795] 这是整场讨论里最具体的一段攻防。

### "问题不在广告，在于数据买卖"

讨论末尾绕不开广告。pull_my_finger 把争议焦点切准：

> "The problem isn't advertising, it's data harvesting and sale. Ads used to rent space on websites - totally reasonable. The whole industry around the purchase and sale of user data is what needs to be banned." — pull_my_finger [c:50051115]
> （译文："问题不在广告本身，而在数据的采集与买卖。广告过去是在网站上租位置——这完全合理。需要被禁的是围绕用户数据买卖的整套产业。"）

MiroslavPokorny 主张更激进的方案：

> "Theres only one solution, ban third party advertising. Everything else is a compromise that doesnt work anyway." — MiroslavPokorny [c:50049686]
> （译文："只有一个解法——禁止第三方广告。其他所有方案都是行不通的妥协。"）

struant 把广告比作癌："任何形式的广告与付费推广从来都不 OK。它一直是社会的癌。忽视小症状到它恶化成怪物，就是现在。" [c:50051464] autoexec 反驳："你永远没法彻底消灭广告。归根到底，人们想了解新产品和新服务，没法做广告的小公司会死掉。" [c:50051617]——广告"必要性"被反驳派当成反例。goodpoint 简洁回应："你 100% 是这种典型。广告是告知的反义词。" [c:50054769]

### 横向对照：肉空间追踪的辩护

一条温和的反对声音来自 ButlerianJihad：

> "Life is far too short to live in fear and paranoia of the scenarios you suggest. Anywhere I go in meatspace, people could be collecting data about me and my behavior. That has <i>always been true</i> since the beginning of time." — ButlerianJihad [c:50053177]
> （译文："活在对你描述的场景的恐惧与偏执里太亏了。无论我走进哪个物理空间，都有人在收集我和我的行为数据。这从开天辟地起就一直是真的。"）

floorsthelimit 的反问则直指"等价"："如果每个你访问的网站都知道是你、知道你点了哪些链接、看了什么内容、永远知道——你真的 OK 吗？" [c:50049617] 把肉空间类比打回去：物理空间的老太太只看到访一次，而互联网的"档案"是永久、可聚合、可跨域的。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 又是酷又是恐 | 1a527dd5 | 技术很酷，隐私入侵很可怕 [c:50049135] |
| EU 法律上已违法 | crote / stavrop | 同意横幅从来是关于追踪；EDPB Guidelines 2/2023 明列 [c:50049154] [c:50052471] |
| 反指纹工具有用 | eks391 / davidjade | Brave 多年有效；Firefox + uBlock + CanvasBlocker 也可 [c:50050102] [c:50050187] |
| 浏览器厂商有动机问题 | avodonosov | 技术不难阻断，但厂商不阻止，因为他们从中获利 [c:50054772] |
| 抗指纹与反 bot 是同一战场 | Terr_ / vntok | 唯一不输的办法是不玩；让两边都消耗算力 [c:50050345] [c:50052817] |
| 指纹不能反欺诈 | wyager | 直接说"不管用" [c:50050297] |
| 指纹可抬高欺诈成本 | anthonyIPH / etatester | 不必 100% 有效，每个 CAPTCHA 都在用 [c:50050479] [c:50051795] |
| 禁第三方广告 | MiroslavPokorny / struant | 其他都是妥协；广告是社会的癌 [c:50049686] [c:50051464] |
| 肉空间追踪的等价辩护 | ButlerianJihad | 物理空间早就在被观察 [c:50053177] |
| 问题在数据买卖而非广告本身 | pull_my_finger | 应禁的是数据买卖，不是广告 [c:50051115] |

## 总体情绪

讨论整体呈现"技术着迷 vs 现实焦虑"的两层反应，同时伴生法律与动机两条线索。1a527dd5 那句"先觉得酷、再觉得可怕"成了贯穿全场的主调；crote 与 stavrop 把欧盟法律现状具体到 EDPB Guidelines 2/2023，把抽象担忧焊在了法条编号上；avodonosov 则把批评从"能不能挡住"转向"为什么没人真的去挡"——把责任挂回浏览器厂商的动机上。

更深一层的张力在于抗指纹工具的副作用：uBlock + CanvasBlocker + PiHole 这套配方让 davidjade 每次刷新都拿到新身份，但同样的策略会让 Cloudflare 把人类当成机器人——russdill 一句"这经常触发 Cloudflare 防御" [c:50052288]，把"自由"和"可见"放在跷跷板两端。Terr_ 的"唯一能赢的一招是不玩"获得多人共鸣，但 wagers 反驳说"指纹根本不能阻止欺诈"，立刻被 etatester 从 CAPTCHA 实战经验里反击。

最终讨论没有得出解决方案，而是把"cookie 已死"翻译成更不透明的语汇：浏览器默认开始指纹识别，第三方广告产业等待下一轮政策，法律条文写在 EDPB 指南里而代码已经跑在浏览器里。一句话总结这场讨论：cookie 之死只是换了个名字，墓碑上刻的是"Privacy Sandbox"，墓里埋的是设备指纹。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Fingerprints are the new cookies | <https://news.ycombinator.com/item?id=50048642> |

<div class="disclaimer">
本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3。引文与事实均来自 royfish.dev 原文与 HN 评论缓存，已逐条比对。<br>
本站为 HN 讨论的二次摘要，所有观点归原作者所有。本站不持有任何相关立场，亦不对原报道或评论的真实性承担担保责任。
</div>