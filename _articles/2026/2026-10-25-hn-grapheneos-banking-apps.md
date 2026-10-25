---
layout: post
title: >-
  银行 app 开始点名放行 GrapheneOS — HN 讨论摘要
date: 2026-10-25
hn_id: 50217495
categories: [articles]
excerpt: >-
  约 10% 的银行 app 因为「不是 Google 认证系统」直接不可用，如今有十来家开始专门为 GrapheneOS 开口子。
  585 分、231 条评论，分歧不在隐私，在银行到底有没有在认真在乎安全。
tagline: >-
  银行不是突然良心发现，只是发现「不是 Google」约等于「有 root」。
---

## 原文概要

10 月 24 日，一条来自 GrapheneOS 官方账号（Mastodon）的说明被顶到 585 分、231 条评论。帖子本身只有三段话，但每段都踩在 Android 生态最脏的那块摩擦带上。

第一段是现状：大多数银行 app 在 GrapheneOS 上能跑，但很多 app 自身有内存破坏漏洞、反篡改检查写得不严谨，需要为每个 app 单独打开「exploit protection 兼容模式」这个开关。第二段是坏消息：约 10% 的银行 app 因为不认非 Google 认证的操作系统而直接不可用。第三段是好消息：大约十二家银行 app 开始在 Google 认证系统之外，专门放行 GrapheneOS——而且这个数字还在涨。

原文没有点名是哪十二家，只给了一个众包清单的链接：privsec.dev 上的「银行 app 与 GrapheneOS 兼容性」列表，最后更新日期是 2026 年 10 月 20 日。这份清单按国家和区域罗列了上百个银行 app 的状态：国际类里有 PayPal、Wise、Revolut、Kraken、Coinbase、Klarna、Binance、Payoneer；欧盟区里有 Trade Republic；澳大利亚那一栏最长，ANZ、CommBank、Westpac、NAB、Bendigo、Macquarie 一路排下去，还有大量挂着「Report」按钮、等着人补实测结果的条目。

于是有两个数字悬在那里：那个 10% 里，哪些是被技术挡住的、哪些是被政策挡住的，清单本身回答不了；而所谓「十二家开始点名放行」，来源是用户报告，不是银行公告。这是评论区后半程吵得最凶的地方。

## 讨论焦点

### 一、银行的安全，到底是安全还是打勾

最锋利的一句来自 ronsor，针对的是官方帖子里「很多 app 有内存破坏漏洞和写错的反篡改代码」那句：

> "Ironic for apps that are often so paranoid about \"security\" and \"hardware attestation\"" — ronsor [c:50219248]
> （译文：对那些经常对「安全」和「硬件认证」极度偏执的 app 来说，这事挺讽刺的。）

przmk 把话说得更冷：

> "Because it’s mostly about checking compliance boxes than really caring about security." — przmk [c:50219371]
> （译文：说到底那主要是为了勾选合规的框，而不是真的在乎安全。）

那么框是谁让勾的？well_ackshually 的答案不在法律里，在保险合同里：

> "Lmao, it's never legislation and/or enforcement. It's the checkboxes that their insurances told them they had to check or they wouldn't be covered. Half of the problem goes back to insurances being thieves who would do anything to not pay up, the other half goes to upper management not giving a shit about people." — well_ackshually [c:50220313]
> （译文：哈，从来就不是立法和执法的问题。是他们的保险公司让他们必须勾的那些框，否则就不给承保。问题的一半要算在那些为了不赔钱什么都能干的保险公司头上，另一半则要算在根本不在乎人的高层头上。）

ironmagma 不接受这种「corporations 没有灵魂」的套路：

> "This meme again? Corporations are not capable of anything, but corporations are made of people, and people can care." — ironmagma [c:50219662]
> （译文：又是这套梗？公司什么都干不了，但公司就是人组成的，人是会关心人的。）

paweladamczuk 则选择另一条更省事的路：

> "Call me cynical, but I would rather rely on written regulations and systems of checks than human altruism." — paweladamczuk [c:50219794]
> （译文：说我愤世嫉俗也好，但比起人的利他心，我更愿意依赖成文的法规和一套核查机制。）

### 二、银行防的其实是 root，不是 GrapheneOS

这条线索由 edent 起头。他按英国银行业的实际体感，把银行分成四类，其中第一类最狠：

> "None. Explicitly banned. And, though I feel bad for saying it, I can't blame them. If some idiot roots their phone and downloads malware, the bank may be responsible for refunding them. I can see why they don't want that headache." — edent [c:50219929]
> （译文：一类是完全不支持，明确禁止。虽然这么说我心里不好受，但我怪不了他们。要是哪个傻子 root 了自己的手机还下了恶意软件，银行可能得为此赔钱。我能理解他们为什么不想沾这个麻烦。）

> "The nice thing about the UK banking sector is that it is trivial to move banks. So I switched accounts to providers which worked with my phone and let the old ones know why I was moving." — edent [c:50219929]
> （译文：英国银行业有个好处，换银行太容易了。所以我直接换到那些能配合我手机的账户，还把原因告诉了原银行。）

justonenote 指出这套「禁令」的真实面目——银行根本没在针对 GrapheneOS，它们只是在信任 Google：

> "I doubt they are explicitly banning GrapheneOS, what they are doing is only trusting Google attestation." — justonenote [c:50220215]
> （译文：我不认为他们在明确封禁 GrapheneOS，他们做的只是信任 Google 的证明而已。）

> "The reason some banks explicitly allow GrapheneOS is because its easy for them to also trust GrapheneOS attestation, because it is not a rooted OS, and sensible security teams in banks can see that its more secure than any other Android phone including Pixels." — justonenote [c:50220215]
> （译文：一些银行之所以明确放行 GrapheneOS，是因为他们同样很容易信任 GrapheneOS 的证明——它不是被 root 过的系统，而银行里靠得住的安全团队看得出，它比包括 Pixel 在内的任何其他 Android 手机都更安全。）

Zak 从设计哲学上补了一刀：GrapheneOS 本来就不是给 root 准备的系统：

> "The central design theme of GrapheneOS is to have stronger sandboxes and more limits on what apps can access than stock Android does. Granting an app root access does exactly the opposite; someone behaving rationally and consistently usually won't want to do both on the same device." — Zak [c:50220423]
> （译文：GrapheneOS 的核心设计主题，是要有比原版 Android 更强的沙箱、更严格地限制 app 能访问什么。给 app root 权限做的恰好是相反的事；一个行事讲道理又前后一致的人，通常不会想在同一台设备上两样都要。）

那银行有没有证据表明「用非 Google 认证的系统」真的更容易被盗号？Zak 说他查过：

> "Without evidence that using an OS that isn't approved by Google or Apple actually correlates with a higher rate of account compromise or fraud, I do blame them for trying to force it on users." — Zak [c:50220227]
> （译文：如果没有证据表明「使用未经 Google 或 Apple 认证的操作系统」与更高的账户失陷或欺诈率确实相关，那我就要怪他们强迫用户接受这个设定。）

> "I've done a couple casual web searches for such evidence and come up short. If somebody has good data on this, I don't think they're publishing it." — Zak [c:50220227]
> （译文：我随便搜过几次，没找到。如果有人有这方面的硬数据，我觉得他们不会公开。）

### 三、「十二家」这个数字有多硬

riedel 抓住的是官方帖子里没写清的那部分——点名放行，和写进服务条款，是两回事：

> "Where is this list of 12+ banks that explicitly allow graphene. My understanding is if the banks do not explicitly state support also in terms of ToS, they might pull the rug any moment. With neo banks you are then basically left without a bank." — riedel [c:50220038]
> （译文：那家明确放行 GrapheneOS 的十二家以上银行名单在哪里？据我理解，如果银行没有在服务条款里明确写上支持，他们随时可能翻脸。对新型银行来说，你基本上就等于没有银行可用。）

> "I found some evidence of half a dozen that there might be support 'by desogn' (all of them might pull the rug at any time again as far as I understand TOS, which however seems true for any android in theory): Swissquote, Yuh, UBS, Starling Bank, Triodos Bankieren NL, AmeriCU Credit Union.  More?" — riedel [c:50220131]
> （译文：我找到大约六家可能「出于设计原因」支持它们的证据（就我对服务条款的理解，这些家随时可能再次翻脸，不过理论上任何 Android 都一样）：Swissquote、Yuh、UBS、Starling Bank、Triodos Bankieren NL、AmeriCU Credit Union。还有别的吗？）

pizzaiolo 补了一个反转的伏笔：此前其实有过反方向的走势。

> "After that guy was arrested for wiping his GrapheneOS phone with a duress password, some reports appeared of previously usable apps becoming unusable specifically on GrapheneOS. This now reads like a possible reversal of that trend." — pizzaiolo [c:50219775]
> （译文：那个用胁迫密码把手机擦掉的人被捕之后，就陆续有报告说，原先能用的 app 偏偏在 GrapheneOS 上用不了了。现在这篇读起来像是那个趋势的一次反转。）

至于这十二家为什么会点头，vaylian 的猜测可能最接近实情：

> "I wonder how many of these supported apps are supported, because there are some geeks on the inside of the banks who want to have their favorite mobile OS supported." — vaylian [c:50220267]
> （译文：我好奇这些被支持的 app 到底是怎么被支持上的——因为银行内部有些 geeks 恰好想让自己喜欢的手机操作系统被支持。）

### 四、真正的解法是换个银行

如果一家不行，那就换一家。这条线在评论区相当务实。

embedding-shape 先确认了这个前提在很多国家成立：

> "Are there countries where this is a hassle? Now I've only had personal banking accounts in ~3 countries (so far?), so maybe I'm in a bubble, but in none of the countries has \"switching banks\" been more than basically create a new account, start using new IBAN for incoming transfers, move direct debits to use new IBAN and start using new card(s)." — embedding-shape [c:50219983]
> （译文：有没有哪个国家换银行很麻烦？我目前也就用过三个左右国家的个人银行账户，所以也可能是我太乐观了，但这些国家里没有一个换银行比「新开一个账户、开始用新的 IBAN 收款、把自动扣款改到新 IBAN、重新启用新卡」更费事。）

lmz 立刻泼了冷水，指出这套便利是制度造出来的：

> "Having the debits move to the new IBAN automatically had to be mandated and built. It doesn't just happen. In markets with large incumbent banks they have no incentive whatsoever to make switching easy." — lmz [c:50220208]
> （译文：让自动扣款跟着新 IBAN 走，这件事必须是立法强制并且被实现出来的，它不会自己发生。在被大银行主导的市场里，他们没有任何动机让换账户变容易。）

TFNA 描述了另一个更糟的角落：

> "There are countries where, as a result of mergers, banking is now down to 3-4 banks, and they all have the same Android requirements, so switching won't get one anywhere." — TFNA [c:50220022]
> （译文：有些国家经过并购之后，整个银行业只剩三四家银行，而且它们对 Android 的要求完全一样，换来换去哪儿也去不了。）

matwood 提到税收这个绕不开的硬约束：

> "You’re right what the law says, but then you run into the Italian tax authority that will only accept an Italian IBAN to pay taxes." — matwood [c:50220561]
> （译文：法律怎么说你说得对，但接着你就会撞上意大利税务局——它只接受意大利 IBAN 报税。）

bluebarbet 给出欧盟公民的解法，顺便点评了行业的样貌：

> "If those countries are in the EU, you have the right to use a bank based in another EU country. The traditional incumbents will likely demand an in-country residential address (in direct contradiction of EU law). Which leaves the internet-only neobanks. I believe the only FOSS-compatible option is Wise, which has a modern web offering and does not even require that you install a native app." — bluebarbet [c:50220447]
> （译文：如果那些国家在欧盟内，你有权使用另一家欧盟国家的银行。传统大行大概率会要求提供本国居住地址（这与欧盟法律直接冲突）。那么剩下的就只有纯线上的新型银行了。我认为唯一兼容 FOSS 的选项是 Wise——它有相当现代的网页端，甚至不要求你安装原生 app。）

> "By contrast Revolut is a privacy-invading walled garden and should be avoided at all costs." — bluebarbet [c:50220447]
> （译文：相比之下，Revolut 是侵犯隐私的围墙花园，应该不惜代价避开。）

### 五、别让银行来决定你的手机长什么样

Arch-TK 的这段话是评论区里最完整的一次立场表达，主题是「凭什么」：

> "I use GrapheneOS, but if you as a bank want to gate access to my money via some kind of technology, you better be including it as part of the account." — Arch-TK [c:50220325]
> （译文：我用 GrapheneOS，但如果你作为银行想用某种技术手段来卡住我取钱的权限，那你最好把它算进账户条款里。）

> "Why do you expect me to be your distributed infrastructure provider? I am not going to let you require that I run your proprietary malware in order to access my own money." — Arch-TK [c:50220325]
> （译文：你凭什么指望我当你的分布式基础设施供应商？我不会为了取自己的钱，被迫运行你们的专有恶意程序。）

具体的兼容坑还有别人补。GreyStache 报了两个：

> "Works, but only every other app version. Second: works if the aosp keyboard or gboard are active but not with LeanType. Easy fix once you know, but that was not a fun time debugging." — GreyStache [c:50220326]
> （译文：一、能用，但只有每隔一个版本能用。二、在使用原生 AOSP 键盘或 Gboard 时能用，换成 LeanType 就不行。知道之后很好修，但当时调试的过程并不愉快。）

设备选择也是坑。LightBug1 说这正是他用 GrapheneOS 时最头疼的问题之一：

> "Excellent. That was one of my main issues with Graphene." — LightBug1 [c:50219926]
> （译文：太好了，这正是我用 GrapheneOS 时最头疼的问题之一。）

但答案多少有点扫兴——只支持 Pixel：

> "It's not Pixel only for no reason, there aren't any other phones which meet the rather sensible requirements at this moment. And even the latest Pixel phones have regressed." — Arch-TK [c:50220340]
> （译文：只支持 Pixel 不是没有理由的，眼下没有其他手机能满足那些相当合理的要求。而且即便是最新的 Pixel 手机也出现了回退。）

而这种「一刀切」对没有本国国籍的人格外难受。dmantis 说得平静，但结论更狠：

> "If you are not a citizen, but an immigrant, it could be very true in some parts of the world." — dmantis [c:50220353]
> （译文：如果你不是公民，而是移民，在世界某些地方这话就特别成立。）

> "I have a living permit and legal status in the country I live in, but only few banks open accounts to people like me, most just deny anyone but citizens of the country." — dmantis [c:50220353]
> （译文：我在所在国拿的是居留许可，法律身份也齐全，但只有极少数银行愿意给我开户，大多数干脆只接受本国公民。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 银行在乎的是合规，不是安全 | przmk | 勾合规的框和真的在乎安全是两回事 |
| 框是保险公司逼的 | well_ackshually | 不是立法和执法，是保险公司不勾就不给承保 |
| 公司由人组成，人会关心 | ironmagma | 别再玩「corporation 没有灵魂」这套 |
| 法规比利他心可靠 | paweladamczuk | 宁愿依赖成文规则，也不信人的善意 |
| 银行防的是 root，不是 GrapheneOS | justonenote | 它们只是信任 Google 证明，GrapheneOS 同样可被信任 |
| GrapheneOS 的设计本就排斥 root | Zak | 给 app root 与强化沙箱是背道而驰 |
| 没有证据证明非认证系统更易被盗号 | Zak | 查过，没有相关硬数据 |
| 名单没写进条款就随时会翻脸 | riedel | 新型银行翻脸等于直接没银行可用 |
| 放行背后是银行内部的 geeks | vaylian | 不是慈善，是内部有人想支持自己那套系统 |
| 换银行是最现实的解法 | edent | 英国换账户太容易，顺手还告诉了原银行 |
| 换银行的便利是立法造出来的 | lmz | 大银行没有动机让切换变简单 |
| 部分国家根本没得换 | TFNA | 并购后只剩三四家，要求还一模一样 |
| 欧盟公民可以去别国银行开户 | bluebarbet | 传统大行要本地地址，最后只剩新型银行 |
| 银行不该定义你的手机架构 | Arch-TK | 我不想当你的免费算力和专有程序的宿主 |

## 总体情绪

这场讨论的裂缝长这样：一边认为银行一直在做对的事——只认它能验证的东西，这没什么可指责的；另一边认为这些年下来的「安全」表演终于被一张兼容性清单戳破，戳破之后连补救都带着敷衍——用「兼容模式开关」给一堆有内存破坏漏洞的 app 开后门，然后宣布胜利。

中间派其实并不站在任何一边。他们更关心的是那张清单到底能信几分：十个百分点的不可用是技术原因还是政策原因，十二家点名放行是写进条款还是仅存在于用户报告。「点名的十二家」和「明确支持的十二家」，是两个差着一个数量级的集合。

真正在动的人是 edent 那一类：遇到不兼容，换一家，然后告诉旧的那家为什么换。评论区最实的一条建议不是去说服银行改，是去找另一家银行。

而原帖开头那句技术细节，可能才是最该被转发的部分：让这些 app 在非 root 系统上跑起来，靠的不是更严的检查，而是 GrapheneOS 那种更严的沙箱。银行防了十年要防的东西，和另一群人花了十年在造的东西，恰好是同一件事。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | GrapheneOS 官方账号的说明（Mastodon，2026-10-24） | https://grapheneos.social/@GrapheneOS/117492375462459244 |
| 2 | 银行 app 与 GrapheneOS 兼容性众包清单（PrivSec，最后更新 2026-10-20） | https://privsec.dev/posts/android/banking-applications-compatibility-with-grapheneos/ |
| 3 | HN 讨论 | https://news.ycombinator.com/item?id=50217495 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
