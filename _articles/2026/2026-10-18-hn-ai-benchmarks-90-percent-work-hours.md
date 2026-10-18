---
layout: post
title: >-
  AI benchmarks 漏掉了 90% 的工作时间——Mercor 一图引发 HN 三场争吵
date: 2026-10-18
hn_id: 50121179
categories: [articles]
excerpt: >-
  Mercor 把 923 个职业、18,797 个任务与 29 个公开基准对齐后发现，真正进 benchmark 的只是少数高薪知识工作。HN 一边在争 ROI 流去资本还是消费者，一边在争剩下 90% 的活是交给机器人，还是交给 anti-stakeholder 的 prompt。
tagline: >-
  Mercor 这一图，把硅谷对 AI 的信心拍回原形。
---

## 原文概要

AI 人才市场 **Mercor**（公司位于旧金山）于 2026 年 10 月发布《A benchmark map of the US economy》。HN 由读者提交约 9 小时内拿到 572 分、514 条评论，登上热门榜前列。

方法学层面，文章把美国劳工部 **O\*NET 分类**当骨架：

- O\*NET 包含 **923 个职业**，对每个职业列一份「tasks」清单，全美合计 **18,797 个任务**，归为 **22 个 job families**。
- 作者从公开来源挑出 **29 个 benchmark**，筛选标准 5 条：公开可用（每个 benchmark 至少 25 个任务）、agentic（让模型去做事，不是回答问题）、经济写实（贴近企业真实任务）、经济多样性（按 job family 设上限，避免软件工程和研究过曝）、未饱和（避免已被前沿模型刷满的题目）。
- 每个 benchmark prompt 用 LLM judge 自动映射到对应 O\*NET tasks，并在 Mercor 自己的 APEX 上做了人评验证。一个 O\*NET task 算「被覆盖」需要至少 5 个 prompt 对应过来。
- 全美工时被估算按 O\*NET 工作时长占比乘以总工时（Hatgis-Kessell et al. 的 LLM-estimated working-time share），以 Eloundou et al. (2023) 的 AI exposure 标签做协变量分析。

核心数字：

- 923 个职业里只有 **208 个**有至少一个任务被 5+ prompts 覆盖；**22 个 job families 中 6 个**完全没有这类职业。
- 「90% 美国工作时间花在 benchmark 几乎没有覆盖的任务上」。
- 控制 AI exposure 后仍存在的三层偏见：(a) 高 AI-exposure 任务被代表概率约 **6 倍**于低 AI-exposure 任务；(b) 即使控制 exposure，**高工资账单职业**的任务仍然显著过代表；(c) 同一职业内，领域专家打分「最重要」的任务被覆盖概率比最不重要的高 **6–10 倍**。
- 文章给出的加权 vs 不加权模型分数示例里，以 Investment Banking 为例：Claude Opus 5.5 Max 73.3% / 70.2%，DeepSeek V4.1 Flash Max 56.5% / 58.4%。顶尖与基础闪存模型在「加权后」评分上拉得更开，但绝对差仍在两位数。

Mercor 自己写明的几条限制：

- 29 个 benchmark 是有意没选饱和的，估算会偏低；同时也避免了「饱和」带来的过度乐观，选择本身带偏差。
- 按 job family 设上限压低了软件工程在样本里的覆盖估算。
- 只看数字任务，按 Dingel & Neiman (NBER w26948「37% 美国工作可完全远程」) 的口径推算，**约 63% 的美国工作**含物理世界成分，短期还进不了 benchmark。

## 讨论焦点

### 一场「基准没看见的工作都是 stakeholder 政治 / ego」

HN 软体工程师最一致的反应是：被 90% 漏掉的部分，大部分是 stakeholder / ego / 流程延迟，本身就难被 AI 化。

qurren 的开场：

> "About 80% of my software engineering job is fighting disagreements between \"stakeholders\"." — qurren [c:50121594] [thread 1]
>
> （译文：我这个软体工程师工作 80% 的时间花在跟「stakeholder」吵架上。）

duttish 给了一个具体的 50/30/10 拆分：

> "50% office politics  30% stakeholder and expectations management  10% design/development" — duttish [c:50121718] [thread 1]
>
> （译文：50% 办公室政治，30% stakeholder 与期望管理，10% 设计开发。）

AI 介入后这条线反而更紧张：

> "AI gives all the cooks the idea that they have the technical knowhow needed to take technical decisions" — eraclide [c:50121773] [thread 1]
>
> （译文：AI 让所有「厨子」都觉得自己懂技术决策。）

把「AI 不止让非技术同事瞎拍板」钉在集成层面：

> "I'm seeing this failure mode at work and it's not limited to non-technical folks. The results are compounding around different verification chokepoints and creating massive backpressure on integration/infrastructure." — scruple [c:50123177] [thread 1]
>
> （译文：我在工作中见到了这个失败模式，不止于非技术同事。问题在不同验证卡口叠加，给集成和基础设施加了巨大反向压力。）

直接否决「AI 干掉 stakeholder」可能性：

> "Code was never the bottleneck. I've worked with plenty of teams that did the \"in prod the same day\" trick without AI. The problem was just fucking ego. Designer has an ego, product owner has an ego, QA has an ego, stakeholder has an ego, platform teams have massive egos, developers have egos. Unrelated but: the only reason people are shipping more with AI is because more people are ok with slop now." — whstl [c:50123295] [thread 1]
>
> （译文：代码从来不是瓶颈。没 AI 之前我见过团队「当天上线」的事，问题就是 ego——设计师、产品、QA、stakeholder、平台团队、开发都有 ego。另说：大家现在多发版本，只是因为越来越多人接受 slop。）

上层视角把 stakeholder 制度化：

> "\"Stakeholders\" are a natural outcome of corporate evolution, because to grow bigger you need to do more, and to do more, you need people, and people come with agendas. The most common one, especially in leadership, being 'how do I get ahead of the rest?' The larger an organization grows the more these agendas come into conflict. This inevitably results in suboptimal dynamics like bureaucracy, empire building, territorialism and other things that get lumped under 'office politics,' which drains a lot of energy away from more productive efforts. So you can see how AI solves that problem too ;-) (Only half joking)" — keeda [c:50121996] [thread 1]
>
> （译文：「Stakeholder」是公司进化的自然结果——公司越大、人越多、agenda 越多，最大的 agenda 是「我怎么压过其他人」。组织越大，agenda 冲突越大，必然衍生出官僚、领地战、地方主义，俗称「办公室政治」，把精力从真正产出里抽干。所以 AI 也能「解决」这个（笑话只开一半）。）

verdverm 从反馈环角度把 AI 化进度封顶：

> "A lot of what humans do does not have a tight feedback loop needed for training and agentic workflows. This is why we are not seeing the jobpocalypse and productivity gains look a lot more like the *very* long-term 2% per year." — verdverm [c:50121239] [thread 1]
>
> （译文：人类大量工作没有训练和 agentic 工作流所需的那种紧反馈环。这就是为什么「工作末日」并未到来，生产力增益看起来更像长期每年 2%。）

ChrisLTD 顺着钉死读者自身的位置：

> "We're on a forum filled with a lot of software engineers, and we might be too ready to believe this is coming for everyone's job, not only generating code." — ChrisLTD [c:50123215] [thread 1]
>
> （译文：这是一个软件工程师扎堆的论坛，大家太容易相信这件事会冲击所有人的工作，而不只是写代码。）

### 一场「AI 省的美元到不了消费者」——资本拿走剩余，历史比较失效

这条线由 10111001 的反讽拉起。HN 对「disinflation」的论战极快展开：质疑者主张，过去几十年的「技术平价」只发生在消费品类（CPU、存储、屏幕），但在大多数人月支出最大的部分（住房、医疗、教育）从未发生；AI 节省的美元很可能根本不到消费者手里。

10111001 的反讽开场：

> "So, in short: they want AI to take the *good* jobs. AI is not coming for jobs with tasks like \"gather and empty trash\" or \"service, clean, or supply restrooms,\" or \"mix water and detergents or acids in containers to prepare cleaning solutions according to specifications.\" We software engineers and lawyers would be smart to start retraining (and adjusting our living standards) now! And this points to one of the ways AI will help improve society and living standards for all: we'll have cleaner, better-maintained bathrooms, as labor one wasted on engaging intellectual tasks is redirected towards menial, low-pay tasks that still need a human touch. Reason to be optimistic, amirite?" — 10111001 [c:50121809] [thread 2]
>
> （译文：简单讲，他们想 AI 拿走的正是「好工作」。AI 不会来抢「收垃圾」「清洁厕所」「配清洁液」这种活。我们这种软件工程师和律师最好早点准备转行（顺便降低生活预期）。这也算 AI 改善全社会的一种方式——把浪费在智力活上的人力导向低薪但仍要人手的体力活上，厕所会更干净。乐观，对吧？）

stouset 反驳「disinflation 一直存在」的说法：

> "I'd love to see some of that disinflation you're talking about. From my perspective, luxuries have gotten cheaper while *basic necessities* like food, housing, and medicine have become dramatically more expensive across the board. More and more it's seeming that the 'societal benefits' from the last fifty years of progress have largely been concentrated at the top." — stouset [c:50122021] [thread 2]
>
> （译文：你说的那种 disinflation 我倒想看看。在我眼里，「奢侈品」越来越便宜，「必需品」（食物、住房、医疗）几乎全线越来越贵。过去五十年「社会红利」越来越多地停在顶层。）

akavi 把这条线补成硬数据：

> "There are a thousand medicines that have experienced literally infinite deflation over 50 years: not available at any price to having a finite price. GLP-1s, Trikefta, Mavyret, Checkpoint inhibitors to name just a few recent blockbusters. People complain about insulin prices, but the insulin from 50 years ago costs 25-50 $/mo (https://www.walmart.com/cp/relion-insulin/8418641), it's the new stuff that wasn't available 50 years ago that's more expensive. Spending on food as a percent of income has declined significantly (~30%) over the past 50 years: https://ourworldindata.org/grapher/food-expenditure-share-family-disposable-income. The decline has flatlined over the past ~20 years, but at least some of that is affluence meaning we choose to eat out instead of cooking at home." — akavi [c:50122466] [thread 2]
>
> （译文：过去 50 年有过千种药品经历字面的「无限 disinflation」——以前压根没药卖，现在有了。GLP-1、Trikefta、Mavyret、Checkpoint 抑制剂是最近一批例子。大家抱怨胰岛素，但 50 年前的胰岛素每月只要 25-50 美元，贵的是 50 年前压根不存在的新药。过去 50 年食品占收入比下降约 30%，但 20 年前已经趋平，部分原因是大家有钱去吃外卖而不做饭。）

Barrin92 把比较拉到更早：

> "In the early 1900s an American household spent roughly 50% of its income on food. And mind you food didn't mean an exotic fruit you flew in from the other end of the world or pounds of meat per week. Today an American household spends 9% of their income on food, the 'dramatic increase' may have bumped that up to 10% by some measures. The size of the average house of the average American family in the last half century has doubled while the family size has halved. In the 1960s 12% of households had AC access, today it's over 80%." — Barrin92 [c:50125329] [thread 2]
>
> （译文：1900 年初美国家庭 50% 收入花在食物上——那时的「食物」不是你现在吃的异地空运水果或一周几磅肉。今天美国家庭食物占收入 9%，涨幅大一点可能到 10%。半个世纪以来美国家庭平均住房面积翻倍，家庭人口减半。1960 年代 12% 家庭有空调，今天超过 80%。）

主要负担的两块——住房和医疗——为什么吃不到技术红利：

> "3 parts of the economy least impacted by Info Tech, also two of them are heavily regulated (housing, healthcare) which can mute tech impact on prices." — jpadkins [c:50122569] [thread 2]
>
> （译文：消费支出里最少受 IT 冲击的三大块，其中两块（住房、医疗）受高度管制，技术对价格的传导被压下来。）

把这一切归到寡头提取租金的口径：

> "Bud, thinking that for-profit corporations - many of whom are in an oligopoly or monopoly position in their markets - are going to pass along savings from not paying people is like thinking the stripper really likes you. Remember how things were cheaper before the pandemic? Well, there were supply shortages and prices rose accordingly. Supply and demand at work, nothing surprising there. The supply chain shocks eventually went away. Some prices have sort-of come down, but many just haven't. Why? Because the people selling goods and services now know that people can and will pay the higher price." — lenerdenator [c:50122891] [thread 2]
>
> （译文：兄弟，幻想营利公司——很多处在寡头甚至垄断位置——会把「不给人发工资省下来的钱」让利给消费者，跟幻想脱衣舞娘真爱上你一个样。疫情前东西更便宜，是因为供给吃紧价格就上去了。供应链冲击结束后有些价格降了，但很多没降。原因：卖家现在知道消费者能也会支付那个价。）

通向裁员的链条 sedan_baklazhan 写得很直白：

> "Automating most jobs means extraordinary unemployment. Which doesn't play well with 'savings for consumers', because these consumers will be unemployed." — sedan_baklazhan [c:50122166] [thread 2]
>
> （译文：把大多数工作自动化意味着异常高的失业率。这跟「让利消费者」难共存——这些消费者会失业。）

zeroonetwothree 给的历史比较最常被钉回：

> "300 years ago 97% of workers were farmers. We automated almost all those jobs away. Is there extraordinary unemployment? I know, this time it's different, AI is different, blah blah blah." — zeroonetwothree [c:50123627] [thread 2]
>
> （译文：300 年前 97% 的人是农民，我们把那些工作几乎全自动化了。请问今天是不是异常高失业率？我知道，这次不同，AI 不一样，blah blah。）

sedan_baklazhan 再反驳一次，定住今日与历史的差距：

> "Of course changes that happened over course of centuries can't be compared with larger changes happening (or promised to be happening) in a few years." — sedan_baklazhan [c:50123818] [thread 2]
>
> （译文：跨几个世纪的进程当然不能和「几年内正在发生（或被承诺正在发生）」的大变化相比较。）

### 一场「先自动化 automation 本身」——coding / math / compute 是 RSI 的第一批

这条线从 jpadkins 的「disinflation 不会到消费者」延展开。一批读者把话题拉回到 AI 厂商自己为什么先做 coding：

> "You automate automation first, what is so hard to understand about this? You pick the highest leverage occupation first. Automating lawyers gives you.. angry lawyers? Automating programmers gives you improved ways of doing literally all other things because all other automation requires.. automation. That is to say bucketloads of software. It's completely obvious what the play is here and it has nothing to do with pay. We pay peanuts for tokens so automating a developer for 200-500 a month worth of tokens ain't getting you to a trillion a year. RSI is the play and it's already happening. Our work is easier and faster and anyone that claims otherwise I have a very hard time taking serious." — whatissohard [c:50122174] [thread 3]
>
> （译文：先自动化 automation，这有什么难理解的？挑杠杆最高的职业。自动化律师，得到的是愤怒的律师；自动化程序员，得到的是所有其他自动化的改进方式，因为所有自动化都需要……海量的软件。整个打法明摆着，根本不是盯工资。我们为 tokens 付的是零头，花 200-500 美元/月 tokens 把开发自动化，做不到一万亿。RSI 就是这打法，它已经发生。活比过去容易、快；谁说不是，我都很难认真听。）

huijzer 一句话总结为什么是 coding / math：

> "Most importantly, in these fields results can be easily verified which means that if you have enough compute, that you can generate correct training data. OpenAI had an early story - which could be a lie of course - about how they tried to train a robot but the actuators would be toast before the robot would have learned. Math and programming doesn't have such problems." — huijzer [c:50122273] [thread 3]
>
> （译文：关键在于这两个领域的结果易验证——有足够算力，就能生成正确训练数据。OpenAI 早期有过故事——也可能是编的——说他们试过训机器人，但执行器先报废在学会之前；数学和编程没这个问题。）

bryanlarsen 把这条线钉在 AGI 的明确定义：

> "AGI is explicitly the goal, where AGI is defined as an AI that can improve itself autonomously. Training an AI to make improvements to itself is training an AI to program." — bryanlarsen [c:50122277] [thread 3]
>
> （译文：AGI 就是这个目标，AGI 的定义就是「能自主改良自己的 AI」。让 AI 自我改良就是让 AI 编程。）

但「RSI 已经在发生」这种说法被反复驳回：

> "Doing work more efficiently through the use of LLMs is not RSI. RSI requires a closed loop automated LLM iteration process which we are not at all close to right now." — root_axis [c:50123791] [thread 3]
>
> （译文：用 LLM 让工作更高效不是 RSI。RSI 要的是 LLM 自我迭代的闭环，我们离那还早。）

danaris 把「重新定义 RSI」直接揭穿：

> "Before this year, 'recursive self-improvement' in the context of AI research meant the holy grail: an artificial intelligence that was capable of improving itself, unattended, in ways that humans can't even imagine, so that within a relatively short period of time, it reaches superintelligence and ignites the Singularity. What's happening now is emphatically not that. And if you think it is, you are buying straight-up propaganda. \"I gave an LLM a tool that lets it make largely-random decisions about how to train its next iteration when I tell it to do so\" bears little to no resemblance to RSI. Because it is, beyond a rounding error, *completely* missing out on the \"improvement\" part." — danaris [c:50124303] [thread 3]
>
> （译文：今年之前，「RSI」在 AI 研究里指圣杯——AI 能自主、无人监督、在人类难以想象的方向上自我改良，短期跨进超级智能、引爆奇点。今天发生的根本不是那回事。如果你觉得是，你就是在直接买宣传。「我给 LLM 一个工具让它在我命令下做大体随机的训练决策」，跟 RSI 几乎不相干——它把「改良」部分整个儿掉了。）

物理世界那一块被单独放到收尾：

> "We are bottlenecked by math, code and compute. 'Doing robotics' first without tackling the others is taking an astronomical detour which we as humanity are fond of. I find the notion we automate cognition itself first and then tackle the secondary problems quite rational." — thatsnotright1 [c:50129352] [thread 3]
>
> （译文：我们被 math、code、compute 卡着脖子。先做 robotics 而不先解决这些，是一个天文级绕路，我们人类本来就爱绕。我反而觉得「先自动化认知本身，再处理次级问题」相当合理。）

vanuatu 在隔壁 thread 把物理缺口和通用人形机器人接起来：

> "Hence the investment into general purpose robots that can do any humanoid shaped task, the market of which is all physical labour. The same robot that cleans your bathroom can also wash your dishes, fold your clothes, defend your home, fix your gutters, etc. (The bottleneck of which is the brain, aka software.)" — vanuatu [c:50124222] [thread 4]
>
> （译文：所以才有了通用人形机器人的投资，它能做人形态能做的所有事，市场就是全部体力劳动。同一个机器人既能扫厕所、也能洗碗、叠衣服、保卫家、修水槽。瓶颈在大脑——即软件。）

rightbyte 顺手给一个体量估计：

> "I spend maybe 12h a year cleaning the bathroom and the dishwasher is a robot. How is that a market to keep dozens of harmonic drives operational. Unless there is some 'post scarcity' there is no way it will be common place." — rightbyte [c:50123807] [thread 4]
>
> （译文：我一年花在扫厕所上大约 12 小时，洗碗机已是个机器人。这市场撑不起几十台 harmonic drive 跑。除非到了「后稀缺」阶段，否则不可能普及。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 代码不是瓶颈 | whstl [c:50123295] | 设计/QA/stakeholder/平台都有 ego，AI 推得动是因为大家现在更能接受 slop |
| Stakeholder 是公司进化的必然 | keeda [c:50121996] | 公司越大 agenda 冲突越多，「stakeholder」是组织规模化的代价 |
| 软体工程师 80% 是吵架 | qurren [c:50121594] | 软体工程师 80% 时间花在跟 stakeholder 吵架 |
| 「jobpocalypse 迟到」原因 | verdverm [c:50121239] | 大量工作没有紧反馈环，所以生产率增益是长期 2% 而不是末日式的 |
| AI 让非技术同事瞎拍板 | eraclide [c:50121773] | AI 让所有「厨子」都觉得自己懂技术决策 |
| Disinflation 只在奢侈品上 | stouset [c:50122021] | 必需品（食品、住房、医疗）过去 50 年越来越贵 |
| 食品占收入比硬数据 | akavi [c:50122466] | 50 年来食品占收入下降约 30%，但 20 年前已趋平 |
| 住房与医疗紧管制 | jpadkins [c:50122569] | 三大消费支出最少受 IT 冲击，其中两块高度管制 |
| 资本不让利 | lenerdenator [c:50122891] | 寡头公司不会让利，疫情后价格不回落本身已是证据 |
| 历史比较失效 | sedan_baklazhan [c:50123818] | 农业转工业是几个世纪跨度，今天的跨度只几年，城市与服务业没对应增量 |
| 「先自动化 automation」 | whatissohard [c:50122174] | coding 是最高杠杆职业，所有自动化都得先有软件 |
| 「RSI 已经在发生」被驳回 | root_axis [c:50123791] | LLM 让工作更高效不是 RSI，闭环自我迭代还远 |
| RSI 是 AGI 的定义 | bryanlarsen [c:50122277] | 让 AI 自我改良就是让 AI 编程，这正是 AGI |
| 物理劳动缺口 | vanuatu [c:50124222] | 通用人形机器人覆盖 63% 物理任务，瓶颈在软件不在硬件 |

## 总体情绪

讨论大致沿着 Mercor 那张图给的数字撕开，但分辨很清楚：

- **实践派**说 90% 的工作时间之所以不可基准化，是因为绝大多数时间本来就不进入可训练、可验证、可调度的循环——stakeholder 政治、ego、流程延迟、反馈环缺失。Mercor 的图把这部分结构性地 visible 化了，所以 HN 的反应不是「AI 进不去」，而是「本来就没想让 AI 进」。
- **政治经济学派**说 AI 节省的美元大概率不到消费者手里。原因链是：住房和医疗是高度管制 + 长期寡头化；过去半个世纪的技术红利集中于消费品（CPU、存储、外卖），并未延伸到必需品；这次进步又会被资本市场截留。zeroonetwothree 给的农业历史比较在这条线下被驳回得很彻底——「农业转工业是几个世纪跨度，城市与服务业一直在吸纳」，今天的跨度只几年，没有对应增量。
- **自动化自体派**说 coding / math / compute 是 AGI / RSI 的天然首选区，因为可验证、有算力、有源源不断的训练数据；其他领域先不上不是因为不能，是 ROI 最高的先上。这一派的内部论战核心是 RSI 这个词被滥用——「我用 LLM 把活干快了」 ≠ 「AI 在自我迭代」，danaris 的反驳把这条线封死。

最后一条隐性收束：Mercor 那张图 90% 没覆盖的工时里，物理世界那一块（按 Dingel & Neiman 口径约 63%）几乎注定要等通用机器人的软件瓶颈解决，而软件瓶颈的加速恰好要靠 coding 自动化的持续推进。两条线在这端相会又分岔——同一份焦虑的两种解读。

整体语气谈不上乐观，也不是末日，更像是工程师与经济学家在「AI 真实能影响什么」这件事上重新划界。一半精力在算预期收入，一半精力在算预期支出，双方都不愿先认输。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Mercor — A benchmark map of the US economy | <https://www.mercor.com/research/labor-index/benchmark-map/> |
| 2 | HN 主帖 | <https://news.ycombinator.com/item?id=50121179> |

## 免责声明

<div class="disclaimer">
本文为 Hacker News 讨论摘要，原始版权归原作者及 Hacker News 社区所有。
引文原文遵循原作者授权（CC-by-3.0 引文豁免）；中文译文部分基于原文意义译出，仅供阅读参考。

⚠ 本次讨论涉及「AI 红利流向」「自动化与失业」「劳动力份额」等话题，所引观点按原帖立场呈现，不代表本项目立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
