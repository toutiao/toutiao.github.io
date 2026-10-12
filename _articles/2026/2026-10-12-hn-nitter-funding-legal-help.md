---
layout: post
title: >-
  Nitter 没钱没律师——HN 讨论摘要
date: 2026-10-12
hn_id: 50041682
categories: [articles]
excerpt: >-
  X Corp 连发两份停止侵权函后，Nitter 创始人 zedeus 公开承认找不到代理律师，只能发帖求援。
tagline: >-
  替代品死了，主站还在好好过日子。
---

## 原文概要

Nitter 项目官网（nitter.net）于 2026 年 10 月 10 日挂出紧急公告：长期维护者 zedeus 公开承认"项目目前没有任何代理律师"，正在寻求资金与法律援助。HN 主帖只贴出官网链接，标题即点出"seeking funding and legal help"，24 小时内冲到 379 分，评论数截至抓取时已达 165 条。

事件坐标从公告原文里直接抓：8 月 24 日，X Corp 向 Nitter 各个实例及项目仓库送达第一份停止侵权函（C&D）；9 月 8 日又送出第二份，连同样诉求与诉讼警告。9 月 7 日的公告曾保证"项目将在代理律师到位后继续"，这条承诺目前已被 zedeus 自己撤回——公告原文写得很坦白："That was based on assurances I received and believed, which have since turned out to be untrue."

故事最让人警觉的细节不是 C&D 函的法律威胁本身，而是公告里那句几乎不留退路的总结——**Nitter currently has no legal counsel.** 一个曾经承载百万级日活的去中心化镜像项目，如今面对的是一份接一份的律师函，加上一张"无可奉告律师"的对外公告。

## 讨论焦点

### 1. Nitter 到底是什么

讨论第一刀切的是"它到底是什么"。1ba9-115454 在主帖下面给出最实用的科普：

> "Nitter is/was a free, open-source alternative front-end for X (formerly Twitter) that lets users view public posts without an account, ads, or tracking scripts." — 1ba9115454 [c:50042028]
> （"Nitter 是一个（或曾是）免费、开源的 X 前 Twitter 替代前端，让用户不用账号、不看广告、不被追踪脚本，就能看公开推文。"）

andsoitis 顺着科普追问实现机制：

> "> that lets users view public posts without an account, ads, or tracking scripts what’s the mechanism they use to get this content?" — andsoitis [c:50042052]
> （"「让用户不用账号、不看广告、不被追踪脚本就能看公开推文」——他们是用什么机制拿到这些内容的？"）

cowlevel 把答案压到最短：

> "HTTP. They just load the page while logged in to one of the server's accounts." — cowlevel [c:50042521]
> （"HTTPS。他们用一个登录态的服务器账号去拉页面。"）

schleck8 把机制补成一句话：

> "The emphasis is on the authenticated session on their end, atleast since Musk locked down X access. It's basically a proxy." — schleck8 [c:50045179]
> （"重点在服务器侧的已认证 session——至少从马斯克收紧 X 访问之后是这样。本质上是个代理。"）

mitxela 在另一条里补充，Nitter 死了不代表镜像生态死了：

> "It's still lasting. Use xxcancel.com to be redirected to a random server." — mitxela [c:50042105]
> （"它还在活。去 xxcancel.com，会被重定向到一个随机实例。"）

skeledrew 一句话把气氛压扁：

> "Well, it was good while it lasted." — skeledrew [c:50042084]
> （"好吧，开心过就好。"）

accountrequired 在讨论末尾用 Hitchhiker's Guide 的梗收尾：

> "> "or its successor" So long and thanks for all the fish." — accountrequired [c:50042487]
> （"「或其继任者」。再见，多谢所有的鱼。"）

### 2. 法律能立得了吗

讨论最刚到骨头上的是第二条线——它合法不合法。bhouston 把判例拉到一边：

> "I don’t think nitter can run legally. It would be like having a proxy for nytimes or cnn. I think its (or systems like it) only possible future is to acknowledge it doesn’t have a legal future." — bhouston [c:50042094]
> （"我不觉得 Nitter 能合法运行。它就像给纽约时报或 CNN 做个代理。它（或类似系统）唯一可能的未来，是承认自己没有一个合法的未来。"）

DoctorOetker 把这条类比拆穿：

> "There is a strong distinction between news articles authored by or on behalf of a company, versus user generated content. So I don't think nytimes, or cnn is an apt comparison. It's more like your cellular provider claiming intellectual ownership over the web you browsed and conversations you read when people start sharing their downloaded pages." — DoctorOetker [c:50042464]
> （"（"纽约时报或 CNN 的类比不成立——新闻文章是公司原创或代为发布的，用户生成内容不是。这更像是你的运营商说，你浏览的网页、你读的对话，知识产权归他们所有——只是因为有人开始分享自己下载下来的页面。"）

cowlevel 把版权这一关钉死：

> "NY Times would get you for copyright infringement, but X has no copyright in the content on X." — cowlevel [c:50042527]
> （"纽约时报会告你版权侵权，但 X 对 X 上的内容没有版权。"）

kmeisthax 把这条路堵死：

> "Yes, but that's not a high hurdle to clear. All Twitter has to do is have an exclusive content program, and now they have standing to sue for copyright infringement on those exclusively-licensed Tweets. The burden falls on Nitter instance hosters to filter that out. And there is no legal obligation on Twitter to actually provide reliable signals to block exclusively licensed content." — kmeisthax [c:50046040]
> （"没错，但这门槛不高。Twitter 只要搞一个'独家内容计划'，就站到了能对那些被独家授权的推文发起版权诉讼的位置。负担落在了 Nitter 实例运营者头上，得去过滤掉这些内容。而 Twitter 在法律上没有义务真的给出可靠的信号，让你能识别'独家授权内容'。"）

hagbard_c 从另一侧顶回：

> "Of course it can run legally. What might not be possible is to open a running instance to the general public, certainly not to paying public but an argument could be made that even allowing free access would violate some law or other. This is not a certainty though and the continued existence of products like Opera Mini speak against there being such legal prohibitions to allowing public access to content-changing proxies." — hagbard_c [c:50046160]
> （"当然能合法运行。不可能的只是把实例开给公众——哪怕是付费公众都不行；不过也有人会争辩：哪怕是免费开放也会违反某条法律。这事没有定论——Opera Mini 一直活到现在，本身就反驳了'不许向公众开放内容变换代理'这种法律禁令的存在。"）

讨论到这一节，两边各自站稳——一边认为 Nitter 跨不过版权门槛，另一边认为只要不缓存、不公开成实例，技术上不存在必然违法的路径。共识是零，但事实层面的拼图已经拼完。

### 3. 旁观者效应：用户不捐

rvz 在主帖下面把"会不会有人捐"摆上桌：

> "Let’s be honest, They won’t. The users won’t fund it, as they want to use it for free. This is what happens when people say they will “donate” but will actually wait for others to do it and little to no one donates. What you are seeing is the bystander effect. It is why projects like Nitter will end up raising capital from VCs as they actually have money." — rvz [c:50042008]
> （"坦白说，他们不会。用户不会掏钱——他们想白嫖。每次有人嘴上说'我会捐'，结果都在等别人先捐，最后几乎没人掏钱。你看到的正是经典的旁观者效应。这也是为什么 Nitter 这种项目最终会从 VC 那里募到钱——因为 VC 真有现金。"）

rwmj 把这条推到 VC 端：

> "Seems an unlikely investment for a VC. Xitter can shut down Nitter any time they want, and the end users don't want to pay for it." — rwmj [c:50042068]
> （"对 VC 来说这不太像一笔划算的投资。X 可以随时关停 Nitter，终端用户又不愿掏钱。"）

cowlevel 把"VC 接盘"的可能路径具体化：

> "That's exactly what VCs are good for. Cities could've shut down Uber any time they wanted, but they didn't, so it grew big. There has to be a plausible path to making money though. If the purpose of nitter is to not make money, VCs won't fund it. If it substituted X's ads for Nitter's own ads, that could work, but the online ad market isn't as lucrative as it once was so it wouldn't be enough money. You could find a VC whose other project has similar legal concerns and get them to fund your legal case to set precedent, but I don't know what that project would be." — cowlevel [c:50042494]
> （"这恰恰是 VC 的强项。城市当局原本可以随时把 Uber 下线，但他们没这么做——于是 Uber 做大了。但前提是要有一条说得通的赚钱路径。如果 Nitter 的目标是不赚钱，VC 不会投。如果用 Nitter 的广告替换 X 的广告，可能行得通，但在线广告市场今非昔比，钱赚不到多少。或者找一家 VC，它旗下的别的项目也有类似的法务风险，让它出钱帮你立判例，但我不知道那是哪类项目。"）

讨论到这一段，"普通用户不会捐、VC 接盘的可能性很窄"的共识基本成型——但这条结论对 zedeus 没有帮助。

### 4. Fork 与 youtube-dl 先例

jaggs 在主帖下面抛出一个乐观方案：

> "Surely Nitter is open source and has 1.4K forks alread. So it should be easy to ramp that up to several thousand more, which can make it harder to stop? or am i being naive?" — jaggs [c:50042103]
> （"Nitter 明明是开源的，已经有 1.4K 个 fork。再多拉几千个 fork 应该不难，这样不是更难被关停？还是我太天真？"）

herunan 把 youtube-dl 先例拉出来：

> "You're not. It's kinda what happened with youtube-dl at some point." — herunan [c:50042645]
> （"你不天真。youtube-dl 当年的剧本差不多就是这样的。"）

timcobb 把战线抬到最高：

> "The legal future is whatever people fight for being legal. You see entities that are hostile to humanity making the laws they want all the time, why be so defeatist?" — timcobb [c:50043316]
> （"合法的未来，是被大家争取出来的合法。你看那些敌视人类的实体天天在制定自己想要的法律——我们何必这么认输？"）

但 Terretta 把"客户端 vs 代理"的法理边界重新画一遍：

> "Given caching, blocking, userscripts, etc., most client things are have things built in that are effectively smart proxies or glorified layer 7 application gateways. You can write your own client for arbitrary services. You can run your own client on your own hardware, and you can host your client on someone else's hardware. Your client can render the content however it likes. You can have someone else do the work to render it like you like it and run that, locally or remotely." — Terretta [c:50044865]
> （"考虑到缓存、拦截、userscripts 这些东西，大多数客户端本质上已经是智能代理，或者打扮过的七层应用网关了。你可以给任意服务写自己的客户端。你可以在自己的硬件上跑，也可以把客户端放在别人的硬件上跑。你的客户端爱怎么渲染内容都行。你也可以让别人替你做渲染——本地跑或远程跑都行。"）

asgraham 立刻把这条边界拉回来：

> "Clients are not proxies. The fundamental difference is who accesses the target server. If you’re using a client (in the sense of a local program that renders your request, like a browser or a browser with extensions) then you are the one accessing the information, and once you have that information it’s hard to make a legal argument against transforming it however you want for your own consumption. But a proxy means you request information from someone else, not from the target server, and the proxy requests from the target server." — asgraham [c:50045080]
> （"客户端不是代理。根本差别在谁去访问目标服务器。如果你在用客户端——本地程序，替你发起请求，比如浏览器或装了扩展的浏览器——访问信息的是你本人。一旦信息到了你手里，怎么变换、怎么自用，法律上很难反驳。但如果走代理，信息是由代理替你拿的，不是你本人；代理再去访问目标服务器。"）

这一组来回没有分出输赢，但已经把 Nitter 类项目在法理上的"中间地带"画得很清楚：本地使用没问题，公网实例化就是另一回事。

### 5. 谁需要 Nitter — 为什么重要

讨论第五刀切的是"谁在乎"。franga2000 给出最实用派的答案：

> "A lot of important information is on Twitter. Being able to access it without giving them your personal information and without jumping through hoops is a good thing." — franga2000 [c:50042338]
> （"大量重要信息都在 Twitter 上。能在不交出个人信息、不绕弯子的前提下访问到这些信息，是件好事。"）

fcarraldo 把"谁在乎"具体到市政公告：

> "Many local governments and municipalities use Twitter as the sole way to make announcements." — fcarraldo [c:50043650]
> （"很多地方政府和市政当局把 Twitter 作为唯一的信息发布渠道。"）

bl4kers 把这条拧成一个反讽：

> "That should be illegal, as it's not an open platform" — bl4kers [c:50045558]
> （"这本来就该被禁，因为它不是开放平台。"）

dgellow 从另一侧把"谁在乎"清零：

> "There is no important information on that platform that you couldn’t get another way" — dgellow [c:50042906]
> （"那个平台上没有任何信息是你用别的方式拿不到的。"）

franga2000 把反驳打到最高层：

> "What the people defacto running the world's most powerful economy are saying seems quite important to get from a primary source. It's so easy to take a few screenshots of a few tweets and write many completely contradictory stories." — franga2000 [c:50043146]
> （"那些事实上在运营全球最强经济体的人说了什么——从一手来源去看，似乎是件要紧的事。截几张推文截图、写出完全矛盾的报道，太容易了。"）

dgellow 同样顶回来：

> "I can assure you, you don’t need to access Twitter to get that information, they are relayed everywhere. Which is really unfortunate because they don’t deserve the attention they receive. Try for yourself, stop using the platform for like a month, you won’t miss anything of value" — dgellow [c:50043822]
> （"我可以跟你打包票，你根本不需要去 Twitter 才能拿到那些信息——到处都有人转发。不幸的是，他们（那些大人物）不值得得到这些关注。你可以自己试试，一个月别用那个平台，你不会错过任何有价值的东西。"）

jacquesm 把讨论引到公权力侧：

> "And they should be utterly ashamed of it. They give it a legitimacy that it has not deserved for years now." — jacquesm [c:50043866]
> （"他们应该为自己感到羞耻。他们给了它（Twitter）一份早就配不上的合法性。"）

Levitz 把这种"羞耻"的成因讲透：

> ">Why on earth they do that, I will never know Because some people in positions of power ignore the consequences of using external services. There has been a bit of a wake up call in this regard in Europe, with many governments making efforts to detach themselves from US corporations, but it's a much larger problem. When a government entity chooses to rely on Whatsapp, or Android, or some other piece of technology bound to a corporation, they are creating a bond between the rights and services they enable and interaction with that corporation." — Levitz [c:50043237]
> （"「为什么他们非这么做？我永远不会懂」——因为一些有权位的人不考虑使用外部服务的后果。欧洲那边有过一次警醒——多国政府开始努力把自己从美国企业身上摘下来，但问题比这大得多。当一个政府机构选择依赖 WhatsApp、Android、或任何绑定到一家公司的技术时，它就把'自己要捍卫的权利/服务'与'和那家公司之间的互动'绑在了一起。"）

讨论到这一段，"Nitter 重要不重要"的两派完全对立，但双方都同意一件事——它"重不重要"取决于 Twitter 是不是事实上的公共基础设施。

### 6. "公共广场"的归属之争

讨论最后一段回到一个老问题：Twitter 是不是公共广场。Avicebron 把十年史压成一段话：

> "> Elevator pitch if you will? For the decade+ there has been an unofficial town square known as twitter. As the town square has slowly become more gated and overgrown with weeds some people thought giving people a way to access the town square without paying the entrance fee would be helpful. Many found this useful. Now I think the whole thing is trash, and agree, why use Twitter? But people like journalists and AI executives are still announcing things on Twitter because having a large following seems like a dopamine booster. In this world where people see the following as a source of legitimacy, having a single company own that town square seems...problematic.," — Avicebron [c:50042495]
> （"「一句话概括？」十多年来，有一个被非正式称为'广场'的地方叫 Twitter。随着这个广场越收越紧、杂草丛生，有人觉得给大伙儿提供一条不用买门票就能进去的路是有用的，很多人确实觉得有用。现在我觉得这整件事就是个垃圾场——我也同意，凭什么用 Twitter？但记者、AI 公司高管仍然在那里发东西，因为在 Twitter 上拥有大量粉丝看着像多巴胺加速器。在一个把'粉丝数'视为合法性来源的世界里，让一家公司独占这个广场……这事儿看着就不对。"）

righthand 从对面把"广场"的比喻拆掉：

> "It was only a “town square” in the minds of Twitter users, no one else thinks that about a news media propped-up social network. If anything it was a comment section attached to nothing. And comment sections all get bad after a while." — righthand [c:50042867]
> （"「广场」只是 Twitter 用户脑子里的幻觉——任何外人都不这么看一个'靠新闻媒体撑起来'的社交网络。它充其量是一个挂不到任何东西下面的评论区。评论区这种东西，过段时间都会烂掉。"）

samatman 把辩论拉到纽特斯类比：

> "It seems like a reasonable question to ask and I'm surprised to see you, in particular, take this point of view. I could argue that due to the New York Times being the "newspaper of record" they should post my manifesto because, after all, it's very important. The obvious objection to this is that the NYT is privately owned, and despite having made itself very important, I don't have the right to tell them what to do. This is the obvious objection to "Twitter is important, we should get to tell it what to do" as well, and you're old enough to know that Twitter kneecapping third-party apps is not at all new to the Musk chapter of the company, either." — samatman [c:50044270]
> （"看起来这是个合理的问题——而且我特别意外你会持这个立场。我可以争辩说：因为《纽约时报》是'记录在案的报纸'，它就应该刊登我的宣言——毕竟我的宣言非常重要。显而易见的反驳是：纽特是私有的，尽管它把自己搞得非常重要，我没权利告诉它该做什么。这也就是对'Twitter 很重要，我要告诉它该做什么'这种说法的最自然的反驳——你活到这把年纪应该知道，Twitter 砍第三方应用根本不是马斯克接管后才有的事。"）

讨论收尾处，"Twitter 是不是公共广场"的争论没分出胜负——但已默认了一个事实：Nitter 的命运不取决于技术或法理细节，而取决于社会能不能把"私人平台"和"公共基础设施"这两件事分开。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Nitter 是个代理，本质是用服务器侧的登录态拉 X 的页面 | cowlevel, schleck8 | Musk 收紧 X 之后 Nitter 实际上退化成"代理" |
| Nitter 已经死了，但镜像生态还活着 | mitxela | xxcancel 仍在重定向到随机实例 |
| Nitter 跨不过版权门槛 | bhouston, kmeisthax | X 搞个"独家内容计划"就能站到起诉位 |
| Nitter 在法理上可以合法运行，但公网实例化是另一回事 | DoctorOetker, hagbard_c | Opera Mini 一直活到现在就是个反例 |
| 普通用户不会捐，VC 接盘的可能性也窄 | rvz, rwmj, cowlevel | 旁观者效应 + VC 不爱投"会被随时关停"的项目 |
| Fork 是出路，youtube-dl 是先例 | jaggs, herunan | 1.4K 个 fork 已经摆在那里 |
| Nitter 重要的理由：地方政府把 Twitter 当唯一公告渠道 | fcarraldo, bl4kers | 公权力用私有平台做公告本身就是问题 |
| Nitter 不重要：信息都从别处能拿到 | dgellow | 一个月不用 Twitter 不会错过任何有价值的东西 |
| Nitter 重要：政治人物发言需要一手来源 | franga2000 | 截几张图就能写出完全矛盾的报道 |
| 政府用 WhatsApp/Android/Twitter 是把公共服务绑到一家公司善意上 | jacquesm, Levitz | 欧洲在拆这根绳子，但拆得还不够 |
| Twitter 不是公共广场，只是 Twitter 用户脑子里的幻觉 | righthand, samatman | 纽特类比可以原样搬到"Twitter 很重要所以该听我的" |
| Twitter 是事实上的公共广场，记者和 AI 资本把它当发布渠道 | Avicebron | 拥有大量粉丝 = 在 Twitter 上拥有权力 |

## 总体情绪

评论区的情绪曲线被两条线拉成剪刀差。一条是法务线——bhouston 把 Nitter 类比为给 CNN 做代理、给纽约时报做代理；cowlevel 把版权这一关钉死；kmeisthax 立刻补出"独家内容计划"这一后门；hagbard_c 从另一侧用 Opera Mini 的先例顶回来——法理边界画得很清楚，但完全没有共识。

另一条是公共性线——Avicebron 用十年史把 Twitter 推上"广场"的位置；righthand 立刻把"广场"这个比喻拆掉；samatman 把争论拉到《纽约时报》刊登宣言的可笑类比；jacquesm 把"政府用 Twitter"钉到"政府应该为自己感到羞耻"；Levitz 把这种羞耻的成因讲透——欧洲开始拆这根绳子，但拆得还不够。

贯穿全帖最扎人的是公告底子——账户名为 accountrequired 的用户在结尾甩出一条 Hitchhiker's Guide 的梗：

> ""or its successor" So long and thanks for all the fish." — accountrequired [c:50042487]

一句几乎是告别仪式的总结：Nitter 在公告里给自己留了"or its successor"这一后门，但 zedeus 自己已经承认"目前没有任何代理律师"。这条暗线最后被 skeledrew 那句压扁成收尾：

> "Well, it was good while it lasted." — skeledrew [c:50042084]

讨论的定调几乎一边倒落在 zedeus 那句公开承认上：

> "Nitter currently has no legal counsel."

一句几乎是讣告格式的总结，把整条讨论压扁成一句：替代品死了，主站还在好好过日子。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Nitter: Update Oct 10th seeking funding and legal help | https://news.ycombinator.com/item?id=50041682 |
| 2 | Nitter 官网 10 月 10 日公告 | https://nitter.net |
| 3 | Nitter 源码（GitHub） | https://github.com/zedeus/nitter |
| 4 | Liberapay 捐赠链接 | https://liberapay.com/zedeus |
| 5 | Patreon 捐赠链接 | https://patreon.com/nitter |
| 6 | Ko-fi 捐赠链接 | https://ko-fi.com/zedeus |
| 7 | Nitter 维护者 Matrix 联系方式 | https://matrix.to/#/@zedeus:nolog.chat |

<div class="disclaimer">

本文摘要为机器辅助生成的 HN 讨论整理，仅作信息汇总之用，不代表本站立场。所有引文均来自原帖评论；观点归属原评论作者，与 AI 摘要过程无关。涉及 Nitter 项目法律状态的部分，背景信息可能在摘要发布后发生变化，请以原始来源为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>