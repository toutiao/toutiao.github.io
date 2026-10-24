---
layout: post
title: >-
  加拿大 C-22 进了参议院：部长级后门令、最长一年的元数据留存，和一场没人投票的争论
date: 2026-10-24
hn_id: 50202114
categories: [articles]
excerpt: >-
  公共安全部长可以下令给消息服务开后门，服务商要保留最长一年的元数据，
  数据还可能直接递到美国警察手里。223 条讨论里最响的不是加密，
  是“反正轮不到我投票”。
tagline: >-
  所有人都在反特朗普，没有一个人抬头看 C-22。
---

## 原文概要

2026 年 10 月 22 日深夜，EFF 发出一篇 deeplinks，标题本身就带着倒计时：《Canadians Are Running Out Of Time To Oppose The Dangerous C-22 Surveillance Bill》。帖子由账号 hn_acker 提交到 HN 热门榜（/best），到 10 月 24 日拿下 418 分、223 条评论，是当天热度榜上分数最高的政治议题帖。

法案本体叫 Bill C-22，也叫 Lawful Access Act，已经通过众议院，正在参议院审议。EFF 列出的事实有三条。第一，政府可以强制数字服务——电信运营商、消息应用都在名单上——协助监控；更关键的是，加拿大公共安全部长可以下令企业给自己的服务开一扇后门，唯一的限制是“不造成系统性不安全”（as long as it doesn't lead to a “systemic insecurity”）。第二，服务商必须保留元数据最长一年：谁联系了谁、去了哪儿、用了哪些服务，即使当事人没有被怀疑任何犯罪。第三，法案还可能把加拿大人的个人数据共享给外国执法机构，包括美国——加拿大正在与美国谈一份跨境数据共享协议，让美国警察不经加拿大法院批准就拿到加拿大网民的信息。

CCLA 和 Citizen Lab 的联合分析结论更硬：这个法案需要的不是打补丁，而是整块撤回 Part 2，也就是监控与数据留存制度本身。参议院 10 月 8 日的辩论记录里，已经有参议员公开表达担忧，认为它可能与加拿大宪法里的隐私保护不兼容。EFF 和 CCLA 都挂着请愿链接，标题里那句“时间不多了”指向的就是参议院这一关。

帖子上线后，讨论的重心很快离开了法案条文，落在一个更难的问题上：一项几乎没有公开反对声音的法案，到底还拦不拦得下来。223 条评论里，篇幅最大的是政治冷漠、选举周期、媒体立场，以及“我认识的人根本不关心”。加密、后门、留存期限这些真正决定技术后果的部分，反而少有人展开。

## 讨论焦点

### 一、“人们不在乎”：冷漠成了政治判断

开场第一条长评来自一个在加拿大找软件工作的开发者。他把法案的重要性说得很直接，然后把它归到了一句更冷的话上：

> "I'm Canadian, and this matters a lot to me, but people don't care" — bluefirebrand [c:50212455]
> （译文：我是加拿大人，这事对我意义重大，但人们不在乎。）

> "The culture here is so mired in political apathy that it feels futile to even bother. People just do not care at all" — bluefirebrand [c:50212455]
> （译文：这里的文化已经深陷政治冷漠，连试一下都显得徒劳。人们就是完全不在乎。）

同一条评论里还有一段更私人的部分，把法案和自己的人生连在一起：

> "I'm unemployed now and worried I'm going to have an incredibly hard time ever finding work in software again, and AI is taking over, and here I am. Defeated again" — bluefirebrand [c:50212455]
> （译文：我现在没工作，担心以后很难再在软件行业找到工作，AI 正在取代一切，而我就站在这里。又一次被打败。）

回应他的是一句毫不客气的话：

> "Get off your ass and help." — allthetime [c:50212648]
> （译文：从你的椅子上起来，去做点什么。）

> "All that apathy out there is an opportunity to awaken care and turn the tide." — allthetime [c:50212648]
> （译文：外面的那些冷漠，恰恰是唤醒关心、扭转趋势的机会。）

同一个国家里也有人给出一个相反的样本：

> "I'm also Canadian and I don't share your pessimism at all." — joshdavham [c:50212665]
> （译文：我也是加拿大人，但我一点也不像你这么悲观。）

这几句其实不是抬杠，而是两种政治判断的对撞：一方认为结构已经僵到没人能推动任何事，另一方认为把“沉默”解读成“不在乎”本身就是偷懒。还有人给出了第三种解释——不是冷漠，是信息没到：

> "I think most Canadians are just not informed." — shovas [c:50213710]
> （译文：我觉得大多数加拿大人只是没被告知。）

### 二、比后门更麻烦的一层：数据会流向美国执法机构

法案里最容易被跳过、却被反复提起的是跨境共享那一条。有读者把它和欧美正在谈的 Cloud Act 条约放在一起看：

> "This is actually even more amazing to me that with all the talk of data sovereignty, the EU and Canada are still negotiating reciprocal Cloud Act treaties that will give the US government warrantless access to basically all digital services and communications." — petcat [c:50212518]
> （译文：更让我吃惊的是，在大家都在谈数据主权的时候，欧盟和加拿大还在谈对等的 Cloud Act 条约，那会给美国政府无需令状就能访问几乎所有数字服务和通信的权限。）

这个方向上还挂着一个更大的时间尺度：

> "Trump is the symptom, not the disease. It will not go back to normal. US politics has changed. The US people have changed." — sandworm101 [c:50212812]
> （译文：特朗普是症状，不是病灶。不会回到从前了。美国政治变了，美国人也变了。）

有人则把逻辑上的漏洞直接问出来：

> "I wonder why the Canadian government would share citizens data with the u.s. while all this 51st state talk and terrif stuff is going on, does Canada get access to Americans data in return?" — sellmesoap [c:50212935]
> （译文：我想知道，在“51 个州”这种说法和关税闹得沸沸扬扬的时候，加拿大政府为什么还要把公民数据交给美国，加拿大能反过来拿到美国人的数据吗？）

回答把这份协议的不对称点破了：

> "It probably is reciprocal, but in reality Canadian companies sell very little (if any) digital services to Americans. There isn't much they can even access. It's why the arrangement is so lopsided." — petcat [c:50213066]
> （译文：大概是对等的，但实际上加拿大公司几乎不向美国人提供服务，他们也没多少东西可以拿到。所以这份安排才这么不对等。）

而来自美国的读者给出的判断更悲观，他列出了加拿大早就身处的位置：

> "Canada already belongs to FIVE EYES, your mobile handset market is almost entirely captured by pushover US corporations that backdoor Push Notifications and rename lakes apropos of nothing." — bigyabai [c:50212772]
> （译文：加拿大本来就属于五眼联盟，你们的手机市场几乎完全被那些唯唯诺诺的美国公司占据，他们在推送通知里开后门，还毫无缘由地给湖泊改名。）

C-22 在这条线上真正扮演的角色因此被重新定义：它不是终点，而是又一道把加拿大数据交出去的闸门。

### 三、公司会退出加拿大，还是会照做？

最激烈的一问是后果问题：如果法案原样通过，谁会先跑。

> "If the bill isn't dramatically changed or killed, all the major messaging services along with tons of other services will end up blocking Canada." — EmbarrassedHelp [c:50212999]
> （译文：如果这个法案不被大改或者废掉，所有主流消息服务以及其他一大堆服务最后都会屏蔽加拿大。）

反对者搬出了英国的先例：

> "Apple in fact did withdraw their security features in Britain over a similar law. It's not simply crying wolf, these companies will withdraw." — tensor [c:50215335]
> （译文：面对类似的法律，Apple 确实在英国撤掉了它的安全功能。这不是狼来了，这些公司会撤。）

> "The law in the UK that makes ADP illegal is basically the same as the Canadian one: it says all messaging and cloud storage (for consumers) has to be backdoored. Apple responded by disabling the non-backdoored version, which is ADP. They'll do the same in Canada, and WhatsApp was always backdoored so doesn't need to change." — cowlevel [c:50217164]
> （译文：英国那部让 ADP 违法的法律和加拿大的基本一样：它要求所有消息和云存储（面向消费者的）必须开后门。Apple 的应对是把没有后门的那一版 ADP 停掉。他们在加拿大也会这么做，而 WhatsApp 本来就带着后门，所以不需要改。）

但有人给出了相反的判断，冷得让人记住：

> "But I don't think that's true. They will comply. They always comply." — cowlevel [c:50216845]
> （译文：但我不这么认为。他们会服从。他们一向服从。）

还有一个说法更具体，声称部分服务已经表明态度：

> "Signal, NordVPN, Psiphon VPN, Tailscale, Windscribe, and DuckDuckGo have already confirmed that they will stop offering their services in Canada, and not route any of their European services through Canadian proiders." — mitthrowaway2 [c:50216186]
> （译文：Signal、NordVPN、Psiphon VPN、Tailscale、Windscribe 和 DuckDuckGo 都已经确认，将在加拿大停止提供他们的服务，也不再把欧洲的业务路由给加拿大的供应商。）

这条说法在讨论里没有出现第二来源支撑，按评论者说法对待更稳妥。真正确定的是技术先例已经在英国发生过——问题只是加拿大会不会重演同一步。

### 四、宪法的牙齿还在不在

另一条线不谈工程，谈的是《权利与自由宪章》能不能接住这一击。

> "but this bill aims to put a harpoon through our charter rights!" — sellmesoap [c:50213920]
> （译文：但这个法案是要往我们的宪章权利里扎一杆鱼叉！）

他这句前一句其实是在讲《宪章》第 8 条——搜查和隐私，连躺在服务器上的消息看起来都需要令状。

有人则指出拿美国宪法做类比是错位的：

> "You should probably educate yourself about the Canadian Charter of Rights and Freedoms, which has so far held up far better than the Amendments." — vkou [c:50214346]
> （译文：你大概该去补一下加拿大《权利与自由宪章》，它到目前为止比美国宪法的那些修正案稳得多。）

更实际的问题是：宪法写得再好，能不能在事前拦住一个多数党政府。有读者举了 2022 年卡车司机抗议那次的例子：

> "So what we have in Canada is a charter that theoretically protects citizens, but in practice can be violated by the government with impunity." — AlexandrB [c:50215823]
> （译文：所以加拿大现在有的，是一部理论上保护公民、但实际上可以被政府毫无代价地违反的宪章。）

不过也有人给出了制度上的希望所在——参议院未必是橡皮图章：

> "At this point, I think the soft landing that privacy advocates can hope for are amendments that curtail the worst aspects of this legislation." — wmchen [c:50213365]
> （译文：到这一步，隐私倡导者能指望的软着陆，是通过修正案砍掉这部立法里最糟糕的部分。）

他补充的机制细节是：参议院研究后大约有四分之一概率提出修正案，下议院没有义务接受，但在协商层面仍有影响力；真正会被参议院“处死”的法案，通常是像堕胎和气候变化那样真正有争议的议题。

### 五、投票现场：谁投了赞成票，谁看错了投票记录

关于投票本身，评论区里有两种互相排斥的判断。

一种认为根本没有抵抗的余地，理由是投票人的构成：

> "the largest voting block in canada (seniors) aren't really capable of understanding this issue let alone prioritizing it." — slopinthebag [c:50212931]
> （译文：加拿大最大的投票群体（老年人）根本没法理解这个问题，更谈不上把它排在优先位置。）

> "there is literally nothing people can do. the party in charge has a majority government and a media biased enough to sell this bill as a positive thing." — slopinthebag [c:50213137]
> （译文：人们真的什么都做不了。执政党有多数政府的席位，而媒体的偏向足以把这个法案包装成好事。）

另一种把希望放在政党的自我约束上：

> "I wouldn't except a liberal MP to vote against this, it's their own plan. I wouldn't expect a conservative MP to vote against this, they believe in neoliberalism and entrenching gov and corporate power the same way the liberals do (see bill C-39, supported by both the liberals and conservatives)." — kennywinker [c:50214655]
> （译文：我不觉得自由党议员会投反对票，这是他们自己的方案。我也不觉得保守党议员会投反对票，他们同样相信新自由主义、相信强化政府和公司权力（参见 C-39 法案，两党都支持过）。）

最尴尬的一段来自一次查错记录：加拿大第 44 届和第 45 届各有自己的 C-22，同名不同案。

> "I'm embarrassed, I searched for the vote, and looked at the results of wrong bill C-22" — notnullorvoid [c:50217759]
> （译文：我很尴尬，我查了投票记录，结果查到的是另一个 C-22。）

> "And seeing the actual results makes me more hopeful that the senate may not allow it through." — notnullorvoid [c:50217759]
> （译文：而看到真实的结果之后，我反而更希望参议院不会让它通过。）

围绕“媒体到底站在哪边”的火药味更浓。一方认为“媒体由国家养着”的说法是虚构：

> "what are you even on about, this is complete nonsense" — cmrdporcupine [c:50214221]
> （译文：你到底在说什么，这完全是胡扯。）

> "the bulk of “the media” in Canada is US owned, not “state funded” (which is only the CBC)" — cmrdporcupine [c:50214221]
> （译文：加拿大大部分“媒体”是美国控股的，不是“国家资助”（国家资助的只有 CBC）。）

另一方给出的判断更冷：

> "Canada has problems - a state media that barks the party line isn't one of them." — munk-a [c:50214708]
> （译文：加拿大的问题不少，但一个只会跟着执政党口径吠叫的国家媒体不在其中。）

而一位自由党选民直接把这条讨论拽回了它的起点：

> "This is a conservative talking point. I'm a liberal voter, and I know lots of people who voted for the liberal party." — aceofspades19 [c:50217513]
> （译文：这是保守党的说法。我投票给自由党，我认识的很多自由党选民也不是这样。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 加拿大已无力抵抗 | bluefirebrand | 这事对我意义重大，但人们不在乎，我已经不想再斗了 |
| 冷漠是动员的机会 | allthetime | 外面的冷漠正是唤醒关心、扭转趋势的机会 |
| 问题不是冷漠而是信息 | shovas | 大多数加拿大人不是不在乎，是没被告知 |
| 真正的问题是跨境共享 | petcat | 数据主权的口号和正在谈的 Cloud Act 条约是同一回事的两面 |
| 时间尺度不等人 | sandworm101 | 特朗普是症状不是病灶，不会回到从前 |
| 协议是不对等的 | petcat | 加拿大公司几乎不卖给美国人，所以没什么可换 |
| 企业会撤出加拿大 | tensor | Apple 在英国已经这么干过一次，这不是狼来了 |
| 企业只会服从 | cowlevel | 他们会服从，他们一向服从 |
| 宪法接不住事前拦截 | AlexandrB | 宪章理论上保护公民，实践中可以被政府违反对待 |
| 参议院能给出软着陆 | wmchen | 隐私倡导者能指望的，是修正案砍掉最坏的部分 |
| 投票根本拦不住 | slopinthebag | 执政党有多数席位，媒体也愿意把它包装成好事 |
| 自由党选民不认这个说法 | aceofspades19 | 我投票给自由党，我认识的人也不是这么想的 |

## 总体情绪

最值得注意的不是有人支持这个法案，而是几乎没人愿意公开支持它。评论区里出现频率最高的句式是“人们不在乎”“抵抗是徒劳的”，另一批人则用更激烈的语气回击——“从你的椅子上起来，去做点什么”。两种情绪指向同一个结论：这项法案真正的阻力不在舆论场，而在流程里——众议院已经过了，剩下的关卡是一个多数党占优、且很少真正废掉法案的参议院。

技术部分的讨论反而稀薄。后门、元数据留存、跨境执法共享，这三条在原帖里都写得清清楚楚，评论区却花了大半篇幅在争选举周期、媒体偏向、老年人投票意愿，以及加拿大到底算不算还在“睡”着。有位读者甚至在查投票记录时查错了同名法案，纠正之后反倒更乐观。这种讨论密度本身说明了一件事：对于绝大多数人，C-22 不是一个技术问题，而是一个“没轮到我”的政治问题。

法案还没落地，窗口还没关，但留给反对者的选择其实很窄：要么接受它作为加拿大的新常态，要么把希望押在一次概率不高、却并非为零的参议院修正案上。后门该怎么留、数据该交给谁，这些问题讨论得并不充分；真正稀缺的是在投票之前，还愿意为它投票的人。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Canadians Are Running Out Of Time To Oppose The Dangerous C-22 Surveillance Bill（EFF） | https://www.eff.org/deeplinks/2026/10/canadians-are-running-out-time-oppose-dangerous-c-22-surveillance-bill |
| 2 | Canadians are running out of time to oppose Bill C-22（HN 讨论） | https://news.ycombinator.com/item?id=50202114 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br>本文涉及加拿大政府监控立法、跨境数据共享、选举与媒体立场等争议性讨论，部分被引言论带有明确立场，引用仅用于还原讨论现场，不构成对任何一方观点的认同或背书。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
