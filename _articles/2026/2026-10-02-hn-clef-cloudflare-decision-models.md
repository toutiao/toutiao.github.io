---
layout: post
title: >-
  Clef — Cloudflare 开源决策模型与 RL 微调平台 — HN 讨论摘要
date: 2026-10-02
hn_id: 49923692
categories: [articles]
excerpt: >-
  Cloudflare 发布基于 Qwen3.5-27B 后训练的 Clef 与基于 9B 的 Clef-flash,均 Apache 2.0;新增视觉编码器、64k 上下文、Brier 损失校准;在 BFCL case exact 拿到 98.47%,中位延迟 209.3 ms,定价 $0.24/M 输入 token 是 Jev 的 6 倍。HN 评论把它拆回后训练 + 分类 + logprobs 的组合,并指出 Apache 2.0 标签只覆盖权重,数据与流水线仍属闭源。
tagline: >-
  Jev 公布几周,Cloudflare 自己做出了更好的版本,顺带把定价拉到 Jev 的 6 倍 — 这场决策模型竞赛,没有赢家,只有生态扩张。
---

## 原文概要

这篇文章来自 [HN 热门榜](https://news.ycombinator.com/item?id=49923692)。Cloudflare 在博客上发布 [Clef](https://blog.cloudflare.com/clef-decision-models/),把过去几周围绕决策模型(Jev 那一类"用一次前向传播输出有界结构化结果"的分类器)的热度接了过来:同步开源两个 Cloudflare 自训的模型 `Clef`(基于 `Qwen3.5-27B`)与 `Clef-flash`(基于 `Qwen3.5-9B`),许可证 Apache 2.0,Jev-API 完全兼容,可直接替换。

设计上 Clef 与现有决策模型最大的差异有三:视觉编码器(支持图像分类,Jev 目前只做文本)、64k 上下文(Jev 是 32k)、`label-smoothed cross-entropy` 配 `Brier loss` 的后训练组合用来"细磨概率校准"——博客直接点名回应了 HN 评论区对"它是不是另一个 LLM finetune"的疑问。

基准层面,Cloudflare 跑了 43 项决策类评测,在 BFCL case exact 拿到 **98.47%**、API-Bank accuracy 91.93%、Home appliances case exact 82.95%、BANKING77 macro-F1 94.20%。延迟方面 Clef 中位 209.3 ms、Clef-flash 中位 **38.8 ms**,分别在 p95 上拿到 238.6 ms 与 122.4 ms。Cloudflare 把这与 Laya(中位 524.1 ms)、DiffusionGemma Jev 84.4 ms 并排放在同一张表里。

Cloudflare 自家用例:Threat Intelligence 团队用 Clef 跑域名分类,传一个域名让它同时给"时尚""电商""钓鱼"等多标签打概率,2.2 秒出结果(同等流水线 `gpt-oss-120b` 4.7 秒,且只回两个分类)。

定价:`Clef` $0.24/M 输入 token,Jev 约 6 倍;`Clef-flash` $0.09/M,与 Laya 等小模型直接竞争。Cloudflare 同步推出 RL 微调平台,允许客户用自己的分类数据继续微调 Clef。

## 讨论焦点

### "决策模型不是新范式" — 把它拆回 LLM 后训练 + logprobs

讨论主线从第一条评论就开始拆解:为什么 Jev 发布后几周内就冒出来这么多变种?

> "Can someone explain how so many folks managed to build decision models within days or weeks after Typesafe came out with Jev? Is this concept of decision models been in the works for a while? Is it easy to copy?" — warkdarrior [c:49923943]
>
> (译文:谁能解释一下为什么 Typesafe 的 Jev 发布后,几天到几周就有人做出了决策模型?这玩意儿其实已经酝酿很久了吗?还是说很容易抄?)

一位长期做 LLM 的开发者直接给出现成配方:

> "You just have to fine tune an LLM like Qwen on some synthetic data to do so. There was even someone that had a model that was exactly like Typesafe and published their work a year before Jev (but wasn&#x27;t marketed as heavily since it was academic)." — zitterbewegung [c:49924186]
>
> (译文:只要拿 Qwen 之类的 LLM 用合成数据微调就能做出来。一年前就有人做出来一个跟 Typesafe 那套很像的东西,只是当时是学术发布,没像商业产品那样宣传。)

这条质疑被另一位回复进一步收紧:

> "It&#x27;s not a "new paradigm", it&#x27;s a low-hanging fruit that&#x27;s been lying around for years; Typesafe were the first to bother to stop and pick it up, and market the shit out of it." — TeMPOraL [c:49924635]
>
> (译文:这不是"新范式",是一个存在多年没人愿意弯腰捡的低垂果实;Typesafe 是第一家愿意停下来捡起来、并把它营销到位的。)

读者反复强调的关键点:输出 token 数极少 + 单次前向 = 快,跟"分类"在数学上没新东西。Cloudflare 在博文里直接展示的 `Brier loss` 校准,本质上也是教科书做法。

### "Apache 2.0 不是开源" — 权重、数据、流水线的三段论

第二条主线戳 Cloudflare 的开源声明:

> "Open weights, not open source.<p>The weights have permissive licensing, but the data and training pipeline are not published to reproduce them from their proprietary Qwen starting points. Weights are not "source."" — buildbuildbuild [c:49924502]
>
> (译文:开放权重,不是开源。权重是宽松许可,但数据和训练流水线没有公开,你没办法从他们专有的 Qwen 起点复现模型。权重不是"源码"。)

有人调侃:"希望我没看到这条评论",并把希望寄托在真正做到"模块化开源训练 + 推理 + 开放语料库 + 权重"的后来者:

> "Came directly to comments hoping not to see this one.<p><sad trombone sound><p>Surely someone will soon do what the title of this post makes it seem like cloudfare did.  Truly modular open source training and inference logic, along with a totally open corpus and weights, will eventually out-compete the closed ecosystem." — jMyles [c:49924562]
>
> (译文:专门跑来评论区,就是不想错过这条。唉。迟早会有人做出这个帖子标题里暗示 Cloudflare 做到了的事。真正模块化的开源训练和推理逻辑,加上完全开放的语料库和权重,最终会跑赢封闭生态。)

被举为对照的是 Allen Institute for AI 的 Olmo 与 EleutherAI 的 Pythia——它们把数据、训练代码、权重三件套都公开了。Cloudflare 把模型权重挂 Apache 2.0,但底座 `Qwen3.5-27B` 与后训练流水线没动,这条质疑成立的前提是"开源"含义应该包括复现能力。

### 定价 6 倍 Jev,Cloudflare 是来做慈善的吗?

Cloudflare 这几年持续发布开发者友好的新东西,在 HN 上有一波"好感账户"。但价格对比直接把这波好感打折:

> "Pricing is $0.24/million input tokens which is ~6x compared to Jev. Clef-flash is at $0.09 which is way more competitive." — ssiddharth [c:49924252]
>
> (译文:定价 $0.24/M 输入 token,大约是 Jev 的 6 倍。Clef-flash $0.09/M,这价格才有点竞争力。)

另一条评论立刻补刀——Cloudflare 自家那张 Pareto 边界图根本没把成本轴画进去:

> "Yeah I also thought it was strange their pareto frontier didn&#x27;t include cost." — CBLT [c:49925249]
>
> (译文:我也觉得奇怪,他们画的 Pareto 边界根本没把成本放进去。)

但 Cloudflare 的好感账户仍在加分:

> "Wow, Cloudflare is definitely buying some goodwill from me. Just consistently interesting new releases alongside and solid products at great prices. Seems nearly too good to be true." — johnecheck [c:49924093]
>
> (译文:Cloudflare 确实在我这攒了不少好感。一直发布有意思的新东西,产品价格也合理。简直好得不像真的。)

评论区对这种"好感 + 涨价"组合的解读是:Cloudflare 把 Jev 还没稳定的早期阶段做完,然后用自家规模摊薄,把开发者先吸引过来。

### "用 Jev 的规则打败 Jev" — 几周内 Jev 生态长出的反例

Cloudflare 的 Clef 在 TypeSafe 自家"决策模型指数"上跑赢了 Jev,这件事在评论区被反复引用——而且只用了几周时间:

> "Am I hearing this right, that they made a decision model based on Typesafe&#x27;s new paradigm, and actually made a model <i>better</i> than Jev based on Typesafe&#x27;s own ranking?<p>And it&#x27;s only been a few weeks." — manlymuppet [c:49924445]
>
> (译文:我是不是听错了?他们在 Typesafe 的"新范式"基础上做了个决策模型,然后按 Typesafe 自家的排名,模型比 Jev 还强?而且只用了几个星期。)

关于"几周"这个速度,有人替 TypeSafe 担心了一下:

> "Imagine making your whole company on one model and then being cucked by everyone within a week. I don&#x27;t think I&#x27;ve ever seen anything like it." — MisterMunchkin [c:49924333]
>
> (译文:想象一下把整家公司押在一个模型上,然后一周内被所有人反超。我从没见过这种事。)

但另一些读者反向解读这件事:如果别人一个月内就能复刻你的产品,说明产品里本来就没太多东西:

> "If everyone else can spin up their own version of your product in under a month, there probably wasn&#x27;t much product there." — RGS1811 [c:49924483]
>
> (译文:如果别人一个月内就能复刻你的产品,说明产品里本来就没太多东西。)

这条争论同时指向一个更大的产业现象——决策模型生态在一两个月内集中爆发:Laya、Cygnet、Jeff、At0M、Ollaya,以及现在的 Clef。一位开发者直接列出名单:

> "With all these new Jev-like models popping up, has anyone actually started building anything with them yet? It&#x27;s odd how quickly they&#x27;ve multiplied despite being relatively niche in their use cases, as far as I can tell. I suppose they&#x27;re simple and cheap enough to make that it&#x27;s a sort of &#x27;why not&#x27; thing for a lot of these companies." — ksymph [c:49924597]
>
> (译文:这些 Jev 风格的模型一个个冒出来,有没有人真的在用它们做什么?据我所知它们的用例相当窄,但短时间内冒出来这么多,有点怪。我猜是因为它们又简单又便宜,各家都觉得"反正也不亏"。)

### 架构真相:Qwen3.5 后训练、Brier loss、视觉编码器

Cloudflare 在博文中刻意把"决策模型不是又一个 LLM finetune"的回应写进正文——`label-smoothed cross-entropy` 配 `Brier loss`。评论区立刻有人确认这一点:

> "No mention of calibration. Is it just another llm finetune?" — zwaps [c:49924303]
>
> (译文:文章里完全没提校准。这不就是又一个 LLM finetune 吗?)

> "> Our post-training utilizes label-smoothed cross-entropy for valid schema outputs paired with a Brier loss to refine probability calibration." — kflansburg [c:49924339]
>
> (译文:我们的后训练用 label-smoothed cross-entropy 保证合法 schema 输出,同时配 Brier loss 调概率校准。)

底座模型也被人翻了出来。Cloudflare 没在博文标题里说"基于 Qwen",但有读者从 model card 看出端倪:

> "Clef is based on Qwen3.8-27B and Clef-flash is based on Qwen3.8-9B (edit: actually Qwen3.5-9B). So, similar in spirit to Kev by my understanding, but based on a newer model." — bityard [c:49924307]
>
> (译文:Clef 基于 Qwen3.8-27B,Clef-flash 基于 Qwen3.8-9B(更正:其实是 Qwen3.5-9B)。我的理解是思路跟 Kev 类似,只是基于更新的模型。)

也有更冷静的观察:这种"对概率敏感"的训练,真正难的不是架构,是数据:

> "They are not too difficult to train if you already have infra to train regular LLMs. You can typically replace a few layers train them alone and you&#x27;re off to the races.<p>Getting training data that works well for <i>calibrated</i> classification objectives is difficult." — porridgeraisin [c:49924321]
>
> (译文:只要有训练常规 LLM 的基础设施,这些模型并不难训。一般换几层就能跑起来。但要做好"校准"分类目标,真正难的是训练数据。)

视觉编码器这条新东西被单独拎出来:Cloudflare 自家 Threat Intelligence 团队就在用 Clef 跑网页截图分类,这是 Cloudflare 决定加视觉能力的真实驱动。

### 60M 参数的另一种解法 — At0M 把战线拉到 16 ms

讨论最后一条主线聚焦"决策模型到底能小到什么程度"。有读者贴出一个已经上线的更小变种:

> "We got you. How would you use it though ? Through Apps ? Would love to discuss.<p>At0M: A 60M local Jev at 16 ms latency and 79% accuracy on Typed Decision<p><a href="https:&#x2F;&#x2F;at0m.pienomial.com&#x2F;" rel="nofollow">https:&#x2F;&#x2F;at0m.pienomial.com&#x2F;</a>" — okpatil [c:49925822]
>
> (译文:给你。你打算怎么用?通过 App?欢迎讨论。At0M:60M 参数本地跑的 Jev 风格模型,16 ms 延迟,Typed Decision 任务 79% 准确率。)

按评论区对比,At0M 比 Clef 小 ~400 倍,比 Clef-flash 小 ~150 倍,延迟压到 16 ms,但代价是准确率差一截、闭源。讨论里反复出现的一个判断:这一类决策模型真正的战场,不在 27B 上做 SOTA,而是在 60M 这种"塞进设备"的尺寸上做出能用的版本——Cloudflare 的 Apache 2.0 权重让本地推理变得可能,但 RL 微调平台的目标客户显然是企业,不是设备端开发者。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 决策模型不是新范式 | TeMPOraL [c:49924635] | 多年没人弯腰捡的低垂果实,Typesafe 第一次愿意捡起来 |
| 给出现成配方 | zitterbewegung [c:49924186] | Qwen + 合成数据微调,一年前就有人做出同款 |
| Apache 2.0 ≠ 开源 | buildbuildbuild [c:49924502] | 只开放权重,数据与流水线没公开,无法复现 |
| 期待真开源 | jMyles [c:49924562] | 模块化开源训练 + 全开放语料库 + 权重,迟早跑赢封闭生态 |
| 定价是 Jev 的 6 倍 | ssiddharth [c:49924252] | $0.24/M 输入 token,Clef-flash $0.09 才有点竞争力 |
| Pareto 没画成本轴 | CBLT [c:49925249] | Cloudflare 自家那张图缺了成本维度 |
| Cloudflare 攒好感 | johnecheck [c:49924093] | 持续发布有意思的新东西,价格合理,好得不像真的 |
| 几周内被反超 | manlymuppet [c:49924445] | Cloudflare 在 TypeSafe 自己的排名上超过了 Jev |
| 押注单一模型的尴尬 | MisterMunchkin [c:49924333] | 一家公司押一个模型,一周内被所有人反超,从没见过 |
| 复刻太快说明没壁垒 | 4thplane [c:49924483] | 别人一个月内能复刻,说明产品里本来就没太多东西 |
| 决策模型生态爆发 | ksymph [c:49924597] | Laya、Cygnet、Jeff、At0M、Clef,几周内全冒头 |
| 校准不是架构问题 | porridgeraisin [c:49924321] | 模型不难训,真正难的是"校准"分类目标的数据 |
| 小模型才是主战场 | okpatil [c:49925822] | 60M 参数的 At0M 16 ms 延迟,比 Clef 小 400 倍 |

## 总体情绪

整场讨论带着一种"拆解-承认-重新估价"的节奏。前 1/3 评论把它拆回既有技术:Qwen 后训练 + 合成数据 + logprobs + Brier 校准,本质上不是"新范式",而是一个多年没人弯腰捡的低垂果实。Cloudflare 在博文里写 `label-smoothed cross-entropy` 配 `Brier loss` 那段,正是对这些质疑的提前回应。

中段两股力量对冲——Cloudflare 攒下来的开发者好感,被"Apache 2.0 只覆盖权重、数据与流水线仍闭源"这条质疑和"$0.24/M 是 Jev 6 倍"这条定价对比同时打折。真正的开源玩家 Olmo 和 Pythia 被拉出来当对照,Cloudflare 这条路线被卡在"友好商业 + 半开源"的中间地带。

后段则把目光从 Cloudflare 拉回整个决策模型生态:几周内 Jev、Clef、Laya、Cygnet、Jeff、At0M、Ollaya 一连串冒头,意味着"决策模型"这个类别正在从单一公司的营销词变成一个开源生态。TypeSafe 用几周时间证明这件事不是"科学突破",而 Cloudflare 又用几周时间证明这件事可以被任何有底座模型的大厂抄走。

最后那条 At0M 的 60M / 16 ms 数字把战线拉到完全不同的方向——决策模型真正的胜负不在 27B 上做 SOTA,而是看谁能先把这东西压到设备本地、压到 16 ms、压到消费者手里的 App 里跑。Cloudflare 的 RL 微调平台瞄准的是企业客户,但战场的另一端正悄悄成型。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Introducing Clef: our open-source decision models, and new RL fine-tuning platform | <https://news.ycombinator.com/item?id=49923692> |
| 2 | Cloudflare 博文:Clef — open-source decision models, and new RL fine-tuning platform | <https://blog.cloudflare.com/clef-decision-models/> |
| 3 | Sebastian Raschka: classifier history and Jev(被 HN 评论引用作为先驱脉络) | <https://magazine.sebastianraschka.com/p/classifier-history-and-jev> |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要,仅整理社区观点,不构成投资或技术选型建议。引文均经本地缓存核对,事实校验以 <code>hn-repair.rb</code> 的 Algolia 二次核对为准。
<br><br><em>本摘要由 AI 模型辅助生成:minimax-cn-coding-plan/MiniMax-M3</em>
</div>
