---
layout: post
title: >-
  一年前我做的非自回归决策模型 — 现在 TypeSafe AI 把它叫“突破”
date: 2026-09-20
hn_id: 49765348
categories: [articles]
excerpt: >-
  ConvAI Innovations 的 CEO 自述：他 2025 年 3 月就在 arXiv 上发了基于 RL 的非自回归决策模型，一年后 TypeSafe AI 的 Jev 把它包装成闭源的“突破”。
tagline: >-
  一年的开源论文 vs 一夜的 VC 闭源营销 — 谁在赢得开发者的注意力？
---

## 原文概要

ConvAI Innovations 创始人兼 CEO Nandakishor Mukkunnoth 在公司博客上发文，详细叙述了一段让他"既欣慰又沮丧"的时间线：他在 2025 年 3 月以 arXiv:2503.23303 发表论文，提出基于序列表示 + PPO 的非自回归决策模型，在垂直销售对话里输出每轮转化概率；接着在 2025 年 9 月跟进 arXiv:2510.01237，把框架正式化为"基于强化学习的 schema 化决策"，并把模型权重（`sales-conversion-model-reinf-learning`）、开放数据集（`saas-sales-conversations`）、PyPI 包（`hallunox`）以及 Reddit 讨论全部公开。

一年后，2026 年 9 月，由 OpenAI ChatGPT 共同发明人 Diogo Almeida 创办的 TypeSafe AI 推出 Jev，宣称"非自回归决策模型"是一项新科学突破，定价 $0.042/M input tokens、典型响应时间约 150ms——但没有技术论文、没有开放权重、没有开放训练数据集。

作者用一年积累的研究结果重写了一遍，做成 Laya：在单 GPU 上 32.8ms（批处理 7.2ms/问），比 Jev 快 6 到 8 倍，Apache 2.0 全开源，权重挂在 `convaiinnovations/laya` hub 下。Laya 围绕三个原语（`choice`、`score`、`noul`）输出校准概率，没有文本生成路径，结构化 schema 违规在物理上不可能。

文章最具攻击性的一组数据来自 51 语言 MASSIVE 基准：ModernBERT-large 在高棉语上 0.000 准确率但报 0.952 confidence，亚美尼亚语 0.050 准确率报 0.885 confidence——也就是说，"模型的自信度"在它看不懂的语言上根本不可信，必须在 forward pass 之前就决定路由到哪个模型。

HN 帖子冲上 701 分，原始评论 153 条。讨论迅速分裂成两条主线：这条工作到底算不算 Jev 的"先驱"，以及 BERT 时代的分类器为什么这几年被 LLM 边缘化了。

## 讨论焦点

### Laya 是不是 Jev 的真正前身

> "Jev was built using the same architecture Laya’s author proposed[1] in March 2025. Laya is an open-source system based on that research from a year ago. Whether Jev is also based on the OP’s materials or independently invented is hard to say." — klibertp [c:49765878]

> （译文）Jev 是用 Laya 作者 2025 年 3 月提出的同一架构搭出来的（原文带 [1] 引用）。Laya 是基于那个一年前研究的开源实现。Jev 是沿用了作者的材料还是独立发明，现在还不好说。

这条评论是早期被引用最多的"中立立场"，但同样被反对：

> "the paper does not describe a model architecture, it describes a system built on embeddings, rag, and orchestratorsthey don’t seem very similar to me" — verdverm [c:49767820]

> （译文）这篇论文描述的不是模型架构，而是基于 embedding、RAG 和编排器的系统。在我看来这两者不太像。

分歧落点在"架构"这个词的定义——是指神经网络拓扑（verdverm 说不一样），还是包括决策范式和输出空间（作者认为一样）。这条争论最终没有结论，但侧面说明 Laya 想在"先驱者"位置上站住并不容易。

更尖锐的反对来自同一条线程：

> "Excuse me, but calibrating language models to accurately reflect probabilities did not start with you." — prodigycorp [c:49766982]

> （译文）等等，校准语言模型来准确反映概率这件事，不是从你开始的。

作者本人在后续回复里承认没有声称首创，但这条评论点出了一个更深层的问题：在 ML 圈，"非自回归 + RL 校准"这个组合并不是 2025 年才出现。kamranjon 引用了 GLiNER 系列工作：

> "It is really interesting to see this claim, because i thought the current theory was that typesafe actually repackaged the work from GLiNER[1] - which does seem to be a closer match, and their original paper[2] predates yours by several years. Curious if you had heard of it before? It is also open source[3] and I think also has some good usage." — kamranjon [c:49766495]

> （译文）这个说法挺有意思，因为现在业界其实普遍认为 TypeSafe 不过是把 GLiNER（[1]）的东西换了个包装——GLiNER 的匹配度更高，原论文（[2]）比你的早了好几年。你之前听说过它吗？GLiNER 也是开源的（[3]），我觉得口碑也不错。

把 GLiNER 拉进来之后，"先驱"叙事的合法性变得更弱了：作者的工作和 TypeSafe 的工作可能都站在 GLiNER 这类更早的 BERT 时代分类器肩膀上。

### "BERT 加上更多数据" —— Jev 的真正评价

HN 上对 Jev 最常见的技术评价不是"突破"，而是"该回到基本功"：

> "I played around with Jev last night and did it for classification tasks that I used Gemini 2.5 flash lite with." — Oras [c:49765997]

> （译文）昨晚拿 Jev 跑了一些之前用 Gemini 2.5 Flash Lite 做的分类任务。

> "It’s a bit faster and bit cheaper, but this is compared to LLM. The consistency was nice to see, BUT, as someone who trained NLP models prior to LLMs, it’s just BERT with more data. I can see why people would want ready made one shot classifier, and I can see the value of sending multiple classifier in one call, but I wouldn’t call it breakthrough." — Oras [c:49765997]

> （译文）快一点，便宜一点——但那是跟 LLM 比。一致性确实好，可我这种 LLM 之前就训练 NLP 模型的人看，Jev 就是"加了更多数据的 BERT"。可以理解大家为什么想要现成的一发命中分类器，也可以理解为什么想把多个分类器放到一次调用里，但我不会叫它突破。

> "I see it as a wake up call for the tech community to go back to basics for most tasks instead of relying solely on generic LLMs." — Oras [c:49765997]

> （译文）我觉得这给技术圈提了个醒——多数任务应该回到基本功，而不是只靠通用 LLM。

Oras 自己也用了 Jev，但明确说"有用"不等于"突破"。这个区分贯穿整场讨论：很多用户实际上把 Jev 当成便宜的替代品用，但不愿意给它贴"科学突破"的标签。

回应这条的 kilroy123 把观点压成一句：

> "I always say the cheapest LLM request is no request at all." — kilroy123 [c:49766131]

> （译文）我一直说，最便宜的 LLM 请求是不发请求。

### LLM 与专用模型的边界之争

这场讨论最激烈的支线不是关于 Jev 或 Laya，而是关于"LLM 是不是对所有任务都过度配置"这个长期争论：

> "Anyone who has worked in ML for 10+ years would already know that the usage of LLMs for everything is lazy, wasteful and a high degree of marketing on it." — tchalla [c:49766268]

> （译文）干 ML 十年以上的人都知道，所有任务都拿 LLM 顶上，是偷懒、浪费，而且营销味极重。

立刻被回怼：

> "why would you waste your time messing around with a team of expensive ml engineers and data scientists that produce vastly inferior to a llm." — dominotw [c:49766353]

> （译文）为什么要浪费时间搞一支昂贵的 ML 工程师和数据科学家团队，产出比 LLM 差几个档的东西？

> "We ripped out custom homegrown ml models that were developed in last 10 yrs and put an llm in its place. Its the opposite of wasteful. Even local gemma models are vastly superior." — dominotw [c:49766353]

> （译文）我们刚把过去十年做的定制模型全拆了，换上 LLM。这不是浪费，是反过来的浪费。连本地 Gemma 都比它们强得多。

tchalla 给出的折中方案在另一条评论里被同意：

> "There’s a middle option. Once you figure that out, you’d soon understand my point today or tomorrow." — tchalla [c:49766542]

> （译文）有个折中方案。等你搞明白这点，你迟早会理解我的意思。

> "I’ve been in this field for 21 years and I use LLMs everyday. I also know when to not use them." — tchalla [c:49766542]

> （译文）我干了 21 年这行，每天都用 LLM——但我也知道什么时候不该用。

讨论延伸到工程经济学的另一面：

> "I would rate using LLM for tasks more specific ML can handle as a lot like using one’s smartphone to snap photos, listen to music, set alarms, and play video games in preference to carrying around a fun cam, ipod, watch, and switch 2 everywhere." — HappMacDonald [c:49766634]

> （译文）拿 LLM 去干专用 ML 能做的任务，感觉就像一个人宁愿用手机拍照、听歌、定闹钟、玩游戏，也不愿意随身带一台相机、iPod、手表和 Switch。专业玩家会带着 DSLR 回家打游戏机，但"能覆盖 90% 需求"这个产品逻辑对绝大多数人已经够用了。

而这条观点又引来了更深一层的反驳：

> "BERT was highly usable for classification and sentiment analysis a whopping 9 years ago, despite being less than 0.5B parameters large. Similar-scale models like FLAN-T5 showed that it could be improved without substantially scaling up." — bigyabai [c:49768373]

> （译文）BERT 在 9 年前就已经能很好地做分类和情感分析了，参数还不到 0.5B。FLAN-T5 这类同等规模的模型证明，不用大幅放大也能进一步提升。

> "Today, we’re extremely spoiled by trillion parameter-scale models. Our conceptualization of vibe coding relies on wasteful tool-calling paradigms, the one-size-fits-all mentality of LLMs is part of the marketing blitz to make people buy more tokens. It’s lazy on the part of frontier labs, but also wastes electricity, time and money." — bigyabai [c:49768373]

> （译文）今天我们被万亿参数的模型宠坏了。"vibe coding" 这个概念靠的是浪费的工具调用范式，"一刀切所有任务"是 LLM 营销战的一部分，逼大家多买 token。是前沿实验室的偷懒，也在浪费电、时间和钱。

讨论到这里已经跟 Laya 没什么关系了——HN 用一个独立开源项目的帖子，把整个"专用模型 vs 通用 LLM"的争论推回桌面。

### 真正的成本故事：Jev/Laya 在生产里值多少钱

少数几条评论给出了具体生产数据，是讨论里最有信息量的一段：

> "I’ve been deeply impressed with Jev as it made a bunch of workloads we had on Luna or Gemini 10x cheaper and 2x faster (previously used non reasoning version for latency reasons)." — zurfer [c:49765916]

> （译文）Jev 给我留下深刻印象——我们之前用 Luna 或 Gemini 的工作流，被它便宜了 10 倍、速度快了 2 倍（之前为了延迟不用推理版本）。

> "I have 10000+ inventory items to categorize but I need an intelligent model (not just if statements). Using LLMs has been slow and expensive and I needed to queue it to run for hours. Jev did it in minutes and for less than 1 cent" — sharms [c:49767449]

> （译文）我有一万多个库存条目要分类，需要一个聪明的模型（不能是 if 条件）。用 LLM 又慢又贵，我得排队跑几个小时。Jev 几分钟搞定，1 cent 都不到。

而另一条评论给出了 Jev 相对 LLM 的具体价格差：

> "Gemini 2.5 Flash Lite is $500/Gt, Jev is $42/Gt. AKA an order of magnitude cheaper." — fastball [c:49768837]

> （译文）Gemini 2.5 Flash Lite 是 $500/Gt，Jev 是 $42/Gt，整整便宜一个数量级。

这几条评论合起来构成了讨论里最不情绪化的声音：Jev/Laya 类模型在固定分类任务上的工程价值是真实的，1 美分处理 1 万条数据的优势不能被"是否突破"这种叙事判断抹掉。

### 营销叙事 vs 真实研究 —— 谁赢得了注意力

HN 上对 Laya 的另一组反对意见指向了讨论本身：

> "Landing page full of AI fluff, discussion feels very fake here, I would assume this is some upvote bot, nothing makes sense." — throwaway63467 [c:49766823]

> （译文）落地页全是 AI 套话，讨论里感觉是假的，我猜是有人在刷票，什么都说不过去。

> "It’s an embarrassing showing for our community, seems like nobody has read anything. None of the claims of the blog post add up." — prodigycorp [c:49766849]

> （译文）这对我们社区来说是难堪的表现，似乎没人读过原文。帖子里的声明都说不过去。

但讨论里更主流的声音是——"营销 vs 研究"是一场规则根本不同的游戏：

> "We’ve all seen "this meeting could have been an email"; now get ready for "this VC-backed firm could have been a single arXiv preprint."" — wren6991 [c:49766844]

> （译文）我们都说"这会议本来一封邮件就能解决"；现在要习惯"这家 VC 资助的公司本来一篇 arXiv 预印本就能搞定"。

> "I don’t want to be too dismissive of Jev, but building technology in stealth for two years just doesn’t make sense to me when the capabilities are so easily replicated." — wren6991 [c:49766844]

> （译文）我不想对 Jev 太苛刻，但既然这些技术这么容易复现，闭门造车两年就没道理了。

> "And yet no one cared about this research until it was productized and communicated well. Multitouch existed before the iPhone." — bensyverson [c:49767143]

> （译文）可是直到 Jev 把这套研究产品化并讲明白之前，根本没人关心这工作。多点触控在 iPhone 之前就有过了。

> "The post is conflating hype and money with technical innovation, they are not really correlated. Kurzweil is known for saying most innovations succeed based not on technology but on timing. Today, who talks about it might matter even more than timing." — avaer [c:49766847]

> （译文）这篇帖把"营销热度"和"技术创新"混在一起了，它们其实没相关性。Kurzweil 说过多数创新靠的不是技术而是时机。今天，"谁在讲"可能比时机更重要。

avaer 的这段话最后延伸出了一个非常实际的建议：

> "If you want to make money/hype/whatever off of your work, do that. But realize that it’s a path that’s often orthogonal to research." — avaer [c:49766847]

> （译文）如果你想靠自己的工作赚钱/制造热度，去做吧。但要意识到，这条路跟做研究往往正交。

这跟 dcow 给出的"现实派"判断指向同一个方向：

> "I can understand why the author feels bitter but it still feels juvenile to me. Certainly both Jev and Laya are based on the research of countless prior papers and academics. Diogo decided to build a product out of the concept. The author didn’t." — dcow [c:49766861]

> （译文）我能理解作者为什么觉得委屈，但我觉得这态度还是幼稚。Jev 和 Laya 当然都站在无数前人论文的肩膀上。Diogo 决定把这个概念做成产品，作者没做。

"做产品 vs 发论文"被这些评论精确地点名为两类不同的工作，不是同一场比赛。

### 真·"沟通即创新"

讨论里最冷静也最善意的一条总结把整个故事重新读了一遍：

> "I think the biggest lesson with Jev was the one of communication and understanding for the broader audience, sometimes a lot about innovating involves repeating yourself and translating your own thoughts to an intended audience." — hmokiguess [c:49766581]

> （译文）我觉得 Jev 最大的启发其实是"沟通和让大众理解"——很多时候创新的一部分就是反复把你的想法翻译给目标听众听。

> "Classical machine learning has been, for the most part, and just by the nature of science, behind academic terms and difficult to engage with as a product." — hmokiguess [c:49766581]

> （译文）经典机器学习因为学科本身的性质，长期藏在学术术语后面，难以作为产品被使用。

> "Jev did really well with coining up "System One" models and defining a standard application interface plus core primitives that landed in the current paradigm of software development." — hmokiguess [c:49766581]

> （译文）Jev 真正厉害的，是发明了 “System One 模型” 这个说法，定了一套标准 API 和核心原语，正好落在当下软件开发的心智模型里。

> "I think it’s sort of like how Cursor reinvented autocomplete back then as a different UX and suddenly everyone was just using it because of how easy the bar was to understanding it." — hmokiguess [c:49766581]

> （译文）这有点像 Cursor 当年把自动补全重新包装成一个不同的 UX，理解门槛一下降低，所有人都开始用了。

这条评论跟作者开篇"既欣慰又沮丧"的视角形成了对照——hmokiguess 没有否认作者一年前的工作，但他把"沟通即创新"作为这条新闻真正的价值判断标准。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Jev 沿用了 Laya 作者的架构 | klibertp [c:49765878] | "Jev was built using the same architecture Laya's author proposed in March 2025." |
| Laya 论文描述的不是模型架构 | verdverm [c:49767820] | "the paper does not describe a model architecture." |
| GLiNER 才是真正的先驱 | kamranjon [c:49766495] | "GLiNER's original paper predates yours by several years." |
| Jev 不是突破，是 BERT 加数据 | Oras [c:49765997] | "it's just BERT with more data... I wouldn't call it breakthrough." |
| 给 ML 圈提了个醒 | Oras [c:49765997] | "wake up call to go back to basics." |
| 10x 便宜 + 2x 快 | zurfer [c:49765916] | "10x cheaper and 2x faster." |
| 万条数据 Jev 一美分搞定 | sharms [c:49767449] | "Jev did it in minutes and for less than 1 cent." |
| 通用 LLM 是浪费 | tchalla [c:49766268] | "LLMs for everything is lazy, wasteful." |
| 通用 LLM 是反浪费 | dominotw [c:49766353] | "We ripped out custom homegrown ml models and put an llm in its place." |
| 一篇 arXiv 就能替代 VC 公司 | wren6991 [c:49766844] | "this VC-backed firm could have been a single arXiv preprint." |
| 产品化才是创新 | bensyverson [c:49767143] | "no one cared about this research until it was productized." |
| 营销 vs 研究是两场比赛 | avaer [c:49766847] | "hype and money... are not really correlated with technical innovation." |
| 沟通即创新 | hmokiguess [c:49766581] | "Jev did really well with coining up 'System One' models." |
| 讨论可能不实 | throwaway63467 [c:49766823] | "Landing page full of AI fluff, discussion feels very fake." |

## 总体情绪

讨论情绪很分裂，但分裂的方式很特别：质疑 Laya 的技术主张和质疑 TypeSafe 的营销主张的力量几乎相等。两条质疑线来自完全不同的方向——一边是技术圈里"这不就是 BERT 吗"的冷眼，另一边是社区里"这落地的看起来像 AI 套话"的怀疑。

更微妙的是中间立场：很多用户其实承认 Jev/Laya 类模型在固定分类任务上的工程价值（10x 便宜、几美分处理一万条数据），但同时拒绝给"突破"这个词背书。这是一种新的现实主义——用户对"功能有用"和"科学突破"开始划出明确的界限，不再因为前者而接受后者。

最有信号量的一条评论来自 hmokiguess——他把整个故事的真正主角定位为"System One"这个概念包装，而不是任何具体的模型架构或论文。这意味着，作者和 TypeSafe 之间的争论最终可能要落在"谁能讲明白这个故事"上，而不是"谁先做出来"。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Laya — 33ms Multilingual System 1 Decision Engine with Calibrated Probabilities（ConvAI Innovations 博客原文） | https://laya.convaiinnovations.com/ |
| 2 | HN 讨论：I Built Non-Autoregressive Decision Models with RL a Year Ago | https://news.ycombinator.com/item?id=49765348 |
| 3 | arXiv:2503.23303 — 作者 2025 年 3 月的原始论文 | https://arxiv.org/abs/2503.23303 |
| 4 | arXiv:2510.01237 — 作者 2025 年 9 月的跟进论文 | https://arxiv.org/abs/2510.01237 |
| 5 | GLiNER 原论文（kamranjon 提到的更早工作） | https://arxiv.org/abs/2311.08526 |

<div class="disclaimer">

本文是对 HN 热门话题的中文摘要，所有引文均来自 HN 评论原文并标注了 comment ID。原文链接见"引用帖子"一栏。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>