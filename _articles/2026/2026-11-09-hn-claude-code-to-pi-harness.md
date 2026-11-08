---
layout: post
title: >-
  告别 Claude Code，迁到 Pi：244 次发布、3000 token 的系统提示，和一场 harness 迁移 — HN 讨论摘要
date: 2026-11-09
hn_id: 50410107
categories: [articles]
excerpt: >-
  一篇「我要离开 Claude Code」的博客冲上 HN 592 分，评论区第一条却在问作者是不是被
  Anthropic 盯上了——那句话是句反话。反话背后是一本算得清的账：今年 244 次发布，
  超过四分之三改了系统提示，默认 Bash 工具的描述就占掉近 3000 token。
tagline: >-
  他把今年 Claude Code 的 244 次发布数了一遍：超过四分之三改了系统提示。
---

> 来源：HN 讨论主帖 [Goodbye Claude, hello Pi](https://news.ycombinator.com/item?id=50410107)（592 分，382 条评论），原文是开发者 Caleb（HN 用户名 karagenit）写下的迁移宣言。本篇为 cluster 模式，覆盖 3 个讨论帖：主帖 50410107、相关帖 50366117（Ask HN: What's your current AI agentic setup?，524 分、645 条评论）、相关帖 50315226（Prospero: A new coding harness for a more civilized age，204 分、134 条评论）。归档快照 2026-11-08 19:23 UTC，入库评论 110 / 151 / 111 条。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

作者 karagenit 在自己的站点 caleb.software 上写了这篇文章，通篇是一份告别书——他说这算是给 Claude Code 写的讣告。文章 9 月 21 日首发，11 月 7 日更新，11 月 8 日上午冲上 HN 首页，一路到 592 分、382 条评论。他自述从 Claude Code 刚进 Claude Pro 订阅那会儿就开始用（一年多以前），第一反应是「giddy」——周末项目丢给它一句 prompt，它就吐出一坨乱七八糟的 Python；他觉得几年后回看，会把 Claude Code 的发布当成这一轮软件开发新纪元的主要推手之一。

真正让他决定走的，是「一堆积起来的小麻烦」，他决定一次列清。第一条是上下文格式：GitHub 上到处散着 CLAUDE.md 文件，他把这看成 Anthropic 的 guerrilla marketing，但用户要自己维护两套格式，复制或者 symlink 来回倒腾。

第二条是 VSCode 集成。harness 接上 IDE 之后，选中一段文本就能自动带进上下文，这正合他「提交前自己先看一遍代码」的习惯。但同一时刻只能有一个 session 连着 IDE——再开一个标签页跑别的活儿，它就再也收不到 IDE 的选区事件。这个问题至少从 2025 年 12 月就有人提过（claude-code issue #14865），被当作另一个不相关 bug 的重复关掉了。改用官方 GUI 扩展可以多开标签页，代价是内置 slash 命令有一半根本不工作、不支持自定义 status line、多个 subagent 的输出按时间顺序直接叠进主聊天流，多开几个就成了一团乱麻。

第三条是节奏。dynamic workflows、agent teams、ultrareviews 这些功能一个接一个地出，都是帮企业客户每天烧更多 token 的东西，他自己并不需要；而每次版本更新又总在改动他个人的配置。他数出一笔账：今年 Claude Code 一共发布了 244 次，其中超过四分之三改动了 system prompt 或 tool description，这些东西会实打实改变模型表现，尤其是当新指令和用户 prompt 或仓库约定打架的时候。

他最在意的其实是开销。即便 Anthropic 已经砍掉 80% 的 system prompt，Claude Code 的额外负担仍然远大于 Pi，其中一大块来自默认 Bash 工具的描述——接近 3000 token，里面大半是在教模型怎么用 git、怎么在 GitHub 上开 PR。脚注里他给了个粗算：假设 100 万日活、每天 1 亿次请求，砍掉 1000 token，一年能省下几百万美元的推理成本。

结论段落很直白：Claude Code 像一个没有强方向的产品，一群兴奋的工程师和 PM 把自己工作流需要的功能往上贴，不太管这会不会把别人的设置搞坏；产品工程里最需要的是有人专职说「不」，而现在没有这个人。

迁到 Pi 之后，前几天要折腾一点，之后一路顺滑。他看重的是稳定、极简和极高的可定制程度，已经写好了两个扩展，还打算整理完开源出来。他自嘲说，装好 Pi 之后他花了 20 分钟写了个扩展，就把原文抱怨的那件事（多标签页 IDE 集成）做掉了——技术上并没有多难。

同一周里，HN 上还有两个帖子在补这块拼图。一个是 11 月 4 日 eggbrain 发的 Ask HN「你现在的 AI agentic 配置是什么」（524 分、645 条评论），它是一张横截面：绝大多数人还在 Claude Code 里，但 Pi、opencode、herdr、DeepSeek Harness 和自研 harness 都已出现在配置单上。另一个是 10 月 31 日的《Prospero: A new coding harness for a more civilized age》（204 分、134 条评论），skeeto 用 C++ 加 Dear ImGui 写了一个自己的 coding harness，宣称资源占用比同类低两个数量级，不内置任何 model provider，也不能直接用 Claude 订阅。三帖指向同一个问题：当模型能力一路往上走，真正决定你每天用起来顺不顺手的，是 harness。

## 讨论焦点

### 一、那句「Anthropic 盯着我」是句反话

第一条评论没读出反话：

> "Forgive me for asking if I should know, but who is the author? Is he famous?" — andsoitis [c:50410258]
> （译文：原谅我这么问，我该知道这个人吗？他有名吗？）

第二条把话说破：

> "I think that was tongue in cheek. And by that I don&#x27;t mean the author&#x27;s tongue was actually in his cheek." — TacticalCoder [c:50410327]
> （译文：那显然是句反话。而我说的「舌头没真在脸颊里」也不是字面意思。）

第三条干脆把玩笑往前推了一步：

> "I wouldn’t even say not Anthropic, Boris is soliciting recommendations for Claude Code right now in the secrets exposure thread. Hardly implausible" — derektank [c:50410549]
> （译文：我甚至不能说 Anthropic 那边没在盯着——Boris 此刻正在「secrets exposure」那个帖子里征集对 Claude Code 的推荐。这种可能并不小。）

作者本人随后下场澄清自己「确实不有名」。但玩笑并没有就此收住，wincy 补上了它的现实基础：

> "If he didn’t read my email directly the gist at least got to him." — wincy [c:50411131]
> （译文：就算不是他本人读了那封邮件，至少大意传到了他那儿。）

他讲的是自己两年前抱怨 ChatGPT Pro $200 的图像额度太低，第二天 Sam Altman 就发推说要调整套餐、把用量并到一个池子里。四条评论连起来是一个典型的 HN 时刻：一句反话被当成字面事实，作者出面澄清，然后又有人补充说其实也不算错——这轮讨论的重心在开篇几分钟内就从原文移开了。

### 二、244 次发布：system prompt 通胀

> "At the time of writing, there have been 244 releases to Claude Code this year; over 3&#x2F;4 of these changed the system prompt or tool descriptions.<p>ooof, that is a lot!<p>And we&#x27;re supposed to believe them and start one-shotting our projects..." — O_H_E [c:50410660]
> （译文：写这篇的时候，Claude Code 今年已经发布了 244 次，其中超过四分之三改动了 system prompt 或工具描述。这数量真不少。而且我们还得信它们，指望一口气把项目做完……）

关于这批版本更新该怎么读，评论区分裂得很直接。lifeisloving 干脆否定了「优化」这个说法——他明确指出改 system prompt 不是 hill climbing，而是在控制用户怎么用他们的 LLM。

> "They&#x27;re hill climbing by changing their system prompt... That&#x27;s not how thats done." — lifeisloving [c:50410787]
> （译文：他们靠改 system prompt 来爬坡……那不是爬坡该有的做法。）

同一场争论的另一侧，是 oblio 那种从性能倒推的反问：

> "Let&#x27;s be real. If their tools were as amazing as they&#x27;re touting, Claude Code would be a tight, hyper optimized Rust&#x2F;Zig&#x2F;FreePascal&#x2F;whatever 3MB binary that would launch instantly, have no trouble scrolling text at lightning speed on its 20 platforms, etc, etc." — oblio [c:50413848]
> （译文：说点实在的。如果他们的工具有自己吹的那么好，Claude Code 应该是一个紧凑的、极度优化的 Rust/Zig/FreePascal 之类 3MB 二进制，启动瞬间完成，在 20 个平台上滚字如闪电——而不是现在这样。）

dannyw 给出了第三种读法：把 244 次改动看成持续爬坡和大规模实验、模拟 rollout 的结果，他自己不用 Claude Code 的理由则是读不到源码——他能确认 Codex 那边至少有 telemetry，也敢让 agent 去检查源码，相对更有把握它没在往自己机器上装间谍软件。同一批评论里还有对 3000 token 的补充：dofm 认为小模型本来就不太需要 system prompt，Muse Glimmer 这类模型几乎只要一个推理档位设置就能干活。

### 三、AGENTS.md 迟到一步，谁优先

> "Having claude code ignore agents.md just made it seem dumb. At this point, you probably don&#x27;t need either." — harrisonjackson [c:50410418]
> （译文：Claude Code 忽略 agents.md 这件事本身就让它显得很蠢。到了现在，你大概两个都不需要了。）

支持本身在他看来是必然的——一个连 skills、instructions、references 都不理的 harness，在模型变聪明的年代反而显得最傻。真正的细节在时间线和优先级上：

> "It has since 9&#x2F;16, however folks soon realized it supports AGENTS.md, but not .agents&#x2F;skills." — bredren [c:50410879]
> （译文：这件事从 9 月 16 日起就成立了，不过大家很快发现它支持 AGENTS.md，但不支持 .agents/skills。）

补充一句优先级：CLAUDE.md 存在时优先生效，没有才回落到 AGENTS.md。而作者在原文里说，Anthropic 是在他做决定的第二天宣布 Claude Code 支持 AGENTS.md 的。把这句和 9 月 16 日这个上线日期放在一起看，那句玩笑的分量就出来了：他的决定日和官宣日只差一天。

> "Claude now supports AGENTS.md fully but the rest of what you said holds" — SurfingAlpaca [c:50410732]
> （译文：Claude 现在已经完整支持 AGENTS.md 了，但你其余的批评仍然成立。）

### 四、订阅能不能带出门

这是全帖最实际的一层：如果你换 harness，原来的订阅还认不认。

> "Using your subscription in 3rd party tools is explicitly allowed for Codex, and disallowed but not really enforced for Claude. There are extensions for Pi that allow you to log in with your Claude credentials, Codex is iirc even built-in." — PufPufPuf [c:50410923]
> （译文：在第三方工具里使用订阅，Codex 是明确允许的；Claude 是不允许，但也没真强制执行。Pi 有扩展可以让你用 Claude 凭据登录，Codex 那边我印象中是内置的。）

理由在另一个帖子里说得很直白：

> "Anthropic only authorizes their own Claude code to be used with a subsidized subscription.<p>They want you to use and get accustomed to only their own tools. If other coding harnesses were allowed, it&#x27;s far too easy to switch providers." — smashed [c:50316381] [thread 3]
> （译文：Anthropic 只授权自家的 Claude Code 使用补贴订阅。他们要你习惯只用他们自己的工具。要是允许别的 coding harness 用，换供应商就太容易了。）

但现实操作层面已经在绕了：

> "Every harness (herdr, paseo, pi, etc) uses claude through the Agent SDK, and this draws from your subscription, not API pricing." — well_ackshually [c:50316415] [thread 3]
> （译文：现在每个 harness（herdr、paseo、pi 等）都是通过 Agent SDK 用 claude 的，这部分走的是你的订阅，不是 API 按量计费。）

三种口径于是并存：规则上，Anthropic 只授权自家 Claude Code 用补贴订阅，第三方要按 API 全价付费，假装成 Claude Code 绕过去会被封号；技术上，godelski 提到任何 harness 都能用订阅，但只能走 `claude -p` 模式，功能受限；现实里，GitHub 上已经有 pi-claude-code、herdr、paseo 这类工具在跑，用 Agent SDK 或 OAuth 登录走订阅额度。well_ackshually 还搬出 Google 把 Claude 塞进 Android Studio 的例子，认为这已经足够说明问题；反方向的说法同样硬——Google 也会因为同样手段封掉整个账号。nsingh2 补了一层概念区分：Agent SDK 跑的就是 Claude Code 那套 harness，如果在 Pi 里再套 Agent SDK，等于用一个 harness 驱动另一个 harness，那正是换 harness 想躲开的东西。

### 五、安全：分类器还是沙箱

换掉 Claude Code 的同时，也换掉了它那套「快速分类器 + auto mode」的护栏。第一个撞上这个缺口的是 giladd：

> "Does Pi come with an auto mode that blocks dangerous actions? It didn&#x27;t last time I checked, and these measures are critical to protect prod (and your personal files, etc) from a confused agent." — giladd [c:50410830]
> （译文：Pi 自带能拦下危险操作的 auto mode 吗？我上次看是没有。这套机制对保护生产环境（以及你的个人文件）很关键，能防一个搞糊涂的 agent 乱来。）

mpern 的方案是反过来做：干脆别信 auto mode，用沙箱包住一切，然后不带检查地跑。

> "Wrap your agent of choice in e.g. docker sandbox, nono.sh, Nvidia OpenShell, microsanbox or any other sandboxing tool and run it without any checks (i.e. &quot;yolo mode&quot;, dangerously-skip-permissions etc.)" — mpern [c:50411345]
> （译文：把你选的 agent 包进 docker sandbox、nono.sh、Nvidia OpenShell、microsandbox 之类的沙箱里，然后不带任何检查地跑（也就是所谓 yolo mode、dangerously-skip-permissions 那一套）。）

giladd 后来自己也搭了沙箱（Bubblewrap 加操作授权流程），但他的结论是这属于把孩子连洗澡水一起泼掉：

> "I did that. Customized Pi to run in Bubblewrap, made an action authorization flow, etc. But that&#x27;s throwing the baby with the bathwater. This gives you a harmless, less capable agent. To get both safety and usefulness, Ant&#x27;s solution of a fast classifier works really well." — giladd [c:50411897]
> （译文：我这么干过。把 Pi 改成跑在 Bubblewrap 里，做了一套操作授权流程。但这是把孩子连洗澡水一起泼了：这样得到的是一个无害但也更弱的 agent。要同时拿到安全和能力，Anthropic 那个快速分类器的方案确实管用。）

pkulak 的立场更干脆：Pi 的整个卖点就是你自己搭，Claude 或 Codex 再叠一层沙箱才叫烦人——所以他把 agent 直接跑在自己的沙箱里。

### 六、Pi 的代价：压缩上下文、内存和手感

> "Pi is awesome until compaction hits. I think one in every two compactions it’s failed on me ie didn’t know how to continue :(" — alfiedotwtf [c:50410706]
> （译文：Pi 挺棒的，直到压缩上下文开始出问题。我感觉每两次压缩就有一次在我这儿失败，它不知道该接着往下做。）

压缩是换 harness 后最常被提起的新问题，esalman 的做法是不指望压缩，而是让 agent 维护一份跨会话的交接文档。也有人给出相反的诊断：多半是模型或 provider 的上下文长度参数没设对，真到了压缩时才把「跑满了」暴露出来。

pi 的拥护者同样有自己的痛点，最常被提到的是可读性和分叉太多：dofm 说 opencode 的源码难读，他更愿意待在 pi 这边，因为后者「没那么拐弯抹角」；segmondy 一句话把关系理清——ohmypi 基于 pi，但它不是 pi。另一条线索来自 bdemirkir：opencode 的 system prompt 比 omp 小不少，小模型反而可能因此吃亏。

内存这笔账在另一个帖子里算得更具体：

> "I already found myself being limited by Memory used by Claude code, about 300MB per session. With 40 sessions that eats up quite a good chunk of my laptop&#x27;s memory" — ithkuil [c:50317284] [thread 3]
> （译文：我自己先撞上了 Claude Code 的内存问题，每个 session 大约 300MB，开 40 个 session 就吃掉笔记本相当可观的一块内存。）

反对的声音同样具体：

> "Are people really fretting over a few MB of memory rather than evaluating these tools on their ergonomics and features?" — eleventen [c:50316717] [thread 3]
> （译文：大家是在为几 MB 的内存纠结，而不是按人体工学和功能来评估这些工具吗？）

这一层的分歧其实不难理解：Prospero 那种做法省下的内存是实打实的，可它的对手方要的是别的——natsucks 的理由和界面有关，理论上 TUI 更简单，他不想依赖第三方把 CLI/MCP 映射到 GUI 的那层实现：

> "Using TUI is also architecturally simpler. I don&#x27;t want to rely upon third-party mappings of the CLI&#x2F;MCP to the GUI, which are potentially incomplete or buggy." — natsucks [c:50317328] [thread 3]
> （译文：TUI 在架构上也更简单。我不想依赖第三方把 CLI/MCP 映射到 GUI 的那层东西，它们可能不完整，也可能有 bug。）

### 七、大家到底在用什么

同一周的 Ask HN 把「谁在用什么」摊开成了一张清单，Pi 的出现频率不低：

> "Mostly Pi, using a variety of models, but mostly GPT 5.6 line of models." — npc99 [c:50367192] [thread 2]
> （译文：主要用 Pi，模型换着用，但多半是 GPT 5.6 这一条线。）

> "Phasing out my usage of cloud based LLMs&#x2F;harnesses.<p>Focus is pi + self hosted GLM Flash.<p>Pi is lightweight and easily extensible and creates minimal extra noise." — dgb23 [c:50367587] [thread 2]
> （译文：我正在逐步停用云端 LLM 和云端 harness，重心是 Pi 加自托管的 GLM Flash。Pi 轻量、容易扩展，产生的多余噪音很少。）

但省事那一派直接用一句话收尾：

> "Claude code is all you need" — saasisdead [c:50367667] [thread 2]
> （译文：有 Claude Code 就够了。）

也有人替「不用折腾」找了个技术理由：

> "I firmly believe that those using out-of-the-box Claude Code or Codex are likely getting the most cutting edge features of agents anyways." — sparklingmango [c:50367466] [thread 2]
> （译文：我一直相信，开箱即用的 Claude Code 或 Codex，反而能拿到 agent 最前沿的那些能力。）

真正被多数人做的事是把订阅拆开用：个人一个 Claude Ultra、工作再一个，Codex 订阅留着当二审；还有人干脆从 CLI 搬到桌面端，因为并行会话一多，终端里的文字墙就顶不住了（sadilek 的做法是自己写 harness，把每个 agent 摊成一张卡片，压缩成气泡式对话，顺手开源了）。当然也有人吐槽整页都是订阅数量的攀比：

> "These comments read like people just bragging about having multiple AI subscriptions but not actually giving any info about what they&#x27;re using them for" — ChrisRR [c:50367618] [thread 2]
> （译文：这些评论读起来就是一群人在晒自己有几个 AI 订阅，根本没说清楚自己拿它们干什么。）

### 八、自己造一个

Prospero 帖里最热的部分不是技术，是「自己动手」这个共识：

> "Many make their own harness today anyway...<p>I did mine as well and that takes 4% the resources of opencode and in a similar tui style.<p>I think it&#x27;s great and everyone should make their own." — keyle [c:50316750] [thread 3]
> （译文：现在很多人本来就在自己写 harness……我也写了一个，资源占用是 opencode 的 4%，形态跟 TUI 类似。我觉得这事挺好，人人都该自己做一个。）

而这个帖子的界面部分干脆分成了两派：

> "Looks like shit and part with professional edition killed me. Bro are we in 2000?" — keepo404 [c:50316083] [thread 3]
> （译文：看起来像坨屎，而且把专业版单独拿出来卖这点直接把我劝退了。老兄，我们还在 2000 年吗？）

> "FIVE megabytes. Wow. What are we <i>doing</i> everywhere else." — jrm4 [c:50317485] [thread 3]
> （译文：五兆字节。哇。别的地方都在干什么啊。）

资源账本身也有人在替它辩护：

> "Typical coding agents of today consume hundreds of MBs of RAM. Once you add GUI into the mix, that could easily slip into GBs." — OleksandrC [c:50316870] [thread 3]
> （译文：今天典型的 coding agent 要吃掉几百 MB 内存，再加上 GUI，很容易就滑到 GB 级。）

于是这个帖子最终的落点，和主帖作者的自嘲几乎是同一件事：harness 是个人化的工具，别人替你做的那个尺寸，永远不会正好合你的手。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 「Anthropic 盯上了」是句反话 | TacticalCoder | 连「舌头在脸颊里」也不是字面意思 |
| 反话也可能是真的 | derektank | Boris 正在征集 Claude Code 推荐 |
| 硅谷的邮件确实管用 | wincy | 抱怨 ChatGPT Pro 的第二天 Altman 就发帖 |
| 244 次发布不可接受 | O_H_E | 四分之三的版本改了 system prompt |
| 改 system prompt 不叫爬坡 | lifeisloving | 那是在控制用户怎么用 LLM |
| 性能宣传跟不上实际 | oblio | 真那么好该是 3MB 二进制 |
| 用不了源码是硬伤 | dannyw | 至少 Codex 那边的 telemetry 是看得见的 |
| AGENTS.md 支持是应该的 | harrisonjackson | 连 skills 都不理的产品才叫蠢 |
| 支持了但缺口还在 | bredren | .agents/skills 至今不支持 |
| 优先级有讲究 | samayashar | CLAUDE.md 优先，没有才回落 AGENTS.md |
| Codex 随便用，Claude 不行 | PufPufPuf | Claude 那条是「不许但没真管」 |
| Anthropic 只授权自家 CLI | smashed | 否则换供应商太容易 |
| 现实里都绕过去了 | well_ackshually | 走 Agent SDK 走的还是订阅额度 |
| 绕过去有封号代价 | mapontosevenths | 假装成 Claude Code 会被封 |
| Pi 没有 auto mode 是缺口 | giladd | 沙箱能自己搭，但 agent 会变弱 |
| 干脆别信 auto mode | mpern | 沙箱里跑 yolo mode 更干净 |
| Pi 的压缩上下文不稳 | alfiedotwtf | 每两次失败一次 |
| 内存账要算 | ithkuil | Claude Code 一个 session 约 300MB |
| 内存不是重点 | eleventen | 该看功能和手感 |
| TUI 架构更简单 | natsucks | 不依赖第三方 CLI 到 GUI 的映射 |
| Pi 已经够用 | npc99 | 主力是 Pi，模型混着用 |
| Claude Code 就够了 | saasisdead | 五个字结束讨论 |
| 原装即前沿 | sparklingmango | 开箱即用反而先拿到新能力 |
| 桌面端正在取代终端 | sadilek | 并行会话一多，文字墙顶不住 |
| 订阅清单只是炫耀 | ChrisRR | 没人说自己拿它们干什么 |
| 该自己写一个 | keyle | 人人都该自己造 harness |
| 界面审美各走各的 | keepo404 / jrm4 | 一个嫌丑，一个嫌老派 |

## 总体情绪

原文的落点其实很克制：作者没有说 Claude Code 不好，他反复说的是「没有方向」——功能在往上贴，配置在被动改动，稳定性和可预期性排在营销后面。评论区则把这份克制拆成了互相独立的八场争论：反话是不是反话，244 次发布算不算失控，AGENTS.md 迟到的责任在谁，订阅能不能带出门，安全该交给分类器还是沙箱，Pi 自己又欠着哪些账，大家到底在用什么，以及干脆自己造一个。

分歧没有被消解，而且每一边的证据都成立。反对方拿的是可数的事实：244 次发布、四分之三改动系统提示、Bash 工具描述近 3000 token、一个 session 约 300MB 内存；支持方拿的是产品逻辑：harness 是你自己的东西，模型厂家的迭代节奏你只能接受，或者用订阅的便利换一份对供应商的锁定。连主帖作者的结论都留着这个尾巴——他说 Anthropic 做出过很酷的软件，换 Pi 的理由只是方向问题，不是这东西不好。

真正没人提出的，是那个最简单的版本：一个开发者决定换一个工具，而工具背后站着一家每次发布都在改写他工作方式的供应商。抱怨可以发 244 次，能换掉的只有自己的键盘。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Goodbye Claude, hello Pi（HN 主帖） | <https://news.ycombinator.com/item?id=50410107> |
| 2 | 原文：Goodbye Claude, Hello Pi（caleb.software） | <https://caleb.software/posts/claude-to-pi.html> |
| 3 | Ask HN: What's your current AI agentic setup?（HN 相关帖 2） | <https://news.ycombinator.com/item?id=50366117> |
| 4 | Prospero: A new coding harness for a more civilized age（HN 相关帖 3） | <https://news.ycombinator.com/item?id=50315226> |
| 5 | 原文：Prospero（nullprogram.com） | <https://nullprogram.com/blog/2026/10/31/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 592 分、382 条评论，归档快照 2026-11-08 19:23 UTC，入库 110 条；相关帖 50366117 入库 151 条；相关帖 50315226 入库 111 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；来自相关帖的引文另标 `[thread 2]`、`[thread 3]`；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于 Claude 订阅在第三方 harness 中的使用限制、Anthropic 与 Google 的封号政策、244 次发布中改动 system prompt 的比例等说法，均来自原文与归档评论引述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
