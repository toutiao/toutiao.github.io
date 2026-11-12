---
layout: post
title: >-
  Microsoft 365 集体降级：状态页自己先挂了 — HN 讨论摘要
date: 2026-11-13
hn_id: 50471731
categories: [articles]
excerpt: >-
  Exchange Online、Teams、SharePoint、Copilot、Defender XDR 一起连不上，微软最后给出的原因不是流量涨了，
  而是一批服务器意外掉线把负载压到了剩下的机器上；而承载这些消息的状态页自己也转不动。
tagline: >-
  微软的状态页也需要一个状态页。
---

> 来源：HN 讨论主帖 [Service degradation on Microsoft 365](https://news.ycombinator.com/item?id=50471731)（386 分，369 条评论），原文指向 [status.cloud.microsoft](https://status.cloud.microsoft/)。同话题关联帖：[Ask HN: Microsoft/Azure Outage?](https://news.ycombinator.com/item?id=50471668)（401 分），其评论被官方迁移至主帖。本篇为 cluster 模式（2 帖），关联帖引文标注 `[thread 2]`。两帖归档快照 2026-11-12 23:17 UTC，主帖入库 100 条评论，评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。状态页正文抓取失败（动态渲染页面，内容长度未过门槛），事件时间线、受影响服务清单与事件编号取自主帖评论中逐字转录的状态页公告与官方 X 公告。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 11 月 12 日 18:10 UTC，Microsoft 365 状态页贴出第一条公告：部分用户无法通过多种连接方式访问 Exchange Online 邮箱，受影响的连接方式包括 Outlook on the web、Messaging API (MAPI)、Exchange ActiveSync (EAS) 和 Representational State Transfer (REST) API，事件编号 EX1550543。

18:32，公告标题升级为「Users may be unable to connect to multiple Microsoft 365 services」，受影响服务清单扩到五项：

> "Potentially impacted services include:<p>- Exchange Online<p>- Microsoft Teams<p>- SharePoint Online<p>- Microsoft Copilot 365<p>- Microsoft Defender XDR" — EvanAnderson [c:50471690]
> （译文：可能受影响的服务包括：Exchange Online、Microsoft Teams、SharePoint Online、Microsoft Copilot 365、Microsoft Defender XDR。）

官方口径是受影响的基础设施在多个区域出现负载升高，可能正是连接错误的来源，正在重启并修复受影响部分，同时复核「某类服务流量出现意外增长」是否与负载升高有关。

18:59、19:16、19:30 三次更新一路收紧：先把连接流量重新分发到全球基础设施并重启服务器，再暂停全部部署和配置变更、把部分服务流量迁出受影响设施，最后给出结论——负载升高不是整体流量增长造成的，而是大量服务器意外不可用，负载被压到了剩下的基础设施上。评论区把 19:30 那条公告的原文整段抄了下来：

> "Current status: We&#x27;re aggressively pursuing all pathways to reduce impact. As a precaution, we&#x27;ve paused all deployments and configuration changes while we review recent changes for any correlation to this event. We&#x27;ve determined that the elevated load isn&#x27;t driven by an overall increase in traffic, but by a large number of servers being unexpectedly unavailable, which is shifting load onto the remaining infrastructure. We&#x27;re investigating what&#x27;s causing these servers to become unavailable while we work to safely return them to service." — EvanAnderson [c:50471690]
> （译文：当前状态：我们正在穷尽一切途径降低影响。预防起见，我们已暂停全部部署和配置变更，同时复查近期的变更是否与本次事件有关。我们已经确认，负载升高不是整体流量增长造成的，而是大量服务器意外不可用，负载因此被转移到剩余的基础设施上。我们正在调查这些服务器为何不可用，同时设法让它们安全恢复服务。）

官方 X 账号 @MSFT365Status 的公告更短，也更能看出口径变化：第一条只谈美洲地区，第二条改口成「任何区域」，第三条给出多区域负载升高，并新增事件编号 MO1550821。

> "We&#x27;re investigating reports of users experiencing issues accessing Exchange Online mailboxes through multiple connection methods in the Americas. More details can be found in the Microsoft 365 admin center under EX1550543." — testplzignore [c:50471685]
> （译文：我们正在调查有用户报告通过多种连接方式访问 Exchange Online 邮箱时出现问题的报告，问题发生在美洲地区。更多细节可在 Microsoft 365 管理中心的 EX1550543 条目下查看。）

> "While we&#x27;re working to mitigate impact, we&#x27;ve confirmed the issue may affect Microsoft 365 service connectivity for users in any region, more information will be provided in the Microsoft 365 admin center under EX1550543." — toss1 [c:50472591]
> （译文：在我们缓解影响的同时，已确认该问题可能影响任何区域的 Microsoft 365 服务连接，更多信息将在 Microsoft 365 管理中心的 EX1550543 条目下提供。）

评论区实测与官方口径基本吻合，只是更快、更具体：有人贴出 status.cloud.microsoft 返回 502，有人确认 M365 Family 一切正常，怀疑它跑在独立基础设施上、也可能是还没着火；RSS feed 反而加载很快。两条线程合计 787 分，主帖 369 条评论，讨论从「谁的责任」一路滑到「云到底算不算单点故障」「Downdetector 该不该信」「微软同时在裁员算不算另一个信号」。

## 讨论焦点

### 一、用户点进来时，帖子已经搬走了

那条 Ask HN 帖的评论被版主整体迁到了主帖：

> "Comments moved to <a href="https:&#x2F;&#x2F;news.ycombinator.com&#x2F;item?id=50471731">https:&#x2F;&#x2F;news.ycombinator.com&#x2F;item?id=50471731</a>." — tomhow [c:50474827] [thread 2]
> （译文：评论已迁移至 https://news.ycombinator.com/item?id=50471731 。）

于是事件的完整脉络都落在主帖里：状态页公告原文、官方 X 公告原文、故障时间线、以及各家公司运维人员的现场描述。

### 二、状态页自己先倒了

> "The service behind this page isn&#x27;t responding to Azure Front Door." — vachina [c:50471792]
> （译文：这个页面后面的服务不响应 Azure Front Door。）

状态页标题栏上写的是「Service Degredation」（把 Degradation 拼错了），而且评论区很快发现它自己也转不动：

> "Edit: Looks like the status page needs a status page." — EvanAnderson [c:50471690]
> （译文：编辑：看来状态页也需要一个状态页。）

同一条评论后面的补充则给出了两个反常识细节：M365 Family 完全正常，而 Teams 和 OneDrive 也确实出了问题。

> "Edit: Verified w&#x2F; multiple other parties that Teams and OneDrive are having issues, too. Interestingly, Microsoft 365 Family services are working fine. That makes me wonder if that product is running on separate infrastructure (or just hasn&#x27;t caught fire yet)." — EvanAnderson [c:50471690]
> （译文：编辑：已向多方确认 Teams 和 OneDrive 也确实有问题。有意思的是，Microsoft 365 Family 完全正常。这让我怀疑那个产品跑在独立的基础设施上（或者只是还没着火）。）

其他人的反应从黑色幽默到幸灾乐祸：

> "The M365 status page not loading reminds me of one of my favourite Simpsons jokes: <a href="https:&#x2F;&#x2F;www.youtube.com&#x2F;watch?v=3Hz2uOSdV24" rel="nofollow">https:&#x2F;&#x2F;www.youtube.com&#x2F;watch?v=3Hz2uOSdV24</a>" — Waterluvian [c:50471700]
> （译文：M365 状态页打不开，让我想起我最喜欢的辛普森一家笑话之一。）

> "It is ironic that this outage map _also_ is not loading for me right now" — justusthane [c:50473256]
> （译文：很讽刺的是，这张故障地图此刻在我这里也打不开。）

> "Ironically, this article is down as well." — throwaway_1016 [c:50471837]
> （译文：讽刺的是，这篇文章的链接也挂了。）

### 三、「云不是单点故障」这句话

这是评论区情绪最集中的地方。听到的版本和听到的语气都很熟悉：

> "I was assured that with cloud we wouldn&#x27;t have a single point of failure like we did on-premise. I must have fallen asleep at my desk." — nazgulsenpai [c:50471818]
> （译文：当年有人向我保证，用了云就不会像本地部署那样出现单点故障。看来是我在工位上睡着了。）

而给出反驳的，是同样在做企业 IT 的人：

> "The &quot;you can&#x27;t possibly have better redundancy in your on-prem&quot; was absolutely a sales pitch I heard to move to Microsoft 365.<p>The biggest site I work for, who went M365 hybrid last year, has incurred more Exchange downtime today than they had all of last year with their on-prem Exchange servers." — EvanAnderson [c:50472254]
> （译文：「你在本地部署不可能有更好的冗余」这句完全是当年劝我们迁到 Microsoft 365 时听到的销售话术。我所在最大的那个站点去年才迁到 M365 混合部署，今天一天的 Exchange 停机时间就超过了它去年全年本地 Exchange 服务器的停机时间。）

讨论随后分成两种口径。一种认为「云」承诺的本来就不是单个产品不出事：

> "That was never the promise. The nearest to that is the promise of multi-cloud or hybrid infrastructure, but neither of those have anything to do with outages of specific Microsoft services." — moronicles [c:50472135]
> （译文：那从来就不是承诺的内容。最接近的表述是多云或混合基础设施的承诺，但这两者都跟某个 Microsoft 服务自身宕机无关。）

另一种认为这种区分在客户侧没有意义：

> "It sounds like you are talking more about product reliability of M365 than you are about enterprise infrastructure reliability. M365 is a Microsoft product. M365 has no bearing on the credibility of cloud infrastructure as a whole, which is what your original comment spoke to." — moronicles [c:50472842]
> （译文：听起来你谈的更多是 M365 这个产品的可靠性，而不是企业基础设施的可靠性。M365 是 Microsoft 的产品。M365 对整个云基础设施的可信度没有任何影响，而你最初那条评论谈的正是后者。）

最精确的收口来自 SoftTalker，它把「冗余」和「单点」放在了两个不同的观察层面：

> "The service has redundancy, better than individual operators could provide on-prem. From the customer standpoint though, the service as a whole is a single point of failure: it either works or it doesn&#x27;t." — SoftTalker [c:50472815]
> （译文：这个服务本身是有冗余的，比单个运维者在本地部署能提供的更强。但从客户视角看，这个服务整体就是一个单点故障：要么能用，要么不能用。）

### 四、Downdetector 之战：众包信标还是遥测

微软状态页半死不活的时候，Downdetector 的曲线成了事实上的第二现场：

> "Down detector shows like <i>everything</i> is down. AWS, Azure, Office, Gmail. Everything." — sonicrocketman [c:50471863]
> （译文：Downdetector 显示几乎所有东西都挂了。AWS、Azure、Office、Gmail。全挂了。）

于是评论区分成两派。反对的一派认为众包数据在大型故障时必然失真：

> "Downdetector&#x27;s methodology is pretty garbage. I&#x27;m always surprised to see techies referencing them." — Icathian [c:50471992]
> （译文：Downdetector 的方法论相当糟糕。我一直对技术圈的人引用它感到意外。）

> "This happens every time there&#x27;s an outage. People see their email not working and go there and mark <i>everything</i> as down regardless of whether it is affected or not. There&#x27;s nothing wrong with Gmail or AWS or Cloudflare or Facebook." — paxy [c:50472311]
> （译文：每次出故障都是这样。人们发现邮箱用不了，就跑去那里把一切都标成故障，不管它是否受影响。Gmail、AWS、Cloudflare、Facebook 什么事都没有。）

支持的一派则认为它至少能区分「是我坏了还是它坏了」：

> "It&#x27;s something to reference. My view is that it&#x27;s better than &quot;doesn&#x27;t load for me&quot;." — sonicrocketman [c:50472012]
> （译文：它总归是个参考。我个人认为它比「我这儿打不开了」要强。）

> "I often know about outages dozens of minutes in advance of it being posted on official channels (or in the case of AWS, three days later...)." — akersten [c:50472637]
> （译文：我经常能在官方渠道发布之前几十分钟就知道哪里故障了（AWS 的话，是三天之后）。）

第三派则直接搬出遥测产品压轴。来自 Cisco 的 tristor 提供了自己公司的方案，也顺便解释了一个尴尬事实：

> "Full Disclosure, this is a Cisco product and I work there.<p>ThousandEyes Internet Insights offers a public outage map at <a href="https:&#x2F;&#x2F;www.thousandeyes.com&#x2F;outages&#x2F;" rel="nofollow">https:&#x2F;&#x2F;www.thousandeyes.com&#x2F;outages&#x2F;</a> that is MASSIVELY more accurate (and faster to detect) than Down Detector because its based on actual telemetry and not on crowdsourcing." — tristor [c:50472902]
> （译文：先做声明，这是 Cisco 的产品，我在 Cisco 工作。ThousandEyes Internet Insights 提供了一张公开的故障地图，比 Downdetector 准确得多（检测也快得多），因为它基于真实遥测数据，而不是众包。）

他后来补充的收尾更黑色幽默：那张地图的服务器自己也被这次流量打挂了。

> "There will be a more detailed message when we finish the SII on our status page at the link I previously provided, but the short version is we took way more traffic than normal to our platform and the related workers were running out of memory." — tristor [c:50474266]
> （译文：等我们完成状态页的事故报告后，会在我之前给的那个链接上给出更详细的信息。简单说就是，我们平台接收到的流量远超平时，相关 worker 的内存不够用了。）

### 五、真正被连累的：SSO、Defender、Intune、VPN

IT 从业者指出，被这次故障打到的不止邮件本身。抱怨 Atlassian 和 AWS 的那些人，真正用到的可能是挂在 Microsoft 上的那层：

> "I work in IT and people are complaining about Atlassian and about AWS but in reality if your organization is using SSO then that would get impacted.<p>If your org is using Intune or Defender EDR then you probably also are impacted." — midas89 [c:50473072]
> （译文：我在 IT 部门工作，人们在抱怨 Atlassian 和 AWS，但实际上如果你的组织用了 SSO，那就会受影响。如果你的组织用了 Intune 或者 Defender EDR，那你大概也一起受影响了。）

> "I think a lot of ms orgs&#x2F;window users may have external links blocked when defender is down. So it may appear other services are down." — inChargeOfIT [c:50472744]
> （译文：我觉得很多用 Microsoft 组织的 Windows 用户，在 Defender 挂掉时外部链接会被拦掉。所以看起来像是别的服务也挂了。）

Teams 则贡献了本次讨论最著名的一句：

> "Teams is working!<p>Or, rather, it&#x27;s acting like it usually does." — marcosdumay [c:50472205]
> （译文：Teams 能用！或者更准确地说，它表现得一如既往。）

> "Teams: Either It&#x27;s Working, Or You Are" — ratelimitsteve [c:50472415]
> （译文：Teams：要么它能用，要么你有问题。）

以及这位发言者几分钟后自己撞上的乌鸦嘴：

> "Funny thing is that my work&#x27;s VPN that uses the MS authenticator just quit, immediately after I made that comment. So you are even more correct than usual." — marcosdumay [c:50472477]
> （译文：有意思的是，我刚发完那条评论，我们那个用 MS Authenticator 的公司 VPN 就直接断了。所以你比平时说得更对。）

反过来也有人划清了边界，Entra 并没有被这次故障波及：

> "Entra is not impacted, SSO is working for non-M365 apps." — jwnin [c:50475375]
> （译文：Entra 没有受影响，非 M365 应用的 SSO 仍然可用。）

### 六、裁员这条支线

故障发生的同时，微软正在推一轮覆盖四分之一员工的自愿离职买断，于是有人把两件事并排放到了一起：

> "Isn&#x27;t this the company that is trying to get rid of 25% of their employees?<p>Status page is down. Much of our org is halted." — NichoPaolucci [c:50471944]
> （译文：这不就是那家正在裁掉 25% 员工的公司吗？状态页挂了，我们组织的大部分人都停工了。）

评论区最认真的一条纠错来自 eightysixfour，他指出「25% 的 offer」和「裁掉 25%」是两回事：

> "They did not make the offer to 25% of the employees to downsize by 25%, they did it to downsize by 5% (or something like that), and then made the offer based on how many they expect to accept." — eightysixfour [c:50472054]
> （译文：他们并不是为了把规模砍掉 25% 才向 25% 的员工发出 offer，而是为了把规模砍掉 5%（大概这个量级），然后再根据预期接受人数来设计 offer 的范围。）

> "They probably expect 10-20% of those offered to take it, which would result in a 2.5-5% total downsizing." — eightysixfour [c:50472054]
> （译文：他们大概预期被 offer 的员工里有 10-20% 会接受，那样总体裁员规模就是 2.5-5%。）

这条支线还拐去了美国雇佣法：

> "Why do they offer these buy outs at all, doesn&#x27;t the US have at will employment?<p>Or is this just a gesture of goodwill to avoid people jumping the ship on their own?" — maxboone [c:50472425]
> （译文：既然美国是「随意雇佣」，他们为什么还要搞这种买断？还是说这只是为了避免员工自己主动跳船而做的姿态性善意？）

> "If you lay people off, you’re on the hook for their unemployment. A voluntary buyout avoids that, and also avoids mandatory reporting for layoffs." — gmane [c:50472610]
> （译文：如果你直接解雇员工，失业保险的责任会落在你头上。自愿买断可以避开这一点，也避开了解雇所要求的强制申报。）

也有律师味道更足的反驳，顺带把讨论拉回了「裁员」这个话题本身：

> "The fact that it is always Big Even Number shows how stupid it is. Imagine if it was serious like &quot;23.5176%&quot; then you&#x27;d know they actually did their homework on leaning up operations instead of just cutting off limbs and seeing if it can still walk or not." — asdff [c:50472781]
> （译文：它永远是个整数大数字，这本身就很蠢。想象一下，如果真写成「23.5176%」这样的数字，那说明他们真的研究过如何精打细算地精简运营，而不是直接砍掉一条腿看剩下的还能不能走。）

### 七、这是不是 AI 写代码的锅

最后一支队伍把 2026 年的两个关键词强行接在了一起：

> "And everybody has spent a year letting AI write code.  Correlation is not causation, but I wonder..." — AnimalMuppet [c:50472479]
> （译文：而且所有人都有了一整年的时间让 AI 写代码。相关不等于因果，但我忍不住想……）

> "The speed of change has accelerated drastically at some organizations, so even if quality stayed the same, the number of outages would increase because of the # of changes has condensed to happen over much shorter time frames." — esseph [c:50473907]
> （译文：一些组织里的变更速度已经急剧加快，所以即便质量没变，故障次数也会增加，因为变更的数量被压缩到了更短的时间窗口内发生。）

而全场最不客气的一句，来自一个全栈程序员：

> "Everyone that is a whole stack programmer (say, kernel to webapp) has seen just how unnecessarily complicated everything has become. Watching it burn to the ground would be a pornographic miracle." — infamouscow [c:50474742]
> （译文：每个做全栈的程序员（从内核到 Web 应用）都见识过这套东西是怎么变得不必要地复杂的。眼看着它烧成灰烬堪称色情级奇迹。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 负载不是流量涨的，是服务器掉了 | EvanAnderson | 大量服务器意外不可用，负载被压到剩下的设施上 |
| 影响面覆盖五个 M365 服务 | EvanAnderson | Exchange、Teams、SharePoint、Copilot、Defender XDR 全在列 |
| M365 Family 幸免于难 | EvanAnderson | 独立基础设施，或者只是还没着火 |
| 状态页也需要一个状态页 | EvanAnderson | 状态页自己都打不开，还拼错了 Degradation |
| 「云不会单点故障」是销售话术 | nazgulsenpai | 当年被保证过，如今只能在工位上睡着 |
| 混合部署一年停机不如旧服务器 | EvanAnderson | 今年一天超过去年全年 |
| 云没承诺过单个产品不出事 | moronicles | 多云/混合说的是另一回事 |
| M365 的锅不算云基础设施的锅 | moronicles | 产品可靠性与企业基础设施可靠性要分开 |
| 客户视角下它就是单点 | SoftTalker | 有冗余的是内部，对客户只有能用和不能用 |
| Downdetector 方法论很糟 | Icathian | 技术圈居然还在引用它 |
| 大故障时人人乱报 | paxy | 邮箱坏了就把 Gmail、AWS、Facebook 一起标了 |
| 它比「我这儿打不开」强 | sonicrocketman | 至少能分清是我坏了还是它坏了 |
| 众包能提前几十分钟知道 | akersten | 官方渠道还没发，AWS 则是三天后 |
| 遥测比众包准得多 | tristor | ThousandEyes 用的是真实遥测 |
| 遥测地图自己也被打挂了 | tristor | 流量远超平时，worker 内存不够 |
| SSO、Intune、Defender 一起遭殃 | midas89 | 抱怨的可能是 Atlassian，用的却是 SSO |
| Teams 能用等于永远能用 | marcosdumay | 它表现得一如既往 |
| 自家 VPN 当场断掉 | marcosdumay | 乌鸦嘴说完就应验了 |
| Entra 未受影响 | jwnin | 非 M365 应用的 SSO 仍然可用 |
| 25% 的 offer 不等于裁 25% | eightysixfour | 真实目标可能是 5%，接受率预计 10-20% |
| 自愿买断避开失业保险与申报 | gmane | 这才是买断的法律动机 |
| 裁员与故障同框只是巧合 | asdff | 永远是整数大数字，说明没做过功课 |
| 变更速度变快会推高故障数 | esseph | 质量不变，窗口变短 |
| 复杂度才是真的烧起来的东西 | infamouscow | 看它烧成灰烬是色情级奇迹 |

## 总体情绪

分歧最后落在同一个问题上：你到底信谁。官方的状态页慢到打不开，页面上还把 Degradation 拼成了 Degredation；众包的 Downdetector 几乎同时给出全景，却顺手把 Gmail、AWS、Facebook 一起拖下水；基于遥测的故障地图比两者都准，只是它自己的服务器也被这次流量打挂了。三种信源同时失灵或同时失真，是这次 outage 里最荒诞的部分。

而讨论里更有意思的那层，是它从技术滑向了组织。有人当场把「微软正在裁掉四分之一员工」和「状态页挂了」并列，也有人立刻用买断接受率的算术把这条线索拆掉。剩下的是一句更朴素的抱怨：想买 redundancy 的人买到了宣传页。

一场 outage 里最讽刺的画面是：所有人都在等状态页恢复，好确认自己是不是也坏了——而这一次，等来的状态页本身也是坏的。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Service degradation on Microsoft 365（HN 主帖） | <https://news.ycombinator.com/item?id=50471731> |
| 2 | Ask HN: Microsoft/Azure Outage?（HN 关联帖） | <https://news.ycombinator.com/item?id=50471668> |
| 3 | Microsoft 365 服务状态页（原文链接） | <https://status.cloud.microsoft/> |
| 4 | Microsoft 365 Status 官方 X 公告 | <https://x.com/MSFT365Status/status/2120938282204688468> |
| 5 | Downdetector | <https://downdetector.com/> |
| 6 | ThousandEyes Internet Insights 公开故障地图 | <https://www.thousandeyes.com/outages/> |
| 7 | onlineornot（主动探测型服务可用性检测） | <https://onlineornot.com/> |
| 8 | Azure 服务状态面板 | <https://azure.status.microsoft/en-us/status> |
| 9 | Reddit r/sysadmin：Microsoft Office seems to be down | <https://www.reddit.com/r/sysadmin/comments/1xuje83/microsoft_office_seems_to_be_down/> |
| 10 | GitHub Status：sign-up 故障事件 | <https://www.githubstatus.com/incidents/nwbjzl7nfrc2> |
| 11 | HN：一年前那次 AWS outage 的讨论 | <https://news.ycombinator.com/item?id=45640838> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 386 分、369 条评论，归档快照 2026-11-12 23:17 UTC，入库 100 条；Ask HN 关联帖 401 分，入库 1 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。本文关于受影响服务清单、连接方式清单、事件编号（EX1550543、MO1550821）与公告时间线的叙述，依据评论区逐字转录的 status.cloud.microsoft 状态页公告及 @MSFT365Status 的 X 公告；状态页正文抓取失败（动态渲染页面，未过内容长度门槛），本站未直接读取该页。裁员支线涉及 GeekWire 等媒体报道，本站未做独立核实。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
