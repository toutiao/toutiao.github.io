---
layout: post
title: >-
  「我们该更有野心一点」：AI 把软件野心从一年压到几小时 — HN 讨论摘要
date: 2026-10-26
hn_id: 50225695
categories: [articles]
excerpt: >-
  一个 JS 引擎四个月跑赢 V8，一个 Postgres 重写项目顺手挖出五个真 bug。同一件事，评论区一半在喊
  「AI 是我的喷射背包」，另一半在数自己还剩几个月房贷。
tagline: >-
  过去要一年才敢想的事，现在顺手就做了——代价是另外一半人开始数存款。
---

## 原文概要

Daniel Luu 在博客发了《We should be more ambitious with the software we build》，标题就是一句话的主张：软件，应该写得更大胆一点。这个说法来自他的朋友 Michael Malis——用 Rust 重写 Postgres 的 pgrust 作者。HN 上 663 分、136 条评论。

Luu 先承认了一个偏见：现在满地都是 AI 生成的垃圾项目，如果他不认识 Malis、也没去翻过代码，他也会直接把 pgrust 当成「永远做不成」的 vibeslop。但他认识，所以信任，事后去查，发现 pgrust 的测试挖出了 Postgres 的真 bug——SP-GiST 的数值 bug 会让本来合法的操作失败，JSONPath 的 format cache bug 会给出错误结果，pgcrypto 的 bug 会让后续操作崩掉，字典加载器里还有多个内存安全 bug，外加一个金额溢出 bug。他的结论很克制：pgrust 本身未必成功，但光是这个尝试，Postgres 会以持久的方式变好。

真正的主菜是 Luu 自己那三个「works for me」级别的项目。他的推演起点是：OpenAI 要用 Cerebras 跑 SOTA 模型，比现在快 10 到 100 倍，那么在这台机器上，时间会花到哪？三个答案：ripgrep、编译 Rust、syscall 与文件系统开销。他为此写了一个能针对特定负载调优的正则引擎、一个用该正则引擎原生代码编译器的 ripgrep 分叉（作者承认「文本索引」才是正解，但那个他早年做过了，这次只是好玩）、一个能加快构建的 Rust（冷构建提升巨大，热构建中等，且他不想 fork Rust 编译器前端，所以受限）。文件系统那部分，他只把开发环境从 Mac 换成 Linux 就改善了很多；而当 agent 在密集做小文件操作时，标准 OS 文件系统接口根本没为现代磁盘性能设计过。

账算下来：对于不懂正则、字符串匹配算法、编译器、解释器的人来说，这批项目过去需要一年以上才能到「works for me」的质量；现在花掉他「低个位数的小时」。

Luu 认为问题不在难度，而在成本模型——人们还带着「前 agent 时代」的估算习惯在算账。十年前，会因为编译器慢就自己去写编译器的人，属于「想做什么都另起炉灶、结果什么都发不出来」那一类；现在这类事变得合理了，但他认识的最 productive 的程序员大多仍对这种做法有本能的排斥。他举的另一个例子是棋类 AI：他的 Azul AI 在瓦片匹配上达到超人级，用的是 GPT-5.1/5.2，他零 AI 知识，5 小时做到超人级、20 小时做到当时最强。Gabriel Cangussu 后来做出了碾压它的 AI，按 Luu 说法花的时间明显更少，关键差异之一是 Fable 5.1 和 Opus 5.5 对棋类 AI 的理解好得多——当年 GPT-5.1/5.2 给的建议几乎全是错的，他要不停纠偏。

顺带一提，HN 讨论里排在最前面的一条评论，跟 AI 毫无关系，是在抱怨这篇博客的行长和换行。

## 讨论焦点

### 一、讨论的第一分钟在吵排版

评论区最前面几条是关于网页排版的：有人建议定下行长和换行规则，也有人直接反对。layer8 把这件事接回了原文的主题：

> "It used to be that people set the width of their browser window to the text page width they’re comfortable with, and configured a different font if they didn’t like the default one on their browser. We should be more ambitious in letting the browser software control the presentation according to the user’s preferences." — layer8 [c:50226307]
> （译文：过去人们是把浏览器窗口宽度设成自己看得舒服的正文宽度，不喜欢默认字体就换一个。我们应该更有野心一点，让浏览器软件按照用户的偏好来控制呈现方式。）

> "We should use the increased ease of building software to create software that is flexible, empowers the user, and accommodates different user preferences." — layer8 [c:50226307]
> （译文：我们应该用「造软件变容易了」这件事，去造更灵活、更能赋能用户、更能容纳不同偏好的软件。）

同一场讨论里还有更直接的一句：

> "No. Line length and text wrapping restrictions are the devil." — bigstrat2003 [c:50227285]
> （译文：不。行长和换行限制是魔鬼。）

### 二、三个「以前不敢做」的项目

主帖最有说服力的部分，是评论区有人当场交作业。

ricardobeat 贴出了自己的 JavaScript 引擎：

> "Having been a product and UX-focused dev for my entire career, I knew only the basics about parsers and compilers, but have enough experience to grasp where each piece of the puzzle fits, and how to evaluate them." — ricardobeat [c:50227021]
> （译文：我整个职业生涯都是产品和 UX 方向的开发，只懂解析器和编译器的皮毛，但有足够经验判断每一块拼图该放哪儿、以及怎么评估它们。）

> "At the beginning it was just a fun test, but it got progressively more serious; it now implements 100% of the latest spec, beats QuickJS in performance, and surpasses V8/JSC in test262." — ricardobeat [c:50227021]
> （译文：一开始只是好玩地试试，但慢慢变得认真起来；现在它实现了最新规范的 100%，性能超过 QuickJS，在 test262 上超过 V8 和 JSC。）

> "It took me four months, and I imagine it would take me a single month to do it again - I’ve learned a lot." — ricardobeat [c:50227021]
> （译文：这花了四个月，我估计再来一次一个月就够了——我学到了很多。）

> "I really think we are in for a cambrian explosion of software, enabling things that were just always a little out of reach before" — ricardobeat [c:50227021]
> （译文：我真的觉得我们将迎来一次软件的寒武纪爆发，让那些一直稍微够不着的项目成为可能。）

zulban 的例子更贴近普通人的冲动——重做一个 1995 年童年游戏：

> "To be clear, I've made large software and game projects over the years, but no way I'd have found the time to do a remake/enhancement of a game I loved as a kid from 1995 that has zero business case. Not without AI." — zulban [c:50226745]
> （译文：说清楚，我这些年做过不少大型软件和游戏项目，但我绝不可能有时间去重制／改进一个 1995 年、童年时喜欢的游戏——它完全没有任何商业理由。没有 AI 就不可能。）

linsomniac 交的是一个 apt 缓存服务，动机具体到有点心酸——去年 Canonical 被打 DDoS 之后，他自己的 apt-cacher 一点用没有：

> "I've put well over 100 hours of my time into it. Still running into a lot of people knee-jerk calling it "slop", but I've had 200-ish machines pulling from it for 6 months and it has worked way better than apt-cacher-ng." — linsomniac [c:50227024]
> （译文：我在上面投入了远超 100 个小时。现在还是经常碰到有人条件反射地管它叫「slop」，但已经有大约 200 台机器从它这里拉包、跑了六个月，效果比 apt-cacher-ng 好得多。）

他最后那句是对整场讨论的总结：

> "I'm not really sure what to do with people who dismiss AI-assisted projects, while dehumanizing the 100 hours of my time I've put into it." — linsomniac [c:50227024]
> （译文：面对那些一边否定 AI 辅助项目、一边又无视我在上面投入的那 100 个小时的人，我真不知道该怎么办。）

> "I fear we're running the very real risk of both sides losing: the people trying to thoughtfully create with AI losing because of the AI, and the people avoiding AI losing because they can't keep pace." — linsomniac [c:50227024]
> （译文：我担心我们正在真正面临两边都输的风险：想用 AI 认真创作的人因为 AI 而失去什么，避开 AI 的人因为跟不上而失去什么。）

### 三、AI 是喷射背包，还是另一种无聊

乐观派的核心表述很短。echelon 用了三行：

> "AI is my jet pack. I was a fantastic IC and built really amazing software. I'm an even better AI-empowered engineer. The old era is dead. The new one is exciting." — echelon [c:50226309]
> （译文：AI 是我的喷射背包。我本来是个很棒的独立贡献者，造过很棒的软件；现在我是被 AI 加持后更棒工程师。旧时代死了，新时代令人兴奋。）

mindcandy 的观察更冷一点，指向的是HN 上的发言姿势：

> "I've been seeing too much "I've been coding for decades and what I've always done has be reduced to telling AI to do it for me." and not nearly enough "I've been coding for decades and recently worked hard for months with AI's help to make something I would have never considered possible before." Much easier to complain that you are bored than to step back up to high-effort with your new fancy tools." — mindcandy [c:50226246]
> （译文：我看到太多「我写了 decades 的代码，结果我一直在做的事变成了让 AI 替我做」，却几乎没看到「我写了 decades 的代码，最近借着 AI 的帮助苦干几个月，做出了以前根本不会考虑的东西」。抱怨自己无聊，比用上这些新工具重新拉高强度要容易得多。）

cowlevel 则给出了更冷静的功能性解释：

> "To play devil's advocate, that sounds like the sort of uncomplicated thing that you could've manually vibecoded in 2020 without an LLM. What changed is that the LLM doesn't let you get analysis paralysis." — cowlevel [c:50227213]
> （译文：唱个反调，这听起来像是那种 2020 年没有 LLM、纯手工 vibe 写也能搞定的简单事。真正变的是：LLM 不会让你陷入分析瘫痪。）

### 四、代价：订阅、账单和「严肃开发者」

乐观派的账，评论区有人替他算了。sdevonoes 的抱怨核心不是贵，是钱流向了谁：

> "Problem is that before I wasn’t paying for tools like postgres, git or linux. I donate, and I know that money goes to good hands. Now I must pay for codex/claude, and that money goes to billionaires psychopaths. So that sucks as you can imagine" — sdevonoes [c:50226395]
> （译文：问题在于，以前我不用为 postgres、git、linux 这类工具付钱。我会捐款，而且我知道那笔钱流向了可靠的地方。现在我必须为 codex／claude 付钱，而这些钱流向了 billionaire 级别的疯子。你可以想象这有多糟。）

另一个更常见的抱怨是「不让用这些模型就不算正经开发者」，源自 Linus 的一段话。bitwize 转述时被简化了：

> "Per Linus, you're not a serious developer unless you can afford access to these models anyway, so it's not really a big deal in the end." — bitwize [c:50226895]
> （译文：照 Linus 的说法，你负担不起这些模型的访问权，就不算正经开发者——反正也没那么要紧。）

wyre 指出这个版本被断章取义了：

> "My understanding from reading the lwn article is Linus's implication is more specifically about filtering out people that cannot write code without LLMs or the willingness to spend the money on the tokens required to uphold the quality of the kernel. He does not want to push out developers that do not use LLMs." — wyre [c:50227702]
> （译文：我读那篇 lwn 文章的理解是，Linus 的意思更具体地指向筛掉两类人：离不开 LLM 就写不了代码的人，以及不愿意花维持内核质量所需 token 钱的人。他并不想把不用 LLM 的开发者赶出去。）

成本本身也有人泼冷水。Aozora7 的判断是长期方向：

> "When AI labs mature and inference costs start to matter, they will start optimizing for inference cost instead of sacrificing everything for intelligence." — Aozora7 [c:50226517]
> （译文：等 AI 实验室成熟起来、推理成本开始变得重要时，他们会转而优化推理成本，而不是为了智能牺牲一切。）

> "But even without that, open weight models are already good enough and everyone would be fine with paying unsubsidized prices for them." — Aozora7 [c:50226517]
> （译文：即便不考虑这个，开源权重模型已经够好，大家也都能接受按不补贴的价格付费。）

### 五、乐趣、心流，和「不再拥有每一个决定」

乐观派没说服的那批人，理由往往不是技术，是手感。xpct 写得很具体：

> "I did some hand coding today and immediately got in the zone, something I'm still not able to do with LLMs. It most definitely took me probably ~2x longer than it would with an LLM, but it was much more enjoyable owning every decision behind the process, and having a full view of how the system worked." — xpct [c:50226556]
> （译文：我今天手写了一段代码，立刻进入了心流——这是我用 LLM 到现在也做不到的。它确实花了我大概两倍于用 LLM 的时间，但整个过程里每一个决定都归自己、也看得清系统怎么运作，这种感觉好太多了。）

> "How it's designed to work now, offloading cognitively, doesn't feel very good, even when you 'ship' more." — xpct [c:50226556]
> （译文：它现在这种把认知负担卸载出去的设计方式，感觉并不好，哪怕你「交付」得更多。）

vigilantpuma 补了半句：

> "Yeah, I can never get in the zone with LLMs either. It’s like operating in constant interruption mode." — vigilantpuma [c:50226851]
> （译文：对，我也永远没法用 LLM 进入心流。那感觉就像一直在被打断模式下工作。）

linsomniac 的回答是另一种快乐——不是过程，是成品：

> "I've gotten a lot of joy over the decades from the specific act of programming. But I also get a lot of joy from making something. I'm old enough now that I don't have a lot of my time left to "hand stitch an amazing tapestry"." — linsomniac [c:50227048]
> （译文：过去几十年，我从「编程」这个具体动作本身获得了很多快乐。但我也从「做出一个东西」获得很多快乐。我现在年纪够大了，剩下的时间没多少去「手织一幅惊艳的挂毯」了。）

> "But with AI tooling, I do have time to try out a bunch of ideas and see how they work, scratch little itches and also just run a mad scientist library of experiments, without each experiment taking tens or hundreds of hours of coding to see how that experiment pans out." — linsomniac [c:50227048]
> （译文：但有了 AI 工具，我确实有时间去试一堆想法、看它们效果如何、挠点小痒，还能像个疯狂科学家那样跑一整个实验库——不用每个实验都先花几十上百小时写代码才知道值不值。）

### 六、我的代码还会给谁用

另一条裂缝在开源动机上。jacquesm 说出了那个交换条件：

> "I think we'll see a lot less people willing to share if the end result is just to feed the machine no matter how they arrived at it." — jacquesm [c:50226832]
> （译文：如果最终结果只是喂给那台机器，不管你是怎么做到的，我想我们会看到愿意分享的人少很多。）

magicalist 用一段假想的回复把这层顾虑挑明：

> "Also, "ok, and now I've cloned your hard work overnight, no need for any decisions on my part, I just had my agent use yours and reverse engineered it and/or used it as an oracle. Why the frown? I thought you were in this for intellectual curiosity and exercising your creativity, not just stroking own ego, right?"" — magicalist [c:50226924]
> （译文：还有，「好，现在我 overnight 克隆了你的苦功，我这边一个决定都不用做，让我的 agent 用你的、再反向工程一下，或者把你当成神谕来问。有什么不高兴的？我还以为你搞这个是为了求知和发挥创造力，不只是满足自己的自尊心，对吧？」）

orangecat 的反驳更实际——训练数据根本不缺：

> "I don't see why I should care about this any more than I cared about "somebody I don't like could read my code and learn from it" in the past. The frontier labs can generate or buy all the training data they need; not releasing your app isn't going to hurt them in the slightest." — orangecat [c:50227146]
> （译文：我看不出为什么我该在乎这件事，比过去在乎「某个我不喜欢的人可能读我的代码然后学走」更在乎。前沿实验室能生成或买到他们需要的全部训练数据；你不发布你的应用，对他们不会有任何影响。）

mindcandy 提了一个折中方案——社区式的分布式训练：

> "I get not wanting to contribute to closed, commercial models. We need to hurry up and get Folding-at-Home style distributed community model training going. At that point, I’d be pretty happy if my projects contributed to improving community models. Even if commercial models benefited too." — mindcandy [c:50227167]
> （译文：我理解不想给闭源商业模型做贡献。我们得赶紧把 Folding@Home 那种社区分布式训练搞起来。到那时，如果我的项目能帮助改进社区模型，我会挺开心——就算商业模型也顺带受益。）

### 七、如果人人都能复制，价值在哪

这是商业侧最扎的一刀。bemtevi 说得最狠：

> "The problem is, why even produce something greater now when someone is just going to clone it with AI? And moreover, what differentiates software now will no longer be the care put into it but marketing and trends." — bemtevi [c:50226319]
> （译文：问题是，现在既然总有人会用 AI 克隆你的东西，为什么还要做出更好的东西？更进一步说，软件今天的区分度不再是投入的用心，而是营销和趋势。）

> "The highly commercialized nature of software means that there's not much point now in doing anything except getting there first and exiting with a decent nest egg." — bemtevi [c:50226319]
> （译文：软件高度商业化的本质意味着，现在除了抢先到位、然后带着一笔可观的储蓄退出之外，做什么都不太划算。）

majormajor 认为这话是老论调：

> "That happened at least 20 years ago." — majormajor [c:50226480]
> （译文：至少二十年前就是这样了。）

但他给出了 AI 时代的新理由——不是大众市场，而是碎片化的定制：

> "There are fields where there's room for a garden of solutions from different small-team vendors appropriate for different use cases instead of a one-size-fits-all SaaS winner-take-all type market in the past." — majormajor [c:50226480]
> （译文：有很多领域存在空间，可以让不同小团队供应商针对不同用例提供一整片解决方案的花园，而不是过去那种一刀切、赢家通吃的 SaaS 市场。）

BobbyTables2 从雇主一侧算这笔账：

> "The problem is now the AI can do for $100 what took you 3 months full time." — BobbyTables2 [c:50228004]
> （译文：问题在于，现在 AI 花 100 美元能干的，是过去要三个月全职才能干的事。）

> "In about an hour I just solved about 80hrs worth of personal coding/debugging with a portion of a $20/month Claude subscription… Frankly it makes all my knowledge and experience feel kinda worthless… I only gave it a few sentences…" — BobbyTables2 [c:50228004]
> （译文：我大约用一小时解决了自己约 80 小时的编码／调试工作，用的是每月 20 美元 Claude 订阅里的一小部分额度……坦白说，这让我所有的知识和经验都显得有点一文不值……我只给了它几句话……）

mindcandy 的回复把问题推回他脸上：

> "My POV is that indicates you need to up your expectations for yourself." — mindcandy [c:50228840]
> （译文：我的看法是，这说明你得提高对自己的期待。）

> "So then, given your knowledge and experience, what challenge would require 80 hours of real, focused work out of you using today’s tools?" — mindcandy [c:50228840]
> （译文：那么，凭你的知识和经验，用今天的工具，还有什么挑战是需要你投入 80 小时真正专注的工作才能完成的？）

Rapzid 则指出这个循环本身就是谬误：

> "Right? If it's so easy and cheap where is the value? There is no value. This fallacy is second to only every SME believing their jobs are going to be the jobs AI can't replace." — Rapzid [c:50231071]
> （译文：对吧？如果这么容易又这么便宜，价值在哪？根本没有价值。这种谬误仅次于「每个 SME 都相信自己的岗位正好是 AI 替代不了的那种」。）

### 八、有人正在丢工作

第三种声音既不是欢呼也不是嘲讽，而是有人正在真的丢掉饭碗。bluefirebrand 的处境很具体：

> "I might feel more optimistic if I hadn't been laid off and weren't struggling to find work in this new madhouse of an industry" — bluefirebrand [c:50228557]
> （译文：如果我没被裁员、也没在这个疯人院一样的行业里挣扎着找工作，我可能会更乐观一点。）

> "I am strongly feeling I'm already redundant" — bluefirebrand [c:50228557]
> （译文：我强烈地感到自己已经是多余的了。）

jacquesm 描述的是年龄结构上的挤压：

> "I know plenty of people in their late 40's 50's and 60's that were doing fine and who now have to compete with junior and Claude. And sometimes just Claude." — jacquesm [c:50226858]
> （译文：我认识不少四五十岁、六十几岁的人，本来过得好好的，现在得跟新人竞争，还要跟 Claude 竞争。有时候光跟 Claude 竞争就够了。）

> "I suspect that when all this is over 1929 will look pretty good." — jacquesm [c:50226858]
> （译文：我怀疑等这一切结束，1929 年会显得挺不错。）

于是评论区爆发了本帖最大的一次正面冲突。otterley 的立场是「别躺着」：

> "I don’t, necessarily; but I do know that if you’re not even trying, then you’re putting yourself at greater risk. This isn’t one of those developments that people can just stubbornly dig their heels in about." — otterley [c:50227020]
> （译文：我倒不一定那么认为；但我知道，如果你连试都不试，你就在让自己承担更大的风险。这不是那种可以靠固执地蹬脚来对抗的剧变。）

jacquesm 的回击是本帖最重的一段：

> "Sorry but you are coming off as utterly tone deaf and patronizing. People are losing their jobs. This is not a small thing and it will cause a lot of misery for those people." — jacquesm [c:50227374]
> （译文：抱歉，但你给人的感觉是彻底聋子和说教者。人们正在丢工作。这不是小事，会给那些人带来大量痛苦。）

> "Not every problem is a technical one and not every problem can be solved with technology." — jacquesm [c:50227374]
> （译文：不是每个问题都是技术问题，也不是每个问题都能用技术解决。）

otterley 的回嘴也很硬：

> "I’m sorry if it’s coming across that way. It’s not my intent, and I’m aware that many people are a lost paycheck away from a crisis. But if you really think the right thing to do in response is to complain and commiserate, I don’t think that is helpful, either." — otterley [c:50227416]
> （译文：如果给人这种感受，我道歉，那不是我的本意，我也清楚很多人离危机只差一张 paycheck。但如果真认为正确的回应就是抱怨和互相同情，我觉得那同样没什么帮助。）

crabmusket 试图把这场争执从个人推回结构：

> "Obstacles presented by, for example, your boss, or your company's competitors, or your political system, are not the same as obstacles like heartbreak, natural disasters, emotions, illnesses we cannot yet cure." — crabmusket [c:50227471]
> （译文：比如你的老板、你的公司竞争对手、你的政治制度造成的障碍，跟失恋、自然灾害、情绪、我们还治不了的疾病造成的障碍，不是一回事。）

> "A lot of people perceive that elites are throwing dodgeballs at them in order to increase their own profits. Saying "them's the breaks, it's just the way it is" appears to be deflecting criticism from those elites and that system." — crabmusket [c:50227471]
> （译文：很多人感觉精英在朝他们扔 dodgeball，好让自己多赚一点。说「就是命，就是这样」听起来像是在替那些精英和那个体系挡掉批评。）

fugalfervor 则否认了「未来已经写好」这个前提：

> "We could also all put our gifts toward preventing the "new reality" you see as inevitable, and put you at greater risk." — fugalfervor [c:50227663]
> （译文：我们也完全可以把力气花在阻止那个你视作必然的「新现实」上，并让自己承担更大的风险。）

> "The future isn't written yet. Your ability to predict it is an illusion." — fugalfervor [c:50227663]
> （译文：未来还没写好。你预测它的能力是一种幻觉。）

历史类比也是两边都爱用的武器。Karrot_Kream 认为程序员是第一次遇到这种冲击：

> "Plenty of other professions were hit by computing. Part of why programmers are so emotive about this concept (other than the fact that emoting online loudly seems to be much more accepted in software than other professions) is that programming has never been threatened in the same way as other professions have been until now." — Karrot_Kream [c:50226933]
> （译文：计算机已经冲击过很多其他职业。程序员对这个概念反应如此强烈，部分原因是（除了在软件圈里大声表达情绪比别的行业更被接受之外）编程从来没有像其他职业那样被这样威胁过，直到现在。）

而政策层面的分歧在 UBI 上直接撞了墙。fuzzythrowaway 主张设一条有尊严的底线：

> "Can we please, for once, stop trying to figure out how to "get ahead" of each other, and instead figure out how to build a decent and dignified floor for as many people as possible?" — fuzzythrowaway [c:50226636]
> （译文：我们能不能，就一次，别再琢磨怎么互相「领先」，而是去琢磨怎么给尽可能多的人建一条体面的底线？）

_heimdall 直接否掉了这条路：

> "A UBI will never work, the Soviets tried effectively that and it fails miserably." — _heimdall [c:50229697]
> （译文：全民基本收入永远不会成功，苏联试过类似的东西，失败得一塌糊涂。）

也有人的两种感受同时存在。bibabaloo 说：

> "Exactly. I feel both feelings simultaneously." — bibabaloo [c:50227645]
> （译文：正是。我两种感受同时存在。）

> "AI has essentially stolen my career from me. I _liked_ having to solve complicated problems with software, I enjoyed having to get into the nitty gritty to get things done." — bibabaloo [c:50227645]
> （译文：AI 基本上偷走了我的职业生涯。我喜欢必须用软件去解决复杂问题，喜欢钻进细节把事情做成。）

> "OTOH, for solving problems I care about, AI has been a god send. I can achieve things that I would have never had the time for." — bibabaloo [c:50227645]
> （译文：另一方面，对我真正关心的问题来说，AI 是天降救星。我能做成那些以前根本没有时间去做的事。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| AI 是喷射背包 | echelon | 旧时代死了，新时代令人兴奋 |
| 抱怨无聊不如拉高强度 | mindcandy | 抱怨容易，重新投入难 |
| LLM 的价值是消除分析瘫痪 | cowlevel | 2020 年手工 vibe 也能写，区别在不会卡住 |
| 排版也该更野心一点 | layer8 | 让浏览器按用户偏好控制呈现 |
| 行长限制是魔鬼 | bigstrat2003 | 不接受 |
| 四个月写完的 JS 引擎 | ricardobeat | 跑赢 QuickJS，test262 超过 V8/JSC |
| 零商业理由的 1995 游戏重制 | zulban | 没有 AI 就不可能 |
| apt 缓存服务 | linsomniac | 200 台机器跑了六个月，比 apt-cacher-ng 好 |
| 两边都输的风险 | linsomniac | 用 AI 的失去 AI，避开的跟不上 |
| 钱流向了谁 | sdevonoes | 以前付给 postgres，现在付给 billionaire |
| Linus 那话被断章取义 | wyre | 他针对的是离不开 LLM 和不愿花 token 的人 |
| 推理成本终将压过智能 | Aozora7 | 实验室成熟后会转而优化推理成本 |
| 心流没了 | xpct | 每个决定都归自己才享受 |
| 心流不等于乐趣的全部 | linsomniac | 老了，更想要的是「做出一个东西」 |
| 分享变成喂机器 | jacquesm | 愿意开源的人会少很多 |
| 训练数据不缺 | orangecat | 不发布你的应用对他们毫无影响 |
| 社区式分布式训练 | mindcandy | 像 Folding@Home 那样 |
| 做了也会被克隆 | bemtevi | 区分度只剩营销和趋势 |
| 这话二十年前就说过 | majormajor | 但碎片化定制是新机会 |
| 100 美元干掉三个月 | BobbyTables2 | 80 小时的工作一小时做完 |
| 那你该提高期待 | mindcandy | 用今天的工具，还有什么需要 80 小时专注 |
| 便宜就不值钱 | Rapzid | 每个 SME 都以为自己是例外 |
| 我已经多余了 | bluefirebrand | 被裁员，还在找 |
| 年纪大的人要和 Claude 竞争 | jacquesm | 有时候光跟 Claude 竞争就够了 |
| 别劝人躺平 | otterley | 不试，风险更大 |
| 这话太刺耳 | jacquesm | 有人正在丢工作，不是小事 |
| 障碍有不同种类 | crabmusket | 老板扔的 dodgeball 和疾病不是一回事 |
| 未来还没写好 | fugalfervor | 预测能力是幻觉 |
| 程序员是头一回 | Karrot_Kream | 其他职业早被计算机冲击过 |
| 该有一条体面底线 | fuzzythrowaway | 别再比谁领先了 |
| UBI 不会成功 | _heimdall | 苏联试过，失败得一塌糊涂 |
| 两种感受同时存在 | bibabaloo | 职业被偷走，但难题也做得成了 |

## 总体情绪

这场讨论最特别的地方，是三种情绪挤在同一个帖子里互相抵消。

乐观派手里有硬货：四个月跑赢 V8 的 JS 引擎、200 台机器在跑的 apt 缓存服务、用二十美元订阅换掉八十小时工作量的实操。这些不是口号，是可以点开链接验证的代码。所以当 linsomniac 说出「人们一边否定 AI 辅助项目，一边无视我投入的 100 小时」时，他是在替一整类人说话。

另一边的分量也不轻，而且带着日期。四十多、五十、六十岁的人突然要和 Claude 竞争，这不是一个抽象命题，而是有人正在数自己还剩几个月房贷。同时被挤掉的还有另一件东西——心流。xpct 说的「每个决定都归自己」，在这个帖子里没有多少人反驳，因为那确实是程序员自己才懂的乐趣。

而把这两边彻底劈开的，是一句「这不是每个问题都能用技术解决」。抱怨者在说结构性失业，鼓劲者在说个体适应，双方其实在争「不适配的人该由谁负责」。谁也没能赢：otterley 说「鼓励有效行为」，jacquesm 说「这话太刺耳」，crabmusket 说「老板扔的 dodgeball 和疾病不是一回事」，fugalfervor 说「未来还没写好」。

帖子里最扎眼的一句，没有任何人接：Luu 那三个项目之所以能在一周内跑完，是因为「以前不敢做的项目」一直都在那儿排队，只是从没有人为它们算过账。等算账的人变多，排队的东西就都会出来——包括那些没人愿意排的。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | We should be more ambitious with the software we build（原文博客） | https://danluu.com/ambitious/ |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50225695 |
| 3 | pgrust：用 Rust 重写 Postgres | https://github.com/malisper/pgrust |
| 4 | boomkat：从零写的 JS 引擎（ricardobeat） | https://github.com/ricardobeat/boomkat |
| 5 | apt-cacher-ultra（linsomniac） | https://github.com/linsomniac/apt-cacher-ultra |
| 6 | Asteria 4X（zulban 重制的 1995 年游戏） | https://store.steampowered.com/app/5482440/Asteria_4X/ |
| 7 | Postgres SP-GiST 数值 bug 报告 | https://www.postgresql.org/message-id/19597-39c532e61d78dff6%40postgresql.org |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及 AI 编程工具对软件工程实践的影响、开源项目的动机与复制风险，以及部分读者正在面对的失业压力与经济焦虑。文中涉及个人职业状况的引文均为当事人在公开论坛的自述，本文按原帖立场呈现，不代表本项目立场。文中数字（HN 得分与评论数、四个月、100 小时、200 台机器、六个月、80 小时、100 美元、每月 20 美元订阅、10 到 100 倍、5 小时与 20 小时、Postgres 的五类 bug）整理自原文博客与 HN 读者在帖内转贴的内容，未经独立核实，请以原始链接为准。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
