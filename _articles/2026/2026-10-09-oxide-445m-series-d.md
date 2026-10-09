---
layout: post
title: >-
  Oxide 4.45 亿美元 D 轮：缴税才是大新闻
date: 2026-10-10
hn_id: 50020014
categories: [articles]
excerpt: >-
  一家硬件创业公司靠卖计算机赚到正 EBITDA——在 AI 公司普遍亏损的当下，这本身就是宣言。
tagline: >-
  BC 亲自下场反驳：扯淡，1996 年我面试 Sun 也是 9 小时。
---

## 原文概要

> 来源：HN 热门榜 (/best)

Oxide 由 Bryan Cantrill 和 Steve Tuck 创办，主营机柜级本地基础设施——一台"大计算机"（技术上是一组机柜里的多台服务器），提供云厂商风格的 API 来管理本地资源：开虚拟机、磁盘、VPC。原文标题是"Our $445M Series D"，但被读者和创始人反复强调的真正信号是：Oxide 在 2026 年春天向 IRS 实际电汇了一笔所得税——这不是会计意义上的盈利，是真金白银从经营性业务（卖计算机）赚到的钱。Cantrill 在配图说明里写"US BEING AS EXCITED AS YOU CAN BE PAYING TAXES"，Steve 正准备按下"确认"。

D 轮 4.45 亿美元由 Eclipse 领投，老股东 USIT、Riot Ventures、Jane Street 大额参与，新引入 Atreides Management 与战略投资人 AMD。AMD 早在 Oxide 创立初期就是 EPYC 平台的押注方，本次进入 cap table 被描述为"长期合作"。

资金用途是硬件创业公司特有的难题：必须在拿到客户付款前大笔押注元器件和制造成本。Cantrill 把 Oxide 的保守态度归因于他和团队"都是互联网泡沫破裂的孩子"。

## 讨论焦点

### 真新闻不是 4.45 亿，是"我们缴税了"

> "Reading the article though it was interesting that having a positive EBITDA was the real news here. Not a single AI company can claim that. That's a pretty big milestone." — ChuckMcM [c:50024007]

> （译文："读完整篇文章，真正的大新闻其实是他们已经实现正 EBITDA。AI 行业里没有一家公司敢说自己做到了。这是一个相当大的里程碑。"）

> "They just paid income tax?" — parthdesai [c:50020446]

> （译文："他们刚刚真的交了所得税？"）

> "You can still be heavily cash flow negative while being Net Income positive. It's actually one of the big use cases for VC money; you have a flywheel of revenue but not enough cash to pay to service that revenue and actually get cash." — log_n [c:50021159]

> （译文："你完全可能在净收入为正的同时，现金流严重为负。这就是 VC 资金最大的用途之一：你有收入飞轮，但手头现金不够支付提供这些收入所需的服务，账面上的钱根本到不了账上。"）

评论区的焦点很快从融资金额转移到 Oxide 罕见地向 IRS 电汇真金白银——大多数被投公司离这一步还有几年。Cantrill 在评论里确认"这其实是真在缴税"，Steve 当时正发起一笔电汇。讨论迅速切到账面利润 vs 现金利润：硬件公司必须先垫付元器件和制造成本，订单交付前数月就要砸大笔现金，所以即便"盈利"也得继续融资。

### "9 小时面试是疯了"——一场关于招聘伦理的持久战

> "I was interested in applying to Oxide a few months back. They ask candidates who reach interviews to provide at least 9 hours of availability, normally arranged as three separate 3-hour blocks. Each block contains three 1-hour interview slots, so the standard schedule is effectively nine one-hour conversations. Not including the follow ups. I got another great offer after just 1 interview that I took, so I never went through their process, but it looks very exhausting to me. Being rejected after investing so much time must also feel awful." — bkolobara [c:50020561]

> （译文："几个月前我本来想投 Oxide。进了面试阶段他们要求候选人预留至少 9 小时，通常安排成 3 个独立的 3 小时时段，每个时段里排 3 场 1 小时面试。还没算后续。我面了另一家 1 轮就拿到的，就没走完他们的流程，但看起来真的很累。被拒的话投入这么多时间更糟。"）

> "Right...so best interview process in the game for employers, not so much employees." — orsorna [c:50020645]

> （译文："所以嘛——对雇主来说是业内最佳面试流程，对员工就未必。"）

> "Nine hours is crazy" — sergiotapia [c:50020740]

> （译文："9 小时太离谱。"）

Oxide 把面试拆成 3×3 小时时段的决定成了评论区火药桶。支持者说：在职跳槽的人一年才换几次工作，9 小时相对 2000 工作小时并不夸张；反对者说：现在很多人每月投 100 个岗位、面试通过率 10%，如果每家都这样，那就是 90 小时无偿面试。Cantrill 亲自下场：

> "Well, bullshit actually. When I went to Sun in 1996, I was flown out for a full day of interviews (9 hours!) plus both lunch and dinner. (And this was true for more or less every company I interviewed with.) I'm not sure why people are indexing so hard on the interviews, as we matriculate very few candidates into conversations; if you want to complain about something, complain about the written nature of our hiring process." — bcantrill [c:50022795]

> （译文："其实吧，扯淡。1996 年我去 Sun 面试，他们把我飞到现场做了一整天——整整 9 小时——外加午饭和晚饭。（基本上我面过的每家公司都是这样。）我不明白大家为什么死盯着面试时长，我们放进来面试的人本来就少；要吐槽就吐槽我们招聘流程里的书面材料环节。"）

> "When I worked at Oxide, you only get to the interview part if you're extremely close to an offer. Like, down to one or two candidates out of hundreds." — steveklabnik [c:50021846]

> （译文："我在 Oxide 工作的时候，只有离 offer 极度接近的候选人才能进入面试环节，基本上几百人里挑一两个。"）

> "In our interviews, the interviewer has read the applicant's detailed written materials, and the candidate has received the interviewer's materials from when they applied. So there is no elevator pitch, no walking through resume, no getting to know you. Just a conversation. We also advance very few candidates to interviews and hire a surprisingly large proportion of those who interview, so it's not like you're doing all this interviewing for the usual slim chance of being hired. The written materials are the primary filter." — dcre [c:50021016]

> （译文："我们的面试里，面试官已经读过候选人的书面材料，候选人也会收到面试官申请时写的材料。所以没有电梯演讲、没有过简历、没有'介绍一下自己'，就是直接对话。我们推进到面试的候选人很少，最终录用的比例反而很高——跟你面十家才拿一个 offer 的常态完全不同。书面材料是主要的筛子。"）

怀旧派依然觉得今非昔比：

> "'Job interviews' in tech used to be casual conversations of a few hours. There weren't even quizzes to see if you really could program, let alone leetcode-grinding insanity. Once a system gets gamed en masse, anti-gaming measures dominate, and ruin, the whole process. See also: ads vs. ad blockers, and the fact that you can't run a fucking email server of your own anymore without jumping through security hoops." — bitwize [c:50024013]

> （译文："科技行业的'面试'以前就是几小时的闲聊。连'你到底会不会写代码'的小测验都没有，更别说刷 LeetCode 那种疯狂的事了。一旦某个系统被大规模玩坏，反作弊手段就会主导，然后毁掉整个流程。同样的事也在广告和广告拦截器之间、自己搭个邮件服务器却要过一堆安全检查这些事上发生。"）

> "my first job at a startup (first engineer after the founders) consisted of 13 hours on the phone with the CTO over a few weeks and then an in person all day interview that included traveling from Chicago to SF and a couple of dinners with the founders. this was 1996. our typical interviews after joining were all day affairs and they people almost all people that were referred in or had worked with in the past (I wasn't). interviews at twitter back in 2010 were 6 hours and that was true even for me when we had an agreement to acquire my company pending the success of those interviews. at the time they had a lot of ex-googlers and they were setup similarly." — spullara [c:50024670]

> （译文："我第一家创业公司的职位（创始团队之后第一个工程师），先用几周跟 CTO 打了 13 小时电话，然后飞到现场做了一整天面试——从芝加哥飞到旧金山，跟创始人吃了两顿饭。那是 1996 年。我们后来招人都是一整天，主要候选人都是被推荐或者以前共事过的（我不是）。2010 年 Twitter 的面试也是 6 小时，就连我那次——他们已经签了收购我公司的意向，前提是我面试过——也是 6 小时。当时他们有一堆前 Google 的人，套路一样。"）

### 招聘流程的"书面材料地狱"

> "I read their 'we will respond to every application, even if it has to be a brief non-specific rejection' and thought that sounded like a great policy that I wish more companies would follow. It's been 6 months now and I never heard anything from them, so that's a little disappointing." — JRandomHacker42 [c:50020695]

> （译文："我看过他们说的'会给每份申请回复，哪怕只是简短的非具体拒信'，觉得这政策挺好的，希望更多公司学学。结果 6 个月过去了，我什么都没收到，有点失望。"）

> "I don't know how they possibly read all these in full. They are quite voluminous: 1-3 work samples, 1 analysis sample, 1-3 writing samples, 1 presentation sample, and then 8 open-ended long-form questions. The instructions often say to give as much detail as possible, and they are very clear that this is the main way they filter candidates, so I'm guessing serious applications are quite long. At some point, there becomes a mathematical impossibility of too many pages of applications for too few evaluators who also have to do the rest of their jobs. Either they don't get quite that many applications, or the initial evaluations must be based on some incomplete reading (looking just at the resume, reading a subsection, skimming, or randomly discarding), or the backlog keeps growing. Fwiw I also applied and the auto-reply said I should expect to wait 4-6 weeks, which has recently passed without hearing back. The application is a ton of work, and I don't mind doing it with a significant chance of being considered, but I think it's a normal reaction to be devastated if you put all that time and energy into crafting your materials, which manifest all your experience, behavior, and personality, and it turned out nobody read them. I still have a little hope, but I'm sorry you never got a response." — singron [c:50025739]

> （译文："我不知道他们怎么可能把每份都看完。材料非常长：1-3 份工作样本、1 份分析样本、1-3 份写作样本、1 份陈述样本，加上 8 个开放式长答案。说明里通常要求尽量详尽，而且明确说这是他们筛选候选人的主要方式，所以我猜认真的申请都是非常长的。但到某个临界点，太多页申请材料配太少评估者（评估者还有本职工作要做），数学上就说不通了。要么申请量没那么大，要么初筛靠的是不完整阅读（只看简历、扫一节、略读或随机丢弃），要么积压越积越多。我自己也投了，自动回复说请等 4-6 周——现在已经过了，还是没回音。申请本身就要花大量工作，如果你有相当概率被考虑，我没意见；但正常的反应是：你把所有时间精力都投进去写材料，那里面是你全部的经历、行为和性格，结果根本没人读。我还抱着一丝希望，但也为你没收到回复而遗憾。"）

> "No they don't. They waste very large amounts of candidate time on an essay like assignment before you get to talk to someone. Truth be told they already know from your resume if you'd be worth interviewing. That's enough, and maybe a OA. The best process I've experienced, was a quick conversion with a few technical questions, then I can start as a contractor. If it works out it works, if it doesn't that's ok too. No need for me to write a long paper, when HR probably took one look at my resume and sent out a rejection." — 999900000999 [c:50020884]

> （译文："他们才不会都回。他们让候选人花大量时间写一篇论文式的作业，才能跟人开口说句话。说实话他们从你简历里早就看出来值不值得面了——够了，可能再加一轮 OA。我经历过最好的流程：快速聊聊几个技术问题，然后我以 contractor 身份开始试，干得好就留，干不好也无所谓。没必要写长篇大论，HR 大概率瞄一眼简历就发了拒信。"）

Oxide 的招聘哲学在创始人这里有解释——Cantrill 罕见地吐露写作密集型流程的诞生来自一次刻骨铭心的失败：

> "What still blows my mind (at least a little) is that our process came directly out of one of the worst moments in my career: making an absolutely terrible hire about two years before we started Oxide. For a while after that, I wished I could go back and warn my previous self to not make the hire that would be so destructive to the organization -- but in the years at Oxide I have come to realize that that terrible hire was in fact essential for the future Oxide: it was the impetus for putting together a writing-intensive process, and there is no doubt in my mind that I had I not made this atrocious hire, I would have continued to hire the (broken) way that I had been hiring." — bcantrill [c:50025347]

> （译文："至今让我有点难以置信的是，我们的整套流程直接来自我职业生涯中最糟糕的一个时刻——创立 Oxide 大约两年前我做出了一次灾难性的招聘。那之后一段时间，我想回去警告过去的自己别招那个人——他对组织的破坏力实在太大了。但这些年我才意识到，那次糟糕的招聘对未来的 Oxide 其实是必要的：它正是让我们搞出这套写作密集型流程的契机。如果我没招错那个人，我八成还会沿用以前那种（已经坏掉的）招聘方式，这一点毫无悬念。"）

一次错误的招聘，决定了一家公司的招聘哲学。

### Oxide 到底是什么？

> "What is their product exactly? It's a server that is cheaper for some reason?" — idontwantthis [c:50021583]

> （译文："他们到底是做什么的？就是一台更便宜的服务器？为某种原因？"）

> "Change 'something' to 'a computer' and you got it! It's a big ass computer (technically many computers in a rack) that gives you a cloud provider style API to manage on-premises infrastructure. Plug it in, connect to the web console or API, and provision yourself some sweet sweet virtual machines, disks, and VPCs." — sudomateo [c:50021927]

> （译文："把那个'某种东西'换成'一台计算机'你就懂了！就是一台巨型计算机（技术上是一机柜多台），给你一个云厂商风格的 API 来管本地基础设施。插上电源，连上 web 控制台或 API，就能开虚拟机、磁盘和 VPC。"）

> "the product is a podcast the server is just merch" — imadethisjustfo [c:50021648]

> （译文："他们的产品其实是 podcast，服务器只是周边。"）

> "Also time for the quarterly reminder that On the Metal / Oxide and Friends is an excellent podcast if you're into Rust and/or EE. Bryan and co. do such a good job keeping the technical discussions entertaining. Seems like an awesome place to work, too." — piker [c:50020229]

> （译文："顺便又到了季度提醒时间——如果你对 Rust 和/或电气工程感兴趣，On the Metal / Oxide and Friends 是非常优秀的播客，Bryan 和搭档把技术讨论做得很生动。看样子也是个超棒的工作地方。"）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 真新闻是缴税不是融资 | ChuckMcM | 在 AI 公司普遍亏损的当下，正 EBITDA 是大新闻 |
| 9 小时面试合理 | bcantrill, Aurornis, steveklabnik, dcre | 候选人已通过书面筛选，面试集中是漏斗优化 |
| 9 小时面试过度 | orsorna, bkolobara, roarcher, sergiotapia | 在职求职者承担不起 |
| 书面材料流程被低估 | singron, 999900000999 | 大量申请可能根本没被读完 |
| 招聘哲学来自失败 | bcantrill | Oxide 写作流程源自本人一次刻骨铭心的招错人 |

## 总体情绪

评论区明显分两派。一派把 Oxide 当成"科技行业罕见的样板"——盈利、缴税、创始人下场回应每一条抱怨、把招聘失败写进博客当作"必要的创伤"。另一派觉得这是个"对员工不算友好"的范本——9 小时面试、几个月不回的申请、写着写着就让人觉得自己是数字而非合作伙伴。

整场讨论最耐人寻味的不是 Oxide 拿多少钱，而是一位创始人在融了 4.45 亿美元之后，还能抽空写评论告诉一位焦虑的应聘者"扯淡，1996 年我也是这么过来的"。这把双刃剑的另一面是：他自己也承认，那套"必须写作"的招聘流程不是因为理念高尚才发明的，而是因为他在 Oxide 创立前两年亲手招错了一个"破坏力极大"的人。一次错误的招聘，决定了一家公司的招聘哲学；而招聘哲学，又决定了未来几年每个坐在镜头前的候选人会被怎样对待。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Our $445M Series D | https://oxide.computer/blog/our-445m-series-d |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50020014 |

## 免责声明

<div class="disclaimer">本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。</div>

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>