---
layout: post
title: >-
  FAA 要在 2028 年前淘汰空管软盘，而卡住四十年的一直不是软盘 — HN 讨论摘要
date: 2026-11-07
hn_id: 50388001
categories: [articles]
excerpt: >-
  交通部长把淘汰空管软盘称为“历史性”的一步，评论区却指出：真正卡住四十年的是还在
  关键路径上的 1980 年代主机，不是那 1.44MB 的软盘本身。而 2026 年 10 月休斯敦机场
  那根被施工队挖断的光缆，正好把“冗余”这个词问出了原型。
tagline: >-
  软盘终于退休了，退休手续办了四十年，截止日期定在 2028 年。
---

> 来源：HN 讨论主帖 [US FAA says it will phase out floppy disks from air traffic control by 2028](https://news.ycombinator.com/item?id=50388001)（267 分，210 条评论），原文是 Reuters 报道。本篇为 single post 模式，registry 内同关键词候选仅此一帖，未构成 cluster。
>
> 归档快照 2026-11-07 00:41 UTC，主帖入库 129 条评论（HN 原始评论数 210，Firebase API 分页未取全）。Reuters 原文对本次抓取与引用均返回 HTTP 401，正文事实改以 FAA 官方新闻稿与 Ars Technica 报道交叉核对。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

2026 年 11 月 5 日（周四），美国交通部长 Sean P. Duffy 宣布了这件事，FAA 局长 Bryan Bedford 在同一份新闻稿里给出了说法：空管系统里的软盘，要退役了。Duffy 的原话是 “Good news America: floppy disks are out, 21st century tech is in.”，他还补了一句 “The greatest nation in the world deserves a state-of-the-art air traffic control system, and under President Trump, we're delivering just that.”。新闻稿标题本身把这件事称为 “historic modernization”（历史性现代化），发布在现代天空（Modern Skies）计划的框架下。

要替换的是四套可以追溯到 1980 年代的显示系统：IDS-4、ACE-IDS、NIDS 和 ERIDS，它们分布在 400 多个 FAA 设施里。新系统叫 E-IDS（Enterprise – Information Display System），FAA 的计划是在 2028 年底之前把它装进 435 个站点。首批五处是 Atlantic City International Airport、Nashville International Airport、Greater Rochester International Airport，以及 Atlanta 和 Salt Lake City 的两个数据处理中心。

软盘上装的是什么？按 FAA 的说法，是“设备故障与中断通知、空域天气状况、天气影响、重要通告”这类必须让管制员秒级看到的信息，以及 PIREP（飞行员报告）和 NOTAM（航行通告）的采集与分发。E-IDS 的定位是一块数字显示板：把原本散在几套系统里的信息汇到一个视图里，并且让这些信息能横跨整个国家空域系统共享。Bedford 的说法是，E-IDS 让管制员“能够即时共享关键飞行警报、限制空域时刻表和飞行员报告”。

其中最老的那套 IDS-4，跑在 MS-DOS 上。支持它的厂商 Systems Atlanta 在 2018 年的新闻稿里写着，它 “has been in constant use since the early 1990s as a vital informational resource/tool for air traffic controllers”；PCMag 的观察是，IDS-4 跑在带 3.5 英寸软驱的台式 PC 上。2026 年 4 月的交通部报告说得更直接：管制员一直靠一套“由软盘驱动、运行在过时操作系统上”的系统获取天气、NOTAM 和机场状态。2026 年 9 月的 GAO 报告 GAO-26-107992 点名这些遗留显示系统“依赖过时技术（例如软盘）和 1980 年代的接口”，数据组织低效、更新靠人工，管制员要检索和显示信息时非常笨拙。

所以 2028 年不是这件事的起点，而是收尾。2020 年 8 月，FAA 已经把 E-IDS 的设计开发合同授予 Leidos；这项工作属于 NextGen 空管现代化项目，而 NextGen 可以追到 2008 年。去年，时任代理 FAA 局长 Chris Rocheleau 在众议院拨款委员会上说的是 “No more floppy disks or paper strips”（再也不用软盘和纸条带）。同一份新闻稿里还列了一串别的进度：已替换 69% 的铜线，在 143 座塔上安装了 Surface Awareness Initiative（SAI）系统，26 座塔转为电子飞行条带，安装了 226 台 IP 语音交换机。

宣布归宣布，评论区先抓住的却是新闻稿里的形容词。

## 讨论焦点

### 一、“历史性”：一件四十年前就该做完的事

最直接的反应来自 superxpro12，他连着说了两句：

> "why is this &quot;historic&quot;? the thirst for this admin to use the most bombastic language possible is so tiring.<p>Just... modernize the thing already. thats your job. It&#x27;s not impressive that you did this. You&#x27;re supposed to do this." — superxpro12 [c:50393658]
> （译文：为什么这件事算“历史性”？这届管理层那种非要用最夸张措辞的渴求实在让人疲惫。<p>直接……把那玩意儿现代化掉就行了，那是你们的活。你做了这件事并不值得表扬。你们本来就得做这件事。）

stevep98 的吐槽落在那个被反复引用的缩写上（BNATCS，Brand New Air Traffic Control System）：

> "&gt; You can track the progress of the Brand New Air Traffic Control System (BNATCS) by state and airport on our Modern Skies website.<p>Another trump tell…  Lame acronym." — stevep98 [c:50394367]
> （译文：可以在现代天空网站上按州和机场追踪全新空管系统（BNATCS）的进度。<p>又一个 Trump 式的信号……这缩写真难看。）

tokai 的判词只有三个词：

> "You could call it histrionic." — tokai [c:50393751]
> （译文：你也可以说这是歇斯底里。）

但把话说完整的是 driverdan，他同时给出了时间线：

> "The politically grandstanding is gross. From what I can tell E-IDS has been in development since at least 2020 with a planned rollout starting in 2025.<p>Unfortunately web search has gotten so bad that it&#x27;s hard to find past information about it." — driverdan [c:50395528]
> （译文：这种政治作秀很恶劣。据我所知，E-IDS 至少从 2020 年就在开发，原定的推广从 2025 年开始。<p>可惜现在的网络搜索已经糟到很难找到过去的信息了。）

也就是说，“历史性”修饰的是终点，不是起点：合同 2020 年就签了，原定推广 2025 年就要开始，现在宣布 2028 年底完成。

### 二、老技术到底安不安全：一份没有结论的对账

支持换的人认为拖延本身才是风险。p-e-w 的判断只有一句：

> "Using outdated computer systems with aging storage media <i>is</i> a safety issue." — p-e-w [c:50393565]
> （译文：使用过时的计算机系统和老化的存储介质，本身就是一个安全问题。）

反对的人从另一个方向问：有没有哪次事故真的由软盘造成？1970-01-01 的反问很硬：

> "No, it isn&#x27;t. This is time tested process. Find me any flight that had to land or crashed because the floppy disk was broken." — 1970-01-01 [c:50393921]
> （译文：不，不是这样。这是一个经过时间检验的流程。你给我找出任何一次因为软盘坏了而必须备降或者坠毁的航班。）

superxpro12 从可靠性数学的角度给同一件事换个说法：

> "The overall reliability of a system is time invariant... its either reliable, or not.<p>The fact that it has gone x days without an incident doesnt upgrade or downgrade its reliability. The engineering and processes are function in an equation that calculates mean time to failure. Life-critical processes have numbers placed to this... like a failure every 50 years or 100 years... or 100000 years, and you work towards solving that." — superxpro12 [c:50397245]
> （译文：一个系统的整体可靠性是与时间无关的……它要么可靠，要么不可靠。<p>它已经 x 天没出事故这件事，既不提升也不降低它的可靠性。工程和流程是那个用来算平均无故障时间的方程里的函数。生命攸关的流程都有对应的指标……比如五十年一失效、一百年一失效，或者十万年一失效，然后你朝那个目标努力。）

drak0n1c 的回答是两边都不完全对：系统是动态的，遗留要求的代价不体现在事故里，而体现在它挡住了别的东西。

> "Systems are dynamic, not static. There are secondary consequences and forgotten&#x2F;ignored opportunity costs. Sure, the existing system has proven workarounds, though labor and attention intensive. When a floppy disk fails it won&#x27;t directly create disaster. But these legacy requirements do block the more cohesive and thorough introduction of additional safety mechanisms that increase redundancy and reduce the scope of possible human error - such as new sensor hardware and their automation, latency improvements, and information synthesis&#x2F;notification clarity." — drak0n1c [c:50398033]
> （译文：系统是动态的，不是静态的。存在次生后果，也存在被遗忘或被忽略的机会成本。现有的系统当然有被验证过的绕行方案，虽然费人力费注意力。软盘坏了不会直接酿成灾难。但这些遗留要求确实会阻挡更整体、更彻底地引入新的安全机制——比如新的传感器硬件及其自动化、延迟改善，以及信息汇总与通知的清晰化。）

这一节没有结论。软盘不会自己让飞机掉下来，但软盘挡住了别的东西——两边都成立，这就是分歧的形状。

### 三、卡住四十年的是老主机，不是软盘

整场讨论里信息量最大的一条，来自 Jtsummers。他说自己这十年还在维护用软盘的系统：

> "I&#x27;ve worked on systems this decade that still relied on floppy disks. It&#x27;s getting harder and harder for them to operate because the disks are getting rarer, as are the drives. And often the essential component is not the disk itself. There are some other computers in the system that cannot be upgraded to any more recent device, systems from the 1980s and 1990s that force them to continue using a floppy disk.<p>If it was just two modern computers and transferring data between them, the floppy disk would have been dropped in a heartbeat. But it&#x27;s the old computers still in the critical path that are holding everything back. And those are <i>really</i> hard to maintain." — Jtsummers [c:50394202]
> （译文：我这十年里一直在用依赖软盘的系统工作。它们越来越难维持，因为软盘越来越难找，驱动器也是。而且关键组件往往不是软盘本身。系统里还有别的计算机没法换成更新的设备——那些 1980、1990 年代的系统逼着它们继续用软盘。<p>如果只是两台现代计算机之间传数据，软盘早就被扔掉了。真正卡住一切的是那些仍然处在关键路径上的老计算机。而那些东西真的很难维护。）

SoftTalker 顺着这个思路解释了“为什么连 U 盘都没换”：

> "Aha so that answers my question about why they haven&#x27;t at least switched to USB thumb drives for their sneakernet. These aren&#x27;t PCs. Probably minicomputers such as a TI-990 or similar. They don&#x27;t have USB ports." — SoftTalker [c:50396586]
> （译文：啊，这就解释了我那个疑问：为什么他们至少没有把随身传数据的介质换成 U 盘。因为这些不是 PC，可能是 TI-990 之类的小型机。它们没有 USB 接口。）

Jtsummers 补上了一个更重要的判断：选项并不是非此即彼。

> "Fortunately the choice isn&#x27;t between 1980s hardware with floppy disk requirements and rented servers in someone else&#x27;s building. There are a <i>lot</i> of options in between those two." — Jtsummers [c:50394733]
> （译文：好在这并不是在“必须用软盘的 1980 年代硬件”和“租用别人机房里的服务器”之间二选一。这两者之间有非常多的选项。）

### 四、那为什么不直接插 U 盘、软驱模拟器或者 Zip 盘

问题被反复提出，答案也反复出现。jonhohle 问的是最朴素的那一版：

> "More information needed. Was this a sneakernet? No one thought of replacing with a floppy emulator and SD cards? All of the data can fit into 1.44MB?" — jonhohle [c:50393856]
> （译文：需要更多信息。这是个人工递送的网络吗？没人想过用软驱模拟器加 SD 卡来替换吗？所有数据都塞得进 1.44MB 吧？）

SoftTalker 提出的成本对比更直接：

> "A bit odd that they didn&#x27;t at least update to using USB thumb drives. Those are readily available and at least as reliable as magnetic floppy disks." — SoftTalker [c:50396466]
> （译文：有点怪，他们至少没有先换成 U 盘。那东西到处都有，而且至少跟磁性软盘一样可靠。）

vkaku 的问题是冲着这套现代化方案去的：

> "This is great. Question was, did you folks consider simply replacing these with Goteks and &#x2F; or testing something just a bit more reliable while digitizing these NOTAMs?" — vkaku [c:50396638]
> （译文：这很好。我的问题是，你们有没有考虑过干脆把它们换成 Gotek（软驱模拟器），或者在把这些 NOTAM 数字化的同时，先测试点更可靠的东西？）

ajsnigrutin 则指出这个问题本身没有出口：换介质这条路已经被走过很多次了。

> "The problem is, with what media would you replace them with if you had to replace them somewhere between then and now? iomega zip drives? Jaz drives? CF cards? sony memory sticks? rewritable cds&#x2F;dvds? Imation superdisks?<p>They could&#x27;ve replaced floppies multiple times, with all the certifications and hardware replacements and new procedures and regulations, and we&#x27;d still be using (a different, but still) &quot;obsolete&quot; medium for this now." — ajsnigrutin [c:50398097]
> （译文：问题在于，如果你非要在从那时到现在的某个节点换介质，你会换成什么？Iomega Zip 驱动器？Jaz 驱动器？CF 卡？索尼 Memory Stick？可擦写的 CD/DVD？Imation SuperDisk？<p>他们本来可以换好几次软盘，每次都伴随着认证、硬件更换、新的流程和规章，结果现在我们用的还是（换了个样子、但仍然是）“过时”的介质。）

还有人在原始报道里挖到了更离谱的一层。wat10000 引用另一篇报道说，实际用的是 8 英寸盘：

> "According to this article, it&#x27;s <i>far</i> worse than that: eight inch floppy disks! Capacity might be as much as 1.2MB per disk, but probably less." — wat10000 [c:50394728]
> （译文：按照这篇文章的说法，情况比那还要糟得多：是 8 英寸软盘！单盘容量最多大概 1.2MB，可能还更少。）

这条来自评论区引用的二手报道，FAA 的官方材料没有提介质尺寸，与之相关的 120 亿美元成本数字同样只出现在评论链接的那篇里。

### 五、物理介质就是隔离层：换成云会不会更糟

这是另一派人的核心理由。Dwedit 承认软盘有物理缺陷，但先肯定了它的架构价值：

> "At the very least, physical media is airgapped.  Floppies still aren&#x27;t a good choice though, since they develop bad sectors so easily." — Dwedit [c:50394538]
> （译文：至少，物理介质是隔离的。软盘仍然不是个好选择，因为它们太容易长出坏扇区了。）

genxy 顺着这个方向问了一句更尖锐的：

> "Do they? or is it low quality media? Rather than judging old tech bad, new tech good we should look at the requirements and tradeoffs. The failure modes of the new replacement system look more catastrophic to me, relying on cloud infra and internet links.<p>... 12 billion for a new system that might not actually be an improvement is a lot of money." — genxy [c:50395414]
> （译文：是它们（出故障）吗？还是介质质量低？与其简单地判定老技术坏、新技术好，不如看需求和取舍。新替代系统的失效模式在我看来更灾难性，因为它依赖云基础设施和网络链路。<p>花 120 亿美元换一套可能并不是改进的系统，这笔钱很多。）

tonymet 补上了这个隔离层其实有多薄：

> "there&#x27;s no such thing as air gapping when people are involved.<p>The weather records have to be written to the floppy from an online device at some point in the pipeline.<p>The workflow has likely been compromised at some time, but due to lack of data integrity checks, it was never detected." — tonymet [c:50399144]
> （译文：只要有人参与，就不存在所谓的隔离。<p>天气记录在流程的某个环节，总是要从一台联网设备写到软盘上。<p>这条链路很可能在某个时候已经被污染过，但因为缺少数据完整性校验，从未被察觉。）

ale42 的担心更直接：

> "Replacing them with cloud-based systems (if this is the &quot;streamlined, 21st-century system&quot;) is a safety issue <i>as well</i>. I hope they are not." — ale42 [c:50393688]
> （译文：把它们换成基于云的系统（如果这个“精简的 21 世纪系统”指的就是那个的话），同样是一个安全问题。希望不是。）

### 六、休斯敦那根被挖断的光纤：冗余长什么样

讨论中途拐进了一条具体事故。lp92 贴出 FAA 提到的一次事件：一根连接休斯敦乔治·布什洲际机场与 FAA 网络的光缆，在航站楼外被挖断，导致设施间数据服务中断，机场进入地面停飞状态。他的反应是：

> "Do they seriously not have a backup connection? I would have expected them to have a backup stelite or maybe even a 4G&#x2F;5G mobile data system in place.<p>If I can use my phone as a Hotspot when Comcast is doing some service so I can work, I don&#x27;t understand what idiot designed an airport without backup connections." — lp92 [c:50394458]
> （译文：他们真的没有备份连接吗？我本来以为至少会有卫星备份，或者一套 4G／5G 移动数据系统。<p>就连 Comcast 维护服务的时候，我都能开手机热点干活，我不明白是哪个白痴设计的机场会没有备份连接。）

Jtsummers 直接把前提拆掉：

> "That <i>was</i> the backup connection. The primary failed, and concurrently the backup had been severed by a construction crew." — Jtsummers [c:50395798]
> （译文：那其实就是备份连接。主链路故障的同时，备份链路被施工队挖断了。）

superxpro12 于是指出真正的问题在冗余度：

> "they did... it was just singly redundant. they would need double redundancy here. so 3 connections, not 2" — superxpro12 [c:50397187]
> （译文：他们有……只是单路冗余。这种场合需要双路冗余，也就是 3 条连接，不是 2 条。）

alt227 把这件事讲成了通用原则：

> "Taking one connection out for maintenance and leaving only 1 live connection is not redundancy, it is a failed backup.<p>Redundancy is always having more than one live connection." — alt227 [c:50397445]
> （译文：把一条连接拿出来维护、只留一条在线，这不叫冗余，这叫备份失效。<p>冗余的定义永远是同时有不止一条在线连接。）

那么正确的冗余长什么样？ErroneousBosh 描述了自己做布线时的做法：

> "I have literally spraypainted the pavement and wall - &quot;One fibre goes here, and down on the corner there, the other fibre goes there&quot; - just to ensure a good separation of routes. I want the pinch point to be within the rack that the routers sit in." — ErroneousBosh [c:50395881]
> （译文：我真的在路面和墙上喷过漆——“一根光纤走这边，拐角那边另一根走那边”——就是为了确保两条路由充分分离。我希望收窄点落在路由器所在的机架里。）

机载系统里的做法是三余度：

> "Which is why many systems on most airliners are redundant in threes (though under double fault may operate in a degraded mode)." — jessa0 [c:50395832]
> （译文：这就是为什么大多数客机上的许多系统都是三余度的（虽然在双重故障下仍可能以降级模式运行）。）

addaon 立刻纠正了这个简化说法：

> "Triplex redundancy is based on a failure model where failures can produce arbitrary output. Three systems allows majority voting (often, median select) to provide correct output in the presence of a single arbitrary failure." — addaon [c:50396658]
> （译文：三余度建立在一个假设失效可以产生任意输出的失效模型上。三套系统允许多数表决（通常是中值选择），从而在任意单点失效的情况下给出正确输出。）

xenadu02 则给了一个更贴近日常的类比，顺带替这套系统说了句公道话：

> "If you are curious: one of the most frequent problems that disables fire sprinklers is maintenance forgetting to turn the water back on. No one notices until it is too late.<p>No one notices the thousands of times the redundant links works just fine. We only notice when the primary has an outage <i>and</i> a construction crew cuts a fiber line at the same time." — xenadu02 [c:50397383]
> （译文：如果你好奇：让消防喷淋失效最常见的原因之一，是维护完之后忘了把水打开。往往等到太晚都没人发现。<p>没人注意到冗余链路上千上万次正常工作。我们只在主链路中断、同时又有施工队挖断光纤的时候才注意到。）

### 七、官僚与速度：安全关键系统的两条路

最后一节把话题从技术拉回了流程，而这一节里最有分量的一段来自一位自称参与过 FAA NOTAM 数字化改造的工程师 bargl：

> "I worked on modernization in the FAA specifically around digitizing NOTAMs.<p>I would urge you not to consider this modernization from the perspective you may be familiar, as someone who may work on the bleeding edge and sometimes sees a lack of caution from engineers pushing for change.<p>The FAAs safety risk management is built around a rigorous process, but that is also a massive slowdown to reasonable progress." — bargl [c:50394856]
> （译文：我参与过 FAA 的现代化改造，具体是 NOTAM 的数字化。<p>我恳请你不要用你可能熟悉的那个视角来看这次改造——你可能在最前沿工作，偶尔会看到工程师推动变更时缺乏谨慎。<p>FAA 的安全风险管理建立在一套严格的流程上，但这同时也是对合理推进的巨大拖慢。）

他的结论落在两个方向的警告上：现任管理层在把安全往后放，但安全也可能变成挡路的绊脚石。

另一派认为这套严格流程本身就是问题。consensus1 说得非常干脆：

> "The assumption that moving slower and more bureaucratically increases safety and reliability is one of the most harmful myths out there." — consensus1 [c:50395637]
> （译文：认为“更慢、更官僚就能提高安全性和可靠性”，这是外面最有害的迷思之一。）

idiotsecant 建议先在别的行业待过再发言：

> "You really, really need to work in industrials controls before your opinion carries weight on this - there are plenty of 40 year old systems humming along keeping the world turning that are bulletproof reliable.<p>&#x27;Move fast and break things&#x27; is fine when the result of failure is someone failing to make a billion dollars at their IPO. It&#x27;s not acceptable in the world where failure means dams break, reactors go supercritical, planes collide, or other similarly apocalyptic scenarios." — idiotsecant [c:50395949]
> （译文：你真的、真的需要在工业控制领域干过，你在这件事上的观点才有分量——有大量 40 年前的老系统还在稳定运转，支撑着世界，而且可靠得能顶子弹。<p>“快速迭代、边做边坏”这套在失败代价只是有人 IPO 少赚十亿美元时没问题。在失败意味着大坝垮、反应堆失控、飞机相撞这种近乎末日场景的世界里，它不可接受。）

AngryData 把两边各打五十大板：

> "I don&#x27;t. Incompetence costs lives. Using old tech that has worked for decades costs a couple dollars extra to maintain for a system worth millions." — AngryData [c:50399011]
> （译文：我不同意。无能是要死人的。用已经稳定运行了几十年的老技术，代价只是给一个价值数百万的系统每年多花点维护费。）

ethin 反驳的是那种“要做得快”的说法：

> "Why? Do you want more people to die? The only way to migrate a system like this safely is to do it competently and slowly." — ethin [c:50397707]
> （译文：为什么？你是想让更多人死吗？像这样的系统要安全迁移，唯一的办法就是既专业又缓慢地做。）

而 lp92 的那句，是这场讨论里最不客气的一句：

> "This isn&#x27;t about safety. Its about bureaucracy wrapped up as safety." — lp92 [c:50395501]
> （译文：这不是关于安全。这是把官僚主义包上一层安全的外衣。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| “历史性”这个词用得离谱 | superxpro12 | 该做的是你们的工作，不需要额外表扬 |
| 缩写是典型的政治信号 | stevep98 | “Lame acronym.” |
| 换成 histrionic 更准 | tokai | “You could call it histrionic.” |
| 时间线才是重点 | driverdan | 合同 2020 年就签了，原定 2025 年开始推广 |
| 老存储就是安全风险 | p-e-w | “Using outdated computer systems … is a safety issue.” |
| 找不到软盘导致的事故 | 1970-01-01 | 请举出一架因软盘坏掉而备降或坠毁的航班 |
| 可靠性与时间无关 | superxpro12 | 系统要么可靠，要么不可靠，不因为“这么久没出事”而升级 |
| 系统是动态的 | drak0n1c | 遗留要求挡住的是冗余、延迟和信息清晰度这些改进 |
| 真正的瓶颈是老主机 | Jtsummers | 软盘早就该扔，卡住的是还在关键路径上的老计算机 |
| 两端之间还有大量选项 | Jtsummers | 不是“1980 年代硬件”与“租别人的服务器”二选一 |
| 连 U 盘都换不了的原因 | SoftTalker | 那些是 TI-990 之类的小型机，没有 USB 口 |
| 为什么不上软驱模拟器 | jonhohle | “All of the data can fit into 1.44MB?” |
| U 盘至少不更差 | SoftTalker | 到处都有，至少和磁性软盘一样可靠 |
| 先换一个更可靠的再数字化 | vkaku | “did you folks consider simply replacing these with Goteks?” |
| 换介质这条路没有出口 | ajsnigrutin | 换过好几次，最后还是“过时”的介质 |
| 物理介质就是隔离层 | Dwedit | “At the very least, physical media is airgapped.” |
| 新系统的失效模式更糟 | genxy | 依赖云基础设施和网络链路 |
| 隔离在有人的地方不存在 | tonymet | 天气数据总要从联网设备写到软盘上 |
| 别把云当成现代化本身 | ale42 | 换成基于云的系统“同样是一个安全问题” |
| 休斯敦机场本来就有备份 | Jtsummers | 那就是备份连接，只是被施工队挖断了 |
| 单路冗余不算冗余 | superxpro12 | 这种场合需要 3 条连接，不是 2 条 |
| 备份失效不等于冗余 | alt227 | “Redundancy is always having more than one live connection.” |
| 三余度是客机的做法 | jessa0 | 双故障下仍可能以降级模式运行 |
| 三余度不是简单多数表决 | addaon | 它建立在一个失效模型上 |
| 冗余链路平时没人注意 | xenadu02 | 消防喷淋最常见的事故原因是维护后忘了开阀门 |
| 参与者有自己的经验 | bargl | 参与过 FAA 的 NOTAM 数字化改造 |
| 官僚不必然等于安全 | consensus1 | “one of the most harmful myths out there” |
| 工业控制的老系统很可靠 | idiotsecant | 失败意味着大坝垮、飞机相撞就不可接受 |
| 老技术维护成本很低 | AngryData | “Incompetence costs lives.” |
| 迁移必须慢且专业 | ethin | “do it competently and slowly” |
| 安全成了挡箭牌 | lp92 | “bureaucracy wrapped up as safety” |

## 总体情绪

这条新闻本身的技术含量不高：一块 1.44MB 的软盘，四套 1980 年代的显示系统，435 个站点，2028 年底。可讨论出来的信息量全在评论区里，而且指向同一个结论：真正被淘汰的不是软盘，是那套让人不去想“为什么要换”的组织习惯。合同 2020 年就签了，原定 2025 年推广，四十年前就该做完的事被包装成“历史性”的成就，而 Jtsummers 说得最清楚——如果只是两台现代机器之间传数据，软盘早就没了；卡住的是还在关键路径上的那些老主机，它们没法换。

另一半的争论发生在纸面上：官僚流程挡住了现代化，还是官僚流程保护了百万条命？没人能给出两边都满意的答案，只有越来越精确的分歧——一个记得休斯敦机场 10 月 13 日那次地面停飞，一个记得 FAA 的安全风险管理流程其实也会变成挡路的绊脚石。lp92 那句“把官僚主义包上一层安全的外衣”，在这个帖子里没有被反驳。

真正让人不安的是另一层：4G、5G、云基础设施被反复拿来当作新的“冗余”，但同一批评论里，Jtsummers 说得没错——那条链路本来就存在，它只是恰好同时被挖断了。这套系统的问题从来不是介质不够新，而是它的冗余设计经不起一次施工队和一次检修撞在同一时刻。一架飞机的安全，最后落在某个机房里谁的机架漆喷得够仔细。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | US FAA says it will phase out floppy disks from air traffic control by 2028 | <https://news.ycombinator.com/item?id=50388001> |
| 2 | 原文：Reuters 报道 | <https://www.reuters.com/world/us/us-faa-says-it-will-phase-out-floppy-disks-air-traffic-control-by-2028-2026-11-05/> |
| 3 | FAA 新闻稿：Trump’s Transportation Secretary Sean P. Duffy Begins Retiring Decades Old Floppy Disks from Air Traffic Control | <https://www.faa.gov/newsroom/trumps-transportation-secretary-sean-p-duffy-begins-retiring-decades-old-floppy-disks-air> |
| 4 | Ars Technica：FAA to finally ditch floppy disks in what it calls “historic” tech upgrade | <https://arstechnica.com/tech-policy/2026/11/faa-to-finally-ditch-floppy-disks-in-what-it-calls-historic-tech-upgrade/> |
| 5 | FAA 技术页：Enterprise Information Display System（E-IDS） | <https://www.faa.gov/air_traffic/technology/eids> |
| 6 | GAO-26-107992：2026 年 9 月遗留显示系统审计报告 | <https://files.gao.gov/reports/GAO-26-107992/index.html> |
| 7 | 交通部 2026 年 4 月 Modern Skies 报告 | <https://www.transportation.gov/sites/dot.gov/files/2026-04/Modern%20Skies%20Summit_digital.pdf> |
| 8 | Systems Atlanta：IDS-4 系统说明 | <https://sysatl.com/ids4/> |
| 9 | Leidos：FAA 选择 E-IDS 作为企业信息显示系统（2020） | <https://www.leidos.com/insights/faa-selects-leidos-enterprise-information-display-system> |
| 10 | 现代天空（Modern Skies）进度追踪 | <https://modernskies.faa.gov/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 210 条评论，归档入库 129 条，快照 2026-11-07 00:41 UTC）及原文抓取内容（FAA 官方新闻稿、FAA E-IDS 技术页、Ars Technica 报道；Reuters 原文本次抓取与引用均返回 HTTP 401，未作为事实来源）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中系统数量、站点清单与改造进度数据截至 2026-11-05（FAA 新闻稿发布日）；8 英寸软盘尺寸与 120 亿美元成本数字来自评论区引用的二手报道，未经官方材料确认，请以 FAA 最新公告为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
