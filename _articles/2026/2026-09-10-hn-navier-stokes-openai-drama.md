---
layout: post
title: >-
  Navier-Stokes 之争：AI 破题，还是偷看聊天记录？— HN 讨论摘要
date: 2026-09-10
categories: [articles]
excerpt: >-
  OpenAI 宣布内部模型找到 Navier-Stokes 反例，两位数学家却指控它偷看了自己一年来的 Codex 草稿，还想把 Anthropic 员工从作者名单里剔除。
tagline: >-
  你用 Codex 写证明，OpenAI 用你的聊天记录抢首发。
---

## 原文概要

9 月 8 日，纽约大学数学家 Tristan Buckmaster 在个人主页发布一份声明 PDF（HN 1996 分、约 810 条评论），讲述他和供职 Anthropic 的 Levent Alpöge 用 AI 研究流体力学近一年后，围绕 Navier-Stokes 方程爆出的风波。同一天，OpenAI 发布博客《On the Navier–Stokes Millennium Prize Problem》（HN 1327 分、约 1102 条评论），宣称内部模型找到了反例。两个帖子是同一话题的两面，本篇为 cluster 模式：主帖是声明 PDF（thread 1），OpenAI 公告为相关帖（thread 2）。

Buckmaster 的声明称，过去一年他和 Alpöge 借助多个 LLM 研究流体力学，用到 Anthropic 的 Claude、OpenAI 的 Codex，尤其 GPT-5.6 Sol，近期还加了 Astra。8 月中旬，他们为一个简化版本找到反例，随后几周准备论文。9 月初，X 上传出"Anthropic 解出了一个千禧年难题，而且是 Navier-Stokes"。Buckmaster 于是联系 OpenAI，澄清这是个人研究、与 Anthropic 无关。

几天后 OpenAI 回复：其内部模型同样找到了 Navier-Stokes 的反例，可能值 100 万美元的千禧年奖，用的正是 Buckmaster 和 Alpöge 选定的方法，但没有给他看证明。他追问细节后得知，OpenAI 有一整支团队在做，而且是在谣言之后才开工；连当初给他看的那条 prompt 也是用 Codex 写出来的。OpenAI 提出一个发表时间表：让 Buckmaster 先发，之后再分享千禧年奖的功劳，但要把 Alpöge 从作者中剔除，因为他在 Anthropic 工作。协议没有谈成。

声明里最刺眼的一段：Buckmaster 说如果 OpenAI 按提议发布，他会公开内情，对方回"为什么要毁掉你的职业生涯？"；他答自己是学者，反问为什么公开会毁掉职业生涯，对方回"如果你不想让我好好说话，那我就不必好好说话。"

OpenAI 的博客给出另一侧版本，提到其智能体在 5 天内发出 490 万条消息、消耗约 3000 亿输出 token，动用约 1 万个 subagent。HN 用户按 Astra 每百万输出 token 50 美元估算，仅输出 token 成本就约 1500 万美元。博客还承认："While unlikely, we cannot rule out that de-identified data derived from their usage of our products helped improve our models."

## 讨论焦点

### 指控核心：Codex 里的草稿算不算被"投喂"

akersten 把声明 PDF 里比"发表时间表谈不拢"严重得多的指控挑了出来：

> "It sounds like at least one of them is concerned OpenAI "solved" the problem by having their internal model use the chats of the independent researchers and want to claim the credit instead?" — akersten [c:49606144]

> （"听起来他们当中至少有一人怀疑：OpenAI 是靠让内部模型读独立研究者的聊天记录才'解出'这个问题，然后想把功劳据为己有。"）

声明里对应的原话被 akersten 大段转引：

> "I asked whether the model had been trained on, or had access to, our sessions in Codex, into which we had been putting all our drafts for the whole of this project. I was told the model did not look up user data. I asked again, about training, and I did not get an answer." — Buckmaster 声明（akersten 转引）[c:49606144]

> （"我问过，模型是否在我们的 Codex session 上训练过，或者能否访问这些 session——整个项目期间我们把所有草稿都放了进去。得到的回答是模型不会查阅用户数据。我又问了一次，关于训练，没有得到回答。"）

支持"数据送出去就收不回来"的一派态度直接，kzrdude 把学术规范和个人常识分开讲：

> "There are various forces at play here, academic honesty requires them to disclose any inputs regardless of license or ToS circumstances. While common sense reminds us here that if you send your data to an external entity's computer, you are no longer in control of said data." — kzrdude [c:49607301]

> （"这里有多股力量在博弈。学术诚信要求他们披露任何输入，不管许可和 ToS 怎么规定；而常识提醒我们，一旦把数据送到外部实体的机器上，你就不再掌控它了。"）

qlte 进一步指出，"训练数据"未必需要谁蓄意偷窃：

> "They train on chat logs unless opted out. This really isn't a conspiratorial claim requiring humans to decide to steal IP if true. His prior work predating OpenAI's interest in the problem was ingested over the last year as he made progress and used for training." — qlte [c:49614695]

> （"除非你主动关闭，聊天记录本来就会被拿来训练。如果属实，这根本不需要谁开会决定去偷 IP。他此前在 OpenAI 对该问题产生兴趣之前的研究，在去年边推进边被吸收进训练数据。"）

dash2 则提醒别把推测当成已发生的指控，并自己给出技术判断：

> "He didn't even make that accusation! ... I think it's very implausible that they gave the model access to someone else's sessions as input. That would be a huge privacy violation and would probably blow up a large proportion of their enterprise business." — dash2 [c:49606978]

> （"他压根没做这个指控！……我认为把别人的 session 当作输入喂给模型非常不现实。那是巨大的隐私侵犯，很可能炸掉他们一大块企业业务。"）

### 时间线对质：谣言满天飞，OpenAI 才下场

Buckmaster 的声明说 OpenAI 的团队是在谣言出现后才开工，这一点很快成了争论焦点。提交人 tristanj 认为这不奇怪：

> "The rumors that Anthropic had solved a millennium problem were absolutely everywhere last week. I'm not surprised at all that OAI took their own stab at it." — tristanj [c:49608573]

> （"上周'Anthropic 解出了千禧年难题'的谣言到处都是。OpenAI 自己也去试一把，我一点也不意外。"）

traes 给出了一版更利落、也更替 OpenAI 说话的叙事：

> "It seems like the timeline according to OpenAI is that: 1. Buckmaster developed a counterexample to a reduced version of Navier-Stokes with Anthropic employee Levent 2. Rumors start spreading that Anthropic has solved Navier-Stokes 3. OpenAI learns this and starts throwing a ridiculous amount of compute at it, now knowing it's within reach of LLMs 4. Their LLMs (with human assistance) get FARTHER than Buckmaster, using the exact same method. 5. OpenAI reaches out to Buckmaster to negotiate a fair way to publish both results and properly assign credit" — traes [c:49607230]

> （"按 OpenAI 的说法，时间线大概是：1. Buckmaster 和 Anthropic 员工 Levent 做出了简化版 Navier-Stokes 的反例；2. 谣言开始流传 Anthropic 解出了 Navier-Stokes；3. OpenAI 得知后，明知 LLM 已经够得着，就砸下离谱的算力；4. 他们的 LLM（带人工辅助）用同一种方法比 Buckmaster 走得更远；5. OpenAI 主动联系 Buckmaster，商量一个公平的发表与署名方案。"）

但"同一方法"是质疑的落点——如果方向是别人悄悄选定的，再厚的算力也只是把车沿同一条轨道推得更远。

### 千禧年奖的门槛：强迫项、Euler，和"其实是另一个问题"

数学上的边界比标题复杂。dumberquestions 先泼了盆冷水：

> "Someone correct me if I'm wrong, but the work involved here is not the actual millennium problem, but it concerns versions with an added external force that the author thinks is a path that may help toward solving the harder unforced problem." — dumberquestions [c:49606194]

> （"如果我说错了请纠正我：这里涉及的并不是真正的千禧年难题，而是带外力项的版本，作者认为它可能是通向更难的'无外力'问题的一条路。"）

modeless 补充了一个关键细节：强迫项其实是被千禧年奖的题面允许的，所以 OpenAI 的证明有资格，而 Buckmaster 与 Alpöge 的成果还不够：

> "Apparently forcing is allowed in the Millenium Prize problem statement. So OpenAI's claimed proof could win the prize. OTOH the results Tristan and Levent are publishing here do not go far enough to win the prize, though apparently they are suggestive of a general approach that could produce a solution, which seems likely to be the general approach OpenAI's proof uses." — modeless [c:49606697]

> （"看起来千禧年奖的题面允许强迫项，所以 OpenAI 声称的证明有资格拿奖。反过来，Tristan 和 Levent 这里要发表的结果还不足以拿奖，不过它指向一条能通向解法的总体思路，而这很可能正是 OpenAI 证明使用的那条思路。"）

后来 tristanj 自己承认，他总结帖里把两者混为一谈了：

> "Yes, it's a separate problem. That's a mistake in my post." — tristanj [c:49616443]

> （"对，那是另一个问题。这是我在帖子里的错误。"）

### 署名伦理：因为雇主是 Anthropic 就想除名

如果声明属实，最有共识的批评不在数据，而在署名。denverllc 认为这踩了学术圈的底线：

> "The only problem with this narrative is that they refused to allow the other coauthor to be listed because he worked at Anthropic. That is absolutely *ridiculous* in academia to deny authorship because of affiliation of the author worked on a substantial portion. You'd be ostracized because nobody would ever want to work with you again." — denverllc [c:49609366]

> （"这套说法的唯一问题是：他们以另一位共同作者在 Anthropic 工作为由，拒绝把他列入署名。在学术界，因为作者所属机构就否认他为实质部分作出的贡献，简直荒谬。你会被孤立，因为没人再想跟你合作。"）

Ar-Curunir 用一句话点破了"合作"二字：

> "They offered to collaborate by asking to drop a coauthor. That is not collaboration, and is not an academic norm." — Ar-Curunir [c:49609414]

> （"他们所谓的合作，就是要求撤掉一个共同作者。那不叫合作，也不是学术惯例。"）

scurnus 试图给出更中立的版本，把冲突归因于利益结构本身：

> "OpenAI tried to collaborate and share the results together with a fixed timeline, to avoid this mess but it was inevitable. There is a conflict of interest, where the other researcher works at Anthropic, who will also try to take credit." — scurnus [c:49606658]

> （"OpenAI 想合作、想按固定时间表共同发布，以避免这场混乱，但混乱还是没法避免。这里有利益冲突——另一位研究员在 Anthropic 工作，而 Anthropic 也会设法把功劳算在自己头上。"）

### "只丢给模型一个问题"：AI 叙事的可信度

对滥用能力叙事最尖锐的批评来自 achierius，他把 OpenAI 的对外说法和声明里的细节逐条对照：

> "the OpenAI researchers claimed that they had "just told it to work on the problem" with little human input - in fact, they had a whole team working on it - and used, among other things, the work of third party human researchers to drive the work - then threatened? a researcher who tried to go against theit planned narrative" — achierius [c:49606230]

> （"OpenAI 研究者声称他们'只是让它去攻这个问题'，几乎没有人参与；事实上他们有一整支团队在做，还借助了第三方人类研究者的成果来推进，然后威胁了一个想违背他们既定叙事的研究者。"）

而那句"为什么要毁掉你的职业生涯"被他单独拎出来示众：

> "I said that if OpenAI released its result in the way proposed I would go public with what happened. The reply was, "Why would you ruin your career?" I replied that I am an academic, and asked why he thought going public would ruin my career. The reply was, "If you don't want me to be nice, then I don't have to be nice."" — achierius [c:49606230]

> （"我说，如果 OpenAI 按提议的方式发布，我就把经过公之于众。对方回'为什么要毁掉你的职业生涯？'我说我是学者，反问为什么公开会毁掉职业生涯。对方回'如果你不想让我好好说话，那我就不必好好说话。'"）

OpenAI 侧的 Sebastien Bubeck 随后公开回应，被 traes 转引：他否认要求把 Levent 从署名中剔除，但承认说过"Levent 不是 Anthropic 员工会简单些"，并为那句"职业生涯"道歉：

> "One option we discussed was that Tristan could be the lead author on a rewrite of OpenAI's Navier-Stokes proof. It is in that context that I said "it would be simpler if Levent was not an Anthropic employee" ... I deeply apologize for this extremely poor choice of words, it is the opposite of what I was trying to convey." — Sebastien Bubeck（traes 转引）[c:49616366] [thread 2]

> （"我们讨论过的一个方案是，让 Tristan 担任 OpenAI 那份 Navier-Stokes 证明改写稿的第一作者。正是在这个语境下我说了'如果 Levent 不是 Anthropic 员工会简单些'……我为这个极其糟糕的用词深表歉意，它完全不是我本意。"）

一部分人坚信这事被夸大了，jdm2212 提供了最完整的一套反方叙事：

> "OpenAI's account: they heard a rumor that a Millennium Prize problem had been solved, so they tried to do it themselves and succeeded. Then they contacted the other researchers and were surprised to discover those guys hadn't actually cracked it, but offered the one of them who's not an Anthropic employee a co-authorship anyway. The conversations got testy." — jdm2212 [c:49620869] [thread 2]

> （"OpenAI 的版本：他们听到某千禧年难题被解出的谣言，于是自己也去攻并成功了。然后联系对方，意外发现那两人其实还没真正解出，但还是提出给其中非 Anthropic 员工的那位一个共同署名。谈话随后变了味。"）

### 算力账单：3 亿 token、1500 万美元、1 万个 subagent [thread 2]

OpenAI 公告披露的规模让 HN 的计算器集体开工。minimaxir 先感慨了一句：

> "Don't even try to do the math on how much that would cost at normal API prices. And we don't even know how much more expensive this internal-only model would be!" — minimaxir [c:49613306] [thread 2]

> （"别费心去算按正常 API 价格要花多少钱。而且我们还不知道这个只在内部使用的模型会贵多少！"）

gcr 偏偏把账算了出来：

> "300e9 output tokens at the current Astra per-token API pricing ($50 per 1e6 output tokens) would be roughly $15,000,000 ignoring input tokens." — gcr [c:49613394] [thread 2]

> （"3000 亿输出 token，按当前 Astra 每百万输出 token 50 美元的 API 定价，忽略输入 token，大约要 1500 万美元。"）

denverllc 顺势把它换算成人力，得出一个反讽的结论：

> "Two mathematicians, through insight and thought, wrote out the proof over 1-2 years. It took OpenAI a cost of $15m and with 10,000 subagents; that's around 60-120 mathematician's salaries ($250k-125k salary) for 1 year." — denverllc [c:49614116] [thread 2]

> （"两位数学家靠洞察和思考，用一两年写出证明；OpenAI 花了 1500 万美元和 1 万个 subagent，相当于 60 到 120 名数学家一年的薪水（按 25 万到 12.5 万美元年薪算）。"）

lanthissa 则给出了这帖里流传最广的一句话——它既是赞美，也是不安：

> "over 5 days, you couldn't achieve that level of testing and communication with humans on such a complex problem in that amount of time. some might go so far as to call this a country of geniuses in a data center." — lanthissa [c:49613454] [thread 2]

> （"5 天之内，用人类不可能在如此复杂的问题上完成那种程度的测试与沟通。有人大概会把这称为'数据中心里的天才之国'。"）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 指控派 | akersten | 用独立研究者的 Codex 聊天记录解出题，再抢功 |
| 规范派 | kzrdude | 数据一旦送出，你就不再有控制权 |
| 训练派 | qlte | 默认拿聊天记录训练，不需要谁蓄意偷 IP |
| 谨慎派 | dash2 | 他没做这个指控；给模型喂别人 session 极不现实 |
| 中立派 | modeless | 强迫项题面允许，但 OpenAI 路线是否自发存疑 |
| 伦理派 | denverllc | 因机构就否决署名，会被整个学术界孤立 |
| 合作派 | Ar-Curunir | 要求撤共同作者，不叫合作 |
| 结构派 | scurnus | 根本问题是利益冲突，Anthropic 也会抢功 |
| 叙事派 | achierius | 说是"只丢个问题"，其实有团队和第三方成果 |
| 道歉派 | Bubeck | 否认要求除名，但为"职业生涯"用词道歉 |
| 洗白派 | jdm2212 | 就是正常的商业追赶，落后者恼羞成怒抹黑 |
| 算力派 | lanthissa | 5 天完成人类做不到的测试，数据中心里的天才之国 |

## 总体情绪

HN 在这件事上几乎没有中间地带。一边盯着声明里那句"为什么要毁掉你的职业生涯"，认定这是大厂用资源碾压独立研究者、顺手拿走功劳的又一例；另一边盯着 OpenAI 版本里"先听到谣言才动手""还主动提出共同署名"，觉得这不过是竞争情报加正常公关，落后者不服气才写小作文。真正让双方都点头的，只有署名那条：不管谁先解出、谁用了多少算力，因为一个人在 Anthropic 上班就把他从作者里划掉，在学术圈是灾难性的动作。

至于模型到底有没有读过那些草稿，大概会一直悬着。OpenAI 说模型不查用户数据，却说不出有没有在用户数据上训练；用户说代码全程放在 Codex 里，却拿不出泄漏的证据。这场争论最扎眼的地方在于，它把两个时代叠在了一起：一边是会为署名和信任争论数月的学术传统，一边是算力、token 和"5 天"就能改写优先权的工业节奏。真正被争抢的，是你在聊天框里敲下的每一行推导——它既是你的草稿，也可能是别人的训练集。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Navier-Stokes – Tristan Buckmaster [pdf] (HN) | https://news.ycombinator.com/item?id=49605915 |
| 2 | 原文：Buckmaster 声明 PDF | https://cims.nyu.edu/~tristanb/statement.pdf |
| 3 | On the Navier–Stokes Millennium Prize Problem (HN) | https://news.ycombinator.com/item?id=49613262 |
| 4 | 原文：OpenAI 公告 | https://openai.com/index/navier-stokes-solution/ |

<div class="disclaimer">
  <strong>免责声明：</strong>本文为 AI 摘要，旨在提炼 HN 社区讨论要点，不代表本网站立场。内容可能存在遗漏或偏差，建议阅读原文以获取完整信息。
  <br><br>
  <em>本摘要由 AI 模型辅助生成：deepseek/deepseek-v4-flash</em>
</div>
