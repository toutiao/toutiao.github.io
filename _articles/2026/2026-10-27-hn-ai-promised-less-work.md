---
layout: post
title: >-
  AI 说好让人少干活：他的年度贡献量却超过了 2021 到 2025 任何一年 — HN 讨论摘要
date: 2026-10-27
hn_id: 50257325
categories: [articles]
excerpt: >-
  2026 年前 10 个月 2102 次 GitHub 贡献，8 月单月 427 次创历史新高，工作日中位数从 3 到 4 次升到 7 次。
  评论区争的不是数据，而是那个从没兑现的前提：AI 让人少干活，效率红利也该落到干活的人头上。
tagline: >-
  说好省时间，贡献曲线却回到了当全栈工程师的年份。
---

## 原文概要

作者是 Orestis Ioannou，Bold.org 的技术副总裁。全文的数据来自他自己的 GitHub 贡献日历：从 2019 年 1 月到 2026 年 10 月 27 日，按月统计提交、PR、review 和 issue（含私有仓库）。2019 年是不完整基线——他上一份工作用自建 GitLab，GitHub 上只有工作之外的记录。

先看他的角色与数字的对应关系。2020 年 1 月加入 Bold.org，2020 年 1 月至 2022 年 8 月做全栈工程师，2022 年 8 月至 2025 年 8 月是首席工程师，2025 年 8 月起是技术副总裁。

- 全栈工程师时期：2020 年 2711 次贡献，是他的最高年份；2021 年降到 1839 次，2022 年 1498 次。
- 首席工程师时期（2022 年 8 月至 2025 年 7 月）：月均 114 次，全栈时期是月均 173 次；2023 年最低，1189 次。
- 2025 年 8 月至 12 月初当 VP：月均 111 次，其中 2025 年 12 月是加入 Bold.org 以来最安静的一个月，只有 50 次。

转折发生在 2026 年：

- 到 10 月 27 日已经 2102 次，超过 2021 到 2025 任何一整年；2020 年同期是 2371 次。
- 8 月 427 次，是整条时间线上的单月最高，此前最高是 2020 年 4 月的 319 次；9 月 301 次。
- 工作日中位数从 2022 到 2025 年的 3 到 4 次升到 7 次，2020 年是 8 次。
- 零贡献的工作日：2022 到 2025 年每年 40 到 46 天，2026 年到 10 月 27 日只有 18 天。
- 单日 24 次以上的贡献：2022 到 2025 年每年恰好 1 天，2026 年已经 16 天，2020 年全年是 17 天。
- 公开贡献在 2021 到 2025 年接近零，2026 年到目前 191 次，不到 2026 年的十分之一。

曲线不是平滑上升，而是一轮轮的爆发与回落。1 月 277 次、2 月 233 次，这是他开始认真用 agent 的阶段，内部的 observability 实验也在这时跑起来；3 月降到 203 次，4 月 187 次，其中有一天 29 次、公开贡献 68 次，是全年公开贡献最高的月份；6 月只剩 77 次；8 月 427 次、9 月 301 次。他数下来一共经历了三轮这样的循环。

作者给出的解释很直接，而且他先声明自己不是在抱怨工具——他现在的所有工程工作都用 agent 完成。实现变便宜之后，想做的事全都想同时做，于是他开更多 agent、开更多线程、对更多实验说 yes；过几周，review 和上下文切换的负担追上来，他就退回一个稳定节奏，等下一个新模型或新工作流出现，再来一轮。最后一句落在两个不匹配上——实现想法的能力涨得比思考想法的能力快得多；能做的事越来越多，就变成了做更多的事，而且我很累。

文章末尾他注明：AI 帮他提取并分析 GitHub 贡献数据、画图、起草这篇文章，经历与观点是他自己的。

## 讨论焦点

### 一、这个前提从来就不成立

评论区里被质疑的不是数据，是标题里那个前提。nkrisc 的两条回复把话说得最直接：

> "The opening premise baffles me. What kind of illusion must one be under to believe that employers would ever pay you the same amount of money to do less work?" — nkrisc [c:50258334]
> （译文：文章开头的前提让我困惑。要相信老板会为更少的工作付同样的钱，得处在什么样的幻觉里？）

> "Realistically there were only ever two possible outcomes: you do more work for the same amount of money, or you’re one of the ones who were laid off and your work was transferred to the former." — nkrisc [c:50258334]
> （译文：现实里从来只有两种结果：你要么用同样的钱干更多的活，要么你被裁掉，活儿转移给了前者。）

boringg 补的是历史那一层：

> "If you don't recall the early innings of AI - that was a big promise from a vocal group of people." — boringg [c:50258478]
> （译文：如果你不记得 AI 的早期岁月——那是一小群高调的人许下的大承诺。）

10111001 则把这看成一种典型的自我叙事：

> "It seems like a pretty common misunderstanding in rank-and-file AI-boosterism." — 10111001 [c:50258783]
> （译文：这在基层的 AI 鼓吹者里似乎是个相当常见的误解。）

他的解释是：这些人最初的体验——老板还没调整预期的那段——被外推到了无穷远。

### 二、效率红利去了哪里：雇主拿走的那一块

如果红利没落到作者身上，它落在谁手里？Zak 的回答最短也最不留情面：

> "A rational employer is interested in how much value they can get, not how hard you work. In most cases, in the short term, an increase in efficiency means they can get more value from you working the same amount of the same pay." — Zak [c:50258465]
> （译文：理性的雇主关心的是能从你身上榨出多少价值，不是你干得多辛苦。多数情况下，短期里效率提升意味着他们用同样的工时、同样的薪水从你身上拿到更多价值。）

bunderbunder 说得更深一层：钱不是被 AI 拿走的，是客户没钱了。

> "They aren’t paying more for productivity because they themselves aren’t earning more for productivity. The elephant in the room is that customers don’t have any more money to spend." — bunderbunder [c:50258390]
> （译文：他们不为生产力付更多钱，因为他们自己也没从生产力上赚到更多钱。房间里的大象是，客户手里没有更多的钱可以花。）

他随后解释，软件产量增加不会像制造业那样堆在仓库里让人看见，于是多年下来管理层普遍把程序员的时间当成生产力来记账，已经没有能力识别那些纯属多余的代码：

> "Decades of accounting for all programmer time as productivity has left managers with limited ability to recognize time spent building unnecessary bloat as a loss." — bunderbunder [c:50258390]
> （译文：几十年来把所有程序员时间都记作生产力，让管理层几乎失去了识别『花在无用膨胀上的时间是一种亏损』的能力。）

citrin_ru 讲的是议价关系：

> "AI give employers immense leverage - by threading with AI layoffs they can exploit workers and in the current job market many have nowhere to go." — citrin_ru [c:50258150]
> （译文：AI 给雇主巨大的筹码——用 AI 裁员的威胁，他们就能压榨工人，而在现在的就业市场上很多人无处可去。）

### 三、同样的经历：事情变多了，人没变轻松

作者描述的那种「不是每件事更难，是同时在手的事太多」，评论区里有人原样复现。sailfast 讲的是上游输入也被 AI 提速之后，整个人像被按着油门：

> "Unfortunately this means that you always feel the need to keep building or fall behind (picturing Lucy and Ethel at the chocolate factory) which means you’re pretty much always feeling burnt out and it feels harder to step away than ever before without feeling a certain way about it." — sailfast [c:50258140]
> （译文：不幸的是，这让你总觉得必须一直造下去，否则就掉队（想象一下《查理和巧克力工厂》里的露西和埃塞尔），于是你几乎一直处于燃尽状态，而且要抽身比以往更难，抽身时还得带着某种说不清的感觉。）

englishspot 的描述更贴近技术活儿的形态：

> "the amount of work I get done increased exponentially, but so did the number of things I have to keep track of in my head." — englishspot [c:50258315]
> （译文：我做完的事情量指数级增长，但要在我脑子里记住的东西数量也指数级增长。）

logicchains 把这件事归到人的角色上——AI 不擅长的那部分空缺，仍然要人来补：

> "AI needs humans to fill in the gaps at what it's not good at: acquiring and managing large volumes of new information/context." — logicchains [c:50258264]
> （译文：在 AI 不擅长的部分——获取并管理大量新信息和上下文——仍然需要人来填坑。）

他的结论是，项目规模膨胀得更快，人得学得更快，也得花更多时间在管理和切换上下文上。y-curious 则指出另一个正在被默认接受的东西：

> "It’s a mixed bag. I would say the worst part is that the increased level of output AND the increased level of tech debt is becoming accepted as the norm." — y-curious [c:50258673]
> （译文：这是把双刃剑。我觉得最糟的部分是，产出量的提升和技术债的提升，正在一起被当成常态接受下来。）

也有人给出完全相反的体感，认为 AI 抹掉的是最枯燥的那部分工作：

> "Oh but AI has wiped out some of the most tedious work I have to do." — jvanderbot [c:50258610]
> （译文：可是 AI 把我要做的那些最枯燥的活儿给抹掉了。）

他随即说自己现在能轻松工作每一个清醒的钟头，甚至包括睡着的部分，工作日因此变轻松了。nkrisc 在下面回了很短的两句：

> "That is not something that should be celebrated." — nkrisc [c:50258880]
> （译文：这不该被庆祝。）
> "It is a warning sign." — nkrisc [c:50258880]
> （译文：这是个警告信号。）

### 四、省下来的时间被复核吃回去

另一条线是：agent 交付得快，但读 diff、判断对错、接住它的错误同样要时间。thatsabadlook 说得直接：

> "No. Actually some things take longer and lead to worse outcomes. AI tools invent problems and find work for themselves while also failing at their stated tasks in opaque ways all the damn time." — thatsabadlook [c:50258346]
> （译文：不。实际上有些事情花的时间更长，结果还更差。AI 工具会自己发明问题、给自己找活干，同时又不停地以各种不透明的方式搞砸它自己声称要做的事。）

但也有人算的是另一笔账：省下来的时间花到哪儿去了。metobehonest 的体感正好相反——把想问题和冒点子挪到吃饭的间隙，反而像回到了从前：

> "Thinking about the domain, typing a bit, maybe having a new idea while I'm eating on a break now feels like a memory of heaven." — metobehonest [c:50259386]
> （译文：现在一边吃午饭一边想问题、打几个字、冒出新点子，感觉像是天堂般的回忆。）

同一位读者抱怨的是相反方向的成本：他成天陷在对话里，要读大量密集文字，每个词都要对回此前生成文档里的术语表，分辨哪些是过度设计的胡话、哪些是真必要。

### 五、反过来看：AI 也把个体的杠杆放大了

同一批人里，也有另一面。logicchains 认为对个人而言杠杆是变大了的：

> "AI also gives employees much more leverage than before, as they no longer need a large team to compete with BigCos at knowledge work. It's never been cheaper to start a software business." — logicchains [c:50258301]
> （译文：AI 也给打工人提供了比以前大得多的杠杆，因为他们在知识型工作上不再需要一支大队伍才能和巨头竞争。开一家软件公司从来没有这么便宜过。）

trollbridge 自己开公司，描述的是另一侧的挤压——客户预期更高，还要跟全世界的 vibe coder 竞争：

> "So that means shipping higher quality, faster, with more features, and for a lower end price." — trollbridge [c:50258433]
> （译文：这就意味着要用更低的价格，交付更高的质量、更快的速度、更多的功能。）

而 rkozik1989 认为个体创业这条路的门槛正在塌陷，塌陷本身就是问题：

> "Pretty much by definition anything that requires low effort is easy to clone and thus become saturated." — rkozik1989 [c:50258483]
> （译文：按定义，任何不需要太多力气的事都很容易被复制，于是迅速饱和。）

debazel 把这一层推到底：软件本身的价值从没这么低过。

> "The side effect of this is also that the value of software itself has never been lower, so starting a new software business isn't very attractive in today's market." — debazel [c:50258445]
> （译文：这件事的副作用是，软件本身的价值从没有这么低过，所以在今天的市场里，开一家新的软件公司并不那么有吸引力。）

### 六、替代、去技能化，和组织起来的可能

更冷的一层是：效率翻倍的时候，谁先被裁。jerf 用一个假想场景把这个问题问了出来：

> "One company fires 90 engineers and does the same work with the remaining 10. The other company keeps all its engineers and does 10 times the work." — jerf [c:50259031]
> （译文：一家公司裁掉 90 个工程师，用剩下的 10 个人干同样的活；另一家公司留住全部工程师，干出 10 倍的活。）

他的问题是：谁在市场上赢？pessimizer 的回答指向岗位本身：

> "The increase in efficiency has largely come from deskilling the job. Deskilling the job makes the employees time less valuable, because they can be substituted for another more easily." — pessimizer [c:50258644]
> （译文：效率提升主要来自岗位的去技能化。岗位去技能化让员工的时间更不值钱，因为他们更容易被替换成另一个人。）

（他还补了一句现实约束：干得更快不意味着有更多活可干，如果以前两个人能按时完成，现在能裁掉一个——至于裁谁，就是一场反向工资竞拍。）

如果个体对老板没有议价能力，剩下的选项只有两个：自己单干，或者组织起来。conception 提的是后者：

> "You are missing a critical third - people organize and via unions or the polls push back and require less work. There is no reason we aren’t working seven days a week beyond people fighting not to." — conception [c:50258450]
> （译文：你漏掉了关键的第三种可能——人们组织起来，通过工会或投票反推，要求更少的工作。除了有人在抵抗，我们没有任何理由不一周工作七天。）

smallmancontrov 认为这条路有个前提问题：

> "The trouble with unionization is that it doesn't really address supply and demand, just bargaining." — smallmancontrov [c:50259320]
> （译文：工会的问题在于，它真正处理的不是供求，只是谈判。）

（他给出的替代思路是另一组杠杆：加班法、休假政策、退休政策、教育投入、税制——而不是只盯着集体谈判。）

Aurornis 则补了约束条件：

> "Much of this unionization conversation has lot the plot about how unionization is about collective bargaining, but you still have to bargain." — Aurornis [c:50259013]
> （译文：关于工会化的讨论大多丢了主线——工会是集体谈判，但谈判本身还是得谈。）

solyin 指出组织起来的难点不在想法，在时机：

> "The problem is everyone's financial cliff is different." — solyin [c:50259071]
> （译文：问题在于每个人的财务悬崖都不一样。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 效率红利全被雇主拿走 | Zak | 理性的雇主只看你能产出多少价值，不看你多累 |
| 根因是客户没钱了 | bunderbunder | 产量涨了收入没涨，代价是没人认维护负担 |
| 效率主要来自去技能化 | pessimizer | 岗位门槛降低 → 更好被替换 → 工资由供求决定 |
| 老板的筹码是裁员威胁 | citrin_ru | AI 裁员让雇主在议价上更强势 |
| 同样是干活变多 | sailfast | 兴奋期只持续一年，之后是逃不掉的跑步机 |
| 省下的时间被复核吃掉 | thatsabadlook | 有些任务更慢更糟，AI 还会自己发明活儿 |
| AI 是个体的杠杆 | logicchains | 一个人也能跟大厂拼知识工作 |
| 小生意门槛低反而更卷 | rkozik1989 | 不费力气的事会被快速复制直到饱和 |
| 集体谈判不解决供求 | smallmancontrov | 真正要动的是加班法、休假政策和税制 |
| 组织起来谈何容易 | solyin | 每个人的财务悬崖不同，站起来的时点也不同 |

## 总体情绪

这是一场几乎没有共识的讨论，但分歧的形状很清楚：多数人认可作者的数据和他的观察——AI 让实现变便宜，于是人接下更多事——但对这件事的归属给出了完全不同的答案。一派认为效率红利被雇主和客户的预算拿走了，个人只是被榨得更干净；一派认为 AI 第一次把个体的杠杆放大到能和大厂对线；另一派越过个人层面去问，如果集体谈不下来，还有哪些别的杠杆可以拉。

作者自己的结尾比数据更诚实：他没有找到平衡，只是发现「能做的事更多」不断变成「做更多的事」，而他已经累了。文章里有一处对照值得单独拎出来——实现想法的能力，已经涨得比想出想法的能力快得多；而评论区把它的另一面拆开：让一个人一天干出三天的活儿不难，难的是让三个人各拿回自己那一份。

真正没人回答的问题是这 2102 次贡献背后，2020 年那个还会觉得 2711 次是负担的自己，和 2026 年觉得 427 次是常态的自己，究竟哪个更快乐。数据只记了次数。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AI promised less work. I've never worked more（HN 讨论） | https://news.ycombinator.com/item?id=50257325 |
| 2 | AI Promised Less Work. I Have Never Worked More（原文） | https://oioannou.com/blog/ai-promised-less-work/ |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论对象是 Orestis Ioannou 于 2026 年 10 月 27 日发表的文章 AI Promised Less Work. I Have Never Worked More，文中关于 Bold.org 的贡献量数据（2020 年 2711 次、2021 年 1839 次、2022 年 1498 次、2023 年 1189 次、首席工程师时期月均 114 次、2025 年 12 月 50 次、2026 年截至 10 月 27 日 2102 次、8 月 427 次、9 月 301 次、6 月 77 次、4 月 187 次、1 月 277 次、2 月 233 次、3 月 203 次、工作日中位数 3 到 4 次与 7 次、零贡献工作日 40 到 46 天与 18 天、单日 24 次以上每年 1 天与 16 天、公开贡献 191 次等）以及作者的角色变化（2020 年 1 月加入 Bold.org，2022 年 8 月起任首席工程师，2025 年 8 月起任技术副总裁）均整理自作者本人根据 GitHub 贡献日历所做的统计，属于作者口径的粗略活动信号，未包含自建 GitLab 上的工作记录，未经独立核实，请以原始链接为准。评论区中关于效率红利归属、雇主议价关系、去技能化与替代、集体谈判与政策杠杆等讨论，均为读者在公开论坛的个人观点，本文照录而不作事实认定。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
