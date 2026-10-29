---
layout: post
title: >-
  Mistral Large 4（Le Chonk）权重上线：输入 $0.70/M，开放权重还是“权重可获取” — HN 讨论摘要
date: 2026-10-30
hn_id: 50289418
categories: [articles]
excerpt: >-
  Mistral 把 1 万亿参数的多模态 MoE 权重放上 Hugging Face，开源权重里编码榜登顶、
  Terminal-Bench 4.0 涨 13 个百分点，输入价砍到 $0.70/M。
  评论区吵的却是另一件事：这份 modified MIT 到底算不算开放。
tagline: >-
  权重随便下，但要拿它做生意，得先跟 Mistral 单独签一份商业授权。
---

> ⚑ **地缘背景**：本文涉及美国国防采购对大模型供应商的限制、咨询公司对中国模型的说法，以及评论区里未经证实的指控。所引观点按原帖立场呈现，不代表本项目立场。⚠ Review recommended.

> 来源：HN 讨论帖，提交者 kuberwastaken。帖子：[Mistral Large 4 (Le Chonk) is now Open Weight](https://news.ycombinator.com/item?id=50289418)，949 分，268 条评论。

## 原文概要

10 月 29 日，Mistral 把 Mistral Large 4 的权重放了出来。社区给它的昵称是 Le Chonk——一只被画胖了的猫。总参数 1 万亿、原生多模态的 MoE 模型，原生通晓 160 多种语言，Hugging Face 上落了两个仓库：`Mistral-Large-4-1T-A52B` 和 `Mistral-Large-4-1T-A52B-NVFP4`（NVFP4 量化版）。帖子当天拿到 949 分、268 条评论，距离 10 月上旬的公开预览不到四周。

成绩单的重点是编码。官方称这三周主要在加码强化学习：在 Cognition 的私有榜单 FrontierCode 2.0（看仓库维护者会不会合并 agent 的改动）上以 19.7% 领先；Artificial Analysis 的 Coding Agent Index 拿到 48%，与开源权重阵营的头名 GLM-5.3 基本打平，但每个任务平均少用 47% token；Terminal-Bench 4.0 比预览版涨了 13 个百分点到 41%，输出 token 少 30%。在 Surge Code 的盲测两两对比里，它胜过 GLM-5.3、Kimi K3 和 DeepSeek V4.1 Flash，只排在 Claude Opus 5.5 后面。安全侧的数字是 Artificial Analysis Cyber Index 51%，恶意网络安全请求的平均拒答率 96.6%（官方称是开源模型里最高）。另外还顺手刷了几个榜：金融任务 Finch 73.3%（开源里第二，仅次于 Kimi K3）、网页浏览 BrowseComp 84.5%、B3 Agent 安全基准 97.1%（预览版 93.3%）。推理档位变成三档：Low、Medium、默认的 High，其中 Low 取代了原先的「None」档。

许可证是这份发布里最有争议的部分。官方写的是 Mistral Ecosystem Open-Weight license，一份 modified MIT：免费使用、修改、微调、商用，只附加一条——以 Model as a Service 形式对外提供模型，需要先和 Mistral 签一份单独的商业授权。价格定在每百万 token 输入 $0.70、缓存输入 $0.07、输出 $2.10，基础价 $1.36 输入 / $4.18 输出，近乎对折。原文还交代了两件不太顺耳的事：官方监控线上流量时发现模型会拒绝对真实目标发起的黑盒攻击，但认为这种能力存在被抬升的风险，所以正在收紧护栏；同时给 Orange Cyberdefense 这类企业设计伙伴提供经过审核的专用变体，限定在自有或明确授权的系统上做渗透测试和红队。

生态铺得很大：Microsoft Foundry 作为首家云厂商上线，OpenRouter、NVIDIA 端点与 NIM 容器都可用，本地部署走 vLLM 或 SGLang，微调走 Mistral Forge，另有 Mistral Studio 和 Vibe Code。给它站台的名单按职能排开：Booz Allen、Cisco、Cloudflare、CrowdStrike、Elastic、ENISA、Fortinet、Orange Cyberdefense、Rubrik、Zscaler、NVIDIA、Hugging Face，以及 ABN AMRO、Belfius、Crédit Agricole、ESA Φ-lab。贯穿全文的关键词是主权 AI——在欧盟境内从零训练、权重自持、数据不出境。

## 讨论焦点

### 一、这到底算不算「开放权重」

最早挑事的是 rcr-anti：

> "It's not open weight, it's weights available as they use a modified MIT license that is not OSI. It's the common \"if you're serving it as a business you need a license\" difference, for what it's worth." — rcr-anti [c:50289652]
> （译文：这不是开放权重，是「权重可获取」，因为他们用的是修改版 MIT 许可证，不是 OSI 认证的那种。这就是那种「你要把它当生意做，就得拿授权」的差别，说到底。）

dcss_gardener 立刻反问定义从哪来的：

> "Where did you get this definition of open weight and who else uses it? The weights are published. Open source is already its own more restrictive category. What would you prefer we call this kind of release?" — dcss_gardener [c:50289742]
> （译文：你这个「开放权重」的定义从哪儿来的，还有谁在用？权重已经公开了。开源本身已经是更严格的一个类别。你希望我们管这种发布叫什么？）

btown 把许可证原文贴了出来，第 2 条写得很清楚：

> "If the Licensee or any of its affiliates operates a Model as a Service business, the Licensee must enter into a separate commercial license with Mistral before using the Model or its derivative works for any commercial purpose." — btown [c:50289907]
> （译文：如果被许可方或其任何关联方经营 Model-as-a-Service 业务，被许可方必须先与 Mistral 签订单独的商业授权，才能把该模型或其衍生作品用于任何商业目的。）

他随后攻击的是授权条款本身的模糊处：

> "\"Meaningful control over the inputs\" is so ambiguous as to be nearly meaningless. Does a model merely summarizing a user's submitted support tickets, give that user meaningful control over the inputs?" — btown [c:50289907]
> （译文：「对输入拥有有意义的控制权」这个说法模糊到几乎等于没说。一个模型只是总结用户提交的工单，能算那位用户对输入有有意义的控制权吗？）

mrob 把这件事归到开源定义的映射关系上：

> "\"Open weight\" is obviously intended to be analogous to \"open source\". The name only exists because people rightly complained about people calling weights \"open source\" when they were not. As such, the most reasonable interpretation is something that obeys the Open Source Definition as closely as possible, but ignores clause 2 because obeying it is legally impossible when the source code infringes copyright (as is the case with almost all LLMs). If it ignores any of the other clauses, it's instead closer to \"source available\" software, so the correct analogous name is \"weights available\"." — mrob [c:50290270]
> （译文：「开放权重」显然是想对应「开源」。这个叫法之所以存在，正是因为有人正当地抱怨过把权重叫「开源」并不成立。所以最合理的理解是：它要尽量贴近开源定义，只忽略第 2 条——因为当源码侵犯版权时，遵守这一条在法律上根本不可能（几乎所有 LLM 都是如此）。如果它违反的是其他条款，那它其实更接近「源码可见」那一类软件，所以对应的准确叫法应该是「权重可获取」。）

maxloh 的类比更直接，指向软件史上的一次集体反弹：

> "Calling this open weight is misleading. That's why we had huge backlash when Redis, Elasticsearch, and Terraform went source-available, right?" — maxloh [c:50290489]
> （译文：把它叫开放权重是有误导性的。Redis、Elasticsearch、Terraform 转成源码可见时招来多大反弹，你还记得吧？）

但反方同样有人。Taek 的说法是标题没骗人：

> "Everyone that I know considers something to be 'open weight' if the weights are available to the public in some form or another." — Taek [c:50289861]
> （译文：我认识的每个人都认为，只要权重以某种形式对公众开放，就可以叫「开放权重」。）

dannyw 则给出他自己的判断——能不能用，和能不能卖，是两件事：

> "Works for me. I can host it, I can run it, I can use it; but if I want to sell access to it as an inference provider, I'd have to get a license. The economics of open-weight models has always been shaky. It's not an OSI license yes, but metaphorically it's kinda like AGPL." — dannyw [c:50289901]
> （译文：对我来说可以。我可以自己托管、自己跑、自己用；但如果我想以此身份卖推理服务，就得拿到授权。开放权重模型的经济学一直就 shaky。它确实不是 OSI 许可证，但比喻起来有点像 AGPL。）

这场分歧其实是权重界的常态：OSI 后来专门发过一份开放权重定义，而大部分模型厂商，包括 Qwen、GLM、Kimi、minimax，用的也都是带额外条件的许可证。争到最后争的不是「能不能用」，是「叫它开放权重算不算诚实」。

### 二、价格砍到对折，但账单不是这么算的

Topfi 第一个把价格摆出来：

> "They slashed pricing, it's now nearly half vs the preview (Input: $0.7/M Tokens, Output: $2.1/M Tokens vs Input: $1.36/M Tokens, Output: $4.18/M Tokens). At the original pricing in my evals, Mistral Large 4 Preview was not competitive. With this price point and some improvements on top, this full release warrants a major reassessment." — Topfi [c:50289701]
> （译文：他们把价格砍了，现在差不多是预览版的一半（输入 $0.7/M tokens，输出 $2.1/M tokens，对比原来输入 $1.36/M、输出 $4.18/M）。按原始价格在我的评测里，Mistral Large 4 预览版没有竞争力。有了这个价格再加上这些改进，正式版值得重新评估。）

almindor 指出价格本身就有过摇摆，而且用下来还是嫌贵：

> "They didn't. Original price was maybe higher but they slashed it during preview and in fact it was lower by a  bit ($0.68/M tokens) and $2.09 for output. I've been using it for my personal project and it's  still too expensive and very slow when thinking. I think we need one more generation from mistral and with maybe 50% of this already \"slashed\" price for this to be competitive (I use Opus 5.5 at work and it's still much better than this)." — almindor [c:50290299]
> （译文：并不是。原始价格可能更高，但预览期他们砍过一次价，实际上还更低一点（$0.68/M tokens，输出 $2.09）。我在自己的项目里用它，还是太贵，思考的时候也很慢。我觉得 Mistral 还需要再出一代，而且要在这已经「砍过」的价格基础上再降一半才够竞争力（我上班用 Opus 5.5，它还是比这个强得多）。）

Topfi 回头查了一遍，承认对方说得对：

> "I just checked, seems you are right. They had roughly a week with the lower pricing, then increased it, now decrease it again. Very odd. My testing was with the higher pricing and looking at AA, theirs seems to have been too." — Topfi [c:50290469]
> （译文：我刚查了，看起来你是对的。他们低价维持了大概一周，然后涨回去，现在又降下来。很怪。我测试时用的是高的那个价格，看 AA 榜单时他们的价格似乎也是高的。）

真正让比较变得不公平的是缓存输入价。miroljub 认为这是对比里最关键却常被略过的数字：

> "Why does everyone avoid publishing the most important part of the pricing while doing a comparison? My coding sessions have a >97% input cache rate. DeepSeek got us spoiled. I am not going to use any AI provider with exorbitant or hidden cache rates." — miroljub [c:50289836]
> （译文：为什么大家做价格对比的时候都避开最重要的那部分？我的编码会话输入缓存命中率超过 97%。DeepSeek 把我们惯坏了。我不会用任何缓存率高得离谱、或者不公开缓存价的供应商。）

Topfi 补上数字后，结论变得很难看：

> "They did, I just didn't include it: $0.07 cached input / M So 10x-20x vs Deepseek v4.1 Flash and I don't have on hand how efficient Mistral is regarding cache hits, etc." — Topfi [c:50289872]
> （译文：他们确实公布了，只是我刚才没写：缓存输入 $0.07/M。那么对比 DeepSeek V4.1 Flash 就是十到二十倍，而且我手上没有 Mistral 在缓存命中上的效率数据。）

对价格合理性的另一种解释是「亏本换数据」：

> "Given the size of the model, that's very aggressive pricing. I wonder if it is serving at a loss to get training feedback (maybe using the margins they get from GLM 5.3 serving which is a slightly smaller model but double the price)." — ismailmaj [c:50290068]
> （译文：以这个模型的体量来说，这是非常激进的定价。我怀疑他们是在亏本服务来换取训练反馈（也许用服务 GLM 5.3 得到的利润来补贴——那个模型更小，定价是它的两倍）。）

oh_no 泼的是冷水：

> "I really don't think it does, the benchmark numbers are dreadful and the cost is higher than Sol. If you have to use an EU model knock yourself out but there are a ton of models that are a lot smarter for a lot less money." — oh_no [c:50292188]
> （译文：我真不这么认为。它的基准数字很难看，成本还比 Sol 高。如果非用欧洲模型不可，那就请便，但市面上有一大堆更聪明、便宜得多的模型。）

还有一个只有欧盟用户才会撞上的细节：

> "Those in the EU wanting EU-only inference should be aware Mistral put a 10% tax (\"upcharge\") on Regional Inference[1]." — traceroute66 [c:50292803]
> （译文：在欧盟、想要纯欧盟境内推理的用户要注意，Mistral 给 Regional Inference 加了 10% 的税（“加价”）。）

### 三、96.6% 拒答率：一个数字的三种拆法

3form 的问题最扎人——官方只报了恶意请求的拒答率，没报正常请求被误拒的比例：

> "I feel like stating the obvious here and hence like I'm missing something. Where is the statistic about not refusing the non malicious requests? I can achieve the same performance with refusing when random(1000) < 967." — 3form [c:50289898]
> （译文：我这话说得可能太浅了，总觉得自己漏掉了什么。非恶意请求的不拒答统计在哪里？我只要在随机数小于 967 时拒答，就能做到同样的性能。）

ex-aws-dude 的吐槽把话说到了公关语言上：

> "It is kind of comical how things that previously would have been obviously true are now only statistically true" — ex-aws-dude [c:50294722]
> （译文：以前一听就知道是真的是，现在只统计意义上为真，这事挺滑稽的。）

他补的那句更像从产品页抄下来的：

> "\"Our product won't hack you 96.6% of the time\"" — ex-aws-dude [c:50294722]
> （译文：“我们的产品有 96.6% 的概率不会黑掉你。”）

kouteiheika 的判断更彻底：自托管模型上的护栏本来就可以绕过：

> "These statistics and safeguards are pretty much meaningless, because it's completely trivial to get around them." — kouteiheika [c:50291521]
> （译文：这些统计和安全机制基本没有意义，因为绕过它们太容易了。）

> "Guardrails on open-weight models is security theater purely to shield whoever released them from a potential PR nightmare." — kouteiheika [c:50291521]
> （译文：开放权重模型上的护栏就是一场安全戏剧，纯粹是为了替发布者挡掉潜在的公关噩梦。）

不过也有人认为拒答率这个指标本身方向就错了。nikanj 一句话带过：

> "Nobody cares about that number, because refusals don't lead to company-ending news headlines." — nikanj [c:50290259]
> （译文：没人关心那个数字，因为拒答不会上头条，但拒答失误会毁掉公司。）

pixl97 谈的是另一层：恶意与否是意图问题，不是工具问题。

> "Yea, the problem with maliciousness is intent. Much like having a hacking tool doesn't mean you're doing anything illegal, attacking a machine doesn't necessarily mean you're committing a crime." — pixl97 [c:50290249]
> （译文：对，问题在于意图。就像手里有黑客工具不等于你在做违法的事，攻击一台机器也不必然构成犯罪。）

### 四、榜单可信吗：连榜单自己都在改数字

有人直接从性价比角度否定整个叙事：

> "Look at the Intelligence Index vs. Cost per Task. Mistral 4 is not competitive." — esafak [c:50290064]
> （译文：看看 Intelligence Index 与单任务成本的关系。Mistral 4 没有竞争力。）

Topfi 指出他看的是旧数据：

> "That is still the Preview, which cost almost twice as much and also had worse eval results." — Topfi [c:50290116]
> （译文：那还是预览版的数据，价格差不多是现在的两倍，评测结果也更差。）

Systemerror7A69 的怀疑指向榜单机构本身：

> "Irregardless of wether or not Mistral Large 4 is competitive or not, I do not trust the AA numbers anymore, for various reasons. Them changing their numbers around so much recently brings the entire validity of this in question, not to mention if such a combined number is even important at all." — Systemerror7A69 [c:50290565]
> （译文：不管 Mistral Large 4 到底有没有竞争力，我现在不信任 AA 的数字了，原因很多。他们最近把数字改来改去，把这件事整体的有效性都打成了问号，更别说这种合并分数本身重不重要了。）

另一个质疑方向是覆盖范围：

> "That's really great! Congratulations to everyone working at Mistral! Now, perhaps Kimi 3.1 is missing from the benchmarks, and Deepseek 4.1 Flash is still has impressive!" — jiehong [c:50289715]
> （译文：真棒！恭喜 Mistral 的所有同事！不过，Kimi 3.1 也许没被放进这些基准里，而 DeepSeek 4.1 Flash 仍然很强。）

至于 Mistral 自己强在哪，最实际的回答来自「我按性能选型，不按护照选型」：

> "EU provenance doesn't matter much to me. I pick a model on performance for the job, and from what I've seen, this isn't it. The price cut makes it more interesting than the preview was, tho." — vincentshipsit [c:50290026]
> （译文：欧洲血统对我来说没那么重要。我按活儿需要的性能挑模型，就我看到的而言，它不在候选里。不过降价之后确实比预览版有意思多了。）

而 satvikpendem 恰好是另一种态度——选型时把「来源」当硬指标：

> "I'm not sure how well Mistral is doing in comparison to the other open-weight models, particularly Chinese ones, and I guess one would only really use Mistral if they want to have EU provenance for models." — satvikpendem [c:50289734]
> （译文：我不确定 Mistral 跟其他开放权重模型相比表现如何，尤其是跟中国那些模型比；我猜只有想要欧洲血统的人才会真的用 Mistral。）

risphere 代表了评论区里最短的那种支持：

> "It's great that Europe finally has a good open-weights model." — risphere [c:50289993]
> （译文：欧洲终于有一个不错的开放权重模型了，这挺好。）

### 五、1 万亿参数本地跑：显存这笔账怎么算

一位手上有 4 张 H200 的用户把问题摆到了评论区：

> "I have access to a server with 4 x h200 cards - 540 GB in total memory, but it appears I have to go to 4bit or 3bit even to serve it. Any idea if that is feasible/desirable (we have restrictions that we can't use a chinese model!)." — jamesblonde [c:50290022]
> （译文：我有一台服务器，4 张 H200，总共 540 GB 显存，但看起来要跑到 4bit 甚至 3bit 才能部署。这可行吗、值得吗（我们有限制，不能用中国模型）？）

答案是显存根本不够——4bit 权重本身就要 610 GB：

> "4 bit quality would be good, but you need more GPU, the 4bit weight is 610gb.  EXL3 in 3 bit has been okay the few times I used it." — segmondy [c:50290921]
> （译文：4bit 的质量不错，但你需要更多 GPU，4bit 权重本身就有 610GB。我用过几次 EXL3 的 3bit 版本，效果还行。）

量化版的门路是 Unsloth 这类团队提前拿到的 day zero 权限：

> "They were given day zero access to release their quantizations[0]. The lowest quant will still require 256GB VRAM to run inferences, but as always I'm amazed by the Unsloth team by how much they can reduce the requirements for these powerful LLM's, and the easy-to-follow guides to get started with using them." — prophesi [c:50293101]
> （译文：他们拿到了首日权限，可以同步发量化版。最差的量化仍然需要 256GB 显存才能跑推理，但一如既往，我叹服于 Unsloth 团队压低这类强模型运行门槛的能力，以及他们提供的上手指南。）

jacquesm 的算术差 32GB：

> "Ugh, ok that's out of my league :) Almost though, another 32GB and it would work." — jacquesm [c:50293137]
> （译文：好吧，这超出我的能力范围了。不过就差一点，再加 32GB 就能跑。）

dada216 的做法是把选择过程工程化：

> "Spend the time to write a test process to try multiple quantization configs/multiple inference engine and throw at it a bunch of request you can reply and evaluate the results of. We got it down to a process and everytime there's a new model/options/inference engine version we just run the internal bench/eval suite and make a choice." — dada216 [c:50295639]
> （译文：花点时间写一套测试流程，试试多种量化配置、多种推理引擎，丢一批能回答的请求进去，再评估结果。我们已经把它沉淀成流程，每有新的模型、选项或引擎版本，就跑一遍内部评测套件，然后做选择。）

结论稍微有点冷：消费级机器基本没戏。

> "I have no idea how you could shrink this down to fit on any type of prosumer hardware though. I doubt it's possible." — sullivanmatt [c:50293134]
> （译文：不过我真想不出有什么办法把它压到任何一种家用级硬件上。我怀疑做不到。）

### 六、当「必须用欧洲模型」变成合规要求

jamesblonde 那句括号里的补充，被 echelon 追着问了下去：

> "Please expand on this if you can. Why can't you? Who mandated this?" — echelon [c:50290101]
> （译文：能展开说说吗？为什么不能用？是谁规定的？）

derektank 指向了一份具体的采购文件：

> "Last I heard, US defense contractors had been directed to not use Deepseek in their operations late last year[0], and most have taken that as an indicator that they shouldn’t be using chinese models generally." — derektank [c:50290593]
> （译文：我最后听到的说法是，去年底美国国防承包商被要求不要在业务中使用 DeepSeek，而多数人把它理解成：那就干脆别用中国模型了。）

质疑这套逻辑蔓延的评论有两个方向。mapontosevenths 指向咨询公司：

> "Executives live in a weird bubble driven largely by consulting firms. Right now those firms are spreading FUD about Chinese models." — mapontosevenths [c:50290245]
> （译文：高管们活在一个奇怪的气泡里，很大程度由咨询公司推动。现在这些公司正在散播关于中国模型的恐慌性说法。）

alembic_fumes 则承认禁令有它的道理，但反对只针对中国厂商：

> "In fairness this doesn't warrant the way that the policy targets Chinese models specifically, but Chinese providers do fall under the broader category of entities that cannot be prosecuted by the U.S. law if such behaviour is found." — alembic_fumes [c:50290710]
> （译文：公平地说，政策这样专门针对中国模型是过头的，但中国厂商确实属于这样一类主体：一旦发现这类行为，无法用美国法律追究。）

至于「模型会偷偷回连」的传闻，评论区里是另一番口径：

> "Recently it was found that Qwen was dialing back home once in a while. It cannot be proven that it does not take commands from home if it can establish connection." — 50or05 [c:50294520]
> （译文：最近发现 Qwen 偶尔会往回连一次。无法证明的是，只要能建立连接，它就不接受来自远端的指令。）

这条说法在帖内没有可核验的证据，评论区也没人给出出处。zardo 的回复更像是吐槽现行司法管辖：

> "Alibaba (Qwen) at least has plenty of people in US offices to go arrest." — zardo [c:50291095]
> （译文：阿里（Qwen）至少在美国有足够多的人可以被逮捕。）

### 七、找不到付款入口这件事

这条讨论跟模型无关，却占了不少篇幅。tokai 的困惑是：

> "why is it so hard to give money to Mistral? Now they finally have a model that might be worth using, but I cannot for my life figure out how to give them money and be allowed to use their model. Its really shouldn't take more than a couple of clicks to get to a payment option." — tokai [c:50289584]
> （译文：为什么给 Mistral 付款这么难？他们现在终于有个可能值得用的模型了，但我怎么都搞不定怎么付钱才能合法用它的模型。走到付款选项那里，真的不该超过点两下。）

markild 亲自走了一遍流程，判定是「藏得深」而不是「难」：

> "Clicked sign in, was presented with a sign up form, got a free account. From there could upgrade to pro plan or pay-as-you-go. I agree it was perhaps too hidden, but calling it hard is not fair I think." — markild [c:50289712]
> （译文：点登录，弹出来是注册表单，我注册了个免费账号，从那里就能升级到 pro 计划或者按量付费。我同意藏得有点深，但说它「难」我觉得不太公平。）

InsideOutSanta 给出了最短路径：

> "That's because the base offering is free. So you create an account, use it for free, and when you want to pay, click on \"Upgrade to Pro.\"" — InsideOutSanta [c:50291173]
> （译文：那是因为基础版是免费的。注册账号，先免费用，想付费的时候点「Upgrade to Pro」就行。）

smodo 补充了订阅方案的真实规格，以及一个容易踩的坑：

> "But their 18 eur per month offering is actually good with 255 eur worth of tokens included. Take care though: you need to create a specific kind of API key to avoid being charged for per token use besides your subscription." — smodo [c:50291632]
> （译文：不过他们每月 18 欧的订阅其实挺划算，含 255 欧等值的 token。但注意，你得创建特定类型的 API key，才不会在订阅之外再被按 token 收费。）

一个以支持欧洲模型为原则的客户，顺便拿法国式工程开了个玩笑：

> "This is on par with European stereotypes about French engineering so I’ll just go along with it :)" — smodo [c:50291632]
> （译文：这完全符合欧洲人对法国工程的刻板印象，那我就配合一下好了。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 按 OSI 定义这不算开放权重 | rcr-anti | modified MIT 只在「自用」范围内像开源 |
| 名字之争没有意义 | Taek | 权重能下就是开放，限制存在也不意外 |
| 实质是自托管自由，商业化受限 | dannyw | 能跑能改能卖吗？卖要授权 |
| 授权条款本身模糊 | btown | 「对输入有意义的控制」几乎无法定义 |
| 价格砍半但仍偏贵 | almindor | 思考慢，还需再等一代 |
| 缓存价才是真实成本 | miroljub | 缓存命中率 97% 的时代，比价不能只看牌价 |
| 拒答率是公关数字 | 3form | 只报恶意拒答，不报正常任务误拒 |
| 榜单数字不可信 | Systemerror7A69 | AA 反复改数，合并分不代表需求 |
| 本地部署基本不成立 | segmondy | 4bit 权重 610GB，最低也要 256GB 显存 |
| 按性能选型不看护照 | vincentshipsit | 欧洲血统救不了不够强的模型 |
| 禁令会从 DeepSeek 外溢到全部中国模型 | derektank | 国防承包商一条指令，企业自己加码 |
| 买入口太深 | tokai | 找付款选项不该超过两下点击 |

## 总体情绪

这场讨论的分裂点很清楚：有人为基准成绩叫好，有人只关心自己的账单，有人纠结「开放」这个词该叫什么，还有人一句都没谈模型，直接问出了付款入口在哪。

有意思的是，骂得最凶和夸得最狠的其实是同一批人。吹开放权重的人，转头就说 Mistral 的护栏是安全戏剧、拒答率是公关数字；夸编码榜第一的人，也承认预览版价格下这模型「没有竞争力」。Mistral 这次发布确实同时踩中了两条敏感神经：一份比 MIT 多一道限制的许可证，和一套把对手价格衬得更高的价格表。

真正被反复验证的，还是那句老话——权重放出来不等于模型能用起来。1 万亿参数、4bit 权重 610GB、最低 256GB 显存，这条链上的每一环都决定了绝大多数人最后还是在用 API。而所谓主权 AI 的卖点，落到评论区里被压缩成了一句：欧洲终于有一个不错的开放权重模型了。

所以这一天真正开放的，是三样彼此不搭界的东西：一个下载链接、一份 modified MIT 许可证，和一堆口径都没统一的口头基准。至于这只叫 Le Chonk 的胖猫，离普通人的显卡还差着 256GB 显存。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Mistral Large 4 (Le Chonk) is now Open Weight（HN 讨论） | https://news.ycombinator.com/item?id=50289418 |
| 2 | We're releasing the weights of Mistral Large 4（Mistral 官方博客） | https://mistral.ai/news/mistral-large-4-oss/ |
| 3 | Mistral-Large-4-1T-A52B（权重，Hugging Face） | https://huggingface.co/mistralai/Mistral-Large-4-1T-A52B |
| 4 | Mistral-Large-4-1T-A52B-NVFP4（NVFP4 量化权重） | https://huggingface.co/mistralai/Mistral-Large-4-1T-A52B-NVFP4 |
| 5 | Mistral Ecosystem Open-Weight license 原文 | https://huggingface.co/mistralai/Mistral-Large-4-1T-A52B/raw/main/LICENSE |
| 6 | Mistral 推理定价 | https://docs.mistral.ai/inference/pricing |
| 7 | Regional Inference 说明（区域推理 10% 加价） | https://docs.mistral.ai/inference/regional-inference |
| 8 | OSI 对开放权重的定义 | https://opensource.org/ai/open-weights |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。讨论涉及开放权重的许可证边界、美国国防采购对大模型供应商的限制、咨询公司对中国模型的说法，以及评论区中关于 Qwen 回连的未证实指控，均属需要独立核实的信息。所引观点按原帖立场呈现，不代表本项目立场。文中基准数字、价格与许可证条款整理自 Mistral 官方博客与帖子内评论者的引用，未经独立复测，请以官方页面与许可证原文为准。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
