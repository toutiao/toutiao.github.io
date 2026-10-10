---
layout: post
title: >-
  「123456」保护 880 万人：丹麦 CPR 数据库泄露事件
date: 2026-10-10
hn_id: 50031269
categories: [articles]
excerpt: >-
  Pays ApS 一家只有 2 名员工的丹麦小公司，却掌握着丹麦全国 CPR 数据库的合法访问权限。黑客用一个前员工泄露的「123456」密码潜伏 22 天拉走 880 万条个人档案，直到账单异常才被发现。
tagline: >-
  这次泄露不是被发现的，是被算账算出来的。
---

## 原文概要

> 来源：HN 热门榜 (/best)

2026 年 10 月初，丹麦最大的数据泄露事件曝光：位于欧登塞（Odense）、仅有 2 名员工的 IT 公司 Pays ApS，其用于访问丹麦中央人口登记系统 CPR（Det Centrale Personregister）的账户密码竟然是「123456」——这一密码在三个账户上同时使用，其中还包括管理员账号。

事件始于 9 月 10 日。黑客使用一个属于某小公司前员工的泄露密码获取了初始访问，随后写了两段小程序，持续从 CPR 系统抽取数据并存储到外部。访问一直持续到 10 月 2 日被发现，共持续 21 天 17 小时，暴露与约 880 万个 CPR 号码相关的信息。Pays ApS 自 2026 年 7 月起在丹麦中央商业登记册中只有 2 名员工。

Pays ApS 的所有者兼总经理 Sophie Laursen 向 TV 2 确认："我们可以确认我们就是那家公司——我们对 CPR 系统的合法查询权限被滥用。"奥尔堡大学电气与计算机工程系教授 Jens Myrup Pedersen 直言这家公司的密码安全"无望"："『123456』这串密码是你拿到常见密码列表后，最先会尝试的几个之一。基本上就是一道敞开的大门。我很难想象还能有更差的安全。出事只是时间问题。"

匿名黑客向《Politiken》声称，自己就是攻击者，并表示获取访问"并不特别困难"，同时表示没有出售或公开数据的计划。

最耐人寻味的细节是：这次泄露被发现，不是因为有安全告警，也不是因为异常监控，而是查询账单比预期高。

---

## 讨论焦点

### 1. 密码离谱到段子都接不住

帖子下面第一个拿到回复的问题是："lol, it's a joke right？"（这是开玩笑吧？）——然后立刻有人回答："Completely real."（完全是真的。）

> "That's the same combination I have on my luggage!" — piker [c:50031385]
> （译：这密码跟我行李箱上的一样！）

> "lol, it's a joke right ?" — m00dy [c:50031391]
> （译：笑，这是开玩笑吧？）

> "Completely real." — lordnacho [c:50031434]
> （译：完全是真的。）

piker 那句"和我行李箱密码一样"的梗一出来，评论里就刷了一波《Spaceballs》经典吐槽片段的链接，外加 "hunter2"、"TSA 行李箱锁"、"我赌你不是唯一这么想"、"我本来也想说同样的话"。整个楼层瞬间变成梗集合——这其实是最响亮的指责：把国家级身份库的访问密码设成"123456"已经超出讽刺的接受范围，连段子都接不住。

### 2. CPR = 同时充当用户名和密码

CPR 是丹麦每位居民的唯一 10 位身份号码，相当于美国 SSN。讨论里不少人指出，它的根本问题不只是"123456"——是号码本身编码了太多信息。

> "It's unique, but it encodes your birthday and sex. There's only 500 numbers it could be, assuming someone knows those other things about you. In any case, there are alternative systems for authorisation." — lordnacho [c:50031468]
> （译：它是唯一的，但里面编码了你的生日和性别。假设有人知道你的生日和性别，那只剩 500 个可能。无论如何，还有其他可用的授权方式。）

> "Personal numbers and social security numbers in US are horrible idea, essentially a password and username simultaneously" — nylonstrung [c:50031811]
> （译：个人号和 SSN 都是糟糕设计，本质上同时充当了用户名和密码。）

> "I'm not super familiar with SSN in US of A, but I think the Danish one is not has secret. Don't get me wrong, the leak is not good, but there is a limit to what you can do with it. Targeted and real looking spam mails come to mind. Hey <NAME> with <Address> and <CPR>, you have to log in <fake government website> to verify X Y Z. Apparently some pay day loans or similar with just CPR + name is or was a thing. Bonkers as CPR should be be treaded as a secret." — Mashimo [c:50031995]
> （译：我对美国 SSN 不太熟，但我觉得丹麦的 CPR 并不是真正保密。说实话泄露不是好事，但能做的坏事有限。我能想到的是带姓名地址 CPR 的精准钓鱼邮件：「您好，请登录某政府网站验证 X Y Z」。据说过去光凭 CPR + 姓名就能办发薪日贷款。CPR 应该被当作机密对待，现在这套逻辑太疯狂了。）

CPR 编码生日、性别、世纪，相当于"半公开的密钥"。它被设计成日常身份标识的同时又被用于授权，于是钓鱼、伪造身份、申请发薪日贷款全都打开了口子。Mashimo 的吐槽一针见血——这种号码被"假定公开"，但又"假定能用来验证身份"，两个假设互相打架。

### 3. 22 天无人察觉，问题不止密码

账号失守或许只是引子，22 天不被察觉才是真正的灾难。

> "So it was actually two weaknesses: The non-password at a two-person IT company (Pays ApS) And then completely unchecked access to the CPR database for 22 days which apparently does not have monitoring or limits if someone tries to access all the records (they must have made some 16k downloads per hour)." — ano-ther [c:50031560]
> （译：实际上是两个弱点：一个两人 IT 公司用了一组无意义的密码，外加 22 天里 CPR 数据库完全没有访问监控或限速（按时间算他们每小时得拉走 1.6 万条记录）。）

> "A least privilege access redesign seems reasonable too. And abuse monitoring; the leak went on for 21 days undetected." — zweifuss [c:50031535]
> （译：重新设计最小权限访问也合理。还有滥用监控——泄露持续了 21 天都没人察觉。）

> "The 'fun' part is that it was only caught because the bill for the lookups was higher than expected. Had the attackers done a lookup every now and then, nobody would have noticed. Apparently no one cares, until it becomes a financial issue. IT professionels have pointed out that the system is deeply flawed for 15 - 20 years, at least, but every issue has been papered over with more IT, tweaks to software and websites. The fundamental issues have never been addressed." — mrweasel [c:50032207]
> （译：有趣的是，它被发现只是因为查询账单比预期高。如果攻击者每次只查一两条，根本不会被发现。显然没人在意，直到它变成一个财务问题。IT 行业的人指出这套系统至少存在了 15 到 20 年的根本性缺陷，但每次都是堆更多 IT、补丁、网站去糊弄。根本问题从来没解决过。）

ano-ther 给了一个具体的"速率"：880 万条记录 / 22 天 ≈ 1.6 万条/小时。mrweasel 的"15 到 20 年"则点出了一个反复被忽视的事实——丹麦这套系统不是今天才出问题的，每次都是打补丁，没有动结构。账单异常是触发点，不是监控。

### 4. 该怪谁？问责是不是做样子

讨论里反复出现一句话：出事就开除最低层的小兵，事情就过去了。

> "I'm less shocked than I should be. National ID registries can be incredibly convenient, but when something goes wrong, it can go terribly wrong. Despite my general misgivings, I hope the IT company is visibly held accountable." — zweifuss [c:50031412]
> （译：我没我应该有的那么震惊。国家级身份登记库可以非常方便，但一旦出问题就会非常严重。尽管我有保留意见，我还是希望这家 IT 公司被显著地追究责任。）

> "This is the likely outcome. It was a company employing 2 people." — tossandthrow [c:50031553]
> （译：这可能就是结局了。一家只有 2 个员工的公司。）

> "Or simply make people who choose insecure passwords criminally responsible for the fallout." — iLoveOncall [c:50031522]
> （译：或者干脆让那些选了弱密码的人为后果承担刑事责任。）

> "Yeah that is a pretty weird opinion. Who cares about if he gets fired. He should be charged with criminal negligence and face prison time. Everyone is responsible for their own actions and its always possible to quit." — tokai [c:50031890]
> （译：说他会被开除这种观点挺奇怪。谁关心他是不是被开除。应当以刑事过失起诉，让责任人坐牢。每个人都要为自己的行为负责，而且永远可以辞职不干。）

> "Massive reorganisation will only happen if companies with poor security record go out of business, while competent ones win market share. Otherwise shareholders do not care, because they do not have skin in the game. Same for government staff." — miohtama [c:50031935]
> （译：只有当安全记录差的公司倒闭、靠谱的公司拿到市场份额时，才会出现大规模重组。否则股东不会在意，因为他们没有切身利害。政府员工也一样。）

tossandthrow 那句"公司就 2 个人"几乎就是预言——问责到位之前公司可能已经不存在了。tokai 主张刑事过失，miohtama 则说真正的市场压力才能推动重组。两派的共同点是：现状下没有人真正在承担后果。

### 5. MFA + 安全/效率伪二元对立

最后这一组讨论从一个最基本的问题开始。

> "Did they have MFA?" — croes [c:50031505]
> （译：他们启用了 MFA 吗？）

> "Nope." — IceDane [c:50032676]
> （译：没有。）

问题就这么结束了。然后话题自然滑向"为什么安全这么差"的更大争论：很多人把"安全 vs 效率"摆成天然对立。

> "It's tussle between two counter-acting forces at play. This get's worse when the overarching authority that supervises both departments, has no clue about how to hit a balanced prioritization." — zkmon [c:50031527]
> （译：这是两股反向力量的拉扯。当同时监督两个部门的高层根本没能力做出平衡的优先级排序时，情况会更糟。）

> "It really doesn't have to be, and setting things up as adversarial is counter-productive. Pretending that you're 'balancing' two competing alternatives when they may not even be opposed is a problem..." — tialaramex [c:50031596]
> （译：其实不必如此。把事情摆成对抗本身就是反生产力的。假装你在"权衡"两个甚至可能并不对立的选项，这本身就是问题……）

> "Well, it's this one? Or at least for a wide array of practices. To take a trivial example, can you explain how switching encryption from DES to AES (a clear improvement to security) is counteractive to productivity? Of course not, whether it's AES or ChaCha20-Poly1305 or ROT13 the choice of underlying cipher is transparent to the higher level user/application." — xoa [c:50032361]
> （译：好吧，但至少在很多实际做法上，这个世界就是这样的。举个最简单的例子：你能解释把加密从 DES 换成 AES（明确的安全改进）怎么会和效率对立吗？当然不能。无论选 AES、ChaCha20-Poly1305 还是 ROT13，对上层用户和应用都是透明的。）

> "You are presenting a false dilemma (probably unintentionally). While security can be at odds with usability, basic measures like password generation and management are a solved problem. In fact using password manager is more convenient than typing password manually, even 123456 :)" — ulfbert_inc [c:50031597]
> （译：你给出了一个伪两难（可能无意）。虽然安全和易用性可能冲突，但密码生成与管理这种基础措施早已是已解决的问题。事实上使用密码管理器比手动输入密码更方便，哪怕是 123456 也是（笑）。）

zkmon 先抛"安全/效率天然对立"，tialaramex、xoa、ulfbert_inc 接连反驳。xoa 那个 DES→AES 的例子尤其到位：底层加密换成更强的，调用方一行代码都不用改。ulfbert_inc 的笑点是——密码管理器连"123456"都能存进去还更省事。辩论到最后一句话其实指向 Pays ApS 的现实：他们连这种"既安全又省事"的免费方案都没用。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 系统不该接受这种密码 | caaqil [c:50031599] | "任何（被无能的人设计的）能接受这种密码的系统都活该被攻破。" |
| CPR 设计本身就有问题 | nylonstrung [c:50031811] | "CPR / SSN 同时充当用户名和密码，从设计就糟糕。" |
| 真正的失败是 22 天零监控 | ano-ther [c:50031560] | "两个失败叠加：弱密码 + 完全没有滥用监控。" |
| 该让责任人坐牢 | tokai [c:50031890] | "应当以刑事过失起诉，让责任人坐牢。" |
| 没人会被真正追责 | tossandthrow [c:50031553] | "公司就 2 个人，结局很可能是它不复存在。" |
| 该学 PCI：第三方要常审计 | sokols [c:50031500] | "CPR 第三方访问方应像 PCI 一样定期审计。" |
| 安全 / 效率不是真对立 | xoa [c:50032361] | "AES 换 DES 不影响效率，密码管理器比手动输入更方便。" |

---

## 总体情绪

整场讨论几乎没人为 Pays ApS 辩护——这本身说明了问题。在 HN 文化里「123456」是个段子；放在国家级身份数据库的访问账号上，它就成了一个让账单异常爆出来的安全事故。

更深一层的情绪分歧不是"要不要问责"，而是"问责有用吗"。怀疑派觉得开除小兵、新闻过去就结束了；激进派主张把弱密码的人按刑事过失起诉；中间派（sokols）则提出更像 PCI 那样的常态化审计流程。mrweasel 那句"直到变成财务问题才被发现"基本概括了这一切——8.8 百万条记录在 22 天里被抽走，最后救火的是账单。

"这次泄露不是被发现的，是被算账算出来的。"——这大概是整场讨论最锋利的结语。

---

## 引用帖子

| # | 标题 | 链接 |
|---|---|---|
| 1 | `'123456' password used in massive Danish CPR data breach` | https://news.ycombinator.com/item?id=50031269 |
| 2 | `The Copenhagen Post 原文` | https://cphpost.dk/2026-10-10/news/round-up/123456-password-used-in-massive-danish-cpr-data-breach/ |

---

## 免责声明

<div class="disclaimer">
本文由 AI 辅助整理自 HN 热门讨论。所有引文均保留原英文；事实部分请以原始来源为准。
<br><br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
