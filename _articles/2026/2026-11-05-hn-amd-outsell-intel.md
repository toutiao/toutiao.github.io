---
layout: post
title: >-
  170 亿美元对 150 亿美元：AMD 说要第一次超过 Intel，评论区在问这是不是 AI 泡沫 — HN 讨论摘要
date: 2026-11-05
hn_id: 50367125
categories: [articles]
excerpt: >-
  第三季度营收 133.77 亿美元，数据中心占到 64%，第四季度指引约 170 亿——
  若兑现将首次反超 Intel 的 150 至 160 亿。评论区不认这个数字，他们认的是：
  AMD 赢的是 AI 的那一半，Intel 输掉的是整张桌子。
tagline: >-
  Intel 十年换了三任 CEO，换来一次腰斩；AMD 只需要赶到 AI 需求的正中间。
---

> 来源：HN 讨论主帖 [AMD expects to outsell Intel in Q4 for the first time in history](https://news.ycombinator.com/item?id=50367125)，提交者 rbanffy，459 分，168 条评论。关联帖：[Intel stock collapse worsens as $3.5T chip rout spreads](https://news.ycombinator.com/item?id=50346153)，提交者 entryleveljobsc，234 分，224 条评论。原文：[Tom's Hardware](https://www.tomshardware.com/pc-components/cpus/amd-expects-to-outsell-intel-in-q4-for-the-first-time-in-history-usd17b-guidance-would-exceed-intels-projections)、[Yahoo Finance](https://finance.yahoo.com/markets/article/the-intel-stock-collapse-is-getting-worse--and-the-37-trillion-chip-rout-is-spreading-212154947.html)。本篇为 cluster 模式，主帖是 AMD 财报讨论（thread 1），Yahoo Finance 的 Intel 股价报道为 thread 2。本地归档抓到的 Tom's Hardware 页面正文大半是该站页尾论坛评论，财报数据依据原网页完整正文补齐。

## 原文概要

AMD 在 11 月 3 日盘后公布了历史最高的一个季度：营收 133.77 亿美元，上一季是 115.4 亿，一年前同期是 92.5 亿；毛利率 54%，净利润同比增长 95% 达 24.3 亿，摊薄每股收益 1.46 美元（去年同期 0.75 美元）。真正引爆讨论的不是这个季度，而是下一季度的指引：约 170 亿美元，上下浮动 3%，中值对应同比增长 66%、环比增长 27%。

Intel 给出的四季度指引是 150 亿到 160 亿美元，理由写得很直接：PC 需求走弱，加上制造产能受限。两家中值之间大约 15 亿美元的差距，意味着如果 AMD 兑现指引，它上市以来第一次在单季营收上压过 Intel。财报里还有一个更刺眼的结构：数据中心业务已经占到 AMD 总营收的 64%。

数据中心的数字是这轮增长的引擎。该部门当季营收 85.5 亿美元，同比涨 97%（去年同期 43.4 亿），环比涨 27%；营业利润涨 168% 到 28.8 亿，营业利润率从 25% 扩到 34%。AMD 把原因指向最新一代 Epyc 处理器，以及刚刚上市的 Instinct MI455X 加速卡——后者是 Helios 机架级系统的核心。公司点名 Anthropic、Meta、微软、OpenAI 和甲骨文云已经在第一代 Helios 系统上跑工作负载。

另一侧在失血。客户端与游戏部门营收 37.22 亿美元，同比降 8%、环比降 3%；客户端 CPU 卖出 29.5 亿（上一季 30.6 亿），游戏业务从一年前的 12.98 亿掉到 7.73 亿——微软和索尼少买了主机 SoC，独立显卡 Radeon RX 依然疲软；该部门营业利润下滑 34% 到 5.73 亿，利润率只剩 15%。公司预计这一块四季度还要环比收缩 20% 以上。Lisa Su 在财报里给的判断更硬：2027 年 PC 市场出货量将出现两位数百分比的下滑，AMD 只能靠企业级、高端消费和桌面处理器跑赢大盘。嵌入式部门则是另一条向上的线：营收 11.1 亿，同比增长 29%，营业利润涨 60% 到 4.53 亿，公司称 2026 年的设计订单有望超过 180 亿美元，将是连续第三年创纪录。

与此同时，Intel 的股价在走另一条曲线。10 月 30 日那份不及预期的指引让股价单日跌掉近 29%，创下 1974 年以来最差单日表现；到 11 月 2 日收盘，这只股票比 9 月底还不到一半。从 10 月 6 日起，芯片与存储板块合计蒸发约 3.7 万亿美元（HN 帖标题用的口径是 3.5 万亿），其中单个交易日就有超过 4000 亿美元市值蒸发。同一天 Micron、Sandisk、希捷和西部数据跌 6% 到 8%，Marvell 因为一笔 115 亿美元的 Lumentum 收购案跌得更多，而 Nvidia 自 10 月 6 日累计下跌约 16%，明显比 Intel 抗跌。

## 讨论焦点

### 一、170 亿美元是本事，还是撞上了 AI

最先冲上来的是一句刻薄话：

> "That says more about Intel's shambolic efforts than it does about AMD's road to damascus moment." — mickeyp [c:50368310]

> （这更能说明 Intel 自己折腾得有多狼狈，而不是 AMD 突然开了窍。）

有人特意去查了 "road to damascus moment"（大马士革时刻）的本意，发现原本是褒义，但放在这里，反讽的成分更重。

紧接着有人补上了更冷的一句：

> "Intel have gone through 3 leadership teams in 10ish years" — sofixa [c:50369859]

> （Intel 十来年间换了三任领导团队。）

温和派的说法则是：

> "Having strong competition between the CPU vendors is always a good thing. AMD has made mistakes, but it's hard to argue they don't deserve to outsell Intel for a change." — davoneus [c:50368127]

> （两家 CPU 厂商之间有强竞争永远是好事。AMD 犯过错，但要它第一次超过 Intel，很难说它不配。）

最清醒的一条把这份财报的成色说穿了：

> "The truth is this is more of the same tech inflationary pressure driven by AI. AMD is winning for showing up." — neuroelectron [c:50368639]

> （真相是：这不过是 AI 驱动的又一轮技术性涨价。AMD 赢在它出现了。）

这三种解读指向同一组数字：数据中心 85.5 亿（同比 +97%），客户端与游戏 37.22 亿（同比 -8%）。AMD 是在一条腿变粗、另一条腿变细的情况下把总额抬上去的。

而全场最容易被忽略的要求，来自一条不太起眼的回复：

> "Hopefully they don't completely swap roles completely, with Intel being incapable of competing and AMD stagnating without competition. I'd rather they both be competitive." — dlcarrier [c:50368337]

> （希望他们别彻底对调角色——Intel 完全没法打，AMD 因为没有竞争而停滞。我宁愿两家都还有战斗力。）

没人希望 AMD 变成下一个 Intel，这句话在评论区里没人反对。

### 二、64% 的营收挂在 AI 上，护城河叫 CUDA

AMD 自己在财报里点名了增长来源：

> "AMD specifically calls out high sales of Instinct products as leading the sales growth." — dlcarrier [c:50368455]

> （AMD 特别提到 Instinct 产品的高销量是这次增长的主要来源。）

有人在下面接了一句，纠正了普遍印象：

> "Instinct is basically the only real alternative to Nvidia in the market." — kcb [c:50369023]

> （在市场上，Instinct 基本是 Nvidia 唯一的真正替代品。）

但硬件能对标不等于生态能替换。评论里把墙说破的是这句：

> "The problem they have and they've always had is that everyone uses CUDA." — sofixa [c:50369851]

> （他们的问题，一直以来的问题，就是所有人都在用 CUDA。）

同一条评论后半段给了一个更实际的换算：

> "Using higher level tooling (vLLM, llama.cpp) I have DGX Spark comparable performance for 1/3 the price" — sofixa [c:50369851]

> （用上层的工具链（vLLM、llama.cpp），我能用三分之一的价格拿到和 DGX Spark 可比的性能。）

这就解释了财报里那份客户名单为什么重要：Anthropic、Meta、微软、OpenAI 和甲骨文云已经在第一代 Helios 上跑工作负载，这是硬件侧的证明；而 CUDA 生态是软件侧那笔更贵的资产。AMD 的数据中心营收从 43.4 亿涨到 85.5 亿，用的是多年攒下的 CPU 口碑和机架级系统设计，不是一夜之间换来的生态。

### 三、Optane：技术没错，时间错了

这是全场唯一一个"如果当初没死，AMD 也追不上"的技术分支。amluto 的判断最狠：

> "I can't think of any company that is as good as Intel at having a technology that's ready or almost ready for at or before the time that the market is ready for it and then completely failing to sell the product into the newly developed market." — amluto [c:50370826]

> （我想不出第二家公司，能像 Intel 一样，在市场快要需要某项技术时把技术备好，然后彻底没能把它卖进这个新长出来的市场。）

支持他的是一批用过 Optane 的人。sethhochberg 讲的是它真正的长处：

> "Having a very low latency, durable write destination is a superpower for lots of database architectures" — sethhochberg [c:50369329]

> （一个延迟极低又耐久的写入终点，对很多数据库架构来说是超能力。）

反驳的则更实际，mort96 说的不是技术不行，而是这东西没人真需要：

> "I don't want persistent RAM, I like the ability to reboot to solve problems" — mort96 [c:50369137]

> （我并不想要持久内存，我反而喜欢能重启解决问题这件事。）

amluto 补充的那层更关键：按每比特成本算，Optane 比 DRAM 便宜，如果 Intel 当时肯把它改造成足够快的权重流式读取设备，或者能扛住 KV cache 写入的读写设备，正好能赶上现在这个市场。

thread 2 里有人把这笔旧账一起算了进来：

> "I'm still salty at them for fumbling Optane, Gaudi, Altera and the Xeon Phi. the company seems like it's full of talented engineers working under terrible leadership." — sterlind [c:50346912] [thread 2]

> （我至今仍对他们在 Optane、Gaudi、Altera 和 Xeon Phi 上的失手耿耿于怀。这家公司好像人才很多，管理层却糟得不行。）

### 四、PC 与游戏这一侧在流血

游戏业务的塌陷，评论区的解释不是 AMD 打不过 Nvidia，而是整个市场被 AI 挤了：

> "Gaming decline is not a good thing, but part of it is overpriced PC components due to AI craze. No one is in a rush to make new PCs for such prices." — shmerl [c:50368408]

> （游戏市场萎缩不是好事，但部分原因是 AI 热潮把 PC 部件价格推上了天。这种价格下没人急着换新电脑。）

AMD 这边的路线反而被夸了一句务实：

> "AMD is reaping the reward of pragmatism, their best gaming CPU skus often have 8 full cores with a large cache for desktops plugged into a wall outlet." — Covzire [c:50368032]

> （AMD 收获的是务实路线的好处：他们最好的游戏 CPU 经常是 8 个完整核心加大容量缓存，为插电的桌面准备的。）

内存涨价的后果还顺带推迟了双方的下一代产品：

> "The memory crisis has delayed both Intel's and AMD's consumer CPU launches, i.e. Nova Lake for Intel and Zen 6 for AMD, to next year" — adrian_b [c:50369347]

> （内存危机把 Intel 和 AMD 的消费级 CPU 发布都推迟到了明年——Intel 是 Nova Lake，AMD 是 Zen 6。）

赢得盆满钵满的那一方也不是没有自己的投诉：

> "I have reservations about AMD due to repeatedly poor Linux support." — deepsquirrelnet [c:50372106]

> （我对 AMD 有保留，因为它的 Linux 支持一再拉胯。）

### 五、thread 2：Intel 腰斩，Nvidia 只跌 16%

关联帖的问题意识和主帖正好相反：不是 AMD 赢了多少，而是 Intel 为什么塌得这么快。最先被提出来的是 Nvidia 的对比：

> "The big question I have, why isn't Nvidia's stock falling quickly ?" — jmclnx [c:50346484] [thread 2]

> （我最大的疑问是：Nvidia 的股价为什么没有快速跌下来？）

> "I wonder if something else is happening to Intel" — jmclnx [c:50346484] [thread 2]

> （我怀疑 Intel 身上还发生了别的什么事。）

回答他的是这条关于护城河的解释：

> "And yet Intel is the one taking a dump here, because it has no moat. People use Wintel because people use Wintel, the same way people bought Gros Michel bananas because people bought Gros Michel bananas. When they went away, people bought something else." — stonogo [c:50347443] [thread 2]

> （可就是 Intel 在这里挨重击，因为它没有护城河。人们用 Wintel 只因为人们用 Wintel，就像当年人们买大迈克香蕉只因为人们买大迈克香蕉；等它们下架，人们就换了别的。）

起点被归到 Apple 换芯那一年：

> "The genesis of this is when Apple moved from Intel to their own chips." — small_model [c:50346832] [thread 2]

> （这一切的起点是 Apple 离开 Intel 换成自己的芯片。）

但更长的那段时间线要算在 AI 之前。frognumber 写了两段：

> "Pre-AI-boom, Intel was a failing chipmaker." — frognumber [c:50348654] [thread 2]

> （AI 热潮之前，Intel 就是一家正在失败的芯片公司。）

> "NVidia, in contrast, looks a lot more like the Amazon of the dot-com bust." — frognumber [c:50348654] [thread 2]

> （相比之下，Nvidia 更像互联网泡沫里的亚马逊。）

也就是说，Intel 这轮下跌不是从 AI 开始的，是 AI 把它本就存在的问题放大到了能被看见的量级。

### 六、真相是两家都卖光了

thread 1 里最硬的一段分析来自 adrian_b，他把 AMD 和 Intel 的财报放进同一张表里：

> "AMD has sold all the server CPUs that it could make, within its allocations at TSMC." — adrian_b [c:50369108]

> （在 TSMC 给它的配额范围内，AMD 能造的服务器 CPU 全部卖光了。）

> "Everybody who did not succeed to buy EPYCs has bought Intel Granite Rapids Xeons, because they are not made at TSMC, but in Intel's fabs, so they did not compete with other TSMC customers for allocations." — adrian_b [c:50369108]

> （没抢到 EPYC 的人全都去买 Intel 的 Granite Rapids Xeon，因为这些芯片不是在 TSMC 做的，而是在 Intel 自家工厂做的，所以不跟其他 TSMC 客户抢配额。）

同一个人在 thread 2 里把 Intel 那一侧补齐了：

> "Their sales of CPUs for personal computers dropped because the huge prices of memories discouraged everybody to make upgrades." — adrian_b [c:50350892] [thread 2]

> （他们 PC 处理器销量下滑，是因为内存价格高得让所有人都不愿意升级。）

> "So their earnings in personal computers dropped, but their earnings in server CPUs have risen like never before" — adrian_b [c:50350892] [thread 2]

> （所以 PC 部分的营收下降了，但服务器 CPU 部分的营收涨得前所未有。）

两场讨论在这里接上了：AMD 的服务器 CPU 卖光是因为 TSMC 配额，Intel 的 Xeon 也卖光是因为它不抢 TSMC 配额。同一场缺货里，两家都拿到了"史上第一次"的数字，只是原因一个是被 AI 拉动，一个是 AI 抢走内存和产能之后剩下的部分。

最后一段讨论把 Intel 当成了战略资产来看：

> "Intel is incredibly important for American sovereignty and that's why they are semi-nationalized. They are a Boeing now." — cco [c:50347139] [thread 2]

> （Intel 对美国主权极其重要，所以它被半国有化了。它现在就是一家波音。）

> "Intel, like Boeing cannot fail. If you believe they can, you better start searching for a bunker." — whatever1 [c:50346984] [thread 2]

> （Intel 和波音一样，不能倒。如果你相信它会倒，那你最好开始找防空洞了。）

最冷的一条来自一位自称在 Intel 做到高级 principal 的工程师：

> "There was a decade of brain drain and we just could not overcome the technical challenges." — poxy22 [c:50347837] [thread 2]

> （有十年的人才流失，我们就是跨不过那些技术难关。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| AMD 该赢 | davoneus | 强竞争对两家都好，第一次超过 Intel 不算过分 |
| 反超只是踩上 AI | neuroelectron | AMD 赢在它出现了 |
| 更怕一家独大 | dlcarrier | 别让两家彻底对调角色 |
| 增长来自 Instinct | dlcarrier | AMD 自己点名 Instinct 是增长主因 |
| Instinct 是唯一替代 | kcb | 市场上它基本是 Nvidia 唯一的真对手 |
| CUDA 才是护城河 | sofixa | 所有人都在用 CUDA，换不掉 |
| Optane 被误杀 | amluto | 技术对、市场来、却卖不进新市场 |
| 持久内存未必需要 | mort96 | 我不想持久内存，我想要能重启 |
| 游戏萎缩怪 AI | shmerl | 内存涨价，没人急着换新机器 |
| AMD 也有软肋 | deepsquirrelnet | Linux 支持一再拉胯 |
| Intel 没有护城河 | stonogo | 人们用 Wintel 只因为人们用 Wintel |
| Intel 是战略资产 | cco | 半国有化，因为它对美国主权重要 |
| 缺货才是主因 | adrian_b | TSMC 配额决定两家各自能卖多少 |
| 崩盘早于 AI | frognumber | AI 之前 Intel 就是家失败的公司 |
| 是人才问题不是管理 | poxy22 | 十年人才流失，技术难关跨不过 |

## 总体情绪

表层是庆祝和玩笑：AMD 第一次站在 Intel 头上，评论区顺手补上 Intel 十年三任 CEO 这条旧账。中层是对数字的警惕——第四季度 170 亿美元的指引背后，数据中心已经占到总营收的 64%，而这部分增长里写着 Helios、MI455X、Anthropic 和 OpenAI，也写着一个叫 CUDA 的护城河；同一个季度里，游戏业务从 12.98 亿掉到 7.73 亿，Lisa Su 自己承认 2027 年 PC 出货量要两位数下滑。

最底下那层其实是同一个情绪的两种说法：AMD 的增长是 AI 的租金，Intel 的下跌是 AI 之后剩下的部分。两家都没能证明自己在 AI 退潮后站得住，而 thread 2 里最清醒的那条不是抱怨管理层，是抱怨十年的人才流失和跨不过的技术难关。

AMD 用 170 亿美元的季度指引第一次站上 Intel 的头顶，而这张门票是 AI 借的；Intel 用三任 CEO 和一个腰斩的股价，为它垫了首付。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AMD expects to outsell Intel in Q4 for the first time in history（HN 主帖，459 分，168 条评论） | https://news.ycombinator.com/item?id=50367125 |
| 2 | Intel stock collapse worsens as $3.5T chip rout spreads（HN 关联帖，234 分，224 条评论） | https://news.ycombinator.com/item?id=50346153 |
| 3 | 原文：AMD expects to outsell Intel in Q4 for the first time in history — $17B guidance would exceed Intel's projections（Tom's Hardware） | https://www.tomshardware.com/pc-components/cpus/amd-expects-to-outsell-intel-in-q4-for-the-first-time-in-history-usd17b-guidance-would-exceed-intels-projections |
| 4 | 原文：The Intel stock collapse is getting worse — and the $3.7 trillion chip rout is spreading（Yahoo Finance） | https://finance.yahoo.com/markets/article/the-intel-stock-collapse-is-getting-worse--and-the-37-trillion-chip-rout-is-spreading-212154947.html |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中财报数据（第三季度营收 133.77 亿美元、毛利率 54%、净利润 24.3 亿、数据中心 85.5 亿、客户端与游戏 37.22 亿、嵌入式 11.1 亿、第四季度指引约 170 亿，以及 Intel 的 150 至 160 亿）来自 Tom's Hardware 的 AMD 财报报道；股价与板块跌幅数据（10 月 30 日单日约 29%、自 10 月 6 日起约 3.7 万亿美元、单日超 4000 亿美元市值蒸发）来自 Yahoo Finance 报道，均为第三方口径，未做独立复核，请以 AMD 与 Intel 官方财报及公告为准。本地归档抓到的 Tom's Hardware 页面正文大半是该站页尾论坛评论，财报数据依据原网页完整正文补齐。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
