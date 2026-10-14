---
layout: post
title: >-
  Redesigning source control at Anthropic — HN 讨论摘要
date: 2026-10-14
hn_id: 50073633
categories: [articles]
excerpt: >-
  334 分贴里，HN 用户在问同一件事：30k commit/天到底算工程还是算凑数；Anthropic 自己说 Scion 不开源，又被读者怼回去。
tagline: >-
  Anthropic 把代码仓库塞进 AI 的胃里，吐出来的是三万次提交。
---

## 原文概要

Anthropic 工程团队发表长文，讲他们怎么把公司单仓（monorepo）的版本控制系统从 Git 换成自研的 Scion。起因是一个数字：2026 年 5 月他们每天合并约 2,500 个改动，到 9 月已经涨到每天 30,000 个。文章把这些数字归因于"AI 让写代码不再是人力的瓶颈"，然后点出新的瓶颈——版本控制、构建、CI 这些原本为人手设计的开发者基础设施，开始撑不住。

故事里有几个具体数字：主干历史接近 100 GB、压缩工作副本超过 25 GB、每天 25M 次代码 checkout（naive fetch 算下来是 600 PB/天）。他们一度跑了几百个内部 git mirror 来扛流量，但 mirror 本身也开始耗磁盘和内存。最终的方案 Scion 五个月建成、五个月完成全仓迁移，并且把代码评审（Antique）、代码搜索、IAM 等一并重写。

Scion 的几条核心设计原则几乎都是对 Git 的反向假设：客户端始终在线、客户端/服务端角色不对称、源码控制能力通过 API 暴露给其他服务、所有组件横向扩展、commit 服务端化且 lock-free、工作副本按需 sparse checkout。文章明确说"不会公开发布 Scion"，理由是：它跟 Git 差异过大、要迁移整条开发链路、配套的 code review/搜索/CI 都很 bespoke，"做一个通用版本出来讨好所有人"未必真有用。HN 帖子（来源：[HN 热门榜 /best](https://news.ycombinator.com/best)）发布后十几小时冲到 334 分、约 320 条评论。

## 讨论焦点

### 30k commit/天：算工程还是算凑数

讨论里最尖锐的反问都集中在这条数字上。一种声音是"commit 数本来就不是好指标"。

> "Commit counts are no better than line counts as a software development metric. Where is the actual software?" — joshheitzman [c:50076046]
> （译文：commit 数跟代码行数一样，不是好的软件开发指标。真正的软件在哪里？）

更直接的是把"每天三万次提交"重新换算成单位口径。

> "Only 30k commits per day? That's not actually very many per employee. I'm suspicious that Anthropic's real issues are that too many of them are giant cross-cutting messes and that git clone is too slow." — amluto [c:50075586]
> （译文：每天才 30k commit？摊到每个员工其实不算多。我怀疑 Anthropic 真正的问题是：太多改动是跨切片的大杂烩，而且 git clone 太慢。）

下面有人接了句 "Yes and they have no choice. And that matters."（对，他们没别的选择，这事本身就是重点）。

### 没有人类 code review 是不是值得骄傲

另一条主线质疑指向"AI 大量写代码"这个前提到底成不成立。

> "Is this really something to be proud of? I make heavy use of AI, but for anything that is eventually going to production there's still a human reviewer. Based on this I assume Anthropic is shipping code with no human review? Is the future of our industry going to be oneshotting prompts with out manual code review and then having AI fix the bugs found in production buy customers? I'm not trying to be a Curmudgeon, but am I missing something?" — jareds [c:50075604]
> （译文：这真的值得骄傲吗？我自己重度用 AI，但任何最终上生产的东西都还有人类 reviewer。从这文来看，Anthropic 是在没有任何人类 review 的情况下发版吗？咱们这行的未来是不是就是一次性写好 prompt、跳过人工 review、再让 AI 修客户在生产里发现的 bug？我不是想当老顽固，是我没理解到哪儿吗？）

讨论里 Anthropic 工程师 nickg-anthropic 明确回应说："我们一般不允许 agent 用 source control 来做 coordination，真正撑起提交量的是实际写的代码"。这条澄清没有被进一步反驳，但 jareds 追问"allow 还是 encourage？怎么 fail-closed"也没拿到更细的回答。

### "提交是服务端做的"丢了 Git 的本

把 commit 放到服务端、客户端只能跟服务器通信，被很多人认为是把 Git 的核心好处扔了。

> "I though the basic idea was reasonable, until: 'So we asked ourselves: if we designed source control with the fact that agents are always online in mind from the start, what would it look like?' And 'In Scion, every commit, rebase, or merge happens on the server' I'll pass. A big part of the theses of git and, even more so, jujitsu, is that you can build up a history entirely locally, making it reasonable to make tiny commits locally and then rework them, push them, or throw them away." — amluto [c:50075586]
> （译文：基础想法我觉得还行，直到这两句："既然 agent 始终在线，那就按这个前提设计源码控制" + "Scion 里所有 commit、rebase、merge 都发生在服务端"。我弃了。Git 的核心理念之一、jujitsu 更甚，是你能**在本地**拼出一段历史，先做小步提交、回头改、推送或丢掉。）

这条评论还顺手抛了一个不太安分的延伸：

> "(Am I the only one who feels like most of the big AI labs are rapidly gradient-descending toward something that is nowhere near a globally optimal stack?)" — amluto [c:50075586]
> （译文：是我一个人觉得几家大 AI 实验室都在沿着梯度一路下到离全局最优很远的地方吗？）

### AI 写的代码越来越多，实际是重造轮子

评论里出现了一种更长线的忧虑：AI 便宜地写代码，会让整个行业进入"人人再造轮子"的泡沫。

> "Not to downplay Anthropic's engineering work here, but I suspect we'll see a lot more reinvention of the wheel, even at smaller startups, as AI makes writing code significantly cheaper. The tradeoff between building something custom and adapting an existing solution is changing. Whether maintaining all of that custom software turns out to be equally cheap is another question." — kburman [c:50075611]
> （译文：不是说 Anthropic 这工程不行，但我猜随着 AI 把写代码的成本压下来，连小创业公司都会大把重造轮子。从零造一个 vs 改造现成的权衡正在变。这些自研软件维护起来是不是也那么便宜，是另一个问题。）

下面的一条跟帖把这条观点扩成了一个清单式的吐槽。

> "Have you always been bothered by the limitations of Grafana? You can generate another dashboarding solution that works best for you. You know that deployment team that is so slow and annoying? Now you can generate your own deployment engine. Have you always hated how kubectl lets you manage one k8s cluster at a time? Now you can ask AI to generate fleetctl." — eddythompson80 [c:50076103]
> （译文：你是不是一直嫌 Grafana 不顺眼？可以生成一个最适合自己的 dashboard。你是不是觉得部署团队又慢又烦？现在可以生成自己的部署引擎。你是不是一直讨厌 kubectl 只能管一个 k8s 集群？现在可以让 AI 生成一个 fleetctl。）

### Scion 是"重新发明 SVN/Perforce"

HN 用户对这套架构最常见的总结很简短：就是曾经的集中式 VCS。

> "So... Anthropic reinvents SVN?" — mijoharas [c:50075274]
> （译文：所以……Anthropic 重造了个 SVN？）

> "Feels more like perforce, but effectively, yes." — bradfa [c:50075998]
> （译文：感觉更像 Perforce，但意思上对。）

底下有人接了一句"以 Anthropic 工程师的品味，应该叫 Subversion 2.0 才显得尊重"。这条线最终指向一个尴尬的位置：Scion 解决的并不是新问题，是 Google Piper、Meta Sapling 十年前就解决过的老问题，只是现在门槛被 AI 拉低到了 Anthropic 这家公司也能做。

### 既然做出来了就开源吧

文章里 Anthropic 自己说了"不打算开源 Scion"，理由是迁移成本太高、配套太 bespoke。读者几乎一边倒地反对这个解释。

> "Anthropic says they don't think Scion is worth a wide release. Practically speaking, it's difficult to offer Scion in a form that would be broadly useful to other organizations. It diverges significantly from git, meaning companies would need to migrate every piece of the development lifecycle, and it requires its own code review, code search, and CI. Our internal versions of these components are highly bespoke, so they would be difficult for other organizations to adopt, and we worry that attempting to build a public version that tries to please everyone wouldn't actually be very useful." — ChrisLTD [c:50076353]
> （译文：Anthropic 说他们觉得 Scion 不值得广泛发布。事实上，要把 Scion 做成对其他组织有用的形式很难。它跟 Git 差异太大，意味着公司得迁移整条开发链路；它还需要自己的 code review、code search、CI。我们内部这几个组件都很 bespoke，其他公司很难采用。我们担心硬做一个讨好所有人的公开版本其实并不好用。）

> "What a weak response, just release the version you use and others will decide if it's useful." — cube00 [c:50077116]
> （译文：这回应太弱了，把你们在用的版本放出来，别人自会判断有没有用。）

### 600 PB/天到底怎么来的

文章里那个最吓人的数字（"600 PB git 流量/天"）也被单独拎出来讨论过。澄清很直接：那是"naive fetch"的算法上限。

> "No, of course not. As the article explains, 'over 600 PB' = 25M code checkouts * 25 GB 'compressed working copy'. So 'fetched naively' here means doing a full `git clone` on every need for `git checkout`, which of course nobody should do, nor does that refer to 'code that needs changing daily'." — nh2 [c:50075855]
> （译文：当然不是。文章里讲了，"600 PB" = 25M 次 code checkout × 25 GB 压缩工作副本。所以"naively fetch"指每次需要 `git checkout` 就做一次完整 `git clone`，当然没人真这么干，也跟"每天要改多少代码"没关系。）

下面 steveklabnik 补了一个 GitHub 内部视角："shallow clone 不一定比 full clone 便宜，因为浅克隆没法复用 packfile"。

### Prompt 当作"源码"？

文章在 HN 上拉出来的另一条支线，是有人开始设想"未来把 prompt 当 source code 提交、AI 生成代码当 build output"。

> "It would be nice if you could just commit the prompts as your 'source code', and let the AI-generated code sit in the repo as a kind of expensive-to-generate build output." — amelius [c:50075108]
> （译文：要是能把 prompt 当成"源代码"提交，让 AI 生成的代码作为昂贵的 build output 留在 repo 里就好了。）

下面立刻被接了一个反问：可复现的 LLM 存在吗？

> "Do we have reproducible LLMs? Possible in theory, with a seeded PRNG, but in practice?" — GuB-42 [c:50075226]
> （译文：有没有可复现的 LLM？理论上可以，给 PRNG 设定种子就行，但实际呢？）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 质疑 | joshheitzman | commit 数本来就不是好的软件指标 |
| 怀疑 | amluto | 摊到员工头上不算多，Anthropic 真正的问题是改动跨切片太多 |
| 警惕 | jareds | 没有任何人工 review 就发版，这是行业的未来吗 |
| 反对 | amluto | 提交放在服务端丢了 Git/jujitsu 的核心价值 |
| 吐槽 | eddythompson80 | 接下来你会看到 kubectl、Grafana、Dashboard 全被 AI 重造一遍 |
| 简短 | mijoharas | Anthropic 重造了个 SVN |
| 补充 | bradfa | 更像 Perforce，意思上对 |
| 反对 | cube00 | 既然做出来就开源，别用"维护成本"当借口 |
| 澄清 | nh2 | 600 PB 是 naive 算法上限，不是真实流量 |
| 内部视角 | steveklabnik | shallow clone 不一定比 full clone 便宜 |
| 工程师澄清 | nickg-anthropic | agent 不能用 source control 协调，是真实代码撑起了提交数 |
| 长线忧虑 | atleastoptimal | 前沿实验室会重写出所有软件，其他人都成它们的供应商 |
| 反问 | amelius | 未来能不能直接把 prompt 提交到 repo |

## 总体情绪

情绪分两层。浅层是质疑 30k commit/天的工程含金量，以及"没有人类 review 就发版"是否值得骄傲；深层是把这件事放回更大的语境——AI 让写代码变便宜，会不会让整个行业同时陷入两个相反的陷阱：一端是软件越来越像"agent 之间的信号系统"、失去 Git 那种"本地历史"的可控感，另一端是人人都有能力造一个自己的 VCS / Dashboard / kubectl，结果没人愿意维护通用的那一个。

更尴尬的位置属于 Anthropic 自己：Scion 解决的并非新问题，是 Piper、Sapling 十几年前就解决过的事，只是 AI 把入场券从"你得是 Google"降到了"你得是个超大 monorepo + 内部最强模型"。读者把这个意思用一句"Anthropic reinvents SVN"就讲完了。

最后让人多看一眼的，是 nickg-anthropic 在评论里随口确认的那一句："Yes, this is a common pattern"（是的，多层 orchestrator + 团队 agent 已经是常态）。Anthropic 内部已经在跑一套"agent 之间互相调用、互相提交、互相协调"的系统，而 Scion 看起来正是为这套系统量身定做的——Git 是为写代码的人设计的，Scion 是为写代码的 agent 设计的。这套区分越成立，越意味着"开发者基础设施为人手设计"这个过去三十年默认的前提正在被悄悄换掉。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Redesigning source control at Anthropic | https://news.ycombinator.com/item?id=50073633 |

## 免责声明

<div class="disclaimer">本文为 AI 辅助生成的 HN 讨论摘要，观点不代表本站立场。引文已对照原帖评论核验（评论 ID 见每条 `[c:...]` 标记）。</div>

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
