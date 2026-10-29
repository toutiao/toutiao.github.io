---
layout: post
title: >-
  The Grid：马萨诸塞的 PCB 机器人，4 天交货，比深圳贵 165 美元 — HN 讨论摘要
date: 2026-10-29
hn_id: 50243060
categories: [articles]
excerpt: >-
  马萨诸塞的工厂机器人 4 天交货，深圳快反厂 9 天，差价 165 美元。
  评论区真正争论的不是速度，而是元件还在亚洲、注册流程劝退用户、
  以及贵出来的那部分里究竟有多少是关税。
tagline: >-
  机器人回了美国，元件没回。
---

> ⚑ **经济政治背景**：本文涉及美国本土电子制造回流、中美关税与供应链对比，属于贸易与产业政策话题。所引观点按原帖立场呈现，不代表本项目立场。⚠ Review recommended.

## 原文概要

10 月 26 日，CircuitHub 创始人 Andrew Seddon 在公司博客公开了一套此前运行了五年、从未公开谈过的产线，名字叫 The Grid。博客原标题是《Unveiling The Grid: PCBs made in America, twice as fast as Shenzhen》，HN 上提交者把标题改成了《The Grid, a factory-scale robot in Massachusetts that builds PCBs on demand》。HN 这条帖子拿到 333 分、169 条评论，创始人 seddona 在第一条评论里现身答问。

文章先摆问题：过去 30 年，电子制造大规模离开西方，装配是劳动密集的，人力贵的地方做不了，于是搬到了人力便宜的地方，「我们在美国设计、在中国制造」，这样很多年都成立。自动化开始改变这个格局，但主要发生在超大批量上——SpaceX 现在在德州 Bastrop 以百万为单位造 Starlink 天线，同一款产品重复一万次，值得为它围一条线。绝大多数产品达不到 Starlink 的量级：一家硬件公司要 10 个这个、100 个那个，下周再来一版。高混合、小批量的活一直拒绝自动化，因为每换一个设计就要几小时设置和手工换型，结果要么继续送到海外，要么交给昂贵的快反（quick-turn）工厂。

The Grid 的思路不同：它不是一条为每款产品重配的固定产线，而是「一台大机器人」。悬浮搬运器（levitating movers）把板子和元件在印刷焊膏、贴片、回流、焊接、检测这些机器之间来回搬，学习型模型、AI agent 和经典优化器一起调度这一切。每块板子走自己的路线，没有换型，也没有按设计做设置，于是 100 种不同设计各做 1 块，和同一种设计做 100 块一样容易；样件和量产批次跑在同一批机器上。用的人也不只是初创公司：一家头部电动车厂商、一家顶级 AI 实验室和若干家知名科技公司已经在 The Grid 上做板子。

价格那部分写得很具体。The Grid 和一家典型的深圳快反厂被放在同一个例子上比：4 层电机控制板，118 个元件（其中 38 个是独有件），每种各 5 块组装好、含元件、送到美国的一个地址。结果是 The Grid 4 天、630 美元；深圳快反厂中位数 9 天、算上运费和美国关税约 465 美元。多花 165 美元，早 5 天拿到板子，没有清关手续，供应链「可依赖」。原文对这一段的总结是：对多数硬件团队来说，5 天的工程时间比 165 美元值钱得多。

最后一段用来打消「这只是个原型」的疑虑：The Grid 已经为客户跑了五年，每年生产数千万美元的电子产品；CircuitHub 累计发货超过 220 万块板、放置超过 1.5 亿个元件、服务过 2.6 万名工程师。需求已经远超产能，今年产能要翻 5 倍，2027 年还有一次大跳。更长的目标没变过：让造硬件和设计硬件一样快。

## 讨论焦点

### 一、价格到底贵几倍，取决于你有没有落在规格里

第一位挑刺的是 Teknomadix：

> "The site quotes prices for  ≥4 layer board production are on the order of 10x JLCPCB." — Teknomadix [c:50243522]
> （译文：网站上给出的报价，4 层及以上板子的生产价格大约是 JLCPCB 的 10 倍。）

他的结论是：「Until costs are more competitive, CN still gets the business.」（在成本更有竞争力之前，生意还是流向 CN。）创始人 seddona 的回复把 10 倍这个数字按规格切成了两半：

> "For 5 units of 2 or 4 layer turnkey assembled boards, so long as you fit in the Grid Proto spec it's a little bit more expensive (not 10x, more like 1.3x) and much faster" — seddona [c:50243974]
> （译文：对于 5 块 2 层或 4 层的贴片组装板，只要你的设计落在 Grid Proto 规格内，价格会稍贵一些（不是 10 倍，更接近 1.3 倍），但快得多。）

他还顺手纠正了一个流传很广的时间预期：「7 days to the US with any consistency is not possible, we have a lot of data points on that, median is about 10 days.」（稳定 7 天送达美国做不到，我们在这上面有很多数据点，中位数大约是 10 天。）后来他把这套边界说得更完整：

> "On the pricing side, if you fit within the Proto Board spec we are very comparable with JLC on much shorter lead time. If you go outside that then for now we are quite a bit higher price." — seddona [c:50278702]
> （译文：价格方面，如果你落在 Proto Board 规格内，我们和 JLC 相当接近，交期短得多；如果超出规格，目前我们就贵得多。）

真正的用户 kevin42 用自己的项目做了算术：

> "I won't complain about the price, I understand it's going to be more expensive than China. But it's a tough one for me. I have a budget that I have to work with, and while I have some flexibility 3X prices (your site priced $9k compared to JLC's $2k, even after tariffs and shipping) make the project nonviable for me." — kevin42 [c:50274323]
> （译文：价格我不抱怨，我理解它会比中国贵。但对我来说很难办：我有预算，虽然有一定弹性，但 3 倍价格（你们网站给我报的 9 千美元，对比 JLC 的 2 千美元，这还没算关税和运费）让这个项目做不成。）

同一串评论里还有一条工程细节的挑刺：

> "They give an example motor controller, but then require your board to be 1oz copper. Motor controllers in particular often use 2oz for high current." — phkahler [c:50273213]
> （译文：他们给的例子是电机控制器，却要求你的板子用 1oz 铜厚。而电机控制器这类设计，为了过大电流常常要用 2oz。）

他的补充是：不允许埋孔也是一条有意思的要求，密集布线往往用得上。

### 二、供应链并没有跟着产线一起搬回美国

nubinetwork 的回复只有一句，却把整篇公告的算术掀开了：

> "A supply chain that also comes from Shenzhen...  last time I checked, North America doesn't make chips or other components either." — nubinetwork [c:50273477]
> （译文：这条供应链本身也来自深圳……我上次查的时候，北美也不生产芯片和其他元件。）

crote 把差距写成了具体的时间成本：

> "You simply can't compete with a Shenzhen where there are a dozen PCB factories and a warehouse for virtually every part you can imagine within a 30-minute drive." — crote [c:50280582]
> （译文：你没法跟深圳竞争——那里有十几家 PCB 工厂，你想得到的任何一种元件，都有一个仓库在 30 分钟车程内。）

他还描述了那边的日常运转方式：「In Shenzhen you can have Some Guy in a truck doing a parts pickup round around town a couple of times a day. In the US you're waiting for overnight Fedex from Digikey.」（在深圳，你可以有个开卡车的人一天在城里跑两趟取件；在美国，你在等 DigiKey 的隔夜 FedEx。）mchannon 做了个反向的补充：

> "A lot of my Shenzhen orders have to wait on international airfreight on US-made chips because the ones I spec'd (basically the only ones that would do the job) are US-manufactured and warehoused." — mchannon [c:50273885]
> （译文：我的很多深圳订单反而要等国际空运的美国产芯片，因为我去指定的那款（基本也是唯一能用的那款）就是美国制造、放在美国仓库的。）

做电子制造的 WarmWash 态度更直接：

> "China is incredibly cheap, incredibly fast, and incredibly skilled. Our domestic made boards tend to be lower quality with more mistakes than Chinese made ones (while also costing up to 50x more)." — WarmWash [c:50273878]
> （译文：中国极其便宜、极快、极其熟练。我们国内做的板子质量更差、出错更多（同时成本可能高出 50 倍）。）

所以「产线回流」这句话能站住，「供应链回流」站不住：能自动化的那道工序搬回来了，那道工序需要的元件没有。

### 三、真正的对手不是价格，是摩擦

ncrtower 是最典型的用户视角：

> "I just wanted a quote. But signup was painful it needs a major review. Then I uploaded a zip of my gerbers and it came up with some error that I could not figure out and halted any further movement." — ncrtower [c:50273151]
> （译文：我只想拿个报价。但注册流程很难受，需要大改；接着我上传了 gerber 的 zip 包，出来一个我搞不明白的错误，直接卡住了后面的所有步骤。）

kevin42 补了另一层：

> "I uploaded gerbers but it wouldn't let me continue unless I uploaded schematics and board files." — kevin42 [c:50279982]
> （译文：我传了 gerber，但它不让我继续，除非我还上传原理图和板源文件。）

这件事在工程圈有标准答案，octoberfranklin 一句话问完：「GERBER is the standard.  Why won't you accept it?」（Gerber 就是行业标准，为什么不接受？）创始人其实接得住这个质疑：

> "You can upload Gerbers/ODB++ if you like. We also sign custom NDA's. We count many of the worlds largest corporations as customers so this is pretty standard." — seddona [c:50278624]
> （译文：你可以只传 Gerber/ODB++。我们也签定制 NDA。我们服务着全球最大的几家公司，所以这很常规。）

WarmWash 把这类摩擦总结成一条商业常识：

> "Never put any friction between your customer and giving you money" — WarmWash [c:50273935]
> （译文：永远不要在客户付钱这件事上设置摩擦。）

他还加了一句：「A longer list of accounts is not worth more than a longer list of orders.」（更长的账号列表，比不上更长的订单列表。）

### 四、源文件和 NDA：比价格更贵的那部分风险

kevin42 在两次评论里反复回到同一件事，第二次写得更重：

> "Nothing in the legal terms explicitly prevents your employees from using my designs for other purposes. If you leak my IP and I find out 13 months later, your terms prevent me from seeking damages because you only cover 12 months from manufacturing." — kevin42 [c:50275204]
> （译文：条款里没有任何一条明确禁止你的员工把我的设计用去别的用途。如果我的 IP 泄露了，而我 13 个月后才发现，你的条款还挡着我追偿，因为你只承保制造后 12 个月。）

他还认为 NDA 不该是开关式的默认项：「I like that you have an NDA that I can opt in to, but you should be offering the NDA by default when I upload the files.」（有 NDA 可以选择加入这点不错，但上传文件时就应该默认给。）他的理由是源文件比 gerber 泄露风险高得多——因为看原理图比看 gerber 更容易判断「这是一个什么电路」，也更容易抄走其中的创新部分。

而 doughecka 的正面反馈恰好是另一半：「We've had a few batches of mostly assembled (minus through hole parts) prototype boards made with y'all recently, pretty stoked how quick it is.」（最近用你们做了几批样件板（不含通孔件），速度让我挺满意。）

### 五、那 165 美元里，有多少是关税

realo 提醒评论区别忽略比较基准：

> "Faster than Shenzen, fine ... but quite a bit more expensive, even taking into account the USA tariffs, which we do not have in the rest of the world." — realo [c:50273058]
> （译文：比深圳快，行……但也贵得多，而且这还是算上了美国关税之后的价格——其他地方可没有这笔关税。）

UncleOxidant 讲了自己被关税和报关流程劝退的经过：一批板子总价约 400 美元，付款页面跳出来提示关税至少 45%，还要求把 SSN 交给海关代收，「That's a hard "Nope" on sending my SSN to China.」（这就是「绝不把 SSN 交给中国」的硬门槛。）他的结论是去美国厂看货。创始人对关税的表态很直接：

> "Not viability but tariffs do swing in our favour, it’s a tailwind for sure." — seddona [c:50278861]
> （译文：不是「能不能活」的问题，但关税确实对我们有利，这是一股确定的风。）

### 六、工厂里还要不要人：美国制造的隐性成本

Ccecil 自家做小型开源硬件产线，把「生活工资」这个概念的成本算给了大家看：

> ""Living wage" in my area is $40/hr.  That is just to live, not thrive or gain." — Ccecil [c:50277326]
> （译文：我这里的「生活工资」是每小时 40 美元。那只是够活着，不是够过好，也不是够有回报。）

他描述的循环是租金推高成本、成本推高租金，反馈已经转了太久；他自己一周干 70 小时，从设计到包装全自己干，理由是「There is not enough money to pay a living wage for others」（没有足够的钱给别人发生活工资）。Aurornis 给出相反的经济学直觉：

> "An unintuitive feature of the job market is that creating more low paying jobs actually puts upward pressure on wages." — Aurornis [c:50272889]
> （译文：劳动力市场有个反直觉的地方——创造更多低薪岗位，实际上会给工资带来向上的压力。）

真正把这道题推到极端的是 dyauspitr：

> "The way around it is not having to pay people wages at all which I hope American manufacturers are trying to do as much as possible. They already have totally dark factories in China and if we want to bring manufacturing back we will have to do it as well." — dyauspitr [c:50278715]
> （译文：绕开这个问题的方式是根本不用给人发工资，我希望美国制造商尽量往这个方向努力。他们（中国）已经有完全无灯工厂了，如果想把制造搬回来，我们也必须这么做。）

创始人没有接受这个前提：

> "One nice aspect of automation is that we are able to pay people well due to the leverage. I'm proud of the fact we've been able to create a lot of good well paying high tech jobs in an area that really didn't have many." — seddona [c:50278748]
> （译文：自动化的一个好处是，靠着这种杠杆我们能把人安顿得不错。我为我们能在这样一个原本并没有多少好工作的地区，创造出大量高薪高技术岗位而自豪。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 价格是 JLCPCB 的十倍，生意还是流向 CN | Teknomadix | 4 层以上板子报价约 10 倍 |
| 落在 Grid Proto 规格内只有 1.3 倍 | seddona | 超出规格才「quite a bit higher price」 |
| 3 倍价就足以让项目做不成 | kevin42 | 同一块板，9 千美元对 2 千美元 |
| 产线回流了，供应链没回流 | nubinetwork | 北美本来就不产芯片和元件 |
| 深圳的优势是元件仓库在 30 分钟车程内 | crote | 那边有人开车在城里跑两趟取件 |
| 国内板子质量更差，还可能贵 50 倍 | WarmWash | 中国便宜、快、熟练 |
| 真正的门槛是注册、Gerber 和报价流程 | ncrtower / kevin42 | 只想拿个报价，却被卡在上传那一步 |
| 只传 Gerber 就可以 | seddona | ODB++ 也行，NDA 也能签 |
| NDA 应默认开启，且只保 12 个月太短 | kevin42 | 条款不妨碍员工拿你的设计做别的用途 |
| 关税是顺风，不是 viability 问题 | seddona | 关税摆在我们这边 |
| 45% 关税 + 要 SSN，直接劝退 | UncleOxidant | 绝不把 SSN 交给中国 |
| 生活工资 40 美元/小时只是活着 | Ccecil | 租金推高成本，成本再推高租金 |
| 自动化能让人拿到更好的工资 | seddona | 靠杠杆在穷地方造出高薪岗位 |
| 要回流就得连无灯工厂一起搬 | dyauspitr | 不发工资才是绕开成本的办法 |

## 总体情绪

这场讨论的表层是价格，深层是「回流」这个词到底指什么。如果 The Grid 说的是「美国重新有了 PCB 制造」，那它确实做到了——一条跑了五年的产线，220 万块板，1.5 亿个元件，2.6 万名工程师。但评论区里的老手们几乎同时指出，被搬回来的只是那道能被机器人接管的工序，工序下面的元件还在亚洲，深圳的仓库仍然在 30 分钟车程内供货，而北美自己的芯片还得等国际空运。

于是真正的问题变成了时间换不换得来。630 美元对 465 美元，差 165 美元换 5 天，这笔账对多数硬件团队成立，因为工程时间比钱贵；可对有固定预算、规模又上不去的项目，同一笔账直接判死。创始人给出的答案不绕弯：规格之内 1.3 倍，规格之外「目前贵得多」，等产能翻 5 倍、价格整体下来——这是把希望押在规模上，而不是押在今天的报价上。

而这场讨论里最被低估的一栏，其实是最后那个问题：美国造的东西，值不值那多出来的 165 美元。Ccecil 给出每小时 40 美元的生活工资和转了太久的租金循环，dyauspitr 说对手早就有完全无灯工厂，创始人则说自动化让人能拿到好工资。三句话各自成立，可它们合起来指向一个不太舒服的结论：产线可以回流，工资、住房和元件未必。

所以这条产线的真正对手不是深圳，而是它自己那套还在使用中的注册流程、只认源文件的条款、和默认十二个月的 IP 保障——这些都不在 4 天交期里计算。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Unveiling The Grid（原文博客） | https://www.circuithub.com/post/unveiling-the-grid |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50243060 |
| 3 | CircuitHub 客户案例页（评论中提到的） | https://www.circuithub.com/case-studies |
| 4 | CircuitHub 招聘页（公告末尾指向） | https://circuithub.com/careers |
| 5 | JLCPCB（评论中反复作为价格与交期对比对象） | https://jlcpcb.com/ |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。原文概要部分转述自 CircuitHub 于 2026 年 10 月 26 日发布的博客文章《Unveiling The Grid: PCBs made in America, twice as fast as Shenzhen》，涉及的产能、发货量、工程师人数、报价对比（4 层电机控制板、118 个元件、5 块、630 美元 / 4 天对 465 美元 / 9 天）与关税等数据均来自该公司自述，未经独立核实。讨论涉及中美供应链与关税对比，属经济政治话题，所引观点按原帖立场呈现，不代表本项目立场；文中省略了原帖中若干更激烈的地缘政治评论。HN 帖标题由提交者改写，与原文标题不同。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位；引文为逐字摘录，仅省略了标注链接等非正文内容。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
