---
layout: post
title: >-
  Margaret Hamilton 去世：AGC 上的 4KB 调度器，和一场关于她到底写了多少代码的争论
date: 2026-10-08
hn_id: 49998895
categories: [articles]
excerpt: >-
  MIT 计算先驱 Margaret Hamilton 于 9 月 30 日去世，享年 90 岁。她在 4KB RAM、0.043 MIPS 的阿波罗制导计算机上写出能自我救场的优先级调度器；1023 分的 HN 热帖里，社区一半在缅怀，一半在追问她的功劳是不是被后人的文章吹大了。
tagline: >-
  她把软件从黑箱变成了工程学，评论区忙着把她的功劳除以二。
---

> 来源：HN 热门榜（`/best`）。帖子：[Margaret Hamilton has died](https://news.ycombinator.com/item?id=49998895)，1023 分，96 条评论。

## 原文概要

Margaret Hamilton 于 9 月 30 日去世，享年 90 岁。MIT News 10 月 7 日发布的讣告把这串数字摆得很密：1936 年生于印第安纳州 Paoli；1959 年进 MIT 气象系，跟 Edward N. Lorenz 一起写天气预报程序，这段工作后来影响了 Lorenz 关于混沌理论发表的论文；1961 年转入 Lincoln Laboratory，为美国第一套防空系统 SAGE 编写软件，跑在原型机 AN/FSQ-7（代号 XD-1）上。

1965 年，她丈夫在报纸上看到一则招聘广告——MIT 仪器实验室要招人写「把人送上月球」的软件。她投了简历，成了阿波罗项目的第一位程序员，也是该项目第一位女性程序员。1968 年她已是指令舱与服务舱团队的负责人手下，整个阿波罗软件团队超过 400 人。她一生发表 130 多篇论文，2003 年拿 NASA 特别成就奖，2016 年奥巴马授予总统自由勋章，2022 年入选国家航空名人堂。

两个技术细节是社区争论的起点。其一是 **P01**：女儿 Lauren 四岁那年，在指令舱模拟器上误启动了一个起飞前程序，模拟器直接崩。Hamilton 写文档警告，也提了修复补丁，被上级以「宇航员不会犯这种错」为由驳回——1968 年阿波罗 8 号上 Jim Lovell 恰好在飞行中误启 P01，导航数据消失，补丁才被合入。其二是 **Apollo 11 的 1202 告警**：1969 年 7 月登月前几分钟，机载计算机因一个硬件开关故障而过载，地面休斯敦选择相信 Hamilton 团队写的优先级调度器，机器主动砍掉低优先级任务保住了着陆流程。

讣告末尾列出的遗属名单也很具体：女儿 Lauren Hamilton，女婿 Richard Selesnick，两个外孙，四个曾外孙，以及兄弟姐妹 John、David、Kathryn。追悼会定在 2027 年春于马萨诸塞州剑桥举行。

## 讨论焦点

### 「man-rated」到底是什么意思

> "The term she coined for it was "man-rated". Meaning that it had been tested rigorously enough to be trusted to keep humans alive." — da_chicken [c:50000937]
> （译文：她为这套东西造了一个词，叫「man-rated」。意思是它被测到足够严格，可以被信任用来保住人的性命。）

> "The Apollo Guidance Computer had 4KB of RAM and 16KB of ROM. Can you write a scheduler that would execute 8 programs related to landing on the moon in 4KB?" — jonstewart [c:50001429]
> （译文：阿波罗制导计算机只有 4KB RAM 和 16KB ROM。你能在 4KB 里写出一个调度器，同时执行 8 个跟登月有关的程序吗？）

> "And it ran at 0.043 MIPS. Each task would get maybe 5000 instructions per second, minus scheduler overhead." — bronson [c:50001600]
> （译文：而且它的算力是 0.043 MIPS。扣掉调度开销，每个任务大概每秒分到 5000 条指令。）

> "An asynchronous scheduler with task priority, interrupts, and real-time response. That goes on a spaceship with less than 70 Watts of power available for the computer. That weighed about 70 pounds." — da_chicken [c:50001631]
> （译文：一个带任务优先级、中断和实时响应的异步调度器，它要跑在一艘给计算机留了不到 70 瓦供电的飞船上，整机重约 70 磅。）

`da_chicken` 给出的关键词是 Hamilton 自己造的词 **man-rated**——「测试到可以拿人命担保」。`jonstewart` 和 `bronson` 把它翻译成可以互相校验的数字：4KB RAM、16KB ROM、0.043 MIPS、每个任务每秒 5000 条指令。`da_chicken` 补上最容易被忽略的两项约束——不到 70 瓦、约 70 磅——并指出当时还在用异步优先级多任务的机器是 IBM OS/360 大型机和 DEC PDP-6/PDP-10，小型机时代。`jacquesm` [c:50001313] 一句话收口：「在那种硬件上同时跑这么多任务本身就是个小奇迹，这不是你平均意义上的 Linux kernel。」

### 1202 到底是奇迹还是常规操作

> "That does not seem like particularly notable example of foresight & robustness, given that it’s such a low number of maximum tasks, and such a fundamental & frequently used element of its operation." — setr [c:50001166]
> （译文：考虑到最大任务数这么低、又是操作里最基础且最高频的一环，这看起来并不算特别值得一提的前瞻性与鲁棒性。）

> "Like it wouldn’t even be describable as a “rescue itself” if the response was simply “No. Too many jobs running. Please kill one to continue”" — setr [c:50001166]
> （译文：如果机器的反应只是「不行，任务太多，请先关掉一个再继续」，那连「自我救场」都算不上吧。）

`setr` 是这一帖里少数反向的读者，他的质疑有具体形状：AGC 最多只能同时跑 7 个任务，第 8 个进来就报警——这种「上限极低 + 触发条件极日常」的设计，在他看来不该被包装成前瞻性奇迹。这个质疑没有被反驳，但也没有被支持；两边都停在判断层面。倒是 `da_chicken` 的原帖补了另一半事实：1202 并非凭空出现的负载高峰，而是「阿姆斯特朗准备手动着陆，Aldarin 按下按钮显示高度与位置」这类动作把任务数顶到了 8，加上一个硬件开关故障才溢出。

### software engineering 这个词，后来被谁改了含义

> "IMO software is not engineering because it has nothing to with the physical sciences" — pvab3 [c:50000849]
> （译文：在我看来软件不是工程学，因为它跟物理科学毫无关系。）

> "It becomes engineering when the software is flying to the moon and back." — akamaka [c:50000870]
> （译文：当软件飞去月球再飞回来的时候，它就成了工程。）

> "Little did she know, the term would be co-opted by guys changing the color of a button on a web site." — penskymaterial [c:50000489]
> （译文：她大概不知道，这个词后来被一群改网页按钮颜色的 guys 收编了。）

> "And gate-kept by just as many. I wonder what she'd take more issue with. My understanding is she wanted to elevate people who work on software, not draw a line around it." — doginasuit [c:50000702]
> （译文：而且守着这条界线的人一样多。我不知道她会对哪一件更不满。按我的理解，她想抬举的是写软件的人，不是划一条线把别人挡在外面。）

`pvab3` 与 `akamaka` 是本帖最干净的一次交锋：软件工程算不算工程学，答案被压成了一句「飞去月球再飞回来」。`monocasa` [c:50000962] 给了更工程化的版本——软件受物理世界和当下造器件能力的约束太多，在这些约束里交付别人能依赖的价值，这定义不算差。另一半讨论完全不严肃但更痛：`penskymaterial` 与 `doginasuit` 指出，Hamilton 本人 2009 年对 MIT News 说的是要把软件「抬到应有的尊重」，而这个词的日常落点变成了改按钮颜色、改 title 描述、被 gate 住。`catskull` [c:50000350] 顺手追了一句词源——这个说法来自一次为某本冷门教科书做的访谈，他后来把原文翻出来贴到了自己博客。

### 软件工程师该不该像造桥的工程师那样被追责

> "I just wish that software engineers had a similar level of accountability that an engineer building something like a bridge is held to. When a negligent software engineer causes harm to people nothing typically happens. No real risk of lawsuits, or loss of license, or worry about their liability insurance." — autoexec [c:50001219]
> （译文：我只希望软件工程师能拥有与造桥的工程师相当的责任水平。当一个疏忽的软件工程师害了人，通常什么都不会发生——没有真正的诉讼风险，不用怕吊销执照，也不用担心自己的责任保险。）

> "Well, Meta just settled with states to the tune of 17 billion dollars for harm caused by its algorithms." — saimiam [c:50001501]
> （译文：Meta 刚和各州就其算法造成的损害达成了 170 亿美元的和解。）

`autoexec` 后面还跟了半句更痛的话：没有问责，也就意味着软件工程师在老板要求实现明知不安全的东西时，没法有效地说不。这条线索被 `saimiam` 用新数据顶回去——`autoexec` 举例航空公司的客服 bot 承诺了不存在的折扣票价被判赔偿，`saimiam` 补上 Meta 的 170 亿和解和近年频发的勒索案例，结论是「公司」在被罚，写代码的人未必被罚。责任落点从个人身上移到了组织身上。

### 她的功劳是不是被后人的文章吹大了

> "She was an excellent leader in a time when women were not commonly in leadership roles. She clearly understood coding and perhaps changed the way the field viewed the importance of software. Did she do any coding that was monumental herself? All I can find is fluff pieces." — ghastmaster [c:50000732]
> （译文：她在女性很少担任领导的年代是一位出色的领导者，她显然懂编程，也可能改变了整个领域对软件重要性的看法。但她自己有没有写出什么 monumental 的代码？我能找到的全是吹捧稿。）

> "She assumed management of the team after most of the code was written. She probably did something cool, but almost certainly not as much the praise articles of the last 15(?) years would like you to believe." — jojobas [c:50001263]
> （译文：她是在大部分代码写完之后才接手带这个团队的。她大概干过很酷的事，但几乎肯定没有过去十五年那些吹捧文章希望我相信的那么多。）

> "A link has been removed from other comments which argues with primary sources that she did not participate in the moon landing project to the extent suggested here. Her rise in popularity coincided with a Wikipedia effort to identify "overlooked heroes" in math and science." — groundzeros2015 [c:50001171]
> （译文：别的评论里有一个链接被删掉了，它援引原始资料论证 Hamilton 参与登月项目的程度没有这里说的那么高。她的流行度上升，与 Wikipedia 那场「找出被忽视的数学与科学英雄」的编辑行动同时发生。）

这是本帖最尖锐的一段事实争议。`ghastmaster` 的疑问很具体：那几张著名照片里的代码，是她写的还是她指挥别人写的？`jojobas` 给出的反方说法更具体——她接手管理时大部分代码已经写完。`groundzeros2015` 提供了第三个维度：把功劳叙事放回 Wikipedia「被忽视的英雄」运动的时间线里看。

争议的收尾方式本身就是新闻。有两条质疑被 downvote 到 killed，`golergka` [c:50001327] 为此发帖：「Personally, I don’t know enough to have an opinion, and I’m not sure if it’s appropriate to discuss in comments about her death either. However, downvoting and killing comments just because you disagree with them is not right.」`saagarjha` [c:50001556] 给出另一套标准：「It is not appropriate and downvoting those comments is how one indicates this.」关于一位刚去世者该不该在评论区被质疑，两边给的是完全不同的社区规范答案。

### 评论区自己先打起来了

> "I disagree. Suggesting that an accomplished woman must have slept with someone to get ahead is incredibly hostile. I was reserved." — dpkirchner [c:50000961]
> （译文：我不同意。暗示一个有成就的女性必须靠跟人上床才能出头，这非常有敌意。我已经很克制了。）

> "Do you get angry at all suggestions of nepotism, or just that particular variation?" — jadamson [c:50001037]
> （译文：你是对所有「靠关系上位」的说法都生气，还是只对那一种变体生气？）

> "How do we know 'she' was real at all? (let alone did all those amazing, yet unprobable things.)" — rsalama2 [c:50001822]
> （译文：我们怎么知道「她」是真实存在的？（更别说她还做了那些了不起、又难以置信的事了。））

> "I have no horse in this race but I've seen nothing in this thread that could be considered "dangerous" by any possible meaning of the word. Just minor flame-warring between people who assume the other side is acting in bad faith, which of course instantly derails any chances of understanding." — GaryBluto [c:50001725]
> （译文：我在这事上没有立场，但这个帖子里我看到的没有任何东西能被任何一种意义称为「危险」。只是一群认定对方在耍坏心眼的人互相小规模对喷，这当然瞬间就毁掉了任何理解的可能。）

事实争议一旦碰到性别，一条线就被引燃了。`dpkirchner` 说「睡上去」这种暗示极度有敌意，`jadamson` 立刻反问：你是对所有关系上位论都愤怒，还是只针对这一种变体？还有人把「她是不是真的存在过」搬了出来。`GaryBluto` 是帖子里少数尝试降温的人，他的诊断比冲突本身更有价值——两边都预设对方不诚实，于是任何理解的可能在第一句就被掐掉。

### 那张著名照片，和被压扁的历史

> "First thing I thought of, too. "Who? ...Wait, not the cool book chick!"" — underlipton [c:50000725]
> （译文：我的第一反应也一样。「谁？……等等，不是那个『很酷的书呆子女孩』吧！」）

> "I’m sorry, I thought this was Hacker News, not Bros R Us. Ms. Hamilton worked on three seminal software projects: Ed Lorenz’s meteorology programs which led to the Lorenz attractor, SAGE, and Apollo. It is hard for me to square your first paragraph with your second, but I’d submit she’s deserving of far more respect than “cool book chick.”" — jonstewart [c:50001397]
> （译文：抱歉，我以为这是 Hacker News，不是「Bros 之城」。Hamilton 女士做过三个奠基性软件项目：催生了洛伦兹吸引子的 Lorenz 气象程序、SAGE 和阿波罗。我没法把你的第一段和第二段放在一起看，但我要说，她值得的尊重远不止「很酷的书呆子女孩」。）

> "I don't usually correct this, but in her iconic photo she's standing next to printed output of an Apollo simulator run, not the actual source code for the AGC or lunar module." — jshier [c:50000528]
> （译文：我一般不做这种更正，但那张著名照片里，她身旁堆着的是阿波罗模拟器运行打出来的打印输出，不是 AGC 或登月舱的源码。）

`jshier` 修正了一个流传最广的事实：那张照片里比她人还高的「代码」，是模拟器的打印输出，不是飞行软件源码（他随后自己补了一句「也可能是两者混合，我查到的大概是这样」）。`jonstewart` 的反驳把被压扁的历史补齐：Lorenz 的气象程序（后来通向混沌理论）、SAGE、阿波罗，三个项目，而不是一张照片加一句「登月代码之父」。

社区里还有另一类材料没有被忽略。`0xpgm` [c:50001702] 引用 Steven Levy《Hackers》第五章的原句，说她在记忆里把九楼那群 hacker 简化成一个集体人格——「one unkempt, though polite, young male whose love for the computer had made him lose all reason」。围绕这段记忆，`bitwize` [c:49999699] 引 Allison Parrish 的说法，认为旧式 hacker 文化从起点就带着有毒男子气节；`kragen` [c:49999957] 逐条反驳，认为史料里只有不负责任、没有男子气节，问题出在那个时代的性别文化对女性更少宽容。方法论上还有一条线：`bitwize` [c:49999747] 说他谈过很多年的 PRIDE（Milt Bryce 的信息系统方法论），而 Hamilton 正是这类方法论的前身之一，「She got the ideas out there; PRIDE just commercialized them」。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 关键词 | da_chicken | Hamilton 自造的词是 man-rated，测到可以拿人命担保 |
| 硬件约束 | jonstewart | 4KB RAM + 16KB ROM 里塞 8 个登月任务的调度器 |
| 算力约束 | bronson | 0.043 MIPS，每任务每秒约 5000 条指令 |
| 能源约束 | da_chicken | 不到 70 瓦、70 磅，同期只有大型机有这种多任务能力 |
| 存疑 1202 | setr | 上限只有 7 个任务，属于常规设计而非前瞻性奇迹 |
| 工程学定义 | pvab3 | 软件跟物理科学无关，不算工程 |
| 工程学定义 | akamaka | 软件飞去月球再飞回来时，它就是工程 |
| 工程学定义 | monocasa | 物理约束下的可靠交付，这定义不算差 |
| 词义漂移 | penskymaterial | 这个词最后被改网页按钮颜色的人收编了 |
| 词义漂移 | doginasuit | 她想抬举写软件的人，不是划线挡人 |
| 词源考据 | catskull | 说法出自一次冷门教科书的访谈，已翻出原文 |
| 责任缺失 | autoexec | 疏忽的软件工程师几乎不用付出代价，也因此无法对老板说不 |
| 责任落地 | saimiam | Meta 刚赔 170 亿，但被罚的是公司不是写代码的人 |
| 功劳质疑 | ghastmaster | 她懂编程、领导有力，但 monumental 的代码是不是她自己写的？ |
| 功劳质疑 | jojobas | 她接手时大部分代码已经写完 |
| 叙事质疑 | groundzeros2015 | 她的流行与 Wikipedia「被忽视的英雄」编辑行动同期 |
| 社区规范 | golergka | 只因不同意就把评论 kill 掉不对 |
| 社区规范 | saagarjha | 不该在这里讨论，downvote 就是表达不赞同的方式 |
| 性别冲突 | dpkirchner | 「靠睡上位」这种暗示极度有敌意 |
| 性别冲突 | jadamson | 你是对所有关系上位论愤怒，还是只针对这一种？ |
| 降温 | GaryBluto | 只是双方都预设对方不诚实，小规模对喷而已 |
| 事实修正 | jshier | 那张著名照片里堆的是模拟器打印输出，不是源码 |
| 补全历史 | jonstewart | Lorenz 气象程序、SAGE、阿波罗，三个奠基项目 |
| 前史追溯 | 0xpgm | 《Hackers》记载她在记忆里把九楼 hacker 简化成一个集体人格 |
| 方法论前史 | bitwize | PRIDE 的前身之一就是 Hamilton，PRIDE 只是把它商业化 |
| 个人回忆 | CyberMacGyver | 多年前在西雅图跟她姐姐学过钢琴，当时完全不知道她是谁 [c:50000834] |
| 时代定位 | diskzero | Draper Lab 那一段是正确时间、正确地点的例外时刻 [c:50001772] |
| 词条推荐 | xtajv | Frank O'Brien《The Apollo Guidance Computer》ISBN 978-1-4419-0876-6 [c:50000479] |

## 总体情绪

整体是哀悼，但哀悼里长出了一次罕见的准史学争论。1023 分的帖子在 HN 上刚好跨过 item 50000000 这条线，`verdverm` [c:50000385] 说「congrats on being the 50M HN item, probably not legendary though」，`jamiek88` [c:50000000] 回「The word legend is used too much. She absolutely qualifies.」——这个 id 巧合本身成了帖子里一个小型彩蛋。有人提议挂黑条（`saulpw` [c:49999279]、`EvanAnderson` [c:49999623]「She was a pioneer of making software quality into a formal discipline」），也有人贴出讣告里那句被引用最多的话，配上一个「If only!」——`sib` [c:50001395] 引的是 Hamilton 2009 年说的「Because software was a mystery, a black box, upper management gave us total freedom and trust.」

三条裂缝贯穿全场。第一条是**历史压缩**：一张照片被误传成源码，一个三项目的人生被压成一句口号，一个在 1968 年才被证明有用的补丁被排成轶事。第二条是**词义漂移**：Hamilton 想抬举的是软件工程师，2026 年的 software engineer 常常在改按钮颜色。第三条最难看——事实质疑刚一出现，就迅速滑向对死者动机与性别处境的攻击，直到 `GaryBluto` 出来说「nothing dangerous here，只是双方都预设对方不诚信」。

值得注意的是社区自己知道这次翻车。质疑者被 kill 之后，`golergka` 与 `saagarjha` 还在争论什么才是死亡帖里该有的讨论方式。`diskzero` [c:50001772] 讲的或许是更贴题的一层：Draper Lab 那段工作是「正确时间、正确地点的例外时刻」，同一个人能在三十年后做分布式音频软硬件，说明难做的事并没有消失，只是**能被正确命名、被承认、被写下来的那一小部分，会比人活得更久**——所以真正该较劲的地方不是「她有没有亲手写完那段代码」，而是「下一个 4KB 里的调度器，会被谁写成文档」。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Margaret Hamilton, computing pioneer who led software development for the Apollo program, dies at 90（MIT News） | https://news.mit.edu/2026/margaret-hamilton-computing-pioneer-dies-1007 |
| 2 | NYT 讣告（由 ChrisArchitect 提供） | https://www.nytimes.com/2026/10/07/obituaries/margaret-hamilton-dead.html |
| 3 | Apollo 11 导计算机代码（GitHub，2015 年全量上传） | https://github.com/chrislgarry/apollo-11 |
| 4 | Margaret Hamilton in Her Own Words（Computer History Museum 口述史） | https://computerhistory.org/blog/margaret-hamilton-in-her-own-words/ |
| 5 | Frank O'Brien, The Apollo Guidance Computer: Architecture and Operation | https://link.springer.com/book/10.1007/978-1-4419-0876-6 |

<div class="disclaimer">

本摘要为 AI 辅助整理，仅基于 HN 公开讨论，所有引文均标注原帖评论 ID。观点不代表本站立场，引用如有偏差欢迎指正。讨论中涉及对在世/已故人物贡献大小的争议，均按原帖观点呈现，未做事实裁决。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
