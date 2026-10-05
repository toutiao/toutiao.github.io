---
layout: post
title: >-
  Pixel 11 缺 MTE 硬件——GrapheneOS 考虑跳过这代——HN 讨论摘要
date: 2026-10-06
hn_id: 49964303
categories: [articles]
excerpt: >-
  Pixel 11 缺了 ARM 硬件内存标签，GrapheneOS 工作一周后放弃移植；社区讨论分流到 Google 的 OEM 限制、Motorola 替代方案以及 Pixel 手机是否已成"已解决问题"。
tagline: >-
  Google 砍了 MTE，省下的钱还不够付 Pixel 11 的智商税。
---

## 原文概要

GrapheneOS 团队发了一条 Pixel 11 系列移植进展公告：他们花了一周时间做了部分移植，最后被迫中断——原因是 Pixel 11 在软件、固件层面"几乎可以肯定也在硬件层面"缺少对 ARM 硬件内存标签 (MTE) 的支持。MTE 是 GrapheneOS 从 Pixel 8 (2023 年 10 月) 开始贯穿整个基础 OS 的核心防护机制，覆盖内核与每一个标准基础 OS 进程，对远程漏洞和大量本地漏洞都有显著效果。

公告同时给出 Pixel 11 的其他改进：后量子安全验证启动 (ML-DSA)、用 AOSP IMS 替换三星 Shannon IMS、Titan M3 安全芯片（首次解锁前的数据提取防护会显著提升）。但失去 MTE 直接"砸穿"了首次解锁后的安全性。GrapheneOS 的建议非常直接——不要买 Pixel 11。Pixel 8/9/10 的综合安全性更高，Pixel 10 价格更便宜且同样有 MTE。他们尚未决定如何处理这一代，可能直接跳过 Pixel 11，把全部精力转向摩托罗拉合作机型。

公告还顺带对比了下代高通骁龙 8 Elite Gen 5：单核 CPU 性能高出 40%，多核高出 80%，GPU 高出 100% 以上，蜂窝射频大幅改善，并补齐了硬件 MTE。这将是首款内置 GrapheneOS 的摩托罗拉手机所采用的芯片。

Google 的另一项决定也在这波讨论中被反复提及：非三星 Android OEM 不被允许直接发售预装 GrapheneOS 的设备，Google 只在配额内放行。工作正在进行规避，最终仍会有设备以 GrapheneOS 为出厂系统发售，不受 Google 数量限制。Pixel 11 这条新闻的讨论主线因此很快从"要不要买新机"滑向了"Google 的 OEM 政策是不是反竞争"。

来源：[HN 热门榜](/news)](https://news.ycombinator.com/item?id=49964303)（270 分，148 条评论，3 小时前，由 finnlab 提交）；原文链接：https://discuss.grapheneos.org/d/41564-pixel-11-doesnt-yet-meet-the-grapheneos-security-standards-and-may-be-skipped

## 讨论焦点

### MTE：Pixel 11 仍值不值得？

部分读者认为，Pixel 11 至少在 Titan M3 的 BFU 防护上有提升，缺 MTE 不至于让整台机器报废。一位用户反驳说："现在没 MTE 就是没 MTE。我买过太多'未来会加上'的空头支票。EOL。"

> "It's not there now -> it's not supported. EOL." — Luker88 [c:49965321]
>
> （译文）

另一种思路绕开了 Google——既然 MTE 是硬件特性，为什么 GrapheneOS 不能自己把它打开，非要等 Google OS 端启用？提问者指出 Pixel 11 在硬件层面"几乎确定"没有 MTE，这条路其实走不通。

> "Why are we dependent on Google to enable MTE on the OS-side? If it's a hardware feature, why couldn't GrapheneOS enable it in GrapheneOS even if Google's OS wouldn't enable it?" — JacobKfromIRC [c:49967069]
>
> （译文）

把公告本身视为"老新闻"也是一种立场。该公告的早期版本早在 8 月就发过，GrapheneOS 在 9 月部分回滚过措辞；这次只是把已知的结论再讲一遍。

> "Quite a bad signal-to-noise ratio in this link. It's an emotional discussion about Google not supporting MTE on Pixel 11 (old news of August, GrapheneOS had to roll back that statement in September [0]). Now the question is whether MTE will be enabled by Google as part of a future OS-upgrade, to which there is no definite answer AFAIK" — rickdeckard [c:49964683]
>
> （译文）

### Google 限制 OEM 预装 GrapheneOS：反竞争还是"安全需要"？

这条线索被多位读者定性为"90 年代末微软级别的反竞争"。论据：Google 当年靠"开放"从 Windows Phone 抢市场，现在要收回承诺；同时被拿来类比的是 CyanogenMod 商业化时 Google 向 OEM 施压的旧事。

> "The much more interesting recent news IMO is that Google is not allowing (non-Samsung) OEMs to sell devices with GrapheneOS... But this is really end-90s/begin-00s Microsoft levels of anti-competitiveness. I'm surprised that (particularly non-US) regulators are not investigating them yet." — microtonal [c:49964791]
>
> （译文）

但 Google 的理由始终是"安全"——一旦 GrapheneOS 出现破口，所有非 Google 认证的 Android 都会被牵连，而 GrapheneOS 恰恰戳穿了"为了安全"这个万能借口。欧盟 2018 年因此罚过 Google 40 亿欧元，但行为模式并未改变。

> "GrapheneOS is especially annoying for them as it destroys their blanket excuse that it's \"\"for security\"\"." — realusername [c:49965866]
>
> （译文）

一位用户提出了非常具体的反制建议：直接走欧盟反垄断举报通道。

> "You can always notify the EC anti competition whatsdpg through their wistleblower portal:)" — pipodeclown [c:49965120]
>
> （译文）

另一条反驳思路是：苹果也从来不允许第三方设备运行 macOS/iOS，Google 限制的只是"别家 OEM 卖别家的手机时能不能用别家的 OS"。两者性质不同。

> "Apple doesn't allow Apple selling Apple devices with other operating systems. Google doesn't allow other OEMs selling the OEMs' devices with other operating systems. Big difference." — microtonal [c:49965719]
>
> （译文）

把监管不作为归因于"政府自己想用 Play Integrity 强推数字身份"也是一种解释：监管者没有动力去打开这道口子。

> "Because corporate managed phones are required for all the id crap governance franchises intend to foist on people." — verisimi [c:49966412]
>
> （译文）

### Motorola 替代方案：怎么卖才是真问题

绕过 Google 限制的工作路径已经存在：OEM 出厂搭载 Google 认证的 Android，第三方（非 OEM）批量买入再刷成 GrapheneOS 出货。但这就回到一个基本问题——你愿意买一台预装系统"可能被动过手脚"的手机吗？

> "One obvious challenge with the distribution is: would you want to buy a phone with pre-installed GrapheneOS? This seems similar to wanting to follow the advice of 'only buy bottled water on your trip to India', but the bottle you're buying has the cap removed so they could put a straw in it for your convenience." — sebastiennight [c:49966978]
>
> （译文）

也有读者澄清：摩托罗拉和 GrapheneOS 的合作原本就是出厂即装 GrapheneOS 的方案，最近没有改变。

> "Unless they've recently changed the deal, they'll be selling GOS out of the box. That was the announcement two or so years ago, and so far as I know nothing had changed." — eszed [c:49966483]
>
> （译文）

### 微软 / 闭源武器化的岔路

讨论在"反竞争"话题上很快滑向了闭源软件本身是否"邪恶"的辩论。一位用户引用了 Bill Gates 早年关于"应该更早派人去华盛顿"的访谈，由此引发了对"系统逼人变坏"的辩护。

> "I saw an interview with Bill Gates once where he said that one thing he would've done differently is more quickly come around to the idea of sending people to Washington. Apparently he didn't like the idea of lobbying and that cost them when the regulators started coming for them" — subarctic [c:49965504]
>
> （译文）

另一条支线则直接给这个辩护打脸——Bill Gates 写给爱好者的公开信、以及 Brad Smith 的言论都把微软定位成"知识产权驱动"的公司。

> "Microsoft was founded on the premise that software is valuable intellectual property that people should pay for. --Bill Gates ... Microsoft was founded on intellectual property. Intellectual property is the foundation of our business. --Brad Smith" — bayindirh [c:49965591]
>
> （译文）

也有人抬出《三体·黑暗森林》的"维度折叠武器"做比喻：开源一旦以"免费+广告"的模式被武器化，就像向宇宙中丢出一颗永久降低自由度的炸弹，再无收回的可能。

> "Some business models - like OSS, and free-with-ads - are like dimension-folding weapons from Dark Forest trilogy: once deployed, there is no stopping them, they just permanently drop a degree of freedom from the universe, inside a shell expanding at the speed of light." — TeMPOraL [c:49966556]
>
> （译文）

### 手机是不是已经"被解决"了

和"要不要换机"挂钩最直接的，是"再换没意义"的论调。这位用户手持 Pixel 9a，本来看过 Pixel 10，发现 Pixel 11 在 10 基础上的提升"小得荒谬"，意识到这条产品线早就过了大改期。

> "I have Pixel 9a and considered Pixel 10 for a while, but seeing Pixel 11 show up with absurdly microscopic improvements over 10 made me realize, that this smartphone line is just a solved problem since years ago." — mystifyingpoi [c:49965282]
>
> （译文）

维护 Pixel 10 Pro 的用户对升级动力也没兴趣。Pixel 11 是 RAMpocalypse 之后的第一代 Pixel，硬件妥协太多。

> "The Pixel 11 is the first Pixel phone to be released after the RAMpocolypse. It has made a lot of compromises in the name of lowering cost. I am definitely going to skip that generation." — aftbit [c:49964734]
>
> （译文）

但反对意见同样存在：这位用户从 Pixel 10 Pro 16/256 升级到 11P 16/512，只花了大约 650 欧元，原因是 SoC 和 modem 组合效率提升 30-40%——更凉、更不焦虑电池。

> "I used the OP15 in the meantime and its ram management and (ironically enough) performance in day to day apps was somehow much worse. It unloaded apps, skipped notifications, apps took longer to open. Google have put in a lot of work into software ahead of the rampocalipse." — yaro330 [c:49966201]
>
> （译文）

Pixel 8 主板随机烧毁被多人提及，成了反对"用到坏再换"论调的实证：旅行中突然失联、本地未上传资料清零、eSIM 无法自行转移、2FA 备份丢失，全是真实代价。

> "Just off the dome: - Suddenly being without a phone while you're travelling or dealing with something important is generally not fun - Anything stored locally that isn't backed up is gone - You can't transfer over your eSIM yourself - Probably going to be a pain in the ass to get into accounts where the now brick was set up for 2FA" — hbn [c:49965088]
>
> （译文）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| MTE 缺失即 EOL | Luker88 [c:49965321] | 现在没 MTE 就是没 MTE，空头支票不算数 |
| Google OEM 政策堪比反竞争 | microtonal [c:49964791] | 限制别家 OEM 装别家 OS，比 90 年代微软还狠 |
| Google 借"安全"当遮羞布 | realusername [c:49965866] | 欧盟罚 40 亿欧元也拦不住，行为模式没改过 |
| 直接走欧盟举报通道 | pipodeclown [c:49965120] | EC 反垄断举报渠道现成的 |
| 苹果限制 ≠ Google 限制 | microtonal [c:49965719] | Apple 管自家事，Google 管别家事，性质不同 |
| 监管不作为是政府需要 Play Integrity | verisimi [c:49966412] | 政府自己要用企业管控手机当数字身份基础设施 |
| 预装 GrapheneOS 反而不可信 | sebastiennight [c:49966978] | 像去印度买瓶装水，瓶盖被拆开过 |
| Motorola 出厂即装方案没变 | eszed [c:49966483] | 两三年前就是这么定的 |
| 手机早已过了大改期 | mystifyingpoi [c:49965282] | Pixel 11 对 10 的提升"小得荒谬" |
| 升级 11 仍有真实价值 | yaro330 [c:49966201] | SoC+modem 效率提升 30-40%，650 欧换到值得 |
| 用到坏再换代价高 | hbn [c:49965088] | 主板随机烧毁 = 旅行断联 + 本地资料清零 + 2FA 锁死 |
| Google 用闭源武器化变现 | bayindirh [c:49965591] | 微软的根基就是知识产权，不是"被系统逼变坏" |
| 监管是科技公司主动布局的结果 | someonebaggy [c:49965398] | 大公司学会了先和监管穿同一条裤子 |
| Bill Gates 的"被迫变坏"叙事站不住 | subarctic [c:49965504] | 他后悔没更早派人去华盛顿游说 |

## 总体情绪

讨论大体分为三条主线：第一条围绕 Pixel 11 本身——这是一台在 AFU 防护上明显退步、在 BFU 防护上有小幅前进、但综合性价比不如上代的设备，不少读者表示会跳过或继续持有 Pixel 8/10。第二条围绕 Google 的 OEM 政策——多家 OEM 不能预装 GrapheneOS 这一事实让"Android 是开放系统"这句话在 2026 年显得尤为空洞；监管不作为的根因被部分归结为"政府需要 Play Integrity 这类企业级管控能力来推行数字身份"。第三条则完全是哲学化的岔路——闭源软件究竟是工具还是武器，开源武器化又是不是另一种维度的"维度折叠"，这种辩论在 Pixel 11 公告下显得既跑题又合理。

一个值得记住的细节是：下一代摩托罗拉手机会搭载 Snapdragon 8 Elite Gen 5，单核性能比 Pixel 11 高 40%，并自带硬件 MTE。Google 砍掉的那一点成本，恰好是 OEM 走向开放生态的入场券。

> 当一家 OEM 主动把"我们不预装 Google"列为卖点，而 Google 用配额去堵这条路，硬件的安全差异反而成了不平等条约的修辞。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Pixel 11 doesn't yet meet the GrapheneOS security standards and may be skipped | https://news.ycombinator.com/item?id=49964303 |

## 免责声明

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3。引文均尽量保持原文，仅做翻译/摘录。所有事实性陈述均来自原文公告及 HN 评论，归原作者所有。

</div>