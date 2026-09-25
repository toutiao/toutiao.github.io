---
layout: post
title: >-
  Anthropic 被定性为「供应链风险」——美上诉法院裁决背后的争议
date: 2026-09-26
hn_id: 49845977
categories: [articles]
excerpt: >-
  美上诉法院维持把 Anthropic 列为供应链风险的裁决，HN 讨论聚焦一处矛盾：拒绝给军方做 AI 的条款，原是合同里白纸黑字写下的。
tagline: >-
  拒签就能把谁打成敌国，这才是这条新闻真正恐怖的地方。
---

> ⚑ **政治背景**：本文涉及美国行政与司法机构针对美国本土 AI 公司 Anthropic 的供应链风险裁定。

## 原文概要

CNBC 报道，美国一家上诉法院维持了将 Anthropic 列为「供应链风险」（supply chain risk）的裁决。帖子发出 4 小时即拿下 252 分、386 条回复（HN 热门榜）。

背景是 Anthropic 与五角大楼之间的合同摩擦。Anthropic 设了两条红线：不接受全自动 AI 杀伤链、不接受针对美国本土的大规模监控。五角大楼随后援引《2018 年安全技术法》（FASCSA，即 10 U.S.C. §3252），把 Anthropic 列入供应链风险名单。后果是：任何给美国国防部供货的承包商及其下游供应商，都不得在其流程中使用 Claude——哪怕是与国防完全无关的业务。

Anthropic 已就此起诉，但本案上诉法院维持了原裁决。值得注意的是，OpenAI 与五角大楼签有类似条款的合同，但并未被列入同一名单——这构成了 HN 讨论里最具杀伤力的反差。

## 讨论焦点

### 法律定义：字面意义还是法庭扩读？

讨论一开始就在抠 10 U.S.C. 3252 的原文。Sippingabonedry 把整条法律定义抄了出来——「供应链风险」指的是「敌方可能破坏、恶意引入非预期功能、或者以其他方式颠覆……系统的设计、完整性、制造、生产、分发、安装、运行或维护」的威胁。但争议焦点很快落在定义末尾那句 "or otherwise manipulate the function" 怎么读。

> “Supply chain risk,” means the risk that an adversary may sabotage, maliciously introduce unwanted function, or otherwise subvert the design, integrity, manufacturing, production, distribution, installation, operation, or maintenance of a covered system so as to surveil, deny, disrupt, or otherwise degrade the function, use, or operation of such system (see 10 U.S.C. 3252). — sippingabonedry [c:49847690]

> （译文：10 U.S.C. 3252 原文如此——"供应链风险"指的是敌对方可能破坏、恶意植入非预期功能、或者以其他方式颠覆……系统的设计、完整性、制造、生产、分发、安装、运行或维护，致使其功能、使用或运行被监视、拒绝、扰乱或降级的风险。）

多数派意见把"manipulate"扩读为「只要技术上能调控输出，就算操纵」；少数派则用图书馆的类比反对这种读法。Romellem 转引了法庭文件里的少数派类比：

> A library might post a sign saying, “Do not shout, loudly talk on the phone, play music, or otherwise disturb others.” The common understanding would be that the rule bans bringing a boom-box into the reading room with the volume turned on high but not listening to music with headphones set at a modest sound level—even though both constitute “playing music.” — romellem [c:49847862]

> （译文：图书馆贴出告示——"请勿喧哗、大声通话、播放音乐或以其他方式打扰他人。"常识会理解为：禁止把大喇叭带进阅览室公放，但不禁止用耳机小声听音乐——尽管两者都构成"播放音乐"。）

少数派的意思是：法律里的 "manipulate" 必须承接前文"恶意、颠覆"的语境，不能被无限扩张成"任何主动输出控制"。多数派却接受了政府的扩读——Anthropic 既然承认自己技术上能调控 Claude 的回答，那就构成风险。

### 笔的类比：从合理到失守

ApolloFortyNine 抛出了 HN 最经典的「笔」类比：

> This is like a pen manufacturer not wanting their pens used to sign drone strike orders, now the military needs to have a special box of pens that don't have stipulations attached. — ApolloFortyNine [c:49847197]

> （译文：这就像一个笔厂不愿自己的笔被用来签无人机打击令，于是军方需要另备一盒没有任何附加条款的笔。）

Comnetxr 沿着这条线把类比推到荒诞：

> I think the better analogy is an insane nuclear power plant manager deciding it wants to buy pens to use as neutron-flux regulator rods — because after all, a pen is functionally a pencil and a pencil is made of graphite. — comnetxr [c:49848346]

> （译文：我觉得更贴切的类比是——一个疯了的核电站经理想买笔当核反应堆中子通量调节棒用，毕竟笔也算铅笔的一种，铅笔是石墨做的嘛。）

类比的精髓在下一句：核电站经理说"反正接口一样，先凑合用，等下一代笔出来效果更好"，笔厂回"在你书面承诺只用于书写之前，我一支都不卖给你"。这条线把"军方的合理需求"刻画为一种"勉强合规"的执念。

### 合同条款 vs 报复定性

讨论最尖锐的对立面在这里。RealFloridaMan 的核心论点是：Anthropic 的红线**从来都在合同里**，国防部签的时候就知道：

> Anthropic did not change the terms. Those were the terms the US Government signed. It was not secret, it was explicit identified and accepted as a term. — RealFloridaMan [c:49848720]

> （译文：Anthropic 没有改条款。那些条款是政府自己签的。不是暗箱，是明明白白列出来、对方接受了的。）

Alwillis 直接质疑"教科书定性"的说法：

> How can it be a textbook designation when designating a US company as a supply chain risk is unprecedented? — alwillis [c:49849042]

> （译文：把一家美国公司列为供应链风险，前所未有，怎么能叫"教科书"？）

> No other administration (Republican or Democrat) would do this. The DoD didn’t have a problem using Anthropic’s models during the raid on Venezuela and early on in the war with Iran. — alwillis [c:49849042]

> （译文：没有一届政府——无论共和党还是民主党——会这么做。国防部在委内瑞拉突袭和伊朗战争早期都用过 Anthropic 的模型，没出问题。）

### OpenAI 的反差

Burkaman 抛出了一个让多数派论点难以回避的反证：

> The reason it appears corrupt is that OpenAI has the exact same restrictions ... but was not declared a supply chain risk. If two vendors have the same restrictions and they only designate one, then the designation must be arbitrary and/or capricious. — burkaman [c:49847399]

> （译文：显得腐败的原因是 OpenAI 也有完全一样的限制条款，却没被列入供应链风险。两家供应商限制相同、只定一家——那这个定性必然是武断或反复无常的。）

Burkaman 后补了一条自我更正：细读 OpenAI 合同发现，OpenAI 实际上对「合法用途」的定义更宽，理论上并不阻止大规模监控或自主武器使用。这条自我更正反而把问题推向另一个方向——如果 OpenAI 没限制，那它愿意配合，这才是 Anthropic 被惩罚的真正理由。

Chriscjj 借法庭文件里的一句话，给这件事做了最冷的一句总结：

> The Department reasonably feared that Anthropic might manipulate Claude’s design to prevent it from performing national-security functions that the Department deems contractually authorized and necessary

> I.e. Anthrophic cannot be trusted to honour a contract.

> Who’d have guessed? — chrisjj [c:49848887]

> （译文：法庭文件原文——"国防部合理地担心 Anthropic 可能操纵 Claude 的设计，使其无法执行部门认为已获合同授权且必要的国家安全职能。"说白了就是：Anthropic 不值得信任，会按合同办事。）

讽刺的反转在于：法院判定 Anthropic 不可信，恰恰因为它**坚持履行合同里关于不允许滥用的那部分条款**。

### 商业波及：不止国防

讨论里被反复拎出来的一个细节——这份定性的连带范围远不止国防部本身。Jzb 直接质疑第三方承包商为何会被波及：

> If a supplier uses Anthropic to develop a product, how does that pose a risk to the DoD or national security? — jzb [c:49847864]

> （译文：一家供应商用 Anthropic 开发产品，跟国防部或国家安全有什么关系？）

Hiddencost 用了最生活化的反例：

> Using Claude for working on the refrigerators at the commissary is not a supply chain risk. — hiddencost [c:49847854]

> （译文：用 Claude 修军人食堂的冰箱，不构成供应链风险。）

Dillondoyle 补充说，特朗普政府最初版本比现在还宽，连完全无关的下游子公司都会被波及——相当于二级制裁的逻辑：

> they originally said the pen, paper, table etc suppliers cant use anthropic even for products and subsidiaries that have nothing to do with their govt work; far beyond the supply chain of the pen (bomb). — dillondoyle [c:49847836]

> （译文：政府最初版本里，连笔、纸、桌子的供应商都被禁止使用 Anthropic，哪怕他们的产品和子公司跟政府业务毫无关系。这比"打击链"的笔那点关系远多了。）

后来法庭把这个范围缩小了一些，但"间接业务被波及"的逻辑没变。

### 反方立场：控制权问题

支持裁决的少数声音集中在"私企不应凌驾于军方决策权之上"。Frumplestlatz 的核心论点是：

> Anthropic took the position that our military’s decision making power should be subordinate to Anthropic’s constraints. Any dependency on a company that thinks they have that moral authority and has the technical means to enforce it is absolutely a risk to the supply chain. — frumplestlatz [c:49847881]

> （译文：Anthropic 摆出的立场是：我军决策权应服从 Anthropic 的约束。任何依赖一家"自认为拥有道德权威且有技术能力执行这种权威"的公司，本身就是供应链风险。）

Smsm42 给出了更冷静的版本：

> Supply chain risk ensures nobody in the chain is buying it and thus becoming subject to Antropic's demand of usage control. They are still free to use it for non-DOD purposes, but if Antropic wants control over DOD, DOD has the right to say "no, we won't have anything to do with you." — smsm42 [c:49848645]

> （译文：供应链风险定性的作用是确保整条供应链上没人会买 Anthropic，从而不受它对使用场景的控制。Anthropic 在非国防领域照样可以用，但如果想控制国防部，国防部有权说"不，我们不跟你做生意"。）

两边的分歧落在"是否允许私企以道德理由设置使用条款"上。支持方认为这越过了私企本就不该越的线，反对方认为这正是合同自由。

### 滥用前景

Iamdelirium 提出最让人不安的一个问题：

> If I was Palantir or any other GOP aligned company, I would be completely against this. What's to stop a Democratic president from doing the same thing and destroying them? — iamdelirium [c:49846594]

> （译文：如果我是 Palantir 或任何共和党友好的公司，我会坚决反对这件事。下届民主党总统照样这么干，把我们毁了，谁能拦？）

Inkysigma 把这个担忧推得更远：

> If a machining shop had a policy against manufacturing weapons at all, could they be blocked from making server racks for Microsoft or perhaps light fixtures for the Department of Labor? — inkysigma [c:49848125]

> （译文：一家机加工店如果有"不生产武器"的政策，那它会不会也被禁止给微软做服务器机架、或者给劳工部做灯？）

> I don't think it's credible to claim that Anthropic will deliberately sabotage operations. — inkysigma [c:49848125]

> （译文：我不认为 Anthropic 会蓄意破坏军方任务这种说法站得住脚。）

### 红线本身是否合理

Felixgallo 把讨论拉回到原点的合理性：

> Anthropic's red lines were 'no fully autonomous AI kill chains' and 'no domestic mass surveillance'.  Those are clearly not national-security or DoD functions in the first place, so why would they be in any way objectionable? — felixgallo [c:49847381]

> （译文：Anthropic 的红线是"无全自动 AI 杀伤链"和"无针对美国本土的大规模监控"。这两件事本来就不属于国家安全或国防部的职能，有什么理由反对？）

这条质疑的核心是：Anthropic 划掉的那两项，根本不是国防部应该干的。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 教科书定性 | ApolloFortyNine [c:49847197] | 私企给军用条款设限，军方拒绝本属正常 |
| 法律字面 | sippingabonedry [c:49847690] | 10 U.S.C. 3252 的"操纵"必须承接恶意语境 |
| 法庭扩读 | chrisjj [c:49848887] | 不按合同办事本身就不可信 |
| 报复定性 | alwillis [c:49849042] | 从未用于美国本土公司，党派色彩明显 |
| OpenAI 反差 | burkaman [c:49847399] | 同条款不同待遇，必然武断 |
| 红线正当 | felixgallo [c:49847381] | 全自动杀伤链本来就不该是国防部职能 |
| 控制权问题 | frumplestlatz [c:49847881] | 军方决策权不能让私企凌驾 |
| 合同履约 | RealFloridaMan [c:49848720] | 红线是合同条款，不是事后追加 |
| 滥用风险 | iamdelirium [c:49846594] | 民主党上台反过来用怎么办 |
| 波及范围 | jzb [c:49847864] | 第三方承包商跟国家安全有何关系 |
| 历史先例 | inkysigma [c:49848125] | 大量美国企业为此递交法庭之友书 |

## 总体情绪

HN 的整体情绪倾向负面——多数讨论者把这件事解读为"政府用国家安全工具惩罚一家不听指挥的美国公司"。讨论热度的核心不是法律技术细节，而是**对工具被政治化的普遍不安**：当一个原本针对外国对手的机制可以被转向本国公司，并且波及范围能扩到下游承包商和子公司时，下一次轮到谁只取决于执政者的好恶。

但讨论里也有少数严肃的反方声音，他们不是为报复辩护，而是从制度层面提出问题——私企是否应该有"道德否决权"凌驾于政府对其产品的使用之上。这个问题没有简单答案，但 Anthropic 划掉的是"全自动杀人"和"国内大规模监控"这两项，门槛不算低。

整场讨论的潜台词很清晰：争议不在 Anthropic 设了什么红线，而在政府动用了一个为对付朝鲜、伊朗、俄罗斯而设计的工具，把一个美国公司放进同一份名单——而且没有给出真正的安全理由。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | U.S. appeals court upholds designation of Anthropic as supply chain risk | https://news.ycombinator.com/item?id=49845977 |

## 免责声明

<div class="disclaimer">
本摘要基于 HN 讨论内容整理，仅代表参与讨论用户的观点，不代表本站立场。
<br><br>
⚠ <strong>政治背景</strong>：本文涉及美国行政与司法机构针对美国本土 AI 公司的裁定。读者应自行核实相关法律条款与裁决细节，避免仅凭单一渠道形成判断。
<br><br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>