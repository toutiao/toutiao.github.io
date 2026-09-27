---
layout: post
title: >-
  Ollaya：本地跑的「决策模型」，要和 TypeSafe 的 Jev 掰手腕
date: 2026-09-27
hn_id: 49848269
categories: [articles]
excerpt: >-
  8 毫秒出结果、Apache-2.0、本地跑——这套「Jev 风格开源替代」性能跑分只有 Jev 的不到一半。HN 562 分讨论里最多被引用的一句话是「Ollaya 想加这个支持随时都行」。
tagline: >-
  8 毫秒给你答案的小模型，业内跑分第 41。
---
## 原文概要

HN 热门榜（/best）上一则 562 分的帖子，介绍一个名为 Ollaya 的开源项目——它的官方说法是「Ollama for open-source, Jev-style decision models」。Ollaya 在自己的网站上展示了几组关键数字：在 NVIDIA RTX 4090 上，一个五问题的请求端到端约 8–10 毫秒；同期对比里，TypeSafe 的 Jev 托管 API 中位数是 236–276 毫秒。

Ollaya 主要打的不是单一模型，而是一组「开源决策模型」的合集——laya（Convai Innovations 出的 322M/421M）、decider（Mapika 在 Qwen3.5 上的 decoder 决策模型，0.75B/1.9B）、nli（Moritz Laurer 的 zero-shot 分类器）、gliclass（Knowledgator 的指令遵循分类器）、qwen3guard（Qwen 团队出品的安全护栏）、decision（vLLM Semantic Router 出品）、kev（Jared Palmer 出的 LoRA + pointer head）、von（Victor Hugo Panisa 在 ModernBERT-large 上的版本）。它们都通过 Hugging Face 仓库以「pin 到 commit + sha256 校验」的方式加载，运行时是 Apache-2.0。

兼容性是 Ollaya 的卖点之一。它宣称自己实现了 TypeSafe 的 `/v1/systemone` 和 `/v1/models` 接口，「官方 TypeSafe Python SDK 0.7.1 无需修改」就能指向本地。FAQ 里写得很明确：Ollaya 不是 Ollama 团队的项目，也不是 TypeSafe 的项目——它是一个独立项目。HN 讨论里有人调侃「Hey Claude, make ollama for Jev like models. Make no mistakes /s」。

价格模式也很明确——本地跑，没有按 token 计费，模型随硬件能力扩展。文章里给的样例是「decider:2b 在 RTX 4090 上 178 毫秒完成一次决策」。

## 讨论焦点

### 真实质量：差距有多大？

讨论里出现频率最高的话题，是把 Ollaya 自带的 laya 与 TypeSafe 的 Jev 在真实查询上做对比。george_max 直接抛出了他个人的观察：

> "Has anyone actually seen better or the same results with Laya compared to Jev? From my experience, Laya performs significantly worse. It's less confident and often makes wrong decisions with more complex queries." — george_max [c:49848537]

> （译文：有人见过 Laya 在 Jev 面前能给出更好或同等的结果吗？我自己的经验是，Laya 明显弱得多。它置信度更低，在更复杂的查询上经常给出错误决策。）

Ollaya 的维护者 cobanov 直接下场回应了这条质疑：

> "Developer here. You're right, Laya is a lot weaker than Jev, especially on harder queries. It's a small model, so it's fast, but that's the trade-off. The open models that get close to Jev are much bigger, and running those is what I'm working on next." — cobanov [c:49848595]

> （译文：开发者在这里。你说得对，Laya 比 Jev 弱不少，在更难的查询上尤其明显。它是小模型，所以快——这就是取舍。能接近 Jev 的开源模型都大很多，让本地跑起来是我接下来要做的事。）

jasonjmcghee 给出的判断比 george_max 更不留情面：

> "In my experience it's not close and the benchmarks I've seen don't reflect my experience at all. But I'm guessing people will find the right training regime and data mix soon to close the gap. But big things I see are instability and inaccuracy — like pick a random problem." — jasonjmcghee [c:49850415]

> （译文：我的经验是两者根本不在一个层级，我看到的跑分也根本反映不出这种差距。我猜大家很快会找到合适的训练方案和数据组合来填上这个鸿沟。但我看到的主要问题是「不稳定」和「不准确」——随便挑一个问题就能看出来。）

讨论里被引用得最频繁的一组数字来自 jonmagic，他在 jevbench 上长期跟踪排名：

> Rank  System           Score   Public / sealed accuracy   Evidence
> 1     decider-4b v2    64.13   83.5% / 34.7%               Evaluator-run, offline
> 2     Jev 1.13         63.29   86.6% / 36.7%               Evaluator-run API
> 3     JevK5 v0.2       62.04   85.3% / 33.1%               Evaluator-run
> 4     Cygnet 12B       61.76   87.9% / 33.8%               Evaluator-run, offline
> 5     Hopper           59.43   82.3% / 34.1%               Evaluator-run
> 28    Kev 4B           36.14   66.2% / 22.4%               Evaluator-run
> "41    Laya 421M        30.25   58.4% / 30.8%               Evaluator-run" — jonmagic [c:49849014]

> （译文：榜单节选——第一名 decider-4b v2，64.13 分；第二名 Jev 1.13，63.29 分；第三名 JevK5 v0.2，62.04 分；第四名 Cygnet 12B，61.76 分；第五名 Hopper，59.43 分。第二十八 Kev 4B，36.14 分。第四十一 Laya 421M，30.25 分。）

rubymamis 在这条榜单下抛出了一个让所有人都要面对的问题：

> "Did anyone else notice the huge gap between scores on private vs public for ALL Jev-like models compared to LLMs (such as GPT Luna)? Doesn't it mean those models aren't generalizing so not very useful on data they haven't seen?" — rubymamis [c:49856145]

> （译文：有没有人注意到，所有「Jev 风格」的模型在「公开」和「私有」数据上的得分差距都远大于 LLM（比如 GPT Luna）？这不正好说明这些模型不会泛化，对没见过的数据基本没用吗？）

「质量差距」这一段基本定下了整个讨论的温度——Ollaya 团队自己的开发者也在承认 Laya「明显比 Jev 弱」。

### 「决策模型」是否只是营销话术？

讨论里另一支尖锐的分支直指 Ollaya 背后的概念本身——「decision model」「system one model」是不是被过度包装的分类器。hbrn 把它翻译成了平实的同义词：

> "Decision model" is just marketing jargon. decision model = classifier. system one model = small non-reasoning LLM. noul = boolean. confidence = f(probabilities). It's sad to see how gullible engineers are today."" — hbrn [c:49848784]

> （译文：「决策模型」就是营销话术。decision model = classifier；system one model = 不带推理的小 LLM；noul = boolean；confidence = f(probabilities)。今天工程师这么好骗，挺让人难过的。）

alex7o 把这个疑虑推到更具体的对比上：

> "Guys I have a real q, what is the difference between an instruct based re-ranker and laya/jev I just don't see it. Edit: One is that jev/laya are tuned to have better probabilities, but a reranker can be fine tuned to do that as well." — alex7o [c:49849302]

> （译文：各位我有个正经问题——基于指令的 reranker 和 laya/jev 到底差在哪？我看不出来。补一句：差别是 jev/laya 调到了更好的概率分布上，但 reranker 也能微调出同样的效果。）

avereveard 给出了最不情绪化的回答——它的核心是「跨任务的可比概率」：

> "Calibrated probability across multi task with zero shot I guess. A reranker is single task and tuning it make it even more narrow. And I guess some piping to make multiclass efficient since you cannot mask logprob for independent questions in the same output space without throwing calibration away." — avereveard [c:49849538]

> （译文：我猜是 zero-shot、跨任务的可校准概率吧。Reranker 是单任务的，调参反而让它的覆盖更窄。再加一些工程上的串联，好让多分类跑得高效——因为同一输出空间里独立问题的 logprob 不能简单 mask 掉，那样会把校准扔掉。）

janalsncm 把整场争论拉回到一个更冷静的判断：

> "I think Jev wins on marketing and convenience. Most SWEs don't want to talk about embeddings, cosine similarity, or precision/recall tradeoffs. They want something which plausibly works and is easy to use." — janalsncm [c:49850424]

> （译文：Jev 赢在营销和便利性上。大多数 SWE 不想聊 embedding、余弦相似度、precision/recall 那些东西。他们想要一个看上去能用、用起来顺手的工具。）

这条观点相当于把「决策模型是不是营销话术」这个争论换了一个角度——也许它真的是营销，但这种营销恰好对应了一种被开发者的现实痛点。

### 真实生产力：低风险决策确实省钱

讨论里最具体的一支分支，是开发者们用自己的实际使用情况回应「这东西到底有没有用」。mtkd 给出了一段被反复引用的总结：

> "It just works ... a whole bunch of low-level/low-importance workflow stuff that was getting farmed out to small/fast LLM models now has a competitive alternative ... and bits that hadn't even been considered to go into some external decision/classifier service can be tested/deployed at ~$0.00003/req." — mtkd [c:49848958]

> （译文：它就是能用……一大票原本只能外包给小/快 LLM 模型的低层级、低重要性的工作流，现在有了一个有竞争力的替代……甚至一些原本根本没想到要丢给外部决策/分类服务的环节，现在能以大约 $0.00003/请求 的成本测上线。）

shepardrtc 把这种实用性讲得更直接：

> "It really does just work. And it works so well I already integrated it into my product. Saves me about 75% of costs for the section its working in, which isn't a small amount." — shepardrtc [c:49849012]

> （译文：它就是能用。而且效果足够好，我直接把它接进产品了。它负责的那一块省下了大约 75% 的成本，不是小数目。）

taylorfinley 给出了一个最具体的应用场景——他在做一个木工 app，让 Jev 当「自动驾驶」：

> "I'm building a woodworking app and I've managed to create an autopilot that can take a simple instruction (get me 5 2x4s", "cut the middle 2x4 into 4 equal pieces", "move the 2x4 3 feet left") and the action instantly happens with next to no lag. There is already an llm but now it can share an intent, and the geometry system shows jev the various actions and jev chooses the action that gets it closer to the goal."" — taylorfinley [c:49852754]

> （译文：我在做一个木工 app，做出了一个「自动驾驶」——给它一条简单指令（「给我拿 5 根 2x4」「把中间那根 2x4 切成 4 等份」「把那根 2x4 左移 3 英尺」），动作几乎无延迟地发生。LLM 是有的，现在它能跟 LLM 共享意图，几何系统把各种动作展示给 jev，jev 选出最接近目标的那一个。）

——LLM 想「高一层」，便宜的 jev 在毫秒级把所有可行选项试一遍。这条应用示例把「决策模型」抽象的卖点翻译成了一个具体的工作流。

DenisM 给出了一个反向的提醒——这种「好用就有人接」的逻辑早在 Dropbox 时代就有人写过：

> "I think it's the infamous Dropbox reaction — anyone can wrap an FTP server, where the innovation? Starting from a business POV one should inflate terminology, hack together an MVP, and see if the market demands it before doing hardcore R&D." — DenisM [c:49849366]

> （译文：我看这就像经典的 Dropbox 反应——任何人都能给 FTP 服务器套个壳子，哪里来的创新？从生意角度看，包装术语、拼一个 MVP、看看市场要不要，再去做硬核 R&D——这才是正路。）

### 护城河与开源节奏：TypeSafe 接下来要拼什么？

讨论里被拎出来的最大问题，是 TypeSafe 在「开源在 2 周内追上」这件事上接下来要怎么走。pradn 直接抛出了一个没有标准答案的问题：

> "I'm not sure what this means for AI startups if their innovations can be copied by OSS so quickly (what, like 2 weeks?). There's consumer surplus" for everyone, to borrow an economic concept. But we do ideally want some of the surplus to flow to the innovator, too."" — pradn [c:49850052]

> （译文：如果 AI 创业公司的创新能被开源这么快地（大概 2 周？）复制，我不确定这对这些公司意味着什么。借用一个经济学概念——人人都有「消费者剩余」。但我们理想中还是希望一部分剩余能流回创新者。）

_menelaus 给出了他认为 TypeSafe 真正的护城河：

> "The moat is the RL synthetic data pipeline they set up to train jev. Open sourcing that would be the coup, not the model architecture and training scripts, which are trivial." — _menelaus [c:49851594]

> （译文：护城河是他们搭起来训练 jev 的 RL 合成数据管线。把这个开源出来才是大招——模型架构和训练脚本本身不值钱。）

redox99 则从另一个方向追问——如果 jev 的核心真是「trivial」，那为什么这件事要等到今天才被产品化：

> "After chatgpt everything in AI mostly became LLMs and building wrappers around them. It's like people forgot how to do ML. To those of us who actually trained models back in the day, its kind of cute to see people wowed by a classifier. Yes, this is 0 shot and doesn't need training (most people wanting this would've used structured output, this is cool because it's cheaper and faster). But anyone with basic ML knowledge could've built this in a few hours." — redox99 [c:49850617]

> （译文：ChatGPT 之后 AI 这块几乎全变成 LLM 和套壳子了。就像大家忘了怎么做 ML。我们这些当年真的训练过模型的人看到大家被一个分类器惊到，多少有点好笑。它零样本、零训练——大部分想用这类能力的人之前会用结构化输出，新做法更便宜更快而已。但凡有基本 ML 知识的人花几个小时就能搭出来。）

janalsncm 把这条线拉回到「为什么是现在」：

> "BERT models have existed for a while but OpenAI made classification via LLM convenient and accessible for regular developers. People didn't know they wanted classifiers until OpenAI gave them a taste." — janalsncm [c:49852648]

> （译文：BERT 模型早就有了，但 OpenAI 把「通过 LLM 做分类」这件事做得对普通开发者够方便、够可达。在 OpenAI 给大家尝到味道之前，大家根本不知道自己想要分类器。）

这条线把「Ollaya 是不是 trivial」这个问题进一步拆成了「trivial 归 trivial，但产品化和时机本身是有价值的」。

### Ollama 与生态整合

Ollaya 这篇文章的最尖锐的一条评论来自讨论的核心——Ollama 团队还没出手。george_max 把它说得最直白：

> "I am fairly confident if Jev-style decision models are seen as prominent (which, they seem to be), Ollama will support them. Surprised the team hasn't implemented this already." — george_max [c:49848485]

> （译文：如果 Jev 风格的决策模型被视作有分量的方向——现在看起来是——我相当确信 Ollama 会支持它们。让我意外的是 Ollama 团队到现在还没动手。）

emmettbt 用更短的句式下了同样的判断：

> "Cool... but this does seem undermined by the fact that Ollama can add support for decision models at any time." — emmettbt [c:49848421]

> （译文：挺酷的……但这件事多少被一个事实冲淡——Ollama 任何时候都可以加决策模型支持。）

mococa 给出了更具体的想象——LLM 和 System One 跑在同一个工具里：

> "It would be really cool to have LLMs and System One in a single tool — in this case, if Ollama implemented it." — mococa [c:49848923]

> （译文：要是 LLM 和 System One 能跑在同一个工具里，会很棒——如果 Ollama 实现这个就更棒了。）

verdverm 则带来了一个不那么显眼但具体的进展——vLLM 的下一个 release：

> "next vLLM release will have this. if you use gateways, GoModel support the S1 endpoints, my favorite feature is the virtual models, stable name, I can swap out the backing model(s)." — verdverm [c:49850309]

> （译文：vLLM 下个版本会有这个。如果你用网关，GoModel 已经支持 S1 endpoints——我最喜欢的特性是「虚拟模型」：稳定的名字，后端模型可以随时换。）

这条更新把 Ollaya 单独的项目意义，压缩到了「在 Ollama 或 vLLM 正式支持之前的一个过渡方案」上。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 质量差距 | george_max [c:49848537] | Laya 在复杂查询上明显弱于 Jev |
| 开发者自承 | cobanov [c:49848595] | Laya 比 Jev 弱很多，让本地能跑的是下一步 |
| 体验差距 | jasonjmcghee [c:49850415] | 跑分根本反映不出真实差距，「随机挑题就不稳定」 |
| 跑分实证 | jonmagic [c:49849014] | jevbench 上 Laya 421M 排名 41，得分 30.25 |
| 泛化质疑 | rubymamis [c:49856145] | 公开/私有得分差距太大，可能根本没在泛化 |
| 营销话术 | hbrn [c:49848784] | decision model = classifier；工程师太好骗了 |
| 同类质疑 | alex7o [c:49849302] | 跟 instruct reranker 到底差在哪？ |
| 工程优势 | avereveard [c:49849538] | 跨任务零样本可校准概率才是核心 |
| 营销胜利 | janalsncm [c:49850424] | Jev 赢在营销和便利性 |
| 真实省钱 | mtkd [c:49848958] | 一堆低重要性工作流有竞争替代，单请求约 $0.00003 |
| 直接集成 | shepardrtc [c:49849012] | 接进产品，省下 75% 成本 |
| 真实工作流 | taylorfinley [c:49852754] | 木工 app 让 jev 当「自动驾驶」，毫秒级选动作 |
| Dropbox 类比 | DenisM [c:49849366] | 包装术语、拼 MVP、看市场要不要 |
| 开源护城河 | _menelaus [c:49851594] | 真正的护城河是 RL 合成数据管线 |
| 创新者剩余 | pradn [c:49850052] | 开源 2 周追上，创新者的剩余谁拿？ |
| Trivial 论 | redox99 [c:49850617] | 有 ML 基础的人花几小时就能搭出来 |
| 时代产物 | janalsncm [c:49852648] | OpenAI 让大家先尝到分类器的味道 |
| 生态预期 | george_max [c:49848485] | Ollama 一定会支持，只是还没动手 |
| 短评 | emmettbt [c:49848421] | Ollama 随时可以加支持 |
| 进展提示 | verdverm [c:49850309] | vLLM 下个 release 会加这个，GoModel 已经支持 |

## 总体情绪

讨论的整体情绪是一种冷峻的好奇——既没有被 Ollaya 的 8 毫秒震撼到，也没有因为「Laya 排名 41」就把它一棒子打死。HN 上对 Jev 本身的争论（是否是过度包装、是否是 trivial 发明、是否有真正的护城河）在这场讨论里被原样复刻了一遍，只是换到了「开源版本能不能追上」这条具体的工程问题上。

最有信息密度的几条讨论都遵循同一种节奏——开发者在自己的产品里接了 Jev，把成本砍掉 75%，把响应时间从秒级压到毫秒级，再回过头冷静地承认 Ollaya 自带的 Laya 跟 Jev 还有显著差距、且 jevbench 上排名 41。这个组合——一边用、一边打分——让「决策模型到底是不是营销」这种抽象争论在 HN 上有了一个相对落地的版本。

讨论里最值得带走的细节有两处。一是 cobanov 作为开发者亲自下场承认 Laya 比 Jev 弱、「接下来要做的是让本地能跑得起来」。这种坦诚在 HN 上少见——它说明 Ollaya 团队没有把自家项目吹成 Jev 的「同等开源替代」，而是清楚地把它定位成「能让本地跑起来的开始」。二是 taylorfinley 那段木工 app 的描述——LLM 在上层想意图，jev 在毫秒级把可行选项过一遍。这个组合让「决策模型」从一个抽象的工程概念落到了一个具体的协同模式里：便宜的分类器和贵的大模型各自做自己最擅长的事。

这场讨论最大的潜台词，是「TypeSafe 接下来要证明的不是 jev 这个模型本身，而是它能不能持续地把 jev 做成一个别人追不上的产品」。_menelaus 提到的 RL 合成数据管线、pradn 提到的「消费者剩余往哪里流」——这些都不是关于 Ollaya 的问题，而是关于 Jev 母公司在 2 周开源窗口期里要怎么走的更上游的问题。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Ollaya – Ollama for open-source, Jev-style decision models | https://news.ycombinator.com/item?id=49848269 |

## 免责声明

<div class="disclaimer">
本摘要基于 HN 讨论内容整理，仅代表参与讨论用户的观点，不代表本站立场。
<br><br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
