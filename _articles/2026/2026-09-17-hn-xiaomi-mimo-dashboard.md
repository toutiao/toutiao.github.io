---
layout: post
title: >-
  小米 MiMo 训练仪表盘全球直播 — HN 讨论摘要
date: 2026-09-17
hn_id: 49732270
categories: [articles]
excerpt: >-
  小米把 MiMo 2.6 的训练进度条、benchmark 分数、训练成本和训练数据构成（66% 源码）全挂上公网。301 分冲到 HN 热门榜后, 评论区争议集中在两点: 边训练边跑分算不算数据污染, 以及中美实验室在开放度上的差距到底有多大。
tagline: >-
  小米的训练进度条全网直播, Anthropic 还在念 frontier 故事。
---

## 原文概要

来源：[HN 热门榜](https://news.ycombinator.com/item?id=49732270)（301 分, 75 条评论）, 项目地址 [mimo.xiaomi.com/rl](https://mimo.xiaomi.com/rl/)。这是小米 MiMo 团队在 2026 年 9 月 16 日上线的一个**实时训练仪表盘**, 公开显示 MiMo 2.6 (含 Pro 和 Flash 两个变体) post-training RL 阶段的进展。

仪表盘的核心数据很具体。2.6 Pro 在 step 10 时 DeepSWE 1.1 分数已达 63.7%, 2.6 Flash 在 step 12 时达到 60.7%。评论区提供的 2.5 Pro 历史对照只有 19%, 同基准下 Fable 70%、Kimi K3 69%、Astra 74%——也就是说, 在公开可见的 RL 阶段, 2.6 Pro 已经接近 frontier 阵营。

训练数据的构成也被公开挂出来, 包括 RL 阶段"约 2/3 是源代码"。仪表盘页脚还印着一句品牌标语: "Open is what we value." 训练成本按秒计费, 一位用户读出来大约 5 美元/秒、约 43.2 万美元/天, "够在 Modal 上租 3000 块 B300 节点"。

文章发布时, 仪表盘仍在跑, 进度条、benchmark 曲线、训练重启事件都会同步刷新。HN 上线后很快冲到 301 分, 评论区核心问题不是技术, 而是"为什么是中国公司先把训练过程挂上网"。

## 讨论焦点

### 用过 MiMo 2.5 的人, ROI 评价两极

最长的一条支线（13 条回复）来自一位把 MiMo 2.5 当主力的开发者。原帖评价很高, 但反驳者也立刻出现。

> "I been using MiMo-V2.5 to do most of my work as software engineer, on a variety of projects I'm working on, and I been VERY happy with ROI. The model is very powerful! Not perfect – I've run in hallucination loops once or twice, but nothing a stop-then-continue wouldn't solve. The cost is unbelievably low, and the quality of intelligence I get is equivalent to when I was working mostly with Anthropic models (late last year/early this year)." — joelwallis [c:49732870]
>
> （译文: 我把 MiMo-V2.5 当主力, 干各种项目, ROI 非常满意。模型很强, 不完美——偶尔陷入幻觉循环, 但停一下再继续就能解决。成本低得离谱, 智能水平基本等同于我去年底/今年初主要用的 Anthropic 模型。）

补充里还把同价位选手都拉出来比了一圈——DS4F、DS41、GLM 5.3 Flash 都"不错", 但算上 M-token 成本, MiMo 还是领先一个数量级。

反对意见同样具体:

> "I've found that mimo v2.5 works for very basic things like a python script to do one thing, but it also is very 'dumb' compared to qwen 3.8-flash-next (I think the benchmark scores for terminal and coding specific benches back this up). And definitely not in the same class as like a GLM5.2 or 5.3. It's fast but makes basic mistakes that only get caught later." — walrus01 [c:49733124]
>
> （译文: 我觉得 mimo v2.5 只能干很基础的事——比如写个一次性 Python 脚本。它比 qwen 3.8-flash-next 笨得多（终端和编码专项 benchmark 也支撑这一点）。和 GLM 5.2 或 5.3 根本不在一个档次。速度是快, 但会犯那种要事后才发现的基础错。）

子线程里还有一条: MiMo v2.5 Pro Ultraspeed beta 跑到过 1000 tok/s, 用户希望 2.6 也能复现这种速度档位。

### 边训练边跑 benchmark, 算不算数据污染

第二条长支线（8 条回复）是关于方法学的。有人质疑: 仪表盘上实时显示的 DeepSWE 分数, 不就是拿 benchmark 当训练信号？这条线最后被压成两个工程实践的辩论。

> "When you run benchmarks while training, isn't that the definition of contamination? Asking because I am not sure if this is normal in big labs now." — liuliu [c:49732837]
>
> （译文: 训练中跑 benchmark, 这不就是污染的定义？我不太确定现在大厂是不是都这么干。）

回答分成两派。主流派说这是 RL 阶段的常规做法, 把 benchmark 当 validation 集合, 不直接喂给 loss:

> "Kinda yes. The benchmarks become part of the validation set, which means the models get slightly overfit to them if they are used as criteria for stopping the training. But a lot less compared to using them in the training data." — jampekka [c:49732943]
>
> （译文: 算是。benchmark 会变成验证集的一部分——如果用作停训判据, 模型会轻微过拟合。但比起把它们直接塞进训练数据, 程度要轻得多。）

> "They are using it to evaluate checkpoints during the training, they are probably not using the benchmarks for training the models. It's a common practice for big reinforcement learning runs." — lucrbvi [c:49732879]
>
> （译文: 他们在训练中拿 benchmark 评估 checkpoint, 大概率不会让 benchmark 进入训练 loss。大规模 RL run 的常见做法。）

另一派更悲观, 认为即便只是选 stopping criterion, 研究员反复调整参数 + 看 benchmark, 信息泄露就是隐性的:

> "It's implicitly trained against. There is like information leakage with researchers messing with the training parameters and checkpoints used. It's not the direct feedback loop of RL but its not far." — kingstnap [c:49733913]
>
> （译文: 这就是隐式地拿 benchmark 训。研究员反复调参和换 checkpoint, 信息泄露是存在的。不是 RL 那种直白的反馈回路, 但离得不远。）

有人顺势追到 2.6 的曲线: Pro step 10 = 63.7%, Flash step 12 = 60.7%——这种"训练中段已经超越 2.5-Pro 终态 19%"的轨迹, 多少是验证集导致的过拟合？讨论没给结论, 但把"训练透明"和"benchmark 透明"拆开成了两个问题。

### 中美实验室, 谁在写"open"这个字

另一条高赞支线（7 条回复）从这次公开动作直接跳到了实验室文化比较。

> "The Chinese labs are just making fun of the US labs at this point. Where is the cool shit from the US labs?" — impulser_ [c:49733211]
>
> （译文: 中国实验室现在就是在耍美国实验室。美国实验室那些酷东西呢？）

> "With other software, devs convince their managers of the importance of using open source stuff in their stack. With AI, it's usually managers choosing what models to use for the devs. The US labs don't need to give a damn how much devs like open source" — culi [c:49733419]
>
> （译文: 其他软件领域, 是开发者说服管理层把开源塞进技术栈。AI 这边反过来, 是管理层替开发者选模型。所以美国实验室根本不需要在乎开发者喜不喜欢开源。）

反驳同样具体。有人直接呛回去——你夸的那些 frontier 模型, 哪个不是中国蒸馏的产物？

> "You mean all of the frontier models that the Chinese distillation clones are copying? Yeah kinda cool imo. If a dashboard showing training for a model that doesn't even come close to anything us labs have released in 6 months is 'cool', then you're a loser" — hsbalanxvxjsmab [c:49735809]
>
> （译文: 你是说那些中国蒸馏克隆出来的 frontier 模型？确实挺酷, 我个人觉得。如果一个训练仪表盘——展示的模型连美国实验室 6 个月内发布的任何一个都比不上——都能算"酷", 那你就是个 loser。）

这条把另一侧的撕裂摆到了台面上: 同一次"训练过程公开", 在一部分人眼里是技术诚意, 在另一部分人眼里是 closed-source frontier 阵营的压力测试。

### "为什么公开"——三种解释各取所需

最像"灵魂拷问"的支线（6 条回复）来自这条追问:

> "Why are they doing this? To try head off accusations about distillation?" — rozab [c:49732829]
>
> （译文: 他们为什么要这么做？是为了堵住蒸馏的指控？）

回答分成三种态度, 对应三种解读。

**自信说**: 小米就是确信自己在做什么, 才敢把后厨亮出来。

> "Sometimes you're confident about what you're doing and show how you work to the world. Keeping the garage door open, or at least making the door translucent. It's always cool." — bayindirh [c:49732930]
>
> （译文: 有时候你只是确信自己在做的事, 就把它展示给世界。把车库门打开, 或者至少做半透明。这永远都很酷。）

**政策说**: 这是自上而下的选择, 不是一个实验室的临时决定。

> "That China's official policy is now to prefer open models and open model development may be a part of it." — jampekka [c:49733121]
>
> （译文: 中国官方现在的政策是优先支持开源模型和开源模型开发, 这件事可能是它的一部分。）

这条还延伸到了 BRICS:

> "BRICS just had a New Delhi meeting where Xi pushed a 5-point plan on AI cooperation that centered on open source models" — culi [c:49733398]
>
> （译文: BRICS 刚在新德里开过会, 习近平推了一个以开源模型为核心的 AI 合作五点计划。）

**品牌说**: 仪表盘页脚那句品牌语已经把答案写出来了。

> "Bottom of the page says 'Open is what we value.'" — anemic [c:49733564]
>
> （译文: 仪表盘页脚写着"Open is what we value"。）

三种说法不互斥, 但讨论里没人合并——有人觉得是技术自信, 有人觉得是政策红利, 有人觉得是 PR。

### 小米自己内部用 Claude?——一个一眼就被看穿的笑话

最喜感的一条支线（5 条回复）起于这条吐槽:

> "You'd think they would make it less obvious that they are running their whole operation with Claude" — levocardia [c:49732907]
>
> （译文: 你会觉得, 他们至少应该把"整套业务跑在 Claude 上"这件事藏得没那么明显。）

被追问"tell 在哪"之后, 答主被反驳——MiMo 自己的 UI 风格（"每个 step 的样本由什么组成"这种清楚表述）跟 Claude 的全大写 + 多 padding + 渐变风格明显不一样。反驳者最后还得加一句"我是认真在反 /s":

> "I hope this is /s because it's very easy to get Claude to write sensibly. That's why AI slop writing is so annoying because it's so easy to avoid with any amount of effort at all." — conception [c:49735720]
>
> （译文: 我希望这是反讽, 因为让 Claude 写出像样的句子一点都不难。这恰恰是 AI slop 文字让人讨厌的地方——只要稍微用点力, 完全可以避免。）

还有人从商业逻辑反驳——按 MiMo 的定价, 真全程跑 Claude 的话, 这家公司早就亏穿了。

### 仪表盘数据到底是不是真的

这条支线（4 条回复）最后被顶成"全场最该问的问题":

> "Very curious that everyone here (so far) seems to assume this dashboard presents real data." — dr_kiszonka [c:49735260]
>
> （译文: 很有意思, 这里所有人（到目前为止）都默认仪表盘呈现的是真实数据。）

回答给出了一组可观察的反证: 刷新页面时进度条会回退; 重启事件日志与数据曲线完全不相关——更像是在回放旧数据, 或者直接由 LLM 实时生成。

> "Haha yeah pretty wild how easily you can see the data is fake by the repeating numbers (refresh the page the progress goes back in time constantly) + watch for restarts. They say they happen but 0 data correlates the log messages. Just a replay of old data or being fed by an llm so they convince people they are open" — hsbalanxvxjsmab [c:49735791]
>
> （译文: 哈哈哈, 数据有多假, 看一眼重复数字就知道了（刷新页面进度条会往回走）+ 看 restart 事件。他们说 restart 发生过, 但 0 个数据点跟日志能对上。要么是回放旧数据, 要么是 LLM 实时编出来的, 就为了让大伙儿相信他们够 open。）

另一条独立回复同样质疑:

> "This is so very clearly fake? See the message stating the flash 2.6 flash run was restarted and 0 graphs correlate that restart" — hsbalanxvxjsmab [c:49735783]
>
> （译文: 这也假得太明显了吧？flash 2.6 flash run 重启过——日志里写得很清楚——但 0 张图跟这个重启对得上。）

这条线没有得到官方回应, 但被顶上来的理由很清楚: 一个号称"Open is what we value"的仪表盘, 如果连数据真实性都站不住, 那整件事就翻车了。

### 训练里出现"实时蒸馏"的可能性

还有人顺着仪表盘脑补出一个更新的训练范式:

> "Distillation in real-time? Very interesting!" — dude250711 [c:49734417]
>
> （译文: 实时蒸馏？很有意思！）

这条立刻被戏仿成"训练成本 = 实时调用 Anthropic/OpenAI API 的费用", 贴了一个 /s 收尾:

> "That 'training cost' is just live revenue count for Anthropic/OpenAI API calls! /s" — Cookingboy [c:49734944]
>
> （译文: 那个"训练成本"其实就是 Anthropic/OpenAI API 调用的实时营收！/s）

段子归段子, 但呼应了 levocardia 那条"小米自己内部用 Claude"的吐槽——没人当真, 也没人当真反驳, 大家都在笑。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| MiMo 重度好评 | `joelwallis` [c:49732870] | 干工程项目主力, 智能水平 ≈ Anthropic, ROI 高一个数量级 |
| MiMo 体验否定 | `walrus01` [c:49733124] | 只能写一次性脚本, 比 qwen 3.8-flash-next 笨, 不如 GLM 5.2/5.3 |
| 训练数据 + 体验 | `passive` [c:49734095] | 2.5-pro 像"忘事的资深工程师", 新模型多任务明显上一档 |
| 训练中跑 benchmark | `liuliu` [c:49732837] | 这不就是污染的定义? |
| 污染可接受 | `jampekka` [c:49732943] | 只做 validation / stopping criterion, 比直接喂数据轻得多 |
| 污染不可忽略 | `kingstnap` [c:49733913] | 研究员反复调参看分, 信息泄露是隐性的 |
| 中国实验室更酷 | `impulser_` [c:49733211] | 中美对比, 美国这边"cool shit 在哪"? |
| 选择权在管理层 | `culi` [c:49733419] | AI 模型选型是管理层定的, 美国实验室不需要在乎开发者 |
| 反方 | `hsbalanxvxjsmab` [c:49735809] | 中国 frontier 模型本来就是蒸馏产物, 这有什么酷的 |
| 自信解释 | `bayindirh` [c:49732930] | 确信自己在做什么, 就敢把后厨亮出来 |
| 政策解释 | `jampekka` [c:49733121] | 中国官方政策现在偏好开源模型 |
| BRICS 维度 | `culi` [c:49733398] | 新德里会上习近平推了以开源为核心的 AI 合作五点计划 |
| 品牌解释 | `anemic` [c:49733564] | 页脚写着 "Open is what we value" |
| UI 风格反驳 | `ricardobeat` [c:49734212] | MiMo UI 风格明显不是 Claude——Claude 会全大写 + 多 padding |
| 商业逻辑反驳 | `jambutters` [c:49734761] | 按 MiMo 定价, 真跑 Claude 早亏穿了 |
| 数据真实性质疑 | `dr_kiszonka` [c:49735260] | 全场默认数据是真的, 但没人验证过 |
| 数据可观察的反证 | `hsbalanxvxjsmab` [c:49735791] | 进度条刷新会回退, 重启事件对不上曲线, 像是回放 |
| 训练成本规模 | `ttul` [c:49735375] | 5 美元/秒 ≈ 43.2 万美元/天, 够在 Modal 上租 3000 块 B300 |
| 实时蒸馏戏仿 | `Cookingboy` [c:49734944] | 训练成本其实是 Anthropic/OpenAI API 实时营收（/s） |

## 总体情绪

讨论的主线其实是两条互相拉扯的叙事。一条是"训练过程公开"作为产品信号——透明度、ROI、可观察的 frontier 进度, 工程师读完仪表盘的评价高度一致: 这件事本身比参数更值得讨论。另一条是"为什么是中国公司先做到"——这背后有技术自信、政策红利、品牌定位三层动机, 评论区没人合并, 也没人要求合并。

最有意思的反转是结尾那条"仪表盘数据是不是真的"。讨论到一半, 没人再单纯把它当成技术 FAQ, 大家意识到: 一个挂在网上、号称"Open is what we value"的仪表盘, 如果连数据真实性都站不住, 那"open"这两个字就要重新读一遍。hsbalanxvxjsmab 给出的"刷新页面进度条会回退"这种最小可观察证据, 比前面所有关于中美实验室文化的讨论都更刺眼。

最后留下的不是"哪家实验室更开放", 而是一个更工程的问题: 公开训练过程, 你愿意公开到什么颗粒度——进度条、benchmark 曲线、成本数字, 还是日志里那行"run restarted"？

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Xiaomi Mimo 2.6 live post-training dashboard | <https://news.ycombinator.com/item?id=49732270> |

## 免责声明

<div class="disclaimer">

本文为 HN 公开讨论的中文摘要, 不代表本站立场。所有引文均直接来自 HN 公开评论页（comment ID 已标注）, 尽可能保留英文原文与原作者表述。

如有引文错漏或需修正, 请通过评论或邮件告知。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>