---
layout: post
title: >-
  iPhone 的「灰名单」：十万条不让补全的短语，打字能打、滑行打不出来 — HN 讨论摘要
date: 2026-11-09
hn_id: 50406111
categories: [articles]
excerpt: >-
  独立研究者 Derik Kauffman 从 iPhone 的系统词典里挖出一份「灰名单」：十万多条短语
  不会出现在预测文本里，打字能打出来，滑行输入却打不出来。评论区真正吵开的不是这份名单，
  而是「少给你一个候选词」和「这是审查」之间的那条线。
tagline: >-
  不是你不小心，是它不让你打出来。
---

> 来源：HN 讨论主帖 [Apple's grey list: Words and phrases your iPhone won't help you spell](https://news.ycombinator.com/item?id=50406111)（484 分，293 条评论），原文是《卫报》关于 iPhone 预测文本「灰名单」的报道。本篇为 cluster 模式，覆盖 3 个讨论帖：主帖 50406111、相关帖 50357782（I dumped Apple's word list，162 分）、相关帖 50394070（Swipeblocked，83 分）。归档快照 2026-11-08 12:54 UTC，入库评论 138 / 101 / 24 条。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

《卫报》11 月 6 日那篇报道的主角，是独立研究者 Derik Kauffman。他先是在自己的 iPhone 上发现，有些短语怎么都拼不出来，有些却毫无障碍，顺着这条线索找到了一张藏在 iOS 里、以编码方式存放的表。这就是所谓的「灰名单」：超过十万个词和短语被排除在预测文本之外。

名单里的内容大致分三类。毒品和性行为相关的词自不必说；还有「iMessage isn't working」这种产品词；剩下的是政治与身份相关的短语，例如「Dictator Trump」「NSA spies」「male chauvinist pig」「Trayvon Martin」。《卫报》还点出，希伯来语版本里被拦下的是「the occupied territories」，阿拉伯语版本里是「the Hamas movement」。研究者把这种做法形容为一种「轻量级的审查」。

Apple 方面的说法是：键盘被设计成不提供不恰当或冒犯性的预测建议，用户仍然可以自己把这些词一个个敲出来，也可以覆盖预测结果。Kauffman 的发现里还藏着更硬的一层——被拦下的短语不只是「不出现」，滑行输入时它会把你已经打对的词改写掉：单独滑「Ireland」没问题，单独滑「United」也没问题，两个连着滑，就变成了「United Iceland」。

这条线索在 HN 上不是一天的热度。相关帖 50357782 是开发者 Helge Sverre 的逆向记录：他从 macOS 的键盘目录里挖出 `~/Library/Keyboard/VulgarWordUsage.db`，发现系统词典里的每个词都带三层标签（vulgar / offensive / sensitive）和最多十一个话题标签（性、毒品、宗教、政治、暴力等），而且没有任何公开 API 可读，只能靠 `Lexicon.framework` 里的私有函数把标志位导出来，他一共导了 15 种语言。相关帖 50394070 则是 swipeblocked.com，直接从键盘自己的数据文件里把这份清单解码出来，截至 iOS 27.0。

## 讨论焦点

### 一、这不是 bug，是定向的

noitpmeder 的定性最直接：

> "This isn&#x27;t a &quot;bug&quot; with the iOS keyboard, this is directed and intentional censorship." — noitpmeder [c:50406452]
> （译文：这不是 iOS 键盘的「bug」，这是有意的、指向明确的审查。）

他另一条评论里的困惑更具体——Apple 到底在防什么：

> "How the hell can they defend banning “Trayvon Martin” of all things. Are they now the arbiters responsible for quashing social movements?" — noitpmeder [c:50406352]
> （译文：他们要怎么解释，连「Trayvon Martin」这种名字都要拦？他们现在是负责平息社会运动的裁判吗？）

tavavex 把这场争论拉回了设计层面：

> "To the shocking number of people here who are justifying this or explaining how it only affect swipe input as if that makes it better: soft coercion is still coercion." — tavavex [c:50406975]
> （译文：这里有大批人在为它辩护，或者在解释「它只影响滑行输入」好像这样就更好一点：软性胁迫也是胁迫。）

把「审查」这个词拆成层次的，是另外两个人。sli 指出 Apple 并不是在执行法律：

> "&quot;Censorship&quot; doesn&#x27;t automatically imply &quot;government censorship.&quot; This is absolutely Apple applying a chilling effect on its customers." — sli [c:50408192]
> （译文：「审查」并不自动等于「政府审查」。这毫无疑问是 Apple 在对自己的用户施加寒蝉效应。）

preg_match 说得更直白：

> "There’s also levels to censorship, like the chilling effect the other commenter noted.<p>Apple, evidently, does not want you to say these things. They can’t outright ban phrases due to optics, so they do this instead." — preg_match [c:50408547]
> （译文：审查是有层级的，比如刚才那位提到的寒蝉效应。显然 Apple 不想让你说这些话。他们出于观感不能直接禁掉这些短语，于是改成这样。）

### 二、另一派：预测器只是不猜高风险词

反方最完整的一条来自 crazygringo：

> "This seems entirely reasonable to me. And to people complaining that this is censorship, it is absolutely <i>not</i>. You can still type these words just fine, it&#x27;s just not going to interpret swipes that are inherently probabilistic and often ambiguous as potentially risky terms." — crazygringo [c:50406649]
> （译文：在我看来这完全合理。对于那些说这是审查的人，它绝对不是。你照样能把这些词打出来，它只是不会去解释那些本质上靠概率、经常带歧义的滑动手势，给出有风险的词。）

scosman 的版本更短：

> "Not predicting to something controversial when doing predictive text isn&#x27;t censorship. You can still type any of these things. When I swing my finger around wildly it&#x27;s making a best guess; not jumping to a phrase that makes me look bad or get arrested (in some countries) isn&#x27;t an awful design choice." — scosman [c:50406663]
> （译文：预测文本不去预测有争议的内容，这不算审查。这些词你照样能打。我甩手指的时候，它只是在做最有根据的猜测；不去补一个可能让我难堪、或者让我在某些国家被抓的短语，不是糟糕的设计。）

这个立场最形象的一个比喻来自 akersten：

> "We&#x27;re not censoring the book. It&#x27;s simply not on the shelves. You can ask for it by name if you like. You have to spell it out exactly though, or else the librarian will deny any knowledge of it." — akersten [c:50406408]
> （译文：我们不是在禁书，只是那本书没上架。你可以点名要它，但你得一个字一个字拼出来，否则图书管理员会假装不知道这本书。）

conradev 提供了另一种解释框架——Apple 只是在两个结果里挑损失更小的那个：

> "Apple is choosing between two outcomes:<p>- There is a chance, quantified by some metric, where a person is suggested a word that is offensive to them or their culture because a probabilistic model made the wrong decision.<p>- There is no chance that the above happens.<p>Apple will choose the latter, time and time again, because they are risk averse and freedom is not particularly high on their values list." — conradev [c:50407427]
> （译文：Apple 是在两个结果里做选择：一是存在一个由某种指标衡量的概率，某个人会因为概率模型判断失误而被推荐一个对他或他的文化而言冒犯的词；二是上面这件事根本不会发生。Apple 会一次次选后者，因为他们风险厌恶，而自由在他们价值清单上的位置并不高。）

otterley 则把它归到公关而不是法律：

> "It&#x27;s not a censorship issue, at least in the USA, because they&#x27;re not afraid of legal pressure from the U.S. government. It&#x27;s a public relations issue." — otterley [c:50407194]
> （译文：这不是审查问题，至少在美国不是，因为他们并不怕来自美国政府的法律压力。这是公关问题。）

不过 Apple 自己的工程解释也不只是公关。Arnt 讲的是这类需求最早出现时的原始诉求：

> "The customer&#x27;s request was: &quot;don&#x27;t make this software produce swear words on its own&quot;. Note: on its own." — Arnt [c:50407353]
> （译文：客户当时的诉求是：「别让这个软件自己冒出来脏话。」注意，是「自己冒出来」。）

kayodelycaon 把这层逻辑补全了：

> "It’s the other way around. Apple don’t want to suggest offensive phases and have it look like they wants you to say those things.<p>The middle ground here is to not suggest anything at all. Because they’re either pushing people to say something or preventing them from saying something." — kayodelycaon [c:50409765]
> （译文：其实是反过来的：Apple 不想建议那些冒犯性的短语，然后看起来像是它想让你说这些话。这里的中间路线就是干脆什么都不建议。因为他们要么是在推着人说某些话，要么是在拦着人不许说某些话。）

连「关掉自动更正就没事了」这种常见反驳也被当场拆掉：krater23 认为这个功能保护的是那些不看提示就直接发送的人。

> "This feature protects people that mindlessly use autocorrect&#x2F;complete from jail, bad discussions with their employer or political correct &#x27;friends&#x27;." — krater23 [c:50406416]
> （译文：这个功能保护的是那些不假思索就用自动更正和自动补全的人，让他们不至于因为一句话被抓、和雇主吵翻、或者在政治正确的「朋友」面前翻车。）

而 howunfortunate 是少数几个承认这事没那么简单的人：

> "As another example, imagine if &quot;trans women are&quot; autosuggested &quot;men&quot; or &quot;ugly&quot; for the next prediction.<p>This would probably be a bad customer experience for many people, even if Apple could prove these are simply the most common n-gram completions." — howunfortunate [c:50408066]
> （译文：再举一个例子：假如「trans women are」后面自动补成「men」或者「ugly」，那对很多人来说会是糟糕的产品体验——哪怕 Apple 能证明这只是最常见的 n-gram 补全。）

ryandrake 的反驳正好对着这一点：

> "What I don&#x27;t understand is how you can type something that is close enough to “Male chauvinist pig” that an uncensored autocorrect will guess it, without intending to type “Male chauvinist pig”. That phrase and others like it, even if one or two letters are wrong or swiped through incorrectly, is unambiguous." — ryandrake [c:50408046]
> （译文：我不明白的是：一个未经审查的自动更正如果能猜出「Male chauvinist pig」这种词，那它几乎不可能不是你的本意——否则它连蒙对都蒙不到。这种短语以及同类短语，哪怕你有一两个字母打错、滑错了，也不会有歧义。）

noah_buddy 给出的解法则是把过滤表整个扔掉：

> "The answer seems obvious to me: train a user’s predictive swipe engine on solely their own messages. It gives them an easy out on controversy while removing the need for a filter list." — noah_buddy [c:50407047]
> （译文：答案对我来说很明显：只用用户自己的消息去训练他的滑行预测引擎。这样既能在争议上给自己留个台阶，又不需要任何过滤表。）

### 三、实测：它真的会改写你写下的词

争论走到实测环节，事实开始压过立场。最关键的一组观察来自 user_7832：

> "I&#x27;m not sure you get what&#x27;s exactly happening. It&#x27;s not <i>only</i> not predicting, it&#x27;s also &quot;typing something else&quot;.<p>Swipe &quot;Ireland&quot; alone, works. &quot;United&quot; alone, works.<p><i>Same</i> swipes but back to back, and now it&#x27;s suddenly &quot;United Iceland&quot;.<p>There&#x27;s no predictive text involved here, this starts going into the willful territory." — user_7832 [c:50407507]
> （译文：我不确定你有没有搞清楚这里到底发生了什么。它不只是「不预测」，它还会「替你打别的字」。单独滑「Ireland」没问题，单独滑「United」也没问题。同一套滑动手势连着来，它就突然变成「United Iceland」了。这里已经和预测文本无关了，这开始进入「故意」的范畴。）

pj1115 把这套行为量化成了可复现的数字：

> "The problem is not accuracy -- the words from the problem phrases are never suggested either. Worse, on the three-word phrases, iOS goes back and changes earlier words to avoid completing the phrase, and removes the original from the suggestions.<p>I tried typing &quot;propaganda&quot; ten times with 100% accuracy. When it&#x27;s preceded with &quot;[left] wing&quot;, the accuracy drops to 0%." — pj1115 [c:50408667]
> （译文：问题不在准确率——这些短语里的词本身也从来不会被推荐。更糟的是，遇到三词短语，iOS 会回头改掉前面的词来避免补全这个词组，并且把原来的词从候选里删掉。我把「propaganda」一字不差地输了十次，只要前面是「[left] wing」，命中率就掉到 0%。）

barrell 重复了同一个测试，结论更冷：

> "Tried this myself. Got 10&#x2F;10 on propaganda, 0&#x2F;10 on left wing propaganda, 10&#x2F;10 on right wring propaganda.<p>I think that’s a bigger issue regardless of your political stance." — barrell [c:50411708]
> （译文：我自己试了：单独打「propaganda」十次全中，「left wing propaganda」十次零中，「right wring propaganda」十次全中。我觉得不管站哪边，这问题都更大。）

而 aucisson_masque 的复现说明这不是概率问题：

> "I swipe United, it gets it right the first time.<p>I swipe Ireland, it gets it right the first time.<p>I swipe “united ireland” a hundred times, it never work.<p>It’s not probability." — aucisson_masque [c:50408858]
> （译文：我滑 United，一次就对。我滑 Ireland，一次也对。我把「united ireland」连着滑一百次，没有一次对。这不是概率问题。）

在 swipeblocked 那个讨论帖里，作者自己演示的改写被读者一眼抓住：

> "WTF, it changes words after you already typed it and moved on?<p>That&#x27;s worse than the HN title of merely just not suggesting the phrase, that is some 1984 going on." — rationalist [c:50397681] [thread 3]
> （译文：什么情况，它在你已经打完并翻过去之后还改词？这比帖子里那个「只是不给你建议」的标题严重多了，这有点 1984 的味道。）

同一批人里还有另一份实测清单，来自 operator-name：

> "This isn’t limited to swipe, they don’t auto-suggest either. Some of the phrases in the full world list are really innocent too:<p>- are some important<p>- fish finger(s)<p>- he’s hot<p>- is the worst<p>- sneak peak<p>- thank god<p>- you suck" — operator-name [c:50398458] [thread 3]
> （译文：这不光限于滑行，自动补全也一样。完整词表里还有些相当无害的短语：are some important、fish finger(s)、he's hot、is the worst、sneak peak、thank god、you suck。）

顺序错乱也能说明问题。AnotherGoodName 贴了一段被键盘改坏的句子，还自带签名行：

> "The hilariops think is that the phome with the mosy terrible keytoard wants to add a tagline to every eamail which can only be read as am apology.<p>- Sent from my iPhone." — AnotherGoodName [c:50408677]
> （译文：搞笑的是，那个拿着最烂键盘的机修想给每封邮件加一句只能读作道歉的附言。——发自我的 iPhone。）

（这段原文的拼写错误由 iPhone 自己造成，此处照录。）

而 Jtarii 的建议是最直接的产品诉求：

> "Then have &quot;child friendly mode&quot; be an option and the adults can have &quot;fuck&quot; back. This isn&#x27;t a difficult design problem." — Jtarii [c:50406792]
> （译文：那就把「儿童模式」做成一个可选项，让成年人还能打出「fuck」。这不是什么困难的设计问题。）

### 四、词表本身在哪儿：VulgarWordUsage.db 与 Lexicon.framework

要判断这份名单到底有多硬，得看它是怎么实现的。相关帖 50357782 的记录最完整：开发者 Helge Sverre 找到了 `~/Library/Keyboard/VulgarWordUsage.db`，里面按应用、按聊天对象记录你用过的脏词；更关键的是上游——系统词典里每个词都带三层标签（vulgar、offensive、sensitive）和最多十一个话题标签（性、毒品、宗教、政治、暴力等），而这些标签没有任何公开 API 能读，作者是靠 `Lexicon.framework` 里的私有函数 `_LXEntryGetCategoryFlags`、`_LXEntryGetMetaFlags` 导出来的。

watwut 一句话点出了这份表的功能定位：

> "But ... the point of that vulgar words list is to STOP autocorrecting them when it detects intentional use." — watwut [c:50358199] [thread 2]
> （译文：但是……这个脏词表的用途，是在你「故意」用它的时候，别让自动更正把它改掉。）

标签的具体内容也在评论里被逐条核对。n2d4 说，Trump 被标的是 sensitive 而不是 offensive，同一档的还有「God」「Jews」「gun」。

> "Trump is marked as sensitive, not offensive; along with words like &quot;God&quot;, &quot;Jews&quot;, and &quot;gun&quot;" — n2d4 [c:50358255] [thread 2]
> （译文：Trump 被标为 sensitive，不是 offensive；同一批里还有「God」「Jews」「gun」这样的词。）

ixtli 注意到的是一份名单的不对称：

> "Incredible that &#x27;conservatards&#x27; is in there but not &#x27;libtard&#x27;. I thought the right was always being censored!" — ixtli [c:50358168] [thread 2]
> （译文：难以想象「conservatards」在里面而「libtard」不在。我一直以为被审查的总是右派！）

他后来又补了一句更实在的观察：

> "I commented this here for this precise reason. `Libtard` is definitely a word people on the internet use but the other one ive literally never seen before. Someone went out of their way to add one and not the other." — ixtli [c:50358800] [thread 2]
> （译文：我正是因为这个原因在这里留言的。「Libtard」肯定是网上有人在用的词，而另一个我连听都没听过。一定是有人特意加了一个、没加另一个。）

flanz_10 认为这根本不是一份人工名单：

> "It&#x27;s not a list, it&#x27;s a series of ML classifications. Basically, you&#x27;ve got &quot;child mode&quot; locked on. The solution is to not use a UK apple id." — flanz_10 [c:50358229] [thread 2]
> （译文：这不是一份名单，这是一系列机器学习分类结果。基本上，你等于把「儿童模式」锁死了。解决办法是别用英国的 Apple ID。）

对中文读者来说，最值得留意的一组数字来自 nonethewiser：

> "There is a lot more interesting stuff to mine from this.<p>The phrase blocklist for the Chinese lanaguge is a lot larger (surprise, surprise). It about 281 KB for Simplified Chinese, 325 KB for Traditional and 160 KB for Cantonese, against 28 KB for English." — nonethewiser [c:50358336] [thread 2]
> （译文：这里还有更多值得挖的东西。中文的短语屏蔽表要大得多（惊不惊喜）：简体中文约 281 KB，繁体中文 325 KB，粤语 160 KB，而英文只有 28 KB。）

英文 28 KB，简体中文 281 KB——差着一个数量级。同样被列进敏感档的还有一批政治词，而这只是那位作者 dump 出来的一个语言分支。

jooize 的经历是这份词表落到个人身上的样子：

> "How do I make iOS let me swipe “fucking” everywhere? fucking<p>fucking fucking fucking!! After typing it manually two or three times it then swipe completes in this particular text field in this app." — jooize [c:50358344] [thread 2]
> （译文：怎么才能让 iOS 让我到处都能滑出「fucking」？fucking，fucking fucking fucking！！我手动打上两三次之后，它在这个 app 的这个输入框里就能滑出来了。）

freehorse 则解释了为什么 Trump 会落在 sensitive 档：

> "&gt; Would anyone be offended by the text “don’t forget to bring your Trump to band practice”?<p>Trump could be offended. It is obviously there to avoid offending Trump.<p>And it is not considered &quot;offensive&quot; but &quot;sensitive&quot;." — freehorse [c:50358615] [thread 2]
> （译文：「谁会因为『别忘了把你的 Trump 带到乐队排练』这句话被冒犯到？」——Trump 本人可能被冒犯。显然放进去是为了避免冒犯到他。而且它不算 offensive，只算 sensitive。）

至于词表本身有多离谱，hugodan 用一个词概括了：

> "If you find something funnier than Oedipus, I want to hear about it." — hugodan [c:50358216] [thread 2]
> （译文：如果你能找出比「Oedipus」更好笑的东西，我想听听。）

（原文的亮点清单里，Oedipus 被标成了 vulgar。）

### 五、比名单更大的那件事：iOS 键盘本身

最后评论区还拐进了一个更大的话题：al_borland、jonplackett、shmoobadge 骂的其实不是灰名单，而是 iOS 键盘本身。al_borland 的对比跨了十九年：

> "I still think the original iPhone keyboard in 2007 was better than what we have now. It’s been downhill ever since iOS 7.<p>I used to tell people just type and trust it to work, it was great. Now, even when I type the right thing, the auto-complete will screw it up after the fact. I feel like I need to proofread everything." — al_borland [c:50408663]
> （译文：我还是觉得 2007 年初代 iPhone 的键盘比现在好，从 iOS 7 之后一直在走下坡路。以前我会跟人说，直接打、信任它就行，那会儿真的很好用。现在即使你打对了，自动补全也会在后面把词改掉。我感觉我得把每条消息都校对一遍。）

jonplackett 的测试更有说服力，因为他换了台老机器做对照：

> "For some reason for me typing now feels like walking on ice. Sure sometimes it successfully corrects a mistyped word - but it so often changes a correct word to an incorrect one that I think I’m worse off overall.<p>I picked up my old iPhone 7 last week and typing on iOS16 on that MUCH smaller screen somehow feels MORE accurate.<p>Something’s gone seriously wrong with predictive text." — jonplackett [c:50399452] [thread 3]
> （译文：不知为什么，现在对我来说打字像在冰面上走路。它当然偶尔能成功纠正一个打错的词，但它太常把本来正确的词改成错的了，我觉得整体上我比以前更差。上周我翻出了旧的 iPhone 7，在小得多的屏幕上用 iOS 16 打字，感觉反而更准。预测文本一定出了什么严重的问题。）

shmoobadge 干脆放弃了滑行：

> "I gave up using swipe typing after the Nth time it changed a word 10 words back just as I pressed send." — shmoobadge [c:50396760] [thread 3]
> （译文：在我第 N 次遇到「就在我按下发送的瞬间，它把十个词之前的那个词改了」之后，我就放弃滑行输入了。）

busymom0 提到 iOS 27 刚出 beta 时键盘其实还不错：

> "When the first iOS 27 beta came out, it was actually really good for me. But later betas and now the public release ruined it once again. It&#x27;s unbelievable how bad it is." — busymom0 [c:50358914] [thread 2]
> （译文：iOS 27 第一个 beta 出来的时候，对我来说其实相当不错。但后来的 beta、还有现在的正式版又把它毁了。烂得难以置信。）

verytrivial 把同一套抱怨搬到了 Mac 上：

> "I have a MacBook that was meant to replace my aging Windows and Linux laptops. This article is a microcosm of why I have just stopped using it." — verytrivial [c:50358123] [thread 2]
> （译文：我买这台 MacBook 本来是为了替换掉我那台老旧的 Windows 和 Linux 笔记本。这篇文章就是我不再用它的原因的一个缩影。）

bbarn 的总结把键盘、语音助手和界面锁成了一张网：

> "I&#x27;d argue iPhone got ahead of the game then just stopped getting at all better.  Siri AI is straight garbage, they won&#x27;t let the interface be anything but what they want it to be" — bbarn [c:50409153]
> （译文：我倒觉得 iPhone 曾经走在前面，之后就再也不进步了。Siri 的 AI 完全是垃圾，他们不会让界面变成除了他们想要的样子以外的任何东西。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 不是 bug，是定向审查 | noitpmeder | iOS 键盘的「bug」说法站不住 |
| 软性胁迫也是胁迫 | tavavex | 只影响滑行输入不能开脱 |
| 审查不等于政府审查 | sli | 这是 Apple 在制造寒蝉效应 |
| 不能明着禁就换个方式禁 | preg_match | 观感所迫，只能悄悄来 |
| 这只是不猜高风险词 | crazygringo | 打出来完全没问题 |
| 不做预测就不算审查 | scosman | 补全本来就是在猜 |
| 相当于那本书没上架 | akersten | 点名要得自己一个字一个字拼 |
| Apple 只是挑了损失小的那边 | conradev | 风险厌恶，自由排位不高 |
| 这是公关问题不是法律问题 | otterley | 在美国他们不怕政府 |
| 原始诉求只是「别自己冒脏话」 | Arnt | 关键词是「自己」 |
| 不给建议是折中方案 | kayodelycaon | 建议了就像 Apple 在让你说 |
| 保护了不看提示直接发的人 | krater23 | 免得被请进局子 |
| 这事没那么简单 | howunfortunate | n-gram 补全更伤人 |
| 滑行不只是不猜，还会改写 | user_7832 | United Ireland 变 United Iceland |
| 命中率从 10/10 掉到 0/10 | pj1115 | 前缀一变就失准 |
| 复测确认不是概率问题 | barrell | 不管站哪边结论都一样 |
| 词表是 ML 分类不是人工名单 | flanz_10 | 相当于把儿童模式锁死 |
| 中文词表比英文大一个量级 | nonethewiser | 281 KB 对 28 KB |
| 敏感档里有 Trump 和 gun | n2d4 | 同一档还有 God、Jews |
| 键盘从 2007 年起就在退步 | al_borland | 现在什么都要校对 |
| 键盘比名单更值得骂 | bbarn | Siri 和界面都由不得你 |

## 总体情绪

这帖的分层很清楚：原文给出的是一份名单和一种行为——不给你提示，还顺手把你打对的词改掉；评论区则把它拆成三个互相独立的争论。Apple 有没有资格决定哪些词能被打出来？noitpmeder、tavavex、sli、preg_match 认定它没有。预测文本该不该做这件事？crazygringo、scosman、akersten、conradev、otterley 认为可以，但不该藏起来。这份名单到底是怎么实现的？技术帖给出了答案：词典标志位加私有 API，没有公开接口，也没有用户能改的地方。

最有意思的地方在于两边都没让步，而且各自的证据都成立。反对方拿出的是可复现的实测：十次全中变十次零中，同一套手势连着滑就变成「United Iceland」；支持方拿出的是产品逻辑：只要不让系统替你说出那些话，风险就被挡在发送之前。于是一边在说「软性胁迫也是胁迫」，另一边在说「这不是审查，这是帮你避免尴尬」，两边说的甚至不是同一件事。

真正没人提出、也没人反驳的，是那个最简单的版本：这份名单不公开、不能改、也不会告诉你为什么收录了某个词。反对方嫌它藏得深，支持方说那本就没上架——两边默认了同一件事：只要 Apple 愿意，它随时可以在你打字之前，先替这个世界把一句话删掉。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Apple's grey list: Words and phrases your iPhone won't help you spell（HN 主帖） | <https://news.ycombinator.com/item?id=50406111> |
| 2 | 原文：Struggling to spell 'male chauvinist pig'? Apple's grey list means your iPhone won't help you spell（卫报） | <https://www.theguardian.com/technology/2026/nov/06/struggling-to-spell-male-chauvinist-pig-apple-grey-list-means-your-iphone-wont-help-you> |
| 3 | Reuters：Apple's predictive text restrictions include 'Dictator Trump' and 'Sleepy Joe' | <https://www.reuters.com/business/retail-consumer/apples-predictive-text-restrictions-include-dictator-trump-sleepy-joe-researcher-2026-11-06/> |
| 4 | I dumped Apple's word list（HN 相关帖 2） | <https://news.ycombinator.com/item?id=50357782> |
| 5 | 原文：macOS vulgar word flags（Helge Sverre） | <https://helgesver.re/articles/macos-vulgar-word-flags> |
| 6 | Swipeblocked: The phrases your iPhone won't suggest（HN 相关帖 3） | <https://news.ycombinator.com/item?id=50394070> |
| 7 | Swipeblocked（站点） | <https://swipeblocked.com/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 484 分、293 条评论，归档快照 2026-11-08 12:54 UTC，入库 138 条；相关帖 50357782 入库 101 条；相关帖 50394070 入库 24 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于屏蔽词条数量、中文与英文词表体积对比、词表标签层级的说法，均来自原文与归档评论引述，本站未做独立复现。

⚠ 本篇讨论涉及 Apple 预测文本对政治与身份相关短语的系统性过滤，引用了 HN 用户关于这份名单是否构成审查的争论，文中保留了相关表述的原貌，供读者自行判断。本站不对文中引用的任何第三方说法背书，Apple 的产品策略以官方说明为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
