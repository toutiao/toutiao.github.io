---
layout: post
title: >-
  Gemini 4 Argon 上线：模型强，发布烂
date: 2026-10-14
hn_id: 50073879
categories: [articles]
excerpt: >-
  740 分贴里，Chrome 40M 行代码几周拆完，Opus 5.5 被嫌卖弄——订阅却找不到入口。
tagline: >-
  Argon 让 Chrome 团队几个月干完多年的活，Google 让你连订阅都付不了。
---

## 原文概要

主帖来自 Google DeepMind 官方页面 [deepmind.google/models/gemini](https://deepmind.google/models/gemini/)，标题「Gemini 4 Argon」，由 [737max](https://news.ycombinator.com/user?id=737max) 在 HN 热门榜首发，4 小时内冲到 **740 分**、**593 条评论**。Slogan 只有一句英文：「Our next era of frontier intelligence, built to solve your hardest problems」。发布页给出的「真家伙」按场景分类：

**长周期工程**。Chrome 团队用 Argon 把 4000 万行代码库里那块 600 万行的遗留「browser features」文件夹解耦，「把几个月的活压到几周内完成」。Agent Development Kit（一个 Python agent 框架）项目里，Argon 通宵改了一晚，把内存里的 session 准备时间砍掉 40%、冷启动导入提速 21%。开源量子化学包 [xTB](https://github.com/grimme-lab/xtb) 用 Argon 重写后，分子结构预测 **2.3 倍**加速、构象搜索 **1.8 倍**加速，patch 已经合入上游 main。

**Gemma 推理性能**。Argon 在 Antigravity 平台基于 vLLM + A100，给 Gemma 4 E2B 做了一轮端到端推理优化：从 **37,900 token/s 推到 108,000+ token/s**，**2.85 倍**加速，零质量损失。

**量子 + 科研**。Argon 把 AlphaQubit 量子纠错解码器的一个内部版本改写成单一优化内核，「推理吞吐接近翻倍」；量子子程序 arcsin 的实现借助 Lean 形式化验证，「相比公开量子 CORDIC 基线，时空成本砍掉 100 倍以上」。机器人方向，Argon 仅靠一段人类玩投沙袋的视频，反推出坐标、写出仿真代码，最终在 [Apptronik Apollo](https://apptronik.com/) 人形机器人上 **连中 7 个目标**。

**基准对比**。DeepMind 把对手写成 GPT-6 Astra、Claude Fable 5.1、Claude Opus 5.5 三家，列了一张长表。Argon 在 **Vals Index 68.9%**（Fable 65.8%、Opus 67.0%）、**Harvey Legal Agent Benchmark 19.6%**（领先第二名 3 倍多）、**DeepSWE 77.9%**、**CWE-bench 68%**（与 Astra 并列 #1）、**LVBench 91.7%**、**GraphWalks long context 99.7%** 等多维度领先；但在 **FrontierSWE 2**（55.0% 对 Astra 65.5%）和 **Terminal-Bench Science 0.1**（57.6% 对 Astra 68.1%）这种「动手跑代码 + 科研」环节，Astra 反超。

**输出窗口 1M token**，官方直接画了一张「100K+ token 推理轨迹 + 完整数学证明 + 完整计算物理求解器一气呵成」的图。

**订阅路径**。今日开放给 Google AI **Pro** 和 **Ultra** 订阅者，三扇门分别叫 Gemini App、AI Studio、Antigravity。Antigravity 是 Google 的 agent 开发平台，对标 Codex 或 Claude Code。

## 讨论焦点

### 模型体验：Argon 写得像「短论文」，Opus 是「卖弄聪明的博士生」

> "I haven't tried it for coding yet, but I ran a couple of my recent curiosity driven queries from Claude (mostly used Fable and Opus 5.5) through it. This is a clear step change, I'm genuinely amazed. Its answers are to-the-point, logically structured, clearly written. Like a really well made mini essay on your question." — svara [c:50077620]
> （译文：「我还没用它写代码，但我把最近在 Claude 上跑的几个好奇心向问题（主要用 Fable 和 Opus 5.5）丢进去试。结果是跨级别的提升，我真心惊艳。回答直击要点、逻辑清晰、文字漂亮，像你那个问题被写成了篇精品小论文。」）

> "I've been using it for a while internally at Google. I prefer Argon over Opus 5.5 because of the clear thinking and directness. It phrases things in an organized, straightforward way." — asdfman123 [c:50075802]
> （译文：「我在 Google 内部用了 Argon 一阵子了。我更喜欢 Argon 不喜欢 Opus 5.5，因为前者想得清楚、说得直接，组织方式和行文都很直白。」）

> "I feel Argon is about as good as Opus 5.5 but I find Opus annoyingly sarcastic and incomprehensible. I know it's a matter of personal taste but it reminds me of a grad student that tries to sound smarter than he is by being dismissive and opaque." — asdfman123 [c:50076854]
> （译文：「我觉得 Argon 大体跟 Opus 5.5 持平，但 Opus 让我烦躁的是那股冷嘲热讽、让人看不懂的味道。我知道这是口味问题，但它让我想起那种装作比你懂的、用含糊和轻蔑来让你觉得自己菜的研究生。」）

svara 从外部、asdfman123 从内部，两条独立的线撞到了同一个点上：Opus 5.5 爱装、行话重、给 hint 不给答案；Argon 反过来直接、干净、写得像「用心写的小短文」。在 [c:50077912] 和 [c:50078203] 的回帖里，A_D_E_P_T、holaysuns 进一步补充：Argon 是「新的通用/非编程首选」，Google 的通用查询能力一向被低估，只是「硬任务掉链子」的刻板印象挡住了口碑。

不过也有人反向警告（[c:50074330]）：「不间断猛干」的训练路线未必是真正的智能突破，更像「越来越会用蛮力把任务砸穿」。这部分质疑在表里单列。

### 发布灾难：付费墙、容量、UX 三连击

> "Announced the model two weeks ago to a ton of hype, model was unavailable for anyone to try. On twitter, Google folks went on a great run taking shots at Muse ('Muse who?'). The hype died down bc nobody could touch the models and meta/muse came out with a similarly capable model in the meanwhile. At the same time, OpenAI had a disastrous dev day that led a lot of users to jump ship to Claude. Couple weeks later, Gemini-4-argon is still unavailable on anything less than the ultra tier, which means there's no natural funnel to get ppl to pay for the more expensive ultra plan other than 'trust us the model is good'. If Google had argon broadly available earlier this month they would have picked up a ton of new users." — postalcoder [c:50074522]
> （译文：「两周前高调发布、根本没让人试用。那段时间 Google 的人在 Twitter 上猛踩 Muse（'Muse 谁啊？'），结果热度还没散，因为没人摸得到模型，Meta/Muse 已经端出了同等档位的竞品。同时 OpenAI 那场灾难性的 dev day 把一堆用户赶去了 Claude。两周过去，Gemini-4-Argon 在 Ultra 之下依然不可用——除了'信我们这模型好'，没有任何理由让人愿意花更多钱去升 Ultra。Google 要是一个月前就把 Argon 大面积铺开，能抢到一大波新用户。」）

> "Not available for AI Pro subscribers in Antigravity. What a disappointment. Google...why. You keep getting so close but constantly fumble at the last moment. I can use Opus 5.5 and Sol/Astra on the $20 Anthropic and OpenAI plans. You are already playing from behind. You need to GET YOUR MODELS INTO MORE PEOPLES HANDS by any means possible." — dcchambers [c:50075394]
> （译文：「Pro 订阅在 Antigravity 里压根就用不了。失望。Google……为什么。你每次都离终点就差一步，然后在最后那一刻掉链子。$20 的 Anthropic 和 OpenAI 套餐就能用 Opus 5.5 和 Sol/Astra，你本来就落后，必须用一切手段把模型塞进更多人手里。继续让用户用你的产品这么难，对你没好处。」）

> "I just created a Google account, which was a hassle. I tried to find an app and found AI Studio, but I'm not sure what that is. Then I found Antigravity, which apparently is Google's alternative to Codex, and I installed it. Then I tried to buy the small Gemini AI Ultra package, but it didn't let me pay. It accepted neither my credit card nor my PayPal account." — I_am_tiberius [c:50075927]
> （译文：「我刚注册了一个 Google 账号，光这就够烦了。我想去下个 app，找到 AI Studio，但我也不知道这是什么。然后我找到了 Antigravity，似乎是 Google 对标 Codex 的东西，装上了。接下来我想买那个入门 Gemini AI Ultra 套餐，结果付款不让过——信用卡不收，PayPal 也不收。」）

postalcoder 算时间账：2 周前高调宣布 → 让 OpenAI dev day 把流量抢走 → 这周终于开放，结果 Pro 订户在 Antigravity 里依然看不到入口。dcchambers 的「在 $20 这一档你能用 Opus 5.5 和 Sol/Astra」是最强反衬。I_am_tiberius 那边更具体：新用户连注册、找入口、付款三关都过不去——评论里 [c:50077554] bluerooibos 紧接着列了三个入口名「Gemini / AI Studio / Antigravity」，非 Google 用户根本看不懂这三者啥区别。

### 价格陷阱：$2 入门价 6 周后悄悄翻倍

> "Couldn't you just say what the price will be after the introductory period and when it'll take effect? Do they have some SKILL.md for these blog posts that requires the most important information to always be buried ten levels deep and hidden behind a login page?" — damsta [c:50074155]
> （译文：「就不能老老实实写清楚介绍期结束之后的价格是多少、什么时候生效？这些博客文章是不是有个 SKILL.md，强制把最重要的信息埋到十层以下、藏在登录页后面？」）

> "They're doubling the price on December 1st: $2/million input and $10/million output today. $4/$20 after December 1st." — simonw [c:50074268]
> （译文：「12 月 1 日起价格翻倍：现在 $2/M 输入、$10/M 输出；之后 $4 / $20。」）

> "I've kinda stopped looking at token pricing. Argon might be the same token pricing as Sol, but in Artificial Analysis' testing, Argon costs 5.8x more to run their coding tasks and 2.2x more for their general index. Likewise, you look at Artificial Analysis' general index and it cost $8,708 to run with Opus and $2,407 to run with Argon so even if Argon's token price doubles, it won't be the same price as Opus. Sonnet is cheaper than Opus per-token, but in their coding tests Sonnet burns through enough tokens that it's 7.5% more expensive." — mdasen [c:50075460]
> （译文：「我基本已经不盯 token 单价了。Argon 跟 Sol 牌价一样，但 Artificial Analysis 实测跑同样的编码任务，Argon 比 Sol 贵 5.8 倍，通用任务贵 2.2 倍。同一个基准跑 Opus 要 $8,708、跑 Argon 只要 $2,407——即便 Argon 12 月翻倍，也不会跟 Opus 真的同价。Sonnet token 单价比 Opus 便宜，但编码测试里它消耗的 token 多出 7.5%，反而更贵。」）

damsta 一句话定调——价格藏在登录页后；simonw 把 hidden pricing 翻到底。「双倍价」单独看不可怕，可怕的是它出现在一个已经因为「12 月 1 日介绍期结束」被频繁质疑的窗口里。mdasen 算的总账更难听：按「完成任务成本」算，Argon 比 Opus 便宜；但按「token 单价」算，介绍价结束后直接翻倍。两个真相同时存在，对外只会挑一个报。

### 内部 vs 外部的体验撕裂

> "I don't understand why people don't like our models but we can't get our act together on the products they use those models in" — BoorishBears [c:50076997]
> （译文：「我不明白为什么大家不喜欢我们的模型，但我们就是不能把装着这些模型的产品整明白。」）

> "'Across Google', wonder how much that is because of an effort by Google to curb usage of Anthropic models. MSFT and Meta similarly are pushing for in-house models. It doesn't mean the models are better when you push your engineers to dogfood and restrict access to other LLMs." — Insanity [c:50074124]
> （译文：「'Across Google' 这个表述，有多少是因为 Google 在推自家模型、限制员工用 Anthropic？MSFT 和 Meta 也是同款打法。强推内部 dogfood 不等于模型真的好，更不等于把别家 LLM 锁起来就能赢。」）

> "As someone internal at Google I don't understand why there's so much criticism of Google models... but right now I'm using the *next* model beyond Argon, and Flash 3.8. In my personal Gemini app I only have access to 3.5. Models move so fast now and Google is very cautious about releasing them." — asdfman123 [c:50075838]
> （译文：「作为 Google 内部人我不明白为什么我们的模型被骂……但我现在用的是 Argon 之后那个下一代，以及 Flash 3.8。我个人的 Gemini App 里只到 3.5。模型跑得太快，Google 出手又特别谨慎。」）

> "Clicking the try gemini 4 link takes me to a demo prompt that loads 3.6 flash. Srsly" — vessenes [c:50077789]
> （译文：「点'试用 Gemini 4'的链接，跳到一个 demo prompt，加载出来的却是 3.6 Flash。认真的吗。」）

> "I'll believe in AGI when Google can figure out how to leverage their model to make their user experience not suck." — gpugreg [c:50078539]
> （译文：「等 Google 能用他们自己的模型把产品体验做不卡的时候，我就信 AGI 真来了。」）

asdfman123 在评论里反复出现——他承认「内部能用 Argon 之后那个版本」，但「个人 Gemini App 还停在 3.5」。BoorishBears 把这层割裂感压缩成一句反讽。vessenes 那边更绝：订了 Ultra 的人点「试用 Gemini 4」，进去加载出来的是 3.6 Flash。gpugreg 那句成为当贴金句——AGI 没来之前，先把产品体验理顺。

### Em-dash 之争：一个标点被玩坏了

> "Em dashes are underappreciated — they are visually pleasing, not cluttery like semicolons or definitive like colons." — cluckindan [c:50077582]
> （译文：「em-dash 被严重低估——视觉好看，不像分号那么乱、也不像冒号那么硬。」）

> "I have a pet theory that there's some overlap of writing patterns that A) indicate quality, clear communication and B) those that the LLMs have been converging on. As a result, we're ruining the reputation of some great writing patterns because we've associated it with AI slop." — bitshiftfaced [c:50077652]
> （译文：「我有个小理论：A 和 B 有重叠——A 是'高质量、清晰的写作模式'，B 是'LLM 正在趋同的写作模式'。结果是，一些真正好的写作模式被我们毁了名声，因为我们把它们和 AI slop 划等号。」）

> "AI writing style comes from post-training, which is entirely under the control of the labs. It's not copying it from any public sources." — astrange [c:50078637]
> （译文：「AI 写作风格来自 post-training，完全在实验室手里。它不是从任何公开数据里抄来的。」）

postalcoder 在 [c:50074108] 里随口一句「the em-dash is back w/ this model」，引出讨论中最长的一条支线。bitshiftfaced 把 em-dash 提升到「优秀写作的 fingerprint」级别：被 LLM 学走之后，写得好的真人也被怀疑。astrange 一句话把它打回原形：「post-training 决定一切，实验室想收就能收」。中间还有相当数量的吐槽帖（[c:50077538] leoooodias、 [c:50078298] lackoftactics），但跟主线关系不大。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 模型封神派 | svara [c:50077620] | 写作像精品小论文，对 Opus 5.5 全面压制 |
| 模型封神派 | asdfman123 [c:50075802] | Google 内部已在用，比 Opus 5.5 更清晰直接 |
| 写作风格派 | asdfman123 [c:50076854] | Opus 5.5 像装聪明的研究生，Argon 才像话 |
| 实战派 | bretpiatt [c:50075622] | Antigravity 拉了 1 个 subagent/审计段，10 分钟/段打 80 万行 |
| 实战派 | protoman3000 [c:50074348] | 「写」最强，「写代码」最烂 |
| 翻车派 | postalcoder [c:50074522] | 2 周预告期把流量全部错失，OpenAI dev day 把人赶走 |
| 翻车派 | dcchambers [c:50075394] | Pro 订户在 Antigravity 看不到 Argon，发布流程全失分 |
| 翻车派 | I_am_tiberius [c:50075927] | 注册、找入口、付款三关全卡 |
| 价格派 | damsta [c:50074155] | 重要信息藏在登录页后面 |
| 价格派 | simonw [c:50074268] | 12 月 1 日起翻倍到 $4/$20 |
| 价格派 | mdasen [c:50075460] | 按任务总成本，Argon 现在比 Opus 便宜 |
| 内部派 | asdfman123 [c:50075838] | 内部已经在用下一代，外部 App 还停在 3.5 |
| 内部派 | Insanity [c:50074124] | 「Across Google」是推自家模型、限制外部 LLM 的结果 |
| 内部派 | BoorishBears [c:50076997] | 反讽自家「产品装不进来模型」的窘境 |
| 反讽派 | gpugreg [c:50078539] | 「等 Google 把产品体验做不卡，我就信 AGI」 |
| 反讽派 | I_am_tiberius [c:50075927] | 注册 Google 账号才是入门第一关 |
| Em-dash 派 | bitshiftfaced [c:50077652] | em-dash 被 LLM 学走，好写作也跟着背锅 |
| Em-dash 派 | astrange [c:50078637] | 写作风格来自 post-training，不是抄的 |
| 怀疑派 | verdverm [c:50074330] | 「不间断猛干」的训练路线不是真智能突破 |
| 怀疑派 | petesergeant [c:50075852] | Google 的模型质量这次真的跟以往不一样？先观望 |

## 总体情绪

故事讲到这里曲线很清楚：模型质量冲击一波高度 → 发布流程把高度全部摔回去。第一天拿到 Argon 的内外部用户在 [c:50075927] / [c:50077789] / [c:50075838] 里互相印证：产品入口找不到、付款被拦、按钮指向旧版本。postalcoder 在 [c:50074108] 里那条原话——「I would be so frustrated with Sundar Pichai if I was on the Google team」——成了整贴情绪的稳定剂：写完一句又自我消解一句。

讨论的裂缝不是模型好不好的问题，是 Google 能不能把模型送到用户手里。这次 740 分、593 条评论一起把这件事按在 HN 热门榜上。但同一天 OpenAI 的 Codex CLI 又因为「默认装后台 daemon」拿到 593 分（Fabe 590 多），Muse Wonder 在这条线外还挂着 656 分。如果 Google 真想在 AGI 之前先把订阅入口整明白——这是 gpugreg 给出的最低门槛。

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3。

引文 ID（`[c:xxxxx]`）已与缓存评论原文逐句比对，文本级一致性已逐条核验。HN 评论 HN ID 与作者名一致；最终存在性 + 作者匹配由 `hn-repair.rb` 在 CI 上经 Algolia 网关注入复核。

</div>

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Gemini 4 Argon（主贴） | <https://news.ycombinator.com/item?id=50073879> |
| 2 | Gemini 4 Argon for Robotics（参见） | <https://news.ycombinator.com/item?id=50074869> |
| 3 | Gemini 4 Argon（Google DeepMind 官方页） | <https://deepmind.google/models/gemini/> |
| 4 | Gemini 4 介绍期价格（simonw 提供） | <https://ai.google.dev/gemini-api/docs/pricing#gemini-4-argon> |
