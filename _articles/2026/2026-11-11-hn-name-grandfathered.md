---
layout: post
title: >-
  Verisign 撤回终止 22,000 个 .name 三级域名的计划：存量保住，新注册关门 — HN 讨论摘要
date: 2026-11-11
hn_id: 50442736
categories: [articles]
excerpt: >-
  Verisign 撤回终止 22,000 个 .name 三级域名和邮件转发的计划，存量域名无限期保留，但三级注册彻底
  关门。评论区真正没吵完的是：一个 TLD 的运营方能不能单方面注销客户资产，以及域名在法律上到底
  算不算财产。
tagline: >-
  域名从来不是被保护住的，只是这次保护它的人还在。
---

> 来源：HN 讨论主帖 [.name Grandfathered](https://news.ycombinator.com/item?id=50442736)（602 分，134 条评论），原文是 Neil Fraser 的博客 We won!；主帖由 p4bl0 提交。本篇为 single post 模式。归档快照 2026-11-10 22:56 UTC，入库评论 100 条。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 11 月 10 日，Neil Fraser 在自己的博客上只写了三个字：We won!。Verisign 撤回了终止 22,000 个 .name 域名和邮件转发服务的计划。落地的方案是：三级域名（third-level domain）不再接受新注册，但所有存量域名和对应的邮件转发无限期保留。配套文件是 ICANN 在 11 月 5 日发布的共识政策文件 Kane to Fessenden，取代了 7 月 28 日那份被作废的旧提案。

问题的根子在于 .name 是一个设计独特的 TLD。正常的 TLD 里，john.smith.com 和 drew.smith.com 都归 smith.com 的所有者，第三方无权在下面各自注册。而 .name 允许你直接注册 one.someone.name、two.someone.name 这样彼此完全独立、持有人完全不同的三级域名——第三方和二级域名所有者之间没有这层父子关系。Verisign 在 2026 年 7 月的说法是手上有大约 22,000 个这样的三级域名。这套设计当年是 .name 的卖点，也是十年后它自身的死穴。

这场仗打得不便宜。Neil Fraser 在原文里点名感谢了从发起者 Doytchin、飞到巴厘岛当面陈情的 Jim、写正式复议请求的 Patrik、Troy、Huyen 等人，到在 Petillion.law 的律师 Jan、Flip 和 Diégo，再到二十多个写信声援的人；他还特意提到 ICANN 内部那些顶住官僚体系的人。上一轮同一话题的讨论发生在 69 天前，那条 HN 主帖底下有 547 条评论。评论区里的一句总结是：Resistance is not futile, and with a lot of money to burn。

但保下来的只是存量，不是生意。新的三级注册通道关闭，二级域名（smith.name 这一层）继续正常销售，而未来随着三级域名被释放，被让出来的二级域名随时可能被重新拍卖。另外，撤回不等于立刻停止接单：mixdup 提醒说三级注册目前似乎还能抢，在新提案走完流程之前动手的人还赶得上。Verisign 方面的说法由 troyrollo 转述——存量三级域名和存量邮件转发会被 grandfathered，新的 RSP（Registry Service Provider）只是不再把这些服务作为新服务提供，Verisign 则保证至少会有一家注册商继续支持这两项。

## 讨论焦点

### 一、被砍掉的不是 .name，是三级域名

评论区第一波分歧是事实层面的：很多人默认「Verisign 要关掉整个 .name」。lambda 是最早指出这条误读的人。

> "Did you read the link?" — lambda [c:50443437]
> （译文：你读过那个链接了吗？）

> "They were apparently planning on shutting down the whole TLD. They will be leaving it up for existing registrants, but not allowing new registrations." — lambda [c:50443437]
> （译文：他们当时显然打算关掉整个 TLD。现在是把它留给存量注册人，但不再接受新注册。）

真正被砍的东西，ksala_ 讲得最清楚：

> ".name allowed you to register &quot;one.someone.name&quot; and &quot;two.someone.name&quot; as completely separated domains with completely separated owners." — ksala_ [c:50443489]
> （译文：.name 允许你注册 one.someone.name 和 two.someone.name 这样完全独立的域名，持有者也完全独立。）

同一个人还给了一句收尾的判断：注册量已经撑起了一整套独立代码路径，当年不要求新注册者同意限制注册商责任的合同，所以直接注销在法律上站不住脚。

> "I understand why they should grandfather in existing domains but this was just madness." — ksala_ [c:50443489]
> （译文：我理解他们应该把存量域名保留下来，但这做法纯粹是疯了。）

而 duskwuff 补上了历史的一环：三级注册本来就是 .name 的起点，是二级注册的需求太旺，才把整个结构推到了今天这一步。

> "It was initially! But there was enough demand for second-level registrations that they opened that up too (and set the stage for this whole mess)." — duskwuff [c:50444263]
> （译文：起初确实是！但二级注册的需求太旺，他们也放开了二级注册（这才为今天这整件事埋下了伏笔）。）

xigoi 用一句话收束了整场误会：

> "The third-level domains are still being discontinued, it’s just that people who already have one get to keep it." — xigoi [c:50443852]
> （译文：三级域名确实还在被取消，只是已经持有的那些人可以留着。）

### 二、Verisign 图的到底是什么

对商业动机的猜测几乎是共识。giancarlostoro 说他当初就认为这才是唯一合理的结局，并且顺手把 Verisign 的算盘说了出来：

> "Allow existing customers to keep renewing, but nobody new allowed, if a tld frees up over time, reclaim it completely and sell it off." — giancarlostoro [c:50443236]
> （译文：允许现有客户继续续费，但不再接纳新人；等某个 TLD 随时间空出来，就整个收回来卖掉。）

> "What they were proposing should really be illegal..." — giancarlostoro [c:50443236]
> （译文：他们那套提案真的应该是违法的……）

echelon 的说法更直白，把二级域名称作极客圈的高端地产：

> "This is essentially premium real estate now. For us nerds, anyway." — echelon [c:50444287]
> （译文：这下本质上就是高端地产了。至少对我们这些极客来说。）

nikanj 算的是另一笔账——真正值钱的是拍卖二级域名，而不是每年收 20 美元：

> "There would be great money to be made if you could auction off domain.name, instead of being stuck just getting $20 per year because some geezer registered his.domain.name." — nikanj [c:50446199]
> （译文：要是能拍卖 domain.name，能赚到的钱多得多，而不是因为某个老家伙注册了 his.domain.name，就只能一年收 20 美元。）

连动机本身都有人质疑，kwanbix 的直觉是这摊业务成本接近于零，关它图什么：

> "Why would they even want to close it? It is probably close to 0 cost tot hem. Or am I wrong?" — kwanbix [c:50443287]
> （译文：他们为什么要费劲关掉它？成本对他们来说大概接近 0 吧？还是我想错了？）

### 三、真正卡住这项业务的是公共后缀列表

技术层面的讨论比商业动机更硬。.name 的三级域名没有父子继承关系，这在浏览器眼里就意味着 john.smith.name 和 drew.smith.name 是两个互不相干的域——可它们共用一个二级后缀。

> "It has weird interactions with some modern browser features. For example domain isolation doesn&#x27;t apply between subdomains of the same TLD, so john.smith.name and drew.smith.name don&#x27;t get isolation in naive implementations." — swiftcoder [c:50444248]
> （译文：它和现代浏览器的一些特性有奇怪的交互。例如域隔离在同一 TLD 的子域之间不生效，所以在朴素实现里 john.smith.name 和 drew.smith.name 拿不到隔离。）

而浏览器判断「这两个域名归不归同一个人管」，靠的是公共后缀列表（Public Suffix List）。OkayPhysicist 一句话点到了要害：

> "The real problem is that we&#x27;d have to add a wildcard to the public suffix list. That&#x27;s it." — OkayPhysicist [c:50445588]
> （译文：真正的问题是，我们得给公共后缀列表加一条通配规则。就这一件事。）

但通配也不是好答案，toast0 指出名单的大头根本不在三级：

> "*.name isn&#x27;t a good solution either, because the vast majority of registrations are at the second level." — toast0 [c:50446502]
> （译文：*.name 也不是好方案，因为绝大多数注册都在二级。）

他还算了一下规模。Verisign 2026 年 7 月的说法是大约 22,000 个三级域名；共享的二级域名数量没公布，但有限，而现有公共后缀列表有 10414 条，所以最坏情况下这份名单也就膨胀到三倍左右：

> "The current public suffix list includes 10414 names [2]; so at maximum, the list would approximately triple in size --- not ideal, but feasible." — toast0 [c:50446606]
> （译文：现有公共后缀列表包含 10414 个名字；所以最坏情况下，这份名单大概会膨胀到三倍——不理想，但可行。）

不过 toast0 提出的正确做法比通配更麻烦：得把每一个挂了多个三级注册人的二级域名逐个列进去，还要跟着域名到期不断增删：

> "there might be three registrants under .example.name today, but if they all (or all but one) stop paying, example.name is no longer a public suffix and it should be removed." — toast0 [c:50446502]
> （译文：今天 .example.name 下面也许有三位注册人，但如果他们全都不续费（或者只剩一位不续），example.name 就不再是公共后缀，应该被移出去。）

troyrollo 则干脆认为整套机制就不该存在：

> "The public suffix list is a stupid hack that should be replaced by formal protocols allowing boundaries to be defined by either DNS entries, or a file on the web server." — troyrollo [c:50446807]
> （译文：公共后缀列表是个愚蠢的补丁，应该换成正式协议，让边界由 DNS 记录或者 web 服务器上的一个文件来定义。）

### 四、域名到底算不算财产

这一段的争论有法条支撑，也有反着说的。schoen 先搬出判例：

> "There is a Ninth Circuit decision that domain names are a form of property" — schoen [c:50444179]
> （译文：美国第九巡回上诉法院有一个判决，认定域名属于某种形式的财产。）

但他立刻给这份乐观泼了冷水——现代注册局和注册商之间的合同丛林，会把注册人的财产诉求压在下面：

> "So I don&#x27;t think a court would think that a modern-day domain name registrant has property rights in a domain name that supersede all of those contractual terms." — schoen [c:50444179]
> （译文：所以我不认为法院会认为现代域名注册人拥有某种凌驾于这些合同条款之上的域名财产权。）

otterley 则纠正了流传很广的一个误读。他认为 Kremen v. Cohen 这个案子的争点不是「域名是不是财产」——双方在这一点上根本没争议：

> "The question before the Court was not whether a domain name is a form of property. Both parties agreed that a domain name is a form of property; that wasn&#x27;t in dispute." — otterley [c:50445046]
> （译文：法院面前的问题并不是域名是否属于某种形式的财产。双方都承认域名是财产，这一点不存在争议。）

> "Rather, the question before the Court was whether, as intangible property, a tort of conversion claim relating to the domain name could be made under California law." — otterley [c:50445046]
> （译文：法院真正面对的问题是，作为无形财产，针对域名的侵占之诉能否依据加州法提出。）

另一派则从根本上否认这份期待。Spivak 的说法是全篇最锋利的一句：

> "But for now a domain you &quot;own&quot; is just an entry in someone else&#x27;s ledger and control is only enforced by contract for big players willing to pay." — Spivak [c:50444082]
> （译文：但眼下，你「拥有」的域名不过是别人账本上的一行记录，而控制力只靠合同来保障，且只对肯付钱的「大玩家」有效。）

not2b 把这个问题推广到了所有数字资产：买来的电子书、电影和游戏随时可能消失，因为卖家的许可到期，或者单纯不想继续提供服务。

> "People persist in &quot;buying&quot; digital movies e-books, and games despite the fact that they can disappear at any point, without warning, because the seller&#x27;s license expired or they just feel like discontinuing the service." — not2b [c:50445543]
> （译文：人们依然在「购买」数字电影、电子书和游戏，尽管它们随时可能毫无预警地消失——因为卖家的许可到期，或者只是单纯想停掉这项服务。）

至于立法层面，colonwqbang 建议干脆给域名版权写一份专门公约：

> "Maybe we need a Reston Convention on the right not to have your domain arbitrarily seized and sold to someone else." — colonwqbang [c:50447128]
> （译文：也许我们需要一份「Reston 公约」，保障你的域名不被随意查封并卖给别人。）

### 五、已经有人为这次公告付了代价

最扎眼的一条来自 nticompass。听说要关停之后，他主动让 first.last.name 到期了——域名当时还在工作，他没多想。

> "I let my &quot;first.last.name&quot; registration expire because of the impending shutdown!" — nticompass [c:50443986]
> （译文：因为我听说要关停，就把我的 first.last.name 注册让它到期了！）

> "I&#x27;m so mad now!  I assume there is no way to get my domain&#x2F;email forwarding back :(" — nticompass [c:50443986]
> （译文：我现在气坏了！我估计我的域名和邮件转发要不回来了：( )

他后来补了一句编辑：其实没那么气，只是搬账户很麻烦。给他的建议是把邮件转发搭进去的账号一并迁走的那位邻居还提了一条实际路径：

> "Definitely email the registrar. Maybe it might work?" — _blackhawk_ [c:50444054]
> （译文：给注册商发邮件问一下。也许能成？）

mzajc 则给了个更专业的希望——很多注册局在到期后还有宽限期，甚至不止一段：

> "I don&#x27;t know about .name specifically, but some registries have a grace period (or multiple) after which you can still renew it. It&#x27;s worth checking if you&#x27;re within the time limit." — mzajc [c:50444080]
> （译文：我不了解 .name 的具体情况，但有些注册局在到期后还有宽限期（有的不止一段），在那之后你仍然可以续费。值得查查你是不是还在期限之内。）

### 六、存量保住之后，谁来维护

撤回方案的最后一块拼图是「谁来继续提供这项服务」。scott00 直接点名了目前还在支持三级域名的注册商：

> "Gandi and 007names are the only ones I&#x27;m aware of that support the third-level domains." — scott00 [c:50445937]
> （译文：据我所知，支持三级域名的只有 Gandi 和 007names 这两家。）

Verisign 方面的承诺，troyrollo 转述得最完整——存量服务保留，新服务停售，但保证至少留下一家注册商：

> "They are grandfathering existing third levels and existing email forwarding services. The new RSEPs will just discontinue offering the services as new services, with Verisign saying they will take responsibility for ensuring that there will always be at least one registrar who supports both." — troyrollo [c:50446904]
> （译文：他们把存量的三级域名和存量邮件转发服务做 grandfathered 处理。新的 RSP 只是不再把这两项服务作为新服务提供，而 Verisign 表示会负责保证：至少会一直有一家注册商同时支持这两项。）

还有一层边界问题：那些底下挂着三级注册的二级域名，以后算不算被保留。toast0 给了现状——历史上重叠的二级域名一直就不可注册：

> "Yes, second level domains that overlap with a registered third level domain have never been available." — toast0 [c:50444525]
> （译文：对，与已注册的三级域名重叠的二级域名一直就不可注册。）

> "I believe current practice is the second level domain becomes available if all of the third level domains expire." — toast0 [c:50444525]
> （译文：我理解当前的规则是，当三级域名全部到期后，对应的二级域名就会变为可注册。）

但从「三级域名的唯一持有人」转成「二级域名的持有人」，中间没有平滑通道——你只能先让自己的名字过期，然后去赌二级域名能被抢回来。

### 七、插曲：一个感叹问号带偏了半个评论区

nticompass 那条评论开头是一个字符：

> "WHAT‽" — nticompass [c:50443986]
> （译文：什么？！）

这个组合符号在英语里叫 interrobang，Unicode 里是 U+203D。BoxOfRain 第一时间出来捧场：

> "While it won&#x27;t lessen your frustration, I applaud your use of the interrobang. That punctuation mark needs wider use." — BoxOfRain [c:50444063]
> （译文：这不能减轻你的挫败感，但我得为你的 interrobang 用法鼓掌。这个标点符号需要更广泛的使用。）

BadBadJellyBean 补了一句冷知识：

> "It&#x27;s called an interrobang. Never really took off but still available in unicode." — BadBadJellyBean [c:50444156]
> （译文：这东西叫 interrobang。从来没流行起来，但 Unicode 里一直有。）

saalweachter 解释了它为什么没流行——输给打字机的是电脑：

> "It lost when computers overtook typewriters." — saalweachter [c:50445568]
> （译文：它在电脑取代打字机的时候就已经输了。）

> "On a typewriter, you could type one punctuation mark, backspace, and then type another." — saalweachter [c:50445568]
> （译文：在打字机上，你可以打一个标点，退格，再打另一个。）

reaperducer 把它的历史拉得更远，顺便还挖出一句怀旧：

> "I first heard of it back when Usenet was still the hotness." — reaperducer [c:50444545]
> （译文：我第一次听说这东西，还是 Usenet 当红的时候。）

adrian_b 则贴出了 Unicode 里 ? 和 ! 的四种两两组合，直接把这个话题推向了字符表考古。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 存量保住就对了 | xigoi | 三级域名在取消，只是已经持有的可以留着 |
| 被砍的只是三级 | ksala_ | one.someone.name 这种独立所有权才是 .name 的独门设计 |
| 撤回才是唯一合理解 | giancarlostoro | 存量续费、新人免进，空出来的二级域名迟早被重新拍卖 |
| 关停并不省钱 | kwanbix | 这摊业务成本接近 0，没道理要关 |
| 技术上被 PSL 卡住 | OkayPhysicist | 公共后缀列表得加通配规则，所有依赖它的代码都得改 |
| 通配也不是答案 | toast0 | 名单大头在二级，正确做法是逐个登记并随到期增删 |
| PSL 本身就该废 | troyrollo | 边界应由 DNS 记录或服务器上的文件正式定义 |
| 域名是财产 | schoen | 第九巡回法院判过，但现代合同丛林把这点压住了 |
| 判例被过度解读 | otterley | Kremen 案争的是侵占之诉，不是域名是不是财产 |
| 域名只是账本条目 | Spivak | 你「拥有」的域名是别人账本上的一行，控制力只对大玩家有效 |
| 数字资产都一样 | not2b | 买来的电子书和游戏也会随时消失，没人立法保护 |
| 该立个公约 | colonwqbang | 需要一份「Reston 公约」防止域名被随意查封变卖 |
| 已经有人踩坑 | nticompass | 以为要关停，主动让 first.last.name 到期，结果真没了 |
| 还有注册商在撑 | scott00 | 目前只有 Gandi 和 007names 支持三级域名 |

## 总体情绪

这场讨论分裂得很干净，但分裂的轴线不是支持或反对 Verisign。一半人在庆祝存量域名和邮件转发活了下来，另一半人根本不在乎 22,000 个域名保没保住，他们追的是那个更冷的问题：一个 TLD 的运营方，到底有没有权力把客户已经付费、已经用了十年的东西一笔勾销。这条线从 Verisign 的商业动机一路延伸到 Kremen v. Cohen 的判决范围，再延伸到「域名只是一行账本记录」这种更彻底的怀疑。

值得注意的是，双方其实都承认了同一件事：域名从来不是靠法律保护的，它是靠合同、靠惯例、靠「目前运营方还没疯到那一步」保护的。这次的结果之所以值得庆祝，不是因为 Verisign 变得高尚了，而是因为一批人花了钱、花了时间、飞到巴厘岛去把那个「还没疯到那一步」续上了。

Verisign 手里还攥着两万个三级域名没释放，公共后缀列表那条通配规则也还没人写。域名从来不是被保护住的，只是这次保护它的人还在。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | .name Grandfathered（HN 主帖） | <https://news.ycombinator.com/item?id=50442736> |
| 2 | Neil Fraser: .name Grandfathered（原文） | <https://neil.fraser.name/news/2026/11/10/> |
| 3 | ICANN 共识政策文件：Kane to Fessenden（2026-11-05） | <https://itp.cdn.icann.org/en/files/consensus-policies/kane-to-fessenden-05-11-2026-en.pdf> |
| 4 | Verisign 旧提案（2026-07-28，已作废） | <https://itp.cdn.icann.org/en/files/consensus-policies/fessenden-to-kane-2-voided-28-07-2026-en.pdf> |
| 5 | 前情讨论：69 天前的同题主帖（547 条评论） | <https://news.ycombinator.com/item?id=49550772> |
| 6 | Public Suffix List | <https://publicsuffix.org/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 602 分、134 条评论，归档快照 2026-11-10 22:56 UTC，入库 100 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。文中关于 22,000 个三级域名、10414 条公共后缀列表、7 月 28 日提案作废等数据，均来自原文与归档评论引述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
