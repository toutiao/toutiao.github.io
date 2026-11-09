---
layout: post
title: >-
  Claude Fable 5.2 与 Mythos 5.2：跑分压过 Opus 5.5，单任务账单却翻倍 — HN 讨论摘要
date: 2026-11-10
hn_id: 50429906
categories: [articles]
excerpt: >-
  同一个晚上，Anthropic 发布 Fable 5.2 与 Mythos 5.2，跑分全面压过旗舰 Opus 5.5，
  第三方评测却算出单任务 26.54 美元、耗时 45 分钟；隔壁那篇 655 分的帖子正在追问
  Opus 5.5 是不是被悄悄削弱了。榜单和账单，给出了两个相反的答案。
tagline: >-
  官宣叫 5.2，跑分赢了 5.5，账单不认版本号。
---

> 来源：HN 讨论主帖 [Claude Fable 5.2 and Mythos 5.2](https://news.ycombinator.com/item?id=50429906)（751 分，422 条评论），原文是 Anthropic 的模型发布公告。本篇为 cluster 模式，覆盖 3 个讨论帖：主帖 50429906、相关帖 50431144（Claude Fable 5.2 Scores 65 on Artificial Analysis, Highest So Far，115 分）、相关帖 50422069（Is Opus 5.5 nerfed? Thinking patterns changed on November 3，655 分）。归档快照 2026-11-09 22:01 UTC，入库评论 100 / 60 / 141 条。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

Anthropic 发布 Claude Fable 5.2 和 Claude Mythos 5.2。这两个名字背后是同一个底层模型，区别只在护栏：Fable 加了网络安全和生物学的安全护栏，因此直接面向所有用户开放；Mythos 去掉这些护栏，只对通过生命科学、网络安全验证计划审核的机构开放。

公告里的成绩单很密。预发布阶段，模型帮工程师完成了原本不可行的软件迁移，从零设计出三台能跑起来的电子设备，解决黑洞物理中的两个开放问题，并在 30 小时内形式化证明了费马大定理。基准表里，Fable 5.2 在 FrontierCode 2.0 上拿到 49.1%（Xhigh effort），Opus 5.5 是 45.5%，GPT-6 Astra 42.8%，Gemini 4 Carbon 41.1%；FrontierSWE v2 69.9% 对 62.3%；RoboDojo Sim 64.9% 对 Fable 5.1 的 27.6%；Humanity's Last Exam（带工具）74.2% 对 65.6%。带上 Mythos 护栏放宽后的成绩更高：CyScenarioBench 76.3%、CVE 复现 89.6%、24 小时从头设计蛋白结合剂 85.1%。最能说明问题的一栏是 Remote Labor Index——41.3%，而 Opus 5.5 是 21.3%，Fable 5.1 是 17.9%，其他两家大约 20%。

价格却是往下走的：$8 每百万输入 token、$40 每百万输出 token，比 5.1 便宜；输出速度最多快 30%；还有一个可选的 fast 模式，生成速度再快 2.5 倍，价格是 $16 和 $80。公告另外强调效率：在 FrontierCode 2.0 上，Fable 5.2 的 High effort 大致等于 Opus 5.5 的 Max effort，而单任务成本只有一半。Anthropic 内部的数据也摆出来了——核心代码库超过 90% 的合并改动由 Claude 写（有人类引导）；一队 agent 用早期版 Fable 5.2 把一个关键生产服务从 Python 迁到 Rust，服务启动快了约 26 倍；还有一名工程师让模型从空目录开始设计一个原型操作系统，模型协调了 1000 多个子代理，连续工作八天，产出一个能在笔记本上启动的系统——自带内核、磁盘键盘网络驱动、永久存储、窗口、登录界面、安装器和内置的 Claude 功能。

同一晚，HN 上还有另一个帖子同时在烧分。相关帖 50422069 引用了一条 X 帖子：有人用 Gemini 4 Argon 分析了 1400 段 Claude Code 会话，发现 11 月 3 日那天，模型名字没变，但推理方式「陡然转向」。那个帖子拿了 655 分，比发布帖的讨论还早一个多小时开火。第三方评测那边也紧跟着贴了数据：Artificial Analysis 给 Fable 5.2 的智能指数是 65（同档中位数 40），单任务成本 26.54 美元，单任务耗时 45 分钟（同档中位数 12.9 分钟），跑完这一套指数烧掉 2.75 亿 token（同档中位数 7280 万）。发布公告里写着「更便宜」，评测页上写着「更贵」，两句话都没说错，只是量的是两件事。

## 讨论焦点

### 一、旗舰为什么叫 5.2：版本号比模型先乱了

版本号是评论区最先抓到的破绽。旗舰 Fable 是 5.2，次旗舰 Opus 是 5.5，而这次公布的表格里 Fable 5.2 几乎全面赢过 Opus 5.5。

> "Very interesting that they set the flagship&#x27;s version number to 5.2, but their penultimate model is 5.5." — ealready_value [c:50430126]
> （译文：很有意思，旗舰的版本号定在 5.2，次旗舰模型却是 5.5。）

也有读者干脆说这就是 5.5 换了个名字，理由是价格和速度都跟 5.1 不一样，架构不可能没变：

> "The pricing is different than 5.1, the model is faster than 5.1." — bhu8 [c:50431164]
> （译文：价格跟 5.1 不一样，速度也比 5.1 快。）

> "So, this is probably Fable 5.5; it&#x27;s just named Fable 5.2." — bhu8 [c:50431164]
> （译文：所以这大概率就是 Fable 5.5，只是被叫成了 Fable 5.2。）

更进一步的说法来自系统卡：有读者翻到第 39 页，给出「这只是 Model 3」和「Anthropic 手里还压着一个明显更强的模型」两个判断。

> "No this is only Model 3." — dwohnitmok [c:50431978]
> （译文：不，这只是 Model 3。）

> "Pretty crazy that Anthropic already has another model waiting in the wings that is <i>significantly</i> better than this." — dwohnitmok [c:50431978]
> （译文：Anthropic 手里已经压着一个明显强得多的模型，这事挺离谱的。）

还有一条关于发布流程的观察：通常新模型要等一段时间才铺开，这次是发布即到位。

> "Surprisingly the model is available immediately in my Claude Code: usually there&#x27;s a delay, either for rollout or safety." — minimaxir [c:50430085]
> （译文：有点意外，这次我的 Claude Code 里立刻就能用：一般来说会有个延迟，要么是灰度节奏，要么是安全审查。）

把这些线索拼起来的还有一条更尖的：既然 Fable 5.2 已经比 Opus 5.5 强，Opus 5.5 那张榜是在削弱之前跑的还是之后跑的。

> "Was this before you lobotomized Opus 5.5 or after?" — shmoil [c:50429993]
> （译文：这是你们把 Opus 5.5 阉割之前跑的数据，还是之后跑的？）

### 二、单价降了，单任务账单却翻倍

Anthropic 反复强调降价，但评测方盯的是另一笔账：跑完一个任务要花多少钱。

> "Forget about the scores... look at the Cost Per Task. Fable 5.1 was already the most expensive by a good margin, and now Fable 5.2 doubles it! This is with the price cut." — rgbrenner [c:50432202] [thread 2]
> （译文：别看分数了，看单任务成本。Fable 5.1 已经是贵出明显一截的那个，现在 Fable 5.2 又翻了一倍——这还是降价之后。）

> "The output tokens per task just exploded. From 118k tokens (46k Answer&#x2F;71k Reasoning) in 5.1 to 274k tokens (81k Answer&#x2F;192k Reasoning) in 5.2." — rgbrenner [c:50432202] [thread 2]
> （译文：单任务的输出 token 直接炸了。从 5.1 的 118k token（46k 回答 / 71k 推理）涨到 5.2 的 274k（81k 回答 / 192k 推理）。）

针对这条，有两条相反的解读。同一线程里有人当场给出反例：单任务贵是因为评测跑在最高档，换成 medium 或 high 就不是那么回事。

> "Change the models in the dropdown to medium &#x2F; high and Fable 5.2 is about twice as cost efficient, and slightly faster." — Tadpole9181 [c:50432212] [thread 2]
> （译文：把下拉框里的模型切到 medium / high，Fable 5.2 的成本效率大约翻倍，还快一点。）

另一条则认为成本焦虑被放大了：

> "Most people never run out of plan usage, so the cost per task matters relatively little." — mordymoop [c:50432391] [thread 2]
> （译文：大多数人的订阅额度根本用不完，所以单任务成本其实没那么重要。）

这一条很快被人当场反驳：

> "It rebuts what you said because your statement that &quot;the cost per task matters relatively little&quot; is not true in the slightest." — qeternity [c:50432565] [thread 2]
> （译文：它正好反驳了你说的那句「单任务成本没那么重要」，因为那句话一点都不成立。）

真正的分歧点被点破了：对拿 API 价的公司来说，「单任务成本」就是成本；对订阅用户来说，它取决于你的 harness 默认停在哪个档位。

> "My beloved predictability is destroyed and trying to get users to understand this is useless." — njovin [c:50432390] [thread 2]
> （译文：我那份宝贝般的可预期性被毁了，而指望用户理解这件事是没用的。）

主帖里也有人得出同一个结论，只是更粗粝：

> "the winning benchmark is much more expensive than what it cost for the same on 5.1" — oh_no [c:50432600]
> （译文：赢下这个基准的花费，比 5.1 做同一件事贵得多。）

> "i&#x27;m begging people to stop looking at token prices" — oh_no [c:50432600]
> （译文：我求求大家别再看 token 单价了。）

### 三、Opus 5.5 是不是被削弱了

相关帖 50422069 的起因是一条 X 帖子：作者用 Gemini 4 Argon 跑了 1400 段 Claude Code 会话，发现 11 月 3 日模型名没变，推理方式却陡然转向。评论区给出的证据几乎全是体感，但彼此惊人地一致。

> "I noticed Fable decline in quality a couple weeks ago. And I&#x27;ve noticed Opus drop over the last week, even after bumping to a default of Extra High reasoning for almost everything." — benwills [c:50422643] [thread 3]
> （译文：几周前我就发现 Fable 的质量在下降；这一周 Opus 也往下掉，哪怕我把默认思考档位调到 Extra High、几乎所有任务都这么跑。）

> "About two weeks ago it completely stopped working. Like ~85% success rate down to ~10% in my workflows." — jdcasale [c:50422710] [thread 3]
> （译文：大约两周前它彻底不灵了。在我的工作流里，成功率从 85% 左右掉到 10%。）

> "Token use exploded a week or two ago. I worked for a few hours and hit my 5 hour limit. Did only some simple bug fix. Somethings definitely broken." — shikck200 [c:50422673] [thread 3]
> （译文：一两周前 token 用量突然暴涨。我干了几个小时就撞上 5 小时上限，只做了个简单 bug 修复。肯定是哪里坏了。）

至于原因，两种解释平分秋色。一种说是算力调度：旧模型量化一半，把产能让给即将发布的新模型。

> "They probably have a fixed amount of compute and they need to make space for new models that will be released. So they quantize existing models e.g. in half so that can use 50% of current capacity for new models." — lukax [c:50422979] [thread 3]
> （译文：他们手上的算力总量大概是固定的，又要给即将发布的新模型腾地方，于是把现有模型量化，比如砍一半，好让新模型吃掉 50% 的当前产能。）

另一种说法更直白，也更商业：

> "nerf them based on supply and demand, when you have a high demand, nerf it, but keep charging same price." — throwaw12 [c:50422997] [thread 3]
> （译文：按供需削弱它们——需求高的时候降质，但价格照收。）

反对意见同样明确：

> "It&#x27;s just a new summarizer, the model and performance itself is unchanged." — sunaookami [c:50422423] [thread 3]
> （译文：只是换了个新的 summarizer，模型和性能本身没变。）

主帖里也有人提供了一条更硬的现场证据：Claude Code 里的 Opus 5.5 第一次无视了一条长期指令，然后照样生成了 Opus 5 风格的 commit message。

> "ignore one of my standing instructions for the first time and then proceed to generate an Opus 5 style verbose and barely readable commit message" — r1ch [c:50431687]
> （译文：它第一次无视了我的一条长期指令，然后照样生成了一段 Opus 5 风格、啰嗦到几乎读不动的 commit message。）

还有一位把这件事直接接到 IPO 上：

> "Welcome to the world of post-IPO AI. Now the 20% growth needs to come somewhere, and profitability would be a nice starter." — perks_12 [c:50423066] [thread 3]
> （译文：欢迎来到上市后 AI 的世界。20% 的增长总得从某个地方来，能顺便开始赚钱就更好了。）

### 四、比分数更持久的是文风

跑分吵得再凶，也没人否认模型「更聪明」这件事；真正被反复提到的缺陷是文字。同一批评论里，抱怨的措辞高度一致。

> "I still find Opus 5.5 way too dense." — iamdelirium [c:50430527]
> （译文：我还是觉得 Opus 5.5 太密。比完全读不懂的 Opus 5 好太多了，但也就是「好一点」。）

> "It&#x27;s like every sentence becomes a struggle to parse: referencing things that haven&#x27;t been introduced, using too many pronouns, the lack of verbs and the passive tense..." — jojva [c:50431340]
> （译文：感觉每一句都要费劲去解析：引用还没交代过的东西、代词太多、缺动词、满是被动句式……）

还有人对版本的期待很直接：想要一个写作能对上 5.5 的 Fable，而不是现在这个还在用 5.0 说话口的。

> "Fable still talks a fair bit like Opus 5.0 for me, so i&#x27;d quite enjoy a Fable equivalent to 5.5." — unshavedyak [c:50430291]
> （译文：对我来说 Fable 说话还是像 Opus 5.0，所以我挺想要一个 5.5 级别的 Fable。）

在第三方评测那条线里，这种印象被写成了一个比喻：

> "has been like the well read snobbish kid at school that openly ignores me when I ask certain questions and often asks me to talk to someone else on other questions." — ProblemExplorer [c:50432507] [thread 2]
> （译文：就像学校里那个读了很多书、很自命不凡的小孩，我问某些问题他直接无视，还常让我去找别人问另一些事。）

### 五、护栏的另一面：拒答和脚注也进账单

公告把 Fable 的 cyber 与 bio 护栏写成产品卖点：比 5.1 更稳，误拦更少，还号称有史以来最强的防蒸馏保护。评论区的担心则来自这些护栏的实际体感——它们不只挡危险请求，还会挡正常问题，而且照常计费。

> "Almost every response it’s telling me “I could not verify X” where X is something that doesn’t need verifying." — joegibbs [c:50432511]
> （译文：几乎每条回复都在跟我说“我无法核实 X”，而 X 是根本不需要核实的东西。）

> "If Fable made Age of Empires you wouldn’t be able to play it because the entire screen would be full of footnotes and caveats." — joegibbs [c:50432511]
> （译文：要是 Fable 来做《帝国时代》，你根本玩不了，因为整个屏幕会塞满脚注和免责声明。）

同一位用户还提到另一层代价：被拒答也要从额度里扣。

> "At least Anthropic should not bill me for the refusal" — ProblemExplorer [c:50432507] [thread 2]
> （译文：至少 Anthropic 不该为一次拒答向我收费。）

### 六、基准能信到什么程度

对官方表格本身，评论区的态度是「先别急着信」。

> "I&#x27;m sure that they get early access to run the benchmarks, it wouldn&#x27;t have time to finish running if they were running it at public release" — jrflo [c:50432175] [thread 2]
> （译文：我敢肯定他们有优先权限去跑基准；如果是在公开发布那一刻跑的，根本来不及跑完。）

至于怎么验，答案朴素得让人意外：

> "The best benchmark is to use the model on a codebase you know well." — theplumber [c:50432567] [thread 2]
> （译文：最好的基准，是拿你熟得不能再熟的代码库去试这个模型。）

这张牌桌上也不只有两家人。有人直接替 Gemini 说话：

> "I actually just think it&#x27;s a meme to talk down on Gemini at any opportunity here." — drusepth [c:50432464] [thread 2]
> （译文：我倒觉得，这儿逢 Gemini 就踩一脚已经成了个梗。）

也有从成本一侧给前沿模型让位的：

> "Anthropic and OpenAI are expensive bleeding edge, but few use cases really need it." — danuker [c:50432813] [thread 2]
> （译文：Anthropic 和 OpenAI 是昂贵的先锋，但真正需要它们的场景没几个。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 旗舰叫 5.2 是刻意的混淆 | ealready_value | 次旗舰是 5.5，旗舰反而定在 5.2 |
| 5.2 就是 5.5，只是改名 | bhu8 | 价格和速度都变了，架构不可能还是 5.1 |
| 这次只放出来 Model 3 | dwohnitmok | 系统卡第 39 页起还有明显更强的模型 |
| 单任务成本才是真成本 | rgbrenner | token 价降了，单任务账单却翻倍 |
| 贵是因为跑在最高档 | Tadpole9181 | 切到 medium / high，成本效率翻倍还更快 |
| 成本焦虑被夸大了 | mordymoop | 大多数人订阅额度根本用不完 |
| 公司采购最怕不可预期 | njovin | 可预期性被毁掉，用户还理解不了 |
| Opus 5.5 确实被削弱 | jdcasale | 工作流成功率从 85% 掉到 10% |
| 削弱是为新模型腾算力 | lukax | 量化旧模型，让出一半产能 |
| 这是非确定性生意的常规操作 | throwaw12 | 需求高时降质，价格照收 |
| 什么也没发生 | sunaookami | 只是换了 summarizer，模型本身没动 |
| 削弱与 IPO 增长是一件事 | perks_12 | 20% 的增长总得有个出处 |
| 文风比分数更影响日常 | jojva | 每句话都要费劲解析，代词太多 |
| 基准要拿自己的代码库验 | theplumber | 最可信的评测来自熟项目 |
| Gemini 没有掉出牌桌 | drusepth | 逢 Gemini 就踩一脚已经成了梗 |

## 总体情绪

三场讨论的落点各不相同，但情绪是同一种：兴奋和记账同时发生。发布帖的读者在算架构、算版本号、算 1000 个子代理写出来的操作系统；评测帖的读者在算 26.54 美元和 45 分钟；nerf 帖的读者在算自己工作流里掉下去的 75 个百分点成功率和撞上的 5 小时上限。同一晚，Anthropic 交付了一个更便宜、更快、更强的模型，而用户拿到手的第一反应是把它和自己的旧账对上。

争议没有被解决。削弱是算力调度还是商业动作，只有 Anthropic 知道；官方表格是提前跑的还是发布后跑的，同样只有 Anthropic 知道。可以确定的是模型换代的节奏已经快过用户建立依赖的速度——那些把成功率从 85% 写进流程的人，和那些花 45 分钟跑完一次智能指数的人，测的根本不是同一个东西。

最后一个反问来自讨论里最短的一句：

> "With open weights, YOU get to decide when the model changes." — xscott [c:50422437] [thread 3]
> （译文：有了开放权重，什么时候换模型由你自己决定。）

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Claude Fable 5.2 and Mythos 5.2（HN 主帖） | <https://news.ycombinator.com/item?id=50429906> |
| 2 | 原文：Claude Fable 5.2 and Mythos 5.2（Anthropic 公告） | <https://www.anthropic.com/claude-fable-and-mythos-5-2> |
| 3 | Claude Fable 5.2 Scores 65 on Artificial Analysis, Highest So Far（相关帖 2） | <https://news.ycombinator.com/item?id=50431144> |
| 4 | 原文：Claude Fable 5.2 模型页（Artificial Analysis） | <https://artificialanalysis.ai/models/claude-fable-5-2> |
| 5 | Is Opus 5.5 nerfed? Thinking patterns changed on November 3（相关帖 3） | <https://news.ycombinator.com/item?id=50422069> |
| 6 | 原文：Claude Fable 5.2 and Mythos 5.2 System Card | <https://www.anthropic.com/document/claude-fable-5-2-mythos-5-2-system-card> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 751 分、422 条评论，归档快照 2026-11-09 22:01 UTC，入库 100 条；相关帖 50431144 入库 60 条；相关帖 50422069 入库 141 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；来自相关帖的引文另标 `[thread 2]`、`[thread 3]`；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于基准跑分、单任务成本、token 用量、成功率变化、模型量化等数据，均来自原文与归档评论引述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
