---
layout: post
title: >-
  把 3090 上被砍半的 FP32 发射率改回来：一个内核模块引发的跑分、功耗与账单之争 — HN 讨论摘要
date: 2026-11-10
hn_id: 50219700
categories: [articles]
excerpt: >-
  Zagitta 的 gpu-unlock 用一个 Linux 内核模块改写 GA10x 的速度选择器，把被限制一半发射率的
  FP/BF16 FMA 指令恢复到专业卡水平；评论区对完账的结论是：跑分写着 25%–80%，落到真实负载
  上可能只剩个位数，功耗账单要另算。
tagline: >-
  跑分写着 25%–80%，到手 7%–8%。
---

> 来源：HN 讨论主帖 [GPU-unlock: FP/BF16 instruction issue rate on Nvidia 3000's cards](https://news.ycombinator.com/item?id=50219700)（353 分，85 条评论），原文是 Zagitta 的 GitHub 仓库 gpu-unlock；主帖由 fragebogen 提交，项目作者 Zagitta 本人在评论区逐条答疑。本篇为 single post 模式。归档快照 2026-11-09 11:01 UTC，入库评论 85 条。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

装在不少实验室里的消费级显卡，有一半算力被锁在门外。Nvidia 在 GA102、GA103、GA104、GA106 这几代消费卡上，把 FP/BF16 的 FMA 指令发射频率砍到一半：同一串指令，专业卡和数据中心卡跑满速率，消费卡只能半速执行。GitHub 用户 Zagitta 做的 gpu-unlock，就是把这道限制解开。

项目本体是一个 Linux 内核模块，既不是 UEFI 应用，也不是打了补丁的 nvidia 驱动。它把 CMP unlocker 的 V67/PLM 技巧和 UEFI 方案的前驱驱动时序合到一起：写入速度选择器（SS0 取 0x88888888，即完整 BF16 速率；4-bit SS1 取 0x8 IMLA4），执行一次 FLR，然后才让未经修改的 nvidia 驱动绑定显卡。这样打包的好处很实际——nvidia 每次发新驱动，使用者不必重新 patch 一次驱动。漏洞本身也不是他的：固件本来就是完整加密的，但 Nvidia 一直在公开发布加密的 debug 镜像，其中一部分能用公开测试密钥解开，而 debug 固件与量产固件足够接近，足以拿来构造漏洞；这一次是写栈的 DMA 缓冲区溢出，可以用 ROP 接管控制流，全程不执行任何未签名代码。

模块被塞进 initramfs，在 nvidia 之前加载（mkinitcpio、initramfs-tools、dracut 各有一份 drop-in），并且默认不动——内核命令行里不加 `gpu_unlock.targets=all` 就什么也不会发生。支持多卡同时解锁（README 提到最多四卡）、显示卡，以及 vfio-pci 直通的卡。README 给的基准是 3090 Ti 在 450W 下跑 dense 8192³ GEMM、FP32 累加、五次取中位数；用户报告部分列得更多：dense GEMM 提升，LLM prefill +14%~36%，扩散模型和 FlashAttention 受益，LLM decode 受内存带宽限制基本不变、INT8 也不变，对比过输出的报告说前后 bit-identical。

转折出现在功耗上。README 自己写着功耗上限影响很大，最低的那个 +25% 来自被限制在 225W 的卡。作者的解释是，解锁只是把卡在频率曲线上往下挪，好让瓦数待在曲线以内，于是得到一张“稍热一点的卡，换一点性能”。评论区实测者的数字散得很开：有人在 8 卡机器上拿到 30% 的 wall-clock 缩短（450W 还没敢开满），有人在 3060 上跑 nanochat 训练快了 6%（功耗被限在 170W），也有人说真实收益只有 7%~8%。

生态立刻跟上：Ada 版本的 fork、Windows 版、专门放开消费卡 P2P 的内核模块补丁、解除 NVENC 同时编码会话数限制的补丁，甚至有把同类思路搬到 Turing 2080 Ti 上的项目。未来则没那么乐观——作者说 Hopper 和 Blackwell 是另一套启动架构、多了几层安全措施，50 系不用等；也有人提醒下一个版本大概会带上签名固件，把这些配置重新钉死。

## 讨论焦点

### 一、被砍掉的到底是哪一半

最先跳出来的是标题本身。有人当场说这个标题写错了，解锁的是 FP32，不是 16 bit 运算；而且就他这一周翻过的所有报告看，除了 3090 和 3090 Ti，别的 3xxx 卡根本没出现过实例。

> "Uh, no. This headline is wrong. It&#x27;s FP32 unlocked from being halved, not 16 bit ops. And to be clear, over the last week I&#x27;ve looked many places and I&#x27;ve not seen <i>any</i> reports of this unlock being applied to any 3xxx card except the 3090&#x2F;3090ti series. Even if it might apply more generally in <i>theory</i>." — superkuh [c:50221729]
> （译文：不，这个标题是错的。它解锁的是被砍成一半的 FP32，不是 16 bit 运算。而且说清楚：这一周我翻了很多地方，除了 3090 和 3090 Ti，没见过任何把这个解锁用在别的 3xxx 卡上的报告，哪怕理论上它可能更通用。）

作者本人的说法指向另一边：被砍的是发射率，不在 16 bit 运算本身。他还补了一句，3000 系绝大多数卡跑的是同一个有漏洞的 GA102 booter，原则上都能解锁——而 superkuh 说的「除了 3090 系没见过别的实例」是另一回事：能不能，和有没有人试过并贴出报告，是两件事。

> "It&#x27;s quite nuanced. In a nutshell the unlock just flips the 2 bits that halves how often the core can issue the specific instructions Nvidia locks to full rate on the professional and datacenter cards." — Zagitta [c:50222247]
> （译文：这事有点微妙。简单说，这个解锁就是翻两个 bit——Nvidia 把这几条指令在专业卡和数据中心卡上锁成全速率，在消费卡上砍成一半发射。）

两种说法其实在说同一件事的两端：被砍的是“多快能吐出这类指令”，而多吐出来的每一条乘加指令，落到张量核心上就是 FP32 的算力。至于为什么消费卡要砍，作者在另一条里说得很直白：

> "Hey this is my work, although the exploits etc aren&#x27;t my ideas by any means.
> This is just a way to wrap the whole thing up in a much less annoying package than having to patch the nvidia driver." — Zagitta [c:50222102]
> （译文：这是我的工作，不过漏洞利用这些点子不是我原创的。我只是把整套流程打包成一个比反复 patch nvidia 驱动省事得多的形式。）

### 二、功耗才是隐藏的那张账单

评论区最先提出的不是“能不能用”，而是“用了会怎样”。一位手握七张 3090 的读者直接列了三条附加条件：

> "- you will need to run your card hotter than you might be comfortable with" — jacquesm [c:50221626]
> （译文：你的卡得跑到比你舒服的温度更高。）

> "- the real pay-off (on some cards, apparently, see downthread) requires increasing the maximum power to 450W" — jacquesm [c:50221626]
> （译文：真正的收益（在某些卡上，看楼下）需要把功耗上限提到 450W。）

> "- This is well above what the stock cooler was designed for so a bit more cooling would help" — jacquesm [c:50221626]
> （译文：这远高于原厂散热器的设计范围，所以最好加点额外的散热。）

作者的解释是一段频率曲线：解锁不改变卡要做多少功，只是把卡挪到曲线的更低处去把瓦数按住，于是换来的必然是一张更热的卡。

> "Obviously doing more compute requires more power but what it does is shift the card down on the frequency curve to keep the wattage in check.
> So you&#x27;re right that at stock power limits it hits a cap where the full issuing rate isn&#x27;t reached but it depends heavily on the exact workload how much juice is left." — Zagitta [c:50222247]
> （译文：干更多的算力当然要更多功耗，但它的作用是把卡沿频率曲线往下挪，好让瓦数待在曲线内。所以你说得对：默认功耗上限下它会撞到一个盖子，达不到满发射率，不过还剩多少余量，很大程度上取决于具体负载。）

到什么瓦数算划算，则完全是各家经验值。有人把 450W 当成不敢久跑的线：

> "If you increase the power limit on the card you will be able to get much more mileage out of this modification. At 450W the difference is much, much larger but that is not something I&#x27;m comfortable with doing for longer runs." — jacquesm [c:50221883]
> （译文：把卡的功耗上限提上去，这个改动能榨出多得多的价值。450W 下差别大得多，但那不是我愿意长时间跑的设置。）

另一位的答案更保守，甜点是 275W：

> "275W is the sweet spot on all my 3090s (not 3090 TIs)." — beacon294 [c:50368688]
> （译文：275W 是我所有 3090（不含 3090 Ti）的甜点。）

> "They are running completely fine at 250W with 13% decrease in compute output. Given the decrease of -25W... that&#x27;s about a 3% net loss for exaFLOPs&#x2F;kWh." — beacon294 [c:50368688]
> （译文：它们跑在 250W 完全没问题，计算输出下降 13%。算上少掉的 25W……换算成每千瓦时的 exaFLOPs，大约是 3% 的净亏。）

这一句把讨论从“快多少”拉到了“每度电换多少算力”，也解释了为什么作者在 README 里坚持写明功耗上限影响很大。

### 三、25% 到 80% 的成色

官方区间和用户实测之间隔着一条沟。跑分最高的说法是 25% 到 80%，但同一条帖子里也有人直接给出折扣：

> "The real gains are far less than the advertised. 
> Tests ton TFTOPS show 25% gains at 200Watt cap. While mostly prefil benefit from that less decoding which make the real gains 7-8%." — blagui [c:50224176]
> （译文：真实收益远低于宣传的数字。TFLOPS 测试在 200W 功耗上限下显示 25% 的提升，而主要受益的是 prefill、不是 decode，落到实际就是 7%–8%。）

> "25%-80%.<p>Certain (mostly AI) workloads. Depends on how hot you&#x27;re comfortable running your card. The real-world improvement is considerably less due to other things being bottlenecks." — Sharlin [c:50226671]
> （译文：25%–80%。特定的（主要是 AI 的）负载。取决于你愿意让卡跑多热。真实世界里的提升要小得多，因为还有别的东西是瓶颈。）

争议的另一半不是技术，而是动机。为什么一款供应紧张的卡，还要锁着一半算力不放？一位读者的判断是，市场结构变了，锁不再有商业价值：

> "Honestly if Nvidia is going to be short on cards for years there is no reason to keep this locked. People are going to buy what they can get and this in no way is going to influence sales at this point by making it official." — pixl97 [c:50224142]
> （译文：说真的，如果 Nvidia 未来几年都缺卡，就没道理继续锁着。人们能买到什么就买什么，官方放开这件事到这一步已经不可能影响销量了。）

把这条接下去的是一句更冷的话：

> "That&#x27;s just modern corporate capitalism.<p>Manufacturing economics favour making everything the same for scale, while sale economics favour market segmentation." — Havoc [c:50235782]
> （译文：这就是现代公司资本主义。制造端的经济性要求为了规模把东西做成一样的，销售端的经济性则要求做市场分层。）

### 四、谁吃得到红利：prefill 与 decode 的分水岭

这个解锁不是均匀加速所有活儿。评论区把它拆得很细：吃算力的活儿受益，吃带宽的活儿基本不动。

> "Training is compute bound.<p>If its memory bandwidth bound you need to raise your batch sizes to leverage more parallelism." — kingstnap [c:50222034]
> （译文：训练是算力瓶颈。如果它受内存带宽限制，你需要加大 batch 才能用上更多并行度。）

> "It&#x27;s also useful for prefill in inference, VLLM sees up to 30% boost depending on the exact kernels and prefill size" — Zagitta [c:50222165]
> （译文：它在推理的 prefill 阶段也很有用，VLLM 那边视 kernel 和 prefill 大小，最多能到 30% 的提升。）

真实落地的数字要小得多。一块 3060 的实测是这样的：

> "It worked for me, and I&#x27;m getting about 6% faster training on nanochat with my 3060 card. Thanks for this!" — chromaton [c:50224546]
> （译文：它在我这儿管用，我的 3060 跑 nanochat 训练快了大约 6%。多谢！）

> "Right now, I&#x27;m clearly power limited at 170 watts and I have no desire to brick my card or set it on fire." — chromaton [c:50224546]
> （译文：目前我很明显是被 170 瓦的功耗卡住了，我可不想把卡搞砖或者点着。）

同一个人还交代了这个项目有多难装：仓库是按 6.x 内核写的，他是 5.15，是 Claude Code 帮他跨过去的。

> "However, it required a few extra steps, as the repo is set up for Linux kernel 6.x and I&#x27;m on 5.15. Claude Code was able to get me past the hurdles, including code modifications and startup scripts." — chromaton [c:50224546]
> （译文：不过得多折腾几步，因为仓库是按 6.x 内核写的，我用的是 5.15。多亏 Claude Code 帮我把这些坎都过了，包括改代码和写启动脚本。）

### 五、封堵的时间表，和 48G 魔改 4090 的坑

解锁能活多久，是评论区另一条主线。有人对 Nvidia 的下一步给出了判断：

> "The next version is sure to have signed firmware which sets these configurations to prevent this sort of thing." — londons_explore [c:50223892]
> （译文：下一个版本肯定会带签名固件，把这些配置重新设定好，防止这类事情发生。）

作者则把 50 系排除在外——不是不想做，是启动架构换了：

> "I wouldn&#x27;t hold my breath for 50 series, hopper &amp; blackwell has a different boot architecture with more security layers" — Zagitta [c:50225140]
> （译文：50 系就别指望了，Hopper 和 Blackwell 是另一套启动架构，安全层也更多。）

至于 5090，作者的判断是消费版和魔改版完全是两笔生意：

> "I suspect that modding a 5090 in such a way that you can sell it is a lot harder than doing the same with a 4090." — jacquesm [c:50223149]
> （译文：我怀疑把 5090 魔改到能拿出来卖，比对 4090 做同样的事要难得多。）

同一条里还藏着这个帖子里最有价值的一段实战警告：48G 魔改 4090 的 BAR1 只有 32G，p2p 映射一段显存到另一段卡上，一旦越过这段空间的上界就会崩，而且崩之前毫无征兆。

> "For instance, you would never know that these cards are modded until you start using p2p and then suddenly it all falls apart." — jacquesm [c:50223149]
> （译文：比如说，在开始用 p2p 之前你根本不会知道这些卡被魔改过，然后事情突然就全崩了。）

### 六、魔改生态，以及一个关于 AI 的玩笑

解锁之所以受欢迎，还因为它选了一条比“改驱动”更省事的路。有人专门为这种打包方式道谢：

> "Super well done, I wished all mods took your approach. Patched drivers are a nuisance, especially if you have more than one kind of card. Thank you." — jacquesm [c:50222191]
> （译文：做得非常好，我真希望所有魔改都走你这个路子。改驱动太烦人了，尤其是你手上有不止一种卡的时候。谢谢。）

而生态里已经挤满了兄弟项目：Ada 版本的 fork、放开的消费卡 P2P 模块、解除 NVENC 同时编码会话数限制的补丁、Turing 2080 Ti 的同类尝试。消费卡之间的 P2P 带宽限制是另一个被拆掉的东西。

> "A semi related: a patch for those with multiple cards. You can unlock around 20% increased card to card speed on consumer GPUs using this library:" — RachelF [c:50223788]
> （译文：顺带一提，有个给多卡机器用的补丁。用这个库可以在消费卡上解锁大约 20% 的卡间速度提升：）

至于风险，普通用户的顾虑很朴素——贵重部件动手动脚总是让人心里没底。

> "I know it&#x27;s probably not that difficult, but I always feel anxious doing things like that with expensive components. The thought of being slightly misaligned and causing issues gives me pause. I guess now that it&#x27;s out of warranty, I have a bit less to lose." — bilalq [c:50237178]
> （译文：我知道这事大概不算难，但在贵重部件上做这种操作我总是心里发慌。一想到没对准、出了岔子就会犹豫。我猜既然已经过了保修期，我少损失一点。）

而有人当场把这份顾虑翻译成了具体工序：

> "You can trivially fix most of the VRM cooling issues btw by pulling the heat sink off, cleaning thoroughly and re applying fresh thermal pads. At this point almost all of 3090s are degraded in some way since those pads have a lifespan. The good news is it has nothing to do with the GPU itself." — oceanplexian [c:50237058]
> （译文：顺便说一句，大部分 3090 的 VRM 散热问题很容易解决——拆下散热片，彻底清理，重新涂上新的导热垫就行。到现在几乎所有 3090 都有某种程度的劣化，因为硅脂垫是有寿命的。好消息是这跟 GPU 本体没关系。）

最后一条评论把整件事变成了一个梗：

> "Did you use AI tools to do it? The README reads like Claudish. It&#x27;s amusing to see Nvidia-powered AI used to unlock their GPUs." — userbinator [c:50236430]
> （译文：你用了 AI 工具吗？这份 README 读起来一股 Claude 味。用 Nvidia 供能的 AI 去解锁 Nvidia 的显卡，挺逗的。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 标题写错了：解锁的是 FP32 发射率 | superkuh | 除了 3090/3090 Ti，没有别的实例报告 |
| 解锁原理就是翻两个 bit | Zagitta | 消费卡半速、专业卡全速的那两位 |
| 真实收益远低于宣传 | blagui | 25% 的 TFLOPS 提升，落到实际只有 7%–8% |
| 区间取决于你愿意多热 | Sharlin | 25%–80%，而且别的环节常常是瓶颈 |
| 功耗上限决定收益 | jacquesm | 完整收益要提到 450W 才拿得到 |
| 275W 才是甜点 | beacon294 | 250W 时计算输出降 13%，每 kWh 净亏约 3% |
| 训练是算力瓶颈 | kingstnap | 受带宽限制就加大 batch |
| prefill 是最大受益点 | Zagitta | VLLM 视 kernel 与 prefill 大小，最多 30% |
| 真实落地是 6% | chromaton | 3060 跑 nanochat 快 6%，还被 170W 限着 |
| 内核模块比补丁驱动省事 | jacquesm | 驱动一升级就得重打补丁，太烦 |
| Nvidia 没理由继续锁 | pixl97 | 缺卡的年代，官方放开也不影响销量 |
| 这就是现代公司资本主义 | Havoc | 制造要标准化，销售要分层 |
| 下个版本会带签名固件 | londons_explore | 这些配置会被重新钉死 |
| 50 系别等了 | Zagitta | Hopper/Blackwell 启动架构不同，安全层更多 |
| 48G 魔改 4090 有坑 | jacquesm | BAR1 只有 32G，p2p 越过边界就崩 |
| 硅脂垫可以自己换 | oceanplexian | 3090 的 VRM 劣化大多能自己修 |
| README 像 AI 写的 | userbinator | 用 Nvidia 的 AI 去解锁 Nvidia 的卡 |

## 总体情绪

一张显卡可以同时是“更快的卡”和“更贵的电费”，这个帖子的全部张力都在这里。项目作者给出的是技术事实：两个 bit、一次 FLR、一个 initramfs 里的模块；评论区给出的是账单：450W、275W、170W、250W，收益随温度递减，每一度电最后都要落到 exaFLOPs/kWh 上算一遍。

围观者的态度分成两种。一种把它当成生产力解放——8 卡机器上 wall-clock 缩短 30%、nanochat 训练快 6%、27B 模型吞吐 3.2 倍；另一种把它当成一次风险对赌——刷固件会不会变砖，硅脂垫要不要换，48G 魔改卡在 p2p 下会不会崩。中间还夹着一句玩笑：这份 README 读起来像 AI 写的，而真正把项目从 6.x 内核移植到 5.15 的，也正是读者的 Claude Code。

争议没有被解决。下一个版本会不会带签名固件，作者没把握；官方的区间到底对应哪一类负载，也没人替他回答。可以确定的是，一块被厂商按规格设计成半速的显卡，现在可以按自己的电费价格，把它跑成全速。

> "Thanks so much. 27b is a favourite model and last night my dev ran some benchmarks to achieve 133tks about 3.2x which changes the economics." — aunty_helen [c:50222269]
> （译文：太感谢了。27B 是我最喜欢的模型，昨晚我的开发跑了个基准，跑到 133 tks 左右，大约 3.2 倍，这改变了经济账。）

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | GPU-unlock: FP/BF16 instruction issue rate on Nvidia 3000's cards（HN 主帖） | <https://news.ycombinator.com/item?id=50219700> |
| 2 | 原文：Zagitta/gpu-unlock（GitHub） | <https://github.com/Zagitta/gpu-unlock> |
| 3 | gpu-unlock-ada（4090 / 4070 Ti Super 版本） | <https://github.com/JustAResearcher/gpu-unlock-ada> |
| 4 | open-gpu-kernel-modules（放开消费卡 P2P） | <https://github.com/aikitoria/open-gpu-kernel-modules> |
| 5 | Windows-GPU-UNLOCK（Windows 版） | <https://github.com/impacifist/Windows-GPU-UNLOCK> |
| 6 | nvidia-patch（解除 NVENC 同时编码会话数限制） | <https://github.com/keylase/nvidia-patch> |
| 7 | turing-unlock（Turing 世代的同类尝试） | <https://github.com/nlzy/turing-unlock> |
| 8 | flopper.io：RTX 3090 规格与数据 | <https://flopper.io/gpu/nvidia-geforce-rtx-3090-24gb> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 353 分、85 条评论，归档快照 2026-11-09 11:01 UTC，入库 85 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。文中关于解锁原理、功耗上限、GEMM 与 prefill 提升幅度、wall-clock 缩短比例、exaFLOPs/kWh 等数据，均来自原文与归档评论引述，本站未做独立复现。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
