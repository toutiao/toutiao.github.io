---
layout: post
title: >-
  A city-building game in which the city would prefer you didn't — HN discussion digest
date: 2026-10-11
hn_id: 50036864
categories: [articles]
excerpt: >-
  一位 SF 开发商在 16 年里拼出 4,147 套住房，城市同期还差 82,069 套。游戏《Discretionary Review》把这套荒诞搬到桌面上，玩家必须与一场接一场的听证、上诉、起诉同行。
tagline: >-
  你想盖房子，旧金山想让你别盖。
---

## 原文概要

上周，独立开发者 Oliver Sin 上线了《Discretionary Review》——一款以旧金山房地产开发为蓝本的城市建造模拟器，发布在他的个人站 `over.pizza` 下，链接指向 `housing.over.pizza/`（HN 热门榜 /best，2026-10-10 18:31 UTC 提交，截至北京时间 10-11 04:00 共 231 分、81 条评论）。

游戏把开发商的角色切成"递案—拉选票—迎接审—打官司—再审"的循环：地块买下不算数，必须先过邻里打分（"The Neighborhood" 评分）、再熬过 8 轮投资人复盘、然后在市议会听证里挨反对意见。游戏内嵌一份"规则手册"，末尾注明："Every rule, vote count and case in this game is drawn from the public record. Sources are in docs/research/ in the project folder."（所有规则、票数和案卷都来自公开记录，文档仓库在项目目录）。游戏里有一关直接触发"蓝天飞行表演"（Blue Angels，旧金山舰队周），还有一关隐藏着核选项（"The Nuclear option"，但被锁住不让用）。网页渲染有声效，移动端 `Safari` 上弹层没法滚动——这些细节都成了讨论的导火索。

## 讨论焦点

### 复杂 UI 是设计选择，还是 vibe-coded 失败？

最早抛问题的是 [thrance](https://news.ycombinator.com/item?id=50037578)：游戏看似是玩笑，却塞进了「丑陋、繁复、啰嗦」的 UI，要玩家花功夫学习才能玩，"这是给谁玩的？"

论坛很快裂成两派。一派坚持"复杂即论点"——

> "If the thesis of the game is that there's too much paperwork and regulatory burden, a simpler game would have to just tell the player 'there's too much paperwork'. This game--whether you liked it or not--is a lot more effective by showing you. You are the (simplified) bureaucrat, not a choose-your-own-adventure player being told that the bureaucracy is dense. I really do think that complexity and UI obtuseness was implemented as commentary, not as a mistake." — [zbentley](https://news.ycombinator.com/item?id=50038804) [c:50038804]
> （游戏想说的是"纸山文海加监管负担"，更简单的版本只能告诉玩家"纸山文海加监管负担"。这个游戏不管你喜欢与否，靠的是"展示"而不是"告知"。你扮演的是被简化过的官僚，而不是一个被告知"官僚很笨重"的选边冒险玩家。我真的认为：复杂和 UI 难用是作为评论被设计进来的，不是失误。）

另一派反过来读——

> "I think the UI of this one accurately models the many moving parts and forces in the process it's simulating, and I didn't have a problem picking it up though I skipped the tutorial. It has a sense of humor (read the speaker comments at meetings, and the news articles), and hits you with the real world outcome each development is based on. Made an impact on me." — [jkestner](https://news.ycombinator.com/item?id=50037908) [c:50037908]
> （这款游戏的 UI 确实把整个流程里的多股力量都建模出来了，我跳过了教程也能上手。会议里发言人的旁白、新闻稿，里面都有幽默。每个开发项目背后的真实结局都甩到你脸上。它打动了我。）

最尖锐的反派来自另一条线——

> "Like most vibe coded projects, it is for the person who created it. And usually only them." — [rjh29](https://news.ycombinator.com/item?id=50037625) [c:50037625]
> （跟大多数 vibe-coded 项目一样，它就是做给作者本人玩的，常常也只对作者本人有意义。）

### Vibe-coded 的目标观众之争

[thrance](https://news.ycombinator.com/item?id=50038729) 把战线拉得更长：他拿一个博士小游戏（`research.wmz.ninja/projects/phd`）当对照组，认为一次性教育游戏理应在十分钟内让玩家接收到论点，而不是让人去啃 UI；并直白指出——

> "Have you considered that TFA was vibe-coded, and maybe the 'game maker' hasn't put much thought into who his target audience could be, like, at all, and just asked Claude to make a game about NIMBYism?" — [thrance](https://news.ycombinator.com/item?id=50038729) [c:50038729]
> （有没有可能 TFA 就是 vibe-code 出来的，做的人根本没想过他的目标观众到底是谁，只是让 Claude "做一个关于 NIMBY 主义的游戏"？）

[roenxi](https://news.ycombinator.com/item?id=50037959) 用 [Dwarf Fortress](https://en.wikipedia.org/wiki/Dwarf_Fortress) 反驳：ASCII 界面的 DF 也是复杂艺术品，复杂并不减损价值。再一个回合里，roenxi 进一步指出："His target audience could be himself, in which case he's probably got a deep understanding of who they are and whether they enjoy the game." [c:50038936]（他的目标观众可能就是他自己，那他自然最清楚对方是谁、喜不喜欢这游戏。）

值得注意的是，整个来回没人怀疑游戏的"题材合理性"——只是反复在争"这种形式是否服务了题目"。

### 旧金山住房的"价格不可能三角"

讨论很快溢出游戏本身，变成一次围绕 SF 住房政策的重型辩论。[JumpCrisscross](https://news.ycombinator.com/item?id=50037819) 写下一段被反复引用的总结——

> "Locked supply. Affordable housing. Growing standards of living (or population). Pick two. If you lock supply and want taxes and wages to grow, you're choosing unaffordable housing. That's San Francisco's current policy choice. Over decades, it filters the poor to San Francisco's 'outer boroughs' or onto its streets." — [JumpCrisscross](https://news.ycombinator.com/item?id=50037819) [c:50037819]
> （锁死供应、负担得起的住房、生活水准（或人口）持续增长——三个里只能选两个。锁死供应还要工资和税收增长，等于选择不可负担的住房。旧金山现在就是这么选的。几十年下来，会把穷人挤到旧金山的"外围区"或人行道上。）

JumpCrisscross 进一步设想了一种极端方案——

> "My suspicion is San Francisco would love a Beijing-style hukou system. That lets it lock housing (and thus the built character of the city) and control immigration which in turn should result in stable housing prices provided units don't go out of use or residents don't have too many children." — [JumpCrisscross](https://news.ycombinator.com/item?id=50038544) [c:50038544]
> （我猜旧金山会喜欢北京式的户口制度。它能锁住房（也锁住城市的既有风貌），控制人口流入；只要房子不空置、居民不多生孩子，房价就能稳住。）

立刻被 [patatero](https://news.ycombinator.com/item?id=50039131) 反呛——

> "That system leads to an oversupply of single men in rural areas and single women in big cities." — [patatero](https://news.ycombinator.com/item?id=50039131) [c:50039131]
> （那套制度会导致农村剩男多、大城市剩女多。）

更深层的反对意见来自 [hyperhello](https://news.ycombinator.com/item?id=50037692)——"如果一座老城有自然边界，它不希望你往里塞一堆赚钱的玩意儿，或许就该接受这个提示，别再自我感动了"，认为 SF 的物理边界（半岛）本就该让人退一步。[bobthepanda](https://news.ycombinator.com/item?id=50037731) 则提醒"美国宪法保障自由迁徙，人家要么挤进来，要么出更高的价来抢你的位子"。

### 一个真实数字戳破了游戏的小剧场

整场讨论最有杀伤力的是这条：

> "Discretionary Review (Developer): I built 4,147 homes in San Francisco, 2015 to 2031. Grade A, 'Builder of Some Things'. Survived all eight investor reviews. 16 hearings, 3 appeals, 4 lawsuits. The city needed 82,069." — [AlbinoDrought](https://news.ycombinator.com/item?id=50039125) [c:50039125]
> （"自由裁量复审（开发商）"成就：2015 至 2031 年间，我在旧金山盖了 4,147 套住房。A 级"小有所成的建造者"。撑过全部 8 轮投资方复盘、16 场听证、3 次上诉、4 场官司。城市需要 82,069 套。）

[JimboOmega](https://news.ycombinator.com/item?id=50039484) 回"build order" 的细节——"要拿到开工许可我能搞定，但 40 套开工上到第二轮就盘不动账（拿到许可也合不上）"，把游戏的难点精确还原成一套财务+审批语境的死结。

### Civ、殖民地与"分歧本身就是机制"

游戏类型上的对照是 [sixothree](https://news.ycombinator.com/item?id=50038013) 这条：

> "I play games like Civilization and we get these tech trees and policy trees and such. And I can never help but wonder what it would be like to play these when the people of the territory act like Americans. You try to incentivize future technology and they push back. You try and prioritize education and they push back. There is always division and infighting. Regardless, I don't think it would actually make the game more fun." — [sixothree](https://news.ycombinator.com/item?id=50038013) [c:50038013]
> （我玩《[文明](https://en.wikipedia.org/wiki/Civilization_(series))》这种带科技树和内政树的游戏，常常想：要是治下百姓表现得更像美国人，会是什么样？你想激励未来科技，他们反对；你想优先教育，他们反对。永远是分歧和内斗。不过，估计玩了也不会更开心。）

[thaumasiotes](https://news.ycombinator.com/item?id=50038056) 直接拆 Civ 机制——指出"教育"在游戏里只剩一座昂贵的大学建筑，真正贯穿全程的是"人口超阈值 → 不快乐 → 城市崩溃"的分歧机制。sf 模拟的难度其实就在这条隐线上。

### 加州 Davis 的"全民公投"传统

轮到非 SF 案例。SubiculumCode 用一句话 "Davis, CA. lol" 起头，再补一段上下文：

> "Davis had a long and contentious civic debate on whether or not Target should be allowed to build a store in Davis, eventually Davis held a city wide vote on the matter, which did pass. Davis voters reject Measure V, spiking plans to build Village Farms housing. Just a couple of examples where growth that most cities would approve without thought became a city wide civic issue that the community actually voted on." — [SubiculumCode](https://news.ycombinator.com/item?id=50038564) [c:50038564]
> （Davis 曾长期争论 Target 要不要在城里开店，最终全市投票通过。同样，V 议案（即 Village Farms 住房项目）被市民投票否决。在很多城市无需讨论的"是否增长"，在 Davis 都会被摆到市民面前投票。）

[fooqux](https://news.ycombinator.com/item?id=50039161) 把这解读为"不受约束的增长并不像宣传的那么好"；[ChickeNES](https://news.ycombinator.com/item?id=50039414) 反驳这预设了"存在不受约束的增长"的前提，而游戏恰恰在否认这种前提。

### 工程债：自动播放音与移动 Safari

技术向评论里最响的是这一骂——

> "Fuck your Autoplaying sound you can't mute without going through onboarding multiple screens. You're a sonic terrorist. Please stop doing this." — [jubilanti](https://news.ycombinator.com/item?id=50039253) [c:50039253]
> （去你的自动播放音效，要关还得走完好几屏引导。你是声音恐怖分子。求求你别这么干。）

[rsyring](https://news.ycombinator.com/item?id=50039301) 提醒这踩了 HN 礼仪底线，建议"换个更建设性的批评方式"。移动端用户 [kistaro](https://news.ycombinator.com/item?id=50039200) 则反馈"弹层（popover）在 Safari 上没法滚，要么横屏切回竖屏，要么干脆不能滚"，疑似让 Claude 去修移动端滚动事件。这两条成了"vibe-coded 即工程债"的最具体论据。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 复杂 UI 是为论点服务的 | [zbentley](https://news.ycombinator.com/item?id=50038804) [c:50038804] | 简化版本只能"告诉"玩家官僚很慢；本作是"展示"官僚的慢。 |
| 吐槽 vibe-coded 一次性的玩法 | [thrance](https://news.ycombinator.com/item?id=50038729) [c:50038729] | NIMBY 不是 Claude 的 prompt 题目，做出花来也是自嗨。 |
| SF 政策不可调和 | [JumpCrisscross](https://news.ycombinator.com/item?id=50037819) [c:50037819] | 锁供应 + 工资涨 + 房价友好——只能任选其二。 |
| 物理边界论 | [hyperhello](https://news.ycombinator.com/item?id=50037692) [c:50037692] | 半岛就是边界，城市告诉过你了。 |
| 真实数字戳破模拟器 | [AlbinoDrought](https://news.ycombinator.com/item?id=50039125) [c:50039125] | 16 年 4,147 套 vs. 需要 82,069 套。 |
| 公民投票能解决 | [fooqux](https://news.ycombinator.com/item?id=50039161) [c:50039161] | 不加约束的增长没那么美好，大家投票挺好。 |
| 工程债批评 | [jubilanti](https://news.ycombinator.com/item?id=50039253) [c:50039253] | 自动播放不让关，等于声波恐怖袭击。 |

## 总体情绪

论坛对这个游戏的态度分裂得很平均：娱乐向的回复要么把它类比《[Papers, Please](https://en.wikipedia.org/wiki/Papers,_Please)》（"the only winning move is not to play" 被三位用户以不同句式写出），要么借它聊 SF 自己的住房病；而开发者向的回复则把它当作 vibe-coded 一次性作品的代表样本在质询。

游戏本身的题材——NIMBY、官僚听证、自由裁量复审——几乎没人质疑合理性，分歧点在一个非常务实的层面：复杂 UI 让玩家在"感受"和"理解"之间走了哪条路。zbentley 那句 "complexity and UI obtuseness was implemented as commentary" 之所以被顶到前列，是因为它恰好把反对派最锋利的指控（"vibe-coded 就是工程债"）反转成了论点。这也呼应 jkestner 的体验——"I didn't have a problem picking it up though I skipped the tutorial" [c:50037908]，跳过教程上手这件事本身就已经是评论的一部分。

游戏之外，旧金山住房政策讨论跑得比游戏本身远得多：政策三角（JumpCrisscross）、宪法迁徙自由（bobthepanda）、半岛的物理边界（hyperhello）、Davis 的公民投票传统（SubiculumCode），每一条都把"游戏玩家"拉回到真实世界里没修好的制度工程。最终的合流点不在游戏，而在玩家从旧金山办公楼出来时顺带问一句：415 套住宅审核下来要多久？

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | A city-building game in which the city would prefer you didn't | <https://news.ycombinator.com/item?id=50036864> |
| 2 | Discretionary Review (游戏本体) | <https://housing.over.pizza/> |
| 3 | 作者主页 over.pizza | <https://over.pizza> |

<div class="disclaimer">

本摘要由 AI 辅助生成，仅基于 2026-10-11 04:00 UTC 缓存的 81 条 HN 评论与作者站首页抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者经 `comments.yaml` 逐条比对一致。游戏本体由 [Oliver Sin](https://over.pizza) 开发。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
