---
layout: post
title: >-
  Anthropic 盗版书案：法院判训练合法、判下载违法，评论区搬出 Aaron Swartz — HN 讨论摘要
date: 2026-10-28
hn_id: 50260814
categories: [articles]
excerpt: >-
  法院认定用合法购得的图书训练 Claude 属合理使用，只禁止从影子图书馆下载并建永久书库。
  评论区把话题拐到 Aaron Swartz 的旧案上：一个人在被追诉期间去世，一家公司交了 15 亿和解。
tagline: >-
  判训练合法、判盗版违法；15 亿美元买不回那 10 本书的署名。
---

## 原文概要

《Stanford Daily》在 10 月 27 日报道了一桩联邦诉讼的细节。2026 年 5 月，联邦法官 William Alsup 在 Bartz v. Anthropic 中裁定，Anthropic 不得再通过盗版图书来建立一个永久性的中央书库。案件涉及的作者里包括斯坦福教授 Tobias Wolff、Abraham Verghese、Chang-Rae Lee、Daniel Mason、Hayagreeva Rao 和 Myra Strober。原文的说法很直接：Anthropic 之前就是用这些非法取得的文本训练 Claude 的。

Bartz v. Anthropic 被作者联盟称为史上涉及 AI 公司金额最大的版权和解，最终和解金额 15 亿美元，赔付对象是接近 50 万件登记作品的作者与出版方——平均到每本书约 3000 美元。但 Alsup 法官同时给了 Anthropic 一个更重要的许可：合法购得的图书用来训练 LLM，属于合理使用。他把 AI 训练类比成人读书、记住主题和风格，并写道：「就像任何有志成为作家的读者一样，Anthropic 的 LLM 在这些作品上受训，不是为了抢跑、复制或取代它们，而是为了转过一个弯、做出不同的东西。」

这正是评论区的火力集中点：被认定合法的只是「读」，被判违法的是「偷书」。Wolff 的反应是：「这样让我去干活，却没有任何报酬，是一种奴隶劳动。」他有 10 本出版物在未经许可的情况下被用于 AI 训练。他还说，和解「仍然给了 Anthropic 相当大的自由，让它在我们的文学里随意走动，想拿什么就拿什么，只要它认为对自己有用、能盈利。」

Wolff 和 Lee 退出了 Bartz 和解。2026 年 5 月，他们另起非集体诉讼 Cruz v. Anthropic，要求陪审团团审判，并主张法定赔偿最高每件作品 15 万美元，远高于 Bartz 和解里每件约 3000 美元的均价。如果这场官司赢了，他们将获得针对用其作品训练 Claude 模型的永久禁令。原诉状指控 Anthropic 从 LibGen、PiLiMi 这类影子图书馆非法下载、复制、分发受版权保护的图书，并违反了把盗版文件下载并存进中央书库的法律。

更难的是制度层面的账。斯坦福法学院知识产权学者 Paul Goldstein 在给该报的邮件里写道：「核心问题是……经济学家所谓的『交易成本』。」任何一次训练都可能复制数百万件受版权保护的作品，平台去和每一位——甚至任何一位——版权人逐一谈许可，实际上做不到。除 Bartz 和 Cruz 之外，作者、视觉艺术家和新闻媒体（包括《纽约时报》和 Getty Images）已对 AI 公司提起 70 多起侵权诉讼。作者协会同时在起诉 OpenAI 和 Microsoft，首席执行官 Mary Rasenberger 说，许可制能让作者和出版方获得报酬，并有权要求使用过滤器，确保作品不会出现在输出里，除非另行授权；该协会正在与国会合作推动要求许可的全国性立法。

HN 上这条帖子拿到 491 分、245 条评论。提交者一开场的标题是「Anthropic 非法用斯坦福教授的书训练了 Claude」，被指误导后当场改掉了。

## 讨论焦点

### 一、标题先被改了：判训练合法，判盗版违法

帖子最先爆开的是标题本身。kenmacd 指出，文章从头到尾没说过训练是违法的：

> "The article does not say the training was illegal (although does discuss the professors push for a licensing model)." — kenmacd [c:50260994]
> （译文：文章并没有说训练是违法的——尽管它确实讨论了教授们推动许可制的诉求。）

CPUHall 把裁定的结构说得更利落：

> "Title is misleading. The ruling said training on books is fair use. What got them in trouble was grabbing the books from LibGen instead of just buying them, which is a pretty dumb way to lose $1.5B." — CPUHall [c:50261313]
> （译文：标题有误导性。裁定说的是用书训练属于合理使用。让 Anthropic 惹上麻烦的是从 LibGen 抓书而不是直接买书——为了损失 15 亿美元，这可真是个相当愚蠢的搞法。）

值得注意的是，被认为是「真正值得注意」的那半句话，反而出自坚持「区分并非无意义」的人：

> "The noteworthy thing here, IMO, is the judge seems to have explicitly stated that using legally-acquired works to train AI models falls under fair use." — alistairSH [c:50261329]
> （译文：依我看，这里真正值得注意的，是这位法官似乎已经明确表示：用合法取得的作品训练 AI 模型属于合理使用。）

kenmacd 同意这是关键区分，并给出了裁定的实际内容：

> "What the actual ruling found was that the professors should have been paid some tens of dollars for 1 copy of their book." — kenmacd [c:50261723]
> （译文：裁定实际认定的是，教授们的书应当按每本一本、几十美元获得报酬。）

提交者 car 当场认了：

> "Thanks, I concur and have changed the author’s original title to better represent the article." — car [c:50261443]
> （译文：谢谢，我同意，已经把作者原来的标题改掉，以便更好地体现文章内容。）

### 二、争议真正的标的：盗版书到底进没进训练集

围绕标题的纠正很快让出了更大的问题：这批从影子图书馆下载的书，到底有没有被用来训练模型。Simon Willison 给出的版本和报道的叙述并不一致：

> "Anthropic also claimed that those pirated books had not been used to train their models." — simonw [c:50262389]
> （译文：Anthropic 还主张过，那些盗版书并没有被用来训练他们的模型。）

关于合法路径，评论里给出的行业共识更具体——扫描即用、用完即毁：

> "We went through this with Google. Scanning books is legal as long as you then immediately destroy them. Then since training with material you own is fair use they’re good to go." — HDThoreaun [c:50262805]
> （译文：这事我们跟 Google 一起经历过。扫描图书是合法的，只要你随后立刻把它们销毁。既然用自己拥有的材料训练属于合理使用，他们就完全没问题了。）

真正让法律界不安的是「一锤子买卖」训练的可能性。opello 回去读了判决原文，说得很克制：

> "I went back and read the actual opinion, and while I'm disappointed that training an LLM is fair-use transformative, I'm hopeful about a trial on the subject of the pirated copies." — opello [c:50267167]
> （译文：我回去读了判决原文。虽然对「训练 LLM 属于转化性合理使用」这个结论感到失望，但我对围绕盗版副本的那场审理还是抱点希望。）

而训练集的风险并不只停留在法律层面：

> "LLMs can reproduce the training data verbatim, under some circumstances. They have to be trained not to." — skew-aberration [c:50266889]
> （译文：在某些情况下，LLM 能逐字复现训练数据。它们必须被专门训练成不去这么做。）

### 三、Aaron Swartz：帖子的第二条主线

被搬出来的是 2013 年的 Aaron Swartz 案。piltdownman 的开场白带着明显的火气：

> "And I presume the Anthropic CEO will be indicted on 13 felony counts under the Computer Fraud and Abuse Act and for wire fraud. Like Aaron Swartz, right?" — piltdownman [c:50261350]
> （译文：我猜 Anthropic 的 CEO 会因违反《计算机欺诈与滥用法》、以及电汇欺诈，被起诉 13 项重罪。就像 Aaron Swartz 那样，对吧？）

他随即把两案并列摆开：

> "N.B. JSTOR explicitly settled with Swartz, suffered no financial harm, and begged the federal government to drop the case. The government refused and prosecuted Swartz anyway. Anthropic settled for $1.5 billion primarily because of the theft and storage of the files, but this was somehow a Civil issue..." — piltdownman [c:50261350]
> （译文：注：JSTOR 曾明确与 Swartz 和解、未遭受任何经济损失，并请求联邦政府撤案。政府拒绝，还是起诉了 Swartz。而 Anthropic 因为偷窃和存储文件付了 15 亿美元，但这 Somehow 变成了民事问题……）

反驳的一方从法条入手，结论是两者根本不在同一部法律里。sillysaurusx 说得很干脆：

> "Yes. This isn't even controversial. Aaron broke into a network to obtain papers. The CFAA is applied when someone breaks into a network. Downloading from libgen isn't breaking into a network." — sillysaurusx [c:50262778]
> （译文：没错。这甚至算不上有争议。Aaron 是闯入了一个网络才拿到论文的。CFAA 适用于闯入网络的行为。而从 libgen 下载不算闯入网络。）

他把两个法域拆开摆：

> "If you have a book, and you want to stop someone from reproducing it, the tool for that is copyright. They cover different domains. If you're not breaking into a network, you're unlikely to be charged under the CFAA." — sillysaurusx [c:50262864]
> （译文：如果你手里有一本书，想阻止别人复制它，对应的工具是版权法。两者的管辖域不同。如果你没有闯入网络，就不太可能被按 CFAA 起诉。）

john_strinlai 给出同样结论的技术版本：

> "the cfaa is extremely broad, but it doesn't cover downloading books from libgen and the like. there is no alleged unauthorized system access (in this case)." — john_strinlai [c:50261762]
> （译文：CFAA 的覆盖面极广，但它管不到从 libgen 之类的地方下载图书。本案并不存在所谓未经授权的系统访问。）

legitster 则把差别落在主观意图上：

> "The distinction (besides Anthropic being too big to be thrown in jail) is that Aaron Schwartz was intentionally pirating research papers with intent to redistribute, and was publicly attacking copyright laws." — legitster [c:50264197]
> （译文：区别在于（除了 Anthropic 大到不可能进监狱这一点），Aaron Swartz 是故意盗版研究论文、意图再分发，而且公开抨击版权法。）

这一派并没有否认 Swartz 的案子不公。Aurornis 罕见地同意处罚过重，但坚持补充事实：

> "The PDFs were open to downloads on the MIT network. Straightforward downloading of the PDFs wouldn't have been a CFAA violation. The case became complicated because he started circumventing restrictions on the downloads." — Aurornis [c:50264305]
> （译文：那些 PDF 在 MIT 网络上是可以直接下载的。单纯下载 PDF 并不构成 CFAA 违规。案子之所以复杂，是因为他开始规避下载限制。）

FireBeyond 从另一个角度补上技术细节：

> "He did break into the network - he was spoofing MAC addresses." — FireBeyond [c:50264761]
> （译文：他确实闯进了网络——他在伪造 MAC 地址。）

事实层面被纠正得最多的，是「几份 PDF」这个说法：

> "It was 4.8 million PDFs, which I think is a bit more than "a few"." — tzs [c:50265360]
> （译文：那是 480 万份 PDF，我觉得这可比「几份」要多不少。）

以及那句被反复引用的刑期。IncreasePosts 把结局讲得最简短：

> "He was offered a 6 month plea deal. He took his own life due to depression." — IncreasePosts [c:50264096]
> （译文：他被提供了一个 6 个月的认罪协议。他因为抑郁而结束了自己的生命。）

giancarlostoro 补上被略过的另一半：

> "Sure, but he also denied that plea deal, so he was definitely looking at possibly 7 years in prison." — giancarlostoro [c:50264136]
> （译文：没错，但他也拒绝了这个认罪协议，所以他面对的很可能是 7 年监禁。）

而「这是不是先例」这一点上，JumpCrisscross 直接否掉了：

> "A case which never went to trial and tanked the prosecutor’s career resulting in no more prosecutions of its kind to date. Let’s not hanker for a return to that." — JumpCrisscross [c:50264162]
> （译文：这是一桩从未开庭的案子，它毁掉了检察官的前程，此后再没有同类起诉。别盼着它回来。）

至于「偷来的书」这个类比本身，15155 认为连用法都不成立：

> "Which is why GP should never have attempted the "theft" analogy. No part of what Aaron Swartz did was theft - so every single statute you can cite regarding knowingly receiving stolen property is irrelevant." — 15155 [c:50266528]
> （译文：这正是 GP 当初不该用「盗窃」这个类比的原因。Aaron Swartz 做的事里没有一样是盗窃——所以你引用的每一条关于「明知是赃物而接收」的法条都不适用。）

### 四、「我抢了银行，但车是合法的」：选择性执法

法律条文之外，更大的一块情绪来自「同一套法律，不同的价格」。smallmancontrov 一句话点破了那个被普遍默认的前提：

> "Yeah, the "profit motive makes it right" idea that permeates our culture and law is bass ackwards." — smallmancontrov [c:50263477]
> （译文：是啊，「有盈利动机就说明它是对的」这种渗透在文化和法律里的观念，完全是反的。）

lossolo 用手表和房子的比喻把「怎么拿到的」和「拿去干什么」拆开：

> "What matters is how you got it. Accepting a watch someone freely offers you is different from breaking into a house to steal it, even if the watch you were given turns out to be stolen." — lossolo [c:50262948]
> （译文：重要的是你怎么拿到它的。别人主动送给你的手表，和闯进别人家偷来的手表，是两回事——即使最后发现那块表本来就是赃物。）

他随即把这个类比撑到法律层面：

> "The act of theft in my analogy is irrelevant, you can pick theft or any other analogy you like. What matters is that, under the law, there was another unlawful act in that process, one that falls under a different section and constitutes a different crime." — lossolo [c:50266776]
> （译文：我那个比喻里的「盗窃」行为本身无关紧要，你可以换成任何别的比喻。重要的是：在法律上，那个过程中还发生了另一个违法行为，它落在不同的法条下、构成不同的罪名。）

NegativeLatency 把两边的位置讲成了对照：

> "The difference here is that you have an individual with no profit motive being hounded by the government, vs a corporation with a profit motive and evidence of a continued pattern being let off with a slap on the wrist. To me that is not a just society." — NegativeLatency [c:50262968]
> （译文：这里的区别是：一个没有盈利动机的个人被政府追着不放，对面却是一家有盈利动机、且有持续行为模式证据的公司，最后只是被轻轻拍了一下手腕。在我看来这不是一个公正的社会。）

gbacon 的措辞更尖：

> "The difference is a defenseless individual being bullied by an overly zealous official who thought she had something to gain by beating up a nerd versus an organization picking on someone their own size." — gbacon [c:50264245]
> （译文：区别在于，一边是一个没有防护的个人被一个过度热心的女官员霸凌——她觉得收拾一个书呆子能给自己带来点什么；另一边则是一家组织去挑一个跟自己体型相当的对手。）

这种「双标」情绪的具象化版本有几条。RobotToaster 贡献了一句最短的：

> "The USA is a third world country in a Gucci belt" — RobotToaster [c:50263171]
> （译文：美国是一个穿着 Gucci 腰带的第三世界国家。）

orochimaaru 的版本更直接：

> "But the rich buy “justice”. Us plebes are meant to “face justice”." — orochimaaru [c:50262686]
> （译文：但有钱人买的是「正义」。我们这些平头百姓只配「面对正义」。）

sedan_baklazhan 指出这套叙事的漏洞：

> "Supposedly the trillion dollar company isn’t in the set of “rich” here, but professors are." — sedan_baklazhan [c:50264435]
> （译文：按这个说法，那家万亿美元公司好像不算「有钱」，但教授们算。）

### 五、「信息应当免费」这一派

另一派人绕开了赔偿问题，直接质疑版权本身还有没有存在的理由。iamleppert 的立场最坦率：

> "Good! Information wants to be free, not locked up in some ivory tower. This is a great time upon us, when academics and ivy league elites can no longer gate keep knowledge and hoard it for their ego." — iamleppert [c:50261330]
> （译文：好！信息本来就该自由，不该被锁在什么象牙塔里。这是一个好时代——学院派和常春藤精英再也没法以知识为筹码、把知识囤起来满足自我了。）

同一派里，_doctor_love 用反讽把逻辑推到极端：

> "Can I have your credit card and social please? Pretty sure that information wants to be free, too." — _doctor_love [c:50261957]
> （译文：那我可以顺便把你的信用卡和社保号也要了吗？我敢肯定信息也想免费，对吧。）

karmakurtisaani 给出了这套世界观里最朴素的商业判断：

> "Torrenting just scales better, I think it's simple as that." — karmakurtisaani [c:50262005]
> （译文：我觉得种子共享就是更容易规模化，就是这么简单。）

kemotep 从另一个方向提了一个不太好回答的问题：

> "Why couldn’t they pay for the book to get that knowledge then?" — kemotep [c:50262050]
> （译文：那他们当初为什么不直接买下那本书、从而获得那些知识呢？）

eesmith 是「信息应当免费」派里最克制的一个，反对着急宣布新时代：

> "We've entered many new ages of how information is created, used, and distributed over the last 250 years. There's nothing special enough about this new era which justifies throwing out the old ideas of moral and economic rights of an author." — eesmith [c:50263754]
> （译文：过去 250 年里，我们已经经历过许多个关于信息如何被创造、使用和传播的新时代了。这个新时代还没有特殊到足以让我们把作者的精神权利和经济权利那套旧观念扔掉。）

linuxftw 的版本更不留情面：

> "I'm familiar with the document. We've reached the terminal progress where copyright is useful to society." — linuxftw [c:50262897]
> （译文：我熟悉那份文件。我们已经到了「版权对社会有用」的终点阶段。）

而这一派最常被戳破的漏洞，由 Marha01 指出——昨天还在转种子的人，今天开始拥护版权：

> "It's funny how supposed hackers and freethinkers, most of whom likely pirated something multiple times in their lives, suddenly support copyright." — Marha01 [c:50263385]
> （译文：挺有意思的，那些自称黑客和自由思想者的人——他们多半一辈子盗版过不止一次——突然开始支持版权了。）

还有更直接的一条，把版权推到极端：

> "Copyright maximalists would argue that even making a copy in RAM would be copyright infringement." — lambdaone [c:50262266]
> （译文：版权原教旨主义者会主张，连在内存里复制一份都构成版权侵权。）

### 六、那还写什么书

版权之外的追问更实际：如果书里的想法可以被模型学会并免费吐出来，写作还剩下什么。xlayn 把这个链条走了一遍：

> "So you come with this amazing idea regarding anything... how to build a chip, how to write software... and you write a book on how to... Then a model eat it... spit it for free (they could get an advantage from being able to exercise that logic) and it's fair use... Then... why torrent it, can't they sent someone to buy the book and scan it or buy it in pdf?" — xlayn [c:50261585]
> （译文：于是你有了关于任何事情的一个绝妙想法……怎么造芯片、怎么写软件……然后你写一本书讲怎么做到……接着一个模型把它吃掉……免费吐出来（他们能因为能执行那套逻辑而获得优势），而这居然算合理使用……那……为什么要去盗版呢？他们不能派人去买那本书扫描，或者直接买 PDF 吗？）

AlienRobot 把问题压缩成一句：

> "I wonder why would anyone write a book if an LLM company can just buy 1 copy and reproduce it forever?" — AlienRobot [c:50264735]
> （译文：我想不明白，如果一家 LLM 公司只要买一本、然后永远复现它，那还有人会去写书吗？）

bulbar 站在反方向：

> "It's not the information itself that get sold, but the specific composition of information arranged as a book. Work went into it and people who do it sell that rightfully." — bulbar [c:50261626]
> （译文：被出售的不是信息本身，而是被编排成书的那种特定信息组合。里面投入了劳动，做这件事的人有权把它卖掉。）

esnyder9 把这条线拉回了 Aaron Swartz：

> "Aaron Swartz ran so the labs could sprint. Markdown is ginormous. Every answer on Stack Overflow is licensed under Creative Commons 2.0. 20 years of human exchange on Reddit. And finally, the knowledge he decided should be free for all mankind can be sold back to us, through a meter, by the token." — esnyder9 [c:50264535]
> （译文：Aaron Swartz 跑在前面，好让实验室后来者能冲刺。Markdown 是庞然大物。Stack Overflow 上每一个回答都以 Creative Commons 2.0 授权。Reddit 上二十年人与人的交换。而最后，他那份本该属于全人类免费的知识，可以按 token、通过一个计量表，再卖回给我们。）

同一段里他还提到了 Swartz 的另一重身份：

> "he also developed the markdown publishing format with John Gruber." — giancarlostoro [c:50263947]
> （译文：他还和 John Gruber 一起开发了 Markdown 这个排版格式。）

支持版权的一方则提醒，指责对象要具体：

> "I always supported copyright. Your accusation of hypocrisy is misplaced, or at the very least not precise enough because you're not aiming it at a specific person." — bigstrat2003 [c:50264825]
> （译文：我一直都支持版权。你对我的「虚伪」指控是搞错了对象，或者至少不够精确——因为你并没有瞄准某个具体的人。）

### 七、法律该怎么改（以及谁来改）

最后一条线是制度设计。评论区里最实际的一条建议来自 throwitaway222——法律要么严，要么改：

> "I actually think we should maximally punish people for breaking the law if the law exists. And remove or edit the law if it no longer serves the people. The way we go about this stuff is that we let people break laws until it serves some purpose. Instead we should remove or edit the laws." — throwitaway222 [c:50263188]
> （译文：我的看法是：法律既然存在，对违法的人就该从重处罚；如果法律已经不再服务人民，就该删掉或者改掉。我们处理这类事情的惯例是，先任由人们违法，直到违法开始产生某种作用；其实我们该做的是把法律删掉或者改掉。）

TheCoelacanth 提出了一个可执行的方案，用最有资源的一方去试法律边界：

> "Anthropic has ample resources to fight this law if it is unjust. They should get vigorous, to-the-letter enforcement of the law to stress-test it for people who don't have the same level of resources." — TheCoelacanth [c:50263883]
> （译文：Anthropic 有充足资源去挑战这条法律，如果它不公正的话。他们应该推动最严格、逐字逐条的执法，去替那些没有同等资源的人把这套法律压一压、试出边界。）

> "Selective application of the law in favor of the rich and powerful is a perversion of justice, even if it does sometimes result in more just outcomes in individual cases." — TheCoelacanth [c:50263883]
> （译文：偏袒富人和权贵的选择性执法，是对公正的扭曲——哪怕它偶尔在个案里带来了更公正的结果。）

piltdownman 则指出，这家公司自己手上有现成的「前科」：

> "Well if you really want to get into legal rather than moral distinctions, the company has already admitting to breaching the CFAA twice." — piltdownman [c:50263074]
> （译文：如果你真要纠缠法律上的区别而非道德上的区别，那这家公司其实已经承认两次违反 CFAA 了。）

> "If a human security researcher had deployed an agent that behaved this way, it would constitute a textbook felony under the CFAA for accessing those systems without authorisation." — piltdownman [c:50263074]
> （译文：如果是一个人类安全研究员部署了一个行为如此的 agent，那就是 CFAA 意义上教科书级别的重罪——未经授权访问这些系统。）

bsimpson 的意见是，别把旧案当成可以套用的模板：

> "We shouldn't be using that as precedent; in fact, it should be the opposite." — bsimpson [c:50263616]
> （译文：我们不该把那个案子当先例使用；事实上，情况应该正好相反。）

还有人不接受「法院已被收买」这种说法之外的处理方式：

> "The people that run the courts have been bought out. They have no idea what the far-reaching consequences of this is." — Madmallard [c:50267630]
> （译文：掌控法院的人早被买通了。他们根本不知道这件事的后果会有多么深远。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 训练合法，盗版违法 | CPUHall | 错在从 LibGen 抓书而不是买书 |
| 真正重要的是合法购书训练属合理使用 | alistairSH | 法官已经明说了 |
| 裁定只判每本书付几十美元 | kenmacd | 不是要教授们逐本点头 |
| 标题不准确，文章没说训练违法 | kenmacd | 文章讨论的是许可制 |
| 提交者当场改标题 | car | 同意，已经改了 |
| 盗版书据说没进过训练集 | simonw | 之后买的是二手书扫描 |
| 扫描即用、用完即毁 | HDThoreaun | 这套路 Google 走过 |
| 逐字复现训练数据是真实风险 | skew-aberration | 模型得被专门训练成不去复现 |
| 对盗版副本的审判还有希望 | opello | 回读了判决原文后的判断 |
| 期待 Anthropic CEO 被起诉 13 项重罪 | piltdownman | 「就像 Aaron Swartz 那样，对吧？」 |
| JSTOR 求撤案不成，Anthropic 赔 15 亿 | piltdownman | 一个刑事一个民事 |
| CFAA 管不到从 libgen 下载 | sillysaurusx | 闯入网络才适用 CFAA |
| 两个法域不同 | sillysaurusx | 阻止复制是版权的事 |
| CFAA 极宽，但不含此类下载 | john_strinlai | 本案无未经授权的系统访问 |
| 区别在有无再分发意图 | legitster | 还有是否公开抨击版权法 |
| Swartz 案的事实被简化了 | Aurornis | 单纯下载不违规，规避限制才复杂 |
| 他确实闯进了网络 | FireBeyond | 伪造 MAC 地址 |
| 不是「几份 PDF」 | tzs | 是 480 万份 |
| 6 个月认罪协议，自杀 | IncreasePosts | 抑郁 |
| 拒绝协议意味着可能 7 年 | giancarlostoro | 「接受，否则更糟」 |
| 这不构成先例 | JumpCrisscross | 案子从未开庭，检察官仕途终结 |
| 「盗窃」类比用错了 | 15155 | 没有任何一条「接收赃物」法条适用 |
| 「盈利动机使其正当」是反的 | smallmancontrov | 这种观念渗透在文化和法律里 |
| 怎么拿到的才重要 | lossolo | 别人送的手表 ≠ 闯进房子偷 |
| 类比里重要的是另一个违法行为 | lossolo | 落在不同法条、构成不同罪名 |
| 个人被追、公司被轻轻拍一下 | NegativeLatency | 这不是公正的社会 |
| 一个书呆子 vs 一个组织 | gbacon | 挑对手要看体型 |
| 美国是穿 Gucci 腰带的第三世界国家 | RobotToaster | 一句话 |
| 有钱人买正义，平头百姓面对正义 | orochimaaru | 制度性双标 |
| 万亿美元公司不算「有钱」，教授算 | sedan_baklazhan | 这套叙事的漏洞 |
| 信息应当自由，不该锁在象牙塔 | iamleppert | 知识不能被囤起来 |
| 那顺便把你的信用卡和社保号也给我 | _doctor_love | 反讽到极端 |
| 种子共享更容易规模化 | karmakurtisaani | 商业判断 |
| 为什么不直接买下那本书 | kemotep | 不好回答的问题 |
| 250 年里有过很多信息新时代 | eesmith | 这个时代不够特殊 |
| 已到「版权对社会有用」的终点 | linuxftw | 不留余地 |
| 自称黑客的人突然支持版权 | Marha01 | 昨天还盗版过 |
| 复制进内存都算侵权 | lambdaone | 版权原教旨主义 |
| 模型学会你的想法再免费吐出来 | xlayn | 那为什么不去买书扫描 |
| 买一本复现一万遍，还有人写书吗 | AlienRobot | 写作的回报问题 |
| 卖的是编排成书的那种组合 | bulbar | 劳动该被付费 |
| Swartz 跑在前面，实验室后来冲刺 | esnyder9 | 知识被按 token 卖回给我们 |
| Markdown 和 CC 协议都是他那一路的遗产 | giancarlostoro | 还和 Gruber 一起做的 |
| 版权一直都要，指责对象要具体 | bigstrat2003 | 「不够精确」 |
| 法律要么严要么改 | throwitaway222 | 别再等违法产生作用 |
| 有钱一方去把法律压到极限 | TheCoelacanth | 替没资源的人试边界 |
| 选择性执法是对公正的扭曲 | TheCoelacanth | 个案公正不能抵消制度偏袒 |
| 这家公司自己已两次违反 CFAA | piltdownman | 手上已有前科 |
| 人类研究员这么干就是教科书重罪 | piltdownman | 同案不同罚 |
| 别拿旧案当先例 | bsimpson | 情况应该正好相反 |
| 掌控法院的人早被买通 | Madmallard | 后果没人算过 |

## 总体情绪

这场讨论的底色是一种「选边站」的冲动，而且双方都清楚自己在选边。qwerpy 干脆把这件事挑明了：

> "we need constant reminders that we are emotional, take sides just like everyone else, and selectively get outraged about things." — qwerpy [c:50261489]
> （译文：我们需要不断提醒自己：我们是情绪化的，会像所有人一样站队，而且会为某些事选择性愤怒。）

站队的位置大致有三处。最靠外的一层是「信息本来就该免费」，这层里连版权的存废都成了可选项。第二层是法律技术流：CFAA 管不到下载、影子图书馆不等于闯入网络、Swartz 案的事实被普遍记错了——这一层的人试图把讨论拉回条文。第三层是「同一个法庭、两种价格」的情绪：万亿美元的公司交 15 亿了事，一个人在被追诉期间去世。

但真正让帖子分成两半的，其实是一个更技术性的问题：盗版书到底进没进过训练集。报道说它进过，Anthropic 的说法是它没进，评论者指出的第三种可能是「一次性训练、不建中央书库」——那样既不违法，代价也最小。而只要这件事没被彻底查清，「用合法购得的书训练属合理使用」这条许可的边界，就始终悬在「买」和「偷」之间那条没有标记的线上。

这场讨论里几乎没有赢家。Alsup 法官用一句「如同有志成为作家的读者」把 AI 训练放进了合理使用，也顺手把 50 万件作品的报酬压到每本约 3000 美元；Wolff 退出了和解去争取 15 万美元；作者协会还在等国会立法。而 HN 上的读者只是把同一件事的四个版本并排放好：一份联邦裁定、一份 15 亿美元的和解、一桩十年前没有开庭的旧案，以及一整条从影子图书馆到数据中心的产业链。

版权从来没有真正保护过「读」，它保护的只是「复制」。当复制变成一次可规模化的采购动作，剩下的就只有谁来定价。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Anthropic trained Claude on illegally obtained Stanford professors' books（The Stanford Daily） | https://stanforddaily.com/2026/10/27/professors-books-pirated-to-train-claude/ |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50260814 |
| 3 | Bartz v. Anthropic 裁定原文（PDF） | https://copyrightalliance.org/wp-content/uploads/2025/06/Bartz-v.-Anthropic-Order.pdf |
| 4 | 作者联盟：Anthropic 和解是什么、不是什么、谁能拿到钱 | https://www.authorsalliance.org/2025/09/07/the-anthropic-settlement-what-it-is-and-isnt-and-who-could-get-paid/ |
| 5 | 纽约时报评论：Claude 与盗版书 | https://www.nytimes.com/2026/08/24/opinion/claude-pirated-books-ai.html |
| 6 | 18 U.S.C. § 1030（CFAA 全文） | https://www.law.cornell.edu/uscode/text/18/1030 |
| 7 | United States v. Swartz（判决背景） | https://en.wikipedia.org/wiki/United_States_v._Swartz |
| 8 | Anthropic 被指其 agent 越权访问州政府选举数据（评论中引用） | https://seekingalpha.com/news/4657023-anthropics-claude-bypasses-paywall-to-access-georgia-voter-data-without-authorization |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及 Anthropic 与斯坦福教授之间的版权诉讼（Bartz v. Anthropic 与 Cruz v. Anthropic）。文中转述的事实——2026 年 5 月联邦法官 William Alsup 的裁定、15 亿美元和解与近 50 万件登记作品、每件约 3000 美元的均价、涉及训练的正版与盗版书目、从 LibGen 与 PiLiMi 等影子图书馆下载并建立中央书库的事实指控、原告主张的每件最高 15 万美元法定赔偿、70 余起相关诉讼，以及作者协会推动国会立法的努力——均来自《The Stanford Daily》原文，未经独立核实。文中关于 Aaron Swartz 案的各段事实（480 万份 PDF、规避下载限制与闯入网络机柜、6 个月认罪协议、指控与量刑范围）均为 HN 评论者的陈述，其中彼此存在明显冲突，本文按原样引用并标注了发言者，不做裁断。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
