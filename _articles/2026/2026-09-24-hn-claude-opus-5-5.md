---
layout: post
title: >-
  Claude Opus 5.5 登场：跑分上去、价格砍 40%，写作还是那个味道
date: 2026-09-24
hn_id: 49803892
categories: [articles]
excerpt: >-
  Anthropic 跳过 5.1-5.4 直接推到 Opus 5.5，价格砍 40%、缓存读砍 60%；但「Claude cadence」依旧是讨论区的核心槽点。
tagline: >-
  跳过版本号不是性能跃迁，是囚徒困境下的发布会。
---
来源：[HN 热门榜](https://news.ycombinator.com/item?id=49803892)（1741 分，1044 条评论），9 月 22 日 Anthropic 主帖；同日两帖为 [Artificial Analysis 性能与价格分析](https://news.ycombinator.com/item?id=49804316)（326 分，103 条评论）和 [重复帖](https://news.ycombinator.com/item?id=49803863)（273 分，2 条评论已合并到主帖）。三条帖子在 HN 上的解读重叠、互相引用。

## 原文概要

9 月 22 日 Anthropic 在博客发布 Claude Opus 5.5——Claude 5.5 家族的首款模型，也是公司首席 Dario Amodei 在「[We Must Pace the Frontier](https://darioamodei.com/post/we-must-pace-the-frontier)」里呼吁放缓之后的第一款正式发布。发布前由 Frontier Design 和 METR 跑外部评估，Anthropic 自家的自动化行为审计（automated behavioral audit）给了有史以来最高分；模型被部署在与 Claude Mythos 5.1 等同的网安和生命科学防护之下，因此当防护触发时，相关任务由 Claude Opus 5 或 4.8 顶替完成。

Anthropic 把 Opus 5.5 定位于「与 Claude Fable 5.1 同档，对典型工作比 Opus 5 便宜 40%」。新定价：缓存读 $0.20/1M tokens（-60%）、输入 $4/1M（-20%）、输出 $20/1M（-20%）、Fast 模式 2.5× 速度、$8 / $40。Pro、Max、Team、seat-based Enterprise 的 5 小时额度上调，并新增可保存一次的 rate limit reset。早期测试者给出的 case 是：一天内完成 680,000 行代码迁移（团队要数周）；让 5.5 在一个 web 应用上逐页降低加载时间 40 次成功 39 次、而 Opus 5 改得更轻但改变了应用行为；同一个 prompt 让 Claude 们各自做游戏，5.5 的画质与精致度最高。

基准对比（Anthropic 自家报）：agentic coding（Terminal-Bench 4.0）：Opus 5.5 66.4%、Fable 5.1 55.8%、Opus 5 52.3%、GPT-6 Astra 57.9%、GPT-5.6 Sol 37.3%；FrontierCode v1.1：54.4% / 50.3% / 48.0% / 53.3% / 47.5%；CursorBench 4.0：57.8% / 51.8% / 46.6% / — / 41.7%；GDPval-AA v2.1：1846 / 1735 / 1708 / 1542 / 1588；AutomationBench：40.0% / 31.4% / 26.9% / 41.4% / 28.8%；Humanity's Last Exam with tools 67.7% / 65.6% / 63.6% / 57.2% / —；Computer use OSWorld 2.0 partial 81.8%；Visual chart recognition Chartography 89.0%。

Anthropic 自己补了一句：「在这些能力段，benchmark 的差距对实际工作差异是个不太可靠的指南。」Sonnet 5.5 和 Haiku 5.5 将在未来数周跟进，共享同样的表现、效率与安全改进。

## 讨论焦点

### 跳过的版本号，是撞顶还是囚徒困境？

主帖一开门就有人贴段子：「所以我们跳过了 5.1、5.2、5.3、5.4——我们真的在撞顶了。」 撑住这层怀疑的 j_heffe 把怀疑推到位：

> "Maybe it's the time period we're in, maybe I'm just grumpy, but it bugs me that they release a new model every single week and the new one is just a fine-tuned version of the 'old' one. If 5.5 performs similar to Fable and really does cost 40% less, then 5.5 really should've just been Opus 5. And they're essentially admitting that they are shipping slop." — j_heffe [c:49805485]
>
> （译文：我们这一行到底怎么了，我现在这心情，可能就是觉得这事儿憋得慌：他们每周就丢一个新模型，新模型又是「上一个」的微调。如果 5.5 真能跟 Fable 一样又便宜 40%，那它应该叫 Opus 5。说穿了，他们就是在承认自己在出货 slop。）

与之相对，「缓速发展」叙事在主帖里被反复点名。抛出来的引子来自早上 mupuff1234：「What happened to 'slowing down'?」 接下来 nozzlegear 把这事直说了：

> "Dario found himself in the prisoner's dilemma." — nozzlegear [c:49804182]
>
> （译文：Dario 自己是囚徒困境里那个人。）

> "Slowing down only makes any sense if you can coordinate a slow-down for everyone." — petesergeant [c:49804086]
>
> （译文：「缓速」只能在所有人都缓速的前提下成立。）

### 「Claude cadence」这次没改善多少

主帖里第二条高密度讨论串是 Opus 5 留下来的写作文风（被网友戏称 claudisms）到底解决了没有。variety8675 帖子一上来就表达期待，紧接着是一连串「我让 5.5 写了段代码注释，结果还是这个味儿」。

> "I don't think it's substantially different. I just pasted a random chunk of code and asked Opus 5.5 to comment on it... It has the same annoying cadence and writing style with slightly less prominent claudisms." — dgroshev [c:49804181]
>
> （译文：差别没多大。我随便扔了一段代码让 Opus 5.5 写注释——同一个讨厌的 cadence，同一套写作口吻，只是 claudisms 没那么明显了。）

> "How? Explicit instructions, memories and even skills have not been able to keep Claude from saying 'genuinely' every two sentences and keep it from explaining heavily what something isn't." — mavamaarten [c:49804557]
>
> （译文：怎么才能改？显式 prompt、memories、skills 加上去都拦不住它两句一个「genuinely」，拦不住它花一大段去解释「它不是什么」。）

crufle_duffle 直接否决了「5.5 是 Opus 6 半步」的命名：

> "Honestly I trust opus so little that the entire 'opus' brand is completely tarnished. Its writing style is so god awful that it needs more than just a point release. Either dump the name and ship a different model entirely or at minimum call it 'opus 6'. Calling it 5.5 makes it sound like it's basically a continuation of the same garbage output that 5.1 had but with some minor adjustments." — cruffle_duffle [c:49806895]
>
> （译文：说真的，我对 Opus 这个品牌已经完全不信了。它的写作风格烂到要重新设计而不是点版本号。要么换名字直接发新模型，要么至少叫「opus 6」。叫它 5.5，听着就像 5.1 那套垃圾输出里加了点微调。）

### Max 推理模式被思维预算卡死（鹈鹕实验）

跑分帖（49804316）的核心爆料来自 Simon Willison。他把 Anthropic 上线时对外宣传的 Max 推理当跑分对象，但让它画一只「骑自行车的鹈鹕」SVG 图——结果两次都把 128,000 token 的思维额度花光，仍在「reasoning about the problem」循环里，没出答案。

> "I've failed twice to get 'Generate an SVG of a pelican riding a bicycle' to work with max, because in both cases it ran out of the 128,000 token budget while it was still reasoning about the problem. I'm suspicious that 'max' may be virtually useless if it's that easy to have it overthink to the point that it doesn't get to a response." — simonw [c:49805100]
>
> （译文：我两次试都没让 Max 把「画一只骑自行车的鹈鹕 SVG」跑通——两次都在 128,000 token 思维预算上烧光时还在「推理问题」。我开始怀疑「max」这个档位几乎是没用的，能这么容易把自己想死，连答案都到不了。）

alansaber 跟进一句对 Anthropic 的嘲讽：「I'm amazed they didn't test xhigh thinking mode explicitly to ensure it didn't exceed the 128k thinking budget allocation. I guess pace of development gets away from everyone, even OpenAI.」他接着补了一句近乎吐槽的话：「步子迈得快，谁都跑偏——OpenAI 也一样。」

### 模型性能真的会随时间回退吗？

跑分帖里更尖锐的副线是 breckenedge 在内网重跑了两周前同一套代码审查 dataset，发现 OpenAI 的 GPT-5.6 Sol 在两次跑之间从 40-50 个 bug 掉到 25 个，与 GPT-5.6 Luna 相当。他点名了 OpenAI 的 tedsanders，tedsanders 当晚回帖（自报 OpenAI 员工）：

> "GPT-5.6 Sol's performance in the API should not change over time. If it has, that's a severe bug and we'll look into it. We do sometimes tweak ChatGPT settings (e.g., tools, system prompts, efforts) over time, but we never play games to juice evals at launch times. You should always get what's advertised." — tedsanders [c:49809266]
>
> （译文：GPT-5.6 Sol 在 API 里的表现不会随时间变化。如果真变了，那是严重 bug，我们会查。ChatGPT 的设置（工具、系统 prompt、effort）我们有时会调，但我们不会为了发布时的跑分作弊。你拿到的就是标的的东西。）

> "Serial testing over time is much less reliable than side by side testing, and even when I do side by side testing, I try to look at multiple attempts per prompt. Seeing multiple per prompt helps me realize how much intrinsic variation there is. My brain always wants to see patterns even when there isn't enough data to prove them." — tedsanders [c:49817602]
>
> （译文：跨时间的串行测试远不如并排测试可靠，即便我跑并排测试也会同一 prompt 看多个 attempt。看到多个 attempt 才有助于意识到模型本身的方差有多大。我的脑子总想看到模式，即便数据根本不够证明。）

Artificial Analysis 帖也因此被这次实锤带歪——doctorpangloss 一句插评：「ArtificialAnalysis tweaks stuff until newest big proprietary model is on top, not you haha.」

### 营销页的「scrollslop」

主帖里另一条脱离产品本身的高分讨论是关于 Anthropic 发布页的滚动动画——m4tthumphrey 上来就发火：「Just post the bloody content. This UI/scrolling thing is horrific.」halyconWays 把这种 UI 取了个名字：

> "I call it scrollslop" — halyconWays [c:49804329]
>
> （译文：我叫这玩意儿 scrollslop。）

> "Hijacking the scroll wheel has existing long before 'AI'. Many 'high end design' websites that want to 'tell a story' get woo'd into thinking it's a good idea. It's terrible, and feels like your scroll wheel is stuck in quicksand." — josefresco [c:49804610]
>
> （译文：劫持滚轮这事儿「AI」之前就有好多年了。一堆「高端设计」网站想「讲故事」，被忽悠得以为这是个好主意。但体验很差——你的滚轮像陷在流沙里。）

oefrha 把这条历史蹭过去：「Parallax scrolling effects were very cool ~2010. By 2015 or maybe earlier it already felt like me-too design that's unoriginal and a little annoying. By 2020 everyone and their mom has it and it's super tiresome. Now it just screams slop design.」amluto 顺着节奏开玩笑：

> "Claude Opus 5.6 should have a new 'UX safety' feature that requires annually-renewed preauthorization to generate webpages that hijack scrolling :)" — amluto [c:49804558]
>
> （译文：Claude Opus 5.6 该上新「UX 安全」功能了：每年重新拿一次预授权才能生成劫持滚轮的网页 :)）

Safari 端的受害报告也夹在里头——serchinastico 在 Firefox 上根本没刷过 hero 区，anon373839 给出 Apple 这边的奇葩绕过：「The fix for this is to tap the overflow menu icon and choose 'Reduce privacy protections'. (Wtf, Alibaba?) This appears to be related to use of iCloud Private Relay.」Alibaba 的 Qwen 公告页在 Safari 上展示成「一个永远停不下来的脉动动画」，看来 scrollslop 不是 Anthropic 一家专利。

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 撞顶警告 | alpineman [c:49803976] | 跳过 5.1-5.4 = 我们真的在撞顶 |
| 囚徒困境 | nozzlegear [c:49804182] | Dario 是囚徒困境里那个人 |
| 写作没改善 | dgroshev [c:49804181] | 同样的 cadence，只是 claudisms 没那么明显 |
| 写作问题彻底 | cruffle_duffle [c:49806895] | Opus 品牌被这个写作风格毁掉了，叫它 5.5 太宽容 |
| Max 推理翻车 | simonw [c:49805100] | Max 把 128K 思维预算花光还没出答案 |
| 性能会随时间掉 | breckenedge [c:49805073] | 我重跑两周前的 dataset，Sol 从 40-50 bug 掉到 25 |
| 官方止血 | tedsanders [c:49809266] | API 表现不该变；若变，是严重 bug（OpenAI 员工） |
| 滚动动画灾难 | halyconWays [c:49804329] | 我管它叫 scrollslop |
| 滚动劫持是旧问题 | josefresco [c:49804610] | 劫持滚轮这事 AI 之前就有好多年了 |
| 价格诚意 | hglaser [c:49804835] | 比 Opus 5 任务成本直接砍一半，确实很香 |

## 总体情绪

情绪大致是「性能价钱点赞、品牌写作减分」的格局。开局的乐观被「Annex 5.5 是 5.1 微调 + 价格下调」这类怀疑快速稀释；中段用户实测又把「写作文风没改」落实成实锤——dgroshev 把 5.5 写出来的代码注释原文摆上来，跟 Opus 5 摆在一起，几乎只有花式标点的差别。尾段 Simon Willison 的鹈鹕实验把 Max 推理档位从「遥遥领先」打成「128K 思维预算都花光没出答案」，让整篇 5.5 基准表的领先更显得像是把墙刷了的版本号工程。

但讨论里也有一条不容忽视的副线：用户对模型「发布时很强、几周后变弱」的怀疑被 OpenAI 员工 tedsanders 在 HN 上公开、直白地答复——「API 表现不该随时间变；若变，会查」。这种公开回应过去两年在同类怀疑里是少见的，因此即便 Anthropic 的发布延期打脸、Opus 5 的 claudisms 原封不动，HN 的整体语气仍然停留在「谨慎乐观、把怀疑写进下次的 eval 流程」。

> 「serial testing over time is much less reliable than side by side testing... My brain always wants to see patterns even when there isn't enough data to prove them.」— tedsanders [c:49817602]

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | Introducing Claude Opus 5.5（主帖, Anthropic 博客） | <https://news.ycombinator.com/item?id=49803892> |
| 2 | Claude Opus 5.5 Intelligence, Performance and Price Analysis (Max)（跑分评测, Artificial Analysis） | <https://news.ycombinator.com/item?id=49804316> |
| 3 | Introducing Claude Opus 5.5（重复帖, 已并入主帖讨论） | <https://news.ycombinator.com/item?id=49803863> |

<div class="disclaimer">

**免责声明**：本文是对 Hacker News 用户讨论的编译与提炼，不代表本网站立场。讨论内容版权归原作者所有。摘要内容仅反映 HN 社区及原文作者观点，不构成对任何企业、模型或产品的评价。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
