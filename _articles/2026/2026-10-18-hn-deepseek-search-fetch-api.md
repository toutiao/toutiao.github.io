---
layout: post
title: >-
  DeepSeek 搜索/抓取 API: 0.75 美元/千次 — HN 讨论
date: 2026-10-18
hn_id: 50138531
categories: [articles]
excerpt: >-
  DeepSeek 把搜索/抓取 API 打到 0.75 美元/千次，比 Exa、Brave、Kagi 都低一个数量级；HN 在 Anthropic IPO 前夕吵成一锅——定价战、反爬虫战、开源资本主义之战同时开打。
tagline: >-
  别人卖 12 美元/千次的接口，DeepSeek 卖 0.75 美元。
---
## 原文概要

[HN 热门榜](/best) 来源. 273 分，5 小时内前为主流的 123 条评论，原帖作者 [fagnerbrack](https://news.ycombinator.com/user?id=fagnerbrack)。

DeepSeek 上线 **Search API** + **Fetch API** 两个新接口，统一挂在 `https://api.deepseek.com/v1/tools/...`，复用与 DeepSeek 主 API 一样的 Bearer 鉴权。

- **Search API**：`POST /v1/tools/search`，由 DeepSeek 自有索引驱动，返回 `rerank_score`（0-3）、`title` / `url` / `snippet`（UI 用，约 100-200 字符）/ `summary`（模型读，约 600-800 字符）/ `content`（当 `need_content=true`）/ `site_name` / `site_icon` / `date`（RFC 3339 UTC）/ `authority`（0-4，>=3 为高权威源）。支持 `site:`、`-site:`、`-`、`-"..."`、`"..."`、`lang:`、`after:`、`before:` 等运算符，`count` 默认 10，上限 50；`query` 与 `ori_question` 上限均为 128 字符。
- **Fetch API**：`POST /v1/tools/fetch`，接 URL 返回 Markdown。URL 长度上限 8192 字符，禁带 username / password。文档明示"取回受目标站点可用性与访问策略影响"。

**定价：0.75 美元 / 1000 次成功请求。** 错误格式与 OpenAI 兼容，`param` 恒为 `null`。

文档：[Search & Fetch | DeepSeek API Docs](https://api-docs.deepseek.com/guides/search/)。

## 讨论焦点

### 价格断崖式碾压

HN 第一反应是把 DeepSeek 的 0.75 美元丢进同价档对比。结论非常一致：DeepSeek 不是"略便宜"，是直接改写价格档位。

> "$4 with Exa, $1.50 with SERP API" — ece [c:50139006]

> "For comparison, Kagi charges $12 per 1000 searches (only talking about their API pricing, like you'd use with an LLM; their $10/mo plan has unlimited searches but it's a TOS violation to use those credentials with an LLM)." — frenchtoast8 [c:50138783]

> "As reference point exa charges 4 bucks" — Havoc [c:50138773]

> "Mojeek is £ 2 per thousand. They have their own index (not a SERP), but subjectively pretty close to Google (I prefer it to Bing/DDG)." — stncls [c:50139427]

> "Ceramic.ai is $0.25/1000 searches. I've been using it as an MCP in OpenCode and it seems adequate. I don't see many people talk about it, and I have not benchmarked it against Exa/Tavilly." — wmchen [c:50139351]

> "$1 for LinkUp fetch, $5 for LinkUp search." — hobofan [c:50139416]

0.25 / 0.75 / 1.50 / 4 / 5 / 12 美元横跨两个数量级，DeepSeek 稳稳坐在第二档（仅次于更小众的 Ceramic.ai 与 Mojeek），但 Ceramic/Mojeek 都没有自带 LLM 推理；DeepSeek 把检索端和模型端都握在手里。便宜不只是噱头，是用 P99 / Pro 价格朝 P99 / Pro 玩家贴脸打。

### 反爬虫战：bot 是 user agent 还是入侵者

第一个被翻开的话题是反爬。讨论迅速从 DeepSeek 是否会被 Cloudflare / Anubis 拦截，烧到 Claude / ChatGPT 绕过反爬的伦理争议。

> "From what I've seen, when operating in an environment with bash tools, Claude and ChatGPT will react to a site blocking their normal, attributed fetch tool by calling curl or writing a python script with a different user agent to try and bypass the blocks, rather than respecting the site owners' wishes. It'd be one thing if they required the user to consciously say \"yes, I want you to bypass the block\" (still unethical), but the fact that it's just default behavior really says something about the service design alignment." — bulder [c:50139303]

> "It’s not exactly recent or a reveal, but I’ve caught at least several OAI models writing Python scripts to access web pages." — amluto [c:50139210]

> "I have noticed that agents become extremely creative to fulfill any non refused requests. And then instructions become more of a suggestions." — ReptileMan [c:50139861]

另一边则把 bot 视为 user agent 的延续：

> "Claude and ChatGPT are user agents. For obvious reasons, they serve the user, not the websites' owners. (Also, if you don't want people to be able to access some information, then don't put it online.)" — gvfsa [c:50139588]

> "Chrome and Firefox aren't people either." — gvfsa [c:50139750]

> "I use the automated captcha solvers, stealth browsers, proxy IPs and so on. In regard to ethics, I think this is the right thing to do. [...] So the point about the bots is that I think people should be empowered to protect themselves from the internet, which is otherwise actively harmful to their wellbeing." — lukewarm707 [c:50139934]

讨论往下延伸到运维侧：bot 工程化绕反爬是有真实代价的。

> "I've spent a lot of time building datamint.xyz, and dealing with user agents, datacenter IPs, and VPNs gets pretty tricky. What works right now is a fork of the latest Firefox with anti-fingerprinting patches, paired with a high-quality residential proxy network with clean IPs. Even the basic setup needs 11+ code-level patches, and there are still a few edge cases, but this setup should cover 99% of cases." — m00dy [c:50138787]

tyre 把球抛回 DeepSeek：自家索引意味着缓存命中后只爬一次，每隔数小时才回访，对站点方是相对温和的爬取节奏。

> "One reason (not the only one!) people use Anubis is to prevent the endless flood of requests from AI companies. If Deepseek scrapes once every few hours, that helps the website owner with the traffic problem while allowing access." — tyre [c:50138791]

### DeepSeek Flash 的真实水位

dsco 顺手提的旁支论点被拉成单独战场：DeepSeek Flash 是否已经跟 SOTA 并肩？

> "DeepSeek Flash really came at a bad time before the Anthropic IPO. I use this thing daily and it's neck and neck with SOTA models. The search is one of the things setting it apart." — dsco [c:50138720]

> "It's really not neck and neck with Opus 5.5." — redox99 [c:50138729]

> "If it depends on your use case then it's not neck and neck…" — gvfsa [c:50138994]

> "Cost-adjusted, it might be ahead. It's key to name the boundary conditions. Unlimited cost is a very HN assumption." — lejalv [c:50139117]

最犀利的一句：

> "True, it isn't neck-and-neck. It's neck and balls. Deepseek's balls and Opus 5.5's neck. Whatever you can build with Opus 5.5, I can build in the same time, 1/500th the price with Deepseek Flash 4.1." — Rodmine [c:50140079]

关于 vibe coding 边界：

> "With Opus 5.5 you can vibe code a whole app without reading the code at all. Obviously you still have to tell it what to make. With earlier models that doesn't really work. You really have to read the code and watch it like a hawk or it will make a big mess. To put it another way, with lesser models you have to guide them at a code level. With Opus 5.5 you only have to guide them at an architectural / feature level." — IshKebab [c:50139259]

### 时机：Anthropic IPO 前的 DeepSeek 牌

dsco 那一行"bad time before the Anthropic IPO"直接打开了地缘/资本战线。

> "If Anthropic or OpenAI fails, the other wins the US market, no? I'm oversimplifying but…that's a pretty realistic possibility in the face of people thinking sinking one US AI company would hurt the greater US venture into AI." — jimbob45 [c:50138871]

> "I am of the opinion that they both either succeed or they both fail. They are both losing money hand over fist and their model quality is pretty close to each other. There is not a whole lot that sets them apart." — cheema33 [c:50138922]

> "If they did then Google would take over, and others would form from their competent engineers. Also, they don't need to be profitable to succeed, they merely need to hype investors enough to ensure that their losses matter less than their growth projections." — tourmalinetaco [c:50138926]

> "I wonder if Google won't end up the last man standing in the end in the west, after Anthropic that they have a major investment and partnership with, and OpenAI crumble under their large financial burdens; while Google has a far deeper actual cash pockets, more diversified, broader and deeper bench in all related matters on top of the massive name recognition and… even if a bit brittle… a 'community' of users through Gmail, Google.com, Google workspaces, etc. not to mention the TPU space and their quantum breakthrough." — tyrabound [c:50140367]

vrganj 走得更远，把这条帖拉进地缘叙事：

> "What if all of them fail because the capitalist model of centralization followed by rent-seeking gets foiled by an open alternative? That is explicitly the Chinese strategy. Now, what if the largest capitalist economy went all-in on an AI that might no longer be sufficiently monetizable?" — vrganj [c:50138984]

> "They wouldn't give away R&D for free, they would give it away to destroy the capitalist mode of production, as outlined above. If that isn't a worthy goal from China's perspective, then I don't know what would be. China isn't the US. They don't share the same ideology, strategy or conclusions." — vrganj [c:50139723]

也有人泼冷水：成本与可持续性不是神话能解决的。

> "The deepseek philosophy has always been to make a small profit or not do it at all. I suspect they have spent months building caching infrastructure and designing intelligent fetch algorithms to get down to this number. Or... CCP gave them a big pile of money to run this as a front for an intelligence operation. Honestly, who knows." — throwa356262 [c:50139600]

### 隐私 vs 日志

行业把"不记日志"切成两类：免费档几乎都记，付费档按需声明。

> "\"Usage records — which endpoint was called, when, the credit cost, the status, and the target URL.\" I would use it, but then the privacy policy says that you would store my search history. I simply want to use the internet in peace without being constantly recorded." — lukewarm707 [c:50139993]

lukewarm707 直接给了全景清单：

> "Firecrawl: logs. Parallel: logs. Bright data: logs. Kagi: logs for abuse. Bocha, querit etc: logs logs logs. Cloudflare: doesn't say what they do. Exa: charge for no retention. Linkup: no retention on request. Brave: no retention on request, but actually approved it (win for brave)." — lukewarm707 [c:50140183]

### 创作者补偿真空

0-bad-sectors 把话题拉到最后一层：被爬的网站拿不到一分钱。

> "Will DeepSeek pay the content creators whom pages were fetched?" — 0-bad-sectors [c:50139266]

> "I am not a service provider. I am a site visitor that would be monetized through ads or other means" — 0-bad-sectors [c:50139625]

ranguna 的反问击中的是整个 agent 时代的结构性问题：

> "Do you?" — ranguna [c:50139396]

没有 Google 那种"搜索 → 点过去 → 看广告 → 创作者收钱"的回环，fetch 类 API 不存在等价机制。0.75 美元里没有任何一分钱流向被取回的页面。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 价格革命 | ece | Exa $4 / SERP API $1.50，DeepSeek 直接把同档往下打 |
| 价格革命 | frenchtoast8 | Kagi $12/千次，同样的接入成本天差地别 |
| 替代选项 | wmchen | Ceramic.ai $0.25/千次，足够撑 MCP 用 |
| 替代选项 | stncls | Mojeek 自有索引，主观接近 Google |
| 替代选项 | hobofan | LinkUp fetch $1 / search $5 |
| 爬虫伦理 | bulder | Claude/ChatGPT 默认用 curl/Python 换 UA 绕反爬 |
| 爬虫伦理 | amluto | 多次抓到 OAI 模型写 Python 取页 |
| 爬虫伦理 | gvfsa | bot 是 user agent，服务用户不服务站点 |
| 爬虫伦理 | lukewarm707 | 用 bot 是为了保护自己免被定向广告剥削 |
| 爬虫伦理 | tyre | 自有索引意味着每隔数小时才爬一次，对站点温和 |
| 实力定位 | dsco | DeepSeek Flash 已经跟 SOTA 并肩，时机对 Anthropic 致命 |
| 实力定位 | Rodmine | 1/500 的价格搭出跟 Opus 5.5 一样的东西 |
| 实力定位 | lejalv | 性价比视角下它可能已经领先 |
| 实力定位 | IshKebab | Opus 5.5 才能 vibe code 整个 app，你得告诉它做什么 |
| 行业前景 | jimbob45 | 两家头部你死我活，另一家接管美国市场 |
| 行业前景 | cheema33 | 两家要么一起活要么一起死，区别不大 |
| 行业前景 | tyrabound | Google 是西方最后的站立者 |
| 行业前景 | vrganj | 中国开源战略是定向打击资本主义生产方式 |
| 行业前景 | throwa356262 | 0.75 要么是极致工程，要么是 CCP 暗中补贴 |
| 隐私 | lukewarm707 | 全员都在记日志，Brave/Exa/Linkup 才有零保留 |
| 创作者补偿 | 0-bad-sectors | DeepSeek 会付钱给被爬的网站吗？ |
| 创作者补偿 | ranguna | 反问：你付钱给你访问的网站了吗？ |

## 总体情绪

讨论大致分裂成三股。

第一股是定价党：$0.75 / 千次足够让做 agent 的开发者重新评估 LLM-driven retrieval 的成本结构。同档的 Exa 4 美元、Brave 5 美元、Kagi 12 美元突然都显得过时。Havoc 之类做 MCP 的人直接表态："我把多个服务 dedup 在一起，免费档的额度对普通 agent 用已经够。"

第二股是爬虫伦理党：DeepSeek 文档对反爬问题没表态，但整条线程因为 Anthropic / OpenAI 的"默认绕过"被引爆。从 bot 是不是 user agent，到 stealth Firefox + 住宅代理的工业链路，再到 Anubis / Cloudflare 为谁而设——HN 把整条战线都翻了一遍。

第三股是地缘资本党：dsco 一句"bad time before the Anthropic IPO" 立刻让讨论滑向"两强格局会不会一起塌"。vrganj 把 0.75 美元读成"开源作为武器"；tyrabound 押 Google 是西方最后站立者；throwa356262 反讽一句"要么极致工程，要么 CCP 暗中补贴"——把无法证伪的两端并列。

结尾点睛是 vrganj 的反问：当中国选择"以开源为武器"时，西方公司是否只能用季度财报作答。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | DeepSeek search and fetch – $0.75 per 1000 successful requests | <https://news.ycombinator.com/item?id=50138531> |
| 2 | Search & Fetch \| DeepSeek API Docs | <https://api-docs.deepseek.com/guides/search/> |

## 免责声明

<div class="disclaimer">

本文为 HN 讨论摘要，引用评论仅代表原作者个人观点。引文为英文原文 + 中文译文，翻译不增删立场。文中触及地缘政治、爬虫伦理等议题，仅作讨论梳理，不代表本刊立场。

⚠️ **审核建议**：本文包含多处涉及 China / CCP / Open-source-as-strategy 的引文，建议发布前人工复核。

<br><br>

<em>本摘要由 AI 模型辅助生成：MiniMax-M3（opencode）</em>
</div>