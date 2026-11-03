---
layout: post
title: >-
  Hacker Times：把 HN 排成一份每小时更新的报纸 — HN 讨论摘要
date: 2026-11-03
hn_id: 50346981
categories: [articles]
excerpt: >-
  一个 AI 编辑的头版站：抓 3 页共 89 条候选，按 60% 分数、25% 评论数、15% HN 排名排版，
  每小时出一期。评论区的真问题不是版式，是这已经是同一类项目的第三遍。
tagline: >-
  AI 排的版，HN 挑的刺。
---

> 来源：HN 讨论帖，提交者 polpenn。帖子：[Show HN: Hacker Times, a New York Times-inspired version of Hacker News](https://news.ycombinator.com/item?id=50346981)，351 分，109 条评论（抓取时快照）。站点：https://hackertimes.ca/ 。站方 About 面板声明的数据快照为 2026-11-03 12:56 UTC。

## 原文概要

Hacker Times 是 polpenn 做的一个 HN 前端：把 HN 首页的故事重新排成报纸版式，每小时出一期。站点自己的说法是「An independent, AI-edited front page from Hacker News, updated hourly」——独立、AI 编辑、按小时刷新。帖子发布十来个小时就到 351 分、109 条评论，在 Show HN 里属于当天讨论量靠前的一批。

排版规则写在站方 About 面板里，数字给得很具体：它抓取 HN 三页列表，筛出 89 条合格候选（2026-11-03 12:56 UTC 快照）；头条位置给首页总分最高的帖子，同分时保留已经在位的那个；其余位置按 60% 分数、25% 评论数、15% HN 排名加权；三页之内取素材，主题版块与「The conversation」那一行各自用不同的故事，避免重复。图片只取跟内容相关的真实图片，明确声明不绕过付费墙；报头用 Manufacturing Consent 字体，SIL Open Font License 1.1。

版面上分 Technology、Software、Science、Culture、Business 五个版块，外加一行「The conversation」专放讨论。当期头条包括：MIT CSAIL 那篇让 GPT-6 Astra 直接读写神经网络权重的实验（854 条评论）、Andrej Karpathy 用 HN 推荐攒出的 6,454 个 YouTube 视频组成的 HackerTube、Ubuntu 内核补丁迟迟不发的质疑（站方记录 11 月 2 日 14:48 UTC 仍未修 CVE-2026-98432）、HackerBooks、Subvocal 的静音语音眼镜、Robert Haas 把 PostgreSQL 延期归因于 AI 找出的 bug 积压、《卫报》报道的隐私电视、欧洲零售冷柜故障与网络攻击、要求 SEC 阻止 Anthropic IPO 的评论文章，以及 Parma 附近农户 Claudio Grossi 从阁楼种子里救回来的意大利小麦；往下的版块还有 NVIDIA 给 agent 的共享词表、OpenAI 的 Scaling Git、陶哲轩博客上讨论数学署名的文章、Warsaw 的体素模型、Windows 2000 发布会彩排回忆（Patrick Stewart 主持）和 Zamzar 兄弟二十年里 7.66 亿次文件转换。站方同时声明：原文和图片归原出版方所有，与 The New York Times 和 Hacker News 均无关联。

## 讨论焦点

### 一、它到底解决了什么：把「链接墙」压成能读的版面

支持者说的第一件事不是好看，是可读。duckkg5 说的正是 HN 首页那种纯链接列表的问题：

> "This is great! Very readable and feels like a nice way to browse articles. I tend to gloss over stuff in the HN wall of text sometimes so this breaks the links up in a useful way. Nice job." — duckkg5 [c:50347483]
> （译文：这个太棒了！非常好读，感觉像一种很舒服的读文章方式。我有时会略过 HN 那一大片文字墙，这样把链接拆开确实有用。干得好。）

FearNotDaniel 把价值说得更具体——他说的不是排版，是编辑：

> "The instant value I got from this is actually something that resembles journalism and editing, even if it’s just an LLM doing the job: the rewriting of headlines along with a half-decent editorial summary paragraph gives me a clear overview of what each link is actually about without the usual puzzling over what the cryptic HN headline is trying to say." — FearNotDaniel [c:50349474]
> （译文：我立刻从中得到的价值，其实接近新闻报道和编辑工作——哪怕干这活的只是个 LLM：它把标题重写一遍，再配上一段还算像样的编者摘要，让我一眼看清每个链接到底在讲什么，不用再猜那些晦涩的 HN 标题想说什么。）

这句跟站方 About 里的 60/25/15 排布是同一件事的两面：分数与排名负责选出「谁上头版」，摘要段落负责让读者「知道自己在读什么」。另外两位读者则认出它其实是老朋友：

> "Having the paragraph under the title reminds me of slashdot.org." — markkitti [c:50348451]
> （译文：标题下面那段摘要，让我想起 slashdot.org。）

代价也有人点出来，rectang 说得算公道：

> "The tradeoff of the Hacker Times design is increased information for each story but lower density of stories compared to the HN homepage." — rectang [c:50348856]
> （译文：Hacker Times 这个设计的取舍是：单条故事的信息量更大，但跟 HN 首页比，故事密度更低。）

而在另一头，latchkey 明确说自己不需要：

> "i'm pretty happy with the existing way of browsing HN. i hope it never changes." — latchkey [c:50347333]
> （译文：我对现在逛 HN 的方式挺满意的，希望它永远别变。）

### 二、他们怀念的不是版式，是节奏

评论里最长的那几条支线都绕回同一个老愿望：每天有一份能拿在手里的东西。vunderba 想起第一代 iPad 上的 Early Edition：

> "It wasn't physical, but there was a slick app for the 1st gen of iPad called Early Edition which was basically just curated RSS feeds presented in the style of a newspaper." — vunderba [c:50347267]
> （译文：它不是实体的，但第一代 iPad 上有过一个很顺手的应用，叫 Early Edition，本质上就是把精选的 RSS 源按报纸的样子排出来。）

al_borland 已经在往纸质方向走了——用 Kagi 这类每日更新的新闻源，再用便宜的熱敏打印机打出来：

> "Just pick up the paper from the printer each morning." — al_borland [c:50348000]
> （译文：每天早上把打印机里那张纸拿起来就行。）

而这条支线的情绪底色是 reaperducer 那两句：

> "You just described what Time magazine was." — reaperducer [c:50347873]
> （译文：你刚才描述的就是《时代》杂志当年的样子。）

> "FOMO is the drug. The tech industry is the dealer." — reaperducer [c:50347873]
> （译文：FOMO 才是毒品，科技行业是发药的。）

这份怀旧也有它的墓碑。slater 和 RachelF 提到当年同样定位的 N-gate 怎么停更：

> "Was kinda filled with N-gate, but they stopped updating." — slater [c:50348317]
> （译文：我以前填的源里就有 N-gate，不过他们后来不更新了。）

> "'twas a sad day when N-gate went quiet." — RachelF [c:50348494]
> （译文：N-gate 安静下来的那天，是个悲伤的日子。）

有意思的是，同一批人一边怀念旧报纸，一边又在讨论区里吐槽 HN 本身。option_greek 数着这一波的项目：

> "so hacker tube, hacker books and now hacker times. what's next? hacker food?" — option_greek [c:50347807]
> （译文：所以是 hacker tube、hacker books，现在又是 hacker times。下一个是什么？hacker food？）

turtleburger 接了这个梗：

> "Hacker food already well defined in 1995 by Razor and Blade - clearly jolt cola :)" — turtleburger [c:50347879]
> （译文：Hacker food 在 1995 年就被 Razor and Blade 定义好了——显然是 Jolt 汽水。）

### 三、第三次同题：先做出来的人到底在争什么

质疑的一派不谈技术，谈的是「这已经是第几个」。emaro 翻出了前辈名单：

> "I remember there was a similar project like this posted a while ago. Turns out there are multiple." — emaro [c:50347818]
> （译文：我记得前面一段时间就有人发过类似的项目。看来这类东西不止一个。）

他列出的单子里有两个月前的 thefrontpage.dev、times.hntrends.net、hackernewstimes.com，还有 6 年前的一个：

> "A couple of months ago (so probably vibe-coded too)" — emaro [c:50347818]
> （译文：几个月前（所以大概也是 vibe 出来的））

其中 paper-hn 当年拿到 627 分、133 条评论；评论里还翻出了 HN 上的旧帖（item?id=23669650）。同一批讨论里，yewenjie 干脆造了个「聚合器套聚合器」的站点 hackeragain.com 去收集这些 HN 味项目，vektormemory 则说：

> "I'm liking all of the remixes." — vektormemory [c:50347397]
> （译文：这些 remix 我都挺喜欢。）

分裂发生在「重复到底算不算问题」上。blocked_againnn 是「先做出来再说」这一派：

> "There is nothing particularly special about building something first." — blocked_againnn [c:50350247]
> （译文：把东西做出来，这本身没什么特别的。）

> "None of these are listed in the guidelines on HN." — blocked_againnn [c:50350917]
> （译文：这些事没有一条写在 HN 的规则里。）

> "Subjective opinions. People can do whatever they want." — blocked_againnn [c:50351338]
> （译文：主观判断。人们想做什么就做什么。）

另一派要求的是「差异」，emaro 给的标准挺具体：

> "make it better, make it weird, or make it recreationally (i.e. by hand)." — emaro [c:50350515]
> （译文：做得更好、做得更怪，或者做出来是为了好玩（也就是手写）。）

simsla 把标准换算成了成本问题：

> "Not saying it's to be banned if there's no additional substance, but worth asking yourself what you've contributed apart from token spend." — simsla [c:50351224]
> （译文：我不是说没有额外价值就该被禁，但值得问问自己，除了烧 token，你到底贡献了什么。）

### 四、AI 写的报纸：一场老争论的新形态

「这是不是又一个 AI 味的东西」几乎是本帖的默认怀疑。lagrange77 写了一段最完整的回答，先把问题从工具上挪开：

> "It's not about the tools." — lagrange77 [c:50348572]
> （译文：问题不在工具。）

> "It's not an inherent property of AI use itself. HackerTimes for example doesn't feel uninspired or bland. And i like it." — lagrange77 [c:50348572]
> （译文：这并不是用 AI 本身固有的属性。比如 Hacker Times 就不会让人觉得乏味或者平淡。我喜欢它。）

他的论证是：让人反感的不是 AI，而是没投入的作者——米色衬线体、塞满功能的 README、错得离谱的信息图，都是「原始输出是商品」的产物；同一套工具换个用法就完全不一样。HN 的 dang 把这个话题接了过去：

> "Of course HN disagrees with itself; it's not a self to begin with." — dang [c:50347795]
> （译文：HN 当然会自相矛盾，它本来就不是一个统一体。）

> "It's also refreshing. There's no intrinsic reason why generated software should look bad or work poorly." — dang [c:50347795]
> （译文：这也让人耳目一新。生成的软件没有内在理由就该长得难看或者不好用。）

反方向的情绪也在场。aurareturn 说出了 HN 的自相矛盾：

> "People here complain about vibe coded apps, then proceed to upvote this to the front page." — aurareturn [c:50347695]
> （译文：这里的人一边抱怨 vibe coded 的应用，一边把这种东西投到首页。）

eddiewithzato 说得更直接：

> "damn the vibecoded ones look a lot better" — eddiewithzato [c:50350483]
> （译文：靠，这些 vibe coded 的看起来好多了。）

真正读出问题的是 user_7832，他盯着报头第一段：

> "Ah, Manufacturing Consent—the font that doesn’t just scream “serious journalism,” it calmly editorializes it in 144-point Fraktur while subtly nudging your worldview." — user_7832 [c:50348658]
> （译文：啊，Manufacturing Consent——这个字体不只是大喊「严肃新闻」，它用 144 磅的 Fraktur 体，不动声色地推动你的世界观。）

> "Unfortunately feels too much like an LLM output for me." — user_7832 [c:50348658]
> （译文：可惜在我看来，这太像 LLM 的输出了。）

顺带一提，有开发者提到这个站点和所有 ChatGPT 站点一样，在 ChatGPT 不可用的地区打不开；又因为用了自有域名，没法像 ChatGPT 域名那样被自动代理——这大概也是那段报头文字读起来「太像 LLM 输出」的一部分原因。

### 五、NYT 这个名字，是借来的权威

另一个方向上的火力冲着署名来的。有人已经对 NYT 这个联想本身反感：

> "I have a visceral dislike for the NYT, so the association is actually a negative, haha — but I could get over it." — rectang [c:50348856]
> （译文：我对 NYT 有一种本能的厌恶，所以这个联想其实是负面的，哈哈——不过我可以克服。）

更细的判断来自 alexgoodhart，他引的是 Jameson 讲「晚期资本主义」的那套说法：报纸的权威来自它发表前承受的风险与审慎，而换皮只复制了审慎的样子：

> "this project would reproduce the aesthetic identity of such carefulness without actually containing it." — alexgoodhart [c:50349984]
> （译文：这个项目会复刻出那种审慎的美学身份，却并不真的包含审慎本身。）

swiftcoder 说得更日常，也更准——大家从小熟悉的是纸刊版 NYT，而眼前这个是点击量最大化的线上版：

> "It's not the classic print edition of the NYT that everybody grew up with, it's the click-maxing online version..." — swiftcoder [c:50349854]
> （译文：它不是大家从小看到大的那版 NYT 纸刊，而是那个点击量最大化的线上版本……）

于是评论区集体玩起付费墙梗——因为这个站确实没有付费墙：

> "NYT but without the annoying google login, or subscribe for $1 paywalls!" — blobbers [c:50348495]
> （译文：NYT，但没有烦人的 Google 登录，也没有每月 1 美元的订阅墙！）

> "It would be more realistic if it was just a paywall." — asmodeuslucifer [c:50349235]
> （译文：如果直接加个付费墙反而更真实。）

> "I don’t think the pay wall is working." — codazoda [c:50347461]
> （译文：我觉得这个付费墙不太灵。）

> "If I cancel can I get the service for $1/week? That's my favorite NYT feature." — Rapzid [c:50349590]
> （译文：如果我要退订，能不能按每周 1 美元卖给我？那才是 NYT 我最喜欢的功能。）

而 danpalmer 那一段把两个问题一起问了：人们为 NYT 付钱买的到底是什么，以及既然只是个换皮，为什么非要开一个整站：

> "Isn't what people pay for with the NYT or other publications, the journalism and editing? Like, the UI isn't why people pay for it." — danpalmer [c:50348904]
> （译文：人们为 NYT 或其他出版物付的，不正是新闻报道和编辑工作吗？人们付费买的并不是界面。）

> "Given that this seems to just be a re-skin, why a full site that updates hourly, instead of just a browser extension that rewrites the content in-place live?" — danpalmer [c:50348904]
> （译文：既然这看起来只是个换皮，为什么不做一个浏览器插件，直接就地改写页面内容，还要开一个每小时更新的整站？）

倒过来想的也有人：

> "i'm open to the idea that its the NYTimes that needs a HN inspired version" — vanjajaja1 [c:50347498]
> （译文：反过来讲，需要一个 HN 版的 NYT，我也能接受。）

### 六、别把它做坏了：缺的功能与拖后腿的细节

最后一拨评论是实操层的，几乎每条都是一个待办。暗色模式被点名最多：

> "I just want HN in dark mode...." — anakaine [c:50349208]
> （译文：我只想要 HN 的暗色模式……）

评论区随即开始推荐替代方案——dongecko 说自己在用另一个 HN 前端：

> "No subscription, no login, mobile friendly and it has been stable and online for several years." — dongecko [c:50349765]
> （译文：没有订阅，没有登录，手机友好，而且已经稳定在线好几年了。）

讨论区的缺失被认为是更致命的：

> "not sure, do the have comments & discussions?" — KellyCriterion [c:50349808]
> （译文：不太确定，它有评论和讨论区吗？）

> "Lot of people come just for comments" — KellyCriterion [c:50349808]
> （译文：很多人就是冲着评论来的。）

连游戏版块都被要求补上：

> "the only thing the site is missing is a games tab like the NY Times" — Tryvrsakjo10 [c:50348689]
> （译文：这个站唯一缺的就是像 NYT 那样的游戏版块。）

具体到站点本身，有一条很硬的技术反馈：

> "Certificate issue, Firefox refuses to load it." — simongray [c:50349614]
> （译文：证书有问题，Firefox 拒绝加载。）

排版上的意见则集中在字体与移动端：muglug 认为标题字体的选择和字号都不成立——

> "Georgia Bold is not fit for the purpose, and there's no earthly reason to use it at 55px." — muglug [c:50347331]
> （译文：Georgia Bold 不适合干这个，用 55px 更是毫无道理。）

donohoe 干脆说移动端读起来费劲：

> "the typography choices here are poor. Nice idea but readability on mobile isn’t great sadly." — donohoe [c:50351232]
> （译文：这里的字体排版选得不好。想法不错，可惜移动端的可读性不太行。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 链接墙终于能读了 | duckkg5 | 把 HN 的链接墙拆开成可读版面 |
| 编辑感真实存在 | FearNotDaniel | 改写标题加摘要段落，接近真正的编辑 |
| 眼熟 | markkitti | 标题下那段摘要让他想起 slashdot |
| 密度是代价 | rectang | 单条信息更多，故事密度更低 |
| 不改也行 | latchkey | 对现在逛 HN 的方式很满意 |
| 怀念的是节奏 | reaperducer | FOMO 是毒品，科技行业是发药的 |
| 纸媒有先例 | vunderba | 第一代 iPad 上的 Early Edition |
| 热榜会死 | slater | N-gate 当年也火过，后来不更新了 |
| 同题第 N 次 | emaro | 前面已经发过好几个同类项目 |
| 六年前就有了 | emaro | paper-hn 拿到 627 分、133 条评论 |
| 做出来本身不特别 | blocked_againnn | 把东西做出来没什么特别的 |
| 不违规 | blocked_againnn | 这些事一条都不在 HN 规则里 |
| 要有差异 | emaro | 做得更好、更怪，或者为了好玩 |
| 质疑只有 token | simsla | 除了烧 token 你贡献了什么 |
| 问题不在工具 | lagrange77 | 这是作者怎么用工具的问题 |
| 生成不等于难看 | dang | 生成的软件没有理由必须难看 |
| 一边嫌弃一边投票 | aurareturn | 抱怨 vibe coded 应用，然后投它上首页 |
| 界面不是付费理由 | danpalmer | 人们买的是新闻和编辑，不是 UI |
| 不如做成插件 | danpalmer | 换皮的话，浏览器插件就够 |
| 缺暗色模式 | anakaine | 我只想要 HN 的暗色模式 |
| 缺评论 | KellyCriterion | 很多人就是冲着评论来的 |
| 细节拖后腿 | simongray | 证书有问题，Firefox 拒绝加载 |

## 总体情绪

整场讨论的情绪不是赞美或反感，而是分成了三层。最外层是具体的喜欢与具体的挑剔——可读、报纸感、每条故事下面那段摘要，都被认可；同时字体、证书、缺评论区、缺暗色模式，也被逐条点名。中间层是「这是第几个」的疲劳：HackerTube、HackerBooks、Hacker Times、hackeragain.com、morningsift.com、hnollo.com 这一串名字在评论区滚过去，emaro 干脆贴出 6 年前那个拿到 627 分的同类项目，simsla 把这件事换算成「除了烧 token 你贡献了什么」。

最内层其实是同一个老问题的新版本：这个站点由 AI 生成，这件事本身该扣分吗？lagrange77 说问题不在工具，dang 说 HN 本来就自相矛盾、生成的软件没有理由必须难看，user_7832 却又从报头第一段里闻出了 LLM 的味道。三个人都没错——他们说的其实是三个不同的问题：产出质量是谁的责任、社区对 AI 产物的默认评价、以及「像 LLM 写的」这种风格判断本身能不能成立。

真正把这场讨论收住的，其实是站方 About 里那几条冷冰冰的规则：89 条候选、3 页 HN、60% 分数 / 25% 评论数 / 15% HN 排名、头条给首页最高分、源站读得着才读、付费墙不绕。它是一份算法版的报纸——版式是新的，选题仍然是 HN 的，评论仍然在原帖。它每小时重新排一次头版，HN 自己不会。差别就在这里，不在那些字体上。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | HN 主帖：Show HN: Hacker Times, a New York Times-inspired version of Hacker News（351 分，109 条评论） | https://news.ycombinator.com/item?id=50346981 |
| 2 | Hacker Times 首页（站方 About：排布规则与 2026-11-03 12:56 UTC 快照） | https://hackertimes.ca/ |
| 3 | paper-hn（评论区列出的 6 年前同类项目，627 分、133 条评论） | https://www.wolfgangfaust.com/project/paper-hn/ |
| 4 | paper-hn 当年的 HN 帖（item?id=23669650） | https://news.ycombinator.com/item?id=23669650 |
| 5 | HackerTube（Andrej Karpathy，评论区 dang 提及） | https://news.ycombinator.com/item?id=50319510 |
| 6 | 评论区列出的其他同类站点 | https://thefrontpage.dev/ |
| 7 | 评论区列出的其他同类站点 | https://hackernewstimes.com/ |
| 8 | HN 报道版报纸类项目的检索入口（评论区提供） | https://hn.algolia.com/?q=hackernews+newspaper |
| 9 | 评论区推荐的 HN 替代前端 | https://hn.premii.com |
| 10 | Manufacturing Consent 字体（站方报头用字，SIL OFL 1.1） | https://fonts.google.com/specimen/Manufacturing+Consent |
| 11 | 站方头条之一：MIT CSAIL 的权重编辑实验 | https://rikiyat.github.io/blog/weight-space-programming/ |
| 12 | 站方头条之一：Ubuntu 内核补丁延迟的质疑 | https://chalmovsky.com/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的帖子分数、评论条数，以及站方 About 面板给出的「89 条合格候选、抓取 HN 三页、60% 分数 / 25% 评论数 / 15% HN 排名、头条取首页最高分、源站读得着才读且不绕过付费墙、报头用 Manufacturing Consent 字体」等规则与 2026-11-03 12:56 UTC 快照，均为 2026-11-03 读取站方页面与 HN 列表所得，站方已声明版面与快照会随更新变化，本文未做独立复核。站方声明与 The New York Times、Hacker News 均无关联，原文报道与图片版权归原出版方所有。评论中关于站点可达性、字体排版、证书问题、暗色模式与评论缺失等说法均为个人观察，可能已随时间变化。「值不值得做第三个」「是不是 AI 味」一类判断属评论者个人意见，非事实结论，各方解读已在正文并列呈现。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖按 <code>item?id=50346981</code> 打开主帖、再定位到对应楼层。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
