---
layout: post
title: >-
  Tim Peters 去世：Python 之禅的作者，第 20 条箴言留空 — HN 讨论摘要
date: 2026-11-12
hn_id: 50450488
categories: [articles]
excerpt: >-
  PEP 20 号称 20 条 Python 箴言，实际只写下来 19 条，第 20 条一直空着等人来填。现在作者本人走了，那一行不会再有人补上。
tagline: >-
  Python 之禅写了 19 条，第 20 条留给后人填——现在作者本人走了。
---

> 来源：HN 讨论主帖 [Tim Peters has died](https://news.ycombinator.com/item?id=50450488)（1039 分，114 条评论），原文是 Python 官方论坛 [In Memoriam: Tim Peters 1952-2026](https://discuss.python.org/t/in-memoriam-tim-peters-1952-2026/110028)——Guido van Rossum 于 2026-11-11 05:36 UTC 发布，本帖 173 个赞，是整串追忆帖里最多的。本篇为 single post 模式：48 小时候选池中没有第二篇同主题 HN 帖（`Python's experimental JIT to be removed` 580 分，发于 10-27，超出时间窗）。归档快照 2026-11-12 06:10 UTC，主帖入库 100 条评论。原文论坛该帖共 30 帖，除 Guido 的两帖外另有 28 篇追忆，未进入 HN 候选池，本文对其内容的引述不带评论 ID，不参与 HN 评论 ID 校验。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 11 月 11 日 05:36 UTC，Python 官方论坛 discuss.python.org 出现一个题为《In Memoriam: Tim Peters 1952-2026》的帖子，作者是 Guido van Rossum。第一句就宣布 Tim Peters 去世，日期给得很干脆：今年 7 月 15 日。这个帖子拿到 173 个赞，是整串追忆帖里最多的，Guido 随后补了一句，欢迎讲出你自己的 Tim 故事，我不可能覆盖他做的所有事。消息传到 HN，主帖拿下 1039 分、114 条评论，到归档时（11-12 06:19 UTC）入库 100 条。

Tim Peters 1952 年生，2026 年 7 月 15 日去世，74 岁。Python 社区里几乎所有人先想到的是两样东西：`import this` 打印出来的那段文本（PEP 20，Python 之禅），以及 2002 年他设计的排序算法 Timsort。Guido 在讣告里写道，没有 Tim，Python 不会是今天的 Python；Timsort 后来被 Java 和 Android 采用。但 Guido 强调的其实是更早的东西：Tim 在 Python 刚发布不久就加入，他做的第一件事是说服 Guido 让 Python 支持 `int` 与 `float` 的混合算术，因为多数用户会期望两者这样混着用。

在此之前，Tim 在 Cray Research 写超算编译器，在 Dragon Systems 写语音识别软件——那在当时几乎是不可能完成的任务。他几乎立刻成了邮件列表上的传说人物，绰号「Timbot」，因为他从不厌倦回答用户提问，还习惯在答案里塞一点温和的幽默：标记成 `<wink>` 或者 `<0.5 wink>`，并经常说自己是在「channeling Guido」。Guido 的评价是，他真正定下了早期核心开发的基调，从不干脆地否定别人，而是详细解释为什么某些东西行得通、为什么行不通。他 2001 到 2014 年担任 Python 软件基金会理事。

讣告下面压着一条暗流：2021 年那场争议。Tim 因「三条誓约」相关的邮件列表争执被 Python 官方论坛停权三个月，事后被当事人称为「可耻的抛窗」。原帖里也给出了相反的记述：Python 核心开发者 Antoine Pitrou 说他后期在讨论中变得有些急躁，但行事本意是好的，只是难以理解达成同一个目的可以用不同手段；Tim 的多年好友 holdenweb 写道，那场因意识形态原因施加于他的禁令确实影响了他，却没能影响他帮助别人的意愿，这一点一直保持到最后。

技术遗产被逐条清点。Python 2.4 时代的核心开发者 nas 在追忆帖里列了一长串：pymalloc 内存分配器由 Vladimir Marangozov 贡献，被 Tim 打磨成钻石般的形态并加入 `Py_ADDRESS_IN_RANGE` 检查；dict 对象的算法优化和他写的 `dictnotes`；修好一个由 ZODB 暴露出来的循环 GC bug 后写下的 `weakref.txt`；把循环垃圾回收器的初版打磨成稳健版本；给生成器写 PEP 并实现；float 对象与 math 模块；longobject 里的 Karatsuba 乘法；doctest 的最初版本、difflib、pickletools，以及「毫不留情」的 tabnanny。

## 讨论焦点

### 一、迟到四个月的讣告，和一封不知道是最后一封的邮件

有人前一天刚查过 Python 之禅，第二天就撞上了讣告：

> "It feels surreal to learn about his death just the next day." — asalahli [c:50457628]
> （译文：前一天刚得知他去世，隔一天就赶上了，这种感觉很不真实。）

dalke 的长贴是这条线里信息量最大的一条。他 1990 年代在 comp.lang.python 这个 Usenet 频道上跟 Tim 打过交道，同行们亲切地叫他「Uncle Timmy」：

> "In the 1990s I was a novice developer, though I considered myself a hotshot because I was better than those around me in college and grad school.<p>I was an active participant in the comp.lang.python Usenet channel in the late 1990s.<p>I learned much from reading Tim Peters&#x27; posts. To many, including me, he was affectionately referred to as &quot;Uncle Timmy.&quot;" — dalke [c:50451689]
> （译文：1990 年代我还是个新手程序员，虽然在 college 和 grad school 里自认为比周围人强不少。我从 90 年代末开始积极参与 comp.lang.python 这个 Usenet 频道。我从读 Tim Peters 的帖子中学到很多东西。很多人，包括我，都亲切地叫他「Uncle Timmy」。）

他还记得 Tim 的邮件签名习惯：

> "He would use &lt;wink&gt; in his messages, and often end with something like &quot;let&#x27;s-hear-it-for-lambda-in-curly-assignment-stmts-ly y&#x27;rs - tim&quot;" — dalke [c:50451689]
> （译文：他会在消息里用 `<wink>`，而且常常以这样一句收尾：「let's-hear-it-for-lambda-in-curly-assignment-stmts-ly y'rs - tim」——这句出自他最初贴出 Python 之禅的那封帖子。）

而 linsomniac 记下的是另一种结尾：

> "My last exchange with Tim was him saying that he wasn&#x27;t feeling up to having visitors.<p>You never know when an email is going to be the Last Email.  Don&#x27;t put off reconnecting with old friends." — linsomniac [c:50456839]
> （译文：我和 Tim 最后一次交流，是他说他这会儿不想见人。你永远不知道哪封邮件会是最后一封。别拖到以后再联系老朋友。）

这三条串起来是同一个人的画像：一个靠回信建立声望的人。评论区的悼念大半不是关于代码，是关于「他解释过什么」。

### 二、PEP 20 号称 20 条，实际写下来的只有 19 条

有人从文本本身找细节：

> "The PEP explicitly says there are 20 of which only 19 are written down and I can&#x27;t figure out if that is a joke, a deliberate statement, or both." — shiandow [c:50457214]
> （译文：PEP 明确写着总共 20 条，其中只有 19 条写了下来。我分不清这是玩笑、还是刻意声明、还是两者兼有。）

有人接了一句：

> "And at that moment, shiandow was enlightened." — leoc [c:50457301]
> （译文：于是那一刻，shiandow 大彻大悟了。）

PEP 20 的摘要里确实写着，Tim Peters 把 BDFL 的设计原则浓缩成 20 条格言，其中只有 19 条被写下来；正文列出的正是 19 行，最后一行是「Namespaces are one honking great idea -- let's do more of those!」，第 20 行是空的。这条空白到底是留给后人填的，还是一句玩笑，成了评论区里的一个小问题：

> "But it was valuable to have a North Star even before I realized why they were important." — Waterluvian [c:50456579]
> （译文：但在意识到它们为什么重要之前，能有这么一颗北极星，本身就已经很值了。）

落到实处的方式往往很朴素：

> "I have the Zen of python printed out on our office wall and everyone quotes it at least weekly. It started as a bit of a joke, but become a pretty big part of our culture." — themanmaran [c:50456416]
> （译文：我把 Python 之禅打印出来贴在我们办公室的墙上，每周至少有人引用一次。起初只是个玩笑，后来变成了我们文化里相当大的一部分。）

### 三、逐字审判：complex 和 complicated 到底差在哪

这是帖子里最技术化的一条分支，从一条箴言的措辞一路吵到布尔类型的语义。最先开火的是 coffeemug：

> "The only thing I never liked about this is complex is better than complicated. Every once in a while there is a post with an “insight” on how they’re different, but it’s the same word! Naming things is hard, but I wish Tim found another word for one of these." — coffeemug [c:50458818]
> （译文：这句话里我唯一一直不喜欢的就是「complex is better than complicated」。隔三差五就有一篇帖子「洞见」出这两者的区别，可它们是同一个词！命名本来就难，我倒希望 Tim 给其中一个换个词。）

collingreen 给了个教科书式区分：

> "Complex - many parts (but the parts could potentially be simple)
> Complicated - have to understand many things in order to understand it at all; large surface area" — collingreen [c:50459922]
> （译文：Complex——部件很多（但每个部件本身可能是简单的）；Complicated——要理解很多东西才能理解它整体；表面积巨大。）

kstrauser 用两个真实协议来说明差别在哪：

> "But because the protocol is so simple, implementing it is extremely complicated. Were the protocol a little more complex, the implementations could be vastly simpler." — kstrauser [c:50460801]
> （译文：但正因为这个协议这么简单，实现它才极其麻烦。要是协议本身稍微复杂一点，实现反而能简单得多。）

jacobolus 干脆承认这个词本来就含混：

> "&quot;Simple is better than complex. Complex is better than complicated.&quot; is a pithy way to express a valuable idea:" — jacobolus [c:50463045]
> （译文：「Simple is better than complex. Complex is better than complicated.」是表达一个有价值想法的俏皮说法。）

真正的分歧出现在「Python 有没有遵守这条箴言」：

> "Oh boy, that didn&#x27;t age well for Python language did it? It matches with C++ in growing complexity of syntax features." — flykespice [c:50457549]
> （译文：哎哟，这句话对 Python 来说可没怎么历久弥新啊。它跟 C++ 在语法特性上的复杂度增长是一个味道。）

> "Python has never followed the Zen. The irritating way the language lets you use non-booleans in a boolean context flies right in the face of &quot;explicit is better than implicit&quot;." — bigstrat2003 [c:50457890]
> （译文：Python 从来没遵守过 Zen。语言允许把非布尔值直接放进布尔上下文，这种恼人的做法，正好撞在「显式优于隐式」这条上。）

顺着这条线，有人干脆把矛头指向 bool 类型本身：

> "This will probably sound crazy to some of you, but I believe the introduction of the boolean type was a mistake.<p>Every primitive type has a null value, and the &quot;if&quot; statement tests for such a value.  Whether a value is true or false is a property of the value.  Notice that &quot;true&quot; and &quot;false&quot; are adjectives, not nouns." — zestyping [c:50461026]
> （译文：这话说出来大概会让一些人觉得疯了，但我相信引入布尔类型是个错误。每个原始类型都有一个空值，`if` 语句测的就是这么个空值。一个值是真还是假，是这个值的属性。注意「true」和「false」是形容词，不是名词。）

有人接了一句更狠的：

> "Booleans are reductionist and likely harmful, as they allow programmers to avoid thinking in terms of the test they are actually performing" — tacitusarc [c:50461489]
> （译文：布尔是还原论的，而且大概有害，因为它让程序员可以不去想自己实际在做的那类判断。）

也有人觉得这笔账根本不用算：

> "Except it mostly just leads to suprising bugs and time wasting, in exchange for saving a small amount of typing" — logophobia [c:50458838]
> （译文：可这么做大体上只会带来意外 bug 和时间浪费，换来的是少打几个字。）

一个下午下来，讨论从「怎么写好代码」滑到了「Python 的布尔类型是不是设计失误」，这在 Python 社区算相当诚实的一次自我审讯。

### 四、Python 从来不是政治中立的：2021 年那次停权

讣告贴出来不到一天，评论区就绕到了另一件事：Tim 在 2021 年被 Python 官方论坛停权三个月，起因是邮件列表上的争执，当事人把它叫做「可耻的抛窗」。讽刺版本先出来：

> "The Steering Council bureaucrats must be very happy that he cannot &quot;post too many mails&quot; or &quot;use the wrong language&quot; on the mailing lists any longer." — 1nahGa [c:50456531]
> （译文：指导委员会的官僚们一定很高兴，他再也不能「发太多邮件」或者「用错语言」了。）

措辞更直接的是 baggy_trough：

> "Obviously a great man, but that was no defense when the intolerant leftists came for him." — baggy_trough [c:50457992]
> （译文：显然是个伟大的人，但当年那帮不容异见的人冲着他来的时候，没人替他挡过。）

polotics 提到那次停权之后他就不写 Python 了：

> "And after that three months suspension BS drama Tim just got back to work on Python. Saintly.<p>btw. made me stop having a favourite programming language." — polotics [c:50457059]
> （译文：还有那场三个月的停权闹剧，Tim 刚恢复工作就回到 Python。真是圣人。顺便说一句，它让我不再有最喜欢的编程语言。）

真正被追问的是程序问题：

> "In particular, the references by Brett Cannon and Emily Morehouse to the fact that they are not sharing the evidence that led to them deciding to suspend a foundational Python developer (and one in no small part responsible for the fun, inclusive nature of the early Python community) means the process is broken and they set themselves up for failure from the start." — wzdd [c:50462650]
> （译文：尤其是 Brett Cannon 和 Emily Morehouse 提到他们并不公开那些导致他们决定停权一位 Python 奠基开发者（他也在早期 Python 社区那种有趣、包容的氛围里占了不小份额）的证据——这意味着流程从一开始就是坏的，他们给自己挖好了坑。）

joering2 的说法更直接：

> "It was disgusting frankly how they banned him for _alleged_ violations and never bother to provide and evidence of sort." — joering2 [c:50458419]
> （译文：说真的，他们以所谓的指控封掉他，却从来没提供过任何证据，这种做法恶心得很。）

（引文里的「provide and evidence」是原文拼写，逐字保留。）

而这条线也暴露出更深的反省：

> "I always thought that DEVELOPING A DAMN PROGRAMMING LANGUAGE is inherently apolitical and strongly meritocratic endeavor. Boy, how naive I was..." — Postosuchus [c:50459195]
> （译文：我一直以为开发一门该死的编程语言本身就是不问政治、强 meritocratic 的事。天哪，我以前有多天真。）

mmooss 把话说得更远：

> "When we find ourselvees thinking that, then we are part of the status quo - the system is designed to suit us." — mmooss [c:50461445]
> （译文：当我们这样想的时候，就说明我们已经是现状的一部分了——这套系统就是为我们设计的。）

这一段的性质其实很清楚：多数人不是在讨论 Python 的设计，他们是在算 2021 年那笔账，而且承认自己算的是这笔账。同一串追忆帖里，Antoine Pitrou 和 holdenweb 给出的是另一面——Tim 后期确实急躁，但行事本意是好的，禁令也没能改变他帮助别人的意愿。两种叙述摆在同一个帖子里，没有人对账。

### 五、Zen 撞上 AI：给 coder 写的箴言，被读成了 agent 的 prompt

评论区里最早跳出来的一条技术观察是 bitter_michael：

> "Interestingly, today this text reads not only as good advice for coders but also as good instructions for agents. Perhaps time to revisit those and make sure the spirit of these adages is captured there" — bitter_michael [c:50457203]
> （译文：有意思的是，今天这段文字读起来不只是给程序员的好建议，也像给 agent 的好指令。或许该重新读一遍，确认这些箴言的精神被保留下来了。）

有人干脆要求把 Zen 装进模型：

> "This is a lot of wisdom, which you can tell comes from years of experience. I would like all llms of the world to have this as their base prompt." — davidja [c:50459401]
> （译文：这里全是智慧，一眼就看出是多年经验攒出来的。我想让全世界所有的 LLM 都拿它当 base prompt。）

也有人泼冷水：

> "Trying to retain hope that newer generations of Python folks will keep the zen of Python alive but especially in an agentic era, to some degree that hope does feel less and less realistic by the day." — yowlingcat [c:50456688]
> （译文：我还留着一点希望：新一代的 Python 人能把 Zen 传下去——尤其是在 agent 时代，这一点希望越来越不现实。）

真正扎眼的是另一条：Tim 二十年前写的垃圾邮件过滤器，和今天的模型其实是同一件事。

> "This concept of making the best use of any available data to infer useful probabilities seems like a crude form of some ideas behind current LLMs, BUT they (Peters, Graham, Robinson and Woodhead) were doing this work 20 years earlier." — curiousObject [c:50457161]
> （译文：这种「尽最大可能利用现有数据、推断出有用概率」的概念，看上去像是当前 LLM 背后那些想法的一个粗糙版本——但他们（Peters、Graham、Robinson 和 Woodhead）二十年前就在做这件事了。）

当事人之 Gary Robinson 说得更直接：

> "The reason that&#x27;s especially interesting is that I was using an AI to write something that needed that functionality, and it spewed out that same Python code, which I recognized immediately." — garyrob [c:50458808]
> （译文：特别有意思的地方在于，我当时正在用一个 AI 写需要那个功能的代码，它直接吐出了同一段 Python 代码，我立刻就认出来了。）

（他说的那段代码，是 Tim 与他一起把 Paul Graham 的《A Plan for Spam》变成 SpamBayes 时写的。）

### 六、真正被传下去的不是代码

收尾的几条评论都不谈技术。

> "I learned how to be a person on the internet in large part by watching Tim back in the day." — kgcgfva [c:50457457]
> （译文：我很大程度上是看着 Tim 学会怎么在网上当个别人的。）

ofek 回忆的是他的写作方式：

> "What he had to say was often lengthy, to address reader assumptions or some nuance, but was written with such a jovial tone that it was rarely dull or inaccessible." — ofek [c:50457143]
> （译文：他要说的东西往往很长，为了回应读者的假设或者某个细微差别，但写得那么愉快语气，读起来极少枯燥或难以接近。）

fxm73 用一首诗收尾：

> "Quiet lines of code  
> Still guide the hands of strangers  
> His kindness lives on" — fxm73 [c:50458843]
> （译文：安静的代码行 / 仍在引导陌生人的双手 / 他的善意长存）

（引文里的诗行用的是原文的换行与行末双空格，逐字保留。）

有人在旁边补了一句：

> "Timsort is presumptively the best-known thing, but he did quite a lot else for core CPython development." — zahlman [c:50460790]
> （译文：Timsort 大概是最出名的那一个，但他在 CPython 核心开发上还做了很多别的事。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| PEP 20 号称 20 条，实际只写了 19 条 | shiandow | 这是玩笑、刻意声明，还是两者兼有 |
| 第 20 条留白是个玩笑 | leoc | 那一刻 shiandow 大彻大悟 |
| 箴言长进了日常文化 | themanmaran | 打印贴墙，每周都有人引用 |
| complex 与 complicated 是同一个词 | coffeemug | 只求 Tim 给其中一个换个词 |
| 复杂是内在的，麻烦是外在的 | collingreen | 部件多 vs 表面积大 |
| 复杂程度是可以设计的 | kstrauser | 协议稍微复杂点，实现反而能简单 |
| Python 早就不符合这条箴言了 | flykespice | 语法复杂度长成了 C++ 的样子 |
| Python 从来没遵守过 Zen | bigstrat2003 | 非布尔值当条件用，撞上「显式优于隐式」 |
| 布尔类型本身就是设计错误 | zestyping | true 和 false 是形容词，不是名词 |
| 布尔让程序员免于思考 | tacitusarc | 还原论式的小类型，砍掉了真正的判断 |
| 停权的程序不透明 | wzdd | 决定停权却不出示证据，流程从一开始就坏了 |
| 以「莫须有」封人是可耻的 | joering2 | 从来没提供过任何证据 |
| 停权改变了一代人的选择 | polotics | 「让我不再有最喜欢的编程语言」 |
| 编程语言不该有政治 | Postosuchus | 「我以前有多天真」 |
| 觉得自己没有偏见就是现状本身 | mmooss | 这套系统就是为我们设计的 |
| Zen 正好是 agent 该守的规矩 | bitter_michael | 今天这段文字也是给 agent 的指令 |
| 所有 LLM 都该以它为 base prompt | davidja | 一眼看出是多年经验的结晶 |
| agent 时代没人会再传下去 | yowlingcat | 这点希望越来越不现实 |
| 二十年前的 SpamBayes 就是 LLM 的先声 | curiousObject | 同样的活儿他们早干了 20 年 |
| AI 直接吐出了 Tim 当年的代码 | garyrob | 一眼就认出来了 |
| 遗产远不止 Timsort | zahlman | 大整数与 Decimal 的算法也出自他手 |
| 传下去的是人，不是代码 | kgcgfva | 我是看着 Tim 学会怎么在网上当个别人的 |

## 总体情绪

这串帖子的情绪不是一条直线，而是三层叠在一起。表层是标准悼词：几十个人回忆起自己读过的帖子、收到的回复、贴满墙的 Python 之禅。第二层是逐字审读——从「第 20 条到底算什么」一路到「bool 类型是不是个错误」，把一段二十多年前的格言当成代码评审来挑毛病。第三层是 2021 年的旧账：停权三个月、没公开的证据、「可耻的抛窗」这个说法，以及一句「编程语言本身不该有政治」被自己拆穿的瞬间。

三层里没有一层能盖住另外两层。悼词里的人往往就是骂过人的人，骂人的人也往往在悼词里句句落到实处：他们怀念的不是 Tim 写过的哪个模块，而是他那种把话说到底的耐心。现在这个人不在了，那条永远在解释「为什么行不通、为什么行得通」的线头断了。

而 PEP 20 里那行空白，恰好是这个社区最擅长的修辞：留一格给人填。Tim 走了，第 20 条还是空的。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Tim Peters has died（HN 主帖） | <https://news.ycombinator.com/item?id=50450488> |
| 2 | 原文：In Memoriam: Tim Peters 1952-2026（Python 官方论坛，Guido van Rossum） | <https://discuss.python.org/t/in-memoriam-tim-peters-1952-2026/110028> |
| 3 | PEP 20 — The Zen of Python | <https://peps.python.org/pep-0020/> |
| 4 | Chris McDonough：The shameful defenestration of Tim（当事人之一的记述） | <https://chrismcdonough.substack.com/p/the-shameful-defenestration-of-tim> |
| 5 | Tim Peters（Wikipedia） | <https://en.wikipedia.org/wiki/Tim_Peters_(software_engineer)> |
| 6 | Timsort | <https://en.wikipedia.org/wiki/Timsort> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 1039 分、114 条评论，归档快照 2026-11-12 06:10 UTC，入库 100 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。Python 官方论坛原文的 28 篇追忆帖未进入 HN 候选池，本文对其内容的引述不带评论 ID，不参与 HN 评论 ID 校验。原文摘要提到的「三条誓约」停权事件、当事人的不同说法与 PEP 20 的行数，均以论坛原帖、PEP 原文与 HN 归档评论为准，本站未做独立核实。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
