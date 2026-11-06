---
layout: post
title: >-
  Kagi 开放免账号搜索：白送 50 次查询，然后争论定价、Yandex 与地图短板 — HN 讨论摘要
date: 2026-11-06
hn_id: 50383740
categories: [articles]
excerpt: >-
  Kagi 让所有人免账号搜 50 次，想用口碑换回付费订阅。评论区当场拆三笔账：免费额度靠客户端
  计数怎么拦、本地商家搜索凭什么打不过 Google、以及 Yandex 那 2% 的成本到底该不该付。
tagline: >-
  为了让你去安利 Kagi，先给你免单 50 次。
---

> 来源：HN 讨论主帖 [Search for everyone](https://news.ycombinator.com/item?id=50383740)（498 分，236 条评论），原文是 Kagi 2026 年 11 月 5 日的更新日志 [Your friends and family can finally try Kagi](https://kagi.com/changelog#11820)。本篇为 single post 模式；归档快照 2026-11-06 01:24 UTC，入库 100 条评论，更新日志正文按 8000 字符截断。

## 原文概要

2026 年 11 月 5 日，Kagi 在更新日志里挂出第 11820 号条目，标题是"Your friends and family can finally try Kagi"，小标题 "Search for everyone"。核心动作只有一句：任何人、不限地区，现在直接访问 kagi.com 就能搜网页，前 50 次搜索不需要账号，注册之后再给 100 次。

这次改动的逻辑是渠道问题。Kagi 强调自家"任何地方都不跑广告"，靠社交媒体和社区维持曝光，增长主要靠用户推荐。而推荐一个搜索引擎的前提是对方能直接试用——过去不能白用，就成了转化链上最厚的一层摩擦。免费额度在这里是拉新工具：先让朋友搜 50 次，用顺手了再谈订阅。

Android 端同期做了一轮重构：主页重做并直接显示剩余免费次数，语音搜索单独做了页面，支持选语言、加了快设置磁贴，支持把图片粘贴进搜索框做以图搜图，搜索建议旁边加了 Quick Answer 按钮，bang 搜索跟随 Result Opening 设置，Privacy Pass 在 token 轮换后白屏的问题也修了。

同一份更新日志还顺手回应了一条行业新闻：Google 宣布从 2027 年初起，学校账号默认关闭 AI 工具，而 Google Search 会跟着一起关掉。Kagi 的表态是"教育不该被广告公司劫持"，并发了一封公开信 Education Shouldn't Be Held for Ransom。

有意思的是，这份日志的修复清单本身就在替免费机制打补丁：其中 "100 searches trial gate query flows out of box" 和 "100 searches trial gate shows urlencoded query if session token in url" 两条，都在修试用额度门槛的查询流程。可公告正文写的是免账号 50 次、注册再给 100 次，门槛数字与清单里的说法并不完全对齐。

## 讨论焦点

### 一、50 次额度到底拦不拦得住

最先被拆的就是免费额度的实现方式。laughing_snyder 一句话点到要害：

> "Isn't the whole point of this announcement that you don't need an account? The 50 searches they mention is just client side stored. if you don't store cookies for kagi.com you have unlimited searches." — laughing_snyder [c:50384728]

额度如果只记在客户端 cookie 里，删掉 cookie 就等于无限。lapcat 的问题更直白：

> "How are they going to enforce the 50 search limit? IP address?" — lapcat [c:50385896]

绕过方式已经有人写成了操作手册。phyzome 的做法是给 kagi.com 的搜索 URL 挂一个关键词前缀 `k`，在 Firefox 里搜 `k giant isopod` 直接跳结果页，token 从设置里拿：

> "Note that that also works in private browsing windows, whether you want it to or not." — phyzome [c:50386092]

同一篇帖子里，ID 里带 kagi 的 khaleel-kagi 还在追问 Android app 到底哪里出错（他问了两次），地图团队的 dylan 也在下面回应。

### 二、广告才是真正的对手

bbor 是这条线的典型代表，他把"不用广告的搜索"和"用广告的搜索"之间的差距说成了两倍价：

> "Using a search engine without ads is such a life improvement that it’d be a steal at twice the price." — bbor [c:50384261]

同一段里他还补了一句针对"广告对我无效"的标准反驳：

> "if you think ads don’t work on you, you’re just not aware enough. Ads work on everyone —in the moment and otherwise- and search ads are the most effective ads in history." — bbor [c:50384261]

对 Google 的抱怨则具体到结果构成。throwaway219450 说的是软件类搜索：

> "And every software-related search returns GeekForGeeks slop instead of the actual docs. And they wonder why traffic is going to agents?" — throwaway219450 [c:50384703]

CSSer 讲的是更底层的一层，他对身边人的观察是连 web 本身的经济学都没人算得清：

> "Even people working close to us seem to have no conception of the economics of the web. Kagi is, practically speaking, an activist's service." — CSSer [c:50384648]

他描述的场景很具体：昨晚社交场合，一个号称懂 AI 的项目经理听说他维护的社区资源站因为流量涨了、带宽和算力都要花钱，直接问"算力是什么"。也有人认为免费替代已经够用：

> "I mean, I think for average internet user the existing free alternatives are more than good enough." — druskacik [c:50384469]

### 三、Yandex：那根一直扎着的刺

免费额度之外，本帖最大的裂缝其实是旧的。Kagi 的结果源里长期有 Yandex，这在 Kagi 社区被反复提，已经是一条固定议题，有人在这里直接贴出了旧帖链接。

抵制的理由写得很直白：

> "I'll re-subscribe to Kagi instantly the moment they announce they stopped paying Russian businesses (for data). That is the only showstopper for me." — jwr [c:50384675]

ActionHank 说自己因此直接退订：

> "Final point was their published and then unpublished support of Yandex." — ActionHank [c:50384311]

Kagi 给的说法是成本占比，linster 在评论里转述了官方表述：

> "“Yandex represents about 2% of our total costs and is only one of dozens of sources we use”" — linster [c:50384804]

> "OP in the linked thread wanted to boycott Russia and Russian businesses. The “context” is that Kagi gives money to Yandex." — linster [c:50384804]

Mawr 抓住这个 2% 反问：

> "So it should be easy to cut then. It's literally an argument for removing it, not for keeping it." — Mawr [c:50386056]

LeBit 则把 Kagi 的姿态概括成一句话：

> "The answer from them : we are unimpressed by world politics." — LeBit [c:50384837]

反对抵制的一方也有明确论证。MostlyStable 说自己同样强烈支持乌克兰，但认为抵制没有用：

> "But I do not see in the slightest how boycotting Kagi, or any other company who technically does business with some entity in Russia, helps the Ukrainians." — MostlyStable [c:50385070]

他的落点是：真正能改变的是政治层面的压力，而不是取消一次订阅。krupan 的提问方向相反，他不接受"换个引擎就更干净"这个前提：

> "I'm not at all a supporter of Putin and his wars. A question for you though: does DDG show ads for any evil companies? Where does DDG get it's search results?" — krupan [c:50385923]

### 四、地图与本地商家：明确打不过的那块

本地搜索是评论区口径最一致的地方：这是 Kagi 的结构性短板。ActionHank 说得直接：

> "How do you deal with searches for local businesses? I've found these to be a big blind spot vs DDG / Google." — ActionHank [c:50384710]

dotancohen 干脆按查询类型分流：

> "Am I searching for a local business? I go to Google." — dotancohen [c:50385352]

> "Am I searching for the range of input voltages an Arduino can safely handle? Kagi." — dotancohen [c:50385352]

SparkyMcUnicorn 是拿 Kagi 的 !gm（跳 Google Maps 的 bang）跟 Kagi Maps 对着比：

> "But Google Maps has been getting worse over time for me, and I want something better." — SparkyMcUnicorn [c:50385641]

> "I just went through my recent !gm history, compared it to Kagi, and I'm impressed with the results and that things like ratings are there" — SparkyMcUnicorn [c:50385641]

地图团队的 dylan 在下面承认了延迟问题：

> "Latency is a weak link rn for sure (from aggrigating so many 3rd party data providers) but we have a solution we're working through for that" — kagi_dylan [c:50384938]

### 五、客户端摩擦：app、扩展，和"必须登录"

老订阅者吐槽最多的还是登录与客户端。furyofantares 说他最大的痛点是搜索时撞上登录页：

> "It is supremely frustrating to search for something and be met with a login screen instead, and enraging if I can't immediately solve it by logging in." — furyofantares [c:50384743]

Android app 的负面反馈同样具体。bdzr：

> "I've found the assistant, particularly the android app, to be buggy as all hell." — bdzr [c:50384487]

neogodless 的版本是直接跑不起来：

> "I recently tried the Android App, and could not get it to function." — neogodless [c:50384618]

客户端问题的归属，freediver 的解释指向浏览器厂商，他自己的落点是 Kagi 自家做的 Orion 浏览器：

> "It is one of the reasons we created Orion - same lightweight, native Safari experience but integrated with Kagi." — freediver [c:50384623]

也有人在评论里把矛头指向 Kagi 的历史决策：

> "Kagi is HN’s favorite darling, but their leadership constantly makes anti-user, bad business decisions." — pprotas [c:50384490]

### 六、真正被认可的东西

正面评价集中在信噪比和小众内容上。egecant 说的是 Kagi 的 Smallweb 功能：

> "I love Kagi. I especially appreciate how it pushes back against AI slop and makes the web feel more human again." — egecant [c:50384302]

> "I've actually replaced doomscrolling with browsing random personal blogs and discovering interesting corners of the internet." — egecant [c:50384302]

pedro_caetano 的理由更偏专业用途——找 prior art：

> "Arguably this can be achieved with frontier models but my experience is that Kagi is vastly more exhaustive and well I don't need to ask for references because they are indexed in the search itself." — pedro_caetano [c:50384773]

关于 AI 额度，有人给出相反的使用体验：

> "I use Kagi Assistant on the $10/mo plan for literally everything I would have used Google for before and have never burned my monthly credits." — gamegod [c:50384472]

而订阅者身份带来的确定性，是 gxs 最在意的：

> "It’s also cool to be a paying customer - you email them, they respond, and sometimes even fix a bug right away for you" — gxs [c:50384396]

jeremyjh 那种"被谷歌伤过"的用户视角，是这条线上的高频表达：

> "Every single time I accidentally use Google I am shocked at how terrible it is. People just haven’t seen the alternatives." — jeremyjh [c:50384650]

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 免费额度是最低成本的拉新 | laughing_snyder | 免账号 50 次，正是为了让口碑传播跑起来 |
| 额度靠客户端 cookie 计数，形同虚设 | lapcat | 靠 IP 限流？换台设备就绕过去了 |
| 广告才是真正的代价 | bbor | 不用广告的搜索，好到两倍价都值 |
| 抵制 Yandex 是唯一条件 | jwr | 只要停掉给俄罗斯业务的付款，我立刻续订 |
| 抵制对战争没有实际作用 | MostlyStable | 真正有用的是给议员写信，不是取消订阅 |
| 本地搜索就是得用 Google | dotancohen | 查商家去 Google，查技术参数去 Kagi |
| 现有免费替代已经够用 | druskacik | 对普通网民，凑合用的方案一直都有 |
| 免费体验被 AI 额度烧穿 | ActionHank | AI 搜索烧额度太快，地图集成又不稳 |

## 总体情绪

这场讨论表面上是一次产品公告，实际上把付费搜索最难回答的两个问题摊在了同一张桌子上：搜索到底该由谁买单，以及一个不接广告、只收订阅的服务，在钱从哪来和世界政治面前该怎么站。

值得注意的火气并不在"免费额度会不会养出用户又收不到钱"上。真正被反复争论、被割的是 Yandex。这条线从 Kagi 集成 Yandex 的那天起就没断过，这次免费额度只是把它又顶到了前面：官方给的比例是 2%，反对者要的是 0%，两边都清楚对方不会让步，于是这条线以"我取消订阅了"和"我写了信给议员"两种方式收尾。

另一端的情绪要平和得多，也更接近日常使用：评论里谈 Kagi 使用体验的部分，谈的是搜索结果的质量、地图的短板、app 的 bug，以及"不用广告"带来的具体生活差异。免费额度在这些评论里的作用被说得很直白——它不解决任何技术问题，只是把"推荐给朋友"的摩擦降到零。

真正被这 50 次搜索撬动的，是过去那些想推荐 Kagi 却开不了口的人：他们中的大多数不是不支持无广告搜索，而是没法让对方先试一次。免费额度改变的不是搜索本身，是"安利"这件事第一次不需要付费试用成本。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Search for everyone（HN 主帖） | <https://news.ycombinator.com/item?id=50383740> |
| 2 | 原文：Kagi 更新日志 #11820 — Your friends and family can finally try Kagi | <https://kagi.com/changelog#11820> |
| 3 | Kagi 公开信：Education Shouldn't Be Held for Ransom | <https://blog.kagi.com/education-should-not-be-held-for-ransom> |
| 4 | Kagi 社区旧帖：重新考虑 Yandex 集成的地缘政治争议 | <https://kagifeedback.org/d/5445-reconsider-yandex-integration-due-to-the-geopolitical-status-quo> |
| 5 | 相关 HN 讨论：Google will turn off search for schools that reject AI | <https://news.ycombinator.com/item?id=50353192> |
| 6 | Kagi Smallweb | <https://kagi.com/smallweb/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖共 236 条评论，归档快照 2026-11-06 01:24 UTC，入库 100 条）及原文抓取内容（Kagi 更新日志 #11820，归档按 8000 字符截断）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中提到的 Yandex 成本占比来自评论者转述的 Kagi 官方说法，本次未对官方页面二次核实；本文只做讨论转述，不构成对相关产品或任何一方的结论性判断，实际功能请以官方文档为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
