---
layout: post
title: >-
  飞船被塔接住了，助推器却没有：Starship 第 15 次试飞 — HN 讨论摘要
date: 2026-11-15
hn_id: 50500963
categories: [articles]
excerpt: >-
  第 15 次试飞，飞船第一次被发射塔夹住，助推器却因为燃料余量不足坠海。22.5 小时的绕地飞行、
  26 颗 Starlink V3、一次只完成一半的「双回收」，以及评论区里关于「回收要不要多付一次火箭方程」
  和「航天飞机才是更笨的设计」的两场硬仗。
tagline: >-
  塔接住了飞船，接住助推器的那一炉燃料差了几秒。
---

> 来源：HN 讨论主帖 [SpaceX catches the Starship to end Flight 15](https://news.ycombinator.com/item?id=50500963)（602 分，384 条评论），指向 [SpaceX 官方 Flight 15 任务页](https://www.spacex.com/launches/starship-flight-15)。关联帖：[Starship Flight 15 on 11/13 plans to catch both booster and ship](https://news.ycombinator.com/item?id=50416471)（173 分，150 条评论），其引文标注 `[thread 2]`。发射时间线、任务目标与官方战报叙述取自 SpaceX 官方内容接口（content.spacex.com，missionId=starship-flight-15），抓取时间 2026-11-15 00:54 UTC；发射前的任务计划全文见关联帖评论 [c:50416671]。两帖归档分别入库 100 条与 126 条评论，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

11 月 13 日下午 4:45（美中时间）开始的一个 75 分钟窗口里，Starship 第 15 次试飞从得州 Starbase 的 2 号工位升空。Super Heavy 带着 33 台 Raptor 起飞，热分离后飞船接着 6 台 Raptor 继续爬升。助推器翻转后，为返程点火重新点着了计划中的 33 台中的 32 台。任务计划写得很直白：这一次计划同时把助推器和飞船都接回发射塔，如果成功，将是轨道级运载系统的第一次完整回收。

但回收只完成了一半。助推器返程点火提前结束，官方说法是燃料质量偏低、根因仍在调查；随后 GNC 系统在滑行段触发自动中止，把它改道到墨西哥湾上的海上落点。助推器在海湾上空悬停、关机，触地前被飞行终止系统引爆成一团火球。飞船这边则按剧本走完：入轨、部署 26 颗 Starlink V3、在轨漂了 22 个多小时，再单台 Raptor 点火离轨、穿过大气层、翻回来，用三台发动机做最后的翻转和缓降，落进 Mechzilla 那对机械臂——人类第一次用发射塔接住 Starship 本体。

官方的时间线把每一个秒数都记了下来：起飞 0 分 00 秒，最大动压 58 秒，助推器主发动机关机 2 分 19 秒，热分离 2 分 21 秒，返程点火 2 分 26 秒开始、3 分 02 秒结束（只有 36 秒），助推器着陆点火 6 分 10 秒开始、6 分 35 秒关机。飞船这边 8 分 09 秒主发动机关机，26 分 10 秒入轨点火、20 秒后关机，35 分 01 秒开始释放载荷、1 小时 17 分 40 秒完成；再往后是三次返回检查（夏威夷、智利、夏威夷）、21:35:57 离轨点火、22:10:46 入大气层、22:29:34 过音速、22:30:13 转亚音速、22:32:16 着陆点火开始、22:32:18 翻转、22:32:26 从三台减到两台、22:32:33 减到一台、22:32:34 关机并被接住。整段绕地飞行超过 22 小时，轨道高度约 275 公里，约 14 圈，落到 22.5 小时后它离开的那个工位上。

任务计划里的几处细节也解释了这次飞行为什么敢做。飞船被反复强调的一点是：只有当飞控团队确认再入机动、最终着陆点火和塔架接近这三套系统都健康时，才会执行返回发射场。也就是说「回不回得来」是一个可以被叫停的开关，而不是必须完成的指标。助推器这边的目标写得更硬——这是 Super Heavy V3 的首次返回与捕获尝试，此前三次捕获成功的是 V1 助推器，其中两枚还完成了复飞。

载荷方面，26 颗 Starlink V3 卫星按任务说明每颗增加 1 Tb 容量、合计约等于 10 次猎鹰 9 的 Starlink V2 Mini 发射；其中 3 颗装了相机，专门用来拍摄 Starship 自己的隔热瓦，这些照片要回传给地面用来判断隔热瓦状态。隔热瓦也做了升级：高风险区域加了固定结构，堵上了等离子体可能钻到瓦片后面的流道，一大片区域换成能降低瓦缝加热的曲面瓦设计。

于是这一天结束时，账面是这样的：一次载入轨、一次部署载荷、一次塔接飞船，外加一次坠海。评论区很快把这场半成功拆成了几个问题——助推器那 36 秒的返程点火为什么不够、那片绿色的尾焰意味着什么、以及这一整套回收到底值不值。

## 讨论焦点

### 一、22.5 小时之后，那对机械臂合拢了

先说现场。绝大多数人的第一反应是形容词，但形容词里也能看出各自在意的点。

> "Damn, that looked smooth and glorious. This is how I&#x27;d like the future to be." — inglor_cz [c:50500976]
> （译文：该死，那看起来又顺又漂亮。我希望未来就是这个样子的。）

> "Holy ship, it was picture perfect capture!" — ryzvonusef [c:50500977]
> （译文：天哪，这是一次教科书级的完美捕获！）

看得懂工程细节的人，注意到的点和围观群众不一样。

> "We&#x27;ve seen the booster landing&#x2F;catch before, but seeing the ship do it with the belly flop definitely looked cooler to me. I still remember the awe of watching two boosters land at the same time after a heavy launch. Watching the transition from bellyflop to landing gave me the same awe and being impressed." — dylan604 [c:50502001]
> （译文：我们以前见过助推器着陆和捕获，但看到飞船用腹部扑腾的方式被接住，在我看来确实更酷。我还记得重载之后两枚助推器同时着陆时的那种震撼。目睹从腹部扑腾到着陆的整个转变，给了我同样的震撼和惊叹。）

有人记得更早的坐标点。

> "I still remember watching Falcon 9 (Block V, iirc) successfully landing back on land (as opposed to droneships) after deploying Orbcomm OG2 satellites in December 2015 -- almost 11 years ago.<p>It blew my teen mind.<p>This day marks a fabulous advancement for the human species." — abixb [c:50501726]
> （译文：我还记得 2015 年 12 月、发射完 Orbcomm OG2 卫星之后，亲眼看着猎鹰 9（我记得是 Block V）成功返回陆地着陆（不是无人船）——快 11 年前了。<p>那件事把我的少年时代彻底击碎了。<p>今天标志着人类物种的一次了不起的进步。）

也有人在千里之外抬头看了一眼。

> "We went outside in our Orlando office to see the flair up in the sky, and then were looking for the re-entry, by the time we could figure out where it was our coworker said it was already standing upright." — giancarlostoro [c:50501794]
> （译文：我们走到奥兰多办公室外面去看天上那道亮光，然后盯着它再入；等我们搞清它在哪时，同事说它已经直立在那儿了。）

一位在卡纳维拉尔角看过双助推器返回的人，补了句关于人类感知的事。

> "I was at Canaveral for the double booster return (Heavy?), and it&#x27;s unbelievable the velocity those things come back down at, with the powered deceleration.<p>A few seconds after the sonic boom, you&#x27;re seeing them cancel out the last of their velocity and land on the pad.<p>One of those &#x27;it can&#x27;t possibly be that big because nothing that big could be moving that fast&#x27; optical lack of reference moments." — ethbr1 [c:50502495]
> （译文：我当时在卡纳维拉尔角看双助推器返回（重型？），那东西回来的速度简直难以置信，全靠动力减速。<p>音爆之后几秒钟，你就看着它们把最后那点速度抵消掉，然后落在发射台上。<p>那种「这东西不可能有这么大，因为这么大的东西不可能动这么快」的视觉参照缺失时刻。）

### 二、助推器为什么没能接住：差的是燃料，不是勇气

官方给的原因很短：返程点火因燃料质量偏低而提前结束，根因仍在调查。评论区把这段话拆成了几种可能，差别在于「差多少」。

有人直接引用了马斯克的说法。

> "That&#x27;s basically what Musk said, yes: that they need to work on both engine performance and performance consistency. He said they&#x27;d be cutting off the main engines one second sooner to provide more margin for boost-back.<p>Amazing that a one-second difference can matter, but those things go through tons of fuel every one of those seconds!" — quotemstr [c:50501086]
> （译文：这基本就是马斯克说的：他们需要同时在发动机性能和性能一致性上做功课。他说他会提前一秒关闭主发动机，为返程点火留出更多余量。<p>一秒的差别居然这么要命，而那些发动机每一秒都在烧掉巨量燃料！）

也有人说，飞控其实在起飞前就已经知道了。

> "Slight underperformance in the engines resulted in the the booster not reaching where it was supposed to be and the GNC systems automatically aborted to the gulf for safety." — DarmokJalad1701 [c:50501030]
> （译文：发动机表现略有不足，导致助推器没到达它本应到达的位置，于是 GNC 系统为安全起见自动中止，改为飞往墨西哥湾。）

流传最广的一个解释有两个版本。

> "Two reasons floating around. 1.)They lost communication with tower 2.)They ran out of fuel for safe land.<p>source: Scott Manley " — proee [c:50501028]
> （译文：目前流传两种说法。一，他们和发射塔失去了通信；二，他们没有足够燃料来完成安全着陆。<p>来源：Scott Manley）

而「差一点」这个说法，最能解释为什么助推器选择了坠海。

> "&quot;Slightly low on fuel.&quot;<p>If I understand correctly, the margin was tight enough not to take the risk of damaging the tower." — inglor_cz [c:50501041]
> （译文：「燃料略微偏低。」<p>如果我理解得没错，余量已经紧到不值得去冒损坏发射塔的风险。）

现场画面也给出了另一个佐证：有人注意到它悬停的时间比以往任何一次助推器着陆都长。

> "I&#x27;m not sure thats the case. the booster hovered for what seemed a lot longer than  prior booster landing attempts. Almost like they were purposely running out the fuel." — ericcumbee [c:50501977]
> （译文：我不确定是不是这样。这个助推器悬停的时间看起来比以往的助推器着陆尝试长得多。几乎像是他们故意在把燃料耗光。）

### 三、那片绿色的尾焰：燃料到底烧完没有

评论区最硬的一段技术分析，来自 landing 画面本身。助推器悬停关机后，尾焰在最后一刻变成了绿色。

> "At the last moment the exhaust turned green.  That&#x27;s consistent with the fuel running out, the engines running oxygen rich, and subsequently &quot;engine rich&quot;.  So I would put my money on actually running out vs a measurement error." — Laremere [c:50501113]
> （译文：在最后一刻，尾焰变成了绿色。这符合燃料耗尽、发动机富氧燃烧，进而变成「富燃」的情形。所以我押的是真的烧完了，而不是测量误差。）

看画面的人给出同样的结论。

> "landing footage shows exactly why they didn&#x27;t attempt the tower catch - the final braking burn was engine rich (green tint), it didn&#x27;t blow up, but there was a respectable chance of it just crashing into the tower running on less than fumes" — baq [c:50501230]
> （译文：着陆画面恰好说明了他们为什么没尝试塔接——最后一次制动点火是富燃的（带绿色调子），它没炸，但完全有可能在只剩残气的情况下直接撞上发射塔。）

有人在评论区替他们喊了句可惜——按画面表现，其实接得住。

> "And if the landing footage is any indication, it sure looks like they would have made the catch anyway if they&#x27;d gone for it." — quotemstr [c:50501094]
> （译文：如果着陆画面能说明什么的话，看起来就算他们去接，多半也接住了。）

至于那团火球，有人认为那是控制系统有意为之。

> "Sounds like the final boom was intentional from control" — dylan604 [c:50501692]
> （译文：听起来最后那声爆炸是控制系统有意为之的。）

也有评论者从物理现象上描述了它：一个先内爆、再变成火球的过程。

> "The goal, as I understand it, is to return the booster with as little fuel as possible at time of catch -- and not run short.<p>The booster footage indicated to me that its engines turned off, and then the body of the booster <i>imploded</i>, before it touched the ground and then became the expected fireball.<p>I&#x27;m definitely not a rocket scientist, but this series of events leads me to believe that the fuel was absolutely exhausted." — ssl-3 [c:50501491]
> （译文：按我的理解，目标是在捕获时刻让助推器带着尽可能少的燃料回来——但不能不够。<p>助推器画面给我的印象是：发动机先关机，然后助推器本体在触地前<i>内爆</i>，接着变成预期中的那个火球。<p>我绝对不是火箭科学家，但这一连串事件让我相信，燃料是真的彻底耗尽了。）

### 四、风险账：唯一那座塔不能冒险

回收失败还有一层更贵的理由：那座塔当时是独苗。

> "Their risk tolerance would probably be greater if both towers were fully operational. But any damage to the only functional tower during booster catch = an automatic abort to the ship catch one day later, and the ship catch is what was really interesting at this point of development." — inglor_cz [c:50501164]
> （译文：如果两座塔都完全可用，他们的风险容忍度大概会更高。但只要在接助推器时弄坏唯一那座能用的塔，结果就是自动中止，转而去接飞船——而飞船捕获才是这个阶段真正有意思的部分。）

被转述的马斯克原话更直白：助推器便宜，塔贵。

> "booster was low on fuel, plus no mood of risking tower with boom, boosters are cheaper than towers." — ryzvonusef [c:50501199]
> （译文：助推器燃料不足，而且没心情用一次爆炸去赌塔——助推器比塔便宜。）

于是评论区开始认真讨论塔本身的工程问题。懂行的这位把现有塔的功能讲清楚了。

> "The existing towers can only handle empty ships &amp; boosters. The tower stacks them, then they’re fueled. A catch-only tower would avoid some cladding and the propellant loading lines, but it would still need a deluge system and a QD arm to replace any remaining propellant with inert gas. At that point you might as well pay a little more and get a fully capable tower." — ggreer [c:50502283]
> （译文：现役塔只能处理空的飞船和助推器。塔先堆叠它们，然后才加注推进剂。一座只用来捕获的塔可以省掉部分外壳和推进剂加注管路，但它仍然需要一套喷淋系统和快速断开臂，把残余推进剂换成惰性气体。做到这一步，你还不如多花点钱弄一座全功能的塔。）

另一派主张干脆加塔。

> "They need another cheaper tower just for catching. Much less mass when landing." — chinabot [c:50502183]
> （译文：他们需要另外一座更便宜的、只用来捕获的塔。着陆时质量小得多。）

还有人从预告片里读出了路线图。

> "The previz imagery of their plans for the Louisiana coast showed pairs of towers dotting the coast. At first I thought they were for alternating the cadence of launches, but now I wonder if one is to catch the booster and the other to catch ship." — dylan604 [c:50501707]
> （译文：他们预告的路易斯安那海岸规划图里，海岸上是一对一对的塔。起初我以为是为了交替发射节奏，现在我怀疑一座接助推器、另一座接飞船。）

### 五、回收是不是要多付一次火箭方程

评论区第二个主战场，是一句流传很广的说法：为了把燃料带回来着陆，等效运力要付 23 倍的发射次数。

> "Reusable stages is very neat, but seems a little crazy to pay the tyranny of the rocket equation twice.    I heard one person say that carrying fuel to land over the whole flight means it takes 23x more launches to get an equivalent payload to orbit.<p>Using modern technology, couldn&#x27;t disposable first stages be produced much more cheaply than during the space race?<p>How much of modern manufacturing disposable booster&#x27;s cost would be fuel vs metal?" — cwkoss [c:50501071]
> （译文：可复用级当然很棒，但为火箭方程的暴政付两次钱，听起来有点疯狂。我听人说，为了把着陆用的燃料一路带回来，等效入轨载荷需要 23 倍的发射次数。<p>用现代技术，一次性一级是不是可以比太空竞赛时代便宜得多地造出来？<p>在现代制造下，一次性助推器的成本里燃料占多少、金属占多少？）

反驳者从火箭方程本身说起。

> "It&#x27;s not paying it twice. The rocket equation is about the ratio of the wet and dry mass, so for an expendable rocket you&#x27;re always limited by the fact that there&#x27;s an upper stage (and for the second stage the payload etc).<p>This is why SpaceX cares more about TWR for their engines than traditional rockets did. It goes from making a negligible difference to a huge component of how much fuel they need to keep for landing." — blackenedgem [c:50501104]
> （译文：这不是付两次。火箭方程讲的是湿重与干重之比，所以对一次性火箭来说，限制总是来自「还有个上面级」（对上面级来说就是载荷等等）。<p>这就是为什么 SpaceX 比传统火箭公司更看重发动机的推重比：它从「几乎无所谓」变成「决定你得为着陆留多少燃料」的大头。）

一派认为这个数字被误读成了「近地轨道任务」。

> "The 23x more launches figure comes from HLS (Nasa sponsored mission to the moon). They may well change the configuration of that anyway, but if you want to refuel in orbit, that&#x27;s what it costs." — grey-area [c:50501163]
> （译文：23 倍这个数字来自 HLS（NASA 出资的登月任务）。他们也可能改掉那个构型，但如果你想在轨道上补加燃料，那就是那个代价。）

也有人直接用这次飞行的实际载荷反驳。

> "That 23x number is trivially refuted simply by looking at the fact that this flight delivered 52 tons of cargo to orbit.  Could a similarly sized expendable rocket like the Saturn V deliver 1196 tons?" — consensus1 [c:50501327]
> （译文：只要看看这次飞行往轨道上送了 52 吨货物，23 倍这个说法就轻松不成立了。同样尺寸的一次性火箭，比如土星五号，能送 1196 吨吗？）

而冷静版提醒：回收不是免费的，只是没那么贵。

> "It costs less, but it is not free. The stages need to be designed to come back and that adds weight. Additionally you need some fuel, it is not all air breaking." — luke5441 [c:50501413]
> （译文：成本更低，但绝不是免费的。各级必须为「能回来」而设计，这会增加重量。另外你还得留一些燃料，不是全靠空气减速。）

这条评论还有下半段：他接着说每一克重量都要命，因为火箭方程，而且在没有内部数据的情况下，谁都说不准最终哪种方案财务上更划算——何况现在开发成本已经是沉没成本。

### 六、塔接和航天飞机：哪种设计更笨

回收方式自然引出老问题：带翅膀的航天飞机不是更优雅吗？

> "I&#x27;m still not really convinced this is better than a space-shuttle style landing.<p>Seems like the same design principles that goes into Starship could create a version with more aerodynamic surface.<p>Is the idea that Starhship will be considered safe enough for human crews?" — kpil [c:50502140]
> （译文：我还是不太信这比航天飞机那种着陆方式更好。<p>用在 Starship 上的这套设计原则，明明可以做出一个气动面积更大的版本。<p>他们的想法是，Starship 会被认为对载人足够安全吗？）

答案里包含了一份航天飞机简史。

> "Was Space Shuttle safe enough for human crews?<p>Space Shuttle was a compromised design from the beginning. They originally wanted the Space Shuttle booster to also have wings and return to launch site (with a crew!). But they couldn&#x27;t afford to develop two new vehicles, so they compromised by making the external tank as cheap as possible and adding solid rockets (which led to the Challenger disaster).<p>But their biggest mistake was having the engines on the orbiter (so they could be recovered) but not the fuel tank. That meant the orbiter had to hang on the side of the external tank, which made it vulnerable to foam strikes (leading to the Columbia disaster).<p>Landing with wings is aesthetically pleasing (compared to tower catches) but consider the waste: You have to boost the weight of the wings, landing gear, etc. all the way to orbit and then bring it all the way back. It&#x27;s much more efficient to just bring fuel and use that for landing. And if your guidance is accurate enough, a pinpoint landing means you can land on the launch tower and not worry about landing legs." — GMoromisato [c:50502333]
> （译文：航天飞机对载人足够安全吗？<p>航天飞机从一开始就是一套被妥协过的设计。他们最初想要助推器也带翅膀、也能飞回发射场（还带人！）。但他们负担不起研发两种新飞行器，于是妥协成把外贮箱做得尽量便宜，再外挂固体助推器（这导致了挑战者号事故）。<p>但他们最大的错误是把发动机放在轨道器上（因为发动机可以回收），却不把燃料箱放上去。这意味着轨道器必须挂在外贮箱侧面，于是容易被泡沫撞击（这导致了哥伦比亚号事故）。<p>带翅膀着陆在审美上确实更讨喜（相对于塔接），但想想这份浪费：机翼、起落架这些东西的重量得一路带到轨道，再一路带回来。高效得多的做法是只把燃料带回来、拿它着陆。而如果制导足够准，一次精准着陆意味着你可以落在发射塔上，根本不用操心起落架。）

翼展的由来，也有人解释得很细。

> "The space shuttle was aerodynamic for a very specific reason - they had to do a mission (that never happened) where they would launch, deploy a spy satellite into a specific polar orbit, and return back to Vandenberg Air Force Base in California in a single orbit. The result was a requirement for a lot of cross range, which needed large wings that hurt its performance a spacecraft.<p>Starship doesn&#x27;t have that - and so it can be much more optimized for it&#x27;s purpose. It&#x27;s basically tanks with a cargo bay and control surfaces, while the shuttle had to toss it&#x27;s tanks away every flight." — trothamel [c:50502373]
> （译文：航天飞机做成流线型有一个非常具体的原因——他们要执行一个（从未发生的）任务：发射、把一颗间谍卫星送进特定极轨，然后在单圈之内返回加州范登堡空军基地。结果就是必须有巨大的横向机动能力，这需要大机翼，而大机翼损害了它作为航天器的性能。<p>Starship 没有这个需求——因此可以针对自己的用途大幅优化。它基本上就是几罐燃料加一个货舱和控制面，而航天飞机每次飞行都得把燃料箱扔掉。）

至于「复用是不是只是换一种烧钱方式」，回答很朴素。

> "Yes, they should just parachute people out of planes, why reuse them thousands of times, carrying that extra fuel to land, they could go another few hundred miles.<p>The point is the ship and rockets are expensive vs fuel. Fly a Starship 100 times the cost is amortised over the flights and fuel+bit of refurb maintenance is tiny." — small_model [c:50502204]
> （译文：是啊，那让人从飞机上跳伞就好了，何必成千上万次地复用，为了着陆还背着额外的燃料，他们完全可以再飞几百英里。<p>关键在于，飞船和火箭本体很贵，而燃料不贵。一艘 Starship 飞 100 次，成本就摊到这些飞行上了，燃料加一点翻修维护费微不足道。）

### 七、接下来才是难的部分

欢呼之后，评论区最实在的一句话是：还得再飞一次。

> "This was a huge milestone, but you&#x27;re right that there are a long list of future milestones: catch both on the same flight, reuse of both on a given flight, fly without significant refurbishment, fly N times in T time for many values of each, orbital refueling, crew, etc." — randallsquared [c:50502368]
> （译文：这是一个巨大的里程碑，但你说得对，前面还有一长串里程碑：同一次飞行里两个都接住、同一次飞行里两个都复用、不经过大幅翻修就飞、在给定时间窗内飞 N 次（对各种 N）、轨道加注、载人，等等。）

> "I&#x27;ll be that guy: they still have to fly it again. That&#x27;s the real question. Incredible achievement. We got used to landing and caught boosters real quick!" — bahmboo [c:50501811]
> （译文：我要当那个扫兴的人：他们还得再飞一次。这才是真正的问题。成就令人难以置信。我们太习惯「助推器很快就着陆并被接住」了！）

关于「原计划是双回收」，事实也被摆清楚了。

> "Did they catch both of them in <i>this</i> mission?<p>It was meant to be a <i>dual catch</i> of the booster and the rocketship and <i>only</i> the rocketship itself was caught.<p>Catching <i>both of them</i> in another mission would top this one." — rvz [c:50501221]
> （译文：这一次任务里他们两个都接住了吗？<p>原计划是助推器和火箭飞船的<i>双捕获</i>，结果<i>只有</i>火箭飞船本身被接住。<p>哪次任务里把<i>两个</i>都接住，会让这次更上一层楼。）

而在关联帖里，一位工程师把这种「每次都被说不行」的循环写成了段子。

> "“If this trend continues” about Falcon 1. About Falcon 9 landings, about Falcon 9 reuse, about starlink capacity, about starship launching at all, about the heat shield, about the catch, about the towers, about drone ship landings…….<p>That has been the narrative about every single step spacex has ever taken.<p>And you know what the trend is?<p>They are kicking fucking ass. Annihilating old space and the writing the game one incremental win at a time.<p>Yes, the trend is incredibly good." — testing22321 [c:50420120] [thread 2]
> （译文：「如果这个趋势继续下去」——这话当年说过猎鹰 1、猎鹰 9 着陆、猎鹰 9 复用、星链容量、Starship 能不能飞、隔热瓦、捕获、发射塔、无人船着陆……<p>SpaceX 走过的每一步，叙事都是这样。<p>那你知道这个趋势是什么吗？<p>他们在狠狠干翻旧航天，并且一次一个增量胜利地重写规则。<p>没错，这个趋势好得不得了。）

### 八、26 颗卫星、半个 Block 3，和两万亿美元的算术

任务计划公布之后，关联帖里就已经吵过一架：26 颗 Starlink V3 是不是太少了。

> "Launching only 26 Starlink v3 satellites is a disappointingly small number. That&#x27;s about ~52t or half the block 3 advertised payload capacity of 100t. Elon said on the Q3 earnings call that flight 14 carrying 26 V3 Starlinks was only about half loaded, so apparently the ship can launch twice as many." — tristanj [c:50416758] [thread 2]
> （译文：只发射 26 颗 Starlink V3 卫星，这个数字小得让人失望。大约 52 吨，只有 Block 3 所宣称 100 吨运力的一半。马斯克在 Q3 财报电话会上说过，第 14 次飞行带着 26 颗 V3 也只装了一半，所以显然这艘船能装两倍。）

反对者的反驳很短，但把历史摆得很重。

> "Which makes it the third heaviest orbital payload in all of history.<p>Funny thing to be disappointed about." — testing22321 [c:50417309] [thread 2]
> （译文：这让它成为有史以来第三重的入轨载荷。<p>对着一件这样的事感到失望，还挺好笑的。）

真正在意的是那些有任务排期的人。

> "I&#x27;m excited at the prospect of Starship landing on the moon. 100T payloads are maybe not required to make it happen, but probably are. For those of us who care about Artemis IV happening on schedule, being disappointed in a 52t payload capacity is very straightforward.<p>I&#x27;m not excited about more Starlink satellites." — lukeschlather [c:50419141] [thread 2]
> （译文：我很期待 Starship 登陆月球。100 吨运力也许不是必需品，但很可能需要。对那些关心 Artemis IV 能否按期推进的人来说，对 52 吨运力失望是很自然的反应。<p>我倒是对多发几颗星链卫星没什么兴奋。）

另一条线是钱和估值。有人在帖子开头就抛了一句。

> "This is exactly the most impressive feat of engineering I have ever seen.<p>Only catching both the booster and the rocket would top this one. But the rocket only being caught is still impressive regardless.<p>SpaceX below $1T is criminally undervalued." — rvz [c:50501048]
> （译文：这是我见过最令人惊叹的工程壮举。<p>只有把助推器和火箭都接住才能超越它。但只接住了火箭本身，同样令人震撼。<p>市值低于 1 万亿美元的 SpaceX，是被低估得离谱了。）

立刻有人纠正这个说法。

> "Why is Space-X undervalued because they can catch a rocketship?<p>You do understand that a company needs to have a business case equivilient to its valuation right?<p>Going to Moon only costs money, going to Mars only costs money.<p>Our whole planet sends 1000-2000t of payload into space, most of it is now starlink." — origini [c:50501303]
> （译文：为什么因为能接火箭飞船，SpaceX 就被低估了？<p>你明白一家公司得有个和估值相当的商业逻辑吧？<p>去月球只是烧钱，去火星也只是烧钱。<p>我们整个星球每年往太空送 1000 到 2000 吨载荷，其中大部分现在是星链。）

反方的回答把估值逻辑摆到了总可触达市场上。

> "Nope. That is not how this works nor how investors see it. It is about their total addressable market (TAM) which SpaceX can capture over everyone else. So here are some more further questions:<p>1) Who is paying SpaceX for the compute that they have?<p>2) How quick is SpaceX building their data centers to support their customers?<p>3) How many people use Starlink as their primary internet provider?<p>You understand that almost all of where SpaceX businesses can expand into those areas and grow into that valuation and higher?<p>&gt; Our whole planet sends 1000-2000t of payload into space, most of it is now starlink.<p>Your point is?<p>So who else can catch and reuse a rocketship to frequently deploy satellites into space in a very short period of time? (Don&#x27;t say Blue Origin.)" — rvz [c:50501421]
> （译文：不，事实和投资者看法都不是这么运作的。关键在于 SpaceX 相对所有其他人能够夺取的总可触达市场（TAM）。所以这里还有几个问题：<p>1）谁在为 SpaceX 手里的算力付钱？<p>2）SpaceX 建数据中心支持客户的速度有多快？<p>3）有多少人把星链当作主力网络服务？<p>你明白 SpaceX 的业务几乎可以扩张到这些方向，并撑起乃至超过那个估值了吧？<p>&gt; 我们整个星球每年往太空送 1000 到 2000 吨载荷，其中大部分是星链。<p>你的意思是？<p>那么，还有谁既能捕获又能复用火箭飞船，从而在极短时间内高频部署卫星？（别说 Blue Origin。））

讨论也滑到了地缘政治。

> "Don&#x27;t you think the US government is very likely to put restrictions on what other countries can use SpaceX services for?" — mupuff1234 [c:50501619]
> （译文：你不觉得美国政府很可能会限制其他国家能用 SpaceX 的哪些服务吗？）

也有人关心那团火球落进墨西哥湾之后的生态账。

> "Do we know what sea life just died as the booster exploded? What are the impacts to the Texas Gulf when a booster detonates into the ocean?" — blondie9x [c:50501852]
> （译文：我们知道助推器爆炸时有多少海洋生物死掉吗？助推器在海里引爆时，对得州湾有什么影响？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 未来就该是这个样子 | inglor_cz | 又顺又漂亮，这就是我想要的未来 |
| 腹部扑腾比助推器更酷 | dylan604 | 看着它从腹部扑腾转到着陆，震撼加倍 |
| 2015 年的猎鹰 9 是原点 | abixb | 那次返回着陆击碎了我的少年时代 |
| 差的就是燃料余量 | DarmokJalad1701 | 发动机略有不足，飞控自动改道墨西哥湾 |
| 提前一秒关机就能救 | quotemstr | 马斯克说他们会提前一秒关主机 |
| 绿色尾焰＝烧完了 | Laremere | 富氧转富燃，是真的燃料耗尽 |
| 画面显示差点撞塔 | baq | 停在残气上撞塔的概率相当可观 |
| 唯一那座塔不能赌 | inglor_cz | 弄坏唯一的塔，飞船捕获就得往后推 |
| 助推器比塔便宜 | ryzvonusef | 没心情拿爆炸去赌塔 |
| 只捕获的塔不值得造 | ggreer | 喷淋和快断臂照样要，省不出多少 |
| 该再加一座塔 | chinabot | 只用来捕获的塔便宜，而且着陆质量小 |
| 火箭方程只付一次 | blackenedgem | 关键是推重比，不是「付两次钱」 |
| 23 倍是拿 HLS 算的 | grey-area | 那是轨道加注任务，不是入轨任务 |
| 52 吨就够反驳 | consensus1 | 土星五号也送不到 1196 吨 |
| 回收不免费但更便宜 | luke5441 | 重量每一克都要算，且开发成本已是沉没成本 |
| 带翅膀更优雅？ | kpil | 同样的设计原则明明能做出更大气动面积 |
| 航天飞机从一开始就被妥协 | GMoromisato | 带燃料回来着陆，比带机翼回来划算 |
| 翼展是为单圈极轨任务买的 | trothamel | 航天飞机每次还得把燃料箱扔掉 |
| 复用摊薄的是硬件成本 | small_model | 飞 100 次，燃料加翻修只是零头 |
| 前面还有一长串里程碑 | randallsquared | 双捕获、双复用、不翻修、在轨加注、载人 |
| 先得再飞一次 | bahmboo | 我们太习惯助推器很快被接住了 |
| 每次都说不行的循环 | testing22321 | 这个趋势好得不得了 |
| 26 颗太少 | tristanj | 52 吨，只有 Block 3 宣称运力的一半 |
| 这是史上第三重入轨载荷 | testing22321 | 对着这件事失望挺好笑的 |
| 登月党在意的是排期 | lukeschlather | Artemis IV 要按期走，52 吨确实不够 |
| SpaceX 被低估了 | rvz | 低于 1 万亿市值就是低估得离谱 |
| 估值靠的是 TAM | rvz | 关键是还能扩张到哪些方向 |
| 生意逻辑不能只靠一次发射 | origini | 去月球去火星都只是烧钱 |
| 政府会管到别国头上 | mupuff1234 | 别的国家能用哪些服务，会被限制 |
| 海里炸掉的账谁算 | blondie9x | 墨西哥湾的生态影响呢 |

## 总体情绪

这一天的情绪基调是罕见的整齐：技术圈几乎无人否认这次回收的分量，争吵全部发生在「还差什么」上面。飞船被塔接住这件事在评论区里没有真正的反对者——连最较真的人也只是问「他们还得再飞一次吗」。剩下的分歧集中在四个可量化的点上：返程点火只烧了 36 秒，助推器因此坠海；当时能用的发射塔只有一座；任务计划里写死的「只有系统健康才返回发射场」给了他们随时叫停的余地；而 26 颗卫星、52 吨载荷、22.5 小时绕地飞行这些数字，离 Block 3 宣传的 100 吨还有一半距离。

有意思的是，最后这场争论的落点并不在工程上，而在算术上：能不能只靠一次塔接就撑起 SpaceX 的估值。评论区里估值一派和「23 倍发射次数」一派打得不亦乐乎，最后是同一条主帖里的两个人把它降维成了「52 吨对 1196 吨」的一次对比。而真正冷静的那条线只有一句话：回收让成本变低，但从来不是免费的。

把这天的两个数字并排放着看最清楚：22:32:34，机械臂合拢；00:06:35，助推器的发动机在海湾上空关机。前一个数字会被写进历史书，后一个数字会写进下一份事故报告里。SpaceX 的两难从来不是「敢不敢接」，而是「差几秒的时候，敢不敢承认差了那几秒」——这一次，他们选择了把助推器扔进海里，把飞船抱了回来。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | SpaceX catches the Starship to end Flight 15（HN 主帖） | <https://news.ycombinator.com/item?id=50500963> |
| 2 | Starship Flight 15 on 11/13 plans to catch both booster and ship（HN 关联帖） | <https://news.ycombinator.com/item?id=50416471> |
| 3 | SpaceX 官方 Flight 15 任务页 | <https://www.spacex.com/launches/starship-flight-15> |
| 4 | 发射前任务计划与完整时间线（社区转载，metalman） | <https://news.ycombinator.com/item?id=50416671> |
| 5 | Flight 15 官方直播（YouTube） | <https://www.youtube.com/watch?v=2brajgZlOKRMka> |
| 6 | Scott Manley：助推器未捕获的两点原因 | <https://www.youtube.com/shorts/m2oGDCvDmdE> |
| 7 | SpaceX 官方 X 账号现场推文 | <https://x.com/spacex/status/2121316300702056595> |
| 8 | Elon Musk 关于提前关闭主发动机的推文 | <https://x.com/elonmusk/status/2121648438144024943> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 602 分、384 条评论，入库 100 条；关联帖 173 分、150 条评论，入库 126 条；抓取快照 2026-11-15 00:50 UTC）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留了 HN 原文的 HTML 实体。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。官方战报叙述、时间线与任务目标取自 SpaceX 官方内容接口（content.spacex.com，missionId=starship-flight-15）；助推器返程点火提前结束的具体根因官方尚在调查，本文中关于燃料余量、发动机一致性、绿色尾焰与塔架风险的所有讨论，均为评论区观点，不代表事实结论。讨论中提及的 Starlink V3 运力、Starlink 商业化前景与 SpaceX 估值属于发言者个人估算，不应作为投资参考。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
