---
layout: post
title: >-
  想要不偷窥的电视？HN 的答案是：别买电视 — HN 讨论摘要
date: 2026-11-02
hn_id: 50328896
categories: [articles]
excerpt: >-
  一个 409 分的 Ask HN 问有没有不偷窥的电视。537 条回复给出的方案高度一致：
  买一块不联网的屏，再接一个盒子。真有人把路由器的 MAC 封了，有人拆了
  无线天线，还有人打算靠 2010 年的旧电视过日子。
tagline: >-
  花三千块买电视，最后只用它的 HDMI 口。
---

> 来源：HN 讨论帖，提交者 LecroJS。帖子：[Ask HN: Which TV do you recommend for privacy?](https://news.ycombinator.com/item?id=50328896)，409 分，537 条评论（抓取时快照）。

## 原文概要

提问者的需求很具体。他想要一台 60 到 80 寸、4K、至少 60Hz 的电视，不在乎贵，但要求它尊重隐私。他自己已经听说 Apple TV 比电视自带的 app 更值得信任，所以设想的方案是：电视只当显示器，内容全部交给 Apple TV。

> "I haven’t owned a TV in years and would like one that respects my privacy. Are there any TV’s which do this well? I am looking for something in the 60”to 80”range and would like a 4k display with at least 60hz display. I don’t mind paying a premium." — LecroJS [c:50328896]
> （译文：我好几年没买过电视了，想要一台尊重我隐私的。有没有做得比较好的？我想要 60 到 80 寸的，4K 面板，至少 60Hz。我不介意多付钱。）

帖子发在 2026-11-01 19:35 UTC，抓取时 409 分、537 条评论，顶层评论就有 166 条。讨论没有停在「推荐哪台电视」，而是变成了一场关于「隐私到底要防到哪一层」的辩论：要不要接网线、要不要拆硬件、吓人的那部分说法有没有证据、断网之后还能不能信这台机器，以及一个绕不开的现实问题——照做的话，谁来维护。

## 讨论焦点

### 一、共识：电视是显示器，盒子才是主机

被反复复述的答案不是某个型号，而是「别让电视上网」：

> "I went and researched this, and found that basically none of the TV brands were anything but creepy on privacy." — epwr [c:50329201]
> （译文：我研究了一圈，发现基本上没有哪个电视品牌在隐私这一项上不让人发毛。）

他的做法是买 LG，不接 WiFi，用 Apple TV 看东西，代价只有一个：Apple TV 没法切电视的输入源，所以每次换游戏机都要动手。他还补了一句选购前提：

> "Make sure the TV supports HDMI CEC." — epwr [c:50329201]
> （译文：一定要确认这台电视支持 HDMI CEC。）

HDMI CEC 是整套方案的地基：它让外接设备互相控制开关机和输入源，没有它，外接盒子的体验会立刻塌掉。有人干脆买了台「和电视一样大、带遥控器的显示器」：

> "Zero smarts, boots in a millisecond, auto-wakes on device power-up, input switching just works, no half-baked HDMI-CEC hell." — lloeki [c:50329664]
> （译文：零智能，一秒内开机，设备一通电就自动唤醒，输入源切换一切正常，没有那套半成品的 HDMI-CEC 地狱。）

他买的是 LG 48GQ900-B，48 寸，没有调谐器，没有 ARC，没有 WiFi。

用 lrvick 的说法更直接：

> "Buy any TV you want, ignore all instructions to connect it to the internet, then look for an HDMI port on the back." — lrvick [c:50329648]
> （译文：你想买哪台电视都行，先无视所有让你联网的提示，然后找到背面的 HDMI 口。）

> "It turns out we never needed Smart TVs in the first place. Just treat it as a screen for a desktop computer." — lrvick [c:50329648]
> （译文：结果是我们从来就不需要智能电视。把它当成桌面电脑的屏幕就行。）

zeagle 的实际配置更完整：LG OLED 面板，电视不接网，用 NVIDIA Shield 加 HDMI-CEC 开关机和切输入，Jellyfin 放本地片源，固件用 U 盘更新：

> "My lg tv has never been connected to the internet and connects to a avr that handles inputs and 5.1.2 speakers" — zeagle [c:50329633]
> （译文：我的 LG 电视从来没接过网，它接的是一台功放，由功放处理输入源和 5.1.2 声道。）

> "You can update firmware via usb stick." — zeagle [c:50329633]
> （译文：固件可以用 U 盘更新。）

真正「无智能」的电视也在讨论里被点名。有人提到 Sceptre 是几乎唯一还在做非智能电视的品牌，另一位说自己家里那台 65 寸的时钟还停在 1989 年：

> "This TV is so dumb its clock is still in 1989." — edoceo [c:50330710]
> （译文：这台电视蠢到它的时钟还停在 1989 年。）

> "No apps, no OS, and no connectivity other than common A/V cables." — charonn0 [c:50330868]
> （译文：没有 app，没有系统，除了常见的 A/V 线缆什么都不能连。）

如果非要用一台 Android TV，也有人给了软件层的办法：

> "Any AndroidTV and then run CleanYourTV [1] on it, gets completely rid of all Google ads and additional bloatware by the manufacturer." — guitarlimeo [c:50329683]
> （译文：任何 Android TV 上跑一下 CleanYourTV，就能把 Google 广告和厂商预装清得一干二净。）

### 二、真动手的人：root、拆天线、贴铜箔、把 MAC 封掉

评论区最硬核的一批人不停留在「别接网线」，而是把机器改到不信任任何人。

root 掉电视是最常见的一条路线：

> "I rooted my LG C1 and honestly I can't go back to an unrooted TV." — damascus_kei [c:50329240]
> （译文：我 root 了自己的 LG C1，说真的，我回不去没 root 的电视了。）

> "Internet is blocked so no nagging or ads" — damascus_kei [c:50329240]
> （译文：网络被封了，所以没有那些 nagging 弹窗，也没有广告。）

更讲究一点的是网络隔离：

> "I recently was stressed about the same & ended up buying an LG C6, sticking it on an isolated VLAN, rooting it, then just letting it hit my NAS for jellyfin." — choroid [c:50329256]
> （译文：我最近也为同样的事焦虑，买了一台 LG C6，把它扔在一个隔离 VLAN 上，root 掉，然后只允许它访问我的 NAS 上的 Jellyfin。）

不 root 的人用路由器解决问题，逻辑更干净：

> "I allow my Samsung to connect to my local network, but then use openwrt and refuse to allow any outbound data from any IP using the MAC address of the television set." — thinkingkong [c:50329595]
> （译文：我允许三星电视连上本地网络，但用 openwrt 拒绝任何携带电视 MAC 地址的 IP 发出任何出站流量。）

> "It cant update itself and no traffic suggests it can do anything regardless of what it might be collecting." — thinkingkong [c:50329595]
> （译文：它没法自己更新，而没有流量就说明它即便在收集什么，也做不了什么。）

物理手段也有人认真讨论过：

> "jailbreak it, or open it and unsolder the wifi antenna, or put some well placed copper tape until you no longer see any wifi traffic from the TV from other wifi capable devices running a wifi packet inspector." — lrvick [c:50329718]
> （译文：那就越狱它，或者打开后端把无线天线焊下来，或者贴几块位置合适的铜箔，直到你用抓包工具再也看不到这台电视发出的 wifi 流量。）

> "Some well placed copper tape on the back of the tv will likely get the job done in many cases." — lrvick [c:50330147]
> （译文：在电视背面贴几块位置合适的铜箔，多数情况下大概就够用了。）

紧接着有人回了更短的一句：

> "Or just rm the nic" — matltc [c:50330591]
> （译文：或者直接把网卡删了。）

也有人泼冷水，说法拉第笼在这个场景里不成立：

> "You might think a microwave is a faraday cage, but a phone can still get calls even if you put it inside." — gruez [c:50330947]
> （译文：你可能以为微波炉是法拉第笼，但手机放进去照样能接电话。）

### 三、另一半人只想要证据：「电视会偷跑连邻居 WiFi」至今没有实据

评论区有一条流传很广的说法：不接自家 WiFi 的电视会自己去连邻居的开放网络，甚至上 LTE。多数人认为这是都市传说。

> "This is repeated every time this topic comes up, but so far it's just a conspiracy theory. An urban legend. An old wives' tale. Are there any documented cases of this happening?" — nvme0n1p1 [c:50329249]
> （译文：每次这个话题出现都会重提一遍，但到目前为止这还只是个阴谋论、都市传说、老妈级传说。有没有这种行为的成文案例？）

nvme0n1p1 后来的补充把举证责任讲得很清楚：

> "I indeed cannot prove it. I also can't universally prove that wombats don't have telekinesis." — nvme0n1p1 [c:50330038]
> （译文：我确实证明不了。我也同样没法普遍证明土豚不会心灵感应。）

有人提到之前 Gamersnexus 的调查：

> "didn’t the Gamersnexus investigation show that even un-connected LG TVs will still scan for open WiFi networks to clandestinely upload their spy data?" — wcfields [c:50330757]
> （译文：Gamersnexus 的那次调查不是显示过，即使不接网的 LG 电视也会扫描开放 WiFi 网络，偷偷把监控数据传上去吗？）

一位读者直接否掉了这类说法：

> "I can find no verified reports of this behavior. People are looking for it." — WarOnPrivacy [c:50330633]
> （译文：我找不到任何经过核实的这类行为报告。是人们自己在找。）

> "So far there's no evidence any TVs are using it, so you're safe for now." — gruez [c:50330960]
> （译文：目前还没有证据表明有电视在用 Sidewalk，所以你暂时是安全的。）

但争议并没有因此消失：

> "There was no evidence about all the spying until 200,000,000 LG displays were sold." — olyjohn [c:50331654]
> （译文：在卖出两亿台 LG 显示器之前，关于这些监控的事一点证据都没有。）

真正有依据的部分是另一件事：Amazon Sidewalk。评论里有人把它的机制讲清楚了（Natfan 附了维基百科链接）——近距离靠 BLE，远距离靠 900MHz LoRa，等于把通信网铺到了社区门口，因此有人认为「不接网」这件事本身已经不再成立：

> "With Amazon Sidewalk I don't think not hooking it up to the internet is an option anymore, unless you live out in the boonies" — smallpipe [c:50329418]
> （译文：有了 Amazon Sidewalk，我不认为不接网还算一个选项，除非你住在那种鸟不拉屎的地方。）

> "Boonies? No. Literally EVERYONE has a damn Alexa and it's on the network. The coverage map is staggering." — kotaKat [c:50334776]
> （译文：鸟不拉屎？不，几乎人人家里都有台 Alexa，它就在网上。那个覆盖地图简直夸张。）

### 四、断网也不等于干净：信任已经先破产了

最有意思的一段不是关于技术，而是关于信任。有人指出，问题已经不是「电视会不会偷窥」，而是「你凭什么相信它没在偷窥」：

> "If you can't tell whether your disconnected TV is spying on you but you know that you cannot trust it, it's better to treat it as compromised." — OroPla [c:50329538]
> （译文：如果你没法确认断网的电视没有在偷窥，但你知道自己信不过它，那就把它当成已经被攻陷更稳妥。）

他的建议直接跳过新型号：

> "Buy something used that was manufactured before ca 2018. Or get a projector that doesn't have any smart stuff built in." — OroPla [c:50329604]
> （译文：买台 2018 年左右之前生产的二手货。或者弄台没有内置任何智能功能的投影仪。）

> "Ultimately I'll need to find data to settle how paranoid I might be." — alserio [c:50329697]
> （译文：Ultimately 我还是得找到数据，才能确定自己该多疑到什么程度。）

讨论里也有人不满足于「无法验证」这种技术性回答，转而怀疑整个商业模式：

> "TV manufacturers are not just creepy on privacy. They are outright stalkers." — heresie-dabord [c:50333370]
> （译文：电视厂商在隐私上不只是让人发毛，它们根本就是跟踪者。）

他还在同一条评论里提了一个冷知识：HDMI 1.4 里其实有一个至今没人用的 Ethernet over HDMI（HEC）规范，Silicon Image 和 Broadcom 当年曾向厂商私下演示过这项能力——如果哪天厂商想给屏幕加网络，硬件早就现成。

针对具体的系统，反馈也是有的：

> "Samsung (TizenOS) does not respect even privacy opt outs." — u1hcw9nx [c:50329546]
> （译文：三星是最糟的，差得远。三星（TizenOS）连隐私退出选项都不尊重。）

### 五、不智能的大屏：商显、酒店机、投影仪、二手货

既然家用电视都不肯当纯显示器，讨论自然转向那些本来就是纯显示器的设备。

商场和机场里那些 LG 和三星的大屏，关键词其实是「显示屏」而不是「电视」：

> "Go to your shopping center or airport and you'll see LG and Samsung displays everywhere. And that's the key word, 'displays' not 'TVs'." — PorciiVorbesc [c:50329673]
> （译文：去商场或机场，你会看到 LG 和三星的显示屏到处都是。关键词是「显示屏（displays）」，不是「电视（TVs）」。）

但这条路有人泼冷水：

> "Those commercial TV-s also phone home if connected to the internet. For software updates, analytics regarding digital signage usage etc." — 2III7 [c:50331063]
> （译文：我有个坏消息。这些商用电视一旦接了网也会往外发数据：软件更新、数字标牌使用情况之类的分析上报。）

> "For a long time they haven't been just dumb displays. They also run Tizen or WebOS for digital signage applications." — 2III7 [c:50331063]
> （译文：它们早就不再是纯显示屏了，还会跑 Tizen 或 WebOS 来跑数字标牌应用。）

酒店机型是另一个折中：

> "Hotel TVs, same panels as consumer models with different supporting hardware and stock calibrations." — wolrah [c:50331195]
> （译文：酒店电视，面板和消费级型号一样，只是配套硬件和出厂校准不同。）

> "They tend to lack gaming features like high/variable refresh rate but they're more functional as normal TVs than digital signage displays." — wolrah [c:50331195]
> （译文：它们通常缺少高刷或可变刷新率这类游戏功能，但当普通电视用比数字标牌显示屏更合适。）

至于投影仪和旧机器：

> "I have a BenQ (710tki iirc) that is like this and I believe it meets all your stated requirements (size, resolution, etc)." — pyrophane [c:50329491]
> （译文：我有一台这样的 BenQ（好像是 710tki），我觉得它满足你提的所有要求（尺寸、分辨率等等）。）

> "I’m sticking with my 2010 Toshiba REGZA until it dies. 1080p is fine for me." — qubex [c:50329277]
> （译文：我要继续用我这台 2010 年的 Toshiba REGZA，用到它坏为止。1080p 对我来说够了。）

商用屏的画质与刷新率也被人泼了冷水：

> "These are generally meant to display (static) advertisement media, you'll have a false experience watching movies or playing games on them." — HelloUsername [c:50329405]
> （译文：它们本来是给（静态）广告素材用的，拿来看电影或打游戏体验会不对。）

> "I believe those displays intended for static advertising etc are not set up for good refresh rate or cinema viewing" — jaggederest [c:50329721]
> （译文：我相信那些给静态广告设计的显示屏，在刷新率和观影方面都没做优化。）

价格上也有争议。PorciiVorbesc 说商用屏比消费级电视贵不少，除非能在二手市场捡漏；另一方认为，电视加上广告和遥测之后也根本没便宜到哪去：

> "I don't think that the cost of TVs has gone down when they added spyware and ads." — g-b-r [c:50331249]
> （译文：我不认为电视在加上间谍软件和广告之后，价格就降下来了。）

### 六、现实阻力：Apple TV 未必干净，Linux 盒子也没那么丝滑

评论区最激烈的一处交锋，是关于 Apple TV 到底算不算「换了个人监听」。

自称在 Apple 工作的人直接反驳：

> "Source: I work at Apple. The privacy story isn’t just marketing, it’s very real and part of every discussion." — azinman2 [c:50330571]
> （译文：来源：我在 Apple 工作。隐私这件事不只是营销，它非常真实，而且贯穿每一次内部讨论。）

另一位从动机出发给出了更狠的论证：

> "Apple could easily make tens of billions dollars extra if they spied more on their users." — tristanj [c:50330627]
> （译文：如果苹果在用户身上多收集数据，轻轻松松就能多赚几百亿美元。）

反驳这段的人也不含糊：

> "Apple's gotten a taste of advertising dollars via the App store." — solyin [c:50330860]
> （译文：苹果已经通过 App Store 尝到了广告钱的甜头。）

> "What information is Apple sharing with advertisers?" — brookst [c:50331147]
> （译文：苹果到底跟广告商共享了什么信息？）

至于最直接的替代品——跑 Linux 的小盒子——反对意见集中在易用性上：

> "Nobody wants to sysadmin their “friendly Linux distro” just to watch shows." — sneak [c:50330569]
> （译文：没人愿意为了看个剧，去维护一个「友好的 Linux 发行版」。）

> "Kodi is amateur hour compared to tvOS." — sneak [c:50330569]
> （译文：跟 tvOS 相比，Kodi 就是业余水平。）

> "You don’t have HDR and can’t pair and then send audio to bluetooth speakers via only the remote in 100 seconds.  These basic things are table stakes." — sneak [c:50331609]
> （译文：你不带 HDR，没法用遥控器在一百秒内完成配对再把声音送到蓝牙音箱。这些都是基本盘。）

> "Even smart people have limited time and limited capacity for effort. Failure to Just Work is sand in their gears. Hand-rolled Linux TVs are a nonstarter." — bitwize [c:50334058]
> （译文：就算是聪明人，时间和精力也有限。用不顺手就是卡在齿轮里的沙子。手搓 Linux 电视是个死路。）

> "Linux is not a viable option for TV for the vast majority of users." — afavour [c:50330638]
> （译文：对绝大多数人来说，Linux 都不是电视上的可行选项。）

> "Jellyfin and Plex cannot stream from major streaming providers." — afavour [c:50331885]
> （译文：Jellyfin 和 Plex 没法从主流流媒体平台拉片源。）

反方的例子也很具体：

> "I literally bought a mini PC, installed Arch with KDE via archinstall, installed chromium" — qweqwe14 [c:50331022]
> （译文：我确实买了台迷你 PC，用 archinstall 装了 Arch 和 KDE，又装了 chromium）

> "Our TV remote can actually control our Apple TV.  It's definitely good enough, and through some witchcraft, it works when the TV is not connected to WiFi." — hedora [c:50333188]
> （译文：我们的电视遥控器其实能控制 Apple TV。用起来完全够用，而且通过某种玄学，电视不连 WiFi 时也能用。）

另外有人提到 RPi4 加 libreelec 的路线，开箱即用还能吃 HDMI-CEC：

> "Personally, I use an RPi4 with libreelec, and it works great - including responding to my remote via HDMI-CEC.  (There's also no need for any sysadmin with libreelec, which is designed to work out of the box.)" — epihelix [c:50331956]
> （译文：我自己用的是 RPi4 加 libreelec，效果很好，包括通过 HDMI-CEC 响应遥控器。（libreelec 是开箱即用设计的，所以也不需要任何系统管理。）

而这套方案有它自己的强制条件：有的电视干脆不联网就开不了机。

> "Some TVs will refuse to work if you don't create an account and connect them to internet." — autoexec [c:50332036]
> （译文：有些电视如果你不注册账号、不连网，就拒绝工作。）

> "I did my research and bought one that does not do this (2025 TCL)" — hedora [c:50333223]
> （译文：我做过功课，买了一台没有这个毛病的（2025 款 TCL）。）

> "the more common tactic is to throw constant nags up if the telemetry is not being sent to the manufacturer" — hedora [c:50333223]
> （译文：更常见的做法是，只要遥测数据没回传给厂商，就不停弹窗 nagging。）

厂商把广告做成订阅制的例子也被摆了出来：

> "constantly pesters about $15 monthly subscription to change the art on the display to their selection of public domain historical artworks" — aDyslecticCrow [c:50331522]
> （译文：不停拿每月 15 美元的订阅费来烦你，为的是把屏幕上的画面换成他们选定的公版历史画作。）

> "I can turn of personalised ads." — aDyslecticCrow [c:50331522]
> （译文：个性化广告倒是能关掉。）

换句话说，能关的只有广告，关不掉的是订阅、账号、弹窗和更新。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 没有哪家电视品牌在隐私上干净 | epwr | 研究一圈，牌子都不行 |
| 电视只当显示器，盒子才是主机 | lrvick | 我们从来就不需要智能电视 |
| 买带遥控器的大尺寸显示器 | lloeki | 没有 WiFi，因为它就是一台显示器 |
| 支持 HDMI CEC 是前提 | epwr | 不支持 CEC 的方案体验会塌 |
| 断网 + 外接 Shield + U 盘升级固件 | zeagle | 面板要 LG，盒子归盒子 |
| 无智能电视只剩 Sceptre | AAAAaccountAAAA | 几乎是唯一还在做的非智能品牌 |
| 自己有两台 Sceptre，推给所有人 | 5555624 | 找得到的话我推荐 |
| 用开源工具把 Android TV 洗白 | guitarlimeo | CleanYourTV 能清掉广告和预装 |
| 蠢到时钟停在 1989 | edoceo | 这台电视真的很蠢 |
| root 掉 LG C1 | damascus_kei | 回不去了 |
| 隔离 VLAN + 只放行 NAS | choroid | 电视只能访问 Jellyfin |
| 用 openwrt 按 MAC 禁止出站 | thinkingkong | 没流量就说明它做不了什么 |
| 拆天线、贴铜箔 | lrvick | 电视是你的，用不了多少功夫就归你管 |
| 法拉第笼在这个场景不成立 | gruez | 微波炉当法拉第笼，手机照样接电话 |
| 直接删网卡 | matltc | 或者 just rm the nic |
| 「连邻居 WiFi」没有实据 | WarOnPrivacy | 找不到经过核实的报告，是人们自己在找 |
| 连土豚心灵感应也证不了 | nvme0n1p1 | 举证责任在提出怀疑的人那边 |
| 卖到两亿台才有证据 | olyjohn | 在那之前，关于监控一切都是空谈 |
| Sidewalk 让「不接网」不再成立 | smallpipe | 除非你住在鸟不拉屎的地方 |
| 断网也该当成被攻陷 | OroPla | 信不过就当它已经泄露 |
| 直接买 2018 年前的二手货 | OroPla | 或者买台没智能功能的投影仪 |
| 厂商不是发毛，是跟踪 | heresie-dabord | 在隐私上他们根本就是跟踪者 |
| 三星连退出选项都不尊重 | u1hcw9nx | TizenOS 是最差的一档 |
| 商场机场那块屏才是纯显示屏 | PorciiVorbesc | 关键词是 displays 不是 TVs |
| 商用屏比消费级电视贵 | PorciiVorbesc | 除非能在二手市场捡漏 |
| 但商用屏接网也会上报 | 2III7 | 它们跑 Tizen 和 WebOS |
| 酒店机是折中 | wolrah | 面板一样，只是缺高刷 |
| 2010 年的 REGZA 还能用 | qubex | 1080p 够看了 |
| 商用屏画质和刷新率不行 | HelloUsername | 那本来是给静态广告用的 |
| Apple 不是监视资本主义公司 | azinman2 | 我就在 Apple 工作，这不是营销 |
| 苹果靠 App Store 吃到了广告钱 | solyin | 搜索排序就能收钱 |
| Linux 盒子没人愿意维护 | sneak | 没人想为了看剧去 sysadmin |
| 手搓 Linux 电视是死路 | bitwize | 聪明人的时间和精力也有限 |
| 迷你 PC 装 Arch 加 KDE 就能看 | qweqwe14 | 装完 chromium 就没再折腾过 |
| RPi4 加 libreelec 开箱即用 | epihelix | 还能吃 HDMI-CEC 遥控 |
| Jellyfin 拿不到主流片源 | afavour | 这是巨大的门槛 |
| 有些电视不联网就开不了机 | autoexec | 还不告诉你 |
| 遥测不上报就弹窗 | hedora | 更常见的做法是不停 nag |

## 总体情绪

这场讨论表面上在找一台电视，实际上在重新划一条线：谁联网，谁负责。有人贡献型号，有人贡献拆机教程，有人贡献路由器配置，有人贡献一句反问：信不过厂商的电视，凭什么信厂商的隐私承诺。

真正被建立起来的，是一套操作规范而不是一份购物清单：面板归面板，主机归主机，电视不该有自己的网络身份；能 root 就 root，不能就 VLAN 隔离，再不济就把无线天线焊掉。而与之对抗的是另一股同样主流的怀疑——不是「它可能在偷窥」，而是「它说过的话我不再相信」，于是买二手货、买商用屏、买投影仪、干脆买 2010 年的旧电视。到最后，可信度不再是厂商给的属性，而是一个要自己动手换回来的东西。

这场讨论最后留下的答案，可能就是提问者一开始写进帖子里、却没想到会被这么多人接住的那半句：想要一台尊重隐私的电视？先决定好你打算让哪台设备联网——很多时候这台电视根本不该是那台。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Ask HN: Which TV do you recommend for privacy?（HN 主帖，409 分，537 条评论） | https://news.ycombinator.com/item?id=50328896 |
| 2 | LG 48GQ900-B 48 寸显示器（lloeki 的「带遥控器的显示器」） | https://www.lg.com/us/monitors/lg-48gq900-b-gaming-monitor |
| 3 | Sceptre 非智能电视官网（评论区里被点名的品牌） | https://www.sceptre.com/ |
| 4 | LG 酒店商用 TV（wolrah 提到的 hospitality 系列） | https://solutions.lg.com/us/hospitality-tvs/lg-55am960h0ud |
| 5 | CleanYourTV：给 Android TV 去广告和预装（guitarlimeo 推荐） | https://github.com/Gathin23/cleanyourtv |
| 6 | Amazon Sidewalk 覆盖图（kotaKat 贴的链接） | https://coverage.sidewalk.amazon/ |
| 7 | Amazon Sidewalk 说明（BLE + 900MHz LoRa） | https://en.wikipedia.org/wiki/Amazon_Sidewalk |
| 8 | Pulse Eight Intel NUC HDMI-CEC 适配器（kitestramuort 的方案） | https://www.pulse-eight.com/p/154/intel-nuc-hdmi-cec-adapter |
| 9 | Smart TV tracking 与隐私退出机制（u1hcw9nx 引用的调查） | https://allaboutcookies.org/smart-tv-tracking-privacy-opt-out |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的型号、得分、评论数与产品行为均为发帖者与评论者在 2026-11-01 至 2026-11-02 期间的公开陈述，本文未做独立核实；涉及「设备是否会主动连接邻近 WiFi」「是否会上报遥测」等说法，评论区本身即存在相反意见，正文已分别列出。root 电视、拆焊天线、拆改固件等做法涉及保修失效、电气安全与厂商服务条款，风险由操作者自行承担；本文不建议在通电状态下自行拆解显示设备。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
