---
layout: post
title: >-
  Ruby 核心开发者归档自己的所有 gem — HN 讨论摘要
date: 2026-10-20
hn_id: 50154518
categories: [articles]
excerpt: >-
  Ruby 核心开发者 po-ru 宣布归档自己所有的 gem，理由是开源"公共地"正在被 LLM 公司掠夺式开采，Ruby 本土也在被重定位成"AI 时代语言"。HN 讨论从床上的隐喻扩散到木匠类比的瑕疵，再到维护者的集体创伤。
tagline: >-
  Ruby 设计给人类快乐，现在它的下一份工作，是给 LLM 当语料。
---

## 原文概要

Ruby 生态中长期维护多个常用 gem 的开发者 po-ru（Daniel Berger），宣布把自己名下全部 Ruby 仓库归档，对应 commit 标题是 "Archived by po-ru"。归档的同时，他在个人博客发了一篇长文解释，题为《Why I'm no longer updating this repository》。

文章的开头引了 Matz 在 2000 年那句经典语录——Ruby 的设计目的是给程序员带来快乐——以及 2019 年受访时说的"Ruby 设计给人类，不是机器"。po-ru 承认，自己最初写这些 gem 的初衷，正是这种"为人而做"的氛围。

随后他把矛头指向三个方向。一是 Rails，po-ru 明说 Rails"开源但被一个人的观点所主导，那个人是我所厌恶的"，并链接到一篇关于"DHH 问题"的批判文章。他同时指出 DHH 在 2026 年 Rails World 主题演讲上的表现，已经显现出 DHH 对 Ruby、Rails、甚至编程本身都不再有兴趣——DHH 现在让 LLM agent 用 Rust 写应用，自己连生成的代码都不看。二是 Matz 本人——po-ru 引用 Matz 在 Baltic Ruby 2025 的主题演讲《Programming Language for AI age》，认为 Matz 实质上在为 LLM 重塑 Ruby 的存在理由，并主张 LLM 需要消费"更多好的、人类写的 Ruby 代码"。三是开源作为一个公共地的整体，po-ru 用了一个很冲的比喻：声称"手写代码不再可持续"的人，说法并不完全错，但同样的话也适用于"床被人拉了屎之后，再睡上去就不再可持续"。结尾 po-ru 的姿态是："想要改动？去问你的 agent。我退场。"

在 HN 的热门榜（/best）上，这篇转载拿到 322 分，285 条讨论。本文讨论帖源自 HN 热门榜（/best）。

## 讨论焦点

### 那张"床"上发生的其他事：网友把隐喻接住了

po-ru 那个"床上有屎"的比喻被顶到了首条回复，本身就是种信号——社区里人愿意把这种冒犯当赞美。更多人则是把它继续展开：一层塑料膜、永远不掀开，假装下面干净，"Claude Code 开发团队已经开创了这种新式睡眠"。

> "What a great phrase!" — lbrito [c:50154616]
>
> （译文：说得太好了。）

> "The trick to sleeping in a shit-covered bed is to slap a big sheet of plastic on it and never look under it. The Claude Code development team has pioneered that new way of sleeping." — 10111001 [c:50154708]
>
> （译文：睡在屎床上的诀窍是铺一层大塑料膜，然后永远不往下看。Claude Code 开发团队已经开创了这种新式睡眠。）

> "I have been told it is the future of sleeping, and if I don‘t sleep with a plastic cover directing the pooping agent I will fall behind and eventually become obsolete. And that sleeping like this will eventually cure cancer and build swarms of mining rigs in space." — runarberg [c:50154806]
>
> （译文：我被告知这是睡眠的未来。如果我不睡在塑料膜下面、让拉屎的 agent 替我做主，我就会落后，最后被淘汰。还说这种睡法迟早能治癌症、在太空建起挖矿机群。）

这段接龙的潜台词是：床可以铺膜，膜可以盖住屎，但屎仍然是屎。LLM 时代的很多公司方法论，本质上就是把膜铺得更厚、把头转得更彻底的那类。

### 机器人取代木匠是个错误类比——LLM 是计算机，不是铲子

讨论里最值得读的反驳是针对一条"机器人盖房子、木匠失业"的类比。原帖认为，po-ru 的处境就像一个手艺木匠，面对一天就能盖好一栋房、时薪 1 美元的机器人，无处可去。两个反驳让这条类比不再成立。

第一个反驳是经济账：机器人不是 1 美元一小时，是用资本烧出来的折扣价，等补贴退潮才能看见真实账单。

> "This analogy hinges on the economic argument (that a robot costs 200x less than a human), but far from being an established fact, that notion is more or less entirely based on vague, misleading and exaggerated claims from the token peddlers. The truth is no one knows how much the robot costs, and we probably won't know until its too late." — lbrito [c:50157577]
>
> （译文：这个类比的关键在经济学论据——机器人比人便宜 200 倍。但这个"事实"离确认还差得远，它基本就是从那些卖 token 的人嘴里抄来的、宣传上含含糊糊、真假掺半的说法。没有人真的知道机器人究竟多少钱，等我们知道的时候往往已经太晚了。）

第二个反驳更击中要害：LLM 不是体力，是确定性计算机。"机器人取代体力"是对的，"机器人取代设计"是错的——更好的比喻是，一位专门画图纸的工匠被泼颜料取代，颜料甩到纸上看起来几乎像图纸，几乎能住人。

> "Robots are computers. Robots are deterministic. A better comparison would be an artisan architect, a blueprint designer being replaced by a special paint splatter, which when thrown against a piece of paper looks almost exactly like a blueprint of an almost completely liveable house." — xorcist [c:50157833]
>
> （译文：机器人就是计算机，机器人就是确定性的。更好的类比是，一位画图纸的工匠被一团特殊的泼溅颜料取代——把这坨颜料甩到纸上，看起来几乎就是一栋可住人的房子的图纸。）

这一层把讨论上拉一档：写代码的人担心的不是"被更快的手臂替代"，而是"被更快地复制出看起来像代码的东西替代"。后者让人更难拒绝，因为它的产出物表面上是合规的，而代价藏在维护期的某一天才被发现。

### DHH 和 Matz 各自往反方向走，Ruby 成了夹心层

如果只看原帖的引文，DHH 和 Matz 几乎是镜像：一个已经在 Rust 和 agent 上过日子，另一个在为 LLM 重新定位 Ruby。讨论里两条线都在被吐槽。

对 Matz 的批评集中在"为 AI 时代重塑 Ruby"这件事本身——原帖里 Matz 的原话被复述："为了做到这一点，LLM 需要消费更多好的、人类写的 Ruby 代码。"这等于官方承认开源 Ruby 代码是一种生产资料。

> "The biggest LLM sellouts in open source are Ruby and Scala. Ironically Oracle with Java is now being the good guy." — 23jah76 [c:50154692]
>
> （译文：开源界最大的 LLM 卖家中，Ruby 和 Scala 排前二。讽刺的是，Oracle 带着 Java 反倒成了好人。）

对 DHH 的吐槽则更刻薄——评论者直接把 DHH、Lütke、Matz 摆成一组"权力榜"，并指出 Matz"他的人生作品（按他自己的说法）当场被宣告无关紧要，他还能坐在那儿接受"。

> "the uncultivated race car driver (dhh) and the snowboarder (Lütke) own Matz now. They can insult him in public and he complies. I'm not sure why he isn't rich enough to walk away." — bloggk [c:50154938]
>
> （译文：未开化的赛车手（dhh）和单板滑雪选手（Lütke）现在控股 Matz。他们公开侮辱他，他照单全收。我搞不懂他为什么有钱到没地方花却不肯走开。）

也有人保持完全乐观，比如一开头就有的典型病例：让 LLM 写底层的 Rust、自己用 Ruby 在上层写。

> "Ruby is still fun to write, in fact I make the LLMs write the underlying libraries in Rust while I enjoy writing Ruby on top. win win" — dahrkael [c:50154655]
>
> （译文：Ruby 写起来还是好玩。实际上我让 LLM 用 Rust 写底层库，自己在上面写 Ruby。双赢。）

这种"上层 Ruby + 下层 LLM 生成 Rust"的活法，可能只是个短期红利——它假设 LLM 写得比人更稳、更快，但谁负责修 LLM 写出来的漏洞，到今天仍然是那个写上层 Ruby 的"我"。

### "开源一直都被开采"——OP 的姿态只是迟到

另一条重头反驳是冲着 po-ru 的叙事框架去的。评论者指出，po-ru 把这件事描述成"一个原本干净的公共地被 LLM 突然破坏"，但这个公共地从来就不干净。

> "Open-source was always strip-mined by massive corporations. It was main source of free labour for decades. Great to see more people awaken to the fact corporations thrive on unpaid work whilst making billions for their shareholders." — varispeed [c:50154677]
>
> （译文：开源一直都被大公司开采。几十年里它就是免费劳动力的主来源。看到更多人终于意识到"公司靠不付费的工作赚钱，再分给股东几十亿"这个事实，挺欣慰的。）

> "I am pretty sure that the whole open source ideology was developed and disseminated exactly by a cartel of those massive corporations with the sole intention to amass as much human-written code as possible to train AI." — wartywhoa23 [c:50157849]
>
> （译文：我相当确定，整个开源意识形态就是被这批大公司的卡特尔恰好发展并散布开的，目的就是尽可能多地积累人类写的代码，用来训练 AI。）

这两条回应把 po-ru 的姿态去神圣化了——你不是第一个被剥削，你是最后一个"以为这事儿干净"的人。换句话说，开源从来就是带病运转，今天的"被 LLM 开采"只是把这个病从隐形改成了外显。这一层讨论，对 OSS 维护者来说比 LLM 本身更刺痛，因为他们无法再把自己放到"无辜贡献者"的位置上。

### 维护者的集体 grief：数学家已经走过的路

讨论里最触动人的一组声音，是来自其他被掏空的 OSS 维护者。他们把 po-ru 的退场看成一种"集体哀伤"的发布会——Loss of joy 不是个别现象，是一个正在扩散的群体症状。

> "I was chatting with a friend who commits on a very well known open source project (~80K stars). He is disillusioned not because the robots aren't good at what they do — they totally are. The sad thing is that he enjoyed writing code and working with the community on improvements because it was a very human, collaborative thing to do. So, while the robots are great at pushing the project forward even faster and doing fantastic things for security and performance, the joy is gone. It must be how professional mathematicians are feeling as well." — ttul [c:50154758]
>
> （译文：我最近在跟一个朋友的闲聊——他贡献于一个 8 万星的知名开源项目。他现在失望并不是因为机器人做不到——它们做得到。让人难过的是，他本来喜欢的是写代码、和社区一起改东西、那种很人性、很协作的感觉。所以即便机器人能把项目推进得更快、安全和性能都很亮眼，乐趣没了。我想职业数学家大概也是这么感觉的。）

这条评论的杀伤力在最后一句：把 po-ru 的处境对应到数学家。当主要的智力成果被视为"语料"，而不是"作品"，最大的代价不是收入，而是"被某种专业身份识别出来的可能"消失。一部分维护者真的去做心理建设：

> "Everyone in SWE (who got into it for the love of writing code) is experiencing this. I've been direct with my team about it being a legitimate feeling of grief and the grieving process that comes along with it. It's been helpful for folks to hear that they aren't alone in that feeling." — rco8786 [c:50154861]
>
> （译文：所有 SWE——那些因为喜欢写代码而入行的——都在经历这件事。我跟团队直接说过，这是一种真实的哀伤感，伴随哀伤过程。让大家听到"你不是一个人"这一点，是有帮助的。）

另一种声调更冷：把多年的硬投入当沉没成本，要被迫接受它正在贬值。

> "That just makes it feel like I wasted a lot of time. I spent years eschewing social gatherings, foregoing other opportunities, and depriving myself of things I enjoy, to cultivate a set of skills. Now I feel like they are rapidly becoming largely irrelevant. I wish I were as selfless as you. I'm not sure many people are, maybe the world would be a kinder place if they were." — decidu0us9034 [c:50157492]
>
> （译文：这话只会让人觉得自己白费了好多年。我花了几年推掉社交、放弃别的机会、不让自己享受喜欢的事，就为了养出一套技能。现在我感觉这套技能正在迅速变得无关紧要。我希望我像你那么无私。我不确定很多人做得到，也许世界会变得更善意，如果大家都做得到。）

grief 不是一个能靠写新工具解决的命题。这也是为什么"换到上层 Ruby + 下层 LLM Rust"的活法，听起来没那么够——因为它不能替代那个"今天做完的东西明天还在那里，而且是我写的"的满足感。

### 小众 OSS 包将消失，未来的常态是 fork + LLM 维护

有人顺着 po-ru 的"退场"预测了一整张图：po-ru 这种"先有维护者、后有维护者工具链"的 OSS 路径，正在被一条更平的路替代——fork、LLM 改、跑自己的私人 fork、维护工作本机化。

> "As time goes on I think these smaller packages / clients will start to disappear as people/LLMs just spit out a client library or whatever or just implement the same thing over and over." — tempest_ [c:50154721]
>
> （译文：我感觉随着时间推移，这些小一点的包 / 客户端会开始消失，因为人/LLM 可以直接吐出一个客户端库，或者干脆一遍一遍重新实现同一件事。）

> "the future might be that the main repo for a project forms the 'core', and consumers use their own forks which are automatically kept up to date. the core doesn't need to be as configurable or flexible as the forks can add functionality directly." — slopinthebag [c:50156378]
>
> （译文：未来很可能是这样——一个项目的主仓库变成"核心"，然后消费者各自用 fork，自动同步。主仓库不需要多灵活多可配，因为功能加在 fork 上就行。）

> "Eventually maintainers will just throw up their hands and leave the repo under the care of a LLM. Merge PRs that align with the product's vision/design/intention. Meticulously examine for malicious contributions. Email me if there are doubts." — aaronax [c:50154978]
>
> （译文：维护者最后会举起手投降，把仓库托给 LLM。合并符合产品愿景/设计/意图的 PR，仔细审视恶意贡献，有疑问就发邮件。）

这三条接起来是一张小型死亡时间表：小项目消失，主项目变瘦，所有"我在维护它"的承诺变成"我有 fork"。当 OSS 的供给侧从"主动维护"转为"按需 fork"，下游选择会变多变厚，但讨论一条 issue 等维护者回应的日子越来越稀有，"认领维护者"将变成一种少数派的热情。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 床屎比喻很准，是这一代人的隐喻 | lbrito [c:50154616] | "原话太到位。" |
| 床屎的活法：铺膜、闭眼、永不掀开 | 10111001 [c:50154708] | "Claude Code 团队已经开了这种睡眠流派。" |
| 这就是未来的睡眠，病能治好、卫星也能造 | runarberg [c:50154806] | "反对不睡塑料膜就会落伍、最后被淘汰。" |
| 机器人时薪 1 美元的事，账单根本没人看过 | lbrito [c:50157577] | "robo 的真实成本只有补贴退潮后才看得见。" |
| LLM 是确定性计算机，类比成机器人就错了 | xorcist [c:50157833] | "不如类比成砸图纸的颜料——几乎像，几乎能住。" |
| Ruby + Scala 是开源 LLM 头号卖家，Oracle 反成了好人 | 23jah76 [c:50154692] | "Ruby 是头号 LLM 卖家，反讽的是 Oracle 带着 Java 成了正面角色。" |
| Matz 在 DHH + Lütke 面前只能照单全收 | bloggk [c:50154938] | "dhh（赛车手）和 Lütke（单板滑雪）已经控股 Matz。" |
| 上层 Ruby + 下层 LLM Rust 是双赢 | dahrkael [c:50154655] | "我让 LLM 写 Rust，自己写 Ruby。" |
| 开源一直都被大公司开采，po-ru 醒得太晚 | varispeed [c:50154677] | "几十年就是免费劳动力，今天才看清。" |
| 开源意识形态就是大公司为了喂 AI 而散布的 | wartywhoa23 [c:50157849] | "从一开始就是为大公司训练 AI 服务。" |
| 8 万星项目维护者已经和这哥们一样在想退 | ttul [c:50154758] | "数学家大概也这种感觉——专业身份被改成语料。" |
| 应当把这种 grief 当哀伤过程公开讲出来 | rco8786 [c:50154861] | "我跟团队直接讲：这就是哀伤过程，不是一个人。" |
| 这种"对的"叙事等于让被剥夺者吃青菜 | decidu0us9034 [c:50157492] | "让人感觉自己白学了这么多年，我希望我有这种无私。" |
| 小包会消失，未来是 fork + LLM | tempest_ [c:50154721] | "OSS 小包将被人/LLM 一次次重写。" |
| 主仓库变核心，fork 加功能 | slopinthebag [c:50156378] | "主仓瘦下来，fork 各自加功能。" |
| 维护者最终会把仓库交给 LLM | aaronax [c:50154978] | "最后就是一句：合 PR，看恶意贡献，邮件我。" |
| 知道自己何时该退场是难得的本领 | swiftcoder [c:50154697] | "知道何时走开是这行被低估的能力之一。" |
| 一切不过是（重新发明）手工织布 | barbazoo [c:50155005] | "就跟裁缝不再自己纺纱织布一样。" |
| 写代码 vs 用 LLM，就像手弹吉他 vs 放 MP3 | jmaw [c:50155398] | "MP3 更高效，但人们还是在弹吉他。" |
| 类比是把讨论拖下水的最快方式 | john_strinlai [c:50157861] | "我们从 Ruby gem 走到了箱里生活，求你别再用类比了。" |

## 总体情绪

整场讨论的情绪底色可以总结成"复杂但克制"。讨论者大体上没有否认 po-ru 的处境，但也很少有人随他一起站在"我退场"那一边。最多的人在做的事情，是把这条叙事拆开看，再重新拼——并发现里面的零件，没几件是新的。

最显著的情绪分叉有两路。一路是把这件事解读成"开源被 LLM 拿来做语料"这一新现象的代价——这一路讨论者对"维护者的集体 grief"有真实痛感，ttul 把这种状态对应到数学家，是整场讨论最安静、也是最重的一句。另一路是把这件事放回到开源与商业关系的老叙事里——这一路讨论者指出，大公司"免费用 OSS 劳动"这件事已经几十年了，po-ru 是个晚到的觉醒者；今天的 LLM 只是让这件事从隐形变成外显，让以前能睁眼装看不见的人装不下去了。

这两路情绪并不冲突。前者让人同情，后者让人清醒。同一个讨论者也可以两条路同时走：既同情那个写了十年 gem 的人，也承认他对自己处境的描述只对了一半。

最后一句留给这句话：当一行人以写代码为身份，机器开始替他做完"看起来像代码"的东西，他的退场不是因为代码消失了，而是因为身份消失了——剩下的事他只是不再想看到它发生而已。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | I no longer care to work on any Ruby gems so I've archived all my repositories | <https://news.ycombinator.com/item?id=50154518> |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及 Ruby 社区、DHH 个人公开立场（其博文链接在原帖中提及但本文未深述）、Matz 对 Ruby 未来定位的公开发言等仍存争议的话题，所引观点按原帖立场呈现，不代表本项目立场。事实性陈述（仓库归档、博客发表、Rails World 2026 主题演讲、引用 Matz 演讲、322 分 / 285 评论）以原文博客及 HN 原帖为准。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 "item?id=50154518#c_{id}" 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
