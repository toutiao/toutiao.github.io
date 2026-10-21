---
layout: post
title: >-
  DeepSeek 开源 DeepInfer：每卡每小时 38 美元，评论区吵的是这门生意能不能一直赚 — HN 热门讨论
date: 2026-10-21
hn_id: '50163277'
categories: [articles]
excerpt: >-
  DeepSeek 把支撑自家 V4.1 Flash 线上推理的框架放了出来，Apache 2.0。真正引爆讨论的不是并行策略和算子清单，而是评论区贴出的两个数字：单集群每天 155 万亿 token，每张卡每小时收入 38 美元。
tagline: >-
  开源框架只是引子，评论区真正在算的账是：一张卡跑一小时，到底能赚回多少折旧。
---

### 原文概要

DeepSeek 在 GitHub 上放出 **DeepInfer**，自我定位是「驱动 DeepSeek 大规模生产服务的高性能推理框架」，这次开放的是离线推理部分，目前**只支持 DeepSeek-V4.1-Flash** 一款模型。许可证是 Apache 2.0，README 里也写清楚了出身：主要构建在 vLLM 之上，另外参考了 SGLang 和 TensorRT-LLM。

功能列表读起来像一份推理框架的体检报告：并行策略覆盖 Attention DP、均衡 CP 和 MoE EP + EPLB；解码侧有 DSpark 与置信度调度的验证机制（用草稿 token 加速，靠置信度估计安排验证顺序）；有针对 SWA 窗口的 bounded replay（只重放有限后缀，减少 prefill 的重复计算）；默认开启异步调度，让 CPU 侧的批次调度和设备执行重叠；还有一个很少见的开关 `DEEPINFER_BATCH_INVARIANT=1`，用来保证**同一个 prompt 在不同批次组合下得到同样的输出**；再往前一步是确定性采样，固定 `seq_seed` 后连采样结果都可复现（两者目前都标注仅限 NVIDIA）。结构化输出支持正则、JSON schema 和 EBNF 语法。算子部分是 FlashMLA、DeepGEMM、DeepEP、TileKernels、DeepSelect 和自研的 TileLang kernel。

但这份 README 同时也是一份缺口清单。**没有 KV cache 系统**，没有 prefill/decode 分离（注释里承认「引擎的大部分功能其实已经实现」），也没有数据并行副本之间的负载均衡。硬件支持写得也很窄：NVIDIA 只认 **SM100**，另一边是华为昇腾 950 NPU。基准测试是在 4 张 SM100 做 prefill、64 张做 decode 的条件下测的。

真正引爆评论区的是第二条评论。有人从知乎搬来 DeepSeek 内部说法：**「基于这个框架，我们已经为 DeepSeek V4.1 Flash 实现了高吞吐、低延迟的大规模推理服务。目前单个集群的服务吞吐量是每天 155 万亿 token，整体收入是每张卡每小时 38 美元（按非高峰时段定价）。」**

这两个数字把讨论从「这个框架怎么用」整个挪到了「推理这门生意到底赚不赚钱」。以下引用的原话全部来自 HN 评论区 cached 数据，翻译为中文。

---

### 讨论焦点

#### 开源框架本身：技术清单几乎无人讨论

一个有点反常识的现象是，730 条评论里几乎没人细读那份功能清单——并行策略、`BATCH_INVARIANT`、TileLang kernel 全部无人问津。最前面那条评论只有三个词，说的是接下来贴出的那两个数字：

> "A nuclear bomb" — schneehertz [c:50163494]
> （一个核弹。）

第二条评论补上了出处，把知乎链接一并给出，于是数字本身成了整场讨论的起点。真正评价框架的人反而出现在很后面，而且评价角度是「谁在底层」：

> "It's really refreshing to put some cold hard numbers on this stuff, hopefully this quells some of the "AI is unprofitable everyone is spending a dollar to make fifty cents" arguments. Amortized cost of owning a DC full of GPUs is far less than $38/card/hr" — abound [c:50163753]
> （把这些东西换成冷冰冰的数字来讨论真是太好了，希望这能让「AI 不赚钱、花一块才回五毛」那套说法收敛一点。自建一整个装满 GPU 的数据中心，摊销后的成本远低于每卡每小时 38 美元。）

一句吐槽则指出了这份开源仓库的真实用途：它证明的不是「我们也能拿到 38 美元」，而是「我们的活儿真的干得不错」。

> "It is mostly response to claims of "all LLM are subsidized and blatant bubble, LLM are useless" etc" — matkoniecz [c:50164322]
> （这主要是对「所有 LLM 都在补贴、纯粹是泡沫、毫无用处」这类说法的回应。）

#### 核心分歧：38 美元是利润，还是入场费

分成两派。乐观派立刻去查了 SemiAnalysis 的利润测算站（`inferencex.semianalysis.com/profit-estimator`），并甩出 70% 以上的净利润率：

> "For the ones who are still wondering how so much profits, inference is a highly profitable domain: https://inferencex.semianalysis.com/profit-estimator" — freakynit [c:50163611]
> （给那些还在想利润去哪的人：推理是个高利润领域。附上 SemiAnalysis 的利润测算器。）

同一个人随后补了限定条件，这个限定条件是整场讨论里最容易被跳过、也最关键的一段：

> "70%+ net profits margins are for rented infra, that means no major upfont expense. Also, these margins are against 60% utilization only. You can well imagine if you own your infra and can make utilization over 90%, where these go. And then, my link above is for K3 model, which, compared to ds flash models, is highly unoptimized. If I had a few million lying around, I would have invested in inference." — freakynit [c:50164060]
> （70% 以上的净利润率是算租用基础设施的，也就是说没有大额的前期投入。而且这 70% 还是按 60% 利用率算的。你可以想象一下，如果硬件是自己的、利用率能做到 90% 以上，这部分利润会变成什么样。另外我上面那个链接说的是 K3 模型，跟 ds flash 系列比，它优化程度差很多。如果我手头有几百万闲钱，我早就投推理了。）

悲观派的反驳更有结构。他列出推理这门生意同时踩了三个坑：

> "I think we need to collectively get a grip on statements like this. There is no reason to think inference can or will remain interestingly profitable even if you assume pure-play inference providers who don't do any model training. Serving an LLM isn't child's play but it's also not so hard as to count as a moat. Inferencing is: 1. Selling a largely undifferentiated product. 2. Into a highly competitive market. 3. To customers who are primarily sensitive to price. Industries like this have always existed and in the modern era tend to have margins of about 3% to 5%. Any level of margin higher than that gets competed into the ground." — mike_hearn [c:50166267]
> （我觉得我们对这类说法需要集体把准一点。即便假设都是不做训练、纯粹做推理的服务商，也没有理由认为推理能长期维持可观的利润。跑 LLM 不是儿戏，但也远没难到能算护城河的程度。推理这件事是：1. 卖一个高度同质化的产品；2. 卖进一个竞争极其激烈的市场；3. 卖给一群主要对价格敏感的买家。这类行业自古就有，在现代经济里利润率通常在 3% 到 5%。高于这个水平的任何利润，都会被竞争磨到地平线以下。）

他还补了一条被忽视的成本项——推理和训练没法干净地切开：

> "The other problem with this analysis is obviously that you can't just stop training models. Even if you don't care about improving capability or performance, the knowledge in their weights gets stale. Cost of inferencing has to take into account the ongoing cost of training, you can't cleanly split one from the other." — mike_hearn [c:50166267]
> （这套分析的另一个明显问题是，你没法干脆停止训练。就算你不关心能力和性能，权重里的知识也会过时。推理成本必须把持续的训练成本算进去，两者没法干净地拆开。）

而当有人指出「5% 利润率也能撑起一个巨大产业」时，他给出了一个更接近金融现实的答案：决定利润的不是供给约束本身，而是竞争对手愿意接受多少利润。

> "Demand is elastic, there's no fixed pool of it. What determines profitability isn't merely supply constraints but how much margin your competitors are willing to accept, more or less. It's not a huge problem for users but if margins are low it's a huge problem for the debt funded datacenter buildout." — mike_hearn [c:50169037]
> （需求是有弹性的，没有一个固定的池子。决定盈利的关键不只是供给约束，而是你的竞争对手愿意接受多少利润，差不太多。对用户来说问题不大，但如果利润率低，对那些靠债务支撑的数据中心扩建就是大问题。）

乐观派的回应也很干脆——**5% 不是终点，是终局，而 5% 完全够活**：

> "Inference will continue to be profitable while we don't have enough compute in the world to serve the demand we have. Also, I don't see why it's a problem that the end game for inference of open models will be relatively low, ie 5% or so. You can have a huge industry running on these margins." — pu_pe [c:50168426]
> （在全世界算力还不够满足需求之前，推理会继续赚钱。另外，我不觉得开放模型的推理终局利润率低到 5% 左右是个问题。在这个利润率上也能撑起一个巨大的产业。）

#### 训练成本多久回本：一个数字被当场推翻

讨论中途冒出「8 到 12 个月回本」的说法，但立刻有人指出原文说的是硬件：

> "I seem to recall the leaked Liang Wenfeng speech gave a figure of 8-12(?) months of inference recouping the training costs of the model." — v9v [c:50164864]
> （我记得梁文锋那次内部讲话泄露出来的数字是，8 到 12 个月（存疑）的推理收入可以回补模型的训练成本。）

> "I think what he said was that 10 months of inference paid for the hardware it runs on (which may have a lifetime of a few years). I don't think he mentioned training/development cost." — HarHarVeryFunny [c:50169904]
> （我理解他说的是 10 个月的推理收入能覆盖运行这些硬件的成本（而硬件寿命可能只有几年）。我不记得他提到了训练或研发成本。）

十个月的推理收入，恰好等于那张 DeepInfer README 上写的硬件折旧周期量级——这个巧合本身就是这场讨论最好的注脚。

#### 开放模型的「危险」：把利润削成一条线

关于开源模型对商业模式的影响，评论区出现了本次讨论最尖锐的一段：

> "Today. As new supply comes online and demand levels off, that 38$ will shrink. Absent legal monopolies, the margin will shrink to a sliver more similar to any other service. That is the danger of open source models. They destroy monopolies and shrink margins." — sandworm101 [c:50163948]
> （就是今天。随着新供给上线、需求走平，那个 38 美元会缩水。在没有法定垄断的情况下，利润率会缩成一条细线，跟其他任何服务没有区别。这就是开放模型的危险之处：它们摧毁垄断，同时压缩利润率。）

这条「危险论」立刻被人用三个字顶了回去，而这也是全场最短的一次交锋：

> "Danger? You mean benefit?" — VulgarExigency [c:50164766]
> （危险？你是说好处吧？）

「危险论」的作者接着把这个反问解释清楚：视角是用户还是股东，取决于你站在哪一边。这把讨论从技术直接拉到了仓位。

> "That would depend on whether you are a user/customer or an investor/owner in AI. At the moment, nearly everyone is on the investor/owner side." — sandworm101 [c:50164855]
> （这要看你到底是 AI 的用户和客户，还是投资人和所有者。此刻几乎所有人都站在投资人/所有者这一边。）

顺着这条思路，另一位参与者把整件事和 Netscape 放在一起比较——技术上的先驱者，往往赚不到自己创造的市场的钱。

> "Boosters are right that AI is a historically impactful product, but big labs will be unable to meaningfully profit from ushering in the AI era just like Netscape failed despite ushering in the internet era." — red_green_yell [c:50167852]
> （鼓吹者说得没错，AI 是一个历史上影响深远的产品，但大实验室很难从主导 AI 时代这件事上赚到像样的钱，就像 Netscape 虽然开启了互联网时代，自己却没做成。）

#### 中国电价的账：便宜是真的，但不是补贴幻觉

「那 38 美元会不会是靠补贴撑起来的」这个问题，有人从电网结构给出了具体答案：

> "China has a two tier energy system. Consumer get the cheaper energy, while industry normally get the twice as expensive energy. But for AI/Datacenters, there is a exception and they get the cheaper consumer level energy. You need to take in account that the way China taxes is not the same as here in the West. And a lot more is put on the local governments regarding generating their own revenue (why there was so much building in China because those projects funded local government). A bit of a side topic lol. Its not so simple as they are making a loss on something because how its structured." — benjiro29 [c:50165437]
> （中国是双轨电价。居民用电便宜，工业用电通常要贵一倍。但 AI 和数据中心是个例外，拿的是居民级的便宜电价。你还得考虑中国的税收方式和西方不一样，而且创收任务更多地压在地方政府头上（为什么中国在建那么多东西，因为这些项目养着地方财政）。算是个题外话。这事没那么简单，不能只说「他们在这上面亏钱」，因为它的结构本来就不是那样。）

身处北京的参与者给出了具体数字，把「便宜」从印象变成了可核对的量：

> "I'm not sure how much you pay in USA. But I live in Beijing, where the residential electricity price is about 0.5 RMB per kWh, roughly 0.0749 USD. China's electricity pricing involves cross-subsidies. Residential and agricultural users pay the lowest rates, which are generally below the cost of supply. Commercial and industrial users pay more and contribute the most of grid revenue. Prices vary by region: commercial electricity can approach 1 RMB (0.15USD) in Beijing, but the national average is about 0.67 RMB (0.1USD), while industrial electricity averages around 0.63 RMB nationally." — ammo1662 [c:50169528]
> （我不清楚美国电价是多少。但我住北京，居民电价约 0.5 元人民币一度，也就是 0.0749 美元。中国电价里存在交叉补贴：居民和农业用电最低，通常低于供电成本；工商业用电更高，也是电网收入的主要来源。各地价格不同：北京的商业电价接近 1 元（0.15 美元），全国平均约 0.67 元（0.1 美元），工业用电全国平均约 0.63 元。）

同一个人还提到一个常被忽略的点：这里的建设热情和 AI 关系不大，更多是为了压低工业用电成本、减少能源进口依赖。

> "The AI in the west have a issue because it really does not matter if you cut China from Nvidia GPUs or advanced nodes, they compensate on the power level." — benjiro29 [c:50165437]
> （西方这边在 AI 上的问题在于，切断中国拿 NVIDIA GPU 或先进制程，其实没什么用，他们能在电力这一层补回来。）

#### 便宜的模型真便宜吗：一次成本结构的分歧

讨论里出现了一段意外的自相矛盾。原本的立场是「便宜的模型够用了」，直到有人换成按总成本而非 token 单价来算：

> "I'm daily driving DeepSeek 4.1 flash (at API prices) and every now and then I give Opus 5.5 a try and don't notice anything missing for me. My workflow is one where I am heavily involved in the process and I don't like giving the agent too much autonomy + I need to follow along. Opus 5.5 speak is still cause aneurysms for my brain." — GreenWatermelon [c:50164219]
> （我天天用 DeepSeek 4.1 flash（按 API 价格付费），偶尔试一下 Opus 5.5，没觉得少了什么。我的工作方式是深度参与全程，不喜欢给 agent 太多自主权，我也得跟得上。Opus 5.5 说话的方式还是让我太阳穴疼。）

> "In my experience, while DeepSeek 4.1 Flash and GLM 5.3 Flash are a lot cheaper per token, they're just as or maybe even more expensive when you factor in all the extra tokens that are need to troubleshoot and fix their mistakes -- and even more expensive if I factor in my own time wasted doing the same, not to mention the frustration of having to deal with that. DeepSeek 4.1 Flash also hallucinates a lot." — pmoriarty [c:50165027]
> （按我的经验，DeepSeek 4.1 Flash 和 GLM 5.3 Flash 单个 token 便宜得多，但把排错和返工多花的 token 算进来，它们可能一样贵甚至更贵；如果再算上我自己浪费掉的时间，就更贵了，还没算处理这种事带来的烦躁。DeepSeek 4.1 Flash 幻觉也很多。）

同一个人还给出了一个相反方向的条件：工作流不同，答案就不同。

> "For such workflows it barely matters which of a dozen models gets used. Whereas if you're handing off all dev and no longer reading code, just making CTO-level architecture decisions, then there are only 2~3 models right now worth using, none cheap." — unsupp0rted [c:50165399]
> （对这类工作流来说，十几种模型里挑哪种其实没那么要紧。但如果是把整个开发交出去、不再读代码、只做 CTO 级的架构决策，那现在值得用的也只有两三个模型，而且没有一个便宜。）

于是「推理利润率低」这件事在评论区有了另一种后果：商业客户正在往便宜的模型上迁移。

> "I'm already seeing this directly at work - lots of devs still happily use claude for development, but the products we're making aren't. They'll use kimi, glm, gpt-oss, etc... basically - if cloudflare is hosting it, we're exploring it (mainly for contractual/security reasons): https://developers.cloudflare.com/workers-ai/models/. Because we are price sensitive, and we already have to do all the work of creating very robust evaluation frameworks for our products, so we might as well choose the cheapest model that meets our standards." — horsawlarway [c:50165584]
> （我已经直接看到这种效应了：很多开发者写代码时还是乐于用 Claude，但我们做的产品不是。产品会改用 kimi、glm、gpt-oss 之类——基本上只要 Cloudflare 在托管，我们都会去探索一下（主要出于合同和安全方面的原因）。原因是我们对价格敏感，而且既然反正要为产品搭一套很扎实的评测框架，那就顺手选一个达到标准的模型里最便宜的。）

同一个评论里还有一句更冷的话：

> "Nobody meets expectations of a 2 trillion dollar IPO selling a fungible commodity like tokens for old models." — horsawlarway [c:50165584]
> （没有谁能在用旧模型卖可替代的 token 这种生意里，兑现两万亿估值的预期。）

#### 泡沫争论：一句 49% 结束

关于「这是否是泡沫」，最有力的反驳把推理和训练的成本分开来看：

> "I think everyone has known that inference is profitable overall for the major providers for a while (I'm sure not all user accounts, but in aggregate). The major providers are unprofitable after you add in the training and research costs and other overheads. This is why the open source models are such a threat if they become good enough - it will destroy the business model of just providing raw chat/intelligence." — Closi [c:50164379]
> （其实大家都知道主要厂商的推理业务整体上是赚钱的（我不确定每个用户账号都赚，但汇总起来是）。把训练、研究成本和其他开销算进去，这些大厂商才是不赚钱的。这也正是开放模型一旦够强就如此危险的原因——它会摧毁「只提供原始对话/智能」这个商业模式。）

这一支的收尾很干脆：

> "AI companies are now 49% of the S&P 500. Massive bubble." — esseph [c:50165597]
> （AI 公司现在占标普 500 的 49%。 Massive bubble。）

而反向的看多则给出了具体收入数字作为对照：Anthropic 年化收入正在冲向 1000 亿美元，而 54 岁的 SAP 还不到 400 亿。

> "Anthropic is zooming to $100 billion in annualized revenue. The tremendous cost is matched by the tremendous business output. In the span of less than five years, starting from their first $1 of revenue, Anthropic + OpenAI will have produced businesses doing at least $150 billion in combined sales. The demand isn't reducing at present, it's climbing, they can't come close to servicing the total demand for their frontier models. SAP is under $40 billion in annualized revenue. They're 54 years old." — adventured [c:50165244]
> （Anthropic 的年化收入正在冲向 1000 亿美元。巨大的成本对应着巨大的商业产出。从赚到第一美元算起，不到五年，Anthropic 加 OpenAI 合计销售额至少做到 1500 亿美元。需求目前没有下降，还在上升，他们离满足前沿模型的总需求还差得远。SAP 的年化收入还不到 400 亿美元，而它已经 54 岁了。）

这段之后紧跟着一句反驳：要是 SAP 每卖一美元只收五毛，它也能长得飞快。

> "If SAP sold $1 bills for $0.50, they too could rapidly outpace Anthro/OAI's growth. And when sane minds ask about profits or a defensive moat, the response is "but look at our revenue bro"." — red_green_yell [c:50167774]
> （如果 SAP 一美元钞票卖五毛，它也能飞快超过 Anthropic 和 OpenAI 的增速。而当清醒的人追问利润或者防御性护城河的时候，得到的回答是：「你看看我们的营收啊兄弟」。）

#### 跑题：AGI 有多远

讨论后段彻底跑题到 AGI 时间表，最短的一条判断：

> "Agi is not coming in this century. Like come on." — blazing234 [c:50168126]
> （AGI 这个世纪不会来。想什么呢。）

这条立刻被同一个人自己打回来——不过他说的是「我们其实已经经历过好几任 AGI 了」，指过去几年一个接一个的模型突破。

---

### 典型观点一览

| 立场 | 用户 | 一句话观点 |
|---|---|---|
| 乐观 | freakynit | 70% 净利率但那是租算力、60% 利用率下的数字，自建机房加高利用率会好看很多。 |
| 乐观 | pu_pe | 5% 的终局利润率也是个大产业，问题不在利润低。 |
| 悲观 | mike_hearn | 同质化产品、激烈竞争、价格敏感买家，这类生意现代利润率只有 3%–5%。 |
| 悲观 | sandworm101 | 新供给上线后那 38 美元会缩水，开放模型会压掉所有垄断利润。 |
| 立场纠偏 | VulgarExigency | 「危险」？那不就是「好处」吗。 |
| 数字辟谣 | HarHarVeryFunny | 梁文锋说的是 10 个月回本硬件，不是训练成本。 |
| 电力视角 | benjiro29 | 中国双轨电价，数据中心拿的是居民级便宜电价，输不起的反而是西方。 |
| 电力视角 | ammo1662 | 北京居民电价约 0.5 元/度（0.075 美元），工商业靠交叉补贴承担电网收入。 |
| 成本纠偏 | pmoriarty | 便宜的模型算上返工 token 和自己的时间，可能一点都不便宜。 |
| 客户行为 | horsawlarway | 开发者还在用 Claude，但产品已经开始换成便宜模型。 |
| 泡沫论 | esseph | AI 公司占标普 500 的 49%，这就是泡沫。 |
| 训练成本 | Closi | 推理赚钱、训练亏钱，这才是开放模型真正的威胁所在。 |

---

### 总体情绪

这场的特别之处在于：一个 1962 分的技术帖，最终几乎没有人在讨论那个框架。DeepInfer 的 Apache 2.0 许可证、批次无关推理、确定性采样、昇腾 950 支持，这些才是发布内容，但评论区的前 100 条里几乎找不到讨论它们的人。第二个评论贴出的两个数字——每天 155 万亿 token、每卡每小时 38 美元——把整场讨论改写成了一个经济问题。

而这恰恰说明了一个关于推理框架的事实：框架本身已经不是瓶颈了。当你能把 38 美元这个数字亮出来时，大家真正想弄明白的不是「你的 kernel 写得怎么样」，而是「这 38 美元里有多少能留下来」「能留多久」「对手会不会接受更低的利润」。讨论里的分歧点非常具体——自建还是租用算力、60% 还是 90% 利用率、训练成本算不算进推理——这些都是可以拿数字继续算下去的问题，但没人给出确定答案。

最有意思的插曲是那个 10 个月：内部讲话里「10 个月推理回本」说的是硬件，而硬件寿命也就三五年；同一条 README 上写着自建集群的自测条件是 4 张卡跑 prefill、64 张跑 decode。当一个框架愿意把「我是在什么规模上测的」写进文档时，账本就已经摊在桌面上了，剩下的只是谁来算、算给谁看。

---

### 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | DeepInfer: High-performance inference framework for DeepSeek models | https://github.com/deepseek-ai/DeepInfer |

---

<div class="disclaimer">
本文为 Hacker News 讨论摘要，原始版权归原作者及 Hacker News 社区所有。
引文原文遵循原作者授权（CC-by-3.0 引文豁免）；中文译文部分基于原文意义译出，仅供阅读参考。

⚠ 本次讨论涉及「中国电价与补贴结构」「中美 AI 商业模式对比」「开源模型与闭源实验室利益冲突」等话题，所引观点按原帖立场呈现，不代表本项目立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>