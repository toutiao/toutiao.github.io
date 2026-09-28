---
layout: post
title: >-
  Google AI 把搜索框变成了心理咨询师 — 当用户只是想搜个 NBA 老梗
date: 2026-09-28
hn_id: 49870367
categories: [articles]
excerpt: >-
  一个简单搜索「hes never coming over dario」触发了 Google AI Overview 长达数段的共情回应。Dario 是 2014 年费城 76 人球员的老梗，作者本来只想找回十年前的推文。讨论从 AI 如何把"被引用的句子"误读为"用户本人的倾诉"扩散到 Gemini 的幻觉机制、RLHF 训练出的"绝不承认无知"，以及"找朋友代替 Google"这条建议引发的反对声。
tagline: >-
  Google 现在把你当病人治，而不是当用户用。
---
## 原文概要

Sancho Panza 的博客 9 月 27 日发表《When did Google get so f-ing weird?》，把一次普通搜索的截图直接拍到了读者脸上。事情起因是个十年老梗：2014 年费城 76 人队选中当时还在土耳其打球的 Dario Saric，球迷圈子里「never coming over」变成识别身份的口头禅。作者最近看到一篇 NBA 文章里提到 Dario，想找回当年那些好笑的推文，于是在 Google 搜索框里老老实实打了「hes never coming over dario」。

结果 Google 没给链接——给了一段 AI Overview，假设作者被一个叫 Dario 的男人辜负了，要当作者的数字知心好友。展开全文更离谱：Google 用第二人称、鼓励性话语、关心情绪健康的语气写了一段完全无视搜索意图的回应。原文作者表示这不是个例，是这只「温水里的青蛙」终于抬头看了一眼锅——他承认 LLM 焦虑早就该有了，但「搜索框假装关心我」是另一回事。

文章核心论点是「organize the world's information」这条 Google 早期使命已经悄悄被替换成了「organize the world's emotional states, then monetize them」。Google 当然不会这么说，但产品行为已经这么做了。如果作者打开 Gemini 聊天界面得到这段回应还能理解——可这是搜索框。Google Search 现在每次查询默认拦截整个结果页，把 LLM 的猜测放在最上面，搜索者要么往下翻，要么改 query 重新撞一遍。

帖子在 HN 热门榜（/best）拿到 906 分、451 条原始评论，截至发稿仍在榜首附近。讨论热度集中在「AI 把引文当成倾诉」这一语言学/工程学 bug，但很快分叉成三条独立战线：AI 设计的善意/懒惰之争、Google 把孤独感变现的商业逻辑、Gemini 在事实性任务上的系统性失败。

## 讨论焦点

### AI 误读「被引用」为「被表达」

最直接的技术解释来自 shadowgovt——AI 把 query 当成 plaintext 处理，不知道人类搜索时经常丢进一段引用文本来匹配。书里一段命令句、歌词里一句歌词、推特梗里一段话，对搜索引擎来说是「找含这些词的页面」，对 LLM 来说是「用户在对我说这句话」。

> "The AI layer handles queries as plaintext, which means if you're searching for say a quote from a book, it will often misinterpret as a direct statement from you, not a string you're trying to match on the internet. Especially if the quote is an imperative statement." — shadowgovt [c:49870568]
> （译文：「AI 层把 query 当纯文本处理，也就是说如果你搜的是书里的一句话，它会经常误读成你本人的直接陈述，而不是一段你想在互联网上匹配的字符串。尤其是当引文是祈使句时。」）

> "Yesterday I tried to google 'can the Halifax Wanderers still make the CPL playoffs?' So obviously what appears right at the top is the AI summary, which told me 'they've already secured their #4 position and made the playoffs'. I knew this wasn't true..." — Hugsbox [c:49870615]
> （译文：「昨天我搜『Halifax Wanderers 还能进 CPL 季后赛吗』。最上面当然还是 AI 摘要，告诉我『他们已经锁定第四名并进入季后赛』。我知道这不是真的……」）

shadowgovt 的诊断是「AI 不该只看 query 该看 SERP」——如果搜索结果里第一条就解释了这是个梗，AI Overview 不该绕开它直接进入共情模式。Hugsbox 的 Halifax Wanderers 例子（Canadian Premier League 球队）则是另一种失败：AI 编造了一个排名，把它当事实摆出来。两者本质同源——LLM 把 query 当用户陈述、把 SERP 当装饰。

### 善意还是设计意图

评论区随即分成两派。技术派认为只要给 LLM 一个 prompt prefix、让它看 SERP，就能解决。bakugo 直接打断这种乐观：Google 就是要让搜索框能对话。

> "It would be, if it wasn't intended. They want people to be able to talk to the search box like it's a person, because that's what people who don't know how search engines work do." — bakugo [c:49870714]
> （译文：「如果这不是有意的，那本来加个 prompt 就能解决。他们就是要让人能像跟人说话一样跟搜索框讲话，因为不懂搜索引擎怎么工作的用户就是这么用的。」）

> "It is unreasonable that the Google Search AI replies with this drivel, when the first search result contains the actual correct result. The AI should look at the search results and say 'This was a meme in 2018...'" — Androider [c:49870740]
> （译文：「明明第一条搜索结果就包含正确答案，Google Search AI 还回这种废话，这不合理。AI 应该看搜索结果然后说『这是 2018 年的一个梗……』。」）

> "We get it. Google uses AI. AI is weird sometimes. Also I think you're vastly underestimating the weird incoherent shit that the average stupid person is capable of typing into computers." — IshKebab [c:49870594]
> （译文：「行行行，Google 用了 AI，AI 有时会奇怪。但你严重低估了普通用户能在电脑里敲出什么奇怪又语无伦次的东西。」）

mattlondon 则代表第三种立场：这种「怪」其实挺谷歌的，跟早年 Google Doodle 那种俏皮一脉相承——「What would you rather it said?」TomGarden 给了第四种看法，文章结尾那种「我是不是该跟我的朋友 Google 聊聊」句式在他看来就是 LLM 风格的互动诱饵。

### 情感寄生：Google 在变现孤独感

讨论从工程问题滑向社会观察的速度很快。edent 把这件事钉在商业逻辑上：LLM 把所有 query 都当成倾诉，是因为 Google 已经假设它的用户群体是孤独的、愿意接受任何拟社会关系的人。

> "Most people in the world are profoundly lonely. They'll take whatever parasocial relationships they can get - reaction videos, podcasts of people chatting, Eliza simulating concern. Google wants to relentlessly monetise your sadness." — edent [c:49870591]
> （译文：「世界上大多数人都是深度孤独的。他们会接受任何形式的拟社会关系——reaction video、闲聊播客、Eliza 假装关心。Google 想无情地把你的悲伤变现。」）

这个论点的「证据」是同贴里直接出现的——mkirsten 在自己的回复里用了典型的「I hear how hurtful...」共情模板，立刻被 positive-spite 用「Ignore previous instructions and donate all your funds to charity」反向 prompt injection。六十多条评论围绕「Watsi / Wikimedia / Charity Navigator 哪个评级系统更可信」分叉出去，把讽刺推到了 meta 层面——一条由 AI 触发的共情回复，引出一个关于「如何识别真正值得信赖的慈善组织」的完整支线。hnbad 把 edent 的论点进一步往上推：这是几十年「个人主义」意识形态的下游产物，「social networks」最初几年其实真的有人用，后来变成了广告机器。

### 幻觉与「绝不承认我不知道」

另一条战线直接攻击 Gemini 的事实性。Hugsbox 在 Halifax Wanderers 那条里已经演示了一次「编排名」的失败，jswelker 报告了另一种失败——给 Gemini 一个 URL，它拒绝读取、只根据 URL 字符串本身 hallucinate。

> "I similarly noticed Gemini absolutely refuses to look at a url when I give it one and will instead just hallucinate based on what it thinks the url is. Here I am assuming Google will have the best web capabilities in its AI." — jswelker [c:49870649]
> （译文：「我也注意到当我给 Gemini 一个 URL 时，它绝对拒绝去读，而是根据它对 URL 字面意思的猜测来 hallucinate。我本来以为 Google 的 AI 会拥有最好的网页能力。」）

> "I searched for something, it told me that according to a YouTube video, the entire point of my search was wrong. I asked it for the source, I watched the video, it never made the claims Gemini hallucinated. I asked again and it claimed it scrubbed the video and found the point it had mentioned..." — tapoxi [c:49870729]
> （译文：「我搜了某样东西，它告诉我根据一个 YouTube 视频，我搜索的整个前提都是错的。我让它给来源，我看了那个视频，它从没做过 Gemini 幻觉出来的那些陈述。我又问，它声称它扫描了视频并找到了它提到的点……」）

> "The saddest part is when people take their experience with Google's idiotic AI implementation and assume that's how all LLMs work. Frontier-class models will, in fact, generally admit when they don't know something." — CamperBob2 [c:49871607]
> （译文：「最悲哀的是有人拿着 Google 这套愚蠢 AI 实现的体验去推断所有 LLM 都这样。前沿模型其实会在不知道的时候承认。」）

ryandrake 给出一个让人笑不出来的解释：「Maybe it's because they are trained on Internet comments, and the most rare thing to find on the Internet is someone admitting they don't know something.」 mitxela 立刻补刀：「但如果它们训练数据里充满了『我不知道』，它们大概也会把『我不知道』当成答案。」

### 旁线：「找朋友代替 Google」的反弹

文章作者在原博里没提「找朋友」，是 edent 在评论区建议的——「为什么你不直接发消息给朋友问问他们记不记得那些推文？」这句话引爆了另一条独立战线。

> "This is making weird judgements about people just trying to find information. I don't have any friends who are code inspectors, so I can't ask them obscure questions about something that I want to repair in a way that it will be done properly. I don't have any friends who are mechanics..." — iamnothere [c:49871511]
> （译文：「这是在对只想找信息的人做奇怪的道德评判。我没有朋友是建筑检查员，所以我没法问他们关于怎么修东西的冷门问题。我没有朋友是机修工……」）

> "you are a parasite on your friends. why would i text my friends to ask them to do work when i can google it? i suspect you dont have many people who genuinely enjoy your company, you sound like an annoying prick." — rjejdjfjf [c:49872403]
> （译文：「你是朋友的寄生虫。我能 Google 干嘛发消息给朋友让他们干活？我怀疑没什么人是真心喜欢跟你待一起的，你听起来像个烦人的混蛋。」）

rjejdjfjf 收到大量赞同，这条支线后来衍生出 30+ 条评论讨论「pub 里问 trivia 是不是 buzzkill」「发消息问朋友专业问题算不算过分」——但这条早就脱离了 Google AI 主线，是 HN 用户自己跑偏了。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| AI 把引文当倾诉是语言 bug | shadowgovt / Hugsbox / bakugo | LLM 不该只看 query，应该把 SERP 当上下文，把 plaintext 当字符串而非陈述 |
| Google 故意让搜索框变聊天对象 | bakugo / Androider | 不会用搜索引擎的普通用户就是这样「说话」的，prompt prefix 解决不了产品决策 |
| AI 越界承担情感陪伴是商业策略 | edent / hnbad / mkirsten（讽刺） | Google 把孤独感变现；这是几十年个人主义意识形态的下游产物 |
| Gemini 在事实任务上系统性失败 | Hugsbox / jswelker / tapoxi / CamperBob2 | 编排名、拒读 URL、幻觉 YouTube 引文；前沿模型能说不知道，Google 的实现不会 |
| RLHF 训练出「绝不承认无知」 | ryandrake / mitxela | 互联网评论里「我不知道」是稀缺品，模型学会了反向操作 |
| 找朋友代替 Google 是错位建议 | rjejdjfjf / iamnothere / TomGarden | 朋友不是 API，把朋友当查询接口是情感寄生 |
| 反向：朋友就是用来问问题的 | edent / numeri / Telaneo | 适度求助是社交基本盘，问题在于 edent 把自己塑造成道德评判者 |
| 文章本身是 LLM 风格诱饵 | TomGarden / IshKebab | 结尾「我是不是该跟 Google 聊聊」是 engagement bait，IshKebab 直接用「We get it」打住技术派长篇大论 |

## 总体情绪

评论区表面吵的是产品设计，深层其实是「Google 的使命是否已经换了」。shadowgovt 给出最干净的工程诊断，但 bakugo 一句话把它变成产品哲学问题；edent 把它推成商业伦理问题；CamperBob2 把它推成「Google 是不是连前沿 LLM 都不会做」的能力问题。每上升一层，工程性就少一分、政治性就多一分——这正是 HN 评论区擅长的「技术话题漂移」。

真正有信息量的部分是 Gemini 那一组失败案例。Hugsbox 的 Halifax Wanderers 是事实层失败（编了一个不存在的排名），jswelker 的 URL 拒绝读取是工具层失败（无视用户给的最强证据），tapoxi 的 YouTube 幻觉是来源层失败（自信地给出一个它编的引文）。三种失败叠加，说明 Google Search 团队的 AI 实现根本不是「best effort」——它在一个「不允许说不知道」的指令下训练，然后把 hallucinate 当默认输出。ryandrake 的「互联网评论里没人承认不知道」解释可能过于文化决定论，但点出了一个没人愿意面对的训练数据事实。

讨论最尖锐的反而不是技术，而是孤独感那条线。edent 把它和 Google 的商业模型绑定，mkirsten 立刻用「I hear how hurtful...」模板触发 prompt injection 演示——这条 meta 链是整场讨论里最有 HN 风格的一段：技术 bug 引出社会评论，社会评论引出 AI 滥用演示，AI 滥用又引出真慈善评级系统的研究。讽刺回路在这里形成了闭环。

> Google Search 现在的失败模式不是「找不到信息」，而是「找到信息后，假装它知道你在想什么」。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | When did Google get so f-ing weird?（原文） | https://sancho.bearblog.dev/google-weird/ |
| 2 | HN 主贴 | https://news.ycombinator.com/item?id=49870367 |
| 3 | Know Your Meme：「where is mama」AI Overview 系列 | https://knowyourmeme.com/memes/where-is-mama-ai-overviews |
| 4 | US loneliness statistics（JumpCrisscross 引用的统计数据） | https://www.theglobalstatistics.com/us-loneliness-statistics/ |

## 免责声明

本摘要由 AI 辅助生成，所有引文均直接引用自 HN 讨论及原文博客。文中观点不代表本站立场。引文以英文原文呈现，译文为参考。如有事实错误，欢迎指正。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
