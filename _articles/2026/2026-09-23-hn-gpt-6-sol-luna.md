---
layout: post
title: >-
  GPT-6 Sol 和 Luna — 50% 降价同时打 Claude Opus 5 — HN 讨论摘要
date: 2026-09-23
hn_id: 49805509
categories: [articles]
excerpt: >-
  OpenAI 用 GPT-6 Sol 和 Luna 把 API 价格腰斩，直接对标 Claude Opus 5 和 Fable 5.1——基准打平或超越，成本只有对手的 1/10；HN 评论区追问的不是能力，而是这种价格能否持续，以及同价位的 Astra 已经改变了谁的饭碗。
tagline: >-
  用 frontier 的能力打 mid-tier 的价格，赌的是对方先眨眼。
---
## 原文概要

9 月 22 日，OpenAI 发布 GPT-6 家族的两位新成员——GPT-6 Sol 和 GPT-6 Luna——把 API 价格对头直接腰斩：Sol 输入 $4 → $2、输出 $20 → $10，Luna 输入 $0.20 → $0.10、输出 $1.20 → $0.50，均为对 GPT-5.6 同名档位促销价的 50% 降幅。Sol 的 API 名为 `gpt-6-sol`，Luna 为 `gpt-6-luna`；两者与本月初发布的 GPT-6 Astra（最强档）一起，构成 Astra / Sol / Luna 三档体系。同日 Anthropic 也更新了 Claude 产品线，HN 评论区几乎立刻分成两派：一派认为是巧合，一派认为是定价阻击。

能力对标被 OpenAI 摆到台面上。GPT-6 Sol 在 [AutomationBench 1.0.6](https://openai.com/index/introducing-gpt-6-sol-and-luna/) 上以 xhigh effort 拿到 33.2%、单任务 $0.27，超过 Claude Opus 5 max effort 的 26.9%（单任务成本 11.1 倍于 Sol）；[DeepSWE v1.1](https://openai.com/index/introducing-gpt-6-sol-and-luna/) 上 Sol max effort 68.8%，距 Claude Fable 5 xhigh 69.9% 仅 1.1 个百分点，单任务成本约低 80%；[OSWorld 2.0](https://openai.com/index/introducing-gpt-6-sol-and-luna/) 上 Sol xhigh 60.5%，相当于 Claude Opus 5 medium 的 60.3%——同样便宜 80%。Luna 在 DeepSWE v1.1 max effort 上 66.6%，比 Opus 5 medium 略好，单任务便宜 93%。

定价之外的两条改动值得单独看。**缓存**：GPT-6 的 cache reads 折扣提到 90%，GitHub 在数十亿请求里把需要新鲜处理的 prompt token 占比砍掉超过 50%；并提供 Prompt Caching Dashboard、显式 breakpoint、推理档位/工具开关切换不再破坏 cache。**沟通风格**：官方称把 Astra 的表达改进下沉到 Sol 和 Luna，举了一个 example 对比——GPT-5.6 Sol 在 prompt "Could we use a Bento Box design style" 上产出 "bento feel" 这种含糊描述，GPT-6 Sol 的回复更克制、更明确说"我做了什么、检查了什么"，少讲实现细节。

可用范围：ChatGPT Work 和 Codex 今日起对 Plus / Pro / Business / Enterprise / Edu 用户开放；Free 和 Go 用户仅能在桌面 app 用 GPT-6 Luna；Chat 渠道尚未包含；API 已在 gpt-6-sol 和 gpt-6-luna 名称下可用。Luna 在 20x 套餐上"接近无限"，原因是 API 价格本身已经很低。Bedrock 已上架。

文章还把对话风格改进做了 example 对比：GPT-5.6 Sol 倾向堆细节、说"bento feel"这种模糊词，GPT-6 Sol 更克制、更明确说出"做了什么、没做什么"，prompt 长度也短一些。

## 讨论焦点

### 价格与对比的"震撼"

50% 的降价幅度让 HN 评论区的第一印象几乎是压倒性的：

> "Cutting prices by 50% as compared to 5.6 prices is exciting. GPT-6 Luna at $0.10/Mio input tokens and $0.50/Mio output is positively insane." — Cu3PO42 [c:49805553]
> （相比 5.6 降价 50% 已经够激动了。GPT-6 Luna 输入 $0.10/Mio、输出 $0.50/Mio，简直疯狂。）

评论区很快把目光放到 Claude 那一边：

> "I don't see how anyone can be using Claude with prices like this, it's pretty incredible what the OpenAI team is doing, w.r.t model quality and pricing." — pookieinc [c:49805615]
> （出这种价，我不知道还有谁能选 Claude——OpenAI 在模型质量和定价上做的事真了不起。）

但这种"震撼"也立刻被反向利用：用户报出 Claude Opus 5.5 的 cache reads / input / output / cache writes 价格（$0.50 / $5 / $25 / $6.25 每百万 token），用 Claude 一边的价格表对照 OpenAI 的降价幅度——评论区的潜台词是，"震撼"既可以解读为 OpenAI 慷慨，也可以解读为 Anthropic 之前收得太贵。

### 与 Anthropic 同日发布：巧合还是定价阻击

发布时间的巧合是被讨论最多的隐线之一：

> "There's no way this wasn't meant to coincide with Anthropic's release today." — beardsciences [c:49805547]
> （不可能不是冲着 Anthropic 今天发布来的。）

> "They hinted this release last week for tuesday already, so if anything it would be Anthropic that tried to make this happen. But I doubt it." — jstummbillig [c:49805599]
> （OpenAI 上周就预告过周二要发，所以更像是 Anthropic 在抢节奏。我倒是不信。）

> "Altman said it was launching last week on twitter, but they pushed it back to this week" — jrflo [c:49805815]
> （Altman 上周在 Twitter 上说就要发了，但被推迟到了本周。）

这条线索本身不重要，重要的是评论区对这种巧合形成的两种叙事：一种认为是防御性跟进，一种是想要抢对方的份额。

### 商业模式：亏本抢市场

降价能否持续，是另一条贯穿始终的主线：

> "GPT would charge more if they could. Both companies need way way more revenue. GPT simply made a calculation that they can earn more money by charging less than their competitors." — bitmasher9 [c:49805661]
> （能收贵 OpenAI 早收了。两家都需要更多收入。OpenAI 只是算了笔账：比对手便宜反而能赚更多。）

评论区顺着这条线展开：

> "They're cutting prices because they want to cannabalize the market for people using models like deepseek via API as well as people paying for anthropic subs. When they cut prices on luna the first time around they took (literally) millions of users from anthropic." — Shekelphile [c:49806229]
> （他们降价的目的是吃掉 DeepSeek API 用户和 Anthropic 订阅用户。上一次 Luna 降价时，他们切走了 Anthropic 几百万用户。）

> "We don't know how much they are bleeding financially, it might just be a front" — baalimago [c:49806581]
> （我们不知道他们财务上亏多少——这可能只是表象。）

> "These are the pre rug pull prices. They'll increase prices 10x and nerf the models after they IPO." — an0malous [c:49805878]
> （这是 rug pull 前的价格。IPO 之后他们会把价格翻十倍，再削弱模型能力。）

反驳的一方则把矛头指向 IPO 节奏本身：

> "They also have postponed their IPO. So they don't have to be profitable that soon. Anthropic on the other hand plans to do the IPO this fall." — blubber [c:49805960]
> （OpenAI 已经推迟了 IPO，所以短期内不必证明盈利。Anthropic 反倒计划今年秋天 IPO。）

> "That would only work if OpenAI were a monopoly, which they are not." — minimaxir [c:49806667]
> （'rug pull' 论只在 OpenAI 是垄断者时成立，而它并不是。）

价格能不能撑住的另一面是 LLM 经济学本身：

> "Any business would charge more if they could. Jevon's paradox would mean that they can make more money by charging less because demand is going to keep growing." — wyre [c:49805867]
> （能收贵任何企业都会收贵。杰文斯悖论意味着：因为需求会持续增长，降价反而能多赚。）

> "FWIW, what you're describing is a simple demand curve, not Jevons paradox." — atq2119 [c:49806040]
> （顺便说一句，你描述的是普通需求曲线，不是杰文斯悖论。）

### 缓存与 agent 的真实成本

降价公告里没明说的缓存定价，被技术派抓出来单独看：

> "Did cache read/write also decrease by 50% or similar? That's where most (95%+) of the cost is for agentic coding workloads." — ignoramous [c:49806077]
> （缓存读 / 写也降 50% 了吗？在 agentic coding 工作负载里，95% 以上的成本都在缓存上。）

> "Yes, still 20% of input cost." — minimaxir [c:49806687]
> （是的，缓存读仍是 input 价格的 20%。）

一位用户反驳了"95%"这一估计：

> "cost is dominated by non cached reads" — blovescoffee [c:49805936]
> （非缓存读才是成本大头。）

但另一位的实际账单相反：

> "that might depend on usecase, half of my cost is cache reads usally" — pinkgolem [c:49806193]
> （看场景，我的成本一半都是缓存读。）

缓存折扣被官方摆到 90% 的背景下，评论区对"50% 降价"的有效幅度产生了分歧——对 cache-heavy 工作流而言，真实降本远不到 50%。

### 长任务、代码质量、orchestration 模式

便宜的 Luna 让"长任务 / 跑一晚"这个用例有了讨论空间：

> "Pricing is insane, can have Luna going after a goal for 10 days and not run into maxing out the limits." — nickandbro [c:49805613]
> （价格疯了，可以放 Luna 追一个目标跑十天都不会撞上限。）

但"能跑"和"能跑好"在评论区被分开：

> "Why would you do this though, surely these long running /goal tasks just like letting a wild animal out into your code base. Does anyone care about code quality anymore?" — physicallyIllfr [c:49805919]
> （但为什么真要这么干？让 LLM 在代码库里无监督跑长任务，等于放野生动物进你的代码库。还有人在乎代码质量吗？）

> "1. you can have luna clean up after itself and improve code 2. you might be doing something like video-editing, cad modeling, artistic direction, pcb routing, etc. that need to run a long time to 'converge'" — blovescoffee [c:49805985]
> （1. 可以让 Luna 自我清理、改善代码；2. 你可能在做视频剪辑、CAD 建模、艺术指导、PCB 布线等需要长时间"收敛"的任务。）

orchestration 模式被另一组用户提出来：

> "It looks like the optimal pattern is to have Astra as the orchestrator and Sol as the implementer. Same as with Fable and Opus." — cesarvarela [c:49805650]
> （最优模式似乎是把 Astra 当编排者、Sol 当执行者。Fable 和 Opus 也是这套。）

> "I've found Sol to be an excellent orchestrator, with Astra the planner and Sol again the implementer." — afro88 [c:49806210]
> （我发现 Sol 做编排也很好——Astra 规划、Sol 执行、再 Sol 收尾。）

但反例也有：

> "I've found Astra to be horrible at making orchestration decisions. I will be trying to use Sol for both. Fable is very good at it though. Worst part of my week is when I hit my Fable usage limit and have to switch to Astra." — petesergeant [c:49805767]
> （Astra 做编排决策其实很糟糕。我想两边都用 Sol。Fable 这点倒是很好——一周最难受的就是 Fable 用量见顶、被迫切到 Astra。）

### 命名层级：Luna → Sol → Astra + 推理档位

新名字让不熟悉的读者困惑了一轮：

> "Wtf is GPT-6 Sol, I though GPT-6 is Astra?" — dyauspitr [c:49805828]
> （什么鬼 GPT-6 Sol？我以为 GPT-6 就是 Astra？）

> "Name is the size (Luna smallest to Astra largest)" — Readerium [c:49805847]
> （名字是尺寸——Luna 最小，Astra 最大。）

> "Then what is Astra high-extra high-Ultra? That's effort within each tier?" — dyauspitr [c:49805895]
> （那 Astra 的 high / xhigh / Ultra 又是什么？是每档内部的推理档位？）

> "Yes that is number of reasoning tokens used." — Readerium [c:49806055]
> （是的，那就是用的推理 token 数。）

这套命名体系在评论区被反复确认：GPT-6 是一代，下分 Luna / Sol / Astra 三档尺寸，每档内部又有 low / high / xhigh（甚至 Max）这种推理 effort 档位。

### 沟通风格改进：少废话，更克制

OpenAI 把"对话风格改进"作为本轮亮点之一。HN 上有人注意到这个改动：

> "I'm glad both labs noticed and are trying to improve the models communication styles, they were getting closer and closer to meaningless gibberish." — sfkgtbor [c:49805629]
> （很高兴两家实验室都注意到、并试图改进模型对话风格——他们之前越来越接近"无意义的乱码"了。）

另一位用户把这条对比拉到 Anthropic 一边：

> "But the reason people say 'Claude can't compete' is because Claude Opus has been going downhill since 4.7, and many have found Opus 5 intolerable. Fable is much better, but also much more expensive than OpenAI's offerings." — ronsor [c:49805712]
> （大家说"Claude 不行"的原因是 Claude Opus 自 4.7 起一直在下滑，很多人觉得 Opus 5 难用。Fable 好得多，但也比 OpenAI 的贵不少。）

### 信任与隐私：为什么还是不选 OpenAI

降价吸引不住所有人。一位用户直白表态：

> "Disagree. I would never use OpenAI cause they're probably just going to steal whatever I'm working on." — LZ_Khan [c:49805846]
> （不同意。我绝不会用 OpenAI——他们很可能偷我正在做的东西。）

立刻有人反问：

> "What are you working on? Is any of it actually worth stealing?" — nradov [c:49805885]
> （你在做什么？真的值得偷吗？）

也有人把矛头指向"任何闭源 API"：

> "and anthropic won't? or any other inference provider? Running your own inference either locally or remotely are probably the only ways to make sure that doesn't happen." — AustinDev [c:49805862]
> （Anthropic 不会吗？任何其他推理提供商不会吗？想确保这点，只能本地或自托管推理。）

这条线的张力在于：OpenAI 把价格砍到能让 Luna "几乎无限"用的程度，隐私顾虑反而成了少数人"无论多便宜都不选"的硬约束。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 价格震撼 | Cu3PO42 | Luna $0.10 / Mio input、$0.50 / Mio output，简直疯狂。 |
| 看好 OpenAI | pookieinc | 出这种价，没人能选 Claude。 |
| 时间巧合 | beardsciences | 不可能不是冲着 Anthropic 今天发布来的。 |
| 时间巧合（反驳） | jstummbillig | OpenAI 上周就预告过周二，Anthropic 反而像在抢节奏。 |
| 抢市场 | Shekelphile | 上一次 Luna 降价就切走了 Anthropic 几百万用户。 |
| rug pull 担忧 | an0malous | 这是 rug pull 前的价，IPO 后价格翻 10 倍、能力被削弱。 |
| 反垄断反驳 | minimaxir | "rug pull" 只在 OpenAI 是垄断者时成立，而它不是。 |
| 杰文斯悖论 | wyre | 能收贵都会收贵；价格降下来后需求会继续涨。 |
| 缓存成本 | ignoramous | agentic coding 95% 成本在缓存，缓存价没降就白搭。 |
| 长任务担忧 | physicallyIllfr | 让 LLM 无监督跑长任务等于放野生动物进代码库。 |
| orchestration | cesarvarela | Astra 编排、Sol 执行——和 Fable + Opus 同套。 |
| 命名解释 | Readerium | 数字是代次，名字是尺寸；档内还有推理 effort。 |
| 风格改进 | sfkgtbor | 两家都在改进对话风格，他们之前越来越像"无意义的乱码"。 |
| 隐私拒绝 | LZ_Khan | 再便宜也不会用 OpenAI，他们大概率会偷我正在做的东西。 |

## 总体情绪

评论区明显分裂成三层。**第一层是震撼**——50% 的降幅让"出这种价谁还选 Claude"成为最自然的第一反应，连 Anthropic 自己也意识到了，Opus 5.5 的价格表在评论区被频繁引用作为对照。**第二层是追问**——价格能不能撑住、缓存折扣实际能省多少、API 降价能不能反映到订阅额度，回答彼此打架：有人用 Jevons 悖论解释降本反而能增收，有人用 rug pull 论警告 IPO 后会变本加厉，更多人在算 agentic coding 工作负载的真实账单（cache reads 占了 95% 还是 50% 直接决定这次降价的实际幅度）。**第三层是不为所动**——价格再低也不选 OpenAI 的用户存在，他们列出的理由不是钱，而是隐私和"任何闭源 API 都一样"的根本不信。

价格战的真正赌注不是这一个版本能卖多少 token，而是同档能力的"对手价位"被压到了多少。当 Sol max effort 的 DeepSWE v1.1 分数只比 Fable 5 xhigh 落后 1.1 个百分点、单任务成本只有对方的 1/5，Anthropic 的回应空间只剩两个——要么跟降，要么赌用户为 Fable / Mythos 的"对齐溢价"和品牌继续多付十倍。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | GPT-6 Sol and Luna | https://openai.com/index/introducing-gpt-6-sol-and-luna/ |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=49805509 |

---

<div class="disclaimer">

本文由 AI 辅助生成，基于 HN 公开讨论。所有引文均来自上述 HN 帖子中的真实评论，评论 ID 可在原帖中验证。立场归原作者，编辑整理与翻译由 AI 完成。

<br><br><em>本摘要由 AI 模型辅助生成：MiniMax/MiniMax-M3</em>
</div>