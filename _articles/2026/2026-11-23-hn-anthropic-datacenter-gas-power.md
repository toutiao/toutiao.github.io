---
layout: post
title: >-
  Anthropic 的数据中心，2028 年烧的是 87% 天然气 — HN 讨论摘要
date: 2026-11-23
hn_id: 50597612
categories: [articles]
excerpt: >-
  Better Data Center Project 估算 Anthropic 2028 年的碳排放可能达到每年 1700 万至 3800 万吨 CO2e，中间情形 3200 万吨，上限足以超过 Google、Microsoft、Meta 三家 2025 年 Scope 2 排放之和。评论区一半在算这笔账，另一半在追问同一个问题：电为什么不用太阳能。
tagline: >-
  Anthropic 说要用地热、风电、光伏——合同全签在挪威和加拿大。
---

> 来源：HN 讨论主帖 [87% of the Anthropic power will come from gas and 11% from coal in 2028](https://news.ycombinator.com/item?id=50597612)（616 分，687 条评论），指向 Better Data Center Project 的案例研究 [How AI is powered: a breakdown of BYOP and grid power](https://betterdatacenterproject.com/2026/11/16/how-ai-is-powered-a-breakdown-of-byop-and-grid-power/)。本篇为 single post 模式。主帖 2026-11-22 08:57 UTC 发布，归档快照 2026-11-22 19:10 UTC（616 分 / 687 条评论），入库 129 条评论（主帖页面共 687 条评论，未取全量），评论分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文保留 HN 原文的 HTML 实体，截取的引文段落均为归档评论中的连续片段。

> ⚑ **政治背景**：本文第八节涉及美国政治注意力、移民与选举等话题，评论区亦有对能源政策与核电路线的政治性归因。所引观点按原帖立场呈现，不代表本项目立场。⚠ Review recommended.

## 原文概要

Better Data Center Project（下称 BDCP）11 月 16 日发布了一份案例研究，把「AI 到底烧什么电」这个问题落到一家具体公司头上：Anthropic。做法是把算力合同、选址、供电方式逐条还原，再用美国环保署的 AVERT 工具建模「新增负荷会由哪几台机组来满足」，最后折算成碳排放与空气污染物。数据源包括 Epoch AI 的数据中心追踪表、Anthropic 自己的公告与备案文件、合作方（Amazon、SpaceX）的公告与备案，以及 The Information、Semafor 等媒体的报道。

核心结论：按目前已签约的美国数据中心计算，2028 年 Anthropic 的电力里约 87% 来自天然气、11% 来自煤。作为背景，BDCP 的前一份报告统计过全美已规划的 BYOP（自带电源）燃气容量达 177 GW，够全美 65% 的家庭用电；而这些自带电源项目里，可再生能源占比到 2032 年预计不足 20%。此外还有约 200 GW 新化石电厂在电网侧在建，其中很大一部分正是为数据中心而建。

规模上，Anthropic 到 2026 年 10 月已签下 15 GW 算力，其中约 5.9–9.6 GW 绑定了具体的数据中心站点。按 9.6 GW 计算，这块负荷大约可以供 700 万户家庭用电，或者覆盖加州 18% 的峰值电力需求——加州是全球第四大经济体。排放方面，报告估算这些站点 2028 年的碳排放可能达到每年 1700 万至 3800 万吨 CO2e，中间情形 3200 万吨。对照的数字都很刺眼：超过加州全州发电的排放（2024 年 3110 万吨，不含进口电力）；超过 Meta、Microsoft、Google 三家 2025 年 Scope 2 排放之和（分别为 590 万、1200 万、1500 万吨）；相当于 2024 年全美数据中心行业排放（1.05 亿吨）的 16%–36% 增量；也会让全美电力行业 2025 年 1.485 亿吨的排放再涨 1.1%–2.5%。报告还估算了 Anthropic 用电的碳强度：1033–1076 lb CO2e/MWh，比美国电网平均的 767 高出 35%。

最具体的两个现场细节来自供电侧。其一，Anthropic 10 月声明要求为它供电的电厂安装选择性催化还原（SCR）脱硝设备，但它自 2026 年 5 月起就在使用 SpaceX 的 Colossus 2 设施的算力，而该设施大部分电力来自临时的、未取得许可的涡轮机，其中多数没有装 SCR；到 2026 年底，Anthropic 计划从 Colossus 2 拿走最多 600 MW。其二，它已从西弗吉尼亚 Mason 的 Nscale Monarch 算力园区签下 460 MW（还在谈最多 920 MW），那座园区用的是往复式内燃机，甲醛和危险空气污染物（HAP）排放明显高于常规燃气电厂。另外，Anthropic 约 25%（2.5 GW）的合同电力来自自建 on-site 燃气，其中 80% 是效率偏低的简单循环机组。报告还追算了 Anthropic 与 SpaceX 的算力交易规模变化：2026 年 5 月宣布 300 MW（22 万块 GPU）；SpaceX 6 月修订的 S-1A 显示每月 12.5 亿美元、32.5 万块 NVIDIA GPU、隐含 IT 功率约 490 MW；Anthropic 10 月的 S-1 里这单已经涨到每月 31 亿美元。

## 讨论焦点

### 一、顶楼是一句道德质问，顶楼之下是三句反驳

帖子第一句话就把气氛定了下来。

> "Why are we letting this happen? Why are we letting the few burn down our planet in order to further decrease reliance on (and opportunities for) the many?" — vrganj [c:50597746]
> （译文：我们为什么要放任这种事发生？我们为什么要让少数人烧掉这颗星球，好让多数人更少依赖它（以及它带来的机会）？）

紧接着的回复立刻转向调侃。

> "Better this than spending another second writing YAML in an air-conditioned room with free snacks." — ares623 [c:50597865]
> （译文：宁愿这样，也好过在有免费零食的空调房里再写一秒 YAML。）

而反驳的一方抓住的是需求这一头——没有人否认代价，问题是代价换回来什么。

> "Letting what happen? Powering our future? How do you intend to provide AI to billions of people without it?" — addedGone [c:50597929]
> （译文：放任什么发生？给我们的未来供能？不靠它，你打算怎么给几十亿人提供 AI？）

真正沉重的发言出现在同一串讨论里：有人一边不看好 LLM 的能力，一边承认自己也在用。

> "I dont know, I really hate the direction this is going. Im not even that confident in the capabilities of llms, but that doesn&#x27;t really matter. We&#x27;re selling our futures, our environment and trading our competency to a couple (greedy) corporations in exchange to be able to cheat at our jobs.<p>Yes, everyone I know including myself at times, is just cheating. Doing a similar amount of work as before with less effort&#x2F;time involved. There&#x27;s not all that much productivity gains, maybe for a select few who practically live in a state or mania (burnout inevitable).<p>I dont see it as all that positive for anyone long term. Im constantly having to relearn things, never retaining anything I learn with these things, and forgetting everything I used to know. Its literally causing a cognitive diabetes of sorts. Like someone who drives their car everywhere loses muscles, gains weight and eventually gets a metabolic disease, im certain this happening to our brains. Im 100% certain of this. Its a net negative all around, there&#x27;s no such thing as a free lunch.<p>Even if everything goes smooth with the progression of this technology, best case scenario is we have massive unemployment and people with jobs make  20% of what they did because they&#x27;re now practically just a meat proxy, the equivalent of a conveyor belt operator. Suddenly find ourselves working for a dozen or so Oligarchs, tons more crime, zero uppward mobility. Thats best case scenario. Im not sure why everyone is so excited about this." — fedupnow [c:50597977]
> （译文：我不知道，我真的讨厌这个方向。我对 LLM 的能力本身都没那么有信心，但这其实无关紧要。我们在卖掉自己的未来和环境，拿我们的能力去和几家（贪婪的）公司做交易，换来的是在工作中作弊的机会。<br>是的，我认识的所有人，包括我自己有时，也是在作弊。用更少的精力/时间完成和以前差不多的工作量。生产力的提升并没有多少，对少数几乎住在 mania 状态里的人可能才有用（倦怠不可避免）。<br>我看不出这从长期看对任何人是正面的。我得不断重新学习，却永远学不扎实，把以前知道的全忘光。它字面意义上在造成一种认知上的糖尿病。就像天天开车的人没了肌肉、长了体重，最后得了代谢病一样，我确信我们的大脑正在发生同样的事。我百分之百确定。到处看都是净亏，不存在免费的午餐。<br>就算这条技术路线一路顺风，最好情况也就是大规模失业，在岗的人拿到的只有原来的 20%——因为他们现在基本上只是肉做的传送带操作员。突然发现自己为十几个寡头工作，犯罪多得多，向上流动为零。这还是最好情况。我不明白大家为什么这么兴奋。）

### 二、「烧煤是唯一选择」这个前提本身被质疑

有一层的回复非常直接：现实早就证明可再生能源是空想。

> "Reality yet again shows why renewables are a pipe dream." — noosphr [c:50597896]
> （译文：现实又一次说明了为什么可再生能源是个白日梦。）

反驳给出的是另一组统计口径——新增装机而不是总装机。

> "New electricity capacity is almost all renewables (90%+) : solar and wind.<p>Renewables are completely dominating. New coal and gas capacity is almost non-existent because it is too expensive in comparison.<p>Even renewables + the extra cost of battery backup are much cheaper than building a new coal or gas plant.<p>Coal and gas are only competitive when the plants are already built, and even for pre-existing its at the tipping point where a new-solar build is cheaper than even supplying coal&#x2F;gas to an existing power plant." — EarthMephit [c:50597967]
> （译文：新增发电装机几乎全是可再生（90% 以上）：光伏和风电。<br>可再生能源已经完全占优。新增煤电和气电装机几乎不存在，因为相比之下太贵。<br>就算加上电池备用的额外成本，可再生能源仍然比新建一座煤电厂或气电厂便宜得多。<br>煤和气只有在电厂已经建好的时候才有竞争力；而即便是存量电厂，也已经处在临界点上——新建一套光伏比给现有机电厂供煤/供气都便宜。）

同一个人随后补了口径上的限定，避免被读成「电力早就干净了」。

> "If you look at new capacity, yes; if you look at total generation, still under 10% of energy (and well under in most places)." — coryrc [c:50598603]
> （译文：看新增装机，是这样；看总发电量，可再生能源仍然不到能源总量的 10%（多数地方远低于这个数）。）

于是「必须烧东西」和「什么都不用烧」被摆成了一道假二选一。

> "Nothing needs to burn, that&#x27;s a false dichotomy." — xandrius [c:50597935]
> （译文：没有东西非烧不可，这是个假二选一。）

但反对者也指出，可再生要替代化石，缺的不只是风机和电池。

> "Because the sun doesn&#x27;t shine 24&#x2F;7, batteries aren&#x27;t there yet and other than China no other country has the powerline infrastructure in place to feed the grid cross-country with the massive amount needed from one place to the other when one part of the country is cloudy and the other is not." — NotGMan [c:50598655]
> （译文：因为太阳不会 24/7 照射，电池也还没到位，而且除了中国，没有哪个国家具备那种跨州输电设施，能在一个州阴天、另一个州晴天时把巨量电力从这里输送到那里。）

这条讨论最浓缩的一句总结来自一位回复者，他用了一个叙事梗。

> "narrator: you can build massive wind, solar, and battery plants and it would be more than enough. however the fossil fuel lobbies and nuclear bros would like a word with you" — dv_dt [c:50598005]
> （译文：旁白：你完全可以建起大规模风电、光伏和电池电站，电力绰绰有余。不过化石燃料利益集团和核电爷们有话要对你说。）

### 三、为什么偏偏是美国：便宜的燃气，饿了三年的电网

最硬的一层论据来自电力从业者视角：这个星球缺的不是技术，是投资。

> "People who aren&#x27;t in the energy sector don&#x27;t realize how energy starved the planet is. There&#x27;s literally deficits in nearly every segment due to chronic (30+ year) underinvestment. The last time a new refinery complex was constructed in the US was decades ago, natural gas power plants have more or less only been replacing ancient coal ones, and total electricity produced has been flat for around 20 years now. Global oil production has been effectively flat over the past 20 years, barely meeting GDP growth, and in fact has been decoupled from GDP since ~COVID due to a sharp spike in services driven growth.<p>&gt; But renewables<p>Not enough, again. You could hypothetically start mass producing solar &amp; wind turbines, but it _isn&#x27;t_ enough. All that has been doing is replacing, again, ancient coal fired power plants. The world needs unprecedented investment in energy." — rfgplk [c:50597966]
> （译文：不身处能源行业的人不会意识到这颗星球有多缺电。由于长期（30 多年）的投资不足，几乎每个环节都存在实际缺口。美国上一次新建成套炼油综合体还是几十年前，天然气电厂基本上只是在替换古老的煤电厂，总发电量已经连续大约 20 年停滞。全球石油产量在过去 20 年基本持平，仅够勉强跟上 GDP 增长；实际上自 2020 年前后以来，由于服务业驱动增长带来的陡增，它已经和 GDP 脱钩。<br>> 但可再生能源呢<br>还是不够。你理论上可以大规模生产光伏和风机，但那还是不够。它们做的仍然只是替换古老的燃煤电厂。这个世界需要史无前例的能源投资。）

（该条评论末尾附有美国能源信息署 EIA 发电数据的链接。）

针对「美国为什么全烧燃气」，回答落在价格上。

> "In the US, gas is cheaper than coal. There&#x27;s no political will to stop this." — throwaway473825 [c:50598125]
> （译文：在美国，天然气比煤便宜。政治上没有意愿阻止这件事。）

同一评论的前半段还给了个对照：当年德国把俄罗斯气价（是本国煤价的两倍）当作便宜电。而要把责任推回美国本土的另一位回复者，给出的对比更直接。

> "This is an American problem due to funneling everything into profits.<p>Australians have three hours of free electricity per day now. Charge your EV, charge your house battery, run your A&#x2F;C at some crazy low temp. All free." — dan_grec [c:50598349]
> （译文：这是美国的问题，因为一切都先被塞进利润里。<br>澳大利亚人现在每天有三小时免费电。给电动车充电，给家里的电池充电，把空调开到极低温运行。全免费。）

> "China add an entire US grid worth (1281GW) of RENEWABLES every 3 to 5.3 years.<p>The US could do these things if they wanted to. But they don’t. Like healthcare, education, prisons and do much more, profit is more important." — dan_grec [c:50598349]
> （译文：中国每 3 到 5.3 年就新增一整个美国电网（1281 GW）的可再生能源。<br>美国想做也能做到。但它不做。就像医疗、教育、监狱以及更多事情一样，利润更重要。）

关于澳洲电价，帖子里出现了正面与反面两种现场数据。

> "Residential electricity is now <i>free</i> during the middle of the day in Australia.<p>Wholesale prices are dropping, my provider just sent an updated price sheet with a lower price per kWh.<p>Is this a US problem only?" — jiggawatts [c:50598012]
> （译文：在澳大利亚，居民用电现在白天中段是<i>免费</i>的。<br>批发电价在下跌，我的电力公司刚发来新的价格表，每千瓦时价格更低。<br>这是美国独有的问题吗？）

> "What do you mean wholesale price is dropping? We&#x27;re sitting at more than double, almost triple, the wholesale price since 2020 (which had been flat for more than a decade prior). If we ignore the 2022 peak as an outlier, we&#x27;re still well and truly trending upwards, with only a tiny reverse in the last year.<p>Projections are that price is likely to increase by 10-25%, especially as more coal is taken offline permamently. These projections look very conservative, and the footnotes say it&#x27;s likely spot prices could double during peak periods (the key part that people ignore when they focus on how low the mid-day prices are, is how the peak prices have been soaring)." — jimmydorry [c:50598330]
> （译文：什么叫批发电价在下跌？相比 2020 年（此前十多年一直持平），我们现在坐的是两倍多、接近三倍的批发电价。就算把 2022 年的高点当成异常值，我们的价格仍然明显上行，去年只有一点点回落。<br>预测是电价大概还要涨 10%–25%，尤其是在更多煤电被永久关停的情况下。这些预测看起来非常保守，脚注里还写着现货价格在高峰期很可能翻倍（大家只盯着白天价格有多低，忽略了高峰价格一直在飙升）。）

而最结构性的解释落在并网流程上：不是没人愿意用绿电，是新用户根本接不进来。

> "Because bureaucracy favours existing electricity consumers over new users, even if the new users are more economically valuable. Connecting to the grid is a nightmare, so every new DC is BYOG, which practically means gas turbines." — brainwad [c:50599245]
> （译文：因为官僚机制偏爱既有用电方，哪怕新用户的经济价值更高。并网简直是一场噩梦，所以每个新数据中心都是自带电源（BYOG），这实际上就等于燃气轮机。）

### 四、煤和气之外：核电、太空、澳大利亚、中东

被问得最多的一条出路是核电。支持者只有一句话。

> "Nuclear power is the future." — newsclues [c:50597989]
> （译文：核电才是未来。）

反对者算的是时间。

> "Sweet! Power in 2046 at the earliest of we start <i>today</i><p>That is simply not workable, and the suggestion needs to die because it sucks motivation from solutions that can work in a year or two." — dan_grec [c:50598163]
> （译文：好极了！今天开始，最早 2046 年才有电。<br>这根本行不通，这个提议得死，因为它会吸走那些一两年内就能见效的方案的动能。）

还有一条彻底跳出地面电网的路子，连吐槽都带着旧账。

> "There&#x27;s always an option of... wait for it... datacenters in space.<p>*runs*<p>But then of course that&#x27;s another front-page submission with its own long thread of commenters feeling smart for calling it stupid, despite recently becoming a worked out plan and addressing exactly the (subset of reasonable) things people are complaining about here. In fact, we had those a week or two ago.<p>I swear the tech space turned into thought-space NIMBYs. &quot;I don&#x27;t understand any of it, but something about it pattern-matches to something I don&#x27;t like, therefore it&#x27;s stupid and people behind it are evil&quot;. In this thread, and in every other thread recently, too." — TeMPOraL [c:50598109]
> （译文：永远还有这么个选项——等一下——把数据中心放到太空里。<br>*跑*<br>但那当然又是另一个首页投稿，配上一长串觉得自己很懂、于是骂它很蠢的评论者——尽管它最近已经变成了一份成型的方案，而且正好回应了这里人们抱怨的那些（合理的子集）事情。事实上，一两周前我们就有过这些了。<br>我发誓科技圈已经变成了想法圈里的 NIMBY。「我完全搞不懂，但它的某些东西让我联想到我不喜欢的东西，所以它很蠢，做它的人是坏人。」在这个帖子里，以及最近其他每一个帖子里都是。）

有人当场查了太空方案的可行性，数字并不乐观。

> "I looked into it just now, and it appears SpaceX is targeting deployment of the first satellites in 2027.<p>To deploy 1 GW of capacity, apparently 100 Starship launches would be needed.<p>On earth, 23 GW are currently under construction, 100-132 GW is already active, and about 100 GW should be added by 2030.<p>SpaceX&#x27;s CFO supposedly cited 2029 as the timeline for multiple GW of compute in operation in space. Musk&#x27;s vision seems to be launching 100GW&#x2F;year or 1 million ton of satellites.<p>This would require 10k launches of Starship per year under ideal conditions, or 5k if Starship Block 4 can double the payload capacity to 200t as planned. This would mean 14 launches per day.<p>It does sound like a lot. Starbase Louisiana, at a $100B buildout, is planned to have 12 launch pads that could handle 30 launches per day.<p>Obviously there&#x27;s much more needed than some launch pads. Anyway, that&#x27;s the numbers and projections I found." — user43928 [c:50598336]
> （译文：我刚查了一下，SpaceX 的目标是 2027 年部署第一批卫星。<br>要部署 1 GW 容量，据说需要 100 次星舰发射。<br>在地面上，目前在建 23 GW，已投运 100–132 GW，到 2030 年还应新增约 100 GW。<br>据说 SpaceX 的 CFO 提到 2029 年是太空中有数 GW 算力运行的时间点。Musk 的愿景似乎是每年发射 100GW，也就是 100 万吨的卫星。<br>理想情况下这需要每年一万次星舰发射，如果星舰 Block 4 能按计划把运力翻倍到 200 吨，则是五千次，也就是每天 14 次。<br>听起来确实不少。路易斯安那的 Starbase 基地按 1000 亿美元建设规模，计划有 12 个发射台，每天能打 30 次。<br>显然需要的不只是几个发射台。总之，这些是我找到的数字和推算。）

地理上的替代方案一端是中东，另一端是澳大利亚。先说中东：把数据中心搬到日照更强的沙漠地带，是这条讨论里被反复提起的选项，但回复者认为今年的地缘局势已经让这条路的可行性下降，而且基础设施仍要从零建起。

> "Given this year’s events [0], even Sahara seems more likely.<p>But you’d still have to build it out from ≈scratch, including cooling, internet connection infrastructure, and maintenance, so I’m not sure what the time horizon on amortization would look like, even with the cheap solar power." — msdz [c:50597984]
> （译文：按今年发生的事来看，连撒哈拉都比原来的选项更有可能。<br>但你仍然得从近似零开始建起来，包括散热、互联网连接设施和维护，所以即使用了便宜的太阳能，我不确定摊销周期会是什么量级。）

（原评论的 [0] 脚注指向一条路透社报道链接，本文未展开。）

澳大利亚方向则落在原本规划跨海卖电给新加坡的 SunCable 项目上：它正在考虑改成本地建光伏数据中心。

> "The Australia–Asia Power Link (AAPowerLink), aka SunCable, is a proposed undersea HVDC cable to export solar power from northern Australia to Singapore via Indonesia. Due to doubts about the economic feasibility of constructing the cable, and question marks over the willingness of Indonesian and Singaporean governments to approve it, they&#x27;ve been exploring pivoting to building solar-powered AI data centres in northern Australia instead." — skissane [c:50598002]
> （译文：澳大利亚—亚洲电力互联（AAPowerLink，又名 SunCable）是一条规划中的海底高压直流输电线，用来把澳大利亚北部的光伏电力经印尼输送到新加坡。由于这条电缆的建设经济性存在疑问，印尼和新加坡政府是否批准也有变数，他们正在考虑改为在澳大利亚北部直接建设光伏供电的 AI 数据中心。）

但这里有个经济性前提被立刻点破：数据中心必须 24 小时不停机。

> "I somehow suspect that datacenters are only economically viable if you run them round the clock, right? So at night they&#x27;d still be using gas. I guess the cost of compute would have to come down a lot, in order to power down a DC and spin up one where sun is shining instead.<p>Although I guess for current AI workloads, it could be viable, since the additional latency of sending your (small, text only) prompt around the world for processing is little compared to the time taken to process (whereas for other stuff being close to users matters more)" — Doohickey-d [c:50598064]
> （译文：我总觉得数据中心只有在 24 小时不停机时才在经济上成立，对吧？那夜里它还是得用燃气。我猜算力成本得大幅下降，才划算把一个数据中心停掉，再把流量切到有太阳的那一个。<br>不过对现在的 AI 负载来说，这或许可行，因为把你那个（小的、纯文本的）prompt 绕地球送出去处理所增加的延迟，相对于处理本身耗掉的时间不算什么（而对别的业务来说，靠近用户更重要）。）

于是有人提出把用电曲线削平：让夜间的 token 贵到没人用。

> "They could run on solar in US throughout the daylight hours. Just make the tokens cost 5x after the sun sets That would reduce the overnight demand enough the data centers could run through night on batteries." — happosai [c:50598327]
> （译文：在美国，它们完全可以在日照时段用光伏跑。只要让太阳落山后的 token 贵 5 倍就够了。这样夜间需求会被压下去，数据中心就能靠电池撑过夜晚。）

### 五、能不能只烧白天的太阳：监管处方之争

对应的政策主张是：别禁数据中心，改成强制配套。

> "Don&#x27;t ban datacenters, require new  110% renewable energy capacity for new datacenters" — dv_dt [c:50598016]
> （译文：别禁数据中心，要求新建数据中心必须配套 110% 的可再生电力。）

这条主张立刻被指出一处结构性问题。

> "The builders of these datacenters will tell you that those two things are the same thing. If you don&#x27;t let them build datacenters without any regulation, in the cheapest possible spot, with the dirtiest possible power, then you are in fact banning them.<p>This is pretty standard capitalist propaganda." — delusional [c:50598106]
> （译文：这些数据中心的建造者会告诉你，这两件事就是同一件事。如果你不允许他们在最便宜的地方、用最脏的电、不受任何监管地建数据中心，那你其实就是在禁止数据中心。<br>这就是相当标准的资本主义话术。）

### 六、到底有多少人在真用 LLM：付费用户 1 亿还是几十亿

「数十亿人需要 AI」这个前提，在帖子里被反复挑战。最直白的反驳直接给出了数字。

> "100m paid users so far no? That&#x27;s not billions" — 233mhz [c:50598062]
> （译文：目前有 1 亿付费用户吧？那不叫几十亿。）

而支持方给的量级更大——「几十亿」这个说法本身成了争议焦点。

> "more like billions." — tedk-42 [c:50598001]
> （译文：更像是几十亿。）

追问者把「想用」和「在用」、「免费用户」和「需求」拆开。

> "1. As you say, &quot;paid users&quot;. I don&#x27;t have data, but looking around, I&#x27;d say <i>by far</i> most users are free tier.<p>2. They said &quot;want to&quot;, not &quot;use&quot;. And of course even less &quot;directly pay to use&quot;" — knorker [c:50598087]
> （译文：1. 就像你说的，「付费用户」。我没有数据，但就我观察，绝大多数用户都是免费档。<br>2. 他们说的是「想用」，不是「在用」。当然，直接付费去用的就更少了。）

> "The point is that people use a lot of free things because it&#x27;s free, not because they need it. It really isn&#x27;t rocket science or up for debate.<p>You can&#x27;t infer demand form &quot;free users&quot; because just from microsoft and meta shoving AI in every single crevices of their free tier software you already get like 2b recurring users even if none of them use&#x2F;asked for&#x2F;care about ai features.<p>If the next windows 11 update turned the mouse pointer into a turd would you say 1b people demanded a turd mouse pointer?" — 233mhz [c:50598654]
> （译文：关键在于，人们大量使用免费东西是因为它免费，不是因为他们需要。这真不是什么高深问题，也没什么可争的。<br>你没法从「免费用户」推出需求：光是微软和 Meta 把 AI 塞进免费版软件的每一条缝隙里，你就已经能得到差不多 20 亿活跃用户，哪怕他们没一个用过、没要求过、也不在乎 AI 功能。<br>如果下一次 Windows 11 更新把鼠标指针变成一坨屎，你会说有 10 亿人要求屎一样的鼠标指针吗？）

反方也有硬料：Google 自己承认 AI 摘要正在侵蚀广告业务，反过来说明有大量用户在从中受益。

> "Not sure what your point is. Because it&#x27;s not refuting the claim that billions want to use LLMs.<p>And didn&#x27;t Google admit that their AI summaries are biting into their ad business (causing their recent drop), meaning a huge number of users are deriving value from it? Possibly billions.<p>And then there&#x27;s all the white collar workers sending emails. SO many people are suddenly sending grammatically correct internal emails now, AI policy or not.<p>(Of course, the recipients of those emails are not as happy, since someone who used to send shitty emails now instead write shitty prompts that don&#x27;t actually ask the LLM to address the real issues. But that still counts as demand)<p>&gt; More people are willing to pay for netflix or youtube premium than AI<p>And even more people breathe air. In both cases the analogies don&#x27;t work." — knorker [c:50598415]
> （译文：不太明白你的论点是什么。因为它并没有反驳「数十亿人想用 LLM」这个说法。<br>Google 不是自己承认了他们的 AI 摘要正在侵蚀广告业务（导致他们最近股价下跌），这意味着非常多的用户从中获得了价值？可能是数十亿。<br>还有所有那些发邮件的白领。现在突然有非常多人开始写语法正确的内部邮件了，不管公司有没有 AI 政策。<br>（当然，收件人不会那么高兴，因为原本写烂邮件的人现在改成写烂 prompt，而 prompt 并没有真的要求 LLM 解决实质问题。但这仍然算需求。）<br>> 比愿意为 Netflix 或 YouTube 付费的人更多？<br>比会呼吸的人还多。这两个类比都不成立。）

还有一条站在效用一侧的辩护：AI 也许能推进医疗，抵消掉排放。

> "No one knows, but if you believe Amodei&#x27;s optimistic projections, it might delay finding cures for most major disease.<p>What would be the upside for the environment? There is no burning of the planet that it would prevent such as some comments here said. What precisely one could name as a realistic consequence of using more gas and coal at that scale over the next years, I am not sure.<p>There is also the question whether process improvements enabled by AI can offset that." — user43928 [c:50598035]
> （译文：没人知道，但如果相信 Amodei 那套乐观预测，它可能推迟大多数重大疾病的疗法被找到。<br>那对环境的好处是什么？并没有阻止某些这里有人提到的「燃烧地球」的事情。未来几年在这个规模上多用一些天然气和煤，具体能推出什么现实后果，我不确定。<br>还有一个问题：AI 带来的流程改进能否抵消这部分排放。）

### 七、经济学版本：Jevons 悖论与外部性

把争论从道德挪到经济学之后，帖子的收尾风格明显不同。

> "It costs less -&gt; we use much more -&gt; total resource usage increases" — speedping [c:50597949]
> （译文：成本更低 -> 我们用得更多 -> 资源总消耗反而上升。）

> "Tokens per megawatt is about to go through the roof with things like disaggregated inference on the horizon.<p>This is going to quickly become similar to worrying about how many trainloads of coal it takes to run everyone&#x27;s WiFi router." — bob1029 [c:50597894]
> （译文：随着解耦推理这类技术出现，每兆瓦能产出的 token 数量即将暴涨。<br>这很快就会变成类似于担心「要烧多少车煤才能跑每个人家里的 WiFi 路由器」这种问题。）

外部性这一支把责任推回政府。

> "It&#x27;s called an externality. It&#x27;s like how people will buy a bigger car without a single thought to how much public space it&#x27;s going to use up. Governments are supposed to be there to understand and compensate for externalities, but we&#x27;ve kinda stopped doing that." — globular-toast [c:50598474]
> （译文：这叫外部性。就像人们买更大的车时，压根不会想它会占掉多少公共空间。政府本该在的问题是理解外部性并给出补偿，但我们基本不这么做了。）

最清醒的一条则把矛头从技术转向结构。

> "Nobody&#x27;s said abandon the tech. Abandon the political economy within which a handful of people get to use the tech to centralize power while burning down the material conditions for survival of humanity.<p>If not for the labor movement, the history of strikes and struggle and the resulting transformation of social conditions, humanity <i>would</i> be worse off from the industrial revolution. Ten year olds would be working twelve hour days in factories with zero attention to safety.<p>The tech itself is just a device for changing the social conditions. The direction of change is what the struggle is about. If we leave it solely to our oligarchy, they will make sure to use it to further entrench their interests while simultaneously reducing the bargaining power of labor." — vrganj [c:50599206]
> （译文：没人说要放弃这项技术。要放弃的是那种政治经济结构——在它里面，少数人得以用这项技术集中权力，同时烧掉人类赖以生存的物质条件。<br>如果没有劳工运动、罢工与斗争的历史，以及由此带来的社会条件变革，人类从工业革命中得到的处境本来会更糟。十岁的孩子会在工厂里每天干十二个小时，安全方面毫无保障。<br>技术本身只是改变社会条件的工具。改变的方向才是斗争的意义所在。如果我们把它完全交给寡头，他们一定会用它进一步固化自己的利益，同时削弱劳工的议价能力。）

### 八、一个气候帖子怎么变成了政治帖子

最后一层是元讨论：为什么气候议题在 HN 上没人接得住。有人把原因归结为注意力被别处吸走。

> "Because public attention for most people has been successfully captured and turned towards political sink holes like immigration. We needed WW2 in Europe to understand the dangers of fascism and keep that understanding for three generations. We will need more forest fires and floods and draughts and the immigration those will actually bring before we understand that we fucked up. By then it will be too late of course. Sometimes I feel guilt towards my children. They will have to pay for our mistakes in blood." — smodo [c:50597904]
> （译文：因为大部分公众的注意力已经被成功吸走，转向了像移民这样的政治黑洞。欧洲需要一场二战，才理解法西斯主义的危险，并把这种理解维持了三代人。我们需要更多的山火、洪水和干旱，以及它们真正带来的那些移民，才能明白我们搞砸了。到那时当然就太晚了。有时候我对自己的孩子感到愧疚，他们将要用血来偿付我们的错误。）

另一批回复则把责任推给政策史：三十年能源政策的后果，如今由同样一批人负责收拾。

> "Because we let mindless “environmentalists“ dictate our energy policies for the past 3 decades, and we didn’t invest in nuclear power like we should have.<p>I find these arguments very interesting, you know. A group of clueless ideologues decide some absurd policy somewhere in the past, and then, in the future, the same or very similar group of ideologues, claims that they should have some moral authority to impose new absurd policies to deal with the outcome of their old absurd policy.<p>Well, no more. It’s going to be hard for some decades, but the cycle must be broken." — notenchange [c:50598039]
> （译文：因为过去三十年，我们让没有脑子的「环保分子」 dictate 我们的能源政策，而且没有像本该做的那样投资核电。<br>我发现这些论证特别有意思：一群无知的意识形态分子在过去某个时间点拍板定了某项荒谬政策，然后在未来，同一批或几乎同一批意识形态分子又声称自己有道德权威去推行新的荒谬政策，来收拾旧荒谬政策留下的结果。<br>不，不会再有了。未来几十年会很难，但这个循环必须被打破。）

还有一条更直白的归因。

> "Because the American population voted Trump into office. Twice. Now the reasons for why they did this, are probably a bit complex. But the reason why this is happening is simply because enough people voted exactly for this: no regulation of the market whatsoever (except for renewables, those need to be prevented at all costs)" — _ink_ [c:50598041]
> （译文：因为美国选民把 Trump 选上了台。两次。他们这么选的原因大概有点复杂，但眼下这件事之所以发生，简单说就是有足够多的人恰恰为此投了票：市场完全不受监管（可再生能源除外——那些必须不惜一切代价拦下来）。）

以及一句反向的追问。

> "Why did we let Greenpeace et al keep us on polluting fossil fuels?" — knorker [c:50598072]
> （译文：我们当初为什么让绿色和平组织之流把我们留在污染的化石燃料上？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|------|
| 放任少数人烧掉星球 | vrganj | 为什么我们要让少数人烧掉这颗星球 |
| 换成写 YAML 也值了 | ares623 | 宁愿在空调房写 YAML，也不想回到过去 |
| 数十亿人的需求是前提 | addedGone | 不烧煤怎么给几十亿人提供 AI |
| 拿未来换作弊 | fedupnow | 我们在卖掉未来和环境，换在工作中作弊的机会 |
| 新增装机早就是可再生 | EarthMephit | 新增装机 90% 以上是风光，煤气只是太贵 |
| 口径要分清新增与总量 | coryrc | 看总量，可再生能源还不到能源的 10% |
| 假二选一 | xandrius | 没有东西非烧不可 |
| 电池与跨区输电没到位 | NotGMan | 除中国外没国家能跨州调度巨量电力 |
| 缺的是投资不是技术 | rfgplk | 30 多年投资不足，总发电量 20 年停滞 |
| 美国燃气便宜且没人想管 | throwaway473825 | 美国的燃气比煤便宜，且没有政治意愿阻止 |
| 这不是技术问题是分配问题 | vrganj | 该放弃的是让少数人集中权力的政治经济结构 |
| 核电是未来但太慢 | dan_grec | 今天开始也要 2046 年才有电 |
| 数据中心必须 24/7 才经济 | Doohickey-d | 夜里还是得烧燃气 |
| 中东与撒哈拉只是听着顺 | msdz | 光照再好，散热和光纤也得从零建 |
| 澳洲白天的便宜是假象 | jimmydorry | 批发电价两年翻倍，高峰期还可能再翻一倍 |
| 并网流程才是真瓶颈 | brainwad | 官僚偏爱既有用电方，新数据中心只能自带电源 |
| 削峰可以靠定价 | happosai | 太阳落山后 token 贵 5 倍，夜里靠电池 |
| 需求可能没那么多 | 233mhz | 只有 1 亿付费用户，不是几十亿 |
| 免费用户不等于需求 | 233mhz | 免费版塞满 AI 就有 20 亿活跃用户 |
| 需求是真的 | knorker | Google 的 AI 摘要正在吃掉广告业务 |
| 外部性本该由政府处理 | globular-toast | 政府本该理解并补偿外部性 |
| 政策要卡在配套电力上 | dv_dt | 新数据中心必须配套 110% 可再生 |
| 不监管等于禁止 | delusional | 建造者会说这两件事是一回事 |

## 总体情绪

这个帖子最奇特的地方在于，几乎没有人否认报告里的数字。616 分、687 条评论里，被反驳的不是 3200 万吨这个量级，而是三个更前置的东西：可再生能源是不是真的只能靠烧煤（有人说新增装机九成以上已经是风光），电力系统是不是真的喂不饱（有人说美国燃气便宜、电网三十年没投资），以及那几十亿人的需求到底存不存在（有人说付费用户只有一个亿）。这三条里任何一条成立，讨论的落点就会整个挪位。

同样容易被忽略的是第三条：需求侧的数字在这个帖子里从头到尾没有被核实过。报告给的是物理量——多少兆瓦、烧什么、由哪台机组来供、排在线上哪个位置；评论区给的是经济量——有多少人愿意付钱、愿意为省下的电付多少钱。这两个量之间没有桥。而 Anthropic 与 SpaceX 的算力交易在三个月里从每月 12.5 亿美元涨到 31 亿美元，这个数字背后站着的是需求，还是抢产能。

报告把碳排算得清清楚楚，评论区把替代方案算得稀里糊涂，而需求那一栏从头到尾没有人填。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | 87% of the Anthropic power will come from gas and 11% from coal in 2028（HN 主帖） | <https://news.ycombinator.com/item?id=50597612> |
| 2 | How AI is powered: a breakdown of BYOP and grid power（Better Data Center Project 原文） | <https://betterdatacenterproject.com/2026/11/16/how-ai-is-powered-a-breakdown-of-byop-and-grid-power/> |
| 3 | The AI Gas Rush: Risks and Implications of “Bring Your Own Power”（BDCP 前作，BYOP 177 GW 统计） | <https://betterdatacenterproject.com/2026/10/08/the-ai-gas-rush/> |
| 4 | Epoch AI data center tracker（报告采用的数据源之一） | <https://epoch.ai/data/ai-data-centers> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 616 分、687 条评论，归档快照 2026-11-22 19:10 UTC，入库 129 条，未取全量）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，截取的段落均为归档评论中的连续片段，HTML 实体按归档原文保留。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文为 Better Data Center Project 的案例研究。关于「2028 年 87% 天然气、11% 煤」「已签约 15 GW 算力、5.9–9.6 GW 绑定站点」「排放 1700 万–3800 万吨 CO2e」「选址碳强度高出电网均值 35%」「Colossus 2 的临时未许可涡轮机与 600 MW 用量」「Nscale Monarch 的 460 MW 往复式发动机」「与 SpaceX 的算力交易金额变化」等事实均出自该报告，本文未做独立核实；报告中的排放单位表述（MtCO2e）沿用原文，本文按「万吨」表述。

评论中转述的第三方数据（例如美国总发电量停滞 20 年、澳洲每天三小时免费电、中国 1281 GW 可再生增量、新增装机九成以上为风光等）由评论者自行给出，本文未核实；引文中出现的第三方链接来自评论者原帖。第八节涉及美国政治与移民议题的引文，均为评论者个人观点，本文只做转述。

本文涉及的「可再生能源能否替代」「需求端规模」「AI 的净效用」等判断，均为 HN 评论者个人观点，本文只做转述，未独立验证。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
