---
layout: post
title: >-
  30 年前 9,375 股 NVIDIA 期权，如今值 10 亿？— HN 讨论摘要
date: 2026-09-29
hn_id: 49872723
categories: [articles]
excerpt: >-
  Eric Gullichsen 1993 年受邀加入 NVIDIA 技术顾问委员会，拿下 25,000 股期权却只行使 15,625 股；480x 拆股后差额膨胀成 450 万股。HN 读者一边同情，一边用 90 天期权失效期和加州 4 年书面合同诉讼时效把他的故事拆得干干净净。
tagline: >-
  期权不是股票，30 年的复利不是天降横财。
---

## 原文概要

这篇文章来自 HN 热门榜首（[HN 讨论](https://news.ycombinator.com/item?id=49872723)）。作者 Eric Gullichsen 自陈：1993 年他受 Jensen Huang 之邀加入 NVIDIA 技术顾问委员会，当年 9 月获授 25,000 股期权，按合同"按季度分批授予，授予日后一年全部归属"。当年见面的地点是他停在 Sausalito 的船屋 S.S. Vallejo（船的前主人是 Jean Varda 和 Alan Watts），同船的还有 Curtis Priem 和 Chris Malachowsky。

让他进入 NVIDIA 视野的关键技术是**双二次纹理映射**（biquadratic texture mapping）—— Curtis Priem 在 Sun Microsystems 设计 SPARCstation GX 时就和他合作过，这项非线性的纹理映射后来写进 US5796426A 系列专利。NVIDIA 把这项能力塞进第一款产品 NV1，结果 1995 年出货后微软 DirectX 直接砍掉 quad 支持，只留三角形，公司差点因此倒掉、大规模裁员。

1996 年 4 月 NVIDIA 的 CFO 来信说 15,625 股已归属、必须行使，他行使了，然后就忘了。直到 2024 年被炒币朋友提醒 NVDA 涨成"地球上最重要的公司"，他才翻出当年的期权协议。协议上白纸黑字写的是按季度一年内全部归属；按这算法，25,000 股本应在 CFO 来信前就全部到手。差额的 9,375 股经 NVDA 累计 480x 拆股后膨胀成约 4,500,000 股。

他请了 Allan Steyer（Steyer Lowenthal）和 Chris Burke（Korein Tillery）两位律师去和 NVIDIA 内部律师 + 外部律所 Cooley 交锋一年，最后被"诉讼时效已过"挡回。加州对书面合同的诉讼时效是 4 年。

## 讨论焦点

### 期权不是股票，90 天归属期先把故事拆开

HN 评论区最先达成的共识是：标题里"owed a billion dollars"是个修辞胜利、法律败仗。期权不是股票，期权有过期日，30 年后还在追究的金额还得按"当年价值 + 利息"算，不是按今日股价算。

> "Even if they won, Nvidia would only be obligated to deliver a fresh option contract. E.g. they would issue options today with the same strike price difference." — imtringued [c:49874789]
>
> （译文：就算他们赢了，NVIDIA 也只是有义务交付一份新的期权合约——比如按同样的行权价差发一批今天的期权。）

> "1. Time barring is pretty iron clad. ... 2. If a court did find in favor of the plaintiff, the court would be more likely to award the 90s cash value of the stock, plus interest, rather than awarding the shares or current market value" — bragr [c:49873437]
>
> （译文：1. 时效问题几乎铁板一块。4. 即便法院判原告胜，更可能的判赔也是 90 年代当时那个现金价值加利息，而不是股票或当下市值。）

另一位读者把这层意思推到极致——

> "There's absolutely no legal case here." — askjdfksdbfhk [c:49875670]
>
> （译文：这里根本没有任何可打的官司。）

技术细节之所以重要，是因为期权过期后只能按授予日行权价补偿；按 1999 年 NVDA IPO 价 $12、行权价 $0.05 算，9,375 股期权的实际赔付价值大约只在六位数美元区间。标题里的"十亿"取决于 NVDA 涨到今天的复利故事，但**法院不会替你脑补 30 年持股策略**。

### 诉讼时效：法律工具 vs 道德直觉

第二大主题是诉讼时效本身的存在是否合理。多人搬出加州《自我帮助》页对书面合同的 4 年时效做硬性反对；但另一些读者把"30 年后才主张权利"看作社会契约层面的问题。

> "Yeah I never understand this idea that 'if you avoid getting caught long enough, you deserve to enjoy the spoils of your crime.'" — ozozozd [c:49873657]
>
> （译文：我一直不理解这种想法——"只要你躲得够久，赃物就归你了"。）

> "One of the important functions of a legal system is to settle rights and obligations. Settled, transparent rights and obligations are also integral to notions of fairness and justice, so it's not a zero sum thing that statutes of limitations sacrifice fairness for cold transactional efficiency." — wahern [c:49873887]
>
> （译文：法律系统的一个重要功能就是把权利义务**了结**。了结、清晰的权利义务同样是公平观念的核心——所以时效制度并不是在用冷冰冰的交易效率换公平。）

但反方同样有力——

> "What's the problem with this alternative, exactly? Some crimes already have no statute of limitations, and this hasn't caused the sky to fall." — greyface- [c:49873545]
>
> （译文：那这个替代方案到底有什么问题？有些罪行本来就没有诉讼时效，天也没塌。）

这条线最终落到一个不可调和的判断上：时效制度在保护**交易稳定性**和**第三方利益**（一旦 30 年前的合同能被翻出来，整个商业生态要承担档案无限期保留的成本），而批评者认为这等于合法化了"消失够久就免责"。Eric Gullichsen 这个案例恰好卡在两者之间——他既不是"主动维权被压"，也不是"今天突然眼红"。

### 卖出诉讼权：法律融资是不是出路？

第三条讨论线索集中在评论区反复出现的"卖给诉讼融资公司"建议。

> "You should sell your right to litigate this. There are hundreds of firms that would pay you to take this on. Would involve near zero effort for you and would also check the box of being 'about the principle'." — whall6 [c:49872996]
>
> （译文：你应该把诉讼权卖掉。有几百家公司愿意接这种单——你几乎不用出力，还能满足"为原则而战"那部分心理。）

但这个建议被立刻拆穿——

> "There's already a relatively liquid market here around legal financing, but they only finance cases that can win. This is not a case that will result in anything but a dismissal." — pclmulqdq [c:49873084]
>
> （译文：诉讼融资本来就有相对成熟的市场，但只投能赢的案子。这个案子除了被驳回不会有别的结果。）

更尖锐的一位建议——

> "Or, find one of the many interest groups who have a non-economic reason to hate NVIDIA. What OP has here is a license to go on a fishing expedition through NVIDIA." — JumpCrisscross [c:49873285]
>
> （译文：或者，找一批出于非经济理由讨厌 NVIDIA 的利益集团——作者手里握着的，是一张对 NVIDIA 进行钓鱼式调查的许可证。）

这条路在加州实际走不通：明知时效已过还要起诉，融资公司和代理律师都可能被制裁。但讨论本身暴露出 HN 读者对法律系统的**杠杆点**很熟——他们不是劝 Eric 维权，而是劝他把叙事武器化。

### 船屋、Tonga 与 90 年代硅谷黄昏门

第四条线由作者本人在评论区的回复拉起来。当有读者问他 Tonga 是怎么回事，他的回答把人拉回 90 年代末——

> "Long story, but HM George V and I were good friends and business partners in some ventures.   Most significant of which was the commercialization of the .TO ccTLD, in 1997, the first to compete with .COM." — Eric_Gullichsen [c:49873326]
>
> （译文：说来话长，但图瓦努阿国王 George V 和我是老朋友，也是商业伙伴。最重要的一项合作是 1997 年把 .TO 这个国别域名推向商用，是第一个跟 .COM 抢饭碗的。）

船屋的来历同样让人侧目——

> "Yes, the S.S. Vallejo.  Formerly owned by Jean Varda and Alan Watts.  I lived there from 1990 until 2023." — Eric_Gullichsen [c:49873300]
>
> （译文：是的，S.S. Vallejo。前主人是 Jean Varda 和 Alan Watts。我从 1990 年住到 2023 年。）

一位叫 femto 的读者立刻把他自己的平行经历摆上来，把整篇文章从"我被 NVIDIA 欠钱"降维成"硅谷早期那批人的集体创伤"——

> "I was in on the ground floor of WiFi ... I could have thrown my hat in the ring: maybe I would have got something, maybe I wouldn't have. Either way, I walked away, as I judged it wasn't worth the non-financial cost. 30 years layer I still think I made the right decision." — femto [c:49873250]
>
> （译文：我当年在 WiFi 的最前线……当时我也可以下场争一下，可能拿到点什么，也可能拿不到。最后我选择放手，因为我觉得那个"非金钱成本"不值。30 年后我依然觉得这是对的决定。）

最后还有一段轻松收尾——当读者问 70 多岁的他还在不在写代码，他答——

> "Yes. I do a lot of embedded systems things and recently some agentic auto-improvement with local LLMs on a strix halo." — Eric_Gullichsen [c:49873310]
>
> （译文：还在写。最近在本地大模型上做 agentic auto-improvement，跑在 strix halo 上。）

这种"我当年帮你起家，今天你告诉我那 9,375 股已经过期"的反差，才是评论区愿意花 400+ 条回复陪他聊的根本原因。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 期权不是股票，标题哗众取宠 | imtringued [c:49874789] | 就算赢了，法院判赔也只按当年价值，不是今天 NVDA 的市值。 |
| 没有任何法律上的胜算 | askjdfksdbfhk [c:49875670] | 这故事有趣，但没有任何可打的官司。 |
| 时效问题铁板一块 | bragr [c:49873437] | 1/2/3 三条理由拆掉诉讼可能：时效严苛、判赔保守、追诉成本过高。 |
| 时效本身有问题 | ozozozd [c:49873657] | "躲得够久就能合法占有赃物"，这种逻辑说不通。 |
| 把诉讼权卖给融资公司 | whall6 [c:49872996] | 有公司专门接这种"为原则而战"的案子。 |
| 诉讼融资只投能赢的案子 | pclmulqdq [c:49873084] | 融资市场不会接一个注定驳回的案子。 |
| 钓鱼式调查 NVIDIA | JumpCrisscross [c:49873285] | 找利益集团把这件事武器化，比打官司有用。 |
| 平行案例：自洽的放弃 | femto [c:49873250] | 当年我也可以争 WiFi 的份额，但选择放手，30 年后看还是对的。 |
| 90 年代硅谷集体记忆 | Eric_Gullichsen [c:49873300] | 船屋、Tonga、DirectX 砍 quad……这是整一代人的故事。 |

## 总体情绪

讨论整体偏**冷峻 + 同情并存**。HN 读者没有站队"Eric 是受害者"或"NVIDIA 是恶霸"——他们一边承认这个故事的荒诞与讽刺价值，一边用 90 天期权失效期、加州 4 年书面合同时效、以及"期权按授予日行权价算不是按今日股价算"这三把刀把"billion dollars owed"切成薄片。少数持道德立场的读者反击时效制度本身，认为 30 年时效等于合法化"消失即免责"，但他们也承认这条线打不赢。

整场讨论的真正主角不是 NVIDIA，也不是 Eric Gullichsen，而是**期权、合同、时效这三样 90 年代硅谷没完全搞明白的金融基础设施**。Eric 故事的力量在于：他不是投资人，他是 NVIDIA 第一个版本的共同建造者之一——船屋开董事会、biquadratic 写进 NV1、然后他远走 Tonga、和图瓦努阿国王一起做 .TO。30 年后回头看，期权协议里那行"quarterly installments"和"one year from Grant Date"既是他的功劳簿，也是他被自己时效制度吃掉的那 9,375 股。

十年后没人会记得这次讨论，但 Eric Gullichsen 还会记得——他在船屋里见过 Jensen，那个决定他今天不必再算账的瞬间。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Owed a billion dollars in Nvidia stock | https://news.ycombinator.com/item?id=49872723 |

<div class="disclaimer">

本摘要由 AI 模型辅助生成，仅供了解 HN 讨论脉络之用，文中观点不代表本站立场。引文均为 HN 用户公开发表的评论，按 Creative Commons CC-BY 引用；译文仅供参考，可能与原文语气有出入。

<br><br><em>本摘要由 AI 模型辅助生成：MiniMax-M3/MiniMax-M3</em>

</div>