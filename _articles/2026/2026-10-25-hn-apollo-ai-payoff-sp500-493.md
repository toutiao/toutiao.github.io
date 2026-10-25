---
layout: post
title: >-
  Apollo 说 AI 只在科技行业赚钱，513 条评论说账记错了地方 — HN 讨论摘要
date: 2026-10-25
hn_id: 50224463
categories: [articles]
excerpt: >-
  Mag 7 的每工营收和利润率在往上走，标普其余 493 家是平的，总要素生产率也看不到 AI 的痕迹。
  Apollo 首席经济学家 Torsten Slok 的判断是：token 支出正在从增长项变成拖住利润率的成本中心。
  503 分、513 条评论，评论区分成三派：统计滞后、账记错地方、推理这门生意不赚钱。
tagline: >-
  AI 要不要改变世界不重要，重要的是数据中心能不能自己回本。
---

## 原文概要

10 月 24 日，美国资管公司 Apollo Global Management（NYSE: APO）的首席经济学家 Torsten Slok 在他们的每日专栏 The Daily Spark 上发了一篇短文，标题就叫「No Signs of AI Payoff Outside the Tech Sector」。正文不长，五张图加几段话，结论落在一个数字上：S&P 493，也就是标普 500 里除去那 7 家之外的其余 493 家。

论证分三层。第一层是每工营收：Mag 7 在涨，S&P 493 是平的。第二层是利润率：Mag 7 在涨，S&P 493 也是平的。第三层落到宏观账上：总要素生产率（TFP，用旧金山联储 Fernand 2014 的 utilization-adjusted 序列，剔除周期波动，统一折算到 2019 年四季度）里，找不到 AI 推高生产率增长的痕迹。

解释部分更直接。文章说，企业已经开始把 token 支出当成成本中心，而不是增长来源：VC 支撑的公司在 token 上越花越多，主流企业既不需要最新模型，也不愿意为此付钱。只要 agentic AI 和 token 支出局限在经济体的一小块地方，AI 的宏观效果就会非常有限。第四、第五张图引的是 Ramp AI Index 和 Ramp 首席经济学家 Ara Kharazian 的分析：token 支出高度集中在少数公司身上，支出本身还带着循环性。

最后两句最锋利。Slok 说，AI 可能是一台很棒的计算器，但在商业里 intelligence 主要是 judgment——判断依赖上下文，换个人问、换个模型问，答案就不同。更要紧的是，AI 不理解问责、信任、文化、潜规则、伦理取舍和公平，而这些恰恰决定声誉风险，最终决定营收和利润率。他把话挑明：AI 这个故事要由 S&P 493 来决定，不是 Mag 7；迄今为止，科技行业之外看不到营收增长或利润率改善的证据。

HN 上这条帖是 10 月 24 日 19:47 UTC 由 the-mitr 转贴的，503 分、513 条评论，现在挂在 HN 热门榜（/best）上。

## 讨论焦点

### 一、口径之争：利润率到底能不能测出 AI

文章一上来就拿利润率当证据，评论区第一个问题就是口径。password54321 干脆说这文章不值得看：

> "You can't measure impact by profit alone so I don't find the article particularly interesting anyway." — password54321 [c:50225065]
> （译文：你不能只靠利润来衡量影响，所以我并不觉得这篇文章有多有意思。）

真正在岗的人问得更具体：

> "Maybe, even likely. But how do you observe this? We are in this situation at work, it feels like \"sure AI is helpful\" but do we actually deliver any faster?" — kaffekaka [c:50225432]
> （译文：也许吧，很可能。但这个该怎么观察？我们工作里就是这种情况，感觉「AI 确实有用」，可我们到底有没有更快交付？）

drivebyhooting 认为文章把太多变量搅在了一起：

> "End of ZIRP, tax law changes, post-COVID inflation, and general economic malaise from federal mismanagement." — drivebyhooting [c:50224643]
> （译文：零利率时代结束、税法变动、疫情后的通胀，再加上联邦治理不善带来的整体经济萎靡。）

> "There are too many confounders." — drivebyhooting [c:50224643]
> （译文：混杂因素太多了。）

而 jeremyjh 这句话被反复贴出来：

> "I would also fire someone who doesn’t know the difference between revenue and profit." — jeremyjh [c:50226721]
> （译文：我还会把分不清营收和利润的人直接开掉。）

### 二、1987 年的计算机：老论证的新版本

评论区最多人引的是那句 1987 年的老话。jstanley 只留了一句：

> "You can see the computer age everywhere but in the productivity statistics." — jstanley [c:50224611]
> （译文：计算机时代到处都能看见，就是不在生产率统计里。——1987 年）

oa335 补上出处和机制：

> "It took decades for effects of personal computing to show up in aggregate statistics." — oa335 [c:50224652]
> （译文：个人计算机的效应花了几十年才出现在总量统计里。）

真正把这个论证讲清楚的是 jmalicki：

> "That's one of the \"everywheres\" the author of the statement was talking about, which is the point - you could see every part of the economy seemingly improved, but it did not show up at the macroeconomic measurement level." — jmalicki [c:50225416]
> （译文：这正是那位作者所说的「到处」之一，问题就在这儿——你可能看到经济的每个部分都变好了，但它没有出现在宏观的测量层面上。）

这一派的核心主张是：宏观统计天然滞后，所以「现在还没看到」不能证明「没有」。

但也有人指出，这个类比本身有历史问题。drivebyhooting 顺手把同一套逻辑翻过来用在科技行业自己身上：

> "Manufacturing, basic science, education, etc languished while Big Tech reaped record profits and achieved stock heights for the last 15 years." — drivebyhooting [c:50224578]
> （译文：过去 15 年，制造业、基础科学、教育都在原地打转，而大科技公司收割创纪录的利润、股价涨到天上。）

### 三、「再等等」这套话，已经用了两年

反方最有力的一条，是 besterman23 说的：把 AI 一律推到未来，等于提前免掉所有当下的批评。

> "It always paints AI as this “in the future” thing which absolves any current criticisms or observations." — besterman23 [c:50225547]
> （译文：这种说法总是把 AI 描绘成「在未来」的东西，好让当下所有的批评和观察都被免掉。）

> "Which is why I say comparing it to personal computers in 1987 is not an apt comparison." — besterman23 [c:50225547]
> （译文：所以我说，拿它和 1987 年的个人计算机相比并不贴切。）

理由是成本结构完全不同：

> "The first requires a fundamental shift in not only how you work but expensive and complex infrastructure changes from the company itself just to make it possible" — besterman23 [c:50224887]
> （译文：第一种做法不只需要你改变工作方式，还需要公司自己投入昂贵而复杂的基础设施改造，才有可能做成。）

asadotzler 则把「还早」的论调翻了个底朝天：

> "Seven years ago (*!!SEVEN!!*) GPT was too dangerous to release and yet everything that AI has touched since then is WORSE now than it was then." — asadotzler [c:50224867]
> （译文：七年前（七个！！）GPT 还「太危险、不能放出来」，而这之后 AI 碰过的一切，现在都比那时更糟。）

IshKebab 的回复很短，是这套「先别下结论」逻辑的最好反打：

> "People being premature before does not mean they are premature now." — IshKebab [c:50225694]
> （译文：人们以前提前看空，并不等于他们现在也提前看空。）

### 四、开发者自己算的那本账

如果只看宏观表，AI 好像什么也没留下。但评论区里做开发的人给的是另一本账，而且他们并不觉得 AI 没用。

jerf 的描述最具体：

> "Even as it has rewritten the minute-by-minute process of doing my job entirely, it hasn't actually changed my job all that much at the higher level and it's hard to assign much more than a 2x or a 2.5x overall improvement to it once I account for all the Amdahl's Law issues that come up from the parts that have not been so amenable to acceleration." — jerf [c:50224741]
> （译文：即便它彻底改写了我做这件事的每一分钟流程，从更高一层看，它并没有真正改变我的工作是什么；把那些不容易被加速的部分按 Amdahl 定律算进来之后，很难给它超过 2 倍或 2.5 倍的整体提升。）

tempest_ 说的是哪一块真的被吃掉了：

> "Most developers don't work building low level high performance scalable systems for a large tech firms, they are making CRUD back-ends for phone apps." — tempest_ [c:50224732]
> （译文：大多数开发者做的不是大厂那种底层、高性能、可扩展的系统，而是手机 App 的 CRUD 后端。）

> "Dev tooling companies are disappearing or being \"bought\" all over the place because what might have been a product before is now an hour or two with someone with CC." — tempest_ [c:50224732]
> （译文：开发工具公司正在到处消失或者被收购，因为以前可能要做一个产品的东西，现在跟一个拿着 Claude Code 的人聊上一两个小时就有了。）

Barrin92 立刻泼冷水，说的是软件质量这笔账：

> "I'd be careful to equate churning out lines of code with the health of a piece of software down the road, even a relatively straight forward one." — Barrin92 [c:50225227]
> （译文：把「堆代码行数」等同于「一个软件往后还健康」，这件事要小心，哪怕它是个相对简单的软件。）

真正让文章和现实对上的，是 repeekad 讲的那家工厂：

> "I know of a brake parts factory outside dayton ohio who had the Microsoft folks come through with promises well over a year ago now. They've already overspent and had to pull back their AI budgets when it made more work than it solved." — repeekad [c:50224641]
> （译文：我知道俄亥俄州代顿郊外有家做刹车零件的工厂，一年多前微软的人就带着各种承诺上门了。他们已经超支，只能把 AI 预算收回来——因为 AI 带来的活儿比它解决的还多。）

这就是文章里「token 支出变成成本中心」那句的一个具体版本。

### 五、token 单价、推理经济，和谁在补贴谁

最硬的一组讨论围绕钱：AI 到底要花多少钱才划算，以及模型厂商到底赚不赚钱。

computomatic 先报了自己的账：

> "I don’t know about you, but for me materially useful AI costs around $10,000/mo in tokens. But it is very useful." — computomatic [c:50224969]
> （译文：不知道你怎样，对我来说，真正有用的 AI 每月在 token 上要花掉大约一万美元。但它确实非常有用。）

> "Anyone selling the system off the shelf is going to be charging API rates. Computers were cheap in comparison." — computomatic [c:50224969]
> （译文：任何把这套系统当现成产品卖出去的人，收的都是 API 的价。相比之下计算机便宜多了。）

同一段话里还藏着一个关键限制：这种用法要求你自带专业能力去围绕模型搭整套系统，还得接受额度用尽时会卡住。

接下来是 Anthropic 那笔著名的亏损账。CuriouslyC 讲的是调整前与调整后的区别：

> "Serving inference is profitable, but serving inference for the last released model doesn't cover the cost of the model in training." — CuriouslyC [c:50225642]
> （译文：做推理是赚钱的，但为最新发布的那个模型做推理，覆盖不了这个模型的训练成本。）

doctorpangloss 把这笔账往 AWS 那头推了一步：

> "what do you think the cost is for AWS to serve inference it sells to Anthropic for \"$1.00\"? I think it's about $0.11." — doctorpangloss [c:50225859]
> （译文：你觉得 AWS 卖推理给 Anthropic 收 1 美元一份，成本是多少？我猜大概 11 美分。）

同一个讨论里还有另一个极端的声音——花得少，用得狠：

> "Holy shit. I’m spending 2 orders of magnitude less per month and still getting good value. But, I’m not an AI maximalist." — datsci_est_2015 [c:50225990]
> （译文：我去，每月少花两个数量级，还是觉得值。但我不是 AI 极端分子。）

> "If it costs 2x-3x the median household income to be an AI maximalist that definitely puts some comments on this forum into context." — datsci_est_2015 [c:50225990]
> （译文：如果当一个 AI 极端分子要花掉中位家庭收入的两到三倍，那这个论坛里的很多评论确实要放在这个背景下看。）

FeepingCreature 给出的是最乐观的那一端：

> "An industry cannot fail because it's too successful." — FeepingCreature [c:50226101]
> （译文：一个行业不会因为太成功而失败。）

### 六、门槛有多高：比所有旧软件加起来还高

如果数据中心这块投资规模这么大，AI 需要改变世界到什么程度才划得来？aDyslecticCrow 把它写成了一张清单：

> "Cause at the current rate and scope of data center investments; they have to transform the world more than... every other software system we've come up with until this points combined; to justify their cost." — aDyslecticCrow [c:50225664]
> （译文：按当前数据中心投资的规模和速率，要证明这些成本是合理的，AI 得让世界改变的程度超过……我们到目前为止发明过的所有其他软件系统的总和。）

但也有评论指出，讨论「AI 有没有用」时大家其实一直在说 LLM，而 AI 早就在别的地方跑着了。nico 举的例子不抽象：

> "Waymo is AI, I personally would happily ride one, or a Zoox. Those are quite real tasks the AIs are performing, people put their lives on the hands of these AIs" — nico [c:50225715]
> （译文：Waymo 就是 AI，我个人很愿意去坐，Zoox 也一样。这些是 AI 在干的实打实的任务，人们把命交在这些 AI 手上。）

> "So inadvertently, and without much choice either, you probably already rely and depend on AI on your everyday life" — nico [c:50225715]
> （译文：所以，不知不觉间，你多半已经在日常生活里依赖上 AI 了，而且没什么选择余地。）

泡沫的说法也在同一节里出现了，两句都很短：

> "That's a Ponzi scheme." — SpaceNoodled [c:50226624]
> （译文：那就是个庞氏骗局。）

> "Dotcom bust - 2000" — bagacrap [c:50226666]
> （译文：互联网泡沫——2000 年。）

唯一一条旁证来自评论区开头，被置顶式地贴了出来：

> "Only 13% of companies see real returns from AI, survey finds" — toomuchtodo [c:50224491]
> （译文：调查发现，只有 13% 的公司从 AI 上看到了真实回报。）

toomuchtodo 把它链接到了另一条 HN 讨论（item?id=50207881），原文是 Gartner 10 月 19 日的新闻稿：只有 13% 的 CIO 说他们所在企业已经从 AI 上拿到了显著或转型级的价值。FrustratedMonky 立刻指出了这个数字的漏洞：

> "13% of all companies, or only those that invested in AI. And if invested, by how much?" — FrustratedMonky [c:50224559]
> （译文：是全部公司里的 13%，还是只算投了 AI 的公司？如果投了，投了多少？）

### 七、两种赌法

讨论收尾时，分成了两拨对未来下注的人。

一拨认为会很快。password54321 的反驳对象是那句「慢慢来，要 20 年」：

> "Yeah, it is not going to be slow. Progress compounds, everything is being built on top of fast computers and fast widespread internet connection." — password54321 [c:50224952]
> （译文：不会慢的。进步会复利，一切都是建在快得多的计算机和普及的互联网连接之上。）

另一拨赌的是形态，不是速度。ben_w 的说法：

> "I expect to be surprised by specific headlines, but I don't expect \"software engineer\" to be any more common a job opening than \"steam locomotive engineer\" in 10 years time." — ben_w [c:50225145]
> （译文：我预期会被具体的新闻标题惊到，但我不觉得十年之后「软件工程师」这个岗位会比「蒸汽机车司机」更常见。）

有人对这种乐观本身感到疲惫：

> "In a way it’s sad that AI came in the age where a lot of us are jaded because the internet which we built has become a place for gambling and scamming." — yoz-y [c:50225706]
> （译文：从某种意义上说挺可悲的，AI 降临在一个我们已经厌倦的时代——我们亲手造的互联网变成了赌博和诈骗的地方。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 利润不是衡量 AI 的正确尺子 | password54321 | 不能只靠利润衡量影响 |
| 感觉有用不等于交付更快 | kaffekaka | 「AI 确实有用」，可我们真的更快了吗 |
| 混杂因素太多 | drivebyhooting | 零利率结束、税法变动、通胀、治理不善 |
| 营收和利润不是一回事 | jeremyjh | 分不清这两者的人该开掉 |
| 1987 年的老论证 | jstanley | 计算机时代到处可见，就是不在生产率统计里 |
| 滞后要几十年才显现 | oa335 | 个人计算机的效应花了几十年才进总量 |
| GDP 层面才作数，不看行业体感 | jmalicki | 每个行业都变好了，但宏观测量层看不到 |
| 类比太贵 | besterman23 | 1987 年用上 AI 比用上个人计算机容易得多 |
| 「推到未来」等于免掉批评 | besterman23 | 这种说法让当下所有观察都失效 |
| 七年不是三个月 | asadotzler | 七年前 GPT 还「太危险不能放」 |
| 过去提前看空，不等于现在也该 | IshKebab | 提前预测失败过，不代表这次还早 |
| AI 对工程师是真的有用 | jerf | 流程被改写，但整体上限大概 2 到 2.5 倍 |
| CRUD 后端在被压缩 | tempest_ | 过去要一个产品的东西，现在一两小时就有 |
| 代码变多不等于软件变好 | Barrin92 | 拿代码行数换软件健康度，这账迟早要还 |
| 企业已经在砍 AI 预算 | repeekad | 代顿郊外的刹车零件厂，把 AI 预算收了回来 |
| 有用的 AI 每月烧一万美元 token | computomatic | 真正有用的 AI 每月 token 成本约一万美元 |
| 推理能赚钱，训练不能 | CuriouslyC | 单个模型可盈利，公司整体仍在亏损 |
| AWS 补贴了推理的价差 | doctorpangloss | 卖 1 美元的推理，成本大概 11 美分 |
| 花得少也能有值 | datsci_est_2015 | 每月少花两个数量级，依然觉得值 |
| 门槛是所有旧软件加起来 | aDyslecticCrow | 数据中心投资要求 AI 改变得比旧软件总和还多 |
| AI 早就在你生活里 | nico | Waymo、搜索、导航、图像识别早就在跑 |
| 这就是庞氏骗局 | SpaceNoodled | That's a Ponzi scheme |
| 泡沫还有空间 | bagacrap | 2000 年的互联网泡沫，还有得涨 |

## 总体情绪

这场讨论的形状很特别：贴的是一篇财经专栏，评论区却打成了一场关于「统计口径」的争吵。Slok 的图很难反驳，Mag 7 的每工营收和利润率在涨、其余 493 家平的、TFP 里没有 AI 的痕迹——但他的结论同样难成立，因为一篇讲生产率的文章，最后落到的是利润率，而利润率里混着定价、供应链、汇率和 ZIRP 的尾巴。真正卡住所有人的，是那句没有被回答的问题：感觉「AI 确实有用」和交付周期真的缩短了，中间到底隔着几步。

另一条线更实际，也更有火药味：谁在为 AI 付钱。文章说 token 支出变成了成本中心，评论区立刻有人掏出自己的月度 token 账单，有人拆 Anthropic 的训练与推理口径，有人直接甩出「那就是个庞氏骗局」。在这些账里，Slok 那个「AI 是一台很棒的计算器，但商业里主要是判断力」的说法反而显得温和——判断力没法自动化，于是也就没法省下这笔钱。

情绪的重心在两难之间：大部分人并不否认 AI 有用，好几个评论者正是在用它写代码；他们否认的是这张表能解释一切。而少数人（大多是做基础模型或基础设施的）则指出，AI 已经在别处产生价值了，只是那些价值不出现在标普 493 的利润率里，就像当年计算机的价值先出现在页数上、表现在 GDP 上已经是 2000 年代的事。

Slok 的图和工程师的账其实并不矛盾：普通公司的利润率确实没动，工程师也确实少写了大量代码。只是这两件事中间还隔着迁移、培训、监管和回本周期。现在没有任何一张表能同时装下它们——所以这场争论从开始到收盘，谁也没说服谁。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | No Signs of AI Payoff Outside the Tech Sector（The Daily Spark，2026-10-24） | https://www.apollo.com/wealth/insights-news/insights/daily-spark/no-signs-of-ai-payoff-outside-the-tech-sector |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50224463 |
| 3 | Gartner 调查新闻稿：只有 13% 的 CIO 说企业已从 AI 拿到显著价值（评论区相关帖引用） | https://www.gartner.com/en/newsroom/press-releases/2026-10-19-gartner-survey-finds-only-13-percent-of-cios-say-their-enterprise-has-realized-significant-or-transformational-value-from-ai |
| 4 | HN 相关讨论：Only 13% of companies see real returns from AI, survey finds | https://news.ycombinator.com/item?id=50207881 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
