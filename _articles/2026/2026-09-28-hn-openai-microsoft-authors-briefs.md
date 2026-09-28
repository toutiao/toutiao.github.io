---
layout: post
title: >-
  HN 讨论摘要 — OpenAI 高管明知《冰与火之歌》未完也要训练 GPT
date: 2026-09-28
hn_id: 49863864
categories: [articles]
excerpt: >-
  新版诉状披露 OpenAI 高管内部对话——明知 LibGen 非法仍用于训练,还说"反正人会失业"。HN 讨论分裂:版权保护 vs 创业自由 vs 公平使用之争。
tagline: >-
  他们把马丁的未完稿喂给 GPT,说"反正人会失业"。
---

## 原文概要

> 来源: HN 热门榜 (/best)

美国作家协会 (Authors Guild) 与多名畅销书作家集体诉 OpenAI 和微软一案,2026 年 9 月 17 日有重大文件解封。原告方提交了 Class Plaintiffs' Memorandum of Law in Support of Motion for Partial Summary Judgment (Docket 1982) 以及 Rule 9.37.1 Statement of Undisputed Material Facts (Docket 1987),把被告方的内部对话直接摆到法庭上。

原告阵容几乎是当代美国畅销书作家的"复仇者联盟":大卫·鲍达奇、泰勒·布兰奇、迈克尔·康奈利、西尔维娅·戴伊、乔纳森·弗兰岑、约翰·格里森、乔治·R·R·马丁、朱迪·皮考特、詹姆斯·夏皮罗等十几位作家,加上超过 18,000 名会员的美国作家协会。首席律师是 Susman Godfrey 的 Justin A. Nelson。

最具杀伤力的是 2020 年 5 月 OpenAI 政策总监 Jack Clark 的内部发言:"Our work on AI and Creativity is going to increasingly lead to us creating systems that substitute for the labor of [] people ... The better we do on GPT-X, the more worried genre fiction authors will become about us substituting for them on Amazon。"他随后补刀:"Our work in this area will make people unemployed ... There will be a point where a bunch of artists express worry about what we're doing here and we'll likely ignore their concerns and release anyway"。

2022 年加入 OpenAI 改善写作质量的 Tarun Gogineni,任务更赤裸:研究目标是让 GPT 写出 A Song of《冰与火之歌》系列的最后两本,让"GRRM 早逝也没关系,GPT-5 会替他写完"。他对作家抗议"数据集被盗"的反应是"可接受的经济破坏",还预言"读者之死"和"机器为机器造垃圾"。

诉状最关键的一击指向微软:2019 年 4 月,Sam Altman 和时任研究总监 Dario Amodei 把一个早期版本的 GPT-3 展示给比尔·盖茨和 Kevin Scott,当场披露了 LibGen 的使用。Amodei 在 Slack 里评价 LibGen"有点 sketchy",而研究员 Sam McCandlish 担心的不是法律,而是"光学"——'openai uses copyrighted data from sketchy russian website' 这个标题出现在 HN 上"会很不幸"。

2022 年夏天,OpenAI 内部启动代号"Project Clear"的删档行动,清除所有 LibGen 痕迹。VP of Research Bob McGrew 在 Slack 写道:"现在是从我们系统和存储中切除 LibGen 的最佳时机"。

诉状总结:这些模型对作家和出版商构成"存在性威胁",OpenAI 整个盗书计划是在充分知情的前提下进行的。

法庭预计 2027 年初举行听证。

## 讨论焦点

### 「sketchy russian website」——内部人自己也知道这事见不得光

> "I was just worried about optics – i.e. 'openai uses copyrighted data from sketchy russian website' showing up on [Hacker News] would be unfortunate." — Sam McCandlish, OpenAI 研究员 [c:49863929]

> （译文:"我只是担心光学问题——'OpenAI 使用来自可疑俄罗斯站点的版权数据'这种说法会很不幸。"）

这条 Slack 记录被无数人引用,因为它把整个故事的焦点从"他们是不是违法"拉到了"他们是不是在乎违法"。研究员担心的不是被抓,而是被骂。HR 部门发的新员工培训里大概很快就会新增一节:"如何在 Slack 里少说两句"。

### 比尔·盖茨 2019 年就知道了——而 OpenAI 是 GPT-3 的展示现场

> "Microsoft knew about OpenAI's use of LibGen as early as April 2019 when Sam Altman and Dario Amodei presented an early version of GPT-3 to Bill Gates and disclosed the use of LibGen to Gates and Microsoft's Chief Technology Officer Kevin Scott, among others." — 诉状原文 (Docket 1982) [c:49864620]

> （译文:微软早在 2019 年 4 月就已知道 OpenAI 使用 LibGen,当时 Sam Altman 和 Dario Amodei 把 GPT-3 的早期版本展示给比尔·盖茨,并向盖茨和微软首席技术官 Kevin Scott 等人披露了 LibGen 的使用情况。）

这等于把微软从"无辜投资人"打成"知情合伙人"。多年声称"我们只是投钱,不知道他们数据怎么来"的大门,在 2019 年 4 月那场演示后就关上了。

### Jack Clark 的"反正人会失业"——把论文写进自己墓志铭

> "Our work in this area will make people unemployed. . . There will be a point where a bunch of artists express worry about what we're doing here and we'll likely ignore their concerns and release anyway . . ." — Jack Clark, OpenAI 政策总监 (2020 年 5 月内部文档, 见 Docket 1982)

> （译文:"我们这领域的工作会让人失业……会有那么一天,一群艺术家开始担心我们在做的事情,而我们很可能会无视他们的担忧,继续发布。"）

政策总监亲口写下这段话,等于 OpenAI 在法庭上递了一把刀给原告。MattGaiser 在评论区写道:"我们倾向于接受违法,只要它给我们想要的产品——有好几家市值几十亿的企业,创世故事就是'要不我们就无视法律'" [c:49864755]。把"先斩后奏"包装成"创新精神",这套话术我们已经听了二十年。

### Aaron Swartz 的平行宇宙——同样的法律,不同的命运

> "Why are we giving free pass to these tech companies? Why are we trusting these CEOs when they have repeatedly broken laws? Remember Aaron Swartz and the fate he suffered? Why is big tech getting away with so much more?" — quaintdev [c:49864650]

> （译文:"我们为什么给这些科技公司一路绿灯?他们反复违法时我们为什么还信任这些 CEO?记得 Aaron Swartz 和他遭受的命运吗?大科技公司为什么可以逍遥法外?"）

Swartz 因下载 JSTOR 学术论文被联邦检察官追诉,最终自杀。OpenAI 用整座 LibGen 训练商业产品,目前面临的是民事诉讼——金额可能是"成本的一小部分"。idiotsecant 写道:"1.5 亿美元——这差不多是他们 GPU 运来的纸箱钱!对大人物这只是'做生意成本',对小人物则是终结人生的判决" [c:49865946]。这种落差不是法律问题,是政治问题。

### 公平使用的边界——训练归训练,产品归产品

> "A xerox machine can produce verbatim copyrighted works when asked as well. That doesn't make distributing the xerox machine the same as distributing the copyrighted works." — tpmoney [c:49866861]

> （译文:"施乐复印机也能按需生成完整版权作品。这并不等于分销复印机就是分销版权作品。"）

版权法在新技术出现时多次被迫调整。印刷机、录像机、复印机、搜索引擎都走过这条路。tpmoney 的论点很技术:模型本身是工具,工具的双重用途不应当让制造商承担无限责任。Eddy_Viscosity2 反驳说:"你买复印机回家,不可能让它'凭空印出'你没放进去的版权书" [c:49869253]。差别在:复印机不会背诵整本书,模型会。这个区别可能就是法庭要花 2027 年一整年去裁决的核心。

### 署名权消失——比"偷"更糟的是"擦"

> "Imagine piracy websites and trackers just dropping first few pages that name their authors, and publishing 'the book you are looking for'. This is exactly what happened." — smugglerFlynn [c:49866058]

> （译文:"想象盗版网站和种子站直接砍掉写有作者姓名的前几页,然后发布'你要的书'。现在发生的就是这回事。"）

版权之争常被简化为"偷不偷",但 AI 模型剥夺的不只是稿费,更是署名。书被盗版至少还署着原作者的名,模型吐出时谁都不知道背后是哪几本书。YQX 的平行比较更尖锐:Swartz 反抗的是学术出版商对公共资金的"知识圈地";AI 公司做的是对个人创作者版权产出的"知识圈地",规模更大,后果更严重 [c:49865888]。两次都是"用别人的内容赚钱",只是分账模式换了。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| OpenAI 早有预谋 | quaintdev [c:49864650] | 反复违法的 CEO 不该被信任 |
| 大科技豁免权 | idiotsecant [c:49865946] | 1.5 亿罚款对巨头只是纸箱钱 |
| 公平使用边界 | tpmoney [c:49866861] | 复印机也能印版权书,但不等于它侵权 |
| 训练 ≠ 替代 | kenmacd [c:49866148] | Anthropic 案已判训练是转化性使用 |
| 署名权被剥夺 | smugglerFlynn [c:49866058] | 模型比盗版更彻底,连作者名都抹掉 |
| 律所只是工具 | locknitpicker [c:49864645] | 多数公司早就在培训新员工"少说两句" |
| 「sketchy」是公关词 | TeMPOraL [c:49864789] | LibGen 担忧本质是怕被联想为俄罗斯 troll farm |
| 双重标准 | SXX [c:49865290] | OpenAI 想让"蒸馏"违法,正是它对全网做的事 |
| 自动化本该如此 | Skyy93 [c:49864549] | 让工人失业?自动化行业一直如此,为何作家特殊? |

## 总体情绪

讨论分裂成三个阵营,几乎不沟通。第一派把诉状当成"良知迟到的清算",引用内部文档证明这不是疏忽而是有意为之;第二派专注法律技术,认为 Anthropic 案的"转化性使用"原则应同样适用,训练和输出是两件事;第三派则把整个事件读成产业政治——AI 公司一边用 LibGen 训练,一边推动"蒸馏"立法,正是经典的双重标准。

争议之外的共识是:这场诉讼的核心不是"训练模型算不算偷",而是"知道自己在偷还继续做"算不算加重情节。法庭上的 OpenAI 不需要否认使用 LibGen——它要否认的是"知情且故意"。从目前解封的文件看,这条路很窄。

读者已死,作者也在被宣布死亡的路上。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Unsealed Briefs in Authors' Case v. Microsoft/OpenAI | <https://news.ycombinator.com/item?id=49863864> |

---

<div class="disclaimer">

本文由 AI 辅助整理自 Hacker News 评论区,不代表原作者立场。引文 [c:nn] 为 HN 评论 ID,可通过 <https://news.ycombinator.com/item?id=nn> 直接定位。

<br><br><em>本摘要由 AI 模型辅助生成: minimax-cn-coding-plan/MiniMax-M3</em>

</div>