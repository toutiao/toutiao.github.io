---
layout: post
title: >-
  巴西大选的 Meta 争议：搜索「brasil」先出博索纳罗 — HN 讨论摘要
date: 2026-10-26
hn_id: 50229587
categories: [articles]
excerpt: >-
  两家倡导组织把搜索截图、话题标签排序和 AI 答题记录递进巴西最高选举法院，指 Meta 给两位总统候选区别对待。
  法院判 Meta 每天罚 9.9 万美元，评论区一句：这点钱等于没罚。
tagline: >-
  一搜「巴西」，先跳出来的不是总统，是对手的选票号码。
---

> ⚑ **政治背景**：本文涉及巴西 2026 年总统大选、最高选举法院（TSE）与联邦最高法院的选举争议、Meta 被指算法偏袒、右翼与左翼阵营互指审查，以及美国科技公司与白宫的关系。文中涉及选举与审查议题属政治敏感话题，所引观点按原帖立场呈现，不代表本项目立场。⚠ Review recommended.

## 原文概要

这桩案子发生在巴西最高选举法院（TSE）。负责审理的高级选举法官 Marco Aurélio Bellizze 在一周之内连出三步：周四裁定 Meta 不得以削减分发、限制搜索、删除帖子的方式在卢拉与弗拉维奥·博索纳罗两名候选人之间制造失衡，其 AI 工具必须对两位适用同一套标准；周五，全院维持这项裁定；周日，法官再次要求 Meta 在 24 小时内证明自己已经照办。逾期不改，日罚金从 50 万雷亚尔（约 9.9 万美元）上调到 100 万雷亚尔（约 19.8 万美元）。

新证据来自 Sleeping Giants Brasil 和 CTRL+Z 两个组织。他们向法院提交的材料指 Meta 的 Instagram 与 WhatsApp 在三处区别对待两位候选人：搜索排序、话题标签推荐、Meta AI 回答。记录很具体——在 WhatsApp 搜「brasil」，第一条 GIF 是带选票号码和竞选搭档的博索纳罗图像，同一条结果在三个不同账号上出现；在 Instagram 搜同一个词，前三位是博索纳罗的照片，卢拉只以一个纯文字名字出现，连配图都没有。

负面词条目的对比更刺眼。搜「ladrão」（小偷），WhatsApp 返回一幅卢拉穿着条纹囚服的漫画，另一条写着「支持劳动党是一种精神疾病」；在 Instagram 搜同一个词，返回一张「Vote 13」的 GIF，13 正是卢拉所属劳工党的选票编号。话题标签那组同样有方向性：搜「lula」，第一个 hashtag 建议是 #lulaladrão（卢拉是小偷）；搜「bolsonaro」，批评性的 #bolsonaronuncamais（博索纳罗永不回来）却排在最后几位。

至于 Meta AI，两个测试者只是让它从 1 到 25 之间随便挑一个数字，没提选举。一个答 13，一个答 22——分别是卢拉和弗拉维奥·博索纳罗的选票编号。原文承认单看这一项得不出结论，但组织方要求 Meta 说明生成答案所用的参数。

另一条 HN 热帖补上了对手一侧的材料。Al Jazeera 引《圣保罗页报》10 月 16 日的报道说，Meta 内部沟通承认卢拉的 Instagram 账号在选举期间受到限制性影响，平台同时推荐过博索纳罗的个人主页和 WhatsApp 频道。卢拉竞选方称部分帖子不显示分享按钮、触达下降，表情、分享、音频、加速播放等选项都缺失。Meta 对路透表示，这些技术问题此前已经公开，内部讨论只涉及严重程度、不涉及政治干预，并称「任何暗示 Meta 偏向一方的说法都是错误的」。

背景是 10 月 25 日的第二轮投票：左翼现任总统卢拉对阵右翼参议员博索纳罗，后者在首轮的表现超出预期。除了诉讼，两个组织还宣布在圣保罗 Meta 总部门外抗议，口号是「Meta，把手从我们的选举上拿开」。新证据由《圣保罗页报》记者 Mônica Bergamo 爆出。

## 讨论焦点

### 一、搜索结果能证明偏见吗

反对者最直接的问题是：你怎么知道排在前面的不是别的原因。shubhamjain 自己动手搜了一遍，给出的解释很朴素——那张 GIF 里他可能只是穿着巴西国旗 T 恤在滑稽地跳舞；一张 GIF 出现在搜索结果里，怎么就成了政治偏见的证据。

同一条线上的 bluegatty 说得更冷：

> "This is anecdotal, it's not evidence. The whole point of this discussion is figuring out the difference." — bluegatty [c:50230201]
> （译文：这是轶事，不是证据。这场讨论的全部意义就在于弄清楚两者的区别。）

JuniperMesos 把同样的怀疑换了个更大的场景。他拿德国选择党（AfD）举例：为什么你确信 YouTube 在推 AfD 的内容？更可能的是你自己反感 AfD，所以任何一条 AfD 内容在你眼里都格外扎眼。他接着追问了一个更难的问题：

> "Are you actually measuring this?" — JuniperMesos [c:50230295]
> （译文：你到底有没有在测量这件事？）

> "But how do you determine what is the correct amount of AfD content to be recommended to people in a politically-neutral way, that doesn't end up amounting to you arguing that the YouTube algorithm is only fair if it censors political content you personally think is bad?" — JuniperMesos [c:50230295]
> （译文：可是你怎么确定，在政治中立的标准下，推荐给用户的 AfD 内容「应该」有多少？这不至于变成你在论证：只有当 YouTube 屏蔽掉你个人看不顺眼的政治内容时，它的算法才算公平吗？）

xvector 的观察更系统：

> "I love how everyone from every political background thinks big tech has it out for them specifically." — xvector [c:50230687]
> （译文：我太喜欢看到各个政治背景的人都觉得大公司专门针对自己了。）

senordevnyc 用自己的信息流举了反例：

> "This is the conspiracy theory thinking GP was referring to. There’s no evidence for any of it, it’s all vibes. I favorite reels that are pro-Palestinian, and now my feed is packed with anti-Zionist reels. I literally don’t think I’ve ever seen a pro-Israel reel." — senordevnyc [c:50231147]
> （译文：这就是 GP 所说的那种阴谋论式思维。这些说法毫无证据，全凭感觉。我收藏的 reels 都是支持巴勒斯坦的，现在我的信息流里塞满了反犹太复国主义的 reels。我敢说我从来没在推荐里见过一条支持以色列的 reel。）

> "On the modern internet, people confuse conspiratorial thinking for well-reasoned thinking. But an idea is not correct just because it is interesting or exciting." — xvector [c:50230687]
> （译文：在今天的互联网上，人们把阴谋论式的思维和有根据的思维混为一谈。但一个想法不会因为有趣或刺激就变正确。）

还有一条最实际的反驳，直接打在罚款上。microtonal 说：

> "The daily fine is so meaninglessly small ($99,000 per day) that there is very little incentive to do anything." — microtonal [c:50229788]
> （译文：每日罚金小得毫无意义（每天 9.9 万美元），根本没有任何动力去做点什么。）

### 二、「技术故障」为什么总偏向同一个方向

接受「故障说」的人，往往是同一种反应模式。moribvndvs 一句话把整帖的潜台词说完了：

> "It’s just a technical issue that seems to magically and repeatedly happen in favor of right wing interests. Crazy how that just works out some times." — moribvndvs [c:50228117] [thread 2]
> （译文：这只是一次技术故障，而它似乎总是神奇地、一再地发生在有利于右翼利益的方向上。每次都这样挺离谱的。）

最「善意」的解读来自 woadwarrior01，他指向的是注意力经济本身：

> "I think the most charitable explanation for this is that it's because polarizing content (aka ragebait) gets views/plays, which the ranking algorithms directly optimize for." — woadwarrior01 [c:50229923]
> （译文：我认为最善意的解释是，因为两极化内容（也就是愤怒诱饵）能拿到播放量，而排序算法直接优化的就是这个指标。）

> "Also, this isn't a new phenomenon. If you're interested, I'd recommend reading Shoshana Zuboff's 2018 book: The Age of Surveillance Capitalism." — woadwarrior01 [c:50229923]
> （译文：而且这不是新现象。有兴趣的话，我推荐读 Shoshana Zuboff 2018 年的《监控资本主义时代》。）

RobotToaster 则把算法描述成另一种东西——不是 conspiracy，是「笨」：

> "I find a lot of social media algorithms are "dumb" in that they will see someone share something saying "x sucks" and interpret that as one being interested in "x"." — RobotToaster [c:50229837]
> （译文：我发现很多社交媒体的算法很"笨"，它们看到有人转发说"X 很差"的内容，就理解成这个人对 X 感兴趣。）

> "Either that or it's deliberately showing people stuff it knows they will hate to harvest hate scrolling." — RobotToaster [c:50229837]
> （译文：要么是这样，要么就是它故意推送你知道你会讨厌的东西，好收割仇恨式浏览。）

233mhz 把这套逻辑换成了时间账：

> "Even out of political reasoning, they are rigged for engagement and as it turns out fear mongering and hate bring a lot of engagement." — 233mhz [c:50230670]
> （译文：即便撇开政治不谈，它们也是为互动率调校的，而事实证明，恐吓和仇恨能带来大量互动。）

> "What are people going to watch between a 3 hours in depth debate about the future of the country on topics such as ecology, finance, social security and pension systems VS hundreds of reels about ImMiGrAnT RiOtS in paris?" — 233mhz [c:50230670]
> （译文：用户会去看什么？一场三小时、深入讨论国家未来的辩论，议题包括生态、金融、社保和养老金；还是几百条关于巴黎移民暴动的 reels？）

### 三、流量到底是怎么分的

热度不只来自选举。Sleeping Giants 自己那份针对众议员 Nikolas Ferreira 的研究报告，是评论区引用最多的数字来源。goshx 转了报告链接：

> "At the same time, some candidates from the opposition are getting more views than Beyoncé and other artists known globally." — goshx [c:50228043] [thread 2]
> （译文：与此同时，某些反对派候选人拿到的播放量比 Beyoncé 和其他全球知名艺人还高。）

Terr_ 把报告内容译成英文贴了出来，关键数字都在里面：

> "Its ten videos totaled 410.5 million views, nearly three times the total of the 90 videos of the other nine MPs analyzed." — Terr_ [c:50228193] [thread 2]
> （译文：他的十条视频总播放量 4.105 亿次，接近被同时分析的那九名议员 90 条视频总和的三倍。）

> "In views by follower, its performance was 17.2 times the typical value of these deputies, 29.3 times that of the largest Brazilian profiles and 33.7 times that of the largest profiles in the world." — Terr_ [c:50228193] [thread 2]
> （译文：按粉丝折算，他的表现是这些议员典型值的 17.2 倍、巴西最大账号的 29.3 倍、世界最大账号的 33.7 倍。）

> "The study documents a persistent disparity that requires more transparency from the Meta, although public data does not allow it to determine its causes." — Terr_ [c:50228193] [thread 2]
> （译文：这份研究记录了一种持续存在的差距，需要 Meta 提供更多透明度，尽管公开数据不足以确定其成因。）

至于首页推荐到底长什么样，读者们的自述和报告结论方向一致。barbazoo 只用 Facebook 交易：

> "All that it's ever suggesting in the home feed is hateful, right-wing content. Never anything positive. It's so sad that that's what drives the metrics these people care about. If this is your job, shame on you!" — barbazoo [c:50228517] [thread 2]
> （译文：它首页推荐的内容永远是有害的右翼内容，从来没有正面的东西。可惜这些人在乎的指标就是这个。如果这是你的工作，真该羞愧。）

ahartmetz 提供了地区差异的证据。他住在德国一个 2025 年选举里 AfD 得票约 25% 的小镇，在那儿会收到 AfD 内容推荐，在柏林不会：

> "I get AfD content recommendations (lurid, trashy stuff of uhm uncertain truth value) a propos of nothing in the village I grew up in - they are popular there with about 25% in the 2025 election. The region is not even in the east or particularly suffering economically. I don't get these recommendations in Berlin. It seems regional." — ahartmetz [c:50229796]
> （译文：在我长大的那个村子里，我会莫名其妙收到 AfD 内容推荐（耸人听闻、垃圾、真实性可疑的那种）——2025 年选举他们在那里拿了大约 25%。那个地区既不在东部，经济上也不算特别糟。我在柏林收不到这类推荐。看起来是地域性的。）

mrtksn 描述的是另一种机制——算法变成电视台：

> "They probably show posts based on location and background, so essentially just like Fox, CNN, MSNBC but everyone sees theirs from the same screen with the same agenda pushed from all of them." — mrtksn [c:50229859]
> （译文：他们大概会根据位置和背景推送内容，所以本质上就像 Fox、CNN、MSNBC，只不过每个人看的都是同一块屏幕，上面推着同一套议程。）

### 四、算法该透明到什么程度

这是帖子里少见的、建设性最强的一条线。msandford 认为平台迟早得交出算法，或者至少把排序权交还用户：

> "At a certain point the big social media companies are going to have to publish their algorithms and/or let you choose your own re: friends updates, friends of friends, things your friends or friends of friends liked, etc." — msandford [c:50228289] [thread 2]
> （译文：总有一天，大型社交媒体公司必须公开自己的算法，或者至少让你自己选：朋友动态、朋友的朋友、朋友或朋友的朋友点赞的东西，等等。）

verdverm 说得更远，直接指向协议层：

> "Algorithms are something we should definitely regulate, as a generalization of social media and Ai decisions over human lives. I'd like to see something like ATProtocol feeds forced upon these companies, anyone can create any kind of feed, it works in all clients." — verdverm [c:50228697] [thread 2]
> （译文：算法这件事肯定需要监管，这是把社交媒体和 AI 影响人类生活的决定做一个推广。我希望看到类似 AT Protocol 的 feed 被强加给这些公司，任何人都能创建任何形式的 feed，并且在所有客户端里都能用。）

### 五、Meta 是被谁指挥的

「白宫在背后指挥」是帖子里频率很高的猜测，答案也分两派。

一派认为扎克伯格没有政治立场，只是算利益账。rf15 用了草坪修剪机的比喻：

> "No, it's the lawnmower analogy again: Zuckerberg has no political views, he just thinks that Trump will restrict him less/allow him to make more money/is easier to exploit." — rf15 [c:50228534] [thread 2]
> （译文：不，还是那个草坪修剪机的比喻：扎克伯格没有政治观点，他只是觉得特朗普会少管他一点／让他赚更多钱／更好利用他。）

tormeh 顺着这个比喻又推了一步：

> "Don't anthropomorphize the lawnmower. It's just a min-maxing hill-climbing machine." — tormeh [c:50232548]
> （译文：别把草坪修剪机拟人化了。它只是一台做极值优化、爬坡的机器。）

另一派认为方向是固定的，跟谁当总统无关。Vaushite 说：

> "It's not the white house, it is always the right wing. When the white house is left wing Facebook is still right wing." — Vaushite [c:50228530] [thread 2]
> （译文：这不是白宫的问题，始终是右翼的问题。白宫是左翼的时候，Facebook 还是右翼。）

derektank 拿 2020 年的旧账反驳这种「始终右翼」论：

> "Facebook has also made content decisions that have hurt right wing interests in the past, such as in 2020 when they banned several accounts affiliated with Bolsonaro" — derektank [c:50228569] [thread 2]
> （译文：Facebook 过去也做过伤害右翼利益的内容决策，比如 2020 年封禁了几个与博索纳罗有关联的账号。）

而 bluegatty 认为 Meta 那套说法更可信：

> "There is very little chance that Meta is doing algorithmic political adjustments at the behest of Zuck. It's conspiracy theory without a shred of evidence." — bluegatty [c:50230752]
> （译文：Meta 按扎克伯格的授意做算法政治微调的可能性极低。这是毫无证据的阴谋论。）

### 六、另一边的账：巴西自己也做过审查

这是帖子里最被低估、也最该讲的一层。matheusmoreira 的意思不是否认 Meta 有问题，而是认为尺度完全不对：

> "Don't be fooled. Whatever it is that Meta is doing, it's only a fraction of what Lula, his party and his supreme court ministers did to the Brazilian right wing. Censorship was the least of it. I'm not even denying that it's happening. I'm just saying I don't care." — matheusmoreira [c:50228660] [thread 2]
> （译文：别被骗了。不管 Meta 在做什么，也不过是卢拉、他的党派和他的最高法院大法官们对巴西右翼所做之事的一个零头。审查都算最轻的。我并不是否认它在发生，我只是说我不在乎。）

ETH_start 给了具体数字：

> "The Supreme Federal Court in Brazil has been notorious for censorship. The New York Times has found that it has ordered 223 account-blocking orders since 2020." — ETH_start [c:50229848]
> （译文：巴西联邦最高法院以审查闻名。《纽约时报》发现，自 2020 年以来它已经下达了 223 道封号令。）

woodpanel 把话说得更尖：

> "Freedom of speech for me, censorship for thee. Playing obvious problems of Brazil‘s judiciary system down like that are clear red flags for somebody not for 1 sec contemplating how he would react if the political camps would be reversed in this situation." — woodpanel [c:50230030]
> （译文：我的自由演讲，你的审查。把巴西司法体系那些显而易见的问题说得这么轻描淡写，对一个哪怕只有一秒钟没想过「如果两个阵营位置对调会怎样」的人来说，都是明显的危险信号。）

同一位 woodpanel 还顺手质疑了举报方本身：

> "Sleeping giants is one of the most shadiest anti-democratic organizations that, once you grasp what they are actually doing, there’s literally nothing else left to do for voters than what you described." — woodpanel [c:50229977]
> （译文：Sleeping Giants 是最阴险的反民主组织之一；一旦你搞清楚他们实际在做什么，选民除了你描述的那条路之外，已经没什么别的可做了。）

Amezarak 的反驳落在效果上：

> "Censorship will just mask social problems until the outbreak is even worse." — Amezarak [c:50230443]
> （译文：审查只会掩盖社会问题，直到爆发的时候更糟。）

### 七、平台归谁管

最后一层是主权问题，评论区把它拆成了两半。一半认为选举是本国内政，外部平台无权插手。提交那篇报道的 vrganj 说：

> "What US companies do to US politicians is an internal matter for the US. As soon as they start interfering with democratic processes in other countries, it's imperialism." — vrganj [c:50229765]
> （译文：美国公司对本国政治人物做什么，是美国的内部事务。一旦他们开始干预别国的民主进程，那就是帝国主义。）

> "As is its sovereign right. It is not Meta's right to interfere with Brazil's sovereignty." — vrganj [c:50229918]
> （译文：那是巴西的主权权利。Meta 没有干涉巴西主权的权利。）

另一半则认为不站边本身就是共谋：

> "Of course. It would be cowardly to not take a side. People that want to do good things and people that want to do bad things don't deserve the same treatment. Neutrality is complicity." — vrganj [c:50230041]
> （译文：当然。不想站队是懦弱。想做好事的人和想做坏事的人不配被同等对待。中立就是共谋。）

roenxi 把这个逻辑推到国家层面：

> "It is somewhat confusing to me that more countries don't treat Meta as a political threat. China's approach to restricting access to western internet companies looks more and more reasonable in hindsight." — roenxi [c:50228626] [thread 2]
> （译文：让我困惑的是，为什么没有更多国家把 Meta 当作政治威胁来看待。事后看来，中国限制西方互联网公司进入的做法显得越来越合理。）

chvid 则给出「各国自建平台」的版本：

> "They are beholden to the current US admin - as always - only good thing is that the current admin is so blatant that maybe one day even the Germans will realize that you need to have your own social media just you have your own national tv, newspapers etc." — chvid [c:50229808]
> （译文：他们一如既往地受制于本届美国政府——唯一的好事是本届政府太露骨了，也许有朝一日连德国人都会意识到：你需要自己的社交媒体，就像你要有自己的国家电视台、自己的报纸一样。）

KronisLV 立刻泼冷水，说这条路有网络效应这一关要过：

> "How could that be made to happen? Should EU somehow move to federated (let’s say per country) instances of Mastodon or something? Or one big platform? How would regular folks get used to it? And how could those initiatives be prevented from falling into irrelevance when network effects are at play?" — KronisLV [c:50229929]
> （译文：这怎么可能实现？欧盟是不是要转向联邦式的（比如每国一套）Mastodon 实例？还是做一个统一的大平台？普通人怎么才能习惯？当网络效应起作用的时候，又怎么阻止这些尝试变得无足轻重？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 轶事不等于证据 | bluegatty | 这场讨论的全部意义就是分清两者 |
| 你测过吗 | JuniperMesos | 中立的标准是什么？不就变成你要求屏蔽自己讨厌的内容 |
| 全是 vibes | senordevnyc | 我的信息流里塞满反犹太复国主义的 reels，一条亲以色列的都没见过 |
| 罚金等于没罚 | microtonal | 每天 9.9 万美元，没有任何动力去做 |
| 故障只是恰好总偏右 | moribvndvs | 技术故障神奇地一再发生在有利于右翼的方向 |
| 最善意的解释是愤怒诱饵 | woadwarrior01 | 排序算法直接优化的就是播放量 |
| 流量规模可量化 | Terr_ | 10 条 Reels 4.105 亿播放，是另外九人 90 条总和的三倍 |
| 地域性推荐是真的 | ahartmetz | 小镇有 AfD 推荐，柏林没有 |
| 算法必须公开 | msandford | 不然「平台推的」会变成愤怒的挡箭牌 |
| 该用协议层解决 | verdverm | 强制 AT Protocol 式的 feed |
| 扎克伯格没有政治立场 | rf15 | 草坪修剪机，只是算利益账 |
| 方向与白宫无关 | Vaushite | 白宫换边，Facebook 还是右翼 |
| Meta 也惩罚过右翼 | derektank | 2020 年就封过博索纳罗的关联账号 |
| 阴谋论没有证据 | bluegatty | Meta 按扎克伯格授意做政治微调的可能性极低 |
| 尺度完全不对 | matheusmoreira | Meta 做的只是巴西左翼对右翼所做的零头 |
| 法院才是审查源头 | ETH_start | 巴西联邦最高法院 2020 年以来下了 223 道封号令 |
| 举报方本身可疑 | woodpanel | Sleeping Giants 是最阴险的反民主组织之一 |
| 别国无权干涉 | vrganj | 美国公司干预他国选举就是帝国主义 |
| 不站边是共谋 | vrganj | 想做好事和想做坏事的人不配同等对待 |
| 该把 Meta 当政治威胁 | roenxi | 限制西方平台进入的做法越来越显得合理 |
| 自建平台过不了网络效应这关 | KronisLV | 普通人怎么习惯？怎么防止被边缘化 |

## 总体情绪

两个帖子的情绪是同一种东西的两面：一半人相信技术故障，偏巧总偏；另一半人相信这根本不是故障，而是排序逻辑在自动放大某一边。而两边都同意一件事——罚金不痛。

真正把讨论推深的其实是第三组人。他们不谈立场，谈机制：算法要不要公开，feed 要不要交给协议层，各国要不要自建平台。这组人看起来最没有情绪，但提出的问题最难回答：平台在商业上根本没有动机交出排序逻辑，而「中立」这个标准本身在评论区就被证明是无解的——JuniperMesos 追问的是，在政治中立的标准下，推荐给用户的某类内容「应该」有多少？这个问题没有人给出答案。

原帖里那个最刺眼的细节，也没人接住：搜「lula」，第一个 hashtag 是 #lulaladrão；搜「bolsonaro」，#bolsonaronuncamais 排在最后。同一套排序逻辑，同一个界面，两个方向。至于 Meta AI 那次随机报数，一个答 13、一个答 22，正好是两个候选人的选票编号——报道本身也只说组织方「质疑这个巧合」，没人知道答案。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Meta Ignores Brazilian Court Order to End Bolsonaro Favoritism（Panamerican Dispatch） | https://www.panamericandispatch.org/p/meta-ignores-brazilian-court-order |
| 2 | 报道提交人 vrganj 的 HN 讨论 | https://news.ycombinator.com/item?id=50229587 |
| 3 | Meta employees say Lula's accounts restricted in Brazil election: Report（Al Jazeera） | https://www.aljazeera.com/economy/2026/10/16/meta-employees-say-lulas-accounts-restricted-in-brazil-election-report |
| 4 | 报道内部沟通的 HN 讨论 | https://news.ycombinator.com/item?id=50227639 |
| 5 | Sleeping Giants Brasil 关于 Nikolas Ferreira 的 Reels 播放量报告 | https://sleepinggiantsbrasil.com/biblioteca/visualizacoes-de-reels-e-indicios-de-favorecimento-algoritmico-o-caso-nikolas-ferreira-no-instagram-2 |
| 6 | Mônica Bergamo 在《圣保罗页报》的原始报道 | https://www1.folha.uol.com.br/colunas/monicabergamo/2026/10/entidades-apontam-novos-indicios-de-tratamento-desigual-da-meta-a-lula-e-flavio-no-tse.shtml |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及巴西 2026 年总统大选与第二轮投票、巴西最高选举法院（TSE）与联邦最高法院的选举争议、Meta 被指算法偏袒与内部沟通泄露、左右翼互指审查、美国科技公司与白宫的关系，以及中国、俄罗斯、德国等国的政治立场，均属政治敏感话题。所引观点按原帖立场呈现，不代表本项目立场。文中数字（每日罚金 50 万雷亚尔／100 万雷亚尔、约 9.9 万／19.8 万美元、选票编号 13 与 22、223 道封号令、10 条 Reels 共 4.105 亿次播放、17.2 倍／29.3 倍／33.7 倍折算值）整理自原文报道与 HN 读者在帖内转贴的报告全文，未经独立核实，请以原始报道与当事方声明为准。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
