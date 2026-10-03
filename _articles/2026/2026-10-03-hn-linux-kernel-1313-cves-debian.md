---
layout: post
title: >-
  DSA-6528-1：Linux 内核 1313 个 CVE 一次性修完，「几个」两个字开不了口
date: 2026-10-03
hn_id: 49928121
categories: [articles]
excerpt: >-
  Debian 一份安全公告替 Linux 内核修掉 1313 个 CVE；HN 用户立刻把矛头对准 Greg 的 CNA 制度与 AI 助攻。
tagline: >-
  Greg 终于把「几个漏洞」做成了字面意思。
---

## 原文概要

2026 年 9 月 29 日，Debian 安全团队发布 **DSA-6528-1** 安全公告（由 Salvatore Bonaccorso 署名），一次性为 `linux` 软件包打完 1313 个 CVE 编号对应的修复补丁。公告原文标题延续 LWN 一贯的克制口吻——《Several vulnerabilities have been discovered in the Linux kernel》，但仔细数过 CVE 编号区间的读者会发现「several」对应的是「一千三百一十三」。

CVE 编号横跨 2024、2025、2026 三个年份，其中包括 `CVE-2024-52560`、`CVE-2025-21817` 等持续两年的高优修复。公告里列出的漏洞按 Debian 安全追踪器的传统，归类为「可能导致权限提升、拒绝服务或信息泄露」。Debian 的追踪器（security-tracker.debian.org）按受影响内核版本逐条映射每个 CVE，用户可直接对照 `linux-source` 版本查表。

公告下方的链接回到 LWN 文章页面（即 HN 提交的来源），文章只点出 DSA-6528-1 的存在并未单独列条目——这正是 LWN 把公告推上首页的原因：这一份单子本身就是一年中内核安全修复体量的一次「快照」。

## 讨论焦点

### 「几个」到底是几个

社区对标题的最大反应是：Debian 把 `several` 用得太轻描淡写。

> "1,313 vulnerabilities, to be precise." — modeless [c:49928195]

> （译：精确地说，是 1313 个。）

> "In Heroes of Might & Magic 3, 'several' means 5–9. 10–19 is 'pack', 20–49 is 'lots', 50–99 is 'horde', 100–249 is 'throng', 250–499 is 'swarm', 500–999 is 'zounds…' and 1000+ is 'legion'." — nathell [c:49928774]

> （译：在《英雄无敌 3》里，several 是 5–9 个，10–19 是 pack，20–49 是 lots，50–99 是 horde，100–249 是 throng，250–499 是 swarm，500–999 是 zounds，1000 以上才叫 legion——按这个量级，这份公告应该叫「一团漏洞」。）

> "'Several' feels a bit of an understatement, there are 1313 CVEs listed on that page!" — embedding-shape [c:49928707]

> （译：「几个」轻描淡写了，页面上列了 1313 个 CVE！）

回复里很快出现了横向对比：2023 年全年 CVE 总数 1527 个，单份 Debian 公告就吃掉了约 86%。社区普遍认为这是「数字通货膨胀」的实证。

### Greg 的 CNA 制度：每个补丁都发一张 CVE

辩论的第二条主线，集中在 Linux 内核自 2024 年成为 CVE 编号机构（CNA）之后的工作流变化。

> "the Linux project registered as an authority to create their own CVE numbers in 2024. Previously the majority of bugs would just be fixed without note unless there was a demonstration that it could be exploited. Now they just give almost every bug a CVE number." — SchemaLoad [c:49928762]

> （译：Linux 项目在 2024 年注册为 CVE 编号机构（CNA）。在那之前，大多数 bug 默默修掉就行了，除非能演示出可利用路径。现在几乎每个 bug 都会被发一个 CVE 编号。）

> "any kernel bug might be exploitable to compromise the security of the kernel… the CVE assignment team is overly cautious and assign CVE numbers to any bugfix that they identify." — john_strinlai [c:49928793]

> （译：几乎任何内核 bug 都可能被利用来破坏系统安全……CVE 分配团队出于过度谨慎，会把每一个识别出的修复都编号。）

> "No. It's because Greg doesn't like the CVE system and MITRE, the stupidest decision ever, made Greg a CNA, and this is his tantrum that he's been waiting 40 years to throw." — insanitybit [c:49929865]

> （译：不，原因是 Greg 不喜欢 CVE 系统，而 MITRE 这辈子最蠢的决定就是把 Greg 招成了 CNA——这是他憋了 40 年的脾气。）

围绕 Greg 的吐槽进一步滑向对 cURL 维护者 Daniel Stenberg 的引用（`daniel.haxx.se/blog/2026/06/24/a-cve-dispute`），把「两个看不上 CVE 系统的老牌 C 维护者」并排放，形成"smells 后继有人"的暗线。

### AI 协助挖洞：CVE 数字翻倍的「功臣」

第三条主线把锅分给 AI 辅助的安全研究。

> "Are these primarily AI-assisted findings? Seems like an enormous increase over 2024 and 2025." — BobbyTables2 [c:49928578]

> （译：这批 CVE 主要是不是 AI 辅助挖出来的？相比 2024 和 2025 增幅大得不正常。）

> "That's probably a great thing. The initial friction of AI overwhelming projects certainly sucks, but once there are better processes to deal with them it's going to strengthen the quality of so many projects!" — tetrisgm [c:49928597]

> （译：这大概率是好事。AI 一开始把项目淹没确实难受，但只要流程跟得上，反而能抬高很多项目的总体质量。）

> "Long term we will end up with software with no low hanging fruit exploits left. But right now we are in a period where low hanging fruit is everywhere and it's easier to exploit systems than ever before." — SchemaLoad [c:49928660]

> （译：长期看，低垂果实的漏洞会被消耗殆尽。但眼下正好处于低垂果实遍地、系统比以往任何时候都更容易被攻破的阶段。）

反对派则把焦点放在「为什么只有热门项目被 AI 扫」：

> "I just mean there is a proliferation of new code. New code == new defects. It's likely that popular software projects get the majority of the scrutiny, while no one is spending tokens looking for defects on my 0-star GitHub repo." — catlifeonmars [c:49929394]

> （译：我意思是说新代码在爆炸式增长——新代码等于新缺陷。热门项目肯定拿到绝大多数关注，没人舍得花 tokens 来给我这个零星 GitHub 仓库挑 bug。）

### 本地 vs 远程：「绝大多数其实是本地 LPE」

用户很快开始追问可利用范围。

> "'Several vulnerabilities have been discovered in the Linux kernel that may lead to a privilege escalation, denial of service or information leaks.' Remotely or locally exploitable? This is very lacking on information." — userbinator [c:49928745]

> （译：公告只写「权限提升、拒绝服务、信息泄露」——是远程还是本地？信息量太少。）

> "If any of these were remotely exploitable it would be getting much louder and more urgent news. Local privilege escalation bugs are encountered all the time." — walrus01 [c:49928976]

> （译：真要哪个能远程利用，新闻早就炸了。本地权限提升的 bug 天天都有。）

> "Most CVEs are irrelevant to most people, that's always been the case." — jeroenhd [c:49930429]

> （译：大多数 CVE 跟大多数人无关，一直都是这样。）

「CVE 数量作为指标」的论战在这里达到高潮：

> "'number of cves' is a useless metric, especially when it comes to the kernel." — john_strinlai [c:49928793]

> （译：「CVE 数量」是个没用的指标，对内核来说尤其。）

> "Resume-driven development for security researchers has never been easier!" — SAI_Peregrinus [c:49928866]

> （译：安全研究员写简历驱动开发的时代从来没这么方便过。）

### 现实风险：NSA 与国家级漏洞储备

最后一条线收在更暗的角度——这些新修的 CVE 背后，可能有多少早就被握在某些人手里。

> "NSA allegedly used to have a 'black budget' of around a couple dozen million dollars for software sabotaging. I wonder what percentage of those CVEs could be related to it…" — crispr245 [c:49929058]

> （译：据传 NSA 有一笔几千万美元的「黑预算」专门做软件破坏。我好奇这批 CVE 里有多少跟那笔预算相关……）

> "We're in an uneasy truce with regards to mandatory backdoors. They're not demanded because targets are just so easy to pop. If we did secure software across the board with AI, there'd likely be a resurgence of calls for mandatory backdoors." — rockskon [c:49929924]

> （译：我们跟「强制后门」之间是一种不安的休战——之所以没人要求强制开后门，是因为目标太好攻了。真要哪天 AI 把软件整体做硬了，强制后门的声音大概会卷土重来。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 标题严重缩水 | modeless | 精确地说，1313 个。 |
| CNA 制度抬升 CVE 数 | SchemaLoad | 内核 2024 年才注册成 CNA，现在几乎每个补丁都发编号。 |
| 把矛头对准 Greg | insanitybit | 把 Greg 招进 CNA 是 MITRE 这辈子最蠢的决定。 |
| AI 助攻是好事 | tetrisgm | 短期痛苦，长期抬高项目质量。 |
| 现实更复杂 | SchemaLoad | 低垂果实遍地，系统比以往都更容易被攻破。 |
| 多数人并不受影响 | jeroenhd | 大多数 CVE 跟大多数人无关。 |
| CVE 数量是烂指标 | john_strinlai | 「CVE 数量」对内核来说是个没用的指标。 |
| 简历驱动研究 | SAI_Peregrinus | 安全研究员写简历驱动开发的时代从来没这么方便。 |
| 多数是本地 LPE | walrus01 | 真要远程能利用，新闻早就炸了。 |
| AI 扫不到冷门项目 | catlifeonmars | 没人舍得花 tokens 给我 0 星 GitHub 仓库挑 bug。 |
| NSA 储备猜想 | crispr245 | 这批 CVE 里不知道有多少跟那笔黑预算相关。 |
| 强制后门会卷土重来 | rockskon | 软件一旦做硬，强制后门的声音会再起。 |

## 总体情绪

整场讨论的语气是技术老炮儿的吐槽派对——既不恐慌也不兴奋，更接近一个长期盯 CVE 数据库的人翻完一行行 ID 后发出的「嗯，果然如此」。两条情绪线最明显：一是把 Greg 当成主角的抱怨文化（「他憋了 40 年的脾气」），二是把 AI 当成水位计——既能测出 CVE 数量暴涨，也暴露了热门项目与冷门项目之间被关注度的巨大落差。

讨论的最后落点放在「数量」与「严重性」的脱钩：用户普遍接受 1313 个 CVE 本身并不意味着 1313 个高危，但同时也指出——一旦 AI 把所有低垂果实扫完，国家级行为者就会把原来「懒得利用」的 CVE 重新捡起来。**CVE 编号不再是问题的严重性，而是问题的能见度。**

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Several vulnerabilities have been discovered in the Linux kernel | https://news.ycombinator.com/item?id=49928121 |

<div class="disclaimer">

本文由 AI 辅助生成，仅基于 HN 公开讨论与原始安全公告。所有 CVE 编号均引用自 Debian DSA-6528-1 公告；分析与译见不代表 Debian 安全团队立场。引用评论版权归原作者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>