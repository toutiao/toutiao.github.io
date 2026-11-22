---
layout: post
title: >-
  LookAtMyQuant：把 Inkling 2 Mini 压进 5.4GB 内存，和评论区对这四张成绩单的怀疑 — HN 讨论摘要
date: 2026-11-22
hn_id: 50591853
categories: [articles]
excerpt: >-
  个人开发者 ShinMegamiBoson 用自写的 trellis 码量化编译器，把 18.89GB 的 Inkling 2 Mini 权重压成 5.38GB，
  声称 12.76GB 版本与 BF16 原模型在 349 项评测上完全一致。评论区分三路：逐条复算 KL 数字的人、
  报自己机器 tok/s 的人，以及指出这批文件只跑在 Apple Silicon 自定义 Metal 内核上的人。
tagline: >-
  12 倍压缩是 Gemma 的成绩单，Inkling 那一栏的数字根本没放进仓库。
---

> 来源：HN 讨论主帖 [Inkling-2-Mini in 5.4 GB Memory](https://news.ycombinator.com/item?id=50591853)（342 分，91 条评论），归档时位列 HN 首页（/news）第 3 位，/best 第 26 位，页面指向 GitHub 仓库 ShinMegamiBoson/lookatmyquant。归档快照 2026-11-22 01:00 UTC，入库 91 条评论（未触及抓取上限）；Algolia 未返回评论分，分数字段均为 0，引文选择依据为内容本身与讨论价值。引文中的 HTML 实体按 HN 页面显示形式还原，文字与作者逐条与归档评论比对。

## 原文概要

LookAtMyQuant 是一个量化编译器，MIT 许可。它的逻辑很朴素：逐块测量「把模型的每一块压到目标格式后，输出会损失多少」，再在给定体积预算内给每一块挑一个码，让总损伤最小。仓库首页给出的第一个成绩单是 Gemma 4 E2B：同样文件大小下，它生成的 GGUF 的 KL 比 Q4_K_M 低 12 倍。

第二版 LookAtMyQuant 2 拿 Qwen3.5-4B 练手，压到 1.23GB、每权重 2.3 bit。文件在 540 道精确答案数学题里解出 330 道；Prism ML 的 Bonsai 2 Ternary 4B 在 1.20GB 下解出 328 道，原模型解出 359 道。它对原模型的 KL 是 0.45 nat，Bonsai 是 0.59。做法是后训练量化加 trellis 码，校准数据用模型自己的解题过程、数字 token 在 Hessian 里加权 10 倍，每行分到的 bit 数由 Fisher 信息决定，之后做 4000 步蒸馏、每层都从原始权重重量化一次。整个配方的 GPU 成本约 34 美元。

同一套配方换成 Qwen3.8-27B，得到 7.2GB、每权重 2.1 bit 的版本：540 道数学题解出 401 道，与原模型持平，而同体积的 Unsloth UD-IQ2_XXS 只解出 348 道；HumanEval 73.8% 对 67.1%，MMLU 78.8% 对 75.0%，GSM8K 94.5% 对 92.7%。旁边还配了一个 1.02GB 的 4-bit DSpine drafter，在 Apple Silicon 上把数学与代码的解码速度大约翻倍。

HN 这条主帖真正引爆的是 Inkling 2 Mini 这一支。这个 26.4B 物理参数、5.4B 激活的 3× 循环 MoE（L6–17 循环三遍，等于 48 次逻辑访问，128 个专家取 top-8），文本权重原本 18.89GB，被压成四个 Apple Silicon MLX 构建：5.38GB（1.65 bpp）、8.87GB（2.72 bpp）、11.18GB（3.43 bpp）、12.76GB（3.92 bpp）。手法是 4KB SRAM 的哈希块向量 trellis 码（ht2/ht3）、行 trellis 码（rtr1/rtr4）、尾巴 lm_head 桶上的 tr2 下限（head.7），再加上原生 NVFP4 直通——11.2GB 与 12.8GB 两个构建里，最敏感的 69/192 和 109/192 个专家桶保持 0.0 误差。

评测协议是固定的一套：max_new_tokens = 1,536，greedy，reasoning_effort 设为 none，对照同一个 BF16 teacher，跑 gsm8k test[:200]、164 道 HumanEval、4 项 Vision VQA（保留未改动的 637MB BF16 视觉塔）和 16 + 13 种语言的 TextMix 窗口。结果是：12.76GB 版本在 349 项汇总评测上与未改动的 BF16 teacher 打成 100.0% 平手（349/349），文本权重内存少 32.5%；11.18GB 与 8.87GB 保留 99.2–99.3% 的三任务均值（345/349 = 98.9% 汇总）；8.87GB 版本在 English/chat/code 上把 KL 压到 Unsloth 9.14GB UD-Q2_K_XL 的 2.34 倍以下（0.0208 对 0.0486），13 语言整体低 29.6%（0.0571 对 0.0811）；5.38GB 版本 GSM8K 88.0%、HumanEval 70.7%（105/164 = 64.0% strict），在同样的 384-token harness 下压过 7.76GB 的 UD-IQ1_S 和 9.14GB 的 UD-Q2_K_XL。四个构建都跑在 lamq / runtime_mlx 的统一单次启动 Metal 内核上，可选配 178.9MB 的 4-bit DSpark drafter。Apple M5 Max 上，12.8GB 版本 prefill 2,016 tok/s（T=512）、串行 60.5 tok/s、无损 draft 解码中位数 112.7 tok/s；5.4GB 版本 prefill 1,807 tok/s、串行 75.3 tok/s、draft 中位数 124.4 tok/s。

## 讨论焦点

### 一、一个原生 NVFP4 训练的模型，为什么还要再被量化

有人第一反应是逻辑问题：这个模型的权重本来就是 NVFP4 训练的，模型卡上写的是「约 20GB 的单一 checkpoint，混合 NVFP4 与 MXFP8 精度」，那再压一遍算哪门子优化。

> "What's the point in quantizing a QAT model? Just for social media karma?" — woadwarrior01 [c:50592509]
> （译文）量化一个 QAT 模型的意义在哪？就为了在社交媒体上刷存在感吗？

有人把 QAT 的机制讲清楚了，问题也就跟着变了形状：

> "QAT approximates quantization-errors in full-size fine-tuning, so that the model itself is insensitive to (or accommodating of, I'm not sure) them when quantized to the corresponding format." — gavmor [c:50592650]
> （译文）QAT 是在全尺寸微调阶段近似量化误差，让模型本身对误差不敏感（或者说能容纳它们，我不太确定措辞），前提是量化到与之对应的格式。

也就是说，QAT 的「抗量化」是绑定格式的：量化到别的格式，这些适应一个都不继承。讨论里另一条线则直接认为这个前提不成立：

> "QAT models are trained to quantize well? I don’t get the concern here." — asaddhamani [c:50592911]
> （译文）QAT 模型不是被训练来量化友好吗？我没明白这里的顾虑是什么。

> "Please read their blog post. This isn't a run of the mill QAT post trained model (like Gemma 4 QAT). It was natively trained in NVFP4, through and through." — woadwarrior01 [c:50593019]
> （译文）去读他们自己的博客。这不是那种流水线上的 QAT 后训练模型（比如 Gemma 4 的 QAT），它从头到尾都是原生 NVFP4 训练的。

把这个疑问落到工程上的，是评论区替作者复述的那条流程——据作者的说法，先回到 BF16，再量化/微调成更小、不同的格式：

> "I think they say they go back to BF16 and then requant/finetune smaller (and to a different format)." — svnt [c:50594181]
> （译文）我记得他们的说法是：回到 BF16，然后再量化/微调成更小的（也是不同格式的）版本。

### 二、格式不只是格式：ht2/ht3 目前只在 Apple Silicon 上存在

上面那条「换格式」的代价，落到能跑起来的地方比想象中大。发布出来的四个 Inkling 文件，全都是 Apple Silicon + MLX 专用。

> "MX/Apple Silicon only for the released Inkling files, yes. The ht2/ht3 codes are hashed block-vector trellis codes meant to fit 4 KB of SRAM, decoded by custom Metal kernels, and the drafter is MLX-only too - none of that runs in llama.cpp today." — Prospernwo [c:50592907]
> （译文）发布的 Inkling 文件确实只有 MX/Apple Silicon 版本。ht2/ht3 码是为了塞进 4KB SRAM 而设计的哈希块向量 trellis 码，靠自定义 Metal kernel 解码，drafter 也只支持 MLX——今天这些在 llama.cpp 里一个都跑不了。

> "The GGUF route is in the repo (gguf_compiler.py emits plans over llama.cpp's own tensor types and the docs say the result runs in llama.cpp as-is), so porting these plans is clearly intended, but right now a 4090 gets you the Qwen files to read about rather than run." — Prospernwo [c:50592907]
> （译文）GGUF 那条路仓库里是有的（gguf_compiler.py 直接按 llama.cpp 自己的张量类型生成计划，文档说结果可以原样在 llama.cpp 里跑），所以移植这些计划显然是有意为之；但现在一块 4090 上能拿到的，只有供阅读的 Qwen 文件，而不是能跑的。

这是整条讨论里最实在的一条约束：所谓「5.4GB 就能跑」有前提，而前提是 M 系列芯片加自研 Metal 内核。

### 三、KL 数字被逐条复算

质疑不是情绪性的，是有人真的拿自己的工具重跑了一遍。最长的一条质疑来自一位先用自己的本地模型跑过一遍、再回头核对 README 的评论者，他给的是同一体积下的直接对撞：

> "The results are complete nonsense and really don't back up any of the README claims. For Inkling-2-Mini; at 5.4 GB its KL is worse than Unsloth's UD-IQ1_S: 0.0895 vs 0.0808 on English/chat/code, and 0.287 vs 0.124 across 13 languages (e.g.: horrible)." — hugmynutus [c:50592929]
> （译文）这些结果完全是胡说，根本不支持 README 里的任何说法。就 Inkling-2-Mini 而言：5.4GB 下的 KL 比 Unsloth 的 UD-IQ1_S 还差——English/chat/code 上是 0.0895 对 0.0808，13 种语言上是 0.287 对 0.124（比如：很可怕）。

> "It then achieved better results by post-training the qaunt'd model on sample inputs (AFAIT)." — hugmynutus [c:50592929]
> （译文）然后它靠在一个样本输入上继续后训练那个量化后的模型，取得了更好的成绩（AFAIT）。

他的结论更直接：GSM8K 与 HumanEval 的结果落在噪声区间里，属于严重夸大——这一条他注明是引自另一位评论者。

其他评论者补的是方法论层面的漏洞——验证集和校准集的关系。

> "Validation dataset. Nobody shares or talks about their validation dataset v.s. their calibration data when doing this kind of quantization / publishing KLD numbers." — liuliu [c:50594479]
> （译文）验证集。做这类量化、公布 KLD 数字的时候，没有人会说、也没人会聊自己的验证集和校准集是什么关系。

> "yup, this. calibrating on wikitext and then validating on it is a shady move" — electroglyph [c:50594983]
> （译文）对，就是这个。在 WikiText 上校准、又在 WikiText 上验证，这是不干净的手法。

> "Could you elaborate on this? Intuitively how can the distribution over logits be similar and the results different?" — nojs [c:50594412]
> （译文）能展开说说吗？直觉上，logits 上的分布都长得这么像了，结果怎么会不同？

回答这个问题的评论者把问题从统计推到了能力：

> "KL divergence does not measure capability. It measures something closer to fact retrieval." — mapontosevenths [c:50594617]
> （译文）KL 散度不衡量能力，它衡量的东西更接近事实检索。

> "Worse, it's a bit of a cheater in that you've optimized it to match the output of the parent on the tested logits... So that's exactly what you get. Nothing else. You lose the long tail of knowledge AND capabilities." — mapontosevenths [c:50594617]
> （译文）更糟的是，这有点像作弊：你优化的是在被测到的 logits 上匹配母模型的输出……那你得到的就是仅此而已，别的东西没有。你丢掉的是知识的长尾，以及能力的长尾。

还有更朴素的实测：

> "Yep. Tried GLM-5.3 1 or 2bit (don't remember), it should be something like 80% as good according to the divergence chart, in reality it's dogshit." — cowlevel [c:50593582]
> （译文）对。我试过 GLM-5.3 的 1 或 2 bit（记不清是哪个），按那张散度图它应该有原版 80% 的水平，实际上是坨屎。

而表格本身也给出了质疑的理由：

> "+1: one of the analysis table has a column named “Text Size” in GBs which I have no idea what it means." — mrbonner [c:50593690]
> （译文）+1：其中一张分析表里有一列叫 “Text Size”，单位是 GB，我不知道它到底指什么。

仓库自己的 README 也承认了一件事：把网站数字拼起来的脚本是「一系列一次性的步骤」，没有公开；LookAtMyQuant 2 的稠密权重、逐题结果，以及写出网页数字的那个脚本，都不在仓库里。复现路径从一开始就是断的。

### 四、vibecoded repo 的免疫系统

本地模型社区对这类项目有一套现成的免疫反应，而且反应得相当熟练。最长的一条评论把话说得很不客气：

> "If you're new to quantized models: Don't get too excited about claims of fitting large models into tiny RAM footprints from random GitHub repos. There is always a tradeoff, and it's too easy to benchmaxx KL-divergence numbers and even single benchmark scores. Just because you can get something to run on a device doesn't mean it's going to be useful." — Aurornis [c:50593478]
> （译文）如果你刚接触量化模型：别因为某个随机 GitHub 仓库宣称能把大模型塞进很小的内存占用就激动。总有代价，而拿 KL 数字、甚至单跑分数字去刷最大值太容易了。能让它在某台设备上跑起来，不代表它有用。

> "The headline claim of this repo (12X better) doesn't even apply to Inkling-2-Mini" — Aurornis [c:50593478]
> （译文）这个仓库的标题数字（好 12 倍）压根不适用于 Inkling-2-Mini。

他的替代建议也很具体：回到主流量化——官方 GGML 发布版、Unsloth 的量化、bartowski 或 AesSedai 这类知名社区量化者，它们的体积-质量权衡是被反复验证过的。

> "The truth is that random GitHub repos with messy READMEs almost never hold a real secret that the mainstream quantizations have missed." — Aurornis [c:50593478]
> （译文）事实是，README 一团乱麻的随机 GitHub 仓库，几乎从来不会藏 mainstream 量化漏掉的什么秘诀。

> "The local LLM communities get spammed with 10 of these types of projects per day but I have yet to see a real breakthrough come from any of the vibecoded ones." — Aurornis [c:50593478]
> （译文）本地 LLM 社区每天被这类项目刷屏十个左右，但至今没有一个真正突破是出自这些 vibe coding 产物。

不过这位评论者也划了一条界：真正的硬活在别处——研究这个方向、有算力做大规模验证、或者去实现需要推理引擎支持的进阶技术（比如 trellis 量化）的人。

而当时的现场状态是这样的：

> "50 comments, 234 points and literally nobody has tried this model. This either smells like astroturfing or the quality of HN has gone to shit completely." — kroaton [c:50593754]
> （译文）50 条评论、234 分，却根本没人试过这个模型。要么这闻着像水军，要么就是 HN 的质量已经烂到底了。

### 五、真正的瓶颈在推理引擎，不在模型

速度是这条线上吵得最细的部分，而结论出奇一致：慢的是引擎，不是模型。

> "I really wanted to like this model but it is sooooo slow. Third of the speed of Qwen 27B on my R9700. I don’t know if it’s an artifact of looped transformer or unoptimized kernel." — syntaxing [c:50592987]
> （译文）我本来很想喜欢这个模型，但它太——太慢了。在我的 R9700 上只有 Qwen 27B 三分之一的速度。我不知道这是循环 transformer 的副作用，还是内核没优化。

> "Depends on your hardware, but this build of [ninfer][1] runs inkling-2-mini for me at 77 tok/s versus llama.cpp at 30 tok/s. So far it has been pretty good." — montroser [c:50593278]
> （译文）取决于你的硬件，但这个 [ninfer][1] 构建在我这儿跑 inkling-2-mini 是 77 tok/s，而 llama.cpp 只有 30 tok/s。目前感觉相当不错。

> "llama.cpp is one of the slowest these days" — nicce [c:50593045]
> （译文）llama.cpp 是这阵子最慢的之一。

跑在笔记本小卡上的结果同样被报出来：

> "I’m getting ~6.7 tok/s out of it on an a laptop RTX 4060 with 8GB VRAM — over twice the speed I can get out of qwen, and arguably fast enough to turn it loose on real work." — flatline [c:50593400]
> （译文）我在一张 8GB 显存的笔记本 RTX 4060 上跑到大约 6.7 tok/s——是我跑 qwen 的两倍多，而且大概已经够快到可以放出去干真活了。

AMD 侧的进度也有人盯着：

> "It takes a while for 3rd party AMD engines to catch up, but 3rd party engines like capy-flash & basalt already run inkling2 at more than 100tps (5k prefill on 5070ti, 16k prefill on 5090)." — veemjeem [c:50593845]
> （译文）第三方 AMD 引擎要花点时间才追得上，但像 capy-flash 和 basalt 这样的第三方引擎已经能把 inkling2 跑到 100 tps 以上（5070ti 上 5k prefill，5090 上 16k prefill）。

> "40+ TG and 1000+ PP on 8GB VRAM RTX2060 Super on an IQ3_XS model. The support and speed should be there in a couple of days." — merbanan [c:50594648]
> （译文）在 8GB 显存的 RTX2060 Super 上、IQ3_XS 模型的 40+ token/s 生成和 1000+ token/s prefill。支持到位、速度跟上，也就这两天的功夫。

把这些数字和 README 的官方值放在一起，能看出一个容易被忽略的事实：官方给的是 M5 Max 上 12.8GB 版本 60.5 tok/s 串行、5.4GB 版本 75.3 tok/s 串行——越小的构建单 token 越快，因为要读的权重更少，但 12.8GB 的 prefill 反而更快（2,016 对 1,807 tok/s）。同一台机器上换引擎能差出 2.5 倍，这个差距远大于模型本身的差距。

### 六、开源与前沿的差距，是时间差还是永久差

讨论的另一半其实和量化无关，是老话题：本地模型到底差前沿多远。

> "Our future hinges on the capability gap between frontier lab models and open source local models" — an0malous [c:50592561]
> （译文）我们的未来取决于前沿实验室模型与开源本地模型之间的能力差距。

> "What gap?" — singpolyma3 [c:50592844]
> （译文）什么差距？

> "The gap is so big you can't see it." — rs_rs_rs_rs_rs [c:50593024]
> （译文）差距大到你都看不见。

争论集中在「差多久」。给出乐观估计的人把差距换算成时间：

> "Yeah, this model is ~comparable to Opus 4.6. That was, not too long ago, a frontier model." — claude-ai [c:50593156]
> （译文）对，这个模型大致相当于 Opus 4.6。而那在不久前还是前沿模型。

> "Exactly. It seems to not really be a permanent gap but more a time gap. Locally you're about a year or so behind SOTA. Is that terrible? Not really, a year ago cloud model users were raving about what they had." — wolvoleo [c:50593225]
> （译文）正是这样。看起来这不像是永久差距，更像是时间差距。本地大约落后 SOTA 一年左右。这算糟吗？不算，一年前云端模型用户还在为他们手上的东西欢呼。

> "If that holds, I'll be able to do 99% of my work with local models around March 2027." — InsideOutSanta [c:50593355]
> （译文）如果这个判断成立，到 2027 年 3 月左右，我就能用本地模型完成 99% 的工作。

反方向的追问同样具体：

> "If there is no gap, then why aren't Cursor and all other coding harness defaulting to the open weight models?" — consumer451 [c:50594666]
> （译文）如果根本没有差距，那为什么 Cursor 和所有其他 coding harness 没有默认切到开放权重模型？

而少数派发言者对「这个模型有多好」本身就存疑：

> "It is enormously promising and it appears to be quite creative; perhaps looping gives it that." — dofm [c:50594724]
> （译文）它前景极大，看上去也相当有创造力；也许是循环给了它这个特性。

> "But I am wary of seeing what I want to see, when a ~30B dense model is, on average, going to plod through and do better on many tasks because of better basic knowledge." — dofm [c:50594724]
> （译文）但我警惕自己看到想看的东西——一个 30B 左右的稠密模型，平均而言会凭借更好的基础知识，在很多任务上稳稳地做得更好。

他的补充解释了为什么本地模型的体感会和榜单排名脱节：

> "A small model that responds coherently to facts fed to it (e.g. via tools) may punch way above a heavier model that gets by more on its sheer knowledge base." — wolttam [c:50594979]
> （译文）一个小模型，如果能对喂给它的事实（比如通过工具）做出连贯回应，表现可能远超一个更多靠自身知识储备吃饭的更重模型。

### 七、蒸馏循环：把上一代 SOTA 喂给下一代

「一年差距」这个判断成立与否，最后落在蒸馏上。

> "Would local models catch up if frontier models paused new training for a year?" — furyofantares [c:50593317]
> （译文）如果前沿模型暂停一年新训练，本地模型能追上来吗？

> "It might just be you can get these nice local models because of distillation from a much more powerful model." — furyofantares [c:50593317]
> （译文）也可能只是因为，你之所以能拿到这些不错的本地模型，靠的就是从更强大的模型蒸馏。

> "Adversarial distillation hasn’t been a major factor in the past year. If the SOTA stops moving, all the other labs catch up to them in 6 months to a year, and distillation into smaller models continues to close the gap between small/large models during that time" — swiftcoder [c:50593376]
> （译文）对抗式蒸馏在过去一年并不是主要因素。如果 SOTA 停下来，其他所有实验室会在半年到一年内追上来，而在这段时间里，向小模型的蒸馏会持续缩小小模型与大模型之间的差距。

最悲观的判断指向数据本身：

> "Every model is now distillation in a way. The US models are now hiring people do, well do their job and make traces of that available to them. This is a desperation move since:" — spwa4 [c:50594455]
> （译文）现在每个模型在某种意义上都是蒸馏出来的。美国的模型公司现在雇人干活，把人干活的轨迹拿给自己用。这是一步绝望的棋，因为：

他列的理由里，前两条直接指向数据：其一，实验室过去靠「偷」人类数据获得蒸馏优势，而花钱买人类数据蒸馏要贵得多；其二，LLM 对人类的反应、人类的反应又是 LLM 的产物，这样的数据不再是好数据——它让模型在某些方面变强，代价是在另一些方面变差，甚至可能是结构性问题。

真正被算进成本账的，是本地使用者的迁移速度：

> "In the last roughly five months, I went from using 100% US SOTA models to using 5% US SOTA models and doing the remaining 95% of the work with much cheaper Chinese models." — InsideOutSanta [c:50594486]
> （译文）过去大概五个月里，我从 100% 用美国 SOTA 模型，变成只用 5% 的美国 SOTA 模型，剩下的 95% 的活都交给便宜得多的中国模型来做。

至于本地模型和云端模型的关系，有人的用法听上去像是把两边拼起来：

> "Weirdly, I use lab models to make the local models useful. Nothing like getting Claude to spin up the system that will put it out of work." — zulux [c:50592957]
> （译文）奇怪的是，我用实验室模型来让本地模型变得有用。没有什么比让 Claude 把那个会把自己干掉的系统搭起来更带劲了。

> "To be fair, the models putting us out of work were trained on our own output as well." — dotancohen [c:50593231]
> （译文）公平地说，那些让我们失业的模型，也是拿我们自己的输出训出来的。

这句冷嘲在评论区被反向解读成另一种乐观：

> "the generational efficiency gain takes the form of going from giving Anthropic $200 a month to paying $5 more on my utility bill. Now that's progress ;)" — idle_zealot [c:50593838]
> （译文）这一代人的效率提升，形式就是从每月给 Anthropic 200 美元，变成每月多付 5 美元电费。这才叫进步；)

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 量化原生低精度模型意义有限 | woadwarrior01、gavmor | QAT 的抗量化只对对应格式有效，换格式就得重新来过 |
| 数字不可信，有人复算过 | hugmynutus | 5.4GB 的 KL 比 Unsloth UD-IQ1_S 还差，13 语言上差一倍多 |
| 验证集与校准集该公开 | liuliu、electroglyph | 没人说自己拿什么验证、校准集是什么关系 |
| KL 不等于能力 | mapontosevenths | KL 更像事实检索的度量，优化的只有被测 logits 上的匹配 |
| 随机仓库别碰 | Aurornis | 12 倍那个标题数字不适用于 Inkling，回到主流量化 |
| 慢是引擎的问题 | montroser、veemjeem、flatline | ninfer 77 tok/s 对 llama.cpp 30 tok/s，AMD 第三方引擎已过 100 tps |
| 差距是时间差不是永久差 | wolvoleo、InsideOutSanta | 本地落后 SOTA 约一年，2027 年春天就能干 99% 的活 |
| 差距可能根本不存在 | an0malous、rs_rs_rs_rs_rs | 差距大到你看不见 |
| 本地模型的体感来自后训练 | wolttam、dofm | 能连贯用上工具事实的小模型，可以打穿只靠知识储备的更重模型 |
| 数据来源正在自我消耗 | spwa4、furyofantares | 每个模型都在蒸馏，喂下一代的数据质量是结构性问题 |

## 总体情绪

这条讨论的情绪分层很清楚。质疑方法论的那一层火力很足，但质疑的对象始终是数字而不是项目本身——复算 KL 的人给出的是可对照的数值，指出验证集问题的人指出的是行业惯例，没人否认 trellis 码这个方向有价值，也没人否认这些文件确实能跑。真正被追问到底的是：12 倍那个标题数字属于 Gemma，而 Inkling 这一栏，仓库既没放逐题结果，也没放拼数字的脚本。

实机那一层则是完全相反的热闹。同一个模型，在 M5 Max 上是 60 tok/s，在笔记本 RTX 4060 上是 6.7 tok/s，换个推理引擎能差出 2.5 倍，而在 AMD 侧还得等 Radiance 这类引擎把 Inkling-2-Mini 的支持合进去。讨论里没有一条「这模型不行」的实测，全是「我的机器上跑不出来」——这恰好说明当时的瓶颈还卡在软件栈上，而软件栈这层从来不参与模型质量的争论。

最后一层是这场讨论真正跑偏、也真正跑远的地方：能力差距、蒸馏闭环、谁在替谁干活。开头那句「我们的未来取决于前沿模型和开源本地模型之间的差距」，三句话之内就被拆成了三个互不相让的版本——差距大到看不见、差距其实只是时间差、而你手上这些好用的本地模型可能只是从更强模型蒸馏来的产物。最有代表性的是那个把 Anthropic 的 200 美元换成 5 美元电费的账本：本地模型不再是要打败的对象，而是要接在云端模型后面的那一段管道。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Inkling-2-Mini in 5.4 GB Memory（HN 主帖） | <https://news.ycombinator.com/item?id=50591853> |
| 2 | LookAtMyQuant（GitHub 仓库） | <https://github.com/ShinMegamiBoson/lookatmyquant> |
| 3 | LookAtMyQuant 2 数据页（评论区提到） | <https://lookatmyquant.pages.dev> |
| 4 | Inkling 2 Mini 发布文章（Thinking Machines Lab，评论区引用） | <https://thinkingmachines.ai/news/inkling-2-mini/> |
| 5 | LookAtMyQuant 2 发布包 lm2-qwen35-4b-1.2gb（仓库 releases） | <https://github.com/ShinMegamiBoson/lookatmyquant/releases/tag/lm2-qwen35-4b-1.2gb> |
| 6 | ninfer（评论区实测 77 tok/s 的第三方引擎） | <https://github.com/iamwavecut/ninfer-all> |
| 7 | Radiance（AMD 侧第三方引擎，评论区提到待支持 Inkling-2-Mini） | <https://codeberg.org/StillDeadcode/radiance> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 342 分、91 条评论，归档快照 2026-11-22 01:00 UTC，入库 91 条，未触及抓取上限）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文抓取成功，但正文在 8000 字符处截断，截断点落在「Install and use the Apple Silicon runtime」一节中途；「原文概要」中关于 Inkling 2 Mini 的事实（四个构建的体积与 bpp、ht2/ht3 与 rtr1/rtr4 与 head.7 tr2 下限、69/192 与 109/192 原生 NVFP4 直通桶、349/349 汇总评测、0.0208 与 0.0486 的 KL 对比、5.38GB 的 GSM8K 88.0% 与 HumanEval 70.7%、M5 Max 上的 prefill 与串行及 draft 速度）均来自截断前的正文，其后的章节（SmolLM2-360M 复现流程、Modal 作业表、drafter 训练细节、仓库文件清单、「What this repository leaves out」一节）不在归档正文内。

关于仓库内容的补充说明：上述后半部分事实取自同一仓库的 README 原文（github.com/ShinMegamiBoson/lookatmyquant 的 raw README），与归档截断部分同源；其中「网站数字的拼装脚本是一次性步骤、未公开」「LookAtMyQuant 2 的稠密权重与逐题结果未公开」两点，是该仓库自己在 README 中声明的。

文中所有本地实测速度、显存与 KV cache 情况，均为评论者在各自硬件与推理框架上的个人结果，不同版本、量化格式与后端差异很大，不可直接横向比较；对仓库官方基准与代码的说法，本文只做转述，未独立验证。KL、GSM8K、HumanEval 等对比数字均引自仓库 README 或评论者转述，未经本文复算。

涉及模型能力对比与工作影响（替代就业、模型取代人类工作等）的引述为评论者个人观点，不代表事实认定；模型能力评测请以官方模型卡与研究论文为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
