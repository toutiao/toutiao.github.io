---
layout: post
title: >-
  Deno 团队加入 Cloudflare —— HN 讨论摘要
date: 2026-10-09
hn_id: 50019911
categories: [articles]
excerpt: >-
  Deno 团队整体并入 Cloudflare，runtime 一年内停更、Deploy 六个月关停；多数读者认为真正被收购的是 celld，而不是 Deno 本身。
tagline: >-
  八年一场 runtime 梦：买的是人，关的是项目。
---

# Deno 团队加入 Cloudflare —— HN 讨论摘要

## 原文概要

2026 年 10 月 9 日，Deno 创始人 Ryan Dahl 在官方博客宣布：整个 Deno 团队加入 Cloudflare，未来工作的重心是把团队自研的 `celld` 与 Cloudflare 的 `workerd` 合并成一个开源、可自托管的运行时。

文章末尾的几条信息被多数读者视为这次公告的重点：

- Deno runtime 还会继续维护一年，每月发布 bug fix 与安全更新，一年后停止开发；代码保持开源，欢迎社区接手。
- Deno Deploy 六个月后停服，付费客户提供迁往 Cloudflare Workers 的支持。
- JSR 继续运营，基础设施迁移到 Cloudflare。
- `rusty_v8`（V8 的 Rust 绑定）继续维护，并逐步合入 `workerd`。

Ryan 在文末点名 Durable Objects："廉价无服务器执行 + 持久状态 + WebSocket + 高层 JavaScript 接口，是 agent harness 想要的能力。"他邀请自建基础设施跑 agent 的团队直接联系 `ry@cloudflare.com`。Cloudflare 一方的 Kenton Varda 在同日发的 Cloudflare 博客里补了背景：合并后会产生一个"first-class open source self-hostable runtime for Workers and Durable Objects"。

来源：[HN 热门榜 (/best)](https://news.ycombinator.com/best)。

## 讨论焦点

### 公告里被"埋掉"的关键细节

不少读者指出，Deno runtime 一年内停更、Deploy 六个月关停，这两条信息既出现在 Deno 博客又被 Cloudflare 博客淡化处理，是这次公告真正的硬内容。

> "So unless someone else picks up development, Deno will no longer be supported." — theodorejb [c:50020072]
>
> （译文：除非有人接手继续开发，否则 Deno 将不再被支持。）

> "I don't like how that's in the Deno post but gets no mention in the Cloudflare post. Seems like a pretty important detail!" — simonw [c:50020172]
>
> （译文：我不喜欢这个细节只在 Deno 那篇博客提一句，Cloudflare 那篇连提都不提。这明明是个非常重要的点。）

两个博客的措辞差距，是评论区分"收购 / 合作"还是"裁员式收购"的源头。Cloudflare 一方的 Kenton Varda 在评论里反复邀请读者去看 Cloudflare 那篇，强调"事情不是 fluff"，但读者注意到的是——那篇里确实没提停更时间表。

### 这次收购买的是 celld，不是 Deno

很多评论认为真正值钱的是 `celld`——Deno 团队独立做的、把对象存储当协调层的自托管运行时。Cloudflare 自己的 `workerd` 反而是这个方向的早期版本。

> "Ryan and co. will be merging celld with workerd to create one first-class open source self-hostable runtime for Workers and Durable Objects." — kentonv [c:50020200]
>
> （译文：Ryan 和他的团队会把 celld 合进 workerd，做出 Workers + Durable Objects 的、头等的、开源可自托管运行时。）

> "the more interesting part is merging the celld model into workerd. I've been following celld since it was announced. Bootstrapping both durability and coordination off object storage simplifies so many things for self-hosting." — ryanrasti [c:50020609]
>
> （译文：更有意思的部分是把 celld 模型合进 workerd。我从 celld 发布起就在跟这项目。把持久化和协调层都建在对象存储之上，让自托管变得简单得多。）

这条思路也解释了为什么 Deno Deploy 必须关——它本来就跟 Cloudflare Workers 是同质产品，留着就是 Cloudflare 自己的两个团队互相竞争。

### JavaScript 运行时战局的最终答案：还是 Node

公告下面最高赞的一类评论回到一个更朴素的问题：新项目该选什么 runtime？

> "I have no idea anymore what is happening, and none of the blogposts seem to explain that either. So, if I am to start a new JS or TypeScript project or whatever, what should I choose and why?" — gen2brain [c:50020519]
>
> （译文：我现在完全搞不清状况，这些博客文章也没解释清楚。我要是新开个 JS 或 TS 项目，到底该选什么？为什么？）

> "One was not rewritten in Go. Typescript rewrote its compiler in Go, but that doesn't affect which runtime you use for the resulting Javascript code." — jerf [c:50020630]
>
> （译文：没人重写 JS。TypeScript 把编译器换成了 Go，但跟你用哪个 runtime 跑生成的 JS 完全无关。）

> "In the age of the LLMs, if you wanna get out of Node, you better translate all to native Go or Rust." — TheRoque [c:50021125]
>
> （译文：在 LLM 这个年代，真要离开 Node，你最好把代码全翻译成原生 Go 或 Rust。）

主流答案集中在两个方向：保守派坚持 Node + LTS，激进派干脆跳出 JS 生态去 Go / Rust。中间路线（Deno / Bun / 各种 Rust 系 JS runtime）被普遍视为高风险赌注——独立 runtime 没有事实标准保护，随时可能成为下一份讣告。

### 迁移成本并没有那么夸张

与之相对，另一组评论指出，Deno → Node 的迁移在过去一年已经被 LLM 大幅拉低：

> "You can migrate off deno in a single day. It's not a big deal." — redox99 [c:50021131]
>
> （译文：一天就能迁出 Deno，没什么大不了的。）

> "Probably an hour if you just tell your model of choice to do it for you and implement a logical testing framework." — hodder [c:50021154]
>
> （译文：要是让你常用的模型替你做，再加上一套合理的测试框架，可能一个小时就够了。）

> "Million lines of deno based ts is not a problem because pretty much any functionality provided to deno is available for node as well. You probably can migrate off much of the external deps without much hassle." — matesz [c:50021361]
>
> （译文：百万行 Deno 的 TS 代码也不是问题，因为 Deno 提供的能力 Node 基本都有。外部依赖大概也能无痛迁出。）

这条声音降低了"弃用 Deno"的整体痛感，但也坐实了另一件事——既然 Deno 在 runtime 层面没有护城河，那它确实没有理由继续独立存在。

### AI agent 与 Durable Objects：Cloudflare 的真实目标

Ryan 自己点名"agent harness"是 Durable Objects 的天然场景，Kenton Varda 解释合并 `celld` 时的措辞也落在同一处。读者注意到了：

> "is this Cloudflare signalling they're going to hard pivot to being an AI company?" — cyanydeez [c:50020328]
>
> （译文：这是不是 Cloudflare 在喊话——他们要硬切到 AI 公司？）

> "celld is a more complete Cloudflare-at-home runtime than current workerd. What does Cloudflare stand to gain from commodizing Workers?" — networked [c:50021206]
>
> （译文：celld 比现在的 workerd 更像是一个完整的、可自托管的 Cloudflare。Cloudflare 把 Workers 商品化，又能拿到什么好处？）

把两段放一起读，Cloudflare 的逻辑浮出水面：把运行时开源、把执行层商品化，押注在数据层（D1 / Durable Objects / R2）和 AI agent 工作流上做差异化。Deno 团队是这条路线的人。

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 正面 | phaser [c:50020037] | Deno 的开发体验一直很好，希望这次合并是 second impulse |
| 正面 | kentonv [c:50020200] | celld 合 workerd 对 Cloudflare 是好生意 |
| 中性 | redox99 [c:50021131] | 一天就能迁出 Deno，没那么严重 |
| 中性 | hodder [c:50021154] | 让 LLM 替你迁，一小时搞定 |
| 中性 | ryanrasti [c:50020609] | 真正有意思的是 celld 进 workerd |
| 负面 | simonw [c:50020172] | 关键细节被埋是糟糕的沟通 |
| 负面 | theodorejb [c:50020072] | 不接手就等于停更，事实就是停更 |
| 负面 | Jgrubb [c:50020646] | 这是开源的死亡，以后谁还敢信 |
| 负面 | behnamoh [c:50020286] | 跟 Bun 一样的 rug pull |
| 负面 | rfgplk [c:50021358] | 一两周就能复刻的项目，收购价不值 |

## 总体情绪

讨论大体分成三层情绪。表层是"Deno 之死"的悼词（"RIP Deno"在多条评论里出现），中层是"我们还要不要继续相信独立开源 runtime"的怀疑——这一点最尖锐的版本来自 Jgrubb，他直接称这是"the death of open source"；底层是少数人对 `celld + workerd` 路线真心的看好，这一层以 Cloudflare 一方的 Kenton Varda 和几位长期跟 celld 的开发者为代表。

读者普遍认为 Deno runtime 已经不是这场交易的实质，但它的死法——"被自己团队主动放弃"——比被直接关闭更让人不舒服。一个被多次提到但跟主公告无关的细节是：Deno 2026 年初已经裁过一轮人，结局其实早就写在墙上。

> "Disappointing news to see it shut down, but maybe the writing was on the wall after they laid off some of their folks." — dpc94 [c:50021372]
>
> （译文：关掉是让人失望的消息，但年初那波裁员之后，写在墙上的字大家都看到了。）

开源 runtime 的退出，正在变成一道算术题：有没有人接盘、谁来付账、什么时候停。下一代 runtime 的事实标准——Workers + Durable Objects 这套——大概不会再给任何独立团队留出重新走一遍的窗口。

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | Deno Is Joining Cloudflare | https://news.ycombinator.com/item?id=50019911 |
| 2 | Deno is joining Cloudflare（Deno 官方博客原文） | https://deno.com/blog/cloudflare |
| 3 | Deno joins Cloudflare（Cloudflare 官方博客原文） | https://blog.cloudflare.com/deno-joins-cloudflare/ |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 公开讨论的摘要与导读，观点不代表本站立场。引文为 HN 评论原文，中文译文为译注。讨论链接全部指向公开页面。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
