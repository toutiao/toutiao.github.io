---
layout: post
title: >-
  ZuckOff — 一款反 Meta 智能眼镜的蓝牙探测器引发 HN 大讨论
date: 2026-09-22
hn_id: 49785429
categories: [articles]
excerpt: >-
  30 岁波兰开发者 Pawel Szydlowski 写了一个免费 app，靠厂商 Bluetooth 签名识别房间里的 Ray-Ban Meta、Oakley Meta、Snap Spectacles；HN 讨论迅速分叉——从「Meta 会不会派人来关掉它」一路滑到「为什么我们要用技术解决社会问题」。
tagline: >-
  你以为戴上眼镜没人看见你，其实手机比你先听见。
---
## 原文概要

[ZuckOff](https://zuckoff.app/) 周一在 HN 热门榜上以 587 分冒头，定位是「智能眼镜探测器」。网站由 30 岁波兰开发者 Pawel Szydlowski 单人搭起，免费上架 App Store（一个月内被下载 5000+）和 Google Play（1000+）。逻辑不复杂——Ray-Ban Meta、Oakley Meta、Snap Spectacles 这类硬件在开机、配对、离开充电盒时都会发出 Bluetooth 广播。Szydlowski 买了若干真机，把每一家的 manufacturer ID 录成数字指纹，做成规则表塞进 app：

| 信号 | 含义 |
| --- | --- |
| `0x0D53` | Luxottica：Ray-Ban Meta、Oakley Meta |
| `0x058E` | Meta Platforms Technologies 穿戴设备 |
| `0x03C2` | Snap：Spectacles |
| `0xFD5F` | Oculus VR 注册的 Service UUID |
| Names | Spectacles、HeyCyan、VisionPro、VistaView 等产品名（低置信度） |

[ZuckOff Pro](https://www.wired.me/story/meta-smart-glasses-detector-app-zuckoff) 是付费版，多了连续后台监听、widget、提醒、CSV 导出。Wired 中东版的报道把背景拉到 Meta 智能眼镜本身：[2025 年 Meta 卖出了约 700 万副智能眼镜](https://www.bbc.com/news/articles/cj37z8357e5o)；[BBC 一月的调查](https://www.bbc.com/news/articles/cr7jej2elyyo)追踪到几十个用 Meta 眼镜偷拍的账号，其中一个把一位 21 岁女性的脸和电话号码挂上网，收获 130 万次观看；2026 年 7 月 Meta CTO Andrew Bosworth 在 Instagram 视频里承诺——「我们设计这台相机就是为了被你身边的人注意到」——尽管该产品商业卖点恰恰是「它看起来不像相机」。

讨论的轴心不是 app 本身，而是它把什么问题摆到了桌面上：你的手机能听见有人在戴 Meta 眼镜，但听见不等于知道对方在录；蓝牙信号强度只能给粗略距离，不能给方向；少数型号会保持静默；app 不能告诉你「谁在戴」。换句话说，它把一个隐形问题部分变可见，但可见不等于可控。

## 讨论焦点

### 「Great name」：命名本身就是一种对抗姿态

> "Yes, the name is absolutely a genius move. I would bet my money that there's a dozen lawyers at work, right now, in Meta's HQ, to get a sense of what options they have to harass, shut down, or do something else to the creator of this app. And I would also bet that Zuck is furious about it." — simonebrunozzi [c:49785647]
> （翻译：这个名字绝对是个天才之举。我敢打赌 Meta 总部现在有十几个律师在加班，研究怎么骚扰、关掉、或对这个 app 的作者做点什么。我还愿意赌 Zuck 本人对这事火冒三丈。）

> "You'd be surprised. They banned Christopher Wylie from Facebook. People routinely report their entire team (building some product for Facebook) getting their accounts banned Zuckerberg takes things personally. It's his entire history" — alex1138 [c:49785750]
> （翻译：你可能会惊讶。他们封过 Christopher Wylie 的 Facebook 号。经常有人报告整个团队（给 Facebook 做产品的人）的账号被封。Zuckerberg 把事情往心里去，这贯穿他整个履历。）

> "He's extremely petty and fhin skinned. Remember the seat booster?" — throwaway85825 [c:49785796]
> （翻译：他极度小鸡肚肠、玻璃心。还记得那次增高坐垫的事吗？）

[「ZuckOff」这个名字](https://zuckoff.app)成了讨论的入场券。`simonebrunozzi` 把它读作「公开叫板 Meta 总部」的法律博弈——名字本身就是挑衅，律师团队不可避免。`alex1138` 给出前例：Meta 把 Cambridge Analytica 吹哨人 Christopher Wylie 封号；为 Facebook 做产品的团队整组被封是常态。`throwaway85825` 抛出更早的[「增高坐垫」国会作证旧事](https://www.businessinsider.com/mark-zuckerberg-used-a-booster-seat-to-testify-to-congress-2018-4)——2018 年 Zuckerberg 在国会听证会上用坐垫加高的照片至今还是 HN 段子库里的常驻条目。

`etskinner` 提了一个冷静的反调：「这事可能根本还没进 Zuck 的雷达」——但这反而是另一种意义上的对抗：当巨头没空看你的时候，单兵开发者反而能跑出空间。`Bluestein` 的修辞更戏剧化：「中欧密林深处，一个孤独的开发者为生命而战，对抗死人开关；一周前 NATO 无人机把他的房子碾成玻璃；现在他逃避无人机、狂躁律师、列车事故、Starlink 蜜罐、突然断网、常规蜜罐、下毒威士忌、社交媒体封禁和点踩……」——这段夸张到失真，但说出了开发者社区的本能感受：单点开源工具对抗平台巨头的姿态本身就自带戏剧性。

### 「Bluetooth 信号强度会随距离变大吗」——把探测改造成反击

> "Bring along a small Bluetooth speaker and call out pervs in public!" — Aboutplants [c:49785755]
> （翻译：带个蓝牙小喇叭上街，逮到变态就开喊！）

> "Wait, doesn't it beep for smartphone cameras too?" — amelius [c:49785903]
> （翻译：等等，它不会对智能手机摄像头也滴滴响吗？）

[captn3m0](https://news.ycombinator.com/item?id=49785397) 提了一个直接的应用问题：「蓝牙信号强度变化、相机靠近时它会叫得更响吗？」`Aboutplants` 把这个想法往前推了一步——「带个蓝牙小喇叭上街，逮到变态就开喊！」——把被动探测变成主动喊话。`amelius` 立刻冷静下来：「等等，它不会对智能手机摄像头也滴滴响吗？」这正是 app 设计时**有意规避**的：规则只覆盖已知的智能眼镜 manufacturer ID，不碰通用手机蓝牙。

这条 thread 揭示了一类常见的应用演化路径——用户一开始问「能不能响」，然后「能不能更响」，最后「能不能让我喊」。app 作者大概率不会做这一步，但用户的想象力已经把它推到「公开反骚扰」的边缘。

### ESP32 假 MAC 让探测变玩具？

> "Anyone can get a $5 bluetooth-capable ESP32 and set its bluetooth mac to one in the range used by smart glasses. Not sure why you'd do that though. The other direction is trickier. You'd have to modify the firmware of the smart glasses to set a different mac, or at least gain arbitrary code execution with hardware access on the glasses. That's well beyond what the average smart glass user will do And at that point, it'd be mostly about the heads-up display anyways. Somebody who is determined to record you without your knowledge has far easier paths available to them. Just get one of those lighters or ear-rings or car key fobs with built-in camera" — wongarsu [c:49785828]
> （翻译：随便花 5 美元买个 ESP32，把它的蓝牙 MAC 设到智能眼镜那个区段就行——虽然不知道为啥要这么做。反过来更难：你要改智能眼镜固件换个 MAC，或者至少拿到眼镜硬件层任意代码执行。这远超普通智能眼镜用户能力。而且到那一步，重点也是 HUD 显示了。真铁了心偷录你，根本用不着这么麻烦——打火机、戒指、车钥匙扣里都有摄像头。）

[KellyCriterion](https://news.ycombinator.com/item?id=49785397) 把矛头对准 app 的可靠性：「它说『按厂商签名标记摄像头眼镜』——怎么保证这不会被伪造？」`dubcanada` 反驳：「哪儿写着说能保证？没人能保证。」`wongarsu` 给出技术细节：要让 app 误报很容易——5 美元的 ESP32 改 MAC 就够了；但要让 app **漏报**极难——要改智能眼镜固件，这超出普通人能力。换句话说，ZuckOff 的威胁模型假设是「普通用户戴着合法眼镜在普通场景出现」，在这个范围内它能给出有效提醒；超出这个范围——伪装、改造、绕开——它和任何便宜的探测器一样会失效。

`IAmBroom` 提了更朴素的问题：「你真的担心被一个非主流眼镜品牌偷拍，而不是真 Meta 眼镜？」这其实是 app 设计的核心 trade-off——它选择覆盖已知的主流 manufacturer ID，让规则表可维护；代价是它对长尾山寨眼镜是瞎的。

### 「应该有个 do-not-film-me 标准」——讨论迅速滑向社会议题

> "Reading this inspired me that it would be nice if there were a do-not-film-me standard: your mobile phone sends out a do-not-film-me request with a (rotating) hash of your facial biometrics via Bluetooth. All cameras (glasses, phones, etc.) then blur your face in recordings. Similarly, a venue could request a do-not-film-this-venue setting and make sure no photos are taken at a party." — ldes [c:49785701]
> （翻译：这启发我想到——要是有个 do-not-film-me 标准就好了：你的手机通过蓝牙发出一个「别拍我」请求，里面带一个你面部生物特征的（轮换）哈希。所有摄像头（眼镜、手机等）拍到你时就把你的脸打码。类似地，一个场地可以请求 do-not-film-this-venue 设置，确保派对上没人拍照。）

> "These are social problems not technology problems. We want a society that does not need these workarounds." — kingkongjaffa [c:49785719]
> （翻译：这是社会问题，不是技术问题。我们想要一个不需要这种 workaround 的社会。）

> "Nor should they. Think about it some more. It's all fun and games, until same technology is used against you. There was literally a Black Mirror episode about this very thing." — TeMPOraL [c:49786222]
> （翻译：厂商也不该配合。再想想，这事好玩归好玩，直到同样的技术被用来对付你。Black Mirror 有一集讲的就是这事。）

> "Some people are far too eager to build the Torment Nexus." — cwnyth [c:49786700]
> （翻译：有些人太急着造「折磨装置」（Torment Nexus，Reddit 社区造词，指听起来美好、实际带来灾难的技术）。）

[ldes 的提议](https://news.ycombinator.com/item?id=49785397) 把讨论从「探测」推到「协议」：你的手机广播一个面部生物特征哈希，所有摄像头拍到你自动打马赛克；场地广播一个「禁拍」信号，确保派对上没照片。这听起来像一个非常美好的标准——但讨论立刻分叉。

`kingkongjaffa` 摆出根本立场：「这是社会问题，不是技术问题。我们想要一个不需要 workaround 的社会。」这是整场讨论最常见的归位——把责任推回给社会规范、立法、peer pressure，而不是开发新协议。

`TeMPOraL` 给技术派泼冷水：「再想想，等同样的技术被用来对付你就不好玩了。Black Mirror 有一集讲的就是这事。」`cwnyth` 跟上：「有些人太急着造 Torment Nexus」（Torment Nexus 是 Reddit r/Terminator 等社区流行的概念，指那种「听起来是进步、实际打开地狱之门」的技术）。`kdjdkcneixj` 把它落到现实：「现在你变成了一根会走路的天线，把你的脸/生物识别哈希广播给范围内所有人。光想想它可能被怎么用就比偷拍恐怖多了。」`63stack` 的讽刺最锐利：「好主意，我们还可以在浏览器里加一个标准，告诉别人不要跟踪你。我们可以叫它 Do Not Track 头。简称 DNT。它会确保没网站跟踪你。」

`rickdeckard` 抛出一个旧案例：Apple 有过专利，QR 码会让设备检测到时停止拍摄——本来是给演唱会场馆用的（在舞台贴二维码，把观众引去 iTunes 买歌）。`Aurornis` 进一步补刀：「渲染安防摄像头无用——没法识别罪犯？」、「警察叔叔最喜欢的就是这个——一个关掉所有摄像头周边录像的开关」。讨论到这里已经滑到一个更大的问题：技术解和权力解是同一枚硬币的两面——给个人用的同时，也给想避免被记录的权力方用。

### 「Detect 不可能永远工作：Meta 会改协议」

> "Amazing. But it won't work for long, they'll patch the BT beacons with some "privacy" mode :(" — eqvinox [c:49785717]
> （翻译：真棒。但它干不长，他们会用某个「隐私」模式把 BT 信标补丁掉。）

> "And even if not - could always make another device with the same company ID and flood everyone with false positives." — tkw01536 [c:49785872]
> （翻译：就算不改——也可以造一个带同样 company ID 的设备，向所有人广播假阳性。）

这两条合在一起是 app 长期命运的预测：`eqvinox` 认为 Meta 下一步会在固件里加一个「隐私模式」开关，让智能眼镜默认不再广播可识别的 manufacturer ID——这是一个完全符合 Meta 利益的动作（一边安抚隐私焦虑、一边把探测 app 废掉）。`tkw01536` 给了另一条攻击路径：造一个伪装成 Ray-Ban Meta 的蓝牙设备，对所有装了 ZuckOff 的手机狂发假阳性——app 就会因为「狼来了」失去可信度。

`LightBug1` 给了一个脑洞修复：「v2.0……自动在被拍者脸上投射两根中指，代替原来的脸。」`mrlonglong` 直说「今日最佳笑点」。技术派的修复思路被现实派的 meta-commentary 顶回——当探测变成猫鼠游戏，工程成本会无限上涨，而对手是一家年出货几百万副眼镜的公司。

### 「隐形侵蚀的漫长历史」：paparazzi 到 ring cam 到 Meta

> "First they filmed the celebrities, then the politicians, then the cops, then came the ring cameras. It was a slow erosion over decades, the justification drifting from "they are a public figure" to "they are standing near me" I never knew why the paparazzi could harass celebrities and a few decades later we are all being secretly filmed for a Meta perv database." — hermannj314 [c:49785891]
> （翻译：先拍名人，再拍政客，再拍警察，然后来了 ring doorbell 摄像头。几十年慢慢侵蚀，借口从「他们是公众人物」漂移到「他们站在我旁边」。我一直不理解为什么 paparazzi 可以骚扰名人，几十年后我们都被偷偷拍给 Meta 的变态数据库。）

`asar` 把抱怨定下基调：「一个本不该存在的问题的好解决方案。我们到底是怎么走到默认被随时拍、还不需要事先同意这一步的？」`hermannj314` 给出历史脉络：paparazzi 骚扰名人 → 警察执法记录 → 民众装 ring doorbell 摄像头拍邻居 → Meta 智能眼镜拍所有人——这是一条从「特权」到「默认」的滑坡，每一步都伴随着借口更换。

这条 thread 把 ZuckOff 从技术工具重新定位为社会抗议工具：它不只是一个蓝牙探测器，它是几十年隐私侵蚀史上的一个反击点。`simonebrunozzi` 的「名字是天才之举」在这里获得了第二层意义——「ZuckOff」三个字压缩了整条历史。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 名字是法律战前奏 | `simonebrunozzi` | 十几个律师已经在加班，Zuck 本人会怒 |
| Meta 历史上会封号 | `alex1138` | Christopher Wylie 被封过，做 Facebook 产品的团队整组被封是常态 |
| 增高坐垫玻璃心 | `throwaway85825` | Zuckerberg 把事情往心里去，2018 增高坐垫是前科 |
| 蓝牙小喇叭 | `Aboutplants` | 带个喇叭上街，逮到变态就开喊，把探测变成反击 |
| ESP32 5 美元伪造 | `wongarsu` | 改 MAC 让 app 误报容易，但让 app 漏报极难 |
| 摄像头不只眼镜 | `IAmBroom` | 你真的担心非主流眼镜品牌偷拍，而不是真 Meta 吗？ |
| 社会问题非技术 | `kingkongjaffa` | 应该要一个不需要 workaround 的社会 |
| Torment Nexus | `cwnyth` | 有些人太急着造 Black Mirror 那种装置 |
| DNT 头讽刺 | `63stack` | 「别跟踪我」头当年也是好主意，然后呢？ |
| 警察用上更糟 | `Aurornis` | 一个关掉摄像头周边录像的开关——警察叔叔最爱 |
| Meta 会打补丁 | `eqvinox` | 下一步固件加「隐私模式」，app 就废了 |
| 假阳性洪水 | `tkw01536` | 造伪装设备狂广播假阳性，让 app 失去可信度 |
| 隐形侵蚀历史 | `hermannj314` | paparazzi → ring cam → Meta，借口从「公众人物」漂到「站在我旁边」 |
| App 是抗议工具 | `asar` | 一个本不该存在问题的解决方案 |

## 总体情绪

讨论的情绪光谱从「戏剧化娱乐」一路滑到「严肃焦虑」并存。前半段集中在 app 本身——名字、规则表、价格、能不能用——是工程和产品视角的常规讨论；后半段迅速被 [ldes 的 do-not-film-me 提议](https://news.ycombinator.com/item?id=49785397) 拉进一个更大的命题：探测是治标，标准是治标+治本的尝试，但标准本身又会被反向利用。

整场讨论最深的一刀是 [wongarsu 的威胁模型分析](https://news.ycombinator.com/item?id=49785397)：app 能挡住普通用户戴合法眼镜在普通场景出现，但它挡不住 ESP32 改 MAC，也挡不住 Meta 固件升级，也挡不住隐藏式摄像头。探测器的真正价值不在于「万无一失」，而在于「让隐形问题部分变可见」——这是 Wired 文章的判断，也是 ZuckOff 自己的判断（app 写明：「quiet is not proof that nobody is recording, and a detection is not proof that anyone is」）。

底层情绪可以概括：ZuckOff 不是终点，是几十年隐私侵蚀史上的一个反击标记——它的名字、它的免费策略、它的开发者单兵姿态，都是这条历史线上的一次具体表达。HN 把它当成一周一次的奇观，但奇观里每一个细节（700 万副眼镜、130 万次观看、5 美元 ESP32、0x0D53 manufacturer ID）都是隐私讨论必须认真对待的硬数字。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | ZuckOff Know when a camera is in the room（主帖） | https://news.ycombinator.com/item?id=49785429 |
| 2 | ZuckOff Is a Free App That Sees Meta Glasses Before They See You（Wired 报道） | https://news.ycombinator.com/item?id=49785397 |

## 免责声明

本文由 AI 辅助生成，所有引文均来自 HN 评论区原始记录。观点不代表原作者完整立场。涉及第三方（Pawel Szydlowski、Mark Zuckerberg、Andrew Bosworth 等）的描述均基于公开报道与 HN 评论中提到的链接，不代表本平台对相关人物的判断。

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3
</div>
