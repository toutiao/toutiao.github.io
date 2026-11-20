---
layout: post
title: >-
  Google 被指逼 OEM 别解锁 bootloader：GrapheneOS 把一场静默的封杀摊到了台面上 — HN 讨论摘要
date: 2026-11-20
hn_id: 50570479
categories: [articles]
excerpt: >-
  GrapheneOS 发帖指控 Google 一边把功能锁进 Pixel，一边拿 GMS 授权条款威胁 OEM 别支持 GrapheneOS、甚至别解锁 bootloader。
  评论区最值得记的不是阴谋论，而是一个反差：据 GrapheneOS 所说，给它们写代码的是 Google 的工程师，去劝 OEM 别合作的是 Google 的商务部门。
tagline: >-
  工程师在给 GrapheneOS 加功能，商务部门在劝 OEM 别解锁 bootloader。
---

> 来源：HN 讨论主帖 [Google is pushing OEMs against GrapheneOS and bootloader unlocking](https://news.ycombinator.com/item?id=50570479)（379 分，131 条评论），页面指向 GrapheneOS 官方账号在 Mastodon 上的一串发帖。归档快照 2026-11-20 10:59 UTC，入库 100 条评论（其中一级评论 20 条），评论分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值。原页面为 JavaScript 渲染，正文抓取失败（`article.fetch_status: error`，`error: gate: too_short`），本文的事实取自 Mastodon API 返回的同一发帖串（57 条回复，含 GrapheneOS 本人回复）。引文中的 HTML 实体按归档形式还原，文字与作者逐条与归档评论比对。

## 原文概要

这次上 HN 的不是一篇文章，是一串 Mastodon 帖子。发帖账号是 GrapheneOS 官方账号，第一条发于 2026 年 11 月 19 日 20:40 UTC（北京时间 11 月 20 日 04:40），HN 上的提交时间是 11 月 20 日 05:21 UTC，目前 379 分、131 条评论。首发帖被转发 358 次、收藏 384 次。

正文只有三句，每一句都指向一件具体的事：

> Google is sabotaging their OEM partners by making a growing number of features and updates exclusive to Pixels. At the same time, Google is trying to convince OEM partners not to support GrapheneOS or even bootloader unlocking. They're also trying to harm GrapheneOS directly.

（Google 正在坑自己的 OEM 伙伴：把越来越多的功能和更新变成 Pixel 独占。与此同时，Google 正在说服 OEM 伙伴不要支持 GrapheneOS，甚至不要解锁 bootloader。他们还在直接伤害 GrapheneOS。）

第二条帖子在 11 月 20 日 00:23 UTC 发出，把指控具体化了：Google 反复联系 OEM，质问他们是否与 GrapheneOS 有合作，并依据 GMS 授权条款威胁他们——而这些条款已被多个法院判为违法。

> Google has been repeatedly reaching out to OEMs to question whether they're working with us and threaten them based on GMS licensing terms found to be illegal by multiple courts. They're trying to stop us from having more than Pixels to support. It's completely outrageous.

（Google 反复联系 OEM，质问他们是否在与我们合作，并依据已被多个法院认定违法的 GMS 授权条款威胁他们。他们想让我们除了 Pixel 之外无处可去。这完全荒唐。）

接下来的回复把局面铺开成三块。

第一块是 Google 内部。GrapheneOS 说，Google 内部有大量工程师支持他们、还直接与他们合作过，甚至为 Play 服务实现了 FIDO2 与 passkey 支持（Vanadium），并补了一句在评论区被反复引用的话：Google 的工程师不是问题所在，问题出在商务部门的人。同时 GMS 授权里被指存在多条旨在阻止竞争的违法条款。

第二块是即将发生的事：Google 会开始锁定 Pixel 的 bootloader，会继续大力推动被指非法的 `Play Integrity` API，会试图让 AOSP 的分叉不可行。帖子的原话是，这些行为明显违反美国刑法，而美国反垄断法对个人是有刑期的。诉求对象写得很具体——美国司法部反垄断负责人 `@AGToddBlanche` 与司法部本身，理由是美国司法部针对 Google 的 Android 反垄断诉讼已经有多起，但都只是擦着最严重的部分。

第三块最扎手：欧盟自己正在成为 Play Integrity 的推手。GrapheneOS 的说法是，欧盟各国正在把 `Play Integrity` API 写进本国银行等应用的标准里，而这个 API 的实际作用是用 GMS 授权条款去禁掉任何没有授权的硬件或系统——他们称这是 GrapheneOS 目前最主要的生存性障碍。另一条配套手段是 Play Store 的应用保护机制（pairip / 自动保护），它可以与「安装前必须通过设备完整性校验」叠加，在实践上把替代系统用户挡在门外；GrapheneOS 说自己已经做了变通方案，但只覆盖简单场景。

与此并行的是对欧盟的失望：GrapheneOS 说自己就 Play Integrity 与欧盟委员会谈过，什么都没发生，问题反而更糟了，所以反问欧盟继续开出数十亿欧元的罚款、却从不触碰核心行为有什么意义。另一条 Mastodon 讨论里出现了 ownyourphone.org 的欧洲公民倡议，GrapheneOS 表示目标是让欧盟或美国的监管方「问 Google 几个问题」。

硬件一端，GrapheneOS 自己的解释是：受 GMS 授权限制，Motorola 不能大规模直接销售预装 GrapheneOS 的设备，Samsung 因韩国法院胜诉而获得了豁免；他们强调 Motorola 的做法是在 Google 规则之内。对 Fairphone 的回应更直接——它说 Fairphone 是个卖 T2Mobile 白牌设备的品牌，自身几乎不做工程，设备安全性差，离 GrapheneOS 的要求还远。至于组织规模，GrapheneOS 也摊了牌：不打算「无谓地硬 fork AOSP」，那需要扩充并招聘数百名工程师，而他们离这个能力还差得远。

## 讨论焦点

### 一、起诉，还是写信：三条法律路径

评论区最高票的建议是把材料寄给州总检察长。

> "Write them a letter. Calmly and dispassionately ask that they look into this from an antitrust perspective. Include a copy of this GrapheneOS thread." — JumpCrisscross [c:50570940]
> （译文）写一封信，冷静而不带情绪地要求他们从反垄断的角度看一眼这件事，并附上这条 GrapheneOS 发帖串的副本。

同一楼层还建议 GrapheneOS 为每个州出一份模板信，并把「反复联系 OEM 质问他们是否与我们合作并据此施压」这句话的证据一并公开。另一位读者把欧盟也拉进来：

> "Also inform the European Commission and other anti-trust authorities. Google is getting more and more authoritarian as far as Android development is concerned." — hn_submit [c:50571046]
> （译文）也去通知欧盟委员会和其他反垄断机构。就 Android 开发而言，Google 越来越专横了。

具体到欧盟，普通公民能走的是 DMA 投诉渠道：

> "If you are an EU citizen, contact the DMA team." — microtonal [c:50571084]
> （译文）如果你是欧盟公民，去联系 DMA 团队。

反垄断这条线最乐观的判断是钱的问题：

> "Google can be fined for its conduct, and for rather considerable sums." — nine_k [c:50571384]
> （译文）Google 会因为它的行为被罚款，而且金额相当可观。

但真正卡住这条路的不是法律，是执行。有人直接指出，写信时得说清违反的是哪条法：

> "To make things easier for folks could you cite what specific law you feel is likely being violated and how?" — dataflow [c:50571452]
> （译文）为了让大家好操作，能不能引用一下你认为是哪条具体法律被违反了、又是怎么违反的？

反对派的理由更冷，是关于检察官本身：

> "They are people who had a choice to use their expertise and education to make a ton of money and help people or destory lives and make far less money and they chose the latter. They are not your ally." — testtestmetest [c:50571913]
> （译文）他们本可以利用自己的专业能力和学识，靠帮别人挣大钱，或者靠毁掉别人的一生挣小钱——他们选了后者。他们不是你的盟友。

国会这条线被认为优先级更低，但有人愿意去推动：

> "Its also something people should be bothering Ro Khanna about, given the area he represents" — boredatoms [c:50570974]
> （译文）考虑到 Ro Khanna 的选区，这也该由选民去催他管一管。

> "Short-term target is the Subcommittee on Antitrust, Commercial and Administrative Law" — JumpCrisscross [c:50571006]
> （译文）短期目标应该是众议院司法委员会下面的反垄断、商业与行政法小组委员会。

同一作者也承认这条路在可见的未来不会成为优先项——真正管用的是司法部和监管机构。GrapheneOS 自己也认同这个判断：两党都从 Google 拿钱，只有行政分支真正相关。

### 二、「证据在哪」：Pixel 现在明明还能解锁

质疑的一方抓住了一个立刻可验证的反例：Pixel 现在还允许解锁 bootloader。

> "Strange since Pixels allow boot loader unlocking." — acd [c:50571074]
> （译文）奇怪，Pixel 不是还允许解锁 bootloader 吗。

回应只有半句：

> "Until Google decides otherwise." — skeledrew [c:50571220]
> （译文）直到 Google 决定不这么做为止。

这句话之所以有分量，是因为 GrapheneOS 在原帖串里明确预测 Google 会开始锁定 Pixel 的 bootloader。这构成了一个具体的时间点式的预言：等 Pixel 也锁上的时候，「Pixel 还能解锁」这条反驳就自动失效。至于「Google 到底有没有真的打电话给 OEM」，帖串里给的是单方陈述，没有第三方记录；这也正是评论区反复追问证据的原因。

### 三、工程师 vs 商务部门：Google 内部自己承认的裂缝

整件事最反直觉的地方，是指控来自 Google 自己的生态，而 GrapheneOS 点名的「帮凶」不是工程师。

> "it seems like Google learned the no good deed goes unpunished lesson." — teravor [c:50570728]
> （译文）看起来 Google 吸取了「好心没好报」的教训。

> "Google's in a real hurry to lock down Android lately. They already got once over trying to keep competing services out with their GMS agreements. Clearly, the only lesson they learned is &quot;try harder.&quot;" — ACCount39 [c:50570831]
> （译文）Google 最近是真的急着把 Android 锁死。他们在用 GMS 协议排挤竞品这件事上已经吃过一次官司。显然，他们唯一吸取的教训就是「再狠一点」。

而把这件事讲成商业模式的人，口气平静得多：

> "This is a business decision clearly. Google is still running a business. A good business, actually." — karel-3d [c:50570979]
> （译文）这显然是一个商业决策。Google 还在做生意，而且是个好生意。

结构性的解释来自双头垄断的角度：

> "Google can do this because they have effectively a duopoly, with Apple, in the domain of operating systems for mobile phones." — leonidasrup [c:50571132]
> （译文）Google 能这么做，是因为在手机操作系统这个领域，它和 Apple 实际上构成了双头垄断。

GrapheneOS 自己那句「工程师不是问题，商务部门才是」，在评论区被解读成一句更锋利的话——同一家公司里，写 `Vanadium` 的那批人和给 OEM 打电话的那批人，坐在不同的楼层，做相反的事。

### 四、解锁 bootloader 的技术现实：TEE、远程证明，和被撕成两半的互联网

技术派的讨论把「能不能阻止解锁」和「阻止了之后会怎样」拆成了两件事。

先说能不能阻止：解锁在技术上并没有被真正锁死。

> "With LLMs, unless you use a more extreme version of Samsung style hardware fuse, there really isn't anything that Google can do to prevent bootloader unlocking from a technical standpoint since all it really takes is one bug in the kernel for the bootloader to be unlocked." — YuechenLi [c:50571117]
> （译文）有了 LLM，除非你采用某种更极端的、三星式硬件熔断方案，否则从技术角度看 Google 没有什么能真正阻止 bootloader 解锁——只要内核里有一个 bug，bootloader 就可能被解锁。

多数设备根本不让你解锁，评论者的说法很直接：

> "you're going to need a kernel or early boot code exploit to run your code with EL1+ privileges. For the minority that does, you usually follow the standard process" — m132 [c:50571250]
> （译文）你需要一个内核或早期启动代码的漏洞，才能以 EL1+ 权限运行自己的代码。对于少数能做到的机器，通常按标准流程走。

另一位评论者把信任执行环境（`TEE`）这层讲清楚了：解锁 bootloader 并不会解锁真正管事的那一层。

> "So at most, with a kernel exploit, you're going to get a temporary root, and you don't get to modify the system partition because the system will refuse to boot the next time because there are integrity checks. Something similar to PS4 and PS5 jailbreaks." — grishka [c:50571340]
> （译文）所以最多也就是靠内核漏洞拿到一个临时 root，你没法修改 system 分区，因为系统下次会因为完整性校验拒绝启动。跟 PS4、PS5 的越狱差不多。

于是真正的战场从 bootloader 移到了远程证明：

> "Google is actively trying to fracture the Internet into 2 halves: one anything can access, and another that'll require hardware-generated, cryptographic proof of the client running the latest, patched-up version of a locked-down operating system." — m132 [c:50571180]
> （译文）Google 正在积极把互联网撕成两半：一半谁都能访问，另一半则要求由硬件生成、密码学证明的客户端凭证，证明你跑的是一个打过补丁的、锁死过的操作系统。

对这套叙事的反驳同样具体：Google 并没有真的为难落后好几年的设备。

> "I don’t believe that: I’ve not seen them causing any trouble for people with devices <i>years</i> behind" — chrismorgan [c:50571816]
> （译文）我不信这一点：我没见过他们为难那些设备落后好几年的用户。

而 AI 反爬这条新变量，让反对派也承认裂缝可能不可逆：

> "If you also take into account the activity of AI companies which is creating a desperate need for anti-bot protections, I really can't see a future without this fracture." — negura [c:50571813]
> （译文）如果再算上 AI 公司的活动——它们制造了对反爬的迫切需求——我真的看不到这条裂缝消失的未来。

评论区还有人把这套机制外推到了嵌入式设备上：

> "When that happens you'll need a connection to their servers to sign the firmware you are developing. And when they terminate your access you won't be able to flash new firmware." — Gibbon1 [c:50571379]
> （译文）到那时候，你刷自己开发的固件就需要连他们的服务器去签名。而一旦他们终止你的访问，你就再也刷不了新固件了。

### 五、买谁的手机：Pixel 不解锁之后的账

假设 Pixel 也锁上 bootloader，评论区算的是另一笔账。

> "My 10a will be the last Pixel I buy if the bootloader of future editions can't be unlocked. I'll jump ship to Motorola." — drnick1 [c:50570969]
> （译文）如果以后版本的 Pixel 不能解锁 bootloader，那我买的最后一个 Pixel 就是 10a。我转投 Motorola。

> "I think the time of open Pixels is over and it is time for a third party to step in (Motorola.. maybe..)." — Helmut10001 [c:50571096]
> （译文）我觉得开放 Pixel 的时代结束了，该有第三方进来了（Motorola……也许吧）。

把「买 Pixel 才能脱 Google」本身视为定时炸弹的人，把话说得更彻底：

> "The easiest method to degoogling being dependent on owning google hardware was always a timebomb." — ozlikethewizard [c:50571135]
> （译文）最简单的脱 Google 方法居然依赖于拥有一台 Google 的硬件，这一直就是颗定时炸弹。

于是问题转向「有没有便宜且安全的替代品」，答案并不乐观：

> "We need cheap phones supporting it" — madduci [c:50571063]
> （译文）我们需要支持它的便宜手机。

> "Not just cheap. Replaceable batteries, audio jack, SD card; there are plenty of reasons to want other hardware." — yjftsjthsd-h [c:50571835]
> （译文）不只是便宜。可更换电池、耳机孔、SD 卡——想要别的硬件的理由多得很。

但便宜和安全在低价机上基本互斥：

> "You are not getting a phone with any security at that price point. They do not have a secure element (only TrustZone), so they are vulnerable against side-channel attacks, etc." — microtonal [c:50571902]
> （译文）那个价位的手机你拿不到任何安全性。它们没有安全元件（只有 TrustZone），所以在侧信道攻击面前是脆弱的，等等。

GrapheneOS 团队自己也承认首款是旗舰机，廉价机型是以后的事：

> "Our team has been pretty upfront from the beginning that the first device was going to be a flagship. There are plans to support more devices in the future, devices that I'd expect will be cheaper." — other8026 [c:50572848]
> （译文）我们团队从一开始就讲得很清楚：第一台设备会是旗舰机。以后计划支持更多设备，我预计会更便宜。

而「便宜」的定义本身在评论区就打了架：

> "Are you calling the Pixel 9a and 10a <i>cheap</i>? Even refurbished, the 9a is <i>twice</i> the price of plenty of perfectly good new phones." — chrismorgan [c:50571448]
> （译文）你把 Pixel 9a 和 10a 叫便宜？就算算二手，9a 的价格也是不少全新好手机的两倍。

### 六、GrapheneOS、/e/OS、LineageOS：路线之争与「别造新的垄断」

讨论里最热闹的一段是三种 Android 替代方案互相拆台。

先说为什么不能联手：

> "Fork Android. Isn't that the only long-term way forward? Create a coalition with e/OS and LineageOS." — mikae1 [c:50571364]
> （译文）fork Android。这不就是唯一的长远出路吗？组一个 e/OS 和 LineageOS 的联盟吧。

立刻有人指出这条路早就断了：

> "I'm pretty sure Graphene nuked that bridge years ago." — RobotToaster [c:50571451]
> （译文）我很确定 GrapheneOS 几年前就把这座桥炸了。

GrapheneOS 的人出来澄清，断的不是 LineageOS 那座桥：

> "I'm not sure why you'd think we have issues with LineageOS." — other8026 [c:50572710]
> （译文）我不明白你为什么会觉得我们跟 LineageOS 有过节。

真正被点名的是 `/e/OS`（Murena）。争议焦点是 microG——它作为 Google 服务兼容层，仍会以特权进程运行 Google 混淆过的 `DroidGuard` 二进制：

> "Murena lies about being degoogled. GrapheneOS solves this the correct way by providing support for sandboxes Google Play." — microtonal [c:50570997]
> （译文）Murena 在「已脱 Google」这件事上撒谎。GrapheneOS 用支持沙箱化 Google Play 的方式给出了正确解法。

有人直接问：既然这套沙箱方案是开源的，为什么没有第二家 ROM 复用？

> "Graphene, AIUI, fixes this by sandboxing Google Play Services so it has no more access than any app. Given the huge obvious advantages, and that their code is open source, why do others not reuse that code to do the same?" — yjftsjthsd-h [c:50571111]
> （译文）Graphene，还有 AIUI，把 Google Play 服务沙箱化，让它的权限不超过任何普通应用。优势这么明显，代码又是开源的，为什么别人不直接复用？

GrapheneOS 的回复带着点无奈：

> "Maybe they want to sell the ‘degoogled’ dream?" — microtonal [c:50571222]
> （译文）也许他们是想卖「脱 Google」这个梦想？

反对 microG 的一方给出的理由更综合：

> "What's the point? If you look at the big picture, microG doesn't offer much in terms of privacy (from what I understand it is (has?) been leaky with things like location, so that's a privacy flaw), but is way less secure and offers far worse app compatibility." — other8026 [c:50572904]
> （译文）这有什么意义？拉远看，microG 在隐私上几乎给不了什么（据我了解它在位置这类信息上一直有泄漏，这是隐私上的硬伤），但安全性差得多，应用兼容性也差得多。

不过「沙箱化 microG」这个折中方案还是有人提：

> "I guess, but then I'd <i>expect</i> the same sandbox could run microG" — yjftsjthsd-h [c:50571327]
> （译文）我猜吧，不过我想同一个沙箱也能跑 microG。

GrapheneOS 方面确认这条路曾经有人走过（DivestOS 做过沙箱化 microG），但同时把话挑明：GrapheneOS 自己不做硬件。

> "GrapheneOS doesn't make hardware, so it's not really up to us. If an OEM makes a device that has those hardware features and meets the requirements, then the device can be supported." — other8026 [c:50572770]
> （译文）GrapheneOS 不做硬件，所以这不由我们决定。如果某家 OEM 做出具备那些硬件特性、并满足要求的设备，那这台设备就能被支持。

最后，路线之争落到一句警告上：

> "Or Lineage, Calyx or eOS. Let's not create another monoculture." — dingaling [c:50571187]
> （译文）或者用 Lineage、Calyx、e/OS。别再造出另一个单一生态。

### 七、要不要自己 fork Android，或者干脆用 Linux

「Android 不够开放，那就 fork 一个」的路线同样有支持者。

> "In Google's eyes, open source was good for Android adoption. Now it's a nuisance at best." — mikae1 [c:50571364]
> （译文）在 Google 眼里，开源曾经有利于 Android 的普及。现在它顶多是个麻烦。

反对者的理由是可持续性——没有 Google 的资源，谁来长期维护：

> "Unless you can commit to fully support the full independently of Google, for ever, I am not sure just forking Android is a good idea." — m4rtink [c:50572908]
> （译文）除非你承诺永远独立于 Google 完整地支持它，否则我不太确定仅仅 fork Android 是个好主意。

他给的替代方案是走 Linux 桌面/移动发行版 + Android 兼容层：

> "This way you have a long term sustainable hardware support model (sharing the effort with all other Linux distro communities) while still supporting the Android apps people care about." — m4rtink [c:50572908]
> （译文）这样你既有了一个长期可持续的硬件支持模型（跟其他 Linux 发行版社区分摊工作量），同时又保留了人们真正在用的那些 Android 应用。

反对者指出这条路在安全模型上会打回原形：

> "Waydroid throws Android's security/sandboxing model under the bus. Also, will run into the same problems, like you cannot pass Play Integrity meeting strong/device integrity." — microtonal [c:50571479]
> （译文）Waydroid 把 Android 的安全/沙箱模型扔到一边。而且会遇到同样的问题，比如你没法通过满足 strong/device integrity 的 Play Integrity 校验。

也有折中派认为可行性比想象中好：

> "You can run Linux on Android phones that have an SoC that supports non-protected VMs (like e.g. Pixel). Since Android 17 even Wayland apps are supported." — microtonal [c:50572780]
> （译文）你可以在支持非保护虚拟机的 SoC（比如 Pixel）上跑 Linux。从 Android 17 开始，连 Wayland 应用都支持了。

至于生态本身：

> "The ecosystem is far too tiny to make this practical for daily driving. Though also without people trying to use it for daily driving, the ecosystem won't move in any significant way. Classic chicken-egg problem." — skeledrew [c:50571207]
> （译文）这个生态还太小，不足以支撑日常使用。但反过来，如果没人拿它日常用，生态也不会有任何实质进展。经典的先有鸡还是先有蛋。

有人把整件事说回 Android 本身：

> "So, Android, in other words. That's Linux for cell phones built properly. The problem isn't Android here, but Google's extensions, or, more precisely, apps that use or enforce those extensions." — drnick1 [c:50571478]
> （译文）所以归根结底还是 Android。那才是被正确造出来的手机版 Linux。问题不在 Android，而在于 Google 的那些扩展，或者更准确地说，在于使用并强制执行这些扩展的应用。

一个简短的纠错也在这里：

> "What do you think GrapheneOS is? Arguably it's more of a fork than LineageOS and e/OS" — akimbostrawman [c:50572895]
> （译文）你以为 GrapheneOS 是什么？可以说它比 LineageOS 和 e/OS 更「分叉」。

### 八、旁支：折叠屏截图，和「我们能要求你」的逻辑

评论区中途拐进一条支线，内容是 Google 要求 Android 开发者支持折叠屏并提交运行截图。

> "If all apps support foldables by default why should I have to submit screenshots of my app running on a foldable? This is clearly authoritarian behavior: we make you do it because we <i>can</i>!" — hn_submit [c:50571376]
> （译文）如果所有应用本来就默认支持折叠屏，我为什么还得提交我的应用跑在折叠屏上的截图？这明显是专横行为：我们让你做，只是因为我们能！

被吐槽的另一件事是这条规则本身站不住：

> "Every single Android app will, by default, support foldables. You have to ACTIVELY take steps to not support them." — well_ackshually [c:50571300]
> （译文）每一个 Android 应用默认都会支持折叠屏。你得主动去做一些事，才算不支持它们。

不过执行层面比想象的松：

> "Google also isn't de-listing apps that don't provide screenshots, they're just not promoting them and you'll have to add screenshots with your next update." — kodebach [c:50571768]
> （译文）Google 也没有把不提供截图的应用下架，只是不给推荐，你下次更新时补上截图就行。

这条支线在讨论里的意义其实超出折叠屏本身：它示范了评论区对「要求你做事」的本能反应。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 走州总检察长 | JumpCrisscross | 写信、附上发帖串，GrapheneOS 该出模板信 |
| 走欧盟 DMA | microtonal | 欧盟公民去联系 DMA 团队 |
| 罚款有效论 | nine_k | Google 会被罚，而且金额可观 |
| 法律要具体化 | dataflow | 得说清违反的是哪条法、怎么违反 |
| 检察官不可信 | testtestmetest | 他们选择了毁掉人生那条路，不是盟友 |
| 国会优先级低 | JumpCrisscross | 短期目标是反垄断小组委员会，但不会是优先项 |
| 现状反例 | acd | Pixel 现在明明还允许解锁 bootloader |
| 时点预言 | skeledrew | 直到 Google 决定不这么做为止 |
| 商业逻辑派 | karel-3d | 这是商业决策，Google 还在做个好生意 |
| 双头垄断论 | leonidasrup | 手机 OS 是 Google 与 Apple 的双头垄断 |
| 技术阻止不了 | YuechenLi | 有 LLM 之后，内核一个 bug 就够解锁 |
| TEE 才是锁 | grishka | 解锁只能拿到临时 root，跟 PS4/PS5 越狱一样 |
| 互联网裂缝论 | m132 | Google 在把互联网撕成可访问和不可访问两半 |
| 裂缝不可逆 | negura | AI 反爬的需求让这条裂缝不会消失 |
| 嵌入式外溢 | Gibbon1 | 以后刷固件得连他们的服务器签名 |
| 换机派 | drnick1 | 我的最后一个 Pixel 是 10a，然后转投 Motorola |
| 开放 Pixel 终结 | Helmut10001 | 该有第三方（Motorola）进来了 |
| 反定时炸弹 | ozlikethewizard | 脱 Google 依赖 Google 硬件，一直是定时炸弹 |
| 要便宜设备 | madduci | 需要支持它的便宜手机 |
| 便宜≠安全 | microtonal | 那个价位没有安全元件，只有 TrustZone |
| 旗舰先行的现实 | other8026 | 第一台设备是旗舰，廉价机型是以后的事 |
| 便宜的标准之争 | chrismorgan | 二手 9a 也要两倍于不少全新好手机 |
| 联盟被否 | RobotToaster | GrapheneOS 几年前就把这座桥炸了 |
| 澄清只针对 e/OS | other8026 | 我们跟 LineageOS 没有过节 |
| 沙箱化正解 | microtonal | Murena 撒谎，GrapheneOS 提供了沙箱化 Google Play |
| 开源方案没人复用 | yjftsjthsd-h | 沙箱方案优势明显又是开源，为什么没人复用 |
| microG 不值得 | other8026 | 隐私上给不了什么，安全性差，兼容性更差 |
| 别造新垄断 | dingaling | 用 Lineage、Calyx 或 e/OS，别再造单一生态 |
| fork 不可持续 | m4rtink | 不能永远独立于 Google 完整支持，就别 fork |
| Waydroid 不安全 | microtonal | Waydroid 把 Android 的安全模型扔到一边 |
| 生态先有鸡先有蛋 | skeledrew | 生态太小，但没人日常用就永远动不了 |
| 折叠屏官僚 | hn_submit | 我们让你做，只因为我们能 |
| 折叠屏规则空转 | well_ackshually | 默认就支持折叠屏，没人主动挡 |
| 情绪：不服就装 | khriss | 我更想装 GrapheneOS 了，就为了跟 Google 拧着干 |
| 情绪：还在 | nzeid | 别输，GrapheneOS 是这几年的新鲜空气 |
| 情绪：别作恶 | DeathArrow / mook / mijowi | 怎么了 / 别作恶 / 「不作恶」已经是 2018 年了 |

## 总体情绪

情绪分得很干脆，但分的方式有点出人意料：争的不是「Google 有没有做这件事」，而是「做了能怎么办」和「不装 GrapheneOS 的话，替代品是什么」。

一派把希望寄托在法律上，另一派把希望寄托在换硬件上。法律那一派的分歧点不在于 Google 能不能被罚，而在于谁来执行、谁来起诉——州总检察长、DOJ、欧盟委员会、DMA 投诉渠道，四条路都被提了一遍，没有一条被认为能在一两年内见效。硬件那一派的分歧点则在于「便宜的替代品」到底存不存在：便宜的机器没有安全元件，有安全元件的机器不便宜，而 GrapheneOS 自己还得先从旗舰机做起。

中间夹着一层更冷的技术判断：就算 bootloader 还解得开，`TEE` 和 `Play Integrity` 也已经把解锁的意义削掉了大半；而 AI 带来的反爬需求，让那条裂缝大概率不会合上。这条线索让讨论从「Google 是不是在作弊」转向了「就算不作弊，趋势也在往这边走」。

还有一小块声音在做相反的事——把它读成一次利好：Google 终于把 GrapheneOS 当成对手了。

> "Now, I'm even more motivated to install GrapheneOS, just to spite Google." — khriss [c:50570677]
> （译文）现在我更想装 GrapheneOS 了，就为了跟 Google 拧着干。

> "Keep fighting the good fight. GrapheneOS has been a breath of fresh air the past several years and I really don't want to go back to manual rooting/debloating/hardening." — nzeid [c:50570689]
> （译文）继续打这场硬仗。GrapheneOS 是这几年来的一股新鲜空气，我可不想回到手动 root、卸载预装应用、手动加固的老日子。

讨论的最后一句玩笑是那三个字的回声：2011 年那封「Don't be evil」至今还有人记得，而 2026 年的版本是「Don't; be evil.」——多出来的分号，就是这五年。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Google is pushing OEMs against GrapheneOS and bootloader unlocking（HN 主帖） | <https://news.ycombinator.com/item?id=50570479> |
| 2 | GrapheneOS 首发帖（2026-11-19 20:40 UTC） | <https://grapheneos.social/@GrapheneOS/117645038299496084> |
| 3 | GrapheneOS：反复联系 OEM 并以 GMS 授权条款施压（2026-11-20 00:23 UTC） | <https://grapheneos.social/@GrapheneOS/117645917131936200> |
| 4 | GrapheneOS：Google 内部有工程师在支持我们 | <https://grapheneos.social/@GrapheneOS/117645042583587277> |
| 5 | GrapheneOS：GMS 授权里有多条违法条款 | <https://grapheneos.social/@GrapheneOS/117645061021012079> |
| 6 | GrapheneOS：希望与 AGToddBlanche 及司法部接触 | <https://grapheneos.social/@GrapheneOS/117645065308754110> |
| 7 | GrapheneOS：预期 Google 会开始锁定 Pixel bootloader | <https://grapheneos.social/@GrapheneOS/117645104633012221> |
| 8 | GrapheneOS：欧盟自己正在推动 Play Integrity API | <https://grapheneos.social/@GrapheneOS/117645276761522463> |
| 9 | GrapheneOS：Play Store 应用保护机制（pairip 等） | <https://grapheneos.social/@GrapheneOS/117645286723920738> |
| 10 | GrapheneOS：对欧盟持续罚款效果的质疑 | <https://grapheneos.social/@GrapheneOS/117645295561402324> |
| 11 | GrapheneOS：关于 Motorola 与 GMS 授权的说明 | <https://grapheneos.social/@GrapheneOS/117647337228275316> |
| 12 | GrapheneOS：关于 Fairphone 的说明 | <https://grapheneos.social/@GrapheneOS/117646937831451705> |
| 13 | Google Play Integrity API 官方文档 | <https://developer.android.com/google/play/integrity/overview> |
| 14 | GrapheneOS：Signature 27 的安全元件说明 | <https://grapheneos.social/@GrapheneOS/117570889454162312> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 379 分、131 条评论，归档快照 2026-11-20 10:59 UTC，入库 100 条，其中一级评论 20 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，引文中的 HTML 标签与实体保留归档原样。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原帖指向的 Mastodon 页面为 JavaScript 渲染，直接抓取正文失败（归档记录 `article.fetch_status: error`，`error: gate: too_short`）。本文「原文概要」中的事实（帖文时间、转发与收藏数、Play Integrity 与欧盟的关系、Play Store 应用保护、Motorola 与 GMS 授权、Fairphone、团队规模与 AOSP 分叉成本等）取自 Mastodon API 返回的同一发帖串，取样时点为 2026-11-20。

文中所述「Google 反复联系 OEM 质问其是否与 GrapheneOS 合作并以 GMS 授权条款施压」，来源是 GrapheneOS 单方陈述，本文未获得第三方记录或独立核实；GrapheneOS 作为直接当事方，其指控的完整性与可诉性均未经独立验证。评论中关于 Google 内部决策、Fairphone 与 Murena 的技术细节等，同样为评论者个人陈述。

文中引用的 `GMS`、`Play Integrity`、`Vanadium`、`pairip`、`TEE` 等术语与接口名称按原文保留；这些机制的具体行为与合规性本文不作独立认定。

评论者对法律途径、硬件选择、系统路线与公司动机的个人判断，按发言者立场转述，不代表本文立场。涉及具体产品与厂商的负面评价（如 `/e/OS`、Fairphone），均转述自评论者或 GrapheneOS 本人，未经独立核实。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
