---
layout: post
title: >-
  Nvidia 被指刻意维持 GPU 高价：把客户的钱借给他们买自己的卡 — HN 讨论摘要
date: 2026-11-15
hn_id: 50501631
categories: [articles]
excerpt: >-
  《华尔街日报》写清了 Nvidia 的定价方法：客人太多、汤太少，所以不把货一次性卖光。
  424 分、216 条评论，分歧不在有没有这回事，而在循环融资到底算不算正常的生意。
tagline: >-
  汤只有那么多，客人却排着长队：所以不把货一次性卖光，价格就下不来。
---

> 来源：HN 讨论主帖 [Nvidia deliberately kept GPU prices high through circular financing deals](https://news.ycombinator.com/item?id=50501631)（424 分，216 条评论），原文是 TechSpot 的一篇报道（归档抓取于 2026-11-15 00:50 UTC），转述《华尔街日报》对 Nvidia 临时 CEO Colette Kress 的人物报道。本篇为单帖模式。主帖归档快照 2026-11-15 10:28 UTC，入库 101 条评论，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对；WSJ 原文片段来自评论者 beloch 的转贴，本站未直接读取 WSJ 页面。

## 原文概要

引子是《华尔街日报》上一篇写临时 CEO Colette Kress 的人物报道，TechSpot 把它转成了「Nvidia 刻意通过循环融资把 GPU 价格维持在高位」。指控其实只有一句话：Nvidia 主动托住自家芯片的价格，办法是循环融资——给买卡的客户钱，让客户拿这笔钱回来买 Nvidia 的卡。主帖在 HN 拿到 424 分、216 条评论。

商业上的原因很朴素：产能。AI 数据中心把 DRAM 和 NAND 的产能抽走，GeForce 的价格经常高于官方建议零售价的 160%，旗舰 RTX 5090 基本买不到。而 Nvidia 在 TSMC 下的单，到 2026 年夏天堆成了报道里那句「雪崩」（avalanche）；另一边，超大规模厂商正在转向自研芯片，能吃下 Nvidia 卡的买家变少。报道说，2026 年中到后期 Nvidia 仍在推动更多交易，目的正是消化这批过剩晶圆，同时把价格顶住。Kress 担心与云厂商和 OpenAI 这类大 AI 公司的交易规模太大，Nvidia 依然推进；到夏天自己也觉得可能推过头了，于是开始放慢、下调、暂停部分融资协议，其中包括最初带 2500 亿美元兜底（backstop）的那笔 OpenAI 数据中心协议。

于是指控里最硬的部分其实是会计口径。厂商给客户垫钱是常规生意，争议在于 Nvidia 记在收入里的有一部分是自己的钱绕了一圈又回来。另外，Nvidia 与 Enron 的类比在公司内部出现过——黄仁勋和 Kress 都曾出面回应这类比较，而 Enron 当年正是用类似手段在 2001 年崩盘前掩盖债务。

定价方法被写进了故事里。柏林的一次会议上，黄仁勋对半打主要买家公司的 CEO 讲了个日本汤摊的寓言：排队很久喝上一碗极好的汤，想再来一碗被摊主拒绝，理由是「客人太多、汤不够」。他的解读是——汤摊老板不把货全卖给一两个客户，而是保持价格高、买家分散；他当场对客户说「你们没有在建立我的产品的价值」。同一场合他还在意股价，认为 Nvidia 平均每月的市盈率倍数已经明显落后于其他大型科技公司。

TechSpot 把这则消息放在黄仁勋辞职的背景下：辞职的起因是婚外情曝光，其中一位是 Alice Huang（与黄仁勋无亲属关系），她的公司 Megaspeed 被美方情报怀疑违规向中国转运 Nvidia 芯片；有人称她是北京的间谍，特朗普与司法部在 11 月 12 日表示尚未定论（路透社）。

## 讨论焦点

### 一、循环融资到底算不算常规生意

smallerize 的提问最朴素：

> "I don&#x27;t have a WSJ subscription, but was there actually anything weird about the deals? I mean it seems pretty normal." — smallerize [c:50501723]
> （译文：我没有 WSJ 订阅，但这些交易真有什么奇怪的地方吗？我是说，看起来挺正常的。）

reenorap 说得更斩钉截铁：

> "People are acting like vendors extending financing to their customers is somehow irregular or illegal.<p>It’s not. It happens ALL THE TIME. This isn’t “circular financing” which is a great meme term but is not factual." — reenorap [c:50502081]
> （译文：大家好像觉得厂商给客户放贷是什么不正规或不合法的事。并不是。这种事天天都在发生。这不是所谓的「循环融资」——那是个很好的梗，但不是事实。）

cpburns2009 一句话带过：

> "That&#x27;s what these allegations of circular financing are about? Extending credit? Lmao" — cpburns2009 [c:50502633]
> （译文：所谓循环融资的指控就是指这个？放贷？就这？笑死。）

也有人认为框架本身错了。flaque 直接说标题在误导人：

> "This is just feels really misleading. Nvidia invested in startups that would turn around and help the market of companies that would buy from them grow.<p>That&#x27;s not &quot;deliberately keeping GPU prices high&quot; and it&#x27;s really weird to frame it this way.<p>It is good that Nvidia focused on supporting startups!" — flaque [c:50502421]
> （译文：这感觉非常误导。Nvidia 投资了那些会反过来帮「买它们产品的公司」这个市场成长的初创公司。这不是「刻意维持 GPU 高价」，这样框定很奇怪。Nvidia 扶持初创公司是好事！）

luckydata 给了行业对照：

> "&quot;engineering scarcity&quot; is bullshit. It&#x27;s called &quot;demand generation&quot; and every single enterprise company that can do so does it (car companies, cloud providers... they all either provide financing or credits &#x2F; volume discounts)." — luckydata [c:50502858]
> （译文：「制造稀缺」是胡扯。这叫「需求创造」，凡是做得到的企业都在做（车厂、云厂商……要么给融资，要么给额度／批量折扣）。）

这一节的共同点是：几乎没人否认交易存在，争议全在定性——厂商融资是常规操作，还是「用金融手段做产品需求」的第一步。顺带，来源也被追问：intothemild 指出这个说法最早出自 Ed Zitron，lizknope 纠正说依据是 WSJ，Zitron 只是复述。

### 二、「自由市场」被拿来当反讽

233mhz 用一句话概括了整帖的调性：

> "The invisible hand of the free market ;)" — 233mhz [c:50502034]
> （译文：自由市场那只看不见的手；）

CamperBob2 接着问：

> "The free market where every innovation is locked up for 20 years behind patent walls?  That free market?" — CamperBob2 [c:50502090]
> （译文：那种每项创新都被专利墙锁住 20 年的自由市场？你说的是那个自由市场？）

andrekandre 的反讽更冷：

> "ironically, it would seem a free (as in free of rents) market seems to be harder to accomplish in a free (as in rules&#x2F;regulations) market..." — andrekandre [c:50502874]
> （译文：讽刺的是，在一个自由（指自由于租金）的市场里，反倒更难实现一个自由（指自由于规则／监管）的市场……）

自由市场这个词在这帖被反复当作反讽素材。真正的分歧不是「要不要市场」，而是「市场被允许做什么」。

### 三、供给侧的反证：租价、产能、份额

maximilianroos 给了个可证伪的判据——看租价：

> "one way to spot that this makes no sense is to look at GPU <i>rental</i> prices [1]<p>if there were some cabal buying them to keep purchase prices high, then rental prices would be falling; it would be unprofitable to buy them in order to rent them out. but actually the opposite is true" — maximilianroos [c:50502741]
> （译文：判断这个说法站不站得住脚的一个办法，是看 GPU 的租赁价格。如果真有一个集团在买卡抬购买价，租价就该往下走——买来囤着出租就不划算了。但事实正好相反。）

Aurornis 顺手纠正了一个流传很久的说法：

> "Why is this false claim so persistent?<p>Companies are expanding productions everywhere." — Aurornis [c:50502764]
> （译文：为什么这个不实的说法这么顽固？各家公司在到处扩产。）

他补的理由是：建晶圆厂并让它跑起来要好几年，内存产能不是一个在厂里一拧就立刻多出芯片的旋钮。

但份额和毛利率的数据把另一边摆了出来。martinald 说这甚至算不上垄断：

> "But they don&#x27;t have a monopoly. Their marketshare is sinking, down to perhaps 45% of estimated TSMC CoWoS supply next year (down from close to 70% last year)." — martinald [c:50502337]
> （译文：但他们并没有垄断。份额在下滑，明年 TSMC CoWoS 供给中他们的份额可能只有 45% 左右（去年接近 70%）。）

stephc_int13 补刀：

> "75% gross margin. For a market this big. This not healthy free-market competition working as expected." — stephc_int13 [c:50502362]
> （译文：75% 的毛利率。这么大的市场。这不是健康的自由市场竞争应有的样子。）

lucaspm98 的提醒则是周期：

> "Chip company profitability is notoriously fleeting and cyclical." — lucaspm98 [c:50502425]
> （译文：芯片公司的盈利能力出了名地短命且周期性强。）

这是全帖最硬的一节。托市论需要「需求是假的」这个前提，而租价、CoWoS 份额、DRAM 扩产三条线索都不支持「需求被凭空造出来」；但 75% 的毛利率和 45% 的份额同时说明，这仍是一家能把价格维持在高位、并且仍然握有定价权的公司。

### 四、自己的钱绕一圈：收入质量

mondrian 把焦点从道德挪到会计：

> "Vendor financing is not illegal but in this case it may have created significant non-recurring revenue. (And maybe amplified scarcity and artificially high chip prices in the industry at large.)<p>And the part that sounds shady to people is that part of Nvidia’s recorded cash flow is its own cash coming back around.<p>Edit: In typical vendor financing it’s a loan that has to be repaid on a schedule but in Nvidia’s case it’s equity." — mondrian [c:50503998]
> （译文：厂商融资不违法，但在这个案例里它可能制造了相当规模的非经常性收入（也可能放大了整个行业的稀缺，推高了芯片价格）。让人觉得可疑的那部分在于：Nvidia 记在现金流里的有一部分，是它自己的钱绕了一圈又回来。补：通常的厂商融资是按期偿还的贷款，而 Nvidia 这边是股权。）

gizzlon 补上这条链的形状：

> "No, it&#x27;s that it goes in a larger circle, involving many companies and gets counted as revenue multiple times" — gizzlon [c:50505103]
> （译文：不是，它进的是一个更大的圈，涉及好几家公司，同一笔钱被多次计成收入。）

这是本帖唯一一条既有事实基础又难反驳的批评方向：不需要证明「故意操纵」，只要披露里分不清自有资金回流的规模与真实第三方需求，任何基于「Nvidia 收入」的估值和产能判断都站不稳。

### 五、拆分还是调查

lukeify 的方案最短：

> "Nvidia should be broken up." — lukeify [c:50502089]
> （译文：Nvidia 应该被拆分。）

keyle 反对：

> "No, competition needs to get their heads together." — keyle [c:50502401]
> （译文：不，竞争对手需要联合起来。）

doitLP 指出拆分的难点：

> "Into what exactly? They have a single product that makes them money." — doitLP [c:50502235]
> （译文：拆成什么？他们就靠一个产品赚钱。）

lizknope 提出另一条更具体的路径——不是拆分，而是调查：

> "I don&#x27;t think they need to be broken up.  Nvidia needs to be investigated.<p>There are stories of huge amounts of sold chips sitting in warehouses unused.  This could be channel stuffing which is illegal<p>There are stories of Nvidia threatening that customers have to buy these chips now or they will be cut off and not able to buy the next gen.  That may be illegal" — lizknope [c:50502582]
> （译文：我觉得他们不需要被拆分，Nvidia 需要被调查。有大量已售芯片堆在仓库里没用，这可能是渠道压货，而那是违法的；也有说法称 Nvidia 威胁客户现在不买就断供、买不到下一代，这同样可能是违法的。）

CamperBob2 立刻指出这条法律推断站不住：

> "Since when is channel stuffing illegal?  It can happen for any number of reasons.  There&#x27;s often a difference between sell-in figures and sell-through figures." — CamperBob2 [c:50503800]
> （译文：渠道压货从什么时候开始变成违法了？它可能有很多原因。出货口径（sell-in）和动销口径（sell-through）本来就常常不一样。）

这条线上最有价值的产出不是「拆不拆」，而是把指控拆成三项可查证的东西：仓库里未动用的已售芯片数量、「不买就断供」有没有书面证据、以及自有资金在收入里占多大比例。三项都能在财报或诉讼里落地，目前一项都没落地。

### 六、临时 CEO Kress 与那碗汤

lizknope 认为人事变动才是重点：

> "You can call it whatever you want but read the WSJ article.  The CFO Kress was against this plan but Jensen pushed it ahead.  Now he&#x27;s out and the CFO Kress is the interim CEO.  She will probably slow down or stop the vendor financing. That will have a huge impact on the AI industry.  What will the new CEO do whenever they are hired?" — lizknope [c:50502947]
> （译文：你怎么叫都行，但去读读 WSJ 那篇。CFO Kress 本来就反对这套做法，是 Huang 硬推下去的。现在他走了，Kress 是临时 CEO。她大概会放慢或停掉厂商融资，这会对 AI 行业产生巨大影响。等新 CEO 到任后，他会怎么做？）

ksec 的反应更激烈：

> "&gt; The CFO Kress was against this plan<p>That is why she should not be a CEO. And frankly speaking she shouldn&#x27;t even be a CFO in the first place." — ksec [c:50503146]
> （译文：正因为 CFO Kress 反对这个计划，她才不该当 CEO。说实话，她一开始就不该当 CFO。）

而那碗汤成了全帖最著名的注脚。trinsic2 反对把它只读成逐利：

> "OMG this is delusional left brain thinking[0] to conceive that the man was spreading his supply out for profit motives. Not everything is about capitalism. Some people make decisions for humanitarian reasons.<p>Our way of life is being destroyed by this limited perception that everything is about self-interest." — trinsic2 [c:50503602]
> （译文：我的天，这种「左脑式」的臆想，竟然会有人以为那个人是为了利润动机在分配供给。不是所有事情都是资本主义。有些决定是出于人道理由。我们这种生活方式正被「凡事都只关乎自利」这种狭窄认知毁掉。）

beloch 的反驳是玩笑式的，但更狠：

> "Maybe the secret ingredient in the soup was snake venom with one bowl containing just a bit less than a dose that would cause medical issues.  Give somebody two bowls and the jig is up!<p>But seriously, somebody with normal, human priorities is not likely to become a billionaire CEO.  It&#x27;s why we shouldn&#x27;t elect billionaires or let them buy power.  Their success at what they do is a demonstration of their unsuitability for greater trust." — beloch [c:50503961]
> （译文：也许那碗汤的秘密配料是蛇毒，每碗里差一点就能让人出问题的剂量。给谁再来一碗就穿帮了！不过说真的，一个有正常人类优先次序的人，大概当不成十亿美元级的 CEO。所以我们不该选举富人，也不该让他们掌握权力。他们在做的事上成功，恰恰说明他们不适合被给予更大的信任。）

同一个汤，两种读法——一版是「限售保价」的定价教程，一版是「用讲故事的方式给定价找理由」。黄仁勋辞任、WSJ 报道、汤的寓言三件事在时间上挨得很近，但因果关系评论区没给出一致答案。

WSJ 原文里关于这笔担保规模的一段，由评论者 beloch 贴了出来：

> "&quot;Nvidia was in talks to provide billions of dollars of guarantees to companies that couldn’t afford its chips. That included deals led by Huang’s son-in-law, Nico Caprez, who had been offering upstart cloud providers and data-center developers financing in the hopes of turning them into long-term customers.&quot;" — beloch [c:50502215]
> （译文：Nvidia 当时正在洽谈为数家买不起自家芯片的公司提供数十亿美元的担保。其中包括黄仁勋的女婿 Nico Caprez 牵头的交易——他在向初创云厂商和数据中心开发商提供融资，希望把他们变成长期客户。）

### 七、CEO 职责、股东至上，与管制下的竞争

TuxedoBuddy 一句话把「贪婪」的指责挡了回去：

> "I’m not being sarcastic, but isn’t that the exact mandate of a CEO?" — TuxedoBuddy [c:50502677]
> （译文：我不是反讽，但这不正是 CEO 的职责所在吗？）

Waterluvian 认同并补上背景：

> "It absolutely is a thing. It’s the fundamental thing. What you’re describing is just the first in a tall pyramid of answers to the question “<i>how</i> do we maximize shareholder value?”" — Waterluvian [c:50503023]
> （译文：这确实是这么回事，是根本性的东西。你说的只是「我们如何最大化股东价值」这个问题的整座金字塔里最底下那一块。）

但 wtetzner 指出这在法律上并不成立：

> "It&#x27;s not law that corporations have to maximize shareholder value. Boards have plenty of room to balance the interests of employees, customers, communities, and long-term company health." — wtetzner [c:50503091]
> （译文：法律并没有要求公司必须最大化股东价值。董事会在员工、客户、社区和公司长期健康之间有很大的平衡空间。）

真正把这条线引向地缘的，是换人本身。itsthecourier 说得很直接：

> "while China pours billions over billions in catching up.<p>neutrally, taking Jensen out is a proverbial shoot in the foot" — itsthecourier [c:50503104]
> （译文：在中国一轮又一轮砸下数十亿追上来的时候。中性地说，把 Jensen 撤下来是典型的搬起石头砸自己的脚。）

georgemcbay 的回应把出口管制摆上台面：

> "&gt; taking Jensen out is a proverbial shoot in the foot<p>Probably should have kept his dick in his pants then, and avoided even the impression that he might be complicit in skirting export controls.<p>FWIW, I don&#x27;t even agree with the export controls, but if they exist then everyone should follow the law equally." — georgemcbay [c:50503144]
> （译文：既然如此，他当初就该管住自己的裤裆，也免得留下他可能牵涉规避出口管制的印象。顺带一提，我并不赞成这些出口管制，但如果它们存在，每个人都应该一样守法。）

这一节把「一家公司怎么定价」接到了「一个国家怎么管」上。发言者给出的判断是分裂的：有人认为换掉黄仁勋是自伤，有人认为出口管制本身就扭曲了竞争，双方最后落到的其实是同一条主张——规则要一致地执行。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 厂商融资是常规生意，「循环融资」是话术 | reenorap | 厂商给客户放贷天天都在发生，这不是新概念。 |
| 标题框架本身在误导 | flaque | 投初创是扶持客户，不是「刻意维持高价」。 |
| 这叫需求创造，不叫制造稀缺 | luckydata | 车厂、云厂商都提供融资或批量折扣。 |
| 自由市场成了反讽素材 | 233mhz | 看不见的手，正好用在这一帖上。 |
| 租价是托市论的反证 | maximilianroos | 真有人囤卡抬价，租价该跌而不是涨。 |
| 内存产能不是旋钮 | Aurornis | 建厂到量产要好几年，扩产一直在发生。 |
| 垄断没那么牢 | martinald | 明年 CoWoS 供给份额可能掉到 45%，去年近 70%。 |
| 毛利率反常 | stephc_int13 | 75% 毛利率配这么大的市场，不健康。 |
| 芯片利润周期性强 | lucaspm98 | 芯片公司的盈利能力出了名地短命。 |
| 会计口径才是真问题 | mondrian | 收入里有一部分是自己的钱绕了一圈回来。 |
| 拆分不如调查 | lizknope | 该查仓库里没用掉的已售芯片，以及「不买就断供」。 |
| 渠道压货未必违法 | CamperBob2 | sell-in 与 sell-through 本来就不是一回事。 |
| 临时 CEO 会踩刹车 | lizknope | Kress 当初就反对，她大概会放慢或停下。 |
| 反对过的人不该升 CEO | ksec | 她的谨慎或只是当 CFO 的资格不够。 |
| 汤不必只读成逐利 | trinsic2 | 不是所有决策都只关乎自利。 |
| 换掉黄仁勋是自伤 | itsthecourier | 中国在砸钱追赶，中性看是搬石头砸自己的脚。 |
| 管制要公平执行 | georgemcbay | 若管制存在，所有人都该一样守法。 |

## 总体情绪

这帖的分歧形状和价格曲线一样：几乎没人否认 Nvidia 在给客户垫钱，也几乎没人愿意说这就是操纵；两边真正争的是「正常」的定义。厂商融资在任何消费行业都存在——车贷、信用卡、路由器补贴——这让批评者看起来像在喊狼来了；可一旦把担保规模、股权回流和「现在不买就断供」放在一起看，普通的融资解释就盖不住所有细节。

第二种情绪是疲惫。评论里反复出现「随它去吧」式的收尾：反正 TSMC 是瓶颈，反正租价还在涨，反正自研芯片那条路也没走通，AI 的大方向并不依赖 Nvidia 的定价是否诚实。

第三条情绪最冷，来自把人事与地缘连起来的人：临时 CEO 上任、董事会换血、中国在补贴追赶、出口管制在实际执行中是否公平——这些变量被排成一条线，而这条线上唯一确定的是周期会结束。吵到最后大家其实都同意一件事：下一份财报之前，关于「循环融资」的三个关键数字一个都不会公开——担保余额、仓库里未动用的已售芯片、以及自有资金在收入里占的比例。

厂商融资可以是生意，也可以是操纵；分界线不在合同里，在谁的钱绕了一圈之后被记成了收入。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Nvidia deliberately kept GPU prices high through circular financing deals（HN 主帖） | <https://news.ycombinator.com/item?id=50501631> |
| 2 | 原文：Nvidia deliberately kept GPU prices high through circular financing deals（TechSpot） | <https://www.techspot.com/news/114558-nvidia-deliberately-kept-gpu-prices-high-through-circular.html> |
| 3 | WSJ 人物报道：Jensen Huang, Colette Kress, Nvidia CEO（付费墙） | <https://www.wsj.com/tech/jensen-huang-colette-kress-nvidia-ceo-eb289097> |
| 4 | 路透社：司法部尚未认定 Alice Huang 是中国间谍（2026-11-12） | <https://www.reuters.com/world/china/us-justice-department-has-not-concluded-alice-huang-was-chinese-spy-blanche-says-2026-11-12/> |
| 5 | TechSpot：GPU 价格失控（2026 年第四季度更新） | <https://www.techspot.com/article/3192-gpu-pricing-q4-2026/> |
| 6 | 评论者转贴的 WSJ 存档（archive.is） | <https://archive.is/gx14x> |
| 7 | SemiAnalysis GPU 定价指数（评论中引用的租价数据源） | <https://semianalysis.com/gpu-pricing-index/> |
| 8 | 同话题 HN 帖：Nvidia allegedly engineered scarcity by funding AI startups to buy its GPUs | <https://news.ycombinator.com/item?id=50493251> |
| 9 | 同话题 HN 帖：Jensen Huang resigns as Nvidia CEO immediately | <https://news.ycombinator.com/item?id=50467132> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 424 分、216 条评论，归档快照 2026-11-15 10:28 UTC，入库 101 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。文中关于循环融资、TSMC 晶圆过剩、2500 亿美元 OpenAI 兜底协议、柏林「汤摊」寓言、GeForce 涨价超过建议零售价 160% 与 RTX 5090 缺货的叙述，依据 TechSpot 归档文本，该文转述《华尔街日报》对 Colette Kress 的人物报道；WSJ 页面本站未直接读取，WSJ 原文片段来自评论者 beloch 的转贴。文中涉及出口管制与个人指控的部分（黄仁勋辞职相关报道、TechSpot 关于 Megaspeed 转运芯片的转述）属第三方报道与未证实指控，本站未做独立核实。

本文涉及中美科技管制与未证实指控，讨论区亦包含相关推测；相关引文仅代表发言者本人立场，不代表本站判断。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
