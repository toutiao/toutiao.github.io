---
layout: post
title: >-
  Google 隐私政策多了一行：Gmail 和照片可以被拿去投广告 — HN 讨论摘要
date: 2026-10-24
hn_id: 50214218
categories: [articles]
excerpt: >-
  10 月 16 日起，Google 在隐私政策里加了一句例外：除非你主动把 Gmail、Drive、Photos 的数据
  交给支持个性化广告的其他服务。评论区读了三遍这句话，然后问：怎么才算你没有主动交？
tagline: >-
  「除非你选择交出」——这句的重量全压在「选择」两个字上。
---

## 原文概要

10 月 23 日晚，The Verge 报道了一条看起来不大的政策改动，而这个改动是 Android Authority 先发现的：Google 更新了隐私政策。原来那版写的是不会拿你的 Drive、Gmail 或 Google Photos 去做个性化广告；从 10 月 16 日起，句尾多了一个例外——除非你选择把这些服务的数据交给支持个性化广告的其他 Google 服务。

触发点是 Google 的 Personal Intelligence 功能。把 Drive、Gmail、Photos 的内容授权给 Search 的 AI Mode 和其他搜索工具，换来更贴合你情况的回答与推荐——此前这只是一份单向的承诺，广告不参与。现在政策原文里写得明明白白：允许 Search 处理你授权给它的部分数据，用于"个性化内容，包括广告"；另一条则说，在某些设置下"我们也可能根据你的兴趣、活动或来自 Google 服务的个性化内容"展示个性化广告，例子是"当你搜索 mountain bikes，在 Search 里你可能会在 YouTube 上看到运动器材的广告"。

边界仍然存在。广告主拿不到你的 Drive、Gmail、Photos 内容，也拿不到姓名、邮箱这类身份信息；Google 不会基于种族、性取向、宗教或健康这类敏感类别投广告。想阻止也有正规入口：在搜索服务的个性化设置页里，把各个应用断开，或者干脆关掉 Personalized Recommendations。

HN 上这个帖子拿到 313 分，162 条评论。

## 讨论焦点

### 争的不是「会不会用」，是「怎么才算你没选」

最先被抬出来的是：这句限制确实存在，而且比多数人以为的更宽松。

> "Since the comments are going to be flooded with people reactively assuming it is straight up directly accessing them, here is the actual qualification:" — zmmmmm [c:50215720]
> （译文：既然评论区马上会涌进一堆凭本能认定他们在直接访问你数据的人，那先把真正的限定条件摆出来。）

反驳的是「用户主动选择」这个前提本身。评论区最流行的一句吐槽是：

> "\"might\" === \"absolutely will\", just for the record." — accrual [c:50215435]
> （译文：顺便记一下，"可能"就等于"肯定会"。）

理由是这一套语言游戏里的"选择"从来不是真正的选择：

> "Even that is a lie, from the formerly Don't Be Evil company." — alvah [c:50217107]
> （译文：连这句都是谎言，出自那家前"不作恶"公司。）

一位读者把 Google 的同意机制总结成两句话：

> "The Google idea of consent is “Yes”, “Ask me again every day until it’s yes”" — Gigachad [c:50217062]
> （译文：Google 式的同意就是：好；再问你一遍，直到你答应为止。）

配合这条政策原文，路径其实不难想象：先在 Android 的官方应用里弹窗请求共享权限（评论区里有人描述过那种不间断、满是暗黑模式的弹窗轰炸），同意一次；再在 Personal Intelligence 里把服务连上；最后那条"除非你选择交出"的例外就被激活了。

### 绕一圈回到照片：间接使用也算用

真正让讨论尖锐起来的是另一条路径——不是"读你的邮件去投广告"，而是"用 Gemini 读你的照片去投广告"。

> "This indirectly uses google photos data to personalize ads so they have to add this rule to their privacy policy." — NoahZuniga [c:50215882]
> （译文：这就间接地用上了 Google 照片数据来做个性化广告，所以他们才必须往隐私政策里加这条规则。）

而按 Google 自己的 Gemini 权限设计，这条路径几乎是默认打开的：

> "You literally can't do anything useful with Gemini (as a Google Assistant replacement) without granting it access to everything." — bastawhiz [c:50216072]
> （译文：你不把权限全交出去，Gemini（作为 Google 助理的替代品）几乎什么有用的事都做不了。）

评论区里最具体的一个例子来自一份 Google 表格。有人在 2023 年减肥，每天往一张名叫 Weight 2023 的表格里加一行体重记录，除此之外没搜过任何减肥产品，也没买过健身器材，结果手机开始收到 Play Store 的健身追踪和卡路里计算器推荐：

> "That's when I realized that yes, Google could tell what I was doing from the title of my spreadsheet and the fact that I added one line to it every day." — rmunn [c:50217605]
> （译文：那一刻我才意识到——是的，光凭表格标题和我每天加一行的动作，Google 就能知道我正在干什么。）

这个例子也立刻招来反驳，方向是"别把什么都往广告上想"：

> "You're just not as unique as you think you are." — Cidan [c:50217884]
> （译文：你没自己以为的那么独特。）

（另一种更省事的解释是：跟你聊过这件事的人本来就在你身边，而 Google 和 Meta 对社交圈子的建模足够细。）

### Gmail 的历史：他们以前就这么干

"这不新鲜"是评论区另一半人的核心论据，而这条论据有历史支撑。

> "Google's always done this, it's the entire reason Gmail exists. Now they're just saying it." — cowlevel [c:50215274]
> （译文：Google 一直就这么干，Gmail 之所以存在就是这个原因。现在他们只是说出来了。）

反驳的人引用的是 2004 到 2017 这段：

> "They originally used Gmail in that way. Many years later they stopped. This was a major victory for privacy." — ViktorRay [c:50215321]
> （译文：他们最初确实那样用 Gmail，很多年后停掉了。那是一次重大的隐私胜利。）

争论停在一句追问上：

> "What's the evidence they stopped?" — cowlevel [c:50215447]
> （译文：他们停掉的证据是什么？）

有人补上了时间线：

> "when gmail launched in 2004, they did indeed target ads based on email content. People did not like it." — genghisjahn [c:50216885]
> （译文：Gmail 2004 年上线时，他们确实按邮件内容投过广告。大家并不喜欢。）

还有人对"为什么后来停了"给了个经济学解释：邮件里带的购买收据信息价值下降，而零售商主动不再在邮件里塞这类数据，Google 从同样的邮件里能榨出的东西就变少了。

### 欧洲：DMA 给了另一套开关

真正有制度意义的一段在评论区被翻了出来——欧盟用户面对的不是同一条政策，而是另一条路径。

> "So at least European users will be able to get personalized search and photos results without also having to share that data for personalized ads." — actapp80 [c:50216043]
> （译文：所以至少欧盟用户可以在不把那份数据同时交给个性化广告的情况下，拿到个性化搜索和照片结果。）

根据 DMA（2024 年 3 月 6 日生效）Article 5(2)，欧盟用户可以选择链接或不链接 Search、YouTube、广告服务、Google Play、Chrome、Shopping、Maps 等服务。但另一个更硬的事实是默认链接清单：

> "The following services are linked by default for users in the European Economic Area (excluding Germany) and can’t be unlinked:" — esperent [c:50218043]
> （译文：以下服务对欧洲经济区用户（德国除外）默认链接，且无法取消链接：）

而这份清单里就包括 Google Photos、Gemini Apps、Messages、Workspace。

围绕监管本身，评论区两极分化。一派认为欧盟的强制开关才是真开关，另一派认为这套监管早就被腐蚀了：

> "Well, if we didn't have corrupt regulators, Google would have been fined out of existence ages ago." — varispeed [c:50215458]
> （译文：好吧，要是没有被腐蚀的监管者，Google 早就被罚到不存在了。）

也有人把矛头指向 S-1 文件里的那句口号：

> "Given that “don’t be evil” featured prominently in their S-1, does this constitute securities fraud?" — jsw97 [c:50217454]
> （译文：既然"不作恶"那句口号在他们的 S-1 文件里 prominently 出现过，这算不算证券欺诈？）

### 定向到底准不准：Meta 赢了

最有意思的反差出现在广告质量上。Google 手上的数据比 Meta 多得多，但两家公司收到的反馈正好相反。

> "The best evidence is just how comically bad their ad targeting is vs Meta" — bensyverson [c:50216471]
> （译文：最好的证据就是他们的广告定向相比 Meta 烂得有多滑稽。）

有人补上了更细的对照：Meta 手上只有 Instagram 的短视频观看记录，Google 手上是你的一生，结果 Meta 的广告更相关。

而"看得见有多糟"的描述非常具体：

> "If I watch just a couple Russian videos on YouTube but never spoke Russian, I get Russians ads!" — Razengan [c:50217368]
> （译文：如果我在 YouTube 上看了几个俄语视频、却从来不说俄语，我就会收到俄罗斯广告！）

同一段里还有：飞到印尼但没看过任何印尼视频，也会收到印尼广告。

反方向的辩护则认为广告本身没什么问题：

> "You've gotta be able to actually show me ads before you can target me with ads." — adamtaylor_13 [c:50215687]
> （译文：你得先真的能给我看到广告，才能拿广告来定位我。）

还有人给出了一个针对广告主本身的损招——不去投消费者的广告，而是给那些买数字广告的公司员工投广告：

> "Targeted ads against workers of companies who buy digital ads." — torben-friis [c:50215866]
> （译文：把定向广告投放给那些购买数字广告的公司员工。）

### 逃出去：换邮箱、自托管照片

讨论最实用的部分，是"那我怎么办"。评论区第一条评论就开始互相问邮箱。

> "What do you use for email?" — noncoml [c:50215254]
> （译文：你用什么邮箱？）

回复里出现了 ProtonMail、FastMail、Tuta、Purelymail、Runbox、Migadu 和自建。反对的理由也很直白：

> "What I want to know is whether Google uses the contents to profile YOU." — throwaway81523 [c:50215328]
> （译文：我想知道的是，Google 会不会用邮件内容来给你画像。）

而"根本离不开 Gmail"这个判断本身，也被逐条拆开：Gmail 在客户端市场份额约 25% 到 30%，不是 100%；真正的问题不在于能不能完全躲开，而在于你到底有多想躲。

> "This is a self-fulfilling prophecy." — msm_ [c:50215771]
> （译文：这是自我实现的预言。）

这一派给出的实操方案出奇地朴素——买一个自己的域名：

> "Get your own domain, then you're free to change provider every 2 months and nobody will realise :-)." — palata [c:50216497]
> （译文：先搞一个自己的域名，之后你每两个月换一次服务商也没人发现 :-)。）

照片这边的主流答案是自托管 Immich，照片服务则是 Ente Photos。

> "PSA: Getting out of Google Photos is both easy and super rewarding if you can run Immich and use Google Takeout." — jmathai [c:50216317]
> （译文：公告一下：如果你能跑起 Immich 并用上 Google Takeout，逃离 Google Photos 既容易又有成就感。）

但真正动手的人立刻发现，取数据本身就是一场苦役：

> "takeout rarely works. Usually fails partway through the export." — boplicity [c:50216687]
> （译文：Takeout 基本不靠谱，通常导出到一半就挂了。）

有人用工作经历反驳，说自己导出过几百个账号、从不到 1GB 到超过 500GB，从没遇到过问题；更常见的折中方案是先导到 Google Drive，再用 rclone 拷出来。另一条现实是"取回来之后也不完全是你以为的那份"——有人的照片重新上传后所有 EXIF 时间戳都变成了导入当天。

### 最后一批人：这有什么新鲜的

总有一批人认为这条新闻不值得讨论。

> "So? what's the harm? At least I'll see targeted ads; ads that I would actually care about and not random ads." — improgrammer007 [c:50216438]
> （译文：那又怎样？至少我看到的会是有针对性的广告，是我真正关心的，而不是随机广告。）

> "They weren't already?!" — jms703 [c:50216746]
> （译文：他们不是早就在这么干了吗？！）

还有一个细节被翻出来当作旧账：你在 Gmail 里点开一个链接，Google 的服务器会顺手对那个链接再发一次请求。

> "Friendly reminder when you click a link in a Gmail message, Google's servers also make a separate HTTP request for that link." — sippingabonedry [c:50215686]
> （译文：友情提醒：你在 Gmail 邮件里点开一个链接时，Google 的服务器也会对那个链接单独发一次 HTTP 请求。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 一直如此，现在只是写出来了 | cowlevel | Gmail 之所以存在就是这个原因，现在他们只是说出来了 |
| 中途确实停过 | ViktorRay | 他们最初那样用，后来停掉了，那是一次隐私胜利 |
| 停没停得有证据 | cowlevel | 他们停掉的证据是什么？ |
| 「你选择」是文字游戏 | alvah | 出自那家前「不作恶」公司，连这个说法本身都是假的 |
| 同意靠反复弹窗拿到 | Gigachad | Google 式的同意：好；再问一遍，直到你说是 |
| 绕一圈还是会用上照片 | NoahZuniga | Gemini 拿照片做上下文再拿去个性化广告，所以政策必须加这条 |
| Gemini 不给全权限就废 | bastawhiz | 不交出全部权限，Gemini 几乎做不了任何有用的事 |
| 广告定向烂得离谱 | bensyverson | 最好的证据就是他们的定向相比 Meta 有多滑稽 |
| 看了也不买 | Razengan | 看几个俄语视频就收到俄语广告，飞到印尼就收到印尼广告 |
| 监管才是真开关 | actapp80 | 欧盟用户可以在不共享数据的前提下拿个性化结果 |
| 默认链接清单里有 Photos | esperent | EEA 用户默认链接且不可取消的服务里就有 Google Photos |
| 监管指望不上 | varispeed | 要不是有腐败的监管者，Google 早就被罚到不存在了 |
| 离不开 Gmail 是自证预言 | msm_ | 你完全可以不用 Gmail，别那么宿命论 |
| 换邮箱前先买域名 | palata | 有自己的域名，每两个月换服务商也没人知道 |
| 逃照片要先受 Takeout 的罪 | boplicity | Takeout 基本不靠谱，通常导出到一半就挂了 |
| 无所谓，反正在免费 | improgrammer007 | 有什么伤害？至少广告是我关心的那种 |

## 总体情绪

这条新闻的体量不大，但它把一整套大家早就默认、却从没人愿意写成一句话的东西摆到了台面上：Google 的个性化广告不需要广告主拿到你的邮件，它只需要自己知道你邮件里写了什么。而"除非你选择交出"这半句话之所以让人不安，是因为在这套体系里，"选择"从来不是一个干净的开关——它是一串藏在弹窗、默认勾选、跨服务联动和多重 opt-out 之间的灰色地带。

讨论里最有意思的分裂不是道德判断，而是事实判断：一派说"早就这样了，现在只是写出来"，另一派说"这次至少写清楚了，可以对着条款去关"。两边其实共享同一个前提——数据早就被拿走了，区别只在于这回它被写进了政策。

而最容易被忽略、也最有信息量的一句来自广告质量：数据最多的 Google，广告却比只拿到你 Instagram 记录的 Meta 更不准。一家能推断你今天体重、健身计划、邮件往来和相册内容的公司，做出来的广告依然笨拙到能靠语言偏好和地理定位来猜——这大概是整场讨论里最不像隐私新闻、却最像隐私新闻的一条。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Now Google says it might use your Gmail and Google Photos data to target ads（The Verge） | https://www.theverge.com/tech/1017600/google-personal-intelligence-privacy-policy-ads-update |
| 2 | Google 账号帮助：DMA 与可链接服务 | https://support.google.com/accounts/answer/14202510?hl=en |
| 3 | Now Google says it might use your Gmail and Google Photos data to target ads（HN 讨论） | https://news.ycombinator.com/item?id=50214218 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br>本文涉及大型科技公司数据使用、在线广告定向与欧盟 DMA 监管等争议性讨论，部分被引言论带有明确立场，引用仅用于还原讨论现场，不构成对任何一方观点的认同或背书。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
