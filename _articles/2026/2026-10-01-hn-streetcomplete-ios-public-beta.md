---
layout: post
title: >-
  StreetComplete 把「地图答题游戏」搬上 iOS 了 — HN 讨论摘要
date: 2026-10-01
hn_id: 49920160
categories: [articles]
excerpt: >-
  那个把 OSM 街景编辑变成「回答问题就能改 OpenStreetMap」的 Android 神器，终于用 Kotlin Multiplatform 完成了 iOS 公测；HN 有人 5 分钟贡献了比过去 15 年还多的内容，也有人为找不到 TestFlight 链接急得转圈。
tagline: >-
  5 分钟改的街景比过去 15 年加起来都多，OpenStreetMap 终于等到它的「答题游戏」上 iPhone。
---

## 原文概要

[主帖](https://news.ycombinator.com/item?id=49920160) 链接到 StreetComplete 在 GitHub 上的 master issue [#5421《iOS - Testing! :-D》](https://github.com/streetcomplete/StreetComplete/issues/5421)，由 Snowly 4 小时前发出，4 小时内冲到 273 分、59 条评论。StreetComplete 仓库同时显示 Star **4.9k / Fork 456**。

[StreetComplete](https://github.com/streetcomplete/StreetComplete) 是一款**面向不懂 OSM 标签规则的人**的 OpenStreetMap 编辑器：在地图上看到「这条路叫什么」「这块路面是什么」「立面活哪一侧有侧道」的问答式任务（quest），点击标记回答单选或填空，答案会自动打包成 OSM changeset 推上去。仓库原文把它称作「The barrier to contribute is brought to nearly zero」——用户在 Android 端的真实评论是「contributed more to open street map in 5 minute than I have in 15 years」（smcleod）。

iOS 移植的关键技术事实——issue 里写得非常工程化：

- 整个代码库 **100% Kotlin**，iOS 版用 **Kotlin Multiplatform** 实现跨端；UI 用 **Compose Multiplatform**（Jetpack Compose 的 fork，目前 iOS 端处于 alpha beta），响应式框架，UI 全在代码里。
- 与 Every Door（用 Flutter 重写成 Dart）相比，**保留 Kotlin 单 codebase**，后续维护成本不会显著上升——这是项目维护者 Tobias Zwick（westnordost）反复强调的最大动机。
- 2024 年 3–8 月由**德国联邦教研部（BMBF）的 Prototype Fund round 15** 全额赞助，NLnet 也参与；issue 明确致谢。
- 预计总工作量约**一人年**，作者粗估迁移已完成约 **50%**；原 issue [#1892](https://github.com/streetcomplete/StreetComplete/issues/1892) 已经沉淀了好几年的调研和讨论，#5421 是后续 master issue。
- iOS 公测链接（评论里被反复转贴）：[TestFlight `K1u3eUU5`](https://testflight.apple.com/join/K1u3eUU5)。

## 讨论焦点

### TestFlight 入口是个隐藏关卡

公告页没有把 TestFlight 邀请链接放在显眼位置，于是 HN 评论区最先爆发的不是技术讨论，而是**寻找入口**。

> "Link to the actual TestFlight beta invite, since it wasn't easily found on the linked page: https://testflight.apple.com/join/K1u3eUU5" — greggsy [c:49920335]
>
> （译文：贴一下 TestFlight 邀请的真链接，主页上不好找。）

> "Thanks. If anyone from StreetComplete is watching - please put the TestFlight link prominently on your page!" — cbeach [c:49921715]
>
> （译文：谢了。如果 StreetComplete 团队在看——请把链接放到显眼位置！）

aquova 给出一条**几乎所有人都没意识到**的解释——TestFlight 对一个 beta 安装人数是有硬上限的，公开链接一旦发出去就会被测试期覆盖上：

> "I wonder if it's by design. TestFlight apps have a hard user install limit, I remember waiting around for someone to leave previous betas to try them out." — aquova [c:49922423]
>
> （译文：我猜这是有意为之。TestFlight 的安装人数有硬上限，我之前为了进一个测试版还特意等他们腾位子。）

这意味着 greggsy 抱怨的「找不到」背后可能不是营销疏忽，而是 Apple 平台机制本身在抑制公开散播——这也解释了为什么链接要靠评论里的热心人转贴。

### 公共资金撑起了这次跨平台移植

Fnoord 把 issue 里那段致谢单独拎出来——iOS 版**不是**个人英雄主义产物，是公共资助下的开源协作：

> "Thank you, German government: > Within the frame of Prototype Fund round 15 (March 2024 to August 2024), the German Federal Ministry of Education and Research sponsored Tobias Zwick to work on StreetComplete for iOS (see progress report) And NLnet." — Fnoord [c:49921800]
>
> （译文：感谢德国政府：> 在第 15 轮 Prototype Fund（2024 年 3 月至 8 月）框架下，德国联邦教研部资助 Tobias Zwick 开发 StreetComplete 的 iOS 版本（见进展报告）。还有 NLnet。）

morsch 顺着这条线把同资助体系的另一个 OSM 项目挖出来——一个**把 OSM 数据实时渲染成可探索 3D 街景**的 demo：

> "I was curious what they're currently sponsoring; here's another neat OSM project: https://osm2world.org/demo/?lat=52.5239396&lon=13.4104859&ra... The current demo doesn't seem to cover many places worldwide, but what is there is really neat! To me this already looks better than modern city sim games, because they never seem to get the scale right, among other things." — morsch [c:49922144]
>
> （译文：我好奇他们最近在资助什么；这里还有一个很棒的 OSM 项目（osm2world.org demo）。demo 目前覆盖的地方不算多，但已经出来的部分比现在的城市模拟游戏**漂亮多了**——那些游戏从来都搞不对比例。）

这条线让讨论的「移植到 iOS」从一个开发者个人项目，升格成「国家级开源基础设施投资的一部分」。

### Kotlin Multiplatform 的实战体感

intrasight 抛出工程界最常见的拷问——Kotlin Multiplatform 真到生产可用了吗？

> "I'd like to hear more about people's experiences with Kotlin Multiplatform" — intrasight [c:49920302]
>
> （译文：想多听听大家用 Kotlin Multiplatform 的真实体验。）

回答来自**项目作者本人** westnordost：

> "Overall, my experience has been pretty smooth. Just look at how little platform specific code is found in the streetcomplete repo and how straightforward these connect with the common code. Or maybe I have been using it too long so that I don't notice the awkward bits anymore. Any specific parts you are after?" — westnordost [c:49921741]
>
> （译文：总体体验相当顺畅。看看 StreetComplete 仓库里平台特化代码的占比就知道，桥接代码和共享代码的衔接非常自然。当然也可能是用得太久，已经感受不到别扭的地方了。你具体想了解哪块？）

这条**开发者现身说法**是讨论里少见的工程干货：Compose Multiplatform iOS 端还处于 alpha beta，但「几乎没有平台特化代码」已经能跑出一个完整的地图 1 任务编辑器。对那些正在评估 KMP 替代 Flutter / React Native 的团队，这是一个具体可量化的样本。

### iOS 的"答不上来"困境

讨论里最长、最支也最有可读性的支线——**问题本身做不对**。dmd 拿到一道侧道题，三个选项都不对：

> "Maybe I don't understand how it's supposed to work, but the very first question I was given had three choices and none of them were correct. What are you supposed to do then?" — dmd [c:49921134]
>
> （译文：可能我没搞懂该怎么用，但给我的第一个题三个选项都不对。怎么办？）

boredinstapanda 的标准答案是「taptitude uh... 留 note」——但 dmd 第二次试时根本没找到这个选项：

> "No, there's only the listed options (street has a sidewalk, or it doesn't - no option for 'sidewalk extends for half the street but not the other half'). I don't know if that counts as it does or it doesn't." — dmd [c:49921399]
>
> （译文：不行，只有列出的选项（侧道有 / 侧道没有——没有「侧道只在半条街上」这一项）。我也不知道这算有还是没有。）

westnordost 作为作者给出一个**精确的解法**——但要按到正确的位置：

> "In this case, the intended flow is that you tap 'Uh...' -> 'Differs along the way...' You will then be led to another UI in which you can split the road into several sections." — westnordost [c:49921691]
>
> （译文：这种情况下，正确流程是点「Uh...」→「Differs along the way...」，会进入可以把道路切成几段的 UI。）

> "Aha. If you click 'Uh' exactly on its text, it works. If you click even one pixel away from the actual text, you get the chooser with not enough options." — dmd [c:49921743]
>
> （译文：哦，明白了。**点 'Uh' 文本正中才能触发**，偏离一个像素就会弹出选项不够的对话框。）

Dunedan 把这件事钉到平台差异上——**Android 端有专门的"dash for whole street / half / no"**按钮，iOS 上是埋在二级菜单里的：

> "I can tell for sure the current version of StreetComplete for Android does allow specifying that only one side of the road has a side walk. I solved a few of these quests just last week. No idea what's the state on iOS though." — Dunedan [c:49921635]
>
> （译文：可以确认 Android 版的 StreetComplete 现在能指定只有单侧有侧道，上周我才做完几道这样的题。iOS 上的状态不清楚。）

这条线暴露的是 iOS 版的**功能差距**：50% 迁移意味着「日常用版」还没完全对齐。

### "Uh..." 手势是个隐藏教程

thrownawaysz 抛出另一条 iOS 专属体验——**连「退出当前问题」都不直观**：

> "> Known caveats (we are working on it): > forms can only be canceled with the back gesture rather than clicking anywhere on the map Well for me not even the back gesture works, I just have to force close the app if I don't want to answer a survey lol" — thrownawaysz [c:49920557]
>
> （译文：> 已知问题（正在修复）：> 取消表单只能用 back gesture，不能点地图空白处取消。对我而言 back gesture 也不管用，不想答题就只能强退应用。）

dewey 解释要练，rgehan 终于搞明白——**从屏幕最边缘左向右滑**：

> "I might be dense, but what's the back gesture exactly? EDIT: Got it, swiping from left to right, starting from the very border of the screen. Not super intuitive but simple enough" — rgehan [c:49921193]
>
> （译文：我可能有点钝，back gesture 具体是什么？编辑：搞明白了，从屏幕最左边缘向右滑——不太直观，但够简单。）

ocdtrekkie 的反应是讨论区里最 HN 风格的吐槽——**用了七年 iOS 都不知道有这个手势**：

> "I've been on iOS for like seven years and have never done this. But... hey, it works!" — ocdtrekkie [c:49922271]
>
> （译文：用 iOS 七年了，从没做过这个手势。但是……嘿，**真的有效**！）

「不是数字的东西」——**这是 back gesture 这个名字的字面误读**：在 iOS 语境下 back gesture 既不是双指也不是下拉，而是一个**没有任何视觉提示**的边缘滑动。StreetComplete 把"退出"绑定到一个多数 iOS 老用户都不知道的手势上，等于把"误点报警"和"找不到出口"两个问题撞在一起。

### 改错怎么办——撤销机制在三个不同的地方

Loic 提出了一个所有 OSM 贡献者都会遇到的具体问题——**改错了再回不去了**：

> "The only one thing missing for me is a small history of my past contributions. At some point, I made a mistake and entered the wrong information (nothing terrible, the surface of a walkway, it was 30% one surface, 70% another, I gave the 30% value instead of what I think 70% would be better). I would have been glad to be able to quickly 'revert' this contribution." — Loic [c:49920713]
>
> （译文：我唯一缺的是一个我的历史贡献列表。有次我填错了（小事，路面铺装，一条 30% 一条 70%，我把 30% 写成了我以为该填的 70%）。我本来很希望能快速「revert」这一笔。）

PetPrince 指路到 OSM 官网：

> "If you go to the OSM website, you can sort of get list of all your modification by date in your profile: https://www.openstreetmap.org/user/YOUR_USERNAME" — PetitPrince [c:49920774]
>
> （译文：去 OSM 官网的用户页面，能按日期看到你所有的改动。）

precommunicator 和 westnordost 本人分别告诉社区 StreetComplete **应用内**就有撤销——左下角小箭头：

> "you can revert immediately in bottom left corner of StreetComplete, click on little revert arrow" — precommunicator [c:49920866]
>
> （译文：在 StreetComplete 左下角可以立刻撤销，点那个小撤销箭头。）

> "There is an undo button on the lower left corner of the screen. Try it! (It only shows edits made in the last 24 hours IIRC, but this limit is chosen quite arbitrarily. If there is a use case for it, it can be extended.)" — westnordost [c:49921626]
>
> （译文：左下角有撤销按钮。试一下！（我记得只显示过去 24 小时的编辑，这个上限是任意定的，有用例支持可以放宽。）

westnordost 这条回答同时揭开了开发者的一个**心路历程**——**24 小时只是"任意定的上限"**，并没有工程上的硬理由。这正是 Loic 想要的"历史贡献列表"的弱化版：

> "There is actually an edit history, the little arrow icon on the map pulls up your recent edits and lets you undo them." — sparrowidle [c:49920943]
>
> （译文：其实是有编辑历史的，地图上那个小箭头图标会拉出你最近的编辑，允许撤销。）

progbits 把撤销和「拆道路」功能接上——这正是 dmd 那条线提到的功能：

> "> I think 70% would be better You can actually split the road into multiple segments and answer each separately if you don't mind the extra effort. I think there should be something like 'differs along the way' button which then asks you to pick a point where to cut." — progbits [c:49921955]
>
> （译文：> 我觉得 70% 更对。其实你可以把道路切成几段，一段一段答，不嫌麻烦就行。我觉得应该有一个「differs along the way」按钮，按下后让你选一个切分点。）

这条线串起了三件看起来不同的事——**撤销**（Loic 想要）、**拆道路**（dmd 想要的）、**历史**（westnordost 承认是任意 24 小时）——它们其实是同一件事的三个面向：**让贡献者能诚实地犯错，再诚实地纠正**。StreetComplete 已经做了撤销（verifiable 存在）、但 24 小时限制是开发者承认的武断决定。

### StreetComplete vs EveryDoor vs Go Map!!——三角对比

tbo47 的对比是**功能定位**：

> "I tried both StreetComplete and EveryDoor on my Android for a while. I prefer EveryDoor. It's oriented more towards stores and things I'm interested in on the map. EveryDoor exist on the Apple store too." — tbo47 [c:49920741]
>
> （译文：Android 上 StreetComplete 和 EveryDoor 都用过一段时间。我更喜欢 EveryDoor。它更偏向于商店和我感兴趣的地图元素。EveryDoor 在 Apple Store 也有。）

rafram 把 EveryDoor 的最大缺点直接说出来——**UI 不直观**：

> "Every Door has a very confusing UI (lots of unlabeled buttons with unclear icons), unfortunately. I would love to use it, but even the web-based iD editor is so much easier to figure out!" — rafram [c:49921200]
>
> （译文：Every Door 的 UI 让人很抓狂，laughing 一堆没标签的按钮配不清晰的图标。我很想用它，但即便网页端的 iD 编辑器都比它好懂。）

westnordost 给 EveryDoor 平反——**你没找到对的功能区**：

> "Have you tried out the Things or Places overlay? Second button from the right at the top, looks like a cake." — westnordost [c:49921792]
>
> （译文：试过 Things 或 Places 覆盖层了吗？右上第二个按钮，看着像个蛋糕。）

abdullahkhalids 把 StreetComplete 的杀手锏抛给 tbo47——**可筛选题目类型**：

> "You can choose the type of questions you want to get asked about in StreetComplete. If you want to only enter store names and timings, then go into Settings and pick those." — abdullahkhalids [c:49922259]
>
> （译文：在 StreetComplete 里可以选你被问的问题类型。如果只想填店名和营业时间，去设置里勾选。）

SomeonesAccount 把 StreetComplete 的名字**重新解释**——它不只是街道数据，remedan 立刻补一刀：

> "StreetComplete, as indicated by it's name, is about street data. Both are for contributing to OSM, but they are for different parts of OSM" — SomeonesAccount [c:49920795]
>
> （译文：StreetComplete，顾名思义，关于街道数据。两个都是为 OSM 做贡献，但面向 OSM 的不同部分。）

> "StreetComplete asks about things other than street data as well. For example, I get queries about operating hours of businesses." — remedan [c:49921149]
>
> （译文：StreetComplete 也会问街道以外的事。比如我被问过商铺的营业时间。）

mbirth 把第三个对手**Go Map!!**带进来——Quests 覆盖层，连图标都一样，只是没有图例：

> "OSM editor Go Map!! also has a 'Quests' overlay that is very similar to Street Complete (even uses the same icons). And you can also define custom quests for data you want to easily gather. However, it's lacking the nice example pictures for each option - so, with Go Map!! you need to know what you're doing." — mbirth [c:49922010]
>
> （译文：OSM 编辑器 Go Map!! 也有一个「Quests」覆盖层，跟 StreetComplete 非常像（甚至用了同样的图标）。你还可以自定义 quest 来轻松收集你想要的数据。缺点是没有每个选项的示例图片——用 Go Map!! 你得**自己知道你在干什么**。）

这条线把"问答游戏"从 StreetComplete 的独家卖点变成了**OSM 移动编辑的事实模式**——三个 app 用同样的图标、同样的玩法，而 iD 编辑器反倒是少数派。

### OSM 是不是 Google Maps 的替代品

conartist6 抛出一个**几乎每个 OSM 新人都会问**的问题。

> "Can you use OpenStreetMap like Google Maps? I tried to use it to list restaurants but the UI reacted like nobody had ever tried that before" — conartist6 [c:49920357]
>
> （译文：能把 OpenStreetMap 当 Google Maps 用吗？我试着列餐厅，UI 反应像从来没人这么用过。）

flexagoon 给出最简短也最重要的回答——**OSM 是数据库，不是地图应用**：

> "OpenStreetMap is a database, not a map application. The map on the official openstreetmap website is more of a demo to show some of the data. There are many different map apps that use OpenStreetMap data though." — flexagoon [c:49920550]
>
> （译文：OpenStreetMap 是**数据库**，不是地图应用。官方 openstreetmap 网站上的地图只是数据的一个 demo。但有很多不同的地图应用用 OSM 数据。）

mbirth 推荐了一长串基于 OSM 的应用——cartes.app、OsmAnd、Magic Earth、TomTom、Scenic——并强调**导航** OsmAnd 也能做：

> "https://cartes.app is trying to do this. OsmAnd is quite usable as well. For navigation there's Magic Earth (can route around traffic jams), TomTom, and Scenic. OsmAnd can also do routing." — mbirth [c:49921953]
>
> （译文：cartes.app 在试这条路。OsmAnd 也相当可用。导航的话有 Magic Earth（能绕堵）、TomTom、Scenic。OsmAnd 也能算路径。）

westnordost 自己推荐**网页端**——osmapp.org 和 cartes.app：

> "For the web, I personally like https://osmapp.org https://cartes.app I can also recommend. Both projects have a similar goal, to offer a more useful UI around using an OSM based map." — westnordost [c:49921885]
>
> （译文：网页端我个人喜欢 osmapp.org，cartes.app 也可以推荐。两个项目目标类似——给基于 OSM 的地图提供一个更有用的 UI。）

mbirth 顺手把 osmapp.org 和英国的 Ordnance Survey 区分开——名字相近、用途不同：

> "It's https://osmapp.org - as in OsmAPP. Not to be confused with https://osmaps.org, the Ordnance Survey Maps." — mbirth [c:49921973]
>
> （译文：是 osmapp.org——OsmAPP。别和 osmaps.org（英国 Ordnance Survey 的地图）搞混。）

unfocso 把 TomTom 拉出来当作**目前最不踩坑的方案**：

> "Partly, with Organic Maps or CoMaps. However, in my opinion TomTom is still the best way to use OpenStreetMap for navigation since it combines OSM data with their own real time traffic information without dark patterns or asking for an account like Waze or Maps do." — unfocso [c:49920544]
>
> （译文：部分场景可以用 Organic Maps 或 CoMaps。但我的看法是 TomTom 仍然是导航场景下用 OSM 的最佳方案——它把 OSM 数据和自己的实时路况信息结合，没有 Waze 或 Maps 那种 dark pattern，也不强求账号。）

xd1936 一句话问穿 TomTom 的本质——**底图是 OSM 还是他们自己的私有图层**：

> "Is TomTom's basemap entirely OpenStreetMap? Or do they add their own proprietary layer of map data on top?" — xd1936 [c:49920991]
>
> （译文：TomTom 的底图完全是 OpenStreetMap 吗？还是他们在上面加了一层私有数据？）

unfocso 自己答了——**混合**：

> "It's a... mix. I can see all the shapes of the roads and areas i mapped in my area, but they seem not to trust OSM naming so they either have no name or the name TomTom gave to the equivalent street. ... It's explicitly advertised for driving, not walking, so it's optimized to get you to places." — unfocso [c:49922118]
>
> （译文：是 mix。我能看到我自己画的所有道路和区域的形状，但他们似乎不太信任 OSM 的命名——要么没名字，要么就用 TomTom 给同一段路的命名。……它明摆着是给开车用的，不是步行，所以优化目标是「把你送到」。）

drcongo 顺手拆 TomTom 的台——**CarPlay 集成有大 BUG**：

> "I tried the TomTom app (on iOS) recently but found it incredibly buggy, especially when connected to CarPlay. The speed indicator would often just show 1mph, the dark mode would work about 20% of the time, and searches would show results from other countries ahead of a place 4 miles up the road." — drcongo [c:49921031]
>
> （译文：最近试了 TomTom iOS 应用，BUG 非常非常多，尤其是接 CarPlay 时。速度显示经常卡在 1mph，暗色模式只有 20% 概率生效，搜索时别的国家的结果排在本地 4 英里外那个地方前面。）

pkthunder 把讨论引向个人偏好——**逃离 Apple Maps，奔向 OSM**：

> "I'm trying to get off of Apple Maps and into OSM (using Magic Earth as my navigation app) - seeing more OSM work is exciting. Now I need to figure out if it's possible to merge my navigation maps with the deflock maps.." — pkthunder [c:49922150]
>
> （译文：我在试着从 Apple Maps 转 OSM（用 Magic Earth 当导航应用）——看到 OSM 有新进展很兴奋。现在我得搞清楚能不能把导航地图和 deflock 地图合并。）

这条线把讨论从「StreetComplete 是不是好用」拉到一个更大的「OSM 移动生态」全景——**底层数据是同一个，但前端从 EveryDoor 到 OsmAnd 到 TomTom 到 Magic Earth 各自定位不同**。

### "5 分钟比过去 15 年贡献都多"——口碑的自爆

最有传播力的一条评价来自 smcleod：

> "That's legitimately a good idea. I just contributed more to open street map in 5 minute than I have in 15 years." — smcleod [c:49920727]
>
> （译文：这是个好主意。我刚刚在 5 分钟里对 OSM 做的贡献，比过去 15 年加起来还多。）

这不是营销话术——这正是 issue 标题里写的「barrier to entry is brought to nearly zero」的具象版。另一paul 也给出了一个具体数字——**几个公共厕所 + 一条小路**：

> "StreetComplete is great. For me it made Openstreetmap much more approachable and now thanks to me there are a few more public toilets and one small road in osm. Especially with the road it was really interesting to see how quickly Google maps also took in this path. But they still also have the old road in the app. So it's linked but not 100%" — anotherpaul [c:49920330]
>
> （译文：StreetComplete 很棒。它让 OSM 对我变得亲民，现在 OSM 上多了一些公共厕所和一条我加的小路。路那条特别有意思——Google Maps 几乎立刻就把这条路收了进去。但他们应用里还留着旧路。所以**是连上了，但 100% 不算**。）

最后一句是个**典型的 OSM-vs-商业大厂**的小故事——OSM 上画的路被 Google Maps 拉走，但 Google Maps 自己的旧路还在；它们不是真合并，只是各画各的，最终结果一致。

### Gateway 警告

bjoli 给所有新用户提了一个**善意的警告**——StreetComplete 是更重度编辑的入门毒品：

> "I feel I must warn you. It is a gateway to more heavy map editing using the online editor or tools like Vespucci." — bjoli [c:49921570]
>
> （译文：我得警告你。这是 StreetComplete 导航页。它**是路上最容易让人入门的毒品**——用过就会想用在线编辑器或 Vespucci 干更重的活。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| TestFlight 邀请不好找 | greggsy [c:49920335] | "主页上不好找，贴个真链接。" |
| TestFlight 安装人数有硬上限 | aquova [c:49922423] | "我之前为了进一个测试版还等过腾位子。" |
| iOS 版由德国 BMBF + NLnet 资助 | Fnoord [c:49921800] | "感谢德国政府，第 15 轮 Prototype Fund。" |
| 同资助体系下还有 osm2world 3D | morsch [c:49922144] | "看着像比 city sim game 更准确，比例终于对了。" |
| Kotlin Multiplatform 体验顺畅 | westnordost [c:49921741] | "几乎没有平台特化代码。" |
| 第一题三个选项都不对 | dmd [c:49921134] | "怎么办？" |
| 答案藏在 "Uh..." 文本正中 | westnordost [c:49921691] / dmd [c:49921743] | "偏离一个像素就弹出选项不够的对话框。" |
| Android 有专门拆道路，iOS 没有 | Dunedan [c:49921635] | "上周我才做完几道这样的题。" |
| back gesture 连知乎不知道 | ocdtrekkie [c:49922271] | "用了七年 iOS 从没做过这个手势。" |
| 撤销在左下角，24 小时是任意定的 | westnordost [c:49921626] | "这个上限可以放宽。" |
| StreetComplete vs EveryDoor UI 难懂 | rafram [c:49921200] | "一堆没标签的按钮配不清晰的图标。" |
| StreetComplete 可筛问题类型 | abdullahkhalids [c:49922259] | "在设置里勾选你想被问的题。" |
| OSM 是数据库不是地图应用 | flexagoon [c:49920550] | "官方地图只是数据 demo。" |
| 网页端推荐 osmapp.org / cartes.app | westnordost [c:49921885] | "两个项目目标类似，给 OSM 提供更有用的 UI。" |
| TomTom 底图是混合 | unfocso [c:49922118] | "我用我自己画的形状，他们用他们自己的命名。" |
| TomTom CarPlay 有大 BUG | drcongo [c:49921031] | "速度显示经常卡在 1mph。" |
| 5 分钟贡献比 15 年都多 | smcleod [c:49920727] | "我刚刚在 5 分钟里做的贡献比 15 年加起来还多。" |
| Google Maps 立刻吃了 OSM 新路 | anotherpaul [c:49920330] | "是连上了，但 100% 不算。" |
| StreetComplete 是更重度编辑的入门毒品 | bjoli [c:49921570] | "用过就会想用 Vespucci。" |
| 小学 Wikipedia 也能学 | amenghra [c:49920315] | "Wikipedia 第一次编辑也很吓人。" |
| Wikipedia 没那么怕 | kccqzy [c:49920902] | "格式写错也有人来 fix。" |

## 总体情绪

整场讨论的真正主角不是「StreetComplete」如何好用，而是「**如何降低一个公共数据基础设施的贡献门槛**」。HN 这次讨论里最常被引用的不是代码，不是 Compose Multiplatform 迁移路径，而是两段用户读到的「5 分钟」「比过去 15 年贡献都多」的具象数字——这些数字把 StreetComplete 钉在了「公民贡献物品」的位置上，与 OpenStreetMap 本身「**让所有人都能编辑地图**」的原始口号完全对齐。

讨论里最有诊断价值的一段是 dmd 和 westnordost 之间关于「侧道一半有」的拉锯——用户拿着三个选项找不出正确答案，开发者解释要按「Uh...」正中那一像素、再选「Differs along the way」、再切道路。**这条操作路径揭示了 StreetComplete 在 iOS 上还没完成的 50%**：把 Android 上「单选/拆道路/留 note」三个独立入口整合到一个统一 UI。开发者本人对 24 小时撤销上限的「这个是任意定的」承认，则是另一个信号——**功能地图已经把「好人不会改错」当作前提**。

讽刺的注脚来自 unfocso 关于 TomTom 的回答——OSM 道路的形状被 TomTom 拉走，但 OSM 道路的命名被 TomTom 替换；数据来源是同一个，但呈现层各管各的。「OSM 是不是 Google Maps 替代品」这个问题本身就是错位的——**OSM 是后端的公共物品，前端永远不会只有一家**。StreetComplete 解决的是后端贡献的门槛，conartist6 想要的是前端呈现的整合——这两条线其实指向同一个未解的问题：**什么时候会出现一个既能用 StreetComplete 贡献、又能在日常通勤中替代 Google Maps 的应用**？今天还看不到。

最后那条 bjoli 的 Gateway 警告——「用过就会想用 Vespucci」——其实是 StreetComplete 最成功的故事：**它做到了让用户进入更重度编辑，而不是把他们锁死在一个轻量游戏里**。这是 iOS 版所有 BUG、所有 UI 不到位的对立面——**它给用户的不是终点，是入口**。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | StreetComplete on iOS is now in public beta | https://news.ycombinator.com/item?id=49920160 |
| 2 | iOS - Testing! :-D（master issue） | https://github.com/streetcomplete/StreetComplete/issues/5421 |
| 3 | TestFlight 公测链接（评论转贴） | https://testflight.apple.com/join/K1u3eUU5 |

<div class="disclaimer">

本摘要由 AI 模型辅助生成，仅供了解 HN 讨论脉络之用，文中观点不代表本站立场。引文均为 HN 用户公开发表的评论，按 Creative Commons CC-BY 引用；译文仅供参考，可能与原文语气有出入。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>