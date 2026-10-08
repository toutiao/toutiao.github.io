---
layout: post
title: >-
  Visa / Mastercard 被告「联合定价」 — HN 拆解这个百年老案：奖励计划才是 lock-in 关键
date: 2026-10-08
hn_id: 49993914
categories: [articles]
excerpt: >-
  一家圣地亚哥披萨店把 Visa / Mastercard / 五大行告上法庭，指控每年 1000 亿美元的刷卡手续费是「垄断租金」；HN 一边拉出 PIX / UPI / Wero 等替代支付做基准，一边拆穿诉讼本身的盲点 — 真正卡住商家的不是网络费，而是奖励计划绑死的 hook。
tagline: >-
  商户刷卡付的不是「费」，是卡组织替消费者发的糖。
---

> 来源：HN 热门榜（`/best`）。帖子：[Visa, Mastercard, major banks facing new litigation over 'anticompetitive' fees](https://news.ycombinator.com/item?id=49993914)，397 分，250 条评论。

## 原文概要

The Pizza Standard LLC 在 9 月 30 日向纽约南区联邦法院递交 134 页诉状（案号 1:26-cv-06087），把 Visa Inc. / Visa U.S.A. / Visa International Service Association / Mastercard Incorporated / Mastercard International / Paymentech / JPMorgan Chase / Bank of America / Citigroup / Capital One / Wells Fargo 共 11 被告一并告上法庭。案由是 Sherman Antitrust Act。

诉状核心指控：Visa 和 Mastercard 几十年来与五大发卡行协同制定刷卡手续费（interchange fee），通过「Honor All Cards」规则（即接受任何一张卡的商户必须接受全部 Visa / Mastercard 卡）、禁止商户针对特定卡品牌加收附加费、限制商户引导消费者选择低成本支付方式等「一组反竞争约束」，让发卡行之间失去压价的竞争动力，每年向商户收取「超过 1000 亿美元」的「垄断租金」。

诉状同时提到 2019 年那笔 50 亿美元的集体诉讼和解——但仅覆盖 2019 年 1 月 24 日以前的费用；从那天往后至今，商户「没有拿到任何救济」。诉方主张的救济包括：取消「Honor All Cards」、允许商户在指定卡品牌上加附加费、要求被告接受费率管制。

## 讨论焦点

### 「高费用 ≠ 竞争」一文正解反义辩

somat 在帖子一开头就抛出一个看起来反常识的判断——「高费率才应该代表竞争激烈，怎么就成了反竞争呢？」

> "Wouldn't high fees be competitive? A lot of incentive to compete there. Anticompetitive would be setting the fees too low to compete with." — somat [c:49994974]
> （「高费率难道不是竞争的结果吗？这领域里压价的动力应该是巨大的。反竞争应该是把费率压低到没法竞争。」）

armada651 立刻把 somat 的判断反过来读——是反竞争**导致**高费率，不是反过来：

> "You've got it backwards, their anti-competitive practices is what <i>allows</i> them to charge such high fees. If they didn't conspire together and actually competed then they wouldn't be able to charge such high fees as they would surely try to undercut each other。" — armada651 [c:49995016]
> （「你把因果反过来了。正是反竞争让他们能收这么高的费率——如果他们不串谋、真的在竞争，那费率一定会被互相压价压下来。」）

2OEH8eoCRo0 把这个反义辩接到法律岗位上：

> "Courts will ask why they can charge high fees and not lose customers. The answer will be that they are anticompetitive or behaving as a cartel or monopoly would." — 2OEH8eoCRo0 [c:49995185]
> （「法庭会问：他们为什么能收这么高费率还不丢客户？答案就是反竞争，或者它们的秩序就是卡特尔 / 垄断的秩序。」）

——somat + armada651 + 2OEH8eoCRo0 这条反义辩把「消费者只要愿意用卡，费率就被市场接受」的常识读成了「市场机制被锁住」的证据。Visa / Mastercard 看似「消费者抢着用」的现象，反过来恰恰证明「Honor All Cards」+「禁加附加费」这套规则让商户没有别的选择。

### PIX / UPI / Wero：替代支付已经在挑战 Visa / Mastercard

hmokiguess 把这个故事直接连到了巴西 PIX：

> "I think a lot of this is starting to bubble up to the surface after PIX made headlines。" — hmokiguess [c:49995216]
> （「我觉得这事在 PIX 上头条之后才逐渐浮出水面。」）

alightsoul 把视角拉到全球尺度——印度 UPI、巴西 PIX、加拿大 Interac、欧洲 SEPA，都是**已经在用**的本土替代支付：

> "It's not different, many countries already have their own version of it, you just don't hear about them. India's UPI has more users but you don't hear about it." — alightsoul [c:49995521]
> （「并没有不同。很多国家都有自己的版本，只是你没听说过。印度 UPI 用户更多，你也没听说过。」）

flockonus 把「为什么美国舆论开始注意到 PIX」归因到地缘政治：

> "Agree that PIX bothers the US more because it's directly under US (self assessed) area of influence. But the reason is not some philosophical alignment, but rather deep rooted lobbying practices." — flockonus [c:49996011]
> （「同意，PIX 更让美国难受是因为它在美国（自评的）势力范围之内。原因不是什么哲学对齐，而是根深蒂固的游说。」）

但 AlotOfReading 提醒到——替代支付不等于 Visa/Mastercard 的替代品：

> "India's UPI is practically impossible to use even for tourists in India. It's not serving the same role as Visa and MasterCard." — AlotOfReading [c:49996188]
> （「印度 UPI 即使对在印度的游客来说都几乎不可用。它不是 Visa 和 MasterCard 的替代品。」）

基于 based2 提供的 [wero-wallet.eu](https://wero-wallet.eu) 链接，欧洲也在做类似的「Pay by bank」式替代支付。这些替代支付的存在把 Visa / Mastercard 的高费率从「天经地义」降级到「历史遗留」——这正是诉方需要的证据。

### 奖励计划是 hook：消费者被锁死的真正原因

sandworm101 把消费者「爱卡组织」的反向逻辑说出来——奖励不是「白送的」，是从商户那边抽走的回扣：

> "They like the card networks because they are lured by point schemes, effectively money charged to the merchants and then shared back to cardholders. Consumers would flip in a heartbeat if shops were allowed to offer discounts to those not using credit cards." — sandworm101 [c:49995853]
> （「消费者喜欢卡组织，是因为被积分计划引诱——这本质上是商户交的钱再分给消费者。如果商店被允许给非信用卡用户折扣，消费者立场马上反转。」）

campground 把这个 hook 拆成两条线——历史上「禁加附加费」规则让非卡用户替卡用户买单，2022 年这条规则被禁之后，奖励计划又把卡用户钩回去：

> "Historically, credit card companies agreements with retailers disallowed them from passing on fees to customers, so effectively anyone paying with cash or debit was subsidizing the fees of credit card customers. Those agreements were made illegal in 2022, but retailers seem to be reluctant to actually start charging credit card users so far. Then, credit card companies take some of their profits and give them back to customers in the form of reward programs. So we all end up paying more for nothing, but the incentives make it a difficult collective action problem." — campground [c:49996501]
> （「历史上信用卡公司与零售商签的协议禁止它们把费用转嫁给顾客——所以实际上用现金 / 借记卡的顾客是在补贴用信用卡的顾客。2022 年那种协议被定为非法，但零售商似乎一直不愿意真的开始对信用卡用户加附加费。然后信用卡公司把自己的一部分利润以奖励计划的形式返还给消费者。结果我们都在为一个不存在的东西买单，但激励机制让这变成一个极难的集体行动问题。」）

——sandworm101 + campground 把诉方漏掉的关键一点拉出来：商户付的费率（3%）跟消费者拿到的奖励（1-2%）之间有 1-2% 的「净 transfer」是商户送给单边钱者的。诉方只告了「费用」那一头，奖励计划作为 hook 是商户维权时真正的痛点。

### 判决能拿来干嘛：欧盟 0.2% / 0.3% 是参考系

criddell 一开头就提了一个让所有人必须想清楚的问题——「这场诉讼的目标是什么？」

> "What's the intended outcome?<p>If you break up the Visa and Mastercard cartels, does this San Diego pizzeria then have to decide what cards to accept on a bank-by-bank basis?" — criddell [c:49995287]
> （「目标是什么？<p>如果打散 Visa 和 Mastercard 卡特尔，那这家圣地亚哥披萨店是不是就要按银行逐张决定接受哪些卡？」）

astura 立刻把欧洲的「管制路径」拿出来做参考：

> "Legislation to cap fees.<p>The European Union caps consumer card interchange fees at 0.2% for debit cards and 0.3% for credit cards" — astura [c:49995348]
> （「立法封顶费率。<p>欧盟对消费者卡的 interchange 费率封顶——借记卡 0.2%，信用卡 0.3%。」）

mahboi 把法庭能做和不能做的边界画出来——法庭能拿高费率当证据，但不能直接封顶：

> "Right. All the courts can do is use the high fees as evidence of monopoly." — mahboi [c:49995784]
> （「对。法庭能做的只是把高费率当作垄断的证据。」）

——这三句把这场诉讼的「上限」摆出来：诉方最多能让法庭认定垄断 + 命令取消某些规则（比如 Honor All Cards），但费率本身得等国会立法。astura 提到的欧盟 0.2% / 0.3% 是个有意义的目标数字——比美国目前的 ~2% 低 5-10 倍。

BeetleB 把「取消 Honor All Cards」的实操后果说出来——商户可能要按 Chase Spark / Costco Visa 这种品牌维度逐张谈费率：

> "So yes - the shop owner will get to decide which banks' VISA cards he will accept. Logistically, this seems like a bit of a nightmare. No longer will it be 'CC purchases will have a 2% extra fee.' Instead it will be 'If you have a Chase Spark card, the fee will be 4%. If you have a Costco Visa card, it will be...'." — BeetleB [c:49996995]
> （「所以——对，店主会决定接受哪些银行的 VISA 卡。从运营上，这听起来像一场噩梦。再也不会是'信用卡交易加收 2%'，而是'如果你用 Chase Spark 卡，费率是 4%；如果你用 Costco Visa 卡，费率是……'。」）

——也就是说诉方想要的解药可能比病更糟。BeetleB 这种「同意诉讼但担心落地」的判断在评论区被反复呼应。

### 「Acquirer 缺席」+ 「诉状律师嫌疑」：被告选错了？

tiffanyh 直接点出诉方忽略的关键一层——acquirer（收单行）才是 Merchant Discount Rate 的定假，决定者：

> "What seems to be getting lost is that the acquirer, not the payment network, sets the Merchant Discount Rate. The acquirer is also the merchant's direct payments provider. Yet the acquirers seem to be always absent from these lawsuits." — tiffanyh [c:49995617]
> （「被忽略的是：定 Merchant Discount Rate 的是 acquirer，不是支付网络。Acquirer 也是商户的直接支付服务商。但 acquirer 在这些诉讼里总是缺席。」）

nickff 进一步把诉讼本身当成「替律师做广告」：

> "It seems like many of these prosecutors/plaintiffs just want to go after the largest organizations in a given industry, almost irrespective of their culpability. It seems to me that most 'consumer protection' lawsuits seem to be more focused on obtaining publicity for the lawyers than actually doing anything useful, but getting a few settlements from larger organizations is a lot easier than actually going after wrong-doers, so it is a somewhat sensible strategy if the goal is to 'win' as much money as possible." — nickff [c:49995703]
> （「看起来很多这种原告/检察官只想去告行业里最大的组织，不管错得与否。在我看来多数'消费者保护'诉讼更像是在替律师做广告，而不是真正做有用的事——但从大公司那边拿和解费比真的去追究违法者容易得多，所以如果目标是'赢'到最多钱，这是个有点'理性'的策略。」）

——tiffanyh + nickff 把这场诉讼的结构性问题摆出来：acquirer（Paymentech 等）是「被告名单」里唯一真正「设费率」的中介方，但 11 个被告里 acquirer 只占 1 个位置（Paymentech, LLC）；与此同时被告名单上的网络方（Visa / Mastercard）和发卡方（五大行）是「被告席的标配」，诉方在按最大目标挑被告。这让这场诉讼看起来「可能赢在金额上，但赢不到机制上」。

### 替代支付真能消除中间层吗？timing gap 才是价值核心

Glyptodon 把视角推到「中间人是否还有价值」的最根本问题：

> "I do think we're getting to the point that middlemen don't have much value add. Economics even suggests they don't add value I think. Possibly neutral markets, payments, and logistics should just be a public service." — Glyptodon [c:49995851]
> （「我的确觉得中间人的价值在减弱。经济学甚至告诉我们他们不创造价值。中立的市场、支付、物流可能就应该是个公共服务。」）

mahboi 提醒到——信用卡公司真正被锁住的是 dispute（争议处理）：

> "The biggest thing is disputes. I have no problem with an escrow service asking for a cut if I want to use them, cause they have real costs. The creepy thing is how that escrow built into credit cards is forced on every little transaction." — mahboi [c:49995898]
> （「最关键的是争议处理。如果我想用 escrow 服务，付一笔分它我没意见——它们有真实成本。真正让人反感的是信用卡里内置的 escrow 被强制应用在每一笔小交易上。」）

rtkwe 把这个 dispute 跟 timing gap 接起来——信用卡公司其实是在做「持卡人付款 → 公司付款给商户」的时间差桥接：

> "That's essentially what a CC company does though, every transaction they're briding the timing gap between the card holder paying the CC company and the CC company paying the business. That's the core value add and cost they're bearing that they charge for." — rtkwe [c:49996091]
> （「信用卡公司本质上做的就是：每一笔交易里，它们在桥接持卡人付钱给卡公司 → 卡公司付款给商户之间的时间差。这是它们在承担的核心增值和成本，也是它们收费的依据。」）

但 ninalanyon 立刻把这个 bridge 拆掉：

> "The timing gap is only there because it is a credit arrangement, it's not inherent in payment processing." — ninalanyon [c:49997120]
> （「那个时间差之所以存在是因为它是信用卡安排，不是支付处理本身必需的东西。」）

——ninalanyon 这一刀切到了 rtkwe 的要害。Visa Debit、PIX / UPI 这些「实时清算」的产品里没有那个 timing gap。Glyptodon 的「中间人没价值」在这里得到一个精确回答：信用卡的中间人有价值（credit arrangement），借记卡 / PIX 的中间人价值有限（实时清算）。诉方没有点出这个区分，所以诉讼看起来「赢了面子，输了里子」。

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 高费是「竞争不竞」的反向证据 | somat | 高费率不是竞争激烈，恰恰相反 |
| 反竞争导致高费率 | armada651 | 不串谋就会被互相压价 |
| 法庭会问为什么不丢客户 | 2OEH8eoCRo0 | 高费率 + 不丢客户 = 卡特尔 |
| PIX 让这事浮上水面 | hmokiguess | 巴西 PIX 之后替代支付开始被看见 |
| 全球都有替代支付 | alightsoul | 印度 UPI、巴西 PIX、加拿大 Interac |
| PIX 受关注是地缘政治 | flockonus | 美国反 PIX 跟加价权一样都是游说 |
| UPI 不能替代 V/M | AlotOfReading | 印度 UPI 游客都用不了 |
| 诉讼目标要问清楚 | criddell | 打散卡特尔之后披店会怎么样 |
| 欧盟已立法封顶 | astura | 借记 0.2% / 信用卡 0.3% |
| 法庭只能证明垄断 | mahboi | 封顶费率得国会做 |
| 落地是噩梦 | BeetleB | 店主按 Chase Spark / Costco Visa 谈费率 |
| Acquirer 才是 MDR 定者 | tiffanyh | 被告名单上 acquirer 缺席 |
| 诉讼是律师广告 | nickff | 被告列表按规模挑 |
| 奖励是 hook | sandworm101 | 积分本质是商户回扣 |
| 集体行动问题 | campground | 2022 后没人敢加附加费 |
| Acquirer 真正扛 dispute | mahboi | escrow 被强制装在每笔交易 |
| Bridge timing gap | rtkwe | 卡公司在做"持卡人→商户"的时间差桥接 |
| 时间差是信用卡特权 | ninalanyon | timing gap 是 credit 安排才有 |
| 中间人没价值 | Glyptodon | 支付 / 物流该是公共服务 |
| 信用卡是 finance 安排 | ajkjk | 模式调整后零售降 1-3% |
| 消费者偏好奖励 | tt24 | 取消奖励消费者更糟 |
| 商店的代价 | m463 | 小餐馆付 3% 跟交保护费差不多 |
| 现金处理也有成本 | ptmcc | 现金防盗 / 押运不一定比卡费便宜 |

## 总体情绪

整体偏正面但带两根刺——正面情绪来自诉方终于把「Honor All Cards」+「禁加附加费」+「费用管制」三件相关的事摆上法庭，HN 普遍认为这是 2019 年那笔 50 亿美元和解之后又一次有意义的尝试。

第一根刺是「诉讼打错对象」：tiffanyh 的 acquirer 缺席、nickff 的「按规模挑被告」把这场诉讼的机制弱点暴露出来——诉方真正该打的 Paymentech 在被告席只有 1 个位置，Visa / Mastercard + 五大行是 10/11 的位置；按最大目标挑被告可以拿到大和解，但赢不到机制改革。

第二根刺是「奖励计划比费率更值钱」：sandworm101 + campground 把消费者被奖励锁死、商户被费率卡死的不对称结构说出来——商户付 3%、消费者拿 1-2%，中间有 1-2% 的「净 transfer」是商户送给单边钱者的。诉方没有把奖励计划放进救济诉求，相当于把最重要的 hook 留在桌面上。

诉方真正的牌是 astura 引用的「欧盟 0.2% / 0.3%」——这是能用判例 + 立法组合推动的数字，比 2019 年那笔「只覆盖到 2019 年 1 月」的和解要有意义得多。但 mahboi 把法庭的能力边界画得很清楚——法庭最多认定 + 命令取消某些规则，费率本身得等国会立法。如果未来几年里 Visa / Mastercard + 五大行能把和解费压在「比诉讼成本略高」的水平，这场诉讼又会变成另一个 2019 年——商户拿到钱，机制没变。

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | HN 原帖 | https://news.ycombinator.com/item?id=49993914 |
| 2 | The Pizza Standard LLC v. Visa Inc. et al. 诉状报道（ClassAction.org） | https://www.classaction.org/news/visa-mastercard-major-banks-facing-new-litigation-over-anticompetitive-merchant-credit-card-transaction-fees |
| 3 | 欧盟 interchange fee 封顶（0.2% / 0.3%） | https://eur-lex.europa.eu/EN/legal-content/summary/fees-for-card-based-payments.html |
| 4 | 美国 Durbin amendment（2010 年 debit 卡费率管制） | https://en.wikipedia.org/wiki/Durbin_amendment |
| 5 | 巴西 PIX | https://whatispix.com |
| 6 | 印度 UPI | https://www.npci.org.in/what-we-do/upi/product-overview |
| 7 | 欧洲 Wero（Pay by bank 联盟） | https://wero-wallet.eu |

<div class="disclaimer">

本文为 HN 热门帖的讨论摘要，非原文翻译，不代表本站立场。所有引文均标注原作者与 HN comment ID，可在原帖核对。诉状事实部分以 ClassAction.org 报道为准，欧盟 / 印度 / 巴西支付系统的细节参见相关链接。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>