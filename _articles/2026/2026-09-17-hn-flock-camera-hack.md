---
layout: post
title: >-
  黑客拆了一台 Flock 摄像头——HN 热议：21 天日志、160 万张图、加密密钥躺在硬盘里
date: 2026-09-17
hn_id: 49726586
categories: [articles]
excerpt: >-
  攻击者从悬在公路上方的 Flock 摄像头里取出了近 21 天的运行日志和加密密钥，连带 5 万辆车、160 万张图——这个被 80% 美国警局采购的系统，物理安全几乎为零。
tagline: >-
  加密密钥写在摄像头自己的硬盘上，物理安全靠摄像头上方没有梯子。
---

## 原文概要

自称 **stegan0gram** 的黑客团队从公路上方拆下一台 Flock Safety 自动车牌识别摄像头（ALPR），把内部存储做了近乎完整的镜像，并把这个分发给 404 Media 与 WIRED 做联合调查。这份数据首次从内部视角揭示了 Flock 摄像头在"宣称加密、本地不留数据"之外的真实工作方式：摄像头运行 Android 系统，处理器相当于中端手机，内置约 20 个 Flock 自研应用负责运动检测、拍照、目标分类、上传和远程更新。

黑客发现 `vendor` 和 `media` 两个分区未加密，后者还藏着解锁其余媒体分区的密钥，于是顺利拿到了几千段车辆视频和图像。21 天的日志显示这台摄像头在若干时段里拍摄了约 50,200 辆车、生成了约 160 万张图像——高峰期 4,454 辆/日。每辆车过境会被连拍约 28 张图，部分情况超过 100 张，多曝光组合是为了同时兼顾车牌与广景。

与 Flock 长期公关口径最直接矛盾的一点是：摄像头软件**明确检测人体**，不仅限车辆与车牌。WIRED 把模型从摄像头文件里拆出来跑了自拍照与 27,321 段恢复视频（这是原文在 8,000 字截断处提到的数字），人物识别模型轻松命中——意味着 Flock "不做人脸识别"的措辞只适用于摄像头本体，整套体系里"识别"是另一个集成的事。日志同时记录到约每两分钟一次的看门狗消息 `"Who's a good boy?!"`（"谁是好孩子？"）以及超过 12,000 条 `"no space left on device"` 错误，27,000 余次崩溃、重启、相关故障。

背景上，Flock 是 YC W17 批次公司，2019 年签下第一家警局（Jersey Village, Texas），2020 年拿到 $47M C 轮，2021 年 a16z 领投 $150M D 轮并以此作为其 "American Dynamism" 招牌案例。其全国联网（national lookup）允许任意接入机构查询任意一台摄像头的车牌记录，404 Media 此前披露过 ICE 通过本地警局间接拉取全国数据，以及一名德州警员用该网络追查一名自行堕胎女性的案例。阿尔法瑞特（Alpharetta, GA）一城的 Flock 数据曾被发现对 2,000 多家机构开放——包括警察、大学、机场，以及莫名在列的联邦总务管理局监察长办公室。

来源：HN 热门榜（/best）

## 讨论焦点

### 物理访问基本无门槛，加密密钥就摆在自己文件系统里

> "So… all that data is literally there for any unauthorized person to walk up and take it. It's not even suitably encrypted on device? Zero trust in anything Flock says." — drfloyd51 [c:49727235]
> （那么……所有这些数据，任何未授权的人走过去就能拿走？设备上甚至都没做合适的加密？Flock 说什么我都不信。）

> "Yep. Clown show." — glaslong [c:49727825]
> （没错。这是一出小丑戏。）

> "There are levels to defending against physical attacks, and Flock half-assed theirs by leaving the encryption key right on the file system, according to the reporting. Those more serious about security — like Apple — store keys in an 'enclave' chip so it can't be easily extracted by an attacker doing the bare minimum." — overfeed [c:49730616]
> （防御物理攻击是有层级的，而 Flock 应付了事——把加密密钥就放在文件系统上。真正在意安全的，比如 Apple，把密钥放进 "enclave" 安全芯片，攻击者做最基础的尝试也提取不出来。）

drfloyd51 一句话点出最让评论区难受的事实：Flock 的销售话术是"加密 + 图像立即上传不留本地"，现实是物理设备挂在电线杆上无人看管、密钥就在 `media` 分区。overfeed 拿 Apple 的 enclave 做了个对照——不是说 Apple 是道德标杆，而是它在 2010 年代经历过早期 iPhone 被偷的高峰后，才把硬件密钥做成隔离芯片。Flock 把"威胁模型里包含物理访问"这件事直接写进免责话语，却没改任何架构。

### 内核停在 2017 年的 Qualcomm vendor 分支

> "I poked around in the boot partition. The kernel is ancient! Linux version 3.18.71-perf-gaf770dc" — fullstop [c:49727305]
> （我翻了翻 boot 分区。内核老掉牙！Linux 3.18.71-perf-gaf770dc）

> "3.18.71-perf-gaf770dc is a Qualcomm Android vendor kernel from roughly late 2017. The 3.18 branch went fully EOL in 2019, so nothing after that was ever backported to it." — incee [c:49727844]
> （3.18.71-perf-gaf770dc 是 Qualcomm 在 2017 年底左右的 Android vendor 内核。3.18 分支在 2019 年完全 EOL，从此之后再没有任何 backport。）

> "It's almost as if they paid a contractor to design the hardware back in 2017 and put all the funding into marketing (bribes) since then. Shocker." — Arrowmaster [c:49728964]
> （就好像 2017 年找了外包把硬件定型，之后所有钱都砸进市场推广/行贿了。吃惊吗？不。）

评论区被这个内核版本号震了一下：3.18 分支主线早就关停，意味着从 2019 年起 Qualcomm 自己都不再为这个分支修 CVE，而内核里任意一个被公开披露的漏洞都不会得到任何官方补丁。硬件 SoC 同样可以加 AES 加速器把 `media` 分区加密做掉（megous 给出 50 MiB/s 的最低估算），但 Flock 没做。Arrowmaster 的吐槽虽重，但对照 a16z 2021 年领投 $150M 这件事之后仍然无人做硬件升级，逻辑上是闭环的。

### 摄像头"明确检测人体"和公司话术之间的缝隙

> "i think this is actually good, because there are differences between the images they found, and security settings that the company claimed. They had not admitted before to tracking people, but their software is clearly submitting them. They had not admitted before to looking at bumper stickers, but turns out they do. I wonder if they could find all cars with Bernie Sanders bumper stickers within X blocks of a polling place.. I can imagine that (or similar queries) might be very useful in the wrong hands." — briffle [c:49729271]
> （我觉得这其实是好事，因为泄露出来的图像和公司宣称的安全设置之间有落差。他们以前没承认追踪人，但软件明明在上传。以前也没承认看保险杠贴纸，但其实就是有。我很好奇他们能不能查出离某投票站 X 个街区范围内所有贴 Bernie Sanders 贴纸的车……这种查询到错的人手里会非常有用。）

> "The devices are entirely open for all practical purposes - but worrying about individual cameras is silly, because they have no meaningful security at all around the API's to access all the cloud data - you can buy law enforcement credentials dirt cheap in dark web marketplaces to log in and track anyone/anywhere you want and access all footage." — stefangordon [c:49729362]
> （设备本身在实用性上完全敞开——但担心单台设备没什么意义，因为访问所有云端数据的 API 根本没做任何安全防护。暗网市场上廉价就能买到执法账号，登录之后想追踪谁/在哪里/任何录像都能调。）

briffle 把"保险杠贴纸"这个细节用得很到位：原报道里提到模型曾抓拍到一名摩托车手行李包上的美国国旗补丁，这意味着图像分类不只是"车牌+车款+颜色"那套官方说辞，而是会提取贴纸、文字、徽标这种语义颗粒度更高的东西。在 2026 年美国政治环境下，把这种检索能力落到"贴了某候选人贴纸的车"上，离直接的政治监控就只差一个查询构造。stefangordon 进一步把焦点从单台设备拉回到云端 API：本地拆摄像头是 demo，真实的高价值威胁是云端的查询权限——而这部分在暗网上以很低的价格就能买到。

### 威胁模型里没考虑过的对手：国家级情报和家暴追踪

> "A network connected device that can be hacked is a small step away from being the first foothold into its server. The fact that on-device security is this atrocious suggests that their server is not any better quality, which means hacking it would probably not take much effort." — voakbasda [c:49728098]
> （一台可被入侵的联网设备，离成为入侵其服务器的第一块跳板只差一步。设备端的安全做到这种程度，意味着服务端也好不到哪里去，入侵它大概也不用费太大劲。）

> "My working assumption based on what I hear out of Flock is that they have a public feature set (mass license plate surveillance for LEO) and a covert feature set (even more mass surveillance, beyond license plates and privacy agreements, for intelligence communities)." — runjake [c:49729045]
> （基于我对 Flock 的了解，我假设他们有一套公开功能集——给执法部门的大规模车牌监控——和一套隐蔽功能集——超出车牌和隐私协议范畴、更大规模地给情报社区用的监控。）

voakbasda 把"设备攻陷→服务器渗透"这条经典 APT 路径摆出来之后，runjake 给出更狠的延伸：摄像头在公共场域、设备可拆、服务端权限外泄，三件事叠加意味着任何有动机的对手——外国情报机构、国内极客、家暴加害者——都能拿到同一条数据管线。fapjacks 的长评补充了家暴受害者这条暗线：十几年前她做志愿者时，受害者逃离施虐警员还需要匿名手机；Flock 把这件事升级为"几百个警局共享一个全国数据库"。

### 投资人尽调的明显缺位

> "Flock is a scourge on democracy. Flock is YC. But looks like they did YC nearly ten years ago. Who knows what their pitch deck looked like? If they pivoted since then to their current sinister incarnation? I don't see any evidence that YC is still actively supporting them." — ohyoutravel [c:49727674]
> （Flock 是民主之癌。Flock 是 YC 出来的。但他们十年前就毕业了。谁知道当年的 pitch deck 长什么样？是不是之后才转到现在这个阴暗的形态？我没看到 YC 还在主动支持他们的证据。）

> "Don't have the pitch deck directly, but do have some of the 'what things looked like then' ... The front page then had 'All the footage is yours. Your neighborhood 100% owns the data. Flock Safety will not share, sell, or access your data.' ... 2019, Flock signed their first police department deal with Jersey Village, Texas." — shagie [c:49727768]
> （没有原始 pitch deck，但有当年的"样子"……首页上当时写的是"所有录像都是你的。你的邻里 100% 拥有数据。Flock Safety 不会分享、出售或访问你的数据。"……2019 年 Flock 签下第一家警局，Jersey Village, Texas。）

> "Interesting that they are a YC Company. Does yC do any ethics vetting of saying 'No, let's stop fascism before it spreads?'" — darksim905 [c:49731367]
> （有意思，Flock 是 YC 出来的。YC 有没有任何伦理审核，会说出"不，我们要在法西斯蔓延之前叫停"这种话吗？）

ohyoutravel 试图给 YC 一些时间距离上的宽限——毕竟是十年前的项目；shagie 用 2020 年 C 轮的 pitch deck 把这段叙事打回去：彼时 Flock 自己亲口承诺"邻里 100% 拥有数据，公司不会访问"，然后两年内就完成了向"全国联网可被 2,000 多家机构查询"的转向。tyrabound 进一步把 a16z 2021 年的 D 轮、2025 年的再次注资和"Flock 全国铺设几乎是在拿到钱之后立刻发生"这件事并置，结论是"对人尽调的失败"。darksim905 的反问虽然短，但把 YC/American Dynamism 整个品牌叙事的裂缝撕开来给读者看。

### "更笨的那个邪恶公司"——为什么偏偏是 Flock 挨这一波

> "While Axon's system should be under the microscope too I don't think they have the nation wide cloud that Flock is doing and requires specific agreements to share data." — cuvinny [c:49727586]
> （Axon 的系统也该被放上显微镜看，但我认为他们没有 Flock 那种全国云，必须靠具体协议才能共享数据。）

> "Flock courts local PDs who will catch a package thief or two but they really just want to have the drag net at their finger tips so that when some more equal animal's cat gets stolen they can walk back in time and figure out the short list of who could've done it." — cucumber3732842 [c:49728043]
> （Flock 走的是本地警局路线，这些警局可能一年抓到一两个偷快递的，但他们真正想要的是把那张拖网随时拽在手里——等哪位更平等的动物家猫被偷，就能往回追出一份嫌疑人短名单。）

> "I think I should start posting a reminder in Flock threads that Axon is a Flock competitor, is also engaged in mass surveillance, and is possibly even worse, but there's rarely any mention of it." — iamnothere [c:49727184]
> （我打算从今往后在所有 Flock 帖子里贴一遍提示：Axon 是 Flock 的竞品，也做大规模监控，而且可能更糟，但几乎没人提到。）

> "'Axon is Flock but worse' will be the next big fight as police departments are pulling a fast one and saying 'we got rid of Flock' by switching to Axon." — jordanb [c:49727237]
> （"Axon 比 Flock 还糟"会是下一场大仗，警局正玩一招——只要换到 Axon 就能宣称"我们淘汰了 Flock"。）

这条线索特别值得拎出来：cuvinny 同意 Axon 该被审视，但指出 Flock 全国联网是这个类别里独有的"无门槛拖网"；cucumber3732842 给了个直白的类比——本地 PD 用 Flock 抓到的是"偷快递的"，真正买单的是"想要拖网"的欲望。iamnothere/jordanb 都在警告读者：警局用换供应商的方式制造"已解决问题"的假象，实际上从 ALPR 整个市场看，监控能力曲线没有下降。jkestner 把这总结成一句话："让 'Flock' 变成这类产品的通称未尝不是好事。"

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 安全失败全在物理层 | drfloyd51 [c:49727235] | 数据就在那挂着，谁走过去都能拿。 |
| 加密密钥放在明文分区是设计缺陷 | overfeed [c:49730616] | Apple 用 enclave，Flock 用"分区放在那"。 |
| 内核 3.18 早 EOL 是硬伤 | incee [c:49727844] | 2019 年起 Qualcomm 不再 backport，意味着 CVE 永久裸奔。 |
| 设备被攻陷等于服务端也完蛋 | voakbasda [c:49728098] | 跳板逻辑——摄像头是 APT 第一站。 |
| 摄像头分类"贴纸"等于政治监控前置 | briffle [c:49729271] | 离"查投票站附近贴 Bernie 贴纸的车"只差一个查询。 |
| 暗网可买执法账号才是真威胁 | stefangordon [c:49729362] | 本地拆机是 demo，云端权限是真金白银。 |
| YC 创立时的承诺和现在完全相反 | shagie [c:49727768] | 2020 pitch 写"邻里 100% 拥有数据"。 |
| a16z 反复注资属于尽调失职 | tyrabound [c:49728695] | 2021/2025 两轮都没人去现场看代码。 |
| 公开/隐蔽两套功能集 | runjake [c:49729045] | 摄像头只是公开层，情报社区用别的接口。 |
| Flock 是被针对但 Axon 同样该查 | iamnothere [c:49727184] | 警局换供应商不等于解决问题。 |

## 总体情绪

讨论从技术故障开始，迅速滑向治理与责任分担，最后落在"Flock 只是可见的那个靶子"上。前半段（内核、内核、加密密钥）几乎是工程社群的反射——三件事任意一件做对都不会让今天这条新闻成立。中间段把设备层的漏洞和国家行为者、家暴追踪、政治监控绑在一起，让读者意识到这件事的破坏面不是"某台摄像头被拆了"，而是"全国联网的检索权限可以被任何有能力的人以很低成本调用"。

后半段则带有明显的情绪急转：shagie 引用的 2020 年 pitch deck 原文被反复引用，"邻里 100% 拥有数据"和今天的事实之间形成一种被背叛的叙事张力；darksim905 和 imthatsteve 的回复把矛头扩展到 YC 和 a16z 的"American Dynamism"品牌叙事——读者普遍认为，监控能力的扩散不是 Flock 一家公司的孤立决策，而是硅谷一整代人在公共安全和隐私之间的天平上做出的选择，外部观察者注意到 YC 公司本身（coldpie 直呼 "YC's finest"）也带着反讽被点名为这件事的一部分。

收尾的强句留给 cucumber3732842 的类比：Flock 真正在卖的从来不是"找回失窃的猫"那种一年用一次的破案能力，而是"随时拽在手里的拖网"——这是一种功能描述，对应的是社会对监控边界的最终接受度。当 Flock 之外的替代方案（Axon、Motorola、Rekor）在能力曲线上没有本质差异时，今天这场"针对 Flock"的反弹，下次会落在谁身上？

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Hackers Got Inside a Flock Camera. Its Data Shows How the System Really Works (WIRED) | https://www.wired.com/story/hackers-flock-camera-data-shows-how-system-works/ |
| 2 | Hackers Stole Flock's Camera Software, Revealing How the Company Tracks Cars and People (404 Media) | https://www.404media.co/hackers-stole-flocks-camera-software-revealing-how-the-company-tracks-cars-and-people-2/ |
| 3 | 原始分区镜像与数据公开（Distributed Denial of Secrets） | https://ddosecrets.org/article/flock-alpr-camera |
| 4 | Flock ALPR 安全研究记录（GainSec, 2025-06） | https://gainsec.com/2025/06/19/grounded-flight-device-2-root-shell-on-flock-safetys-falcon-sparrow-automated-license-plate-reader/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，原文链接与作者观点均归原作者所有。摘要不代表译者立场，引文翻译力求忠实原文，部分用词为可读性作了微调。摘要涉及的 Flock Safety 监控系统在多州引发过执法与隐私争议，本文仅整理公开讨论内容，不构成投资、法律或政策建议。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>