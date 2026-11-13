---
layout: post
title: >-
  LibreOffice 的「一年 365 天都能用」：一句玩笑引出三笔办公软件旧账 — HN 讨论摘要
date: 2026-11-14
hn_id: 50486482
categories: [articles]
excerpt: >-
  M365 故障期间，LibreOffice 官方账号发了一句「一年 365 天都能用」。705 分的讨论里没人怀疑它能不能打开文件，
  争的全在三笔旧账：界面老派、格式兼容、买断软件的更新权益。
tagline: >-
  丑归丑，它开机不看你脸色。
---

> 来源：HN 讨论主帖 [LibreOffice actually works 365 days a year](https://news.ycombinator.com/item?id=50486482)（705 分，227 条评论），指向 [LibreOffice 官方 X 状态](https://twitter.com/LibreOffice/status/2121205272479998268)。本篇为单帖模式（同一关键词下无同期其他帖子）。主帖归档抓取于 2026-11-13 21:14 UTC，入库 100 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。原帖正文抓取自 X 页面，只拿到 536 字符且几乎全是登录墙提示，官方状态正文就是本文开头引用的那一句话；「365 天」玩笑所指向的背景，取自主帖前一天（2026-11-12）的 Microsoft 365 服务降级公告与相关讨论，本站未直接读取该状态页。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 11 月 13 日，LibreOffice 官方账号在 X 上发了一条状态，全文只有一句：「LibreOffice actually works 365 days a year. Just saying.」（LibreOffice 一年 365 天都能用。不多说了。）

玩笑的落点很明确。前一天 11 月 12 日 18:20 UTC，Microsoft 365 状态页贴出服务降级公告，Exchange Online、Teams、SharePoint Online、Copilot 365、Defender XDR 一起连不上（受影响服务清单来自该次降级公告在 HN 评论区被逐字转录的文本，本站未直接读取状态页）。那条降级帖在 HN 拿到 1145 分和 963 条评论。「365」这个数字因此不是随口一说，它说的是「全年无休」，对照的是「订阅制软件的可用性由别人的服务器决定」。这句吐槽当天 17:09 UTC 被提交到 HN，最终 705 分、227 条评论。

抓正文时，X 页面除了登录提示什么都没给得出来——官方状态本身就只有一句话。整场讨论的原料全在评论区。

真正被顶起来的是三笔旧账：它到底算不算 Word 的合格替代品？那套老派界面是负担还是特色？买断软件的更新权益到底谁说了算？评论区里的反对意见没有一条落在「它打不开文件」上——争论全部发生在这一步之后。而反对最坚决的那一条，句式和主帖几乎一模一样。

挖到最底下的共识反而朴素：数据放在一个真正开放、有文档的格式里，本身就值回票价。至于「值不值」，评论区给出的不是结论，而是两种失败模式的对撞——服务宕机，和十年后打不开自己的文件。

## 讨论焦点

### 一、玩笑的落点：365 天对宕机日

> "In other news, Claude outages today." — svachalek [c:50486752]
> （译文：另一个新闻：Claude 今天也在宕机。）

> "While true and a comment I support, it is worth noting that offline versions of Microsoft Office are and have been just fine, including the latest version of 2024 just updated this week." — kencausey [c:50486698]
> （译文：这话成立，而且我支持这个观点；不过要补充一点：Microsoft Office 的离线版本一直都没问题，包括上周刚更新的 2024 版。）

> "It&#x27;s not even really particularly true, at least the implied criticism. My work uses M365 and Microsoft Office worked fine, both online and offline versions. Email stopped working, but AFAIK Open Office doesn&#x27;t make an open source email server." — Exmoor [c:50487308]
> （译文：这个说法其实也不算特别成立，至少它隐含的那份批评不成立。我的工作用 M365，Microsoft Office 在线版和离线版都正常。坏掉的是邮件，但据我所知 Open Office 也没做一个开源邮件服务器。）

> "The offline app licensing system is explicitly designed to only require refreshing the status regularly, each successful refresh will keep the state for six months even it it fail to refresh during that period. After the six months there comes the one month grace period (basically reminding the user to get online or contact their IT) where there&#x27;s a warning banner but it still work. After the grace period it will disable saving." — martheen [c:50488026]
> （译文：离线授权机制的设计是只需要定期刷新状态：每次刷新成功会保留六个月的授权状态，即便这期间刷新失败也一样。六个月之后是一个月的宽限期（基本上是在提醒你联网或者去找 IT），这时会弹出警告横幅，但软件仍然能用。宽限期过后，它会禁止保存文件。）

一句玩笑被拆成了三问：哪些功能真的在线、授权能撑多久、以及「离线版」这个东西现在到底还存不存在。martheen 描述的机制最具体——买断的 Office 并不是永久离线可用，它要靠定期联网续命，续不上就只剩一个月宽限期，然后禁止保存文件。这正好把「365 天」的边界画了出来：本地套件不是无条件独立，它只是把「在线依赖」从每次打开挪到了每半年一次。

### 二、「它不是 Word 的合格替代品」

> "And it&#x27;s not a proper substitute for Microsoft Office. Just saying." — n4bz0r [c:50486767]
> （译文：而且它也不是 Microsoft Office 的合格替代品。就这么一句。）

> "try to open sreadsheets, especially wide&#x2F;big one, and you will love it even more. I literally have to do non intuitive moves and fall back into gdrive or claude docs." — maxdo [c:50486768]
> （译文：你去试试打开表格，尤其是又宽又大的那种，然后你会更喜欢它。我实在得做一些反直觉的操作，最后退回 Google Drive 或者 Claude 文档。）

> "The main problem is that if you get sent any slightly complicated word document, it doesn’t display properly. Equally if you create something using it and have to send it to someone who uses Word, then it doesn’t work properly for them." — rythie [c:50488247]
> （译文：主要问题在于，对方发过来的 Word 文档只要稍微复杂一点，在你这儿就显示不对；反过来，你用它做完东西发给用 Word 的人，对方那边一样不对。非工作用途的话，Google Docs 和在线表格已经够用了，我个人机器上根本没装 MS Office。仅供参考。）

> "Not sure about Word or other apps, but in Excel there are many useful functions added in the later versions like XLOOKUP, LAMBDA, LET, FILTER, MAP, REDUCE, GROUPBY." — duckmysick [c:50487912]
> （译文：Word 和其他应用我不确定，但在 Excel 里，后期版本加了不少有用的函数，比如 `XLOOKUP`、`LAMBDA`、`LET`、`FILTER`、`MAP`、`REDUCE`、`GROUPBY`。）

反对意见的形状很一致，都落在「能打开」和「能交付」之间的那段距离上：一个说表格，一个说文档，一个干脆列函数清单。而这批函数——`XLOOKUP`、`LAMBDA`、`LET`、`FILTER`、`MAP`、`REDUCE`、`GROUPBY`——正是近十多年 Excel 真正拉开差距的地方，也是评论者认为 Calc 对不上的地方。

也有人把问题往产品设计上提：

> "With a well-defined python API instead of the abomination that is VBA, you could dispense with all the fancy mail-merge and other stupid features and greatly simplify the word processor product.  I think most people would be happy to pay $250, or whatever, for an offline office suite that worked and was free of serious&#x2F;security-relevant bugs." — stackghost [c:50487907]
> （译文：如果用一套定义明确的 Python API 来替代 VBA 这个灾难，就可以去掉邮件合并之类的花哨功能，把文字处理器这个产品大大简化。我觉得大多数人愿意花 250 美元，或者差不多的钱，买一套离线、能正常工作、没有严重安全漏洞的办公套件。）

这段话把「替代品」的判据换了：不是功能表对齐，而是买断价位的离线套件能不能兑现。

### 三、丑是不是原罪

> "It it can do the job, i&#x27;ll take ugly." — kbrannigan [c:50486908]
> （译文：只要它能把活干完，我认丑。）

> "A world-class designer can make a GUI great, but the vast majority of designers are average at best. Restricting their design freedom increases the chances that they&#x27;ll create something decent than if they had full freedom to exhibit their lack of design skill." — win311fwg [c:50487253]
> （译文：顶尖设计师能把 GUI 做得很好，但绝大多数设计师水平也就一般。限制他们的设计自由度，反而更可能让他们做出至少体面的东西，而不是放任他们把自己设计功底的不足暴露出来。）

> "I can&#x27;t use the ms office ribbon ui. Guessing by the fact no other modern desktop software I&#x27;m using copied it, it&#x27;s probably not just me." — tpm [c:50488788]
> （译文：我用不了 MS Office 那个 ribbon 界面。从我用的其他现代桌面软件一个都没抄它这点来看，应该不只是我一个人这样。）

> "I still can&#x27;t find anything in the ribbon in excel. Is it in the home tab, formatting, or data? Guess I&#x27;ll look in each. Every time. Something about it that after so many years can&#x27;t internalize it." — k0morebi [c:50489716]
> （译文：我在 Excel 的 ribbon 里还是找不到东西。它在 Home 标签？在 Formatting？在 Data？猜吧，我每次都得一个一个点过去。有些东西过了这么多年还是没法内化。）

> "Let&#x27;s be honest though, the UI is absolutely dreadful." — emsixteen [c:50487224]
> （译文：不过说实话，那个界面确实糟糕透顶。）

审美之争的妙处在于，反对方攻的往往不是 LibreOffice，而是微软自己。k0morebi 描述的是一种过了很多年也没能内化的肌肉记忆，而吐槽 LibreOffice 老派的人，理由常常是「现在的 Word 比它还难看」：

> "I consider LibreOffice Writer superior to old MS Word versions, and old MS Word versions superior to new MS Word versions." — adrian_b [c:50487323]
> （译文：我觉得 LibreOffice Writer 比旧版 MS Word 好，旧版 MS Word 又比新版 MS Word 好。）

同一个人也承认另一半：

> "On the other hand, I agree that MS Excel is clearly superior to LibreOffice Calc." — adrian_b [c:50487323]
> （译文：另一方面，我同意 MS Excel 明显强过 LibreOffice Calc。）

所以「界面老派」这个批评在评论区其实站不稳：真正被广泛承认的，是现代 Office 的界面同样老派——或者按 win311fwg 的说法，是设计上受限反而逼出了平均水准以上的结果。

### 四、「够用」为什么换不来「有人用」

> "If LibreOffice were good enough already, it would already be popular. It&#x27;s the same with GIMP. On paper it&#x27;s a Photoshop alternative, but we&#x27;ve all struggled with it. These projects need to take the same route as Blender did. Originally it was a clunky open source alternative, but it went through a complete UI transformation and now blows the competition away." — jdlyga [c:50486761]
> （译文：如果 LibreOffice 早就够用，它早就有人用了。GIMP 也是一回事。纸面上它是 Photoshop 的替代品，可我们都在它上面挣扎过。这些项目需要走 Blender 走过的路：起初只是个笨拙的开源替代品，后来经历了一次彻底的界面改造，如今把竞争者打得没脾气。）

这条路不是纯口号，评论区给出了两个已经走完的样本。一个是 Blender，另一个是 Audacity：

> "Audacity has gone through this transformation. Tantacrul (designer, MS Paint 3D, and musician) made a video about how he directed the rewrite of the UI for version 4:" — eastbound [c:50487768]
> （译文：Audacity 经历过这样的改造。Tantacrul（设计师、MS Paint 3D 的作者，也是个音乐人）拍过一个视频，讲他如何主导了 4.0 版本的界面重写。）

> "Not true. There&#x27;s inertia and network effects in play that often prevent better products from succeeding against established ones." — Narishma [c:50487108]
> （译文：不成立。这里有惯性和网络效应在起作用，它们常常阻止更好的产品战胜既有玩家。）

> "The problem is the lack of integration into a wider ecosystem, that&#x27;s what MS provides." — mschuster91 [c:50488189]
> （译文：问题在于它没能融进一个更大的生态，那才是微软提供的东西。）

> "A major barrier to the improvement of giant FOSS replacements like GIMP and LibreOffice is that the people who develop it and the people who use it have become very used to all of its quirks. It&#x27;s extremely hard to identify the rough edges in a UI without an external perspective." — StableAlkyne [c:50486960]
> （译文：GIMP 和 LibreOffice 这类巨型开源替代品难以改进的一个主要障碍，是开发它的人和用它的人都已经太习惯它那些毛病了。没有外部视角，界面上的毛刺极难被发现。）

这一节的分歧最有意思：jdlyga 的判断是「产品还不够好」，而反驳者认为问题根本不在产品。惯性与网络效应、生态集成、开发者与用户共同被自己的习惯绑住——三条理由都指向同一个结论：LibreOffice 缺的不是功能，而是让功能被看见的路径。

而路径的问题被其中一位从格式切入：

> "Forget the cost. Just having my data and documents in a truly open and documented format is value enough to use LibreOffice." — dotancohen [c:50487853]
> （译文：别谈成本了。仅仅让自己的数据和文档处在一个真正开放、有文档说明的格式里，就足以值得用 LibreOffice。）

这条理由和「好不好用」无关，它说的是十年后你还能不能打开自己的文件。

### 五、买断软件的更新权益归谁

> "I have been on HN since 2010, and I will never understand this sentiment of &quot;we deserve free updates&quot;. Unless you were promised an update in the purchase agreement, you got what you literally paid for." — georgel [c:50487335]
> （译文：我在 HN 上混了十年，始终无法理解「我们理应免费获得更新」这种情绪。除非购买协议里承诺了更新，否则你拿到的就是你当时付钱买的东西。）

> "No one &quot;needs&quot; new features, but everyone needs security updates." — jsLavaGoat [c:50487417]
> （译文：没人「需要」新功能，但所有人都需要安全更新。）

> "Some security updates, some features, and if you&#x27;re unlucky and run MacOS - the ability to save files." — gnabgib [c:50487264]
> （译文：有些安全更新，有些功能；如果你倒霉还用的是 macOS——那还有保存文件这个能力。）

争议很快从「买断值不值」滑向一个更具体的威胁：老版本不是「少几个新功能」，而是「不能保存」。评论区里最具体的一条来自 fg137：

> "With Microsoft, especially in the past few years, there is no such thing as &quot;offline version&quot;" — fg137 [c:50488786]
> （译文：尤其在近几年，对微软来说根本不存在「离线版」这种东西。）

他指的是 Office 2021 Mac 版：产品生命周期结束后，买了正版的老用户被发现编辑功能被禁用，社区里流传着「修复」教程。这条评论和前面 martheen 讲的六个月宽限期机制，正好构成一对——买断的老版本既不能保证新功能，也不能保证长期可用。

于是「更新权益」的辩论最后落到三个比喻上：

> "Kinda. I think the prevailing sentiment is more of a manufacturer recall where BMW has realized a flaw that leads to a safety issue or a critical functionality and issues a recall to resolve it." — swasheck [c:50488721]
> （译文：差不多。我倒觉得主流情绪更像是厂商召回：宝马发现了会导致安全问题或关键功能失效的缺陷，于是发起召回来解决。）

> "It isn&#x27;t curmudgeonly to say that a product has reached maturity, and does not need changes. This happens a lot outside of the computing realm; a screwdriver from 50 years ago is basically the same as a modern one." — dghlsakjg [c:50488675]
> （译文：说一个产品已经成熟、不需要改动，并不等于守旧。这种事在计算机之外也常见：五十年前的螺丝刀和现代的螺丝刀基本一样。）

> "What I read from your comment is that youre proud of being stuck in the past. For whatever it&#x27;s worth (to you, the viability of libreoffice) you&#x27;re wrong that a multi decade old ui is better than today&#x27;s." — halJordan [c:50488346]
> （译文：照我看，你是在为自己停在过去而自豪。不管怎么说（就你对 libreoffice 可行性的判断而言），你错了：几十年前那套界面并不比今天的好。）

三个人用三个不同的类比说同一件事：产品成熟不需要被当成道德过错，但「买断就永远能用」这个前提，在联网软件时代本身就已经不成立。

### 六、vibe-coded 的 Rust 替代品

讨论中途还拐进一条平行线：不是「老牌开源能不能用」，而是「用 vibe coding 重写一遍会怎样」。评论里提到 PhotoCraft、WordCraft、LightCraft、ArtCraft 这一批用 Rust 写的替代品。

> "Basically drop-in replacements written in Rust. Each one is around 100mb and no bloat like the real versions. Adobe and Microsoft are in trouble." — dmarzio [c:50486996]
> （译文：基本上就是用 Rust 写的即插即用替代品。每个大约 100mb，没有正版那种臃肿。Adobe 和微软要麻烦了。）

> "They try to recreate proprietary apps 1 to 1 so there&#x27;s no real innovation, but it creates a baseline for new open source projects that can be even better than the original." — tancop [c:50486852]
> （译文：他们试着把专有应用 1:1 复刻出来，所以没有真正的创新，但这给新的开源项目立了个基线——它们可以做得比原版更好。）

> "Be careful with this with the knowledge that it&#x27;s an ongoing vibe-coded effort. Wordcraft failed to detect spacing after paragraphs and I could not use &quot;Remove spacing after paragraph&quot;, whereas it worked in Word." — usui [c:50487056]
> （译文：试用时请注意，这是一个持续进行中的 vibe-coded 项目。Wordcraft 没有正确识别段落后的间距，「删除段后间距」在 Word 里能用的功能它用不了。）

> "Well, PhotoCraft and LightCraft are completely unable to deal with RAW files from Olympus&#x2F;OM Systems cameras. That&#x27;s a known limitation, on their Issues list." — CWuestefeld [c:50488212]
> （译文：PhotoCraft 和 LightCraft 完全处理不了奥林巴斯／OM 系统的 RAW 文件。这是个已知的限制，就在它们的 Issues 列表里。）

这里最尖锐的一句来自一个本该站在传统开源这边的人：

> "But the reason they&#x27;re making waves when traditional FOSS hasn&#x27;t is that the UX is leagues ahead." — StableAlkyne [c:50486960]
> （译文：但传统 FOSS 还没闹出动静，他们却火起来的原因，是 UX 领先好几个身位。）

于是「够用」这条防线被从侧翼绕开了：老牌项目的失败不在能力，而在没人再替它做界面。

### 七、下一个办公软件会是什么形状

> "In reality the office work will be replaced not by libre office, but something like claude work. It&#x27;s an obvious direction." — maxdo [c:50486704]
> （译文：实际上取代办公工作的不会是 LibreOffice，而是某种「Claude 工作」之类的东西。这是个显而易见的方向。）

> "I think the word processor, and the office suite have advanced features that would be better suited in a programming language. like mail merge or macros....<p>do you really need them in a day and age where you have an llm subscription is a different question" — htrp [c:50487780]
> （译文：我觉得文字处理器、办公套件那些高级功能，更适合用一种编程语言来实现，比如邮件合并、宏之类的……在人人手里都有 LLM 订阅的今天，你到底还需不需要它们，那是另一个问题。）

这两条把问题从「谁替代谁」抬到了「还要不要桌面套件」。maxdo 的说法很直白：最后取代办公室工作的既不是 LibreOffice，也不是 Office，而是某种订阅式的 AI 工作方式。htrp 走得更远一步——邮件合并、宏这类功能本来就不该长在菜单里，该长在一种编程语言里；至于你还有没有需求，等人人都有 LLM 订阅之后再说。

有意思的是，这条路线和第六节那批 vibe-coded 的 Rust 替代品刚好对上：本地、可离线、体积小的单点应用，配上会写代码的 agent，反而更容易活下来。

### 八、那些具体的失败模式

散落在整场讨论里的，还有几个非常具体的「不能忍」。

> "On Mac, all key mappings are still wired for PC. In the Save As dialog, Alt-Shit-Left to select the last word of the filename doesn&#x27;t work, the Home key doesn&#x27;t work, the Cmd+C doesn&#x27;t copy, nothing works like on Mac." — eastbound [c:50487839]
> （译文：在 Mac 上，所有快捷键还是按 PC 逻辑接的。「另存为」对话框里，Alt-Shift-← 选文件名最后一个词不管用，Home 键不管用，Cmd+C 也不能复制，没有一处像 Mac。）

> "I couldn&#x27;t launch LibreOffice for like, 3 days, earlier this year after a botched ArchLinux upgrade that moved some libraries it needed." — internet2000 [c:50486787]
> （译文：今年早些时候，一次搞砸的 ArchLinux 升级把它需要的库挪了位置，我有三天都启动不了 LibreOffice。）

> "So? The operating system package manager breaking packages is a different type of problem to an online service being down. LibreOffice presumably did not break in Debian or Nix." — jen20 [c:50487623]
> （译文：那又怎样？操作系统的包管理器搞坏包，和在线服务宕机，是完全不同类型的问题。LibreOffice 在 Debian 或 Nix 上总不至于坏掉吧。）

> "A big thing that came with the roll out of OOXML, along with the controversy, is that all of the weird serialization corruption bugs went away." — maxerickson [c:50488744]
> （译文：OOXML 推行时带来的一件大事（连同那些争议一起）是：所有奇怪的序列化损坏 bug 都消失了。）

这条最后被一个更谨慎的版本修正了：knottn 说自己的经历并不一致，可能把序列化问题和同步问题混在了一起。格式兼容这条线至今没有结论——到底 LibreOffice 的问题是文件本身不支持，还是渲染细节对不齐，评论区只能举出各自的例子。

收尾处是最没有争议的一句：

> "I use LO Calc on my home and work computers, and my work computer comes with Excel installed." — hobo123 [c:50488288]
> （译文：我在家里和公司的电脑上都用 LO Calc，而我的办公电脑上还装着 Excel。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 支持 | kbrannigan | 能把活干完就认丑；Web 应用更漂亮却更臃肿更慢，CLI/TUI 正在回潮 |
| 支持 | dotancohen | 数据放在真正开放、有文档的格式里，这一条就值回票价 |
| 支持 | adrian_b | LibreOffice Writer 的界面好过旧版 Word，而旧版 Word 又好过新版 Word |
| 保留 | tpm / k0morebi | LibreOffice 谈不上丑，但 Office 的 ribbon 同样反人类，问题不在谁更丑 |
| 保留 | StableAlkyne | 开发者与用户都被自己的习惯绑住，没有外部视角就发现不了毛刺 |
| 反对 | n4bz0r | 它不是 Word 的合格替代品，就这点没得洗 |
| 反对 | duckmysick | Calc 缺 `XLOOKUP`、`LAMBDA`、`LET`、`FILTER`、`MAP`、`REDUCE`、`GROUPBY` 一整排函数 |
| 反对 | rythie | 稍复杂的 Word 文档在它那儿显示不对，发给用 Word 的人一样不对 |
| 结构性 | Narishma / mschuster91 | 惯性与网络效应、生态集成，才是它进不去的真正原因 |
| 更新权益 | georgel | 买断就该有更新；没写进合同的东西，你没付过钱 |
| 更新权益 | jsLavaGoat / gnabgib | 新功能可以不要，安全更新不能不要；macOS 上甚至会失去保存能力 |
| 更新权益 | fg137 | Office 2021 Mac 版在生命周期结束后编辑功能被禁用，微软这边早已没有真正的离线版 |

## 总体情绪

分歧最后落在同一个问题上：到底瘫了多少。是「整条 M365 都停了」，还是「我的 Word 还能开，只是登录和邮件坏了」？这条线在评论里来回拉扯——有人问「有 365 授权的话，Excel 是完全打不开了吗」，有人回「我的工作用 M365，在线和离线的 Office 都正常，坏掉的是邮件」。官方公告列出的受影响服务是一长串，用户体验却各自窄得多。玩笑之所以好笑，正因为它戳到了真问题：当「能不能用」要由第三方投票决定时，「一年 365 天」这种承诺才算卖点。

而更值得记下来的是玩笑落下去之后的走向。反对意见没有一条停在「它打不开文件」，被反复拿出来的是两类具体的失败：Excel 的新函数、复杂文档在别人机器上变形、Mac 上失灵的快捷键、授权过期后不能保存——都是「出问题时才发现」那一类。反过来，支持者那边的账也算得很具体：格式开放、PDF 导出比 Word 早十年、界面密度高、屏幕利用率高、离线不依赖别人的服务器。评论里还夹着一条谁也没反驳的观察：让 LibreOffice 变得难用的，恰恰是那些天天用它的人——他们的习惯成了阻力，也让外部视角越来越难进来。

一场由宕机引出的口水战，最后落在一句更朴素的话上：你买的到底是软件，还是一个需要别人替你保证它还在运行的服务。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | LibreOffice actually works 365 days a year（HN 主帖） | <https://news.ycombinator.com/item?id=50486482> |
| 2 | LibreOffice 官方 X 状态（原文链接） | <https://twitter.com/LibreOffice/status/2121205272479998268> |
| 3 | Service degradation on Microsoft 365（背景 HN 帖） | <https://news.ycombinator.com/item?id=50471731> |
| 4 | Microsoft 365 服务状态页 | <https://status.cloud.microsoft/> |
| 5 | Audacity 4.0 界面重写（Tantacrul 视频，评论中提及） | <https://youtu.be/QYM3TWf_G38> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 705 分、227 条评论，归档抓取 2026-11-13 21:14 UTC，入库 100 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。原帖正文指向 X 页面，抓取结果几乎全是登录墙提示，官方状态正文即本文开头引用的一句话；「365 天」玩笑所指向的 Microsoft 365 服务降级，取自主帖前一天（2026-11-12）的公开状态公告与评论区讨论，本站未直接读取该状态页，也未核实其影响范围。文章中关于 PhotoCraft、WordCraft、LightCraft、ArtCraft 的功能与限制，均转述自评论区作者陈述，本站未做独立核实。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
