---
layout: post
title: >-
  Amazon 把每笔订单抽走一半——它怎么把全网价格都顶上去
date: 2026-10-15
hn_id: 50084757
categories: [articles]
excerpt: >-
  FBA 卖家把近 50% 销售额交给 Amazon；Fair Pricing Policy 禁止卖家在他处降价，连沃尔玛、Target 都跟着涨。FTC 2023 反垄断案明年开庭。
tagline: >-
  你以为在别家比较便宜，其实大家都在替 Amazon 交过路费。
---

> 来源：HN 热门榜（/best），由 notship 提交，626 分，542 条讨论。原文链接见文末。

## 原文概要

newsletter *Not-Ship* 10 月 13 日发表长文，把 Amazon 抬高全网商品价格的两条机制画在同一张图上：卖家给 Amazon 付的近 50% 抽成，以及 Amazon 的『公平定价政策』（Fair Pricing Policy）禁止卖家在他处报更低价格。两条机制叠加，意味着消费者即便不在 Amazon 下单，也在付 Amazon 的批发价。

文章把数据摆得很具体：2014 年 Amazon 对第三方卖家的综合费率大约是销售收入的 19%；到 2023 年，FTC 起诉书公开的对应数字已接近一半。其中 15% 是基础的『介绍费』，剩下是 FBA（仓储与配送）、广告投放等可选费用。文章把『可选』二字加上引号——Prime 资格在事实上要求使用 FBA，而广告位又和搜索可见度直接挂钩。

第二条机制是 Amazon 的 Fair Pricing Policy：只要卖家在任何地方——包括自己品牌独立站——报出低于 Amazon 的价格，Amazon 可以拿走 Buy Box（『加入购物车』按钮），最严重的可以暂停账号。这条规定让卖家的选择从『提价还是不提』变成了『在 Amazon 还能不能做生意』。报道引用加州总检察长在 2023 年提起的部分立案，说明 Amazon 据此施压品牌让沃尔玛、Target 等对手跟着提价；more perfect union 甚至找到了一个卖家因为和 Target 价差 1 美分被暂停账号的案例。

文章把这一现象接到了 Cory Doctorow 的『enshittification』框架——平台先服务用户，再服务广告主，最后一步是反向倒逼上游与下游按平台定价。Amazon 不是这个框架的发明者，但它是目前最大的样本。文章结尾把视角拉到监管：2023 年 FTC 与 17 个州起诉 Amazon，指控其『非法维持垄断』，案将在明年开庭；2026 年早些时候，德国竞争管理局已先行下令 Amazon 停止控制卖家定价。Amazon 否认指控。

## 讨论焦点

### 50% 的『税』和『批发业转包』是常态吗？

第一条主线落在一个具体数字上：Amazon 对每笔订单的抽成。

> "A few years ago I looked at the finances of a company that sells on Amazon (FBA). It was pretty astounding the number of fees they charge. They were paying to show up in sponsored results which obviously increased the fees but from what I remember between all the fees roughly 50% of the sale price of their products was just going directly to Amazon." — weird-eye-issue [c:50085691]
> （译文：几年前我研究过一家在 Amazon 上做 FBA 的公司。Amazon 收的费用多得吓人。光是让自己出现在赞助结果里就要再付一截，但综合所有费用，商品售价的差不多 50% 是直接交给 Amazon 的。）

跟帖里一位自称在做 3PL 网络咨询的用户补了一个细节：使用非 Amazon 的 3PL 通常更便宜，但能不能拿到 Prime 标就看 Amazon 物流占比：

> "Well, it's usually much cheaper to use a non-Amazon 3PL to ship your Amazon volume (along with other D2C channels), but then you might not have the prime badge if you go on the cheaper side of the market. And even if you want a prime badge, it's often/usually cheaper to go with a 3PL that can do some sort of SFP setup if you have reasonable volumes. Although Amazon has a stranglehold on 3PL's too (or if you are a seller offering SFP), as they will force you to use Amazon Logistics at a certain % of volume if you want the prime badge which can be more expensive than other carriers." — Closi [c:50090772]
> （译文：通常用非 Amazon 的 3PL 来发 Amazon 的订单（顺带做 D2C）是更便宜的，但你走低价一端就拿不到 Prime 标。想拿 Prime 标的话，量大时用支持 SFP 的 3PL 一般也更便宜。但 Amazon 对 3PL 也有掐脖权（或者对做 SFP 的卖家）：想拿 Prime 标，Amazon 物流占比必须够高，那可比其他承运商贵。）

反对意见认为这不过是零售业的常规操作：

> "50% \"tax\", or 100% markup, is the typical reseller markup for consumer products across the market, and anti-undercutting clauses are also universal. Every bit of what you're describing is the way retail distribution works across the industry in general. Amazon isn't doing anything out of the ordinary in any way." — Gormo [c:50092588]
> （译文：50% 的『税』，或者 100% 的加价，是消费品的零售业一般性加价；禁止压价的条款也无处不在。你说的每一项，都是整个零售分销行业的常态。Amazon 没有任何一处是越轨。）

这条支线的潜台词是——这场关于 50% 的争议其实是在问：让单一公司独自行使『全美零售业加价规则』，还是让市场决定。

### Fair Pricing Policy 是不是『市场调节』？

第二条主线落在 Fair Pricing Policy 这条规则上：

> "Amazon's regulation often means sellers are blocked from selling the same items at a lower price elsewhere." — GrinningFool [c:50085873]
> （译文：Amazon 的『自我监管』往往意味着卖家不能在他处用更低价格卖同一件商品。）

支持 Amazon 的跟帖把这套机制解释为『批发业反压价条款』的传统做法：

> "That seems like a reasonable policy for Amazon to have. It's pretty normal practice for wholesale/distribution contracts to include clauses prohibiting the manufacturer from undercutting them in other channels after the contract is signed. Why would Amazon want to bear the cost of people using their store as a free product billboard, or using their warehouses as cheap transient storage space, while trying to push customers to actually make their purchases elsewhere?" — Gormo [c:50088992]
> （译文：那条规则 Amazon 应当有。批发/分销合同里写禁止厂商在合同签下后还在其它渠道低价抢市场，是行业常态。Amazon 凭什么要承担『别人拿它的店当免费广告牌、当便宜中转仓，自己却在别处成交』的成本？）

反对意见把它升级为垄断问题：

> "A monopoly store is charging (according to sibling posts) about a 50% tax to its suppliers, and will ban them if they sell their products for a fair price anywhere else. The tax percentage keeps increasing over time, as the monopoly uses this policy to prevent anyone else from competing on price. That's clearly in violation of antitrust laws." — hedora [c:50090485]
> （译文：一家垄断商店对供应商抽 50% 的『税』，而且一旦供应商在别处以公平价格卖就会被封。这个比例还在逐年涨，垄断方就用这一招阻止任何人在价格上竞争。这明显违反反垄断法。）

有一位用户指出，Fair Pricing Policy 在英国和欧盟其实是非法的：

> "Amazon Fair Price Policy doesn't apply in the UK and EU (it's illegal). The EU are currently running an investigation into how this affects market dynamics, which will be interesting to see." — A_Duck [c:50086034]
> （译文：Amazon 的公平定价政策在英国和欧盟不适用——它在那里是非法的。欧盟正在就它对市场的影响立案调查，结果值得期待。）

这条支线的潜台词是——『批发业常识』与『反垄断』之间的张力，在 Amazon 这里走到了边界。

### 物流是天险，但最近也在裂

第三条主线把『物流垄断』单独拆开看：

> "To steal Benn Jordan's ideas, capitalism is replacing itself with leveragism. You don't buy things from Amazon because they're the best store with the best prices, you buy them because they're the only store that has their own massive scale delivery service that delivers more packages than FedEx or UPS (not combined, but Amazon still delivers more packages than either). It's not possible for another store to compete with that. There is no competition. Starting a competitor to Amazon would be more difficult and capital intensive than starting a new car or rocket company. There is no other store that can get me the most obscure and random stuff in less than 24 hours." — Grombobulous [c:50085918]
> （译文：套一句 Benn Jordan 的说法，资本主义正在被『杠杆主义』替代。你不是因为 Amazon 价格最好才买它的东西，你买它是因为它有自营的大规模配送服务，单家的配送量比 FedEx 或 UPS 都大（不是两者加总，是单家更大）。任何其它商店都没法与这种规模竞争。没有竞争可言。要再造一家 Amazon 比造一家新汽车或火箭公司还难。没有任何其它商店能在 24 小时内把最冷门的小件送到我手上。）

跟帖把『物流优势』开始下沉的事实摆出来：

> "Amazon has been dropping the ball pretty regularly on shipping recently." — JumpCrisscross [c:50085984]
> （译文：最近 Amazon 的物流越来越不稳了。）

> "It was Amazon's increasingly slow and unreliable deliveries that caused me to cancel Prime earlier this year, and I'm strongly motivated to shop elsewhere now because I know that the package will be delivered by someone other than Amazon's own service." — tomwheeler [c:50086153]
> （译文：是 Amazon 越来越慢、越来越不稳的物流让我在今年早些时候取消了 Prime。我现在强烈倾向于在别处买东西，只要承运商不是 Amazon 自家。）

但反对意见认为 Amazon 的全球电商本体并不赚钱，是 AWS 在补贴这一切：

> "Their global operating margin ex-AWS (which is a whole different beast) was 6.8% in Q2. (AWS was 39%). That's actually not anything phenomenal -- and worse than I thought before I looked it up just now. I can't understand AMZN's stock valuation. They should really spin off AWS to be its own thing. Their international margins are even worse in isolation, 4.1%." — mrngld [c:50087717]
> （译文：Amazon 全球电商本体的运营利润率（剥离 AWS）在 Q2 是 6.8%。AWS 是 39%。这个数字并不惊艳——比我自己查之前以为的还差。我搞不懂 AMZN 的估值。他们真该把 AWS 分拆。国际业务的利润率单独看是 4.1%。）

这条支线的潜台词是——『物流天险』+『AWS 补贴』这条结构已经不再稳固，Amazon 的电商本体在快递品质恶化时只能继续掏自己的现金流来补。

### 把 Amazon 从『平台』变成『领取政府补贴的帝国』

第四条主线把视角拉到 Amazon 拿到的补贴上：

> "Amazon shipping and logistics are heavily subsidised by the social contract in Western Countries - it's not remotely a fair comparison even if these were removed based on Amazon's effective corporate income tax rates coming in as low as 1.4%. In the US alone Amazon has received over $11 billion in cumulative taxpayer subsidies, and governments spend an average of nearly $43,000 per fulfillment center job created. This is ramping up exponentially with regard to their data center rollout. In a single instance in rural Oregon, five AWS data centers will avoid $1 billion in property taxes. This is completely aside from the qualitative damage done to traditional retail, shopping districts as a whole, SME innovation on consumer products, and distorting market competition beyond all recognition." — piltdownman [c:50086598]
> （译文：Amazon 的物流与配送被西方社会的隐性契约大幅补贴——光是 Amazon 的实际企业所得税率最低到 1.4%，就已经让『公平竞争』无从谈起。Amazon 在美国累计拿了超过 110 亿美元的纳税人补贴，每新建一个配送中心岗位平均花掉政府近 4.3 万美元。这个趋势在他们的数据中心扩张上还在指数级放大：在俄勒冈农村一个案例里，五个 AWS 数据中心将合计免掉 10 亿美元房产税。这些都还没算上对传统零售、商业街整体、小型消费品企业创新的毁灭性破坏，以及对市场竞争的全面扭曲。）

这条支线的潜台词是——Amazon 的『物流天险』不只是资本建出来的，它也是地方政府用税收减免和补贴堆出来的。110 亿美元的累计补贴让『公平定价』那一套逻辑基础更不稳。

### 『那就别用它』的上限悖论

第五条主线接收到了一个常见反问——『你不用就行了』：

> "What's the reasonable alternative to Amazon?" — bix6 [c:50086430]
> （译文：Amazon 的合理替代品是什么？）

跟帖给出的答案是一个词：

> "Competition." — intended [c:50086459]
> （译文：竞争。）

这条线随后被拉长成对美国生活情境的细化。一位用户描述了一种具体的退订行为：

> "Yep. Amazon is almost no advantage here in the UK. I used to bulk buy stuff from them because it was cheaper than the supermarkets. That is no longer true. In fact it's 10-25% more expensive usually. I really should just cancel my prime now. Edit: just cancelled it!" — sdcfgy [c:50086022]
> （译文：没错。在英国 Amazon 几乎没什么优势了。我以前因为比超市便宜还经常在 Amazon 上囤货。现在不一样了——通常贵 10–25%。我真应该把 Prime 退了。编辑：刚退了。）

跟帖里有人指出，Amazon 在英国的隔日达是真便宜：

> "I'm no Amazon fan but very cheap next day is still an Amazon advantage, and a pretty big one. £9/mo vs £4-8 per delivery from other retailers. Unlike the US I believe in practice it's all but guaranteed next day too." — gib444 [c:50086190]
> （译文：我不粉 Amazon，但便宜的次日达仍然是它的，而且是大优势。每月 ¥9 对比别家 ¥4–8 一单。而且在英国实际上基本保证次日达。）

但反对意见指出，便利的话题不是消费者唯一衡量的东西：

> "I've stopped shopping on Amazon entirely, and the impact on my credit card bill has been substantial. It's not simply that products are priced poorly, but it is also that they seem to be priced just at the threshold where the purchase remains sufficiently convenient not to shop locally or elsewhere online." — dleslie [c:50085951]
> （译文：我已经完全不在 Amazon 上买东西了，我的信用卡账单变化很显著。问题不只是 Amazon 上价格高，而是它们把价格卡在『买东西足够方便，不去本地或别处网上买』的门槛上。）

这条支线的潜台词是——『那就别用它』是一个对消费者可行、对供应链不可行的方案；Amazon 不需要把每个消费者都抓住，它只需要让卖家的报价结构依赖这一个来源。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| Amazon 抽走近 50% 销售 | weird-eye-issue [c:50085691] | 综合所有费用，售价 50% 是流向 Amazon |
| 物流拿不到 Prime 标就贵 | Closi [c:50090772] | Amazon 对 3PL 也有掐脖权 |
| 50% 是零售业一般水平 | Gormo [c:50092588] | 这没什么出奇 |
| 卖家在他处被禁止压价 | GrinningFool [c:50085873] | Amazon 的『自我监管』机制 |
| 公平定价政策合理 | Gormo [c:50088992] | 批发业反压价条款是通例 |
| 这是反垄断问题 | hedora [c:50090485] | 单店 50% 抽成 + 跨平台压价 = 垄断 |
| Fair Pricing 在欧盟非法 | A_Duck [c:50086034] | 欧盟已立案调查 |
| Amazon 是『杠杆主义』 | Grombobulous [c:50085918] | 资本主义的下一站是杠杆主义 |
| Amazon 物流最近在裂 | JumpCrisscross [c:50085984] | 频繁翻车 |
| 取消 Prime 的具体原因 | tomwheeler [c:50086153] | 慢、不稳、想避开 Amazon 自家物流 |
| 电商本体利润率仅 6.8% | mrngld [c:50087717] | AWS 在补贴整个电商 |
| Amazon 拿了 110 亿美元补贴 | piltdownman [c:50086598] | 每个配送中心岗位 4.3 万美元补贴 |
| Amazon 的合理替代品是什么？ | bix6 [c:50086430] | 一句反问 |
| 替代品就是竞争 | intended [c:50086459] | 一个词 |
| 英国用户已退订 Prime | sdcfgy [c:50086022] | 比超市贵 10–25% |
| 便宜的次日达仍是 Amazon 优势 | gib444 [c:50086190] | £9/月 vs £4-8/单 |
| 完全离开 Amazon 显著省钱 | dleslie [c:50085951] | 价格卡在『懒得比价』的门槛上 |

## 总体情绪

讨论从两条看似相反的方向切入：第一条主线是『这是常态』派，主张 50% 加价、反压价条款、物流自营都是零售业通例，Amazon 没有越轨；第二条主线是『这是垄断』派，主张把零售业通例交给单一公司集中行使，结果就是市场无路可走。

中段把焦点从『卖家付多少』转到『消费者付多少』。英国用户已经在自发退出 Prime；美国用户则在『能不能不在这家买』和『能不能少花钱』之间做平衡。Amazon 的电商本体利润率仅 6.8%、AWS 拿到 39%——这个结构说明 Amazon 的护城河在『物流+品牌账户』而不是『更低的进货价』。在这种情况下，它对全网商品价格的反向倒逼机制会持续工作到物流本身开始裂的那天。

讨论最刺痛的一段不是任何一条主线，而是 Amazon 的累计补贴数：110 亿美元、每个配送中心岗位 4.3 万美元、5 个 AWS 数据中心免掉 10 亿美元房产税。补贴来自地方政府的公共资金池——也就是说，Amazon 用来『抬升全网价格』的那套机制，部分是由公共资金买单的。讨论里没有用户给出一个能直接把这些外部性内化的方案，大多数讨论都在不同程度上承认：这一轮不是关于『电商能不能让价格变低』，而是关于『能不能在 Amazon 已经把价格顶上去之后把它拉下来』。这件事小到在英国退订 Prime、大到 FTC 反垄断案明年开庭同时并行——给 Amazon 的窗口只剩明年开庭之前这一年。

## 引用帖子

| # | 标题 | HN URL |
|---|------|--------|
| 1 | Amazon pushes up prices across the Internet | <https://news.ycombinator.com/item?id=50084757> |
| 2 | Not-Ship: How Amazon pushes up prices all across the Internet | <https://www.not-ship.com/how-amazon-pushes-up-prices-all-across-the-internet/> |
| 3 | FTC v. Amazon 起诉书（2023） | <https://www.ftc.gov/news-events/news/press-releases/2023/09/ftc-sues-amazon-illegally-maintaining-monopoly-power> |
| 4 | Good Jobs First: Amazon tracker（纳税人补贴累计） | <https://goodjobsfirst.org/amazon-tracker/> |

## 免责声明

<div class="disclaimer">
本摘要基于公开报道与 HN 用户讨论的二次整理。原文与评论仅作为引用素材，不代表本站立场。本文所引言论均明确标注原作者与 HN 评论 ID，并标注 [c:NNNN] 用于事实校验。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>