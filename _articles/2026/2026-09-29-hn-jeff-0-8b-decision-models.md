---
layout: post
title: >-
  Jeff — 0.8B 开源决策模型，在家训练、本地 22 毫秒决策 — HN 讨论摘要
date: 2026-09-29
hn_id: 49883844
categories: [articles]
excerpt: >-
  firelex 用一张 RTX PRO 6000 + 两台 DGX Spark，在家用硬件上训出 Jev 兼容的 0.8B / 2B 决策模型：分类基准 83.1% 与 Jev 公开数据持平，单次决策 22-28 ms。HN 评论把它拆成"既有技术的再组装"，但承认 0.8B 级别的"判断-不思考"模型打开了请求路径上的新位置。
tagline: >-
  Jev 的开源小兄弟：分类基准追平，本地 22 毫秒，前线实验室是不是都得抄一份。
---

## 原文概要

这篇文章来自 [HN 首页](https://news.ycombinator.com/item?id=49883844)。开发者 firelex 把 Jev 的"小、快、准"思路搬到了家用硬件上：他在一张 RTX PRO 6000 上训出三个模型 —— `Jeff-Qwen3.5-0.8B`、`Jeff-Qwen3.5-2B`、`Jeff-Gemma4-E2B`，合成训练数据由两台 DGX Spark 上跑的 `Qwen3.8-Flash-Next` 写，测试在 MacBook 上完成。

Jeff 的接口照搬 Jev：传一段"情境 + 候选项"，模型一次 forward pass 就吐出每个选项的校准概率，不生成文本。基准层面，`Jeff-Qwen3.5-2B` 在 5 个公开数据集组成的 panel 上拿到 **83.1%**，比 Jev 公开数据里的 83.0% 高 0.1 个百分点；`Jeff-Qwen3.5-0.8B` 拿到 79.1%。延迟上，0.8B 在 RTX PRO 6000 上 **22 ms/决策**，M4 Max 上 **28 ms/决策**。

firelex 特意把"系统 1 / 系统 2"边界画清楚：Jeff 在分类和 grounding 类任务（Financial PhraseBank 96.4%、RAGTruth 86-89%）上打平甚至超过 Jev，但在 BBH、JudgeBench、JevBench-hard 这类多步推理上差距明显（BBH 64-68% vs Jev 94.3%）。在 Doom / Frogger / Pac-Man 三个零样本游戏测试里，0.8B 跑出 6.55 kills、10.3 crossings、57/98 pellets —— 与一个手写规则机器人同分，2B 因为"风险厌恶"反而表现更差。

训练侧的关键参数：0.8B 训约 2 小时，2B 训约 3.5 小时，权重 Apache 2.0，代码 MIT，灵感来自 Denis Yarats 的 `AutoJev` 配方。firelex 强调独立于 TypeSafe，调用格式只是兼容。

## 讨论焦点

### "Jev 不就是个分类器" — 把 Jeff 拆成既有技术的再组装

讨论主线之一是把它拆回普通 LLM 工程：能稳定吐 JSON 的方式早就有了，Jeff 的速度优势来源于一次前向传播 + 极少的输出 token。

> "Do people really have zero awareness that Structured Outputs with a constrained schema has been a thing for a while now, and open weight models that give you logprobs can give you distributions per key? ... I can triage 10,000 support tickets with deepseek flash for less than \$1, and latency is sub 1 second if it needs to be integrated into a live user flow. I don't need anything cheaper or faster than that." — jubilanti [c:49886699]
>
> （译文：难道没人意识到带约束 schema 的 Structured Outputs 早就有了吗，开源权重模型给的 logprobs 就能给每个 key 出一个分布？我现在用 deepseek flash 处理一万张工单不到一美元，要塞进在线用户流程延迟也压在一秒内。我不需要比这更便宜或更快。）

> "Negative three years, give or take. ... For any open model you just tell it to respond with a single token \"Y/N\" and take the logit difference. ... OpenAI and Anthropic don't want to give out logprobs these days but could trivially add a dedicated classification API to their existing models if there was enough demand." — wgd [c:49886348]
>
> （译文：负三年，差不多。任意开源模型你只要让它输出单个 Y/N token，再去取 logit 差就行。OpenAI 和 Anthropic 现在不愿意给 logprobs，但只要有需求，给现有模型加个分类 API 是举手之劳。）

> "BeRT and FLAN-T5 were used as classifiers 5-7 years ago, they were technically \"frontier\" for their time." — bigyabai [c:49885116]
>
> （译文：BERT 和 FLAN-T5 五到七年前就当分类器用了，按当时的尺度它们就是"前沿"。）

几位读者把差异归到"输出 token 数"。`Jeff-Qwen3.5-0.8B` 一次出 **255 个浮点**，只取前 N 个对应候选项，其余在 UI 里藏起来 —— 这跟 LLM 解码到第一个合法 token 就停下的做法差不太多。

### "零样本"不是"零工程" — 通用与垂直的拉锯

第二层张力在 zero-shot vs fine-tune 的边界。一线开发者给 Jeff 泼了冷水：

> "I compared it to Jev in my current use cases and it's very inaccurate. 70% vs 94% . for classification, it's unacceptable." — AgentMasterRace [c:49884862]
>
> （译文：拿我的实际场景比，Jeff 的准确率只有 70%，Jev 是 94%。分类任务上 70% 不能用。）

> "For _your_ classification it's unacceptable. The OP seems to have anticipated this and mentions you can fine tune it for your use case. ... I don't think the point is to displace Jev, but to show it's possible to build an MVP on open weights without years of work and millions of dollars." — tbeseda [c:49885107]
>
> （译文：你的分类场景不能用。OP 显然想到了这点，README 里就写了可以微调。我觉得重点不是替代 Jev，而是证明开源权重 + 家用硬件也能搭出 MVP，不必花几年时间和几百万美元。）

更尖锐的是读者把"小模型 + 微调"这件事降维：

> "You can already so that with classification models such as ModernBERT, at 0.4B. Jev's value is its zero shot performance without having to fine-tune." — senko [c:49885588]
>
> （译文：拿 ModernBERT 0.4B 就能这么干。Jev 的价值在于免微调的零样本表现。）

但反驳者很快给出了现代 BERT 微调的真实工程成本：

> "There is a fixed cost (and some maintenance) to e.g. fine tuning ModernBERT. Maybe once you include all of that it might be a half-day to a day of engineering time to set everything up in a maintainable fashion. For Jev, it takes all of 30 seconds of prompting." — jmalicki [c:49886825]
>
> （译文：微调 ModernBERT 有一次性成本和后续维护，全部算上可能要花半天到一天搭一套可持续的服务。Jev 那边，写 prompt 30 秒就行。）

企业用户的经验验证了"零样本试错，再决定要不要自建"的实际路径：

> "For my org, it meant we could trial classifiers across various internal systems with little to no engineering effort. In one case we ended up building our own classifier instead of Jev, but in others we kept Jev because it was zero-effort for a great impact." — shaewest [c:49886443]
>
> （译文：对我们公司来说，这意味着可以用几乎零工程量去各个内部系统试分类器。有些场景我们最后自建了分类器，但另一些场景 Jev 留着，因为零成本却效果显著。）

### 架构揭秘：encoder-only、255 个浮点、单次前向

面对 TypeSafe 不公开 Jev 的细节这件事，读者做了一轮集体逆向工程：

> "Typesafe has been quite about the underlying technology behind Jev. Given the speed and cost my hypothesis is that it doesn't input tokens the way that LLMs do, ie iterating over every word and drawing the connections between each. That is an o(n^2) problem which is why LLMs are so expensive as they scale." — velominati [c:49885224]
>
> （译文：TypeSafe 对 Jev 的底层技术一直守口如瓶。从速度和成本倒推，我的假设是它不像 LLM 那样逐词迭代画连接 —— 那个 O(n²) 是 LLM 贵的根本原因。）

> "Most likely: it does still have attention layers (the O(n^2) part), but it's not autoregressive (which makes it O(n^3) because you have to run the whole model again for each predicted token)" — odo1242 [c:49885288]
>
> （译文：最可能的方案：仍然有 attention 层（O(n²) 那块），但不是自回归（自回归是 O(n³)，因为每个 token 都要把整模型跑一遍）。）

> "Then again, it's only a very small number and fixed set of tokens for the output." — k__ [c:49885486]
>
> （译文：再说了，输出 token 数很少，而且集合固定。）

最具体的拆解来自 Jeff 的另一位参与者 make3，他解释了模型到底"输出什么"：

> "Jev is basically a kind of FLAN-BERT ... It only generates 255 floats all at once, making it much faster, and what those floats mean (if anything) depends on the prompt. Eg, the following query is put in the encoder model: {\"question\": \"Rank these 5 things by increasing order of how big they are\", \"choices\": [\"truck\", \"cow\", \"mouse\", \"ant\", \"building\"]} The model returns [3., 2., 1., 0., 4.], and 249 other meaningless floats that are hidden from you by the UI." — make3 [c:49885623]
>
> （译文：Jev 本质上算一种 FLAN-BERT。它一次吐出 255 个浮点，速度因此极快，这些浮点的含义（如果有的话）由 prompt 决定。比如 query 写"按从小到大排列这五个东西"，传 choices 是卡车、牛、老鼠、蚂蚁、楼；模型吐 [3., 2., 1., 0., 4.]，剩下的 249 个浮点被 UI 藏起来了。）

### Jev 的真正用途：放进请求路径里做 routing

讨论里最有共识的部分反而是 Jev 的定位 —— 它不是用来替代 LLM 思考的，而是把 LLM 解放出来。

> "I think these products (Jev and the inevitable offerings from Anthropic, OpenAI, etc) want to become more than end-user output machines. They'd benefit from being in the hotpath of other services. Not backgrounded generation but in-band, request-time work. 1M x \$0.50 == 1B x \$0.0005" — tbeseda [c:49885698]
>
> （译文：我觉得这类产品（Jev 以及 Anthropic、OpenAI 早晚要出的同类）想做的不是替代面向终端的输出机器，而是成为其他服务的请求路径上的一环。不是后台批处理，是请求时的带内工作。一百万次乘以 0.5 美元等于十亿次乘以 0.0005 美元。）

> "Everyone saying you could replace Jev or decision type models with an LLM with bolted schema output constraining are missing the point completely. Its about extreme speed and cost effectiveness with high quality, neither of which you are going to get with LLMs even with these KV-cache tricks" — imranq [c:49887387]
>
> （译文：说"加个 schema 约束就能用 LLM 替代 Jev"的人完全没抓到重点。重点是极快速度 + 极低成本 + 高质量这三者同时达成，哪怕用了 KV-cache tricks 的 LLM 也做不到。）

> "My understanding of Jev is that it's a replacement for the LLM you'd necessarily need to use to identify reasoning-sensitive workloads in a heterogeneous mix, where Jev will be cheaper than an actual LLM and so act as an actual optimization / de-bottlenecking change." — derefr [c:49886106]
>
> （译文：我理解的 Jev 是一个替代品：在一堆异构任务里识别哪些需要推理，本来要用一个 LLM 去做这件事，现在用 Jev 更便宜，所以它起到了真正的优化和解瓶颈作用。）

firelex 自己在 README 和评论里也强调同一点：分类器不是规划器，prompt 里把每个选项的后果讲清楚就行，不要让模型去预测未来。

### 谁会先抄？前线实验室的尴尬

一个有趣的子线：Jev 的成功让 Anthropic、OpenAI 处于一个奇怪的产品定位尴尬。

> "If I had to guess, it's already built and is just waiting on Product's/Marketing's desk. How do you position this without looking like your roadmap is being determined by newcomers? Probably don't want to adopt the same verbiage+acronyms - but also can't be seen to be just sherlocking features." — tbeseda [c:49885143]
>
> （译文：让我猜，这东西其实早就做完了，就卡在产品和市场的桌上。你怎么定位它才不至于看起来像被新人牵着鼻子走？大概不会用同样的术语和缩写，但也不能看起来只是跟在后面抄功能。）

> "I think Apple has demonstrated that shipping second has essentially no negative impact if your product is seen as higher quality." — seizethecheese [c:49885232]
>
> （译文：苹果已经证明，如果你产品质量更高，晚一步发几乎没有负面影响。）

> "If I had to guess, Cursor/Grok or Google/Antigravity will be the first major players to natively support something like this to drive down cost, as they're primarily the budget conscious choices. I would be astounded if Anthropic leads the way on a cost reduction." — onlyrealcuzzo [c:49885651]
>
> （译文：让我猜，Cursor、Grok 或者 Google/Antigravity 会是第一批原生支持这类能力的大厂，因为他们本来就是成本敏感的选择。如果 Anthropic 第一个站出来降本，我反而会惊讶。）

当然，这整套讨论里始终有一根警惕的弦：

> "I've always been more afraid of these types of models than LLMs. These are what enable mass surveillance at scale and autonomous real time combat drones. Now they are spreading and being optimized. Gg." — zeroCalories [c:49886175]
>
> （译文：我对这些模型的恐惧一直比对 LLM 更深。它们才是大规模监控和实时自主战斗无人机的基础设施。现在它们被复制、被优化。Gg。）

### 串场笑点：AskJeeves 还活着

与主题无关但意外抢戏的支线，是有人注意到 Jev 和 AskJeeves 的拼写相似。AskJeeves 的域名 askjev.com 居然还能访问。

> "For those of a certain age - the fact that Askjev.com is still available astounds me." — phlipski [c:49886868]
>
> （译文：对有一定年龄的人来说 —— askjev.com 这个域名居然还没被注册，让我震惊。）

> "Blows my mind that Jeeves never came back as an AI model. Even if it's poor quality, it'd still be better than Google." — NetOpWibby [c:49887935]
>
> （译文：Jeeves 从来没有以 AI 模型形态复活过，这让我震惊。就算质量差，也比 Google 强。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| Jeff 不神秘，就是 LLM 技巧 | jubilanti [c:49886699] | Structured Outputs + logprobs 早就能做，差别只在速度成本 |
| 架构 = encoder + 受训 readout | make3 [c:49885623] | 255 个浮点一次吐出，UI 只用前 N 个 |
| 零样本省下的是工程时间 | jmalicki [c:49886825] | ModernBERT 微调要搭半天到一天，Jev 写 prompt 30 秒 |
| 实战里零样本不够 | AgentMasterRace [c:49884862] | 70% vs 94%，分类场景不能接受 |
| Jev 的真正位置是请求路径 | tbeseda [c:49885698] | 1M × \$0.5 = 1B × \$0.0005，把 LLM 从 routing 解放出来 |
| 慢一步发也可以 | onlyrealcuzzo [c:49885651] | Cursor / Grok / Google 这种成本敏感玩家会先动手 |
| 真正的风险在监控侧 | zeroCalories [c:49886175] | 这种模型才让大规模监控和自主武器可行 |

## 总体情绪

整场讨论带着一种"拆解-承认-重新估价"的节奏。前 1/3 评论把它拆成已有技术的组合：logprobs、constrained decoding、BERT 微调，结论都是"没那么神秘"。中段在 zero-shot 和 fine-tune 之间反复拉锯，企业用户给出了一致的答案 —— 先用零样本试水，不行再自建，这是过去一年里小模型路线最成熟的落地方式。

真正的新共识在请求路径的定位上：Jev/Jeff 这一类模型的价值不在"它比 LLM 更会分类"，而在"它把 LLM 从必须分类的位置上挪开"。firelex 把这条线写得最清楚 —— 分类器不是规划器，把每个选项的后果讲清楚、不要让模型预测未来。

这种判断的另一面是焦虑：把决策速度拉到 22 ms、成本压到本地电费水平，意味着实时路由、自动调度、个性化干预这些以前卡在 LLM 延迟上的场景突然打开。如果 0.8B 都能跑 60 FPS 的 Pac-Man，那 0.8B 也能跑很多别的东西。

最后那条 AskJeeves 域名还活着的支线，像是在提醒所有人：AI 这一波新词和 1996 年的旧词之间的距离，可能比想象中更短。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Jeff – Jev-compatible 0.8B decision models, trained at home, ~30 ms | <https://news.ycombinator.com/item?id=49883844> |
| 2 | 项目仓库（firelex/jeff） | <https://github.com/firelex/jeff> |
| 3 | AutoJev 原版配方（Denis Yarats） | <https://github.com/denis-pplx/autojev> |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，仅整理社区观点，不构成投资或技术选型建议。引文均经本地缓存核对，事实校验以 <code>hn-repair.rb</code> 的 Algolia 二次核对为准。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
