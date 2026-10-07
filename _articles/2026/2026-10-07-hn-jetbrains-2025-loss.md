---
layout: post
title: >-
  JetBrains 2025 财报 — 营收创纪录，利润却掉了 113%
date: 2026-10-07
hn_id: 49977072
categories: [articles]
excerpt: >-
  JetBrains 2025 营收 CZK 16,008 mil（+6.3% 创新高），净利 -315 mil（同比 -113%），毛利率从 53.7% 砸到 10.7%。评论区一边算 Junie 烧钱账，一边争论 IDE 是不是该让位给 agent。
tagline: >-
  营收涨了 6.3%，利润跌了 113%——AI 补贴烧穿地板。
---

> 来源：HN 热门榜（`/best`）。帖子：[JetBrains reports revenue growth, net financial loss for 2025](https://news.ycombinator.com/item?id=49977072)，554 分，504 条评论。

## 原文概要

Helgi Library 10 月 6 日上线 JetBrains 2025 年度财务数据，原始来源是 JetBrains s.r.o. 提交给捷克商业登记处的法定财报（unconsolidated, Czech GAAP）。数据要点：

- **营收 CZK 16,008 mil**，同比 +6.3%，连续五年增长，2025 创历史新高。
- **净利润 CZK -315 mil**，同比 -113%（2024 净利 CZK 2,479 mil）。ROE -11.1%。
- **EBITDA CZK 918 mil**，EBITDA Margin 从 2021 的 48.9% 一路滑到 5.73%。Net Margin -1.97%。
- **毛利率从 2021 的 53.7% 跌到 10.7%**，五年蒸发 43 个百分点。营业费用同比 +26.5%，员工费用 +34.2%。
- **投资活动现金流 -10,273 mil CZK**（对比 2024 的 -1,946 mil）——单年投资性现金流出放大 5 倍。
- **净现金 CZK 7,584 mil**，资产负债率还在可承受范围。

Helgi Library 统计的是母公司单体报表，覆盖 2005–2025 共 721 个指标。捷克 GAAPS 报表口径与合并报表有差异，Helgi 也明确标注「不是投资建议」。核心叙事用一张表可以概括：营收越高，利润越掉水。

## 讨论焦点

### 利润坍塌是 AI 补贴烧的，还是多年趋势？

> "Jetbrains has been pushing Junie real hard, my guess is that they've been giving out too many cheap tokens to try to stay relevant as Claude and friends pull people away from the IDE." — jeroenhd [c:49977537]
> （译文：JetBrains 在猛推 Junie，我猜他们一直在发太多廉价 token，想在 Claude 这类产品把人从 IDE 拉走之前保持存在感。）

> "Their revenue is increasing, but their profits have been on a decline despite increased revenue. The table on that page only goes back to 2021, but the trend of increasing revenue and decreasing profits has been going on at least that long. I don't think ai would have been a factor that far back. Even though github copilot did launch sometime around then, I doubt it was much of a factor." — onionisafruit [c:49977601]
> （译文：营收在涨，但利润一直在跌。表只回溯到 2021，但「营收涨利润跌」的趋势至少从那时就开始了。那时候 AI 还不是因素，Copilot 刚出来，影响也有限。）

`jeroenhd` 把 2025 利润塌方归因到 Junie 补贴——JetBrains 自家 AI 编程 agent，深度集成在 IDE 里，给 All Products Pack 订阅者免费配额。`onionisafruit` 反驳：利润下滑的曲线从 2021 就在了（毛利率 53.7% → 10.7% 是五年级别的趋势），AI 投资最多只是加速器，不是元凶。`snarfy` [c:49977524] 一句话补刀：「probably ai related」。

### 营收仍在涨，所以是「投资期」而不是「衰退期」

> "All the death knell comments - Is no one looking at the revenue line? Revenue still trending the same. Costs presumably haven't skyrocketed. They've invested in something big. Thats probably a good thing, and often needed to evolve." — bdavbdav [c:49977482]
> （译文：全是死亡钟声——没人看营收那条吗？营收趋势没变。成本没失控。他们在投大事，这反而是好事，是企业进化所必需的。）

> "Software is changing.  It would be a good time to invest rather than to focus on the bottom line. Their revenue is up." — perbu [c:49977463]
> （译文：软件业在变，现在该投，而不是盯利润。他们的营收在涨。）

> "I find IntelliJ IDEA a great tool, even for my fully vibecoded apps. I edit the READMEs in it, look at the version history, use it for debugging, for builds, and so on. My guess is that people aren't abandoning their IDEs. Their market is probably growing. I suspect they're burning money on subsidized inference, just like everybody else." — InsideOutSanta [c:49977517]
> （译文：我用 IntelliJ IDEA 即使在 vibecoded 项目上也顺手——编辑 README、看版本历史、调试、构建都用它。我觉得大家没在抛弃 IDE，市场可能还在长。我猜他们在补贴推理 token，跟所有人一样。）

`bdavbdav` 与 `perbu` 强调「营收 +6.3% 是事实」，把利润下滑解读为战略投资；`InsideOutSanta` 给出一个具体场景：即使 vibe coder 也会用 IntelliJ 做构建和调试，IDE 仍有不可替代的角色。`dukeyukey` [c:49979053] 一句话点睛：「营收涨了，投更多有什么问题？」

### IDE 还有没有护城河？VS Code 派 vs JB 派正面互喷

> "It's not even close. vscode can approximate JB IDEs but that takes pulling in plugins on your own, managing their configuration, and adapting when the setup inevitably breaks. JB IDEs bake in everything you can get via vscode plugins with documentation, a cohesive experience, and regular maintenance to keep them working for you. Concrete examples that are better in JB land for me: git conflict resolution, refactoring (in numerous ways), jumping to definitions, finding usages (especially on Python projects)." — gomoboo [c:49977678]
> （译文：差距不是一点点。VSCode 想追平 JB，得自己装插件、管理配置、修崩。JB 把 VSCode 插件的功能都打包好了，文档、体验、维护都是原生的。具体例子——JB 更好的：git 冲突解决、各种重构、跳转定义、查找引用（Python 项目尤其明显）。）

> "I love JetBrains. For many years I was a happy subscriber to the All Products Pack, paid for out of my own pocket. I would have said that you'd have to pry my JetBrains from my cold, dead hands. A year or two ago, I finally gave up: 1. The IDE was simply too slow - notably slower and 'heavier' than VS Code in particular - and it seemed to regularly get slower. 2. Bugs - from the complex (TypeScript constructs that tsc itself handles just fine while WebStorm's code analysis kept throwing false positives on) to the trivial and silly (failing to properly handle the <col> tag in React), and often staying open for years. Meanwhile, VS Code just kept getting better…" — joshkel [c:49978436]
> （译文：我爱 JetBrains。前几年我自掏腰包买全套，惨的话可以抢走。后来放弃了：1. IDE 太慢——明显比 VS Code 慢且重，还在持续变慢；2. bug——复杂的（WebStorm 在 tsc 能处理的 TS 语法上误报）到弱智的（连 React 的 <col> 标签都处理不好），一挂就是好几年。与此同时 VS Code 越来越好。）

这场是评论区的核心战场。`gomoboo`、`ipsod` [c:49977638]、`memsom` [c:49978103] 站在 JB 一边：代码智能、refactor、find usages 是「工业级机器 vs 乐高积木」的差距；`joshkel`（前 JB 十年付费用户）、`jvidalv` [c:49979615]（WebStorm + DataGrip 六年用户）站在 VS Code 一边，核心论点是性能与维护：JB 越来越慢，bug 越来越弱智，VS Code 越追越近。`Shaolin` [c:49977618] 的总结被反复引用：「VSCode 不是 IDE，是带可选插件的文本编辑器」——反驳 `folkrav` [c:49977905] 时几乎定义了 HN 这场 IDE 战争的战场。

### 退订潮：有多少人真走了？

> "I have paid out of pocket for Jetbrains for 15 years. I don't think I've opened it in the past year and should probably cancel my subscription. For me, the things that made Jebteains great just don't matter anymore." — SkyPuncher [c:49977485]
> （译文：我自掏腰包买了 15 年 JetBrains。过去一年都没打开过，估计该取消订阅了。对我来说 JetBrains 当年厉害的那些功能现在不重要了。）

> "I canceled my DotNet Ultimate subscription (or whatever it's called) earlier this year, even though Rider is (was) one of the best IDEs for my main squeeze, F#. It's not because I don't use Rider or IDEs, but because I've felt the quality has gone downhill ever since I first started paying for it. What broke the camel's back was the constant surveys they were sending me surveys asking how much I love AI in Rider, and how much I wanted to see more AI in their IDEs, when all I wanted was an IDE that didn't have some shitty new F# language bug every time I updated it." — nozzlegear [c:49983206]
> （译文：我今年早些时候取消了 Rider 订阅（Rider 是 F# 用户最好的 IDE）。不是因为我不喜欢事，而是因为我付钱以来质量一直在下降。最后一根稻草是他们不停地发问卷，问我有多爱 Rider 里的 AI、多想看更多 AI——我只想用个更新一次没有新 F# bug 的 IDE。）

> "I had personal subscriptions to WebStorm and GoLand and cancelled them not long after getting Windsurf. Just don't need the IDE abilities like I used to... Still use 'go to definition' but that's pretty much it." — chris_st [c:49978262]
> （译文：我买了 WebStorm 和 GoLand 个人订阅，拿到 Windsurf 后没多久就取消了。IDE 那些花活我现在不太需要了……「跳转定义」还偶尔用，基本就这一项。）

退订派的共同叙事：AI agent（Windsurf、Claude Code、Junie）覆盖了 IDE 的大量功能，价值锚点从「智能 + 重构 + 浏览」缩到「跳转定义」。`nozzlegaur` 额外提供一个具体细节：JetBrains 反复推送 AI 满意度问卷成为压垮最后防线的稻草。`chasd00` [c:49979370] 的版本更激进：「VSCode 都快被我抛弃了，Claude + 终端 + grep + .vimrc 才是新工作流」。

但反对的声音依然存在：`KptMarchewa` [c:49977562] 说「JB 作为代码浏览器挺好」，`cbg0` [c:49977869] 反向嘲讽「你会惊讶地发现很多人根本不用任何 IDE——Claude 写，另一个 Claude review，直接合」。

### 「做回 niche」还是「继续 AI 化」的战略选择

> "I don't think they can compete with AI IDEs. They should maybe focus on the niche that they are good at, and completely get rid of anything ML/AI related. It's going to be a lot cheaper. It's better to be the king of a niche." — markus_zhang [c:49977479]
> （译文：我认为他们打不过 AI IDE。最该把擅长的小众赛道做透，彻底砍掉 ML/AI 相关业务，会便宜很多。做小众之王更好。）

> "Just feels like they've been making all the wrong decisions. Quality has been really lackluster, and their attempts to hop onto the AI train have been as annoying as they have been bad. CoPilot sucked. Their own AI coding models suck. The redesign they've gone for also seems like a supremely weird choice. It's like they're trying to be more like VS Code, when their probably biggest selling point was that unlike VS Code, they offered a full and traditional IDE experience. Their trajectory has been a deeply questionable mix of change for the sake of change and nervously doing what everyone else is doing." — marginalia_nu [c:49978983]
> （译文：感觉他们一直在做错误决定。质量拉胯，蹭 AI 这件事又丑又差。Copilot 体验糟糕，自家模型更挫。改版设计也很怪——越改越像 VS Code，而他们最大卖点就是跟 VS Code 不一样，提供完整传统的 IDE 体验。轨迹就是一团乱搞。）

> "Ironically, back then they praised JetBrains for not following hype staying focused on IDE and Dev environment" — eunos [c:49978136]
> （译文：讽刺的是，过去大家夸 JetBrains 就是因为不追 hype，专注 IDE 和开发环境。）

`markus_zhang` 提的战略是「回 niche」，把 AI 砍掉；`marginalia_nu` 的批评更整体——质量、改版、AI 化都在错。`echo in HN` [c:49978136] 的反驳一针见血：当 JetBrains 不追 hype 时，社区夸它专注；当它追 hype 时，又被骂丢掉专注。这条线呼应了 `erichocean` 在 Mistral 帖中提过的「什么都能被骂」结构。

`Applejinx` [c:49977776] 站在 JetBrains 一边给出反例：「我是付费 JB 用户，但他们 vibe coding 把自己 vibe 成垃圾的话我也会跑。现在还没有，还在试水，我认为还有专业能力在。」这条线把讨论拉回到对**未来判断**而不是**当下数据**的分歧。

### Junie 究竟好不好用？

> "Worked fine as a free tool, but as long as AI companies are selling their slopware tokens below cost with subscriptions, it's not really that interesting in my opinion. The Jetbrains integration is nice, but if you rely on the tool you're probably not going to use the IDE much anyway." — jeroenhd [c:49977642]
> （译文：作为免费工具还行。但只要 AI 公司在亏本卖 token 订阅，Junie 就不那么有意思了。JetBrains 集成是加分项，但你真要用 IDE 就用不了多少。）

> "I enjoyed it a lot early on.  In particular it didn't have all the confusing and anxiety inducing options that other agents have to use more expensive or less expensive models, I liked the way it approached \"plan mode\" [1] and I didn't feel like I had to stress it about token costs the way I do with the other models…  Jetbrains now gives me a choice of agents which I don't like because having to think about it makes feel like one of those \"ai bros\" who is overthinking their relationship to ai and underthinking their code…" — PaulHoule [c:49977736]
> （译文：早先用着很爽。它没有其他 agent 那种「选大模型还是小模型」的焦虑选项，plan mode 也好，我不用像其他工具那样担心 token 成本……但现在 JetBrains 让用户选 agent，这反而让我不爽——选了就要想，一想就像那些 overthink 跟 AI 关系的 AI bro。）

> "I tried it in DataGrip on a messy database. It hallucinated about which tables and columns to use. Had better results using Claude in the terminal and having it give me the SQL to run." — bdcravens [c:49978505]
> （译文：我在 DataGrip 里试过，处理一个乱的数据库。它会幻觉表和列。在终端里用 Claude 直接给我 SQL 反而更靠谱。）

Junie 实际体验分裂：`chrisandchris` [c:49978357] 把 Junie 形容为「boring, and that's perfect」——明确表示不追新工具，Junie 当锤子和锯子用刚好；`surgical_fire` [c:49977899] 给的负面反馈很具体——额外 token 太贵，又不能配 GLM/MiMo 自有 API key；`bdcravens` 直接给出反例场景。`PaulHoule` 的反馈是「好坏参半——最早 Junie 的「不用选模型」体验很好，后来加了「选 agent」反而劣化」。

`chrisandchris` [c:49978357] 的金句：「Junie 很 boring，对我刚好完美」——这正好对应 JetBrains 的整个战略困境：它的 IDE 用户大部分是想买锤子和锯子的人，不是想做 agentic workflow 的人。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 看好 / 投资期 | bdavbdav | 营收在涨，投大事是好事，是企业进化所需 |
| 看好 / 投资期 | perbu | 软件业在变，现在该投而不是盯利润 |
| 看好 / IDE 未死 | InsideOutSanta | vibecoder 也用 IntelliJ 做调试构建，市场可能还在长 |
| 中性 / 利润多年下滑 | onionisafruit | 利润下滑曲线从 2021 就在，AI 最多只是加速器 |
| 担忧 / AI 补贴 | jeroenhd | 猛推 Junie、发廉价 token 是烧钱主因 |
| 担忧 / 错决策 | marginalia_nu | 质量、改版、AI 化都在错，越改越像 VS Code |
| 担忧 / 战略失焦 | eunos | 当年夸 JetBrains 就是不追 hype，现在追了又被骂 |
| 退订 / 性能 + bug | joshkel | 十年付费用户，IDE 越来越慢，bug 一挂好几年 |
| 退订 / AI 替代 | SkyPuncher | 15 年付费，过去一年没打开，该取消了 |
| 退订 / AI 替代 + 问卷惹烦 | nozzlegear | F# bug 加 AI 满意度问卷，最后稻草 |
| 退订 / Windsurf | chris_st | 拿到 Windsurf 后 IDE 不重要了 |
| 弃 IDE / agent-only | chasd00 | VSCode 都快被我抛弃，Claude + 终端才是新工作流 |
| 防守 / JB 不可替代 | gomoboo | VSCode 是乐高，JB 是工业机器，差距巨大 |
| 防守 / Java 护城河 | szatkus [c:49977787] | Javaland 里 VSCode 不是选项 |
| 战略 / 回归 niche | markus_zhang | 别打 AI IDE，做小众之王 |
| 战略 / 接受风险 | But who | 我是付费用户，JB vibe 成垃圾我也会跑，现在还没 |
| Junie / 体验差 | bdcravens | DataGrip 上幻觉表列名，不如 Claude 直接给 SQL |
| Junie / boring = 好 | chrisandchris | Junie 很 boring，对我刚好完美 |
| Junie / 体验退化 | PaulHoule | Junie 原本「不用选模型」的优势被新功能阉割 |

## 总体情绪

分歧明显，但偏焦虑。营收涨 6.3% 创纪录这条事实没法黑，所以「这是投资期不是衰退期」的声音在理性投资期内不会被一棍打死；问题是 JetBrains 投的方向对不对，社区没有共识。

`bdavbdav` 一派的乐观建立在「营收还在涨 = 业务基本面好」的假设上；但 `marginalia_nu`、`SkyPuncher`、`nozzlegear` 一派的退订案例让「基本盘」这个词变得可疑——他们都是 5–15 年付费用户，意味着哪怕订阅留存率只跌几个点，对一家以订阅为命脉的公司也是重创。Hans 也是从「Junie 补贴」这个角度算出烧钱账：`jeroenhd` 提到 Junie 给 All Products Pack 免费配额，这是现金消耗但不算费用的大头。

更大的张力是 JetBrains 的产品哲学：HN 用户里既有想当「买锤子和锯子」的人（`chrisandchris` 式的 Junie boring 党），也有想当「AI 编程新工作流」的人（`chasd00` 式的 VSCode 都不要的人）。JetBrains 的财报困境，本质上是它在「用 IDE 集成的传统优势」和「被 agent 拆掉 IDE 价值」之间做选择——补贴 Junie 是它在押后者，但 Junie 本身没有给出「比 Cursor / Claude Code 更强」的差异化证据，`bdcravens` 给的反例已经具体到 hallucinate 表名。

这场讨论不会有赢家。JetBrains 2025 财报把一个结构性矛盾量化了：营收越高、利润越掉、现金越多——这是「还在投资期」的乐观解读，也是「主业被 AI 蚕食」的悲观解读。同一条数据，看的是哪一面决定结论。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | JetBrains 公司财务页（Helgi Library） | https://www.helgilibrary.com/companies/jetbrains |
| 2 | JetBrains 投资活动现金流页 | https://www.helgilibrary.com/companies/jetbrains/total-cash-from-investing |
| 3 | JetBrains 官方博客（2025 公开财报口径说明） | https://blog.jetbrains.com |
| 4 | Junie 官方文档 | https://www.jetbrains.com/junie/ |
| 5 | JetBrains 现金流分析（HN 衍生） | https://news.ycombinator.com/item?id=49977477 |

<div class="disclaimer">

本摘要为 AI 辅助整理，仅基于 HN 公开讨论与 Helgi Library 公开财报数据。JetBrains 财报原始来源为捷克商业登记处（Český OR）法定申报，Helgi Library 加工后提供。所有引文均标注原帖评论 ID。JetBrains 是 Czech GAAP 单体报表口径，与合并报表或 IFRS 不可直接比较。观点不代表本站立场，引用如有偏差欢迎指正。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>