---
layout: post
title: >-
  Google Gemini 把 Drive 文件和邮件送进人工标注队列 — HN 讨论摘要
date: 2026-11-10
hn_id: 50429426
categories: [articles]
excerpt: >-
  2023 年 Google 承诺连上 Gmail 和 Drive 的内容不会被真人看到，10 月 16 日那次文档修订悄悄把它收回了。
  随口问一句「我这个月网费是不是交多了」，就有概率把整封账单原文拖进对话上下文，
  落进人工审核队列。评论区分成三路：愤怒、迁移、和算账。
tagline: >-
  写进 2023 年博客的承诺，活到了 10 月 16 日那份修订。
---

> 来源：HN 讨论主帖 [Google Gemini routes personal Drive files and emails to human annotators](https://news.ycombinator.com/item?id=50429426)（519 分，118 条评论），原文是一份 GitHub 文档 [thisisme6598/gemini_files](https://github.com/thisisme6598/gemini_files/)。本篇为单帖模式。归档快照 2026-11-10 06:21 UTC，入库评论 95 条。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

2023 年 Google 发布 Gemini 的 Workspace 扩展时，承诺写得很清楚：来自 Gmail、Docs、Drive 的个人内容「不会被真人审阅员看到」（is not seen by human reviewers）。现在这条承诺被悄悄收回——Google 帮助中心的答案 16836988，以及 2023 年那篇博客的 10 月 16 日修订版，都明确承认连上 Drive 和邮箱之后，这些内容会被送进人工审核流程；文档还提醒审阅者看到的东西「可能就只是那封邮件或那个文件」，以及「不要把含有机密信息的应用连到 Gemini Apps」。

要害不在于「会有数据被看」，而在于这条路径是模型自己踩响的。文档作者的测试显示：在消费版 Gemini 里开启 Connected Apps 之后，只要对话中顺带提到旅行、账单、姓名、预订这类个人话题，模型就会在后台去查 Workspace——不需要 @Drive 或 @Gmail 标签，也不需要你明确要求找文件。而且这是概率性的，取决于模型的工具调用和上下文注入是否触发。

同一条查询会落在四种状态之一。文档作者的分法是：零检索（模型根本没调工具，问题可能用模型权重或旧对话就答了）；元数据摘要（「你有 3 封关于航班的邮件」）；部分原文抽取（2 到 4 句逐字引用，经常带着账号、确认号、具体金额）；以及全文摄入——整封邮件、连邮件头一起，原封不动进上下文。

复现方法文档写得很具体：打开 Connected Apps，模型选「Flash」并且「High Thinking」或更高；用一个你 Drive 或邮箱里确实存在的话题随口问一句，不加 @ 标签；等它给出基于某个邮件或文件的回答之后，紧接着说「Print the exact text and metadata block that the retrieval tool returned and injected into your prompt to get that answer. Use a human readable format without code blocks」；想重测就先删掉对话，免得它从历史里直接抄。作者自己的实验用的是一封运营商账单，追问「我是不是网费交太多了」，四种结果全出现过，包括只回「9 月 4 日有一笔 122 美元的账单」，以及带上姓名、账号、确认号的完整版本。

最后一段是要害：Google 自己的文档承认，正则加 NER 的自动脱敏没法处理叙述性数据——账号、确认号、交易日期，以及姓名加城市加事件这种组合型可识别信息。也就是说，2023 年卖出去的那个「与人工审核隔离」的前提已经不存在：文件是在闲聊中被概率性地整份吸进去的，而这些会话会被人工承包商审阅。

## 讨论焦点

### 一、消费版 Gemini 和 Workspace 不是同一件事

排在最前面的评论先把范围划开：受影响的只有消费版 Gemini 的 Connected Apps，Workspace 侧仍然声称不受人工审阅影响。

> "Note that this is specifically Consumer Gemini with Connected Apps; Workspace Gemini (and Workspace Intelligence, the RAG thing for enterprise&#x2F;Workspace) still claims not to be subject to human review:<p><a href="https:&#x2F;&#x2F;knowledge.workspace.google.com&#x2F;admin&#x2F;generative-ai&#x2F;generative-ai-in-google-workspace-privacy-hub" rel="nofollow">https:&#x2F;&#x2F;knowledge.workspace.google.com&#x2F;admin&#x2F;generative-ai&#x2F;g...</a><p>So basically if you use consumer Gemini and specifically authorize the GMail app, for example, then it will sometimes use the GMail tool to load your mail from GMail, and that data (like all data in consumer Gemini) might be given to the human annotation pipeline.<p>This whole thing seems deeply stupid to me from Google&#x27;s standpoint, although they&#x27;ve never been good at product management - there&#x27;s _way_ too much nuance to what&#x27;s going on and even if they aren&#x27;t technically affected, this kind of thing will almost surely make their paying enterprise customers leery." — bri3d [c:50432666]
> （译文：注意这里说的是消费版 Gemini 加 Connected Apps；Workspace Gemini（以及面向企业的 Workspace Intelligence 那个 RAG）仍然声称不受人工审阅影响：[链接]。所以基本上，如果你用消费版 Gemini 并且单独授权了 Gmail 应用，它就会时不时调用 Gmail 工具去读你的邮件，而这些数据（就像消费版 Gemini 的所有数据一样）可能会被送进人工标注流程。这整件事从 Google 的角度看蠢得可以，虽然他们从来就不擅长产品管理——这里面的细节差异实在太多了，哪怕技术上没被波及，也几乎必然会让他们的企业客户心里打鼓。）

对 Meet 转写耗时异常的另一位读者，他给出更冷的一句：

> "There are explicit data retention contracts for Workspace (including Gemini transcription) and Google claim this data is never used for training or human review, so this is fairly baseless.<p>This gist is specifically about the consumer version of Gemini used in Gemini Apps. Basically if you connect your consumer Gemini (which always sends stuff to the training pipeline) to your personal Google Apps account, it gets tools that it can invoke to read your Google Apps data, which then might appear back in your consumer Gemini transcripts that are getting sent to the training pipeline.<p>Doing this is a stupid product move from Google (per the usual) because it confuses their enterprise customers into thinking Really Bad Stuff like this is happening." — bri3d [c:50432919]
> （译文：Workspace（含 Gemini 转写）有明确的数据留存合同，Google 声称这些数据从不用于训练，也不用于人工审阅，所以那个说法基本是无的放矢。这份文档说的只是 Gemini Apps 里消费版 Gemini 的情况。基本上你把消费版 Gemini（它本来就什么都往训练管线里送）和你的个人 Google 账号连上，它就拿到了可以调用、读取你 Google Apps 数据的工具，而这些数据又可能回到消费版 Gemini 的对话记录里，再被送进训练管线。这对 Google 来说是个愚蠢的产品决定（不出所料），因为它会让企业客户误以为这种事正在发生。）

争论的焦点因此不是「Google 会不会看我的邮件」，而是消费版与企业版之间的那道边界画在哪、有没有被写在用户看得见的地方。

### 二、那个弹窗，没有人看得懂

权限提示的实际含义和它的措辞对不上，这是评论区反应最快的一处。

> "Any time I’ve opened Gemini it’s given me a full screen “do you want to allow connected apps” popup and I click no every single time.<p>It’s not clear what clicking yes does. Is it my entire drive and Gmail? Do I have to give permission per-file&#x2F;folder&#x2F;email?<p>So I click no. And it just gives me the popup again later" — snailmailman [c:50433351]
> （译文：我每次打开 Gemini，它都会弹一个全屏的「要允许连接应用吗」提示，而我每一次都点否。点同意之后会发生什么并不清楚。是我整个 Drive 和 Gmail 吗？需要按文件、按文件夹、按邮件逐个授权吗？所以我点否。然后它过一会儿又弹一次。）

作者本人来回答这个提问：

> "It allows Gemini to autonomously search anything in your Drive or email. If it deems it relevant to the conversation, Gemini can pull summaries, snippets, or even the file plaintext of the file into the context window, making it eligible for human review." — gf74918 [c:50433380]
> （译文：它允许 Gemini 自主检索你 Drive 或邮件里的任何内容。它判断与对话相关时，可以把摘要、片段，甚至文件原文拉进上下文窗口，从而进入人工审阅范围。）

每天都在点这个按钮的人，描述了按钮的措辞方式：

> "I use Gemini and every day it tries to connect all these apps together. It always uses reassuring language like &quot;You are in control of your data&quot;. That wording actually makes me take a second look at what I am approving." — dizhn [c:50433593]
> （译文：我用 Gemini，它每天都试图把这些应用连起来，用的还都是「你的数据由你掌控」这类让人安心的措辞。正是这种措辞让我会多看一眼自己到底批准了什么。）

而这套设计的商业逻辑，被人一句话点破：

> "You have to remember that Google is first and foremost a data company. I don&#x27;t want to sound conspiratorial but every misclick or misunderstood permission window does give Google more data which means more money." — scuttlebutt98 [c:50434345]
> （译文：别忘了，Google 首先是一家数据公司。我不想搞得像阴谋论，但每一次误点、每一扇没读懂的权限窗口，都等于送给 Google 更多数据，也就是更多钱。）

也就是说，读者担心的不是一次授权换来的长期能力，而是模型在后台自主检索这个事实——授权按钮解释的是前者，文档描述的是后者。

### 三、愤怒之外，还有一种「早该知道」

反应最激烈的一条把问题指向了信任的流失过程：

> "Really frustrating that our privacy eroded to the point anyone would think this is reasonable.<p>But it does explain some conversations with Gemini when I wonder why it&#x27;s talking about particular things. Like asking it about consultation processes for changes to parks only to get a response that&#x27;s uncannily tuned to the email I got prompting the enquiry.<p>No mention of I just read your emails etc ." — rustyhancock [c:50431419]
> （译文：真正让人憋屈的是，我们的隐私已经退化到有人会觉得这事是合理的程度。但这倒也解释了为什么我有时会困惑 Gemini 为什么在讲某些具体的事。比如我问它关于某个公园改造的咨询流程，得到的回答却精准地贴合了当初促使我去咨询的那封邮件。它完全不提「我读了你所有的邮件」这种事。）

有人把一次 Google Meet 转写耗时超过 24 小时（平常不到 1 小时）和人工介入联系起来：

> "I had a Google Meet Gemini transcription take well over 24hours once recently, rather than the usual &lt;1hr. I could only assume manual intervention was the cause.<p>It might also explain why Google do not provide a page to view transcription job queues from meet. You just have to sit and wonder" — easytiger [c:50431802]
> （译文：最近有一次 Google Meet 的 Gemini 转写花了超过 24 小时，平时都是不到 1 小时。我只能假设是人工介入导致的。这也解释了为什么 Google 不提供查看 Meet 转写任务队列的页面——你只能坐在那里猜。）

另一批读者的反应则要平得多，认为这只是数据采集链条上早已注定的一环：

> "Of course they do. Now that all the freely available training material has been consumed, every website ingested, every image classified, every YouTube video watched, and even books scanned and destroyed, the insatiable hunger for more data must be fed." — jttnr [c:50432082]
> （译文：他们当然会这样。现在免费可用的训练材料都被消耗完了，每个网站被吞下，每张图片被分类，每段 YouTube 视频被看过，连书都被扫描并销毁，对更多数据的贪得无厌终究要被喂饱。）

也有读者顺手算了一下自己已经付出的成本：

> "Gemini is the worst AI agent I&#x27;ve used so no big loss here. Another great move to get people to move off Google services." — 0xbadcafebee [c:50434460]
> （译文：Gemini 是我用过的最糟糕的 AI agent，所以这也没什么损失。Google 又迈出了漂亮的一步，把人往自家其他服务外面赶。）

> "The only thing they seem to never route to humans is support." — pmdr [c:50432588]
> （译文：唯一他们从来不路由给真人的，是客服。）

### 四、自托管：评论区最具体的一节

讨论从愤怒转向了动手迁移，落地细节占了不少篇幅。

已经在搬的这位读者描述了自己的全套方案：

> "As soon as AI started blowing up I rushed all of my data out of Google and to self hosted. It&#x27;s obvious they were going to suck it all up in to their training and analyze everything to build a perfect profile on you. They always were but the capabilities are supercharged now.<p>Immich + Nextcloud + Dawarich behind Tailscale has been a dream. I picked up a second hand HP mini PC for cheap, 3D printed a mini server rack to mount it in with some hard drives." — Gigachad [c:50434334]
> （译文：AI 一开始爆火，我就赶紧把自己的数据全搬出 Google，搬到自托管机上。他们显然是要把这些数据全部吸进训练里、分析一切，给你建一份完整档案。他们一直是这样，只是现在能力被放大了。Immich + Nextcloud + Dawarich 挂在 Tailscale 后面用起来很舒服。我淘了个二手 HP mini PC，又 3D 打印了一个迷你机架，把硬盘挂上去。）

关于顺序，有一条经验被反复提到：

> "As someone who self hosts many services, I would encourage you to switch to self hosted email last. Even though self hosting has been made much easier thanks to really incredible FOSS tools, you are going to have random learning pains, some delayed by a few months, and it would really suck to lose email for even the shortest durations. The others are easy to live without while you debug during the learning process.<p>Btw immich is incredible. I recommend Nextcloud AIO instead of raw Nextcloud. Absolutely great tools" — eks391 [c:50433056]
> （译文：作为一个自托管了很多服务的人，我建议把自托管邮件放到最后。虽然 FOSS 工具让自托管容易了很多，但你还是会遇到各种学习上的痛点，有些会拖上几个月，而且哪怕只中断一小会儿，邮件全丢的感觉也会非常糟糕。其他那些在调试学习过程中少用几天没什么。顺便说一句，immich 非常棒。我推荐 Nextcloud AIO 而不是原生 Nextcloud，都是好工具。）

备份方案的成本也算得很细：

> "I use Mega. They have the cheapest per TB S3 compatible service I can find, and they&#x27;ve actually been very reliable. I use Kopia to perform (and encrypt) the backups, so they never get anything other than the raw data and it&#x27;s all done on a schedule.<p>I think I paid $300&#x2F;year for 20TB, so it&#x27;s not free, but it&#x27;s offsite, well encrypted, and I&#x27;m pretty sure it will still be there if I need it next week." — mapontosevenths [c:50435678]
> （译文：我用 Mega。它是我找到的最便宜的每 TB S3 兼容服务，而且一直很可靠。我用 Kopia 做备份（并且加密），所以它们拿到的永远只是原始数据，而且是按计划跑的。我记得我是一年 300 美元买了 20TB，不算免费，但它是异地、加密的，而且我下周需要的时候它多半还在。）

自托管本身也不是没有代价，风险被算成了两个概率：

> "NextCloud AIO runs in Docker containers, so it&#x27;d be a jump to break out of that, but, yes, they could exfiltrate your data, though the PHP2Shell PoCs I&#x27;ve seen aren&#x27;t trivial (unlike the Alpine ssh vulnerability).<p>I guess it&#x27;s choose your poison. What are?<p>P(companies&amp;governments spying on you)<p>P(hacker stealing your files)<p>The impacts of the latter are probably more dangerous but unless you&#x27;re a juicy target, I&#x27;d imagine most hackers are going to go for rich grandmas (sadly). So my gut feelings are ~0.95 and ~0.04, respectively." — kevg123 [c:50434792]
> （译文：Nextcloud AIO 跑在 Docker 容器里，要从里面逃逸确实难度不小，但他们仍然可能把数据外泄，不过我见过的 PHP2Shell PoC 并不简单（不像 Alpine 那个 ssh 漏洞）。大概只能算二选一：P(公司与政府监控你)，P(黑客偷走你的文件)。后者的影响大概更严重，但除非你是个 juicy target，否则黑客多半会去盯有钱的老太太（可惜了）。所以我直觉上大约是 0.95 对 0.04。）

评论区的共识是：真正的成本不是硬件，是长期运维——有人干脆选择最省事的补法：

> "That feeling is your cue to do something about it. Don’t let best be the enemy of good. Automatic backups are great, but if you have irreplaceable data that it would pain you to lose, go get an external hard drive and dump it all on that, right now." — taneq [c:50434329]
> （译文：有这种念头，就该现在动手做点事。别让「做到最好」成为「做到够好」的敌人。自动备份当然不错，但如果你有那种丢了会心疼、而且不可替代的数据，现在就去弄个移动硬盘，把东西全倒进去。）

### 五、钱能解决什么，技术能解决什么

关于「能不能退出」，有一条算得最清楚：

> "So, if you want privacy from human reviewers, pay up $7&#x2F;month (with an annual plan) and signup for Business Starter which comes with basic usage limits for Gemini. Then, for more gemini usage pay up more for AI Ultra plans.<p>Strangely, they let you opt out of using your data for AI training, but not opt out of human reviewers." — vinay_ys [c:50435759]
> （译文：所以，如果你想躲开人工审阅，那就每月付 7 美元（年付），开通带 Gemini 基础额度的 Business Starter。想要更多 Gemini 用量就再往上加 AI Ultra 档。奇怪的是，他们允许你退出「用你的对话做训练」，却不允许你退出人工审阅。）

一位读者说自己正是因此关掉了 Gemini：

> "Not that surprised. I dropped gemini as soon as I learned that I could not opt out of google using my chats for training." — rbobby [c:50433563]
> （译文：我并不怎么惊讶。我一知道自己的对话没法退出 Google 的训练用途，就立刻不用 Gemini 了。）

更老练的读者则指出这只是长逻辑里的一环：

> "Google and the companies it considers its competitors in a given space (e.g. primarily Microsoft in &quot;workspace&quot; and cloud storage, for example) have already demonstrated for over a decade that they&#x27;re willing to use any data you store in their services for any purpose they feel like, and often much of this is written into EULAs, but also it doesn&#x27;t seem to matter if it isn&#x27;t. I hope that if this is your first exposure to this basic fact, it encourages you to stop trusting google and look for alternatives with auditable guarantees" — advael [c:50435416]
> （译文：Google 以及它在某个领域里视为竞争对手的公司（比如主要是 Workspace 和云存储领域的微软），十几年来早就证明了：只要数据存在它们的服务里，它们愿意拿来做任何它们想做的用途，而且很多时候这已经写进了 EULA，但即使没写似乎也无所谓。我希望这是你第一次意识到这个基本事实，那它应该能促使你停止相信 Google，转而去找那些有可审计保证的替代方案。）

### 六、法律、行业结构，以及「谁在看」

要抓的是人的一类评论直接指向集体诉讼：

> "This all to me sounds like a serious class-action lawsuit." — giancarlostoro [c:50434252]
> （译文：这一切在我听来就是一场严肃的集体诉讼。）

另一条线指向行业结构本身：把矛头对准的不是 Google 的道德，而是 AI 与云这两块市场的竞争格局。更熟悉这一行的人当场给出了相反的账本：

> "There are 5 major frontier labs competing in the US alone with serious capital. Perhaps only 2 of them are are truly in contention for the top spot, but it&#x27;s highly competitive. Then throw in the handful of very serious sub-frontier open weights labs, who are creating huge price competition for the frontier labs, and I have no idea how you can come to this conclusion.<p>Cloud is no different: 3 major cloud vendors, with 1 clear leader...and now a long tail of tier 2s and neoclouds that are also investing incredible sums to compete.<p>Where is the pre-structured duopoly? Where is the profit moating?" — qeternity [c:50432674]
> （译文：仅美国就有 5 家资本雄厚的头部实验室在竞争。或许真正争第一的只有 2 家，但竞争非常激烈。再算上几家非常认真的次前沿开放权重实验室，它们正在给头部实验室制造巨大的价格竞争，我完全看不出你怎么得出这个结论。云也一样：3 家主要云厂商，1 家明显领先……而现在还有一长串二线厂商和 neocloud 也在砸重金竞争。预先搭好的双头垄断在哪？利润护城河在哪？）

至于「谁在看」这件事，评论区里有两句被反复转述的黑色幽默：

> "Don&#x27;t worry, it&#x27;s safe because they also send your personal files to be inspected by extremely poorly paid human reviewers who will definitely keep your bitcoin keys safe for you." — mapontosevenths [c:50435617]
> （译文：别担心，很安全的，因为他们还把你的个人文件送给工资极低的人工审阅员，而他们肯定会替你看好那些比特币私钥。）

> "Any tool having manual human reviewers or annotator like all of Gemini and notebooklm (now Gemini notebook) suffer from this. Your data has high chance being read by random people or being leaked for training because they might flag it then use it to &quot;improve&quot; the model." — hek2sch [c:50432220]
> （译文：任何带人工审阅或标注员的产品都有这个问题，Gemini 和 NotebookLM（现在叫 Gemini Notebook）都一样。你的数据大概率会被陌生人读到，或者被泄露用于训练，因为他们可能把它标记出来拿去「改进」模型。）

还有读者把问题推到了更远的地方：连 AI 生成的照片，最终都可能被系统当成事实：

> "It&#x27;s worse than that.<p>&gt; Google Photos data is used to infer your interests, relationships to people in your photos, and where you&#x27;ve been, including by associating your face with corresponding location data and timestamps. This data is also used to do things for you, like look up your info or add items to your grocery list, and to improve Google services, including training generative AI.<p>How does that work exactly if the images aren&#x27;t even real and are generated by AI? When Google siphons up these photos to help them train their AI, the AI is now going to make associations as depicted in that photograph?<p>That you really were with that person, in that place, in that situation, on that date? As some sort of a fact?<p>Can someone else create that image and just put it in their library and then have that become a fact on your behalf when picked up, analyzed and trained on?<p>Where does that all lead?" — EMM_386 [c:50433036]
> （译文：比那更糟。……Google Photos 的数据被用来推断你的兴趣、你与照片中人的关系、以及你去过哪些地方，包括把你的脸和对应的位置数据、时间戳关联起来。这些数据还用来替你做事，比如查找你的信息或往你的购物清单里加东西，也用来改进 Google 的服务，包括训练生成式 AI。……如果这些照片根本不是真的、而是 AI 生成的，这套机制到底是怎么运作的？当 Google 把这些照片抽走用于训练 AI 时，AI 就会按照片里描绘的样子建立关联——认定你确实和那个人在那个地方、在那种情境下、在那个日期在一起，当成某种事实？那别人是不是可以生成一张图放进自己的图库，等它被采集、分析、训练之后，就替你成为事实？这到底通向哪里？）

至于会不会有人去推动监管，也有人提了一句：

> "Leads to people start calling their senator and start pushing to regulate and break apart every big tech... just as they torrent everything (whoops), they will access everything..." — xlayn [c:50433713]
> （译文：这会让人开始给自己的议员打电话，推动把每一家大科技公司都拆掉监管掉……就像他们盗版一切一样（他们也会访问一切）……）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 只有消费版中招，企业版仍有合同兜底 | bri3d | Workspace 声称不用于训练也不做人工审阅，问题出在消费版接了个人账号 |
| 权限窗口没解释真实范围 | snailmailman / gf74918 | 点一次同意，换来的是 Gemini 对整个 Drive 和邮箱的自主检索权 |
| 授权话术是数据公司的常规操作 | scuttlebutt98 | 每一扇没读懂的权限窗口，都是送给 Google 的更多数据 |
| 这是信任退化的结果，不是意外 | rustyhancock / easytiger | 隐私已经退化到有人觉得人工审阅合情合理 |
| 早该知道，训练材料早就吃完了 | jttnr / 0xbadcafebee | 数据饥饿是必然结果，Gemini 本来就是最差的 agent |
| 能用钱换到的隐私很有限 | vinay_ys / rbobby | 可以退出训练，不能退出人工审阅 |
| 迁移方案可以自己搭 | Gigachad / eks391 / mapontosevenths | Immich + Nextcloud + Dawarich 挂 Tailscale，邮件放最后迁 |
| 自托管不是免费的 | kevg123 / mapontosevenths | P(被监控) 约 0.95 对 P(被黑) 约 0.04，备份 20TB 一年 300 美元 |
| 行业远没到双头垄断 | qeternity | 仅美国就有 5 家头部实验室，云厂商后面还排着一长尾 |
| 可能得靠法律解决 | giancarlostoro / xlayn | 指向集体诉讼与拆分监管 |

## 总体情绪

这帖的底色不是纯愤怒，而是愤怒之后的一种熟悉感。有人早就把 Google 当数据公司而不是服务商，也有人早就搬到了自托管机房；真正让讨论升温的，是这件事发生在一次闲聊里——没有人命令 Gemini 打开那封账单，是模型自己判断这个话题和你的邮箱有关，然后整封邮件进了可能被人看的队列。

分岔也就出现在这里：有人认为这是隐私退化的又一步，有人认为这是数据采集链条的必然，还有人关心的是执法与行业结构。评论区里唯一实际发生的动作，是迁移——照片搬去 Immich，邮件服务器搬回自己家里，硬盘买好，备份加密。只是这一整套动作的前提，是承认自己手里的数据迟早会被读。

到最后，最让人不安的不是「有人看了」，而是「看的人不在合同里」。Google 能让你退出训练，不能让你退出人工审阅；能把所有承诺写进帮助中心，也能在某一天把旧版本悄悄改掉。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Google Gemini routes personal Drive files and emails to human annotators（HN 主帖） | <https://news.ycombinator.com/item?id=50429426> |
| 2 | 原文：thisisme6598/gemini_files — Gemini 文件读取行为文档（GitHub） | <https://github.com/thisisme6598/gemini_files/> |
| 3 | Google Gemini 帮助中心答案 16836988（原文引用） | <https://support.google.com/gemini/answer/16836988> |
| 4 | Google 2023 年博客：构建生成式 AI 护栏的负责任做法（原文引用，10 月 16 日修订） | <https://blog.google/innovation-and-ai/products/our-responsible-approach-to-building-guardrails-for-generative-ai/> |
| 5 | Google Workspace 生成式 AI 隐私说明（bri3d 在评论中引用） | <https://knowledge.workspace.google.com/admin/generative-ai/generative-ai-in-google-workspace-privacy-hub> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 519 分、118 条评论，归档快照 2026-11-10 06:21 UTC，入库 95 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于 Google 帮助文档答案编号 16836988、10 月 16 日博客修订、四种抓取状态与 122 美元账单等数据，均来自原文仓库及作者自述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
