---
layout: post
title: >-
  OccupySaaS：被 AI 裁掉的工程师，用 AI 重建被裁掉的 SaaS — HN 讨论摘要
date: 2026-11-22
hn_id: 50331402
categories: [articles]
excerpt: >-
  一个自称「OccupySaaS」的运动在 HN 贴出完整方法论：只读公开文档写成规格书，让 AI agent
  按规格重建 Auth0 与 Salesforce，兼容到能直接跑厂商自家的 SDK。评论区先问的不是技术，
  而是被 AI 优化掉的人用 AI 造替身去对抗 AI，算哪门子反抗。
tagline: >-
  被优化掉的那一百万人，排队给按人头收费的 SaaS 写替身。
---

> 来源：HN 讨论主帖 [OccupySaaS](https://news.ycombinator.com/item?id=50331402)（540 分，322 条评论），指向 OccupySaaS 官网 [occupysaas.com](https://occupysaas.com/)。本篇为 single post 模式。主帖 2026-11-02 00:17 UTC 发布，归档快照 2026-11-18 02:45 UTC，入库 120 条评论（主帖页面共 322 条评论，未取全量），评论分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文保留 HN 原文的 HTML 实体，锚点标签的属性引号统一写作 `&quot;`，文字与作者逐条与归档评论比对。

## 原文概要

OccupySaaS 的自我定位是一句宣言：They laid us off. We're rebuilding their SaaS.——裁掉我们的是他们的 SaaS，那就由我们来重建它们。网站页脚写着成立时间：2026 年 10 月，许可证 Apache-2.0。首页正中最显眼的一行字是 We are the 1,000,000（我们是那一百万），指一百万名被裁掉的工程师；旁边的标语是「被 99% 造出来的软件，应该归 99% 所有」。整站借用 Occupy Wall Street 的语汇：没有领袖、没有游行、不设路障，只是把帐篷换成终端——每个「被占领」的品类，对应一个能跑起来的开源仓库。

方法论写成了五步，任何人都可以照着执行。第一步 Read the public record：只允许使用公开 API 文档、公开标准与 RFC（点名了 OAuth 2.0、OIDC、REST）、以及已发布 SDK 的可观测行为，把它们写成一份书面规格。第二步 Raise the firewall：写规格的人和写代码的人严格分开，每个仓库带一份 `CLEAN_ROOM.md` 政策，每条 fixture 与引用的来源都要记录在案。第三步 Rebuild with AI：AI agent 只看规格干活，顺序是契约优先（先 `openapi.yaml`）、再代码、再测试，每次合并都要人工 review。第四步 Prove compatibility：建一个「兼容性实验室」，拿厂商自己公开的客户端 SDK 去打自己的服务器，「如果你的老代码不能不改一行就跑起来，那就不算做完」。第五步 Release it to everyone：Apache-2.0、可自托管、可插拔存储、没有你没要求过的遥测、没有座席计数器。允许进入的只有公开 API 文档、公开标准、公开 SDK 行为和黑盒测试结果；被明确禁止的是泄露的专有源码、反编译出来的二进制、前雇主的机密信息，以及抄来的 UI 素材与商标。

已经开工的是两座「被占领的塔」。ZeroAuthy 对标 Auth0：一个能说 Auth0 API 的自托管身份服务器，把现有 Auth0 SDK 指向 ZeroAuthy 的租户域名就能登录，第一个候选版本 v1.0.0-rc.1（2026-11-04）拿到了 OpenID Certified 的 Basic、Config 与 Form Post OP 认证，支持 SQLite、PostgreSQL、MySQL 和 gRPC 插件；这一版明确不含 WebAuthn、通行密钥、SAML、WS-Federation、企业目录、CIBA、JAR 与 token 交换，兼容矩阵里逐条列着缺口。SalesCompel 对标 Salesforce：Go + PostgreSQL 的多租户内核加 Vue 记录编辑器，提供 Account 与 Contact 的持久化 CRUD、object describe 与受限查询、External-ID upsert 与 bearer 认证，另配一个按 Salesforce 公开 API 契约跑的离线测试实验室。两个仓库页面当时分别挂着 313 星和 270 星。

剩下的部分读起来像募捐说明书：三个捐款渠道（Buy Me a Coffee、GoFundMe、GiveSendGo），理由是「这场占领由被裁掉的工程师买单」。技术选型也逐条交代：为什么用 Go——编译出单个自带依赖的二进制，扔到服务器或塞进容器就完事；为什么不用 Rust——「Rust 没什么不对」，规格、API 契约和兼容性测试都与语言无关，Rust 移植版欢迎来做。FAQ 里最要紧的是法务口径：干净室重实现是既有做法，「与 API 互通不等于复制一个产品」，每个项目公开自己的 `CLEAN_ROOM.md` 与来源记录，但「本页不是法律意见」。页面的时间线从 2011 年 9 月 17 日纽约 Zuccotti Park 搭起第一顶帐篷，一路排到 2026 年 10 月 14 日 ZeroAuthy 开源、10 月 15 日 SalesCompel 入场、11 月 4 日第一个候选版本发布。

HN 上的数据轨迹也留了痕迹：快照显示它 11 月 2 日当天从 287 分冲到 482 分，11 月 4 日停在 527 分、317 条评论，之后就淡出了轮询列表；等到 11 月 13 日，评论区又冒出一条新评论——它成了归档里该帖的最后一条记录，内容是吐槽另一个同类项目 PhotoCraft 的 bug。

## 讨论焦点

### 一、最先被指出的讽刺：被 AI 优化掉的人，用 AI 造 AI 的替代品

主帖作者自己在第一条回帖里就把问题摆了出来，语气是反问。

> "Is this Big Tech&#x27;s &#x27;We demand you use AI! Noooo, not like that! moment?" — misswaterfairy [c:50331403]
> （译文：这是不是大科技公司那句「我们要求你用 AI！不不不，可不是这么用！」的时刻？）

反对者的理由说得很直白：逻辑上讲不通。

> "No. Some people want it to be, but it doesn&#x27;t take a lot of thinking to understand why &quot;we got fired from big tech because of AI, so now we&#x27;re fighting back by funding said AI out of our own pockets&quot; makes absolutely no sense." — bakugo [c:50332157]
> （译文：不对。有人当然希望它成立，但「我们因为 AI 被大科技公司裁掉，于是用自己掏的钱去供养 AI 来反抗」这个说法，不需要怎么想就知道讲不通。）

> "exactly, do the people behind this not see the irony of this movement?" — byzantinegene [c:50332260]
> （译文：就是说，这个运动背后的人难道看不到这个运动本身的讽刺意味吗？）

还有一条评论把矛头指向评论区本身。

> "posting this to a website full of ai bots in the comments and software that gets posted here written with ai" — usernametaken2 [c:50332259]
> （译文：把这个帖子发到一个评论区里塞满 AI 机器人、而且贴上来的软件本身也是 AI 写的网站上。）

讽刺之外，也有人认为工具只是工具，用它的人才是关键：读公开 API 文档、翻公开标准、在旧仓库里做考古，AI 恰好是最便宜的实现手段，用不用 AI 和「谁拥有产品」其实是两件事。反对者的火力因此被引向别处——这个运动到底成不成立，取决于它的软件能不能用，而不是它用什么造。

### 二、技术工人到底算不算 99%

「我们是 99%」这句口号是全场最招打的靶子。第一条反对意见把语气、现实、AI 炒作和幼稚混在一起数落。

> "This is a very interesting mix of tone-deaf, disconnected from reality, AI-hype, and naivety that is just hard to wrap ones head around. where do I start.<p>First, is tech workers the 99% now? Come on, look at the average salary vs national median anywhere in the world. This is just a stupid take.<p>Second, this sounds like the idea of &quot;Twitter is just a couple of SQL tables and UI pages&quot; level of &quot;I don&#x27;t understand the depth of software engineering&quot;." — asdfsa32 [c:50332257]
> （译文：这是非常有意思的一种混合物：听不懂话、脱离现实、AI 炒作，加上幼稚，让人一时不知该从何说起。就说两点。第一，现在技术工人是 99% 吗？拜托，看看任何国家的平均工资对全国中位数是什么水平。这是个蠢到家的说法。第二，这听起来像是那种「Twitter 就是几张 SQL 表加几个页面」级别的误解——根本不理解软件工程的深度。）

反驳的一方抓住了 99% 这个数字的定义。

> "The top 3-5% is part of the 99%. Only the top 1% isn&#x27;t. You&#x27;re stealth changing it to the top 95%; don&#x27;t." — deaux [c:50332620]
> （译文：前 3–5% 也属于 99%，只有前 1% 才不算。你这是在不动声色地把 99% 换成前 95%，别这样。）

> "The 99th income percentile for an individual in the USA seems to be over $500,000" — xgulfie [c:50346852]
> （译文：美国个人收入排在第 99 百分位的人，年收入似乎超过 50 万美元。）

这场口水战后面还藏着一个更实际的风险：如果这个运动真的起势，很快就会被贴上政治标签、被分化。评论里有人提到当年 Occupy Wall Street 时期就有过政府渗透与清场的先例，因此这类运动能否维持共识，本身就是个问号。

### 三、许可证之争：Apache-2.0 到底保护了谁

Apache-2.0 是整个项目写进方法论里的选择（官网 FAQ 明确「所有项目以 Apache License 2.0 发布，你可以跑、可以 fork、可以围着它卖服务」），但评论区第一反应是：这不正好让别人拿走你的代码再变回 SaaS 吗。

> "Apache 2.0... so someone can take your code and turn it into saas again!" — everfrustrated [c:50332262]
> （译文：Apache 2.0……那不正好有人可以拿走你的代码，再把它变回 SaaS 吗！）

主张强 copyleft 的理由是：这整套「占领」叙事像一场针对大 SaaS 的圈套，用 MIT/Apache 这种宽松许可证等于给对手递刀。

> "&gt; Apache-2.0<p>Seeing this just feels like this whole thing is just some sort of trick by Big SaaS™ Use a strong copyleft license or go away." — fishgoesblub [c:50332305]
> （译文：> Apache-2.0<br>看到这个我只觉得整件事就是 Big SaaS 玩的一种把戏。用强 copyleft 许可证，不然就别干了。）

反对 copyleft 的一方指出：在 AI 能重写代码的时代，「保护」本身就没那么有意义。

> "&gt;Copyleft.<p>Why even bother with the extra &quot;protection&quot;. It can be re-made by AI as easily.<p>Just go all the way, MIT or BSD. Maximize reusability and adoption." — snvzz [c:50332616]
> （译文：> Copyleft。<br>何必费劲要那点额外的「保护」。AI 一样能把它重做出来。<br>干脆走到底，MIT 或者 BSD，把复用率和采纳率拉满。）

还有一条把许可证当成无用投票的看法。

> "If they had chosen something like AGPL, they would have had comments saying noone is going to use it.<p>Can&#x27;t make everyone happy." — jenadine [c:50333705]
> （译文：如果他们选了 AGPL 之类，就会有人来说没人会用。没法让所有人同时满意。）

真要往「公有领域」那头走，也有人给出了具体的候选。

> "&quot;Zero-Clause BSD&quot; is a bit closer to public domain than MIT if you want that. It&#x27;s essentially <i>only</i> the disclaimer of liability. It omits the requirement to include any notices with the software." — electroly [c:50339992]
> （译文：想要更接近公有领域的话，「零条款 BSD」比 MIT 更近一步。它本质上只保留了免责声明，去掉了必须随软件附带声明的要求。）

### 四、企业为什么不换：从「承担责任」到「谁来兜底」

反对者的火力随后转向最实际的一层：这个替代品就算免费，公司也未必迁移。理由不是意识形态，而是责任、支持与切换成本。

最锋利的一条把「买软件」重新定义成「买一份责任外包」。

> "In my opinion, most tech-like professionals miss the point of delegating liabilities.<p>The whole reason to pay for software is to offload the liability to a 3rd-party. In simpler words: &quot;As a company, I have this need and I don&#x27;t want to solve it myself. Also, if I pay someone, I can sue them on contract breach just in case.&quot;<p>The legal part of the liability offload is key in the decision, because it requires ownership.<p>FOSS doesn&#x27;t fulfill that requirement, therefore, adopting FOSS means the user owns the liability of using the software. Companies don&#x27;t need or want more liability than they currently have to, less is better." — ivanmontillam [c:50332816]
> （译文：在我看来，大多数技术行业的人误读了「责任外包」这件事。我们付钱买软件的全部理由，是把责任甩给第三方。说得直白点：「公司有个需求，不想自己解决；另外我付了钱，万一对方违约我还能起诉他。」这里面法律上的责任外包才是决策关键，因为它要求对方有「主体」。FOSS 不满足这个条件，所以用 FOSS 意味着使用者要自己承担使用软件的责任。公司不需要、也不想要比自己现在更多的责任，责任越少越好。）

第二条把「客户成功」这件事摆到台面上：企业买的不只是软件，还有随时能接电话的人。

> "no opinion of if this is a good idea or not or the overall statement of the thing... but isn&#x27;t support a big part of what these saas companies are really providing... its not just salesforce, its salesforce and customer success teams and 24&#x2F;7 support etc.<p>i suppose this could provide that also (dont see that they want to) but then its just back to vendor a vs vendor b and vendor a in this case has a lot of history and inertia with the companies these guys would need to switch.<p>maybe that wouldnt be a big deal longer term, but near term i think we are probably still in a &quot;nobody gets fired for buying ibm&quot; phase at the moment.<p>ya you could save a ton on that salesforce contract and sticking it to them might feel great, but the project to migrate and then self support this with your own employees is non-trivial and would be a pretty monumental risk to take. like you might as well just internally vibe code a new solution that is perfectly tailored to your biz vs getting a knock off vibe coded version of a saas thing that you only actually use 20% of." — dgently7 [c:50332354]
> （译文：我对这个主意本身和它的整体表态都没意见……但这些 SaaS 公司真正提供的一大块，不就是支持服务吗……它不只是 Salesforce，还有客户成功团队和 7×24 支持等等。<br>我猜这个项目也能提供这些（虽然看不出他们有这个打算），但那样就回到了厂商 A 对厂商 B，而厂商 A 在这些需要迁移的客户那里积累了大量历史与惯性。<br>长期看也许不算大事，但短期我们大概还处在「买 IBM 不会丢工作」的阶段。<br>没错，省下一大笔 Salesforce 合同、并且能恶心他们一下确实很爽，但迁移、再让自己的员工去自维护这个项目绝不是小事，风险相当大。与其拿一个 knock off 的 vibe coded 版 SaaS——而且你实际只用到其中 20%——不如自己在内部 vibe code 一个完全按自己业务定制的方案。）

第三条更具体：自建身份系统的兼容性账单，会由每个下游 SaaS 支付。

> "And because it&#x27;s not trivial for SaaS to support your self-hosted IDP.<p>We have standards like OIDC 2.0, but every IDP (including the big ones like Entra and Google) have subtle differences that still requires custom code per IDP. So all SaaS you interact with will have to do work to support your specific IDP solution.<p>Then there is support, you can&#x27;t reasonably expect a SaaS that you pay a few bucks a month for to help you troubleshoot problems when authenticating using your self-hosted IDP solution inevitably fails." — LeonM [c:50334874]
> （译文：而且，让 SaaS 支持你自建的身份系统（IDP）本身就不轻松。<br>我们有 OIDC 2.0 这样的标准，但每个 IDP（包括 Entra、Google 这些大厂自己的）都有细微差异，仍然需要针对每个 IDP 写定制代码。也就是说，你交互的每一个 SaaS 都得为你这套 IDP 方案额外做功。<br>再说支持：你不能指望一家你每月付几美元的 SaaS，在你的自建 IDP 认证迟早出问题时，帮你排查。）

还有一条把「动机」和「产品」分开：靠愤怒驱动的团队，做不出让客户愿意迁移的产品。

> "Most of the organizations that are successful are so because they had a coherent vision for what the product would be and a passion for solving that particular niche&#x27;s problem. I&#x27;m not sure how anger&#x2F;vengeance rather than a passion for the problem space is going to positively change the customer&#x27;s perception of the product&#x27;s long term vision, support and guarantees. Imagine trying to poach a Salesforce client and they ask you why would they need to invest time and money into migrating to your solution and all you got is &quot;haha, fuck salesforce, they fired me&quot;.<p>The idea seems noble, but a good market-fit product is more than just code sitting inside a github repository. That&#x27;s why there have always been open source alternatives to commercial CRMs long before AI even came into the picture but they never took off." — neya [c:50332170]
> （译文：大多数成功的组织之所以成功，是因为它们对产品要成为什么有一致的愿景，并且对解决那个细分问题有热情。我不确定，用愤怒／复仇代替对问题本身的热情，会怎样正面地改变客户对产品长期方向、支持和保障的观感。设想你要挖一个 Salesforce 的客户，客户问你：为什么要我再花时间和钱迁移到你这边，而你给的理由只有「哈哈，去你的 Salesforce，他们把我裁了」？<br>这个想法听上去很高尚，但一个适配市场的产品不只是躺在 GitHub 仓库里的代码。正因如此，在 AI 出现之前很久，就一直有开源的 CRM 替代品，但它们从来没能真正做起来。）

这层的最后一个问题是动机本身：复仇能不能当燃料。评论者的回答是别把它烧进产品里。

> "You may begin with vengeance but I hope vengeance won&#x27;t be your permanent fuel. It tends to lead with clouded and personal decisions, emotionally charged responses (like the very website copywriting itself) and... well, I have my fair share of grievances and a significant boost of confidence is to persevere in what is right against the wrong that I felt were done to me... but if I make my grievances my customers and supporters&#x27; problem, I am dragging them into my cesspool, spreading the negativity and it simply does not create an environment and spirit of productivity.." — Sydrik [c:50332245]
> （译文：你当然可以从复仇出发，但我希望复仇不是你的永久燃料。它会引出被情绪与个人因素搅浑的判断、情绪化的回应（这个网站的文案本身就很有味道）……我自己也有一肚子委屈，也因为想坚持做对的事而信心十足；但如果我把自己的委屈变成客户和支持者的问题，那就是把他们拖进我的污水坑，把负面情绪扩散出去，这根本营造不出有生产力的环境和氛围。）

### 五、同一个帖子里已经在跑的平行项目

意外的是，这个帖子还长出了一条支线：一批评论者当场展示自己正在做同类项目，方法论高度一致。

一位做电商 SaaS 替代品的开发者直接贴出了自己的三个仓库。

> "I’m already building this:<p><a href=&quot;https:&#x2F;&#x2F;openship.org&quot; rel=&quot;nofollow&quot;>https:&#x2F;&#x2F;openship.org</a><p>I built the e-commerce[0] and restaurant[1] ones by guiding AI heavily but now have a software factory building the rest[2].<p>0. <a href=&quot;https:&#x2F;&#x2F;e-commerce.openship.org&quot; rel=&quot;nofollow&quot;>https:&#x2F;&#x2F;e-commerce.openship.org</a><p>1. <a href=&quot;https:&#x2F;&#x2F;restaurant.openship.org&quot; rel=&quot;nofollow&quot;>https:&#x2F;&#x2F;restaurant.openship.org</a>" — theturtletalks [c:50332237]
> （译文：我已经在做这个了：<br>https://openship.org<br>电商版和餐饮版是我大量带着 AI 写的，现在我有一个「软件工厂」在造其余的版本。<br>0. https://e-commerce.openship.org<br>1. https://restaurant.openship.org<br>后面还有一批按行业命名的子站，健身房、酒店、杂货、租赁、药房、咖啡店等等。）

他的项目名分别是 Openship（订单管理系统）和 Openfront（面向门店的前端），替代目标是 Shopify、Toast、GlossGenius、MindBody、Booksy、Cloudbeds、Dutchie 这一串。起步动机也很朴素：当年 Shopify 开始折腾自定义应用注册，商家做自己的自定义应用还得先去登记，于是他干脆自己写了一个。

另一条评论把整套打法总结成了五步流程，和 OccupySaaS 的方法论几乎一一对应。

> "Many other people in this thread with similar projects seem to be following the same workflow:<p>1. LLM agents sent out to find locked in proprietary software without a FOSS alternative<p>2. Targets selected by a human for deeper research on feasibility and alternatives<p>3. Clean room plan established<p>4. Human uses the software and takes notes<p>5. Feed notes into a token subsidized frontier model for orchestration. Architecture and plan written, beginning normal agentic development flow." — komali2 [c:50332329]
> （译文：这个帖子里不少做类似项目的人，似乎都在走同一套流程：<br>1. 派 LLM agent 去找那些被锁定、又没有 FOSS 替代品的专有软件<br>2. 由人选定目标，深入调研可行性和已有替代方案<br>3. 确立干净室方案<br>4. 人工使用该软件并做笔记<br>5. 把笔记喂进由 token 补贴的前沿模型做编排，架构和方案先写出来，然后进入正常的 agentic 开发流程。）

同一个作者还泼了盆冷水：重写 Photoshop 不现实，理由不是技术，是 GIMP 已经在那儿了而人们照样不用。他更看好被小众软件商锁死、又没有替代品的细分市场——比如绗缝软件、殡仪馆 SaaS，还有 QuickBooks 桌面版这种没有导出通道的死软件。

这段讨论里最热闹的分支是一个同类项目 PhotoCraft（vibe code 出来的 Rust 版 Photoshop）。有人宣称它全面优于 GIMP 3。

> "Usability is much better, binaries are 4 times smaller, and it&#x27;s way faster. GIMP takes 5+ seconds to start, vibe-coded Rust Photoshop starts instantly.<p>I think the &quot;old&quot; open source community has very low standards for user experience when it comes to GUI software. It&#x27;s one of the main reasons I could never get myself to use desktop Linux.<p>With AI, there are no excuses for open source software to be worse in any aspect at all." — Aozora7 [c:50332842]
> （译文：易用性好得多，二进制小 4 倍，快得多。GIMP 启动要 5 秒以上，vibe code 出来的 Rust 版 Photoshop 秒开。<br>我觉得老的开源社区对 GUI 软件的用户体验标准定得太低了，这也是我一直没能说服自己用桌面 Linux 的主要原因之一。<br>有了 AI，开源软件在任何方面做得更差，都没有借口了。）

而本帖归档的最后一条评论（11 月 13 日，也就是让这个帖子重新回热的那条）正是给他泼冷水的：打开就撞上三个 bug，参数还没设就先报 null，直接换回 GIMP 了。

> "It&#x27;s not better. I discovered like 3 errors in photocraft as soon as I opened it. I immediately just switched back to GIMP. GIMP used to be super unusable in like 2008 when I first used it. I&#x27;ve used to do a decent amount of graphic design in the past year and its really not that bad any more. Maybe you&#x27;re just more used to photoshop? Again, photocraft literally complained that i had set parameters to null before even opening the dialogue i needed to set them. It was too buggy to use." — helboi4 [c:50481326]
> （译文：它没那么好。我一打开就发现了大概三个错误，立刻换回了 GIMP。GIMP 在 2008 年我第一次用的时候确实非常难用，但过去一年我做了一些平面设计，它其实已经没那么糟了。也许你只是更习惯 Photoshop？再说一次，photocraft 甚至在我打开需要设置参数的对话框之前，就抱怨我把参数设成了 null。它 bug 太多，用不了。）

这条支线也顺带给「绿地为什么有吸引力」提供了一种解释。

> "Not necessarily (just) ego. It&#x27;s also that greenfield is much, much easier than brownfield. You can make your own decisions, rather than first having to learn what others decided for you. You can start with a naive blue sky vision of the product, not yet tainted by all the complexities that will only surface when you really get into the weeds of the problem you&#x27;re trying to solve." — LawrenceKerr [c:50334658]
> （译文：未必只是自我作祟。绿地项目也比棕地项目容易得多。你可以自己做决定，而不用先去搞懂别人替你做了什么决定。你可以先从一个天真的、蓝图式的产品愿景出发，还没被那些只有真正扎进问题深处才会浮现的复杂性污染。）

### 六、干净室能撑多久，以及 AI 这张牌的代价

最后是技术层面的两个追问：这个「兼容到 100%」的目标现实吗，以及用 AI 造这些东西的代价由谁承担。

有人点出了这个项目真正的差异化：不是「开源替代品」，而是「与现有 SDK 完全对齐」。

> "They are aiming for 100% parity with existing SDKs and APIs. Most FOSS alternatives won&#x27;t get anywhere near that." — wackget [c:50333072]
> （译文：他们的目标是与现有 SDK 和 API 做到 100% 对齐。大多数 FOSS 替代品连边都沾不上。）

而用 AI 做这件事的伦理账单，有人用石棉做了个类比。

> "&gt; <i>I&#x27;m having a hard time demonstrating the enormous activist potential these tools present</i><p>The problem isn&#x27;t that they don&#x27;t have potential, but that the downside isn&#x27;t worth it.<p>You&#x27;re trying to convince people that asbestos has great potential as a building material. You&#x27;re saying it does an amazing job of fireproofing, and don&#x27;t worry your pretty little head about cancer.<p>Asbestos is everywhere in older buildings because it was excellent fireproofing. We&#x27;re still dealing with the consequences." — 0c3ca83 [c:50333091]
> （译文：> 我很难向别人展示这些工具巨大的行动主义潜力<br>问题不在于它们没有潜力，而在于代价不值得。<br>你是在劝人相信石棉是很好的建材——你告诉它防火性能一流，别拿你那颗小脑袋操心致癌的事。<br>石棉出现在那么多老建筑里，正因为它防火性能出色。我们到现在还在处理后果。）

也有人根本不信这套「用开源替代品换掉锁定」的叙事。

> "That’s just a commercial SaaS suite using open as a marketing hook, unless I’m missing something. Many companies start this way and become entrenched." — 1123581321 [c:50333177]
> （译文：除非是我看漏了什么，这无非就是一套把开源当营销钩子的商业 SaaS。很多公司都是这么起步的，然后慢慢固化。）

而支持者那边的回答朴素得多：读公开 API 文档、翻公开标准、在旧仓库里做考古，AI 恰好是最便宜的实现手段；用不用 AI 和「谁拥有产品」其实是两件事。真正该较劲的，是软件本身能不能用——就像 PhotoCraft 那个分支演示的，宣称和实测之间隔着一条鸿沟。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|------|
| 用 AI 重建是逻辑漏洞 | bakugo | 被 AI 裁掉后用自己的钱供养 AI 来反抗，说不通 |
| 看到讽刺是清醒 | byzantinegene | 背后的人难道看不到这个运动本身的讽刺吗 |
| 99% 的说法站不住 | asdfsa32 | 看工资中位数，技术工人在多数国家属于前 3–5% |
| 前 3–5% 仍在 99% 内 | deaux | 只有前 1% 才不算，你是在偷换概念 |
| 愤怒不能当燃料 | Sydrik | 可以从复仇出发，但别把委屈变成客户的问题 |
| 买软件是买责任外包 | ivanmontillam | FOSS 不满足责任外包的条件，责任回到使用者头上 |
| 自建身份系统账单转嫁下游 | LeonM | 每个 SaaS 都得为你的 IDP 写适配代码，还指望它给你排查 |
| 兼容性实验室才是关键 | wackget | 目标是与现有 SDK 100% 对齐，多数 FOSS 替代品做不到 |
| 许可证该用强 copyleft | fishgoesblub | Apache-2.0 感觉像 Big SaaS 的圈套 |
| copyleft 保护无意义 | snvzz | AI 一样能重写，不如直接 MIT/BSD 拉满采用率 |
| 开放是营销钩子 | 1123581321 | 这无非是套用开源当营销的商业 SaaS |
| 平行项目已在生产运行 | theturtletalks | 自己的电商业务已经在用 Openfront 和 Openship |
| AI 的代价被低估 | 0c3ca83 | 你是在劝人相信石棉是好的建材 |

## 总体情绪

这个帖子表面在讨论两个开源项目，实际上在争三件事：这个运动的叙事成不成立（被裁掉的人算不算 99%）、它的方法论撑不撑得住（干净室加 AI 能不能做到真兼容），以及更实际的——企业到底会不会为「便宜」而放弃「有保障」。

支持方的底气来自可核对的东西：Apache-2.0、公开仓库、`CLEAN_ROOM.md`、拿厂商自家 SDK 打的兼容性实验室、一个已经拿到 OpenID 认证的候选版本。质疑方的底气则来自常识：软件不等于支持，兼容不等于可用，动机一旦是愤怒，产品就会带上愤怒的味道。这两股力量谁也没压过谁——因为连反对者都承认，把 Auth0 和 Salesforce 拆成「公开 API + 规格书 + SDK 行为」这件事本身并不难，难的是把它做到 100% 对齐、并且长期有人维护。

最有意思的副线反而是评论区自己长出来的那条：有人当场贴出同构的项目，有人贴出五步流程，还有人把「用 AI 重写老软件」这条路的成败，用一个 vibe code 出来的 Rust 版 Photoshop 演示了一遍——宣称全面优于 GIMP，开箱三个 bug，11 天后有人回来泼冷水说已经换回 GIMP 了。理想与现实的距离，就摆在那条讨论里。

最后留在桌上的事实大概是这样：写一份兼容规格书不难，难的是凌晨三点有人接电话——而那恰恰是开源替代品最难免费提供的东西。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | OccupySaaS（HN 主帖） | <https://news.ycombinator.com/item?id=50331402> |
| 2 | OccupySaaS — They laid us off. We're rebuilding their SaaS.（原文首页） | <https://occupysaas.com/> |
| 3 | ZeroAuthy — 兼容 Auth0 API 的自托管身份服务器 | <https://github.com/occupysaas/zeroauthy> |
| 4 | SalesCompel — 按 Salesforce 公开 API 契约构建的开源 CRM | <https://github.com/occupysaas/salescompel> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 540 分、322 条评论，归档快照 2026-11-18 02:45 UTC，入库 120 条，未取到全量评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按归档原文保留，锚点标签的属性引号统一写作 `&quot;`。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文抓取成功，但归档正文在 8000 字符处截断，11 月 4 日发布的 v1.0.0-rc.1、仓库星标数、兼容性矩阵与完整 FAQ 段落不在截断范围内。本文「原文概要」中的这部分事实（ZeroAuthy v1.0.0-rc.1 与 OpenID Certified 认证、313 星 / 270 星、SalesCompel 的功能清单、Go 与 Rust 选型说明、时间线与募捐渠道）取自 2026-11-21 直接访问官网首页所得的完整正文；引用帖表中的仓库链接同样取自该页面。

主帖数据轨迹取自归档快照序列：2026-11-02 10:39 UTC 为 287 分 / 167 条评论，11 月 4 日 01:05 UTC 为 527 分 / 317 条评论，此后不再出现在轮询列表；归档中该帖最后一条评论发表于 2026-11-13 10:26 UTC。

文中关于「干净室重实现是否合法」「技术工人是否属于 99%」「Apache-2.0 是否足以保护作者」等说法，均为项目方或评论者个人观点，本文只做转述，未独立验证；PhotoCraft、Openfront、Openship、genairosity 等项目由评论者自行提及，其代码质量与生产使用情况未经核实。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
