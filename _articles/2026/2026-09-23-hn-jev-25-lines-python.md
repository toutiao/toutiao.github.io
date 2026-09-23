---
layout: post
title: >-
  Jev 用 25 行 Python 复刻——HN 评论：营销把 logprobs 包装成了「下一个 LLM 范式」
date: 2026-09-23
hn_id: 49812769
categories: [articles]
excerpt: >-
  把 Qwen 0.6B 的 logprobs 读出来当成概率——这就是被吹成「下一个 LLM 范式」的 Jev 在 25 行 Python 里的实现。评论区一边看穿是低悬果实，一边在算它和真 Jev 还差多远。
tagline: >-
  Jev 99% 准确率被嫌不够，0.6B 模型给个数字就封神。
---

## 原文概要

9 月 22 日，NobodyWho 团队发了一篇调侃博客《Jev in 25 Lines of Python》，点名 TypeSafe AI 的「System One decision model」Jev。整篇的论点很直白：TypeSafe 强调的不再生成 token、并行采样、输出结构化概率这套玩法，拿 `Qwen/Qwen3-0.6B-GGUF` 加 `llama-cpp-python`，25 行 Python 就能复刻出 demo。

代码本身没什么花活：用 `model.scores[model.n_tokens - 1]` 拿到最后一个 token 的 logits，按标签 `[A, B, C]` 切出 `Legitimate / Spam / Phishing` 三个选项的概率，做 softmax 归一化，最后 print 出来。结果是 `{Legitimate: 0.031, Spam: 0.084, Phishing: 0.885}`——一个能正常工作的三分类+校准概率的分类器。

作者在博客末尾主动加了一句 "this is a parody blog post"，并把真正的开源实现（OpenJev、openjev-sglang、OpenJev on DiffusionGemma）链接列在下面。言下之意：这条路的可行性不靠他们证明，开源社区已经做出来了；他们只是想戳破 TypeSafe 给「logprobs + 并行采样」加的那层神秘感。

帖子在 HN /best 拿到 342 分，112 条评论，主流讨论几乎都在同一个问题上打转：「25 行 Python 复刻」这件事到底说明了什么。

## 讨论焦点

### 「25 行」到底覆盖了什么

最先被提出来的是基准缺失。HN 用户 heaney-555 第一条评论就是三个字——"Latency and compute comparison needed."。no-name-here 把它扩成了一段：「Beyond the missing latency and compute comparisons that Heaney commenter mentioned, also nothing about its error rate compared to Jev」——把「功能等价」和「产品等价」混为一谈是这篇博客最大的漏洞。

但这层批评被另一群人挡住了：他们指出博客根本没承诺和 Jev 同台竞技。ricardobeat 把题目改成了产品级要求——"Now, can you do it in <200ms for 45 questions at once, have 0% malformed output, and any kind of meaningful benchmark? We'll wait!"——然后顺着这条线往下推。

> "Latency and compute comparison needed." — heaney-555 [c:49813000]
> （译文：需要对比延迟和算力。）

> "Now, can you do it in <200ms for 45 questions at once, have 0% malformed output, and any kind of meaningful benchmark? We'll wait!" — ricardobeat [c:49813112]
> （译文：那么，你能做到 200ms 内同时处理 45 道题、零格式错误输出、再加上任何一种像样的基准测试吗？我们等着瞧！）

更技术性的批评落在 logprobs 本身。sigmoid10 指出直接读 chat model 的 logprobs 有个隐藏陷阱：

> "Going directly for the logprobs is always icky when you use a chat model as base, because they are trained to write prose as output. So your "choice" tokens and thus their probabilities might get diluted in whatever else it wanted to say." — sigmoid10 [c:49813052]
> （译文：直接读 chat 模型的 logprobs 一直让人不舒服，因为它们被训练成输出散文。所以你那几个「选项」token、连同它们的概率，会被模型本来想说的话稀释掉。）

这条意见被 dTal 反驳——他做过类似的实验，结论是只要 prompt 写得好，token 分布能压到 95% 以上都集中在选项字母上；模型偏选 "A" 不是因为它想写文章，而是因为训练语料里英文字母 A 开头的词本来就多。TeMPOraL 进一步指出，dTal 测出的偏差最大能到 70%——比 prompt 不服从（<1%）严重得多。

### Jev 是低悬果实，不是新发明

围绕 Jev 的核心质疑是「这玩意到底新在哪」。这条线上最冷静的声音来自 wongarsu：

> "I think we can all agree that Jev is not rocket science. It's a good idea executed well, with marketing that might have been a tad too bold" — wongarsu [c:49813241]
> （译文：我想我们都同意 Jev 不是什么火箭科学。是个执行得不错的好点子，营销可能稍微激进了一点。）

_davide_ 把话说得更满："Jev was a low-hanging fruit all along; no one cared, and probably no one will in a few weeks?"——他还顺手算了笔账：45 道题并行做一次分类，prompt 处理 1317 tokens，5.5k PP 速度下大约 240ms，加上 50 tok/s 的输出，45 个 token 在并行里不到 20ms，整体跑进 200ms 内并不难。

> "Jev was a low-hanging fruit all along; no one cared, and probably no one will in a few weeks?" — _davide_ [c:49813283]
> （译文：Jev 从一开始就是个低悬的果实；之前没人摘，可能几周之后也没人摘？）

baobabKoodaa 在这条线上反复强调一个对比：Jev 宣传自己是「frontier intelligence」，而 NobodyWho 这套实现跑在 8-bit 量化、0.6B 参数的 Qwen 上——「There's no universe in which that claim is technically correct」。

> "Except in this case it's not technically correct. Jev's claim is that it's frontier intelligence and these guys are pretending that a 8-bit quantized 0.6B param Qwen model is that. There's no universe in which that claim is technically correct." — baobabKoodaa [c:49814085]
> （译文：只不过这次它连「技术上正确」都不沾边。Jev 说自己站在智能前沿，而这些人假装一个 8-bit 量化、0.6B 参数的 Qwen 模型就是那回事。在任何一种宇宙里这个说法都不成立。）

### System One 是营销比喻，不是技术分类

TypeSafe 把 Jev 包装成「System One 模型」——套用 Kahneman《思考，快与慢》里的人类认知二分法，意思是「不思考、直觉式输出」。评论区里这条叙事被反复拆解。

alun 是最不留情面的那个：

> "The one thing I can't wrap my head around with Jev is why they're trying to create that "System One" narrative. In real life, a human doesn't do classification tasks with the System One part of their brain, they use System Two. So by definition what Jev does isn't System One thinking." — alun [c:49814660]
> （译文：Jev 有件事我怎么也想不通——他们为什么要硬造一个「System One」的叙事。在真实生活里，人类做分类任务用的不是大脑的 System One 部分，而是 System Two。所以按定义来说，Jev 干的事根本不是 System One 思维。）

ActivePattern 直接定性——「It's just marketing. More specifically, it's an answer for why their model can't answer questions that require reasoning.」（它就是个营销话术，更具体地说，是给「模型不能做需要推理的问题」这个事实找的说辞。）

orsorna 把整件事的根源挖了出来：「"System One" 和 "System Two" 出自某本科普书……所以这个用法本身就是营销。」

### 「X in Y 行」的老套路

NobodyWho 的写作结构招来了一类历史性的类比。ramon156 第一个站出来：

> "IT's the infamous "OneDrive in 10 lines of code (SFTP)" While technically correct, it's not the same thing" — ramon156 [c:49813337]
> （译文：这跟臭名昭著的「10 行代码搞定 OneDrive（其实就是个 SFTP）」一个套路。虽然技术上没错，但它不是同一件事。）

shawabawa3 把它接成 Dropbox 的 FTP+curlftpfs+SVN 版本（这条梗本身早就是 HN 的固定节目）：「strong "You can build dropbox quite trivially by getting an FTP account, mounting it locally with curlftpfs, and then using SVN or CVS on the mounted filesystem" vibes」——你做了一个「像 Jev 的东西」而不是 Jev，输出质量天差地别。

> "strong "You can build dropbox quite trivially by getting an FTP account, mounting it locally with curlftpfs, and then using SVN or CVS on the mounted filesystem" vibes
>
> You have built something like jev but not jev" — shawabawa3 [c:49813277]
> （译文：浓浓的「你可以用 FTP 账号、curlftpfs 本地挂载、再叠个 SVN 或 CVS」DIY 一个 Dropbox 的既视感——你做了一个「像 Jev 的东西」而不是 Jev。）

iLoveOncall 的态度更直白：「Nothing I hate more than bullshit articles claiming X in Y lines of code, only to use libraries abstracting hundreds of thousands of lines of code.」——把这次复刻归进"调用了 llama.cpp 这种几百万行底层库之后，封装出 25 行调用方"的常见骗术。

zeroq 用更短的方式总结这条逻辑——画一个圆，import the rest of the owl：

> "How to write Jev in 25 lines of Python:
>   1. draw a circle
>   2. import the rest of the owl" — zeroq [c:49814907]
> （译文：如何用 25 行 Python 写一个 Jev：1. 画一个圆；2. import 剩下的猫头鹰。）

boros2me 直接引用一个俄语 meme 句式：「We have Jev at home.」——意思是「我们家里也有一个 Jev」（指这种自制的、远不如正版的同类品）。

### 校准与置信度：Jev 真正卖的是什么

如果 Jev 只是「logprobs + softmax」，那任何人都能做。评论区里最认真的讨论是它和纯 logprobs 之间的差——calibrated confidence（校准置信度）。

porridgeraisin 在这条线上反复纠偏。他先指出：「The confidence score is not trivial to compute. That is the whole point of the model.」——置信度不是个简单函数，深度网络的输出分布需要专门的后训练才能校准，这是 Jev 真正卖的货。

> "The confidence score is not trivial to compute. That is the whole point of the model. Even if you are using a proper scoring function such as NLL, it is not enough to ensure calibration in deep nets. So you have to do good post training to ensure it. These are all known techniques, but they are far from trivial, especially on large scale datasets." — porridgeraisin [c:49813378]
> （译文：置信度不是个简单函数。这正是模型的全部意义。即便你用的是 NLL 这种正经的打分函数，也不一定能保证深度网络的校准。所以你得做扎实的后训练。这些都是已知技术，但绝谈不上简单，尤其在大规模数据集上。）

wongarsu 拿出 TypeSafe 自己的文档，把 confidence 公式扒了出来：「(3 × largest probability − 1) / 2」——三条目时；通用形式被 kantahayashi 顺手补完：「(N × Max Probability − 1) / (N − 1)」。结论是「confidence is just a converted max probability and not an independent signal」——置信度就是最大概率的换皮，不是独立的信号。

> "For N options, it's (N x Max Probability - 1) / (N - 1). It's verified in this article: https://bernoulli.app/articles/is-jev-confident It means confidence is just a converted max probability and not an independent signal." — kantahayashi [c:49815455]
> （译文：N 个选项的情况下，公式是 (N × 最大概率 - 1) / (N - 1)。https://bernoulli.app/articles/is-jev-confident 这篇文章验证过。这意味着置信度只是最大概率换了个壳，并不是独立信号。）

ainch 接着补充实战经验——「LLMs are a poor fit. Neural nets in general struggle with 'calibration'」——他引了一篇 2017 年的 calibration survey，再补一句：「On ambiguous options which had to be escalated to a human, the LLM would regularly output something like a 99.8% probability, compared to 99.99% for a correct answer.」——好答案和坏答案都是 99%+，概率没法用来 routing。

xg15 则把双标直接点破：

> "I missed the hypewave so can't say a lot about Jev, but the double standards are entertaining:
> About Jev:
> Only 99% correctness! Borderline unusable!
> About their model:
> You want numbers, it gives you numbers! What more could you want?" — xg15 [c:49814572]
> （译文：我错过了 Jev 的炒作高峰所以不好多说，但双标真的很有趣：
> 评价 Jev：只有 99% 准确率？基本不可用！
> 评价他们的模型：你想要数字，它给你数字！还想要什么？）

### 这条路线的真实落地场景

抛开 Jev 本身，评论区里有一类建设性的声音在讨论 logprobs 分类到底能用在哪些地方。

cupofjoakim 提了一个本地 prompt router 的思路：

> "I wonder if this could be a good stepping stone to write a local prompt router to optimise what model get what prompt. I.e. if the prompt is just a lookup, send it to haiku, if it's reasoning, send it to opus and if it's implementation send it to sonnet." — cupofjoakim [c:49813257]
> （译文：我在想，这能不能成为写本地 prompt router 的一块垫脚石——按 prompt 类型把请求分给不同的模型。比如只是查询就丢给 haiku，要推理就丢给 opus，写实现就丢给 sonnet。）

petercooper 直接报了个数据——Qwen 3.5 0.8B 在 Mac 上做图像分类+OCR，每条 250ms 左右，accuracy 视任务而定：

> "You can also go beyond Jev. Qwen 3.5 0.8B is fantastic at basic image classification/question answering (including OCR elements) also. Though rather than looking at logits, I get it to output a structured JSON object and it does simple object classification tasks on a Mac at under 500ms a pop (I forget how far, but I think it's like ~250ms) with good accuracy (depending on task)." — petercooper [c:49813575]
> （译文：你还能比 Jev 走得更远。Qwen 3.5 0.8B 在基础图像分类/问答（包括 OCR 元素）上也非常能打。只不过我没读 logits，而是让它输出结构化的 JSON 对象，在 Mac 上跑简单的对象分类任务单条不到 500ms（具体数字忘了，大概 ~250ms），准确度也够用（看任务）。）

foo12bar 提到一个意外好用的场景：字幕翻译。把 5 条已翻译的字幕作为 partial answer 接进 prompt，模型就能「接着翻」——不会出现 markdown，不会因为内容敏感（生物武器、核）而拒绝。

但 armcat 给这条路线泼了一盆冷水：

> "Looking at the logprobs on tokens works for the local models, but not on the frontier ones. It's been more or less broken since GPT-4o for example." — armcat [c:49814490]
> （译文：读 token 的 logprobs 这套在本地模型上能用，但 frontier 模型上不行。比如 GPT-4o 之后基本就废了。）

GPT-4o 之后，闭源 frontier model 的 top-k logprobs 已经退化到不可用——本地模型能玩 logprobs，云上的不一定能玩。

antirez 在这条路上贡献了一条经验性 tip：把选项放在正文之前能让 transformer 提前知道要看什么，加上「重复一遍问题」的小技巧还能进一步抬一抬准确率。这条评论引发了一连串吐槽，techterrier 一声短促的「fuck this timeline」最能代表 HN 对当前 AI 工程现状的态度。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 反对 | heaney-555 [c:49813000] | 没有 latency / compute / error rate 对比，「25 行复刻」什么也证明不了 |
| 反对 | baobabKoodaa [c:49814085] | 把 8-bit 量化 0.6B Qwen 说成 frontier intelligence 在任何宇宙里都不成立 |
| 反对 | porridgeraisin [c:49813378] | 校准置信度不是简单函数，需要专门后训练——这是 Jev 真正的护城河 |
| 反对 | armcat [c:49814490] | frontier 模型 GPT-4o 之后 logprobs 已经基本不可用 |
| 拆解 | sigmoid10 [c:49813052] | chat model 的 logprobs 容易被「想写文章」稀释，prompt 必须特别处理 |
| 拆解 | alun [c:49814660] | System One / System Two 是人类认知二分法，套在分类模型上不成立 |
| 拆解 | ramon156 [c:49813337] | 和「OneDrive in 10 lines of code」一个套路，技术正确但不是同一件事 |
| 拆解 | shawabawa3 [c:49813277] | 复刻的是「像 Jev 的东西」而不是 Jev，输出质量天差地别 |
| 拆解 | xg15 [c:49814572] | 对 Jev 99% 准确率不满、对 0.6B 模型「给了数字」就满足，是典型双标 |
| 支持 | wongarsu [c:49813241] | Jev 不是火箭科学，是个好想法 + 略激进的营销 |
| 支持 | _davide_ [c:49813283] | 是个低悬果实，没人做过；45 题并行 200ms 内完全可达 |
| 支持 | faangguyindia [c:49813511] | 26B 自建版已经在跑了，TypeSafe 兼容 API |
| 支持 | petercooper [c:49813575] | Qwen 3.5 0.8B 在 Mac 上做图像分类 250ms 一条，准确度足够 |
| 实用 | cupofjoakim [c:49813257] | 适合做本地 prompt router，按任务类型分流到不同模型 |
| 实用 | foo12bar [c:49814384] | 字幕翻译里 partial answer 技巧非常好用，不会拒答敏感内容 |
| 营销 | ActivePattern [c:49814998] | System One 这套叙事是给「不能做推理问题」找的说辞 |
| 营销 | orsorna [c:49814756] | System One / System Two 出自科普书，本身就是营销用法 |

## 总体情绪

评论区整体分成三股力量，互相之间不太说服得了对方。

第一股是技术怀疑派。他们承认 logprobs 分类这条路成立，但反复强调几件事：Jev 卖的不是「logprobs」本身，而是「校准过的概率」——这需要专门后训练，是 25 行 Python 复刻不出来的那部分；frontier 模型从 GPT-4o 之后 logprobs 已经开始退化，这套玩法在云上不一定能用；直接读 chat model 的 logprobs 还有 prompt 不服从和「A 偏置」两个坑。

第二股是营销解构派。他们把焦点放在 TypeSafe 的叙事层：System One 是 Kahneman 概念的滥用，「frontier intelligence」是个大词，「25 行复刻」也不是 TypeSafe 自己宣传的——所有这些加起来让人觉得 Jev 在卖概念而不是卖技术。revexos 一句话最锐利：「Startup coming out of 2 years of stealth to be reproduced this easily」（一个秘密研发两年的初创公司，被这么轻易地复刻了）。

第三股是建设性的应用派。faangguyindia 跑了 26B 自建版本、petercooper 用 0.8B Qwen 在 Mac 上做图像分类、cupofjoakim 想拿来做 prompt router——这群人不怎么在乎 TypeSafe 的叙事，他们在乎的是「这条路线到底能给我省下多少 LLM 调用」。estetlinus 把这层意思说得最直白：「From what I've learned about Jev I feel it's just a very successful marketing campaign to developers not fully understanding data science (and deep learning). It's nothing new, been around since 2022? Being local is an extreme advantage lol.」

整场讨论最让人会心一笑的是 antirez 那条「重复问题两次能提高准确率」的 tip——以及 techterrier 一声短促的「fuck this timeline」。HN 上对 AI 工程现状的态度，一句脏话比一篇论文更准确。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Jev in 25 Lines of Python | https://news.ycombinator.com/item?id=49812769 |

## 免责声明

<div class="disclaimer">

本文为 HN 热门讨论的中文摘要，所有引文均尽力保留原文及 HN 评论 ID 以便核对。翻译为意译，与原文可能有细微差异，请在原帖核对完整语境。HN 评论用户的观点不代表原作者或本刊立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax/MiniMax-M3</em>

</div>
