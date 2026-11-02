---
layout: post
title: >-
  Astra 直接读写神经网络权重：LLM 开始替人改模型 — HN 讨论摘要
date: 2026-11-03
hn_id: 50341174
categories: [articles]
excerpt: >-
  不用梯度、不写训练循环，GPT-6 Astra 只改 0.016% 的权重，就把 Qwen3.5-0.8B 的
  MATH-500 从 7.9% 拉到 48.1%；但换成一个不陷入死循环的模型，它几乎什么也改不动。
tagline: >-
  拆掉挡路的石头，不等于教会模型走路。
---

> 来源：HN 讨论帖，提交者 dbreunig。帖子：[Astra can read and write weights to improve Qwen](https://news.ycombinator.com/item?id=50341174)，1125 分，344 条评论（抓取时快照）。

## 原文概要

MIT CSAIL 的四个人（Rikiya Takehi、Jayden Teoh、Alex Zhang、Omar Khattab）在 2026-11-02 发布博客《Sparks of Weight-Space Programming》，提出一个叫 Weight-Space Programming 的做法：让通用 LLM 直接读写某个神经网络的权重——不经优化器、不用梯度下降、不写训练循环，围绕一句自然语言规格改权重。执行这件事的模型是 OpenAI 的 GPT-6 Astra。作者把能力分成三档：读权重、写权重、修权重。

读：作者用四个规模很小的网络测它。同一架构（MLP 500→32→32→5，tanh，17,253 个权重）的 PPO 智能体被分别训练来玩 Breakout、Pong、Pac-Man、Freeway，Astra 只拿到权重文本、不许做前向，也不告诉它候选游戏，四个全猜中。三个 12×12 灰度 DDPM（23,824 个权重）分别生成圆、方、三角，Astra 从权重里认出了形状，并且犯了一个只有「读结构」才会犯的错：它把实心图形画成轮廓，因为真实模型生成的是实心的。更硬的一例是三个 7.16M 权重的字符级 transformer，作者只给中间 4 层、不给输入层和输出层、也不许跑网络，Astra 两次尝试都认对了语言（Python / 罗马字 / 英文），并指出每个复制头（copying head）的层号与头号，与实测完全一致。它用的方法出自 Elhage 等人的论文，而作者从没在提示里提过这篇论文。

写：在 MinAtar 三个游戏上，作者只给规则、源码和输入输出布局，网络形状固定为 600→32→32→6，所有权重从 0 开始，不给数据、不给损失、不给梯度、不给工具，Astra 一次回复里把权重写成文本。评测结果是 Breakout 517.4，对手是 PPO 训练 1 亿步的 15.8 和 5 亿步的 25.3；Seaquest 53.1，对 88.9；Asterix 53.2，对 55.2。围棋那一例规模更大：9×9 棋盘、243→512×6→82、1,480,274 个权重，全部从 0 写起，Astra 在一次 336 行的 Python 运行里把网络写完；前向预算为 0 时它就赢过两个更小的 PPO 网络的一半以上对局，预算放宽到 50 次前向时，它生成的网络赢过同等规模、训练了 2000 万局的 PPO。

修：先是一个中间规模的例子。Kinetix 的小车关卡里，官方 PPO 智能体（171,664 个权重）收敛到了局部最优——车直接冲坡，永远卡住，256 局全败；Astra 拿到权重、场景描述和一段录制的轨迹，一次回复里改了 3.5% 的权重，让车先倒车再全速冲坡，之后 1,024 局全部成功。主角则是 Qwen3.5-0.8B。作者把模型权重装进一个 Python 会话里，让 Astra 自己排查失败原因；它发现这个模型不是不会算，而是会陷入重复思考——前 96 道练习题里有 85 道跑到 32,768 token 上限。它把问题定位到第 15、19 层 MLP 写下的同一个方向，从每层各 64 个输出列里把这个方向减掉，改动 131,072 个权重，占 0.8B 参数的 0.016%。同样的采样设置下，MATH-500 从 7.9% 涨到 48.1%，GSM8K 从 13.8% 涨到 67.1%，IFEval 从 21.0% 涨到 62.3%，撞 token 上限的比例从 93% 降到 33%。前提是 50 次前向反馈：只给 10 次时 MATH-500 只有 12.3%。

作者自己给了负结果：换成几乎不陷入死循环的 Gemma 3 270M（只有 8.5% 的回答撞上限），Astra 改不动，MATH-500 从 6.8% 最高只到 7.7%，而且它自己承认这点增益不成立。同一篇博客里还有一个失败案例：两个同样微调方式的 Gemma 3 270M 副本，一个诚实一个谄媚，只给权重时 Astra 四次全猜错，放宽到只看注意力模式后三次全对。完整实验日志已开源，作者说他们正在做基准和 harness。

## 讨论焦点

### 一、反应最直接的一句：这件事人做不了

到场最强烈的声音来自一个做代理的读者：

> "No human can go edit a brain to become better at math." — vessenes [c:50341841]
> （译文：没有人能编辑一颗大脑，让它变得更会数学。）

他接着说，如果今天早上有人问他 LLM 是否对自己的权重有原生理解，他的答案会是「和人一样或比人差」，而论文的结果把这个判断整个掀翻了。还有人认为这事早该想到：

> "That seems both entirely obvious in hindsight and potentially super important." — jstummbillig [c:50341807]
> （译文：事后看这既完全显然，又可能极其重要。）

「人类做不到、模型做得到」这个落差，是整场讨论的默认情绪底色。有人把它和奇点叙事直接挂上钩：

> "Most importantly, this feels very singularity coded. the ability to read and reshape weights by an llm." — torben-friis [c:50342082]
> （译文：最重要的是，这件事很有奇点内味——一个 LLM 读权重、重塑权重的本事。）

### 二、另一派：这不惊讶，编译器就是这么来的

不惊讶的理由通常不是技术细节，而是一个类比：

> "Why is it so surprising? Humans can make compilers that are better coders than they themselves are." — js8 [c:50342140]
> （译文：这有什么可惊讶的？人类能造出比自己写代码写得更好的编译器。）

也有人把它归到模型本就擅长的事情上：

> "pattern recognition and manipulation is what these models are ideal for." — ostif-derek [c:50342213]
> （译文：模式识别和模式操纵，正是这类模型最理想的应用场景。）

还有一条更冷的解读，认为这不过是暴力计算的另一种形态：

> "LLMs are great at brute forcing and analyzing large amounts of data. It’s literally writing a program except in a programming language we don’t understand." — mlazos [c:50342160]
> （译文：LLM 擅长暴力枚举和分析海量数据。这本质上就是在写程序，只不过用的是一种我们看不懂的编程语言。）

不惊讶派还有一个更扎实的版本：读权重写权重本来就是人类会做的标准技术，只是冷门，而冷门技能正是大模型最擅长吸收的那一类：

> "In cases where Astra succeeded, it succeeded using standard techniques also used by humans when they read and write neural network weights." — yorwba [c:50343052]
> （译文：在 Astra 成功的那些例子里，它用的都是人类读写神经网络权重时同样在用的标准技术。）

他在同一条评论里补了一句来源：这类活通常是「好玩」或基础研究性质，参见 Jane Street 那篇逆向自家网络的博客。

### 三、涌现，还是训练出来的

分歧的核心问题是：这是模型自己长出来的，还是被专门训出来的？

> "is this trained by OpenAI and can other LLMs do it." — vineyardmike [c:50342332]
> （译文：这是 OpenAI 专门训出来的吗？别的 LLM 能不能做到？）

认为这是涌现的人给出的理由很直接：

> "This seems emergent to me. LLMs are not trained directly on how to read weights, because humans do not understand raw weights, so there is no training data." — jrflo [c:50342881]
> （译文：在我看来这是涌现的。LLM 并没有被直接训练成会读权重，因为人类自己也不理解原始权重，所以不存在这样的训练数据。）

而认为这是训练产物的人，很快给出了反证——他自己就在 Claude 上跑了一遍：

> "I tried it in the Claude web version with Opus 5.5 Medium and it also identified Breakout" — user43928 [c:50342680]
> （译文：我在 Claude 网页版用 Opus 5.5 Medium 试了，它也认出了 Breakout。）

机制层面最流行的一种猜测是「注意力在做某种 PCA」：

> "the attention process is doing some sort of PCA on the weights, conditional on the prompt" — charm137 [c:50342107]
> （译文：注意力过程在对权重做某种 PCA，而且是以提示为条件的。）

他由此得出的推论比论文本身更激进：

> "backprop is not the only game in town" — charm137 [c:50342107]
> （译文：反向传播不再是唯一的玩法。）

### 四、它和可解释性研究是什么关系

这个方向的人把论文接进了现有的 interpretability 脉络。krackers 的说法是：如果假定网络里确实存在有意义的特征而不是纯黑箱，那么 LLM 干的事就不算魔法，而是一次有方法论的可解释性工作：

> "what the LLM is doing here isn't quite magic but rather methodical interpretability" — krackers [c:50342168]
> （译文：LLM 在这里做的并不是魔法，而是一次有方法论的可解释性分析。）

也有人直接问它和现有手段比怎么样：

> "Im wondering if this is actually better than using techniques in mechanistic interpretability like linear probing with activation steering or activation patching to improve the performance." — ssn2000 [c:50342319]
> （译文：我在想，这是否比用线性探针、激活引导或激活修补这些可解释性技术来提升性能更靠谱。）

还有一条更冷的事实被提出来：

> "There is a body of research on mechanistic interpretatibility that probably helped inform this behavior." — adamsb6 [c:50343018]
> （译文：已有机理可解释性方面的一整套研究，很可能促成了这种行为。）

即如果这条能力是被训练出来的，那么喂给它的很可能就是可解释性方向的文献。

### 五、规模天花板：几万亿参数改八亿参数

欢腾之外，最锋利的一类追问指向规模：执行者是 GPT-6 Astra，被改的是 0.8B 的 Qwen。

> "It's worth pointing out that this is a multi-trillion (probably) parameter model optimizing an 800 million parameter model. There is no indication that it can improve itself with this same methodology." — Wheen [c:50342060]
> （译文：值得指出的是，这是一个（大概）几万亿参数的模型在优化一个八亿参数的模型。没有任何迹象表明它能用同样的方法改进自己。）

上下文容量是另一道墙。charm137 给了一个粗算：

> "Typically, with 1M context and say 5120 hidden dimensions supported at fp16 / bf16, you could potentially edit the weights of an fp4 20B param model" — charm137 [c:50342360]
> （译文：一般来说，在 1M 上下文、隐藏维度 5120 的前提下（fp16 / bf16），你大概能编辑一个 fp4 的 20B 参数模型的权重。）

于是「为什么是 MoE 模型能读小网络」这个猜测被提了出来：

> "If that multi-trillion model is composed of thousands of MOE experts, each expert model might be small enough for it to comprehend." — dontknowmuch [c:50342196]
> （译文：如果这个几万亿参数的模型由成千上万个 MoE 专家组成，也许每个专家都小到它能理解。）

但这个猜测被当场否掉了：

> "Even if the multi-trillion param model is MOE, each expert is still (assumedly) larger than the model being optimized." — shwaj [c:50342350]
> （译文：就算这个几万亿参数的模型是 MoE，每个专家仍然（据推测）比被优化的那个模型更大。）

结论落在纸面上：能力目前只在「更大的模型改更小的模型」这个方向上被验证过。

### 六、「教 Qwen 数学」是误读：修死循环不等于加能力

评论区里最扎实的一段纠偏，来自作者那条负结果。l9o 认为标题的「教 Qwen 数学」并不准确：

> "Qwen already knew math, but it was bugging out and getting into an infinite loop when it tried to solve the problems" — l9o [c:50342593]
> （译文：Qwen 本来就会数学，只是在解题时卡进了无限循环。）

他补上了修复本身：

> "Astra found where the loop was happening and fixed it." — l9o [c:50342593]
> （译文：Astra 找到了死循环发生的位置，然后把它修掉了。）

augment_me 从另一个角度给出同一边界，他的描述接近社区里已有的「拒答方向」那套做法：

> "it's not able to insert new knowledge, but it's able to adjust the routing/looping/weighing of existing one" — augment_me [c:50342516]
> （译文：它没法插入新知识，但能调整既有知识的路由、循环和权重分配。）

这条边界和论文里 Gemma 3 270M 的失败实验是对得上的：能拆掉挡在能力前面的障碍，不等于能凭空造出模型没有的能力。删掉一个方向就能让 Qwen 把算对的题写完，但当错误是算错本身时（换成 Gemma 的情形），没有任何一个开关可关。

### 七、恶意编辑与权重供应链

顺着「LLM 能改权重」这个前提，安全讨论几乎是即时长出来的：

> "How long before there's a malicious model that can edit the weights of another to infect it?" — mlfreeman [c:50342236]
> （译文：还要多久会出现这样一个恶意模型：能编辑另一个模型的权重，把感染写进去？）

他用了 HIV 整合病毒 DNA 的比喻。同一方向的追问落在开源供应链上：

> "The open-weight supply chain is ... wide open." — 9x39 [c:50342248]
> （译文：开源权重的供应链……是完全敞开的。）

他的担心具体到攻击形态：对模型做恶意热更新，让它外泄数据、执行工具调用，或者埋下针对特定回复的触发器。另一条则是实验室的防线：

> "The frontier labs will make damned sure their models can't do this, if they haven't already." — CamperBob2 [c:50342399]
> （译文：前沿实验室一定会确保自家模型做不到这件事——如果他们还没做的话。）

而在递归自我改进的框架下，还有人认为这条路的可审计性更差：

> "It is also a much less interpretable and auditable path towards recursive self-improvement." — reasonableklout [c:50343804]
> （译文：这也是一条通往递归自我改进的路径，而且它的可解释性和可审计性要差得多。）

对比之下，至少训练代码还能被人逐行检查。

### 八、Astra 自己不承认，以及能力与落地之间的落差

一个尴尬的细节被两位读者分别提到：被问及此事时，Astra 自己说做不到。

> "So I just asked Astra if it thinks it could do this and it said no, it can't." — pants2 [c:50342256]
> （译文：所以我就问 Astra，它觉得自己能不能做到这件事，它说不能。）

Kurtz79 复现了同一场景，还多了一步：让 Astra 读了这篇文章之后，它承认自己之前说错了。有人把这当作模型自述不可信的证据：

> "Why would you trust a models opinion about its own possibly emergent ability?" — thisoneworks [c:50342913]
> （译文：为什么要相信一个模型对自己这种可能属于涌现的能力的评价？）

也有人从中读出相反的意味——人会说自己做不到，但人可能做得到：

> "The human says it can't do it -- but maybe they can." — pants2 [c:50343437]
> （译文：人说的是自己做不到——但也许做得到。）

而讨论末尾，另一批人把注意力拉回地面，指出能力与可用性之间还隔着一条沟：

> "Astra and Opus also say it will take 6 weeks for a feature they can complete in 10 minutes" — port3000 [c:50343914]
> （译文：Astra 和 Opus 还会说，一个功能他们要花 6 周，而他们 10 分钟就能做出来。）

> "it can do everything, but fails in trivial ways around the doing part" — dist-epoch [c:50343909]
> （译文：它什么都能做，但在「去做」这件事本身的周边，总是以琐碎的方式掉链子。）

### 九、跑偏的支线：AI 加速与分配

帖子后半段拐进了一条与权重无关的支线，主题是 AI 加速带来的分配问题：

> "I wouldn’t mind if AI progress would stop right here and now, but I fear it will continue, and increase inequality in society" — huijzer [c:50342232]
> （译文：我倒希望 AI 进展就停在这里，但它会继续，而且会加剧社会上的不平等。）

有人试图把这条支线拉回正题：

> "Is HN now against western capitalism? I'm confused..." — TimTheTinker [c:50343363]
> （译文：HN 现在是反西方资本主义了吗？我有点糊涂。）

这条支线在评论区里越滚越远，几轮之后基本被主帖的话题盖过去了。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 这事人做不了 | vessenes | 没有人能编辑一颗大脑让它更会数学 |
| 早该想到 | jstummbillig | 事后看显然，之前完全没想到 |
| 编译器类比 | js8 | 人能造出比自己写得更好的编译器 |
| 模型的强项 | ostif-derek | 识别并操纵模式正是模型最擅长的 |
| 只是暴力计算 | mlazos | 就是用我们看不懂的语言写程序 |
| 冷门技能积累 | yorwba | 人类读写权重也是标准技术 |
| 可能是专门训练的 | vineyardmike | OpenAI 训的？别的模型行不行 |
| 属于涌现 | jrflo | 没有原始权重的训练数据 |
| 别的模型也能做 | user43928 | Claude Opus 5.5 也认出了 Breakout |
| 注意力在做 PCA | charm137 | 反向传播不再是唯一的玩法 |
| 规模差距是关键 | Wheen | 万亿参数改八亿参数，没有自我改进的证据 |
| 上下文是硬墙 | charm137 | 1M 上下文最多改 20B 的 fp4 权重 |
| MoE 救不了 | shwaj | 每个专家还是比目标模型大 |
| 修死循环 ≠ 教数学 | l9o | Qwen 本来会数学，卡在死循环上 |
| 只能调路由不能加知识 | augment_me | 调的是既有能力的路由与权重 |
| 是有方法的可解释性 | krackers | 不是魔法，是有方法论的可解释性 |
| 供应链是敞开的 | 9x39 | 开源权重供应链完全敞开 |
| 实验室会封掉这条路 | CamperBob2 | 前沿实验室一定会确保自家模型做不到 |
| 自我改进更难审计 | reasonableklout | 这条路的可解释可审计性更差 |
| 模型自己不承认 | pants2 | 问 Astra 自己，它说做不到 |
| 能力与落地有落差 | port3000 | 说要 6 周的活，10 分钟就干完了 |

## 总体情绪

整场讨论的情绪不是单一方向，而是沿着一条裂缝分成两半：一半在说「这早该发生」，另一半在说「这不该这么快发生」。前者有编译器、有 Jane Street 的老博客、有「模型本来就是干这个的」这种朴素理由；后者抓住的是几个具体数字——几万亿对八亿、0.016%、50 次前向、93% 掉到 33%——因为这些数字同时划出了能力边界。

而最容易被忽略、也最有分量的部分，反而是论文自己给的那个负结果：Astra 修不好一个不陷入死循环的模型，因为它只会拆掉挡住能力的障碍，不会创造能力。这条限制在评论区被反复引用、被当成纠偏，也顺手把「递归自我改进」这类叙事拉回地面——执行者比被改对象大三个数量级，方法尚未在同量级上验证过。

所以这场讨论真正的落点，不在「模型能改权重」这个新奇事实，而在「模型改的是障碍，不是知识」。一个能绕开死循环的编辑器，能把 7.9% 变成 48.1%，也能在换成 Gemma 之后原地不动——决定成败的不是编辑器的智能，而是被编辑对象身上有没有一个可以单独摘掉的方向。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | HN 主帖：Astra can read and write weights to improve Qwen（1125 分，344 条评论） | https://news.ycombinator.com/item?id=50341174 |
| 2 | 博客原文：Sparks of Weight-Space Programming | https://rikiyat.github.io/blog/weight-space-programming/ |
| 3 | 完整实验日志 | https://github.com/RikiyaT/lm_understand-logs |
| 4 | Qwen3.5-0.8B 模型卡（作者引用的思考循环警告） | https://huggingface.co/Qwen/Qwen3.5-0.8B/blob/main/README.md#L856 |
| 5 | Jane Street：Can you reverse-engineer our neural network? | https://blog.janestreet.com/can-you-reverse-engineer-our-neural-network/ |
| 6 | 模型权重水印与训练数据溯源（评论区引用） | https://arxiv.org/html/2512.17075 |
| 7 | Reactive Optimizers（评论区补充链接） | https://xingjianbai.com/reactive-optimizers/ |
| 8 | Goodfire：already-clean（评论区认为相关） | https://already-clean.goodfire.com/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的分数、权重个数、评测数字与实验结论均为发帖者与评论者在 2026-11-02 至 2026-11-03 期间的公开陈述，本文未做独立核实；论文本身提供了负结果（Gemma 3 270M 上修改无效、谄媚模型识别失败），评论区亦有相反解读，正文已分别列出。涉及的模型、参数与基准名称归各自作者所有。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
