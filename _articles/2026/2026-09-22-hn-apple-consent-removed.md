---
layout: post
title: >-
  我说了「不」，苹果说「好」——macOS 27 取消 Apple Intelligence 关闭开关引发 HN 关于「consent」的全面清算
date: 2026-09-22
hn_id: 49797982
categories: [articles]
excerpt: >-
  伦敦前端开发者 David Bushell 的博客文章 368 分登顶 HN 热门榜：他 2025 年 2 月就关掉了 macOS 15.3 每 15 分钟回传一次数据的功能，上周升级到 macOS 27 后发现开关被悄悄移除；22.28 GB 的 Apple Intelligence 砖头还堵在他磁盘上；HN 评论区把这场「个人控诉」读成整个科技业的「consent 危机总账」。
tagline: >-
  当「不」不再是一种选项，沉默就是默认勾选。
---
## 原文概要

伦敦前端开发者 [David Bushell 的博客文章《I said no and Apple said yes》](https://dbushell.com/2026/09/22/apple-intelligence/) 周二冲上 HN 热门榜首，368 分、279 条评论。故事源于一条私人 timeline：2025 年 2 月 5 日上午 9:51，他在 macOS 15.3 上发现一个新功能**每 15 分钟向苹果回传一次个人数据**；他在系统设置里找到了关闭开关（苹果故意把开关拆成两层，第二层藏得很深），点了「no」，关掉了。

上周他在「苹果的骚扰」下屈服，升级到 macOS 27（他跳过了 26；讽刺的是——「苹果跳过了 10」）。装好之后他在设置里翻了一遍，发现**那个「no」开关被苹果悄悄删掉了**。AI 行业的「consent」一词早已从训练数据和公司手册里消失；今年 6 月苹果推 [deepfake 功能](https://dbushell.com/2026/06/12/apple-deepfakes/) 时就露馅——「think different」现在只剩一个意思：默认开启。

更具体的是数字：macOS 27 的 Apple Intelligence 在他磁盘上占了 **22.28 GB**。新 MacBook 的存储升级费是 £500/TB，折合他被「偷」了大约 £11。这笔账小，consent 的账大：「你不能用走开——AI 会塞进你喉咙；你如果说『不』，他们就把你的舌头割掉。」

文章末尾的清单比开关本身更刺眼——Bushell 列了本月三条 AI 行业新闻：

- [《Despite Pledges From Musk, Child Sexual Abuse Material Persists on X》](https://www.nytimes.com/2026/09/11/technology/x-grok-child-images.html)——Grok 仍在 X 上生成 CSAM 内容
- [《OpenAI Is Now Facing Over 50 Consumer Harm and Wrongful Death Lawsuits》](https://futurism.com/artificial-intelligence/openai-consumer-harm-wrongful-death-lawsuits)——OpenAI 累计被告 50 余起
- [《OpenAI and Microsoft Admits LLMs Are Destroying the Web and Built on Theft》](https://www.404media.co/doom-loop-openai-and-microsoft-admits-llms-are-destroying-the-web-and-built-on-theft/)——两大厂首次书面承认「LLM 正在摧毁网络，建立在偷窃之上」

Bushell 收尾一句最冷：「想要下一份 Epstein list？这就是怎么造出来的——用不 consent 和不隐私的地基，养一代 psychopathic。」

## 讨论焦点

### 「Maybe later」——苹果和整个科技业的老病灶

> "You ever notice how Apple never really lets the user say &quot;no&quot; to their nudges? It&#x27;s always &quot;maybe later&quot; and never &quot;no seriously, I don&#x27;t want this, go away&quot;" — rozenmd [c:49798366]
> （翻译：你们有没有注意到，苹果从来不真的让用户对它的 nudge 说「不」？永远是「以后再说」，从来不是「我跟你说真的不要这个，滚」。）

> "I have this one notification asking me if I want to enable the Personal focus when I'm at home. I don't want my iPhone to care if I'm at home or not, so the past two years whenever it pops up I click Later. It will probably never stop asking." — aranelsurion [c:49798495]
> （翻译：我有一个通知，反复问我要不要开启「Personal focus」——就因为我回家了。我不想让 iPhone 关心我在不在家；过去两年每次弹出来我都点「Later」。它大概永远不会停。）

> "I think this should be called the ratchet theory of consent because it only tightens." — frereubu [c:49798565]
> （翻译：我认为这应该叫做「consent 的棘轮理论」——它只会越来越紧。）

[rozenmd 的吐槽](https://news.ycombinator.com/item?id=49797982) 把整场讨论钉在了最具体的 UI 现象上：「maybe later」是苹果（也是整个行业）最经典的 dark pattern——它**永远不让你说「不」，永远给你留一扇「以后再说」的门**。`aranelsurion` 给出现实案例：iOS 上有一个「Personal focus」通知，问你在家要不要开启，他两年里每次弹都点 Later，「它大概永远不会停」。

`frereubu` 直接给这个模式命名——**「consent 的棘轮理论」**：它只会越来越紧，你以为点 Later 是给自己留后路，其实是把自己往坑里推。

这条 thread 的另一支迅速长出一段极有戏剧性的副线——`jacquesm` 撞上一个 2018 年就写过同样论点的人（[Dark patterns: the ratchet](https://jacquesmattheij.com/dark-patterns-the-ratchet/)），`frereubu` 回了一句「Great minds think alike. Although they do also say that fools seldom differ...」——HN 式的自嘲带着点酸，因为七年过去，这个「棘轮」不仅没被叫停，反而成了行业默认。

### 22 GB 强占硬盘——「我付钱买的 SSD 不是你的训练场地」

> "No it doesn&#x27;t, one can hate LLMs with a passion and still not want features they don&#x27;t use take 20GB of the storage they paid a premium for." — zecg [c:49798760]
> （翻译：才不会削弱。一个人可以一边恨 LLM 到骨子里，一边也不想让自己花大价钱买的存储被不用的功能吃掉 20GB。）

> "Mine is strongly at the "forcibly stealing huge amounts of disk space for features you don't want" point. As a happy Mac and Android user, I don't recognise the 'make it as hard as possible to escape from their "ecosystem"' description; maybe you can give an example?" — oneeyedpigeon [c:49798776]
> （翻译：我的底线卡在「强行偷走大量硬盘空间塞进你不要的功能」这一点上。作为一个 Mac + Android 双修的用户，我听不太懂「想方设法让你逃不出他们『生态』」这种描述——你能给一个例子吗？）

> "Anyone should be allowed to disable generative AI features on their device, especially a general computing device such as Mac. It's not some hysterical outburst about the industry to be upset when you can't do that, especially when the option used to exist but was removed." — LoganDark [c:49798638]
> （翻译：任何人——尤其是在 Mac 这种通用计算设备上——都应该被允许关闭生成式 AI 功能。不能关不是行业歇斯底里，尤其是当那个开关**曾经存在过、后来被悄悄移除**。）

`zecg` 把两件事分开：[原帖 author 38](https://news.ycombinator.com/item?id=49797982) 把「恨 LLM」和「不想被强占 22GB」混在一起说，被评论说成「情绪化」，`zecg` 反驳：一个人完全可以一边恨 LLM，一边也有权不让自己花钱买的 SSD 被别人的模型塞满。这条分割很关键——它把「AI 哲学争论」和「硬盘主权」拆成了两件事：你不必同意 Bushell 对整个 AI 行业的态度，也可以同意他有权要回自己 22GB。

`oneeyedpigeon` 把这条底线定为「强制偷走硬盘」：[这条 thread 下](https://news.ycombinator.com/item?id=49797982)，一个 Mac + Android 双修用户说「我作为用户找不到『强行把你留在生态里』的具体例子，你能给一个吗？」——`zecg` 的 22GB 就是例子。

[LoganDark](https://news.ycombinator.com/item?id=49797982) 给这场讨论定下最冷静的基调：「任何人——尤其是在 Mac 这种通用计算设备上——都应该被允许关闭生成式 AI 功能。**当开关曾经存在过、后来被悄悄移除**——这才是问题。」这句话把焦点从「AI 好不好」的本体论拉回到「开关有没有」的工程事实——而工程事实是最难辩驳的。

### Apple 究竟是「隐私之王」还是「价值榨取」——HN 阵营分裂

> "If you value things like your privacy or the ability to strictly control what runs on your computer then perhaps it would be a good idea to not run a proprietary operating system that's primarily designed to extract value from you. Of course, it's not Apple's fault, it never is -- it's those 'AI bros'!" — kouteiheika [c:49798433]
> （翻译：如果你在乎隐私、在乎严格控制自己电脑上跑什么，也许该考虑不用一个主要设计来从你身上榨取价值的专有操作系统。当然，这不会是苹果的错，从来都不是——是那些「AI 佬」！）

> "Of course it's designed to extract value. MacOS is primarily a consumer content platform with some developer features, rather than vice versa. The Apple experience is enshitifying at all levels and becoming consistently intrusive." — TheOtherHobbes [c:49799312]
> （翻译：当然是设计来榨取价值的。macOS 本质上是一个消费者内容平台加一些开发者功能，而不是反过来。Apple 的体验正在所有层面上 enshitify，并且变得持续地 intrusive。）

> "I don't have a solution, but on this topic I let Fable write a browser extension I called 'Nee, krijg de tering'. It's 'No, fuck off' in English, but the Dutch feels more visceral for me." — Phemist [c:49798579]
> （翻译：我没有解决方案，但针对这个我让 Fable 写了个浏览器插件叫「Nee, krijg de tering」。英语翻译过来是「不，滚」，但荷兰语对我来说更 visceral。）

[kouteiheika 的反驳](https://news.ycombinator.com/item?id=49797982) 是 HN 上对所有「商业平台 + 隐私」抱怨的标准反应：「你既然在乎这个，为什么还要用一个从设计上就为了从你身上榨取价值的专有 OS？」——言下之意：要 free，去 Linux。讽刺的是，他在引文里把 `&quot;I&#x27;ve chosen not to kowtow to billionaires&quot;` 一段单独高亮出来——作者嘴上说「我不向亿万富翁下跪」，身体却继续给一个市值 5 万亿的公司付费。

`TheOtherHobbes` 把这层讽刺直接展开：「macOS 本质上是一个消费者内容平台加一些开发者功能。Apple 的体验正在所有层面上 enshitify，并且变得持续地 intrusive——我被一个 3 个月的 Apple Music 试用一直骚扰，从来不会用也没兴趣；音乐播放器在我上车时自动启动。」

[Phemist 的解决方案](https://news.ycombinator.com/item?id=49797982) 是这场讨论里最反讽、也最诚实的一段——他让 Fable 写了个浏览器插件，专门扫描网页里的「Maybe later」「No, thank you」按钮，**把它们替换成荷兰语脏话「Nee, krijg de tering」**（字面意思：「不，去得肺结核」）。他承认这不能解决任何问题，但他最后一句话把整个 dark pattern 钉死：「好像我有义务在某个将来时间被迫回答这个问题，或者在我拒绝被扇耳光的时候还要特别礼貌。正确答案显然是『不，滚』。」

### 「Yes / No / Remind me later」——苹果明明做得对过

> "A much better way would be “Yes” and “No” with a small message of “you can change this later in the Settings”. Or have three buttons: “Yes”, “No”, “Remind me Later”. Apple does stuff like that in other parts of the OS, like when asking for app permissions, so they clearly know how to do it." — latexr [c:49798691]
> （翻译：更好的做法是「Yes」和「No」再加一行小字「你之后可以在设置里改」。或者三个按钮：「Yes」、「No」、「Remind me Later」。苹果在 OS 的其他地方就那么做——比如问应用权限的时候——所以他们显然知道怎么做。）

> "i see this virtually everywhere, and worked at several places where PMs proactively changed text banners to not equate to 'no'. severe industry brainrot" — sitzkrieg [c:49798573]
> （翻译：我到处都见到这玩意儿。我还在好几个地方工作过，那里的 PM 会主动改文案，让按钮不再等于「no」。严重的行业脑腐。）

[latexr 的方案](https://news.ycombinator.com/item?id=49797982) 看起来平淡，但杀伤力最大——它不是在抱怨 UX，是直接贴出**苹果自己的反例**：当 iOS 问你要不要给某个 App 位置权限时，三个按钮清清楚楚：「允许」、「不允许」、「下次再说」。Bushell 文章的 22GB 问题之所以让人愤怒，恰恰是因为苹果**已经在自己的其他对话框里把正确的做法做了出来**。它们不是不知道，是选择在这件事上不这么做。

`sitzkrieg` 把这层 critique 推到行业内部视角：他以前工作过的公司里，PM 会**主动**把文案里的「no」删掉，让按钮永远不再是一个干净的「不」。「严重的行业脑腐」——这不是某个公司的失职，是一种行业级别的、明知的、主动的设计语言选择。

`Vinnl` 是这场讨论里**唯一的辩护者**——他说「maybe later」其实是有用的：「用户没法自己再次触发 dialog，所以这句话等于一个承诺：你即使在 dialog 里说『no』，也随时可以进设置改回来。这让我对选择不那么焦虑。」`latexr` 立刻拆穿：「那也写明『你可以之后在设置里改』就好，何必绕个弯用『maybe later』？」`notpushkin` 把讽刺推到顶：「PM 完全可以用一段文字明确承诺『你可以之后在设置里改』，并且真的兑现这个承诺。但现实是这种措辞**就是为了给 PM 留 weasel out 的余地**——下一次更新就改成再骚扰你。」

### 「最 consentless 的科技」——把问题抬到本体论层面

> "The most consentless (don't underline this in red firefox!) technology that I can think of certainly." — jpnc [c:49798405]
> （翻译：这是我能想到的最 consentless（Firefox 别再给我画红线了！）的科技，没有之一。）

> "The 'AI' industry has many flaws, the word 'consent' being seemingly missing from training data and company handbooks is one of them." — David Bushell [c:49797982]（原帖）
> （翻译：AI 行业毛病很多，「consent」这个词像是从训练数据和公司手册里被偷偷拿走了——这是其中之一。）

[jpnc 的评价](https://news.ycombinator.com/item?id=49797982) 把这个 thread 抬到了本体论高度：「这是我能想到的最 consentless 的科技，没有之一。」Firefox 把 consentless 标成拼写错误这件事本身变成一个小彩蛋——「**这个词不是我们的日常词汇**」，但讨论进行到这里，它成了这场对话的核心词。

但 jpnc 在 quote 末尾还偷偷塞了一句 `&quot;edit: also install and use Linux&quot;`——这是 HN 上对一切专有 OS 抱怨的标配「补丁」。也就是说：技术圈面对这种「consent 系统性消失」的问题，**最终的逃逸方案仍然回到「离开生态」**——装 Linux、装 BSD、装 GrapheneOS。这条 thread 后面确实分叉出 FreeBSD、Thinkbook、Wi-Fi 兼容性一长串讨论，但对大多数非技术用户来说，「装 Linux」不是答案，而是问题的进一步证明：当一个商业生态把「不」也变成付费墙，用户唯一的回击是放弃整个生态。

Bushell 自己那段话被反复引用：「AI 行业毛病很多，consent 像是从训练数据和公司手册里被偷走。」这句话之所以有传播力，是因为它不指向某个具体 bug——它指向**一个行业的默认设置**。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 苹果的「no」从来不是真的 no | `rozenmd` | 永远是「maybe later」，没有「我跟你说真的不要这个，滚」 |
| 两年点 Later 仍不停 | `aranelsurion` | iOS 反复问我要不要开 Personal focus，点 Later 永远管不久 |
| 棘轮理论命名权 | `frereubu` | consent 只越来越紧，应叫「棘轮理论」 |
| 22GB 与恨 LLM 是两件事 | `zecg` | 可以一边恨 LLM 一边不让自己 SSD 被吃 20GB |
| 偷硬盘是底线 | `oneeyedpigeon` | 强制偷走硬盘塞进你不要的功能——我的底线 |
| 开关曾经存在 | `LoganDark` | Mac 这种通用设备上应允许关 AI，开关曾存在后被移除才是问题 |
| 怪 OS 别怪 AI | `kouteiheika` | 在意隐私就别用设计来榨取价值的专有 OS |
| enshitify 各层都在 | `TheOtherHobbes` | macOS 是消费内容平台加开发者功能，正在各层 enshitify |
| 浏览器插件替换脏话 | `Phemist` | 让 Fable 写了个插件把所有「Maybe later」换成荷兰语脏话 |
| 苹果知道怎么做 | `latexr` | 权限对话框就三个按钮「Yes / No / 下次再说」，明显知道 |
| PM 主动删掉 no | `sitzkrieg` | 以前公司 PM 主动把按钮文案里的「no」拿掉，行业脑腐 |
| maybe later 是焦虑缓冲 | `Vinnl` | 用户没法自己触发 dialog，「maybe later」等于承诺可改 |
| PM weasel out 借口 | `notpushkin` | 「Maybe later」就是给 PM 留「下次更新改回再骚扰你」的余地 |
| 最 consentless 科技 | `jpnc` | 这是我能想到的最 consentless 的科技，没有之一 |
| 跑路派补丁 | `jpnc` | edit: 也 install + use Linux |

## 总体情绪

整体情绪是**「隐私 vs 平台的长期清算」加上「AI 让这一切加速到无法忍受」**。Bushell 的文章表面上是一个前端开发者对 macOS 27 的吐槽，但 HN 评论区把它当成了一笔总账：22GB 是一个具体数字；「yes/no 改成 maybe later」是一种 UI 语言；「consent 从训练数据里消失」是一种行业默认设置。这三件事在 Bushell 那条 timeline 上同时发生，于是被读成「AI 时代的平台权力集中爆发」。

讨论分叉最深的不是「苹果好不好」，而是**「当一个平台把『不』也变成付费墙时，普通用户的真实选择是什么」**。技术派的答案是「装 Linux」、「装 BSD」、「装 GrapheneOS」——但 `jpnc` 在 quote 末把这条建议当成补丁贴出来本身就说明问题：**对一个非技术用户来说，「装 Linux」不是解决方案，而是问题的进一步证明**。如果一家商业平台能把「no」也商品化，那么逃逸到开源生态就不是「用户的选择」，而是「用户最后一道防线」。

`Phemist` 的「Nee, krijg de tering」浏览器插件是这场讨论里最黑色幽默的一段——它不能解决任何问题，但它的存在本身就是对「maybe later」这种温和措辞的反抗：**当整个 UI 都在告诉你「你以后可以再决定」，能让你恢复一点主体感的，反而是把按钮换回一句脏话**。

讨论最深的一刀是 [LoganDark](https://news.ycombinator.com/item?id=49797982) 那句：**「开关曾经存在过、后来被悄悄移除。」**——把 AI 行业是否邪恶、AI 是否有用这些宏大问题绕过去，直指一个工程事实：一个 OS 级别的功能曾经允许关闭，现在不允许了。读者不必关心 AI 是不是未来，也不必在乎苹果的隐私口号——他们只在乎自己能不能要回自己磁盘上的 22GB、能不能要回自己设置面板里的「不」。

HN 的潜台词：**如果一家公司能在你升级 OS 的时候悄悄把「不」删掉，那么这家公司对你说的所有「Yes, you can change this later」都是可疑的。**当「no」本身需要靠一个荷兰语脏话浏览器插件来重建，用户和企业之间的信任合同就已经被改写了——不是被废除，是被悄悄换了一页。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | I said no and Apple said yes | https://news.ycombinator.com/item?id=49797982 |

## 免责声明

本文由 AI 辅助生成，所有引文均来自 HN 评论区原始记录（_data/hn/2026/W39/49797982/comments.yaml）。观点不代表原作者完整立场。涉及第三方（Apple、OpenAI、Microsoft、X/Grok 等）的描述均基于公开报道与 HN 评论中提到的链接，不代表本平台对相关公司或人物的判断。22.28 GB、£500/TB 等数字来自原博客文章，转引时未独立验证。

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3
</div>