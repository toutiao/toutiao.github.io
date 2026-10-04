---
layout: post
title: >-
  $10、6 杯健力士和一个 abliterated Qwen：他是如何在 HN 上做出一夜 #1 的讽刺站
date: 2026-10-04
hn_id: 49941114
categories: [articles]
excerpt: >-
  [extrabigassintelligence.com](https://www.extrabigassintelligence.com/) 是一个一夜冲到 HN 榜首的「Geocities 怀旧 + 广告弹窗」讽刺站。事后作者自白：整个站点是 GLM-5.3 在 OpenCode 里用 2 张 RTX 4060ti 边喝边跑出来的。
tagline: >-
  $10 域名、6 杯健力士、一个 abliterated Qwen：HN #1 是这样炼成的。
---
## 原文概要

10 月 3 日凌晨，[extrabigassintelligence.com](https://www.extrabigassintelligence.com/) 凭借荒诞的「超级智能 + 弹窗广告 + 老式 Geocities 视觉」冲上 HN 榜首（456 分）。首页写满了「OW! MY BALLS」「Show me your tits」「Total Genius Award」之类的低智广告词，配合移动的关闭按钮、闪烁跑马灯，以及一个会跟着鼠标跑的开遮阳片。它把整页做成 Idiocracy（《蠢蛋进化论》）式广告地狱，目的是讽刺 AI 巨头们当下「超级智能」叙事的荒唐。

「Extra Big Ass Intelligence」也是一场针对 [Trump 行政命令推动「Super Intelligence」并抢注相关域名](https://www.snopes.com/news/2026/10/01/trump-super-intelligence-order-domain-names/) 的回应——首页里「OW! My Balls」的一句被解读为对 [Sam Altman](https://news.ycombinator.com/item?id=49941456) 那句名梗的引用。

事后，[作者](https://news.ycombinator.com/item?id=49944552) 在评论里给了一个比作品本身更反常的交代：整个站点是他喝着 Guinness 3 到 8 杯、用 [OpenCode](https://opencode.ai/) 里的 GLM-5.3 自动生成的；背后跑的是他自己 PC 上两张 RTX 4060ti 加一个 `qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive`（去审查强化版）。预算合计 $10——只买了域名。250k 请求后冲到榜首那一刻，他坦言服务器差点被压垮，Cloudflare 配额也快用尽。

## 讨论焦点

### $10 的讽刺：从健力士到 OpenCode

[原帖](https://news.ycombinator.com/item?id=49944552) 评论区最炸的，是那位[作者本人](https://news.ycombinator.com/item?id=49944552) 的自白：

> "I had GLM-5.3 in OpenCode make this while I drank Guiness 3 through 8. Then I posted it to HN before bed, thinking a couple other people might get a kick out of it. ~250k requests and a brief stint at #1 later, and I'm amazed that my 2 RTX-4060ti's haven't collapsed under the load. The model is an abliterated version of Qwen3.6 35B running on my PC. (qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive) So anyway, it's just a fun satirical sort of protest directed at the absurdity of it all. No attempts to monetize have been made or will be made. I'm already at 76% of my daily quota for the cloudflare workers, so it won't be around much longer. My budget for this project was the $10 I spent on the domain." — 34679 [c:49944552]

这条自白让评论彻底跑偏成「边喝边写」工程师秀。

socializer 不买账，他觉得「外包荒诞给 LLM」本身就是一种新的荒诞：

> "I find it doubly absurd that we can no longer be bothered to write 1990s style absurdist satire by hand and we outsource the absurdism to an LLM." — socializer [c:49945652]

Kakashi4 则护住了作者：

> "I doubt the author would have made something worth posting (much less something that hit #1) if he had attempted to make this by hand while drinking 6 guinness" — Kakashi4 [c:49945859]

这场 [口角](https://news.ycombinator.com/item?id=49945988) 顺手被 JackFr 终结在一个 HN 式的神吐槽上：

> "Your book doesn't seem very amusing." — JackFr [c:49946121]

Culo[ronavirus](https://news.ycombinator.com/item?id=49946336) 把这场争辩拔到时代高度：「agentic 时代最大的好处，是给重度酒精依赖的能人一个边喝边干活的出口。」

### Idiocracy 早已预言过

[第一位回帖](https://news.ycombinator.com/item?id=49941412) 就把方向钉死了：

> "Welcome to Costco, I love you." — electroglyph [c:49941412]

[第二位](https://news.ycombinator.com/item?id=49941426) 直接拉出电影梗：

> "Say what you will about President Dwayne Elizondo Mountain Dew Herbert Camacho -- at least he cared about the well-being of his country and sought out expert guidance to set things right." — Jordan-117 [c:49941426]

[pessimizer 在最离谱的细分处](https://news.ycombinator.com/item?id=49944795) 提醒大家「Idiocracy 不是预言，是乐观主义」：

> "That feeling when you realize Idiocracy wasn't prophetic, it was <i>optimistic</i>. (Omg I'm even talking like one now.)" — psvv [c:49944472]

`sellmesoap` 顺势提名 Mike Judge 为现代先知：

> "I nominate Mike Judge as a modern day prophet!" — sellmesoap [c:49942027]

ur-whale 用 Idiocracy 里那句被反复引用的台词作结，让整场讨论在一个精确的节奏点上收束：

> "A true fan of the movie would have remembered the following quote: 'money? ... [thinks hard for a couple of seconds and then remembers] ... I like money!'" — ur-whale [c:49945578]

### 当「AI 味儿」变成一种风格

[LLM 风格的视觉](https://news.ycombinator.com/item?id=49941514) 是这场讨论的另一条线。torginus 第一个点出讽刺点：

> "While HTML4 geocities style website have a soft stop in my heart, this page absolutely feels like it was made by an LLM which makes it ironic in a way it was never intended to be I assume." — torginus [c:49941514]

archievillain 把这种现象描述成 LLM 的视觉指纹：

> "I genuinely have never seen these stupid bordered bubbles with gradient backgrounds and emojis-for-icons before LLMs, why are they obsessed with them? How did they get into the dataset???" — archievillain [c:49943044]

pessimizer 用一长段牢骚把「数据集」「em-dash 段落」「以 emoji 之别带小标题的『The meat of the issue』」一一拆穿——这是 HN 长期争议的 LLM 输出标志：

> "These were chosen manually, by committee. It's as natural as bootstrap. I love the "dataset" guys. "The reason there are so many em-dashes is because they were trained on the work of great writers, and people <i>frequently</i> used em-dashes before AI. I certainly did!" 1) You didn't.* 2) So explain all of the sections starting with emojis. Did all of the great writers have a section called "The meat of the issue" with an emoji of meat? Why did they go away? Are you starting to suspect that this doesn't work like you think it does?" — pessimizer [c:49944795]

embedding-shape 给出更技术化的批评：

> "Yeah, somehow whoever (or whatever) decided to build this, decided to use Tailwind for something that absolutely doesn't need a CSS library/framework, it'd be what, ~30 CSS rules to write? :P LLMs truly is the kings of bloat as it stands right now." — embedding-shape [c:49942992]

但 linguae 提醒，并不是所有「看起来 slop 的东西」就一定是 slop：

> "Amazingly, this doesn't look like slop to me, unlike the slop articles and images I'm flooded with on the Web these days. The world of Idiocracy actually had some taste, unlike the timeline we're on today." — linguae [c:49941736]

viccis 用一句经典广告梗接话：

> "If it doesn't look like slop to you, I might have some electrolytes to sell you for your plants." — viccis [c:49941742]

### 「OW! My Balls」是一条隐线

[walrus01](https://news.ycombinator.com/item?id=49941456) 把站里反复出现的「OW! My Balls」与 Sam Altman 的那个梗作了对照：

> "OW! My balls! Brought to you by OpenAI (OpenSI?) dots You know with enough compute and video generation resources now, you probably could make an entirely AI-slop 24x7 streaming channel of OW! My balls! BaAs - Balls as a service." — walrus01 [c:49941456]

nxobject 顺势「护盘」一个域名：

> "Shoot - time to squat opensi.com!" — nxobject [c:49945590]

[lwansbrough](https://news.ycombinator.com/item?id=49942117) 把这条线接到更具体的政治背景：

> "He may have promoted Super Intelligence as part of a domain squatting scheme for his buddies." — lwansbrough [c:49942117]

jpster 把这句话接到一个看起来无关的拼图上：

> "The in-demand domains are Slovenian, just like the First Lady. What a funny coincidence!" — jpster [c:49942206]

defrost 接了一个文化梗：「Laibach boosters strike again!」（[Laibach](https://en.wikipedia.org/wiki/Laibach_(band)) 是斯洛文尼亚乐队，长期以政治戏仿闻名。）

这条支线说明：HN 用户对这个站的解读不只是「LLM 写出来的乐子」，更是当下「super intelligence」叙事与 Trump 行政命令抢注域名风潮的集体照妖镜。

### 广告弹窗的真实性

站里最被讨论的细节之一，是那个跟着鼠标跑的「关闭 X」按钮。o4c 给出了最具体的使用体验：

> "The funniest thing about the design is when I click the 'X' on ads to see if they close, but the button keeps moving. I feel like I'm literally chasing it like a mouse, I was laughing straight out :)). A correct depiction of the modern ad system." — o4c [c:49942219]

zzgo 顺手补一刀真实经验：

> "I was reported to Child Protective Services for closing an ad. :(" — zzgo [c:49942237]

trwired 提醒这不是新发明：

> "That was actually a thing back in the late 90s. There were ad popups that would do that, so the user couldn't close them." — trwired [c:49942986]

### 关于「OpenSI」的遗憾

[api](https://news.ycombinator.com/item?id=49945216) 给这场闹剧加了一个未实现的剧本：

> "I'm kinda surprised we are not mandated to call it America Intelligence. The initials would still be AI! I'm personally still bummed basilisk.ai was taken. Looked for it as soon as I heard about that silly thing. Was going to make a Geocities style "shrine to Roko's Basilisk."" — api [c:49945216]

Alive-in-2025 用预言家的语气回应：

> "That's a terrible suggestion that will no doubt be what happens" — Alive-in-2025 [c:49946123]

### 时代的新规律

[simpaticoder](https://news.ycombinator.com/item?id=49946516) 用一句话总结整场讨论的隐线：

> "Sturgeon's law will need to be revised in the AI age." — simpaticoder [c:49946516]

Sturgeon 定律原本是「90% 的东西都是垃圾」。在 LLM 把「制造内容」的边际成本拉低到接近 0 的时代，这个百分比还需要重新校准。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 作者自白 | 34679 | GLM-5.3 + 2 张 4060ti + 6 杯 Guinness，$10 域名换来 250k 请求和 #1 |
| 反 AI 生成讽刺 | socializer | 把荒诞外包给 LLM 本身是新的荒诞 |
| 护作者 | Kakashi4 | 边喝 6 杯手写写不出能上 #1 的东西 |
| 一句话终结辩论 | JackFr | Your book doesn't seem very amusing |
| Idiocracy 警告 | electroglyph | Welcome to Costco, I love you |
| Mike Judge 是先知 | sellmesoap | 提名 Mike Judge 为现代先知 |
| 视觉 LLM 指纹 | archievillain | 边框气泡+渐变+emoji 是 LLM 标志 |
| 反 dataset 辩护 | pessimizer | 这不是「数据集」自然演化，是人手选的委员会风格 |
| Slop 还是 taste | linguae | 这站不像 slop，反而 Idiocracy 时代还有点品味 |
| 广告 X 按钮 | o4c | 真的在追那个 X，笑了，这是现代广告的真实写照 |
| Trump 域名抢注 | lwansbrough | 这只是 Trump 那场 super intelligence 域名抢注风潮的一环 |
| 时代定律 | simpaticoder | Sturgeon 定律在 AI 时代需要重写 |

## 总体情绪

讨论的真正分歧不在「这个站好不好笑」——几乎所有回帖者都被逗乐了；分歧在「它是不是该手写出来」以及「它在评论什么」。

乐观的解读是：作者一人、两张消费级显卡、一个 abliterated 开源权重模型和一晚上就把一个讽刺作品推上 HN 榜首，这本身是 agentic 时代的具象证明。悲观的解读是：当讽刺本身也被 LLM 量产，讽刺作为文化批评的力气就开始被稀释——Sturgeon's law 会被改写不是玩笑。

讨论里反复回到 Mike Judge 和 Idiocracy，不是怀旧，而是用一个被时间验证过的「未来」去对照正在发生的「未来」。`Welcome to Costco, I love you` 和 `I like money!` 这两句台词本身就是那种讽刺的终态——当整个互联网都被「super intelligence」命名抢注、被 abliterated Qwen 跑出来的 Geocities 风格讽刺站占领，HN 用户最后引用的是 2006 年那部电影里的台词。

$10 域名，6 杯健力士，一个 abliterated Qwen——HN 的 #1 是这么炼成的，也是这么被解构的。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 主 | Extra Big Ass Intelligence | https://news.ycombinator.com/item?id=49941114 |

<div class="disclaimer">
本摘要由 AI 模型辅助生成，仅根据公开 HN 评论反映讨论脉络；不代表原作者及 HN 用户立场。引文为 HN 用户公开发布的内容（CC BY-SA 3.0 / HN Terms）。摘要中涉及的所有链接、产品名与品牌归各自所有者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>