---
layout: post
title: >-
  MIT「几乎什么都能做」上 HN：18 学分的速览课该学广度还是深度
date: 2026-11-16
hn_id: 50514470
categories: [articles]
excerpt: >-
  CAD、激光切割、3D 打印、焊接、Edge AI，一门课塞进 18 学分、每周 18 小时。
  争议不在课好不好，而在你是真会了，还是只是见过一遍。
tagline: >-
  课程叫「几乎什么都能做」，课表长到像一份工具清单。
---

> 来源：HN 讨论主帖 [How to make almost anything](https://news.ycombinator.com/item?id=50514470)（313 分，43 条评论），链接直指 MIT 媒体实验室 CBA 的课程站点 [HTMAA 2026](https://pub.cba.mit.edu/863.26/site/)。归档快照 2026-11-16 10:44 UTC，入库 43 条评论，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。课程学分数、评分权重、招生规则与 12/4 截止日期均转述自课程站点的申请说明页，本站未做独立核实；引文保留 HN 原文的 HTML 实体。

## 原文概要

这次上 HN 的不是一个产品，而是一个课程网站。MIT 媒体实验室 Center for Bits and Atoms（CBA）的 HTMAA —— How to Make (almost) Anything，课程编号 MAS.863 / 4.140 / 6.9020，这是它的 2026 年秋季学期版本，授课 Neil Gershenfeld。页面朴素得近乎粗暴：一张从 9 月 9 日排到 12 月 15 日的课表，一堆指向各处的小链接，一份学生名单，一个搜索框。HN 主帖拿到 313 分、43 条评论——讨论的热度全部来自那份课表。

申请页把课程的实际重量写得很直白：18 学分，每周约 18 小时花在这门课上（lecture、design、training、prototyping、documentation）；成绩 80% 来自每周作业，且必须附带能让别人复现的文档，20% 来自期末项目，考察的是整合各项技能的能力；12 月 4 日是周作业提交截止日，也是领取最终项目材料的截止日，过了这天再动手只能算调试，不算开发。选课名额受实验室空间限制，需要申请，每学期要在初学者与专家、严肃与玩笑、本科与研究生之间取平衡。

课表本身像一份工具清单：9/9 开场与 CAD，版本控制与 web 开发，项目管理，计算机控制切割，参数化设计，嵌入式编程，电子学，3D 扫描与打印；10/01 的 recitation 单独讲 AI agents，10/08 讲 EDA，10/29 讲 Edge AI；10/21 是计算机控制加工与 CAM，11/05 电机与运动控制，11/11 机械与机器设计，11/18 是 wildcard week 与模具铸造，11/25 网络与通信，12/02 系统集成，12/15 项目展示。项目展示之后是 9:00-1:30 考前准备、1:30-4:30 期末考试、5:00-6:30 开放日。课程站还留着往年版本入口，2023 版附有录像，以及更高阶的续课 865 版本 How to Make Something that Makes (almost) Anything。

同一门课去年也上过 HN，评论区有人翻出了旧帖链接（item?id=44775830）。所以这场「速览课到底算不算学会」的争论，不是第一次在这门课上重演。

## 讨论焦点

### 一、一张清单，算不算学过

最直接的反对意见来自 mitchweaver。他先拿标题里那个 (almost) 回了句 (poorly)，然后把矛头指向课表：

> "People dedicate entire careers to things like CAD — yet they somehow crammed it all into part of one lecture which seems to be little more than an enumeration of 50 different CAD tools." — mitchweaver [c:50514681]
> （译文：人们把整个职业生涯都献给 CAD 之类的东西——而他们却把这一切塞进了一节课的一部分，那节课看起来不过是在罗列 50 种不同的 CAD 工具。）

同一派还有更朴素的困惑：

> "I&#x27;m struggling to find prose. I just see lists of buzzwords. Am I reading it wrong? I struggle to see how this teaches superficial knowledge." — LoganDark [c:50515110]
> （译文：我找不到连贯的论述。我只看到一串行话。是我读错了吗？我实在看不出这怎么会只教表面知识。）

反击的一方认为，课程的目标从来不是让人毕业就能上岗：

> "I don’t think anyone is expecting they can waltz out of this course ready for a career in CAD. It is intended for students coming from a wide range of backgrounds including non-technical, so a whirlwind tour of the fundamentals of many different fab and design tools is perfect." — gadsdengrappler [c:50514959]
> （译文：我认为没人指望上完这门课就能直接进 CAD 行业。它的定位是面向各种背景、包括非技术背景的学生，所以对各种制造与设计工具的基础做一次快速巡游正合适。）

mitchweaver 的回击把课程类比成儿童节目：

> "This is like taking a &quot;tour the crayon factory&quot; episode of Mr. Rogers and making a college-level course out of it, but through the eyes of open source evangelist MIT-types." — mitchweaver [c:50515077]
> （译文：这就像把《罗杰斯先生的节目》里「参观蜡笔工厂」那一集拉出来，改造成一门大学课程，只不过是透过开源布道者式的 MIT 人的视角。）

回应的一方则把广度本身重新定价：

> "But let&#x27;s not forget that an overview of what’s even possible is extremely valuable in its own right. When these students are later faced with a problem X, they&#x27;ll remember that there was this thing called Y which might help." — renehsz [c:50514910]
> （译文：但别忘了，一份「到底有哪些事可能做到」的概览，本身就极有价值。等这些学生日后遇到问题 X 时，会记得有个叫 Y 的东西也许能派上用场。）

这句和另一条被反复引用的补充构成了这帖最有分量的论据——知道「能做什么」，本身就构成一种能力：

> "Making things poorly is a lot more interesting than not making them at all. And then you know who to ask when you need part of it done well." — pastel8739 [c:50514949]
> （译文：把东西做得糙，比根本不做要有意思得多。而且到时候你还知道该去找谁把它做好。）

### 二、你看到的只是大纲，不是课程

另一条线指出，这个网站根本不是课程本身——课程在实验室里。

> "This website is a syllabus and summary of a course, not the course itself. The actual course involves hands-on time in a lab, building things." — teraflop [c:50515427]
> （译文：这个网站是一份课程大纲和摘要，不是课程本身。真正的课程包含在实验室里动手的时间，要动手做东西。）

上过这门课、还当过助教的人给的说法更具体：

> "The weekly pages that guide lectures are only part of the story; the best way to see what is actually taught is to peruse the sites students make to document their projects." — zakqwy [c:50515387]
> （译文：那些指导每周课堂的页面只是故事的一部分；想看真正教了什么，最好的办法是翻学生自己搭的项目记录站点。）

> "HTM(A)A is about the delta between the start and end of the semester for each individual, and is both a life-changing course and a massive time commitment for all involved." — zakqwy [c:50515387]
> （译文：HTM(A)A 关注的是每个人从学期初到学期末之间的增量变化；它既是改变人生的课程，也对所有参与者都是巨大的时间投入。）

在 TechShop 时代上过十三门课的人补上了这门课最费时间的部分——动手：

> "The syllabus is huge but the actual projects aren&#x27;t that complicated." — Animats [c:50514731]
> （译文：大纲很庞大，但实际的作业项目没那么复杂。）

> "The computer-controlled stuff is easy to learn for a programmer. Welding requires endless practice and most people never get very good at it." — Animats [c:50514731]
> （译文：计算机控制的那部分东西，对程序员来说很容易学。焊接则需要没完没了的练习，而且大多数人都永远练不到太好。）

而申请页上的 18 学分，才是这堂课真正的成本：

> "It might be &quot;just one course&quot;, but that&#x27;s a lot of work!" — fxwin [c:50515634]
> （译文：这也许是「就一门课」，但那可是巨量的工作量！）

### 三、AI 时代，广度从选修变成刚需

这帖里最被低估的一段论证，来自 renehsz：AI agent 越能实现东西，人越需要先知道有什么可实现。

> "This is especially important if you want to rise to managerial positions, and it might become more relevant now that AI agents are increasingly capable of implementing things: Solving problems is not all about <i>how</i> to do something, but also about knowing what <i>can</i> be done at all." — renehsz [c:50514910]
> （译文：如果你想升到管理岗位，这一点尤其重要；而在 AI agent 越来越能实现东西的当下，它可能变得更加相关：解决问题不只关乎<i>怎么</i>做，还关乎知道到底<i>能</i>做什么。）

顺着这个逻辑，评论区拐进了一个更实际的话题：LLM 会写脚本，但没人复用脚本。

> "This is the reason I think LLM are not being used to their full potential. A lot of busy office work can be automated if people knew they could get llm to make them scripts to do it. Where as currently a lot of people keep asking the llm to do things instead of asking the llm to build tools to do stuff." — xbmcuser [c:50515083]
> （译文：这就是我认为 LLM 没有被用到极限的原因。很多琐碎的办公室工作本可以自动化，只要人们知道可以让 LLM 写脚本去做。而现在很多人只是不停地让 LLM 替自己干活，而不是让 LLM 造工具。）

> "I think these models could be trained&#x2F;fine tuned in a way to anticipate future issues or create general enough solutions but it would imply lowering their own use... so there might not be an incentive for that." — sureglymop [c:50515105]
> （译文：我觉得这些模型可以通过训练/微调的方式预判未来的问题，或者产出足够通用的方案，但那意味着降低它们自身的使用率……所以可能没有动机这么做。）

反过来，实验室里的日常提示词早就长得像写代码：

> "<i>Let me just write a small Python script to decompile a section of this DLL so I can verify the constants for this function matches what the reference said</i>." — magicalhippo [c:50515315]
> （译文：<i>我干脆写个小 Python 脚本，把这个 DLL 的一段反编译出来，好确认这个函数的常量跟参考实现说的一致</i>。）

> "Almost literally what Claude (Opus) casually has written as it chipped away at a couple of my problems." — magicalhippo [c:50515315]
> （译文：Claude（Opus）在帮我啃几个问题时，几乎就是这么随手写出来的。）

而复用之所以没发生，还有一层训练机制上的原因：

> "It&#x27;s also because the LLM training loop is too short-lived to give them feedback on how well repurposed their code can be." — xpct [c:50515306]
> （译文：另外是因为 LLM 的训练循环活得太短，拿不到关于「它的代码被复用得怎么样」的反馈。）

### 四、AI 已经能动手了，只是还差一道工序

另一条支线是实物：已经有评论在用模型给自己造零件。

> "I recently just prompted fable to make me an stl for a hobby of mine. You would be surprised by its success." — whatever1 [c:50514693]
> （译文：我最近只是让 fable 帮我生成一个业余爱好的 STL 文件。它的成功程度会让你吃惊。）

> "The model didn&#x27;t even bother to chamfer the edges but if you have no experience building physical stuff it still could come as a miracle." — varjag [c:50514819]
> （译文：模型连倒角都懒得做，但如果你没有动手做实物的经验，它依然可能是个奇迹。）

> "I spent the weekend with multiple codex sessions watching it build 3d prints for me." — ryandetzel [c:50514866]
> （译文：我整个周末开着好几个 Codex 会话，看它给我做 3D 打印件。）

这条支线在评论里的定位其实很明确：模型能出形状，但「形状到实物」之间还卡着倒角、公差、工艺这些环节。这恰好是 HTMAA 整门课在补的那一段。

### 五、从原型到产线，课程教不了的那一段

讨论中段出现了一个跟课程完全不同的缺口，一位刚从深圳回来的人提出：

> "Realizing there is a big gap in higher education for how to understand at-scale industrial processes. From prototype to product, there is a lot of know-how." — dr_dshiv [c:50515008]
> （译文：意识到高等教育在「如何理解规模化工业流程」这件事上存在很大缺口。从原型到产品，中间隔着大量 know-how。）

做过产线的人立刻接过这个话题，指出难点的位置：

> "In my experience the hardest parts are mechanical DFM and automating verification&#x2F;QA. Choosing the right factory helps with that, and pretty much everything else" — sampullman [c:50515144]
> （译文：按我的经验，最难的部分是面向制造的设计（DFM）以及把验证/QA 自动化。选对工厂能帮上忙，其他差不多都能靠它。）

于是评论区推荐了一本正好补这块的书——Bunnie Huang 的《The Essential Guide to Electronics in Shenzhen》新版：

> "That&#x27;s funny, I was going to suggest Bunnie&#x27;s book, but this is the new edition of that book (updated by Naomi Wu). Thanks for the link!" — schoen [c:50515261]
> （译文：有意思，我本来也想推荐 Bunnie 的书，但这个链接是那本书的新版（由 Naomi Wu 更新）。谢谢分享！）

### 六、这门课真正交付的产品

争论最后落回一个共识：这门课的产物不是掌握每一项手艺，而是知道这些手艺存在、彼此怎么衔接。

> "Indeed, this is what university actually IS. You won&#x27;t be an expert in anything much at all when you graduate, but a broad survey will tell you how experts divide up the field, what concepts matter, and you will have a decent BS detector for your area of study." — lordnacho [c:50515135]
> （译文：没错，这本来就是大学真正的样子。你毕业时不会在任何一件事上成为专家，但一次广泛涉猎能让你知道这个领域里的专家是怎么分工的、哪些概念重要，并且在自己的研究方向上具备一个还算管用的胡说八道检测器。）

> "You need depth in a given area. You should absolutely be an expert at the thing that you&#x27;re most immediately doing most of the time. But you should also have a great breadth of knowledge, especially within your field, and the reason is so that you recognize situations where a particular solution to a problem you encounter may be relevant." — CobrastanJorji [c:50515484]
> （译文：你需要在自己主要从事的那一块有深度，绝对应该成为那件事的专家。但你也需要在自己领域内有足够的广度，这样在遇到问题时，你才能识别出「某个特定方案可能适用」的情境。）

一位在剑桥三一学院申请时被人推荐过《The New Turing Omnibus》的读者，给了这条共识一个书面的注脚：

> "But it does exactly this: it skims across the top of dozens of topics, and it makes you just aware enough of... all sorts of areas of CS." — tekacs [c:50515119]
> （译文：但它做的正是这件事：从几十个主题的表面掠过，让你刚好对……计算机科学的各个领域有足够的认知。）

一位从别的专业路径转进软件行业的人，说的是「词汇」而不是「能力」：

> "But as I got out into the workforce, I&#x27;ve noticed it&#x27;s been useful to have tried a bit of everything and to have the vocabulary to talk about the basics in each of the sub-studies." — kqr [c:50515625]
> （译文：但进入职场之后我注意到，每样东西都试过一点、并且拥有讨论各个子领域基础问题的词汇，是有用的。）

还有人把这门课的教法直接类比成当下最流行的工作方式：

> "To be fair - they seem to focus on setting goals for learning, so that the student would have to learn it all on their own. It&#x27;s like vibe coding. Teachers give prompts to students and students deliver on the learning work." — zkmon [c:50515014]
> （译文：公平地说，他们似乎把重点放在设定学习目标上，让学生自己去学会这些东西。这就像 vibe coding：老师给出提示词，学生交出学习成果。）

而「看 plumber 拆水管」这段个人经验，是这帖里把「知道」和「会做」之间的落差讲得最实在的一条：

> "I recently watched a plumber open and clean some pipes. I understood (at least at a superficial level) what he was doing and I&#x27;ve been able to complete the cleaning myself" — pmontra [c:50515053]
> （译文：我最近看一个水管工拆开管道清理管道。我至少在表面上理解了他在做什么，后来我自己也把清理做完了。）

课程的教授者本人也被反复提及，一句来自老学员的评价是：

> "This is, hands down, one of the best classes in the already exceptional MIT Media Lab.<p>Gershenfeld is a low key genius, and this curriculum has been taught every year well before AI." — epsteingpt [c:50515118]
> （译文：毫无疑问，这是本就已经出色的 MIT 媒体实验室里最好的课之一。Gershenfeld 是个低调的天才，而这套课程在 AI 出现之前就已经年年开讲了。）

课程本身的延续性也留在评论里：2023 版还留着录像，有人在问有没有更高级的续课，也有人直接问有没有公开可得的等价物——那个问题在这帖里始终没人回答。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 一节课塞了 50 种 CAD 工具 | mitchweaver | 职业级的 CAD 不该被压进一节 lecture |
| 全是行话，看不出结构 | LoganDark | 我只看到一串 buzzwords |
| 课程目标是巡游，不是上岗 | gadsdengrappler | 面向非技术背景的快速基础巡游正合适 |
| 广度优先是教学选择 | thomascountz | 20 年前不这么可行，现在一个人能端到端做出来 |
| 概览本身就有价值 | renehsz | 遇到问题时至少知道从哪查起 |
| 做得糙比不做强 | pastel8739 | 做完再找人把它做好 |
| 网站只是大纲 | teraflop | 真正的课在实验室里动手 |
| 真教了什么看学生项目站 | zakqwy | HTMAA 关心的是每个人学期前后的增量 |
| 大纲大，作业不复杂 | Animats | 真正耗时的是动手做 |
| 焊接练不好 | Animats | 计算机控制易学，焊接靠反复练 |
| 18 学分不便宜 | fxwin | 「就一门课」也是巨量工作量 |
| LLM 应该被用来造工具 | xbmcuser | 让它写脚本，而不是替它干活 |
| 脚本用完即弃是激励机制问题 | sureglymop | 通用化意味着降低自己被用 |
| 实验室日常已经在这么用 | magicalhippo | Claude Opus 顺手写 Python 脚本 |
| 训练循环太短，拿不到复用反馈 | xpct | 复用好不好，没法进入训练信号 |
| 模型已经能出 STL | whatever1 | 提示一句就拿到了可打印文件 |
| 差的是倒角和工艺 | varjag | 没倒角，但没经验的人仍觉得像奇迹 |
| 周末批量出打印件 | ryandetzel | 多个 Codex 会话连着跑 |
| 原型到量产是教育缺口 | dr_dshiv | 从原型到产品隔着大量 know-how |
| 最难的是 DFM 和自动化 QA | sampullman | 选对工厂能解决大半 |
| 深圳电子指南有新版 | schoen | Bunnie 那本书的新版由 Naomi Wu 更新 |
| 大学本来就是广度 | lordnacho | 顺带给你一个胡说八道检测器 |
| T 型知识才够用 | CobrastanJorji | 主要方向要深，同时要有识别相关性的广度 |
| 概览体裁有先例 | tekacs | 《The New Turing Omnibus》干的是同一件事 |
| 试过一点就有用 | kqr | 拥有讨论基础的词汇本身就有用 |
| 这门课就是 vibe coding | zkmon | 老师给提示词，学生交学习成果 |
| 看过 plumber 就能自己动手 | pmontra | 表面理解已经够你迈出第一步 |
| 最好的课之一 | epsteingpt | Gershenfeld 是低调的天才 |

## 总体情绪

这帖的分歧比常见的课程争论更深一层：几乎没人否认这门课有用，争议全在「有用」指的是什么。说它浅的人，骂的是「速览」这个形式；说它好的人，说的也是「知道能做什么」这一层价值。双方其实共享同一个底色——真正扎实的操作能力从来不在一门课里，课程能给的只是边界感。

两个具体事实让这场争论更耐嚼：一门 18 学分、每周 18 小时的课，评分的 80% 压在每周作业上而不是期末项目上，说明「持续动手」比「一技之长」才是这门课的真正考核方式；而课程页面里 10/01 的 recitation 单独讲 AI agents、10/29 讲 Edge AI，说明授课方早就在把「造工具」写进大纲，而不是等着 AI 自己改变制造。

真正没人回答的问题留在了评论区最后：一个想问「怎么用 recitations 自学这条路径」，一个问「有没有公开可得的等价课程」，还有一条问「从原型到产线那段 know-how 该跟谁学」。课程网站能告诉你有哪些工具，但把 50 个工具排成一张时间表之后，那个真正的问题依然悬着——你到底是从此能做点什么，还是只是知道有什么东西可以做。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | How to make almost anything（HN 主帖） | <https://news.ycombinator.com/item?id=50514470> |
| 2 | HTMAA 2026 课程站（MIT CBA，MAS.863 / 4.140 / 6.9020） | <https://pub.cba.mit.edu/863.26/site/> |
| 3 | 课程申请说明页（18 学分、评分权重、12/4 截止、招生规则） | <https://pub.cba.mit.edu/863.26/site/file/app.html> |
| 4 | HTMAA 2023 课程站（含录像） | <https://fab.cba.mit.edu/classes/863.23/index.html> |
| 5 | How to Make Something that Makes (almost) Anything（865 续课） | <https://fab.cba.mit.edu/classes/865.24/index.html> |
| 6 | HN：同一门课的去年主帖（2025） | <https://news.ycombinator.com/item?id=44775830> |
| 7 | The New Turing Omnibus（A. K. Dewdney，评论中给出的购书链接） | <https://www.amazon.com/New-Turing-Omnibus-Turning-Excursions/dp/0716782715> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 313 分、43 条评论，归档快照 2026-11-16 10:44 UTC，入库 43 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留 HN 原文的 HTML 实体。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

课程信息（18 学分、80/20 评分权重、12 月 4 日截止日期、按实验室空间限制招生、课表主题与日期、12/15 项目展示及期末考试安排、授课教师 Neil Gershenfeld）均转述自课程站点及其申请说明页，本站未做独立核实。该课程学期尚未结束，后续安排以教师与学生的最终发布为准。评论中提到的开源等价课程、模块化产线 know-how 等问题，在原帖中无人回答。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
