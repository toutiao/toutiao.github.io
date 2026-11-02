---
layout: post
title: >-
  警察局长亲手拔了 Flock 摄像头的电源 — HN 讨论摘要：合同已取消，设备还在录
date: 2026-11-02
hn_id: 50326118
categories: [articles]
excerpt: >-
  明尼苏达州普利茅斯市议会投票停用 Flock 车牌识别，厂商一周多不予回应，
  警察局长下令拔掉摄像头电源。评论区把争点从「拔线有没有用」推到
  「这些数据到底在谁手里」，以及厂商拒绝回应时究竟在赌什么。
tagline: >-
  合同已经作废，摄像头还在录；拔电源的是警察，不是市长。
---

> ⚑ **政治背景**：本文涉及美国警务系统、Flock 车牌识别监控网络（ALPR）、联邦移民执法与外包服务商之间的关系，以及围绕隐私权、公共资金采购、厂商问责与选票的讨论。⚠ Review recommended.

> 来源：HN 讨论帖，提交者 entryleveljobsc。帖子：[Police chief unplugs cameras after Flock ignores contract cancellation](https://news.ycombinator.com/item?id=50326118)，411 分，145 条评论（抓取时快照）。原文报道：[The Drive](https://www.thedrive.com/news/my-city-canceled-flocks-contract-flock-ignored-it-so-the-police-chief-unplugged-the-cameras)。相关讨论线：[In Leaked Audio, Flock CEO Tells Cops Backlash to the Company Isn't Real](https://news.ycombinator.com/item?id=50248005)，317 分，168 条评论，原文为 [404 Media](https://www.404media.co/in-leaked-audio-flock-ceo-tells-cops-backlash-to-the-company-isnt-real/)；[Proton Flock Camera Map](https://news.ycombinator.com/item?id=50236748)，89 分，18 条评论，原文为 [Proton](https://proton.me/flock-camera-map)。

## 原文概要

The Drive 的报道从一个私人恩怨写起。四个月前，普利茅斯（明尼苏达州）有四名警察开着警车埋伏了记者 Joel Feder 和他的妻子；按他自己的说法，他们靠 Flock 摄像头跟踪了这对夫妻好几天之后才动的手，而那次埋伏是错的（wrongfully）。一个月前的那个星期二，市议会投票决定取消 Flock 合同；而报道当天，这些摄像头还装在城市各处。

引出这件事的是警察局长 Eric Fadden。他给出的时间线很清楚：市议会在 9 月 22 日的会议上投票停用 Flock 的自动车牌识别（ALPR），9 月 23 日警方就停用了普利茅斯用户的全部 Flock 账号并通知了 Flock；随后在咨询市法律顾问办公室后，用美国邮政和电子邮件发出了正式的解约函。Fadden 说，此后没有收到 Flock Safety 公司或法务部门的任何回复，只有和本地代表有过一些沟通。等了一周多没有下文，他下令让工作人员把摄像头的电源线拔掉，以确保它们没有在运作、没有在记录车牌。Feder 自己去看了两台摄像头，电源线确实被拔掉了。

解约函没有连带拆走硬件。Flock 是订阅制服务：警察部门签合同，Flock 安装设备并提供硬件与软件访问权限，摄像头本身归 Flock 所有。Fadden 说他们仍在不断联系 Flock 索要拆除时间表，但目前没有确切答案可分享；The Drive 就解约流程与拆除时限多次联系 Flock，同样没有回应。

第二条线来自 404 Media 拿到的一段录音。10 月下旬，Flock 的 CEO Garrett Langley 在奥兰多举行的国际警察局长协会（IACP）年会上，对着一屋子的警察局长说，针对 Flock 的抗议不是真的：社交媒体上关于 Flock 的讨论从 7 月起下降了大约 95%，原因是有人之前在付钱、后来不付了；他称这些内容由匿名机器人批量生产，反对声音不是真实的，并重复了一种已被证伪的说法——乌克兰用无人机轰炸俄国的数据中心，一夜之间让机器人活跃度减半。他还提到妻子的建议是「你永远不该道歉」，随后自陈过去九年犯了很多错、这个夏天也犯了很多错，「但我们做的是好事」。

这段话里有两个被反复引用的数字：Flock 的全国网络约有 8 万台摄像头，警察搜一个车牌可以搜到本辖区、本州之外的机器，只要那些地方的警方把设备接进了网络；404 Media 去年披露过本地警察替移民与海关执法局（ICE）做查询，也披露过德州一名警察在全国范围内搜寻一名自行终止妊娠的女性。过去 18 个月里，已有几十座城市取消了与 Flock 的合同。同一周末，竞争对手 Axon 在 Hard Rock Cafe 办了派对。Langley 判断说，反对声音还没到底，但已经很接近，接下来会从另一边回来。同一条讨论线里还转引了两条更早的报道：9 月的《Flock Offers Employees Buyouts as Customers Flee》，以及 8 月底 Ars Technica 的《Cities terminate Flock contracts at record pace in August》。

第三条线来自 Proton 托管的一张公开地图，可以按邮编搜索 Flock 设备位置，数据出自安全研究员 Joshua Michael 的独立研究：2025 年 11 月他发现 Flock 的服务器存在无需登录即可获取的访问令牌，能拿到设备位置信息，报告给 Flock 后在当年 12 月公布清点结果——17 万台以上摄像头，外加 13 万台以上其他 Flock 设备；而 Flock 公开的说法是约 12 万台摄像头，实际数量高出约 40%。Proton 的页面上还给出这层网络的两项量级：Flock 称其网络每月处理超过 200 亿次车辆读取，覆盖 49 个州；《华盛顿邮报》的调查发现至少 50 名警官被指控或被控滥用车牌识别系统，Flock 出现在其中 46 起案件里。

## 讨论焦点

### 一、一周的沉默，算不算「不回复」

事实先被校准了一遍。有人认为标题把事情说轻了：

> "I think this is sensationalised - it looks like they only waited about a week after cancellation before they started unplugging them." — Closi [c:50327217]
> （译文：我觉得这件事被渲染了——看起来他们取消之后也就等了一周左右就开始拔线。）

「不回复」这个说法立刻遇到了反驳：

> "One week to respond to a letter delivered by US postal mail isn't really much time." — SoftTalker [c:50327197]
> （译文：给一封走美国邮政的信件留一周回复时间，谈不上多。）

更细的分歧在合同本身。没人看到合同条款，所以「市议会投票取消」和「合同即刻终止」被当成两件事：

> "The article doesn't really tell us what the contract terms are, though. Just because the city voted to cancel the contract doesn't mean it ends immediately and Flock has to come remove all the cameras upon request." — idopmstuff [c:50327097]
> （译文：文章其实没说合同条款是什么。市议会投票取消合同，并不意味着合同立即终止、Flock 必须应要求马上拆走摄像头。）

而真正尖锐的问题是：合同没了，Flock 继续占着公共资源合不合法。

> "So if they no longer have a contract, how is it legal for Flock to continue to use the allocated resources? Why not hit them with theft of service for continuing to draw power and use public infrastructure?" — voakbasda [c:50326566]
> （译文：那如果他们已经没有合同了，Flock 继续占用那些资源怎么就合法了？为什么不能以盗用服务追究他们继续取电、继续使用公共设施？）

这条问题下面挂着的追问更实用：解约要做的第一件事不是拔电，是锁数据。

> "The first thing the city should do when cancelling is lock down the data so no jurisdictions have access to the data." — thephyber [c:50328761]
> （译文：取消合同时，这座城市该做的第一件事是锁住数据，让任何辖区都查不到这些数据。）

同一位评论者把合同透明度摆到制度层面：

> "If nothing else, this is a good example of why the contract terms for government vendors MUST be public records and NDAs of private companies on public officials for the purposes of sales should not be legally enforceable." — thephyber [c:50328761]
> （译文：起码这说明了为什么政府供应商的合同条款必须是公开记录，而私营公司对公职人员签的、用于销售目的的保密协议不应该具有法律效力。）

拔电这个动作因此被放回了合同框架里：它是一场单方面的紧急止损，不是执行解约。

### 二、拔电源这件事，可能从一开始就没拔对

拔线的细节被评论区纠了一遍：Flock 的摄像头大多根本不靠市电。

> "flock cameras aren't powered from the power grid, they have their own solar panels and batteries (which is what allows them to be deployed to quickly and widely) so I presume the article just meant unplugging those." — voxic11 [c:50327667]
> （译文：Flock 的摄像头不是靠电网供电的，它们有自己的太阳能板和电池（也正是这一点让它们能被快速、大范围地部署），所以我猜原文说的「拔掉」指的就是拔这些线。）

> "They have cell signals, batteries, and solar panels. Many are already not plugged into anything." — delecti [c:50327862]
> （译文：它们有蜂窝信号、有电池、有太阳能板。很多本来就没插在任何东西上。）

于是破坏性方案被摆到桌面上，而且讨论迅速转向更技术的一层：

> "The cameras seem vulnerable to a simple non-invasive opaque elastic-banded plastic shower cap" — kirykl [c:50326976]
> （译文：这些摄像头看起来很容易被一个简单、无侵入、不透明、橡皮筋绑着的塑料浴帽搞定。）

> "I'm more interested in whether they are vulnerable to fake data being injected via a slide show of car images shown in front of the camera lens." — thephyber [c:50327020]
> （译文：我更关心的是它们是否容易被假数据攻破——在镜头前放一段汽车图片的幻灯片播放。）

这两种思路的共同前提是：设备是死的，删掉设备就删掉了监控。而评论区里另一种意见直接否掉了这个前提——设备能被远程重新启用。有读者从原文里摘出了另一座城市的做法：

> "Dayton, another city in Minnesota located just 10 miles north of Plymouth, has also paused its Flock program and disabled the two devices in the area." — dcrazy [c:50327443]
> （译文：戴顿，明尼苏达州另一座城市，在普利茅斯以北 10 英里，也暂停了 Flock 项目，并停用了当地的两台设备。）

对砸设备这件事本身，评价并不客气：

> "I am not impressed by the destruction of easily replaced obsolete hardware." — buildsjets [c:50329647]
> （译文：砸掉一些轻易就能被替换的过时硬件，我并不觉得有什么可 impressed 的。）

### 三、CEO 说反弹「不是真的」

第二条讨论线的主线是那段录音本身。最直接的读法是：每一次指控都是一次自白。

> "Every accusation is a confession. Flock pays for support. They have a marketing department and they tell cops what to tell elected officials to think." — 01HNNWZ0MV43FF [c:50249089] [thread 2]
> （译文：每一次指控都是一次自白。Flock 在花钱买支持，他们有市场部门，会告诉警察该怎么去影响民选官员。）

「反对声音是机器人」这个说法本身，被认为是一件危险的事，而不只是公关失误：

> "The concern with this is that it gives any company/government/etc. latitude to plant paid protestors or bot traffic in order to undermine opposition with greater efficacy in the AI era." — CodingJeebus [c:50249480] [thread 2]
> （译文：这里的隐患在于，它给了任何公司或政府一种余地：在 AI 时代花钱雇人抗议或者刷机器人流量，更有效地瓦解反对声音。情报机构早就懂这套打法很多年了。）

而对「承认错误却拒绝道歉」的读法，评论区里的追问很直白：

> "So this guy admits he did things that he shouldn't have then contends that he shouldn't have to say sorry for them? Am I reading this right?" — alexjplant [c:50249463] [thread 2]
> （译文：这家伙承认自己做了不该做的事，然后还主张自己不该为此道歉？我读得对吗？）

更让人不安的不是机器人说法本身，而是它通往的下一步：

> "Historically it was an easy step going from "these people are not real" to "these people are now dead"." — BoxwoodSeed [c:50248999] [thread 2]
> （译文：历史上，从「这些人不是真的」到「这些人现在是死了的」，只是一步之遥。）

另一种读法把这当成创始人性格问题：CEO 说话的对象一直是警察，不是大众。

> "Garrett Langley scares the normies. That's fine if your audience is just cops. But it doesn't go over well with the public at large." — Zigurd [c:50249839] [thread 2]
> （译文：Garrett Langley 会把普通人吓着。如果你的观众只是警察，那没问题；但对大众来说就不好使了。）

真伪之争则完全没有结论。有人说反弹百分之百是真人：

> "Yeah, I don't think so. The backlash is 100% real people. I don't know a single pro-Flock person but I know 100s that want to go take them down." — slowin [c:50249500] [thread 2]
> （译文：我不这么看。反弹百分之百是真人。我一个支持 Flock 的人都不认识，但我认识几百个想去把它拆了的人。）

也有人现身说法自称支持方：

> "I am a pro-flock real person. I'll get down-voted and likely flagged for saying this so you may believe I don't exist but I do." — bko [c:50249688] [thread 2]
> （译文：我是一个支持 Flock 的真实存在。我会被踩，也很可能被标记，所以你可以不信我存在，但我确实存在。）

最后一种回答把真假问题搁置，改成承认两边同时存在：

> "As with most antistate issues today, there is a mix of bots/institutional interference (both foreign and domestic), and real people. Both can be true." — CGMthrowaway [c:50248618] [thread 2]
> （译文：像今天大多数反国家议题一样，机器人和机构性干预（国内国外都有）混着真人，两件事可以同时成立。）

### 四、地图：把三十万台设备摊在桌面上

第三条讨论线的规模感来自那张地图本身。评论者的第一反应不是政治，而是数量：

> "Wow, they're everywhere. I did not realize the extent of it" — FergusArgyll [c:50238451] [thread 3]
> （译文：哇，到处都是。我之前完全没想到是这个量级。）

地图本身也被当作数据来挑毛病，尤其是和众包的 DeFlock 项目对照：

> "This map is missing a number of locations near me that DeFlock (https://deflock.org/) has. For example, entrances to Stanford's campus." — eiiot [c:50237592] [thread 3]
> （译文：这张地图漏掉了我家附近 DeFlock（https://deflock.org/）有的好多个点，比如斯坦福校园的各个入口。）

> "Why are there so few cameras in Manhattan, but so many almost everywhere else? San Francisco has a ton of them for example." — olegdotcom [c:50238526] [thread 3]
> （译文：为什么曼哈顿的摄像头这么少，其他地方几乎到处都是？比如旧金山就多得吓人。）

地图上标着「在运行」的一台设备，可能早就被人拆了：

> "The two in my California neighborhood actually got cut down about a month ago and one hasn't been replaced yet (still shows active on that map)." — carimura [c:50238594] [thread 3]
> （译文：我加州社区里的那两台其实一个月前就被砍倒了，其中一台到现在没被替换（在地图上仍显示在运行）。）

而地图可能带来的风险，评论区也提了：把火力集中在一家公司身上，别的公司反而没人盯。

> "It is very good that Flock is getting so much negative attention, but I fear that Flock may be a "trap crop" in this space, distracting the public taking all the heat while some other companies are doing the same thing without all the public awareness." — b00ty4breakfast [c:50238595] [thread 3]
> （译文：Flock 得到这么多负面关注当然很好，但我担心 Flock 可能是这个领域里的一株「诱捕作物」——把公众的火力全吸走，而其他公司做着同样的事，却没得到同样的公众认知。）

把地图托管给一家以隐私为招牌的公司，也有人觉得需要额外谨慎：

> "I'm a big fan of Proton, and I couldn't imagine using anyone else's email services, but in the age of ID verification for porn and governments trying to ban VPNs, I just hope there aren't any bears that feel this poke is too hard." — illithid0 [c:50237255] [thread 3]
> （译文：我是 Proton 的铁杆用户，想象自己用别人的邮件服务，但在连成人内容都要查身份证、连政府都在想法禁用 VPN 的年代，我只希望没有哪只熊觉得这一下戳得太狠了。）

### 五、Flock 不回信，在赌什么

「为什么一家公司宁愿把客户得罪到底也不回信」，是这条讨论线里最集中的疑问。最直接的猜测是：警察部门不是唯一客户。

> "The local government isn't their only customer. They also have contracts with the federal government who wants piggyback access to as many cameras as they can." — pavon [c:50328360]
> （译文：地方政府不是他们唯一的客户。他们和联邦政府也有合同，联邦政府想搭便车用到尽可能多的摄像头。）

而「本地」的价值，也许只是让设备先落地：

> "That's what confuses me too. If they aren't making money any longer, they're basically saying "fuck you" to their own target customers? What's the aim?" — siruncledrew [c:50327920]
> （译文：这一点也让我困惑。如果他们不再从本地赚钱了，那基本上等于对自己的目标客户说了「去你的」？图什么？）

商业模式被类比成 Uber：把风险留给城市，把收益留给平台。

> "They're just following the Uber business model. Consequences for thee, not for me." — kevin_thibedeau [c:50327043]
> （译文：他们不过是照着 Uber 的商业模式做而已。后果归你，不归我。）

> "Wasn't this basically Uber's model? They just ignored any local regulation they didn't like, even to the point of building a system to prevent government officials were trying to take Ubers so they couldn't get fined." — apical_dendrite [c:50327830]
> （译文：这不就是 Uber 的模式吗？他们无视任何自己看不顺眼的地方规定，甚至专门造了一套系统，防止那些想查 Uber 的政府官员把他们罚了。）

于是责任归属成了分歧点：把 Flock 当成一把枪，还是当成一个有人的公司。

> "Flock has real human officers who direct it and shareholders who profit from it (those groups overlap), it is not an inert object wielded by the State." — dragonwriter [c:50328643]
> （译文：Flock 有真实的人在指挥它，有真实的人从它身上获利（这两拨人还有重叠），它不是国家手里一件惰性的工具。）

> "it's clear that 3 letter agencies wants flock online, bit weird to put blame on flock, when it's just a gun that's being handled by the federal gov." — Yiin [c:50327912]
> （译文：很明显三字母机构想让 Flock 上线，把责任推给 Flock 有点怪，毕竟它只是联邦政府手里的一把枪。）

> "It's a mass-surveillance dragnet, not a gun." — skinfaxi [c:50328225]
> （译文：它是大规模监控的拖网，不是一把枪。）

### 六、Ring 还是 Flock：这场争论的真正分界线

评论区里另一条清晰的轴，是把 Flock 和 Ring 放在一起比。差别不在数量，而在数据和辖区：

> "Flock gives law enforcement privileged access to footage outside of their jurisdiction with actual features that support mass surveillance, like tracking cars across state lines." — tomnipotent [c:50328266]
> （译文：Flock 让执法部门获得辖区之外的特权访问，而且它真的具备支持大规模监控的功能，比如跨州追踪车辆。）

> "Only one of these two supports commercial dragnet." — tomnipotent [c:50328266]
> （译文：这两家里只有一家支撑得起商用级的大规模拖网。）

反对这种区分的人则认为这是一条光谱，不是二分：

> "You're reducing a spectrum to a binary, with all the errors that always come along with that." — antonvs [c:50328302]
> （译文：你把一条光谱压成了二分法，而这么干总是伴随着那些随之而来的错误。）

而摄像头与犯罪的关系，仍然是另一场没有结论的争论。一份自称严谨的本地研究报告给的是零：

> "I ran an in depth study of Flock for my city. It's been deployed here for several years. What I found is that there is no statistically significant correlation between Flock being installed and any reduction in any kind of crime." — felixgallo [c:50249887] [thread 2]
> （译文：我为我们市做了一份 Flock 的深度研究，它已经部署好几年了。我发现的是：Flock 的安装与任何类型犯罪率下降之间，没有统计显著的相关性。）

反方则要求先看更长的时间尺度和别的变量：

> "Have you tried zooming out on the stats at all, or analyzing any other variables? You realize there was a crazy spike in crime in the wake of the pandemic, right?" — rconti [c:50249784] [thread 2]
> （译文：你有没有把统计图放大一点看，或者分析一下别的变量？你知道疫情之后犯罪率出现过一轮疯狂飙升，对吧？）

而认为公众把注意力放错了地方的人，给出的比例更刺眼：

> "I find the backlash against ALPRs wildly disproportionate." — whimsicalism [c:50327338]
> （译文：我觉得针对 ALPR 的反弹严重失衡。）

> "On a local thread complaining about our township budget it was pointed out that we spend 45% of tax revenue on policing and that if we want real cuts, some has to come from there." — Libcat99 [c:50327781]
> （译文：在我们镇的一个讨论预算的帖子里有人指出，我们把 45% 的税收花在警务上；如果想真正削减开支，总得从那儿先砍。）

把注意力引到别处去的观点，也在同一批评论里：

> "Data centers and Flock are the two things uniting left and right protesters." — nkrisc [c:50250037] [thread 2]
> （译文：数据中心和 Flock，是把左翼和右翼的抗议者拉到一块儿的两件事。）

讨论的终点绕回了政治参与。有人认为不投票不是冷漠，是不信任：

> "I don't think people aren't voting due to apathy, they aren't voting because they don't trust the system." — Avicebron [c:50327764]
> （译文：我不认为人们不投票是因为冷漠，他们不投票是因为不信任这个系统。）

也有人认为这件事本身就是参与的结果：

> "The genesis of the article is civic engagement that rejected Flock, prompting elected officials, whose decision is then being supported by the police department." — 1shooner [c:50328192]
> （译文：这篇报道的起点就是一次拒绝了 Flock 的公民行动，它推动了民选官员，而民选官员的决定又得到了警方的支持。）

> "What evidence will be sufficient for you that, yes, citizens are engaged in civics?" — drewbeck [c:50328887]
> （译文：什么样才算是足够的证据，能让你承认公民确实参与了公共事务？）

而对警察这个角色本身，评论区的判断分成两半：

> "One of the most compelling aspects of American governance is the latitude local law enforcement has. They can be both an ally and enemy to freedom." — Papazsazsa [c:50326612]
> （译文：美国治理中最耐人寻味的一面，就是地方执法部门拥有的自由度。他们既可能是自由的盟友，也可能是自由的敌人。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题夸大了 | Closi | 取消之后也就等了一周左右就拔线了 |
| 一周回复期不算短 | SoftTalker | 走美国邮政的信件，留一周回复时间不多 |
| 合同条款才是关键 | idopmstuff | 投票取消不等于合同即刻终止 |
| 无合同还占资源应追责 | voakbasda | 继续取电用公共设施，可以算盗用服务 |
| 解约第一件事是锁数据 | thephyber | 任何辖区都不该再查得到这些数据 |
| 政府供应商合同应公开 | thephyber | 对公职人员签的 NDA 不该有法律效力 |
| 拔线可能拔错了地方 | voxic11 | 摄像头靠太阳能板和电池，不靠市电 |
| 破坏设备不算参与 | buildsjets | 砸掉轻易可替换的过时硬件没什么意义 |
| 每次指控都是自白 | 01HNNWZ0MV43FF | Flock 在花钱买支持，还教警察怎么影响民选官员 |
| 机器人说法很危险 | CodingJeebus | 这给了公司雇人抗议、刷流量瓦解反对的余地 |
| 认错却拒绝道歉 | alexjplant | 承认做了不该做的事，还说不该道歉？ |
| 一步之遥 | BoxwoodSeed | 从「这些人不是真的」到「他们死了」 |
| 说话对象只是警察 | Zigurd | Langley 吓得到普通人，吓不到警察 |
| 反弹百分之百是真人 | slowin | 一个支持 Flock 的人都不认识 |
| 我就是支持方 | bko | 我会被踩，但我确实存在 |
| 两边可以同时成立 | CGMthrowaway | 机器人和真人同时存在，不是二选一 |
| 地图漏点 | eiiot | 斯坦福校园入口在 DeFlock 上有，这张图上没有 |
| 曼哈顿为什么这么少 | olegdotcom | 旧金山多得吓人，曼哈顿几乎没有 |
| 地图上的「运行中」未必在运行 | carimura | 我家那台一个月前被砍了，地图仍标在运行 |
| Flock 可能是诱捕作物 | b00ty4breakfast | 火力被一家吸走，别的公司没人盯 |
| 真正的客户在联邦 | pavon | 联邦政府想搭便车用尽可能多的摄像头 |
| 商业模型是 Uber | kevin_thibedeau | 后果归你，不归我 |
| Flock 不是惰性工具 | dragonwriter | 有真实的人在指挥它，也有股东在它身上获利 |
| 它是拖网不是枪 | skinfaxi | 大规模监控的拖网 |
| Flock 与 Ring 不是一回事 | tomnipotent | 跨州追踪加辖区外特权访问 |
| 光谱不能压成二分 | antonvs | 这么干总伴随那些错误 |
| 本地研究没找到相关性 | felixgallo | 安装与犯罪率下降之间没有统计显著关联 |
| 先看更长的时间尺度 | rconti | 疫情之后有过一轮犯罪率飙升 |
| 45% 的税收花在警务上 | Libcat99 | 想真削减开支，总得从警务先砍 |
| 不投票是不信任 | Avicebron | 不是冷漠，是不信任这个系统 |
| 警务既是盟友也是敌人 | Papazsazsa | 地方执法部门拥有美国治理中最耐人寻味的自由度 |

## 总体情绪

这场讨论表面上是一件市政小事：一个警察局长拔了监控摄像头的电源。但把它拆开看，三条线各自在问同一个问题的不同侧面——当一家私营公司控制着执法部门的数据和硬件时，地方还能不能单方面地说不。普利茅斯给出了最直接的回答：能，但代价是自己动手拔线，且拔线未必真能停机。CEO 在警察局长大会上给出的回答则是另一种：把反对声音定义成机器人，就不必回答。

情绪基调不是一边倒的愤怒，而是三股力量的拉扯。绝大多数人认定了 Flock 有问题，但分歧落在「问题出在什么上面」——是设备的物理存在，是数据的跨辖区流通，是厂商拒绝回应，还是警务预算本身占掉了 45% 的税收。支持者的存在被反复提到却始终缺席，只有一个人跳出来说「我就是支持方」，并且提前做好了被踩的心理准备。另一种更冷的情绪来自那些认为注意力放错了地方的人：数据中心和 Flock 才是把左右翼联合起来的两个议题。

真正把讨论拧在一起的是一个无法回避的判断：拔电源是有效的止损，还是只是给警察局长刷一个硬汉形象。评论区给出的答案是设备早就自供电自联网、远程还能被重新启用，也就是说到最后，能停住这套系统的仍然只有合同和舆论，而不是一根电源线。这或许也是这场讨论最实际的结论——法律和合同是这件事的真正开关，物理手段只是它在紧急时刻的替身。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Police chief unplugs cameras after Flock ignores contract cancellation（HN 主线，411 分，145 条评论） | https://news.ycombinator.com/item?id=50326118 |
| 2 | 原文报道：Police Chief physically unplugs Flock cameras…（The Drive） | https://www.thedrive.com/news/my-city-canceled-flocks-contract-flock-ignored-it-so-the-police-chief-unplugged-the-cameras |
| 3 | In Leaked Audio, Flock CEO Tells Cops Backlash to the Company Isn't Real（HN 相关线，317 分，168 条评论） | https://news.ycombinator.com/item?id=50248005 |
| 4 | 原文报道：In Leaked Audio…（404 Media） | https://www.404media.co/in-leaked-audio-flock-ceo-tells-cops-backlash-to-the-company-isnt-real/ |
| 5 | Proton Flock Camera Map（HN 相关线，89 分，18 条评论） | https://news.ycombinator.com/item?id=50236748 |
| 6 | 原文报道：Use this Flock camera map to find the devices near you（Proton） | https://proton.me/flock-camera-map |
| 7 | Flock Offers Employees Buyouts as Customers Flee（评论引用，2026-09） | https://news.ycombinator.com/item?id=49762835 |
| 8 | Cities terminate Flock contracts at record pace in August（评论引用，2026-08-28） | https://arstechnica.com/tech-policy/2026/08/cities-terminate |

## 免责声明

<div class="disclaimer">
本文基于 Hacker News 三条公开讨论帖的评论整理而成，涉及美国警务系统、Flock 车牌识别监控网络与相关外包服务商。英文引文为原文摘录，附 [c:id] 形式的评论编号，可在原帖定位；中文为意译，不替代原始语境。文中关于美国警务体制、公共采购、移民执法、厂商责任与选票的评价，均属原报道作者与评论者个人观点，不代表本项目立场。所引报道与材料的版权归各自出版方所有，本文仅作转述与讨论。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
