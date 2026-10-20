---
layout: post
title: >-
  德国选择党 42 万封泄露邮件 — HN 讨论摘要
date: 2026-10-20
hn_id: 50163502
categories: [articles]
excerpt: >-
  281 GB、421,179 封德国选择党（AfD）内部邮件被公开，内容含种族歧视言论与纳粹符号。但真正引爆讨论的还有另一层：报道此事的柏林媒体要求读者先交出自己的邮箱才能读完，而选择党全国民调仍有 29%。
tagline: >-
  想看 42 万封别人泄露的邮件，你得先把自己的邮箱交出去。
---
> ⚑ **政治背景**：本文涉及德国选择党（AfD）、德国联邦宪法保卫局（Verfassungsschutz）对该党的"确认右翼极端"定性争议、德国国内情报法对极端主义言论的规制，以及欧盟/美国/俄罗斯等国的政治立场。⚠ Review recommended.

## 原文概要

周一，一个规模庞大的 AfD 内部邮件档案被公开：281 GB，包含 421,179 封党内邮件。据该报道，部分查看过档案的记者认为材料为真。档案全部在线可取，但在德国，下载传播这些材料本身可能构成刑事犯罪。

档案没有直接挂在网站上，而是先由 AI 生成的摘要呈现，并按严重程度（CRITICAL、HIGH、MEDIUM、LOW）和类型过滤，类型标签包括 `racism_xenophobia`、`corruption_money`、`leadership_feud`、`conspiracy`、`violence_threats` 和 `antisemitism_extremism`。摘要里写的东西很具体：把难民做成手袋和靴子的玩笑、在边境是否该朝难民开枪的讨论、印着万字旗并写着 "Heil Hitler" 的圣诞卡、以 "Heil und Sieg" 结尾的邮件串。

不少摘要本身就是党内的纪律处分程序——发给各级党务委员会、用来决定是否对某位党员启动开除程序。其中一封 2016 年的邮件显示，Alice Weidel 把某位党员的反犹材料转交给联邦党务委员会，同时提醒同事德国宪法保卫局可能正在看这些邮件。也有没引发党内追究的案例：一位巴伐利亚官员敦促党内头头脑脑每天喊 "Merkel croak"，以及联邦党部员工讨论如何把一名摄影师诱到党内活动上再强行架走。

AfD 向《图片报》确认了这次入侵：2026 年 9 月，黑客攻击了该党一家托管服务商的账户，部分多为多年未用的邮箱内容被非法复制。黑客自述动机是要展示该党的"堕落与虚伪"。转存档案的透明度组织 DDoSecrets 称，其软件标记出 34 份挪用资金文件、23 份账外付款、14 份未披露捐款和 7 份挪用赃款。该党目前全国民调 29%，同时在法庭上对抗宪法保卫局对其"确认右翼极端政党"的定性——萨克森-安哈尔特等州分支机构已获此定性，而该党 9 月在那里拿到 43.8% 的选票。

本次讨论源自 HN 热门榜（/best）。

## 讨论焦点

### 一篇讲邮件泄露的文章，先要你交出自己的邮箱

报道来自柏林的工作者所有制杂志 HEIST，正文被邮件墙拦住，进度条显示"You've read 21%"，剩下的要用邮箱换。这条设定成了评论区第一波共识：讨论泄露邮件的人，先被要求贡献自己的邮箱。

> "Nothing speaks more about the quality of your newsletter than forcing people to sign up for it." — stratocumulus0 [c:50163639]
>
> （译文：还有什么比强迫人注册订阅更能说明一份 newsletter 的质量。）

> "You gotta respect the honesty." — cmoski [c:50163839]
>
> （译文：这份诚实值得尊重。）

读者的实际解法分两派。一派去找免墙的替代来源：yreg 贴出 Euronews 的同题报道，ctolsen 和 SigmundurM 指向泄露档案的索引站 hexane.cc。另一派直接放弃，Markoff 说 "Give us your email to read the full story" 然后 no thanks 关掉标签页。中间还有一批人认真讨论技术方案：apples_oranges 提到 Mac 上可以生成 iCloud 一次性邮箱，SanjayMehta 推荐 mailinator。

> "In all fairness, handing over emails does seem like the central topic here." — gaiagraphia [c:50163689]
>
> （译文：公平地说，交出邮箱确实像是这里的核心议题。）

### 泄露物到底是什么：AI 摘要、torrent，还是原始邮件？

hexane.cc 页面上的说法是"完整原始邮件——带完整邮件头、正文和附件，DKIM 签名齐全——在 torrent 里"。这与原报道和 Euronews 的表述冲突：两处都说黑客公开的是 AI 摘要，不是原始邮件。mr_mitm 认为站点上"主要是元数据"，完整内容在 200 GB 以上的 torrent 里。

> "That's not the whole thing. Looks like it's mostly meta data. The whole thing is some 200G+ bittorrent. I have yet to see any actual data of this leak, even though it's all over the news." — mr_mitm [c:50164078]
>
> （译文：那不是全部。看起来主要是元数据。完整的东西是某个 200 GB 以上的 torrent。我到现在还没见到这次泄露的任何实际数据，尽管新闻里铺天盖地都是它。）

这个疑问没有在帖内得到解答，但折射出一个结构性问题：公众读到的是二手机器摘要，媒体引用的也是这份摘要，原始邮件大多没人验证。摘要的分类标签——`antisemitism_extremism`、`violence_threats`——本身决定了读者的第一印象，而生成摘要的模型和筛选规则没有公开。

> "The entire archive is available online – though it may be a criminal offence in Germany to torrent the material or distribute it online." — alkonaut [c:50163698]
>
> （译文：整个档案在线可得——但在德国，下载这些材料或在线传播可能构成刑事犯罪。）

### 时机：柏林选举之后，"反犹"标签刚被贴到左翼身上

多位评论者指出泄露公开的时间点很讲究。德国刚刚经历柏林选举，一轮持续数周的竞选叙事把左翼党（Die Linke）描述成反犹政党、把德国执政党 CDU 的说法——"Die Linke 与 AfD 差不多"——当作共识，而后者依据的是该党在加沙问题上的立场。

> "The timing of the release is rather sinister" — endangeredhuman [c:50163688]
>
> （译文：这次公开的时机相当阴险。）

> "This comes after a campaign that has been going on for weeks claiming that Die Linke is antisemitic (the left-wing party that got the most votes in Berlin's most recent election). CDU (the current national governing party) has been pushing the narrative that Die Linke is comparable to AfD, because they call for human rights in Gaza and to stop the unconditional support for Israel by the German government." — dudefeliciano [c:50163804]
>
> （译文：这发生在连续数周的一轮竞选之后——那轮竞选一直在说 Die Linke 反犹（它是在最近一次柏林选举中得票最多的左翼党）。德国当前执政党 CDU 一直在推"Die Linke 和 AfD 差不多"这个叙事，理由是该党呼吁加沙的人权，并要求停止德国政府对以色列的无条件支持。）

leothetechguy 的回应只有一句，用笑脸收尾："时机很走运，在我看来。"

### "系统在运转"：29% 民调与一个没生效的定性

数据层面的核心矛盾是：AfD 全国民调 29%，宪法保卫局的"确认右翼极端"定性在法庭上尚未生效，而它已经在部分州分支落地。dudefeliciano 把这一组事实压缩成三个词。

> "The system is working" — dudefeliciano [c:50163721]
>
> （译文：系统运转良好。）

由此引出评论区最大的一次对撞。AltruisticGapHN 认为AfD 只是想把（主要是经济）移民赶出欧洲，就会被贴上"纳粹""法西斯"的标签，而这类标签早就不管用了。这一派进而主张投右翼不会带来第三帝国，批评者则指出党徽、口号和"边境开枪"的言论本身已经把联想坐实。

> "will bring back the Third Reich and concentration camps and the like is ridiculous, and completely dishonest." — AltruisticGapHN [c:50163832]
>
> （译文：会让第三帝国和集中营回来，这个说法既荒谬又不诚实。）

> "Any association with the Third Reich reasonably comes from their use of Nazi symbolism and use of Nazi slogans." — AlecSchueler [c:50163910]
>
> （译文：把第三帝国联想起来，完全有理由来自他们使用纳粹符号和纳粹口号。）

也有评论者给出冷静的选举学解释：欧洲每个国家都有这类政党，法国 RN、奥地利 FPÖ、匈牙利 Fidesz、荷兰 PVV 都能拿到大量选票，主要因为执政党几十年来没解决选民的现实问题。ZeroGravitas 的说法更直接——出钱的人不会让中间派做任何对普通人有用的事。

> "It's pretty easy to be successfull when your competition is the established parties who make they contempt for Germans clear every day." — account42 [c:50164875]
>
> （译文：当你的对手是那些每天都在让德国人看清自己被瞧不起的建制派时，成功其实很容易。）

### 俄罗斯：制造论还是土壤论

一派认为没有俄罗斯的持续推动，AfD 不可能有今天的规模；另一派认为这已经滑向阴谋论——德国完全能内生出一个仇视的极右翼运动。

> "It's misdirection to the point of conspiracy theory to assume that Germany is incapable of organically producing a hateful far-right movement like AFD without it being manufactured by Russia" — nylonstrung [c:50163683]
>
> （译文：认为德国不可能自发长出一个像 AfD 这样的仇恨极右翼运动、除非它是被俄罗斯制造出来的——这种说法已经把注意力引偏到了阴谋论的程度。）

> "It's obscene to think they would be so successful however without Russia's active role in it." — scrollaway [c:50163749]
>
> （译文：但要认为他们在没有俄罗斯积极参与的情况下也能这么成功，未免太荒唐了。）

crimsoneer 给出中间版本：德国有法西斯的历史传统，普京当然在推一把，但影响力若真有那么大，早就看得更明显。lifestyleguru 把德国对俄的亲近串成一条线：朔尔茨、Wirecard、AfD——每一件都长出了大骗局。camillomiller 则用另一个比喻收尾：普京只需找到合适的坏种子并浇水，而这在德国是公开的秘密，党内甚至在争论公开展示对俄同情该到什么程度。

> "The German-Russian sympathy is the most incredible oddity and never fails to breed a major fraud - Schroeder, Wirecard, AfD." — lifestyleguru [c:50163940]
>
> （译文：德国对俄罗斯的亲近是最不可思议的怪事，而且从不空手而归——朔尔茨、Wirecard、AfD，一个大骗局接着一个。）

### 亲以色列与反犹并存：AfD 支持者内部的悖论

另一条线是评论者注意到的矛盾：该党一方面狂热亲以色列，另一方面推崇希特勒、传播犹太人控制世界的理论。这引出一个更大的问题——反犹和反以是不是一回事。

> "That they are rabidly pro-Israel while simultaneously glorifying Hitler and indulging in conspiracy theories of Jewish domination certainly lends credence to the idea that anti-Zionism ≠ antisemitism" — nylonstrung [c:50163659]
>
> （译文：他们一边狂热亲以色列，一边推崇希特勒、沉迷于犹太人控制世界的阴谋论——这确实让人更相信反锡安主义不等于反犹主义。）

> "Jews are grandfathered in, muslims are the new enemy. It's hilarious watching old European neonazis allying themselves with Israel today. The confusion is palpable." — INTPenis [c:50163755]
>
> （译文：犹太人算是被 grandfathered 进去了，穆斯林才是新敌人。看老欧洲新纳粹今天和以色列结盟，实在很好笑。这种混乱是有迹可循的。）

对这个问题，评论区给出三种解释。最简单的一种是双重仇恨：既恨犹太人，更恨穆斯林。throwa356262 给了更结构化的版本——民粹党需要一条简单到支持者一听就懂的信息，同时树立两个不同的敌人只会更难；"如果今天德国一个穆斯林都没有，他们的政治就会 100% 变成犹太人控制世界那一套"。

> "I think it is even simpler than that. Populist parties need to have a simple message that their supporters can easily understand. Having two quite different enemies at the same time would make things harder. If there were 0 muslims in Germany today, their politics would be 100% about Jews controlling the world and all that stuff." — throwa356262 [c:50163916]
>
> （译文：我觉得比那更简单。民粹党需要一条支持者一听就懂的简单信息，同时挂着两个很不一样 的敌人会让事情变难。如果今天德国一个穆斯林都没有，他们的政治就会百分之百变成"犹太人控制世界"那一套。）

第三种解释来自 throw310822，他搬出了 1948 年爱因斯坦与汉娜·阿伦特联名致《纽约时报》的公开信，指控当年那个"自由党"在组织方式、手段、政治哲学和社会吸引力上都与纳粹、法西斯政党高度相似，其领导人正是后来的以色列总理、后来的利库德党创建者 Menachem Begin。他还加了一句更重的判断：AfD 所谓反犹只是小菜一碟，他们真正的敌人是阿拉伯人和穆斯林。

### 从反犹到反穆：议题替换与边界争论

顺着上一节的替换逻辑，讨论滑向德国当下最热的移民议题。selfmodruntime 认为伊斯兰的某些态度和文化确实与西方不合，而社会还没想出应对办法；account42 的回怼只有一句："那也是十字军东征前的说辞？"

> "The reality is that quite a bit of islamic attitudes and culture don‘t fit in in the west. We‘ve not figured out how to counter this yet." — selfmodruntime [c:50164345]
>
> （译文：现实是，伊斯兰的某些态度和文化确实与西方不合。我们还没想出该怎么应对。）

nylonstrung 用跨国数据反驳"伊斯兰威胁论"：英国 5% 的穆斯林人口被说成要把国家送回黑暗时代，而新加坡在 15% 的比例加上成文的多元文化保障下，现代化和发展指标全面碾压。ivell 则把这条线接到更大的类比上——外群体从犹太人换成移民，需要发泄愤怒的人始终需要一个外群体。

> "The parallels are striking. Now the outgroup is immigrants instead of jews." — ivell [c:50164131]
>
> （译文：这些平行关系很扎眼。现在外群体是移民，而不是犹太人。）

也有 lived experience 的发言：myaccountonhn 说自己在德国有几个移民朋友，"这个场面让人很不舒服"。

### 右翼为什么能赢：经济不安全、羞耻失效、社媒放大

评论区最长的一条解释线不谈意识形态，只谈选民处境。keiferski 说自己不是 AfD 粉丝（他住在波兰，不想在不懂语言的国家对政党发表意见），但他认为正因为这种道德洁癖式回避，右翼在全球范围内赢了：选民最在意的是个人经济安全和家庭安全，道德上令人反感的党至少承诺回应这些问题，而看似更干净的党只会挥手赶走。

> "But I think this kind of moral approach is precisely why right wing parties have been winning globally, in the US and elsewhere. For many voters, the overwhelmingly important thing is individual economic security and personal/familial safety. Full stop." — keiferski [c:50163773]
>
> （译文：但我认为恰恰是这种道德取向，导致右翼党在全球各地——包括美国——持续取胜。对很多选民来说，压倒一切重要的是个人经济安全和家人的人身安全。就这么简单。）

这套叙事把 2026 年和 1930 年代连起来。password54321 直说纳粹是在大萧条中上台的，而历史正在重演；consp 补上机制链条：财富集中 → 投机 → 不平等 → 关税 → 国际贸易萎缩。Voultapher 则从反面举证：极右翼领导人上台后普遍违背承诺，特朗普以"鸡蛋太贵"竞选，上台后立法让农场更方便地协同定价，结果鸡蛋更贵了；他提到"让国家重新安全"这类口号的历史记录同样如此。

> "History is chock full of examples where far-right leaders got into power and broke most of their promises and achieved the polar opposite for most of their followers." — Voultapher [c:50164326]
>
> （译文：历史上塞满了这样的例子：极右翼领导人上台后违背了大部分承诺，对支持者中的大多数人来说，结果恰恰是承诺的反面。）

荷兰被视为可复制的样本：microtonal 描述 PVV 两次组阁都以灾难收场，选民随后转向更极端的 FvD（与 AfD 相当接近），几年后又回头；优势在于多党制和比例代表制让极右翼几乎总是必须 coalition，而 coalition 通常以党内或党际内斗告终——如今荷兰组阁常常需要四个党。

social media 被视为放大器而非根源。piva00 说"你低估了社交媒体煽风点火的作用"，并指向平台只关心互动量、回避监管的激励；microtonal 认为两者可以同时为真：住房与融合问题真实存在，而政党又用大规模虚假信息、火药味串烧去污染议题。

> "I think you downplay the role of social media in fanning the flames." — piva00 [c:50163982]
>
> （译文：我觉得你低估了社交媒体在煽风点火上的作用。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 邮件墙比它报道的内容更讽刺 | stratocumulus0 [c:50163639] | "强迫人注册订阅最能说明一份 newsletter 的质量。" |
| 公众看到的只是机器摘要 | mr_mitm [c:50164078] | "到现在没人见过这次泄露的任何实际数据。" |
| 时机是被设计过的 | endangeredhuman [c:50163688] | "这次公开的时机相当阴险。" |
| 29% 民调 + 定性未生效 = 系统正常 | dudefeliciano [c:50163721] | "系统运转良好。" |
| 投右翼不会带来第三帝国 | AltruisticGapHN [c:50163832] | "这是荒谬且不诚实的说法。" |
| 纳粹符号是联想的合法来源 | AlecSchueler [c:50163910] | "第三帝国的联想来自他们用的符号和口号。" |
| 极右翼崛起是建制自己的错 | account42 [c:50164875] | "对手天天让德国人看清自己被瞧不起，赢很容易。" |
| 俄罗斯制造论是阴谋论 | nylonstrung [c:50163683] | "德国完全能自发长出这种运动。" |
| 俄罗斯作用不可忽视 | lifestyleguru [c:50163940] | "朔尔茨、Wirecard、AfD，一条线上的大骗局。" |
| 反犹 ≠ 反以 | INTPenis [c:50163755] | "老欧洲新纳粹今天和以色列结盟，混乱得 palpable。" |
| 民粹党只能有一个简单敌人 | throwa356262 [c:50163916] | "没有穆斯林，他们就会 100% 谈犹太人控制世界。" |
| 道德洁癖让右翼赢了 | keiferski [c:50163773] | "选民要的是经济安全，不是体面。" |
| 极右翼上台后普遍背叛承诺 | Voultapher [c:50164326] | "以鸡蛋太贵竞选，上台后鸡蛋更贵。" |
| 社媒是放大器不是根源 | piva00 [c:50163982] | "你低估了社交媒体煽风点火的作用。" |

## 总体情绪

整场讨论的底色不是兴奋，而是疲惫。一边是"他们连 Nazis in disguise 都不装了"的断言，一边是"我朋友就在德国，我 uncomfortable"的私人感受；两边的共同前提是——那些邮件是真的。

真正的分裂点在因果。有相当一部分评论者拒绝任何"外部势力造出了 AfD"的说法，主张这更多是选举制度、移民政策、社媒算法和建制党派系内斗共同作用的结果。另一些人则认为建制与极端右翼之间存在结构性共谋，这一点在"讽刺的是文章本身也要读者交出邮箱"的那一刻被反复强化——左翼被贴上反犹标签，媒体要求用订阅换取内容，而真正的纳粹材料躺在 torrent 里。

第三条线最冷：把这一切当作可预测的重复。ivell 说人类很可以预测；keiferski 说哈里斯 2024 年输掉是因为同样原因；consp 说大萧条的机制链条正在重演。这些话听起来像抽象的历史类比，但它们指向的判断很具体——如果经济不安全不解决，道德指责对选民几乎不产生成本。

留给最后一句的是泄露本身的意义被重新定价：一次可以让 42 万封邮件成为公共材料的入侵，同时也让普通读者为了看一眼同样的材料，交出自己的邮箱。这个交换条件，是这场讨论里最没有人反驳的部分。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AfD Leak: What 421,179 Hacked Emails Show about the German Far Right | <https://news.ycombinator.com/item?id=50163502> |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及德国选择党（AfD）、反犹主义与排外言论、移民与宗教议题、德国国内情报法，以及俄罗斯、欧盟、美国相关政治立场，均属政治敏感话题，所引观点按原帖立场呈现，不代表本项目立场。文中关于邮件数量（281 GB、421,179 封）、民调（29%、43.8%）、党务处分与财务标记（34/23/14/7）等数字整理自 HEIST 报道与 HN 读者在帖内转贴的报道全文，未经独立核实，请以原始报道与当事方声明为准。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>