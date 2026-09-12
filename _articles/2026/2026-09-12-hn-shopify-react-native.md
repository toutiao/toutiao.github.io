---
layout: post
title: >-
  Native 回归 — Shopify 弃 React Native 回 Swift/Kotlin，HN 怎么看 AI 重写移动栈
date: 2026-09-12
categories: [articles]
excerpt: >-
  HN 1231 分。Shopify 把 2020 年全押的 React Native 拆掉，理由是 LLM 把“写两遍”的成本压平。但谁真的跟得起，谁只是大公司的特权？
tagline: >-
  AI 改写了“双写”的成本账，但 parity 是发散成本 — 等一年再看 Shopify 能不能撑住。
---

## 原文概要

2020 年 Shopify 全面押注 React Native，三大目标很明确：别再为同一个功能写两遍、让没有移动背景的工程师也能上手、把“追平台 feature parity”的时间省下来干正事。文章承认这套打法当年是成功的。

2026 年的这篇博文是一份回调。Shopify 工程团队说：从 2021 年起他们就在用 LLM 写代码（比 ChatGPT 还早一年），起初只是补 bug、补测试；到 2025 年底，模型已经能干“iOS 版当参考，反向实现 Android 版”这种跨栈翻译活儿。于是他们决定重新评估 mobile stack，原型用 Swift / Kotlin 重建，结果“意外地顺利”——核心假设变了，结论也跟着变。

迁移策略选了 greenfield。Shop app（购物榜常年第一的那款）从 PoC 到 App Store 上线只用了 12 周；Shopify 主 app（300+ 屏、lockscreen widget、Apple Watch、complications、Siri Shortcuts）在路上，今年稍后发布；其余应用陆续跟上。

关键基础设施有两个。一个叫 **Helix**：开发者把 React Native 屏幕指给它，它先把工作切成小的有序 checkpoint，逐个 checkpoint 推进——每个 checkpoint 必须通过测试、视觉对比、两个对抗性 code reviewer、人工 gate，失败就回到上一个。另一个是把业务逻辑从 UI 完全解耦出来，做成无头可在桌面跑的版本，再用 CLI 暴露给 agent；agent 不必碰 simulator，几毫秒就能迭代一次，绕开了“agent 改代码几秒、验证几分钟”的瓶颈。

附带处理的是开源库。`React Native Skia` 由 Shopify 出资赞助到 2026 年底，William Candillon 之后 fork 改名续命；`FlashList`（每周约 200 万下载）Shopify 继续修 critical bug，正在找长期 steward；`Restyle` 用户基数小，直接归档。

文章末尾有一句话值得拎出来："React Native apps can be fast. Ours are." 这不是性能问题，是经济性问题。

## 讨论焦点

### 核心命题：LLM 把“两端重复”这道题解掉了

> "I suspect we'll see a lot of large orgs doing this in the next year." — ceejayoz [c:49644231]
>
> （译文：预感明年会有不少大厂跟牌。）

> "Yes, AI have changed the game, and now you can build and maintain two separate projects in Swift & Kotlin instead of one on React" — railka [c:49644312]
>
> （译文：是的，AI 改写了游戏规则——现在可以维护两个独立的 Swift/Kotlin 项目，而不只是写一个 React 应用。）

> "I'm surprised we aren't seeing it more already. LLMs suddenly make it reasonable to maintain multiple native apps. I'd love to see this start to supplant Electron and its ilk on the desktop." — dpark [c:49644402]
>
> （译文：奇怪还没看到更多公司这么做。LLM 让同时维护多个 native app 变得合理了。希望这种趋势也能淘汰桌面端的 Electron 之流。）

讨论里不少人对这条主线表示认可。两年前维护两套原生代码库是不现实的，工程师和 token 都撑不住；现在“翻译”成本被 agent 吸收，理论上两端可以独立演进。这条线最积极的延伸是桌面端——如果 SwiftUI/AppKit 也能享受同样的红利，Electron 的日子大概不会好过。

### 大公司特例：模仿前先看队伍规模

> "Definitely makes sense for a large org with massive resources (such as Shopify) to do this. But for everyone here pondering what to use for their startup or a smaller project, there are still important trade-offs." — stephenhuey [c:49644839]
>
> （译文：对 Shopify 这种资源大户来说是合理的。但对正在想该用什么的创业者或小项目，重要的权衡还在。）

> "I basically could not care what Shopify is doing because they have hundreds or thousands of people." — SV_BubbleTime [c:49647584]
>
> （译文：Shopify 怎么做我基本不在乎，因为他们有几百几千号人。）

> "I think it'll become a trend at larger, well-capitalized companies and startups, but not universally... they're well positioned to maintain two native codebases with agents and practically infinite token spend. Migration will be a harder sell for resource-constrained businesses." — accumulator [c:49645272]
>
> （译文：这会变成大厂和资金充足的初创公司的趋势，但不是普适的……他们有能力靠 agent 和近乎无限的 token 预算维持两套原生代码库。对资源紧张的公司来说，迁移更难讲通。）

这条线几乎是所有人共识：Shopify 跑得通不等于所有人都跑得通。两端原生意味着两个 release cadence、两份 platform-specific bug、两份 platform feature 跟进；token 账单一上来，小团队立刻就看到底。讨论里多次出现“你团队有几个人”这个反问。

### 原生端的隐性税：审核时延与迭代速度

> "App Store Review time, this used to be hours to 1-2 days, now it can take a week or more... we can go from a bug in the field to a fix in <1hr easy. Try doing that with a native app" — joshstrange [c:49644359]
>
> （译文：App Store 审核以前几小时到一两天，现在动不动一周以上……我们用 web 技术构建时，发现问题到修复上线一小时就够。原生应用试试看？）

> "The compile and build times on iOS (and Android) are also painfully slow... you can often edit and text your changes 10x faster on React than native. Quality often comes from iteration and it's an order of magnitude faster with React." — blehn [c:49660041]
>
> （译文：iOS（和 Android）的编译和构建时间也慢得让人难受……你修改 UI 然后看到效果的速度，React 比原生快大约十倍。质量来自迭代，而 React 的迭代速度高一个量级。）

这条线把“回原生”的代价算得很具体。审核时间是看天吃饭，编译迭代速度是真金白银的开发体验。讨论里有人用 CapacitorJS 做对比：在 dev server 上按一下保存，手机端不到一秒就更新——这种节奏原生几乎复现不了。但 Shopify 的回应是另一套架构思路：把业务逻辑剥离出来做成 CLI 让 agent 跳过 simulator，本质上是用“另一条路”绕开原生开发的迭代税。

### 核心质疑：parity 是发散成本，不是实现成本

> "Feature parity isn't an implementation cost. It's a divergence cost. It accrues over years across experiments, analytics, accessibility, edge cases, bug fixes, platform behavior, and a thousand little decisions which current agents aren't great at tracking." — hermitwriter [c:49644429]
>
> （译文：Feature parity 不是实现成本，是发散成本。它在多年时间里不断累积——实验、分析、可访问性、边界情况、bug 修复、平台行为，以及无数个 agent 不太擅长追踪的小决策。）

> "You haven't maintained parity yet. You've built prototypes. You're making a claim about a cost that compounds over time based on what it costs at t=0." — hermitwriter [c:49644429]
>
> （译文：你还没真维持过 parity，你只是造了原型。你用一个 t=0 时刻的成本去推断一个会随时间复利的成本。）

> "One React app vs two native apps is a false comparison. A sufficiently polished React Native app still means two platforms to tune, test, debug, ship, and maintain." — simondotau [c:49656378]
>
> （译文：“一个 React app 对两个原生 app”是假对比。一个打磨过的 React Native 应用同样需要在两个平台上调优、测试、调试、上线和维护。）

> "If AI can make any language do anything, why move away from React Native? ... This just feels like internal factions wanting their own teams, and owning their respective politics, than a discussion on Merit." — kamaal [c:49654483]
>
> （译文：如果 AI 能让任何语言做任何事，为什么要离开 React Native？……这看起来更像内部派系想保住自己的团队和话语权，而不是在讨论技术优劣。）

这条线是反对票的核心，也是整场讨论里最有分量的反方论据。论点很明确：Shopify 展示的是“今天写两遍有多便宜”，但跨端一致性的真正成本是“五年里两套代码各自漂移多远”。agent 写得快，但追踪“iOS 那边一年前加的某个边界处理，Android 这次有没有同步”这种问题，目前还远不擅长。还有人顺着这条线指出：如果 AI 让 RN 维护也变便宜了，那为什么不把同样的 agent 灌到现有 RN 代码库上，何必重写？

### 开源生态的涟漪：谁来接盘

> "Major loss for react native community at large with Skia and Flashlist dying. :(" — sergiotapia [c:49644354]
>
> （译文：对整个 React Native 社区是重大损失，Skia 和 FlashList 都要没了。）

> "Legend List is the new hotness in RN." — gagabity [c:49645271]
>
> （译文：在 RN 里 Legend List 是新的热门选择。）

> "Plus you're trading RN problems for gradle and integration problems on iOS." — hn-acct [c:49657403]
>
> （译文：你只是把 RN 的问题换成了 iOS 上的 gradle 和集成问题。）

Shopify 的开源贡献是 RN 生态的地基之一。讨论里有人担心 Skia fork 改名后的可见性、FlashList 长期 steward 的真空。也有人从工程角度指出，原生不是没有代价——Swift 编译工具链、Gradle、Android emulator 的麻烦会原样接过来，并不是“甩掉一层抽象”就能省心。

### 时尚论 vs 经济性论

> "The wheel of fashion turns once more." — quotemstr [c:49644301]
>
> （译文：时尚的轮子又转了一圈。）

> "I don't think its purely fashion here. React Native always incurred a bit of a performance & UX penalty, but many people decided that this tradeoff was worth it for the increase in product development velocity. LLMs change the tradeoff and organizations would be remiss to not reconsider previous decisions." — jmknoll [c:49644898]
>
> （译文：我并不认为这纯粹是时尚。React Native 一直都有性能和 UX 上的代价，只是很多人觉得换取产品迭代速度更划算。LLM 改变了这种权衡，组织如果不重新审视过去的技术决策，是失职。）

讨论最后落到了“到底是真的经济性变了还是只是风潮轮转”这个元问题上。最有力的反时尚论是：RN 的性能与 UX 税一直存在，只是被开发速度红利掩盖了；现在 LLM 把开发速度红利抽走，原生那一端的优势就重新显形。但另一面，评论里也有人不客气地指出，Shopify 最近的技术决策（加上前一天的 Tailwind 事件）让人怀疑这究竟是技术评估，还是新领导班子的偏好投射。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 趋势已成 | ceejayoz | “预感明年会有不少大厂跟牌” |
| 经济性真变 | railka | “AI 改写了游戏规则——可以维护两个独立 Swift/Kotlin 项目，而不是一个 React” |
| 延伸到桌面 | dpark | “希望这种趋势也能淘汰桌面端的 Electron 之流” |
| 大公司特例 | SV_BubbleTime | “Shopify 怎么做我基本不在乎，因为他们有几百几千号人” |
| 资源门槛 | accumulator | “他们有能力靠 agent 和近乎无限的 token 预算维持两套原生” |
| 创业建议 | stephenhuey | “大多数项目不该学 Shopify，应该用能给你杠杆的平台” |
| 核心质疑 | hermitwriter | “Parity 不是实现成本，是发散成本——agent 写代码快，但追踪多年累积的细微决策不是它的强项” |
| 假对比 | simondotau | “‘一个 React 应用对两个原生应用’是假对比，RN 同样要在两端调优” |
| 内部派系 | kamaal | “这看起来更像内部派系想保住自己的团队” |
| 时尚轮转 | quotemstr | “时尚的轮子又转了一圈” |
| 反驳时尚论 | jmknoll | “RN 的性能税一直存在，LLM 只是把权衡挪动了” |
| 生态担忧 | sergiotapia | “对整个 RN 社区是重大损失” |
| 迭代速度 | blehn | “React 改 UI 的迭代速度比原生高一个量级” |
| 审核代价 | joshstrange | “原生应用做不了‘一小时修 bug 立刻上线’” |

## 总体情绪

讨论呈温和分裂。多数人承认 Shopify 给出了清晰的论证框架，并相信“跨端一致性 vs 原生体验”这道算式在 LLM 时代会被重新算过一遍；但真要跟牌的人少之又少——核心阻力不是技术原理，而是“你的团队够不够厚、token 预算够不够松”。

最尖锐的反对意见指向一个 Shopify 没回答的问题：他们展示的是“今天写两遍的便宜”，但跨端系统真正的成本在 t=0 之后几年逐步显形。Helix、checkpoint、adversarial reviewer 这些机制看起来更像是对“agent 容易出 slop”这个事实的承认，而不是对“两端能长期同步”的证明。如果一年后 Shopify 公开 parity bug 数、review 工时、experiment drift 这些数据，整场讨论的判断可能要被改写。

另一层隐性情绪是疲倦——很多人写过跨端，也写过原生，深知“抽象层永远有代价”。抽象层不消灭问题，只是把它挪个位置。LLM 是新的挪法，但“挪完了成本是否真的下降”这种问题，只有在几个产品周期之后才有答案。

RN 不是死掉，社区仍然存在，库会换名字、换维护者继续运转；真正被重新评估的，是“跨平台”这个概念本身的经济学意义。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Shopify is moving from React Native back to Swift and Kotlin | <https://news.ycombinator.com/item?id=49643982> |

## 免责声明

<div class="disclaimer">

本文为 HN 讨论摘要，观点不代表本站立场。引文翻译为意译，完整原文请查阅引用帖子。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
