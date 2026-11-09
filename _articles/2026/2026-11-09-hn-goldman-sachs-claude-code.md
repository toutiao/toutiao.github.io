---
layout: post
title: >-
  高盛限制交易员使用 Claude Code：AI 编程工具全员普及面临的墙
date: 2026-11-09
hn_id: 50415628
categories: [articles]
excerpt: >-
  高盛 10 月更新内部指引，仅允许 1.2 万名工程师使用 Claude Code 与 GitHub Copilot，禁止交易员和投行家自行通过 AI 编写运行代码。
tagline: >-
  首席信息官 7 月还在夸赞 Vibe Coding，10 月就对非工程人员下达禁用令。
---

## 原文概要

据彭博新闻报道，高盛（Goldman Sachs）在 2026 年 10 月更新了内部指引，将 Anthropic 的 `Claude Code` 以及微软的 `GitHub Copilot` 等 AI 编程工具的使用权限严格限制在工程人员范围内。这意味着此前一直使用这些工具监控客户交易流、构建市场模型及制作分析图表的交易员和投资银行家，将被剥夺直接使用 Autonomous Coding Agent 的权限。不过，跨越交易、定量研究和软件工程的 Strats 部门人员仍保留了访问权限。

这一决定与高盛管理层早前的立场形成了鲜明对比。就在 2026 年 7 月，高盛首席信息官 Marco Argenti 还曾公开赞扬非技术员工的“Vibe Coding”（氛围编码），称交易员和投行家利用 AI 构建了原型工具，并提交给公司约 1.2 万名工程师进行优化。然而，这种允许非技术人员在处理敏感数据的同一台机器上运行代码生成与执行 agent 的做法，引发了极大的合规和操作风险顾虑。

此外，高盛在此前已有过区域限制举措：2026 年 4 月，高盛因合同条款限制将 `Claude` 移除出香港内部 AI 平台；而摩根大通（JPMorgan）也在 6 月跟进限制。更具戏剧性的是，高盛与摩根士丹利（Morgan Stanley）正是 Anthropic 即将上市的联席主承销商。高盛银行家们在准备为 Anthropic 的 IPO 进行路演的同时，自己却被禁止在日常业务中使用该公司的核心编程工具。

与高盛收紧权限不同，巴克莱银行（Barclays）在 10 月表示计划在年底前让半数开发人员使用 `Claude Code`，并在三周后宣布削减约 5000 个工程岗位。相比之下，高盛的选择反映出大型金融机构在面对 AI 工具带来的生产力诱惑与合规风险、数据安全及信息壁垒（Chinese Wall）要求之间的艰难权衡。

## 讨论焦点

### 非技术人员“Vibe Coding”带来的维护与合规噩梦

很多程序员对非技术人员使用 AI 编写代码并扔给工程团队的做法深感困扰。虽然“让最了解业务的人构建原型”听起来很美，但实际上交付的代码往往缺乏工程设计与安全保障，最终要么变成技术债务，要么直接被废弃。

> "As someone who has been on the receiving end of many of these tools, I feel 'improved' is doing some heavy lifting here." — cloudednine [c:50415829]
> （作为接手过很多此类工具的人，我觉得报道里的‘改进’这个词用得太客气了。更准确的说法是‘彻底重构以达到可用状态’，或者更大概率是直接扔进 backlog 的角落。）

> "I bet engineering loved traders tossing vibe-coded crap across the wall and demanding it be productionized. "It can't be hard, after all I've already written the code for you."" — hn_go_brrrrr [c:50415855]
> （我敢打赌工程团队最讨厌交易员把 Vibe Code 出来的垃圾甩过墙，还要求将其推向生产环境：“这又不难，反正代码我都替你写好了。”）

### 角色区分与专业门槛

部分社区成员支持高盛的限制决定，认为软件工程需要专业思维与严谨流程，AI 编程工具应当是专业工程师的赋能器，而非让所有人盲目替代专业开发。

> "Internal guidance updated in October restricts Anthropic's Claude Code and Microsoft's GitHub to the bank's engineers There. Now only devs can use Claude Code. That makes sense." — aurareturn [c:50415848]
> （指引限制只有开发人员能使用 Claude Code，这合情合理。好的工程师具备专业思维，理解系统连接方式、方案优缺点，能看出 AI 什么时候在胡说八道。我们不会让软件工程师仅凭 AI 去做高盛的年度报税，同理也不该让销售或交易员去写生产系统。）

> "The ability of bankers or traders to even create an app that others can run, without any IT review/approval process is probable a compliance issue in and of itself." — steveBK123 [c:50416113]
> （银行家或交易员在没有任何 IT 审核或批准流程的情况下建立供他人运行的应用，这本身就很可能构成合规违规。）

### 合规、数据隐私与安全边界

在高度监管的金融行业，数据隐私、合规审查以及“中国墙”（Information Barriers）是绝对红线。允许自主 agent 随意读取文件和运行程序，极易引发敏感数据泄露或合规漏洞。

> "In certain industries, compliance/lack thereof has serious consequences, so it might be more to do with that rather than punishing non-technical users just for using AI." — neya [c:50415952]
> （在特定行业，缺乏合规性的后果极其严重。这更多是出于合规考虑，而非惩罚非技术用户。例如，如果 AI 模型拿内部财务数据训练，其他人据此获利，那就是内幕交易。）

> "You can use Claude with HIPAA/PHI. You need to sign a BAA (Business Associate Agreement). It dictates how Anthropic may use and how they must safeguard the PHI (Private Health Information), including not training on it." — caymanjim [c:50416163]
> （在医疗等监管领域使用 Claude 需要签署 BAA 协议，明确规定 Anthropic 如何保护数据且不得用于训练。没有 BAA 保障的高风险使用环境，会把个人与敏感数据直接暴露给共享模型。）

### 金融巨头的策略分歧与 IPO 前夕的戏剧性

高盛禁用 `Claude Code` 与巴克莱大规模推行并裁员的举措形成对比。同时，高盛作为 Anthropic 的 IPO 主承销商却限制内部使用，引发了社区对前沿 LLM 在金融机构真实信任度的讨论。

> "OK so when push came to shove, the frontier of LLMs were not trusted at Goldman Sachs. Maybe more banks to follow?" — baalimago [c:50415924]
> （在关键时刻，最前沿的 LLM 在高盛依然未获得信任。也许接下来会有更多银行跟进？）

> "The most interesting part of this announcement is the timing. GS is leading Anthropic's IPO, what motivated them to announce this a few weeks before trading starts?" — cactca [c:50416089]
> （最有趣的是这个公告的时间节点。高盛正主导 Anthropic 的 IPO，究竟是什么动机让他们在距离开盘只有几周时发布这一消息？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 支持限制 | cloudednine | 交易员用 AI 写出的原型根本无法直接上线，重构成本极大 |
| 专业门槛 | aurareturn | 软件开发需要专业工程思维，AI 无法替代开发者的合规与架构能力 |
| 合规风险 | steveBK123 | 非技术人员未经 IT 审查自行分发应用本身就是重大合规隐患 |
| 监管红线 | neya | 禁用核心在于合规与隐私防护，避免内幕交易和敏感数据越界 |
| 质疑趋势 | baalimago | 高盛的决策说明金融核心圈层对前沿 LLM 仍缺乏根本信任 |

## 总体情绪

社区对于高盛限制交易员使用 AI 编程工具的态度呈现高度理性的务实倾向。大多数开发者与业内人士并未将此视为“AI 技术的失败”，而是将其视为企业对待 AI 工具从“盲目狂热”走向“风险控制与责任归属”的理性回归。

随着 Autonomous Agent（自主代理）越来越深入企业工作流，如何划清影子 IT（Shadow IT）与合规生产的界限，成为所有大型企业无法回避的难题。高盛的收紧政策表明：在风险敏感的金融核心圈，工具的威力越强，安全的栅栏就必须筑得越高。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Goldman Sachs is pulling Claude Code from its bankers and traders | https://news.ycombinator.com/item?id=50415628 |

<div class="disclaimer">
声明：本文讨论内容源自 Hacker News 热门讨论，文中引用的用户观点仅代表原作者个人立场。
<br><br><em>本摘要由 AI 模型辅助生成：google/gemini-3.5-flash</em>
</div>
