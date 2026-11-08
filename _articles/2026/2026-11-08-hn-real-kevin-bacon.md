---
layout: post
title: >-
  六度凯文·培根的真正中心是山姆·杰克逊：17 万名演员的数据集把培根排到第 175 位 — HN 讨论摘要
date: 2026-11-08
hn_id: 50169499
categories: [articles]
excerpt: >-
  凯文·培根的 remoteness 是 2.28，在好莱坞只排第 175；真正的中心是山姆·杰克逊（2.09），
  而他在 2006 年就坐上了这把交椅。评论区真正吵开的不是算法，是数据集：IMDb 全量版本算出的
  第一名是艾瑞克·罗伯茨，原文只用了票房前 1 万部电影。
tagline: >-
  六度分隔的游戏主角，在自己的六度世界里排第 175。
---

> 来源：HN 讨论主帖 [The Real Kevin Bacon](https://news.ycombinator.com/item?id=50169499)（380 分，97 条评论），原文是 pudding.cool 的交互式数据故事。本篇为 single post 模式；归档快照 2026-11-07 21:33 UTC，入库 97 条评论。引文保留 HN 原文的 HTML 实体与段落标记。该帖在 2026-11-07 与 11-08 的热度榜上被标记为回热（resurrected），评论区最后一条评论出现在 11 月 3 日。

## 原文概要

「六度凯文·培根」是个游戏：任意两名演员之间，只要经过不超过六步就能连上，每一步代表两人共同出演过一部电影。常规认知是，凯文·培根是包罗整个好莱坞的绝对中心。原文的做法是给每个演员算一个 remoteness——到任意演员的平均距离——结果有点反常识：培根的 remoteness 是 2.28，这个数字不算差，但远不是最好。他在这个 16.9 万名演员的数据集里只排第 175 位。

真正的中心是山姆·杰克逊，remoteness 2.09；第二名是 Willem Dafoe（2.13），第三名 Robert De Niro（2.14）。Philip Seymour Hoffman 排到第 250 位。前 100 名里女性只占 16 席，女性中排位最高的是 Nicole Kidman（第 21）。原文还做了一台「时间机器」：把计算推到过去，可以看到 1980 年以来每一年的中心是谁——2006 年山姆·杰克逊就已经坐上了这把交椅；而培根的历史最高名次是 1996 年的第 108 位，那一年他刚演完《Sleepers》。

什么在决定一个演员离中心多远？最直观的指标是片单数量：山姆·杰克逊职业生涯拍了 116 部，是全数据集最多，紧随其后的 Nicolas Cage 是 96 部。但片单数量解释不了全部——Natalie Portman 和 Anna Kendrick 片子数一样，remoteness 却差得很远。差别在共同出演的演员：Portman 合作的 250 位最高连接度演员数量，几乎是 Kendrick 的三倍。于是有了第二个因子——合作演员的产量（取该演员最 prolific 的 50 位合作者的电影数做平均）。在这个模型下，演员类型越杂、越常跟「大狗」合作，越靠近中心。

最后是预测部分。原文挑出 99 位 1997 年后出生、至少 5 部电影的 Gen Z 演员，参照历史上片数与从业年限相近的样本（同样是 15 年 16 部，Sydney Sweeney 对应的 De Niro 最终拍了 87 部，Chevy Chase 最终只有 27 部），跑了 1 万次模拟。胜出者依次是 Chloë Grace Moretz（11.6%）、Ariana Greenblatt（9.4%）、Maya Hawke（6.4%）、Isabela Merced（5.3%）、Fred Hechinger（4.7%）——Moretz 的 remoteness 中位数是 2.19，预测片数中位数 66，离杰克逊的 116 部和 2.09 还有距离。原文最后给凯文·培根留了一句：在好莱坞熬了 47 年，他的片单数量和 Helen Mirren、Gene Hackman 差不多，他本来可以是那个中心，只要早出生 20 年。

## 讨论焦点

### 一、算法之外的因素：类型跨度、franchise 巴士与配音演员

评论里最有信息量的一批，不是质疑算法，而是解释为什么算法会得出这个结果。

gste 用类型跨度解释：

> "He&#x27;s my favourite actor, so I know: he&#x27;s in a very eclectic range of films in loads of genres with all kinds of actors.<p>I think that your range as an actor helps you here. For example, Seth Rogan, while he&#x27;s in loads of films, he is extremely typecast into stoner comedies. So he is more separated from actors in other genres." — gste [c:50213059]
> （译文：他是我最喜欢的演员，所以我了解：他出现在各种类型、各种风格的电影里，跟各种演员合作。我觉得你的类型跨度在这里是有帮助的。比如 Seth Rogan，虽然片子很多，但被非常强烈地定型在「stoner comedy」那一类，所以他和别的类型的演员之间隔得更远。）

bena 则把 franchise 拆成一张张公交线路图，谁上车谁就离中心更近：

> "Being in a Marvel movie greatly increases your connectedness.<p>Samuel L. Jackson and Robert Downey Jr. are central to a lot of plotlines in the first 10 years of Marvel movies. With either them or characters connected to them appearing in other movies.<p>Then you have other franchise connections. If you&#x27;ve been in a Kevin Smith film, you&#x27;re at most three steps from Samuel L. Jackson by way of Kevin Smith -&gt; Bruce Willis -&gt; Samuel L Jackson." — bena [c:50213163]
> （译文：出演漫威电影会极大提高你的连接度。山姆·杰克逊和 Robert Downey Jr. 在漫威前十年的大量剧情线里都是核心，他们或与他们相连的角色又出现在别的电影里。然后还有别的系列连接：如果你演过一部 Kevin Smith 的电影，你离山姆·杰克逊最多只差三步——Kevin Smith → Bruce Willis → 山姆·杰克逊。）

同一段里还有两条线路：速度与激情全靠 Vin Diesel 连线，星战前传 trilogy 靠 Natalie Portman 连线。

另一个方向是配音演员。card_zero 注意到榜上出现过 Frank Welker：

> "Somehow it&#x27;s a fun fact that you can reach any other actor in four moves, but a much less fun fact that you can probably-reach any other actor in 2.6 moves.  &quot;Connectedness&quot;, huh. Though it was interesting to see that Frank Welker used to be in fourth place. Never heard of him." — card_zero [c:50212120]
> （译文：不知怎么，「四步之内能连上任何演员」是个有趣的事实，但「平均 2.6 步大概能连上任何演员」就没那么有趣了。这就是所谓的「连接度」吧。不过看到 Frank Welker 曾经排到第四位还是很有意思，我从没听说过他。）

时间维度也被反复提起，geooff_ 指出这是一条随时间变松的绳子：

> "This is missing the fact that there&#x27;s a temporal element to this. Over time, the corpus grows larger and larger meaning younger actors and actresses find connections easier through common ancestors." — geooff_ [c:50212688]
> （译文：这漏掉了一个事实——这里有时间维度。随着时间推移，语料库越来越大，年轻演员和女演员通过共同祖先找到连接变得更容易。）

### 二、数据集才是战场：IMDb 全量，还是票房前 1 万

最尖锐的一批质疑全部指向语料。ameliaquining 直接搬出更早的同类项目：

> "Prior art here is the much older Oracle of Bacon project (which I&#x27;m hoping the author didn&#x27;t know about). It uses the full IMDb data set (not just the top 10,000 films) and gets different results, with Eric Roberts in first place and Samuel L. Jackson in fifth" — ameliaquining [c:50213440]
> （译文：这件事更早的前作是 Oracle of Bacon 项目（希望作者不知道它）。它用的是完整的 IMDb 数据集，而不是票房前 1 万部电影，结果不一样：艾瑞克·罗伯茨排第一，山姆·杰克逊排第五……）

aidenn0 补上了差额在哪：

> "The data TFA uses excludes many B and DTV movies since it limits to the top 10k films.  A more catholic approach indeed puts Roberts at the top" — aidenn0 [c:50218348]
> （译文：TFA 用的数据排除了大量 B 级片和直接发行录像（DVD）电影，因为它只取票房前 1 万部。用一个更包罗万象的做法，确实会让罗伯茨排到第一……）

也就是说，原文的第一名和这份名单的第一名，差别不在方法，在样本边界。评论里因此反复点名被漏掉的那个人：

> "I&#x27;m not sure this presentation is complete if they don&#x27;t even mention Eric Roberts" — codingdave [c:50212673]
> （译文：如果连艾瑞克·罗伯茨都没提，我不确定这个演示算完整。）

> "Yeah I was disappointed that Eric Roberts wasn&#x27;t on the list of allowed actors. He was my first choice" — archermarks [c:50221696]
> （译文：对，我挺失望艾瑞克·罗伯茨不在可选演员名单里，他是我的第一选择。）

pvaldes 指出的是另一类系统性偏差——连线只在好莱坞内部成立：

> "Is nice, but incomplete, as is seems to ignore the connections between two Hollywood actors appearing in Non-Hollywood films and punish also actors that take risks in indie films. Also is not clear who deserves to be named a Hollywood actor." — pvaldes [c:50237214]
> （译文：好看，但不完整——它似乎忽略了「两名好莱坞演员一起出现在非好莱坞电影里」这种连接，同时也在惩罚那些去拍独立片的演员。另外，也没说清楚谁有资格被叫做好莱坞演员。）

还有更基础的一条：榜单只统计还在活跃的演员。

> "I don&#x27;t think the site mentions it, but it seems to stop counting actors after they retire. There&#x27;s no way anyone is within 4 movies of every single actor in history." — bagacrap [c:50217341]
> （译文：我觉得站内没提这件事，但它似乎在演员退休之后就不再统计了。没人能只靠 4 部电影就连上历史上每一位演员。）

MattGrommes 用一个具体的不合理收尾：

> "It&#x27;s weird that James Hong is so far down the list. The man has been in 470 movies." — MattGrommes [c:50216794]
> （译文：James Hong 排得这么靠后很奇怪。这个人演过 470 部电影。）

### 三、凯文·培根本人：B list 还是 A list

原帖的题目让评论区顺带吵了一场关于培根段位的旧账。

> "The thing about Kevin Bacon is he&#x27;s b list yet still highly connected.<p>Shah Ruh Khan is more like George Clooney or something." — bagacrap [c:50217319]
> （译文：关于凯文·培根这件事是，他是 B list，但连接度依然很高。Shah Rukh Khan 那种才算更像 George Clooney……）

> "Kevin Bacon is objectively an A-list actor." — cwnyth [c:50218329]
> （译文：凯文·培根客观上就是一线演员。）

支持前者的理由是数量，AnneTrotter 的说法最刻薄也最具体：

> "I mean. Footloose. But his list of stinkers is so epic it overshadows his peak movies. His career is an iceberg, with only the tiniest but showing above the popularity line." — AnneTrotter [c:50220092]
> （译文：我是说，《舞动青春》。但他那份烂片列表太 epic，把他的巅峰之作都盖过去了。他的职业生涯是一座冰山，露出水面的那一点点小得可怜。）

而题目本身为什么成立，hoppp 问得最直接：

> "Why is Kevin Bacon such a legend?" — hoppp [c:50216181]
> （译文：凯文·培根为什么是这种传奇？）

fusslo 给出的是片单和导演名单：

> "Marvel Movies, John Wick, Robert Eggers films, To Live and Die In LA, Streets of Fire, American Psycho, The Last Temptation of Christ, he was unforgettable in The Life Aquatic, and Wild at Heart!<p>The directors he&#x27;s worked with: Robert Eggers, Wes Anderson, David Lynch, Martin Scorsese, Oliver Stone, John Waters, William Friedkin, David Cronenberg, Sam Raimi... who am i forgetting?" — fusslo [c:50212840]
> （译文：漫威电影、《疾速追杀》、Robert Eggers 的片子、《洛杉矶激情》、《火爆动作场》《美国精神病人》《基督最后的诱惑》，还有《水中生活》《野性难驯》——他都令人难忘！合作过的导演有：Robert Eggers、Wes Anderson、大卫·林奇、马丁·斯科塞斯、奥利弗·斯通、约翰·沃特斯、威廉·弗莱德金、大卫·柯南伯格、Sam Raimi……我还漏了谁？）

历史榜上的位置也让人感慨，gbil 看到的是 1993 年的第二名：

> "John Candy #2 in 1993! Makes his loss hit hard even after all these years." — gbil [c:50212470]
> （译文：John Candy 在 1993 年排第 2！这么多年过去，他的离世还是让人难受。）

### 四、从明星制到 franchise 制：为什么新一代没人认识

当原文把培根的历史最好名次（1996 年的第 108 位）和今天这批 Gen Z 候选者摆在一起讨论时，评论区的解释基本一致——好莱坞换了运行方式。

> "That&#x27;s because Hollywood moved away from stars to franchises. People no longer watch a movie because an actor they know is in it, they watch it because it is connected to a franchise they know." — BoxwoodSeed [c:50219466]
> （译文：那是因为好莱坞从明星制转向了 franchise 制。现在人们看一部电影不是因为里面有自己认识的演员，而是因为它连着自己认识的系列。）

sublinear 说得更不留情面：

> "No, it&#x27;s not that you&#x27;re old. It&#x27;s that the movie industry took a big shit in the late 2000s.<p>Even the takeaways from the last few slides strongly support this. The Gen Z actors are nowhere near as prolific nor have starred in as memorable roles. Previous generations had their actors passing the baton to the next one by co-starring. None of this happened for Gen Z which is why you don&#x27;t know their names." — sublinear [c:50217773]
> （译文：不，不是你老了。是电影行业在 2000 年代末烂掉了。后面几页的结论也强烈支持这一点：Gen Z 演员远没有那么高产，也没演过那么多有记忆点的角色。前面几代演员是靠同台演出把接力棒交给下一代的，Gen Z 完全没有这回事——这就是为什么你不认识他们的名字。）

ryandrake 描述的是同一种个人体验：

> "Side note: I feel old. As soon as it started mentioning the set of younger actors, I didn&#x27;t recognize a single name. I feel like I&#x27;m watching new-ish movies, I just don&#x27;t know who the actors are and it seems like they&#x27;re all kind of interchangeable &quot;undifferentiated young good looking people&quot;." — ryandrake [c:50218561]
> （译文：顺带一提，我觉得自己老了。它一开始提到年轻演员那批名字，我一个都没认出来。我感觉自己在看不算新的新片，只是不知道那些演员是谁，而且他们看起来都像是「没差别的、年轻好看的年轻人」。）

至于原文的预测名单，reticulates 直接拆了 Moretz：

> "Chloë Grace Moretz was huge as a child star but she is basically retired now, the likelihood that she continues to appear in any major movies is very slim. Her career&#x27;s early start was beneficial to this ranking but is not representative. The likelihood that she ever overtakes Samuel L Jackson is... nothing, nada, because Samuel L Jackson is more active than her." — reticulates [c:50217868]
> （译文：Chloë Grace Moretz 作为童星时红过，但她现在基本已经退居二线，继续出演主流电影的可能性非常低。她起步早对这份排名有利，但并不代表她之后的轨迹。她超越山姆·杰克逊的可能性……等于零，因为她比山姆·杰克逊更不活跃。）

Markoff 指向另一批人：

> "Timothy chalamet or Jennifer Lawrence were famous in their 20s and seems to be doing ok (not DiCaprio level, but still), so they have for sure better opportunity to improve their remoteness score than Moretz, maybe Tom Holland stand a chance as well" — Markoff [c:50221101]
> （译文：蒂莫西·查拉梅或者詹妮弗·劳伦兹，20 多岁就出名了，现在看起来也还行（不到莱昂纳多那个级别，但至少还在），所以他们在改善 remoteness 分数上的机会肯定比 Moretz 大，Tom Holland 也许也有一线机会。）

### 五、交互体验：点不动的「tap to continue」

pudding.cool 的这类故事是要一屏一屏点着看的，于是评论区顺带成了一次兼容性测试。

> "This does not work on iOS Safari, I get stuck in a loop. I haven’t installed the latest iOS update FWIW" — quickthrowman [c:50211949]
> （译文：这在 iOS Safari 上跑不起来，我卡在循环里。顺便说一句，我还没装 iOS 的最新更新。）

> "It seemed buggy for me and kept looping around. Never got past the one that said Kevin Bacon wasn&#x27;t the center. Maybe it&#x27;s broken in Firefox?" — mikepavone [c:50214075]
> （译文：对我来说像是坏了，一直在循环。始终过不去那句「凯文·培根不是中心」。也许是 Firefox 上的 bug？）

> "Fascinating content, engaging visuals, painfully difficult navigation.<p>B+" — excalibur [c:50213455]
> （译文：内容引人入胜，视觉效果不错，导航让人痛苦。评分 B+。）

> "Only has 2 text blobs and a few actors? Not really worth a &quot;tap to continue&quot; a. If the continue doesn&#x27;t have any value" — readthenotes1 [c:50211791]
> （译文：只有两段文字和几个演员？那这个「点一下继续」实在不值得点。如果「继续」本身没有价值的话……）

但也有人认为问题在自己：

> "I don&#x27;t think you clicked far enough. There&#x27;s an <i>entire section</i> about the temporal element, replete with time-axis charts." — virgil_disgr4ce [c:50213498]
> （译文：我觉得你大概没点够。里面有一整个章节在讲时间维度，还有完整的时间轴图表。）

### 六、沉寂两周后的一条评论

这个帖子 10 月 23 日热了一轮，之后安静下来，最后一条评论出现在 11 月 3 日：

> "I&#x27;m adding &quot;Sunshine&quot; to my answer.<p>Cliff Curtis<p>Chipo Chung<p>Cillian Murphy<p>Michelle Yeoh<p>Hiroyuki Sanada<p>Rose Byrne<p>Benedict Wong<p>Chris Evans<p>Troy Garity<p>Mark Strong" — underlipton [c:50357591]
> （译文：我在答案里加上《Sunshine》。Cliff Curtis、Chipo Chung、Cillian Murphy、Michelle Yeoh、Hiroyuki Sanada、Rose Byrne、Benedict Wong、Chris Evans、Troy Garity、Mark Strong……）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 类型跨度比片单数量更关键 | gste | 拍得越杂，越靠近中心 |
| 超级英雄片是连接度加速器 | bena | 漫威、速激、星战各是一条总线 |
| 配音演员也曾排到第四 | card_zero | Frank Welker 常年霸榜 |
| 时间是隐藏变量 | geooff_ | 语料越大，年轻演员越好连 |
| 原文只用了票房前 1 万部 | aidenn0 | 换成全量，第一名就变 |
| 早有前作：Oracle of Bacon | ameliaquining | 全量 IMDb 下罗伯茨第一、杰克逊第五 |
| 名单漏了艾瑞克·罗伯茨 | codingdave | 连提都没提 |
| 艾瑞克·罗伯茨本该是首选 | archermarks | 不在可选名单里 |
| 非好莱坞电影与独立片被系统性低估 | pvaldes | 连线只在好莱坞内部成立 |
| 榜单只统计活跃演员 | bagacrap | 这是活人的榜 |
| 培根是 B list 但高度连通 | bagacrap | 片子烂，人脉广 |
| 培根客观上就是一线 | cwnyth | 不用为段位辩护 |
| 他的生涯是一座冰山 | AnneTrotter | 巅峰之作被烂片列表盖住 |
| 培根为什么是传奇 | hoppp | 六度游戏的文化遗留问题 |
| 培根的片单与导演阵容 | fusslo | Eggers、林奇、斯科塞斯、柯南伯格 |
| 好莱坞从明星转向 franchise | BoxwoodSeed | 观众追的是系列不是人 |
| 行业在 2000 年代末烂掉了 | sublinear | 代际之间没有交棒 |
| 预测名单里的名字一个都不认识 | ryandrake | 新演员像可互换的漂亮年轻人 |
| Moretz 基本已退居二线 | reticulates | 童星起点不代表轨迹 |
| 真正有希望的是查拉梅或劳伦兹 | Markoff | 也在 20 多岁就成名了 |
| 交互做得很糟 | excalibur | 内容精彩，导航折磨人 |
| 是 Safari 的锅 | quickthrowman | 卡在循环里出不去 |
| 没点够页数而已 | virgil_disgr4ce | 还有一整章在讲时间维度 |

## 总体情绪

这篇故事真正的反常识不在算法，而在时间。山姆·杰克逊在 2006 年就成了中心——也就是说，「六度凯文·培根」这个流行文化共识，本身已经落后了至少一代人。评论区因此分成两拨吵：一拨盯数据边界（全量 IMDb 还是票房前 1 万，差出来的第一名是艾瑞克·罗伯茨而不是杰克逊），另一拨盯时代机制（明星制变成 franchise 制，代际之间不再有同台演出，所以原文预测名单上的名字读者一个都不认识）。两拨吵的其实是同一件事：一张按「谁和谁一起演过」算出来的图，形状是由语料决定的。

最后还剩一层，谁都没太当真却又都提了：这个故事做得并不好用。iOS Safari 上循环、Firefox 上像坏了、导航被形容为「painfully difficult」，评分 B+。但 11 月 3 日还是有新人跑来，在自己的答案里加进《Sunshine》和一串演员名字。凯文·培根的名字被借去形容世界的连通，而在他自己的那张图上，他离中心还差 174 个位置。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | The Real Kevin Bacon（HN 主帖） | <https://news.ycombinator.com/item?id=50169499> |
| 2 | 原文：The Real Kevin Bacon（pudding.cool） | <https://pudding.cool/2026/10/kevin-bacon/> |
| 3 | 评论中提到的前作：Oracle of Bacon 中心榜 | <https://oracleofbacon.org/center_list.php> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 380 分、97 条评论，归档快照 2026-11-07 21:33 UTC，入库 97 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论及 HN Algolia 接口逐条比对，截断处用「……」标出。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于 Oracle of Bacon 排名、Eric Roberts 位置、Frank Welker 曾排第四、James Hong 参演数量、凯文·培根片单与 Helen Mirren/Gene Hackman 相近等说法均来自评论者本人，本站未做独立核实；原文的 remoteness 数值、排名与 1 万次模拟结果出自 pudding.cool 一文，本站照录。该帖 2026-11-07、11-08 在热度榜上被标记为回热（resurrected），最后一条评论发表于 2026-11-03，本站未对该标记的判定过程做复核。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
