---
layout: post
title: >-
  LibreOffice 26.8 因「没有 AI」下载破百万 — HN 讨论聚焦捆绑分发与因果错觉
date: 2026-09-11
categories: [articles]
excerpt: >-
  LibreOffice 26.8 一周下载超百万，TDF 把「不内置 AI」当作卖点宣传。但 HN 讨论指出，ChatGPT 与 Codex 早已把整套 LibreOffice 静默打包进客户端，所谓「反 AI 下载」更像因果错觉。
tagline: >-
  救火的被奖励，防火的被遗忘——但也许连火都是幻象。
---

## 原文概要

2026 年 8 月 26 日，The Document Foundation（TDF）发布 LibreOffice 26.8。9 月 2 日，基金会发布统计：26.8 在一周内被下载 1,031,162 次（不含 Linux 发行版仓库更新），被官方称为「LibreOffice 史上首周下载量最高」。

一周后，TDF 发表署名文章《Yes, no AI is now a feature》。文章由 Italo Vignoli 执笔，澄清立场——TDF「并不一概反对 AI」，但目前的技术无法满足六条默认集成原则：用户可控执行、内容不得未经授权外发、零遥测、不依赖单一供应商、不妥协文件格式、完全可选。基金会建议通过社区插件方式集成 AI。

TDF 在文中对抢先内置 AI 的对手做了含蓄的吐槽：「AI 助手恰好为涨价提供了理由，也让把所有文档留在自己基础设施内变得顺理成章。」——讽刺的是，最讽刺的一击来自 HN 评论：很多人根本没有主动下载 LibreOffice，他们只是用了 ChatGPT。

---

## 讨论焦点

### 1. ChatGPT/Codex 早已把 LibreOffice 静默打包

最热闹的支线：客户端软件偷偷把 LibreOffice 当作底层依赖。当用户让 ChatGPT 生成 PPT 时，应用就会下载一份 LibreOffice。整件事因此变得不那么浪漫。

> "Yeah, an AI tool: The ChatGPT/Codex app bundles a full copy of LibreOffice" — andai [c:49612686]
> （是的，AI 工具：ChatGPT/Codex 应用捆绑了一整份 LibreOffice。）

> "The ChatGPT app downloads a copy of LibreOffice when you ask it to make pptx files. So I've downloaded LibreOffice 3 times this week without really paying attention to it." — gopalv [c:49612942]
> （让 ChatGPT 生成 PPT 时，应用就会下载一份 LibreOffice。我这周不知不觉就下了三遍。）

> "Ironic since the headline implies that people are downloading it specifically to avoid AI features being shoved into our document editors." — jandrese [c:49612999]
> （讽刺的是，标题暗示大家下载它就是为了避开被塞进文档编辑器里的 AI 功能。）

这个分支把整条新闻的因果链彻底打散：「反 AI 下载」的功臣，很可能就是 AI 自己。

### 2. 周下载量本来就在涨，「记录」是错觉

HN 老派用户对「记录」这个词高度警觉。每周下载量随用户基数上涨而抬高，是单调递增现象，不是因果。

> "The number of weekly downloads has simply been increasing over time, due to growing popularity. Calling each new high 'record-breaking' is a bit meaningless. Unix timestamp counter breaks record after writing this comment." — smokel [c:49610713]
> （周下载量本来就随时间上涨。给每次新高都贴上「破纪录」有点没意义。写完这条评论 Unix 时间戳也破纪录了。）

> "It's the tried and true headline method of 'event 2 happened after event 1', implying a causal effect between the two, despite no evidence of such effect existing. Technically the headline is correct, in the same way that 'Canada Tariffs $20b in US Goods After Amazon Plane Crash' is also correct." — jrflo [c:49611179]
> （这是经典的标题手法：「事件 2 在事件 1 之后发生」，便暗示因果关系。事实上没有证据。技术上说，标题也没错——「亚马逊飞机失事后加拿大对美国加征 200 亿关税」同样语法正确。）

> "Post hoc ergo propter hoc." — gadrev [c:49611489]
> （后此即因此。）

有人贴出 Document Foundation 自己的统计图：26.8 的峰值落在历史周间波动的正常区间里；按 ISO 周口径，LibreOffice 在第 31 周就已经跨过百万周下载。

> "Yes, here's the graph of weekly downloads: https://stats.documentfoundation.org/downloads#week,version The 26.8 peak is within the normal range of week-to-week variation." — yorwba [c:49611377]
> （周下载图在这。26.8 峰值在周间波动的正常范围内。）

### 3. 「没 AI」是真卖点，但 HN 可能是信息茧房

TDF 把「无 AI」摆成核心卖点。围绕这条线索，HN 内部分成两派。

一派认为这低估了大众对 AI 的反感：

> "You underestimate the public's hatred of AI-in-everything. HN is a bubble of AI." — leptons [c:49612696]
> （你们低估了大众对「AI 无处不在」的厌恶。HN 是个 AI 信息茧房。）

> "I fully expect the bubble is the people in tech who have strong feelings about the goodness or badness of AI one way or another." — ghaff [c:49616441]
> （我猜真正的信息茧房是技术圈——对 AI 持强烈立场的人。）

另一派怀疑一般人真会为这事换掉 Office：

> "Disliking clunky autocomplete is very different from going out of your way to replace Word with Libre Office. The average office worker will tolerate ten bad assistants before they voluntarily deal with ODF formatting quirks in a corporate environment." — KolibriFly [c:49622353]
> （不喜欢笨拙的自动补全是一回事，主动把 Word 换成 LibreOffice 是另一回事。普通上班族能忍十个烂 AI 助手，也不愿在企业环境里对付 ODF 格式怪相。）

### 4. TDF 的六条原则不是反 AI 宣言

TDF 在《Yes, no AI is now a feature》中明确写出六条「默认集成 AI」必须满足的原则。Vignoli 在结尾说，这「和技术本身几乎无关」。HN 用户注意到，这其实是针对订阅型 AI 商业模式的隐性攻击。

> "Either there's 1m people downloading new software 'because no ai', or there's another popular thing that installs this, and is not counted in the 'updates via linux repos'. One is much much more probable than the other." — NitpickLawyer [c:49612553]
> （要么真的有 100 万人「因为没 AI」下载，要么有别的东西在静默装它，而 Linux 仓库更新没被算进统计。后者概率远高于前者。）

### 5. 一些不在统计图上的真实用户

讨论的轻支线：老年人用 LibreOffice 写文档、写信。这是统计图看不到的故事。

> "Really timely, too, since my 83-year-old mom called me the other day to help her E-mail a document she prepared in LibreOffice. I installed it on her (seldom-used) computer years ago. So I talked her through E-mailing it with Thunderbird. And I say 'talked,' because the jagoffs at Microsoft REMOVED Remote Assistance from every version of Windows used by people who are likely to need it." — MoonWalk [c:49611338]
> （来得正是时候——我 83 岁的妈妈刚打电话来，让我帮她把 LibreOffice 写的文档用邮件发出去。几年前我在她那台不怎么用的电脑上装好了。我只能「嘴上」指导她用 Thunderbird 发邮件，因为微软把最需要远程协助那批人用的 Windows 版本上的远程协助功能全砍了。）

> "If she's anything like my mom, i.e. someone who has been using computers for a while now but never had the confidence to experiment with it, any small change will freak her out and there really is a long tail of those. It's not a matter of Linux not being good enough, being different is already a real problem." — account42 [c:49623165]
> （如果她像我妈妈——用电脑多年但从来不敢折腾——任何小变化都会让她慌。这类人有一长串。Linux 够不够好不是问题，「不一样」本身就是问题。）

这条支线让人暂时从统计曲线和捆绑分发里走出来。每一个「下载」背后都是一个人。统计图分不出谁是主动下载，谁是被 ChatGPT 顺带装上的，但这些人分得出。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 因果错觉派 | smokel / jrflo / gadrev | 周下载量本来就在涨，「破纪录」不证明因果。 |
| 捆绑分发派 | andai / gopalv / jandrese | ChatGPT/Codex 静默打包 LibreOffice，所谓反 AI 是错觉。 |
| 大众反 AI 派 | leptons / ghaff | 普通人对 AI 无处不在的厌恶被技术圈低估。 |
| 现实主义派 | KolibriFly | 普通上班族宁忍十个烂 AI，也不愿换 LibreOffice。 |
| 数据质疑派 | yorwba / smokel / tzs | 26.8 峰值在历史波动的正常区间。 |
| 温和支持派 | MoonWalk / account42 | LibreOffice 在被统计忽略的角落真的有人在用。 |

---

## 总体情绪

讨论分裂得很整齐：一半人质疑因果链，另一半人为 TDF 的姿态叫好。讽刺来自一个完全出乎意料的方向——给 TDF「下载破百万」贡献最大的，可能恰恰是 TDF 公开反对的那些 AI 应用。统计图上的尖峰是真实的，但尖峰背后的解释权不在基金会手里，也不在用户手里，而在那些把 LibreOffice 当底层依赖打包进客户端的公司手里。

「救火的被奖励，防火的被遗忘」这句话放在 TDF 身上还要再翻一层——也许连火都是幻象。

---

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | LibreOffice breaks download records after declaring it has no AI features | https://news.ycombinator.com/item?id=49610538 |
| 2 | Yes, no (built-in) AI is now a feature | https://blog.documentfoundation.org/blog/2026/09/03/yes-no-ai-is-now-a-feature/ |
| 3 | The ChatGPT/Codex app bundles a full copy of LibreOffice | https://news.ycombinator.com/item?id=49527396 |
| 4 | One week of LibreOffice 26.8: the stats | https://blog.documentfoundation.org/blog/2026/09/02/one-week-of-libreoffice-26-8-the-stats/ |
| 5 | LibreOffice weekly download stats | https://stats.documentfoundation.org/downloads |

---

<div class="disclaimer">

本文为 HN 讨论摘要，所有引文均来自评论原文。立场归原作者。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
