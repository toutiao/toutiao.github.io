---
layout: post
title: >-
  ChatGPT 把纽约客漫画家的真名签到伪造漫画上 — HN 讨论纪要
date: 2026-10-06
hn_id: 49971846
categories: [articles]
excerpt: >-
  OpenAI 的图像生成器模仿《纽约客》风格时, 会顺手把在职漫画家的真名签在角落。十五位以上的漫画家被发现, 一张 Dolly Parton 的"天堂漫画"拿了 2.5 万点赞。
tagline: >-
  签名是作者的"信用存根", ChatGPT 把这张卡复印到了每一张 AI 废纸上。
---
## 原文概要

Nieman Lab 10 月 5 日发表的报道 [ChatGPT is adding real cartoonists' signatures to fake New Yorker cartoons](https://www.niemanlab.org/2026/10/chatgpt-is-adding-real-cartoonists-signatures-to-fake-new-yorker-cartoons/) 记录了一件已经被错过好几次的事。导火索是一张 8 月底在网上流传甚广的"天堂入场"漫画：身着亮片礼服的 Dolly Parton 与扮演 Dr. Frank-N-Furter 的 Tim Curry 手挽手站在圣彼得门前，对上帝说"I knew I chose the right plus one"。这张图在 Twitter 拿到 2.5 万个赞，还在 Facebook、Instagram、Bluesky 反复转发。漫画右下角的署名是 **BLOPER**——这是《纽约客》在职漫画家 Brendan Loper 的笔名。但 Loper 没画这张图，也没签过名。原始作者只是一个 Dolly Parton 粉丝，她在 Facebook 评论区承认自己只是让 ChatGPT 做一张"《纽约客》风格"的漫画。

这不是孤例。Loper 在 5 月就已经收到陌生人发来的 Instagram 警告，称他在 ChatGPT 输出的图里看到了自己的笔名；夏天他又在一系列 Reddit 帖子里发现了更多。报道作者 Andrew Deck 自己也测试了 ChatGPT，确认它能稳定输出包括 George Booth、Liza Donnelly、Ellis Rosen、Saul Steinberg 等十余位漫画家签名的图像，加在一起他记录到的"被冒名"漫画家超过 15 位。其中 Emily Flake 说自己 2008 年起给《纽约客》供稿，她在 AI 图里看到了自己笔下那种"姿势与阴影的 DNA"——但每一张图末尾的 `e. flake` 都不是她写的；Pat Byrnes 自 1998 年起以 `P.Byrnes` 署名，每张 AI 图都精准地复制了他那个"句号收尾"的签名习惯。

OpenAI 给出的标准回复是："我们相信创造力的未来本质上属于人，我们专注于构建赋能人类创造力与创作者的工具。"在 Deck 提醒之后，ChatGPT 开始对"画一张《纽约客》风格漫画"的请求加一条新提示——"此提示可能违反我们关于第三方内容相似性的护栏"——但截至报道发稿，它仍在为一些通用漫画图签上在职漫画家的真名。

法律层面，《纽约客》母公司 Condé Nast 在 2024 年与 OpenAI 签订了一份多年期内容授权协议，但该协议并不覆盖《纽约客》的漫画库——漫画采用投稿制，作者保留版权，合同条款不允许 AI 训练用途。即便如此，《纽约客》漫画里那些反复出现的笔名还是进了 ChatGPT。报道指出上月解封的 *New York Times v. OpenAI* 法庭文件显示，OpenAI 在训练过程中**主动绕过**了出版商的付费墙；一份未被涂黑的微软内部备忘录把抓取数据称为"人类历史上最大规模的劳动盗窃"。报道采访的卡通画家普遍认为这事已经超出了"画风模仿"——Joe Dator 在《纽约客》供稿 20 年，他的原话是："信用卡被刷爆时他们没扮成我的样子，这件事比那还糟。"

## 讨论焦点

### "签名 = 像素统计"派：这就是模型该做的事

> "I mean, the bug is, 'it generated the most likely cluster of pixels in the corner of a New Yorker cartoon'." — saalweachter [c:49972345]
>
> （翻译：所谓 bug 就是——它生成了《纽约客》漫画角落最可能出现的那团像素。）

> "I think what you're seeing is the probability of a particular signature or style of signature appearing on a particular style of cartoon, not an intent to sign." — kzsh [c:49972352]
>
> （翻译：你看到的只是某个签名（或签名样式）出现在某类漫画里的概率，不是"它想签名"。）

> "It's also while you'll sometimes get a mangled Getty Images watermark on some image generations, or a logo in the bottom left corner. If it's a prominent feature in the training dataset it'll show up, exactly how these models are supposed to work." — ctippett [c:49972641]
>
> （翻译：有时候你还会看到 Getty Images 的水印被画歪，或者左下角多出一个 logo。只要训练集里这个特征足够显眼，它就会出现——这恰恰是这类模型该做的事。）

这派观点认为，**这不是 bug，是训练数据决定的下游产物**。既然《新 Yorker》漫画右下角几乎永远带签名，模型就把"右下角像素簇"学成了漫画的一部分。gwern 在评论里说他自己用 Nano Banana Pro 和 ChatGPT 生成漫画时也碰到这事，每次都得手动多生成一步把伪签名抹掉：

> "This has been a perennial problem with my own generated comics with both Nano Banana Pro and ChatGPT (all generations). I often have to put in an extra edit to erase the false signature." — gwern [c:49972442]
>
> （翻译：我自己用 Nano Banana Pro 和 ChatGPT 生成漫画时这也常年发生，我经常得额外编辑一步把那个假签名擦掉。）

> "Despite what all the clickwrap warnings and 'AI can make mistakes' subtitles might lead you to believe, the service offering of AI is explicitly designed to be as 'one and done' as possible. The inherent nature of these tools is to service laziness, and disincentivize too much scrutiny." — bulder [c:49972598]
>
> （翻译：尽管那些点击同意条款和"AI 可能出错"的字幕一直在暗示，但 AI 服务的设计目标就是尽可能"一次搞定"。这些工具的本质就是服务懒惰，让用户懒得细看。）

### "不是 bug，是署名权"派：跨过的不只是风格线

> "Why is it a bug? If other parts of the generated illustration are similarly taken from an artist, why not the signature as well? Why is a signature crossing the line but the rest of the image isn't?" — dorkwood [c:49972513]
>
> （翻译：凭什么算 bug？图里其他部分也是从这位画家那里学来的，凭什么签名跨过了线而其他像素没有？）

> "For the same reason I'm allowed to draw, paint, or write things very similar to what others have drawn, painted, or written but I have to sign my own name not theirs." — DonsDiscountGas [c:49972562]
>
> （翻译：原因很简单——我可以画、可以写，画得、写得像别人都行，但我必须签自己的名字，不能签他们的。）

> "You are a person, LLMs are not. You know this, which is why you know that if you signed someone else's name it would be forgery, but when you see the machine do it you call it a bug." — pessimizer [c:49972601]
>
> （翻译：你是人，LLM 不是。你很清楚这一点——所以你知道人签别人的名是伪造，看到机器签了反而叫它 bug。）

这派的分歧点在**"跨过线"的那条到底在哪**。如果画风可以被学，那右下角那串手写体为什么不能被学？pessimizer 一针见血：同一件事，人做是伪造，机器做就降级成了"统计过程"。评论区有人补刀说"因为签名让否认不可能了"——生成图带风格还能解释成"学的是风格"，带署名就是另一码事。

### "这是诉讼材料"派：法律边界的重新画线

> "The copyright washing machine strikes again." — dormento [c:49972264]
>
> （翻译：版权洗白机又开张了。）

> "That's not a copyright issue, it's a trademark issue." — drdaeman [c:49972886]
>
> （翻译：这根本不是著作权问题，这是商标问题。）

> "Artists should be able to personally sue OpenAI for libel every time they forge an artists signature." — SchemaLoad [c:49972718]
>
> （翻译：每次冒签艺术家签名，艺术家都应该能以诽谤罪起诉 OpenAI。）

> "So this has morphed from plagiarism and copyright infringement (bad) to impersonation (also bad, arguably worse, and maybe more provable in court). It's chilling to think of the implications of having one's signature attached to a document or to words that are not one's own." — baubino [c:49972561]
>
> （翻译：所以这件事已经从抄袭和著作权侵权（已经够糟）升级成了冒名顶替（可能更糟，也可能更容易在法庭上证明）。想到自己的签名会被贴到一份根本不是自己写的文件上，那种感觉真让人发冷。）

> "Plagiarism as a Service. We can all try really hard to pretend that's not the business model, but that's totally the business model." — MarkusQ [c:49972566]
>
> （翻译：抄袭即服务。我们都可以假装这不是商业模式，但它就是。）

Cornell 法学院的数字与信息法教授 James Grimmelmann 在原报道里点出另一条路——**right of publicity**（公开权），这是美国各州法层面的"个人身份权"，专门管未经授权使用他人姓名或身份的行为。这条路径对漫画家更友好，但要证明对方有商业用途，不能只是玩笑。评论区里 SchemaLoad 直接喊出"诽谤罪"——但更稳的说法是冒名顶替/冒充（misappropriation），举证难度低于证明一张图"风格相似到构成实质性相似"。一旦先例落地，后果不止于漫画，**任何带签名的视觉产物都可能中招**。

### "训练数据才是源头"派：拆掉就好，问题是值不值

> "I really wish there'd be a split among these disciplines (science/math/code vs. videos/art/literature) - one is vastly more problematic than the other." — zzzeek [c:49972390]
>
> （翻译：我真希望能把这几条线分开——科学/数学/代码 vs. 视频/艺术/文学——前者麻烦远小于后者。）

> "They can't be ethically sourced and good at the same time. The current models intelligence depends on massive training dataset of essentially stolen data." — PunchyHamster [c:49972541]
>
> （翻译：它们没法既合乎道德又足够强。当前模型的智能依赖的海量训练数据，本质上就是偷来的。）

> "I don't think it is likely that they could get enough data without stealing. It would be incredibly costly to have to pay artists to church out art just to train an AI." — harimau777 [c:49972892]
>
> （翻译：我觉得他们不可能在不偷的前提下拿到足够的数据。付钱让艺术家专门为训练 AI 而创作，那成本高得吓人。）

> "What Microsoft's Director of Applied Science called the, 'largest theft of labor in human history'." — GolfPopper [c:49972596]
>
> （翻译：微软应用科学总监称之为——"人类历史上最大规模的劳动盗窃"。）

更多"工程上能不能修"的具体方案：zzzeek 自己提出数学/科学任务可以用合成数据解决一大半；johnnyanmac 列出五步方案（只用开源/CC 资源、付授权费、给创作者按样本量分成、雇人做训练用素材、政府补贴），承认"会花上千亿美元，但本来这就不是行业的瓶颈"；mehrzad 提出更激进的做法——立法要求 LLM 输出只能用于 STEM，拒绝任何文艺任务。

这是 LLM 圈里反复出现的"工程问题 vs 道德问题"分裂：能解决的人认为代价太高、不该解决的人认为代价不是不做的理由。

### "这不是 LLM"派：图像生成是另一类模型

> "Nice. This demolishes the 'LLMs can reason' (but not enough to avoid this sort of basic error) and 'humans make mistakes too' (not like this) talking points from the LLM promoters." — ThrowawayR2 [c:49972523]
>
> （翻译：好。这把 LLM 鼓吹者两条论点一起打翻——"LLM 能推理"（至少不足以避开这种低级错误）和"人也会犯错"（不会错成这样）。）

> "you're confusing image generation models with LLMs. There are very big differences between the two. No-one is claiming that image generation models are capable of reasoning." — antonvs [c:49972682]
>
> （翻译：你把图像生成模型和 LLM 搞混了。两者差别很大。没人说过图像生成模型能推理。）

> "Quiz: What does the second 'L' in 'LLM' stand for? Hint: it isn't 'image'." — duskwuff [c:49973235]
>
> （翻译：测验：LLM 里第二个 L 是什么？提示：不是"image"。）

> "Image generators aren't LLMs." — wilg [c:49973469]
>
> （翻译：图像生成器不是 LLM。）

这一派的核心反驳是**别拿这件事打 LLM**——ChatGPT 是 LLM 套壳产品，但生成图像的是另一套架构（diffusion），不是"语言模型下一个 token 预测器"。但也有人补刀说，**ChatGPT 把图像生成集成进了 LLM 的工作流**，LLM 在 prompt 编排阶段、签发阶段都参与其中，把"图像生成器不是 LLM"当成挡箭牌本身就是话术偷换。这条线最后往哪落，并不取决于技术分类，而是取决于"AI 公司对 AI 产品的整体责任"这条法律原则什么时候成形。

### "LLM 能推理吗"长尾：这件小事意外变成了哲学测试

> "This is a pretty solid argument against people who argue that LLMs are more than just (very massive) next token predictors. If there was any thought or underlying thought going on here not putting a signature (at least a real one) would be the right move, despite it being less likely." — parineum [c:49972564]
>
> （翻译：这对"LLM 不只是超大号下一个 token 预测器"派是个挺有力的反例。如果这里有过任何思考，它就该意识到——哪怕这在概率上更不可能——也别签一个真人的名字。）

> "There's a lot of space between: LLM's can reason, everything an LLM does is the result of reasoning. This demolishes only the latter point, which as far as I know has no supporters." — __MatrixMan__ [c:49973242]
>
> （翻译：中间留有大量空间——一边是"LLM 能推理"，另一边是"LLM 做的每件事都是推理的结果"。这件事只打翻了后者，而后者本来也没什么人支持。）

> "I remain unconvinced. The thing about a generative language model that's trained from a massive but unknown corpus is, it's practically (if not theoretically) impossible to evaluate the extent to which data leakage contributes to any particular output. 'Sophisticated engine for approximately querying a pastiche of the results of human reasoning that comprise its training corpus' remains a more parsimonious explanation than 'it's doing actual reasoning' for how this neural network architecture produces the phenomena we've been observing." — bunderbunder [c:49972927]
>
> （翻译：我还是不信。一个用巨大且未知语料训练出来的生成式语言模型——实操上（哪怕理论上不成立）我们根本无法评估某个输出有多少是数据泄露造成的。"对一个由人类推理结果拼凑而成的大杂烩进行近似查询的精密引擎"——比起"它真的在做推理"，是对当前这种神经网络架构如何产生我们所观察到现象的更简洁解释。）

__MatrixMan__ 的反驳其实是逻辑上最干净的——签名这件事只证伪了"LLM 做每件事都是推理的结果"，并不能证伪"LLM 能推理"。但反 LLM 阵营不在意这种精度，他们要的是把"AI 不理解自己在做什么"钉死到公共讨论里。这条线一直往"AI 与人之间的本质差别"延伸，但目前还没有任何一方能在工程上给出可证伪的判定标准。

### 个人使用者的尴尬：签名真的会跑到你脸上

> "Engineering manager at my company put a comic at the end of our sprint demo that was signed bloper. Except it wasn't funny at all, and kind of weird. I asked him, sure enough it was ChatGPT and he didn't notice the signature." — WD-42 [c:49972489]
>
> （翻译：我们公司的工程经理把一张漫画贴到了 sprint demo 结尾，签名是 bloper。完全不好笑，还有点怪。我问了他，果然是 ChatGPT 生成的，他根本没注意到那个签名。）

WD-42 的经历把整件事从"理论侵权"拽回了现实——Sprint demo 上已经有人不小心把一张冒 Brendan Loper 名义的 AI 漫画贴出去了。这事的可怕不在于 Loper 是否起诉，而在于**99% 的使用者根本不会去检查右下角**。gwern 自己说"我不意外大多数用户懒得擦"，这意味着这种冒名图已经在大量文档里悄悄存活。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 统计派（不算 bug） | saalweachter [c:49972345] | 它只是生成了《纽约客》漫画角上最可能的那团像素 |
| 统计派（不算 bug） | kzsh [c:49972352] | 这是签名在漫画里的概率，不是"它想签名" |
| 跨线派（签名是另一码事） | dorkwood [c:49972513] | 风格能学，签名不能学，否则就是伪造 |
| 跨线派（签名是另一码事） | DonsDiscountGas [c:49972562] | 我可以写得跟人很像，但只能签自己的名字 |
| 法律派（已构成诉讼） | SchemaLoad [c:49972718] | 艺术家应以诽谤起诉 OpenAI 每次冒签 |
| 法律派（已构成诉讼） | MarkusQ [c:49972566] | "抄袭即服务"是这行的真正商业模式 |
| 数据源头派 | PunchyHamster [c:49972541] | 道德与性能无法兼得——当前模型靠的就是偷来的数据 |
| 数据源头派 | harimau777 [c:49972892] | 不偷就拿不到足够数据，付费创作成本太高 |
| 不是 LLM 派 | antonvs [c:49972682] | 图像生成模型与 LLM 差别很大，没人声称前者能推理 |
| 不是 LLM 派 | duskwuff [c:49973235] | LLM 里第二个 L 不是"image" |
| 推理论战（反） | parineum [c:49972564] | 如果有过思考，它就不会签真名 |
| 推理论战（反） | bunderbunder [c:49972927] | "近似查询引擎"仍是更简洁的解释 |
| 推理论战（中立） | __MatrixMan__ [c:49973242] | 这件事只打翻了"LLM 做每件事都是推理的结果" |
| 个人使用尴尬 | WD-42 [c:49972489] | Sprint demo 上已经有人在播了，根本没人看 |
| 远程使用尴尬 | gwern [c:49972442] | 我每次都得手动多生成一步把假签名擦掉 |

## 总体情绪

评论区没有否认这两个事件的总量。分歧在于**这件事到底算什么**——统计产物、培训错配、著作权侵权、还是冒名顶替。三股情绪最显眼——第一股是技术派"**这是统计常态不是 bug**"，给出最稳的解释但也最没动力去修；第二股是版权派"**ChatGPT 是能训练的，应该把签名带过来**"，给人以道德歉意，但开出的账单太高（按样本量分成、付授权费、付创作费），只有更激进的监管才可能让它落地；第三股是法律派"**这是诉讼材料**"，最容易落地，但要先有人愿意真去告。

整件事最好笑的部分是——OpenAI 给 Deck 的标准话术是"我们相信创造力的未来本质上属于人，我们专注于构建赋能人类创造力与创作者的工具"。下次它在右下角签上 `manus` 的时候，可能还得让那位漫画家本人来点这个"赋能"按钮。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | ChatGPT is adding real cartoonists' signatures to fake New Yorker cartoons — Nieman Lab | [news.ycombinator.com/item?id=49971846](https://news.ycombinator.com/item?id=49971846) |

<div class="disclaimer">

本文摘要由 AI 模型辅助整理，所有引文均直接来自 HN 评论原文。文章内容仅反映 HN 讨论中的观点，不代表本摘要作者或 [yuedulijie.com](https://yuedulijie.com) 立场。引文末尾 `[c:id]` 为对应 HN 评论 ID，可用于在原帖中定位。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>