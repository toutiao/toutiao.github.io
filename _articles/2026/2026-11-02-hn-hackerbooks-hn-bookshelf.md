---
layout: post
title: >-
  把 HN 二十年提过的书摆成一个书架 — HN 讨论摘要
date: 2026-11-02
hn_id: 50326821
categories: [articles]
excerpt: >-
  535 位 HN 用户在评论里提到过《我的奋斗》，真正推荐它的只有 15 位。
  一个由 Claude 从零搭出来的书架站点，把「被提到」和「被推荐」之间的裂缝
  完整地摆在了首页上。
tagline: >-
  全站最热的一本《我的奋斗》，推荐人数：15。
---

> 来源：HN 讨论帖，提交者 roansh。帖子：[Show HN: HackerBooks – HackerTube, but for books mentioned on HN](https://news.ycombinator.com/item?id=50326821)，409 分，114 条评论（抓取时快照）。站点：[hackerbooks.org](https://hackerbooks.org)。站内数据取自 hackerbooks.org 的公开数据文件（meta / topics / books / trends，2026-11-02 读取，数据生成日期 2026-11-01）。

## 原文概要

起因很直接。前一天 Andrej Karpathy 刚把 HN 评论里被推荐的视频做成了一个 YouTube 式的站点 HackerTube，roansh 看完就想：那书呢？于是一个叫 HackerBooks 的站出现了。帖子发在 2026-11-01，抓取时已经 409 分、114 条评论。

作者在帖子里把话说得很清楚：Claude 写了几乎全部的东西，包括数据管线和站点本身，他负责掌舵、做决策、买域名。站点自己的 about 页把五步管线写成了清单。第一步是拿 HN 全量的 item 和 comment dump；第二步用正则和轻量 NLP 抽种子——带引号的书名、「by 作者」、Amazon / Goodreads / Open Library 链接、ISBN；第三步把候选匹配到 Open Library 的作品条目，拿到稳定 ID、作者、首版年份、封面和主题标签；第四步是全语料回扫，把每个已解析的书名在整个语料里再搜一遍，所以没人贴链接的书也能被数到；第五步只用小模型处理歧义书名，比如 Dune、Influence、Range 这类。

真正麻烦的是「提到」不等于「推荐」。站点于是给每一条提及打立场标签：recommend、neutral、critical、not-about-the-book，标注模型是 Claude Sonnet 5.5，抽查 400 条跟 Opus 5.5 比对，一致率 85%。更简单的方案——关键词规则、情感打分、TF-IDF 分类器——都先试过，准确性更差。于是站上摆着两个数：Recommended by 是推荐过这本书的不同人数，mentioned by 是提到过的不同人数，提到但其实在说同名电影、游戏或别的作品的提及会被丢掉。

规模比预想的大。站点自己的 meta 数据是 15,362 本书、270,334 次提及、217,954 条评论、来自 56,456 位不同评论者，覆盖 2007 到 2026 年，其中 147,823 次提及被判为推荐。29 个主题里，文学与小说 3,331 本，政治与社会 2,149，其他 1,817，历史 1,520，商业与管理 1,316，心理学与行为 1,275，经济与金融 1,131，数学 1,001，编程只有 872，生物与医学 866，科幻 860。前端是原生 JS 加静态 JSON 放在 Cloudflare：首屏拉约 30KB 的头部书单索引，1.6 万本完整列表在后台加载，文件名带 hash 所以可以永久缓存，封面存在 R2；数据管线是 Python 加 duckdb 直接跑 HN dump，站点也导出 CSV。

上线当天就被抓住了硬伤。首页 Top all-time 里《我的奋斗》被标成「recommended by 651 HNers」；「Vanity Fair」被归给萨克雷，而大量评论其实在说那本杂志；Other 类里混进了 Angry Birds、Breaking Bad 这类游戏和剧集，还出现了一条「Harry Potter and the Sorcerer's Stone by John Williams」。作者当天一个一个改：措辞从 recommended 改成 mentioned by，Vanity Fair 只算真正提到 Thackeray 的评论，筛选器的过滤条件从「最近一次提及」换成「第一次被提及」。

## 讨论焦点

### 一、「提到过」和「推荐过」被混为一谈，而这个差别就是整个站点的命门

最早发现问题的人说得很客气：

> "I like the idea, but the wording might need to change as to how it counts a recommendation." — drayfield [c:50327129]
> （译文：我喜欢这个想法，但措辞可能需要改一改，讲清楚它是怎么算「推荐」的。）

他当时的观感是《我的奋斗》被「651 位 HN 用户推荐」——一个让人不太舒服的数字。作者当天就认了：

> "Noted, pushing a fix for the wording for now. Will also look into improving the recommendations." — roansh [c:50327270]
> （译文：收到，先把措辞改掉；也会再改进推荐算法。）

他改完的版本把标签换成了 mentioned by。换成今天站上的数据，《我的奋斗》被 535 位不同的人提到过，真正推荐过的只有 15 位。同一份数据里，《阿特拉斯耸耸肩》有 758 人提到、207 人推荐；而《人性的弱点》以 579 位推荐者排在推荐榜第一，《计算机程序设计艺术》则是 1,125 人提到、336 人推荐。榜单从「谁被提得多」换成「谁被推荐得多」，次序就整个翻了过来。

问题被说得更直接：

> "If you’re using claude to build the whole thing and gather and parse the data, how on earth are you unable to get it to filter out the noise and show recommendations?" — danso [c:50327726]
> （译文：如果你用 Claude 从头把这个东西连数据采集和解析一起做了，那你到底怎么会搞不定过滤噪声、给出真正的推荐？）

分类噪声也确实是肉眼可见的：

> "apparently angry birds is a book? and it's more popular than the new testament in the "other" category." — notatoad [c:50327899]
> （译文：原来 Angry Birds 是一本书？它在「其他」这一类里比《新约》还热门。）

> "The "Other" category has a whole load of random stuff in it, including TV series like Breaking, and music like Thriller or Master of Puppets. There's also some wonky attribution in places, like "Harry Potter and the Sorcerer's Stone by John Williams"" — entuno [c:50328103]
> （译文：「其他」这一类里塞着一大堆乱七八糟的东西，包括《绝命毒师》这类剧集，还有《Thriller》《Master of Puppets》这类音乐作品。有些作者归属也不太对，比如出现了「Harry Potter and the Sorcerer's Stone by John Williams」。）

数据里也留着这种痕迹：站点收录的《New Testament》只有 64 次提及、59 位提到者、4 位推荐者，主题标签却是 productivity 和 philosophy。

### 二、整个站点是 Claude 写的，而这成了评论区的主要话题

第一条踩线的评论来自对 AI 文风过敏的人：

> "The site is really fast. I see HTTP/3, OpenGraph, and Cloudflare. Can you expand on the technologies used? Also... "Each book links back to the comments that mentioned it." > Please don't put generated text in HN posts. Claude speak gives me a gag reflex these days." — jchook [c:50327092]
> （译文：这站真快，我看到 HTTP/3、OpenGraph 和 Cloudflare。能展开讲讲用了什么技术吗？另外……「每本书都链回提到它的那几条评论。」> 请不要在 HN 帖子里放生成式文本。Claude 那套腔调让我看到就反胃。）

作者没有辩解，直接认了：

> "Thanks! First version was clunky, and hot-linked all cover images. Right now its plain JS and static JSON files, hosted on Cloudflare. First load pulls a ~30kb index of the top books, the full 16k list loads in the background, and everything has hashed filenames so it's cached forever. Covers are on R2. The data pipeline is python + duckdb over the HN dump." — roansh [c:50327179]
> （译文：谢谢！第一版很笨重，而且直接热链了封面图片。现在是纯 JS 加静态 JSON，放在 Cloudflare 上。首屏拉约 30KB 的头部书单索引，1.6 万本的完整列表在后台加载，所有文件都带哈希文件名，所以可以永久缓存。封面在 R2 上。数据管线是 Python 加 duckdb，跑在 HN 的 dump 上。）

> "And fair on the post, I had claude draft it and only edited it a couple of times. Should have just written it myself." — roansh [c:50327179]
> （译文：帖子的事也公平地说一句，是我让 Claude 起草的，我只改了两三次。本来该自己写的。）

连界面都被一眼认出：

> "This is the stock claude UI" — Starlevel004 [c:50327538]
> （译文：这就是 Claude 的标准 UI。）

> "honestly claude did the frontend, my instruction was "make it feel like hackertube, but for books"." — roansh [c:50327550]
> （译文：老实说前端是 Claude 做的，我的指令就是「做成像 hackertube，但换成书」。）

调侃顺着这条线一路跑偏：有人说 Claude 的 token 用完了、Cursor 把他切到了 Grok，而 Grok 极力推荐《我的奋斗》；有人接话说，几天后就知道了，标题是不是要改成《我的奋斗》；还有人顺手补了一句，帖子文案是 Claude 起草的，Claude 有史以来最擅长的就是写这一段。

而这套工具在别处被认真对待：

> "Opus 5.5 is an order of magnitude better at design and design nuances than GPT 6.1 Sol, surprisingly. If there is a design that LLMs do that you don't like, tell it that. You're allowed to be picky." — minimaxir [c:50328038]
> （译文：出人意料的是，Opus 5.5 在设计和设计细节上比 GPT 6.1 Sol 强一个数量级。如果 LLM 做出的某个设计你不喜欢，就告诉它。你完全可以挑剔。）

### 三、评论区把这个站当成需求单，作者当天就改

站点上线不到两小时，第一批 bug 报告就来了：

> "The “mentions since” picker appears to be broken, nothing in the list changes as far as I can see. Also I wish it wouldn’t add another page to my history." — vigilantpuma [c:50327103]
> （译文：「mentions since」那个选择器看起来坏了，反正我看列表里什么都没变。另外我希望它别再往我的浏览历史里塞一页。）

作者的诊断很具体：过滤用的是「最近一次被提及的时间」，而热门书几乎总是最近被提过，所以筛选等于没筛。

> "Good catch, thanks! The filter was using a book's most recent mention on HN, which is pretty much always recent for popular books, thats why nothing changed? It now filters by when a book was first mentioned instead. and filters shouldn't add to history anymore." — roansh [c:50327303]
> （译文：抓得好，谢谢！过滤器用的是一本书在 HN 上最近一次被提及的时间，而热门书这个值几乎总是很近，所以筛了等于没筛。现在改成按第一次被提及的时间来筛，筛选器也不该再写进历史记录。）

翻页也坏了：

> "If this is the bug-reporting subthread: "Show more comments" stops working after clicking it once." — peri-cl [c:50327204]
> （译文：如果这里是报 bug 的分支：「显示更多评论」点一次之后就失灵了。）

> "It only keeps 30 comments per book so the second click was the last one :) pushed a minor fix, will look into adding all comments later" — roansh [c:50327314]
> （译文：每本书只保留 30 条评论，所以第二次点的时候就已经是最后一条了 :) 推了个小修复，之后再考虑把全部评论都加上。）

最夸张的一次是曲线图。有人问，能不能画点图，看看书是怎么涨上去、待一阵、又退下去：

> "I don't know if this is in  there, but I wonder if books have a kind of 'eb and flood', where books raise to the top, stay there a while, then go away again. Could you plot some graphs? I'd expect some alrounders to stay around in the background forever, and other books come and go according to the average HN trending mood" — hyperman1 [c:50327370]
> （译文：我不知道站里有没有这个功能，但我好奇书是不是也有一种涨潮和退潮：升到顶部，待一阵，然后又下去。能不能画几张图？我猜有些常青书会永远在背景里待着，另一些则跟着 HN 的整体情绪潮起潮落。）

这条评论发于 16:57:30，作者 17:05:06 就贴出了结果：

> "Love this idea, building a trends page now." — roansh [c:50327456]
> （译文：这个想法我喜欢，正在建一个趋势页。）

> "Built it - https://hackerbooks.org/#/trends" — roansh [c:50327456]
> （译文：建好了——https://hackerbooks.org/#/trends）

提问者的反应是：

> "I wonder if you've built it faster than I wrote that post." — hyperman1 [c:50327668]
> （译文：不知道你建好它是不是比我写完那条帖子还快。）

作者归属错乱也当天修了：有人指出有些书挂错了作者，读一下页面里链出的那条评论就能看出正确的作者是谁——他举的例子是一本《Rainbow's End》，Open Library 上这个条目被另一本同名书污染，作者栏挂着的是 H. Thipperudra Swamy。作者于是加了一个「建议修正」的入口；Vanity Fair 那个把萨克雷和杂志混在一起的问题，作者改成只统计真正提到 Thackeray 的评论。

### 四、常青书和一波流：HN 的口味其实有清晰的年表

站点的 trends 数据把这个问题回答了。取每年被提及最多的那一本书，19 年的第一名依次是：2008 和 2009 年是 Jessica Livingston 的 Founders at Work（2008 年它占了当年全部书提及的 1.65%），2010 年是《计算机程序设计艺术》，2011 到 2013 年是《精益创业》，2014 年是《哥德尔、艾舍尔、巴赫》，2015 和 2016 年又是《计算机程序设计艺术》，2017 年是《深度工作》，2018 年《哥德尔、艾舍尔、巴赫》回榜，2019 年《我们为什么要睡觉》，2020 年《思考，快与慢》，2021 年《雪崩》，2022 年《数据密集型应用系统设计》，2023 年《计算机程序设计艺术》，2024 年《雪崩》，2025 年《计算机程序设计艺术》，2026 年至今则是 Sarah Wynn-Williams 的 Careless People。

常青书和一浪书的差别，在站点的「最近提及占比」这个指标上更直白：Careless People 2025 年才第一次被提到，这个比例是 1.0，也就是它的全部提及都发生在最近窗口；而 2008、2009 两年连庄的 Founders at Work，这个比例只剩 0.05。《计算机程序设计艺术》是 0.43，《雪崩》0.61，《数据密集型应用系统设计》0.72。

但榜单之外，用户对「推荐」这件事本身并不买账：

> "Not a fan of "For you" based on supposed similarities to what I've clicked before. Especially when e.g. "Scratch Programming Playground" has nothing to do with "Brave New World"." — pndy [c:50327553]
> （译文：不太喜欢那个基于「我点过什么」的相似度做的「为你推荐」。比如「Scratch 编程 playground」跟《美丽新世界》明明毫无关系。）

### 五、这个想法不新，但历史上每一个版本都没活下来

先到的质疑是「早有人做过了」：

> "This was done already, back in 2021!" — MYEUHD [c:50327283]
> （译文：2021 年就有人做过了！）

翻出来的前作确实存在——2021 年的那个 HN 帖子，链接就在评论里。更让人在意的是评论区里关于「活不过多久」的集体记忆：

> "I remember there were multiple such websites before being shared in HN. I bookmarked them, and a couple years later when I finally wanted to find a book, the only thing I got is 404. I hope this one lives longer." — 361994752 [c:50328127]
> （译文：我记得在 HN 上分享过好几个这样的站。我把它们都收藏了，两年后真想找本书的时候，拿到的只有 404。希望这个能活得久一点。）

> "HackerTube is 404 and 503ing, so it might not last a day." — genxy [c:50328222]
> （译文：HackerTube 现在 404 和 503，所以这个可能一天都活不下去。）

> "Pleading guilty" — thibaut_barrere [c:50328244]
> （译文：坦白从宽。）

> "I planned to revive it later, but life got in the way" — thibaut_barrere [c:50328244]
> （译文：我本来打算以后把它复活，但生活把事岔开了。）

而人本身的收藏习惯也是问题的一部分：

> "Funny, I bookmark interesting things all the time on here. I had this bookmarked. I've never revisited it." — jjordan [c:50327774]
> （译文：我老是在这儿收藏有意思的东西。这个我收藏过，但我一次都没回去看过。）

结论因此变得很直接：既然每一个前作都会死，那就自己 vibe 一个。

> "They're all just vibecoded, so whenever you need one just spend an hour doing it yourself I guess" — micromacrofoot [c:50328549]
> （译文：反正它们都是 vibe 出来的，哪天你真需要一个，就自己花一小时做一个呗。）

> "This is why way. I vibe coded my own for personal use when the one I used went down." — joebates [c:50328640]
> （译文：这就是原因啊。我用的那个站挂掉之后，我自己 vibe 了一个自用的。）

类似的活法其实早有人在做：

> "Nice. I did something similar ranking the top 100 software/tool request of HN since 2008." — bilater [c:50327238]
> （译文：不错。我做过类似的东西，把 HN 从 2008 年到现在请求过的前 100 个软件和工具排了个榜。）

### 六、几乎每个人都要一个自己的版本

需求清单在评论区迅速膨胀：

> "I want this but for podcasts. I pick a podcast I subscribe to say the Tim Ferris show and I see book mentions by episode/theme/tim/guest with links to favorite/library/amazon." — srik [c:50327148]
> （译文：我想把这个做成播客版的。我订一个播客，比如 Tim Ferris 那个，然后按集数／主题／嘉宾看到书提及，链到收藏夹／图书馆／Amazon。）

> "Build it!" — kxrm [c:50327279]
> （译文：做啊！）

> "Claude can turn something like this around in less than a day." — kxrm [c:50327279]
> （译文：Claude 一天之内就能把这种东西做出来。）

> "HackerMovies someone with free tokens please" — amiune [c:50327359]
> （译文：求一个 HackerMovies，有 token 赠的那种。）

> "I'd love to see a books and youtube thing for metafilter too. It has a similarly good recommendation history for me." — oidar [c:50327656]
> （译文：我也想给 MetaFilter 来一个「书 + 视频」版本，对我来说它的推荐历史一样可靠。）

> "The next stage is "HackerTime", a startup providing enough time to watch all the video and read all the books and play all the game and read all the news on "HackerZ for Z in tube, books, games, news"." — phtrivier [c:50327165]
> （译文：下一阶段是「HackerTime」，一家提供足够时间的创业公司，让你看完所有视频、读完所有书、玩完所有游戏、读完所有新闻——「HackerZ，Z 是 tube、books、games、news」。）

再往下就直奔版权去了：

> "It would be much more amazing if theres just a link to download all thees books as a ZIP file." — bosshawg [c:50327942]
> （译文：如果能直接给一个链接，把这些书全打包成 ZIP 下载，那就 Amazing 了。）

> "Have AI create a clean room rewrite of each book, so we can read them on the site." — addandsubtract [c:50327632]
> （译文：让 AI 为每本书生成一份净室改写版，这样我们就能在站上直接读了。）

### 七、一个书架到底改变了什么

讨论最后落回书本身。有人解释为什么要读一本自己并不认同的书：

> "Even if you completely disagree with every single word, it's still good to know what it actually says, if for no other reason than to be better equipped to argue against the parts you disagree with." — blooalien [c:50327330]
> （译文：哪怕你不同意里面的每一个字，知道它到底说了什么还是有价值的，哪怕只是为了在反驳你不同意的那部分时更有底气。）

也有人被这份榜单直接改主意：

> "Edit: I will try to read thinking fast and slow because of HN recommendations. I have heard some good things about the book but I will try to read it in future given HN's immense recommendations, so your website has already had a negative net positive for me :-D" — Imustaskforhelp [c:50327027]
> （译文：编辑：我打算因为 HN 的推荐去读《思考，快与慢》。我之前听说这本书不错，但既然 HN 推荐得这么猛，我以后会读，所以你的网站已经对我产生了负的净收益 :-D）

哲学书在榜上的意外位置也让人莞尔：

> "This is wonderful. I'm delighted to see that Wittgenstein's Philosophical Investigations has been recommended over 100 times." — RGS1811 [c:50327140]
> （译文：太棒了。维特根斯坦的《哲学研究》被推荐了 100 多次，我很高兴。）

而讨论的收尾是对这种策展方式本身的判断：

> "Content curation will be overhauled for a world with WAY more content of lower average quality. Heavily curated like this is one direction. Micro consumables (ala tiktok) supporting more impressions is another." — nonethewiser [c:50328115]
> （译文：内容策展这件事会被一个「内容多得多、平均质量更低」的世界彻底改写。像这样重度策展是一条路，像 TikTok 那样支持更多曝光的微型消费品是另一条。）

> "I'm beginning to like this new internet…" — JKCalhoun [c:50328063]
> （译文：我开始有点喜欢这个新的互联网了……）

> "Also: no ads, banners…" — JKCalhoun [c:50328226]
> （译文：还有：没有广告，没有横幅……）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 「提到」不能叫「推荐」 | drayfield | 《我的奋斗》被标成 651 人推荐，措辞得改 |
| 改词：改成 mentioned by | roansh | 当天推送修复，还会继续改进推荐 |
| 推荐榜和提及榜是两张榜 | roansh | 579 位推荐者能把《人性的弱点》顶到第一 |
| 整条链都是 Claude 干的 | roansh | 数据管线和站点都是 Claude 写的，我只改了两三次 |
| AI 文风让人反胃 | jchook | 请不要在 HN 帖子里放生成式文本 |
| 一眼认出是 Claude 的界面 | Starlevel004 | 这就是 Claude 的标准 UI |
| 用 Claude 却做不出过滤 | danso | 你既然让 Claude 采数据，怎么就搞不定过滤噪声 |
| 令牌用完就换成了 Grok | DonHopkins | 于是 Grok 极力推荐《我的奋斗》 |
| Opus 5.5 的设计能力更强 | minimaxir | 比 GPT 6.1 Sol 强一个数量级，而且你可以挑剔 |
| 筛选器按最近提及等于没筛 | roansh | 热门书最近总被提，改成按首次提及筛 |
| 每本书只留 30 条评论 | roansh | 所以第二次点就是最后一条了 |
| 曲线图当天就做出来 | roansh | 提问 16:57，趋势页 17:05 上线 |
| 榜单该有年表 | hyperman1 | 想看哪些书常青、哪些书一波流 |
| 推荐算法不靠谱 | pndy | Scratch playground 和《美丽新世界》有什么关系 |
| 2021 年就有人做过 | MYEUHD | 同类站点早出现过 |
| 前作全都 404 了 | 361994752 | 我收藏过好几个，两年后打开全是 404 |
| HackerTube 自己在 503 | genxy | 所以这个可能一天都活不下去 |
| 收藏了也不会再回去看 | jordan | 我收藏过，一次都没回去点过 |
| 不如自己 vibe 一个 | micromacrofoot | 花一小时自己做一个就好了 |
| 播客版也要 | srik | 按集数和嘉宾看书提及 |
| 一天就能复制一个 | kxrm | Claude 一天之内能搞定 |
| 电影版、MetaFilter 版也要 | amiune / oidar | 求 HackerMovies，MetaFilter 也来一个 |
| 直接下载全书 ZIP | bosshawg | 给个链接把书全打包 |
| 让 AI 生成净室改写版 | addandsubtract | 这样就能在站上直接读 |
| 读到不认同的书也有用 | blooalien | 为了反驳，你得先知道它到底说了什么 |
| 榜单能改变阅读计划 | Imustaskforhelp | 我准备因为 HN 推荐去读《思考，快与慢》 |
| 策展会被内容通胀改写 | nonethewiser | 重度策展是一条路，微型消费品是另一条 |

## 总体情绪

这场讨论的表面主题是「又一个人用 Claude 造了个 HN 玩具」，但真正被反复追问的只有一个技术问题：怎么把「被提到」和「被推荐」分开。这个问题的难处不在算力，而在口径——同一个书名可能指的是电影、游戏、杂志或者同名作者的作品，提到它可能是在夸，也可能在骂，可能只是提一句作者是谁。站点的解法是把标注交给 Sonnet 5.5，抽查 400 条与 Opus 5.5 一致率 85%，剩下的交给运气。这套解法不完美，但足够把《我的奋斗》的推荐人数从 651 修正到 15。

第二个反复出现的情绪，是对这类站点寿命的集体不信任。2021 年就有人做过同样的东西，评论里不止一个人记得自己收藏过好几个前作，也记得它们后来一个个 404；而作者本人做的东西就在同一天被吐槽正在 404 和 503。于是社区给出的答案不是「再做一个」，而是「直接自己 vibe 一个，反正只要一小时」——这种把可持续性问题的答案交给个人劳动力的姿态，比对站点的任何批评都更说明问题。

真正被建立起来的，是一份 HN 的书目年表。2008 年是 Founders at Work，2011 年是《精益创业》，2020 年是《思考，快与慢》，2026 年是 Careless People；常青书像《计算机程序设计艺术》二十年不断被提起，新书则像潮水一样来了又走。一个二十年的社区，到底在读什么，其实一直写在评论里，只是没人把它整理成书架。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Show HN: HackerBooks – HackerTube, but for books mentioned on HN（HN 主帖，409 分，114 条评论） | https://news.ycombinator.com/item?id=50326821 |
| 2 | Hacker Books 首页（books / trends / topics 数据） | https://hackerbooks.org |
| 3 | Hacker Books 趋势页 | https://hackerbooks.org/#/trends |
| 4 | Hacker Books 站点元数据（书数、提及数、评论者数） | https://hackerbooks.org/data/meta.4ad945e7.json |
| 5 | Hacker Books 全量书籍索引（提及数、推荐者数、主题标签） | https://hackerbooks.org/data/books.f17d4185.json |
| 6 | Hacker Books 年度趋势数据（各年提及占比与排名） | https://hackerbooks.org/data/trends.0ebe503b.json |
| 7 | Hacker Books 主题分布 | https://hackerbooks.org/data/topics.d608b6ca.json |
| 8 | HackerTube（Karpathy 的 HN 视频推荐站，本项目的灵感来源） | https://hackertube.org |
| 9 | 2021 年的同类站点讨论 | https://news.ycombinator.com/item?id=28595967 |
| 10 | HN 长期未实现工具请求榜（同类做法） | https://stillunbuilt.shiptiffin.app/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的书籍榜单、提及数、推荐人数、主题分布与年度排名，均来自 hackerbooks.org 于 2026-11-01 生成、2026-11-02 读取的公开数据文件，站方数据可能随站点更新而变化，本文未做独立复核；同一批次数据中《我的奋斗》的「推荐人数」与评论者在帖中看到的数字并不一致，原因见正文。立场标注由站方使用 Claude Sonnet 5.5 生成并抽样自评一致率 85%，本文未复核该标注本身。「提到过」与「推荐过」的差别、书单排序是否代表书的价值，均属评论者个人判断，非事实结论。本文未收录任何评论者提出的绕过版权、下载或改写受版权保护作品的具体方案。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
