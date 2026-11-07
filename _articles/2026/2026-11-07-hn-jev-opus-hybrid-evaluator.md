---
layout: post
title: >-
  便宜模型先审、拿不准再问 Opus：Jev 混合评估器的 4 倍成本争议 — HN 讨论摘要
date: 2026-11-07
hn_id: 50397429
categories: [articles]
excerpt: >-
  便宜模型先审、拿不准再问 Opus：Jev 混合评估器在难例上做到 95.3%，比 Opus 单独跑还准，
  每千条身份只要 2.94 美元。评论区一半在争「4x lower」这四个字算不算数，另一半在质疑
  校准曲线到底能不能读出结论。
tagline: >-
  省钱的关键不是更聪明，是知道自己什么时候不够聪明。
---

> 来源：HN 讨论主帖 [A Jev that can ask Opus for help gives Opus accuracy at 4x lower cost](https://news.ycombinator.com/item?id=50397429)（468 分，107 条评论），原文是 Hightouch 团队的 Albert Jin、Neil Desai、Delaney Mackenzie 于 11 月 4 日发布的技术博客。本篇为 single post 模式；归档快照 2026-11-07 09:42 UTC，入库 101 条评论。

## 原文概要

原文要解决的是一个很脏的商业问题：identity resolution（IDR）——把同一个人的多条数据记录合并成一个身份。最麻烦的错法叫 over-merge，两个不同的人被并成了一个人。麻烦在于真实数据里没有标准答案可以对：合并完了你才知道错了，而想估计 over-merge 率，人工抽查大概每小时 50 个身份，要把这个比率的误差压到 ±1% 以内，需要抽样 1000 个以上。

Hightouch 的做法是让模型当裁判。他们用 IHME（华盛顿大学健康指标与评估研究所）的 pseudopeople 造了一个虚构的美国小镇，把真实世界的脏数据错误掺进去——拼写错误（Valentino 变 Valentinp）、认错字符（Sam 变 5am）、日期日月颠倒（02/17/2020 变 17/02/2020）、填了同住亲属的生日、昵称（Robert 变 Bob）、占位名（Female Child）、字段留空（Mendoza 变空）。1000 个身份里，一半是同一个人的噪声版本，一半是 over-merge。

提示词也分两步。第一步列出上面这些错误类型，让模型知道拼写错误不等于换了人；第二步交代数据来源：人口普查、两项家庭调查、WIC 福利项目、社保记录、W-2 和 1040 税表，覆盖 2020 到 2040 年。结果是每个模型在第一步提升最大，第二步只给前沿模型再加约 1 个百分点，对决策模型完全没用——作者的猜测是决策模型并不真的推理，给它背景也没用。

简单集上的成绩单（成本按每 1000 个身份计）：Claude Opus 5.5 准确率 99.0%、2.2 秒、3.86 美元；Gemini 3.1 Pro 98.3%、4.48 美元；GPT-6 Sol 98.3%、2.50 美元；GPT-6 Luna（Decisions API，70% 阈值）97.3%、0.17 秒、0.10 美元；Jev（60% 阈值）95.7%、0.15 秒、0.05 美元。决策模型比前沿模型便宜到 90 倍、快 10 倍以上，代价是在难例基准上落后 Opus 约 6 个百分点。

难例集才是这篇博客的战场：造出同名双胞胎、父子同姓、生日等关键字段互相冲突的样本。此时 Opus 掉到 95.1%（每千条 5.39 美元），Jev 单独只剩 89.1%、Luna 单独 88.8%；但把「置信度落在 30–90% 区间才升级给 Opus」这套混合方案用在 Jev 上，得到 95.3%、每千条 2.94 美元——比 Opus 单独跑还准，还便宜近一半。同一套混合方案换成 Luna 只有 91.6%、1.15 美元。

作者把差距归到校准（calibration）上：Jev 的错误集中在 50% 置信度附近，那才是校准良好的模型该有的样子；Luna 在 90–100% 那一档却「壮观地过度自信」。结论一句话——便宜模型的价值不在它答得多准，而在它知不知道自己答不准。

## 讨论焦点

### 一、「4x lower」这四个字，被评论区反复解剖

一场严肃的成本实验，评论区先抓的是标题的数学表达。intervolz 的吐槽只有一句：

> "4x lower is so mathematically awkward." — intervolz [c:50398180]
> （译文：「4 倍更低」在数学上实在太别扭了。）

mjuarez 把话说完整，给出了替代写法：

> "Like a comment on another thread, 0.25x would be the much better way to say this.  It&#x27;s 25% of the original value.  It&#x27;s also consistent: If 3x means 300% the original value, then 0.25x is 25% of the original value." — mjuarez [c:50398806]
> （译文：就像另一个帖子里说的，写成 0.25x 会好得多。它就是原价的 25%，而且前后一致：3 倍既然指原值的 300%，那 0.25 倍就该指原值的 25%。）

他的论点很实在：「4 倍更低」把「低于 x 倍」和「高于 x 倍」两套语义搅在了一起，而 0.25x 没有这个问题。jcelerier 则从语言学角度回了一句，语气并不服软：

> "where does it say in the rulebook that human languages have to have perfectly symmetric pairs of words?" — jcelerier [c:50399416]
> （译文：哪条规定写着人类语言必须有成对对称的词？）

最后这条把整段讨论收到了一个玩笑上：

> "Whatever happens, surely we can unite against the Crazed Barbarians who use percentages. :)" — Terr_ [c:50400979]
> （译文：不管怎样，我们总该联合起来反对那帮用百分号的疯狂野蛮人。:)

### 二、整套方法立在「置信度校准」上，而这个前提正被挑战

如果只能保留一条对原文的批评，评论区多数人会选 pcwelder 那条——它直接冲着文章的核心结论去：

> "There is an error in your interpretation of calibration graphs and the conclusion that Jev is more calibrated than Luna is likely incorrect. Or at least the graphs aren&#x27;t enough to conclude either way." — pcwelder [c:50401734]
> （译文：你们对校准图的解读有误，「Jev 比 Luna 校准更好」这个结论很可能不成立。至少，仅凭这些图还不足以支持任何一方的结论。）

他的补充更具体：Luna 虽然给出更多高置信度的错误答案，但它的通过率也更高，因此「错得多且自信」本身并不是缺陷；真正该报出来的是实际期望校准误差（ECE），而文章没报。

不过也有评论指出，文章至少做对了一件关键的事——把校准当成筛选器而非装饰。rickypp 的总结是这套技术成立的核心条件：

> "Seems to me that the important factor is that Jev has well-calibrated confidence for this task. Which secondary expensive model it defers to is probably less critical in this technique as long as that model has higher performance than Jev." — rickypp [c:50397886]
> （译文：在我看来，关键因素是 Jev 在这个任务上置信度校准得好。至于它升级时找的是哪个更贵的模型，在这项技术里大概没那么关键，只要那个模型比 Jev 强就行。）

ezotony 则干脆从文章自己给的数字里把没写出来的关键量反推出来——难例集上到底有多少比例被升级到了 Opus：

> "their cost numbers give you the hard set escalation rate even though they don&#x27;t list it, (2.94 - 0.06) &#x2F; 5.39 is ~53% going to Opus vs ~22% on the easy set, same thresholds" — ezotony [c:50400499]
> （译文：他们的成本数字其实泄露了难例集的升级率，虽然没明写：(2.94 − 0.06) / 5.39 说明约 53% 的样本走了 Opus，而同样阈值下简单集约 22%。）

这条把文章的隐藏机制摆到了台面上：简单集靠「几乎不升级」省钱，难例集靠「大量升级」保住准确率。

### 三、便宜模型该指挥贵模型，还是贵模型该指挥便宜模型

原文的架构是「便宜模型主动叫贵的」，评论区立刻有人指出自己反着干。drkleiner 的方案是让 Opus 当编排者和规划者，永远不亲自实现：

> "I do the opposite of this, use Qwen3.8-27B as subagents, Opus 5.5 as orchestrator and planner, never implementer, and it cuts my token usage significantly. So it is using Claude to direct Qwen. Never thought of the other way around, will give this a try soon as possible." — drkleiner [c:50398050]
> （译文：我正好反过来做：用 Qwen3.8-27B 当子 agent，Opus 5.5 当编排者和规划者，绝不当实现者，这大幅削减了我的 token 消耗。也就是说是我在让 Claude 指挥 Qwen。之前从没想过反过来的方向，很快要去试试。）

beefsack 跑的是三级结构，思路和 drkleiner 一致，只是模型换了：

> "This is how I do it too. I run three levels:" — beefsack [c:50401554]
> （译文：我也是这么干的。我跑三层：）

他的配置是 Opus 5.5 当编排者、GPT 6.1 Sol 当 feature lead、Muse Spark 1.3 Contributor 当工人，而且给出了这条路线的一个实战经验——低能力的模型在链条里做得不好的是「什么时候该喊人」：

> "I&#x27;ve also had systems that invert this and allow cheaper models to call out to more capable models when they need to, but in my observation I found them quite bad at knowing even when to call out and I find wrapping the cheap models a bit more reliable in that problems tend to get caught before they bubble up to the user." — beefsack [c:50402669]
> （译文：我也搭过反过来让便宜模型主动喊更贵模型的系统，但按我的观察，它们很不擅长判断什么时候该喊人；相比之下把便宜模型包起来用更可靠一点，因为问题往往在冒到用户那里之前就被抓住了。）

这恰好是原文没有正面回答的问题。rao-v 把它抽象成了一句话：

> "My sense so far is it’s very much about problem domain “taste” and there is no one correct answer (that is token cost efficient)." — rao-v [c:50398893]
> （译文：我的感觉是，这非常取决于问题领域的「口味」，并不存在唯一正确（也就是 token 成本最优）的答案。）

而 nextaccountic 追问的正是那个没人拿出数据的问题：

> "Does anyone have any evidence that having the most powerful model being the orchestrator, and other sub agents being progressively less powerful, is optimal? Is this just common sense or it has been measured somehow?" — nextaccountic [c:50402368]
> （译文：有没有任何证据表明「让最强的模型当编排者、其他子 agent 逐级变弱」是最优的？这是不是只是常识，还是有人真的测过？）

现实世界里两种做法都有人在跑。josht 用一个很老派的类比解释为什么「弱模型先做、有人复核」是常识：

> "The real-world provides us many examples of such big -&gt; little, or smart -&gt; not-as smart workflows. For instance, we don&#x27;t typically ask juniors or mid-level SDEs to design solutions to exceedingly challenging problems for a reason. However there are _some_ areas that those with less experience can tackle that is relatively risk-free if their work is reviewed by a more experienced engineer, which leads me to a conclude that it&#x27;s task dependent." — josht [c:50401499]
> （译文：现实世界里有很多这种「大 -> 小」或「聪明 -> 不那么聪明」的工作流。比如我们通常不会让初级或中级 SDE 去设计极难问题的方案，这是有原因的。不过确实有一些领域，经验较少的人可以做而且风险相对可控——只要他们的产出被更有经验的工程师审一遍。这让我得出结论：这事取决于任务。）

### 四、已经这么干的人，给出的答案比文章更具体

评论区里有一批人不是来评价文章的，是来交自己怎么做的。pkulak 的做法是把一个「裁判」接进已有的 Jev 流程，结果出乎自己意料：

> "Not hard to test. I wired a “judge” into my existing Jev setup and… it works. I was able to trim my prompt down to the basics without “engineering” and have my entire test suite pass. Best I could get before was 1 failure, with an extremely brittle prompt. Like, adding a comma where grammatically appropriate broke 10 more tests." — pkulak [c:50401352]
> （译文：测起来并不难。我在自己原有的 Jev 流程里接了个「裁判」……它居然好使。我能把提示词砍到最基本的样子，不用任何「工程」，整个测试套件就全过了。之前最好的时候也还有 1 个用例失败，而且提示词极其脆弱——在语法该加逗号的地方多加一个逗号，就能多挂 10 个用例。）

ghempton 则把 Jev 用在 agent 编排器里做路由，解决的是「一堆并行 agent 该找谁说话」的问题：

> "Jev is pretty cool for augmenting llms in a lot of ways. We use it in our own agent orchestrator[1] to help route ideas&#x2F;prompts to running agent sessions. I find when I have a lot of parallel agents running its hard to reason about which agent I should be talking to and Jev makes that call for me." — ghempton [c:50399690]
> （译文：Jev 在很多方面都是给 LLM 增强的好东西。我们在自研的 agent 编排器里用它帮想法和提示词路由到正在运行的 agent 会话。我发现并行 agent 一多，就很难判断该跟哪个 agent 说话，而 Jev 替我做了这个决定。）

一个做安全工程的人给出的是另一个方向——用本地小模型守输入输出：

> "I had the same idea, I extended opencode-warden to use a local decision model to validate tool inputs and outputs. It seems to work... ok? d1 is fast enough to run locally on an old 1080 GTX. Not sure if I can recommend relying on it." — morsch [c:50398259]
> （译文：我有同样的想法，我扩展了 opencode-warden，用一个本地决策模型来校验工具的输入和输出。看起来是能跑的……大概吧？d1 快到可以在一张老 1080 GTX 上本地跑。但我不太敢推荐大家依赖它。）

还有更省的一个版本——直接把决策模型当裁判接进来，工作量能砍掉七成：

> "We&#x27;ve been doing this for a while. Fine tuning the decision model helps a lot too. The problem is you still need a pretty low confidence threshold (e.g 10%), but often times that reduces the work by 70% with 0% quality loss (in our benchmarks)" — dangoodmanUT [c:50398551]
> （译文：我们这么做已经有一阵子了。对决策模型做微调帮助很大。问题是你还是得把置信度阈值设得很低（比如 10%），但很多时候这样能把工作量减少 70%，而质量毫无损失（在我们自己的基准上）。）

不过这套账算得并不长久。netshade 复现了类似结果，然后发现模型一更新，结论就作废：

> "When Haiku 5.5 came out though, for my tasks, the cost differences disappeared almost immediately. Haiku was good enough &#x2F; fast enough for so many things that introducing a decider layer didn&#x27;t offer huge wins. Jev&#x27;s &quot;millisecond&quot; level performance was nice but would get dwarfed by other latencies in my chain ( web browsing ), that it didn&#x27;t make a measurable difference in my tasks." — netshade [c:50399491]
> （译文：不过 Haiku 5.5 发布之后，对我的任务来说成本差几乎立刻消失了。Haiku 对太多事情来说已经足够好、足够快，加一层决策器带来的收益不大。Jev 那种「毫秒级」的性能固然不错，但在我这条链路上会被其他延迟（比如网页浏览）淹没，所以在我的任务里它没带来可测量的差别。）

### 五、厂商早就把开关做进产品里，命名还在互相打架

原文标题的「Jev 叫 Opus」并不是新东西——有评论直接指出 Anthropic 早就有原生机制。ninininino 给了文档路径：

> "Anthropic has a native solution to this which is that you can use `&#x2F;advisor` to adjust config to enable using Sonnet but set Opus as an advisor or use Haiku and then set Sonnet or Opus as advisor that the weaker model will automatically call when it thinks something warrants it:" — ninininino [c:50398323]
> （译文：Anthropic 已经有原生方案：用 `/advisor` 调整配置，可以让 Sonnet 当主力、把 Opus 设为 advisor；或者用 Haiku 当主力、把 Sonnet 或 Opus 设为 advisor，这样弱模型会在自己认为有必要时自动调用强模型：）

pearcoder 补了一句更轻的：

> "they do have the &#x27;advisor&#x27; model setting now which also plays well with this" — pearcoder [c:50398325]
> （译文：他们现在确实有 `advisor` 这个模型设置，跟这个玩法也正合适。）

另一半的混乱来自模型命名。Jaxkr 指出文章里的一处表述含糊：

> "GPT-6 Luna is a small LLM, not a decision model :P" — Jaxkr [c:50398223]
> （译文：GPT-6 Luna 是个小 LLM，不是决策模型啦 :P）

ax0ar 告诉他其实有个决策模型版本，只是命名没人分得清：

> "There&#x27;s actually a decision model version of GPT-6 Luna..." — ax0ar [c:50398364]
> （译文：其实确实有 GPT-6 Luna 的决策模型版本……）

至于「Jev」这个词本身，aizk 注意到它已经完成了从产品名到通用词的转变：

> "As an aside I&#x27;m amazed at just how fast the word Jev became generic. Possibly the fastest ever in corporate history?" — aizk [c:50401123]
> （译文：顺带一提，我惊讶于「Jev」这个词变成通用词的速度。可能是有公司史上最快的？）

也有人把这类模型一句话说穿了：

> "Small LLM + no reasoning + fixed JSON-only output = decision model" — paxy [c:50398436]
> （译文：小 LLM + 不推理 + 固定只输出 JSON = 决策模型）

### 六、最硬的反对意见：这活儿本来就该用规则写

对文章本身最不留情面的质疑来自 jwpapi。他的起点是一个反问：

> "Isn’t that by nature a deterministic problem?" — jwpapi [c:50400211]
> （译文：这本质上不就是一个确定性的问题吗？）

然后他列了一串问题，其中两条直指方法论：其一，误报和漏报不该等价；其二，该先用确定性规则清理一遍，再让 AI 审剩下的可疑样本。

> "- Shouldn’t one false positive rank higher than a hundred rank negative." — jwpapi [c:50400038]
> （译文：难道一次假阳性，不该比一百次假阴性权重更高吗？）

> "- You should definitely clean up deterministically first." — jwpapi [c:50400038]
> （译文：你当然应该先做确定性的清理。）

他的总结毫不客气：

> "I feel like if you really want to solve this problem, you would approach it differently. This seems like a wrong approach and a bad article on top?" — jwpapi [c:50400038]
> （译文：如果你真想解决这个问题，你会用完全不同的方法。我感觉这个方法方向就是错的，而且这篇文章本身也写坏了？）

jwpapi 的提问被 angry_octet 逐条接住，而回应比提问更尖锐——他同意「不可判定」的情况非常常见，甚至认为监管该在这点上强硬起来：

> "No, and I think undecideable is quite frequent." — angry_octet [c:50400988]
> （译文：不是。而且我认为「不可判定」的情况相当常见。）

> "Yes, and I think regulation should be quite strong in this regard." — angry_octet [c:50400988]
> （译文：是的，而且我认为监管在这件事上应该相当强硬。）

但他对「拆成小问题、用规则集解决」这条建议的反驳，恰恰指向 agentic 方式的软肋：

> "For larger contexts I worry about agentic confabulation, but humans unquestionably look at the gestalt when doing matching. I don&#x27;t want idiot clankers making enforced decisions because they have misunderstood one field." — angry_octet [c:50400988]
> （译文：在更大的上下文里我担心 agent 会编造，但人类做匹配时无疑是看整体感觉的。我不想让那些看不懂一个字段就乱套的铁笨蛋做出强制判定。）

第二层质疑更隐蔽：连题目本身都写错了。angry_octet 挑出原文给的错误类型示例里的硬伤：

> "Yet this is obviously a boy name, else it would be Valentina. Is this model going to return confidence values? No, they want decisions. This is an inherent problem in AI with reductive logic for these tasks." — angry_octet [c:50399975]
> （译文：可这明显是个男名，不然就该叫 Valentina。这个模型会返回置信度值吗？不会，他们要的是判定。这正是 AI 在这类任务上做还原式逻辑的固有问题。）

他接着把日期歧义列了出来——同一个 17/08/22，在中国人写的语境和北美语境下含义完全不同，而提示词里并没有交代语种和地区。angry_octet 还有一个更根本的建议：模型应该允许「无法判定」这个输出，而不是只有成立与不成立：

> "Additionally, when someone submits documents that can&#x27;t be recognised as valid, the response should not be INVALID, it should be UNDECIDED. In that sense, passing to Opus is great, but passing a tiny fragment of the problem is a bad way to do it." — angry_octet [c:50400920]
> （译文：另外，当有人提交的材料无法被识别为有效时，回应不应该是 INVALID，而应该是 UNDECIDED（无法判定）。从这个角度看，把问题整体交给 Opus 很好，但只丢一个问题的碎片过去是个糟糕做法。）

而「什么时候该升级」这件事，评论区给出的答案不是「模型有多确定」，而是另一套东西。bastawhiz 说得很直接：

> "I don&#x27;t believe the answer is ever &quot;how certain is the model?&quot; It&#x27;s &quot;how much is at stake?&quot; Or &quot;how hard of a problem does this appear to be?&quot; It&#x27;s not about teaching the model to have uncertainty, but rather to be avoidant of things that are sufficiently important to get right." — bastawhiz [c:50400231]
> （译文：我不认为答案永远是「模型有多确定」。应该是「这件事有多要紧？」或者「这题看起来有多难？」重点不是教模型有不确定性，而是让它对那些足够重要、必须做对的事保持回避。）

theptip 用另一套术语描述同一件事，把它归到精度与召回的权衡：

> "Yeah, it’s a precision&#x2F;recall tradeoff. And as such you calibrate by the cost of each FP vs FN." — theptip [c:50400264]
> （译文：对，这是个精度/召回的权衡。所以你要按假阳性和假阴性各自的成本来校准。）

### 七、标题与现实的落差，以及评论区的那点火气

文章被讨论得最多的另一层，是它到底能推广到多远。nico 的提醒很及时：

> "Despite the title, the article is not making claims of, or demonstrating general usage improvements or general coding agent improvements" — nico [c:50398951]
> （译文：尽管标题这么写，这篇文章并没有主张、也没有证明通用场景下的效果提升，或者通用 coding agent 的提升。）

mannyv 说得更冷一些——这类结论的保质期短得不合理：

> "What&#x27;s interesting and annoying is that the results only matter for these specific releases of the models, with the specific parameters used." — mannyv [c:50400032]
> （译文：有意思也有点恼人的是，这些结果只对这些模型的具体版本、这些具体参数有效。）

而 asar 的吐槽，是整场讨论里情绪最重的一句：

> "i&#x27;m so numb to these headlines nowadays... i guess i&#x27;ve been disappointed by how effective these approaches end up being for actual work but i feel like it&#x27;s easy to produce these headlines with &quot;proof&quot; that doesnt prove anything besides the sandboxed scenario it was run in" — asar [c:50398480]
> （译文：我现在已经对这类标题免疫了……我想我是对这些做法在真实工作里到底有多有效感到失望，但我总觉得这类标题很容易做出来：配上「证据」，而这些证据除了它被跑的那个沙盒场景之外什么都不证明。）

应用本身的用途也让人不安。有人对「把不同来源的数据合成一个人」这件事的直觉反应只有一句：

> "The application creeps me out" — blurbleblurble [c:50400704]
> （译文：这个应用让我发毛。）

而在企业内部，落地阻力往往不来自技术。anshumankmr 说他的卡点在审批，不在能力：

> "Why isn&#x27;t Jev on Bedrock asap... I did a demo for using it as an orchestrator but the problem is upper management won&#x27;t approve it unless its on Bedrock which is a real bummer" — anshumankmr [c:50401131]
> （译文：为什么 Jev 还不赶紧上 Bedrock……我做过一个把它当编排器的演示，但问题在于，除非它在 Bedrock 上，否则高层不批，真是扫兴。）

latentsea 用一句话替他说完了：

> "Upper management don&#x27;t like the idea they could be replaced by Jev." — latentsea [c:50401477]
> （译文：高层不喜欢「自己可以被 Jev 替代」这个想法。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题的数学表达有问题 | mjuarez | 「4 倍更低」应该写成 0.25x，否则语义拧巴 |
| 校准图被误读，结论站不住 | pcwelder | 该报实际 ECE，「Jev 更校准」很可能不成立 |
| 校准才是这套方法的关键 | rickypp | 关键是便宜模型的置信度可信，不是它升级给谁 |
| 升级率能从成本里反推出来 | ezotony | 难例集约 53% 走了 Opus，简单集约 22% |
| 便宜模型该喊人还是贵模型该派活 | drkleiner | 我反着干：Opus 当编排者，Qwen 当子 agent |
| 弱模型不擅长判断何时该升级 | beefsack | 我见过便宜模型喊人，喊得很不准 |
| 「最强模型当编排者」缺乏证据 | nextaccountic | 这是常识还是实测结论？ |
| 弱先强后符合现实分工 | josht | 让初级 SDE 干活，前提是有资深的人复核 |
| 决策模型可以真接进现有流程 | pkulak | 接个裁判进已有 Jev 流程，测试全过 |
| 决策模型已经能本地跑 | morsch | 一张老 1080 GTX 就够跑 d1 守输入输出 |
| 模型一更新这套账就作废 | netshade | Haiku 5.5 一来，成本差立刻消失 |
| 厂商早有原生开关 | ninininino | Anthropic 的 `/advisor` 就是同一件事 |
| 模型命名混乱 | Jaxkr | Luna 是小 LLM 还是决策模型，标题没说清 |
| 该用确定性规则先做 | jwpapi | 先规则清理、再 AI 审可疑样本 |
| 一次假阳性该重过一百次假阴性 | jwpapi | 误报和漏报不该等价 |
| 该有「无法判定」这个输出 | angry_octet | 无法识别就该 UNDECIDED，不该硬判 INVALID |
| 该问「有多要紧」而非「有多确定」 | bastawhiz | 阈值不是标定信心，是标定风险敞口 |
| 结论只对特定版本有效 | mannyv | 换一次模型发布，这些数字就得重测 |
| 标题别外推 | nico | 文章没证明通用 coding agent 的提升 |
| 对这类标题已免疫 | asar | 沙盒里的「证据」证明不了真实工作 |
| 应用本身让人发毛 | blurbleblurble | 把不同来源的数据合成一个人，这应用让我发毛 |
| 落地卡点在审批 | anshumankmr | 不在 Bedrock 上，高层就不批 |

## 总体情绪

这场讨论表面上在讨论成本和准确率，实际在讨论一个更朴素的问题：便宜的模型到底能不能替人做判断，做判断的时候它自己知不知道。原文给出的答案漂亮——把「模型够不够聪明」换成了「模型知不知道自己不够聪明」，于是校准良好的小模型有了上岗资格。这套说法在评论区收获了大量「我早就在这么干」的附和：有人接裁判、有人做本地守门、有人拆三级编排器，细节比文章更具体。

但怀疑同样有分量，而且集中在两个地方。其一是证据本身：校准图怎么读、ECE 报没报、这些数字换成下一个模型版本还成不成立。另一半人质疑得更狠，认为这个题从头就该用确定性规则做，LLM 只是把「假阳性和假阴性等价」这个错误的代价隐藏在了基准里。中间还有一批人根本不关心这些，他们指出文章的方法早就有了，而他们真正遇到的问题是落地——审批、命名、以及模型每几个月就把上一轮的成本账推翻一次。

情绪的底色是一种疲倦的怀疑掺着实用主义的接受：一边是「这类标题我已经免疫了」，一边是「我今天就把裁判接进去了」。没人否认省钱有用，大家否认的是「证明」这两个字的分量——在一份只在自己沙盒里跑过的数据上，那个字太容易写了。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | A Jev that can ask Opus for help gives Opus accuracy at 4x lower cost（HN 主帖） | <https://news.ycombinator.com/item?id=50397429> |
| 2 | 原文：A Jev that can ask Opus for help gives Opus accuracy at 4x lower cost | <https://hightouch.com/blog/llm-judges-identity-resolution> |
| 3 | Introducing System One Models and Jev | <https://typesafe.ai/blog/introducing-system-one-models-and-jev> |
| 4 | pseudopeople（IHME，华盛顿大学） | <https://www.pseudopeople.org/> |
| 5 | OpenAI Decisions API（GPT-6 Luna） | <https://developers.openai.com/api/docs/guides/decisions> |
| 6 | Claude Code `/advisor` 文档 | <https://code.claude.com/docs/en/advisor> |
| 7 | OpenRouter：gpt-6-luna-decisions | <https://openrouter.ai/openai/gpt-6-luna-decisions> |
| 8 | jevk5（本地 Jev 权重） | <https://github.com/allebee/jevk5> |
| 9 | processed-beef（多层编排 skill 配置） | <https://github.com/beefsack/processed-beef/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 468 分、107 条评论，归档快照 2026-11-07 09:42 UTC，入库 101 条）及原文抓取内容（hightouch.com 原文正文与数据表）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中准确率、时延与每千条成本数字均转自 Hightouch 原文表格，属该公司自有环境下的观测值，非独立复测；原文测试数据由 pseudopeople 合成生成，不含真实个人信息。「难例集约 53% 升级至 Opus」一条系评论者依成本数字反推，非原文直接给出。文末提到的第三方项目与文档链接由评论者提供，本站未做可用性核验。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
