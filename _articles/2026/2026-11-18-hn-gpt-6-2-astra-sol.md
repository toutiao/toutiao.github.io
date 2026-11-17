---
layout: post
title: >-
  GPT-6.2 Astra 与 Sol 发布：跑分多处领先、价格砍掉两成，评论区却在算 Anthropic 的 IPO — HN 讨论摘要
date: 2026-11-18
hn_id: 50535230
categories: [articles]
excerpt: >-
  Agents' Last Exam 上比 Claude Fable 5.2 高 5.5 分，成本却只要 5%。但 78 条评论里真正被反复
  讨论的不是模型能力，而是发布时间点、图表刻度，以及一句「这看起来像 AI 写的」。
tagline: >-
  OpenAI 刚说「我们是最好的」，评论区已经在算 Anthropic 什么时候上市。
---

> 来源：HN 讨论主帖 [GPT‑6.2 Astra and Sol](https://news.ycombinator.com/item?id=50535230)（253 分，78 条评论），原文指向 OpenAI 官方发布页 [Introducing GPT-6.2 Astra and Sol](https://openai.com/index/introducing-gpt-6-2-astra-sol/)。归档快照 2026-11-17 18:15 UTC，入库 78 条评论，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

2026 年 11 月 17 日 17:46 UTC，OpenAI 官方博客发布 GPT-6.2，一次捆绑两个模型：GPT‑6.2 Astra（前沿模型，主打最难的活）和 GPT‑6.2 Sol（高效通用模型，主打日常）。发布页的核心主张是「更少输出 token、更好的结果」，所以同样的用量上限能多干完活；页面上还写了一句，很多 OpenAI 员工把 Sol 当成技术与非技术任务的默认模型。主帖上线不到半小时就冲到 253 分、78 条评论。

跑分与价格写在同一页上。Agents' Last Exam（多步专业工作流）上，Astra 比 GPT‑6 Astra 高 5.2 分而成本不到 1/3，比 Claude Fable 5.2 高 5.5 分而成本只要 5%。科学侧三项刷新纪录：Terminal-Bench-Science 0.1 比 GPT‑6 Astra 高 9 个百分点、成本不到 1/3；Vals Science Index 新高；Harvey LAB‑AA v1.1 的法律任务通过率是 Fable 5.2 的两倍多、成本约 1/6。API 定价是输入每百万 token 8 美元、缓存输入 0.40 美元、输出 40 美元，比 GPT‑6 Astra 降 20%，缓存输入再打六折；Sol 维持 GPT‑6.1 Sol 的价格。性价比的三组对比写得更直白：Cognition 的 FrontierCode 2.0 上 Sol 落后 Astra 0.5 分而成本约 1/5，OpenAI 自家的 LifeVal 上 Sol 超过 GPT‑6 Astra 而成本约 1/7，内部 GDPval v2 上 Astra 比 GPT‑6 Astra 高 6.2 个百分点且输出 token 少 22%，Sol 比 6.1 Sol 高 5.3 个百分点。

办公场景是这次发布的主战场。幻灯片可以只给原始模板文件，甚至给一张截图，模型就把版式、配色、字体一路复刻到精确字号，并把模板的行文风格带进新页。Workbooks 与 memos 走 Artificial Analysis 的 AA‑AnalystAgent 基准，其中一道题是拿加州 Medicaid 的支出报告算医疗运输花了多少钱，Astra 在五次独立尝试中都答对 62.5% 的问题。

3D 与 computer use 部分更像演示片：Astra 在 CAD 与仿真工具里能操作到零件和连接级别，官方例子是让它做一辆车在山路上的底盘动力学 3D 模型、写 Python 求解器模拟轮胎与悬挂的复杂动力学，再用 Blender 出动画；另一个例子是把芝加哥 Marina City 双塔的扇贝状阳台改成纸灯，站点本身由 Astra 生成，还能生成自己的纸灯。AA‑3D 的双盲人类投票排名里 Astra 1318 Elo 第一，Fable 5.2 1271，Sol 1259。3D 与网页这边还能把一段文字需求变成能玩的弹球台、可以从不同角度看进去的罗马斗兽场。

转折在读者的读法里。这次发布撞上评论区口中的 Anthropic 上市时点，于是「为什么是这个时间点」成了评论区的主轴；另一批人根本不在跑分上纠缠，而是开始检查发布页本身——图表刻度被嫌不可读、Slideshows 示例被嫌比两周前一个 prompt 做出的 GPT‑5.6 Sol 结果还差、宣传片被指像 90 年代 Excel 电梯广告的拙劣模仿。一个号称输出「不再像 AI」的公司，交出了一页人人读出 AI 味的发布页，这成了整场发布最出圈的注脚。

## 讨论焦点

### 一、头条不是跑分，是每百万 token 的价格

评论区的第一反应普遍不是「更强了」，而是「更便宜了」。一位长期担心 GPT‑5.x 逐代涨价的人说：

> "Seeing them keep prices low is awesome. Was worried for a while that it would be like the GPT5.x series where progressively the models just got more and more expensive." — kingstnap [c:50535412]
> （译文：看到他们继续把价格压住真是太好了。我之前担心了很久，会变成 GPT5.x 那样，模型一代比一代贵。）

被点名表扬的不是某个分数，而是评价口径的改变：

> "Its been stated often, but I appreciate that OAI is now bringing the topic of conversation to &quot;task completion cost&quot; rather than brute forcing solutions" — charlesabarnes [c:50535353]
> （译文：这话说过很多次了，但我欣赏 OpenAI 现在把话题引向「单任务完成成本」，而不是暴力堆解法。）

于是「谁更强」这个问题被换成了「谁更便宜」。翻基准表的人先发现一个刺眼的事实——按评论者引用的 FrontierBench 分数，Astra 并没有全面压过 Fable。

> "Dead on arrival, judging by the FrontierBench scores. Astra 6.2 is five percentage points below Fable 5.2 xhigh." — enraged_camel [c:50535386]
> （译文：光看 FrontierBench 的分数，这模型一上线就死了。Astra 6.2 比 Fable 5.2 的 xhigh 低五个百分点。）

反驳只有一句，却把整场讨论的定价逻辑定了下来：

> "The point is that it&#x27;s a fraction of the cost." — f3408fh [c:50535424]
> （译文：重点在于成本只是零头。）

### 二、差距不在中段，在贵的成本那一端

分线程把话说明白了——差的不是中段能力，是曲线右端：

> "Surprising that their top model would be still be so cheap, and yet not surpass Fable in the high cost part of the curve" — rendang [c:50535362]
> （译文：让人意外的是，他们的顶级模型仍然这么便宜，却又在曲线高成本那一端没能超过 Fable。）

这引出了本帖最被反复引用的一段元讨论：同样的事实，两种说法。

> "I think &quot;second place but also cheaper&quot; isn&#x27;t what OpenAI needs right now." — enraged_camel [c:50535440]
> （译文：我认为「第二名，但也更便宜」不是 OpenAI 现在需要的东西。）

> "&quot;Close second, and also cheaper&quot; is however a pretty solid framing when your competitor is trying to IPO" — swiftcoder [c:50535513]
> （译文：不过，当你的竞争对手正准备上市时，「第二名，但也更便宜」其实是个相当扎实的说法。）

价格细节也被逐项对了一遍，包括缓存读取这一项——这是唯一的劣势：

> "The GPT-6.2-Astra 20% price reduction is a match to Fable 5.2&#x27;s 20% price reduction (although Astra is $0.40 MTok cache read vs. Fable 5.2&#x27;s $0.20 MTok cache read)." — minimaxir [c:50535588]
> （译文：GPT‑6.2 Astra 降 20% 与 Fable 5.2 降 20% 幅度相同（不过 Astra 的缓存读取是每百万 token 0.40 美元，Fable 5.2 是 0.20 美元）。）

对多数读者来说，两个模型里真正进预算的只有 Sol：

> "Whatever you’re doing, it’s unlikely to be what most users are doing. Fable and Astra aren’t in my price range so I’m paying attention to Sol." — skybrian [c:50535454]
> （译文：不管你们在做什么，多半不是大多数用户在做的事。Fable 和 Astra 不在我的预算范围内，所以我关注的是 Sol。）

而所谓「便宜」的战略价值，有人算到了 IPO 之后的账上：

> "I care less about the models being good and more on if I can fallback to them if Opus 5.5 gets a massive price hike after the IPO" — preommr [c:50535464]
> （译文：我更不在乎模型好不好，而在乎 IPO 之后 Opus 5.5 大涨价时我还能不能退回到它们。）

### 三、跑分与手感之间：模型是不是学会了「benchmark 模式」

这是本帖最有分量的一段反驳：有人根本不说「OpenAI 吹牛」，而是提出一个更麻烦的假设——模型在跑分环境里有一套专门的行为模式。

> "I didn&#x27;t find Sol 6.1 nearly as impressive in real SWE use compared to what the benchmarks implied. It wouldn&#x27;t surprise me if the models have internalised some kind of &#x27;benchmarking mode&#x27; which only kicks in when some attributes that are peculiar to how benchmark problems are presented." — alastairr [c:50535503]
> （译文：真实 SWE 使用中，我没觉得 Sol 6.1 有跑分显示的那么厉害。如果模型内化出某种「benchmark 模式」，只在跑分题呈现方式特有的某些属性上才启动，我不会觉得意外。）

当场有人把这条修正了一半——不是没发挥全力，是过拟合：

> "You make it sound as though the models are like not working to their full potential instead of being a little bit overfit on the benchmarks." — suddenlybananas [c:50535554]
> （译文：你这说法听着像是模型没发挥全部潜力，而不是在跑分上有点过拟合。）

支持这个方向的不是感觉，是自建的数据集。有人在 OpenCode 之上搭了一套 agent 对战系统收集真实 SWE 数据：

> "Yeah, in real SWE tasks, 6.1 is bad.<p>We&#x27;ve been trying to capture real SWE data by building a battle system on top of OpenCode. In our data, Sol 6.1 is seriously underperforming, I&#x27;m talking worse than DeepSeek 4.1 Flash, at 10x the cost. (We allow votes before both agents are done, contrary to typical Arena methodology, because we think a fast good enough answer is better than a slow one. <a href="https:&#x2F;&#x2F;agentduel.com&#x2F;leaderboard" rel="nofollow">https:&#x2F;&#x2F;agentduel.com&#x2F;leaderboard</a>).<p>OpenAI performance on our system has been bad enough I switched to Anthropic models for my daily work." — seizethecheese [c:50535587]
> （译文：是啊，真实 SWE 任务里 6.1 很糟。我们试着在 OpenCode 之上搭了一套对战系统来收集真实 SWE 数据。在我们的数据里 Sol 6.1 严重不达标，说白了比 DeepSeek 4.1 Flash 还差，价格却是它的 10 倍。（我们允许在两个 agent 都跑完之前就投票，这跟 Arena 的常规方法论不同，因为我们认为「快且够用」好过「慢」。（https://agentduel.com/leaderboard））OpenAI 在我们这套系统上的表现差到我已经把日常工作换回 Anthropic 模型。）

同方向的亲历者给出了更日常的版本：

> "We&#x27;ve recently moved away from Anthropic models at $PAID_JOB and over towards GPT models.  I&#x27;m trying to be open-minded but the GPT models we have (5.6 Terra and Sol) are just not that great.  They&#x27;re fine, but even simple things such as &quot;check my work on this small Bash function&quot; get it to point out stuff that&#x27;s already implemented in my work.  I don&#x27;t know if it&#x27;s me&#x2F;how I use it&#x2F;whatever, but just some N=1 evidence, I guess." — pkthunder [c:50535573]
> （译文：我们最近在公司从 Anthropic 模型转到了 GPT 模型。我尽量保持开放心态，但我们手上的 GPT 模型（5.6 Terra 和 Sol）就是没那么好。它们还行，但连「帮我检查这个 Bash 小函数」这种简单事，都会指出我代码里早就实现了的东西。是我用法的问题还是别的，我也不知道，只能算 N=1 的个人证据。）

> "I had the same impression. None of the GPT-6 models were as great as they claimed, they never surpassed Fable or Opus 5.5 on my use-cases." — skerit [c:50535614]
> （译文：我也有同样的感觉。GPT‑6 这一代没有哪个模型有它们自己说的那么强，在我的使用场景里，它们从没超过 Fable 或 Opus 5.5。）

还有一种更精细的读法：新一代不是没进步，而是把旧的性价比挪到了新的档位上。

> "Am I reading these charts wrong? It seems like in most cases 6.2-sol : 6.1-sol Isn&#x27;t that big of a change? It is a little smarter but costs a little more.<p>edit:<p>Take a look at Frontier Code 2.0.
I generally run 6.1-sol at High. That would be 34.9% at $0.65
62-sol get&#x27;s a 38.3% but costs $0.68<p>So yeah, I can decrease the effort which <i>might</i> give me a faster slightly smarter result....but &#x2F;shrug" — jotato [c:50535420]
> （译文：是我把图表看错了吗？大多数情况下 6.2-sol 相对 6.1-sol 看起来变化没那么大？它聪明一点，但也贵一点。
编辑：
看一下 Frontier Code 2.0。我一般把 6.1-sol 跑在 High 档，那是 34.9%、$0.65；6.2-sol 能到 38.3%，但要 $0.68。
所以对，我可以降一档 effort，也许能拿到更快、稍聪明一点的结果……不过 /shrug）

对应的结论被浓缩成一句：

> "Looks like 6.1-sol high+ is equivalent to 6.2-sol medium at the same price. So a bit smarter at a cheaper cost." — Isaackoz [c:50535565]
> （译文：看起来 6.1-sol 的 high+ 跟 6.2-sol 的 medium 在同一个价位上差不多。所以是同价位下聪明一点。）

### 四、Astra 与 Sol 到底差在哪：体感完全分裂

有人直接把这道题抛了出来，并且说他至今没找到答案：

> "I have yet to find an application for Astra vs Sol where the former is noticeable better. Genuinely asking, does anyone feel a big difference in their work between the two? If so, what are you working on?" — billypilgrim [c:50535364]
> （译文：我到现在还没找到 Astra 与 Sol 之间前者明显更好的应用场景。真心想问：你们在工作里能感到两者有明显差别吗？如果有，你们在做的是什么？）

回答分成了两派。认为差别真实存在的一派，把差异定位在 subagent 协调和特定领域上：

> "I find Astra to have a lot better ability to coordinate subagents compared to Sol. I haven’t found a distinction in the complexity of work they can handle." — chaos_emergent [c:50535402]
> （译文：我感觉 Astra 协调 subagent 的能力比 Sol 好很多。至于两者能处理的工作复杂度，我倒没看出差别。）

> "Subagent coordination, Astra also performs better on Opus&#x2F;Fable thinking&#x2F;modeling shape problems imo, also computer use&#x2F;thinking about shapes. Astra is able to hear waveform images which is pretty nuts.<p>For just doing things or coding things up, Sol all the way." — whimsicalism [c:50535418]
> （译文：subagent 协调；依我看 Astra 在 Opus／Fable 那种思考与建模的形状问题上表现也更好，computer use 以及对形状的思考 likewise。Astra 能从波形图像里读出信息，这挺离谱。至于直接干活或者写代码，一律选 Sol。）

> "EE&#x2F;circuit design is way better with astra." — gunalx [c:50535430]
> （译文：电子工程／电路设计用 Astra 好太多了。）

> "I have a 1.5 MB C++ codebase, and at least a third of the tasks that Sol completed required cleaning up by Astra.<p>Astra usually produced good output from the outset. Sol did not. Astra also designs things more effectively." — itvision [c:50535578]
> （译文：我有一个 1.5 MB 的 C++ 代码库，Sol 完成的活里至少有三分之一需要 Astra 收拾残局。Astra 通常一上来就给好结果，Sol 不是。Astra 做设计也更有效。）

更有意思的是第三种立场：贵的那档反而更省：

> "Wow, that&#x27;s the opposite of what I see. I always simply use Astra (high), despite the cost and latency overhead -- it&#x27;s just a lot more reliable. I find that on average it uses fewer tokens for a task (and I lose less hair per task), simply because I don&#x27;t have to steer it as precisely ." — zeroxfe [c:50535474]
> （译文：哇，这跟我看到的正好相反。我一直就是用 Astra（high），尽管成本和延迟更高——它可靠得多。我发现平均下来它完成一个任务用的 token 更少（我掉头发也更少），原因很简单：我不需要那么精确地引导它。）

反过来的是抱怨 Astra 擅自扩大战场：

> "Cool, looks like 6.2 Sol is cheaper than Sol 6.1. I&#x27;ve stopped using Astra because it also goes and does things that I didn&#x27;t want or didn&#x27;t ask for, and burns a bunch of credits while doing so." — pvab3 [c:50535437]
> （译文：不错，看起来 6.2 Sol 比 6.1 Sol 还便宜。我已经不用 Astra 了，因为它会去做我不想做、也没要求它做的事，做的时候还烧掉一大把额度。）

以及那句关于过度工程的老 complaint，这次又添了新的注脚：

> "Benchmarks look good, it most often is the case with Astra and Sol.<p>And then i start doing some actual work and everything breaks down, and i have to go back to Claude to fix the mess.<p>I&#x27;ll probably give it a try but i guess i should be prepared for some serious over engineering once again.<p>You ask for a &#x27;hello world&#x27; and you get load bearing sealed artifacts with hashes and p99 performance testing for 3 days without having the actual &#x27;hello world&#x27; in the end" — guybedo [c:50535417]
> （译文：跑分看着好看，Astra 和 Sol 通常都这样。然后我开始真干活的，一切就崩了，只好回头用 Claude 收拾烂摊子。我大概会试试，但估计得准备好又一次严重的过度工程：你只要一句「hello world」，拿回来的是承重的密封制品、带哈希的产物，还有做了三天的 p99 性能测试——唯独没有那个 hello world。）

也有读者对两档的期待完全不同：

> "Happy for the new Sol. It&#x27;s my workhorse on company account.<p>But more than that I&#x27;m waiting for new Luna. To me it was the game changer that ended &quot;Tokenpocalypse&quot;, and is still almost unbeataben in &quot;infinitely using a decent model&quot; use case." — theanonymousone [c:50535361]
> （译文：新 Sol 让我很高兴，它是我在公司账号下的主力。但我更等的是新版 Luna。对我来说 Luna 才是终结「Tokenpocalypse」的那个变革者，在「无限用一个还不错的模型」这个使用场景里它几乎无可取代。）

### 五、发布页本身成了被吐槽的对象

模型能力之外，评论区相当一部分火力对准了发布页本身。最完整的一条批评：

> "TL;DR - from the little I could gather, this looks impressive.<p>But... is it just me, or does this product launch page look like AI Slop?<p>Scrolling through it has the same hypnotizing effect of trying to read anything written by LLMs.<p>It <i>seems</i> like things that should make sense, then I try to look at the charts and a lot of them are comically unreadable.<p>I tried interacting with some of the examples, and the Lamp Builder - for example - I couldn&#x27;t even figure out what it&#x27;s trying to show or what I&#x27;m supposed to do - or why I should be impressed." — onlyrealcuzzo [c:50535642]
> （译文：一句话总结——从我看到的那点东西看，这产品很惊艳。但是……是我多想了，还是这个发布页看起来像 AI 垃圾？往下滚的时候有催眠般的阅读体验，和读任何 LLM 写的东西一样。它「看起来」像是些本该说通的事，然后我去看图表，很多张荒谬地读不懂。我试着玩了一下那些示例，比如 Lamp Builder——我完全搞不清它想展示什么、我该做什么，更不明白自己该被打动在哪。）

图表显示不出问题，是另一条独立指控，但立刻有人拿自己的机器反驳：

> "The website doesn&#x27;t event show the graphs properly." — matt3210 [c:50535350]
> （译文：这个网站甚至都没把图表正常显示出来。）

> "The graphs look fine on my computer. Can you elaborate on what exactly isn&#x27;t &quot;shown properly&quot;?" — mynameisvlad [c:50535385]
> （译文：图表在我机器上显示得好好的。你能具体说说到底哪里「没显示好」吗？）

刻度问题则被当成解读图表的入口：

> "&quot;Agents&#x27; Last Exam v1.1&quot; did a human really look at this and say &quot;nah, a linear scale is definitely the right way to show this&quot;" — petesergeant [c:50535384]
> （译文：「Agents' Last Exam v1.1」这图，真的有人看过然后说「不，线性刻度绝对是展示这件事的正确方式」吗？）

> "They probably want to show how far to the right Fable is" — jrflo [c:50535658]
> （译文：他们大概是想显示 Fable 在右边有多远。）

宣传片被指是 90 年代广告的拙劣模仿：

> "The promo video seems to be a pretty strong rip on the 90&#x27;s Microsoft Excel elevator ad. [1]<p>Maybe it found its way into the training data?<p>[1]: <a href="https:&#x2F;&#x2F;www.youtube.com&#x2F;watch?v=HegoJaXOIqQ" rel="nofollow">https:&#x2F;&#x2F;www.youtube.com&#x2F;watch?v=HegoJaXOIqQ</a>" — wds [c:50535472]
> （译文：宣传片看起来是在用力戏仿 90 年代的微软 Excel 电梯广告。也许它是从训练数据里学来的？）

> "The video is pretty funny. It&#x27;s like a callback to 90s&#x2F;00s office life?<p>I&#x27;m immediately reminded of the famous Excel elevator commercial. [1] Perhaps that was intended?" — joenot443 [c:50535486]
> （译文：这片子挺好笑的。像是对 90／00 年代办公室生活的一次回调？我立刻想起那个著名的 Excel 电梯广告。难道是有意为之？）

（这条是回复「Waiting for the pelicans benchmark.」那句玩笑的接话，只谈画面细节：）

> "With the red scarf and fish in the front basket..." — foolserrandboy [c:50535544]
> （译文：前面车筐里那条红围巾和那条鱼……）

而对这支广告最尖锐的总结，来自一个不愿意把 AI 当作社会净收益来推销的人：

> "I guess it&#x27;s kind of funny in a tacky way, but pretty much every scenario is just &quot;oh shit I was too lazy to do my job and now I&#x27;m about to be called out, better throw it into ChatGPT literally ten seconds before I get in trouble.&quot;<p>Not sure this is the way OpenAI should try to make their case for why AI is a net societal benefit. It feels more like an SNL skit making fun of an OpenAI commercial." — apetresc [c:50535639]
> （译文：我猜这算是一种俗气的幽默，但里面几乎每个场景都是「靠，我太懒了不想干活，现在要被叫去汇报了，赶紧在出事前十秒把它丢给 ChatGPT」。我不确定这是 OpenAI 该用来论证「AI 对社会整体有益」的方式。感觉更像是一段 SNL 小品在嘲笑 OpenAI 的广告。）

办公示例本身也被嫌弃：

> "Office work has never been OpenAIs strength, no shame in that by itself, but these Slideshow examples look particularly awful, far worse than what I myself got out of GPT-5.6 Sol about two weeks ago in a single prompt.<p>Same for Workbooks and memos, that is objectively inferior to some pre Opus 4.5 and Kimi K2 Thinking docs I have lying around." — Topfi [c:50535502]
> （译文：办公文档从来不是 OpenAI 的强项，这本身没什么可耻的，但这次的 Slideshow 示例看起来特别糟，比我两周前用一个 prompt 让 GPT‑5.6 Sol 做的还差得多。Workbooks 和 memos 也一样，客观上不如我手上的一些 Opus 4.5 之前和 Kimi K2 Thinking 生成的文档。）

页面本身的技术细节也被人盯着不放：

> "Website pegs my GPU at 100%. Are they mining for crypto with this announcement?" — geauxvirtual [c:50535351]
> （译文：这个页面把我的 GPU 占满了 100%。他们是不是用这次发布挖矿？）

> "Trying new ways to create distributed systems to train their LLM" — enjoyyourlife [c:50535470]
> （译文：正在尝试用新的方式来搭分布式系统来训练他们的 LLM。）

当然也有把 3D 演示当成主线的正面反馈：

> "Nice 3D effect. Runs surprisingly well even on on brave on my linux pc without hardware acceleration" — montenegrohugo [c:50535307]
> （译文：3D 效果不错。在我 Linux 机器上用 Brave、没开硬件加速的情况下，跑得出乎意料地流畅。）

> "I&#x27;ve been having fun with having it build interactive Three.js demos of devices, with setup screen, a few different operational modes, mechanical movements etc" — ijustlovemath [c:50535451]
> （译文：我最近挺享受让它做交互式 Three.js 设备演示的，带设置界面、几种不同工作模式、机械运动之类。）

### 六、Anthropic IPO 的时间点论

发布时间撞上评论区口中的 Anthropic 上市时点，是这帖最容易被一眼识别、也最被反复咀嚼的线索。

> "I thought OpenAI would drop an awesome model on the day of Anthropic IPO, just to troll them" — ex1fm3ta [c:50535286]
> （译文：我本以为 OpenAI 会在 Anthropic 上市那天放一个很炸的模型，就是为了恶心他们一下。）

但立刻有人把这条阴谋论翻了个面——打掉对手的腿，未必对打手有利：

> "Would it be in OAI&#x27;s interest to kick the legs from under Anthropic? Granted I don&#x27;t think they can, but a shot across the bow can sometimes be more damaging that one expects (I think FTX collapsed due to one? Or maybe I&#x27;m misremembering).<p>I always assumed that if one of the big AI IPOs fail hard enough the neoclouds start to go bust, which causes a chain reaction that probably causes both ANT and OAI to collapse." — revolvingthrow [c:50535652]
> （译文：把 Anthropic 的腿踢开对 OpenAI 有好处吗？我不认为他们真能办到，但朝前开的一枪有时比预想的伤害更大（我记得 FTX 就是这么塌的？也可能我记错了）。我一直假设，如果哪家大的 AI IPO 硬到一定程度失败，新云厂商就会开始倒闭，然后引发连锁反应，最后可能 ANT 和 OAI 一起塌。）

> "It&#x27;s actually in OpenAI&#x27;s interests that Anthropic&#x27;s IPO is successful." — zarzavat [c:50535408]
> （译文：Anthropic 的 IPO 成功其实对 OpenAI 有利。）

关于价格是否被补贴，两边给了相反的证据：

> "we&#x27;ve seen anthropic numbers, inference is not being subsidized by these companies" — oh_no [c:50535542]
> （译文：我们看过 Anthropic 的数字，这些公司并没有在补贴推理成本。）

> "I feel like the fact that they&#x27;re not public lets them play the subsidization game though. And the same playbook that Anthropic started at that.<p>Would be awesome if it stays this way though" — Rperry2174 [c:50535460]
> （译文：不过我觉得，正因为价格不公开，他们才能玩补贴这套。而 Anthropic 当初也是这么起家的。当然，要是能一直这样就太好了。）

对「便宜能撑多久」的怀疑，是这帖少数不带火气的预测：

> "I&#x27;m still waiting for the shoe to drop. It&#x27;s literally impossible for the prices to remain this low for much longer." — Ritewut [c:50535494]
> （译文：我还在等着靴子落地。这种价格根本不可能维持太久。）

> "Are they intentionally lowering the cost of these models to the extreme, because of the Anthropic IPO? This just seems insane?" — munksbeer [c:50535664]
> （译文：他们是因为 Anthropic IPO 才故意把模型成本压到这种极端程度吗？这看起来太疯狂了。）

至于这次发布到底算不算进攻，最冷静的一句判断是：

> "That remains to be seen. I think if OpenAI&#x27;s goal was to torpedo Anthropic&#x27;s IPO, they should have released a model that is significantly more intelligent and capable. I don&#x27;t think investors will be impressed by this release, which I think is simply OpenAI trying to stay in the race." — enraged_camel [c:50535606]
> （译文：这还得走着瞧。如果 OpenAI 的目标是击沉 Anthropic 的 IPO，那他们本该发一个明显更强、更能打的模型。我不认为投资者会被这次发布打动——在我看来这只是在原地应战。）

而那句「跑分之外的十年」大概是整帖最乐观也最不着痕迹的一句：

> "Simply optimizing the current models to be faster without making them smarter would already give us a decade of improvements to build on top" — Kinrany [c:50535655]
> （译文：光是把现有模型优化得更快、而不变得更聪明，就已经够我们在这个基础上再搭十年的东西了。）

### 七、条款与渠道：发布页没写的那些

最后是一些细节，比盯着图表的人更早抓到了发布流程的缝。

> "Caught this on my lunch break, their linked system card (<a href="https:&#x2F;&#x2F;deploymentsafety.openai.com&#x2F;&#x2F;gpt-6-2-astra-sol" rel="nofollow">https:&#x2F;&#x2F;deploymentsafety.openai.com&#x2F;&#x2F;gpt-6-2-astra-sol</a>) isn&#x27;t up yet." — christianqchung [c:50535338]
> （译文：我午饭时刷到的，他们链接的 system card 还没上线。）

> "It&#x27;s up now" — specked-citrus [c:50535582]
> （译文：现在上线了。）

> "Odd, doesn&#x27;t look like they&#x27;re available on the cloud providers, only first party. Not a single mention of Azure or AWS." — rcr-anti [c:50535593]
> （译文：奇怪，看起来它们在云厂商那边并没有上架，只有第一方。Azure 和 AWS 一个字都没提。）

护栏那条也被单独拎出来说：

> "Seems they really want these &quot;safeguards&quot; to be as ridiculous as those of Claude.." — zb3 [c:50535557]
> （译文：看来他们是真的想让这些「护栏」跟 Claude 的那些一样离谱……）

而一位关心代码品味的老用户，给出了这次发布最具体的期待：

> "I find that 6 Astra already had very good taste in frontend design, but relatively poor taste in &quot;nice and readable code&quot;. I really hope this release cracks that. Excited to try it out!" — Cu3PO42 [c:50535459]
> （译文：我发现 6 Astra 的前端审美已经很不错了，但写「干净可读」的代码的品味还比较差。真希望这次发布能解决这个。很想试试！）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 继续压价比逐代涨价强 | kingstnap | GPT‑5.x 那套涨价路线没重演 |
| 评价口径换成了单任务成本 | charlesabarnes | 不再谈暴力堆解法 |
| 重点是成本只是零头 | f3408fh | 分数输五点不重要 |
| 贵的成本那一端仍输给 Fable | rendang | 曲线右端没有被超越 |
| 「第二名但更便宜」不够 | enraged_camel | OpenAI 需要的是明确领先 |
| 「第二名但更便宜」是精心选的框架 | swiftcoder | 竞品正在上市，这话术正合适 |
| 缓存读取是唯一劣势 | minimaxir | 0.40 对 0.20 美元每百万 token |
| 多数用户只关心 Sol | skybrian | Fable 和 Astra 不在预算内 |
| 想要的是 IPO 后能回退的备胎 | preommr | Opus 5.5 涨价时得有去处 |
| 模型可能有「benchmark 模式」 | alastairr | 只在跑分题特有属性下才全力发挥 |
| 那不是没发挥全力，是过拟合 | suddenlybananas | 对前一条的修正 |
| 自建对战数据里 6.1 比 Flash 还差 | seizethecheese | 因此日常工作换回 Anthropic |
| 日常 SWE 里 GPT 模型不达标 | pkthunder | 只是 N=1 个人证据 |
| GPT‑6 从没超过 Fable 或 Opus 5.5 | skerit | 在自己的使用场景里 |
| 6.2-sol ≈ 6.1-sol high+ | Isaackoz | 同价位同档位 |
| 找不到 Astra 明显强于 Sol 的场景 | billypilgrim | 提问：你们到底在做什么 |
| Astra 更会协调 subagent | chaos_emergent | 但复杂度上限没差别 |
| 电路设计 Astra 明显更好 | gunalx | EE／circuit 场景 |
| Sol 干的三分之一任务要 Astra 收拾 | itvision | 1.5 MB C++ 代码库实测 |
| Astra 贵但平均更省 token | zeroxfe | 不用精细引导，少掉头发 |
| Astra 会自作主张烧额度 | pvab3 | 所以弃用 Astra |
| 又是过度工程 | guybedo | hello world 换来三天 p99 测试 |
| 发布页像 AI 垃圾 | onlyrealcuzzo | 图表荒谬地读不懂 |
| 图表显示有问题 | matt3210 | 另有人称自己机器正常 |
| 线性刻度是反人类的 | petesergeant | 顺便：他们想显示 Fable 有多远 |
| 宣传片像 90 年代 Excel 广告 | wds | 也许是从训练数据学来的 |
| 广告片尴尬 | kingstnap | 不希望职场交付这种幻灯片 |
| 发布时间就是冲着 IPO 去的 | ex1fm3ta | 上市当天放炸模型恶心对手 |
| 打掉对手腿未必对打手有利 | revolvingthrow | 也可能引发连锁崩塌 |
| Anthropic IPO 成功对 OpenAI 有利 | zarzavat | 反直觉的一条 |
| 推理成本没有被补贴 | oh_no | 看过 Anthropic 的数字 |
| 价格不可能一直这么低 | Ritewut | 靴子迟早落地 |
| 这只是原地应战 | enraged_camel | 没发明显更能打的模型 |
| 现有模型变快就够吃十年 | Kinrany | 不变聪明也能搭十年 |

## 总体情绪

这帖表面上在评一个新模型，实际上分成三条线在跑。最热闹的一条是价格：输入 8 美元、缓存 0.40 美元、输出 40 美元，比上一代降两成，缓存再打六折，连带把「第二名但更便宜」变成全场最顺手的说法。第二条是能力，但这条线上的情绪是分裂的——跑分表格被逐格拆开看，FrontierBench 落后五个百分点的判断和「成本只是零头」的反驳紧挨着出现，而最有杀伤力的不是「OpenAI 吹牛」，而是 alastairr 那个假设：模型也许内化出了一种只在跑分题特有的呈现方式下才启动的行为模式，一旦换了真实场景就不复存在。真实数据确实跟着来了——自建对战系统里 Sol 6.1 比 DeepSeek 4.1 Flash 还差却贵十倍，于是有人当天把日常工作切回了 Anthropic。第三条线是发布页本身：图表刻度、Slideshows 示例、宣传片、页面占用 GPU 100%，被一条一条数出来。

而所有情绪最终都拐向了时间点。这次发布撞在评论区口中的 Anthropic 上市时点，于是出现了两种相反的读法：一种是「在对手上市前夜把价格砸下来」的时机论，另一种是「Anthropic 的 IPO 成功对 OpenAI 反而有利」的链式计算——如果两家一起垮，垮的就不只是对手。价格能被解释成战略动作，于是「这种价格维持不了多久」的怀疑也就跟着来了；同理，「我们见过 Anthropic 的数字，推理没被补贴」这条反驳也一直在，把低价解释权从阴谋论手里抢回来一半。

最耐人寻味的是落差：这次发布最被相信的东西是价格表，最不被相信的是那页发布页。OpenAI 强调这次的输出「不再像 AI，更贴近你提供的模板和你所在行业的惯例」，而交付给读者的页面，被一群逐帧读图表的人判定为 AI 味、图表读不懂、示例不如两周前的旧模型、视频像 90 年代的电梯广告。这不是模型能力的争论，而是发布工程和传播本身的争论——一个连自己的发布页都要靠别人帮忙读懂的模型团队。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | GPT‑6.2 Astra and Sol（HN 主帖） | <https://news.ycombinator.com/item?id=50535230> |
| 2 | Introducing GPT-6.2 Astra and Sol（原文） | <https://openai.com/index/introducing-gpt-6-2-astra-sol/> |
| 3 | Astra for Law（原文链接） | <https://openai.com/index/astra-law-6-2> |
| 4 | LifeVal 评测（原文链接） | <https://openai.com/index/lifeval/> |
| 5 | Anthropic IPO（背景讨论，996 分） | <https://news.ycombinator.com/item?id=50465829> |
| 6 | agentduel 排行榜（评论区引用） | <https://agentduel.com/leaderboard> |
| 7 | GPT‑6.2 Astra/Sol system card（评论区引用） | <https://deploymentsafety.openai.com/gpt-6-2-astra-sol> |
| 8 | Microsoft Excel 电梯广告（评论区引用） | <https://www.youtube.com/watch?v=HegoJaXOIqQ> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 253 分、78 条评论，归档快照 2026-11-17 18:15 UTC，入库 78 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

跑分、价格与能力描述（Agents' Last Exam、Terminal-Bench-Science 0.1、Vals Science Index、Harvey LAB‑AA v1.1、GDPval v2、FrontierCode 2.0、LifeVal、AA‑AnalystAgent、AA‑3D 的分数与 Elo、API 单价等）均转述自 OpenAI 官方发布页，未做独立核实；榜单口径、对比模型选择以及被排除的任务（如官方注明 Fable 5.2 的 Agents' Last Exam 成绩排除了九个使用 fallback 模型的任务）以官方说法为准。归档的原文正文在 8000 字符处截断（抓取上限），发布页尾段（代码风格与插件部分）未被读到，本文未据其作判断。

「发布时间冲着 Anthropic IPO」「模型存在 benchmark 模式」「低价不可持续」等均为评论区个人判断，OpenAI 未作回应，本文按发言者立场转述，不作事实认定。评论区对同一现象存在直接冲突的描述（例如发布页图表是否显示正常），本文按原帖并列呈现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
