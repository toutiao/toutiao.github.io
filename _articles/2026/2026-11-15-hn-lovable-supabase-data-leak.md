---
layout: post
title: >-
  Lovable 应用把护照号和 20 万条私信摆在明面上 — HN 讨论摘要
date: 2026-11-15
hn_id: 50499017
categories: [articles]
excerpt: >-
  Crissy Field 检查了 159,041 个 Lovable 项目：24,664 个站点不登录就吐数据库记录，
  7,403 个（30%）的表里能读到邮箱；某服务商的 1,000 多条记录写着护照号与国籍，
  德国生活方式论坛的 8 万份档案和 20 万条聊天消息直接可读。评论区吵得最凶的不是漏洞本身，
  是研究者的取证边界。
tagline: >-
  报告说 30% 的站点能读到邮箱，作者说 30% 不是泄漏率。
---

> 来源：HN 讨论主帖 [Lovable apps expose passport details and more than 200K private messages](https://news.ycombinator.com/item?id=50499017)（250 分，抓取时点 72 条评论），指向 Crissy Field GmbH 的研究报告 [Lovable: Many Apps Expose Sensitive Data](https://www.crissyfield.de/research/lovable-en/)。本篇为 single post 模式。主帖抓取于 2026-11-14 19:46 UTC，入库 72 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。归档文章正文为博客前 8000 字符，本次已补抓全文（7,264 字符）核对。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

Crissy Field GmbH 是一家德国的网络安全研究公司，这次的报告与《Handelsblatt》合作完成——2026 年 11 月 2 日，记者 Lina Knees 先发过德语版，这次是更新数字的英文完整版。样本来自 Common Crawl 公开数据集：研究者圈出 159,041 个 Lovable 项目（时间跨度 2025 年 12 月到 2026 年 9 月），其中 34,545 个用了 Supabase 数据库。测试方法分两步——先看网站首屏加载时返回了什么，再用同一把匿名 key 发额外的只读请求。结果是，24,664 个网站在页面加载时就把 Supabase 的数据库记录发了出去，不需要登录，也不需要任何交互。

含邮箱的记录出现在 10,560 张表里，分布在被细查的 24,664 个站点中的 7,403 个，占 30%。报告自己踩了三脚刹车：邮箱可能本来就是公开联系邮箱或测试数据；反过来，不含邮箱的敏感记录这套方法又抓不到，两边互相抵消但幅度无法确定，所以 30% 不等于确认泄漏率；Common Crawl 的样本也不代表全部 Lovable 应用。另外，Lovable 自家 2025 年底才推出的数据库功能没被检查，只查了 Supabase 这条集成路径。

案例本身足够具体。一个德国生活方式论坛暴露了 8 万多份档案，含全名、邮箱、生日、性别，还有 20 多万条聊天消息同样可读。若干活动主办方和餐厅暴露了数万个票务与餐饮记录，含邮箱、电话、邮政地址、支付信息和票码。一家物业管理公司暴露了内部邮件的 AI 摘要，牵涉租户、业主和商业伙伴。最严重的一例来自某服务商：1,000 多条记录写着护照号、有效期和国籍，足以用于身份盗用。此外还有数万个合同、发票、私人相册、内部 WhatsApp 通讯；某供应商发给客户的 28 万封邮件也可被读取。报告称这类数据可用于钓鱼、票务欺诈和身份盗用，但无法确认是否已被滥用；调查结果已告知 Lovable。

HN 上这条帖子拿了 250 分。评论区里第一个冒出来自白的是报告作者 neathack：他说自己两周前也发过一次，只是没什么水花，这次重发才炸开。他在评论区补了几件报告正文没写的事：他们另外用 System 1 决策模型、85% 置信阈值筛过一遍，判定将近 4,000 个网站确实泄露了隐私敏感信息（他补充说约相当于使用 Supabase 的 Lovable 网站的 15.9%）；合作记者不会在命令行里敲 curl，请 AI 代劳，AI 以网络滥用风险为由拒绝了；整个研究有数据保护与道德黑客方向的律师参与。还有个顺手发现的细节：Supabase 会在错误消息的 `hint` 字段里泄露表结构，你访问一张叫 "secret" 的表，它可能回你 "Perhaps you meant the table 'public.super_secret'."。评论区最激烈的部分不是技术，是研究者的取证边界。

## 讨论焦点

### 一、取证边界：这场审判席摆得比想象中靠前

质疑来得又快又直接，而且首先指向的不是 Lovable，是研究者本人。

> "Don&#x27;t you think you should have reported this after you established the principle rather than to download more than you needed to do so? Because it looks to me as though you went from &#x27;white hat hacker&#x27; to &#x27;quite probably criminal&#x27; without a really good reason." — jacquesm [c:50499913]
> （译文：你不该在确认漏洞成立之后就去上报吗，而不是多下载超出必要范围的数据？在我看来，你是在没有任何正当理由的情况下，从"白帽黑客"变成了"很可能是罪犯"。）

作者的回答很简短：数据已经全给了厂商。

> "What do you mean? This has been disclosed to, and the full dataset has been shared with, Lovable." — neathack [c:50499946]
> （译文：你这话什么意思？这件事已经向 Lovable 披露了，完整的数据集也已经交给他们了。）

jacquesm 不接受这个回应，追问的正是研究者方法论上的关键一步。

> "You probably should not have done that. It&#x27;s one thing to determine that a hole exists, an entirely different one to exploit it to the point that you can do damage assessment on the target." — jacquesm [c:50500067]
> （译文：你不该这么做。确定某个洞存在是一回事，把它利用到能给目标做损失评估的程度，是另一回事。）

作者随即给出方法上的辩护：只取到能判断是否敏感为止，而判断敏感与否看两条记录不够。

> "We retrieved only enough data to determine whether it was privacy-sensitive, which could not be reliably assessed from just two records. We did not download any more than that.<p>Supabase tables also use pagination, and we never downloaded more than the first page." — neathack [c:50500045]
> （译文：我们只取了足以判断是否属于隐私敏感数据的数据量，这个判断光看两条记录没法可靠地做。我们没有下载比这更多的内容。<p>Supabase 的表格还带分页，我们从来没有下载超过第一页。）

他随后补上一条本该写在报告里的信息——研究有专业律师参与。

> "I should also mention that the analysis was conducted in collaboration with a lawyer specializing in data protection and ethical hacking." — neathack [c:50500074]
> （译文：我还应该说明一点，这次分析是与一位专攻数据保护与道德黑客的律师合作完成的。）

这句补充引来的回应，语气比之前的质问更冷。

> "That&#x27;s an important bit of information that probably should make it into the blog, and I hope you guys made the right call, but I think that that is probably not the case. Best of luck." — jacquesm [c:50500110]
> （译文：这是条挺重要的信息，本来应该写进博客里；我希望你们做对了，但我认为多半没有。祝你们好运。）

至于那些真正该被讨论的受害站点，讨论里几乎没人接。

> "Need to know the full blast radius and severity..." — logotype [c:50500025]
> （译文：得知道完整的爆炸半径和严重程度……）

### 二、责任在 Lovable、Supabase，还是用户自己

作者对责任的落点非常明确：不在用户，在 Lovable 的营销话术。

> "To me, the issue is Lovable’s borderline reckless marketing: repeatedly claiming that “everyone” can build a website “without any technical knowledge” (verbatim from their website), while disclaiming all liability for bugs in their terms and placing responsibility for security on their customers." — neathack [c:50499856]
> （译文：在我看来，问题出在 Lovable 近乎不负责任的营销：反复宣称"每个人"都能"无需任何技术知识"地做出网站（这是他们官网的原文），同时在条款里撇清所有 bug 责任，把安全责任全推给客户。）

社区里也有人把锅分给 Supabase——他们指出自己的默认策略是十年前为降低上手成本做的取舍。

> "This was supposedly fixed on October 30, but there are reports floating around that for existing projects, the defaults still apply.<p>Lovable deserves some heat for using this, but this was a choice that was made by Supabase many years ago to support making it easier to onboard potential customers, a deliberate tradeoff of less onboarding pain for less security." — SOLAR_FIELDS [c:50499905]
> （译文：这据说在 10 月 30 日已经修了，但有说法称对既有项目来说默认值依然生效。<p>Lovable 因为用了它而挨骂是合理的，但这是 Supabase 多年前为了更容易把潜在客户拉进来而做出的选择，是一个刻意做的取舍：更少的上手痛苦，换更少的安全。）

作者顺带补刀 Supabase 本身。

> "For example, if you try to access a table named &quot;secret&quot; that doesn’t exist, Supabase might return a hint saying, &quot;Perhaps you meant the table &#x27;public.super_secret&#x27;.&quot;<p>Thanks for volunteering that information, I guess." — neathack [c:50500006]
> （译文：比如，你试着访问一张不存在的名为 "secret" 的表，Supabase 可能会返回一条提示，说"你是不是想找 public.super_secret 这张表？"<p>谢谢你主动送上门来的这条信息。）

而最常见的一条辩护思路，是把问题推回到"你自己写的规则不对"。

> "One of the golden rule of webdev is &quot;never build your own auth&quot; for a reason.<p>To me, it feels like Lovable is an irresponsible product selling the idea that web development is trivial now with LLMs, where the reality is that although it&#x27;s true that agentic coding means while anybody can spin up a website in like 10 minutes, a professional software engineer who knows what they are doing can still utilize LLMs much more effectively than an amateur ever could." — YuechenLi [c:50500004]
> （译文：Web 开发有句金律——"永远不要自己写认证"，是有原因的。<p>在我看来，Lovable 是个不负责任的产品：它兜售"有了 LLM，Web 开发已经变简单了"这种想法；而现实是，虽然 agent 式编程确实让任何人十分钟就能搭个网站出来，但一个真正懂行的软件工程师用 LLM 的效率，依然远高于业余者。）

fabian2k 指出这里的技术细节被普遍搞错了。

> "I don&#x27;t see any indication in the post that these cases involved someone writing their own authentication code. This is about authorization mistakes, or the lack of any authorization. And that part you have to write yourself in some way (even if you use libraries), someone has to define the rules about which data is accessible under which rules. Using a pre-made library won&#x27;t save you from defining those rules wrong.<p>To me only hard rule like this is to never implement your own cryptographic code. A decent developer can easily implement simple session-based authentication safely, or at least I&#x27;d suspect the chance of mistakes is no higher than this developer misconfiguring a much more complex library for authentication." — fabian2k [c:50500031]
> （译文：我没在帖子里看到任何迹象表明这些案例涉及有人自己写认证代码。这是授权失误，或者说完全没有授权。而这部分你总得自己写点什么（就算你用库），总得有人定义清楚哪些数据在什么规则下可以被访问。用现成的库救不了你把规则定义错。<p>在我看来像这样的硬规则只有一条：永远不要自己实现密码学代码。<p>一个像样的开发者完全能安全地实现简单的基于会话的认证；或者至少我认为，出错的概率不会比这个人把一个复杂得多的认证库配错更高。）

被追问"规则写在哪"的人，则把门槛抬高到另一个量级。

> "Where is that rule written? You can build a really solid auth system, if you follow the rules. Also, what kind of auth method are you mentioning?" — meerita [c:50500072]
> （译文：这条规则写在哪里？如果你照着规则来，完全可以搭出很扎实的认证系统。另外，你说的是哪一种认证方式？）

> "The thing is that in auth (like in cryptography) the rulebook is 2000 pages and there is an annotation book of another 2000." — raizer88 [c:50500097]
> （译文：认证这件事（就像密码学一样），规则手册有两千页，还有一本两千页的注释手册。）

> "If you miss one page, the llm doesn&#x27;t and will open you like a tuna can." — raizer88 [c:50500097]
> （译文：你漏掉其中一页，LLM 不会替你补，它只会像开罐头一样把你打开。）

### 三、追责：只有硬邦邦的责任能治这个病

认为这是 AI 造成的讨论很多，但一位用户把话说明白了：不是 AI，是没人需要付出代价。

> "Folks are blaming AI, and that&#x27;s certainly part of it (folks without knowledge and experience can now build polished apps, though there were still plenty of &quot;WTF&quot; security breaches before AI), but I feel like the only thing that can fix this are real, stiff liability consequences." — hn_throwaway_99 [c:50499757]
> （译文：大家都在怪 AI，这肯定有一部分原因（没有知识经验的人现在也能做出像样的应用，尽管 AI 之前就有不少"WTF"级安全漏洞），但我觉得唯一能解决这件事的，是真实而严厉的责任后果。）

> "The defects listed in this report didn&#x27;t require some complicated 0-day exploit chain - they were just sensitive data stored without any authentication at all, in a database that anyone with Internet access can view. In other words, it would be the  equivalent of a company like Public Storage leaving all of its storage units with no locks on them at all." — hn_throwaway_99 [c:50499757]
> （译文：报告里列出的这些缺陷，并不需要什么复杂的 0-day 漏洞链——只是敏感数据被存进一个任何能上互联网的人都能查看的数据库里，完全没有任何认证。换句话说，这相当于 Public Storage 这样的公司把仓库储物柜全都不上锁就对外租。）

> "Affected users should be able to sue for a lot in these basic security failures. And obviously for many of these small websites, the potential damages would quickly bankrupt the site owners, but that&#x27;s the point. People would think a lot more carefully about how they protect sensitive data if there were real negative consequences for their failures." — hn_throwaway_99 [c:50499757]
> （译文：受害用户在这些最基本的安全失误上完全可以索赔。而且对许多这样的小网站来说，潜在赔偿很快就能让网站主破产，但这正是重点：一旦失败真有负面后果，人们在保护敏感数据这件事上就会想得仔细得多。）

具体到能落地的路径，有人指向 GDPR。

> "EU citizens can sue. It&#x27;s not easy in every EU country, and ot differs whether you will be compensated.<p>But in all cases, under GDPR, the one having the data breach is required to act. If they fail, there&#x27;s steep fines, often proportional to your revenue. It will hurt the business." — berkes [c:50499932]
> （译文：欧盟公民可以起诉。在每个欧盟国家都不容易，而且能否拿到补偿也因国而异。<p>但在所有情况下，GDPR 都要求发生数据泄露的一方采取行动。如果他们不作为，会面临巨额罚款，通常与营收挂钩。那会伤到企业。）

也有人在评论区追问一个更实际的问题：这份报告本身报没报给监管。

> "Seeing as this is reported by a German organisation about a Swedish company: has this been filed with the authorities under the GDPR? " — berkes [c:50499964]
> （译文：既然这是一个德国机构在报道一家瑞典公司：那这份报告是否已按 GDPR 提交给监管机构？）

> "Any details on whether (national) data protection authorities have picked it up and warned the companies and people in violation?" — berkes [c:50499964]
> （译文：有没有细节说明（各国）数据保护机构是否已经接手，并且对违规的公司和个人发出了警告？）

### 四、能做什么：在网关层把洞堵住

讨论里给出的最实用的一条建议来自一位已经在动手的人：别指望应用自己守规矩，在网关层加一层认证。

> "I&#x27;ve started putting OIDC auth in front of my app (at the gateway level) so that no matter how badly my LLM botches the app, requests can&#x27;t get through.<p>This only really works with 1-person apps though. If you need multiple users then you have to match the login with specific database records to make sure you&#x27;re only exposing the right stuff." — hdjrudni [c:50500122]
> （译文：我开始在自己的应用前面（网关层）放 OIDC 认证，这样不管我的 LLM 把应用搞得多烂，请求都过不去。<p>不过这招基本只对单人应用有效。如果你要多用户，还得把登录和具体的数据库记录对上，确保只暴露该暴露的东西。）

被描述成"vibe coding 到医院"的人，喊出了这个问题更本质的一面。

> "You’re right, only if the person building the application is using sound judgement, which goes against the premise.<p>You and I wouldn’t build applications naively that could lead to people dying. People who don’t understand what they’re building might.<p>People are vibe coding at your hospital. They’re vibe coding at your utility company. They’re vibe coding at your pharma lab. I’ve met these people. They’re smart. They have phds. I tell them about SSL." — heartbreak [c:50500041]
> （译文：你说得对，前提是构建应用的人有健全的判断力，而这恰恰与前提相悖。你我不会天真地搭出可能导致人死亡的应用程序；那些不明白自己在造什么的人会。<p>人们正在你的医院里 vibe coding，在你的公用事业公司里 vibe coding，在你的药厂实验室里 vibe coding。我见过这些人。他们很聪明。他们有博士学位。我会跟他们讲 SSL。）

也有人提醒：这类应用之所以好打，正是因为门槛低到不需要任何专业技能。

> "- They are an easy target, they don’t need any sophisticated hacking knowledge (article mentions inspecting network calls in browsers).<p>- There tons of those, and more created everyday. For the average user, they don’t know what they are using, or how risky it can be." — Oras [c:50499542]
> （译文：- 他们是容易得多的目标，不需要任何高深的黑客技术（文章里提到只要在浏览器里看网络请求就行）。<p>- 这种应用数量巨大，而且每天都在新增。对普通用户来说，他们不知道自己在用什么，也不知道它有多危险。）

然后是全场最干脆的一句反对意见。

> "Nobody is dying from this leak." — JumpCrisscross [c:50500069]
> （译文：这次泄露没让任何人送命。）

### 五、AI 是不是元凶：情绪跑得比技术远

关于 AI 的争论占了这场比赛最长的篇幅，而且很快从技术滑向情绪。有人从攻防速度的角度给出警告。

> "Imagine frontier abliterated models running at 2,400 TPS finding all these issues rapidly on web apps like this." — rvz [c:50499208]
> （译文：设想一下前沿的去对齐（abliterated）模型以 2,400 TPS 的速度在这些 Web 应用上飞快地找出所有这类问题。）

也有人说，这跟 AI 其实关系不大，该来的总会来。

> "Or just the natural consequence of adopting &quot;move fast and break things&quot; from top to bottom for 20 years, a house-of-cards methodology that was destined to fall in on itself whether or not such models ever arrived." — swatcoder [c:50499287]
> （译文：或者，这只是"快速上线、边做边坏"这套方法论从上到下贯彻了 20 年的必然结果——一套注定要塌回自己身上的纸牌屋，不管这些模型会不会出现。）

最被讨论的一条评论，来自一个愤怒值拉满的老手。

> "I can&#x27;t state my disdain enough for the rabid, careless advancement of AI, and all the bros that keep telling me to catch up or fall behind, while they are actively causing harm to the hundreds of thousands, or millions of users they have, without care or consideration.<p>Nearly two decades of experience learning how to build safe, performant software, to be replaced by this shit.<p>We don&#x27;t care about people, our customers anymore. We actively harm them for profit. This is such a garbage industry now." — birdsongs [c:50499296]
> （译文：我对 AI 这种鲁莽而草率的推进怎么表达蔑视都不够，还有那些一直叫我要跟上、否则就落伍的兄弟，而他们正在毫无顾忌地伤害他们那几十万、上百万的用户。<p>我近二十年学到的、如何构建安全且高性能的软件的经验，就这么被这坨东西替代了。<p>我们不再在乎人，在乎客户了。我们为了利润主动伤害他们。这是个垃圾行业。）

被追问"以前的公司在乎吗"，他给出了那个年代的具体记忆。

> "Exactly. I cared, and the amazing engineers that taught me cared. We didn&#x27;t have KPIs in 2008, we had code reviews and mean senior engineers (that were secretly kind) that would tear your code apart and send you back until you got it right.<p>And we were allowed to? I raised so many tickets over time that had no real business impact beyond &quot;this is a security risk&quot; and nearly all of them I was allowed to adress.<p>Maybe that makes me some kind of tech-boomer, like people responding to me are implying, but I don&#x27;t really give a shit." — birdsongs [c:50499612]
> （译文：没错，我在乎，教我的那些优秀工程师也在乎。2008 年我们没有 KPI，有的是代码评审和严厉的老工程师（其实是心善的），他们会把你的代码拆了让你改到对为止。<p>而且我们是被允许这样做的？那几年我提过很多没有实际业务影响、只是"这是安全风险"的工单，几乎都得到了处理。）

另一条线则指出代价结构变了：在乎的门槛从"慢一点"变成了"丢工作"。

> "In the past the price of caring was that you were slightly slower, but it would be obvious that the delivered quality was better.<p>Now you&#x27;ll be at least 50% slower and likely fired if you care, because caring means understanding the code." — jeppester [c:50499989]
> （译文：过去，在乎的代价是你会稍微慢一点，但交付的质量明显更好。<p>现在你至少要慢 50%，还可能因为在乎而被开除——因为在乎意味着你得理解这些代码。）

而回应"公司以前也不在乎"的人，给出的判断更冷。

> "The idea that companies invested in &quot;safe, performant software&quot; before AI is laughable. Tech companies have never cared about the customers beyond their effect on KPIs." — tortasaur [c:50499423]
> （译文：说公司在 AI 之前投资于"安全、高性能的软件"，这个说法本身就很好笑。）

招聘市场上的一件事被当成这条线的注脚。

> "They actually said we&#x27;re looking for someone who&#x27;s a big AI booster. Bullet dodged." — andrew_lettuce [c:50499352]
> （译文：他们其实说的是"我们在找一个 AI 铁杆支持者"。逃过一劫。）

也有人试图把"用 AI 的人"和"AI 本身"分开。

> "Have you ever considered that the people who are pro-AI are not a monolith, and that it can be simultaneously true that you should absolutely be learning how to effectively and safely use LLMs in engineering workflows, while it is also true that there are people who are using them very unsafely?<p>Beig opposed to learning how to use AI correctly because some people use it recklessly is like being opposed to learning AWS in 2015 because some people left sensitive data in open S3 buckets." — anonym29 [c:50499469]
> （译文：有没有想过，AI 拥护者并不是一个铁板一块？既可以完全成立——你绝对应该学会在工程流程中有效且安全地使用 LLM，同时也可以成立——确实有人在非常不安全地使用它们？<p>因为有人 reckless 地用工具，就反对学习如何正确地使用 AI，这就像因为有人把敏感数据留在公开的 S3 桶里，就反对学习 AWS（2015 年）。<p>不要把工具的疏忽性滥用，和工具本身的价值主张混为一谈。）

被这么一驳，原作者回头澄清了自己的立场。

> "Re-read my post before quoting it and getting defensive. I&#x27;m not anti-AI, I use Claude daily, partly because that&#x27;s all the industry is now, partly because it can be an amazing tool.<p>I&#x27;m furious about slop-shovelling profit-driven development that actively causes harm to people. And the lack of care for, or outright disdain of customers, specifically fuelled by a misuse of AI, and the people telling me to get used to this, the people telling me to stop reading my own PRs, the people telling me this is just how it is now. When we all know that doesn&#x27;t have to be true." — birdsongs [c:50499564]
> （译文：引用我之前的话之前先重读一遍，别急着防御。我不是反 AI，我每天都用 Claude，一半是因为整个行业现在就是这样，另一半是因为它确实可以是个了不起的工具。<p>我愤怒的是那种为了利润而粗制滥造的开发，它正在主动伤害人；以及对客户毫无关心、甚至公然蔑视客户的态度，尤其是被 AI 的滥用所助长的；还有那些叫人认命、叫人别再读自己的 PR、叫人"现在就是这样"的人。而我们都知道这本来不必如此。）

最后，有人试图把这场战争拉回中间地带。

> "As with all new things that have extreme views on either side (AI is complete shit versus AI is the second coming of Christ in this case), there&#x27;s generally a middle ground in between that we can collectively correct toward." — sky2224 [c:50499883]
> （译文：就像所有有两极观点的新事物一样（在这件事上，一边是"AI 完全是坨屎"，另一边是"AI 是基督再临"），中间总是有一块可以共同收敛的地方。）

而作者本人还带来一个关于 AI 的意外插曲。

> "As a side note to the &quot;nerfing&quot;, I worked with a journalist on the analysis, and she wasn’t comfortable running `curl` on the command line. So she asked the AI to do it -- but it refused, citing concerns about cyber abuse.<p>On the one hand, that’s kind of encouraging. On the other, it feels like the unskippable “don’t copy this movie” warning on a legally purchased DVD -- the one that gets removed from pirated versions.<p>It seems to punish the wrong people." — neathack [c:50499802]
> （译文：顺便说一句关于"阉割"的事：我和一位记者一起做了这份分析，她不太愿意在命令行里跑 `curl`。于是她让 AI 去做——AI 拒绝了，理由是担心被用于网络攻击。<p>一方面，这多少让人欣慰。另一方面，这像正版 DVD 开头那段不可跳过的"请勿翻录"警告——盗版里那段反而被剪掉了。<p>它好像在惩罚错的人。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 取证越界 | jacquesm | 多下载的部分超出必要，白帽变成"很可能是罪犯" |
| 已完整披露给厂商 | neathack | 漏洞已上报，完整数据集也交给了 Lovable |
| 只取判断敏感度所需 | neathack | 表格分页，从不超过第一页 |
| 研究有律师背书 | neathack | 律师专攻数据保护与道德黑客 |
| 定级需要爆炸半径 | logotype | 得知道完整的爆炸半径和严重程度 |
| 责任在 Lovable 的营销 | neathack | 宣传"无需技术知识"，条款却让客户担责 |
| 锅有一半在 Supabase | SOLAR_FIELDS | 默认值是十年前为降低上手成本做的取舍 |
| 别自己写认证 | YuechenLi | 这是 Web 开发的第一条金律 |
| 根因是授权不是加密 | fabian2k | 用库也救不了你把授权规则写错 |
| 规则有两千页 | raizer88 | 漏一页，LLM 就会像开罐头一样把你打开 |
| 只有硬责任能治 | hn_throwaway_99 | 敏感数据裸奔，责任却软塌塌 |
| GDPR 能追责 | berkes | 罚则通常与营收挂钩 |
| 该报监管未报？ | berkes | 德国机构报道瑞典公司，GDPR 流程走了吗 |
| 网关层加 OIDC | hdjrudni | 不管 LLM 把应用搞得多烂，请求都过不去 |
| vibe coding 到医院 | heartbreak | 他们很聪明，有博士学位，但我会讲 SSL |
| 门槛低才好打 | Oras | 看浏览器网络请求就行 |
| 没人送命 | JumpCrisscross | 这次泄露没让任何人送命 |
| AI 只是加速器 | rvz | 2,400 TPS 的模型会更快找到这类问题 |
| 这与 AI 无关 | swatcoder | "边做边坏"贯彻 20 年的必然结果 |
| 在乎的代价变高 | jeppester | 现在在乎就意味着慢 50%，还可能被开除 |
| 公司从来不在乎 | tortasaur | 说公司以前投资安全软件本身就很好笑 |
| 别混淆工具与滥用 | anonym29 | 像因为有人把数据留在 S3 桶就反对学 AWS |
| 我不是反 AI | birdsongs | 我愤怒的是拿利润当杠杆的糊弄式开发 |
| 中间地带存在 | sky2224 | 极端观点之间总有可以共同收敛的地方 |

## 总体情绪

这次讨论的分歧很少落在技术判断上，几乎所有人都同意：数据库里那 7,403 个站点的表，就是几张没上锁的储物柜。分歧在于该由谁挨罚——Lovable 的营销话术、Supabase 十年前的默认设置、还是既不懂技术也不知道自己在干什么的小应用主；以及一个更冷的判断：既然这些应用本来就不懂认证规范，任何"你自己写错了"的说辞都只是把成本转嫁给用户。评论里最有分量的声音因此不是技术建议，而是"只有硬邦邦的责任后果能解决这件事"，以及 GDPR 罚则真的与营收挂钩这一事实。

另一条线则热闹得多：AI 到底是不是元凶。有人认为去对齐模型一旦跑起来就会自动扫出所有这类漏洞，有人认为这不过是二十年来"边做边坏"的必然结果，还有人索性把火气撒在十年做安全软件的老工程师身上。真正有信息量的是那些提到具体处境的发言——招聘方明确要"AI 铁杆支持者"，工程师说能保住饭碗的是"有主见的创造力和常识"（kpil），在乎质量意味着至少慢 50% 还可能丢工作。到最后作者自己跳出来说：被引用的那段话不是反 AI，他每天都在用 Claude，他愤怒的是拿利润当杠杆的糊弄式开发。

而最刺眼的一幕出现在收尾：报告作者说，他合作的记者不会在命令行里敲 `curl`，于是让 AI 代劳，AI 以网络滥用风险拒绝了；可这 7,403 个站点的数据就那么明明白白摆在浏览器的网络面板里，任何人伸手就能拿。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Lovable apps expose passport details and more than 200K private messages（HN 主帖） | <https://news.ycombinator.com/item?id=50499017> |
| 2 | Crissy Field 研究报告：Lovable: Many Apps Expose Sensitive Data | <https://www.crissyfield.de/research/lovable-en/> |
| 3 | Supabase 社区讨论 4547（评论中引用的默认策略问题） | <https://github.com/orgs/supabase/discussions/4547> |
| 4 | PostgREST 错误响应文档（`hint` 字段泄露表结构） | <https://docs.postgrest.org/en/latest/references/errors.html> |
| 5 | 荷兰数据保护局：数据泄露受害者如何索赔 | <https://www.autoriteitpersoonsgegevens.nl/en/themes/security/data-breaches/victim-of-a-data-breach#compensation-for-a-data-breach> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 250 分、72 条评论，抓取快照 2026-11-14 19:46 UTC）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。报告正文数据（159,041 个样本项目、34,545 个使用 Supabase、24,664 个首屏即返回记录、10,560 张表与 7,403 个站点含邮箱记录、8 万份档案与 20 万条聊天消息、1,000 余条含护照号的身份记录、28 万封客户邮件等）取自 Crissy Field 研究报告原文；"近 4,000 个网站""15.9%""记者不会跑 curl"等细节来自报告作者在 HN 评论区的补充说明，未经独立核实。文中引用的 Supabase 默认策略与 PostgREST `hint` 字段两条结论来自评论者陈述，本摘要未做技术验证。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
