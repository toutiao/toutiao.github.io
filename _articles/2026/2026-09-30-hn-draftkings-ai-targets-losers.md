---
layout: post
title: >-
  DraftKings 用 AI 锁定「必输」赌徒 — HN 讨论摘要
date: 2026-09-30
hn_id: 49896050
categories: [articles]
excerpt: >-
  EFF 引用《纽约时报》调查，揭 DraftKings 用 ML 在自己的下注记录里筛出最可能输钱的客户，再把他们送回平台；HN 讨论在「赌博到底是不是天生让人上瘾」「VIP 是不是必然等同于病态赌徒」「预测市场怎么跟着变烂」三个方向上反复开火。
tagline: >-
  你以为算法在帮你挑比赛，其实它在帮你挑你自己。
---

## 原文概要

[主帖](https://news.ycombinator.com/item?id=49896050) 由 Electronic Frontier Foundation 发布，标题《DraftKings Is Using AI to Supercharge the Harms of Online Behavioral Advertising》，3 小时内拿到 408 分。文章依据《纽约时报》9 月 19 日的调查，核心事实链如下：

- DraftKings 用**自家客户的下注记录**训练机器学习模型，专门找出"最可能输钱 + 最可能响应促销"的客户。
- 找到后向这些客户发送**针对性促销**，把他们重新拉回平台下注——而下注本身就被 DraftKings 判定为**大概率输**的那种。
- DraftKings 的商业模式建立在"留住输钱的客户"上，因为这些客户才是真正给它贡献收入的人；按 EFF 的说法，"问题赌徒"（problem gamblers，反复赌博伤害自己、财务、关系的人）正是这个模型**最高优先级**的目标。
- EFF 把这定性为"线上行为广告"（online behavioral advertising）的延伸：它本身有害，AI 把它的危害**放大**——AI 是黑箱，训练时为了榨干边际信号，公司会**不断收集更多数据**。

EFF 在政策层面给出的判断是：**仅限制第三方数据分享的政策挡不住这种掠夺**——DraftKings 用的就是**第一方数据**。必须直接禁止行为广告本身，才能切断激励。

文章还点出 ICE（美国移民与海关执法局）今年早些时候发布过一份 Request for Information，"试图了解商业大数据与广告科技公司如何直接支持调查行动"。EFF 的潜台词是：**被训练来识别赌徒的模型，可以轻易地被政府拿来识别移民**。

评论区里的具体引用包括：

- SaucyWrong 在 MA 给了一组数据——"州赌博求助热线在网络体育博彩合法化之后**翻了一倍**"。
- AlexandrB 引用 The Guardian 2022 调查，指出**赢钱的客户会被"影子封禁"**（Stake factoring），赔率被悄悄调低。
- Meowface 把战火烧到 Kalshi / Polymarket——"预测市场原本可能是规则里的例外，但所有这类公司最终都向体育博彩收拢"。

## 讨论焦点

### ProPublica 一年前已经讲过同一个故事

HN 第二条热评直接引用了 ProPublica 早先的调查——

> "ProPublica had one of their reports work with gambling addition experts to see how DraftKings would respond to someone presenting signs of a gambling problem. It's a hell of a read, and makes it clear that this company is full of people with absolutely no ethics whatsoever." — tedivm [c:49896224]
>
> （译文：ProPublica 之前的一项调查是和赌博成瘾专家合作，模拟一个呈现赌博问题迹象的客户，看 DraftKings 怎么反应。读起来触目惊心，能清楚地看出这家公司从上到下毫无道德底线。）

这条线的重要性在于——EFF 这篇文章**不是第一次揭露**。ProPublica 在一年前就用"卧底式实验"演示过 DraftKings 的 VIP 流程：客户呈现成瘾迹象之后，DraftKings 的反应是**给他升 VIP、给他更多优惠**，而不是引导他去找戒赌机构。

把 ProPublica 的"行为实验"和 EFF 这篇文章的"算法揭露"放在一起，HN 读者的结论是——这不是**员工道德问题**，而是**产品设计本身**。

### 「赌博是不是天生让人上瘾」：整场讨论的根本分歧

HN 评论区几乎所有后续辩论都回到同一个根本问题——**赌博到底是不是天生让人上瘾**。

支持"是"的极端版本（garbageman）——

> "Gambling is absolutely inherently addictive as it's essentially perfectly paired with your brains reward system and hijacks it. There's literally dopamine cycle and tolerance happening. And when compounded by algorithms and notifications which are designed to amplify this even further I'm not sure how you can think it's not inherently addictive." — garbageman [c:49897188]
>
> （译文：赌博天生让人上瘾，它和大脑奖励系统几乎完美对接，会劫持它。多巴胺循环和耐受性都在发生。再加上专门设计来放大这种循环的算法和推送，我看不出你怎么能否认它天生让人上瘾。）

支持"是"的中等版本（cynicalkane）——

> "Gambling is proven to be addictive in the same way many other things are, and the harm of severe addiction is comparable to that of the worst drugs. It's very common for severe gambling addicts to lose everything they have, to lose everything they love, to never psychologically recover, to kill themselves." — cynicalkane [c:49897981]
>
> （译文：赌博被证明跟很多东西一样让人上瘾，严重成瘾的危害和最糟糕的毒品相当。严重赌徒常常倾家荡产、失去所爱、心理再也回不来、甚至自杀。）

反对"天生"的版本（skippyboxedhero）几乎逐句反驳——

> "It isn't inherently addictive. Gambling addiction is significantly less common than alcohol addiction, and has no properties that make it inherently addictive to someone who is not predisposed towards that addiction (unlike drugs, for example, which are inherently addictive to all humans). Some slot machines/casino games are designed to appeal to problem gamblers. DK and co, however, do not design these games, and state regulators do already control aspects of their design." — skippyboxedhero [c:49896998]
>
> （译文：赌博不是天生让人上瘾。赌博成瘾显著少于酒精成瘾，对没有成瘾倾向的人它并不具备天生让人上瘾的属性（不像毒品，对所有人都是天生让人上瘾）。部分老虎机/赌博游戏是为问题赌徒设计的，但 DK 不设计自己游戏，州监管机构已经控制游戏设计的某些方面。）

skippyboxedhero 在另一条评论里把 **VIP 制度**当作反驳 EFF 论点的核心证据——

> "Again, the same mistake.<p>Yes, it happens to every gambler who spends a lot of money. That is how VIP tiers are defined, based on how much you spend. There is no way for them (or anyone) to understand the customer's state of mind. Should it be illegal for retailers to offer customers discounts? Compulsive shopping is significantly more common than gambling addiction, do retailers target those customers?" — skippyboxedhero [c:49897048]
>
> （译文：又搞错了。是的，每个花很多钱的赌徒都会升 VIP。VIP 是按花多少钱定义的，没人能（也没有已知借口能）了解客户的心理状态。给客户打折要不要也违法？强迫性购物比赌博成瘾更常见，零售商是不是在针对他们？）

这场辩论的真正分歧不在事实，而在**因果归责**——赌徒成瘾是**产品制造**的还是**个人倾向**？EFF 整篇文章建立在"产品制造"的一侧，skippyboxedhero 站在"个人倾向"的一侧。两边的论据都是各自立场内部自洽的，但任何一方都没能让另一方改口。

### MA 求助热线翻倍：可量化的代价

skippyboxedhero 那条"应该让零售商也禁止给强迫性购物者打折吗"的反驳，被 SaucyWrong 用马萨诸塞州的数据反打——

> "In my state (Massachusetts), the number of people who call in to the state's gambling problem hotline doubled after online sports books became legalized. That is, by definition, a negative effect on the public good. The net number of people seeking help for gambling problems increased by 100%." — SaucyWrong [c:49898323]
>
> （译文：在我们州（MA），在线体育博彩合法化之后，州赌博求助热线的来电量翻了一倍。**按定义，这是对公共利益的负面效应**。寻求赌博问题帮助的人数净增 100%。）

pbronez 试图给反对者留一条退路——

> "It’s definitely bad that twice as many people have a gambling problem. However to assess the NET impact you also have to count how much value/fun/whatever the non-problem-gamblers are having, plus whatever tax revenues you get, increased economic activity from more attention on sports, etc." — pbronez [c:49898622]
>
> （译文：人数翻倍确实不好。但要算**净**影响，还得算非问题赌徒获得的价值/乐趣，加上税收、体育关注带来的经济收益。）

但 vintermann 把这条线换了一个角度反驳——

> "I think an important question to ask is: how much of a company's income comes from harmful use? Gambling (and some other industries, in particular alcohol) come out so bad on this metric, you can practically let the industry define excessive use themselves. In order to claim most of their money comes from 'healthy normal entertainment use' or similar, they'd have to claim absurd things, such as that drinking a bottle of whisky per day or spending your entire paycheck each month on slots can be healthy, normal use." — vintermann [c:49899169]
>
> （译文：真正该问的问题是：公司收入里有多大比例来自"有害使用"？赌博（还有酒）这个指标特别难看，可以基本让行业自己定义"过度使用"。如果它们要声称大部分收入来自"健康正常使用"，那就得主张每天一瓶威士忌或每月把工资都扔进老虎机也算"健康"。）

这条线把辩论从"个人倾向 vs 产品制造"拉回**收入结构**——EFF 文章里那句"留住输钱的客户，因为这些客户才是真正给公司贡献收入的人"，正是 vintermann 这条"行业统计"的工程版。MA 求助热线翻倍只是冰山一角，更深的数字藏在 DraftKings 的财报里——只是它不会主动披露。

### 赢钱的人反而被影子封禁：AlexandrB 的杀手级证据

EFF 文章主要谈**怎么识别输钱的赌徒**，但 AlexandrB 用 The Guardian 2022 调查给这场讨论加了另一层——**DraftKings 同时在识别赢钱的客户，并悄悄调低他们的赔率**。

> "My problem with sports gambling is that all these companies are lying. If you win a lot you get (the gambling equivalent of) shadow banned. The provider pretends they're providing a game where you can 'win big' and it's all up to your knowledge of sports, but the reality is that it's a skewed playing field where you can either lose or lose more." — AlexandrB [c:49899026]
>
> （译文：体育博彩让我不舒服的是这些公司都在说谎。赢多了就会被（赌博版的）影子封禁。平台假装这是个"你能赢大钱"的游戏，全靠你对体育的了解，但现实是个倾斜的牌桌，要么输，要么输更多。）

把这条线和 EFF 文章放在一起，HN 读者的结论就清楚了——**DraftKings 的 ML 不是单向的**：一头用 ML 找输钱的赌徒拉回来，另一头用 ML 找赢钱的客户调赔率。两边都是 ML，但方向相反。把"AI 撞到天花板了吗"那条辩论的数字借过来，**DraftKings 的 AI 在两件事上同时没有撞到天花板**。

### 行业道德 vs 监管：HN 上反复拉锯的老辩论

辩完"按 H"和"按 P"两件事后，评论区反复回到一个**更老**的问题——**行业道德是不是一种有效期望**。

groestl 把立场摆明——

> "IMHO one shouldn't expect a company to have any ethics to achieve a positive outcome for society. This needs to be baked into the rules (taxes, regulation, ...), so the ethical behavior becomes the rational behavior." — groestl [c:49897034]
>
> （译文：恕我直言，不能指望公司有任何道德来实现对社会的正向结果。这要写进规则（税收、监管……），让道德行为变成理性行为。）

反驳来自 Barrin92——

> "companies are a fiction made out of people, they don't have anything, and regardless what the rules are I expect those people to behave ethically at any given time. I'm not entirely sure when people started to have this idea that when they walk through a company door, as if this is some magical portal into the realm of amorality, give up their human responsibilities and faculties." — Barrin92 [c:49897164]
>
> （译文：公司是人的虚构，没有自己的器官，无论规则怎么写，我期望这些人在任何时候都按道德行事。我搞不懂从什么时候起，大家觉得走过公司大门就像进入了不道德的魔法王国，把人的责任和能力都交了出去。）

跟帖 Henchman21 把这条线拉到 1970 年代——

> "It started with Milton Friedman and the idea that The Social Responsibility of Business is to Increase its Profits -- full stop, nothing else. ... Now we have people so confused by this and so in need of viewing themselves as 'temporary poor' that they vote against their own interests on a regular basis. Fortunately, the changing climate will wipe us out. :)" — Henchman21 [c:49897959]
>
> （译文：这事得从米尔顿·弗里德曼讲起，把"公司的社会责任就是增加利润"立成铁律——别的都不算。……现在大家被这套话术洗得太彻底，又急着把自己看成"暂时的穷人"，结果经常投票反对自己的利益。所幸气候变化会把我们都抹掉 :)）

这条线把 EFF 文章从"产品揭露"拉到了**资本主义伦理史**层面——但 HN 上大部分读者对此没有共识：groestl 一派认为"监管优先于道德"，Barrin92 一派认为"个人道德优先于制度设计"，两边的分歧不在 DraftKings 这家公司，而在**公司和道德的本体论关系**。

### 预测市场也跟着变烂：EFF 没写但 HN 看见

EFF 文章没有提到预测市场，但 Meowface 把这场讨论**外推到 Kalshi / Polymarket**——

> "Prediction markets seemed like a possible exception to the rule that anything to do with betting is always a scourge on the commons, but those companies quickly realized sports gambling is the best way to rake in cash, so they all converge on it. I am one of the very few people in the United States who actually does still earnestly believe prediction markets do in principle serve an immense social good that can't be provided in any other way." — Meowface [c:49898345]
>
> （译文：预测市场原本可能是规则里的例外——所有赌博似乎都是公地的祸害，但预测市场没动。结果这些公司很快意识到体育博彩是来钱最快的路子，全都往那边收拢。我是美国极少数还真心相信预测市场**原则上**能提供无可替代的社会价值的人。）

lovich 把这条线往怀疑论方向推——

> "An idealized prediction market could be a social good the same way a frictionless spherical cow is good for making my physics homework easier. There is no way to remove the incentive for people with the ability to alter the events being bet on. Insider trading is generally considered a bad thing for the stock market because of the non symmetrical information for everyone trading but all of sudden in the past few years a cohort of people(rationalists) have found it virtuous." — lovich [c:49898571]
>
> （译文：理想化的预测市场可以是社会善行，就像无摩擦球形奶牛能让我物理作业变简单一样。无法消除**拥有能改写被下注事件本身的人**的动机。股票市场的内幕交易一般被认为不好，因为信息不对称——结果过去几年忽然有一群人（理性主义者）把它当成美德。）

Meowface 又把战线拉回到 EFF 的核心问题——预测市场现在的危害已经超过它的好处——

> "It just happens to almost always be the case that the bad greatly outweighs the good, and it usually just leads to things like brazen war profiteering (+ plan-leaking that jeopardizes operations, in the event the military operations were perhaps for a morally net good cause)." — Meowface [c:49899304]
>
> （译文：结果几乎总是坏远超好，常常就是赤裸裸的战争牟利（+ 泄露作战计划，危及那些本来在道德净意义上好的军事行动）。）

EFF 文章的真正外延不在 DraftKings，而在**所有"靠数据预测人类行为"的金融化产品**——行为广告的激励结构一旦被接受，预测市场、AI 招聘评分、AI 健康评分都会走同一条路。Meowface 这条线把 EFF 的论点从"一家公司"拉到了**整个行业范式**。

### 赌博合法化的反讽：执法机构也在用广告数据

EFF 文章最后一段点出一个**反讽**——ICE 早些时候的 Request for Information 实质上是想**用广告科技公司的数据做调查**。HN 上没人直接展开这条线，但把它放回"行业激励"的层面，含义是：**被训练来识别赌徒的模型，可以被执法机构直接调用**。

Autoexec 的评论在另一条线里间接点到了这一点——

> "I'd be happy if we focused on restricting the most harmful actions of the companies who profit from the people they turned into addicts. No more online sports betting. No more adverting for gambling. No more targeting children with gambling in video games that accept real money for anything. No more using AI or surveillance to detect and target addicts." — autoexec [c:49898352]
>
> （译文：如果监管真的够了，我愿意看到限制从这些公司最有害的行为入手——禁掉在线体育博彩、禁掉赌博广告、禁掉用真钱在电子游戏里针对儿童的赌博、禁掉用 AI 或监控识别并定位成瘾者。）

autoexec 把"识别赌徒"和"识别成瘾者"和"识别移民"放到同一个列表里——这正是 EFF 文章 ICE 那段没明说的扩展：**这套 ML 模型的真正客户不是赌博公司，是任何需要"识别特定人群"的组织**。DraftKings 训练出来的"问题赌徒识别器"和 ICE 想买的"移民识别器"，技术栈几乎完全相同。

### 监管够不够：EFF 的答案是直接禁掉行为广告

EFF 在文章里给出**一个具体政策建议**——**直接禁止行为广告**本身，不止是限制第三方数据分享。

qurren 把这条线和"行业里的其他产品"连起来——

> "I feel like a much larger fraction of the economy is predatory than is made out to be in these gambling discourses. Examples: FSA plans are designed to get you to gamble on how much medical expenses you will have; Extended warranty plans are baiting you to pay for something you are statistically unlikely to need; Insurances but co-insurances, deductibles, clauses; Trip protection." — qurren [c:49898509]
>
> （译文：我觉得比这些赌博讨论里体现出来的更大一部分经济都是掠夺性的。比如 FSA 医疗储蓄账户就是在赌你的医疗花费；延长保修就是引诱你买大概率不需要的；保险"共保、免赔、条款"组合也是；旅行保险也是。）

跟帖 satyrnein 重新定义了"保险"和"赌博"的边界——

> "In theory, insurance is the polar opposite of gambling. It's supposed to be reducing your risk, while gambling increases it. Like 'do you want to gamble on that TV lasting, or do you want to buy the extended warranty?' But in practice, the pricing is so terrible that it's not worth it." — satyrnein [c:49899352]
>
> （译文：理论上，保险是赌博的反面——降低风险，而赌博理论上增多增加风险。像"你是赌电视能用多久，还是买延长保修？"但实际操作里，定价差到不值得买。）

这条线把 EFF 的论点从"赌博行业"扩展到**整个"概率即商品"的经济**。DraftKings 用 ML 识别赌徒，FSA 用 IRS 规则逼你赌自己的医疗支出，延长保修用统计概率赌你会需要维修——**当概率被金融化、被 ML 优化、被广告精准投放，EFF 说的"行为广告的激励问题"就不再是赌博行业问题，是整个数据资本主义的问题**。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| ProPublica 一年前已经讲过 | tedivm [c:49896224] | "这家公司从上到下毫无道德底线。" |
| 赌博天生让人上瘾 | garbageman [c:49897188] | "多巴胺循环和耐受性都在发生。" |
| 严重成瘾的危害和毒品相当 | cynicalkane [c:49897981] | "倾家荡产、失去所爱、心理再也回不来。" |
| 赌博不是天生让人上瘾 | skippyboxedhero [c:49896998] | "强迫性购物更常见，零售商是不是也在针对他们？" |
| MA 求助热线翻倍 | SaucyWrong [c:49898323] | "按定义这是对公共利益的负面效应。" |
| 算净影响不能只看受害者 | pbronez [c:49898622] | "还要算非问题赌徒获得的价值/乐趣。" |
| 问公司收入结构 | vintermann [c:49899169] | "他们要主张每天一瓶威士忌也算'健康'吗？" |
| 赢钱的人被影子封禁 | AlexandrB [c:49899026] | "平台假装你能赢大钱。" |
| 公司道德不可指望 | groestl [c:49897034] | "道德行为要变成理性行为。" |
| 个人道德优先 | Barrin92 [c:49897164] | "走过公司大门不是进入不道德的魔法王国。" |
| 责任始于弗里德曼 | Henchman21 [c:49897959] | "公司的社会责任就是增加利润——别的都不算。" |
| 预测市场都向体育博彩收拢 | Meowface [c:49898345] | "我仍相信它**原则上**是社会价值。" |
| 预测市场是无摩擦球形奶牛 | lovich [c:49898571] | "内幕交易忽然变美德。" |
| 预测市场的坏远超好 | Meowface [c:49899304] | "赤裸裸的战争牟利、泄露作战计划。" |
| 监管要禁最有害的具体行为 | autoexec [c:49898352] | "禁掉识别并定位成瘾者的 AI。" |
| 整个经济都有掠夺性 | qurren [c:49898509] | "FSA、保修、保险条款都是概率赌。" |
| 保险和赌博是反面 | satyrnein [c:49899352] | "理论上保险降低风险，赌博增加风险。" |
| 行业从来不会主动"因为不道德所以不做" | gigatree [c:49896630] | "从来没见过董事会说"因为不道德所以不做"。 |
| 提建议时用统计替代群体 | hnlmorg [c:49896882] | "没人真对现实失明，但统计学让人方便非人化。" |
| 美国人投票反对自己利益 | Henchman21 [c:49897959] | "把自己当'暂时的穷人'。" |

## 总体情绪

整场讨论的真正主角不是 **DraftKings**，而是 EFF 文章里那段不显眼的话——**"行为广告的激励结构"**。HN 读者从 DraftKings 的 ML 模型出发，把战线拉到三个完全不同的方向：

第一，这场讨论反复回到的根本问题是"赌博到底是不是天生让人上瘾"——garbageman 一派说"是"，skippyboxedhero 一派说"不是"，EFF 文章建立在"前者是过去时、后者是激励使然"。MA 心理求助热线翻倍是这场讨论里唯一一组**硬数据**——其他都是因果叙事。HN 没有靠这组数据说服任何人，它提供了**政策必要性**的基础。

第二，HN 几乎所有读者都同意 ML 在 DraftKings 内部至少有两件事：识别输钱的赌徒拉回来，识别赢钱的客户调赔率。AlexandrB 的"影子封禁"是这场讨论里最有杀伤力的事实——它意味着 DraftKings 的 AI 不是单边"找目标"，而是双向**"优化公司赔率"**。当一家公司能用 ML 把赔率向对自己有利的方向调整，再用 ML 把会输的客户拉回来，所谓"AI 让赌博更精准"在 HN 读者眼里就变成了**"AI 让赌博变成单向倾倒"**。

第三，HN 这次讨论的最深一层出现在 Meowface / lovich / satyrnein 三条线上——**EFF 文章的论点不限于赌博行业**。DraftKings 用 ML 优化的是一档赌徒；Kalshi 用 ML 优化的是一档预测市场玩家；FSA 用 ML 优化的是一档医疗支出赌注；延长保修用 ML 优化的是一档维修概率赌注。当所有这些产品**都用同一套激励结构**——用 ML 优化概率分布、向高消费人群精准投放——EFF 提出的"禁掉行为广告"就不仅是赌博政策，是数据资本主义政策**。

最后一条不那么讨喜感的解读来自 Henchman21：HN 上"享受游戏是为了放松"的辩护者和自动嵌入的"AI 优化赔率"的产品经理，距离只有一扇公司大门。Henchman21 把这场讨论的政治经济学拉到 1970 年代的弗里德曼命题——**公司的社会责任就是增加利润**——然后由 Donaldshimoda 把它收回到具体的监管设计：要么你写规则让道德变理性（groestl 一派），要么你期待走过公司大门的人满足伦理（Barrin92 一派），要么你承认这一切都是资本主义异化的必然产物（jmyeet 一派）。三种立场没有共识，但 HN 这次讨论的真正进展是把这三件事**放到了同一段对话里**。

讽刺之处在于：EFF 这篇文章发布当天，正值另一条新闻——MA 求助热线翻倍。EFF 没提这条新闻，但 HN 读者几乎所有人都引用了它。两组事实并排放——DraftKings 的 ML 主动找出最可能输钱的客户 vs MA 求助热线来电量翻倍——**前者是 EFF 想让读者知道的事，后者是它不需要让读者知道的事**。把这两组事实并排放，HN 这次讨论的最终隐喻是：**监管机构能从热线的 100% 翻倍看到"据情况加剧"，DraftKings 从 ML 模型里只能看到"成功留存高价值客户"——两家看的是同一组人，但只有前者叫它"危害"。**

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | DraftKings Is Using AI to Behaviorally Target Chronic Gamblers | https://news.ycombinator.com/item?id=49896050 |

<div class="disclaimer">

本摘要由 AI 模型辅助生成，仅供了解 HN 讨论脉络之用，文中观点不代表本站立场。引文均为 HN 用户公开发表的评论，按 Creative Commons CC-BY 引用；译文仅供参考，可能与原文语气有出入。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>