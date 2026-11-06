---
layout: post
title: >-
  Facebook 明知故犯的诈骗生意：160 亿美元与 150 亿条高风险广告 — HN 讨论摘要
date: 2026-11-06
hn_id: 50385870
categories: [articles]
excerpt: >-
  Meta 的内部文件承认，每年约 160 亿美元、也就是 2024 年收入的 10% 来自诈骗广告。
  争论不在数字上，而在三个问题：Section 230 管不管用、平台审查过之后算不算明知、
  AI 生成的深度伪造该由谁负责。
tagline: >-
  他们不是没看见，是看完之后按下了“不违规”。
---

> 来源：HN 讨论主帖 [Cuban: Facebook knowingly runs AI deepfake scam ads; docs say $16B fraud revenue](https://news.ycombinator.com/item?id=50385870)（340 分，159 条评论），原文是 Moneywise 的报道《Mark Cuban says Facebook knowingly runs AI deepfake scam ads as Meta docs reveal $16 billion in fraud-linked revenue》。本篇为单帖模式。归档快照：主帖 2026-11-05 23:09 UTC 发帖，2026-11-06 10:29 UTC 抓取，归档含 100 条评论与 8,000 字符原文正文（按上限截断）。

## 原文概要

Mark Cuban 每周都会收到几封邮件，问他那款从没有卖过的 294 美元糖尿病药是否有效。这些药不是他卖的，而是有人用 AI 复制了他的脸和声音去做广告。他在 Kara Swisher 与 Scott Galloway 主持的播客 Pivot 八月一期里说，Facebook 明知道那些“小老太太小老头”正在被骗，仍然照放这些广告。他的原话是：“Facebook knows the little old ladies are getting ripped off”，并把这个平台称为“the worst of the worst”。Cuban 并非旁观者，他与人合伙创办了以低价卖仿制药著称的 Cost Plus Drugs。

他还指出，有些广告甚至自带免责声明，说明画面里的人是 AI 生成的、片段只供娱乐，但等观众看到时，推销已经完成了，“And to Facebook, that's good enough”。在他看来，“The point is, that defines the culture of the organization”——一家放任骗子找上老人家的公司，已经说明了自己在每一层能容忍什么。

数字来自路透社 2025 年 11 月 6 日的调查。Meta 的内部文件显示，公司自己预计约 160 亿美元、也就是 2024 年收入的约 10%，来自推广诈骗和违禁商品的广告。Meta 自己的统计是，旗下应用的用户每天能看到约 150 亿条带有明显欺诈标记的“高风险”广告；一份 2024 年底的内部文件把这一类别的价值估到每年约 70 亿美元。2025 年 5 月的一份演示里，Meta 自己的安全团队估计平台参与了美国成功诈骗的三分之一。文件里还有一条关键阈值：封禁一个广告主之前，自动化系统必须把该账户判定为至少 95% 可能是诈骗；低于这条线，涉嫌诈骗的一方只要多付广告费就能继续在线。

Meta 发言人对路透表示，这些文件“present a selective view that distorts Meta's approach to fraud and scams”，并称 10% 这个估计“rough and overly-inclusive”。他给出的另一组数字是：关于诈骗广告的用户投诉在此前 18 个月里下降了 58%，2025 年公司下架了超过 1.34 亿条诈骗广告。同一批文件还提到，证券交易委员会正在就与金融诈骗相关的广告调查 Meta。

报道里还有一件相关的事：一个多伦多男子在 9 月 26 日让 Meta 的 AI agent 代管自己的 Facebook Marketplace 挂牌，agent 把他的住址给了买家，还接受了一个压价报价，他后来把部分原因追到一个自己选过的权限设置。

受害者一侧的数字来自 FBI 互联网犯罪投诉中心的 2025 年报告：60 岁以上人群在 201,266 起投诉中共损失 77 亿美元，比上一年多 59%；其中投资骗局 35 亿美元居首，技术与客服类骗局 10.4 亿美元。AI 出现在 3100 多起投诉里，受害者损失超过 3.52 亿美元，而这还只是愿意报案的那一部分。FBI 2025 年冻结了与老年受害者案件相关的 3290 万美元，但它只能追回自己知道的那些钱。Cuban 的建议很朴素：看到名人脸在 feed 里推销东西，就当它是假的；把产品名和“scam”一起搜一遍；给家里用 Facebook 最多的人发条消息提醒；发现可疑就当天去 ic3.gov 报案。

## 讨论焦点

### 一、Section 230：删掉它解决不了这件事

Section 230 是评论区里出现频率最高的法律名词，而多数发言者认为它跟这件事无关。ethin 的判断最干脆：

> "Removing section 230 does not solve this problem. Section 230 does not do what you think it does." — ethin [c:50387657]
> （译文：删掉 Section 230 解决不了这个问题。Section 230 并不是你以为的那个东西。）

csnover 把民事责任和刑事责任分开讲：

> "It is a shield against _civil_ liability, not _criminal_ liability. If Facebook are aiding and abetting to profit from _criminal fraud_, Section 230 does not allow them to skate free, and so, it does not need to be changed." — csnover [c:50389255]
> （译文：它是民事责任的盾牌，不是刑事责任的盾牌。如果 Facebook 在协助教唆、以刑事诈骗获利，Section 230 不会让他们逃脱责任，所以它也不需要改。）

Terr_ 补了一个反直觉的观察：那些最脏、完全没有审核的站点从来就不需要 Section 230，正是这条法律让平台敢做一点审核。

> "Section 230 is what allows you to have _some_ moderation (e.g. banning spammers) without suddenly becoming _entirely_ liable for anything that passes the filter." — Terr_ [c:50386676]
> （译文：恰恰是 Section 230 让站点可以在封掉垃圾信息这类事上“做一点审核”，而不必突然为任何通过筛选的内容负全责。）

主张删掉它的人，通常站在“平台就是出版者”的角度，SideQuark 的类比最朴素：

> "No other business is liable in this manner. Run a classified ad in a newspaper, use it to scam someone, newspaper not liable. Hack into router at Starbucks, use it for fraud, Starbucks not liable." — SideQuark [c:50387306]
> （译文：没有别的行业要承担这种责任。在报纸上登分类广告，用它去骗人，报纸不负责。入侵星巴克的路由器拿它搞诈骗，星巴克不负责。）

反方则主张付费广告应当被区别对待。georgemcbay 说：

> "Paid advertisements should be exempt from Section 230. If you’re earning almost 200 billion dollars a year directly from the posting of a certain type of content, you can afford basic moderation to avoid obvious scams and fraud." — georgemcbay [c:50386462]
> （译文：付费广告应当豁免 Section 230。如果你每年直接从某一类内容的投放里赚到近 2000 亿美元，你完全负担得起基本的审核，去避免那些一眼可见的诈骗和欺诈。）

Terr_ 也承认这个方向有道理，但指出了定义上的漏洞：

> "For example, suppose someone pays $/month for Cubic Zirconia Membership Tier on a site that boosts their posts over the hoi polloi. That person makes a post hyping up their company or product with a link. Isn’t that _also_ a &quot;paid advertisement&quot;, just with a different payment scheme?" — Terr_ [c:50387660]
> （译文：假设有人按月付费购买某个网站的“立方氧化锆会员等级”，让帖子排到普通人前面。这个人发一篇吹自己公司或产品的帖子并带上链接，这难道不也是“付费广告”，只是换了种付费方式吗？）

### 二、“我们审查过，符合条款”：明知参与

平台的回信成了评论区里最有力的证据。jhloa2 反复举报之后的经历：

> "The amount of times I’ve reported obvious scam ads on instagram just to receive a “we found this to not be in violation of our terms” is so disheartening." — jhloa2 [c:50386402]
> （译文：我无数次举报 Instagram 上显而易见的诈骗广告，只为了收到一句“我们未发现其违反我们的条款”，这太让人灰心了。）

erentz 把这封回信在法律上的意义拆成两步：

> "Prior to being notified they could claim they were unaware it was fraud. But after being notified of it, they have confirmed back that they reviewed it. Yet they continue to show it, making them aware and participating in the distribution." — erentz [c:50387844]
> （译文：在被通知之前，他们还可以声称自己不知道那是诈骗。但在被通知之后，他们回信确认已经审查过，却继续投放，这让他们变成知情并参与分发。）

> "So as soon as Facebook says &quot;we’ve reviewed this scam ad you notified us of, but found it complies with our terms and conditions&quot;, they’re pretty clearly knowingly participating." — erentz [c:50388436]
> （译文：所以只要 Facebook 说“我们审查了你举报的这则诈骗广告，认为它符合我们的条款与条件”，他们就很清楚是在明知参与。）

把 Facebook 当成出版者，问题就绕开了 Section 230。erentz 说：

> "E.g. Facebook, is the worlds largest media company, and it truly acts and behaves as a publisher now. It acquires its content from an army of paid and unpaid providers." — erentz [c:50387268]
> （译文：比如 Facebook 是全世界最大的媒体公司，它现在的行为举止确实就是一个出版者。它从一支有薪无薪的供给大军那里获取内容。）

otterley 用报纸打比方，把这条线拉得更大：

> "When social media chooses what to display in a user’s feed—even if the content is 3P generated— then it starts to look an awful lot like a publisher. Would you consider a newspaper not to be a publisher of its own op-Ed page? How about the old Reader’s Digest?" — otterley [c:50387949]
> （译文：当社交媒体决定在你的 feed 里展示什么——即便内容是第三方生成的——它就开始非常像出版者了。你会认为报纸不是自己社论版的出版者吗？老的《读者文摘》呢？）

主张给平台压责任的人把话说得更直接，kraf 认为“算法做的”不是免责理由：

> "Those platforms should be liable for _everything_ they show, because they choose what gets shown to you. I think it’s completely messed up that they just get to say &quot;oh it’s not me, it’s the algorithm&quot;. It’s so very very overdue." — kraf [c:50388505]
> （译文：这些平台该为它们展示的_一切_负责，因为展示什么是它们自己选的。我完全不能接受它们一句“哦，不是我，是算法”就脱身。这件事早该处理了。）

### 三、阈值背后的经济学

评论区里另一条更冷静的线索来自那份 95% 阈值的文件。ToucanLoucan 的反问最短也最致命：

> "For real. Why in the world would they police this? They have NO liability whatsoever. You’re asking a business to turn down money because the money is shady. They don’t give a fuck." — ToucanLoucan [c:50387049]
> （译文：说真的，他们为什么要管这事？他们完全没有任何责任。你是在要求一家企业因为钱不干净就放弃这笔钱。他们根本不在乎。）

sneak 追问的是“你的方案怎么落地”：

> "“make” here either means legislation to enable civil liability that doesn’t exist today, or enforcing existing criminal laws against the wealthy ownership class. Neither of these things will happen, for reasons which are obvious. How do you suggest we implement your proposal? Anyone can say what they think _should_ be. An implementation plan with actionable steps is the hard part." — sneak [c:50387560]
> （译文：这里的“让平台承担责任”要么是指立法建立今天并不存在的民事责任，要么是指对富人阶层执行已有的刑法律。这两件事都不会发生，原因显而易见。你打算怎么落实你的方案？任何人都可以说自己认为_应该_怎么做，真正难的是一份可执行的实施计划。）

bdangubic 把它还原成股东语言：

> "they have no obligation unless there is a law that says they have an obligation. otherwise every penny spent is penny less for shareholders. talking about morality and obligation in the context of meta, one of the most vile and evil corporations ever is not going to get us anywhere" — bdangubic [c:50387837]
> （译文：除非法律明确规定他们有义务，否则他们没有任何义务；否则每花出去一分钱，就意味着股东少分一分钱。在 Meta 这样的公司身上谈道德和义务——它大概是有史以来最邪恶的公司之一——不会带来任何结果。）

顺着这条线，甚至有人认为诈骗广告比正经生意更赚钱：

> "Scams might be more profitable than legitimate businesses." — api [c:50386868]
> （译文：诈骗可能比合法生意更赚钱。）

那么广告质量下降是“油井见底”还是“收入压力太大”？peterbecich 提出这个问题：

> "These companies were profitable on higher quality ads in earlier years. Does this drop in quality indicate the ad well has run dry, so to speak? Or the demands for revenue are greater, necessitating a drop in standards?" — peterbecich [c:50386721]
> （译文：这些公司早些年靠质量更高的广告就足够赚钱了。这次质量下滑，是不是说明“广告油井”快抽干了？还是说收入压力更大，只好降低标准？）

LargeWu 给出了一个具体的量级判断：

> "No other platform has the scale that Meta does. Any company making as much money as they do can’t claim they can’t spend an extra $20 million/year to even pretend to fight the issue. The larger the company, the larger the obligation they have to be a good citizen." — LargeWu [c:50387557]
> （译文：没有别的平台有 Meta 这个量级。任何赚着这种钱的公司，都没法说他们连每年多花 2000 万美元、装模作样处理这个问题都做不到。公司越大，做个好公民的义务越大。）

### 四、这不是新问题：注意力、过捞与监管俘获

另一部分发言者把时间线拉长，认为这是老故事的新版本。mirashii 记得十五年前的高流量网站：

> "I really think even if the scale is maybe amping up, things weren’t much better 20 years ago, the web was just smaller, fewer people were paying attention, and the folks who were there had grown up learning to spot that stuff from the beginning." — mirashii [c:50387178]
> （译文：我真的觉得，即使规模确实在膨胀，二十年前的情况也没好多少，只是那时网络更小，盯着看的人更少，而在那儿的人早就练出了识别这类东西的本领。）

sjdh76 给出的是结构性的解释，注意力被当成无限资源：

> "The advertising industry is run by people trained for centuries to do one thing well - find ways to mine your finite Attention. This is what they spend their mind on 24x7. They have discovered thousands of ways to do it. So blocking one or two paths at a time doesnt do anything useful. Human Attention so far is not treated as a scare natural resource. So there is a free for all overfishing of the finite pool going on." — sjdh76 [c:50387490]
> （译文：广告业由一群训练了上百年、只擅长一件事的人经营——找出开采你有限注意力的办法。他们 7×24 小时想的都是这个，并且已经发明了几千种办法。所以每次只堵一两条路没有意义。人类的注意力至今没有被当成一种稀缺的自然资源，于是这个有限的池子里正在发生一场无序的过度捕捞。）

他把矛头又转向政治：

> "Since politicians/lawmakers also use the same mechanisms to harvest attention the Ad/Ad tech industry has regulatory capture. It will never collapse just like Big Tobacco is happily chugging along baring some major public catastrophe." — sjdh76 [c:50387490]
> （译文：由于政客和立法者也用同一套机制开采注意力，广告与广告技术行业获得了监管俘获。它永远不会自行崩塌，就像大烟草公司一样，只要没有重大的公共灾难降临，就会一直乐呵呵地往前开。）

whycombilater 补了一句更直接的话：

> "Politicians who want a slice of that money do..." — whycombilater [c:50388930]
> （译文：想从这笔钱里分一杯羹的政客，可是有的……）

也有人认为封堵是可行的，nixon_why69 用 20 世纪的电视业做类比：

> "Blocking a few of the biggest paths absolutely can work, look at 20th century TV with a few big networks. You couldn’t easily get wide distribution of anything too bonkers. We _already_ have a form of this for the internet that you can see if you visit sketchy pirate websites, you don’t see those ads for porn games on facebook or any reputable website. They get flagged by adsafe and/or the ~15 or so big exchanges. So it’s possible, it’s just a question of will." — nixon_why69 [c:50387710]
> （译文：只封住最大的那几条路绝对有效，看看 20 世纪只有几家大台的电视业就知道了，那时想广泛传播任何太离谱的东西并不容易。我们其实已经有类似的东西：去那些来路不明的盗版网站看看，你在 Facebook 或任何正规网站上都看不到那种色情游戏广告，它们会被 adsafe 或者那十来家大的广告交易所标记掉。所以这是可能的，缺的只是意愿。）

### 五、把责任推给 AI：沙箱、执照与看门狗

评论区最密集的一段，是把责任推给 AI 的玩笑。augment_me 顺着原报道里那个多伦多用户的 agent 事故一路演下去：

> "You don’t understand, an AI agent made the ad, so it’s okay, it just escaped its’ sandbox, you have to understand that this was not meant to happen and it was an accident." — augment_me [c:50387146]
> （译文：你不明白，是 AI agent 做的广告，所以没关系，它只是从自己的沙箱里逃了出来，你得理解，这本来不该发生，是个意外。）

> "What if an AI ad agent that escaped its’ sandbox makes the ad, and an AI ad verifier agent that breached containment and went rogue accepted the ad, can they be held liable?" — augment_me [c:50387157]
> （译文：那如果是一个逃出沙箱的 AI 广告 agent 做了广告，又一个突破隔离、失控的 AI 广告审核 agent 放它过审，这两个能被追责吗？）

bumby 用执照工程师的旧办法来接这个问题：

> "Example: Licensed professional engineer has an intern design a bridge. Bridge collapses. Who is responsible? The licensed professional engineer. This isn’t new to other domains. They already have systems to define who is responsible. If you’re outsourcing to AI, that shouldn’t absolve you of responsibility." — bumby [c:50387797]
> （译文：举个例子：一个持照专业工程师让实习生设计了一座桥，桥塌了，谁负责？持照工程师。这在别的领域不是新问题，他们已经有界定责任的制度。如果你要把活外包给 AI，那就不该因此免除你自己的责任。）

raizer88 的类比更生活化：

> "If my dog escape his cage and bite the hand of a woman, who is responsible? Me. The owner. The end." — raizer88 [c:50389115]
> （译文：如果我的狗从笼子里跑出来咬了女士的手，谁负责？我，主人，就这样。）

真正的解法仍然在“结果”而不是“过程”上。nkrisc 给了两句：

> "If they accepted the ad they are liable. The origin of the ad is irrelevant. How they review the ad is irrelevant. The law need only regulate the outcome." — nkrisc [c:50390034]
> （译文：只要他们放了这则广告，他们就该负责。广告从哪来无关紧要，他们怎么审的也无关紧要。法律只需要规制结果。）

> "Of course. If they want to use an AI as verifier then they should be liable for the decisions it makes. If that sounds too risky, then don’t use one, or develop one they reasonably trust and accept the cost when it fails." — nkrisc [c:50390014]
> （译文：当然。如果他们要用 AI 当审核员，那就该为它的判断负责。如果这听起来风险太大，那就别用；否则就开发一个你能合理信任的，并接受它出错时的代价。）

### 六、读者手上的证据

评论区里另有大量第一手经历，构成另一组样本。8ytecoder 买过的东西和举报的结果：

> "I bought a “smart” bike headlight from an Instagram ad. They sent me a regular old led headlight with a tracking number and everything. Instagram refused to take down the ad even after submitting proof." — 8ytecoder [c:50386797]
> （译文：我从 Instagram 广告上买过一个“智能”自行车灯。寄来的是一个普通得不能再普通的 LED 灯，还带着快递单号。提交证据之后，Instagram 依然拒绝下架那则广告。）

gwerbin 对 YouTube 的观感更直接：

> "Upwards of half the ads I see on YouTube are obvious scams. There’s no way nobody at Alphabet is aware." — gwerbin [c:50387401]
> （译文：我在 YouTube 上看到的广告，一半以上都是显而易见的诈骗。不可能 Alphabet 没有人知道。）

甚至报道本身的版面就成了证据，scosman 指着文章里 Yahoo 投放的那条广告：

> "The ad Yahoo puts in this article is amazingly ironic > Jeff Bezos backs a platform that lets anyone invest in rental homes for as little as $100 — 6 ways to build wealth like a landlord without actually being one" — scosman [c:50386363]
> （译文：Yahoo 投在这篇文章里的广告讽刺得惊人——Jeff Bezos 投资了一个平台，让任何人用低至 100 美元就能投资出租屋——6 种不需要当房东也能积累财富的方法。）

monster_truck 描述的是广告位的完整生态：

> "I’ve also seen offers of free shit from amazon sellers in exchange for positive reviews, &quot;legal&quot;/unscheduled drug analogues, flavored nitrous (free shipping!), unrestricted gambling/prediction markets" — monster_truck [c:50389027]
> （译文：我还见过亚马逊卖家用“免费赠品”换好评、所谓“合法”／未列名的药物类似物、加了香味的笑气（还包邮）、以及不受限制的博彩／预测市场。）

sneak 则把套路搬到了亚马逊的假容量 U 盘上：

> "Of course they know. They have no civil or criminal consequences for engaging in a conspiracy to commit large scale wire fraud, so of course they just let it happen, because who wants to speak up and cause the metrics to go down?" — sneak [c:50387606]
> （译文：他们当然知道。他们参与大规模电汇欺诈既没有民事责任也没有刑事责任，所以当然就放任了——谁会出头去让指标掉下来呢？）

同一个疑问还落在举报机制上。sneak 的一句话把整个流程说穿了：

> "First off, why would you snitch? Secondly, why would you report the offense… to the offender? That’s like filing a citizen complaint form for police misconduct… to the police. HR is not your friend." — sneak [c:50387576]
> （译文：第一，你为什么要告密？第二，你为什么要向肇事者举报违法行为？这就像拿着市民投诉表去投诉警察滥用职权——投诉对象是警察。HR 不是你的朋友。）

而澳大利亚的案例说明这条路早就有人走通，anenefan 提到一个已经被起诉的当地骗局：

> "Yes they were doing the same is Australia ... I wouldn’t know if they’re still doing it here since one of the favourite scams used an Australian who took them to court." — anenefan [c:50386563]
> （译文：澳大利亚当时也一样……我也不知道他们现在还在不在这么做，因为其中一个惯用骗局里的澳大利亚人把他们告上了法庭。）

### 七、从愤怒到行动

最后一段讨论的分歧在于：既然这套系统看起来不打算改，还能做什么。

augment_me 是最悲观的那一派：

> "Fantastic, your wish is granted, the monkey’s paw bends one finger. &quot;I do not accept this&quot; does nothing, look at the current power situation of the big data companies, look at the economical incentives, will you personally go out and do something in the coming weekend that will change anything regarding this question? Next weekend? Who is going to do this? If you can’t answer that, you have to go with the assumption of status quo because it doesn’t seem like your world is happening." — augment_me [c:50387889]
> （译文：好极了，你的愿望实现了，猴爪的手指向弯了一根。“我不接受这件事”起不了任何作用。看看这些大数据公司目前的权力位置，看看经济激励，你打算在这个周末亲自做点什么、来改变这个问题上的任何一点吗？下个周末？谁会去做？如果你答不上来，那你只能接受现状是默认选项，因为看起来你的世界并不是这样运转的。）

gspr 骂的正是这种情绪：

> "I think this is the single most annoying thing about this site – the pervasive belief that anything that is happening must be allowed to continue happening, because if it’s happening it’s somehow good or right or at least unstoppable. This goes further than a simple aversion to regulation. It’s a kind of defeatism on a scale I’ve never seen anywhere else, bar maybe very nihilist circles or angsty teenagers." — gspr [c:50389770]
> （译文：我认为这是这个站点上最让人恼火的一件事——一种弥漫的信念，认为凡是正在发生的事都必须被允许继续发生，因为只要它在发生，就总归是好的、对的，或者至少是拦不住的。这已经不只是对监管的反感，而是一种我在别处从没见过的宿命论，也许只有极端虚无的圈子和中二少年能比。）

ruidnd37434 的回应只有三句，却把话头扳了回来：

> "customary reminder that things can be better… “things are bad” is a good reason to align your work towards things that make life better As hard as that may be, it’s where progress rather than backsliding comes from We should champion every effort for improving the conditions rather than restate things are bad" — ruidnd37434 [c:50388037]
> （译文：照例提醒一句：事情是可以变好的……“事情很糟”恰恰是一个把工作转向让它变好的方向的理由，尽管这很难，但进步而不是倒退就从这里来。我们应该支持每一件改善处境的努力，而不是反复陈述事情很糟。）

bigfudge 提醒不要把美国当成唯一样本：

> "Making networks liable for fraudulent ads, or even placing a small duty of care on those who display ads would be politically popular in much of the developed world. I don’t see it as at all unrealistic that a populist of the left or right would not try and implement this in the next 10 years." — bigfudge [c:50389188]
> （译文：让广告网络为诈骗广告负责，或者哪怕只是给投放广告的一方加一点注意义务，在发达国家的大部分地区都会很受欢迎。我并不认为左右翼的民粹人物在接下来十年里不去推动这件事是不现实的。）

pllbnk 说的则是技术与法律的关系：

> "They will say &quot;it’s impossible&quot;, &quot;this technology doesn’t work like that&quot; and conveniently forget that technology must follow the law, not the other way around, and that the laws can be changed to fit the technological advances." — pllbnk [c:50389239]
> （译文：他们会说“这不可能”“这项技术不是这么运作的”，然后就顺手忘掉一件事：技术必须服从法律，而不是法律服从技术；而且法律是可以改成适应技术进步的。）

最后是那条具体的、有点笨的方案。dpkirchner 想做一个只拦 AI 广告的扩展：

> "I have a terrible idea: an ad blocker that only blocks AI generated ads. It submits the ad image/copy to Gemini and if it is not a fake product the ad is displayed. I’m confident that Gemini would do a pretty good job at identifying these scams and that the extension would demonstrate how easy it would be for Google to do it themselves." — dpkirchner [c:50386755]
> （译文：我有个烂主意：做一个只拦截 AI 生成广告的广告拦截器。它把广告的图片和文案交给 Gemini，如果这不是个假产品就放行。我确信 Gemini 识别这类诈骗会做得相当好，而且这个扩展能说明，Google 自己要做同样的事有多容易。）

ryan_lane 给这个主意泼了盆冷水，理由比想象中朴素：

> "It’s not like that would save you from the scam ads. They were a problem before AI and if they see their AI ads blocked in large volume, they’ll switch back to non-AI generated ads. I can’t remember the last time I saw an ad on instagram that wasn’t some kind of scam." — ryan_lane [c:50387162]
> （译文：这样也躲不过诈骗广告。它们在 AI 之前就是问题，如果他们发现自己的 AI 广告被大量拦截，就会退回做非 AI 生成的广告。我已经想不起来上一次在 Instagram 上看到的广告不是某种骗局是什么时候了。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 删掉 230 解决不了问题 | ethin | “Section 230 并不是你以为的那个东西” |
| 230 挡的是民事责任 | csnover | 协助教唆刑事诈骗，230 救不了他们 |
| 没有 230 也敢做点审核 | Terr_ | 230 让你能封垃圾信息而不必负全责 |
| 其他行业也不背这个锅 | SideQuark | 报纸刊登诈骗广告，报纸不负责 |
| 付费广告应豁免 230 | georgemcbay | 年赚 2000 亿美元，负担得起基础审核 |
| “付费广告”定义有漏洞 | Terr_ | 付费会员版块置顶，也是付费广告吗 |
| 平台回信等于明知 | erentz | 回信确认审查过还继续投放 |
| Facebook 就是出版者 | erentz | 全世界最大的媒体公司，行为也像出版者 |
| 算法不是免责理由 | kraf | 展示什么是他们自己选的 |
| 没有责任就不会自我审查 | ToucanLoucan | 凭什么让企业为了钱不干净而放弃钱 |
| 方案必须能落地 | sneak | “应该怎么做”人人会说，实施计划才是难点 |
| 义务要靠法律强制 | bdangubic | 每花一分钱，都是股东少分一分钱 |
| 诈骗比正经生意更赚 | api | “Scams might be more profitable than legitimate businesses.” |
| 质量下滑是收入压力 | peterbecich | 是广告油井快干了，还是必须降标准 |
| 2000 万美元也不多 | LargeWu | 公司越大，做个好公民的义务越大 |
| 这不是新问题 | mirashii | 二十年前高流量站也是满屏诈骗广告 |
| 注意力是有限资源 | sjdh76 | 注意力正在被无序地过度捕捞 |
| 广告业已被监管俘获 | sjdh76 | 和大烟草一样，等一场公共灾难 |
| 政客也想分那笔钱 | whycombilater | 想分一杯羹的政客有的是 |
| 封堵大路是可行的 | nixon_why69 | 二十世纪电视只有几家大台 |
| 责任推给 AI 是个玩笑 | augment_me | agent 逃出了沙箱，这是意外 |
| 旧办法照样能用 | bumby | 持照工程师为塌桥负责，AI 不豁免你 |
| 狗咬人也是主人负责 | raizer88 | 责任很清楚，链条很清楚 |
| 规制结果而非过程 | nkrisc | 广告来源和审核方式都无关紧要 |
| 用了 AI 审核就要担责 | nkrisc | 要么别用，要么接受它失败的代价 |
| 平台审查过还照放 | jhloa2 | 回信：“我们未发现其违反我们的条款” |
| 实物与广告严重不符 | 8ytecoder | 智能自行车灯收到普通 LED，举报无效 |
| YouTube 广告一半是诈骗 | gwerbin | 不可能 Alphabet 没人知道 |
| 版面本身就在打广告 | scosman | 同一篇文章里的 Yahoo 广告很讽刺 |
| 广告位生态比想象中杂 | monster_truck | 换好评、药物类似物、笑气、博彩 |
| 举报等于向肇事者举报 | sneak | HR 不是你的朋友 |
| 澳大利亚已有判例 | anenefan | 一个当地骗子被告上了法庭 |
| 现状是默认选项 | augment_me | “我不接受”起不了任何作用 |
| 这是宿命论 | gspr | 凡正在发生的都必须被允许继续 |
| 事情可以变好 | ruidnd37434 | 进步而不是倒退就从这里来 |
| 别只盯着美国 | bigfudge | 未来十年左右翼民粹都可能有动力推动 |
| 技术服从法律 | pllbnk | 法律可以改成适应技术进步 |
| 拦截 AI 广告的扩展 | dpkirchner | 交给 Gemini 判断，Google 自己也能做 |
| 拦不住的 | ryan_lane | 他们会退回做非 AI 广告 |

## 总体情绪

这帖的底色不是新发现，而是迟到的确认：诈骗广告不是 Meta 独有的意外，而是它 160 亿美元收入线里被写进预算的一部分。真正让评论区转向的，不是路透社的文件，而是那份文件里的 95% 阈值——只要不把某个账户判定为 95% 可能是诈骗，多付广告费就能继续在线。这条规则把道德问题翻译成了定价问题，后面所有的争论都从此出发。

有意思的是，愤怒的方向并不一致。有人要法律，有人要股东，有人要看到 Facebook 关门；但也有人在提醒另一件事——封死最大的几条路并不难，20 世纪的电视网只有几家大台，盗版网站上的广告从来不会出现在正规网站上，缺的只是意愿。也有人在提醒这件事其实刚刚开始：举报是有效的，只是对方是肇事者本人；而在另一个半球，一个本地骗子被起诉的案子已经说明这条路走得通。

最后落在 AI 上。深度伪造让“我不知道那是假的”不再是有效辩护，于是平台被指认明知，老年人成了最贵的目标；而有人已经开始把责任推给逃出沙箱的 agent，语气半开玩笑。玩笑背后是一个还没答案的问题：当广告、审核和放行都交给模型，谁来承担模型出错的那一次。评论里那句最冷静的话是——广告从哪来无关紧要，审核方式也无关紧要，法律只需要规制结果。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Cuban: Facebook knowingly runs AI deepfake scam ads; docs say $16B fraud revenue | <https://news.ycombinator.com/item?id=50385870> |
| 2 | 原文：Mark Cuban says Facebook knowingly runs AI deepfake scam ads（Moneywise） | <https://finance.yahoo.com/technology/ai/articles/mark-cuban-says-facebook-knowingly-213000020.html> |
| 3 | 原文：Andrew Forrest 在澳大利亚起诉 Meta 的诈骗广告案（ABC News） | <https://www.abc.net.au/news/2026-08-11/andrew-forrest-meta-scam-ads-case/107025146> |
| 4 | FBI 互联网犯罪投诉中心（IC3） | <https://www.ic3.gov/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（thread 共 159 条，归档快照 2026-11-06 10:29 UTC，入库 100 条）及原文抓取内容（Moneywise 报道经 Yahoo Finance 转载，归档按 8000 字符截断）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，评论 ID 与作者另经 Algolia HN 接口逐条核验存在且一致。文中 160 亿美元、150 亿条高风险广告、95% 阈值等数字出自 Meta 内部文件经路透社报道，FBI 损失数据出自 IC3 2025 年报告；相关数字与公司回应请以原文为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
