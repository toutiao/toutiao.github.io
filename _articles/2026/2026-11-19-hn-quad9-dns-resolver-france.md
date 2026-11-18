---
layout: post
title: >-
  Quad9 退出法国，OpenDNS 先走：DNS 解析器正在变成欧洲版权执法的被告席 — HN 讨论摘要
date: 2026-11-19
hn_id: 50538994
categories: [articles]
excerpt: >-
  2024 年 6 月 OpenDNS 先退出法国，2026 年 11 月 24 日 Quad9 跟着走。比利时给每家公司开出的罚单上限是
  2000 万欧元，意大利给 Cloudflare 的罚单是 1420 万欧元。一块不生产任何内容的 DNS 解析器，成了各国版权
  执法唯一能点名的对象。
tagline: >-
  谁在生产盗版不重要，重要的是谁还在运行 DNS。
---

> 来源：HN 讨论主帖 [Quad9's withdrawal from France: A canary in the coal mine](https://news.ycombinator.com/item?id=50538994)（归档快照 866 分、416 条评论，入库 152 条），原文指向 Cloudflare 博客 [Quad9's withdrawal from France: A canary in the coal mine](https://blog.cloudflare.com/quad9-withdrawal-from-france/)；关联帖 [DNS resolvers are the wrong place to fight piracy](https://news.ycombinator.com/item?id=50545958)（452 分、147 条评论，归档留存 100 条），指向 TechStackups 的长文 [DNS resolvers are the wrong place to fight piracy](https://techstackups.com/articles/quad9-leaves-france-dns-blocking/)。本篇为 cluster 模式：同一关键词（Quad9 / DNS 封锁）下两帖，均未成文。归档快照 2026-11-18 20:06 UTC，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

2026 年 11 月 17 日晚，Cloudflare 在博客上发了一篇文章，标题里的词是「煤矿里的金丝雀」。文章的主角不是 Cloudflare，而是 Quad9——一家 2017 年由 Global Cyber Alliance、IBM 和 Packet Clearing House 共同创立的瑞士非营利机构，产品是免费的公共 DNS 解析器 9.9.9.9。2021 年它把法律主体迁到苏黎世、由 SWITCH 托管，官方称每天拦截 670 万次以上恶意域名，节点分布在 110 多个国家的 230 多个解析集群上。11 月 24 日起，它将停止为法国用户解析 DNS。

导火索是一份判决。2026 年 10 月 21 日，巴黎法院在 RG 26/11882 案中判 Quad9 每天罚款 1000 欧元。数字的落差值得单列：beIN 要求按「每个仍可访问的域名每天 1 万欧元」计，58 个域名合计 58 万欧元/天；法官把罚金定为总计 1000 欧元/天，从 10 月 21 日算到 WTA 赛季结束的 11 月 14 日。Quad9 抗辩说自己无法按地理位置分发屏蔽结果，法院在判决第 16 段回应，Quad9「appears to contradict itself」——它已经在全球范围内对恶意域名做自动化过滤；第 18 段更直接：Quad9 声明为执行判决一项措施都没做，仅此一点就足以支持罚款。三周约 2.4 万欧元，Quad9 付得起，但它说还有 20 起同类案件在审，每一起都可能拖满一个赛季。10 月 22 日，Quad9 宣布退出。

Cloudflare 的论证有两条。第一条是退出伤害的是互联网而不是盗版用户：Quad9 的使用者里有法国的政府部门、教育机构、医院和公用事业——DINUM、France Travail、CEA、Institut Pasteur、RENATER、EDF、SNCF、马赛 AP-HM 医院集团、法国电信、Thales、Airbus 的 Stormshield——而 Quad9 没有能力通知到其中任何一家。原文的措辞是，解析器消失时用户不会看到任何错误提示，「他们的网络就是直接停了」。第二条是公共解析器全球运营，法国的命令天然跨境，一纸命令就决定了巴西、肯尼亚或德国的用户能解析到什么。Cloudflare 还给出两个前例：Cisco 的 OpenDNS 早在 2024 年 6 月就撤出法国，后来是葡萄牙和比利时；比利时布鲁塞尔商业法院 2026 年 8 月支持了针对 Cloudflare、Google 和 Cisco 的核心命令，罚款按「每场比赛日 10 万欧元」计，每家公司上限 2000 万欧元，最后期限是 2027 年 1 月初。意大利 AGCOM 在 2026 年 1 月给 Cloudflare 开出 1420 万欧元罚单，占其全球营收的 1%，Cloudflare CEO Matthew Prince 当时的回应是「Play stupid games, win stupid prizes」。

另一侧的数字并不站在法院这边。法国监管机构 Arcom 报告：2022 年以来共封了 12606 个体育相关域名，其中 6496 个集中在 2025 年（同比涨 71%），而盗版量在 2025 年只下降 4%，比 2021 年下降 34%。Arcom 交给国民议会的 2025 年 12 月报告说，20% 的法国网民已经在用替代解析器，29% 在用 VPN。OONI 2025 年的测量：抽样 542 个域名，291 个至少被一家 ISP 拦下，四家都拦的只有 132 个。欧盟委员会 2025 年的评估结论是效果「有限」。法国自己的域名注册机构 AFNIC 在科学委员会报告里写过一句：「Le DNS n'a pas été conçu pour filtrer les contenus.」（DNS 并不是被设计用来过滤内容的。）IETF 的 RFC 7754 说得更冷：技术上只有「最不坏」的方案，没有好方案。

另一条 HN 讨论的关联帖，是 TechStackups 在 11 月 18 日发出的一篇长文，回应的是 Quad9 CTO John Todd 在主帖评论区里的一个请求：他正在 IETF 127 会议上，说「目前 100% 支持我们的立场」，并号召欧洲读者写长文，「做一份关于法国走错了哪条路的有充分论证的声明」，发给政策制定者。TechStackups 那篇就是照着写的，时间线从 2023 年 12 月 Canal+ 起诉 Cloudflare、Google 和 Cisco 开始，到 2024 年 6 月 Google 服从、Cisco 撤出法国，2024 年 12 月 Canal+ 拿下针对 Quad9 的三份命令（英超、欧冠、法甲 Top 14 橄榄球），2026 年 3 月巴黎上诉法院驳回 Google、Cloudflare 和 Cisco 的五份上诉（RG 24/09372），同月还同时向 19 家 ISP、Google、Cloudflare、Quad9 和 VPN 服务商发出命令，2026 年 4 月 Canal+ 拿下欧盟资助的 DNS4EU（Whalebone），后者选择「在全球所有解析层封」，2026 年 7 月又有 14 份新命令把 Bing 也列入名单。文中还提到一个具体的副作用：Mullvad 在 2026 年 11 月 2 日关掉了自己的公共加密 DNS，把 Mullvad Browser 的用户整体迁到 Quad9——于是法国的 Mullvad Browser 用户被迁到了一个三周后就要消失的解析器上。

## 讨论焦点

### 一、Cloudflare 自己没有承诺任何事

主帖最靠前的位置不是欢呼，是追问：

> "This article is nice but CF does not commit to doing anything in it. They say they are opposed to this and vaguely imply they might have to do something if they lose their appeal.<p>Stop being vague. CF, will you commit to also withdrawing from impacted countries if the ruling goes against you?" — driverdan [c:50540380]
> （译文：这篇文章写得不错，但 CF 并没有对任何事作出承诺。他们说自己反对，只是含糊地暗示如果上诉失败，可能不得不做点什么。<p>别含糊。CF，如果判决对你不利，你愿不愿意也从受影响的那些国家撤出去？）

这条追问的份量在于 Cloudflare 自己就站在同一条司法线上：比利时给每家公司的罚单上限是 2000 万欧元，意大利已经罚了它 1420 万欧元。更值得注意的是另一件事——2026 年 10 月 7 日，法院因 Cloudflare、NordVPN 和 Surfshark 都做出过一定努力而拒绝追加罚款，Cloudflare 之所以没被罚到 1.1.1.1 头上，是因为它直接在自己的 CDN 层动手。也就是说，它在原则上反对解析器被要求屏蔽，在操作上把动作挪到了另一层。也有读者把资格问题直接摆上桌：

> "I would take this argument a lot more seriously if it didn&#x27;t come from fucking Cloudflare, the entity that puts all sorts of barriers to access this mythical &quot;free and open&quot; internet if you are not using the corporate-approved fingerprinted browser." — surgical_fire [c:50539757]
> （译文：如果这话不是出自他妈的 Cloudflare，我会认真得多——这家公司给那些不用官方认证指纹浏览器的用户访问这个神话般的「自由开放互联网」设了各种门槛。）

TechStackups 那篇长文在「反方意见」一节里正面回应了同一类质疑：Cloudflare 的 CDN 确实挡着大量盗版站，但那是 CDN 的问题，法国法院本来就够得着 CDN，跟「解析器该不该说谎」是两件事。

### 二、「自由互联网」这个说法还剩多少

第二个分支是关于「金丝雀」这个词本身。

> "we are probably witnessing the beginning of the end of the free global internet, towards a balkanization of nation-internets with their own services." — slopinthebag [c:50539387]
> （译文：我们大概正在见证自由全球互联网终结的开端，走向各自带一套服务的国别互联网碎片化。）

反对者给了一个更冷的框架：

> "The &quot;free global internet&quot; has always, <i>always</i>, been incompatible with national sovereignty.<p>None can be the servant of two masters for long, and that remains true when the servant is a corporation and the masters are nations. You can pick one, but you do have to actually pick." — ben_w [c:50539545]
> （译文：「自由的全球互联网」一直、一直都和国家主权不兼容。<p>没有人能长期同时侍奉两个主人，仆从是一家公司、主人是国家的时候也一样。你可以选择，但你就必须真的选一个。）

也有人认为「自由」这个词早就不成立了：

> "If by &quot;free&quot; you mean being able to publish anything on the internet you want without restrictions, that ended a long time ago." — alwillis [c:50539808]
> （译文：如果你说的「自由」是指可以在互联网上不受限制地发布任何东西，那它很久以前就结束了。）

英国读者 kypro 的版本更悲观，也更难反驳：

> "here in the UK people wouldn&#x27;t see this as a &quot;canary in the coal mine&quot; at all, but probably an example of how a national government can successfully regulate the internet – even if it upsets tech billionaires." — kypro [c:50539799]
> （译文：换句话说，在英国，人们根本不会把这看成「煤矿里的金丝雀」，更可能把它看成「一个国家政府可以成功监管互联网——哪怕这会惹恼科技亿万富翁」的样本。）

他补的那一段更扎心：这些文章读起来像是写给过去的人，或者像他这样把自由当成美德来信的怪人写的；「假设普通读者在乎一个自由开放的互联网，这本身就很荒谬。普通人觉得互联网开放得过头了。」

被追问「2000 年代到底发生了什么」的人，给出了一个具体的记忆：

> "The 2000s era was so strong for European internet freedoms with Bittorrent&#x2F;early TOR&#x2F;anonymous hosting providers. It&#x27;s a shame it has completely vanished, what went wrong?" — liquid_oil [c:50539764]
> （译文：2000 年代是欧洲互联网自由度最强的时代，Bittorrent、早期 TOR、匿名主机服务商都在。今天它彻底消失了，可惜了——到底发生了什么？）

还有一句更冷的话，把这场讨论从「法国」拉回「互联网本身」：

> "It&#x27;s not just overregulation, it&#x27;s the dissolution of the internet. At some point you&#x27;ve amputated what makes it &quot;inter&quot;." — isityettime [c:50539539]
> （译文：这不只是过度监管，这是互联网在解体。到某个点，你就把让它成为「互联」的那部分切掉了。）

### 三、谁在为这场仗买单

第三支队伍不谈技术，直接查人。

> "A reminder who is behind this:<p>The legal warfare is driven by the beIN Sports chairman, Nasser Al-Khelaifi. He is also president of Paris Saint-Germain and chairman of Qatar Sports Investment.<p>He is, obviously, not French." — miohtama [c:50539841]
> （译文：提醒一下这背后是谁：<p>这场法律战是由 beIN Sports 主席 Nasser Al-Khelaifi 推动的。他同时是巴黎圣日耳曼主席和卡塔尔体育投资主席。<p>他显然不是法国人。）

同一条评论还挖出了 beIN 的总法律顾问 Caroline Guenneteau——2018 年成立、聚合转播商、联赛和体育组织的行业组织 APPS 的创始人和现任董事，也是动态封禁令、ISP 层面的 DNS 屏蔽、平台与搜索引擎责任扩大的推动者，其中就包括 2021 年那部引入动态封禁机制的法律。制度层面的变化同样清楚：2026 年 7 月通过的体育法修正了 L.333-10 条，新增由 Arcom 运行的自动化实时封禁系统，原文引述 Arcom 的话说「不再事先审批每一条封锁」，Quad9 对此的评价是「recklessly dangerous」。

政治层面的现实也被点出来：

> "The hard reality is that politicians are fickle beasts.  All they care about is where their next vote is coming from." — traceroute66 [c:50539988]
> （译文：残酷的现实是政客是善变的野兽。他们唯一在意的，就是下一张选票从哪里来。）

至于「别给支持这种政策的政治人物投票」这种建议，评论区自己就回了一句：说起来容易，做起来难——政客的立场随风向变，几个月后他们会说是「情况变了」。

### 四、解析器只是指针

第四个焦点是技术论证本身，也是两篇文章共同的核心。

> "DNS tells you where something is, no more and no less.  When queried, it points to the map and says: &quot;It&#x27;s there, off you trot&quot;.  DNS does not care what <i>is</i> there, it is just a guide." — gerdesj [c:50540375]
> （译文：DNS 告诉你东西在哪儿，仅此而已。被查询时，它指着地图说：「在那儿，去吧。」DNS 不关心那里有什么，它只是一张指路牌。）

关联帖里有人把这句话推到了制度层面：

> "Every attempt to “fight piracy” that isn’t “prosecute pirates” is just a backdoor to suppressing speech a government doesn’t like." — trentnix [c:50547167] [thread 2]
> （译文：任何不打算「起诉盗版者」、只打算「打击盗版」的尝试，都只是政府用来压制它不喜欢的言论的后门。）

最扎人的一条来自一个完全不相干的角度——模型：

> "It’s insane to me that they found a legal way to prevent the distribution of copyrighted material via DNS. Why isn’t ChatGPT.com blacklisted? I can ask for a verbatim copy of any book and get it 1:1 too?" — usernametaken29 [c:50546391] [thread 2]
> （译文：让我抓狂的是，他们居然找到了一种能用 DNS 阻止受版权保护内容传播的法律路径。那为什么 ChatGPT.com 不被拉黑？我可以让它逐字复制任何一本书，1:1 给我。）

这条评论的后半句是「这显然是盗版，却被容忍了」——同一个行为，换个载体就没人管。它还带出一个更实际的漏洞：法国的命令管得住解析器，管不住把内容复制出来的模型；而 Arcom 自己的研究已经说过，20% 的法国网民在用别的解析器，29% 在用 VPN。至于「欧洲政府在替足球联赛省钱」这个更结构性的判断，来自另一位读者：

> "It&#x27;s absolute madness, and it&#x27;s a reflection of the corruption and how football got too big and too powerful in Europe.<p>There&#x27;s nothing bad with football, but having it take &gt;90% of all sport revenues and mindshare is unhealthy" — qalmakka [c:50546995] [thread 2]
> （译文：这绝对是一场疯狂，也是欧洲的腐败、以及足球变得过于庞大和过于有权势的写照。<p>足球本身没什么不好，但让它拿走全部体育产业收入的 90% 以上和大部分注意力，是不健康的。）

### 五、「退出法国」到底怎么退出

第五个焦点是个技术细节，但答案指向法律。

> "One thing is not well explained, if they can’t reliably detect french users, how can they leave france?" — rileymat2 [c:50546766] [thread 2]
> （译文：有一点没解释清楚：既然他们没法可靠地识别法国用户，那他们要怎么「离开法国」？）

回复给出的答案是，「退出」本来就是法律姿态，不是技术开关：

> "It mostly means having no legal entity or property in France that French courts can render judgments on. So they will geoblock as a basic compliance measure that doesn’t fully work but they avoid exposure by staying out of France." — jeremyjh [c:50546790] [thread 2]
> （译文：这主要意味着在法国没有可被法国法院判决的法人实体或财产。所以他们会做地理封锁作为基本的合规手段——它并不完全管用，但他们靠「不在法国经营」避开了被追责的风险。）

住在法国的人给出的判断更实际：

> "By saying they are not serving French users anymore, Quad9 will now be able to blame French users who are still accessing the service as circumventing their technical measures (if they ever enable some). Any court order from France will now get a standard answer &quot;we do not serve France&quot;, so this should reduce legal costs." — dolmen [c:50550469] [thread 2]
> （译文：一旦宣布不再服务法国用户，Quad9 以后就可以把仍在使用服务的法国用户说成是在规避他们的技术措施（如果他们真启用了的话）。法国来的任何法院命令，现在都能得到一个标准答复：「我们不服务法国。」这样应该能降低法律成本。）

同一条评论的结尾还写着：希望他们实施的技术措施能真的影响到服务，并且能上媒体——「我住在法国」。长文里还有一个更细的地理细节：法国这份命令覆盖海外省和圣皮埃尔与密克隆，却不包括新喀里多尼亚、瓦利斯和富图纳以及法属波利尼西亚。

### 六、写给政策制定者的长文有用吗

最后一个焦点是 Quad9 CTO 的号召本身。

主帖里排第一的评论来自 Quad9 的 CTO John Todd：

> "Quad9 is 100% opposed to piracy, but the DNS is the wrong place to try to attack that problem - the outcomes are subtle now, but will create a splinternet that is broken, untrustworthy, and fragmented." — johnhtodd [c:50539856]
> （译文：Quad9 百分之百反对盗版，但 DNS 是试图解决这个问题时最不该下手的地方——眼下的后果还很微妙，最终却会造出一个破碎、不可信、碎片化的「分裂互联网」。）

同一条评论的后半段，是这次讨论最特别的一处：

> "you should write a long-form, well-reasoned statement of why France is taking the wrong path on this enforcement of rightsholder demands. Make sure your post is scrape-able by search engines and AI." — johnhtodd [c:50539856]
> （译文：你们应该写一份长文、有充分论证的声明，说明法国在执行权利人诉求这件事上走错了哪条路。确保你的文章能被搜索引擎和 AI 抓取。）

关联帖那篇 TechStackups 长文，就是照着这个号召写的产物——它开篇就引用了 John Todd 的这段话。这件事本身在评论区被反复戳：

> "The irony of this clearly AI-written piece starting out by referencing the need for &quot;a long-form, well-reasoned statement of why France is taking the wrong path&quot; is amusing" — NikxDa [c:50546710] [thread 2]
> （译文：这篇明显是 AI 写的文章，开头却引用了「需要一份关于法国走错了哪条路的长文、有充分论证的声明」这种需求，这个讽刺很有意思。）

对这种做法最不客气的质疑来自另一位读者：

> "If you want things to change fundamentally, you need money, leverage, or guns. Those in power have all three, and they are laughing at your attempts to educate them about what you think they should be doing." — p-e-w [c:50546373] [thread 2]
> （译文：如果你想让事情发生根本性改变，你需要的是钱、杠杆或者枪。掌权者三样都有，他们正在嘲笑你那些试图教育他们该怎么做的努力。）

p-e-w 的判断更冷：法官和立法者这么做，不是因为误解了某个技术问题，而是因为他们收了钱，或者是被收钱的人任命的；「他们不是在误解你，也不是把事情搞砸了……一切都在按（他们的）计划完美进行。」

也有人问了一个更尖锐的问题：NextDNS 也在法国，为什么它不吭声？

> "Why then does NextDNS (also based in France, and a much much better service) not cry on the Internet like American Johnny?" — CarlitosHighway [c:50547100] [thread 2]
> （译文：那为什么 NextDNS（同样在法国，而且服务好得多）就不像美国 Johnny 那样在互联网上嚎叫？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|------|
| Cloudflare 没资格谈自由互联网 | surgical_fire | 这话要是换个作者说的，我会认真得多 |
| Cloudflare 必须先给承诺 | driverdan | 如果判决对你不利，你撤不撤 |
| 自由全球互联网与国家主权天生冲突 | ben_w | 你可以选，但必须真的选一个 |
| 「自由」这个前提早就不成立 | alwillis | 不受限制地发布任何东西，很久以前就结束了 |
| 普通人根本不想要开放互联网 | kypro | 假设读者在乎自由互联网，这本身就很荒谬 |
| 2000 年代的欧洲自由已经消失 | liquid_oil | Bittorrent、早期 TOR、匿名主机，那个时代过去了 |
| 这不是过度监管，是互联网解体 | isityettime | 到某个点，你把「互联」那部分切掉了 |
| 解析器只是指路牌 | gerdesj | DNS 不关心那里有什么 |
| 不起诉就是压制言论的后门 | trentnix | 任何「打击盗版」的尝试都是后门 |
| 模型能逐字复制书，为什么不禁 | usernametaken29 | DNS 能拦，ChatGPT 不拦 |
| 欧洲政府在替足球联赛省钱 | qalmakka | 足球拿走 90% 以上的产业收入和注意力 |
| 「退出」是法律姿态不是技术开关 | jeremyjh | 在法国没有可被判决的法人实体 |
| 退出之后法律成本更低 | dolmen | 标准答复：「我们不服务法国」 |
| 政策靠教育改不动 | p-e-w | 需要的是钱、杠杆或者枪 |
| 真正的对手是钱不是技术 | miohtama | 推动这场仗的是 beIN 主席和卡塔尔体育投资 |
| 想保住互联网就得给版权一个解法 | wmf | 版权比互联网早几百年，你总得给点什么 |
| 那就取消版权 | Refreeze5224 | 让商业模式适应数字网络，别用立法否定现实 |

## 总体情绪

这场讨论的分歧不在 Quad9 该不该退出——几乎没人替法国说话——也不在 DNS 能不能拦下盗版站，技术上一分钟就能绕开，两边都认。真正的分歧在两个更硬的地方：一是「自由互联网」这个前提还成不成立，一方认为法国这类判决是分割互联网的第一步，另一方认为分割早就发生了，这只是把既成事实写进判决书；二是给政策制定者写长文到底有没有用。评论区里最诚实的一句话来自 p-e-w：他们不是在误解你。

而更让人记住的是那些不站队的细节：Quad9 赢过德国那场官司——2023 年 12 月德累斯顿高等法院认定解析器享有与接入服务商同等的责任特权，德国民间权利组织 GFF 说这个判决把举证责任推回给了权利人——但代价是「几年时间、六位数的成本和大量被浪费的时间」，对手「律师比我们的钱和时间都多」；Mullvad 刚在 11 月 2 日关掉自己的公共 DNS，把用户整体迁到 Quad9，于是法国的 Mullvad Browser 用户搬进了一个三周后消失的解析器；Arcom 封了 12606 个域名，换来的是盗版量下降 4%。判决书最后要求出庭的，不是盗版服务器，是那些从不停机、也不生产任何内容的解析器——而它们唯一能做的事，就是在答案里说谎。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Quad9's withdrawal from France: A canary in the coal mine（HN 主帖） | <https://news.ycombinator.com/item?id=50538994> |
| 2 | Cloudflare 博客原文：Quad9's withdrawal from France | <https://blog.cloudflare.com/quad9-withdrawal-from-france/> |
| 3 | DNS resolvers are the wrong place to fight piracy（HN 关联帖） | <https://news.ycombinator.com/item?id=50545958> |
| 4 | TechStackups 长文：DNS resolvers are the wrong place to fight piracy | <https://techstackups.com/articles/quad9-leaves-france-dns-blocking/> |
| 5 | Quad9 公告：Au Revoir France | <https://quad9.net/news/blog/au-revoir-france/> |

---

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 50538994 归档快照 866 分、416 条评论，入库 152 条；关联帖 50545958 为 452 分、147 条评论，归档留存 100 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。带 `[thread 2]` 的引文来自关联帖。

原文事实（法院判决、罚金计算方式与第 16/18 段的推理，Quad9 的成立背景与运营数据，Cloudflare 原文中的 Cisco/比利时/意大利/西班牙案例，TechStackups 长文中的 2023—2026 年判决时间线、Arcom 与 OONI 数据、AFNIC 与 RFC 7754 的表述）均转述自 Cloudflare 博客与 TechStackups 长文；评论者对卡塔尔资本、欧盟监管动机、「自由互联网」前景的判断属于评论者个人立场，本文按原帖立场并列呈现，不做事实判定。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
