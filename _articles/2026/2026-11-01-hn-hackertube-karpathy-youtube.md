---
layout: post
title: >-
  Karpathy 用两小时和 5 亿 token 造了个 YouTube 替代品 — HN 讨论摘要
date: 2026-11-01
hn_id: 50319510
categories: [articles]
excerpt: >-
  YouTube 的推荐算法优化的是观看时长，HN 二十年的评论区优化的是另一件事。
  两小时、5 亿 token，6,454 个视频——Andrej Karpathy 把两套信号拼成了自己的 YouTube，
  顺便暴露了谁才是真正的瓶颈。
tagline: >-
  他不写代码了。他跟 Claude 聊天，两小时后网站上线。
---

> 来源：HN 讨论帖，提交者 karpathy。帖子：[HackerTube: YouTube built from videos recommended by HN](https://news.ycombinator.com/item?id=50319510)，938 分，290 条评论。原文：[HackerTube](https://karpathy.bearblog.dev/hacker-tube/)（karpathy 博客，2026-10-31 发布）。站内数据取自 [hackertube.org/api/stats](https://hackertube.org/api/stats) 与 [hackertube.org/api/export](https://hackertube.org/api/export)（2026-11-01 读取）。

## 原文概要

起因在周五深夜。周五晚上 11 点，Karpathy 累了，打开 YouTube 想看点东西，看到的却是一堵被「enshittified」的垃圾墙：夸张到荒谬的缩略图，翻来覆去重复的疲惫话题，还有他所说的那种 idiocracy 级（白痴级）内容。他的判断很精确——这套算法对互联网中位数用户可能很有效，对他显然不成立。于是周六早上，他打开 Opus 5.5，给了一句任务描述：那就写一个我们自己的 YouTube 克隆吧，用 HN 上被人推荐过的视频当素材。两小时后，hackertube.org 上线。

做法比想象中暴力。Opus 把 HN 的全部评论拉下来、过滤一遍，再用 Claude Code 的 Workflow 功能让 Sonnet 逐条过一遍，剔掉 spam，最后收敛到 4 万条提到 YouTube 视频的评论，得到 6,454 个视频，横跨 2007 到 2026 年、150 个话题。然后套上 YouTube 的界面，弄个域名，推到一台 VPS 上，做安全加固和优化。站点自己的统计接口给得更细：6,454 个视频、39,834 条被标注的评论、15,041 位推荐者、16 个领域 150 个话题、2007–2026 共二十年。

筛选规则是这套东西的核心，也是它跟「抓热门视频」最大的区别：一个视频要被留下，至少得有三个人在至少三个不同的月份里，带着实质评论链接过它，一次性甩链和纯粹凑热闹的会自然掉队。每条评论由 Claude 判定它的立场——是在推荐这个视频、当成信息来源引用、当玩笑提一句，还是在批评它——同时抽出短引文和话题标签。每个视频最后配一张卡片：摘要、HN 为什么喜欢它、它属于哪一类、是否经得起时间。排名的依据是「被多少个不同月份推荐过」，而不是点赞数。

包装上刻意反着做：不用上传的缩略图，改用视频中段 50% 位置的截图；For You 推荐自己实现，不需要账号，状态存在浏览器本地 session；带键盘快捷键（按 `?` 看全部，`/` 搜索，`j`/`k` 移动）。

Karpathy 随后的补充说明了工作流本身。他用 Claude Code 桌面版（Mac），Opus 5.5，Medium effort，并且明确说自己已经不做任何像传统工程的事——不读代码、不写代码、不在终端敲命令，只跟 Claude 说话，让它去干。人工部分只有三件：在 Google Cloud 界面里建一个查 YouTube 视频元数据的 API key、启动一台 VPS、买域名。服务器起来之后，他把 IP 给 Claude，说「更新、部署、加固、优化」，它就把整件事做完了。

数据是可以带走的。站点提供 `hackertube-data.zip`（约 17.8 MB，ODC-By 1.0 许可），里面是 `videos.jsonl`（6,454 行）、`mentions.jsonl`（39,834 行，34.7 MB，每条含评论 id、作者、月份、立场、理由、引文和清洗后的原文）、`taxonomy.json`（150 个话题分类）、`related.jsonl`（3,778 条「HN 的人也推荐」）、`embeddings.npy`（bge-small 搜索向量），以及一份专门写给 agent 看的 `DATA.md`。服务端代码没有开源——理由在评论区的讨论里。

## 讨论焦点

### 一、这笔账到底是 250 美元还是 0 美元

Karpathy 本人在被问到 token 成本时，给的是一份自报账：

> "I'm on subscription but I had Claude add it up: 504M input tokens (90% cached), 7.6M output tokens." — karpathy [c:50319793]
> （译文：我用的是订阅制，但我让 Claude 算了一下：5.04 亿输入 token（其中 90% 命中缓存），760 万输出 token。）

> "90+% of that was Sonnet calls to label the comments, all of the actual work, the app and deploy etc was ~1M tokens of Opus 5.5, I compacted context once." — karpathy [c:50319793]
> （译文：其中 90% 以上是 Sonnet 给评论打标签的调用；真正写应用、部署这些活总共只用了大约 100 万 token 的 Opus 5.5，中途压缩过一次上下文。）

这个数字立刻被翻译成钱，而且出现了两种口径。senko 直接按 API 单价折算：

> "It'd cost ~$250 via API (ie. paying current API pricing per token). Source: copy pasted the tokens into a chatbot and told it to figure it out." — senko [c:50320649]
> （译文：按 API 计费（也就是按当时的每 token 单价付费）大概要 250 美元。来源：把那串 token 数字粘进一个聊天机器人，让它自己算出来的。）

mips_avatar 算出来是 300 美元，顺带提出了一个更根本的抱怨：

> "I wish someone would make a decision model that’s as good as sonnet but like 10-100x cheaper." — mips_avatar [c:50319993]
> （译文：我真希望有人做一个跟 Sonnet 一样好用、但便宜 10 到 100 倍的判定模型。）

> "Because for this project which is a pretty small dataset you’re spending ~$300 on sonnet usage." — mips_avatar [c:50319993]
> （译文：因为就这个项目、数据集还这么小，你在 Sonnet 上已经花掉大约 300 美元了。）

答案的反方向是本地小模型。gambiting 举了个亲身例子——用 GLM 5.3 Flash 把家里那台跑着老服务的机器整个迁到新 droplet 上，顺手把系统加固到十年不用看：

> "GLM 5.3 Flash is incredibly cheap and imho as good as or better than Sonnet." — gambiting [c:50320277]
> （译文：GLM 5.3 Flash 便宜得离谱，而且在我看来不比 Sonnet 差，甚至更好。）

> "it took about an hour, and cost a grand total of 4 american.... _cents_" — gambiting [c:50320277]
> （译文：整个过程大约一小时，总成本是 4 美分——原文写作 `4 american.... _cents_`，把美元和分故意混在一起。）

但同一个人给了个限定：

> "GLM is really good, but sonnet outclasses it. Anthropic really cooked with sonnet 5+" — mips_avatar [c:50321815]
> （译文：GLM 确实很好，但 Sonnet 还是压过它。Anthropic 在 Sonnet 5+ 上是真的下了功夫。）

这组争论的实际含义是：Karpathy 这套流程里真正贵的是「让 Sonnet 读完 4 万条评论并判断每条的立场」这一步，而这一步恰好是可以被更便宜的模型替换的。剩下的活——写应用、部署、加固——大约 100 万 token，占比不到 1%。

### 二、他没写一行代码，而且代码写得很糟

Karpathy 说没开源服务端，理由给得很坦率：

> "I didn't publish the server because it's a vibe coded mess, but if you point your Opus 5.5 at the zip and ask for YouTube-like site it will be basically instant. This part was like 3 min." — karpathy [c:50320084]
> （译文：我没把服务端开源，因为那是一坨 vibe coding 出来的乱码；但你只要把那个 zip 丢给 Opus 5.5，让它做一个 YouTube 风格的站，基本是瞬间的事。这一步大概 3 分钟。）

这句话背后是一个更值得注意的事实：这个站在帖子发出后的几十分钟里，被评论区当成了产品需求单用。Karpathy 在评论里贴出了一份改动清单：

> "Filters on search and topic pages: upload date, duration, type (talk, lecture, documentary, ...), and sort by upload date, view count, etc." — karpathy [c:50320460]
> （译文：搜索页和话题页加了筛选器：上传日期、时长、类型（演讲、讲座、纪录片……），还能按上传日期、播放量排序。）

> "HackerTube Longs: every video over an hour, right where YouTube puts Shorts." — karpathy [c:50320460]
> （译文：HackerTube Longs：所有超过一小时的视频，就放在 YouTube 放 Shorts 的那个位置。）

他给的回应方式也简单到有点粗暴：

> "added and pushed!" — karpathy [c:50320058]
> （译文：加上了，已经推上去了。）

怀疑派也有，而且说得很具体。codingisfreedom 的问题不是「AI 能不能写」，而是「AI 会不会收手」：

> "I am not even remotely getting that kind of thoroughness from claude with opus 5.5 or anything really." — codingisfreedom [c:50320117]
> （译文：说实话，用 Opus 5.5 或者别的什么模型，我完全得不到这种程度的细致。）

> "It seems to want to stop as soon as it thinks it figured things out and then the rest of the conversation is just itself saying that its previous claims were wrong." — codingisfreedom [c:50320117]
> （译文：它好像一旦觉得自己搞明白了就急着收手，剩下的对话全是在自我推翻之前说过的话。）

同一场讨论里，另一种判断也很有代表性：

> "you have to admit that what he did here shows the distance of how easy it is to get from prompt to a working prototype if you have a clear idea of what you want to do" — iugtmkbdfil834 [c:50320201]
> （译文：但你得承认，他这次做的事说明了这样一件事：只要你心里有一个清楚的想法，从一句 prompt 走到一个能跑的原型，中间已经短到了这种程度。）

### 三、HN 也是算法

最直接的反例来自 ajs1998：

> "Unfortunately HN is just another algorithm." — ajs1998 [c:50321521]
> （译文：可惜 HN 也只是一个算法。）

> "This is indeed a HN video site and I hate it lol." — ajs1998 [c:50321521]
> （译文：这确实就是个 HN 视频站，而我讨厌它，哈哈。）

他指出的具体毛病是：HN 的品味里有一部分和自己重叠，但混进了太老的老视频，以及那些他明知道自己再也不想看的频道。sublinear 说得更细：

> "Considering that every Veritasium and Technology Connections video ever made has gotta be linked in there, I think you need to check your biases." — sublinear [c:50321529]
> （译文：考虑到 Veritasium 和 Technology Connections 做过的那每一个视频大概都被链进去了，我觉得你该检查一下自己的偏见。）

而在看到有人把 HN 与 Reddit 的公开意见做成可视化产品之后，他的反应是：

> "I love that this perfectly highlights all the HN astroturfing." — sublinear [c:50322027]
> （译文：我喜欢这个，它把 HN 的那些水军痕迹照得清清楚楚。）

更直接的反对来自 fortran77：

> "Really? I quickly found some awful horrific racist material on "HackerTube". No thanks." — fortran77 [c:50321269]
> （译文：真的？我在 HackerTube 上很快就翻到了可怕的种族主义内容。不了，谢谢。）

这段合起来说明的事情是：HN 的品味不等于普遍意义上的好品味。Karpathy 换掉的只是推荐源，不是人类判断这件事本身。

### 四、YouTube 的推荐到底在优化什么

讨论中最锋利的一刀来自 rileymat2：

> "I am not sure the personalize algorithm is based on what you want to watch, but what will keep you watching. That’s a measurable KPI." — rileymat2 [c:50320297]
> （译文：我不确定那个个性化算法是基于你想看什么来做的，更可能是基于什么能让你继续看下去——那是个能量化的 KPI。）

而 HackerTube 的命中率反常地高：

> "I find it amazing how close the front page of this is to what I actually watch/want to watch on YouTube." — reorder9695 [c:50319961]
> （译文：这个站首页跟我真正会在 YouTube 上看的、想看的东西有多接近，我觉得挺离谱的。）

不过「命中率高」和「推荐精准」不是一回事。Barrin92 讲的是那个经典的负反馈陷阱：

> "I watched one news video about the pope and now half of my feed is Catholic news channels." — Barrin92 [c:50321560]
> （译文：我看了一条关于教皇的新闻，现在推荐流里一半都是天主教新闻频道了。）

> "I buy a mattress on Amazon and I get recommendations for... ten other mattresses?" — Barrin92 [c:50321560]
> （译文：我在 Amazon 上买了张床垫，它给我推荐了……另外十张床垫？）

也有认为推荐算法本身不算太糟的。jumploops 觉得短视频那边反而更强：

> "I rarely use TikTok, only to view links people send me (similar to YouTube), but the recommended content is miles ahead, making it much more difficult to close compared to YT." — jumploops [c:50319845]
> （译文：我很少用 TikTok，只看别人发给我的链接（这点跟 YouTube 一样），但它推荐的内容强太多了，比 YouTube 难关掉得多。）

而 zmmmmm 描述的是个性化推荐带来的方向性偏差——它不只让你看得多，还让你看得越来越窄：

> "I realised after a while that one of the main reasons I go online is to expand my horizons." — zmmmmm [c:50321152]
> （译文：我后来意识到，我上网的一个主要理由就是拓宽自己的视野。）

> "So it turns out personalised feeds are actively curating against what I'm looking for." — zmmmmm [c:50321152]
> （译文：所以说到底，个性化推荐是在主动地跟我想要的东西对着干。）

Karpathy 给出的解释是这个讨论里最反直觉的一段：

> "I think many experiencing the same thing but we're way too small drop of a drop in the bucket that it doesn't even resolve in all of their measurements and A/B tests." — karpathy [c:50322226]
> （译文：我觉很多人有同样的感受，但我们在他们的全部指标和 A/B 测试里都小到可以忽略不计，连一个水花都溅不起来。）

> "Basically I think we see a massive deterioration of quality because we are a rounding error." — karpathy [c:50322226]
> （译文：基本上，我们看到质量大幅滑坡，是因为我们只是四舍五入之后的余数。）

这句解释的逻辑是：推荐系统里的梯度信号（gradient signal）绝大部分来自大众用户，HN 这种小群体在对方的指标里根本不产生偏移，于是任何针对 HN 用户优化的行为，在 YouTube 那边既看不见也测不出来。

### 五、不等 Karpathy 也能自救

评论区有一整条线在讨论怎么在 YouTube 内部绕开推荐。ssl-3 的经验是反直觉的——用得越久，feed 越准：

> "My YouTube feed is pretty good; it's full of technical discourse on topics that I enjoy learning about, ranging from electronics hacking to civil engineering." — ssl-3 [c:50320431]
> （译文：我的 YouTube 推荐流其实挺好的，全是我喜欢学的技术话题，从电子 hacking 到土木工程都有。）

> "It works well enough that an unfiltered, logged-out view of YouTube is completely and utterly appalling by comparison." — ssl-3 [c:50320431]
> （译文：它好到这种程度，以至于 YouTube 那个未登录、未经过滤的首页相比之下简直糟糕透顶。）

于是结论变得很直接：不是 YouTube 的推荐不行，是登录状态让它在替你想。nwmck 的做法是直接砍掉：

> "Recommendations aren’t optimized for your benefit. Cutting out the recommendations really helps to not get sucked in." — nwmck [c:50319983]
> （译文：推荐机制本来就不是为你的好处优化的。直接把推荐砍掉，对不被它吸进去很有帮助。）

cush 用扩展把这件事自动化了，数字很直观：

> "I’ve had the UnTrap for YouTube extension installed for a while to remove all the shorts, feeds and algorithmic content and my YouTube consumption has gone down by like 90%." — cush [c:50322468]
> （译文：我装 UnTrap for YouTube 这个扩展有一阵子了，把 Shorts、推荐流和算法内容全去掉，我的 YouTube 消费下降了大概 90%。）

不想装扩展的，tmoertel 给了个一键方案：

> "Tired of low-effort YouTube clickbait slop? Just click on the Subscriptions heading to go to https://www.youtube.com/feed/subscriptions." — tmoertel [c:50322628]
> （译文：受够了 YouTube 那种低质标题党？直接点侧栏的 Subscriptions，去 https://www.youtube.com/feed/subscriptions 就行。）

uvu 走的是另一个极端，直接开一个新账号：

> "If I want to watch something I have to type and search, there is no recommendation and it's been great so far." — uvu [c:50321790]
> （译文：现在我想看什么就得自己打字搜，没有推荐，用下来感觉好多了。）

### 六、真正的门槛不是技术

numbasys 指出，大部分人卡住的地方根本不在模型：

> "In my opinion this is the part that's holding back _a lot_ more people from publishing." — numbasys [c:50321002]
> （译文：在我看来，正是这一步挡住了很多人不敢把自己的东西发出来。）

他指的是「推到 VPS、买域名、长期维护」这一段。moffkalast 把这层顾虑说得更实在：

> "I've always been put off by the continuing financial obligations personally. Like I'll invest a considerable amount for one time things easily, but year after year with constantly increasing costs? No fuckin way." — moffkalast [c:50321063]
> （译文：说实话，一直让我打退堂鼓的是那些持续产生的费用。一次性投入一大笔钱我没什么犹豫，但年年都要付、而且还越来越贵？门儿都没有。）

而推荐流差这件事本身，在另一派人看来根本不是产品缺陷，是商业模式：

> "Bad by what metric? They're interested in getting you to watch ads, they couldn't care less what you want." — globular-toast [c:50319919]
> （译文：按什么标准算「差」？他们的目标就是让你去看广告，你想要什么他们根本不在乎。）

> "I suspect they know perfectly well when they can't make money from someone, so they deliberately serve up boring crap to save on hosting costs." — smokel [c:50319900]
> （译文：我怀疑他们非常清楚哪些人身上赚不到钱，于是故意给这些人塞无聊内容，顺便省下托管成本。）

### 七、合规、商标和隐私

站点能活多久，取决于 Google 的态度。GodelNumbering 的担心有历史依据：

> "Although I have heard in the past that youtube is quick to ban any use of its content on a third party site." — GodelNumbering [c:50319962]
> （译文：不过我听说 YouTube 过去对第三方站点使用其内容一向反应很快。）

albert_e 问得更直接：

> "But is this compliant with Google / YouTube terms?" — albert_e [c:50322413]
> （译文：这符合 Google / YouTube 的服务条款吗？）

支持方的技术解释是站得住的：globalnode 指出这不涉及复制内容，xpct 把它说成一条更精确的界线：

> "its not copying the content, its just a recommender system that links to the video stored on youtube." — globalnode [c:50322410]
> （译文：它并没有复制内容，只是一个指向 YouTube 上视频的推荐系统。）

> "The Algorithm is what YouTube sells. This is only a static collection of videos with YouTube embeds." — xpct [c:50322425]
> （译文：YouTube 卖的是算法。这只是一个带 YouTube 嵌入播放器的静态视频合集。）

真正的雷点是 logo。doginasuit 的提醒被当场采纳：

> "You may want to change the logo, it is a different color but close enough to cause confusion." — doginasuit [c:50320222]
> （译文：logo 你可能得改一下，颜色虽然不同，但接近到足以让人混淆。）

隐私是另一个角度。privacyishuman 注意到了 youtube-nocookie 仍然在加载追踪脚本：

> "Could you block all the trackers from loading from https://www.youtube-nocookie.com on your side?" — privacyishuman [c:50319765]
> （译文：你那边能不能把 https://www.youtube-nocookie.com 加载的所有追踪脚本都拦掉？）

### 八、数据从哪来，以及这事一年前就有人做过

取数这一步在评论区被拆解了一遍。gambiting 的惊讶是：

> "I'm actually surprised this was that easy to do, ngl" — gambiting [c:50320237]
> （译文：说实话，我真没想到这事儿能这么容易。）

dang 指出了真正的坑：

> "HN's Firebase-based API (https://github.com/hackernews/api) makes that easy, until you want to reconstruct the threads (i.e. who replied to who) and then it's annoying." — dang [c:50320641]
> （译文：HN 那套基于 Firebase 的 API（https://github.com/hackernews/api）让这件事变得很容易，直到你想把评论树还原出来（也就是谁回复了谁），那就烦人了。）

至于怎么绕开 API 逐条抓，Karpathy 指向了现成的数据集：

> "There turns out to be an export on HuggingFace as well as a bunch of parquets." — karpathy [c:50320784]
> （译文：结果发现 HuggingFace 上有一个 HN 的导出，还有一堆 parquet 文件。）

xpct 补了个体量感：

> "I believe the full dataset is under 20GBs." — xpct [c:50322405]
> （译文：我认为全量数据集不到 20GB。）

最后是这件事并不新鲜。有人翻出了几乎一模一样的前作：

> "Only 12 upvotes - I guess his name wasn’t Karpathy." — beaker52 [c:50320885]
> （译文：只有 12 个赞——我猜作者不叫 Karpathy。）

> "Someone did something similar for the current front page: https://hn.video" — Doohickey-d [c:50320102]
> （译文：已经有人做过类似的东西了，针对当前 HN 首页：https://hn.video）

一年前那个版本只拿到 12 分。Karpathy 对数据会不会消失的回应是：

> "The site won't disappear (imminently, as I'd like to use it personally!) but head over to the about/ section and download the .zip with the underlying data, which I put up for this purpose." — karpathy [c:50319817]
> （译文：这个站短期内不会消失（我还想自己用着呢！），但你可以去 about/ 页面把底层数据的 zip 下载下来，我放上去就是为了这个。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 订阅制下这笔账约等于零 | karpathy | 5 亿输入 token 里 90% 命中缓存 |
| 按 API 价算是 250 美元 | senko | 把 token 数粘进聊天机器人算出来的 |
| 同一笔账算成 300 美元 | mips_avatar | 数据集不大，Sonnet 一项就 300 美元 |
| 便宜模型够用 | gambiting | GLM 5.3 Flash 迁一台老服务器只花 4 美分 |
| 但 Sonnet 更强 | mips_avatar | GLM 很好，Sonnet 还是压过它 |
| 服务端是 vibe coding 垃圾 | karpathy | 没开源，但扔给 Opus 5.5 重建只要 3 分钟 |
| 评论区被当成需求单 | karpathy | 一小时内加完筛选、排序、Longs |
| LLM 收手太早 | codingisfreedom | 它一旦觉得搞明白就停，剩下的对话全在自我推翻 |
| prompt 到原型的距离 | iugtmkbdfil834 | 想法清楚时，这段距离已经短得离谱 |
| HN 也是算法 | ajs1998 | 这确实就是个 HN 站，而我讨厌它 |
| HN 有自己的偏好 | sublinear | Veritasium 那一票视频肯定都在里面 |
| HN 的水军痕迹 | sublinear | 这个项目把 astroturfing 照得清清楚楚 |
| 社区不保证内容干净 | fortran77 | 很快翻到了种族主义内容 |
| 推荐优化的不是你看什么 | rileymat2 | 优化的是让你继续看，这是可量化的 KPI |
| 非个性化流命中率更高 | reorder9695 | HN 流的命中率比「个性化」的 YouTube 高 |
| 一次误触毁掉一周 | Barrin92 | 看一条教皇新闻，首页一半变成天主教频道 |
| 短视频推荐反而更强 | jumploops | TikTok 的推荐内容强得多，也难关掉得多 |
| 个性化在对抗你的兴趣 | zmmmmm | 上网是为了拓宽视野，推荐却在收窄它 |
| 我们只是余数 | karpathy | 在他们的 A/B 测试里小到不产生任何影响 |
| 长期训练能救回来 | ssl-3 | 我的 YouTube 推荐流全是爱学的技术内容 |
| 砍掉推荐就赢了 | nwmck | 推荐从来不是为你优化的 |
| 扩展能砍掉 90% 消费 | cush | UnTrap 扩展去掉 Shorts 和算法流 |
| 一键只看订阅 | tmoertel | 点 Subscriptions 标签页信噪比立刻提升 |
| 真门槛是持续成本 | moffkalast | 一次性投入无所谓，年年付费不行 |
| 卖的是广告不是你想看什么 | globular-toast | 你的兴趣跟他们的收入无关 |
| 只嵌链接不复制内容 | globalnode | 静态合集 + 嵌入播放，不碰他们的内容 |
| 算法才是 YouTube 卖的东西 | xpct | 这只是一个带嵌入播放器的静态合集 |
| 商标近似有风险 | doginasuit | logo 换个颜色，但仍可能引起混淆 |
| 全量数据不到 20GB | xpct | 数据集比想象的小 |
| 一年前就有人做过 | beaker52 | 只有 12 个赞，作者不叫 Karpathy |

## 总体情绪

这场讨论同时给出了两个不太舒服的结论，而且是同一个结论的两面：一方面，Karpathy 证明了一件事——把「近四万条评论、二十年攒下来的口碑」变成一个可用产品，门槛已经降到两小时、五亿 token 和一张订阅卡；评论区的反应不是羡慕技术，而是迅速分成两派，一派开始算成本（250 美元还是 0 美元），一派开始算合规（YouTube 会不会封你、logo 会不会被告）。

另一方面，几乎所有实际用过 YouTube 的人都指出，Karpathy 解决的问题对自己并不成立。推荐机制存在的前提是「你还想要它给你点什么」，而一旦你接受「我想要什么我自己知道」，土办法就够用：关掉历史记录、装个扩展砍掉算法流、只点 Subscriptions 标签页、或者干脆换一个新账号。评论区里最让人意外的不是这些技巧，而是 ssl-3 那句「未登录的 YouTube 首页糟糕透顶」——推荐质量不是算法问题，是状态问题。

Karpathy 自己的回答可能是整场讨论里最有价值的一句：在对方的指标里，HN 这种小群体小到只是四舍五入后的余数，所以任何针对这类人的优化在 YouTube 那边既看不见也测不出来。这既解释了为什么一个用 HN 评论做出来的站命中率更高，也解释了为什么它注定停留在 6,454 个视频——它服务的是一群在任何主流指标里都不存在的人。而当推荐系统可以被两小时和五亿 token 复制出来的时候，被算法决定看什么这件事，就不再是一个不可逆的工程事实了，它变成了一次可以随时重来的选择。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | HackerTube: YouTube built from videos recommended by HN（HN 主帖，938 分，290 条评论） | https://news.ycombinator.com/item?id=50319510 |
| 2 | HackerTube（karpathy 博客原文，2026-10-31） | https://karpathy.bearblog.dev/hacker-tube/ |
| 3 | HackerTube · About（站点自述构建方法与导出清单） | https://hackertube.org/about |
| 4 | HackerTube 数据导出清单（/api/export） | https://hackertube.org/api/export |
| 5 | HackerTube 站点统计（/api/stats） | https://hackertube.org/api/stats |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中提到的 token 消耗、成本估算、模型版本与站点数据均来自原帖评论与 2026-11-01 读取的 hackertube.org 公开接口，站方数据可能随站点更新而变化，本文未做独立复核。「推荐机制在替谁优化」「HN 品味是否等于好品味」等均属评论者个人判断，非事实结论。讨论中提到的关历史记录、装扩展、只看订阅等规避方式为个人做法，各平台策略随时可能调整。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
