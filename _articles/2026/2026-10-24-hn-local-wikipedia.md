---
layout: post
title: >-
  Local Wikipedia：把维基百科裁成步行半小时的半径 — HN 讨论摘要
date: 2026-10-24
hn_id: 50202285
categories: [articles]
excerpt: >-
  附近少于 25 个条目就给你最近的 25 个、半径约 6 英里；多于 500 个就只留 500 个。
  1288 分的创意，评论区吵最凶的却是它用英尺和码报距离。
tagline: >-
  维基百科早就在你家门口，只是没人问过你要走多远。
---

## 原文概要

10 月 22 日，一个名为 Local Wikipedia 的项目上线，地址是 edjefferson.com/localwiki/，由 HN 用户 sohkamyung 分享到讨论里。页面写着一句自我描述：The Encyclopedia For Local People，副标题是 Wikipedia in Nearby。逻辑不复杂——维基百科里凡是带地理坐标的条目，都能按你所在的位置取出来，并且只取你附近这一圈。

规则写得很具体。附近条目少于 25 个时，取最近的 25 个，搜索半径约 6 英里；多于 500 个时，只保留最近的 500 个。内容不做二次生成，直接来自维基百科本身，只取带地理坐标的页面。页面提供输入城镇、区域、地标或邮编，也提供随机条目、A–Z 索引、Main page、Try another area，以及把某条本地条目分享出去的入口。

隐私上它只做了两件事：位置存在浏览器本地，分享出去的链接不带位置信息。页面同时声明，与维基百科本身没有任何隶属关系。

技术底座没藏住。评论者 esperent 试了几个地方，发现结果与维基百科的 Special:Nearby 一模一样；维基媒体基金会基础设施部门的一位员工 hashar 也下场说明，Special:Nearby 背后是 MediaWiki 的 NearbyPages 扩展。这场讨论的另一个主角，是开发者 tomthe 顺手推广的另一个工具：把所有维基条目按重要度标在一张可缩放的地图上。

这个帖子在 HN 拿到 1288 分，226 条评论。

## 讨论焦点

### 一个「显而易见」的点子，和它当场兑现的东西

最常见的第一反应不是惊讶，是「这早就该有人做了」：

> "Very cool. Obvious in hindsight with every location having coordinates." — refsab [c:50205138]
> （译文：很酷。现在每个地点都有坐标，事后看这个想法太显而易见了。）

第二轮的惊喜来自具体的东西。有人输入邮编连点三次随机条目，在俄勒冈州波特兰几条街的范围内翻出三段自己不知道的地方史；有人发现自己每天路过的一座早已关闭的教堂叫 St Chad's；有人在帕洛阿尔托查到可能是当地第一家书店咖啡馆 Printers Inc.，而它早就没了：

> "It's cool, but a bit sad, to discover establishments that used to exist nearby but don't any longer. It's not easy to do that otherwise." — pastel8739 [c:50205206]
> （译文：挺酷的，但也有点难过——发现曾经就在附近、现在却不在了的店铺。用别的办法很难做到这一点。）

旅行者干脆把它当成行程的一部分：

> "When I visit a new city I usually spend time poking around Google Maps to discover points of interest nearby, but this will be another useful resource. Thanks!" — johnny_lol [c:50205757]
> （译文：我去一座新城市时，通常会花时间在 Google Maps 上乱翻，找附近的兴趣点；这个会是又一个有用的资源。谢谢！）

### 它其实是维基百科 Special:Nearby 的壳

底座被翻出来之后，讨论没有终止，反而转向一个更有意思的问题：一个自己没有数据源、只做重新包装的项目，价值到底在哪。

> "EDIT: actually this is just a wrapper around wikipedia's nearby feature I think. I tried a couple of places and they give identical results." — esperent [c:50205318]
> （译文：编辑：我觉得这其实就是维基百科 nearby 功能的一个壳。我试了几个地方，结果完全一样。）

反驳的人不多，反而有人替它找到了差异化的地方：

> "It does at least add a useful feature: being able to state a location to search from." — dspillett [c:50208923]
> （译文：它至少加了一个有用的功能：可以指定一个位置来搜。）

来自维基媒体基金会内部的一条说明，把这个壳的底座坐实了：

> "Disclaimer: I work for the Wikimedia Foundation, albeit in the infrastructure rather than in development / product." — hashar [c:50206291]
> （译文：声明：我在维基媒体基金会工作，不过是在基础设施这一边，不在开发或产品这一边。）

### 距离单位：吵得最凶的一件事

比功能更抢眼的是界面上的一行小字：距离。默认给的是英尺和英里。

> "I guess it works but I have no idea what a yard or a mile is." — ChrisGreenHeur [c:50205359]
> （译文：我猜它能用，但我完全不知道一码和一英里是多少。）

欧洲用户被这行字直接冒犯到：

> "Distances measured in yards for European destinations is an insult" — darkest_ruby [c:50205576]
> （译文：对欧洲目的地用码来量距离，是一种侮辱。）

更让人抓狂的是英制和公制混着来。一段描述最能说明问题：

> "For example, there's a park that's 1 mi 180 yds from me - if you were to pick one and stick with it then you could say either 1.1 mis or 1940 yds, rather than mixing the two and expecting people to do multiple rounds of arithmetic." — roryirvine [c:50208820]
> （译文：比如，我附近有个公园是 1 英里 180 码。如果非要挑一个单位用到底，你可以说 1.1 英里，也可以说 1940 码，而不是把两个混在一起，还指望读者自己做几轮算术。）

也有人替这套混乱的制度辩护——毕竟这是英制单位自己的老问题：

> "Well yeah, imperial units are a mess. But keeping it all imperial or all metric is better than mixing the two" — ChrisRR [c:50210374]
> （译文：是啊，英制单位本来就是一团乱。但全用英制或者全用公制，总比两个混着用强。）

### 半径写死了，定位也不准

第二条主线是「我想要的东西不在这个圈里」。页面上没有输入半径的地方，半径和条目数上限都是写死的：

> "Very nice! It really should have a field to enter the radius of the search." — dyauspitr [c:50205352]
> （译文：非常好！但它真的应该给一个输入搜索半径的输入框。）

住在市中心的人遇到的恰好相反——太多：

> "I have the opposite problem - I live a half hour walk from central Cambridge UK, so results are full of the tourist destinations!" — parkersweb [c:50206134]
> （译文：我正好相反——我住在英国剑桥市中心步行半小时的范围里，所以结果里全是旅游景点！）

还有人根本没走到「半径」这一步：定位信不过，页面就没法用。

> "So, unless there is some way to manually enter a town name or ZIP code that I missed, the feature is unusable, which is a shame." — edwcross [c:50205305]
> （译文：所以，除非有一种我漏掉的方式可以手动输入城镇名或邮编，否则这个功能没法用，挺可惜的。）

这里的信任问题被另一位读者点得很直白：

> "It's bizare how many people give their coodinates to any random website that asks for them." — GJim [c:50208522]
> （译文：有多少人把坐标随手交给随便一个开口要它的网站，这件事有多奇怪。）

有意思的是，页面自己说了位置只留在浏览器本地、分享链接不带位置——这正是评论区一边骂一边用得最多的地方。

### 排序和筛选：翻到第三条就后悔

真正让人从兴奋翻脸的是内容本身。条目按什么顺序排，决定了你先看到什么——而排在前面往往是那些"有分量"的条目，包括不好的分量：

> "This is a really fun idea, but I went from excited to disgusted in the span of one click. The first thing that pops up for my city of Malmö is the school stabbing that happened in 2022." — INTPenis [c:50205474]
> （译文：这真是个很棒的想法，但我从兴奋到反感只用了一次点击。在我的城市马尔默，跳出来的第一件事就是 2022 年那起校园刺杀案。）

也有人拿到一份清一色的学校名单：

> "In the same vein all of my results are schools except two so it would be nice to have some filters on keyword." — throwaway173738 [c:50208653]
> （译文：同样地，我的结果除了两条之外全是学校，所以希望能按关键词过滤。）

一位做过类似地图的开发者，把这个坑说得很完整——他在自己的项目里选择按字数排序，结果优先弹出的就是写得最长的条目，而那通常是战争、犯罪、事故和争议：

> "If people spent more time writing a page, it must be a great topic, right?" — zulko [c:50206961]
> （译文：如果人们在一个页面上花了更多时间，那它一定是个好题目，对吧？）

于是「按类型筛一遍」成了评论区最集中的功能请求：教堂、桥、博物馆，或者干脆只要有正经词条的对象、滤掉只有 Wikidata 坐标的条目。

### 本地语言条目更多，站点却只给英语

英语维基百科在很多地方条目稀薄，本地语言版本反而更全。请求切换语言是高频词：

> "Is it possible to change the language of Wikipedia? For many places, the local language Wikipedia has more articles." — kubb [c:50205174]
> （译文：可以切换维基百科的语言吗？很多地方，本地语言维基百科的条目更多。）

切换本身有技巧——改 URL 里的语言代码就行。但即使切了，覆盖面也未必更好：

> "Yes, but coverage outside the US is surprisingly sparse. Many European countries (Italy, Spain, France, Germany, Greece…) have fewer than 20 points of interest each." — marcomezzavilla [c:50206229]
> （译文：是的，但美国以外的覆盖出奇地稀薄。很多欧洲国家（意大利、西班牙、法国、德国、希腊……）每个国家的兴趣点都不到 20 个。）

### 不是第一个，也不会是最后一个

老项目早就在那里：

> "Been around over 20 years" — kristopolous [c:50205897]
> （译文：已经存在二十多年了。）

这里指的是 localwiki.org。除此之外还有带本地语言版本的 wiki-map.com、在离线地图里内置维基坐标点的 OsmAnd，以及把收集附近条目做成游戏的 Open World。

讨论里出现频率最高的一个同类项目是开发者 tomthe 的 wiki-importance-map——把所有维基条目按重要度画在一张可缩放的地图上。他解释排序依据时给出了一个后来被反复引用的答案：

> "Yes, the pageview statistics might be enough, but I started from the pagerank dataset https://github.com/athalhammer/danker And because of bot traffic, the pageview statistics are sometimes suspicious and noisy." — tomthe [c:50206661]
> （译文：是的，浏览量统计也许够用，但我一开始用的是 PageRank 数据集 https://github.com/athalhammer/danker。因为有机器人流量，浏览量统计有时可疑而且噪声很大。）

而这些同类项目里最被认同的，是它对「人味」的坚持：

> "Content that is curated by interested humans, without commercial interests, is so good." — snickerer [c:50205507]
> （译文：由感兴趣的人策展、不带商业利益的内容，才是好内容。）

最响的一句总结来自另一个方向：

> "This is the World Wide Web I want to see. Amazing job. Thank you!" — bcvvvy [c:50205556]
> （译文：这就是我想看到的万维网。干得太漂亮了，谢谢！）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 创意显而易见，早该有人做 | refsab | 现在每个地点都有坐标，这想法事后看太显然 |
| 本质是 Wikipedia 的壳 | esperent | 这就是 Special:Nearby 的包装，换几个地方结果完全一样 |
| 价值在于「能指定位置搜索」 | dspillett | 维基自己那个只能用当前位置，这个补上了缺口 |
| 同类项目按 PageRank 而非浏览量排序 | tomthe | 浏览量被机器人流量污染，改用 danker 的 PageRank 数据集 |
| 用码和英里报距离是侮辱 | darkest_ruby | 对欧洲目的地用码量距离是一种侮辱 |
| 混用英制和公制更糟 | ChrisRR | 全用英制或全用公制，都比两个混着用强 |
| 搜索半径应该可调 | dyauspitr | 该给一个输入搜索半径的框 |
| 半径固定对市中心居民是灾难 | parkersweb | 住在剑桥市中心半小时范围内，结果全是景点 |
| 排序会推到不该看的条目 | INTPenis | 点一次就从兴奋变成反感 |
| 覆盖在欧洲非常稀疏 | marcomezzavilla | 意大利、西班牙、法国、德国、希腊每国不到 20 个点 |
| 无商业利益的人类策展最好 | snickerer | 有兴趣的人自己策展、没有商业利益的内容才是好内容 |

## 总体情绪

讨论的两条主线其实不在一条线上。一条是尺寸问题：单位用错了、半径写死了、筛选没做；另一条是位置问题：你走过的那些街、那些店、那些关掉的老房子，本来就在维基百科里，只是没人按你所在的格子去取。

于是评论区分裂成三种情绪：「这不早就该有了」「这个距离单位是故意的吧」「我要的那个条目不在里面」。真正被反复确认的只有一件事——数据是现成的，难的是把「半径」做成一个人人可用的默认值。有人建议这项目干脆改叫 Walkipedia，一半是玩笑，一半是方向：把知识从全球图层上一张张切下来，贴到人脚下那一小块地砖上。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Local Wikipedia | https://edjefferson.com/localwiki/ |
| 2 | Wikipedia: Special:Nearby | https://en.wikipedia.org/wiki/Special:Nearby |
| 3 | Local Wikipedia（HN 讨论） | https://news.ycombinator.com/item?id=50202285 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
