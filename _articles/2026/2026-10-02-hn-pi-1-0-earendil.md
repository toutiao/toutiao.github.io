---
layout: post
title: >-
  Pi 1.0 正式发布：Earendil 的极简 agent harness 走到 1.0
date: 2026-10-02
hn_id: '49926069'
categories: [articles]
excerpt: >-
  Pi 1.0 在坚守极简主义的同时内置 Codemode 与原生 MCP 支持, 并新增长任务子项目 Pi Durable。HN 用户围绕「极简 vs 功能堆叠」激烈交锋, Earendil 两位创始人下场回应。
tagline: >-
  Earendil 终于承认: agent 也得跟着训练集走。
---

## 原文概要

Earendil 发布了 Pi 1.0——一款定位「极简、可扩展、可塑性极强」的 agent harness, MIT 协议, 可通过 `curl -fsSL https://pi.dev/install.sh | sh` 一行安装。官方称「全球每周有数十万人在用 Pi」(这一数据有评论者提出质疑)。

1.0 新增能力集中在七项: 原生 Codemode(支持 MCP 接入, 以及 Jev 这类非 LLM 模型与图像模型)、虚拟模型扩展、延迟工具加载(deferred tool loading)、Anthropic 模型缓存预热、会话中途系统消息(可感知 transcript 的 prompt 与工具改动)、新 TUI 主题、全屏默认模式。Earendil 强调「很多东西上墙又掉墙, 留下的才是真有用的」。

同日发布的还有实验性子项目 **Pi Durable**, 面向「长跑型」agent 应用——不是把 Pi 拖向臃肿, 而是把长时间运行、多表面接入、可被人中途接管的场景拆出去做新基座。`npm install @earendil-works/pi-durable @earendil-works/pi-ai @earendil-works/chord` 即可使用。

来源: HN 热门榜 (/best)

---

## 讨论焦点

### 1. Pi 在真实工作流里被怎么用

最被反复追问的是「这玩意到底怎么落地」。评论者们给出了五花八门的实战配方:

> "the main thing i use it for that seems like a pain with other coding agents is my sandboxing workflow: i have a custom extension which allows the pi process to run on my laptop, keeping all my transcripts in one searchable place, while delegating all the bash and file system commands to a VM."
> — igorbark [c:49926430]

> （跟其它编码 agent 比起来, 我主要用它的沙盒工作流: 我写了一个扩展, 让 Pi 进程跑在我笔记本上、把全部 transcript 集中索引, 同时把所有 bash 和文件系统命令都转给一台 VM.）

> "I have a custom Django app that calls out to [Pi] for a bunch of stuff. [...] one pi uses a whatsapp wrapper to constantly listen to a whatsapp group and find bills. Then those get added to the Django Database which triggers a second pi + deepseek to OCR them, parse out the data like amount, due date, reference etc, and update the database with that."
> — ritzaco [c:49926391]

> （我有个自建的 Django 应用调用 Pi 做一堆事. [...] 一个 Pi 跑 WhatsApp wrapper, 盯着群里有人发的账单; 账单进 Django 库后触发第二个 Pi 加 deepseek 做 OCR, 解析金额、到期日、参考号之类.）

Pi 的另一个反复被点名的优势, 是对本地模型的友好: 系统提示短, 在消费级硬件上 prefill 不会卡到分钟级。

> "Love pi. I tried to run some local models and pi was the only one that actually worked decently because it didn’t have a gargantuan system prompt that would take minutes to prefill on my scrawny ass laptop."
> — FacelessJim [c:49926563]

> （爱 Pi. 我试着跑本地模型, Pi 是唯一一个真能跑得动的——别人家的系统提示太长, 在我这破笔记本上 prefill 要好几分钟.）

有意思的是, 多名重度用户提到「我已经把 harness 当作基座」, 自己写扩展是常态:

> "I have a subagent/Ralph loop extension I coded and that's basically it. [...] I'm about 75% pi, 20% autolith, and 5% my own harness."
> — sroerick [c:49926371]

> （我写了个 subagent/Ralph loop 扩展, 别的就没了. [...] 大概 75% 工作量在 Pi, 20% 在 autolith, 5% 在我自己的 harness.）

### 2. 「极简」还能守多久

1.0 引入了 Codemode、原生 MCP, 「极简派」立刻警觉:

> "Sigh, looks like Pi's days as a nice minimal agent TUI are numbered. I guess no third-party offering can fight that entropy for long and I'll just have to polish up one of my toy projects for personal use."
> — wgd [c:49926549]

> （唉, Pi 作为一款极简 agent TUI 的日子看来要数着了. 我猜任何第三方产品都扛不过这股熵增, 我得把自己的玩具项目打磨一下自用了.）

Earendil 联合创始人 Mario Zechner 直接下场回应, 给出相当具体的边界:

> "All of these features are still entirely optional and the only thing I could think of that could be considered 'bloat' is the additional few megabytes for the QuickJS WASM blob."
> — badlogic [c:49926840]

> （这些特性全都是可选的. 我能想到的「臃肿」就只有 QuickJS WASM 镜像多出来的几 MB.）

他还顺手给出了一条产品取舍标准——「跟着模型训练集走」:

> "We follow what the models are trained on. E.g. the GPT family of models is actually trained on codemode for parallel tool calls now. The MCP spec has gotten a major update recently that makes it much less bad than it used to be in the past 24 months. Combined with codemode, it is now passable, so it got added to pi."
> — badlogic [c:49926840]

> （我们跟着模型的训练数据走. 比如说 GPT 系列现在就是在 codemode 上训练并行工具调用. MCP 规范最近一次大更新让它过去 24 个月没那么糟了. 配 codemode 之后总算能用, 所以进了 Pi.）

而长期用户更担心的不是功能多少, 而是 UX 不能倒退:

> "I love how consistent pi has been, especially in regards to not breaking ux"
> — lionkor [c:49926428]

> （喜欢 Pi 一以贯之的地方——尤其是别破坏 UX.）

### 3. 「成熟」的判断标准: 为什么不早不晚

这一轮真正被反复拷问的, 是 Pi 团队「等一项技术被证明」的门到底在哪里。评论者 hhh 直接质疑:

> "I don't really understand the criteria for when something is 'proven' to the Pi team. Jev and the like took off less than a month ago, but MCP has been growing for nearly 2 years, and it only gets support now?"
> — hhh [c:49926262]

> （我不理解 Pi 团队眼里「成熟」的判定标准到底是什么. Jev 这类东西起飞还不到一个月, MCP 已经长了快两年, 结果现在才支持？）

Earendil 联合创始人 Armin Ronacher 直接给出「看模型训练在什么上」的解释:

> "we look at what the models are doing. They are trained on their respective harnesses and we're not here to fight their behavior. Codex in particular is using responses lite internally and relies on codemode for parallel tool calling. So codemode was a given."
> — the_mitsuhiko [c:49926377]

> （我们看模型在做什么. 它们是按各自的 harness 训练的, 我们没必要跟模型的行为对着干. Codex 内部就是用 responses lite + 靠 codemode 做并行工具调用, 所以 codemode 是必选项.）

这解释并未被普遍买账。charcircuit 认为这与「让用户自己扩展」的极简哲学冲突:

> "But why does it need to be integrated with a minimal coding agent? Trying to support every possible thing that exists goes against being minimal."
> — charcircuit [c:49926493]

> （为啥要把这些内嵌进一个极简的编码 agent？什么都支持一点, 跟极简正好相反.）

而 Armin 的二次回应把立场说得更直白——「极简」不是「拒绝训练集」:

> "The point of Pi is to be minimal but also follow what the models need. [...] Mario and I talked about this last week if you want to know our thinking: [...] And yes, that's why there is no Jev tool in Pi either."
> — the_mitsuhiko [c:49926755]

> （Pi 的定位是极简, 但也要跟着模型的需求走. [...] 我跟 Mario 上周聊过这个, 链接在上面. 对, 所以 Pi 里也没有专门的 Jev 工具.）

### 4. 用 JS 写底层工具这件事

另一个相对独立但被顶到前排的吐槽, 是 Pi 选了 TypeScript:

> "what drives people to use <i>javascript</i> of all languages to build these fundamental pieces of tooling? We have so many better options, especially now since humans aren’t writing most of the code. It’s hard to take seriously anyone that wants to make a primarily CLI tool with heavy interactivity and parallelism requirements and decides to use a joke language that happened to luck its way into prominence because of web browsers."
> — semiquaver [c:49926433]

> （为什么偏偏是 JavaScript？明明有更好的选择——尤其现在大部分代码都不是人在写. 很难认真看待一个做 CLI、需要重交互和并行、却选了个靠浏览器火起来的「玩笑语言」的工具.）

反驳则指出, harness 的瓶颈根本不在语言层:

> "Most of the harness apps will be spending most of their time waiting for the models response and tool calling rather than running their code. Languages with less opensource footprint or too verbose are at the losing side in a llm-driven world."
> — pezgordo [c:49926649]

> （harness 类应用大部分时间在等模型响应和工具调用, 而不是跑自己的代码. 在 LLM 时代, 开源生态弱、语法又啰嗦的语言会越来越吃亏.）

Earendil 团队自己也给出了选 TS 的实操理由——「让 agent 改自己」要快:

> "With Pi the agent edits agent itself. That’s one of the reasons it’s written in typescript, to make such iteration fast."
> — charcircuit [c:49926746]

> （在 Pi 里, agent 可以改 agent 自身. 这也是为什么用 TypeScript 写——迭代要快.）

---

## 典型观点

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 实战派 | igorbark | 把 Pi 当沙盒中枢, 自己写扩展把 bash/FS 转给 VM |
| 实战派 | ritzaco | 用两个 Pi 加 deepseek 拼出一条 WhatsApp-OCR-账单流水线 |
| 极简派 | wgd | Pi 的极简 TUI 日子数着了, 自己玩具项目顶上 |
| 维护方 | badlogic (Mario) | 新特性全可选, 「臃肿」只剩 WASM 镜像那几 MB |
| 质问方 | hhh | 「成熟」的判定标准说不清, MCP 两年才进, Jev 一月就进 |
| 解释方 | the_mitsuhiko (Armin) | 看模型训练在什么上, 不跟模型行为对着干 |
| 反解释 | charcircuit | 这跟「让用户自己扩展」的极简哲学直接冲突 |
| 本地派 | FacelessJim | 系统提示短是 Pi 跑本地模型的杀手锏 |
| 反 TS | semiquaver | 用 JavaScript 做底层 CLI, 很难认真看待 |
| 反反 TS | pezgordo | harness 卡在等模型响应, 语言选择没那么要命 |
| 品牌梗 | sgustard | 「托尔金名字的公司都是战争贩子吧?」 |

---

## 总体情绪

HN 上对 Pi 的整体评价偏正面——「能跑本地模型」「UX 不破」「可扩展做基座」是被反复点名的优势, 老用户的回购理由是「我写扩展它不挡我」。

但 1.0 把 MCP 和 Codemode 一起拉进核心, 直接撞上了 Pi 自身的招牌「极简」。讨论里最值得看的不是「1.0 好不好用」, 而是 Earendil 给出的产品哲学——「跟着模型训练集走, 而不是跟用户想要的 feature list 走」。这条原则在评论者那里分裂得很整齐: 长期用户和依赖 Pi 做基座的开发者大多点头, 「我就要一个干净的 TUI」的用户已经在物色替代品。

更值得玩味的是数据本身: 官方称「每周数十万人在用」, 下面第一条就是「hundreds of thousands 没人信服, 我要看证据」。在一个「极简工具想留住极简用户」的故事里, 这种质疑比功能争议更扎眼。

极简不是免费午餐——它要么被功能吃掉, 要么被体量吃掉。Pi 选了前者, 然后赌它的老用户愿意跟着训练集走。

---

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Pi 1.0 | https://news.ycombinator.com/item?id=49926069 |

<div class="disclaimer">
**免责声明**: 本文是对 HN 讨论的编译与提炼. 所有观点来自 HN 评论者, 不代表本人立场. 引文中的 `[c:xxxxxx]` 为对应 HN comment ID, 可用于原文核验.

<br><br><em>本摘要由 AI 模型辅助生成: minimax-cn-coding-plan/MiniMax-M3</em>
</div>
