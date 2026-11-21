---
layout: post
title: >-
  Inkling 2 Mini：把中间 12 层跑三遍，26.4B 参数的开源小模型，本地跑得动但比理论慢四倍 — HN 讨论摘要
date: 2026-11-21
hn_id: 50581260
categories: [articles]
excerpt: >-
  Thinking Machines Lab 发布 Inkling 2 Mini，开源权重，26.4B 总参数、3.4B 激活、约 20GB 内存占用，
  中间两个 block 各跑三遍（looped transformer），DeepSWE v1.1 拿到 48.2%。
  评论区真正在算的是另一笔账：M1 Max 上 20 tok/s，5090 上 52 tok/s，而按带宽推算应该是 74 tok/s。
tagline: >-
  循环三层省了 token，却把内存带宽吃回来了：省下的和吃掉的，账单在评论区算得比官方细。
---

> 来源：HN 讨论主帖 [Inkling 2 Mini](https://news.ycombinator.com/item?id=50581260)（687 分，110 条评论），页面指向 thinkingmachines.ai 的发布文章。归档快照 2026-11-21 01:59 UTC，入库 100 条评论（触及抓取上限 100；Algolia 未返回评论分，分数字段均为 0），引文选择依据为内容本身与讨论价值。引文中的 HTML 实体按 HN 页面显示形式还原，文字与作者逐条与归档评论比对。

## 原文概要

Thinking Machines Lab 在 11 月 20 日发布 Inkling 2 Mini，开源权重，同天上 Hugging Face 和自家 Tinker 平台。这个型号里最不常规的不是 Mini，而是结构本身：它是一个 looped transformer（循环层模型）——24 层被切成 4 个 block，每个 6 层；中间两个 block 各跑 3 遍，首尾两个各跑 1 遍。模型是 MoE，26.4B 总参数、3.4B 激活；把循环算进去，每个 token 要激活 5.4B 权重。

跑分上官方给的说法是：在总参数小于 100B 的开源权重模型里，DeepSWE v1.1（48.2%）和 Vals Index v2.2（46.5%）都排第一；agentic coding 基准领先，kernel 优化基准 PMPP-Hard 上逼近更大的 Inkling 2 Small。权重大部分原生 NVFP4 训练、最后四层用 MXFP8，整套约 20GB 内存占用。研究人员在飞机上用 MacBook Pro 离线跑了一个可玩的飞行模拟器。斯坦福 Hazy Research 测的 intelligence per joule：DGX Spark 上 0.703，Qwen3.6-35B-A3B 是 0.430，Gemma-4-26B-A4B 0.159，Qwen3.5-27B 0.036。发布材料里还附了一段像素动画：Thinkyville 小镇里 20 个居民，由同一台离线 MacBook（M5 Pro，48GB）上的同一个模型驱动。

可监控性是这次发布着力讲的一件事。官方同时放出一个研究用的变循环版本（TML-d24-varloop-research），循环次数可以在推理时配置：无 CoT 的情况下，模型的「时间跨度」从 1 遍的 16 秒提高到 3 遍的 37 秒；串行推理基准在 10 遍时仍在提升，而训练时只用了 3 遍；循环越多，写出来的 CoT 越短但仍然可读；agentic sabotage 这类测试没有随循环变多而升高。循环位置也做了对照：循环中间 12 层（7–18）等算力增益是 1.51–1.91 倍，循环末尾 12 层（13–24）只有 1.24–1.36 倍，28 项评测里 27 项是中间循环赢。

官方自己承认的短板同样写在明面上。循环提升推理，但不增加权重能存下的事实——AA-Omniscience 与同级模型持平，知识密集型基准不随遍数改善，长上下文基准（GraphWalks BFS、MRCR v2）才随遍数改善。多轮对话和复杂指令不是强项：MultiChallenge 50.0%、ComplexConstraints v1.1 33.4%，两项都落后 Qwen3.8-27B；CritPt v2 和 HLE-Diamond 也落后。

## 讨论焦点

### 一、Goodhart 又赢了一次：跑分和手感是两件事

第一个回合就是基准与体感的对撞。

> "This is bonkers good if these benchmarks hold up in real-world scenarios." — montroser [c:50581726]
> （译文）如果这些基准在真实场景里站得住，这东西就好得离谱。

> "To me, this means they probably won't." — stavros [c:50583759]
> （译文）在我这里，这只意味着它们多半站不住。

把这句话放在一起，讨论的基调就定了：跑分被当作待验证的声明，而不是结论。用过太多小模型的人对此有现成的条件反射：

> "Every time I look at these I think, yep, another small MoE claims to outperform Muse Glimmer. And then I test it in comparison and I remember Goodhart's Law." — dofm [c:50583998]
> （译文）每次看到这类东西我都会想：又一个声称超过前一个小 MoE 的小 MoE。然后我真去对比一下，就想起古德哈特定律。

反例也是同一位评论者给的，他并不怀疑模型本身，只是不信表格：

> "It feels like a masochistic exercise entirely removed from reality." — solarkraft [c:50584492]
> （译文）这感觉像一场自我折磨，跟现实完全脱节。

具体到 agent 场景，有人直接质疑跟「有用」最相关的那一列分数：

> "Big fan of open weights but those Terminal Bench numbers are pretty abysmal" — causal [c:50582923]
> （译文）我支持开源权重，但那些 Terminal Bench 的数字相当难看。

而真正用了之后的感觉，比分数更有信息量：

> "Benchmarks look good, and inkling 2 small felt better than the benchmarks suggested, so I am very excited to play with this." — mattnewton [c:50581428]
> （译文）基准看起来不错，而 Inkling 2 Small 的手感比基准暗示的还要好，所以我很期待去玩它。

### 二、循环层到底循环了什么

「looped transformer」对多数读者是全新概念，一位评论者直接问了：

> "This is the first I’m hearing of a looped model. What is it?" — LPisGood [c:50583675]
> （译文）这是我第一次听说循环层模型。它是什么？

回答有两条。一条是通俗版：

> "Goes a couple or three times through the same weights in a middle layer of the model. Nemotron's Dory pioneered this I think." — cmrdporcupine [c:50583704]
> （译文）就是让模型中间某层的同一批权重多跑两三遍。我记得英伟达的 Nemotron Dory 是先行者。

一条是研究版：

> "the gist (when talking about Transformers) is that instead of stacking 12 latent blocks, you can stack 4 and let them loop 3 times" — calebkaiser [c:50584025]
> （译文）大意是（就 Transformer 而言）你不必堆 12 个隐层块，可以堆 4 个然后让它们循环 3 次。

但讨论的重点不是机制本身，而是「这是不是第一个」。

> "I think this may be the first public example of a looped transformer model good enough for real world use cases?" — gchadwick [c:50581821]
> （译文）我觉得这可能是第一个好用到能进真实场景的公开循环层模型。

> "But, Inkling 2 Mini is the first open weight MoE looped transformer of any note that I've seen (the others are dense models), and the benchmark scores really do look incredible." — coder543 [c:50582836]
> （译文）不过 Inkling 2 Mini 是我见过的第一个称得上重要的开源权重 MoE 循环层模型（其他都是稠密模型），而且基准分数看起来确实惊人。

还有人对「循环」这件事的来路做了考古，指出它并不是某个实验室的独创：

> "For example, stretching LLM context window through stretching RoPE was discovered by /u/kaiokendev on the original Llama in 2023" — dannyw [c:50584466]
> （译文）比如说，通过拉伸 RoPE 来扩展 LLM 上下文窗口这件事，是 /u/kaiokendev 在 2023 年的初代 Llama 上发现的。

这位评论者真正想说的大概是另一句：概念一旦被证明有效，就会先在 DIY 圈子里长出来，然后才进论文。而训练难度被普遍低估了：

> "the fact that they trained it as a looped model in 4-bit native is also kind of impressive to me as well, because it combines recurrence, routing, and narrow-format - all of which adversely impact numeric stability during training." — twothreeone [c:50583775]
> （译文）他们用 4-bit 原生格式训练一个循环层模型这件事本身也有些让我刮目相看，因为它把递归、路由和窄数值格式叠在了一起——三者都会在训练期损害数值稳定性。

### 三、本地实测：18 tok/s 与 74 tok/s 之间的那个差

这是全场最热闹的一段，因为很多人在发帖当天就把模型拽到了自己的机器上。

> "bonkers - I'm getting 20 tokens/s running the 4-bit version on my 2021 M1 Max MacBook pro with 64Gb...!!" — gregsadetsky [c:50583627]
> （译文）离谱——我在 2021 款 64GB 的 M1 Max MacBook Pro 上跑 4-bit 版，能到 20 tokens/s……！！

> "I'm getting 700 tok/s prefill and 52tok/s generation on a 5090 RTX, not bad" — enlyth [c:50582795]
> （译文）我在 5090 RTX 上跑到 700 tok/s prefill、52 tok/s 生成，不算差。

> "This looks like it could run on my M2 32GB MBP." — lenerdenator [c:50582311]
> （译文）这东西看起来能在我那台 32GB 的 M2 MacBook Pro 上跑起来。

然后有人拿带宽把账算了一遍，算出来跟实测差了四倍：

> "Theoretically with 400GB/s memory bandwidth and effectively 5.4B active parameters (accounting for the looping), token generation should be closer to 74 tokens/second. 18tps is close to what you'd expect for a dense model this size (22GB for UD-Q8_K_XL)." — meatmanek [c:50584615]
> （译文）理论上，按 400GB/s 内存带宽和 5.4B 有效激活参数（已经把循环算进去了）算，生成速度应该接近 74 tokens/second。实测 18 tps，反而接近这个体量的稠密模型该有的水平（22GB 的 UD-Q8_K_XL）。

差在哪里？ROCm 上 Flash Attention 还没支持是常见的答案：

> "Current benching shows ~28 tok/s decode and ~481 tok/s prefill." — rsolva [c:50582966]
> （译文）当前测下来大约 28 tok/s 解码、481 tok/s prefill。

怀疑者的结论要更直接：

> "I'm worried this tri-loop setup is going to be too slow." — jakswa [c:50583339]
> （译文）我担心这套三层循环会太慢。

而「本地能用」带来的最实际后果，是硬件订单。评论区里 Framework 桌面机成了明星：

> "I'm loving this trend. My framework desktop is looking like a better and better investment." — christkv [c:50581614]
> （译文）我很喜欢这个趋势。我那台 Framework 桌面机越来越像一笔划算的投资了。

> "I got it for 2100 EUR and now it looks like a steal." — christkv [c:50582754]
> （译文）我当初花 2100 欧元买的，现在看起来简直是白捡。

不只一个人注意到这层含义——模型在笔记本上能跑，等于把「买还是租」的决策从云厂商手里拿走了。也有人点出多 agent 场景的可能性：

> "it might be the first model that can reliably run multi-agent reasoning harnesses on local hardware, as this is a MoE model and can have several agents each with their own KV caches that fit into VRAM." — 2001zhaozhao [c:50582284]
> （译文）它可能是第一个能在本地硬件上可靠运行多 agent 推理框架的模型，因为这是 MoE，可以有多个 agent 各自带着能塞进显存的 KV cache。

生态跟进也是现成的：unsloth 当天就出了 GGUF 版本，有人因此反问为什么还要量化。

> "why do people need to even quantize this model? it is already in nvfp4." — ycui7 [c:50584545]
> （译文）为什么人们还要量化这个模型？它本来就是 nvfp4。

至于「本地运行」本身，还是有一些没跟上：

> "Doesn't seem to run in MLX-Serve yet :(" — jedisct1 [c:50583653]
> （译文）好像还不能在 MLX-Serve 上跑……

> "hate these dark practices. they say click here to try it on our site. then u click. auth wall. fine you give it all your info. sunk cost is maximized. then they hit you with the credit card wall." — purplecats [c:50583670]
> （译文）讨厌这种套路：他们说点这里去我们站点试用，你一点，登录墙，好，你把信息都交了，沉没成本拉满，然后他们再给你一道信用卡墙。

### 四、循环不增加知识：省 token 与省事实是两笔账

官方在发布材料里写得很直白：循环让模型推理更久，却不增加权重能存的事实。评论区立刻拿实测印证这一点。

> "The model burned through 19200 thinking tokens on this task (which was the hard limit I had set) and didn't finish." — dofm [c:50583503]
> （译文）模型在这个任务上烧掉了 19200 个思考 token（这是我设的硬上限），而且没做完。

这位评论者的任务是写一个 WordPress 插件，钩住用户登录、把上次登录时间存成 metadata，并要求不调用工具、只靠记忆：

> "Both Qwen 3.6 35B and Gemma 4 26B can cope with this task, from memory, in far fewer tokens (even taking into account Qwen's tendency to loop in thinking)." — dofm [c:50583503]
> （译文）Qwen 3.6 35B 和 Gemma 4 26B 光靠记忆都能处理这个任务，用的 token 少得多（这还没算上 Qwen 在思考里绕圈的倾向）。

允许用工具之后，模型找到了解法，但思考里预示的那个错误还是发生了；而且两万 token 之后，它开始反复输出结束标记而不去真的调用工具。结论是：

> "So far, I think I would run Muse Glimmer or Nemotron Bolt over this; Muse Glimmer would output tokens more slowly but still get to a result much more quickly." — dofm [c:50583503]
> （译文）目前为止，我觉得我会用 Muse Glimmer 或者 Nemotron Bolt，而不是它；Muse Glimmer 输出更慢，但能更快拿到结果。

这段实测被反复引用，也就成了整个帖子里最有杀伤力的一条证据：一个宣称在 agentic coding 上领先的模型，在一个几十行的插件任务上烧掉两万思考 token 而没有交卷。

### 五、CoT 变短：更安全，还是更看不见

官方把可监控性当成卖点：循环越多，写出来的思维链越短，模型却能想更久。这在安全讨论里立刻变成一个正反两面的问题。

支持读法的人注意到，这正是他们想看的部分：

> "I like their section about CoT monitorability." — 2001zhaozhao [c:50582284]
> （译文）我很喜欢他们关于 CoT 可监控性的那一节。

反对读法的人把问题推得更远：

> "Wonder what it means for safety and interpretability at this level of availability." — lilytweed [c:50582638]
> （译文）我想知道，在这种普及程度下，它对安全和可解释性意味着什么。

> "We already know from official model cards that the GPT-6 models are substantially less monitorable than other (non-looped) models." — cubefox [c:50583404]
> （译文）我们已经从官方模型卡知道了：GPT-6 系列模型比其他的（非循环）模型可监控性差得多。

 doom 计数器当然也没闲着：

> "The trends of capabilities and efficiency we've seen over the last few weeks should terrify anyone with any sense." — kypro [c:50582637]
> （译文）过去几周我们看到的能力和效率趋势，应该让任何有点理智的人感到恐惧。

但另一派认为，开放权重在防守侧是必需品：

> "Anyone following the news is aware that we've had Mythos-comparable cyber red-teaming capabilities for quite a few months now. The sky hasn't fallen" — bigyabai [c:50582942]
> （译文）关注新闻的人都知道，我们早就有 Mythos 级别的网络红队能力了，而且已经持续了好几个月。天并没有塌下来。

> "I'm gonna bet you'd be complaining a lot more if a bioterrorist used Claude and their blocks weren't strict enough." — xvector [c:50584156]
> （译文）我敢打赌，如果某个生物恐怖分子用了 Claude 而它的拦截不够严，你会抱怨得多得多。

### 六、Qwen 3.8 的位置还稳吗

被反复拿来当参照物的是 Qwen3.8-27B。兴奋的一方：

> "The masses lying in wait for Qwen 4 cry out in joy. A savior? Could it be?!" — jakswa [c:50581731]
> （译文）等 Qwen 4 的大军喜极而泣。救世主？有可能吗？！

> "When you are sure enough about what you are doing to include Qwen 3.8 27B in your compare.. we know you are talking... let's test drive it!" — xlayn [c:50582497]
> （译文）你要有把握到把 Qwen 3.8 27B 放进对比里，我们就知道你在说什么了……来开一把试试！

冷静的一方给出的是分寸：

> "more of like it's on par / a few points ahead on some, behind on others." — twothreeone [c:50583775]
> （译文）与其说它「打败」Qwen3.8-27B，不如说大致持平：某些项目上领先几分，某些项目上落后。

同一位评论者提醒了一个容易被忽略的差别：Qwen3.8-27B 是稠密模型，Inkling 2 Mini 是 MoE，激活参数少得多，所以「打平」的含金量不一样。

> "If it can outsmart Qwen3.8-27B while using substantially fewer active parameters... this is going to be really great." — coder543 [c:50582836]
> （译文）如果它能在激活参数少得多的情况下压过 Qwen3.8-27B……那将会非常了不起。

至于跟谁同档，另一位评论者给的定位是：

> "In terms of the active parameters and token/s on slow or less capable hardware it seems like it should be in the same general performance category as qwen 3.6 35B A3B." — walrus01 [c:50581530]
> （译文）就激活参数量和在较慢硬件上的 token/s 而言，它应该和 qwen 3.6 35B A3B 属于同一个大致性能档位。

### 七、多轮对话与创意写作：不是它的战场

官方自己承认 MultiChallenge 和 ComplexConstraints 两项都落后 Qwen3.8-27B。评论区实测和这个承认一致，而且顺带暴露了一个小模型的通病。

> "Even more talkative than Qwen" — sourcecodeplz [c:50583265]
> （译文）比 Qwen 还啰嗦。

一位用户的反馈列了三条，其中两条正好对应发布材料里的限制：

> "1. it feels intelligent, and can solve open problems throw at it like other quasi-frontier models (DeepSeek 4 Flash 0731 / DeepSeek 4.1 Flash 1017 / GLM 5.3 Flash etc). 2. its responses sometimes can be odd (they are honest about it in the blog post!), can have wrong use of markdown syntax, sometimes overly brief, etc." — liuliu [c:50581652]
> （译文）一、它感觉很聪明，能解决我随手丢给它的开放问题，表现接近其他准前沿模型（DeepSeek 4 Flash 0731 / DeepSeek 4.1 Flash 1017 / GLM 5.3 Flash 等）。二、它的回答有时会有点古怪（他们在博客里也承认了这一点！），markdown 语法有时用错，有时又过于简短，等等。

而在闲聊与创作这一侧，社区给出的答案是「先别看它」：

> "What are some models in this ballpark that are also good at conversation? They always show off their software capabilities, but can it talk naturally? make creative stories?" — Almondsetat [c:50582822]
> （译文）这个档位里有哪些模型是同时擅长对话的？他们总是秀软件能力，可它能自然地聊天吗？能写有创意的故事吗？

> "The closest to this that's also good at prose is gemma4 26b a4b." — hunterloftis [c:50583344]
> （译文）跟它这个档位接近、同时又擅长文笔的是 gemma4 26b a4b。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 跑分与体感脱节 | dofm | 又一个声称超过前一个小 MoE 的小 MoE |
| 基准不可信 | stavros | 既然好得离谱，那就说明多半站不住 |
| Terminal Bench 难看 | causal | 支持开源权重，但那个分数很糟 |
| 首个可用的开源循环层模型 | gchadwick | 可能是第一个能进真实场景的 looped transformer |
| 开源模型会集体转循环层 | lilytweed | 我押大部分开源模型会跟进 |
| 首个 MoE 循环层开源模型 | coder543 | 在此之前的都是稠密模型 |
| 循环层是什么 | calebkaiser | 12 个隐层块换成 4 个跑 3 遍 |
| 4-bit 原生训练不易 | twothreeone | 递归、路由、窄格式叠加，数值稳定性很难搞 |
| 概念来自 DIY 圈 | dannyw | RoPE 拉伸当年就是用户先发现的 |
| 本地真能跑 | gregsadetsky | 2021 款 M1 Max 上 20 tok/s |
| 速度担心 | jakswa | 三层循环大概率太慢 |
| 带宽账不平 | meatmanek | 理论 74 tok/s，实测 18 |
| 多 agent 本地化 | 2001zhaozhao | 可能是第一个能可靠跑多 agent 框架的本地模型 |
| 量化多余 | ycui7 | 它本来就是 nvfp4 |
| 循环不增知识 | dofm | 权重存不下更多事实 |
| 省 token 不出结果 | solarkraft | 像一场自我折磨 |
| CoT 变短更危险 | cubefox | GPT-6 的模型卡已经承认可监控性更差 |
| 开放权重对防守有用 | bigyabai | 天没有塌，反倒帮了逆向与渗透 |
| Qwen 位置动摇 | jakswa | 等 Qwen 4 的大军喜极而泣 |
| 聊天写作不是强项 | sourcecodeplz | 比 Qwen 还啰嗦 |

## 总体情绪

这是一场被两类情绪分开的讨论。一类是技术兴奋，但它兴奋的对象很具体——不是「又一个小模型超过 Qwen」，而是「循环层第一次以开源权重的形式，进入了能真跑的区间」。评论区里那些立刻下载 GGUF、把速度数字报出来的人，是这次发布最实在的回应：模型好不好的争论，最终要用 token/s 结算。

另一类是怀疑，而怀疑的落点不是模型本身，是那张表。Goodhart、Terminal Bench、官方自己承认的知识上限、以及那个烧掉 19200 个思考 token 仍没交卷的插件任务——这些构成了一个连贯的叙事：循环层确实让模型想得更久，但想得更久不等于知道更多，也不等于更快，更不等于在实际任务上做对。当一位评论者说，一个输出很快、却把无数 token 浪费在思考上、最后还答错的模型没有多大用时，评论区没有人反驳。

真正被低估的是本地这条线。687 分的帖子下面最有生活气息的对话，不是关于基准，而是关于谁在攒 Framework 桌面机、谁的 64GB M1 Max 刚跑到 20 tok/s、谁在 ROCm 上被 Flash Attention 挡住。官方用「研究者在飞机上用 MacBook Pro 做了个飞行模拟器」来展示 20GB 内存占用的意义，评论区则用一整晚的折腾把它翻译成了普通人能算的账。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Inkling 2 Mini（HN 主帖） | <https://news.ycombinator.com/item?id=50581260> |
| 2 | Introducing Inkling 2 Mini（原文，thinkingmachines.ai） | <https://thinkingmachines.ai/news/inkling-2-mini/> |
| 3 | TML-d24-varloop-research（变循环研究版模型卡） | <https://thinkingmachines.ai/model-card/tml-d24-varloop-research/> |
| 4 | Inkling-2-Mini（Hugging Face 权重） | <https://huggingface.co/thinkingmachines/Inkling-2-Mini> |
| 5 | unsloth/Inkling-2-Mini-GGUF（第三方量化版） | <https://huggingface.co/unsloth/Inkling-2-Mini-GGUF> |
| 6 | llama.cpp PR #32695（评论区引用的循环层支持） | <https://github.com/ggml-org/llama.cpp/pull/32695> |
| 7 | Intelligence per Watt（斯坦福 Hazy Research，评论区引用） | <https://arxiv.org/abs/2511.07885> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 687 分、110 条评论，归档快照 2026-11-21 01:59 UTC，入库 100 条，触及抓取上限 100，未取到全量评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文抓取成功，但正文在 8000 字符处截断，截断点落在「架构与训练」一节中途；「原文概要」中的事实（looped transformer 结构与 24 层四 block 划分、26.4B/3.4B/5.4B 参数口径、DeepSWE v1.1 48.2%、Vals Index v2.2 46.5%、PMPP-Hard、NVFP4 与 MXFP8 训练、约 20GB 内存占用、Thinkyville、斯坦福 intelligence per joule 数字、变循环版本的 16 秒/37 秒时间跨度与 10 遍外推、循环位置的 1.51–1.91 倍对照、MultiChallenge 50.0% 与 ComplexConstraints v1.1 33.4% 等）均来自该截断前的正文，其后的章节（attention residuals 的具体做法、训练数据规模、完整评测表等）未完整取得。

文中所有本地实测速度、显存与 KV cache 情况，均为评论者在各自硬件与推理框架上的个人结果，不同版本、量化格式与后端差异很大，不可直接横向比较；对官方基准与架构的说法，本文只做转述，未独立验证。

涉及安全、监控性与网络攻防能力的引述为评论者个人观点，不代表事实认定；模型能力评测与安全结论请以官方模型卡与研究论文为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
