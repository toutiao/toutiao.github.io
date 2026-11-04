---
layout: post
title: >-
  Google 搜索：营收占比首次跌破一半，同时成了学校拒 AI 的开关 — HN 讨论摘要
date: 2026-11-04
hn_id: 50353192
categories: [articles]
excerpt: >-
  2026 年第三季度，Google 搜索占 Alphabet 营收 49.7%，第一次不到一半；同一周它宣布：禁用 AI
  的学校，学生连搜索都打不开。一边是半壁江山，一边是拿来当筹码。
tagline: >-
  学校不想要 AI，Google 就把搜索拿走。
---

> 来源：HN 讨论帖，提交者 ceejayoz。帖子：[Google will turn off search for schools that reject AI](https://news.ycombinator.com/item?id=50353192)，554 分，374 条评论。原文：[Google Will Turn Off Search for Schools That Reject A.I.](https://www.nytimes.com/2026/11/03/us/google-search-schools-restrict-ai.html)（纽约时报，2026-11-03）。
>
> 配图帖：提交者 hubraumhugo。帖子：[Google Search is now less than half of Alphabet's revenue](https://news.ycombinator.com/item?id=50291945)，431 分，354 条评论。原文：[For the first time ever, Google Search is less than 50% of Alphabet's revenue](https://www.kadoa.com/companies/insights/google-search-below-half)（Company Atlas，2026-10-29）。
>
> 一手材料：[Designing responsible AI for learning](https://blog.google/products-and-platforms/products/education/ai-learning-era-updates-2026/)（Google 官方博客）。
>
> 归档快照：主帖 2026-11-04 01:05 UTC，111 条评论；配图帖 2026-10-31 16:57 UTC，114 条评论。

## 原文概要

2026 年 11 月 3 日，纽约时报刊出一篇由教育记者 Dana Goldstein 与教育科技记者 Natasha Singer 合写的报道，标题是《Google Will Turn Off Search for Schools That Reject A.I.》。核心信息只有一句，但分量很重：如果一所学校在政策上禁用了 AI，那么这所学校的学生将连 Google 搜索都用不了。报道引用 Google 教育业务副总裁 Chris Phillips 的说法——AI 功能已经是 Google 商用搜索的标准组成部分，“搜索与 AI 是深度整合的”，因此停用 AI 意味着搜索本身也停用，学生看到的是学校发来的一条“该服务不可用”的提示，而不是 Google 的任何解释。

Google 同一天在官方博客发布了《Designing responsible AI for learning》，给出了更完整的机制：管理员将获得对 Gemini、Gemini Notebook、Gemini in Classroom 和 Google Search 四项产品的开关控制权，对 K-12 学生账号默认全部关闭，直到管理员逐项打开。同篇博客还发布了 Guided Learning——一种用分步提问代替直接给答案的引导式学习功能，当天已在 Google Classroom 上线，11 月晚些时候会在美国部分学校的搜索中试点。两件事拼起来是一次定位调整：Google 想让“关掉 AI”看起来是学校自己拿到的控制权。

同一周还有另一条关于 Google 搜索的独立消息，被 HN 读者贴成配图帖。Company Atlas 的统计显示，2026 年第三季度（截至 9 月）Google 搜索贡献 634 亿美元，占 Alphabet 1280 亿美元总营收的 49.7%——这是 Alphabet 开始单独披露搜索收入以来，搜索占比首次低于一半。此前 31 个季度里，这一比例一直落在 52.8% 到 62.0% 之间。搜索收入本身还在增长（同比 12%），只是涨得比别处慢：同期 Google Cloud 增长 103%，其营收占比已经从多年前的 4.4% 升到 24.1%。财报发布后 Alphabet 股价单日跌约 13% 到 15%，每股收益 2.12 美元，低于分析师预期的 3.01 美元。

两条新闻放在一起，指向的是同一个东西的两面：搜索既是 Alphabet 收入的一半，是难以替代的现金流入口；也正因为难以替代，它天然适合当筹码用——不给搜索，就等于不给整个课堂。

## 讨论焦点

### 一、标题是标题党吗：opt-in 还是捆绑

第一条回复就替这篇报道定了性：

> "As usual, the truth is a little less clickbaity. It's just opt-in:" — djoldman [c:50353739]
> （译文：老样子，真相没那么标题党。这本来就是 opt-in。）

他贴的是 Google 同日发布的官方博客，里面的措辞相当克制：

> "Access to these products will be entirely off for K-12 student accounts until school administrators explicitly turn them on." — djoldman [c:50353739]
> （译文：这些产品对 K-12 学生账号将完全关闭，直到学校管理员明确把它们打开。）

但立刻有人指出，博客和纽约时报讲的其实不是一回事：

> "So yeah the blog post says Google Search itself will be entirely off until being turned on. There’s nothing in this blog post to indicate whether Google Search can be turned on without also turning on Gemini." — kccqzy [c:50353893]
> （译文：对，博客确实写了 Google 搜索本身在打开之前会完全关闭；但博客里没有任何地方说明，搜索能不能在不一起打开 Gemini 的情况下单独开启。）

纽约时报那一侧的引述则来自被采访的 Google 高管：

> "If a school has banned A.I., he [Chris Phillips, vice president for education at Google] added, students “will not have access to search, and they’ll see a message from their school that indicates it’s not available.”" — jlev1 [c:50353704]
> （译文：如果学校禁用了 AI，他补充说，学生“将无法使用搜索，并且会看到学校发来的一条消息，说明该服务不可用”。）

有人把这两份材料对起来读之后，给出了全场最尖锐的一句总结：

> "Scummy wording makes it looks like google is giving more control, but it's really the opposite." — insane_dreamer [c:50356168]
> （译文：这套措辞很不要脸，让它看起来像是 Google 在给更多控制权，其实恰恰相反。）

反对者则从隐私角度给这套设计找理由：

> "From a privacy perspective, having all of this off by default is sensible. But only offering a basic product like Search if you opt into AI (when search as a capability does not need AI to function) - is newsworthy." — dan_thinks [c:50353864]
> （译文：从隐私角度看，默认把这些全关掉是合理的。但如果连 Search 这种本身并不需要 AI 才能工作的基础能力，都必须先同意 AI 才能用，那才是真正值得报道的事。）

这场的分歧点其实是「捆绑」二字：管理员拿到的到底是四个独立开关，还是一个开关带着三个附赠品。谷歌的博客没有写清楚，纽约时报引述的高管说没有分开控制，评论区因此分成了两半。

### 二、这不是功能问题，是胁迫问题

把话题从产品设置推到市场结构，最短的一条路径是这样：

> "How is this not monopolistic behavior?" — messh [c:50353749]
> （译文：这怎么就不是垄断行为了？）

展开来的是这样一段：

> "This comes off as comically evil. Disabling the AI summaries in search results is trivial, so them refusing to do so and blocking search entirely feels like a blatant attempt at coercion. Isn't it an abuse of monopoly power?" — TazeTSchnitzel [c:50353766]
> （译文：这看起来简直邪恶到滑稽。关掉搜索结果里的 AI 摘要是轻而易举的事，他们却拒绝这么做，直接把整个搜索封掉，这明显是一种胁迫。这算不算滥用垄断权力？）

懂一点反垄断法的人给了他一个更冷静的回答：

> "But they’re not CHARGING separately for search and AI, so I doubt a tying theory would hold up in court." — arctic-true [c:50354457]
> （译文：但他们并没有对搜索和 AI 分开收费，所以我怀疑「搭售」这个说法在法庭上站不住。）

但争议很快离开法条，转向更具体的权力使用方式：

> "That's what every Big Tech company has done when threatened with loss of access to their children: weaponize the children themselves with poor gaslighting to fight the adults so Big Tech gets its way." — kotaKat [c:50354760]
> （译文：每当大厂在孩子身上面临失去入口的风险时，都是这么干的：拿起孩子当武器，用拙劣的煤气灯话术去对付大人，这样大厂才能如愿。）

这段历史在评论区被反复调用。最常见的一个类比是微软：

> "That's the same argument Microsoft made with Internet Explorer." — ceejayoz [c:50354326]
> （译文：这跟当年微软捆绑 Internet Explorer 时的说法是一回事。）

有人补充了更完整的细节，说明那次捆绑是怎么一步步变成默认的：

> "MS had an Internet Explorer that was not integrated in Windows, it was like any other browser. Then they decided to build it inside Windows." — pmontra [c:50355194]
> （译文：当年微软的 Internet Explorer 并没有集成在 Windows 里，它跟别的浏览器没什么两样。后来他们决定把它做进 Windows 里面。）

反对把 Google 和微软相提并论的人也存在，理由是这次的形式不同：不是买下一个浏览器塞进系统，而是把一堆功能打包进一个学生账号必须使用的服务里。真正被追问的是：学校还有别的选择吗。

### 三、搜索到底能不能“关掉 AI”

产品层面的追问在评论区里被拆得很细。持“早就深度绑定”立场的一派说：

> "Note that Google search has been AI-powered since before AI became a thing; it's now just more advanced, and particularly, explicitly publicized." — skeledrew [c:50354458]
> （译文：注意，Google 搜索在“AI”这个词出现之前就已经由 AI 驱动了；现在只是更先进，而且被明确地宣传出来了。）

> "Well their search engine is explicitly AI-driven; no AI, no search. Like you can't have juice that doesn't contain water." — skeledrew [c:50354363]
> （译文：他们的搜索引擎明确就是 AI 驱动的；没有 AI 就没有搜索，就像不含水的果汁不能叫果汁。）

反方的反驳是时间尺度和沉没成本：

> "Schools invested enormously in Google Classroom and Google for Education, and now the deal's changing. Not for the benefit of students." — ceejayoz [c:50354388]
> （译文：学校在 Google Classroom 和 Google for Education 上投入巨资，现在合同条款变了。而且不是为了学生的利益。）

真正动手的人给出了操作性答案：

> "I added a custom search engine entry to firefox that does this, made it the default, and haven't seen an AI summary from Google since I did that." — Polizeiposaune [c:50355475]
> （译文：我给 Firefox 加了一条自定义搜索引擎条目来干这件事，把它设成默认，从那以后就再没见过 Google 的 AI 摘要。）

（他的完整做法是在查询 URL 后面加 `&udm=14`。）这句之后紧跟着一句更工程化的判断：

> "Hiding one div is 90% of the solution." — Dylan16807 [c:50358371]
> （译文：藏掉一个 div 就解决了 90% 的问题。）

还有一条不肯买账的：

> "It’s not integrated, they are lying" — lokar [c:50355617]
> （译文：那不叫集成，他们在撒谎。）

这三条摆在一起，“深度整合”这句话就站不住脚了：一个参数、一个 div、一次设置就能拆掉大部分 AI 摘要。评论区的结论偏悲观：所谓“无法分开”，更多是产品默认值的产物，而不是技术上的必然。

### 四、绕得过去吗：网络拦截、没有电脑的孩子、和正在流失的用户

假设学校真的把搜索关掉，学生怎么办。答案很快出现，而且比想象中难：

> "The schools thought of that. Every connection (at least on my school laptop) is MITMed." — MetalBreaksAndB [c:50355243]
> （译文：学校想到这一点了。至少在我学校的笔记本上，每一条连接都被中间人拦截了。）

老师视角的补充更具体：

> "You can't count on kids having access to personal computers. And sometimes the computer is the class. I taught graphic design, and even though the kids all had licenses to use the Adobe suite at home, few actually could." — jdiff [c:50359322]
> （译文：你不能指望孩子们有条件用到自己的电脑。有时候电脑本身就是那堂课。我教过平面设计，即便孩子们家里都有 Adobe 全套授权，真正用得上的也没几个。）

而对搜索的依赖，往往是在学校这种“没有替代品”的环境里形成的：

> "It would be odd for a major search engine to just not be available at my school, I feel." — antiframe [c:50357748]
> （译文：一家主要搜索引擎在我学校直接不可用，这事想起来有点怪。）

于是评论区出现了对未来最担心的一层：

> "All those kids will get used to whatever other search they can use." — 6thbit [c:50354011]
> （译文：那些孩子会习惯上他们能用的别的搜索引擎。）

对应的乐观派则说，习惯早就在别处形成了：

> "Kids already use ChatGPT as their search engine. Which is precisely the reason Google doesn't want to compete with one hand tied behind their back." — ralph84 [c:50357323]
> （译文：孩子们早就把 ChatGPT 当搜索引擎用了。这恰恰是 Google 不想在捆住一只手的情况下参与竞争的原因。）

> "They don't care, they think traditional search is already dead and are trying to jump ship to save the company." — brainwad [c:50355167]
> （译文：他们不在乎，他们认为传统搜索早就死了，这套做法是为了跳船自救。）

这部分的分歧其实比看起来温和：如果学生早已转向对话式搜索，那么关闭传统搜索对他们的伤害，可能小于校方预估的那么多。

### 五、教育的目的到底是什么：教搜索，还是教工具

另一条线争的是更本质的东西——搜索这件事本身值不值得教。反对把 AI 摘要等同于搜索的人，搬出了「出版社硬塞书摘」这个类比：

> "This is like a book publisher refusing to sell books to schools without including spark notes on the inside cover." — morkalork [c:50355000]
> （译文：这就像出版社不肯把书卖给学校，除非在扉页上塞进一份剧情摘要。）

而认为重点不在工具的人，指出的是原始资料能力：

> "How the sausage is made is irrelevant when the goal is to get students to research primary sources of which Google AI summaries cannot be." — rockskon [c:50359374]
> （译文：当目标是让学生去查原始资料、而 Google 的 AI 摘要根本做不到这件事时，香肠是怎么做的并不重要。）

最简单的一派干脆主张回到纸笔：

> "For responsibile learning, focus on pencil, paper, and books." — 0c3ca83 [c:50354099]
> （译文：谈负责任的学习，就该把重点放在铅笔、纸和书上。）

这句被顶了上来：

> "Very narrow minded approach, why not use the tools available? Experimentation is one of the best ways to learn, breaking stuff is a great way to learn." — mym1990 [c:50354185]
> （译文：这种思路太狭隘了，为什么不用现成的工具？试错是最好的学习方式之一，把东西弄坏更是很好的学习方式。）

两种主张的共同点其实不冲突：不希望 AI 摘要代替学生做判断，和允许学生使用工具，可以同时成立。分歧点在于，Google 这次改的是默认值，而默认值决定的是默认会发生什么。

### 六、HN 自己也出了场：标题被换成公关稿

这条讨论在中途被一段 HN 内部的争议打断。帖子最初是纽约时报原文，但 HN 页面上一度被换成了 Google 的官方博客，标题也从报道标题变成了《Designing responsible AI for learning》。提交者 ceejayoz 表示不满：

> "If the mods are gonna Orwell this, at least take my name off it." — ceejayoz [c:50353886]
> （译文：既然审核要这样奥威尔化，那至少把我的名字去掉。）

moderator tomhow 给出的解释是既有规则：

> "The exception to this this where a source contains significant additional information that is not in the original source, which, as commenters have pointed out, seems to be true in this case." — tomhow [c:50354441]
> （译文：例外情况是，当一个来源包含原始来源里没有的重要额外信息时；正如评论者所指出的，这个帖子似乎正是这种情况。）

标题后来被改了回来，但这段插曲本身成了讨论的一部分。评论区里最老派的一句评价，是说 Google 已经「离不要作恶走了很远」——这条评论后来被折叠，原帖页已搜不到，这里只作转述。

关于正文本身，还有一个实用提醒，来自付费墙：

> "Also you can click the archive link that op posted and read it there without paywall." — randomNumber7 [c:50353751]
> （译文：另外，你可以点开楼主贴的存档链接，在那里绕过付费墙读原文。）

### 七、Search 第一次不到一半：49.7% 这组数字

配图帖里的讨论，比主帖更冷，也更具体。有人先给这组数字降温：

> "Somewhat impressive that search share of revenue is 5% down, but search revenue is 12% up.." — dumberquestions [c:50292079] [thread 2]
> （译文：搜索占营收的份额跌了 5 个百分点，但搜索收入涨了 12%，这还是相当亮眼的。）

也有人认为这恰恰是好事：

> "Isn't this good news because they're diversifying their streams?" — lab14 [c:50292058] [thread 2]
> （译文：这难道不是好消息吗，说明他们在分散收入来源。）

讨论很快落到广告主身上：

> "They still bring 250B ads dollars to google search, meaning it provides more than 250B value to them," — andriy_koval [c:50292990] [thread 2]
> （译文：他们仍然从 Google 搜索带来 2500 亿美元的广告收入，也就是说搜索为他们提供的价值超过 2500 亿美元。）

而替代渠道的选择并不多：

> "What other channels? The alternative on search is Bing and it's a tiny market. Then there's display which is total dog shit." — morkalork [c:50292952] [thread 2]
> （译文：还有什么别的渠道？搜索的替代品就是 Bing，而那是个小得不能再小的市场。展示广告则完全是垃圾。）

财务数字本身的争议则集中在预期差上：

> "Earnings per share.  Analyst expectations were for $3.01 and it came in at $2.12." — nostrademons [c:50292879] [thread 2]
> （译文：每股收益方面，分析师预期是 3.01 美元，实际是 2.12 美元。）

> "While not negative, it seems that their total revenue and EPS was still lower than forecast, hence GOOG stock being down 15% today." — nerevarthelame [c:50292416] [thread 2]
> （译文：虽然不算负面，但他们的总营收和每股收益都低于预期，所以 GOOG 股价今天跌了 15%。）

也有人认为这份财报的“难看”有技术性原因：

> "It's basically due to their large share in SpaceX, which they have to mark to market at the end of the quarter." — gniv [c:50294101] [thread 2]
> （译文：这基本是因为他们持有大量 SpaceX 股份，需要在季度末按市价计价。）

### 八、“注水”指控、1320 亿美元资本开支，和 YouTube 之争

配图帖还带进了一条跑偏但很热闹的支线：有人转发帖子，指控 Google 在给财报“注水”。一位长期持有 Google 股票的评论者把这条指控的法律边界说清楚了：

> "Lying on financial statements is in fact illegal. Juicing implies that some number is being misrepresented as higher than it otherwise would be which is a form of lying and thus would be illegal." — ericmay [c:50292955] [thread 2]
> （译文：在财报上撒谎其实是违法的。“注水”意味着某个数字被夸大了，而这就是一种撒谎，因此同样违法。）

质疑方则拿资本开支当挡箭牌：

> "Google has spent $132 billion on capex this year. Most of that money is going to GCP." — HDThoreaun [c:50294079] [thread 2]
> （译文：Google 今年花了 1320 亿美元资本开支，其中大部分流向 GCP。）

Google Cloud 的真实体量是这场争论里更正的一处：

> "In the past quarter, Google Cloud's revenue was ~$30B, just shy of Azure (~$33B) and well shy of AWS (~$45B). That's about 28% of the cloud computing market excluding other players." — whakim [c:50296803] [thread 2]
> （译文：上个季度，Google Cloud 的营收大约 300 亿美元，略低于 Azure（约 330 亿），远低于 AWS（约 450 亿）。算上其他玩家，约占云计算市场的 28%。）

另有支持者说云这行根本不构成护城河：

> "It's not a moat because it's a commodity." — shadowgovt [c:50293406] [thread 2]
> （译文：它不是护城河，因为它就是商品。）

这轮讨论最后滑向了 Google 到底做成了哪些产品。老派观点是：

> "Google really had developed only 2 good products(not including acquisitions such as YouTube): search and gmail." — theplumber [c:50292115] [thread 2]
> （译文：Google 真正自己做出来的好产品只有两个（不算 YouTube 这类收购）：搜索和 Gmail。）

反驳同样直接：

> "It's absurd to say that Google did not develop YouTube. They acquired it at a point where it was a galaxy-scale cash incinerator and made it work economically using their superior platform." — jeffbee [c:50292148] [thread 2]
> （译文：说 Google 没有发展 YouTube 太荒谬了。他们收购它的时候，它正是一个星系规模的现金焚烧炉，是他们靠自己的平台让它在经济上跑了起来。）

这条支线还顺手留下了两个常被引用的细节：

> "Chrome logs every site you visit with the mothership, and that is very valuable data to Google." — mlmonkey [c:50292646] [thread 2]
> （译文：Chrome 会把你访问的每个网站都记录到母公司那里，这对 Google 来说是非常有价值的数据。）

> "At least 30% of Americans use an ad blocker." — drnick1 [c:50293241] [thread 2]
> （译文：至少有 30% 的美国人使用广告拦截插件。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 这本来就是 opt-in | djoldman | 博客写明搜索默认关闭，是管理员自己打开 |
| 博客没说清能否拆开 | kccqzy | 博客里找不到“能只开搜索不开 Gemini”的说法 |
| 措辞在偷换概念 | insane_dreamer | 看起来是给控制权，其实是反着来 |
| 默认全关在隐私上合理 | dan_thinks | 隐私上应该关，但搜索不该被捆绑 |
| 这是垄断行为 | messh | 怎么就不算垄断 |
| 关掉 AI 摘要很容易 | TazeTSchnitzel | 不关摘要是能做到的，整封搜索才像胁迫 |
| 搭售在法律上站不住 | arctic-true | 没对搜索和 AI 分开收费 |
| 拿孩子当筹码 | kotaKat | 威胁拿走孩子的入口，逼家长让步 |
| 这是当年捆绑 IE 的翻版 | ceejayoz | 跟微软当年一个套路 |
| 搜索本来就是 AI 驱动 | skeledrew | 没有 AI 就没有搜索 |
| 一个参数就能拆开 | Polizeiposaune | 加 `&udm=14`，AI 摘要就不再出现 |
| 藏一个 div 就够 | Dylan16807 | 工程上没什么难度 |
| 学校网络会拦截 | MetalBreaksAndB | 学校笔记本上的每条连接都被中间人过一遍 |
| 孩子用不上自己的电脑 | jdiff | 我教平面设计，有授权的没几个真能用 |
| 会流失到别的搜索 | 6thbit | 那些孩子会习惯上别的搜索引擎 |
| 搜索早就被聊天取代 | ralph84 | 孩子早就拿 ChatGPT 当搜索引擎 |
| 搜索引擎不能缺 | antiframe | 主要搜索引擎在学校不可用，想起来就怪 |
| 拒绝在扉页塞书摘 | morkalork | 出版社硬塞剧情摘要的感觉 |
| 重点是原始资料 | rockskon | 目标是查一手资料时，香肠怎么做不重要 |
| 该用就用工具 | mym1990 | 试错是最好的学习方式 |
| 份额跌了但收入在涨 | dumberquestions | 占比掉 5 个点，搜索收入还涨 12% |
| 替代渠道很有限 | morkalork | 搜索的替代品只有 Bing |
| EPS 大幅低于预期 | nostrademons | 预期 3.01 美元，实际 2.12 美元 |
| 注水指控需要证据 | ericmay | 财报撒谎是违法的，不能靠推文定性 |
| 资本开支在压利润 | HDThoreaun | 今年 1320 亿美元资本开支，多数流向 GCP |
| 云其实已经追上来了 | whakim | GCP 约 300 亿美元，约占云市场 28% |
| 云不是护城河 | shadowgovt | 它是商品 |
| Google 自研产品就两个 | theplumber | 搜索和 Gmail |
| YouTube 是 Google 做起来的 | jeffbee | 收购时它是现金焚烧炉，是平台让它活下来的 |

## 总体情绪

这场讨论的起点是愤怒，落在 Google 的一个产品默认值上——学校要 AI 开关，Google 顺手把搜索也绑了进去；愤怒之后紧跟着一层更冷的现实：搜索确实早就不是「不靠 AI 也能跑」的老东西了，排序、摘要、结果页都缠在一起，所以想拆开的人只能去用一个查询参数，或者去改一行 HTML。

分歧最大、也最有意思的地方在第三层：当评论者开始讨论学生实际会不会受影响时，两派人竟然在同一个方向上会合——反对者也承认，如果搜索早就由 AI 驱动了，如果学生早就在用对话式搜索，那么关掉它未必像看上去那么致命。真正被反复拿出来讨论的，不是技术可行性，而是权力形状：一家公司的默认设置，能决定一间教室里能不能查资料；一个拥有近半壁江山营收的业务，能被当作谈判桌上的筹码。

配图帖带来的另一个提醒同样具体：同一个搜索业务，在财报上第一次不到 Alphabet 的一半，并且那不是萎缩，而是别处涨得更快。评论区为此吵了两个方向——有人觉得是多元化，有人觉得是支柱松动，还有人顺手把「注水」的指控翻了个底朝天，最后停在一句法律常识上。

两场讨论的共同点是：所有人都在算同一笔账，只是有人算的是 Google 有多霸道，有人算的是 Alphabet 有多健康。而当一个产品同时是这两笔账的主角时，它就不需要藏起自己的意图。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | HN 主帖：Google will turn off search for schools that reject AI（554 分，374 条评论） | <https://news.ycombinator.com/item?id=50353192> |
| 2 | 配图帖：Google Search is now less than half of Alphabet's revenue（431 分，354 条评论） | <https://news.ycombinator.com/item?id=50291945> |
| 3 | 原文：Google Will Turn Off Search for Schools That Reject A.I.（纽约时报） | <https://www.nytimes.com/2026/11/03/us/google-search-schools-restrict-ai.html> |
| 4 | 原文：For the first time ever, Google Search is less than 50% of Alphabet's revenue（Company Atlas） | <https://www.kadoa.com/companies/insights/google-search-below-half> |
| 5 | Google 官方博客：Designing responsible AI for learning | <https://blog.google/products-and-platforms/products/education/ai-learning-era-updates-2026/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 2026-11-04 01:05 UTC 归档的 HN 评论（主帖 111 条、配图帖 114 条）、Google 官方博客与 Company Atlas 原文。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。纽约时报原文正文在付费墙后，涉及该报的内容以评论区原文转述与 Google 官方博客为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
