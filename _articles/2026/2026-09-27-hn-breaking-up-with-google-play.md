---
layout: post
title: >-
  与 Google Play 分手 —— Conversations 作者写下 12 年关系的最后一句
date: 2026-09-27
hn_id: 49855315
categories: [articles]
excerpt: >-
  Daniel Gultsch 用 12 年把一个 XMPP 客户端做成自己的饭碗，再用一年把它从 Google Play 下架。HN 552 分讨论的核心不是告别本身，而是告别信里那句「我每年付 Google 的钱，比我付网费还多 1.5 倍」。
tagline: >-
  Google 一年抽走 1000 欧元，14 天才肯看一眼我的安全更新。
---
## 原文概要

HN 热门榜（/best）上一则 552 分的帖子，来自 Daniel Gultsch 一篇题为《Breaking Up with Google Play: Why Conversations Is Now Free》的博客自述。Gultsch 是 Android 上一款联邦即时通讯客户端 Conversations 的作者——这款 XMPP 客户端自 2014 年 3 月 24 日（恰好 12 年半前）上架 Play Store，长期被视作开源 XMPP 移动端的代表作之一。

告别信里最重要的数字有几个。Google 抽走他 Play Store 总收入的 15%，折合每年超过 1000 欧元——比他的网费贵 1.5 倍，几乎相当于他用三四年换一次的笔记本电脑成本。Gultsch 写道，他与 Google 的关系从一开始就不好：app 更新被拒过无数次，无法计数的两次被下架，其中一次 Google 凭空指控他上传用户联系人；他写博客时正在等一个安全更新通过审核，已经等了 14 天。他在文中特别指出：Google 不区分功能更新和安全更新，把后者延迟数天乃至数周是「outright dangerous」。

收入结构已经发生迁移。Conversations 早年靠企业付费开发、定制功能、服务器部署咨询，后来 NLnet 与欧盟委员会的 grant 接上，Gultsch 表示资金来源「securely funded until the end of 2029」。分发渠道也彻底倒挂：APK 现在通过 F-Droid 分发，可复现构建（reproducibly built）并用他的个人密钥签名。Play Store 营收不再是核心收入来源——「Google doesn't deserve me and my money anymore. I'm done. Fuck the gatekeepers.」

## 讨论焦点

### 15% 的本质：税、租金还是合作分成？

讨论一开始就被这条数字牵住。wccrawford 在排名靠前的回复里替 Google 做了一类辩护：

> "And you were making like 7x as much as they were taking. Without them, you would even get noticed and you'd have made nothing." — wccrawford [c:49855664]

> （译文：你赚的钱其实是他们的 7 倍。没有他们你甚至不会被注意到，也根本赚不到这些。）

Netcob 沿着这个角度反推：

> "It's not just business — it's basically a monopoly. Enough to extract rent while providing a minimal service." — Netcob [c:49855761]

> （译文：这不只是做生意——它本质上是个垄断。能在一项最基础的服务上抽取足够多的租金。）

mitxela 把这个推论推到极端：

> "The app store is full of crappy and malicious software though. Why pay them for something they aren't doing anyway?" — mitxela [c:49856256]

> （译文：可应用商店里到处都是垃圾和恶意软件。它们根本没在做这件事，凭什么还要付钱？）

后续的跟帖把 mitxela 的回答逼到了结论：

> "For the services they currently provide, zero. They provide negative value. If they shut down the play store that will be good." — mitxela [c:49858892]

> （译文：就它们现在提供的服务而言，零。它们提供的是负价值。如果关掉 Play Store 反而是好事。）

围绕「分成」是否合理的争论延伸出一个更具体的问题——这部分租金里有多少实际花在了开发者看得见的服务上。pi-victor 给出了讨论里被反复引用的一句话：

> "I think it bothers OP less that they take a 15% tax than the fact that google provides terrible support for their own play store. If they would take that tax and provide good feedback and speedy version reviews, nobody would ever complain." — pi-victor [c:49855855]

> （译文：我觉得让 OP 难受的倒不是那 15% 的抽成，而是 Google 对自家 Play Store 的支持烂到家。如果它收了这个税同时把反馈和版本审核做快做好，没人会抱怨。）

### 客服灾难：所有大公司都没人接电话

讨论很快从分成滑向 Gultsch 文章里最容易引发共鸣的一段——Google 不让人跟活人说话。happosai 把这写成了他对 Google 方案的最终判决：

> "Yeah that there is no way to talk to a human at Google" is one of the reasons I never recommend a Google solution at current workplace... Or to family."" — happosai [c:49855744]

> （译文：Google「没办法跟一个活人说话」这件事，是我从不向公司、甚至家里推荐 Google 方案的原因之一。）

4chandaily 给出了一段私人化的对照——他一边抱怨大公司客服一边对作者本人道谢：

> "Customer support has gotten so terrible. Now that all big companies have terrible support, none of them are punished for it... If you are here, thank you for Conversations, Daniel, it has been my go-to for years for communicating with friends and family." — 4chandaily [c:49855671]

> （译文：大公司的客服已经烂透了。现在每家都烂，反而没人为此付出代价……如果 Daniel 你在看，谢谢 Conversations，多年来它一直是我跟亲友联系的首选。）

讨论里最具体的一段客服故事来自 crazybonkersai，他回忆起八年前做 Chrome 扩展时遭遇的 Google 支持：

> "Several messages later, I still got these overly friendly elaborated messages, but the issue did not proceed anywhere. I kept explaining my problem and they assured me that they are working on it. Eventually I got bounced to their Android support (my problem concerned Chrome store), which made me think either they were taking a piss or used this tactique on purpose." — crazybonkersai [c:49859039]

> （译文：来回几封邮件，我收到的还是那些过分热情、长篇大论的回复，问题却哪里都不前进。我反复解释，他们一直保证「正在处理」。最后我被转到了它们的 Android 客服——而我提的明明是 Chrome 商店的事——这让我觉得要么是故意的，要么就是它们拿这种话术在糊弄人。）

crazybonkersai 在结尾补了一句「这还是在 LLM 出现之前」，顺手给当下「友好但无用」的客服套了一个共同解释。

### 垄断争议：是 Public Utility 还是被夸大的基础设施？

讨论里有一整支子链在抠 Google Play 究竟算不算「垄断」。Topfi 把它直接拉回既有的法律事实：

> "How is the Play Store not a monopoly? It has been found such by multiple judges in multiple jurisdictions for a reason." — Topfi [c:49855830]

> （译文：Play Store 怎么就不算垄断了？多个司法管辖区、多位法官都判定它是垄断，这背后是有理由的。）

WarmWash 提醒反对者不要忽略另一面的判例——App Store、PlayStation Store、Xbox Store 都被判过「不构成垄断」：

> "Ironically, the Apple App store was found to not be a monopoly. Or the playstation store, or xbox store for that matter. In fact the legal system punishes you for having an open platform." — WarmWash [c:49857335]

> （译文：讽刺的是，苹果 App Store 就被判定不是垄断。PlayStation Store、Xbox Store 也一样。事实上——法律体系会因为你开放平台而惩罚你。）

WarmWash 的意思被 Topfi 反驳了回去——Apple/Google v Epic 的判决重点不在「开放与否」，而在「是否滥用市场地位」。

讨论里另一支反向声音把 Google 类比为「公共事业」。Loquebantur 写得最完整：

> "Google has captured what really is a public utility and should be either state-owned or heavily regulated. (Long) distance communications, just like public roads, breathable air, potable drinking water and so on do not fit into a free market economy" paradigm."" — Loquebantur [c:49855931]

> （译文：Google 抓住了一项本应是公共事业的服务，应当被国有化或严加监管。长途通信、公共道路、可呼吸的空气、可饮用自来水——这些东西根本装不进「自由市场经济」的范式。）

philipallstar 反驳说，市面上不是只有 Google 一家——Apple、Samsung、Huawei、Tencent MyApp、Xiaomi、Oppo、Vivo、Honor 都在做应用商店：

> "And there are other companies: Apple, Samsung, Huawei, Tencent MyApp, Xiaomi, Oppo, Vivo, Honor, K Telecom T-Store, Jio, MTN Play. Not even close to a captured utility." — philipallstar [c:49856071]

Matl 把这条反驳压回桌面现实：

> "Tell me about the different OSes each of Samsung, Huawei, Tencent MyApp, Xiaomi, Oppo, Vivo, Honor etc. run then that we can choose from. It's like saying Windows doesn't have a monopoly in the PC space because HP, Dell, Lenovo, ASUS." — Matl [c:49856131]

> （译文：那你说说 Samsung、Huawei、Tencent MyApp、Xiaomi、Oppo、Vivo、Honor 各家分别跑的是哪几套不同的操作系统，让我们能挑？这就像说 Windows 在 PC 端没有垄断，因为还有 HP、Dell、Lenovo、ASUS。）

「公共事业 vs 多供应商竞争」的辩论在 HN 历史上反复出现，这次的版本里没有任何一方真正说服对方。

### 「Tax 还是 Fee」的语义之争

讨论里最经典的一场分支战发生在「15% 究竟是税还是费」这件事上。chii 给出了一个被广泛转引的论断：

> "people hate taxation without representation. That's why this model has to be unsustainable, but the legislation has not caught up at all." — chii [c:49855880]

> （译文：人们厌恶「无代表则不纳税」。所以这种模式注定不可持续，只是立法完全没跟上。）

bambax 把这条线划到了「税」的一边：

> "It's taxation when it's imposed by a monopoly over users who have no choice except walking away." — bambax [c:49856127]

> （译文：当它由垄断者强加、用户除了离开之外别无选择时，这就是税。）

mitxela 用一个「DQ 汉堡」的反例试图反驳：

> "This definition doesn't work, because my only choice when buying a burger at Dairy Queen is to pay the burger's price or walk away too, but it's not taxation." — mitxela [c:49856184]

> （译文：这定义站不住——我在 DQ 买汉堡，「付钱或者走开」也是我唯一的选择，但那不是税。）

chii 把反驳又推回了现实——汉堡市场有多家供应商，应用商店没有：

> "You don't have a real choice in an app store on android. That's why it's not a tax when you choose to buy DQ burgers, but a tax when you choose to deploy an app to google app store." — chii [c:49856206]

> （译文：在 Android 上你没得选。所以买 DQ 汉堡不是税，把 app 部署到 Google 应用商店是税。）

这条子链最后停在 chii 自己补的一刀上：

> "but that raspberry pi won't be able to run google apps (or other apps like your bank's) that require play store certification." — chii [c:49856999]

> （译文：可那块树莓派跑不了需要 Play Store 认证的 Google 应用——包括你银行的那个 app。）

「替代路径能不能绕开垄断」这件事，被这个例子钉死在桌面上。

### F-Droid：开源分发是否真正可行？

讨论里被反复拎出来的一个可行路径是 F-Droid。gdulli 把这条路径和更早的桌面时代做了对照：

> "It is not a win that we've given up our freedom and privacy to Google, Apple, Steam, etc. because people refused to learn how to click setup.exe." — gdulli [c:49856237]

> （译文：我们把自由和隐私交给了 Google、Apple、Steam，不是因为它们更好，而是因为大家不肯再学一下怎么点 setup.exe。这不是胜利。）

wccrawford 之前提过「几乎没人安装 F-Droid」——这条反对意见也被 N_Lens 的回应轻轻化解：

> "I recommend the book sacred economics" regarding this play."" — N_Lens [c:49855798]

> （译文：关于这种玩法，我推荐读《Sacred Economics》。）

faangguyindia 则展示了一条更具体的「绕开 Google 税」的方法：

> "Our app has 17,000+ users and has never paid a cent to Google :) With a little out of box thinking, you can avoid Google tax." — faangguyindia [c:49855767]

> （译文：我们的 app 有 17000+ 用户，从没付给 Google 一分钱。只要稍微动点脑子，就能避开 Google 税。）

他后续解释了具体做法——在 Google Play 上提供长试用，等用户主动搜索续费时再把订阅页面推到站外，「user is happy」。这条做法的存在本身就把「15% 是行业唯一路径」的论调反证了。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 平台价值 | wccrawford [c:49855664] | 没 Google 你根本赚不到这些，分成是合理的 |
| 租金论 | Netcob [c:49855761] | 这是垄断抽租，不只是做生意 |
| 负价值 | mitxela [c:49858892] | 它们现在提供的服务价值为负，最好关掉 |
| 客服之痛 | happosai [c:49855744] | 「找不到活人」是我永不向家人推荐 Google 的原因 |
| 客服反讽 | crazybonkersai [c:49859039] | 友好但完全无用——这还是在 LLM 出现之前 |
| 法律事实 | Topfi [c:49855830] | 多地法院都已判定 Play Store 是垄断 |
| 反垄断案例 | WarmWash [c:49857335] | Apple、PlayStation、Xbox 都被判不构成垄断 |
| 公共事业 | Loquebantur [c:49855931] | 通信基础设施不是自由市场能管的事 |
| 多供应商 | philipallstar [c:49856071] | Apple、Samsung、Xiaomi 等都在做应用商店 |
| 操作系统垄断 | Matl [c:49856131] | 不同 OEM 跑的都是 Android，没有真正的替代 |
| 收税论 | bambax [c:49856127] | 垄断者强加、用户别无选择，就是税 |
| 汉堡反例 | mitxela [c:49856184] | 垄断者收的钱不该叫税，DQ 汉堡也是付钱或走开 |
| F-Droid 可行 | gdulli [c:49856237] | 桌面时代我们都会点 setup.exe |
| 避开 Google 税 | faangguyindia [c:49855767] | 长试用+站外订阅就能绕开 Google 抽成 |
| 关系尾声 | skybrian [c:49855692] | 文章里也承认 Google 帮他付了多年房租 |
| 自由之争 | Sayrus [c:49855749] | 被困住、被虐待的关系，告别时不会有好聚好散 |

## 总体情绪

讨论的整体情绪偏负面，但远比 HN 上常见的「反大公司」叙事更具体——它锚定在 1000 欧元/年、14 天审核、两次被下架这些可核对的数字上，而不是抽象的「Google 邪恶」一类情绪化结论。Gultsch 那封告别信之所以激起讨论，不是因为他在抱怨，而是因为他在抱怨之前已经把离开的经济条件讲清楚了：他有 NLnet 和欧盟资金撑到 2029，他没有负债，他没有赌气，他只是算完账之后做了决定。

讨论里最有穿透力的几条评论也都遵循这种风格。mitxela 那段「14 天等审核」和「键盘坏了会有人上门修、Google 坏了没人」的对照，把抽象的「被忽视」翻译成了具体的金钱时间。faangguyindia 那条「17000 用户没付 Google 一分钱」的反例，比任何抽象的「垄断」叙述都更有杀伤力——它证明了所谓「别无选择」其实只是分工上的选择。

这场讨论最让人带回的细节，是 Gultsch 在文章结尾写下的那句「Fuck the gatekeepers」。这种情绪并不只针对 Google——它指向一种更广泛的「平台是基础设施却由私企单方面定价」的处境。HN 这次没有给出答案，但给出了足够多的具体数字让任何想认真讨论这个问题的人，可以从「讲道理」开始而不是从「骂 Google」开始。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Breaking Up with Google Play: Why Conversations Is Now Free | https://news.ycombinator.com/item?id=49855315 |

## 免责声明

<div class="disclaimer">
本摘要基于 HN 讨论内容整理，仅代表参与讨论用户的观点，不代表本站立场。
<br><br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
