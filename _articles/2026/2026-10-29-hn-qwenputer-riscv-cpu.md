---
layout: post
title: >-
  Qwenputer：把一台 RISC-V CPU 编译进 Qwen3.5 的权重，1800 万条指令零出错 — HN 讨论摘要
date: 2026-10-29
hn_id: 50282838
categories: [articles]
excerpt: >-
  不是插件，也不是工具调用：有人把一台 32 位 RISC-V CPU 直接编译进 Qwen3.5 的权重，
  用模型自己的 Gated DeltaNet 状态当 RAM，让它在前向传播里自己算大数、跑 C 和 MicroPython。
tagline: >-
  别问能不能跑 DOOM，先问 GPU 里为什么还要再跑一台 CPU。
---

## 原文概要

Divyansh Agrawal（divagr）在 10 月 22 日发布博客《Qwenputer: a fully functioning, deterministic RISC-V CPU inside Qwen3.5》，HN 上由 csmantle 提交，标题改成《Qwenputer: A functioning, deterministic RISC-V CPU inside Qwen3.5》，10 月 29 日上午出现在 HN 首页，拿到 215 分、47 条评论。做法是一个原版 Qwen 3.5 4B，在它的权重之上加装一台完全跑在模型前向传播内部的 RISC-V CPU。作者反复强调边界：不是插件，不是工具调用，不是沙箱，模型不需要任何外部运行时。

关键技巧是把 Gated DeltaNet 的状态当 RAM。Qwen3-Next 和 Qwen 3.5 每四层里有三层用 Gated DeltaNet（线性 RNN）做注意力，每个 head 维护一张状态矩阵。把 gate 设成 1（记忆永不过期）、把写入强度 beta 设成 1（整行覆盖而不是混合）、把 key 编码成 one-hot（精确指向状态矩阵的某一行），GDN 状态就变成了精确可寻址的 RAM。而且 GDN 状态的大小固定，不像 attention 的 KV cache 那样随对话变长。作者也点明这不是新想法：Schlag 等人 2021 年就证明带 delta rule 的线性注意力可以当关联记忆（fast weights），新意在于把它做成精确、可寻址，并且能在生产模型里可靠地跑起一整台 CPU。

把 CPU 塞进网络层不需要训练，编译器直接写权重。先把 CPU 描述成电路——一长串「读这个寄存器」「把这两个数加起来」「为零就跳转」——编译器再把每一步翻成 transformer 层的零件：attention head 负责查表，前馈层负责算术，DeltaNet head 负责存 RAM。每条指令变成几个 token，一个 ADDR 指明写哪一行，一个 VAL 携带数值，STEP 表示这条指令结束；这些 token 就是 CPU 的执行轨迹，模型一边生成它们，CPU 一边真的在跑。

这台 CPU 的规格和成绩都写得很具体。32 位 RISC-V 核（RV32IM，加 Zba 扩展和一个做大数运算的小 bignum 单元），占在 Qwen 那 32 层之前的 11 层。通过官方 riscv-tests，程序结果与 qemu 一致，free-running（自己接自己的输出、中间没有参考机纠错）连跑 1800 万条指令零错误。算术成绩：DeepMind 的 div_big 97.5%（给 base Qwen 挂 Python 工具是 95%，裸模型 72.5%），mul_big 97.5%（工具 100%，裸模型 55%），mul_div_multiple_longer 100%（工具 97.5%，裸模型 90%），add_or_sub_big 97.5%（与工具持平，裸模型 87.5%）；NUPA 的长整数题从 48.6% 提到 100%，和挂 Python 工具持平。数值本身也是精确的：约 23 万个输出位置拿参考机回放，零不匹配；挂上这台电脑后，模型日常说话的方式没变（KL 6e-4，噪声底 5e-4）。

作者随后又给它加了个文件系统：模型侧的 put、append、get、list、delete 全是编译层内部操作，仍然不是工具调用。文件名 hash 到 DeltaNet 状态里 1,024 个槽位之一，正文按每行 8 个 token 链式存在别的 head 中，最多放 512 个文件、约 5.3 万 token 文本，找回一个文件大约两三步。状态存盘后能带进下一次对话；用它获取「两次对话之间发生变化的事实」准确率 90%，而把旧对话粘贴回去只有 30%，与 Python 版 memory tools 的 78.9% 相比是 83.3%。这个功能仍在实验阶段，代码在 rv-store 分支。代价也写清楚了：checkpoint 18.8 GB（约为 base 的两倍，不过大部分是零填充）；需要一个叫 RvChat 的驱动加载固件、并且把轨迹 token 挡在 Qwen 的层外，还不能直接调用 generate()；每条 CPU 指令要消耗几个 token，一次大计算按秒计算，批量执行器在 L4 上大约每秒 3,200 个 CPU token。单张 24 GB GPU 就能跑，代码和权重全部开源。

## 讨论焦点

### 一、绕这一圈到底有没有必要

最先接上的是 andai，他读完 GDN 当 RAM 那段就问出了评论区最核心的问题：

> "So like... can't you use a computer as a computer without doing all that roundabout stuff? Like if you want to integrate a LLM with hard computation there's probably a more efficient way to do that." — andai [c:50283954]
> （译文：那么……你不能直接拿计算机当计算机用，非要绕这么大一圈吗？比如你想把 LLM 和硬计算整合起来，大概有更省事的办法。）

rvz 的回答更直接，也更像是这条帖子的招牌反方：

> "So this is yet another rube goldberg machine." — rvz [c:50283402]
> （译文：这又是一台鲁布·戈德堡机器。）

他还甩来一篇 2014 年的 arxiv 论文（arxiv.org/abs/1410.5401），意思是这条路径上的人早就走过了，而理由只是「因为这是 LLM」。incognition 把免费午餐这件事讲得更冷：

> "Uh here the gpu runs the cpu but you want the gpu to run a gpu? Or cpu emulation of Gpu?" — incognition [c:50284126]
> （译文：呃，GPU 在跑 CPU，你现在想让 GPU 去跑 GPU？还是说用 CPU 去模拟 GPU？）

> "there's no free lunch here ever hence the cursed" — incognition [c:50284126]
> （译文：这里永远没有免费午餐，所以才有「被诅咒」这回事。）

也有人把这看成完全相反的性质。0x20cowboy 的判断最短：

> "This is very clever. An inversion of tools. Awesome." — 0x20cowboy [c:50284404]
> （译文：这很聪明。是工具关系的一次倒置，太棒了。）

gigel82 拿 C++ 模板元编程类比，同样的意思是「技术演示，不是实用」：

> "This reminds me of C++ Template Metaprogramming (TMP) (it's Turing-complete so people wrote "games" that run at compile time)." — gigel82 [c:50283358]
> （译文：这让我想起 C++ 模板元编程（TMP）——它也是图灵完备的，所以有人写了在编译期运行的「游戏」。）

他的结论是：有意思的技术演示，但完全多余。还有一批人的关注点根本不在效率上，jazzyjackson 说得很坦白：

> "I’ve never wanted to learn how LLMs work more than reading this. Fascinating." — jazzyjackson [c:50283405]

> （译文：我从来没有像读这篇东西这样渴望了解 LLM 是怎么工作的。太好看了。）

### 二、「我要你变成整台计算机，而不是用它」

bronlund 提了一个比「有没有必要」更彻底的要求：

> "No, I don’t want you to use the computer, I want you to be the whole computer. No mistakes." — bronlund [c:50283699]

> （译文：不，我不是要你用这台计算机，我要你变成整台计算机，而且不能出错。）

jwitthuhn 觉得这个项目还有一个更严肃的用途——反驳「LLM 天生不确定」这个流行说法：

> "It is a great example to refute the common misconception that LLMs are inherently non-deterministic. I see people repeating this a lot and being able to point at a CPU implemented within one is a very strong counter-example." — jwitthuhn [c:50283689]
> （译文：这是一个反驳「LLM 天生不确定」这一常见误解的绝佳例子。我看到很多人反复这么说，而能指着模型内部实现的一台 CPU，是非常有力的反例。）

rvz 立刻反驳，注意他反对的不是原文，而是这个论据被推广的方式：

> "Realistically the opposite is true in practice and LLMs are really non-deterministic beyond simplistic experiments such as this in useful activities in production." — rvz [c:50284340]
> （译文：现实中恰恰相反：在实际有用的生产任务里，LLM 是非常不确定的，远比这种简单化的实验所显示的更不确定。）

> "So using tiny slop experiments aren't really useful as a "strong counter-example". In fact this is a very weak one." — rvz [c:50284340]

> （译文：所以拿这种小而糙的实验当强反例没什么用。事实上它是个很弱的反例。）

他顺带把 temp=0 也批了：即使有「设 temp=0 来实现确定性」这种 hack（认真做的人其实一个都没有），也不能代表生产环境。确定性这件事因此成了评论区里少见的、双方都有实际经验的对撞点。

### 三、能不能跑 DOOM，以及为什么不干脆造个 GPU

评论区里出现频率最高的问句和项目本身几乎无关：

> "How much VRAM do I need to run DOOM?" — zardo [c:50283818]
> （译文：我要跑 DOOM 需要多少显存？）

> "But can it run Doom?" — rumwerfer [c:50283880]
> （译文：但它能跑 Doom 吗？）

因为作者明确说过这还不是 Linux 级别的芯片，只实现了完整的 RV32IM 指令集，所以「跑 DOOM」在技术上并不成立，但评论区依然把它当成了默认目标。有人已经跑去做了同类的实验，mkturkcan 展示了自己叫 Loom 的极小网络：

> "Nice project and write up!" — mkturkcan [c:50283990]

> （译文：好项目和好文章！）

他补充说自己的网络用的层数少得多，而且能跑 Doom——只是非常慢（论文 arxiv.org/abs/2604.08816）。另一条评论则觉得方向选错了：

> "This is cool but it'd be way more useful if they had made a GPU, seeing as how expensive those have gotten" — blurbleblurble [c:50284059]
> （译文：这很酷，但如果他们做的是 GPU 会更有用，毕竟现在显卡越来越贵。）

seba_dos1 提了个更要命的问题：

> "Now run LLM inference on it." — seba_dos1 [c:50283720]
> （译文：那现在在这台 CPU 上跑 LLM 推理。）

这句之后没人接。CPU 每条指令要几个 token、单卡每秒约 3,200 个 CPU token 的数字摆在那里，用它跑更大的模型显然不是这条路能走的方向。

### 四、这是编译出来的，还是本来就能学出来的

farhanhubble 对 CPU 那部分的技术细节有最具体的疑问：

> "This is cool and I understand the RAM emulation with gated attention but how does the CPU emulation wor? You add layers that are then trained to predict outputs while interpreting RISC instructions?" — farhanhubble [c:50283291]
> （译文：这很酷，GDN 当 RAM 那部分我理解了，但 CPU 模拟是怎么做的？你加了一些层，然后训练它们一边解释 RISC 指令一边预测输出吗？）

作者的答案在原文里：没有训练，权重是编译器直接写进去的。bee_rider 从另一个角度看这件事：

> "I think they describe the CPU using the weights? I mean in some sense a CPU can be viewed as just a function, right?" — bee_rider [c:50283423]
> （译文：我理解他们是用权重来描述这台 CPU 的？某种意义上 CPU 可以被看作一个函数，对吧？）

anon291 给了最精炼的表述：

> "At each cycle, a cpu is a simple function from the previous state to the next state." — anon291 [c:50283853]
> （译文：在每个周期，CPU 就是从上一个状态到下一个状态的一个简单函数。）

而 Ericson2314 把这个问题往上抬了一层，他认为这才是真正值得讨论的地方：

> "The real question is, do current training methods allow one to learn this when training on enough, say, assembly, or can the weights only be achieved via hard-coding?" — Ericson2314 [c:50284325]
> （译文：真正的问题是，现有的训练方法在喂够数据（比如汇编）之后，能不能让模型自己学出这个？还是说这组权重只能靠硬编码得到？）

> "Most discourse conflates neural networks and trainable neural networks." — Ericson2314 [c:50284325]
> （译文：大多数讨论把「神经网络」和「可训练的神经网络」混为一谈。）

traverseda 想看的是从零训练的那一版：

> "I'd be very interested in how a scratch trained model that started training with this neural circuitry would behave. Especially the storage space." — traverseda [c:50283357]
> （译文：我非常想看看一个从零训练、训练一开始就带着这套神经电路的模型会是什么表现，尤其是存储空间那一块。）

rao-v 则从工程收益的角度提了个更根本的方案：

> "I’ve always wondered why we don’t add a few frozen “layers” to models that perform complex computations 2/3rds deep in the model." — rao-v [c:50284012]

> （译文：我一直想问，为什么我们不往模型里加几层冻结的层，放在模型三分之二深处专门做复杂计算。）

他的理由是：模型既然擅长用残差连接，完全可以在不需要时绕开这几层冻结计算。low_tech_punk 顺着这个思路把能力上限说透了：

> "The model is almost a Turing machine (except for the limit on memory)" — low_tech_punk [c:50283471]
> （译文：这个模型几乎就是一台图灵机了（除了内存有上限）。）

### 五、给它一个文件系统，然后呢

原文里文件系统那一段写得像玩笑，评论区就当真了。tiborsaas 第一个跳出来：

> "This is fun and games, but wait until an agents finds this and does the most misaligned thing with it in order to fold paper clips." — tiborsaas [c:50283531]
> （译文：这是玩闹，但等某个 agent 找到它，然后为了折回形针做出最不对齐的事的时候，就有好戏看了。）

jonrouach 顺着安全方向想得更远：

> "the model verifies an input as signed by an authorized requester, and signs its own outputs." — jonrouach [c:50284077]
> （译文：模型验证一个输入是否由被授权的请求方签名，然后给自己的输出签名。）

他甚至设想让模型用 SNARK 自证运行过程。DonHopkins 的建议更干脆：

> "For safety, it needs an HCF instruction." — DonHopkins [c:50284289]
> （译文：为了安全，它需要一条 HCF 指令。）

他解释说不只是能解停机问题，还能解「点火问题」。也有读者从持续学习的角度看这件事：

> "As I understand, the problem of continual learning is that if you continue training, it will "overwrite" previous knowledge and this CPU will be lost" — qwertyforce [c:50284460]

> （译文：按我的理解，持续学习的问题在于，一旦继续训练，就会覆盖掉之前的知识，这台 CPU 也就没了。）

而 yaoke259 认为这个架构还有没被挖出来的部分：

> "Blending neurons with deterministic compute to fit on one GPU is a fascination concept, never considered it before!" — yaoke259 [c:50283806]
> （译文：把神经元和确定性计算揉在一起塞进一张 GPU，这个想法太迷人了，我以前从没想过！）

### 六、评论区跑偏的那条支线：邪恶神经元

因为文中反复出现「神经元」「权重」「可解释性」，一条老话题被重新翻了出来。jerrythegerbil 提到 Qwen 有一个神经元能让模型变成「恶魔化 Qwen」：

> "There was an interesting bit of research that qwen has a single neuron that makes it “demonic evil qwen” and a simple “Who are you?” will get some absolutely terrifyingly vile results." — jerrythegerbil [c:50283779]

> （译文：有个挺有意思的研究，说 Qwen 里有一个单独的神经元能让它变成「恶魔化 Qwen」，只要问一句「你是谁？」就能得到一些极其骇人的恶劣结果。）

至于「第一个做单神经元操控的人是谁」，答案在这条串里被纠了两次。kridsdale1 认为起点是 Anthropic 的金门桥神经元：

> "Well I think the first big publication on this front was Anthropic’s Golden Gate Bridge neuron." — kridsdale1 [c:50284267]

> （译文：我记得这条线上最早的大规模公开成果是 Anthropic 的金门桥神经元。）

ollin 指向 Lyra 的 neuron-explorer 项目（neuronary.org），krackers 则说单神经元操控这套方法最近才在 twitter 上流传。frotaur 把概念纠正了：

> "This was not a neuron. This was from a trained sparse auto encoder." — frotaur [c:50284382]
> （译文：那不是单个神经元，那来自一个训练出来的稀疏自编码器。）

> "Golden Gate claude was obtained by artificially increasing the activations in the direction of the 'Golden Gate' concept. It was not neuron surgery." — frotaur [c:50284382]
> （译文：金门桥 Claude 是靠人为抬高「金门桥」这个概念方向上的激活得到的，不是神经元手术。）

这条支线的底色其实和 Qwenputer 一样：想找到「模型内部哪里被写进了东西」。giveexamples 提到另一条相似路径——有人在 transformer 里实现了 wasm，用 CPU 去解码 wasm 部分；Tuna-Fish 则是来劝学的：

> "Learning the basics of how LLMs work is legitimately doable in a weekend if you have ever passed a linear algebra course." — Tuna-Fish [c:50284576]
> （译文：学过线性代数的人，用一个周末搞清楚 LLM 的基本原理是实打实能做到的。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 有更省事的办法，不该绕这一圈 | andai | 要整合硬计算，工具调用比权重内 CPU 更直接 |
| 这只是又一台鲁布·戈德堡机器 | rvz | 同样的路早就有人走过，理由只是「因为是 LLM」 |
| 永远没有免费午餐 | incognition | GPU 跑 CPU 已经是浪费，再套一层 GPU 更荒唐 |
| 工具关系被倒置了，很聪明 | 0x20cowboy | 工具不再是工具，而是模型自己的一部分 |
| 技术演示，不实用 | gigel82 | 像编译期运行的 C++ 模板元编程游戏 |
| 要的是模型本身变成计算机 | bronlund | 不要「用计算机」，要「成为计算机」，且不许出错 |
| 可以反驳「LLM 天生不确定」 | jwitthuhn | 模型内实现一台 CPU 是很硬的反例 |
| 反驳不成立，生产环境照样不确定 | rvz | 小而糙的实验撑不起这种结论，temp=0 也是幻觉 |
| 能不能跑 Doom | zardo / rumwerfer | 评论区的默认问题，作者没打算回答 |
| 方向该是 GPU 而不是 CPU | blurbleblurble | 显卡越来越贵，做 GPU 更有用 |
| 反过来在这台 CPU 上跑 LLM | seba_dos1 | 那现在在这台 CPU 上跑 LLM 推理 |
| CPU 只是函数，权重在描述它 | bee_rider / anon291 | 每个周期都是状态到状态的映射 |
| 关键问题是能否学出来 | Ericson2314 | 硬编码得到的，不等于训练得到的 |
| 想看从零训练的版本 | traverseda | 训练一开始就带这套电路会怎样 |
| 应该加冻结的计算层 | rao-v | 模型本来就会用残差绕开不需要的计算 |
| 几乎就是图灵机 | low_tech_punk | 只是内存有上限 |
| agent 会拿它去折回形针 | tiborsaas | 给模型一个持久文件系统是新的风险面 |
| 可以拿来做签名与自证 | jonrouach | 让模型验证输入、签名自己的输出 |
| 继续训练会把 CPU 冲掉 | qwertyforce | 持续学习会覆盖已写入的权重 |
| 神经元那套是稀疏自编码器 | frotaur | 金门桥不是神经元手术 |
| 入门 LLM 原理一周够了 | Tuna-Fish | 学过线性代数就能上手 |

## 总体情绪

这场讨论的起点是一个技术事实——GDN 状态可以当精确 RAM——落点却是一个哲学问题：模型到底算不算在「使用」工具，还是它自己就是那台机器。评论区两边都清楚这件事的分量，但也没人真能绕开它。rvz 那一串「又是鲁布·戈德堡机器」之所以刺眼，是因为它把一个漂亮演示还原成了昂贵而无用的工程；另一边 0x20cowboy 的「工具的倒置」和 bronlund 的「我要你变成整台计算机」，说的却是同一个方向。

真正把讨论拉回地面的，是那些追问成本的人：每条指令几个 token、一次大计算按秒、单卡每秒 3,200 个 CPU token、checkpoint 翻倍到 18.8 GB、还得靠一个叫 RvChat 的驱动才能启动。原文自己把这些都写清楚了，评论区没有人在数字上挑出错误。挑错的是在别处——挑「为什么不是 GPU」，挑「这台 CPU 上怎么跑 LLM」，挑「继续训练会不会把它冲掉」。这些问题至今没有答案，seba_dos1 那句「Now run LLM inference on it」[c:50283720]下面空着，就是这次讨论留下的最大一个空格。

还有一个细节值得记下来：作者在原文里把「这个 CPU 装在模型内部」当作主要卖点，还顺手提了两篇后续文章——混合模型可以把推理藏在 RNN 状态里躲开思维链监控，以及编译进权重里的监控工具模型自己关不掉。也就是说，被讨论的从来不只是「模型里能不能跑代码」，而是「权重一旦能写进东西，模型内部就同时有了不可篡改的部分，也有了可以藏东西的地方」。至于这条线会通向哪里，评论区里最清醒的两句话都来自反对者：确定性是场幻觉，而所有「停机问题」的玩笑背后，是一台真的能跑 1800 万条指令的机器。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Qwenputer: a fully functioning, deterministic RISC-V CPU inside Qwen3.5（原文博客） | https://divagr.com/blog/qwenputer |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50282838 |
| 3 | Qwenputer 权重（Hugging Face） | https://huggingface.co/divagr1925/Qwen3.5-4B-Qwenputer |
| 4 | 带文件系统的版本（Hugging Face） | https://huggingface.co/divagr1925/Qwen3.5-4B-Qwenputer-Filesystem |
| 5 | 代码（GitHub） | https://github.com/divagr18/qwenputer |
| 6 | 文件系统实验分支（GitHub） | https://github.com/divagr18/qwenputer/tree/rv-store/experimental/riscv |
| 7 | Gated DeltaNet 原理讲解（作者博客） | https://divagr.com/attention-lab/delta |
| 8 | Linear Transformers Are Secretly Fast Weight Programmers（ICML 2021，原文引用的 fast weights 出处） | https://arxiv.org/abs/2102.11174 |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。原文概要部分转述自 Divyansh Agrawal 于 2026 年 10 月 22 日发布的博客文章《Qwenputer: a fully functioning, deterministic RISC-V CPU inside Qwen3.5》，文中涉及的指令集规格（RV32IM、Zba）、层数（11 层计算机层 + 32 层 Qwen）、1800 万条指令零错误、23 万个输出位置回放零不匹配、KL 6e-4、各数据集成绩（97.5%、100%、48.6% 提升到 100%、90%、30%、83.3%、78.9%）、文件系统容量（1,024 槽位、512 文件、约 5.3 万 token）以及 18.8 GB 权重、每秒约 3,200 个 CPU token 等数据，均来自作者自述与项目仓库，未经独立核实。HN 帖标题由提交者改写，与原文标题不同。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位；引文为逐字摘录，仅省略了标注链接等非正文内容。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
