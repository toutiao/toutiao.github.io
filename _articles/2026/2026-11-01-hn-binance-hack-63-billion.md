---
layout: post
title: >-
  63 亿美元、20 分钟：Binance 史上最大劫案，评论区在吵冻结还是去中心化 — HN 讨论摘要
date: 2026-11-01
hn_id: 50296470
categories: [articles]
excerpt: >-
  63 亿美元、20 分钟、10 条链。约 28 亿美元被冻结，33 亿美元冻不住——
  剩下的只能等它流进交易所。评论区争的不是谁偷的，而是「冻结」这两个字该不该存在。
tagline: >-
  钱包没被偷，签名服务替它按了 50 次。
---

> 来源：HN 讨论主帖 [Binance-hacker-1029 – $5.6B stolen from Binance](https://news.ycombinator.com/item?id=50296470)（1746 分，1183 条评论）。关联帖：[The $6.3B Binance Hack Was Pulled Off in Just 20 Minutes](https://news.ycombinator.com/item?id=50303172)（WIRED，537 分）、[Blockchain intelligence firms link North Korea to $6.3B hack on Binance](https://news.ycombinator.com/item?id=50305480)（NPR/AP，193 分）。原文：[WIRED](https://www.wired.com/story/the-dollar63-billion-binance-hack-was-pulled-off-in-just-20-minutes/)、[NPR](https://www.npr.org/2026/10/30/g-s1-150902/blockchain-intelligence-firms-link-north-korea-to-6-3b-hack-on-binance)、[808bits 技术复盘](https://808bits.com/articles/binance-hot-wallet-eip-7702-delegations/)。本篇为 cluster 模式，主帖为劫案现场讨论（thread 1），WIRED 报道为 thread 2，NPR/AP 报道为 thread 3。

## 原文概要

10 月 29 日下午 4 点前后，Binance 的热钱包开始被掏空。TRM Labs 的结论是：攻击者从十条链上的 Binance 钱包搬走约 63.6 亿美元，绝大部分发生在 20 分钟内，这是有记录以来最大的一笔加密货币盗窃。主帖发出来时 Arkham 链上追踪给出的数字是 56 亿美元，几小时后被修正到 63 亿——这个数字本身就是这场事故的第一个注脚。

TRM 说准备工作至少提前了 36 小时：10 月 29 日当天，攻击者先在两个钱包上部署代码测试，又在第三个钱包上完整演练了一遍，把测试资金原路退回自己，四小时后才把同一套代码装到 Binance 的热钱包上。Chainalysis 则给出了更狠的一条线索——被盗资金在链上实时混入了上个月 Bitget 被盗的资金，"我们从未见过这种洗钱模式"，并指向上千笔快速处理的小额交易，说明攻击方在用自动化抹痕迹。

技术细节来自 808bits 的独立复盘，它是目前把这条链扒得最细的一份。时间线从 20:05 开始：XRP Ledger 上五个 Binance 钱包在四分二十秒内转出 2.335 亿枚 XRP，其中第一次尝试用 4200 万枚 RLUSD 付款还失败了（tecNO_DST，接收账户当时还不存在，而那条链上的一笔转账无法凭空创建账户）；20:10，Solana 上 965,455 枚 SOL 离开 Binance 2；20:20，比特币区块 973732 花掉主热钱包的 18,270 枚 BTC，由 513 个签名支付到一个从未见过的新地址，随即被拆成 17 份、每份正好 1000 枚。

20:20:59，Ethereum 区块 26300753 落下一笔不含任何转账调用的交易，载荷是一份长度 50 的 EIP-7702 授权列表——50 条全部由 Binance 最忙的热钱包 Binance 14 签出，指向同一个当天下午部署的合约。三分二十四秒后，那个合约一次调用清空钱包：167,464 枚 ETH 加 63 个代币，其中 16.15 亿枚 USDT，按当时行情约 25 至 28 亿美元。

让 808bits 作者改变判断的是那 50 个 nonce 的排列方式。EIP-7702 授权不是交易，只是一段 29 字节的签名对象：魔数前缀、RLP 列表、链 ID 1、20 字节委托地址、nonce。签名服务拿到的是一串摘要哈希，它根本看不见自己签的是什么；策略引擎检查目标地址、金额、data 字段，也一样看不见——这个对象里根本没有这些字段。攻击者签的是一段窗口：nonce 18914775 到 18914824，连续 50 个，逆序提交。报告人写道，这种五十宽的窗口，正是"你把摘要丢给某个自己不控制返回速度的服务"时才会出现的形状。Binance 14 在攻击前三分钟里发了 33 笔交易，nonce 推进极快，所以窄窗口必然失效，只有五十宽才够用。结果是 50 条里 34 条一落地就已作废、15 条富余，只有第 16 条真正生效。

Binance 的第一份声明说初步调查指向一台被攻破的笔记本电脑，没有发现私钥泄露的证据；808bits 的作者认为如果这句话站得住，那就是第二种读法——没人偷走密钥，攻击者只是把请求喂给了持有密钥的那条流水线，而流水线照常为 Ethereum 签了 50 份授权、为其他每条链签了普通转账。他同时指出，加密签名策略要挡住这次攻击，规则清单得有八条，第二条就是"解析密钥签的每个对象的完整输入，把任何以 0x05 开头的东西单列规则"——而他见过的策略模板里没有这一行。

后续几件事让时间线显得更难看。23:50，也就是被掏空三个半小时后，Binance 14 仍在执行攻击者的合约；00:10:35，Binance 才用一条指向零地址的授权把它清掉，随后暂停提现。链上还有更尴尬的细节：被掏空之后 Binance 钱包照常发出了 326 笔 USDT 转账，其中一笔 2 亿在 21:42:59 发出，72 秒后被扫走。

冻结的部分由 Tether 和 Circle 主导。Tether、USDC 这类稳定币发行方能按合约冻结地址，评论区实测的数字是 Circle 与 Tether 合计已冻结约 24 亿美元，Elliptic 的 Tom Robinson 给出的稍晚数字是 28 亿美元、占总被盗额约 44%，且几乎全是稳定币。剩下的 33 亿美元主要是 BTC、ETH 和 XRP，没有人能冻结它们——只能等它们流进某个交易所或服务商时被拦下。Robinson 说冻结比例不会明显再涨。

归因指向朝鲜。TRM 与 Chainalysis 都认为攻击者是朝鲜精英黑客组织 TraderTraitor，TRM 说"我们高度确信"，Chainalysis 创始人 Jonathan Levin 在 X 上称"很可能是 DPRK 的 TraderTraitor"。Elliptic 的 Robinson 更直接："我们认为朝鲜很可能是幕后黑手。如果是，这单 theft 将让该政权迄今在加密领域的窃取总额几乎翻倍。"2025 年 2 月 Bybit 的 15 亿美元被盗，FBI 已认定朝鲜 TraderTraitor 所为，这次的作案手法与之高度相似。CZ 也在 X 上发帖："用户资金是安全的！"同时承认"看起来确实是对 Binance 的黑客攻击"。安全公司 NyxLab 联合创始人 Kok Tin Gan 提出了评论区之外的关键问题："这看起来就是一个签名，给了攻击者一个永不过期的、全权限的 Binance 热钱包令牌。"

## 讨论焦点

### "我以为加密货币的重点是不讲道理"

主帖最早爆开的那批评论，几乎都在同一处撞墙：冻结。

> "I thought the point of crypto was no takesies-backsies?" — rwmj [c:50296611]

> （我以为加密货币的重点就是不讲道理、不认账？）

有人直接把吐槽落到了对象上：

> "We're talking about Binance, a centralized exchange." — method_capital [c:50297031]

> （我们讨论的可是 Binance，一家中心化交易所。）

还有更短的一句：

> "So much for anti-centralization." — chairhairair [c:50296640]

> （反中心化也就这样吧。）

为什么冻得住？因为 USDT 这类代币从设计上就留了后门。codedokode 在主帖里翻出合约源码：

> "So USDT is not truly decentralized and your money can be frozen for any reason or no reason at all." — codedokode [c:50297785]

> （所以 USDT 根本不是去中心化的，你的钱可以被冻结，不讲理由也不讲理由。）

wmf 把机制说得更干净：

> "Most crypto assets are operated by a smart contract that controls every transfer. So the contract can decide to not perform certain transfers." — wmf [c:50296900]

> （大多数加密资产都由一个控制所有转账的智能合约运营。所以这个合约可以决定不执行某些转账。）

而 Dagonfly 补上了那句让人更不安的话——冻结并不是不可逆的：

> "To be clear: There is no permanently frozen guarantee. Tether can and has unfrozen (called removeBlackList)addresses before. All of this is just a public database fully controlled by Tether Limited." — Dagonfly [c:50302468]

> （说清楚：这里没有任何"永久冻结"的保证。Tether 以前解冻过地址（他们管这叫 removeBlackList）。这一切都只是一份由 Tether Limited 完全掌控的公开数据库。）

反对冻结的一方也给出了自己的账。jwpapi 是最不留情面的：

> "Freezing crypto is so disgusting to me I don't know… Like the whole point of crypto to me I money without central governance. I never liked stable coins or the concept of it and it's mainly a huge fraud, so freezing just adds on top." — jwpapi [c:50297495]

> （冻结加密货币这件事让我恶心得不知道该说什么。对我来说加密货币的全部意义就是钱不受中心治理支配。我从来就不喜欢稳定币这个概念，它本身就是个巨大的骗局，冻结只是雪上加霜。）

ajross 的回复把两边都算了一遍：

> "The feature literally appears to have just saved over two billion USD from being stolen!" — ajross [c:50300048]

> （这个功能看起来确实刚刚保住了二十多亿美元不被偷走！）

### 谁来赔：Tether 的账与 DeFi 出借人的账

冻结之后的账没人算得清，因为至少有三方受损：被冻结资产的持有者、给冻结稳定币做过抵押放贷的 DeFi 平台，以及 Binance 自己。

Ntrails 先把稳定币发行方的动机拆开：

> "I think the idea is that they freeze them indefinitely, and then they no longer count against the centralised reserves, since they can never cash out. Now they can mint the equivalent amount back to Binance and remain solvent." — mcintyre1994 [c:50300552]

> （我的理解是：他们无限期冻结这些币，于是这些币不再计入中心化储备——反正也永远兑不出来。这样他们就能重新铸造等额的币还给 Binance，同时保持偿付能力。）

Ntrails 承认这个解释说得通，但立刻反问另一个方向：

> "The alternative is the stablecoin providers effectively keep the money for themselves. At that point the justification for the blacklisting seems like little more than self enrichment?" — Ntrails [c:50302382]

> （另一种可能是稳定币发行方干脆把钱留给自己。那样的话，列入黑名单这件事的理由看上去就只剩自我 Enrichment 了？）

真正麻烦的是 DeFi 那条线。extraextra 补充的情报是：攻击者把稳定币当作抵押品，通过 DeFi 借出了 ETH。

> "There are reports that the hackers used the stablecoins as collateral to borrow ETH via DeFi, before the stablecoins were frozen" — extraextra [c:50304309]

> （有报道称黑客在稳定币被冻结之前，把它们当作抵押品通过 DeFi 借出了 ETH。）

> "In this case, the hackers have the ETH, while the lender has some frozen stablecoins" — extraextra [c:50304309]

> （这样一来，ETH 在黑客手里，出借方拿到的却是一堆被冻结的稳定币。）

globuous 把这个结构描述得更完整：

> "Apparently [1], he managed to put them as collateral on a lending platform. That allowed him to borrow ETH. The way it works is that if you don't pay back the loaned ETH, the lenders can take the collateral. Except that here the collateral is itself frozen. So apparently, the ETH as now safe in the hacker's wallet and the lenders just lost a bunch of money." — globuous [c:50301259]

> （据说他设法把这些币抵押到一个借贷平台上，从而借出 ETH。机制是这样的：如果你不归还借来的 ETH，出借方可以拿走抵押品。但这里抵押品本身是被冻结的。所以结果是 ETH 安全地躺在黑客钱包里，出借方白白损失了一大笔钱。）

也就是说，"冻结 28 亿"这个数字在不同的账本上并不等于同一件事：被冻住的是已经换不回现金、也可能没人要的稳定币，而真正流走的 ETH 和 BTC 一枚都没停。

### DAO 分叉是不是先例

老问题又被翻了出来：既然以太坊当年能为 DAO  hacks 回滚，这次为什么不能回滚？

michaelt 给出的是最广为流传的版本：

> "Back in 2016 a then-huge Ethereum smart contract called "The DAO" [1] had a loophole that let an attacker extract a third of all the funds. But a lot of the developers and miners had either lost money themselves, or had friends who'd lost money, or felt the embarrassing incident was devaluing their own Ethereum holdings. So they decided to allow takesies-backsies." — michaelt [c:50297166]

> （2016 年，一个当时规模巨大的以太坊智能合约"The DAO"有个漏洞，攻击者借此卷走了三分之一的资金。但很多开发者和矿工要么自己也亏了钱，要么有朋友亏了钱，要么觉得这次丑闻正在让自己的 ETH 持仓贬值。于是他们决定允许一次不讲道理。）

phire 反对把这件事当成可复制的先例：

> "The DAO incident was a special case. It was only sane to do the rollback because the stolen funds were time-locked up for 28 days." — phire [c:50297802]

> （DAO 那次是特例。当时做回滚是唯一理性的选择，因为被偷的资金有 28 天的锁定期。）

> "Ethereum never did it again, rolling back hacks didn't (and couldn't) become normal policy. IMO, they shouldn't have made an exception, as it set a bad example." — phire [c:50297802]

> （以太坊后来再没这么干过，回滚黑客攻击既没变成也不可能变成常规政策。在我看来当初就不该破例，因为它开了个坏头。）

michaelt 的收尾把技术问题推成了政治问题：

> "There's probably a philosophical lesson there about power and who the rules really apply to." — michaelt [c:50297166]

> （那里大概藏着一个关于权力、以及规则到底对谁生效的哲学教训。）

### 你的币其实不是你的

"not your keys, not your crypto"这老话在这场事故里被反复拿出来鞭尸，但方向变了：这次连 key 都是别人的，只有钱包是自己的。

ebiester 的说法最狠：

> "There apparently is no such thing as "your crypto" with how many security problems there are." — ebiester [c:50297236]

> （鉴于有这么多安全问题，显然不存在"你的加密货币"这种东西。）

hgoel 把它压成一句：

> "Turns out that even crypto's rules only apply if you're poor." — hgoel [c:50297241]

> （原来连加密货币的规则，也只对穷人有效。）

而更深一层的问题由 Analemma_ 提出——他劝人别再往这个方向砸：

> "To a first approximation, nobody in crypto actually believes in the stated principles of anti-centralization, freedom, etc. It's entirely about number go up and always has been." — Analemma_ [c:50296824]

> （粗略地说，加密圈里没人真的相信什么反中心化、自由那一套。从头到尾都只是"数字涨上去"，一直如此。）

CodingJeebus 说得更狠，他给这套体系找了个病根：

> "Ironically, the piece that makes crypto fundamentally unworkable 20 years in is capitalism." — CodingJeebus [c:50305334] [thread 2]

> （讽刺的是，让加密货币在二十年后依然从根本上行不通的那个东西，恰恰是资本主义。）

EGreg 则是这套理念的正面辩护者，他坚持目标从来是分散：

> "The point is to NOT have a single place with access to all the money, votes, etc. Every participant should be acting as themselves, and there should be no way to do things on behalf of others without their consent." — EGreg [c:50304963] [thread 2]

> （重点从来就是不要让某一个地方能掌握所有资金、投票权等等。每个参与者都该以自己的身份行动，不该存在替别人做事而不需要对方同意的方式。）

他后来补的那条，正好是这次事故最锋利的注脚：

> "The very reason that this Binance hack is a huge issue is that $5B was concentrated in specific wallets under specific keys." — EGreg [c:50306166] [thread 2]

> （这次 Binance 被盗之所以是大事件，最根本的原因就是 50 亿美元集中在特定钱包、特定密钥之下。）

ebertucc 把两边各让一步：

> "Centralization (on Binance) made the attack appealing, but decentralization (of crypto broadly) is the only reason it's possible, and centralization (of USDT et al) is the only path to recovery." — ebertucc [c:50306763] [thread 2]

> （中心化（Binance 层面）让这次攻击变得有利可图，但整个加密体系的去中心化恰恰是它能发生的前提，而中心化（USDT 之类）又是唯一的追回路径。）

### 安全工程：签名服务那一层

thread 2 的讨论更偏工程。toomuchtodo 直接把复盘文章甩了上来：

> "Binance hot wallet signed 50 EIP-7702 delegations 3 minutes before the drain" — toomuchtodo [c:50306738] [thread 2]

> （Binance 热钱包在被掏空前 3 分钟签下了 50 份 EIP-7702 委托授权。）

saalweachter 把话说到点子上：所有软件都有洞，问题在于谁在认真防。

> "All software has flaws and it's now easier than ever to find and exploit them, but this disproportionately hurts people who were only putting on a show of security and relying on a single layer or two of defense instead of developing a robust insider threat model (which helps with both insider threats and threats that get inside) and defense in depth." — saalweachter [c:50304370] [thread 2]

> （所有软件都有缺陷，而且现在找漏洞和利用漏洞都比以往容易。但这 disproportionately 伤害的是那些只在做安全表演、只靠一两层防护就以为安全的人，而不是那些认真做了内部威胁模型（它同时对内部人和已经渗透进来的威胁都有效）、并做了纵深防御的人。）

再往上一层，他指出这不是"改改流程"能解决的：

> "It requires management buy-in, both to allow some number of engineers to be allocated to such "non-production" work, and also to allow the friction security creates to continue to exist and "slow down" the "real work"" — saalweachter [c:50304988] [thread 2]

> （这需要管理层买账：既要让一部分工程师被分配到这种"非生产"工作上，也要允许安全带来的摩擦继续存在，让"真正的工作"慢下来。）

一个反常识的补丁来自 avidiax：

> "There's a really simple solution that people will hate: server goes offline at night." — avidiax [c:50309731] [thread 2]

> （有个大家会恨的简单方案：服务器晚上下线。）

> "Many banking operations are not actually instantaneous, they settle in a batch job overnight." — avidiax [c:50309731] [thread 2]

> （很多银行操作其实并不是即时的，它们在夜里跑批处理结算。）

他的逻辑是：链上转账的可怕之处在于毫秒级完成，没有留给人反应的时间窗口，而批量结算天然提供了窗口。而 ethbr1 走的是另一条更粗野的线：

> "Why would they? In addition to moral hazard (next time), this is binance's fuck-up. Have bad security, get hacked." — ethbr1 [c:50301909]

> （为什么要呢？除了道德风险（下次还会有人试）之外，这是 Binance 自己的锅。安全做得差，被黑是活该。）

kshacker 用电影剧本的节奏把整件事重演了一遍，是整个 thread 里最欢乐的一段：

> "51-60: We are going to hack StarLink (they never say that, it is just the logo in the background when they are talking how easy it is to get in and out)" — kshacker [c:50304066] [thread 2]

> （51-60：我们要黑掉 Starlink（他们从来不直说，只是背景里放着那个 logo，边说边讲我们进进出出有多容易））

> "86-88: Oh it was Solozzo (Binance) all along, not Starlink." — kshacker [c:50304066] [thread 2]

> （86-88：哦，原来从头到尾都是 Solozzo（Binance），不是 Starlink。）

### 传统金融也在冻结，差别只是速度

thread 3（NPR/AP 那个帖）的方向完全不同：有人提醒，传统金融的冻结能力一点不弱，链上的特殊之处在别处。

manquer 举了孟加拉央行那桩旧案：

> "Most of it was stopped and some was even recovered but $66Million is still lost 10years later ." — manquer [c:50308506] [thread 3]

> （大部分被拦下了，也有一些被追回，但十年后仍有 6600 万美元没有着落。）

Shank 补充了花旗的旧事：

> "Most notably, 900 million in accidental payments made by Citi were eventually fully reversed by appeals courts." — Shank [c:50309047] [thread 3]

> （最出名的是花旗那 9 亿美元的误付款，最终被上诉法院全部判回。）

Lichtso 提出了一个更精确的区分：可逆性不是关键差别，速度才是。

> "That means attackers can do a fast sweep on blockchains, which is not possible with bank transactions because everything happens in slow motion and humans have way more time to react and step in." — Lichtso [c:50308802] [thread 3]

> （这意味着攻击者可以在区块链上快速扫荡，而银行转账做不到——银行的一切都在慢动作里，人有充足的时间反应和介入。）

gradus_ad 把整个加密体系重新定位了一遍：

> "Crypto has been entirely subsumed into this architecture through the exchanges which are obviously beholden to the holders of real power, i.e. governments." — gradus_ad [c:50308299] [thread 3]

> （通过交易所——那些显然听命于真正权力持有者、也就是政府——加密货币已经被完全吸纳进这套架构里了。）

rlpb 则给出了一个有点科幻的技术方案，方向是"把延迟和封锁设计进链本身"：

> "I imagine it's possible to design a blockchain where transactions are 1) artificially delayed; and 2) can be blocked by anyone who has the key." — rlpb [c:50310248] [thread 3]

> （我设想完全可以设计出这样的区块链：交易一被人为延迟，二是有钥匙的人可以随时封锁。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 冻结是有效功能 | ajross | 二十多亿靠这个功能保住了 |
| 冻结背离初衷 | jwpapi | 稳定币本就是骗局，冻结只是加码 |
| 你用的不是去中心化 | method_capital | 我们说的是 Binance，中心化交易所 |
| 冻结不是永久的 | Dagonfly | Tether 以前解冻过，黑名单就是它自己的数据库 |
| DAO 是坏先例 | phire | 回滚从来不是常态政策，它开了个坏头 |
| DAO 是情有可原 | michaelt | 回滚背后是亏了钱的开发者和矿工 |
| 银行同样在冻结 | manquer | 孟加拉央行那 10 亿美元，十年后仍有 6600 万没追回 |
| 真正的差别是速度 | Lichtso | 链上毫秒级，银行要好几天，人来得及反应 |
| 安全是工程问题 | saalweachter | 纵深防御加内部威胁模型，别只做一层 |
| 也有粗暴派 | ethbr1 | 安全做不好就等着被打 |
| 核心不是反中心化 | Analemma_ | 没人真信那套，一直只是数字涨上去 |
| 交易所自找的 | ethbr1 | 出了事是 Binance 自己的锅 |
| 链可以重新设计 | rlpb | 人为延迟加上有钥匙就能封锁 |
| 攻击会被当成演练 | mahirsaid | 下次他们会改进流程，同行也会跟着改 |

## 总体情绪

这场讨论的分裂点不是"该不该抓黑客"，而是"冻结"这个动作本身该不该存在，以及——如果它存在，那么加密货币到底还剩多少是自己能作主的。评论区里最能代表两种极端的，一句是 rwmj 的"我以为加密货币的重点是不讲道理"，一句是 EGreg 的"重点从来就是不要让某一个地方能掌握所有资金"。这两句之间，是整整一代人对同一套叙事的不同理解。

情绪的分层也很清楚：最表层是玩梗和嘲讽——"朝鲜人替你写代码"式的黑色幽默、电影剧本式的复盘、还有一句"连加密货币的规则也只对穷人有效"。往下一层是技术人的不安：真正让他们睡不着的不是 63 亿这个数字，而是 808bits 那条时间线里的几个细节——29 字节的签名对象，签名服务看不见自己签了什么，策略引擎也没有对应字段，50 条授权里 34 条一落地就作废，还有被掏空三个半小时后 Binance 14 仍在执行攻击者的合约。评论里的原话是"这看起来就是一个签名，给了攻击者一个永不过期的、全权限的热钱包令牌"。再往下是对"追回"的清醒：冻结 28 亿听着像胜利，但剩下的 33 亿冻不住，出借人的钱也拿不回来，被冻结本身也不是永久的——黑名单只是一份由发行方完全掌控的公开数据库。

最沉的一层其实在自我审判。评论者反复说的不是"币圈完了"，而是"这套东西当初许诺的分散、不可追回、无需信任，恰恰在最需要它的地方缺席"。祁连山下那句"反中心化也就这样吧"，和 808bits 作者那句"没人偷走密钥，攻击者只是把请求喂给了持有密钥的那条流水线"，说的是同一件事的两面：中心化不在链上，在签名服务、策略引擎和那个永远能重建的中心账户里。

63 亿美元，20 分钟，50 份授权，34 份当场作废。到最后，Binance 用一条指向零地址的授权，在事发三个半小时后才把攻击者的合约清出钱包。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Binance-hacker-1029 – $5.6B stolen from Binance（HN 主帖，1746 分） | https://news.ycombinator.com/item?id=50296470 |
| 2 | The $6.3B Binance Hack Was Pulled Off in Just 20 Minutes（HN 关联帖，WIRED，537 分） | https://news.ycombinator.com/item?id=50303172 |
| 3 | Blockchain intelligence firms link North Korea to $6.3B hack on Binance（HN 关联帖，NPR/AP，193 分） | https://news.ycombinator.com/item?id=50305480 |
| 4 | 原文：The $6.3B Binance Hack Was Pulled Off in Just 20 Minutes（WIRED） | https://www.wired.com/story/the-dollar63-billion-binance-hack-was-pulled-off-in-just-20-minutes/ |
| 5 | 原文：Blockchain intelligence firms link North Korea to $6.3B hack on Binance（NPR/AP） | https://www.npr.org/2026/10/30/g-s1-150902/blockchain-intelligence-firms-link-north-korea-to-6-3b-hack-on-binance |
| 6 | 原文：Binance hot wallet signed 50 authorizations 3 minutes before the drain（808bits 技术复盘） | https://808bits.com/articles/binance-hot-wallet-eip-7702-delegations/ |
| 7 | TRM Labs：North Korea Steals USD 6.36 Billion from Binance | https://www.trmlabs.com/resources/blog/north-korea-steals-usd-6-36-billion-from-binance-in-the-largest-hack-in-history |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中涉及的被盗金额（56 亿美元／63 亿美元／63.6 亿美元）、冻结金额（约 24 亿／28 亿美元）、链上时间点与代币数量，来自 TRM Labs、Elliptic、Chainalysis、Chainalysis 的公开分析、NPR/AP 报道、WIRED 报道及 808bits 的独立复盘，均为第三方口径，未做独立复核，请以官方事后报告为准。Binance 官方声明与 808bits 作者的推论存在分歧（是否为密钥泄露、签名服务如何工作），本文两种读法并列呈现，不做判定。攻击者身份目前仅有区块链取证机构的归因与推测，官方尚未确认。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
