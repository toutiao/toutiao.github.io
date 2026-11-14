---
layout: post
title: >-
  修士用 CNC 造哥特教堂：40 小时的工作量压进 2 天，评论区争的是「灵魂」 — HN 讨论摘要
date: 2026-11-14
hn_id: 50274409
categories: [articles]
excerpt: >-
  怀俄明州一群修士用五轴 CNC 刻石头，几个月的手工雕花被压进几天。538 分的 HN
  热帖里几乎没人讨论技术：争议集中在「机器刻出来的还算不算真的哥特式」——一边说这是
  迪士尼乐园里的巴黎圣母院，另一边搬出古埃及的网格、罗马的翻模和瓦特的自动复制机，
  说哥特式本来就是技术的产物。
tagline: >-
  几个月的手工雕花压进几天，修士们说是解放，评论区说是迪士尼乐园。
---

> 来源：HN 讨论主帖 [CNC Stone Carving](https://news.ycombinator.com/item?id=50274409)（538 分，143 条评论，HN 热门榜 /best），原文是 carmelitegothic.com 上怀俄明州 Carmelite 修士记录自己用 CNC 雕刻哥特石构件的笔记。本篇为 single post 模式；归档快照 2026-11-13 21:14 UTC，入库 122 条评论。引文保留 HN 原文的 HTML 实体与段落标记。该帖在 2026-11-14 的热度榜上被标记为回热（resurrected），评论区最后一条评论出现在 11 月 6 日。

## 原文概要

在美国怀俄明州 Meeteetse 的山谷里，Carmelite 修士正在用石头盖一座哥特式修道院。他们的官网 carmelitegothic.com 上有一篇专门讲 CNC 雕刻的笔记，开头就替机器辩护：哥特式这么古老的建筑形式里出现 CNC 看起来有点违和，但中世纪的建造者本来就是站在他们那个时代技术前沿的人，今天要造哥特式，它就得是现实，而不是锁在脑子里的浪漫念头。修士们把分配给自己的劳作时间（Horarium）花在工地上。

机器来自意大利贝加莫的 Prussiani Engineering。雕花和雕像用的通常是五轴机——左右、上下、前后三向平移，再加两个方向的旋转；碰到尖塔、石像这类高件还会加第六轴，把工件放上转台或车床一起插补。刀头是金刚石，不是水刀也不是激光，水只负责给摩擦生热的金刚石降温、把石粉冲走。机器可以无人值守地整夜刻。按原文的说法，一周 40 小时的活儿在 CNC 上不到两天；以前要熟练石匠花上几个月的装饰件，现在几天就能出。

流程是一条完整的数字流水线：头号石匠先在 3D 建模软件里把花叶、雕像、石像鬼捏出来，像捏橡皮泥，但有 Undo 键；CNC 程序员把模型导入 CAM 软件生成刀路，再交出 Gcode；锯工（sawyer）负责跑机器，同时用线锯和桥锯开料——两轴的线锯从一整块板上能切出 20 到 30 块小料，柱身和窗套的直料都归它，把五轴机腾给复杂件。风动凿和手工收尾依然留在流程里。

笔记里也留了一次事故。开始刻石几个月后，他们让第一台 CNC 整夜加工几根 7 英尺长的窗台，第二天早上，几百磅重的石料像被龙卷风扫过一样在铣削区里翻滚、碎裂。查下来是那批 Gcode 末尾多了一段：每根窗台雕完之后，机器被反复命令砸向台面顶端，「像一只巨大的拳头」。同一台机器此后近十年还在刻石。

## 讨论焦点

### 一、「迪士尼乐园里的巴黎圣母院」：机器刻的到底算不算真的

争议的主线在 roughly 的长评里说尽了。他并不反对机器，只是认为机器省掉的那部分正是教堂之所以为教堂的东西：

> "I understand why the monks have developed this technique, and I don’t disagree with them - the act of building a gothic cathedral is outside the capacity of modern society. I’ll never begrudge someone a hack to preserve some beauty in this machine we’ve created. But I can’t help but feel like they’ve created a facsimile of a cathedral - they’ve created the palace at Disneyland, not Notre Dame." — roughly [c:50275588]
> （译文：我理解修士们为什么发展出这套技术，也并不反对——建造一座哥特式大教堂已经超出现代社会的承受能力。我永远不会因为有人用取巧的办法，在我们这台机器里保住一点美，就去责怪他。但我忍不住觉得，他们做出的是一座大教堂的复制品——他们造出了迪士尼乐园里的宫殿，而不是巴黎圣母院。）

他背后站着 radiorental 提出的「材料的阻力」：徒手用简单工具和材料打交道本身是种冥想过程，而这恰恰是修士生活该有的东西。

> "However there is the concept of &#x27;the resistance of the material&#x27; where the act of working with the material with bare hands and simple tools is a meditative process.  Something I would have thought applicable to the contemplative and monastical life of a monk." — radiorental [c:50276582]
> （译文：不过还有「材料的阻力」这个概念——徒手用简单工具跟材料打交道，这个动作本身就是一种冥想过程。我本来以为这正适用于修士那种默观而纪律化的生活。）

那么修士为什么偏偏选石雕？tantalor 用一个确认式的问题把这条逻辑挑明：

> "Not that I disagree, but I want to confirm: you are suggesting the <i>reason</i> (or one of the reasons) they chose to do stone carving, as opposed to some other form of monastic pursuit, was <i>because</i> it took a lot of time and effort?" — tantalor [c:50275716]
> （译文：我不是不同意，但我想确认一下：你的意思是，他们选择做石雕（而不是别的某种修士功课）的原因是——或者说原因之一是——它要花很多时间和力气？）

反驳的一方则认为，「耗时」从来不是问题本身。fatbird 的算术更朴素：

> "Even with the CNC machines, this is still a multi-decade endeavor that will span generations because the number of monks (and outside support) is small and not getting larger.  They&#x27;ve scaled down the work required to match their capabilities, and still creating something that will last centuries.  Relative to their community, it&#x27;s still a cathedral effort." — fatbird [c:50279020]
> （译文：就算有了 CNC 机器，这仍然是一项要跨几代人、几十年的工程，因为修士（以及外部支持）的人数很少，而且不会变多。他们把工作量压缩到自身能力范围内，同时依然造出能立几百年的东西。相对他们的社群而言，这依然是大教堂级别的努力。）

zehaeva 则指向法国 Guedelon 那座只用时代工具和技术盖起来的中世纪城堡——与现代修士做的是相反方向的实验，但结论一样：

> "You only need to look at the group in France[0] where they are building a medieval castle using only period appropriate tools and techniques. It is more of a research project than an act of devotion, but I think it demonstrates that we are still capable of such acts." — zehaeva [c:50275721]
> （译文：你只要看看法国那个团体就行，他们只用符合那个时代的工具和技术在造一座中世纪城堡。那更像一项研究工程而不是一次献身，但我认为它证明了我们仍然有能力做这样的事。）

### 二、自动化本来就在哥特式里面

wolframhempel 直接把「自动化 = 背叛艺术」这条前提拆了：

> "Before anyone complains that this removes the human aspect of art, it&#x27;s worth stressing that sculptors have always looked for ways to automate work and save time (as the website itself points out)." — wolframhempel [c:50275842]
> （译文：在有人抱怨这抹掉了艺术中人的一面之前，值得先强调一句：雕塑家一直在寻找自动化作业、节省时间的办法（正如原文自己指出的那样）。）

> "As far back as ancient Egypt, grids and measuring tools were used to reproduce figures at different scales. Roman workshops churned out copies of Greek statues in marble and bronze, using casts and moulds. From the 18th century onwards, sculptors used outright pointing machines to transfer models into marble. James Watt, the steam engine guy, even built a mechanical sculpture-copying machine that could (somewhat) automatically reproduce reliefs and medallions." — wolframhempel [c:50275842]
> （译文：早在古埃及，人们就用网格和量具在不同尺寸上复制图像；罗马的作坊用模子和铸模批量翻制希腊雕像的大理石和青铜版本；从 18 世纪起，雕塑家开始直接使用对模机（pointing machine）把模型转移到大理石里。就连蒸汽机那位 James Watt，也造过一台机械的雕塑复制机器，能（部分地）自动复制浮雕和纪念章。）

> "Gothic architectural decoration wasn&#x27;t about expressing the inner world of its makers in the way we think of art today. Much of it was produced by large masonry workshops using standardized geometry, wooden templates and repeated designs.<p>So, yeah, using a CNC machine is truly Gothic." — wolframhempel [c:50275842]
> （译文：哥特式的建筑装饰并不像我们今天理解的艺术那样，是制作者内心世界的表达。它们中的很大一部分，本来就是由大型石工作坊用标准化的几何形制、木模板和重复的设计批量生产的。所以，是的，用 CNC 机器才是真正的哥特式。）

taion 在这条线上补了一个史料级的事实纠错：pointing machine 是 18 世纪的，但 pointing 这件事古老得多。

> "One small correction&#x2F;addition! While the pointing <i>machine</i> is 18th century, the practice of pointing itself is quite a lot older. Its precursor was the three-compass method, which was known in antiquity and recovered in the 15th century. In fact, if you look closely at Michelangelo&#x27;s David, you can see the little holes on the marble used for pointing." — taion [c:50276293]
> （译文：一个小更正／补充！pointing「机器」是 18 世纪的，但 pointing 这套做法本身要古老得多。它的前身是三罗盘法，古代就有，15 世纪重新被人发现。事实上，仔细看米开朗基罗的《大卫》，能看到大理石上留着用于 pointing 的小孔。）

更实际的先例在西班牙：巴塞罗那的圣家堂石匠从 1990 年代初就开始用 CNC 雕石头。

> "Worth noting that the stonemasons of Sagrada Familia (the catholic basilica Barcelona) have been using CNC to carve it&#x27;s stones since early 1990s. Most Barcelonians thought they would never see the temple finished in their lifetimes, myself included. Part of the progress that made its completion possible this year is thanks to this technology improving over time." — soci [c:50276920]
> （译文：值得一提的是，巴塞罗那的圣家堂（天主教宗座圣殿）石匠从 1990 年代初就在用 CNC 雕石头。多数巴塞罗那人以为这辈子都看不到这座教堂完工，我也这么以为。今年能完工，部分要归功于这项技术一路在改进。）

> "EDIT: Actually, it’s a mix of CNC roughing to shape the stone, followed by manual finishing. According to the Sagrada Família’s website, this allows each stone to remain a unique piece of craftsmanship while significantly speeding up the process." — soci [c:50276920]
> （译文：补充：其实是 CNC 粗雕定形，再人工收尾。按圣家堂官网的说法，这样既能让每块石头仍是独一无二的手工艺，又大幅加快了进度。）

shellfishgene 顺手把圣家堂抬进了「现代人做得到」的证据清单：

> "The Sagrada Família is a &quot;recently&quot; built cathedral, and I&#x27;d say is on a similar level as a Gothic cathedral. So modern society is not necessarily incapable of similar feats." — shellfishgene [c:50276844]
> （译文：圣家堂是一座「最近」建成的大教堂，而且我认为它跟哥特式大教堂是一个层级的。所以现代社会未必做不出类似的事。）

### 三、装饰为什么从建筑里消失了

帖子后半程的火力集中在一件更眼熟的事：既然机器能刻，为什么我们的城市里没有装饰？NoImmatureAdHom 抛出的解释很冷：美一旦变便宜，就不再传递任何信息。

> "Up until the late 1800s, beauty was expensive. Therefore, it was a costly (i.e., believable) signal of wealth, status, and taste. In the late 1800s and early 1900s, modern manufacturing got going and made beauty cheap. The ornate wrought iron door that took some workman hundreds of hours to produce was a good signal. Now, a cast simulacrum can be made at scale and ordinary people can have beautiful doors." — NoImmatureAdHom [c:50276836]
> （译文：19 世纪末之前，美很贵，所以它是一个昂贵的（也就是可信的）财富、地位与品味的信号。19 世纪末到 20 世纪初，现代制造业起来，把美做便宜了。那扇曾要某个工匠花几百个小时锻出的华丽铁艺大门，是个好信号；现在，一个浇铸的仿制品可以规模化生产，普通人也用得起漂亮的大门。）

PaulDavisThe1st 觉得这个说法锋利但不够准确，给出了一个更平的版本：

> "I think you could rephrase this as &quot;where what&#x27;s beautiful is no longer determined by the amount of skill and effort to construct it&quot;, which I think is also true but also more meaningful and much more accomodating to the range of actual &quot;ordinary people&#x27;s&quot; tastes ..." — PaulDavisThe1st [c:50277208]
> （译文：我觉得可以换个说法：「美不再由建造它所需的技艺与投入量决定」。我认为这个说法同样成立，但更有意义，也更能容纳「普通人」实际口味的多样性……）

Brendinooo 补上了实证那一半：

> "There&#x27;s study after study that shows that regular people are way more inclined to let things get built if it just looks good, and when people are presented with choices they&#x27;ll basically always pick the classic-looking building. And yet we never seem to get them." — Brendinooo [c:50277965]
> （译文：一项又一项研究显示，普通人只要东西看着好，就更愿意让它被建出来；而当人们面前有得选时，他们基本上总会挑那栋看起来经典的房子。可我们好像永远拿不到这样的建筑。）

而 munificent 的说法更尖：不是没人要，是建筑被有钱人整个劫持了，审美成了阶层距离的广播。

> "My cynical take is that architecture has been fully captured by the wealthy elite.<p>The elites like things the masses dislike as a way to signal their social distances from the masses. By designing a building that conforms to their elite taste at the expense of nearly everyone else who has to look at the thing, it reinforces their power and control over the space.<p>It&#x27;s the moral equivalent of buying a beachfront property and blasting noise every morning from a giant PA system just so that everyone trying to just relax on the beach knows who is really in charge." — munificent [c:50278751]
> （译文：我比较悲观的看法是，建筑已经被富人阶层彻底劫持了。精英喜欢大众讨厌的东西，借此彰显自己与大众的社会距离。通过设计一栋符合自己品味的建筑、代价由几乎所有不得不看它的人承担，他们强化了对这个空间的权力与控制。这在道德上等同于买下临海地产，每天早上用巨型音响放噪音，只为了让所有想在沙滩上放松的人知道到底谁说了算。）

bluGill 则泼了一盆冷水：先把要保护的东西分清楚。

> "Most buildings are not historic.  Protecting everything ruins the value for things that are worth protecting.<p>I have come to the conclusion that if it is worth protecting you can see it in tourist numbers - people who go out of their way to look at something." — bluGill [c:50276304]
> （译文：大多数建筑并不是历史建筑。保护一切，反而会毁掉真正值得保护的那些东西的价值。我得出的结论是：值不值得保护，看游客数量就知道——那些愿意特意跑去看的人。）

### 四、谁来买单：成本、产权与环保

修士的账很好算：一栋教堂，几十年。普通人的账要难看得多。bluGill 甩出一条经验法则：

> "We can, but will you pay for it?  The standard house building a house is cheap - some of those decorations would increase the costs by as much as double - but they won&#x27;t increase the value of the house.<p>I have a rule of thumb that seems to hold: until you get to about 3500 sq feet in a house people will choose larger over decorations where possible." — bluGill [c:50276130]
> （译文：我们可以做到，但你愿意付钱吗？盖一栋普通住宅很便宜——某些装饰会把成本抬到两倍——但它不会抬升房子的价值。我有条经验法则似乎一直成立：一栋房子在 3500 平方英尺以内，人们会优先选更大，而不是选装饰。）

LinuxAmbulance 从业主那一侧给出了同一结论的商业版本：

> "In short, buildings have two scenarios - one, the person or company paying for the building plans on keeping it over the next decade plus, or two, the buyer plans on flipping the building as soon as possible.<p>In the first case, and extremely so in the second, buyers are entirely without taste and despise spending any money that they don&#x27;t absolutely have to. The desire to min&#x2F;max buildings has led to function over form to the point of nearly ignoring form." — LinuxAmbulance [c:50279706]
> （译文：简而言之，建筑有两种情形——要么是出图纸费的业主打算持有十年以上，要么是买家打算尽快转手。在第一种情形下、在第二种情形下尤其如此，买家完全没有品味，鄙视任何不是非花不可的钱。把建筑成本压到最低、把收益拉到最高的欲望，让功能压过了形式，几乎把形式本身抹掉。）

> "&quot;Cheap&quot; is the top priority, followed closely by &quot;inoffensive to the people we want to rent this to &#x2F; flip this to&quot;. This results in cheap, low effort facades and an absolute minimum of permanent decorative elements.<p>Buildings are seen as short term (10 years or less) consumable items, and nothing endures long enough to make it seem worthwhile to buyers to put any money towards design excellence." — LinuxAmbulance [c:50279706]
> （译文：「便宜」是第一优先级，紧随其后的是「不得罪我们想租给／转手给的人」。结果就是廉价、不费力的立面，和被压到最低下限的固定装饰。建筑被视为十年以内的短期消耗品，短到没有任何东西能维持得足够久，值得买方为设计上的优秀掏钱。）

但「不值得」这件事，评审标准本身就有争议。venzaspa 提醒还有几千座没什么钱的小教堂：

> "Not every building with stone carvings will be gothic cathedrals with regular incomes- there will be thousands of small churches out there, which don&#x27;t have the budget for expensive stonemasons to hand carve items for repairs.<p>If we want to protect historic buildings for generations to enjoy then we&#x27;re going to need to be more pragmatic." — venzaspa [c:50275867]
> （译文：不是每座带石雕的建筑都是有大教堂那种稳定收入的大教堂——外面有几千座小教堂，它们请不起昂贵的手工石匠来修配零件。如果我们想保护历史建筑、留给后代享用，就得讲点更实际的办法。）

vinaigrette 把话说得更不客气，顺便给了环保派一记闷棍：

> "A friend of mine wrote about neo-pastiche in Plessis-Robinson, France in Archiscopie magazine. He showed me very impressive images of styrofoam shaped as greek, roman and hausmannian elements sprayed with a cheap render slapped on a concrete building that end up gentrifying neighborhoods. Perhaps a low quality, poorly performing, ecologically irresponsible building is what you want ? I&#x27;d rather be paying for what I consider important for a building (longevity, ecology and thermal efficiency) than some esthetical addendum.<p>In the end, the construction industry is really a deciding factor : you only see, as a classic survivorship bias phenomena, what the best building with all the money in the world looked like, ie cathedrals, palaces, and expect every building to have the same standard today. It is not realistic, nor responsible. Cheap building for the masses have always been the norm!" — vinaigrette [c:50279522]
> （译文：我一位朋友在 Archiscopie 杂志上写过法国 Plessis-Robinson 的新拟古风。他给我看过一些极其唬人的图片：把希腊、罗马和奥斯曼式的构件用聚苯乙烯泡沫塑形，喷一层廉价涂料，直接糊在混凝土楼外面——最后还把街区给中产化了。难道你想要的就是一栋低质量、性能差、生态上不负责任的建筑？我宁愿把钱花在我认为对建筑重要的事上（寿命、生态和热工效率），而不是某种审美加料。说到底，起决定作用的是建造行业本身：你只看得见（典型的幸存者偏差）有全世界最多钱时建出来的最好建筑，也就是大教堂和宫殿，然后期待今天每栋房子都有同样标准。这既不现实，也不负责。给大众盖便宜房子，一直都是常态！）

Brendinooo 把这个二选一拆了，还顺手把环保账翻了过来：

> "I would call this a false dilemma. There are a bunch of examples in Manhattan of beautiful facades that are extremely ornate but are painted cast iron. It does not have to be styrofoam.<p>&gt;I&#x27;d rather be paying for what I consider important for a building (longevity, ecology and thermal efficiency) than some esthetical addendum<p>First of all, I&#x27;m not even sure that modern buildings achieve these goals." — Brendinooo [c:50280535]
> （译文：我会把这称作假两难。曼哈顿有一堆例子：极其华丽的立面，其实是刷了漆的铸铁。它不必是聚苯乙烯泡沫。〈转引上文 vinaigrette：「我宁愿把钱花在我认为对建筑重要的事上（寿命、生态和热工效率），而不是某种审美加料。」〉首先，我甚至不确定现代建筑真的实现了那些目标。）

> "If a building is beautiful, it is loved; if it is loved, it is more likely to remain. And a building that remains is best for ecology.<p>And also, buildings are not just for the owners, they are public works, and should be designed as such. An &quot;esthetical addendum&quot; is not mere vanity, it is an important contributor to quality of life in a city." — Brendinooo [c:50280535]
> （译文：一栋建筑如果美，就会被爱；被爱，就更可能被留下来。而留下来的建筑，对生态最友好。另外，建筑不只是给业主的，它是公共工程，就应该按公共工程来设计。所谓「审美的附加项」不只是虚荣，它是城市生活质量的重要贡献者。）

### 五、修士是什么人：苦修、过剩男丁与「工作创造者」

讨论绕到修士身上时，评论区顺手翻出了修道院的政治经济学。Maken 的一句话把「修士」还原成了历史功能：

> "Concretely it absorbed an excess of male heirs so they could live a comfy life and would not try an hostile takeover over their elder brothers&#x27; state." — Maken [c:50275894]
> （译文：具体来说，它（教会）吸纳了多余的男性继承人，让他们能过得舒服，同时不会去争夺兄长的家产。）

ramesh31 接着反驳，但反驳的方向反而更支持「这条路提供了今天稀缺的东西」：

> "That was often a consequence, but in general it provided an alternative pathway to male success in life and a means of advancing through a respected status hierarchy that did not depend on the traditional markers. Something sorely lacking today, when even outside the question of inheritance you are faced with the near impossibility of achieving the economically independent and socially valuable life that your grandfather or father had by simply working." — ramesh31 [c:50276125]
> （译文：那常常是结果之一，但总体上它提供了一条男性在世上取得成功的替代路径，一种不依赖传统标记、通过受尊重的身份序列往上走的方式。这在今天极其稀缺——即便撇开继承问题不谈，你也会发现，要靠单纯劳动去获得你祖父或父亲那种经济独立且对社会有价值的人生，几乎已经不可能了。）

而把这条帖子重新点着的那条评论（11 月 6 日）说的是同一件事的另一面：

> "It’s hard to say because the church was the job creator. In effect it was like working for the government. So who knows. I’d imagine like any society, you had a few “men of God” and then the rest of the people helped build the church then went to a brothel afterwards.<p>It’s far too easy to romanticize the past, which was categorically rife with hypocrisy just like today.<p>It’s pretty easy to understand monks though: they are getting meaning out of life through their work on something bigger than themselves." — whatthejesus [c:50393473]
> （译文：很难说，因为教会曾是工作创造者。实际上那就像给政府打工。谁知道呢。我想在任何社会里都是这样：有那么几个「上帝的人」，其余的人帮忙把教堂盖起来，然后去妓院。总之，把过去浪漫化太容易了，那里面从来都充斥着虚伪，和今天没两样。不过修士倒是挺好理解：他们通过一件大于自身的事业，从生活里获得意义。）

另一条更不留情面：

> "It’s the architecture and the design that reflects the Lord almighty. The peasants doing it are a means to an end: so the church stands tall, so they can massacre the non-believers, burn witches, infidels, and imprison astronomers. All in the comfort of a beautiful cathedral." — whatthejesus [c:50275882]
> （译文：反映至高神的是它的建筑与设计。动手的农民只是手段：为了教堂高高地立起来，好让他们去屠杀异教徒、烧死女巫与异端、把天文学家关起来——同时享受一座美丽大教堂带来的舒适。）

也有人提醒：别只把中世纪修士当成只会祈祷的人。

> "It may be worthwhile noting that the medieval Carmelites have pulled off some impressive civil engineering projects in their own right. St. John of the Cross himself is credited with the design and construction of an aqueduct for their monastery in Spain.<p><a href="https:&#x2F;&#x2F;www.ocarm.org&#x2F;en&#x2F;item&#x2F;4545-st-john-of-the-cross-mystic-of-the-light" rel="nofollow">https:&#x2F;&#x2F;www.ocarm.org&#x2F;en&#x2F;item&#x2F;4545-st-john-of-the-cross-myst...</a><p>It may seem from our perspective that monasteries are full of prayer and spiritual endeavors, but they are also the site of a large amount of manual labor and highly-educated expertise that can be brought to bear on large projects like this." — ButlerianJihad [c:50276955]
> （译文：也许值得提一句，中世纪的 Carmelite 自己也完成过一些了不起的土木工程。圣若望·十字本人就被认为参与了他们西班牙修道院那条引水渠的设计与施工。从我们的视角看，修道院似乎充满了祈祷与灵修，但它们同时也是大量体力劳动与高水准专业能力的所在地，完全能承担得起这样的大项目。）

ricardobeat 的一句话把整个项目的成本结构讲清楚了——这不是钱的问题，是时间的问题：

> "I love this story. They started roasting coffee and saving money for nearly a decade, until they could buy land in the mountains, and then set out to build a medieval monastery entirely in stone and developing the CNC machining. It&#x27;s amazing what people can do when they have a goal." — ricardobeat [c:50276119]
> （译文：我喜欢这个故事。他们先烘咖啡、攒钱，攒了将近十年，直到能买下山里的地，然后才动身用石头盖一座中世纪修道院，同时摸索 CNC 加工。有目标的时候，人真能做出不可思议的事。）

### 六、题词、能耗账与更便宜的替代品

帖子里有个反复出现的梗：William Blake 的《And did those feet in ancient time》里那句 “dark Satanic Mills”。评论者立刻分成两派，一派说这是标题党的误会，一派说其实没误会。

tim333 去查了原诗：

> "I criticise organised religion but have never much associated it with gothic.<p>Blake&#x27;s first mention of mills says &quot;Get to thy Labours at the mills&quot; which doesn&#x27;t sound very church like <a href="https:&#x2F;&#x2F;upload.wikimedia.org&#x2F;wikipedia&#x2F;commons&#x2F;8&#x2F;8b&#x2F;Milton_a_Poem%2C_copy_C%2C_object_4_%28Bentley_4%2C_Erdman_6%2C_Keynes_4%29_detail-a.jpg?utm_source=en.wikipedia.org&amp;utm_campaign=imageinfo&amp;utm_content=thumbnail_unscaled" rel="nofollow">https:&#x2F;&#x2F;upload.wikimedia.org&#x2F;wikipedia&#x2F;commons&#x2F;8&#x2F;8b&#x2F;Milton_a...</a><p>I looked him up and funnily enough he lived in the same area I do. The majority the churches are not gothic eg. St Pauls.<p>Also he lived at a time when cotton mills were booming which do look kind of dark and satanic" — tim333 [c:50287311]
> （译文：我批判有组织的宗教，但从来没把哥特式跟它联系在一起。Blake 第一次提到 mills 时说的是「Get to thy Labours at the mills」（去你那 mills 里劳作吧），这听起来一点也不像教堂。我查了一下，有意思的是他就住在我现在这个区域。多数教堂并不是哥特式的，比如圣保罗大教堂。）

ninalanyon 给出了另一种读法：

> "One of the interpretations of the poem is that it criticises organised religion and that the mills in question are the church as an organisation represented in concrete terms by the church buildings." — ninalanyon [c:50281239]
> （译文：这首诗的一种解读是：它在批判有组织的宗教，而诗里的 mills 就是作为组织的教会，其具体化身就是教堂建筑。）

干脆反讽回去的也有：

> "What&#x27;s more gothic than dark satanic mills" — RobotToaster [c:50275875]
> （译文：还有什么比黑暗的撒旦工厂更哥特式的呢？）

真正没人数的，是石材和混凝土之间的那笔能耗账。NonHyloMorph 把它摆了出来：

> "How is the energy footbrint of cutting and machining stones in comparison to pouring concrete? How for the whole of mining tarnsporting cutting stone in comparison to mining sand and lime, firing the concrete, transporting and pouring it? Would seem like the energy that is already invested through geological processes to make stone (sedimentary, metamorphic, pyrophoric) would be a huge share of the energy. The whole chemical energy needed for concrete should be huge comparatively to blasting once way through a rock deposit and cutting it. But then that is entirely unsubstantiated and I&#x27;m very aware that such intuited assumptions are very prone to erring." — NonHyloMorph [c:50287914]
> （译文：切割和加工石材的能源足迹，和浇筑混凝土相比是什么量级？把开采、运输、加工石材的整条链，和开采砂石与石灰、烧制混凝土、运输并浇筑相比呢？直觉上，似乎光是把石头造出来（沉积岩、变质岩、火成岩）所投入的地质过程能量，就占了很大一份。混凝土所需的全部化学能，相比之下应该相当巨大——毕竟它只要把一座岩体炸开一次再切一刀。不过这完全未经证实，我也非常清楚这种直觉式的假设极容易出错。）

至于「如果不用真石头」这条路，评论里也给了两个现成方案——一个是工业界已经在做的，一个是更便宜的：

> "Monumental and Robotor do this<p>E.g. <a href="https:&#x2F;&#x2F;x.com&#x2F;Monumental_Labs&#x2F;status&#x2F;2102775795689419214?a=xFXsasTSvod8T4j0468&amp;s=20" rel="nofollow">https:&#x2F;&#x2F;x.com&#x2F;Monumental_Labs&#x2F;status&#x2F;2102775795689419214?a=x...</a><p><a href="https:&#x2F;&#x2F;www.cbsnews.com&#x2F;news&#x2F;robot-role-marble-art-sculpting-60-minutes&#x2F;" rel="nofollow">https:&#x2F;&#x2F;www.cbsnews.com&#x2F;news&#x2F;robot-role-marble-art-sculpting...</a>" — arjie [c:50277666]
> （译文：Monumental 和 Robotor 就是干这个的。例如：他们公司在 X 上发的机器雕大理石作品，以及 CBS《60 分钟》关于机器人雕大理石艺术的报道。）

> "You could probably get something that looks very close by 3d printing forms and casting it in tinted concrete." — sarchertech [c:50282018]
> （译文：大概可以用 3D 打印出模具，再浇成染色混凝土，做出看起来很接近的东西。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 机器刻的不是真大教堂 | roughly | 造出来的是迪士尼乐园里的宫殿，不是巴黎圣母院 |
| 徒手与材料的阻力本身是冥想 | radiorental | 这正该是修士生活的一部分 |
| 选石雕是不是因为它费时间 | tantalor | 把「苦修」的逻辑挑明 |
| 相对他们的社群仍是大教堂级努力 | fatbird | 工作量压缩了，努力的性质没变 |
| 纯手工造城堡证明现代人做得到 | zehaeva | 法国 Guedelon 是反向实验 |
| 雕塑家一直在自动化 | wolframhempel | 古埃及网格、罗马翻模、瓦特复制机 |
| pointing 这套做法比 pointing machine 老得多 | taion | 《大卫》上的小孔就是证据 |
| 圣家堂石匠 1990 年代初就在用 CNC | soci | 粗雕用 CNC，收尾靠手工 |
| 圣家堂算现代社会的同类成就 | shellfishgene | 现代人做得到 |
| 美变便宜就不再传递信号 | NoImmatureAdHom | 铁艺大门从几百小时变成浇铸件 |
| 更准确的说法是「美不再由技艺与投入决定」 | PaulDavisThe1st | 同一个现象的另一种表述 |
| 普通人其实更想要经典外观 | Brendinooo | 研究显示他们总是挑经典 |
| 建筑已被富人阶层劫持 | munificent | 审美是阶层距离的广播 |
| 保护一切会毁掉值得保护的东西 | bluGill | 值不值得保护，看游客数量 |
| 装饰让成本翻倍但不抬房价 | bluGill | 3500 平方英尺经验法则 |
| 平庸的现代建筑该怪业主 | LinuxAmbulance | 「便宜」第一，「不得罪买家」第二 |
| 保护历史建筑要讲实际办法 | venzaspa | 外面有几千座请不起石匠的小教堂 |
| 幸存者偏差：只看得见有钱时的杰作 | vinaigrette | 泡沫塑形贴皮也在美化街区 |
| 假两难：曼哈顿有刷漆铸铁立面 | Brendinooo | 不必是泡沫 |
| 美→被爱→留存→最环保 | Brendinooo | 建筑是公共工程 |
| 教会吸纳过剩男性继承人 | Maken | 另一条不争夺兄产的路 |
| 这条路提供了今天稀缺的东西 | ramesh31 | 靠劳动获得体面人生几乎不可能了 |
| 教堂曾是工作创造者 | whatthejesus | 11 月 6 日那条把帖子点着的评论 |
| 修士从大于自身的事业里获得意义 | whatthejesus | 这条最容易被浪漫化 |
| 中世纪 Carmelite 自己也干土木工程 | ButlerianJihad | 圣若望·十字修过引水渠 |
| 攒了近十年咖啡钱才买下山里的地 | ricardobeat | 瓶颈是时间不是钱 |
| Blake 的 mills 指的是棉纺厂不是教堂 | tim333 | 多数教堂本来就不是哥特式 |
| 另一种读法：mills 就是教会的建筑 | ninalanyon | 诗在批判有组织的宗教 |
| 没人算过石材和混凝土的能耗账 | NonHyloMorph | 直觉偏向石头，但完全未证实 |
| 替代方案已经有了 | arjie | Monumental、Robotor |
| 或者更便宜：3D 打印模具 + 染色混凝土 | sarchertech | 看起来很接近 |

## 总体情绪

这帖真正的裂缝不在技术。538 分、143 条评论，最后吵的还是那两个老问题：机器能不能造出配得上「教堂」这个词的东西，一栋建筑值不值得为它的好看多花一倍的钱。前一个问题被「哥特式本来就是技术的产物」挡了回去——从古埃及的网格到瓦特的自动复制机，理由都齐了；后一个问题没人解决，成本、产权周期、审美信号、石材的能耗账，没有一笔被认真算过。

真正把这条帖子重新点亮的，是一条来路不明的评论，出现在评论区冷了将近八天之后。它说教堂过去是工作创造者，而修士是在一件大于自身的事业里找到意义。整场讨论里最刻薄的批评和最踏实的辩护，说的其实是同一件事：一座大教堂从来不只是石头，是一群人愿意为它交出的时间——而那恰恰是机器省不掉的部分。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | CNC Stone Carving（HN 主帖） | <https://news.ycombinator.com/item?id=50274409> |
| 2 | 原文：CNC Stone Carving（Carmelite Gothic） | <https://carmelitegothic.com/cnc-stone-carving/> |
| 3 | 修士日程表 Horarium | <https://www.carmelitemonkshorarium.org/> |
| 4 | 文中提到的 Guedelon 中世纪城堡工地（法国） | <https://www.guedelon.fr/en/> |
| 5 | Tom Wolfe《From Bauhaus to Our House》 | <https://en.wikipedia.org/wiki/From_Bauhaus_to_Our_House> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 538 分、143 条评论，归档快照 2026-11-13 21:14 UTC，入库 122 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，每段引文均为该条评论的连续原文片段。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于 Guedelon 城堡、圣家堂的 CNC 使用史、Blake 题词、Tom Wolfe 著作、Prussiani 机器轴数与刀头材质、圣若望·十字修筑引水渠等说法均来自评论者本人或原文，本站未做独立核实；原文抓取内容按 8000 字符截断，教堂造价、进度与捐赠等数字原文未披露，本站不做推测。该帖 2026-11-14 在热度榜上被标记为回热（resurrected），最后一条评论发表于 2026-11-06，本站未对该标记的判定过程做复核。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
