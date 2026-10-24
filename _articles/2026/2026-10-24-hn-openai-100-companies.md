---
layout: post
title: >-
  Ask HN：如果模型这么好，OpenAI 为什么不自己开 100 家公司 — HN 讨论摘要
date: 2026-10-24
hn_id: 50200997
categories: [articles]
excerpt: >-
  624 分、701 条评论，全在算同一笔账：模型好到能解千年难题，
  为什么还是不能自己开 100 家公司。答案落在注意力、卖铲子，
  和一张 5000 亿美元的订单上。
tagline: >-
  卖铲子的公司不会自己下场挖矿——他们只是不想分心。
---

## 原文概要

10 月 22 日，一位 ID 叫 ex-aws-dude 的用户在 HN 发了 Ask HN：「如果模型这么好，OpenAI 为什么不自己开 100 家公司？」他先声明标题是夸张的，真正的疑问其实更朴素——如果前沿模型已经好到那个程度，为什么还要把「卖 token」当成主要赚钱手段？既然模型正在商品化、价格在往下掉，是不是说明钱在应用端，而不在工具端？帖子拿到 624 分，701 条评论。

这是一个没有链接、没有文章、全靠观点的帖子。700 多条评论分成几大阵营：卖铲子派、已经在开公司派、注意力瓶颈派、资本与债务派、Jevons 需求派。争论的技术含量不高，但每一条支线都拖着真实数据。

最热的一条支线是钱。模型公司到底欠了多少钱？有人翻出 40 亿美元循环信贷额度、Oracle 从 2028 年起 5000 亿美元的算力预订单、SoftBank 的高杠杆，还顺手算了一遍「花 2200 万美元解一个 100 万美元的数学题」这个宣传案例该怎么记账。结论分裂得很厉害：一方说 OpenAI 根本没借过钱，投资不是债；另一方说债只是搬到了别人的账上——数据中心、Neocloud、以及替它们发债的巨头。

讨论最终落在一个反直觉的地方：模型「有多好」和「能不能开 100 家公司」之间，其实没有因果关系。

## 讨论焦点

### 标题夸张，但问题是真的

提问者自己先给了这个问题的动机：

> "I mean it sounds stupid but I think its a fair question if you can spend 15 million and solve a millennium prize problem, what happens if you take the same resources and just aim the cannon at making money?" — ex-aws-dude [c:50201945]
> （译文：我知道这听起来很傻，但我认为这是个合理的问题——如果你能花 1500 万美元解出一道千年难题，那么把同样的资源直接瞄准赚钱又会怎样？）

paxy 的回复把问题本身拆开了一半：

> "AI models are very good at doing [a set of things]. Autonomously running a large, complex business is not one of them." — paxy [c:50201489]
> （译文：AI 模型很擅长做[某些事情]。自主运营一家庞大复杂的企业，不在其中。）

也有人举出已经发生的例外，只是两个例子的结局相反。做过硬核对冲基金的 Leopold Aschenbrenner 被提名为反面教材：

> "Leopold Aschenbrenner tried this and got eaten by the wolves as far as I can tell..." — dingdongditchme [c:50206057]
> （译文：就我了解，Leopold Aschenbrenner 试过，然后被狼群吃掉……）

正面例子来自国防工业：

> "There was some recent news that Lockheed Martin was collaborating with them on some problem." — rohit89 [c:50211406]
> （译文：最近有消息说洛克希德·马丁正在和他们合作解决某个问题。）

### 卖铲子：模型公司只卖工具

这是全场最主流的解释。淘金热里卖铲子的人不去挖金子，因为挖金子要雇人、要担风险、要分心。

> "During a gold rush, sell shovels. They are investing heavily in in-house custom silicon, which is the shovel end of things." — Rodmine [c:50201190]
> （译文：淘金热里，要卖铲子。他们正在大力投资自研芯片，那就是铲子这一端。）

有人把这套逻辑画成了一条链：

> "It’s shovels all the way down. Nvidea is selling shovels to frontier model labs who are selling shovels to AI companies who are selling shovels to actual businesses who have nicer power point presentations, a lot more dashboards, and some inference driven workflows." — nemo44x [c:50206929]
> （译文：铲子一直往下传。英伟达卖铲子给前沿模型实验室，实验室卖铲子给 AI 公司，AI 公司再卖铲子给真正的企业——那些企业有更漂亮的 PPT、更多的仪表盘，和一些由推理驱动的工作流。）

对这套说法最直接的反驳是：卖铲子的明明是英伟达。

> "I thought NVidia was the one selling shovels here, not OpenAI." — stingraycharles [c:50201480]
> （译文：我一直以为在这里卖铲子的是英伟达，不是 OpenAI。）

而且英伟达自己可能都不信模型会一直值钱：

> "The former means NVidia believes LLMs are fundamentally limited, and if that’s the case OpenAi and Anthropic are basically screwed as their core products become commodities." — besterman23 [c:50202379]
> （译文：前者意味着英伟达认为 LLM 有根本性的局限；如果真是这样，随着核心产品变成商品，OpenAI 和 Anthropic 基本就完了。）

Google 则被当成反面教材：只让租铲子，不让买铲子。

> "Google is doing it successfully to the point where they only let you rent their shovels and never let you buy them." — imtringued [c:50205609]
> （译文：Google 做得非常成功，成功到他们只让你租铲子，永远不让你买。）

### 他们其实早就在开公司了

另一派直接说：已经在做了。digitaltrees 讲的是软件本身正在被替代这件事：

> "They are doing that. That is why they have moved into the app layer. They are counting on software being replaced with agentic super apps." — digitaltrees [c:50201039]
> （译文：他们确实在做。这正是他们转向应用层的原因。他们指望软件被 agent 化的超级应用取代。）

同一位用户还顺口提了一句：公司已经在往咨询业务挤（他们买下了我朋友那家咨询公司）。

CoolestBeans 列出五条理由，第一条直接回答提问：

> "They are starting to do it. Take a look at OpenAI's product portfolio, there's a galaxy of attempts at application." — CoolestBeans [c:50201229]
> （译文：他们已经开始做了。看看 OpenAI 的产品组合，那是一片在应用层上的尝试星群。）

但同一个人的第 5 条把话说回来：前沿模型仍然受制于 AI 的局限，不是什么都擅长，让别人在自己的钱上学会这一点更好。

至于能力结构，有人用一句谚语总结：

> "On 1) though, they're an inch deep and a mile wide." — physicsguy [c:50207560]
> （译文：不过就第 1 条而言，他们是一英寸深、一英里宽。）

反方立刻举例反驳——OpenAI 做的可不只是「浏览器里的 AI」：

> "Didnt OpenAI build a browser not just AI inside a browser?" — sumedh [c:50207776]
> （译文：OpenAI 难道不是做了一个浏览器，而不只是浏览器里的 AI？）

至于「开公司」到底由谁来做，discordance 提到了模型公司里真实存在的一个岗位：

> "To make point 3 happen fast, their army of Forward Deployed Engineers roam inside existing companies and build for the companies using the companies subscriptions." — discordance [c:50206666]
> （译文：为了让第 3 条快点实现，他们那一支驻场工程师大军会钻进现有公司内部，用这些公司的订阅替这些公司搭东西。）

### 卖 token 是 App Store 抽成

NormalGoat 的类比是全场传播度最高的一个：

> "It's basically the same reason why Apple didn't create every app in the App Store. No single company can be specialised in everything, and more importantly, selling tokens is risk-free money since they get a cut for every app without taking any business risk." — NormalGoat [c:50201618]
> （译文：这基本就是苹果为什么不自己做 App Store 里每个 App 的同一个原因。没有哪家公司能在所有事情上都专业；更重要的是，卖 token 是无风险的钱——每个 App 你都抽成，却不用承担任何经营风险。）

psadri 指出这个类比其实比看上去更贴：苹果确实会「抄」那些成功且长寿的 App（他建议去读「getting sherlocked」那段历史），但其余的 App 转瞬即逝又小众，收广告和支付抽成就够了。

> "The rest of the apps are transient, niche and it’s easier to just harvest your cut of ads/payments." — psadri [c:50201878]
> （译文：剩下的 App 转瞬即逝、又小众，收广告和支付的抽成更省事。）

NormalGoat 接着把边界划出来：苹果只「抄」面向大众的通用功能，从不碰专业 B2B 和极小众的软件，模型公司也是这样——通用的自己做，边缘的留给别人。

> "They build the broad stuff themselves, like AI inside Excel or PowerPoint" — NormalGoat [c:50202027]
> （译文：通用的部分他们自己做，比如 Excel 或 PowerPoint 里的 AI。）

### 100 家公司的瓶颈是注意力，不是代码

paxy 给了全场最干脆的答案：

> "Because running 1 business is easier than running 100 businesses. It takes a lot more than writing good software for a company to be successful." — paxy [c:50201337]
> （译文：因为经营 1 家公司比经营 100 家公司容易。一家公司要成功，需要的远不止是写出好软件。）

zahrevsky 把它量化成了一百分之一：

> "You can't run 100 businesses because each one would only receive 1/100 of your attention, and they would all perform poorly." — zahrevsky [c:50202605]
> （译文：你没法同时经营 100 家公司，因为每一家只能分到你 1/100 的注意力，它们全都会表现不佳。）

ricardobeat 立刻把这句话顶回提问者脸上——这正是问题的核心：

> "But that’s the gist of the question, can’t their internal frontier models provide that infinite attention? That is what their PR implies." — ricardobeat [c:50205223]
> （译文：但这正是问题的要义啊——他们内部的前沿模型难道不能提供那种无限的注意力吗？他们的宣传稿就是这个意思。）

### 钱从哪来：债不在账上，在别人账上

这场支线的火力最猛，因为每个数字都是真的。

一派先撇清债务问题：

> "OpenAI has hardly borrowed anything. They have a $4B revolving credit line but have hardly touched it. They haven't issued any bonds." — nl [c:50201982]
> （译文：OpenAI 几乎没借过什么。他们有一个 40 亿美元的循环信贷额度，但基本没用过。他们没发过债。）

另一派立刻指出债只是换了个地方记：

> "The duopoly AI labs haven't technically borrowed much, but a metric ass-ton of money has been borrowed by various other entities in service of them as infrastructure proxies." — georgemcbay [c:50202171]
> （译文：这两家双头垄断的实验室在账面上确实没借多少，但替它们当基础设施代理的其他实体，借了海量的钱。）

> "but the investment is increasingly _fueled_ by debt, regardless if OpenAI is the direct borrower. just look at the bond market." — rsalus [c:50213362]
> （译文：不管 OpenAI 是不是直接借款人，投资越来越被债驱动。看看债券市场就知道了。）

最耸人的那个数字来自 Oracle：

> "Don’t they have a fully committed preorder for like $500 billion in compute from Oracle starting in 2028? And Oracle is funding that buildout with junk debt?" — estearum [c:50206615]
> （译文：他们是不是有一份从 2028 年开始、总额约 5000 亿美元的算力全额预订单？而 Oracle 正用垃圾债给这场扩建融资？）

于是出现了全场最尖锐的一句总结：

> "They owe people hundreds of billions, possibly even over a trillion. They've just been very clever in how they've structured it, so on paper they have low debt." — MisterMunchkin [c:50206271]
> （译文：他们欠着别人几千亿美元，甚至可能超过一万亿。他们只是把结构设计得很聪明，所以账面上债务很低。）

至于「花 2200 万美元解一道 100 万美元的数学题」这种宣传案例怎么记账，fn-mote 给了一个毫不留情的答案：

> "Fake costs. The numbers reported are what they would have charged other companies for the tokens." — fn-mote [c:50207424]
> （译文：虚报的成本。报出来的数字，是他们本来会向其他公司收取的 token 价格。）

### Jevons 悖论成立吗：需求到底涨没涨

如果模型越用越便宜、反而用得更多（Jevons 悖论），那应用端的钱就更多——这是提问者的隐含前提。有人认为数据支持它：

> "AI price-performance is improving rapidly. AI usage, whether in tokens used, in cash spent, or any of the above performance-adjusted, is curving upwards too." — ACCount39 [c:50206280]
> （译文：AI 的价格性能比在快速改善。AI 的使用量——无论按 token 算、按花的钱算，还是按上面任何一种性能调整后算——也都在往上走。）

但同一批人给出了一条反对证据：

> "One issue is that token usage and revenue seem to be decoupling in real time." — CoolestBeans [c:50216578]
> （译文：一个问题在于，token 的使用量和收入似乎正在实时脱钩。）

他补充的数据点被另一位评论者直接贴了出来：

> "OpenRouter's token volume plateauing" — senordevnyc [c:50217456]
> （译文：OpenRouter 的 token 用量出现平台期。）

### 真正稀缺的，是原语和判断力

讨论快结束时，话题落到了一件模型解决不了的事上。

lconnell962 把「开公司需要什么」拆成三步，每一步都要人：

> "Need a person with an Idea. Need someone to refine their idea. Need someone to spend the time filtering through the slop to find the good bits." — lconnell962 [c:50205759]
> （译文：需要一个人有想法。需要有人去打磨这个想法。需要有人花时间从一堆垃圾里筛出真正好的那部分。）

TheOtherHobbes 反驳了「想法不值钱、执行才值钱」这个通行说法：

> "It's common knowledge that ideas are worthless and only execution matters." — TheOtherHobbes [c:50206695]
> （译文：都说想法一文不值，只有执行才重要。）

他的下一段才是重点：执行昂贵又费时的年代这说法大致成立，但原创的想法远比看起来稀有，因为深入理解一个领域和其中关系是稀缺技能；与此同时，AI 让执行变得便宜多了。

还有一个更朴素的观察，关于「人人能造 App」之后会发生什么：

> "Inevitably, like three people in the office make the same app." — altcognito [c:50201581]
> （译文：必然的事——办公室里会有三个人做出同一个 App。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 模型公司只卖铲子 | Rodmine | 淘金热里卖铲子，他们把钱投在自研芯片上 |
| 铲子一直往下传 | nemo44x | 英伟达卖给实验室，实验室卖给 AI 公司 |
| 卖铲子的其实是英伟达 | stingraycharles | 在这里卖铲子的是英伟达，不是 OpenAI |
| 英伟达可能不信 LLM 会一直值钱 | besterman23 | 如果模型商品化，模型公司反而会被做垮 |
| 他们已经在开公司了 | digitaltrees | 已经进了应用层，还买下了朋友的咨询公司 |
| 应用层是一片尝试星群 | CoolestBeans | 看看 OpenAI 的产品组合就知道了 |
| 能力结构是一英寸深一英里宽 | physicsguy | 通用面广，但深度不够 |
| 卖 token 就是 App Store 抽成 | NormalGoat | 苹果不做每个 App，抽成不担经营风险 |
| 通用功能自己做，边缘的给别人 | NormalGoat | 像 Excel 里的 AI，剩下留给别人 |
| 瓶颈是注意力，不是代码 | zahrevsky | 每家只分到 1/100 的注意力，都会做不好 |
| 内部模型能提供无限注意力吗 | ricardobeat | 这正是提问的要义，也是他们宣传的意思 |
| OpenAI 几乎没借过钱 | nl | 只有 40 亿循环信贷，没发过债 |
| 债在基础设施代理的账上 | georgemcbay | 替它们当代理的实体借了海量资金 |
| 欠款可能超过一万亿 | MisterMunchkin | 结构设计得聪明，所以账面上债务低 |
| Jevons 悖论成立 | ACCount39 | 单价下降的同时使用量在往上走 |
| 用量和收入正在脱钩 | CoolestBeans | OpenRouter 的 token 用量已经出现平台期 |
| 稀缺的是想法和筛选能力 | lconnell962 | 要有人有想法、打磨想法、从垃圾里筛出好的 |
| 原创想法依然稀有 | TheOtherHobbes | AI 让执行变便宜，但原创想法远没那么不值钱 |

## 总体情绪

这场讨论的调性比想象中平静。提问者自己先把话说软了（「我知道这听起来很傻」），全场没有一个人真的把它当成外行问题；主流解释是商业常识——卖铲子的公司不该下场挖金子，抽成的钱比经营的钱安全，一百家公司需要一百份注意力。

真正扎手的地方在钱的支线上。当「模型有多好」这个问题被换算成「谁在为这些算力买单」，讨论就从策略推演变成了账目核对：40 亿的循环信贷、5000 亿的 Oracle 订单、垃圾债、软银的杠杆、还有 2200 万美元解一道百万美元难题的账该怎么算。评论区里那句「他们欠着几千亿美元，账面上却几乎没债」，把整场讨论的性质改写了一次——问题不是模型好不好，而是这些模型背后的资产负债表能不能撑到商业模式跑通。

而最让人记住的其实是那个最朴素的反驳：一百家公司需要一百份注意力。这不是模型能变出来的东西，至少现在还不是。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Ask HN: If the models are so good, why doesn't OpenAI just start 100 companies? | https://news.ycombinator.com/item?id=50200997 |
| 2 | The Token State of Play（OpenRouter，评论区引用） | https://openrouter.ai/data/newsletter/the-token-state-of-play |
| 3 | Why Even Anthropic Can't Vibe-Code Away Salesforce（评论区引用） | https://www.salesforceben.com/why-even-anthropic-cant-vibe-code-away-salesforce |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
