---
layout: post
title: >-
  GPT-6.1 Sol：逼近 Astra 的智能，五分之一的价格 — HN 讨论摘要
date: 2026-09-30
hn_id: 49896586
categories: [articles]
excerpt: >-
  OpenAI 在 Astra 因安全担忧被搁置的同周，把 Sol 拉到 Opus 5.5 五分之一价；HN 讨论集中在「模型通胀」、中国开源压力、与那句被反复复读的"我们撞到能力天花板了吗"。
tagline: >-
  旗舰要等安全审查，平价先上场；OpenAI 这场发布会像把折扣价贴在了急诊室门口。
---

## 原文概要

[主帖](https://news.ycombinator.com/item?id=49896586) 由 OpenAI 官方发布，标题《GPT 6.1 Sol: Near-Astra intelligence for a fifth of the price》，3 小时内拿到 588 分，是 9 月 29 日 HN 热度榜首。同一周，OpenAI 把 **GPT-6.1 Astra** 的发布因"安全担忧"临时搁置——消息在 24 小时内被多家媒体报道，评论区第一条就追问"昨天不是说安全原因不发吗"。

帖子开门见山给出两个数字：**接近 GPT-6.1 Astra 的智能水平，价格仅为对手 Claude Opus 5.5 的五分之一**。配套调整包括 API 计费方式改动——缓存输入 token 的折扣结构被重排，企业市场被官方定位为这次降价的真实目标。文章没有披露基准成绩单，只给出"近 Astra"这一相对位次描述。

评论区最常见的具体陈述包括：

- aaronbreathorst 直接把数字敲在第一楼："Shots fired, half the price of Opus 5.5"。
- prodigycorp 提示，**计费方式变更**才是这次降价的真正杠杆——把 token 重新分类，缓存输入折算方法改动之后，账单才能直接砍到五分之一。
- nsingh2 把发布时间线解释清楚：GPT-6 上周刚发但"反响平淡"，**Opus 5.5 抢走**了部分风头，6.1 Sol 的加速发布被部分读者解读为对 Anthropic 的反击。
- algoth1 指出："6 Sol 根本没进 ChatGPT 聊天界面"，意味着官方对它的定位一开始就是 **API / Work / 企业**渠道，不打算让普通用户随便用。

## 讨论焦点

### Astra 被搁置 vs Sol 提前发：同一周的两个动作

HN 上第一个被反复复读的话题不是 Sol 本身，而是 24 小时前刚发生的另一件事——**GPT-6.1 Astra 因安全原因被暂缓发布**。

> "Weren't there headlines just yesterday that they weren't releasing this due to safety concerns?" — hlynurd [c:49896637]
>
> （译文：昨天不是还有新闻说因为安全原因不发这个吗？）

> "GPT-6.1 Astra is what those headlines referred to. This is GPT-6.1 Sol." — tedsanders [c:49896648]
>
> （译文：那些新闻说的是 GPT-6.1 Astra。这是 GPT-6.1 Sol。）

> "Yes but it was underwhelming, so they seem to have rushed 6.1 Sol out. Also Opus 5.5 may have spooked them too." — nsingh2 [c:49896723]
>
> （译文：是的，Astra 上周反响一般，所以他们把 6.1 Sol 提前拿出来了。也可能是被 Opus 5.5 吓到了。）

这条线的重要性不在于"哪个模型更强"，而在于它给整场发布打上了**两套标准**的标签：旗舰要先过安全审查，平价版本可以绕过这道闸先上。pkulak 的跟帖把这种割裂挑明——

> "That was 6.1 Astra. And I'm assuming it's being tabled because it still doesn't match Opus 5.5. This is a decent win though, if it really is better. 6-sol was really no good, at least in my work." — pkulak [c:49896679]
>
> （译文：那说的是 6.1 Astra。我猜它被搁置是因为还打不过 Opus 5.5。如果 6.1 Sol 真的更好，那是个不差的胜利。6 Sol 至少在我这里不行。）

如果 Astra 真的只是"反响平淡"，"安全担忧"就是一个公关故事；如果它真没打过 Opus 5.5，那 Sol 就是**临时救场**。HN 这条线的读者两边都信。

### 价格战是 2026 的主战场，Anthropic 是不是该 IPO 了

整场讨论被反复提起的一个判断——**token 价格正在变成 AI 行业的主战场，而不是模型能力**。gradus_ad 几乎一锤定音：

> "Ominous for the industry and investors that token price is becoming the main battleground. Could be Anthropic's rationale for IPOing this year." — gradus_ad [c:49896666]
>
> （译文：对行业和投资人来说不祥的信号是 token 价格成了主战场。Anthropic 今年 IPO 的逻辑可能就是被这件事逼出来的。）

跟帖里 nojito 把这条线往消费者一侧拉：

> "Great for the consumer.<p>I remember when bandwidth was super expensive and now it's dirt cheap." — nojito [c:49896710]
>
> （译文：对消费者是好事。我记得当年带宽贵得要命，现在跟不要钱一样。）

跟帖再被回怼——AWS 用户的体验显然没那么乐观：

> "Not an AWS customer, I take it? :-)" — vanviegen [c:49897031]
>
> （译文：你大概不是 AWS 客户吧。）

但真正把这条线推到底的，是中国开源模型的现实压力。jorblumesea 给了 HN 读者最具体的一组数字——

> "This is literally the plan, open weight models are something like 60% of token spend, and it will get worse. many companies now have model gateways where you can slot in cheaper models via cli for cheaper. we've been using glm 5.x and it's pretty close to SOTA frontier models. it's also why there have been so many calls for regulation and slowdowns." — jorblumesea [c:49897020]
>
> （译文：开源权重模型大概已经吃掉 60% 的 token 花费，而且只会更多。很多公司现在有 model gateway，用 CLI 直接换更便宜的模型。我们在用 GLM 5.x，离 SOTA 前沿模型差不了多少。这也是为什么"监管、放缓"的呼吁越来越多。）

> "Yup.<p>I see posts about OpenAI and Anthropic latest and don’t even care looking at what they do better. I just read the comments here.<p>I use DS4.1 Flash and GLM 5.3 Flash, pay peanuts per day and get more than acceptable results." — LeBit [c:49897871]
>
> （译文：没错。OpenAI 和 Anthropic 的新东西我都懒得看它们到底好在哪，就来这儿看评论。我用 DS4.1 Flash 和 GLM 5.3 Flash，一天几块钱，结果能接受。）

这条线指向一个比"5 万 vs 1 万"更具体的场景：**公司层面接入 OpenAI 的方式已经被工程化**——model gateway、CLI 切换、按价格自动选模型——OpenAI 这次的"5 倍降价"不是被一个对手逼的，是被这套已经成形的工程流程逼的。OpenAI 自己文章里那句"计费方式变更"是这个判断的旁证。

### "我们撞到能力天花板了吗"：一场贯穿全帖的哲学辩论

Sol 的低价让一个被压抑了一年的话题重新浮出水面——**AI 的能力曲线是不是正在变平**。这条线被 mixdup 用一句话开场：

> "Another piece of evidence on the pile that the sudden panic and desire to 'slow down' is because they're hitting the plateau on capability. Which, honestly, is fine. A lot of juice to squeeze in efficiency and even if models got zero more capable, making the capability that is already here cheaper is a huge win for everyone (except Nvidia)." — mixdup [c:49896949]
>
> （译文：又一块证据。监管呼声、"放缓"诉求突然增多，就是因为他们撞到了能力天花板。说实话，这没什么不好。即使模型能力不再涨，把现有能力做便宜也是巨大的胜利，除了 Nvidia。）

反驳来自 semiquaver——

> "What universe do you live in that you can look at the past six months and see anything like a plateau in capability?" — semiquaver [c:49897016]
>
> （译文：你住在哪个宇宙，能让你看着过去六个月说"这像撞到天花板"？）

跟帖把战线扩展到具体领域——3D、图形、视频编辑——

> "The difference between 6 months ago frontier and now frontier in 3d modelling, graphics and video editing is night and day." — CuriouslyC [c:49897289]
>
> （译文：六个月前的前沿模型和现在的，在 3D 建模、图形、视频编辑上的差距是天和地。）

但 ActionHank 又把这条线拉回来——

> "Have we honestly seen that great a leap in the last 6 months, or just better application of what we had 6 months before that. We are seeing multiple frontier models dropping on the same day and no one bats an eye, because it's more of the same." — ActionHank [c:49897069]
>
> （译文：过去六个月我们真的看到了巨大飞跃，还是只是把六个月前的能力用得更熟？多个前沿模型同一天发布没人在乎，因为都差不多。）

这条线没有结论，但 HN 的整体倾向是**怀疑**。curiouslyC 引用 NeurIPS 论文数据**反驳**怀疑论——GPT-5.6-sol+codex 在某 benchmark 上从 o3 时代的 3-4% 跳到 16%，Astra+codex 跳到 24%——这些数字恰恰指向"能力还在涨"，而不是"撞到天花板"。但怀疑论者同样有数据：digdugdirk 的 CNC 机床类比被反复复读。

> "The difference now is that they've hit the &quot;good enough&quot; point. LLMs are a tool, and that tool is useful but not incredibly valuable unto itself. To make a manufacturing analogy - ChatGPT was a manual machining mill, and in the years after we've gone from that to a 3-axis CNC mill. Now we've added a 4th and 5th axis, which is great for the 2% of parts that need that functionality." — digdugdirk [c:49898363]
>
> （译文：区别在于现在已经到了"够用"的点。LLM 是工具，本身不是特别值钱。打比方：ChatGPT 是手动铣床，几年后我们有了 3 轴 CNC，现在多了 4 轴和 5 轴，对 2% 的零件有用。）

HN 上"是不是撞到天花板"的辩论每隔几个月就会回到这条线，但每次带回来的具体证据不一样。这次 Sol 的低价本身被两边同时引用：怀疑论者说"价格战说明能力见顶"，反驳者说"价格战是市场选择，跟能力无关"。

### Sol 自己没进 ChatGPT：openai 自己的产品策略有问题

Sol 6.1 让一部分**真实用户**不满的原因更工程化——它没法在 ChatGPT 聊天里直接用。

> "It was so underwhelming that it didn't even make it to chatgpt chat interface." — algoth1 [c:49896821]
>
> （译文：反响太一般了，根本没进 ChatGPT 聊天界面。）

> "Sol 6 is in there? You may be on Enterprise where it didn't roll out by default and comes out in a week or so. (Which is a weird and bad change to their model releases.)" — oh_no [c:49897464]
>
> （译文：Sol 6 在那里？你可能是 Enterprise 用户，默认没铺开，要一两周后才到。这是模型发布策略上一个奇怪而糟糕的变化。）

pkulak 把这条线和自己的工作流连起来：

> "I used it for one day, spent the next day fixing its lousy code, then went back to 5.6." — pkulak [c:49896747]
>
> （译文：我用了一天，第二天在修它写的烂代码，然后就回 5.6 了。）

> "6 Sol was worse than 5.6 Sol from my own experiences. Far worse. Will see if this remedies things." — cmrdporcupine [c:49896703]
>
> （译文：我自己的体验，6 Sol 比 5.6 Sol 差很多。差太多了。看看 6.1 能不能治回去。）

Sol 系列的"低能评级"是这次发布会的暗伤。OpenAI 把 Sol 当 API 主力卖，**但真实用户的代码体验**显示它在前一代就已经输给了 5.6。这条线指向一个尴尬结论——**5 倍降价是因为它在能力上没资格卖原价**。OpenAI 的官方文章当然不会这么说，但 HN 用户拿 Sol 6 vs 5.6 Sol 的代码体验做对照时，结论是清楚的。

### DeepSeek v4.1 的真正威胁：KV 缓存效率

Sol 5 倍降价的故事背后，还有一个被技术读者拎出来的事实——这次降价**主要杠杆是缓存输入 token 的折扣结构重排**，而不是模型本身变便宜。

sharpshadow 把这条线抛出来——

> "Response to DeepSeek’s technical paper and competition." — sharpshadow [c:49896783]
>
> （译文：回应 DeepSeek 的技术论文和它的竞争压力。）

跟帖 wg0 追问细节，被 Wheen 用 DeepSeek v4.1 的 KV 缓存数据回答——

> "Not the person you're replying to, but judging by the emphasis on the cost of cached input tokens in the OP article, I'd guess it has to do with DeepSeek v4.1's KV cache efficiency. It uses <1000 bytes per token, so they're able to get 1M token context in under a GB." — Wheen [c:49897690]
>
> （译文：不是我回的贴，但看 OpenAI 文章对"缓存输入 token 成本"的强调，我猜和 DeepSeek v4.1 的 KV 缓存效率有关。每个 token <1000 字节，100 万 token 的上下文 1GB 不到。）

这条线把"价格战"重新定义成一场**基础设施战**。DeepSeek 把 KV 缓存压到 <1000 字节/token，OpenAI 的回应不是跟进基础设施，而是**重新定义账单**——把缓存输入的折算方式改掉，让 API 价格表上看起来便宜了。两种思路都通向"让 1M token 上下文便宜"，但**实现路径完全不同**：一个是工程效率，一个是会计游戏。

### Pro 20X 被砍成 10X：用户钱包上的副作用

这场发布还附带了一条用户痛点——Pro 订阅的 20 倍速率上限被悄悄砍到 10 倍。

> "I think they are hitting compute restrictions. And buying compute right now can be 3-4X. And the costs are increasing. If they train a larger model and demand is high, that's a lot of compute for Codex subscriptions, which is a loss leader for them. Especially Pro 20X which they just nerfed to 10X." — theturtletalks [c:49897084]
>
> （译文：我觉得他们撞到了算力上限。现在买算力贵 3-4 倍，成本还在涨。要是大模型训练 + 高需求，对 Codex 订阅是巨大的成本压力，订阅本来就是亏本买卖。尤其是 Pro 20X，刚被砍到 10X。）

这条线把"降价"和"砍额度"放进了同一个故事：**对外报价更便宜，对内补贴缩紧**。订阅用户原本被 20X 速率上限吸引，现在被砍到 10X——降价不是补贴，是重新分配成本。HN 用户讨论里几乎没人给这种"价格 vs 额度"的玩法单独算账，但把它放回"订阅亏本"那条线时，结论就清楚了：OpenAI 的订阅用户在补贴它对 Anthropic 的价格战。

### 模型通胀：每周一个新版本是常态

最后一条被复读最多的话题是**模型通胀**——每周都有新版本，谁也跟不上。

> "Wasn't 6 released like last week? I can't keep up anymore." — t-sauer [c:49896665]
>
> （译文：6 不是上周才发的吗？我跟不上了。）

> "What's driving the increase in release cadence here? We seem to get new models every week or so now, is this RSI?" — phpnode [c:49896671]
>
> （译文：发布节奏在加快，是因为 RSI（重复性劳损）吗？）

跟帖 dandellion 把"大版本号崇拜"说成行业病——

> "The old &quot;the bigger number is better&quot;, GPT announces model 6.1, the obvious thing to do next is to announce Gemini 27, and after that Claudé 3000, then a flute album." — dandellion [c:49896976]
>
> （译文：老一套"数字大就是好"，GPT 发 6.1，下一步显然要发 Gemini 27，再发 Claudé 3000，然后一张长笛专辑。）

跟帖把战线往中国开源模型上拉——

> "Chinese model pressure. Many of my SWE friends switched to Chinese models. I also use QWEN and GLM for many of the api requiring projects and dropped OpenAI and Anthropic. The only reason was the cost." — system2 [c:49896820]
>
> （译文：中国模型的压力。我的 SWE 朋友很多切到中国模型。我自己的 API 项目也用 QWEN 和 GLM，OpenAI 和 Anthropic 都放弃了。唯一的原因是成本。）

这条线把"跟不跟得上"和"用不用得起"绑在一起。HN 真实用户的日常已经变成：**API 项目跑 QWEN 和 GLM，偶尔来 HN 看前沿动态，新模型几乎不试**。OpenAI 这种"每周发一个"的节奏，对订阅用户是 stress test，对工程用户是噪声。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Astra 因安全被搁置 | hlynurd [c:49896637] / tedsanders [c:49896648] | "昨天新闻说的是 Astra，这是 Sol。" |
| 6.1 Sol 是被 Opus 5.5 吓出来的 | nsingh2 [c:49896723] | "Opus 5.5 把 OpenAI 吓到了。" |
| 6 Sol 上一代就不行 | pkulak [c:49896747] | "我用了一天，第二天在修它写的烂代码。" |
| 6 Sol 比 5.6 Sol 还差 | cmrdporcupine [c:49896703] | "差太多了。" |
| token 价格是主战场 | gradus_ad [c:49896666] | "Anthropic 今年 IPO 的逻辑可能就是被这件事逼出来的。" |
| 降价对消费者是好事 | nojito [c:49896710] | "带宽当年也是贵，现在跟不要钱一样。" |
| 开源权重模型已吃 60% token 花费 | jorblumesea [c:49897020] | "公司在用 GLM 5.x，离 SOTA 差不了多少。" |
| 自己已经在用 DS4.1 Flash | LeBit [c:49897871] | "一天几块钱，结果能接受。" |
| 已经撞到能力天花板 | mixdup [c:49896949] | "把现有能力做便宜是巨大的胜利，除了 Nvidia。" |
| 过去 6 个月根本没撞到天花板 | semiquaver [c:49897016] | "你住在哪个宇宙？" |
| 3D/视频/图形 6 个月差距是"天和地" | CuriouslyC [c:49897289] | "Astra+codex 在 benchmark 上从 3% 跳到 24%。" |
| "够用点"已经到达 | digdugdirk [c:49898363] | "LLM 是工具，CNC 机床类比。" |
| Sol 6 没进 ChatGPT 聊天界面 | algoth1 [c:49896821] | "反响太一般了，连界面都不让上。" |
| 模型发布策略已经变怪 | oh_no [c:49897464] | "默认不铺开，要一两周后才到。" |
| 订阅用户在补贴价格战 | theturtletalks [c:49897084] | "Pro 20X 刚被砍到 10X。" |
| 缓存输入折算才是降价的杠杆 | Wheen [c:49897690] | "DeepSeek v4.1 KV 缓存 <1000 字节/token。" |
| 跟不上了 | t-sauer [c:49896665] | "我跟不上节奏了。" |
| 这是 RSI | phpnode [c:49896671] | "每周一个新模型是 RSI。" |
| 大版本号崇拜 | dandellion [c:49896976] | "GPT 6.1，下一步 Gemini 27，再发 Claudé 3000。" |
| 中国开源才是真正的竞争 | system2 [c:49896820] | "朋友都切到中国模型，唯一原因是成本。" |

## 总体情绪

HN 这场讨论的真正主角不是 **GPT-6.1 Sol 本身**，而是**两件事的同时发生**：旗舰被安全审查挡在门外一周，平价版本加速发布。这种割裂是这次发布会的真实底色——OpenAI 的产品节奏已经不是"我们准备好了就发"，而是"能发的先发，发不了的就先审"。把这件事和 Astra 的安全搁置并排放，"安全担忧"四个字在 HN 读者眼里就变成了"还没准备好"的代名词。

评论区里最刺骨的解读来自 Sol 6 vs 5.6 Sol 的对照：**OpenAI 给 Sol 1.5 倍的价格，可能是因为 Sol 在能力上没资格卖原价**。pkulak 和 cmrdporcupine 两条评论都指向同一个真实工程体验——上一代 Sol 在代码任务上输给了 5.6，而 6.1 Sol 是不是真解决了这个问题，OpenAI 文章里没给基准。这种"降价但不等于便宜"的张力，是评论区反复追问但没人答完的问题。

更深一层的张力来自 token 价格战的中国侧。jorblumesea 给出的"60% token 花费跑在开源权重模型上"和 LeBit 的"我用 DS4.1 Flash 和 GLM 5.3 Flash 一天几块钱"，把 OpenAI 的"5 倍降价"重新解读成**对已经发生的替代方案的回应**。Wheen 的 KV 缓存数据则把这场价格战重新定义成**基础设施战**——OpenAI 没有跟进 DeepSeek 的 KV 缓存效率，而是重写了账单结构。两种路径都通向"1M token 上下文变便宜"，但工程含量完全不同。

最后，HN 这次讨论几乎所有人都同意的一件事是——**模型通胀已经到了让用户疲劳的程度**。dandellion 的"Gemini 27、Claudé 3000、长笛专辑"被复读成 HN 这一周最受欢迎的版本号讽刺，而 system2 的"朋友都切到中国开源"则把它从吐槽升级成数据：当用户**已经习惯不试新模型**的时候，OpenAI 每周发一个新版本号的边际效用就是负的。

讽刺之处在于：HN 这场讨论里最一致的口味——token 价格战、撞到天花板的怀疑、模型通胀疲劳——**全部是 OpenAI 这次降价想缓解的症状**。但 5 倍降价本身又引发新的症状：订阅用户被砍额度、Sol 系列被怀疑"降价是因为它便宜所以便宜"、账单结构重排被解读成会计游戏。一场发布会同时治三种病和生三种病，这是 HN 这次讨论的最终隐喻。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | GPT 6.1 Sol: Near-Astra intelligence for a fifth of the price | https://news.ycombinator.com/item?id=49896586 |

<div class="disclaimer">

本摘要由 AI 模型辅助生成，仅供了解 HN 讨论脉络之用，文中观点不代表本站立场。引文均为 HN 用户公开发表的评论，按 Creative Commons CC-BY 引用；译文仅供参考，可能与原文语气有出入。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>