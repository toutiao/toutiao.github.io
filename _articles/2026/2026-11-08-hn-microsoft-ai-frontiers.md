---
layout: post
title: >-
  微软 AI Frontiers 解散：50 人研究组并入只信 scaling 的 Microsoft AI — HN 讨论摘要
date: 2026-11-08
hn_id: 50406563
categories: [articles]
excerpt: >-
  研究组长亲口给了两个理由：创新送不进产品，MSR 的基本契约也断了。评论区真正吵开的却是另一件事——scaling 还能撑多久，那笔 token 账已经对不上。
tagline: >-
  不是没做出东西，是做出来的东西进不了产品：50 人的前沿组被并进了 MAI。
---

> 来源：HN 讨论主帖 [The end of Microsoft Research's AI Frontiers group](https://news.ycombinator.com/item?id=50406563)（236 分，137 条评论），原文是 Langford 写在 hunch.net 上的告别文章。本篇为 single post 模式；归档快照 2026-11-07 21:33 UTC，入库 100 条评论。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

2023 年 ChatGPT 发布之后，Langford 和 MSR 里的几位同事决定把研究组织起来。理由写在原文里：靠一个人推进一个好点子，跑不快，基线也攒不够，想法多半会来得太晚、说服力不足。AI Frontiers（AIF）就这样成立，规模约 50 人。

AIF 的产出是可以点名的：Autogen 编排框架、Fara computer use agent，以及纽约团队做的几项基础工作——Next Latent objective（用于外推）、Dion3（一个优化改进过的 Muon）、Full Bandwidth Transformer（靠递归让模型在不加算力的前提下大幅变强）。他们还建了一个默认对整个 MSR 共享的 monorepo，里面装着作者上个月 COLM keynote 讲的 edge scale pretraining 代码库；他顺手补了一句：至少还有 3 个类似的模型流水线项目正在别处同时做，而「把一条能用的模型流水线做成型」本身就要花掉不少力气。

转折是 2026 年 9 月初，AIF 被重组进 Microsoft AI（MAI）。作者对这次合并的判断相当负面：MAI 的领导层来自 Inflection，核心哲学是 scaling，而且明确排除 research。他的理由是商业的——更大的模型确实带来更好的预测质量，而从投资回报的可预测性看，规模远胜于研究。后果是，在只谈规模的环境里，主要精力自然落到获取、制造和精炼数据上，离他们做的事已经很远。他随后加了一句更直白的判断：除了方向不兼容，还有大量证据表明他们并不真的想要我们。

他没有回 MSR，理由也是两条。一是他不愿意待在一个「我做的研究没有任何通向实际使用的路径」的公司——在 MAI 时期他既没法把创新推进使用，甚至没法让它被认真考虑，所以从 MSR 出发的成功预期很小。二是他担心 MSR 的基本契约已经破了：做好工作，好事就会发生；而按他的说法，我们做好了工作，然后被非自愿地重组掉。他还提到明年不会有 AIF 的实习岗位。

他给 scaling 算了一笔账：字节跳动的实验显示，Full Bandwidth Transformer 的某个变体可能与规模大两倍的模型相当，也就是同等能力下训练和推理成本可以减半。原文的原话是：Do the math—how much is it worth to halve training and inference cost given that the industry has investments approaching a trillion dollars?

## 讨论焦点

### 一、标题读错了：一个 50 人小组的安置，不是「微软放弃 AI 研究」

最早指出歧义的是 smokel：

> "This refers specifically to &quot;AI Frontiers&quot;, a research group within Microsoft Research that focuses on fundamental advances in AI.  There is no end in sight to real AI frontiers." — smokel [c:50406763]
> （译文：这说的具体是「AI Frontiers」，即微软研究院内部一个专注 AI 根本性进展的研究组。真正的 AI 前沿还看不到尽头。标题改成「微软研究院 AI Frontiers 小组的终结」，大概会少一些歧义。）

shermantanktop 说得更尖：

> "The headline makes good bait for AI skeptics. But this is a team of 50 people with a grandiose name." — shermantanktop [c:50406925]
> （译文：这个标题很适合拿来钓 AI 怀疑论者。但说到底，这是一个 50 人、名字取得很大的小组。）

他同一条评论里给出了另一个更值得讨论的判断：

> "The more interesting idea is that MS has abandoned AI research entirely, presumably because their zillions invested in other companies are a better bet in that area." — shermantanktop [c:50406925]
> （译文：更有意思的想法是，微软已经彻底放弃了 AI 研究，大概是因为它在别的公司砸下的巨额投资，在那边是更好的筹码。）

原文其实在 HN 上被提交了两次：主帖 18:02 UTC 由 srean 提交，两分钟后 andsoitis 又用同一链接提交了一次，标题更短（The End of AI Frontiers）。评论区为此还讨论了一轮该把哪条链接放在前面：

> "This should be the main link" — muglug [c:50406767]
> （译文：这个应该做主链接。）

> "Ok we&#x27;ll use that above. Thanks!" — dang [c:50407336]
> （译文：那我们改用上面那个。谢谢！）

sheepscreek 承认自己一开始也读错了：

> "Yeah, I went down the rabbit hole scratching my head the whole time. This is about the group at Microsoft Research that was disbanded or reorged into what is now Microsoft Research." — sheepscreek [c:50406860]
> （译文：我一开始也是一头雾水。这讲的是微软研究院里那个被解散、或被重组进现在 Microsoft Research 的小组。）

但读完原文，情绪立刻转向另一个方向。

> "Microsoft is a really shitty place to work right now. There are a hundred stories like this all over the company like this." — outside1234 [c:50406840]
> （译文：微软现在真是个很糟的工作地方。公司里到处都有这样的一百个故事。）

> "They&#x27;ve offered voluntary redundancy to a quite large proportion of the staff (a quarter?) so they&#x27;ll also soon be losing anyone with employment prospects elsewhere." — rwmj [c:50407040]
> （译文：他们已经向相当大比例的员工（大概四分之一？）提供了自愿离职方案，所以那些在外面还有就业机会的人也会很快走掉。）

> "Curse of money strikes again. $4tn market cap company thinks team of 50 researchers too expensive." — 2OEH8eoCRo0 [c:50407076]
> （译文：钱的诅咒再次应验。一家市值 4 万亿美元的公司，觉得 50 个研究员太贵。）

> "Hugged to death like it’s 2008 and you’ve just lit your LAMP stack." — pavlov [c:50406847]
> （译文：被「拥抱至死」——就像 2008 年你刚点起 LAMP 栈的那个时候。）

把这两条放在一起才对得上：被重组掉的是 50 人的 AIF，而评论里还有人说，微软同期向大约四分之一员工提供了自愿离职方案——用财务理由处理人，已经绕过了绩效这一关。

### 二、一条「高速公路」：scaling 派与 research 派

最早把这次重组翻译成路线之争的是 AnotherGoodName，他用了一个「高速公路」的比喻：

> "The transformer based approach is seen as a highway to race down in terms of training and building better models with minimal organizational distractions allowed while every company puts its foot down on this highway." — AnotherGoodName [c:50406862]
> （译文：基于 transformer 的路线被看成一条可以全速狂飙的高速公路——在训练和造模型上尽量少分心，而每家公司都把脚踩在这条路上。）

同一条评论里，他还给出了这条路线的信条：

> "I have the view this makes sense too. Current top models are mere (mere in big datacenter terms) trillions of parameters right now. We definitely haven&#x27;t hit the ceiling and everyone&#x27;s noticing &quot;Hey this Opus 5.5 with the increased parameters seems much better than the last one&quot;. Well that&#x27;s a trillion parameter model." — AnotherGoodName [c:50406862]
> （译文：我也认为眼下这么做是对的。当前最顶级的模型不过是（以大数据中心的标准衡量）几万亿参数而已。）

被拉来当例子的是 Meta：

> "Almost all statements Yann LeCun made back then (LLMs won&#x27;t be able to do this or that) turned out to be wrong. They were right to fire him." — redox99 [c:50406906]
> （译文：LeCun 当年说的那些话（LLM 做不到这个、做不到那个）几乎全被证明是错的。他们解雇他是对的。）

frays 认为问题不在探索本身，而在机会成本：

> "The issue isn&#x27;t the exploration itself, it&#x27;s the opportunity cost. When a figure of Yann LeCun&#x27;s influence pushes a specific direction, it pulls key talent and resources away from mainstream LLM work." — frays [c:50407145]
> （译文：问题不在探索本身，而在机会成本。当一个像 LeCun 这样有影响力的人把方向推向某处时，关键人才和资源就被从主流 LLM 工作上拉走了。）

「两个都要做」的声音同样具体：

> "What makes sense is to do both.<p>Race down the transformer highway as fast as possible <i>and</i> explore other AI methods.<p>One need not preclude the other." — jmull [c:50407618]
> （译文：合理的做法是两个都做。尽可能快地沿着 transformer 这条高速公路冲，同时探索别的 AI 方法。两者并不互相排斥。）

也有人认为 LeCun 的判断未必全错。airstrike 的说法是双重否定，值得逐字看：

> "All statements he made about world models did not already turn out to be wrong. He may be right in the long term." — airstrike [c:50407940]
> （译文：他说过的那些关于 world model 的话，并不是全都已经被证明是错的。长期来看，他可能是对的。）

frozenseven 的反驳更干脆：

> "He was against LLMs, reinforcement learning, etc. Claiming that those are a dead-end. He was wrong. His own &quot;JEPA&quot; ideas have basically gone nowhere. Meta was right in moving on without him." — frozenseven [c:50407941]
> （译文：他反对 LLM、反对强化学习，说那些是死路。他错了。他自己的「JEPA」想法基本也没了动静。Meta 绕开他继续走是对的。）

也有把这条路线批评成「无视苦涩教训」的：

> "Obviously we&#x27;ll see how it pans out, but other approaches feel a bit like trying to ignore the bitter lesson." — hn_throwaway_99 [c:50407271]
> （译文：结果如何还得看，但别的路线总有点像是在无视苦涩的教训。）

dfdydx 给了一个更干净的框架：

> "It’s a simple exploration&#x2F;exploitation trade off. Always explore, never exploit is probably not the optimal strategy every time." — dfdydx [c:50407909]
> （译文：这就是个简单的探索/利用权衡。每次都只探索、从不利用，大概不是最优策略。）

ion_trapper 评价的是人：

> "I empathize with LeCunn but he is a prime example of why scientists often make poor leaders. It’s too tempting to always do the cool and interesting thing instead of drilling down on the boring but reliable thing that actually creates value." — ion_trapper [c:50407797]
> （译文：我同情 LeCun，但他是「科学家常常做不好领导者」的典型例子。总是去做那个酷、有趣的事，而不是死磕那个无聊但可靠、真正创造价值的事，实在太有诱惑力了。）

### 三、scaling 的物理账：参数、token 与数据中心

这是本帖最硬的一段。先是参数和 token 的配比：

> "100 trillion parameters doesn&#x27;t make any sense if your dataset is ~30 trillion tokens. My uneducated guess is 1&#x2F;10 compression ratio is good and that point to ~300 to ~1000 trillion tokens, which again, doesn&#x27;t make any practical sense." — liuliu [c:50407477]
> （译文：如果你的数据集只有约 30 万亿 token，100 万亿参数根本讲不通。我这个外行猜 1/10 的压缩比算不错，那就指向 300 万亿到 1000 万亿 token，而这同样没什么实际意义。）

扩展轴其实已经换过一次：

> "From the outside it seemed like GPT 4.5 was the apogee of parameter size scaling and since then a huge investment in RLVR became the new scaling axis." — qlte [c:50407891]
> （译文：从外面看，GPT 4.5 似乎就是参数规模扩展的顶点；此后大规模投入 RLVR 成了新的扩展轴。）

> "It is also my understanding that Opus 5.5 is probably a well under 10T parameter model. Probably a similar size class to Fable 5 earlier. And supposedly even GPT-4 was a 1T model. Clearly most of the gains are coming from something other than scaling up the model size. Yes, scaling up RL counts as scaling too, but the fact that labs have pivoted to a different axis of scaling is evidence that it&#x27;s not just a &quot;straight highway&quot; to improve LLMs." — markasoftware [c:50407736]
> （译文：显然大部分收益来自把模型做大以外的东西。把 RL 规模也算作扩展的一种，但各家实验室已经转向了另一条扩展轴，这本身就说明改进 LLM 不是一条「直路」。）

Chinchilla 这条线也早就过期了：

> "The Chinchilla paper is probably the poster child of “paper that aged like milk” in LLM field though. Everyone over the past 4 years have trained with several orders of magnitude more data than the Chinchilla optimal number." — stymaar [c:50408221]
> （译文：Chinchilla 那篇论文大概是 LLM 领域「像牛奶一样变质的论文」的典型标本。过去 4 年里，大家训练用的数据都比 Chinchilla 给的最优值多了好几个数量级。）

zer00eyz 的结论更狠：

> "Chinchilla Law says no, we wont. We&#x27;re likely well past the point of diminishing returns but MOE hides a fair bit of it." — zer00eyz [c:50407550]
> （译文：Chinchilla 定律说了，我们不会有的。我们多半早已越过收益递减的拐点，只是 MoE 把其中一部分藏起来了。）

> "This is where the real gains for AI come from - good enough and CHEAP is going to win the day here (brute force, mixture of models). It&#x27;s the engineers displacing the academics - and that will mean a bloodbath for revenue (see DeepInfer for what the end game looks like)." — zer00eyz [c:50407550]
> （译文：AI 真正的收益会来自这里——够用且便宜才是王道（暴力堆量、模型混合）。是工程师在取代学者，而这意味着收入上的一场大洗牌（终局的样子可以看 DeepInfer）。）

kylestanfield 一句话戳破效率焦虑：

> "Everyone wants radically more efficient AI. That doesn’t mean it’s coming any time soon. And when models are twice as efficient, guess what happens next. We try making one twice as big for the same cost." — kylestanfield [c:50408091]
> （译文：人人都想要效率高得多的 AI。但这不代表它马上就来。而当模型效率翻倍之后，接下来会发生什么？用同样的成本做一个两倍大的模型。）

至于「定律」到底是什么：

> "As far as I know, there isn’t - it’s purely empirical curve fitting. Train a model with different amount of compute &#x2F; data &#x2F; parameters, measure performance, fit curve." — dfdydx [c:50407931]
> （译文：据我所知没有——纯粹是经验曲线拟合：用不同的算力、数据、参数训练模型，测性能，然后拟合曲线。）

> "It should be noted that these laws aren&#x27;t, well, laws; <i>&quot;a neural scaling law is an</i> empirical <i>scaling law that describes how neural network performance changes as key factors are scaled up or down.&quot;</i>. Notice the word empirical here." — joe_the_user [c:50408165]
> （译文：得说明一下，这些「定律」其实并不是定律：「神经扩展律是一种经验性的扩展律，描述当关键因素被放大或缩小时，神经网络性能如何变化。」注意这里的「经验性」这个词。）

token 从哪来是另一笔账：

> "From your link:<p>&gt; for every doubling of model size the number of training tokens should also be doubled<p>Well, I don&#x27;t think many claim that increasing the model size while also increasing the training tokens doesn&#x27;t make sense.<p>The problem is how to get the training tokens..." — luke5441 [c:50408133]
> （译文：从你给的链接看：「模型规模每翻一倍，训练 token 数也应该翻一倍。」我不觉得有多少人主张「把模型规模增大、同时把训练 token 也加大」这件事说不通。问题在于 token 从哪来……）

再往外一层是物理约束：

> "Ignoramus question: does the 100s of trillions of parameters world still exist with a constrained domestic data center build out? Democrats are signaling they are about to go psycho mode on data center contracts." — rib3ye [c:50408216]
> （译文：请原谅我这个外行：在国内数据中心建设受约束的情况下，「几百万亿参数」的世界还成立吗？民主党人正在放话要对数据中心合同下狠手。）

以及一个更根本的追问：

> "What if scaling fails to hold at a certain point? Whether that is a steep or gradual dropoff in returns. What happens to the empires of accumulated compute? How much value do they immediately lose once the returns to scaling ceiling is reached?" — gradus_ad [c:50407950]
> （译文：如果 scaling 在某个点上不再成立会怎样？无论收益是断崖式还是缓慢下滑。那些靠积累算力建起来的帝国会怎样？一旦触及 scaling 的天花板，它们会立刻损失多少价值？）

这一节其实把原文里那条「成本减半」的期待一并降级了：连 token 数量和数据中心能不能跟上都还没算清楚，那笔账就无从谈起。

### 四、大公司为什么养不起「支线」

原帖说 AIF 被并进了 MAI，评论区里最尖锐的追问是：为什么不干脆让它独立存在。

> "These corporations have an obscene amount of money<p>This is a false dichotomy if I ever saw one<p>Why not hedge and just keep an ai skunkworks team working? These companies are big enough that they can have these people far away from the main work without distraction or without starving those teams of bandwidth" — gxs [c:50408139]
> （译文：这些公司钱多得荒唐。这是我见过最典型的伪二分。为什么不干脆对冲一下，养一个 AI 版的 skunkworks 小队？这些公司足够大，完全可以把这帮人放在离主战场远一点的地方，既不让他们分心，也不至于把他们的带宽饿死。）

dragonwriter 讲的是更一般的规律：

> "Its not a bad thing, but exploratory research as opposed to reaearch that finetunes along a path already paved by exploratory research is something that doesn’t usually happen much in for-profit product-oriented firms when there is such a path available" — dragonwriter [c:50407742]
> （译文：这本身不是坏事，但「探索性研究」和「沿着探索性研究已经铺好的路继续微调」不一样；在这条路已经存在的情况下，探索性研究在以营利为导向的公司里通常不会发生太多，它更多发生在学术界，等基本原理显示出商业前景后再被公司接手。）

（这条引文的原文把 research 拼成了「reaearch」，是评论者随手敲的，此处照录。）

pyrale 把原因指向钱本身：

> "...And because they have monopoly money. Basically, research labs are usually vanity spending for corporations with too much money. Xerox parc was funded by a monopoly. Bell labs was funded by a monopoly. Google funds its moonshots with its monopoly." — pyrale [c:50408178]
> （译文：……还有因为它们有垄断的钱。基本上，研究实验室对钱太多的公司来说就是一项 vanity 支出。Xerox PARC 是垄断养出来的，贝尔实验室是垄断养出来的，Google 的登月项目也是用垄断资金养出来的。）

bigfatkitten 给出反面清单：

> "Those exploratory &quot;side quests&quot; in industry are how we got the transistor, the liquid crystal display, Shannon&#x27;s information theory, the laser and practical photovoltaic cells, among many other foundational technologies upon which we rely today." — bigfatkitten [c:50408185]
> （译文：工业界那些探索性的「支线」，正是晶体管、液晶显示器、香农的信息论、激光和实用光伏电池的来源，以及今天我们赖以生活的许多其他基础技术。）

更悲观的判断来自 antonvs：

> "Real research at most big companies is dead. Unfortunately, what has replaced it is mostly venture-backed startups, where the timeline to a return is still expected to be quite short." — antonvs [c:50406939]
> （译文：大多数大公司的真研究已经死了。不幸的是，取代它的是风投支持的创业公司，而那里的回报周期预期依然很短。）

> "As a result, you end up with companies doing basic research under the guise of developing a product, announcing timelines which are never going to be met." — antonvs [c:50406939]
> （译文：结果就是，你看到一堆公司打着做产品的旗号做基础研究，宣布的时间表永远不可能兑现。）

esseph 一句话收尾：

> "This is a prime example of why large companies have a problem innovating.<p>Once you get close to the top, the risks don&#x27;t look worth it." — esseph [c:50407664]
> （译文：这正是大公司难以创新的典型例子。一旦你接近了顶部，那些风险看上去就不值得冒了。）

Toyota 与 Ford 的类比是本帖最生动的一段：

> "Umm no. There’s the old factory way to build things like Ford model T; and then there’s the f*king Toyota method!" — whatthejesus [c:50407358]
> （译文：不。有造福特 T 型车那种老工厂做法，也有他妈的丰田式做法！）

0xbadcafebee 把这个类比展开到「只优化效率要付出什么代价」：

> "Ruthlessly optimizing isn&#x27;t the best goal, because people &quot;optimize&quot; all the quality out, and lack of quality leads to lack of sales and increased cost. Ford&#x2F;GM may have &quot;optimized&quot; their line for efficiency, but the increase in defects caused more losses. Companies that practice Lean tend to forget this and focus only on speed and cost, leading to enshittification." — 0xbadcafebee [c:50407875]
> （译文：无情地优化不是好目标，因为人会把质量「优化」掉，而质量一掉，销量就掉、成本就升。福特和通用可能把产线「优化」得更有效率，但缺陷增加带来的损失更大。搞精益的公司往往忘了这一点，只盯速度和成本，最后搞成 enshittification。）

> "And that&#x27;s what&#x27;s happening with AI. While there are plenty of players now, it&#x27;s the ones that aren&#x27;t looking ahead that will be left behind. Nothing scales forever; when you hit the ceiling, you&#x27;re trapped in a box of your own making." — 0xbadcafebee [c:50407875]
> （译文：AI 正在发生的也是这件事。现在玩家很多，但会被甩下的是那些不往前看的。没有什么能永远扩展；等你撞上天花板，就被困在自己造出的盒子里。）

tehjoker 则把「该不该」和「能不能」拆开：

> "I&#x27;m not an AI booster (in a &quot;should&quot; not &quot;can&quot; sense), but in terms of &quot;can&quot; we are going to see next generation hardware (i.e. Vera Rubin GPU architecture)" — tehjoker [c:50407782]
> （译文：我不是 AI 鼓吹者（在「该不该」的意义上不是），但在「能不能」的意义上，我们会看到下一代硬件（比如 Vera Rubin GPU 架构）和模型密度的提升……）

而效率提升本身也不等于问题变少：

> "Do you think humanity is just going to run out of problems that need the smartest intelligence?<p>If so, then yeah, increasing efficiency 100x means we hit that point much faster.<p>If not, then it just means we make improvements 100x faster." — senordevnyc [c:50407881]
> （译文：你觉得人类会不会只是把需要最聪明智能的问题都用光了？如果是，那把效率提升 100 倍意味着我们更快撞到那个点；如果不是，那只意味着我们改进的速度快了 100 倍。）

### 五、离开之后：AIF 的东西会去哪

原帖说作者把手下的人安顿好然后离开，也说不回 MSR。评论区给这个结局补了几种解释。

最有想象力的是 thepace：

> "If MS abandoned a promising idea, pursuing it outside makes perfect sense. I am sure there are investors willing to fund this. This could even be an opening to attack the moat of the current AI frontier model companies." — thepace [c:50407508]
> （译文：如果微软放弃了一个有前景的想法，带到外面继续做完全说得通。我敢肯定有投资人愿意出钱。这甚至可能是一个去攻击当前前沿模型公司护城河的口子。）

srean 给出的是更冷的解释：

> "When a company pays billions to OpenAI, any activity that does not do a glorious dance in praise and support of that investment is taken to be an act of disloyalty." — srean [c:50406907]
> （译文：当一家公司给 OpenAI 付了几十亿美元，任何不为这笔投资跳一支赞美的舞的活动，都会被当成不忠。）

sigbottle 指出原文没正面回答的那个问题：

> "This doesn&#x27;t engage with the article in the precise way that <i>transformer-based improvements</i> and fundamental research that way are not being incorporated into models, at Microsoft AI, which is concerning." — sigbottle [c:50407639]
> （译文：原文没有正面回应这一点：像 transformer 式的改进和这类根本性研究，并没有被并进 Microsoft AI 的模型里，这让人担心。）

至于模型到底还在不在进步，评论区吵的是体感。surgical_fire 说：

> "I barely notice any improvements ever since... 4.6? At least for software development.<p>Opus makes the same sort of mistakes and has the same sort of strengths ever since that point in my perception. My impressions is that increasing the number of parameters clearly has diminishing returns." — surgical_fire [c:50407499]
> （译文：自……4.6 之后，我基本察觉不到改进，至少在软件开发上是这样。在我看来，Opus 犯的错和它的强项从那以后都没变过。我的印象是，增加参数数量的收益明显递减。）

AnotherGoodName 反驳的点是时间间隔太短：

> "Well 4.6 was released Feb this year.<p>As in your statement to me indicates that you clearly see the scaling working over longer timespans. You chose a relatively recent 2026 model as your baseline after all, not a 2025 model or earlier. You clearly see that the 2026 model is better than ones in the past.<p>Might i suggest that you perhaps just don&#x27;t see the improvement as clearly when comparing iterations that are fairly close together? If you&#x27;re not anecdotally seeing improvement between an early 2026 model and one from ~6 months later perhaps just give it another iteration? Personally i do see 5.5 as much better but i can understand not seeing a lot of difference to 4.6 since they literally aren&#x27;t that far apart in releases." — AnotherGoodName [c:50407658]
> （译文：4.6 是今年 2 月发布的……我个人确实觉得 5.5 好很多，但也能理解为什么有人看不出它跟 4.6 有多大差别，两个版本发布的时间本来就没隔多远。）

还有人把话说得更冷：

> "Something tells me the only “good thing” in those two companies is the pay.<p>They look more like complete organizational shit shows." — xondono [c:50407314]
> （译文：总让我觉得那两家公司唯一的好事就是薪水。它们看起来更像彻底的组织烂摊子。）

也有人替离开的决定留了余地：

> "The fact that someone made a mistake before doesn&#x27;t mean that they will always make wrong calls." — hikarudo [c:50408251]
> （译文：一个人以前犯过错，不代表他以后会一直做错判断。）

benatkin 则说自己越来越同情 LeCun：

> "I&#x27;m becoming more sympathetic to LeCun&#x27;s views, but being able to train something that acts the tiniest bit like those who made the training data (authors, professors, researchers, etc) is an absolute juggernaut and will be for some time." — benatkin [c:50407539]
> （译文：我越来越同情 LeCun 的观点了，但能训练出一种哪怕只有一点点像训练数据制造者（作者、教授、研究员等）那样的东西，绝对是一头猛兽，而且会是这样一段时间。）

而 siva7 看到的是另一类人：

> "except they weren&#x27;t part of the revolution and still don&#x27;t want to accept the reality that their research has become obsolete." — siva7 [c:50407601]
> （译文：只不过他们不是这场革命的一部分，而且仍不愿接受一个事实：他们的研究已经过时了。）

bmitc 的总结最简短：

> "It seems to me that everyone is in &quot;always exploit&quot; mode.<p>Seems weird when it&#x27;s become apparent that LLMs aren&#x27;t really special sauce outside of just having the compute." — bmitc [c:50407943]
> （译文：在我看来大家都处在「永远只利用」的模式里。可当人们已经发现 LLM 的特殊之处不过是算力本身时，这就很奇怪了。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题有歧义，读错了对象 | smokel | 说的是 50 人的 AIF，不是 AI 前沿本身 |
| 标题成了怀疑论者的诱饵 | shermantanktop | 名字很大，人只有 50 个 |
| 微软现在是很糟的工作地方 | outside1234 | 公司里到处是这类故事 |
| 裁员绕过了绩效 | rwmj | 四分之一员工的自愿离职方案 |
| 财务理由压倒一切 | 2OEH8eoCRo0 | 4 万亿市值嫌 50 个研究员太贵 |
| transformer 是一条高速公路 | AnotherGoodName | 全公司都把脚踩上去 |
| 当前模型还远没到天花板 | AnotherGoodName | 顶级模型才几万亿参数 |
| Meta 解雇 LeCun 是对的 | redox99 | 他当年的判断几乎全错 |
| 问题在机会成本 | frays | 有影响力的人会拉走关键人才 |
| 两个都要做 | jmull | 冲高速公路和探索别的方法不冲突 |
| LeCun 长期看可能是对的 | airstrike | 关于 world model 的话没有被证伪 |
| JEPA 本身也没了动静 | frozenseven | 他反对 LLM 和 RL 的判断是错的 |
| 这是探索/利用的权衡 | dfdydx | 只探索不利用不是最优策略 |
| 科学家常常做不好领导者 | ion_trapper | 酷的事总比无聊但可靠的事有诱惑力 |
| 100 万亿参数配 30 万亿 token 不成立 | liuliu | 得先有 300 万亿到 1000 万亿 token |
| 扩展轴已从参数换成 RLVR | qlte | GPT 4.5 是参数扩展的顶点 |
| Chinchilla 早就过期 | stymaar | 大家都比最优值多训了几个数量级 |
| 已过收益递减点 | zer00eyz | MoE 只是把一部分藏起来了 |
| 真正的收益在「够用且便宜」 | zer00eyz | 工程师正在取代学者 |
| 效率翻倍后就做两倍大 | kylestanfield | 效率焦虑自我实现 |
| 那些不是定律 | dfdydx | 只是经验曲线拟合 |
| 量的不是「智能」 | joe_the_user | 扩展律是经验规律 |
| token 从哪来才是问题 | luke5441 | 参数翻倍 token 也要翻倍 |
| 数据中心建设是硬约束 | rib3ye | 几百万亿参数的世界未必存在 |
| 算力帝国会瞬间缩水 | gradus_ad | 触及天花板后损失多少价值 |
| 大公司养不起支线研究 | gxs | 养个 AI skunkworks 不就行了 |
| 探索性研究属于学术界 | dragonwriter | 公司等有商业前景再接手 |
| 研究室是垄断钱养出来的 | pyrale | Xerox PARC、Bell Labs、Google 月球计划 |
| 支线带来了晶体管和激光 | bigfatkitten | 今天的基础技术都来自「支线」 |
| 大公司的真研究已经死了 | antonvs | 取代它的是回报周期很短的风投公司 |
| 越接近顶部越不敢冒险 | esseph | 大公司创新难的典型 |
| 精益会牺牲质量 | 0xbadcafebee | 只盯速度和成本，最后 enshittification |
| 效率提升 100 倍不等于问题变少 | senordevnyc | 要么问题用完，要么改进快 100 倍 |
| 离开可能是进攻机会 | thepace | 攻击前沿模型公司的护城河 |
| 拿了 OpenAI 的钱就得围着转 | srean | 不赞美那笔投资就是不忠 |
| 原文没回答模型那一层 | sigbottle | 根本研究没被并进 MAI 的模型里 |
| 模型进步已经难以察觉 | surgical_fire | 参数增加的收益明显递减 |
| 版本间隔太短，看不出差别 | AnotherGoodName | 4.6 才发布半年 |
| 以前犯错不代表一直错 | hikarudo | 一次误判不能定终身 |

## 总体情绪

这帖的读法有两层，评论区的注意力也正好分在这两层。原文讲的是一次组织安置：50 人的组被并进一个只信 scaling 的部门，作者认为创新送不进产品，于是连 MSR 也不回。多数读者读完先愣了一下，然后不约而同地把它读成了别的故事——「微软放弃 AI 研究」。shermantanktop 说标题成了钓怀疑论者的诱饵，而真正有意思的判断藏在他后半句：微软大概觉得，砸在别处的巨额投资是更好的筹码。

真正吵起来的是 scaling 这条路线还能撑多久，而这部分的算术比原文更硬：token 不够、Chinchilla 过期、数据中心受限、scaling 一旦到顶算力帝国立刻缩水。所以最有意思的错位是，原文讲的是「研究派输给了 scaling 派」，评论区则把 scaling 派自己的账也翻了一遍——zer00eyz 说真正会赢的是「够用且便宜」，kylestanfield 说效率翻倍只会让人去做两倍大的模型，dfdydx 说那些「定律」从来只是经验拟合。等两边都把话说到底，剩下的其实只有一句：这条路确实有效，只是没人说得清它还剩多长。

结束在 thepace 那条有点兴奋的猜测上——一个被放弃的方向带出去做，很可能就是下一个前沿模型公司的护城河被撬开的地方。至于 AIF 那些具体的东西（Autogen、Fara、Full Bandwidth Transformer），讨论里几乎没人提；在评论区眼里，被解散的不是某个方向，而是一家公司愿意为一个方向留出 50 个人的那种耐心。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | The end of Microsoft Research's AI Frontiers group（HN 主帖） | <https://news.ycombinator.com/item?id=50406563> |
| 2 | 原文：The End of AI Frontiers – Machine Learning (Theory)（Langford） | <https://hunch.net/?p=13764006> |
| 3 | 评论中引用的另一篇讨论：AI is dramatically accelerating AI research | <https://news.ycombinator.com/item?id=50397994> |
| 4 | 同一篇文章的另一次提交：The End of AI Frontiers | <https://news.ycombinator.com/item?id=50406589> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 236 分、137 条评论，归档快照 2026-11-07 21:33 UTC，入库 100 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。原文作者署名 Langford 系依据评论区指认（评论 50406832），原文正文内未标注作者名，本站未另行核实。文中关于同一篇文章二次提交（HN item 50406589）、两位提交者（srean、andsoitis）及其提交时间与分数的信息，由 HN Algolia 接口核对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于微软自愿离职比例、Opus/GPT-4 参数规模、数据中心建设等说法均来自评论者本人，本站未做独立核实。本站与 Microsoft、Google、Meta、OpenAI、Anthropic 等公司无利益关系。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
