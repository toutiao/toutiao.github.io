---
layout: post
title: >-
  Yandex 数据中心遇袭后 Cloudflare 雷达图流量骤降——HN 评论区大多读错了这张图
date: 2026-10-11
hn_id: 50041619
categories: [articles]
excerpt: >-
  Cloudflare Radar 公开页显示 AS13238（Yandex LLC）的"机器人流量占比"在几日内跌至接近零，但 125 条评论里相当一部分把它读成了"恶意机器人溃败"。这张图真正度量的是"来自该 ASN 的请求中被判为机器人的比例"——被打击后分子分母一起塌，看起来也是零。
tagline: >-
  雷达图跌至零，三机房四天被端。多数评论把这当成恶意机器人消亡记，其实只是 Yandex 自己爬虫停了。
---

## 原文概要

2026 年 10 月 11 日，Cloudflare Radar 上 [AS13238（Yandex LLC）](https://radar.cloudflare.com/bots/as13238?dateRange=7d) 的"机器人流量占比"曲线在过去几天里近乎跌到零。同一家公司的另一个 ASN [AS200350（Yandex Cloud/主机托管平台）](https://radar.cloudflare.com/bots/as200350?dateRange=7d) 同步断崖式下跌。HN 主帖以"Sudden drop in Cloudflare bot traffic after strike on Yandex datacenter"为题，445 分、125 条评论。

HN 上的资讯补充由 schleck8 整理得最完整：四天内三次打击把三个 Yandex 主要设施下线，failover（故障切换）失灵；故障从 Yandex Go（出行）、Yandex Pay（支付）、外卖、智能家居、内部物流，扩散到 Yandex Cloud 上承载的第三方企业服务，并波及白俄罗斯、哈萨克斯坦、亚美尼亚、塞尔维亚等使用这些系统的邻国。Yandex 自己的[状态页](https://status.yandex.cloud/ru/dashboard)上 Compute Cloud、Kubernetes、PostgreSQL、ClickHouse、MySQL、YDB、Kafka、Application Load Balancer 全部标红，Cloud Backup 也挂了。状态页甚至直接建议用户切到 Selectel、K2Cloud、VK Cloud——"下一个被端的大概就是它们"。

事件真正的新闻价值，不在"恶意机器人少了一部分"，而在一家大型科技公司被物理打击后整体流量几乎归零——这是数据中心第一次在 HN 讨论里以"军事目标"身份出现。

## 讨论焦点

### 这张图度量的是什么——多数人先抢了结论

讨论前段大量评论把雷达图读成"俄罗斯恶意机器人被消灭的证据"。最先站出来纠偏的是 throwaw12：

> "Someone needs to learn how to read the Bot Traffic page. That is a drop in traffic specifically from Yandex bots (which includes their crawlers and other apps hosted in their DC). Now compare it with Bot Traffic in Russia / Europe / Worldwide — dip is barely noticeable even in Russia." — throwaw12 [c:50042416]
> （这张图需要重读一遍。它度量的是来自 Yandex 机器人的流量——包括 Yandex 自己的爬虫和托管在该数据中心的其它应用——的下降。拿全俄罗斯、欧洲、全球的机器人流量对比一下就会发现，即便在俄罗斯这个层面上，下降都不明显。）

timr 顺势补了一组对照数据：

> "Isn't this showing the percentage of bot traffic *from the Yandex IP range*? If so, it isn't particularly surprising that the line would go down. EDIT: yes, it is. Looking at the same graph *for all of Russia*, and there's no discernible pattern." — timr [c:50042343]
> （这图度量的不就是来自 Yandex IP 段的机器人流量占比吗？这样的话这条线掉下去一点都不意外。编辑：是的。同样的图切到全俄罗斯，看不出任何趋势。）

f311a 的语气更直接：

> "I can't believe there are so many dumb comments in this thread. All it shows is that crawling from Yandex search engine stopped from one Yandex data center ASN. No one runs opinion/malicious bots from data center IPs that people mention here. Did people actually stop thinking?" — f311a [c:50042444]
> （不敢相信这条帖子里这么多无脑评论。它只显示 Yandex 搜索引擎的爬虫从其中一个 ASN 停了。评论区提到的那种"观点机器人/恶意机器人"没人在数据中心 IP 上跑。大家是不是不思考了？）

这张图实际上度量的是"来自 AS13238 的请求里，被 Cloudflare 判定为机器人的比例"。在被打击前分子分母都在；被打击后，分母（来自这个 ASN 的全部请求）本身先塌了，所以"机器人占比"曲线也会跟着跌到零。分子分母一起没，看起来也是"零"。

### HA / Ops 视角：这是物理+智能的复合灾难

部分评论把视角转到运维与可靠性工程。Bluestein 给整组讨论定了调：

> "This will be a case study in catastrophic events for HA and Ops folks.-" — Bluestein [c:50042187]
> （这会成为 HA（高可用）和运维同行眼里的灾难案例研究。）

AlienRobot 把攻击矢量分类讲清楚：

> "I don't think there is much you can do about being targeted by a military, simply because of how unique the attack vector is. Hacking is smart but happens through software, so if you have hardware (i.e. physical) barriers, that stops the hacking. Natural disasters happen physically but they are dumb, so if you have software redundancy (i.e. by copying the data to multiple locations), that stops them from destroying everything. A military is both physical AND smart. They can target multiple locations at once and destroy whole buildings." — AlienRobot [c:50042326]
> （被一支军队盯上，能做的有限，因为攻击矢量太特殊。黑客是聪明的，但发生在软件层，物理隔离就能挡住。自然灾害是物理的，但它们是"笨"的，软件冗余（数据多地复制）就能挡住大部分破坏。军队两者兼具——能同时打多个地点，把整栋楼端掉。）

simondotau 进一步说：

> "You can learn to quickly diversify availability (or at least data safety) beyond the region of conflict when a kinetic war breaks out. The moment "kinetic sanctions" became the strategy, the risk to data centres should have been self-evident." — simondotau [c:50042454]
> （动能战争开始时，可以学习快速把可用性——至少是数据安全性——分散到冲突区之外。"动能制裁"成为策略那一刻起，数据中心的物理风险就应当是显而易见的。）

ivan_gammel 把这个判断推到更广的范围：

> "drone attacks are probably on the threat list for everyone now, for various reasons, including domestic terrorism and hybrid warfare. If you want to defend your investment, time to think what covers you from the air." — ivan_gammel [c:50042757]
> （无人机攻击如今大概在每个人的威胁清单上——原因很多，包括国内恐怖主义和混合战争。想保住投入，是时候想想"空中怎么盖"了。）

walrus01 把未来推演到商业模式上：

> "It's an open question at what point we'll start seeing small fiesty startups that want to sell you a privately owned air defense system for your datacenter roof. The tech to do it is probably far ahead of the regulatory regime to own and operate autonomous small radar+SAM batteries." — walrus01 [c:50042820]
> （什么时候会出现卖"数据中心屋顶专用私有防空系统"的小型硬核创业公司，是个开放问题。技术上大概早就跑在监管前面了——自主小型雷达+防空导弹系统这种配置能不能合规运营，目前还没有答案。）

最后，他还在同一支线里给出了一个具体的"攻击端降本"画面：

> "I happened to get on the marketing lists for about six different Chinese companies that will gladly sell you a full size Shahed-136 clone complete with 2 stroke petrol motor. They even advertise the airframe and motor packages on *Instagram*...." — walrus01 [c:50043230]
> （我不知怎么被加进了六家中国公司的营销名单，他们很乐意卖你一台尺寸齐全的 Shahed-136 仿制机，配二冲程发动机。机身和发动机套件甚至在 Instagram 上打广告。）

传统数据中心冗余方案（异地多活、跨区域备份）解决的是软件层失效或物理层自然灾害。这次事件让评论区分成了两派——一派认为"是时候补上空中覆盖"，另一派则追问：传统多 AZ（可用区）够不够用？显然，当"区域里所有可用区同时消失"被摆上桌面时，原来的"跨可用区冗余"假设就不再成立了。

### 制裁让俄罗斯同行的 DR 路径几乎被卡死

讨论里有一条少被注意但很重要的支线：HA 文档通常假设你能买到任何地区的机柜，而现实是被制裁的俄罗斯并非如此。

> "I don't know how useful it will be as a case study since an HA/Ops person in (let's say, the US, Canada, AU, western european countries) has access to do things like buy hypervisor capacity or colocation in just about any location. I could go buy colo in Brussels or Panama City or San Diego or Edmonton or Melbourne tomorrow by contacting the right people. The Russians are much more restricted from doing anything geographically outside of their own borders (for very well justified sanctions reasons), so their limitations are not the same as an HA person in almost any other country. Maybe some Iranian HA/Ops people will be comparing notes with them." — walrus01 [c:50042630]
> （我不确定它作为案例研究有多大参考价值，因为美国、加拿大、澳大利亚、西欧的 HA/Ops 同行随时能买到全球各地的虚拟化或机柜资源，比如今天联系一下合适的人就能在布鲁塞尔、巴拿马城、圣迭戈、埃德蒙顿、墨尔本买到机柜。俄罗斯同行因为制裁（理由完全正当）在境外部署受到很多限制，他们的约束条件跟大多数其它国家的 HA 从业者不一样。也许伊朗的同行会跟他们对一对笔记。）

ivan_gammel 提示，这并不只是俄罗斯一家的问题：

> "Sometimes there exist data or processing residence requirements that bind you to a specific region (e.g. EU-only). Also, „all AZs in this region no longer exist“ is not on everyone's bingo card, this is a good reminder why multi-AZ deployment in the same region may be not enough." — ivan_gammel [c:50042757]
> （有些场景是数据/计算驻留要求把你绑死在某个地区，比如 EU-only。还有，"同一区域内所有可用区同时消失"并不在大多数人的预案里。这次事件是个提醒：同区域多 AZ 部署也许不够用。）

HA 文档通常画一张漂亮的多区域拓扑图，前提是你能跨境采购、跨境支付、跨境物流。一旦这些通道被制裁、被地缘卡死，拓扑图上的"另一区域"可能根本不存在。这一次被端的公司，恰好是受地缘约束最紧的那一类。

### 真正值得关注的是哪些账号会哑火

讨论里有一条很少被外行注意到但被 walrus01 反复强调的线索：数据中心里不只有搜索引擎爬虫，还有相当数量的"操控服务器（C&C）"——它们控制着散布在居民 IP 里的代理网络，替社交平台上的账号做操作。

> "On the other hand there are plenty of datacenter located command/control systems that puppeteer vast fleets of residential proxies (and Russia is by no means the only one doing so), so it will be very telling to see what social media accounts go silent over the coming days and weeks." — walrus01 [c:50042457]
> （另一方面，数据中心里也有大量操控系统，调度着一大片居民代理网络（俄罗斯绝不是唯一这么干的）。接下来几天到几周，哪些社交账号会安静下来，会很有看头。）

f311a 不以为然——他在同一支线里说："没人在数据中心 IP 上跑观点机器人/恶意机器人。"（"No one runs opinion/malicious bots from data center IPs..."）[c:50042444] walrus01 反驳道，被端的这个 ASN 是 Yandex 仍在运营的两个 ASN 之一，覆盖范围比"某一个地区"更广 [c:50042457]。

机房被端，机房里的 C&C 自然就断了。如果某些账号是靠这种 C&C 在活动，它们会同步哑火——这反而比流量曲线更能说明问题：曲线只反映请求量，账号沉默直接反映操作者的基础设施位置。

### "俄罗斯偏执症"的反向数据

反对"过度解读"的评论拿出了 Cloudflare Radar 的全球分布数据：

> "USA accounts for 44% bot traffic worldwide. Russia 0.9%. Russia derangement syndrome on HN as usual." — onemanstartup [c:50042387]
> （美国占全球机器人流量的 44%。俄罗斯 0.9%。HN 上一如既往的"俄罗斯偏执症"。）

cowlevel 用自己的实际观测补刀：

> "This is true. Almost all of my website's bot traffic is from USA." — cowlevel [c:50043205]
> （这是真的。我自己的网站绝大多数机器人流量来自美国。）

数据摆在这里：HN 在涉及俄罗斯的话题上经常"谈俄色变"，但全球机器人流量的实际分布里，俄罗斯连前几名都排不上。把 Yandex 这一个 ASN 的崩溃读成"俄罗斯恶意机器人溃败"，本质上是看错了分母。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 这张图度量的是 Yandex ASN 的机器人占比，被打击后分子分母一起没 | throwaw12, timr, f311a | 把"俄罗斯恶意机器人溃败"读错了 |
| 这是 HA/Ops 的灾难级案例 | Bluestein, AlienRobot, simondotau | 军队同时具备物理性与智能性，传统冗余不够用 |
| 未来数据中心的反制将走向防空 | ivan_gammel, walrus01 | 攻击方门槛降到电商购物车级别，被攻击方要谈空中覆盖 |
| 俄罗斯公司的 DR 选项受制裁约束 | walrus01, ivan_gammel | 跨境采购、支付、物流都被地缘卡死 |
| 真正的新闻是哪些社交账号哑火 | walrus01 | 机房里的 C&C 断了，靠它活动的账号会同步沉默 |
| 俄罗斯并非机器人流量大国 | onemanstartup, cowlevel | 全球 44% 来自美国，俄罗斯 0.9%，别过度解读 |

## 总体情绪

评论区的情绪曲线分四段：起于幸灾乐祸（"机器人少了一部分"），很快被技术细节纠偏（"是分子分母一起没"），中段转入 HA/Ops 视角把这个事件当成罕见的"物理+智能"复合灾难案例，末段重新回到地缘话题——一半评论认为这是正当反制，另一半则指出制裁让俄罗斯同行几乎没有可借鉴的 DR 路径。

而贯穿全程的潜台词是：数据中心第一次在 HN 上以"军事目标"身份出现——不是被 DDoS，而是被弹体端走。这张雷达图只是它安静下来的回响。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Sudden drop in Cloudflare bot traffic after strike on Yandex datacenter | https://news.ycombinator.com/item?id=50041619 |
| 2 | Cloudflare Radar: AS13238 (Yandex LLC) bot traffic | https://radar.cloudflare.com/bots/as13238?dateRange=7d |
| 3 | Cloudflare Radar: AS200350 (Yandex hosting) bot traffic | https://radar.cloudflare.com/bots/as200350?dateRange=7d |
| 4 | Yandex Cloud status page | https://status.yandex.cloud/ru/dashboard |

<div class="disclaimer">

本文摘要为机器辅助生成的 HN 讨论整理，仅作信息汇总之用，不代表本站立场。所有引文均来自原帖评论；观点归属原评论作者，与 AI 摘要过程无关。涉及地缘与武装冲突话题的部分，背景信息可能在摘要发布后发生变化，请以原始来源为准。

⚠ 本帖涉及正在进行中的武装冲突与数据中心物理打击话题，部分观点带有强烈地缘立场，建议读者结合多方信源独立判断。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
