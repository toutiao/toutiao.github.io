---
layout: post
title: >-
  Gemini 4 Neon 发布：智能指数冲到全球第三、每任务成本比 Carbon 低 32%，评论区却在解元素周期表 — HN 讨论摘要
date: 2026-11-19
hn_id: 50552424
categories: [articles]
excerpt: >-
  跑分冲到全球第三、每任务成本比上一代低三成，评论区却被另一个问题劫持：Hydrogen、Neon、
  Carbon、Argon 到底谁是谁？用户把元素周期表、原子序数、密度和字母序挨个试了一遍。
tagline: >-
  Google 一次发了四个 Gemini，用户先要了一张元素周期表。
---

> 来源：HN 讨论主帖 [Gemini 4 Neon](https://news.ycombinator.com/item?id=50552424)（476 分，438 条评论），原文指向 Google 官方发布页 [Introducing Gemini 4 Neon](https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-neon/)。归档快照 2026-11-19 02:20 UTC，入库 100 条评论（抓取上限），评论分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

2026 年 11 月 18 日 21:34 UTC，Google 官方博客发布 Gemini 4 Neon。官方给它的定位卡在中间：Carbon 负责最难的超长程项目，Hydrogen 负责日常快速执行，Neon 在深度和效率之间取平衡，主打复杂编码、分析推理和生产级企业工作流。发布当天进入 Gemini API（Google AI Studio）、Gemini for business、Google Antigravity（付费 AI Pro／Ultra 订阅）与 Gemini 应用（Pro／Ultra 订阅）。

跑分和价格写在同一页上。Artificial Analysis 智能指数在 xhigh 思考档拿 61 分，总榜第三，只落在大而慢的模型后面；Vals Index 第二（70.9%），且位于帕累托前沿；Agent Arena Index 上可控性排第二、全球总分 1336（4200+ 场真实 agent 会话）。企业向：Legal Research Bench 与 Tax Agent Bench 均第一，Zapier AutomationBench 总分第一（56.3%），Andon Labs Vending-Bench 2 第一（$16,843），Surge AI 在财务、会计、表格建模、复杂约束跟随上多数基准第一，Chartography 73.5%。科学向：Terminal-Bench Science 70.5%、RiemannBench 84.0%、HLE-Diamond 71.3%。编码向：Artificial Analysis Coding Agent Index 总分第一（58.6），Terminal-Bench 4.1 65.2%，FrontierCode 2.0 46.2%（默认 high 档），SWE-sweep 在 mini-SWE 上以 12.8% 领先、放进 Antigravity 后放大到 SOTA 39.0%。定价是输入每百万 token 3 美元（缓存 0.15 美元，95% 折扣）、输出 15 美元，100 万 token 上下文；默认 high 思考档每任务成本比 Carbon 低 32%，比顶级竞品低 50%–80%。

演示部分更像节日烟火：用 Blender MCP 配 /swarm 造出一间元素周期表实验室，Carbon 和 Hydrogen 配本生灯火焰，Argon 和 Neon 配高压气体放电管；用 10,200 行自定义 shader 写出第一人称 WebGL2 自由滑雪模拟器，踩的是勃朗峰与霞慕尼真实高程地形，120Hz 滑雪物理、六条雪道、板状雪崩、空间音频，零预制素材；用 /swarm 复原图灵 1936 年在剑桥国王学院的研究室，从国王礼拜堂外景进到 X.8 房间，桌上那台通用图灵机真能跑；agent swarm 还把一张图片变成 10 万单元格的 Google 表格，零嵌入图片、零 Apps Script，用 50 万条活公式做边缘检测、3D 深度与六种交互模式的重光照。安全侧另有一条产品线：Neon for cyber 在 AutoBaxBench 难档做到 76% 的 SOTA，WebExploitBench v1.2 51.26%（成本约为竞品一半），SEC-bench Pro 90.5%，CWE-bench v2 70.7%（比 Carbon 提升 3.4%），以 Fairwind Program 名义向可信防御者开放。

真正的转折发生在评论区——发布的重点是模型，讨论的重点是名字。这套 Hydrogen／Neon／Carbon／Argon 的命名不是第一次挨骂：Argon 当初发布时就被猜成是不是照元素周期表排的（惰性气体里挑名字），Neon 一出来，争论立刻升级成三个具体问题：Argon 是不是被顶掉了？Neon 比 Carbon 便宜还是贵？$20 档到底能用哪些？没人给得出确定答案，因为官方从没公布参数规模，也没把四个模型的能力、价格、思考档摆成一张能读的表。

## 讨论焦点

### 一、头条不是模型，是名字

第一个把话说透的，是盯着开发者文档看的人。他贴出的模型清单里，光是 Gemini 4 就有 Neon、Hydrogen、Carbon、Argon 四个，再叠上 LOW／MEDIUM／HIGH／XHIGH 四档思考级别：

> "I&#x27;ve no clue whatsoever how to read anything about the names of them and what they might imply you would use them for though. Within these most of them have LOW MEDIUM HIGH XHIGH, with the default being different for some of them,  how anybody is possibly meant to understand this whole matrix of ambiguously named products is beyond me." — drum55 [c:50552581]
> （译文：我完全看不出这些名字该怎么读，也看不出它们暗示我该拿来做什么。这里面大多数还有 LOW、MEDIUM、HIGH、XHIGH 四档思考级别，默认档还各不相同——这么一套名字含混的产品矩阵，怎么指望普通人搞得明白。）

把这当成一次命名竞赛的，也不少：

> "Credit to Google for outdoing Open AI and Anthropic in terms of choosing a confusing naming convention." — 3wolf [c:50552517]
> （译文：得恭喜 Google，在「选一套让人费解的命名」这件事上，它成功超过了 OpenAI 和 Anthropic。）

> "Great, consumers now need to first learn chemistry to be able to figure out which model to use!" — ehsankia [c:50552777]
> （译文：好，普通用户现在得先学一遍化学，才能搞清楚自己该用哪个模型！）

唯一一条替 Google 说话的，说的还是「不该由用户来背这张表」：

> "If one needs a lookup table to understand the product by name then it&#x27;s a product issue, not a consumer issue, even if everyone &quot;should&quot; have the first N elements memorized by atomic $property." — accrual [c:50552916]
> （译文：如果一个产品要靠对照表才能靠名字理解清楚，那是产品的问题，不是用户的问题——哪怕每个人都「应该」背下了前 N 号元素的原子属性。）

### 二、用户们把所有排序规则都试了一遍

既然官方不给表，大家就自己发明表。第一种答案是「随便起的」：

> "As far as I can tell it&#x27;s arbitrary and Google is just choosing element names they think sound good." — Mogzol [c:50552724]
> （译文：据我判断，这就是随意的，Google 只是挑了些自己觉得好听的元素名。）

> "And now they&#x27;ve come out with Hydrogen and Neon, and there&#x27;s no logical way to order them. The actual model sizes are Hydrogen (small), Neon (mid), Carbon (big). This doesn&#x27;t match sorting by atomic number or alphabetically." — Mogzol [c:50552724]
> （译文：现在又来了 Hydrogen 和 Neon，根本没有逻辑能把它们排开。真实的模型规模是 Hydrogen（小）、Neon（中）、Carbon（大），这既不按原子序数排，也不按字母顺序排。）

于是有人把三条排序线并排摆出来，结果三条互相打架：

> "The elemental ordering is H C Ne Ar. The cost ordering is H Ne Ar C (with Ar and C being the same per token but I gather that C thinks more and thus costs more). The capability ordering seems to be H Ar C Ne." — wat10000 [c:50552867]
> （译文：元素序是 H、C、Ne、Ar；价格序是 H、Ne、Ar、C（Ar 和 C 单价一样，但我猜 C 想得更多所以更贵）；能力序看起来是 H、Ar、C、Ne。）

把元素直接和价格对齐的版本最有画面感：

> "They use the very precise &quot;it sounds cool&quot;. Neon is 75% the price of Carbon but has 4 extra protons in the nucleus and is also a noble gas. Argon is a heavier noble gas at 16 protons.
> element&#x2F;model - atomic number - cost
> H - 1 - $1.50 &amp; 7.50 per mtok
> C - 6 - $4 &amp; 20 per mtok
> Ne - 10 - $3 &amp; 15 per mtok
> Ar - 16 - $2 &amp; 10 per mtok" — kphorn [c:50552839]
> （译文：他们的标准非常精确——「听着好听」。Neon 是 Carbon 的 75% 价格，却比它多 4 个质子，而且同样是惰性气体；Argon 则是更重的惰性气体，16 个质子。
> 元素／模型 — 原子序数 — 价格
> H — 1 — 每百万 token $1.50 与 $7.50
> C — 6 — 每百万 token $4 与 $20
> Ne — 10 — 每百万 token $3 与 $15
> Ar — 16 — 每百万 token $2 与 $10）

还有几种更冷门的解释：按密度排（氢 0.0000899、氖 0.000900、氩 0.001784、碳 2.267），按字母顺序排（像 Ubuntu 发行版代号那样，还跳过 Oxygen 这类不想用的名字），或者干脆承认元素表根本不管用——「Hydrogen 最轻这点说得通，往后就不成立了」。

为这套命名辩护的也不是没有，理由很朴素：元素周期表是全世界最普及的一张有序表，够用了。

> "Everyone seems quite upset&#x2F;perplexed by the Gemini naming scheme but I quite like it. And hey, if you find yourself lost, the periodic table is probably the most ubiquitous ordered list in the world and serves to clear things up pretty fast." — baoooooooooooo [c:50552749]
> （译文：大家好像都被 Gemini 这套命名搞得又气又懵，但我挺喜欢的。而且说真的，如果你搞不清了，元素周期表大概是全世界最普及的一张有序表，足以让人很快理出头绪。）

### 三、比价格更难的是「你到底能用哪个」

价格本身有人算清楚了，问题是同一份价格表在不同人眼里对不上号。评论区流传的这张表，把速度档和 API 单价钉在一起：

> "(S) Gemini 4 Hydrogen - fastest - $1.50&#x2F;$7.50
> (M) Gemini 4 Neon - second fastest - $3&#x2F;$15
> (L) Gemini 4 Argon - second slowest - $2&#x2F;$10 (till Nov 30), $4&#x2F;$20 (&gt; Nov 30)
> (XL) Gemini 4 Carbon - slowest - $2&#x2F;10 (till Nov 30), $4&#x2F;$20 (&gt; Nov 30)" — adithyareddy [c:50552645]
> （译文：（S）Gemini 4 Hydrogen——最快，$1.50／$7.50
> （M）Gemini 4 Neon——第二快，$3／$15
> （L）Gemini 4 Argon——第二慢，11 月 30 日前 $2／$10，之后 $4／$20
> （XL）Gemini 4 Carbon——最慢，11 月 30 日前 $2／10，之后 $4／$20）

真正让人不爽的是订阅档位这套迷宫。$20 档和 $100 档能摸到的模型完全不一样：

> "Uh yeah, is this the big news of this announcement? They are moving all the good coding models into the Ultra price tier." — jeffbee [c:50553996]
> （译文：呃，所以这次发布的大新闻是这个？他们把所有好用的编码模型都挪进 Ultra 价格档了。）

> "On the $20&#x2F;mo tier, Argon has been removed from the web interface and app, but is still available in Antigravity (while Carbon is only on the $100&#x2F;mo tier in both)." — _delirium [c:50553615]
> （译文：看起来很不一致。在 $20／月档，Argon 已经从网页端和应用里下架，但在 Antigravity 里还能用（而 Carbon 两边都只有 $100／月档）。）

也有用户当场否认「好模型都在 Ultra」这种说法：

> "Are they? Neon seems great and it’s available on the Pro tier." — Ternari [c:50554544]
> （译文：是吗？Neon 看着挺不错的，而且 Pro 档就能用。）

至于配额焦虑，另一个方向的话术更干脆——问题不在模型，在用户怎么用模型：

> "Worse, people burning dumb prompts on large models also has the net effect of shrinking quotas for everyone." — WarmWash [c:50552761]
> （译文：更糟的是，人们在大模型上烧蠢 prompt，净效果是所有人的配额都被压小了。）

### 四、模型到底多大：全是传闻，硬约束是显存

问 Neon 有多少参数，没有人答得上来，评论区只能互相转述传闻：Google 的模型明显比 OpenAI、Anthropic 的小一档，却想在同一层级上掰手腕。

> "I think the rumor-mill consensus is that Google&#x27;s models are significantly smaller while attempting to swing at the same level - but the ratios AFAIK are thought to be around the same  - i.e. Neon is <i>somewhere</i> around half as big as Carbon, big enough that a newer checkpoint can make it temporarily a little bit better." — onlyrealcuzzo [c:50552847]
> （译文：我听说圈子的共识是，Google 的模型明显更小、却想跟同级别掰手腕——不过据我所知比例大致相当，也就是说 Neon <i>大概</i>是 Carbon 的一半大，而一个更新的 checkpoint 足以让它暂时强上一点点。）

真正硬的一条约束来自硬件算术：

> "A GB300 rack has 72x288GB=20TB VRAM. Do the math and 10T parameter models are just about the max size you can easily train and serve (at 1M context) without doing a lot of custom hardware development or limiting your scale." — weitendorf [c:50553263]
> （译文：一个 GB300 机架是 72×288GB=20TB 显存。算一下就知道，100 亿参数级的模型差不多就是你能轻松训练和服务的上限了（还是在 100 万上下文的前提下），除非你去做大量定制硬件开发或者压缩规模。）

如果参数规模本身不是命名依据，那差别只能藏在别的地方：

> "I have to assume they&#x27;re messing with something other than size here - nobody would be <i>this</i> bad at naming different model sizes." — daemonologist [c:50553119]
> （译文：我只能假设他们在尺寸之外还动了别的手脚——没人会把不同尺寸的模型起成 <i>这么</i>糟糕的名字。）

Argon 的去向也在这一轮被顺手解决了，一句话就把两个模型合并成一个：

> "Carbon is just Argon with extended thinking." — lukax [c:50552895]
> （译文：Carbon 就是开了 extended thinking 的 Argon。）

> "Argon is already deprecated." — thevillagechief [c:50553125]
> （译文：Argon 已经弃用了。）

### 五、「新的就是更强的」——规模叙事正在退场

这帖最深的一层不是命名，是「尺寸不等于实力」。有人把发布节奏和命名混乱连在一起解释：

> "at the pace they are launching new models - and the similarity of model sizes between Neon&#x2F;Carbon, Opus&#x2F;Fable, Sol&#x2F;Astra - the best model is going to be the most recently released one, not the biggest one." — onlyrealcuzzo [c:50552601]
> （译文：按他们这个发布节奏，加上 Neon／Carbon、Opus／Fable、Sol／Astra 之间尺寸相近——最好的那个模型将会是最近发布的那个，而不是最大的那个。）

这个判断还带来一个日常结论：多数人根本用不上最大的那个。

> "At this point a model like hydrogen can cover just about everything an average person is doing. You don&#x27;t need Carbon deploying an agent swarm pushing terabytes of parameters through HBM memory to help you plan your birthday party." — WarmWash [c:50552615]
> （译文：到今天这个阶段，像 hydrogen 这样的模型已经能覆盖普通人的几乎所有需求了。你不需要为了策划一场生日派对，让 Carbon 派出一支 agent 群、把数 TB 的参数推过 HBM 内存。）

> "It very well might be better. Nowadays being newer tends to matter more than being bigger." — WarmWash [c:50553222]
> （译文：它很可能确实更好。如今「更新」往往比「更大」更重要。）

有人干脆甩出老论文当判词：

> "<i>The Bitter Lesson - Richard Sutton (2019)</i>" — andai [c:50552900]
> （译文：<i>苦涩的教训——Richard Sutton（2019）</i>）

而这条线往下追，就撞上一个更根本的问题：

> "Do you believe the amount of available training data has stopped growing?" — sdenton4 [c:50554564]
> （译文：你相信可用的训练数据量已经停止增长了吗？）

### 六、能力到底行不行：有人私下跑了分

能力这条线反而最短，因为多数人不打算在评论区逐格对表。真正做了实测的，是自己搭了私有测试集的那种用户——而且他测的是上一代的 Carbon：

> "Running my benchmarks to verify their quality claims. Carbon performed very well on my private suite - spitting distance to Opus 5.5." — aenis [c:50552850]
> （译文：我跑了自己的基准来验证他们的质量宣称。Carbon 在我的私有测试集上表现非常好，离 Opus 5.5 只差一点。）

对性价比的判断则明显偏另一边：

> "That looks to me like OpenAI equals or beats everything Google offers at half the price." — jeffbee [c:50552739]
> （译文：在我看来，OpenAI 用一半的价格提供了和 Google 相当、甚至更好的东西。）

至于这张牌该怎么打，多数人给的是实用主义答案：

> "Hydrogen is the new flash, at least" — kzrdude [c:50552882]
> （译文：至少 Hydrogen 就是新的 Flash。）

> "How do you decide which model is best for telling you which model to use?" — jimbokun [c:50552972]
> （译文：你怎么决定哪个模型最适合告诉你该用哪个模型？）

> "At this point you just use roulette on which Gemini model you&#x27;ll use for a task" — bloky [c:50552503]
> （译文：到这一步，做任务选哪个 Gemini 模型干脆就轮盘赌吧。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 名字彻底没法读 | drum55 | 四个思考档加不同默认值，矩阵无从下手 |
| 恭喜 Google 刷新命名混乱纪录 | 3wolf | 命名上赢了 OpenAI 和 Anthropic |
| 用户得先学化学 | ehsankia | 会背元素周期表才能选模型 |
| 查表是产品问题不是用户问题 | accrual | 不该指望人人背原子序数 |
| 命名就是随意的 | Mogzol | 真实规模是 Hydrogen 小、Neon 中、Carbon 大 |
| 元素序、价格序、能力序三套 | wat10000 | 三条排序线互相打架 |
| 用密度解释 | georgemcbay | 氢 0.0000899、碳 2.267 |
| 字母序，像 Ubuntu 发行版 | dudeinhawaii | 名字对应的是发布新鲜度 |
| 周期表够用了 | baoooooooooooo | 全世界最普及的一张有序表 |
| 参数规模只是传闻 | onlyrealcuzzo | Neon 传闻约为 Carbon 的一半大 |
| 硬件才是硬上限 | weitendorf | 20TB 显存对应 10T 参数天花板 |
| 尺寸之外还动了别的 | daemonologist | 否则没人会把名字起得这么烂 |
| Carbon 就是 Argon 加思考 | lukax | Argon 已经弃用 |
| 新的比大的好 | WarmWash | 如今更新比更大更重要 |
| Hydrogen 已经够用 | WarmWash | 策划生日派对用不着 Carbon |
| 苦涩的教训 | andai | 2019 年就写好的判词 |
| 训练数据见顶了吗 | sdenton4 | 一个反问 |
| 能力确实到了前沿 | aenis | 私有测试集上离 Opus 5.5 只差一点 |
| OpenAI 性价比更高 | jeffbee | 一半价格打平甚至更好 |
| Hydrogen 就是新 Flash | kzrdude | 至少看起来是 |
| 选型靠掷骰子 | bloky | 轮盘赌 Gemini |

## 总体情绪

这帖的两股情绪拧在一起，一股是认 strengths 的：官方数字漂亮，Artificial Analysis 智能指数冲到全球第三、每任务成本比 Carbon 低 32%，有人私下跑分发现上一代 Carbon 已经贴到 Opus 5.5，而想用 Neon 的人发现 Pro 档就够，不必掏 Ultra 的钱。另一股是嫌恶的：名字起得莫名其妙，四档思考级别默认档各不相同，$20 档和 $100 档能摸到的模型互相打架，参数规模官方一个字都不说。两种情绪指向同一个结论——能力这次没人真挑出毛病，毛病全在产品设计上。

分歧的真正焦点是「该按什么选模型」。一派认为这是 Google 有意为之：名字故意模糊，逼你去看模型描述符而不是背名字，反正多数人最终都会用氢气这个档。另一派认为纯粹是失序：原子序数、密度、字母序、发布日期，每种解释都能找到反例。争到最后，两派其实共享同一个前提——「更新的比更大的好」，这也解释了为什么 Carbon 到底是不是 Argon 的换皮、Argon 是不是已经弃用，反而没人真正在意。

Google 花了几十个季度把 Neon 调快、调便宜，评论区只用了一个下午就把它翻译成了「原子序数 10」——然后发现官方从头到尾没公布过 Neon 到底有多少参数。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Gemini 4 Neon（HN 主帖） | <https://news.ycombinator.com/item?id=50552424> |
| 2 | Introducing Gemini 4 Neon（原文） | <https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-neon/> |
| 3 | Gemini 4 家族定位（原文锚点） | <https://blog.google/innovation-and-ai/models-and-research/gemini-models/introducing-gemini-4-neon/#:~:text=Where%20Neon%20sits%20in%20the%20Gemini%204%20family> |
| 4 | Artificial Analysis 智能／效率指数（评论区引用） | <https://artificialanalysis.ai/#intelligence-efficiency-tabs> |
| 5 | The Bitter Lesson（评论区引用） | <https://news.ycombinator.com/item?id=19393432> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 476 分、438 条评论，归档快照 2026-11-19 02:20 UTC，入库 100 条，抓取上限 100）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

跑分、价格与能力描述（Artificial Analysis 智能指数 61 分与全球第三、Vals Index 70.9%、Agent Arena Index 1336、Legal Research Bench、Tax Agent Bench、Surge AI、Zapier AutomationBench 56.3%、Vending-Bench 2 的 $16,843、Terminal-Bench Science 70.5%、RiemannBench 84.0%、HLE-Diamond 71.3%、Coding Agent Index 58.6、Terminal-Bench 4.1 65.2%、FrontierCode 2.0 46.2%、SWE-sweep 12.8% 与 39.0%、AutoBaxBench 76%、WebExploitBench 51.26%、SEC-bench Pro 90.5%、CWE-bench v2 70.7%、输入 3 美元／输出 15 美元／缓存 0.15 美元、100 万 token 上下文、每任务成本低 32%、以及拒答率与失配动作率等安全数字）均转述自 Google 官方发布页，未做独立核实。归档抓取的原文正文在 8000 字符处截断（抓取上限），本文另经网页抓取补齐了安全与家族定位段落。模型档位划分（哪些模型对应 S／M／L／XL、哪些订阅档可用）来自评论区用户观察，非官方声明。

「Neon 约为 Carbon 一半参数」「Carbon 就是加了 extended thinking 的 Argon」「Argon 已弃用」「OpenAI 同价更强」「训练数据已见顶」「命名是故意模糊的」等均为评论区个人推测或传闻，Google 未作回应，本文按发言者立场转述，不作事实认定。评论区对同一现象存在直接冲突的描述（Neon 算不算便宜、Argon 是否被下架），本文按原帖并列呈现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
