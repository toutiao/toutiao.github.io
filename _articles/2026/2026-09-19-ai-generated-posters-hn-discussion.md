---
layout: post
title: >-
  AI 生成海报不必那么糟糕 — HN 讨论摘要
date: 2026-09-19
hn_id: 49764791
categories: [articles]
excerpt: >-
  一篇博客主张只要给 AI 列出具体美学风格（包豪斯、孟菲斯、Designers Republic 等）就能摆脱 ChatGPT 默认的「番茄酱滤镜」。274 点的热门帖把这个命题扔进现实：大多数抱怨针对的不是单张图，而是 AI 内容整体的饱和。
tagline: >-
  把 ChatGPT 默认海报逼回设计语言的窄巷里，它其实能做出不丢人的东西。
---
## 原文概要

2026 年 9 月 19 日，HN 首页置顶了一篇博客——John Hartnup 的《AI-generated posters don't have to be horrible》。文章开头放出一组被广泛转发的「同质化海报」拼图：乡间集市、社区咖啡店、学校演出，全是 ChatGPT 默认风格的小清新花卉图标加微透明色块。Hartnup 没有停留在抱怨，他给 ChatGPT 出了一道题——为虚构的「Honeyford 春季集市」做海报，要求「干净、不繁复、亮色、醒目的春天主题图形，避免粉彩/喷绘/油画风格或人物图」。

第一次返回的依然是默认的小清新集市模板。他换了一种问法：「Make another one using a completely different design aesthetic of your choice」，ChatGPT 给出了包豪斯 / 现代主义几何风格，并主动列出了 15 种风格选项——从瑞士网格、Risograph、Matisse 剪纸、90 年代锐舞传单、Memphis Design，到日本极简、Wayfinding 标识系统。

Hartnup 接着依次让模型切换到：Stamp / Letterpress、Memphis、Designers Republic、童趣水彩加专业字体、1980 年代朋克小志、90 年代鼓打贝斯演出传单、1940 年代立体派展览海报。每一张风格都明显跳出了 ChatGPT 默认模板。作者承认锐眼仍能认出 AI 痕迹，但「不一样了，也并不丑」。

文章最后指向他后续整理的 100 种风格 Prompt 目录，并补了一句：Claude 和 Gemini 可以直接输出 HTML / PNG / PDF 让文字保持为真文字、图层为真图层，编辑性更好，但「今天不展开」。

---

## 讨论焦点

### 1. 问题不是单张图，是「饱和」

评论里最有力的反驳不是针对某一张图，而是整套 AI 海报的同质化。

> "It's saturation. If I saw an Images 2.0 flyer in year 2020? In a world where Images 2.0 didn't exist? I'd be impressed. But if I see it now, today? I'm not impressed at all. It's the same image, produced by the same AI and seen by the same person. So, what's the difference?" — ACCount39 [c:49765550]
> （这就是饱和。2020 年看到同样的图我会眼前一亮；今天再看，毫无感觉。同一张图，同一个 AI，同一个人看，区别在哪？）

> "That's not what OP is complaining about. The issue with AI art isn't how the individual piece look, but the similarities they have in aggregate. One image can look perfectly fine, once you seen a hundred they all start looking extremely similar." — grumbel [c:49765375]
> （OP 抱怨的不是单张图，而是大量图叠加起来的相似性。一张看着 OK，看了 100 张就开始雷同。）

> "I bet you would not feel sick if you didn't know ahead of time they were AI-generated. Some really are quite good." — jwr [c:49765373]
> （如果事先不知道是 AI，你未必会反感。确实有几张相当不错。）

把同一张图放给不知道 AI 存在的人看，是另一回事。AI 海报的「丑」有一半是曝光过度的副作用。

### 2. 模型默认的「最常见联想」就是陈词滥调

> "I find it kinda funny that even "smartest", most capable models often have a very hard time going beyond surface-level, top-of-mind associations, when faced with creative tasks. Of course, a "Japanese Minimal Poster" has a sakura and a stylized flag of Japan, duh." — vova_hn2 [c:49765461]
> （有趣的是最强模型碰到创意任务也只能想到最表层的关联——「日本极简海报」当然是樱花加国旗。）

> "But AI has absolutely no problem with going with the cheesiest, most overused trope." — vova_hn2 [c:49765461]
> （AI 完全不介意挑最俗套的套路。）

> "That's a prompt problem. If you named a Japanese artist or style rather than giving an adjective derived from a country, you might get something that wasn't national wank. Yes, a human might do this step for you. A mediocre one might not." — oliwarner [c:49765730]
> （这是 prompt 的问题。你只说「Japan」就只会拿到国旗和樱花，给个具体艺术家或流派名字结果会不一样——但平庸的人类设计师可能也想不起来。）

> "The thing is, they aren't creative. When I ask an LLM to go beyond the mean, it has no idea what to do and returns incoherance. Its responses seem to have N latent dimensions of information. But, the value of each of those dimensions is always the midpoint." — afpx [c:49765759]
> （模型不「创造」。让它超出均值，它就崩了——它输出的每一维都向中点回归。）

> "My point is that those kinds of prompts are dumb and I actually expect the model to produce slop. In programming we write these huge prompts that go into a lot of detail, and when we do that, it actually works." — danpasca [c:49765869]
> （那种 prompt 是笨 prompt，模型吐出 slop 是理所当然。写代码要写一长串细节 prompt 才有效，设计也一样。）

模型是统计学意义上的「最常见」，不是「最有趣」。想要绕过这个均值，要么写出强约束 prompt，要么靠人类先做一轮创意筛选。

### 3. 小地方本来就不会请设计师

> "Maybe, but a small local event or business probably won't have the budget to hire them or know where to find them. It's cheaper, faster and easier to use AI to generate something that's good enough for their purposes." — ajjenkins [c:49765646]
> （小镇活动或小店根本请不起也找不到设计师。AI 生成一个「够用」的海报更便宜、更快、更省事。）

> "This is my experience as well. I run a bootstrapped business, so we don't have a ton of backing. We can't afford the top design firms, and Fable can do better than those within our budget. So it's not that we prefer AI over human designers; we just don't have the money!" — ha-shine [c:49765691]
> （我自己的初创公司也一样，请不起顶级设计公司，AI 在预算内能做到更好。不是偏爱 AI，是没钱。）

> "I was one of those "skilled friends" that people go to, to make those posters in times of need back in school. ... The posters and designs were often rushed out late night by the closest person you can find who had a copy of photoshop on their computer. If we had AI back then, I would bet you 100% it would be the preferable solution and no one would bat an eye." — dreambigwrkhard [c:49765625]
> （学生时代我就是那个被拉去做海报的「会设计的朋友」……海报都是熬夜赶出来的。如果当年有 AI，100% 大家都愿意用，没人会有意见。）

> "The alternative is WordArt, or just black on white Comic Sans with some bolding and font size variations with bad ClipArt. These small scale events would never hire a professional." — bonoboTP [c:49765177]
> （替代品是 WordArt 或白底 Comic Sans 加粗体配剪贴画。这种小活动本来就不会请专业设计。）

很多读者承认替代品从来都是 WordArt / Comic Sans / Canva 模板，AI 至少把下限抬了一档。对预算受限的小活动方，这不是「取代设计师」，是「取代什么都不做」。

### 4. 「低投入装高投入」的别扭感

> "It's not complicated - the default style signals low effort. Why should I get excited about the village fete if the organizers put in the barest minimum of effort? But there's another reason it drives people crazy - it's low effort trying to present as high effort." — JSR_FDED [c:49765120]
> （不复杂——默认风格就是「低投入」信号。但让人恼火的是它「低投入却装高投入」。）

> "The last paragraph in GP's comment is the key. Nobody would care about a low effort poster, what they care about is the deception of pretending you put a lot of effort into the poster. It's dishonest, and it would make me subconsciously question what else they're being dishonest about." — bspammer [c:49765304]
> （重点就在最后一句——没人介意低投入，介意的是「假装投入」的欺骗感。它会让你下意识怀疑主办方还在别处装。）

> "Like how if you bought a box of chocolates, and it was actually filled with rocks, you wouldn't dislike it until you found out. Immediate glamor followed by gradual disappointment is AI output all over." — card_zero [c:49765434]
> （像买了一盒巧克力，打开发现装的是石头——你不会讨厌石头，是发现被骗之后才讨厌。第一眼的惊艳随后变成失望，AI 输出的通病。）

低投入本身不是问题，「低投入假装高投入」才是。这种「虚假努力信号」在小红书、Instagram 广告、餐厅菜单图上已经让人疲倦。

### 5. 文中的变体确实跳出了——但仍未解决「为什么是它」

> "The variations the author generates are night and day better than the "piss filter" era slop in the first batch. Some of them would have passed as intentionally crafted by a graphics designer before AI." — echelon [c:49765238]
> （作者做出来的变体比第一批「番茄酱滤镜」好太多了，有些放在 AI 时代之前完全能以假乱真。）

> "Did you look at the examples? They're almost ridiculously diverse, and the prompts show very little handholding was required. They're not novel, but a poster for a spring fair isn't supposed to look like a de Kooning." — TheOtherHobbes [c:49765481]
> （你看过例子吗？多样性高得离谱，prompt 也没多费劲。海报本来就不是德库宁。）

> "It doesn't fail, it actually demonstrates how the model can improve the output if the prompt is better. AI generated websites look like crap because developers don't know any design language so they have no idea how to prompt the models to get something good and more unique and creative out of them." — danpasca [c:49765498]
> （文章没失败，反而证明了好 prompt 能改善输出。AI 生成的网站丑，是因为开发者没有设计语言，不知道该怎么 prompt。）

赞成派的核心论点是：模型能做对，问题出在用户不知道「要什么」。一旦给出具体风格名（包豪斯 / Memphis / 1980s fanzine），模型就能在那个窄空间内合理发挥。

### 6. 一旦细节变多，AI 的「文化失明」就会暴露

> "90s DnB was absolutely not about "good vibes". The smiley face logo is completely inappropriate; that's associated with late 80s/early 90s rave culture, pre-DnB era. 90s DnB was much darker and edgier in tone." — mrob [c:49765539]
> （90 年代鼓打贝斯传单里的笑脸 logo 完全是错的那是 80 年代末 90 年代初锐舞文化的符号，鼓打贝斯要黑暗得多。）

> "To me if you ask to a 10 years old kid and give him a PC with Microsoft Paint on it it will you will have a much better result than any AI-generated option in the post. If there are graphics designer that produce a worse result of what AI creates, it's because they probably use AI as well." — alerighi [c:49765830]
> （给一个 10 岁小孩一台装 Microsoft Paint 的电脑，结果都比任何 AI 生成的强。如果有设计师比 AI 还糟，那大概率他自己也用 AI。）

> "The alternatives are not horrible, but look like I'm being lured to a Spring Fair by an alien. It makes no sense to associate with Japanese imagery or 90s computer graphics for an event that has nothing to with these topics. Design is a language and these speak gibberish." — exitb [c:49765810]
> （替代品不算丑，但看着像被外星人诱骗去春季节日。把日本元素或 90 年代电脑图形放在无关活动上根本讲不通。设计是语言，这些在讲胡话。）

风格可以选对，但风格背后的「文化语境」AI 几乎抓不住——90 年代鼓打贝斯不是「好氛围」，日本不是「樱花+国旗」。它能模仿视觉，无法理解场景。

### 7. 反 AI 情绪的真实强度与类比风险

> "Because a lot of "everyday" folks really strongly dislike AI. I've lost count of the number of AI generated Instagram ads I've seen where the comments are filled with "AI slop!". It's not a positive signal for anyone who wants to persuade someone of the value of whatever they're advertising because it's associated with being cheap and lazy." — afavour [c:49765867]
> （普通用户对 AI 的反感是真实的。Instagram 上 AI 广告下面全是「AI slop！」的评论。）

> "A lot of everyday folks also strongly dislike vaccines. I've decided that I'm going to treat these two groups the same going forward." — p-e-w [c:49765882]
> （普通用户对疫苗的反感也一样强烈。我决定以后把这两个群体一视同仁。）

> "They really don't. A tiny minority of cranks dislike vaccines. AI dislike is far, far more widespread." — afavour [c:49765901]
> （不一样。反对疫苗的是少数边缘人，反 AI 是普遍得多得多的情绪。）

反 AI 的强度比反疫苗广得多。把「反 AI」类比成「反疫苗」会激怒双方——一边觉得被轻视，一边觉得被捆绑成阴谋论者。这是 HN 上常见的类比陷阱：类比太顺手，反而让讨论更分裂。

### 8. 小场景里的真实权衡

> "For me what always gives it away is not the posters themselves, it's the context. These are all overdesigned for a local community fair. There is no way they'd be paying for a professional designer for this, therefore it's AI." — bspammer [c:49765271]
> （对我来说露馅的不是海报本身，是场景。社区集市用这种过度设计的图，本就不可能请专业设计师，所以一定是 AI。）

> "Context is everything. A twee handwritten sign for free range eggs at the roadside is likely to do well. A handwritten sign for flying lessons on the other hand.." — _puk [c:49765449]
> （场景决定一切。路边卖散养鸡蛋的手写牌子很好；飞行课程用手写牌子就……）

> "Beer? The first example is about a beer festival. People go there to drink beer, not to see posters. A blank piece of paper that says 250 kinds of beers would get more excitement than any AI or handcrafted poster." — gus_massa [c:49765662]
> （人家是啤酒节。去的人是为了喝酒不是看海报。一张白纸写「250 种啤酒」都比 AI 或手工海报有吸引力。）

> "Making a good poster is bikeshedding. Organizing an event is hard and making better posters than this is a waste of their limited resources." — zulban [c:49765272]
> （做好海报是自行车棚效应。办活动本身很难，把精力耗在海报上是浪费有限资源。）

对小活动方来说，海报设计的真实瓶颈是「信息能不能在 3 秒内被扫到」，不是美学。功能主义的胜利——读者不会为审美去集市，但会为「250 种啤酒」去。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 反对 AI 海报（风格层面） | alerighi | 10 岁小孩用 Paint 都能比 AI 强，因为大脑已经学会了识别 AI 内容并本能排斥。 |
| 反对 AI 海报（文化层面） | mrob | 视觉能模仿，文化抓不住——90 年代鼓打贝斯的「笑脸+好氛围」是彻底的时代错位。 |
| 反对 AI 海报（语境层面） | exitb | 设计是语言，这些图在讲胡话，把无关文化符号乱拼。 |
| 支持 AI 海报（预算现实） | ajjenkins / ha-shine / dreambigwrkhard | 替代品从来是 WordArt / Comic Sans / 临时被抓的同学，AI 把下限抬了一档。 |
| 支持 AI 海报（功能主义） | zulban / gus_massa | 海报是通知工具不是艺术品，把精力耗在审美上才是浪费。 |
| 中间派（饱和论） | ACCount39 | 不是图变丑了，是你看腻了。同一张图在 2020 年是惊艳，在 2026 年是俗套。 |
| 中间派（prompt 论） | danpasca / TheOtherHobbes | 模型能做对，问题在用户不知道要什么。给具体风格名就能跳出默认。 |
| 反 AI 类比的警惕 | afavour / p-e-w | 反 AI 是普遍情绪，反疫苗只是少数人；类比只会让讨论更分裂。 |

---

## 总体情绪

讨论分成两个不太重叠的子话题。审美派关注「图本身够不够好」「模型能不能抓住风格背后的文化」；实用派关注「小活动方本来就没有设计资源，AI 是填补空缺而不是取代设计师」。两边都有合理论据，也都没有说服对方。

真正值得记住的是 ACCount39 的「饱和」论：单张图并不一定比人类设计师差，但当一个风格一年里被生成几十亿次之后，它就从「新颖」变成「廉价」。这不是模型的缺陷，是曝光的代价。文章给出的解法——给具体风格名、让模型在窄空间里发挥——技术上成立，但它绕开了一个更根本的问题：未来 90% 的 AI 海报用户根本不会去写那么长的 prompt，他们要的就是「默认按钮」。把宝押在「大家都学会写好 prompt」上，跟把宝押在「大家都学会欣赏设计」一样乐观。

---

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | AI-generated posters don't have to be horrible | https://news.ycombinator.com/item?id=49764791 |
| 2 | Poster Prompts 风格目录（博客附属资源） | https://john.hartnup.uk/poster-prompts/ |

---

<div class="disclaimer">
本文为 HN 热门讨论的摘要，所有引文与观点均来自 HN 用户。立场不代表本站观点，事实部分以原文为准。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
