---
layout: post
title: >-
  Anthropic Glasswing 开跑七个月：37,966 个发现，217 个修复 — HN 讨论摘要
date: 2026-11-11
hn_id: 50447074
categories: [articles]
excerpt: >-
  VulnCheck 追踪 Anthropic 的 Glasswing 七个月：账面上 37,966 个发现只有 217 个被修复，curl
  收到的 34 份报告里有 19 份不是漏洞。评论区真正在吵的不是数量，而是这些洞到底算不算数。
tagline: >-
  找洞已经流水线生产，修洞还停在手工艺阶段。
---

> 来源：HN 讨论主帖 [After 7 months, Glasswing overwelms maintainers with underwhelming findings](https://news.ycombinator.com/item?id=50447074)（357 分，167 条评论），原文是 VulnCheck 的 Patrick Garrity 的追踪博客。本篇为 single post 模式。归档快照 2026-11-11 05:05 UTC，入库评论 100 条。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 4 月 7 日，Anthropic 发布 Project Glasswing，公告里写的是「我们已经发现了数千个额外的高危和严重漏洞，正在负责任地披露给开源维护者」，宣传口径是「漏洞发现的 Mythos 时代」。项目还附了一份叫 Ledger 的披露台账，供外界核对。VulnCheck 的 Patrick Garrity 从 4 月 17 日起在 GitHub 上建了个仓库（Anthropic Credited CVEs）逐条追踪，用 CVE 记录、GHS advisory、Linux 内核 commit 和 Anthropic 自己的台账交叉比对，11 月 10 日发了第七个月的账。

数字是这样：Garrity 追到 442 个归属 Anthropic 的 CVE，平均每月 63 个，占今年发布的 93,450 个 CVE 的 0.5%；Anthropic 自己的台账上「已修复」的只有 217 条，Garrity 追到的数量是官方口径的两倍多。他同时把这些 CVE 跟 VulnCheck KEV 交叉比对，442 个里只有 2 个在野被利用——CVE-2026-61500 和 CVE-2026-26980，占 0.45%。台账那边则是另一个故事：5 月首次公布时是 23,019 个 findings、真阳率 90.8%；11 月 2 日更新后是 37,966 个 findings，修复数仍是 217。公开的只有 7,349 个（19.4%），标为重复的有 1,654 个（4.4%），被撤回的 419 个，真阳率反而从 90.8% 涨到 94.2%。Garrity 特别指出 9 月到 11 月这两个月里，新增量接近 12,000 个 findings，修复数只多了 15 个。

转折出现在 10 月 8 日 Anthropic 推 OSS Scanner 的时候。这个扫描器的自述很坦白：发现了 29,000 多个候选漏洞，人工只审了大约 6,000 个，「仍然卡在人工验证这些发现的人力瓶颈上」，同时已经向维护者批量发出了近 5,000 份未经人工复核的报告，维护者要求全量接收。Anthropic 也明说这些报告「完全由模型生成，没有人工复核或分类」。换句话说，triage 瓶颈没有消失，它只是从 Anthropic 内部挪到了维护者身上。

于是就有了 11 月 7 日前后的 curl 事件。curl 维护者 Daniel Stenberg 宣布项目收到 Anthropic 的 45 份漏洞报告，Anthropic 只给其中 1 份评了 medium，其余全评 low；他按自己的节奏往 GitHub 搬，「to soften the impact for the team」。截至统计时已公布 34 份，其中 19 份被判定不是漏洞，6 份确认是 low 严重度，9 份待评估——假阳率 55.9%，确认率 17.6%。5 月份 curl 就写过，5 个 Mythos findings 最终只对应 1 个确认漏洞。而 Garrity 早在 9 月就发现，Claude 把台账里的 findings 评为 critical 或 high 的比例是 91.5%，维护者给出的比例只有 51.3%。同一个洞，模型和维护者给出的评级差着四十个百分点。

## 讨论焦点

### 一、「19.4% 已公开」这个样本本身就偏了

Garrity 的整套推论都建立在「已公开的 7,349 个」之上，而评论区最先拆的就是这个前提。dfee 说得很直接：

> "In other words, this is analysis of survivors (public); not much can be said about those still under embargo." — dfee [c:50447443]
> （译文：换句话说，这是在分析幸存者（已公开的那批）；对仍在禁运期的那批，说不了什么。）

hologramofham 的提问更直接：

> "So the article is making a sweeping statement based on the 19.4% of publicly disclosed CVEs?" — hologramofham [c:50447495]
> （译文：所以这篇文章是基于那 19.4% 已公开的 CVE 下的一个笼统结论？）

milkshakes 则把「public」这个词的常见误读先纠正掉：

> "&quot;public&quot; here has nothing to do with government holding on to vulns. it&#x27;s about landing fixes and coordinating complicated &#x2F; impactful findings" — milkshakes [c:50447536]
> （译文：这里的「公开」和政府扣着漏洞不报没关系，它指的是落地修复和协调那些复杂、有影响的发现。）

真正给出替代解释的是 ASalazarMX：

> "I&#x27;d expect the remaining 80% are delayed not because there&#x27;s something statistically special about them, but from the massive workload thrown at humans in the loop." — ASalazarMX [c:50448086]
> （译文：我预计剩下那 80% 之所以延迟，不是因为它们有什么统计意义上的特殊性，而是因为压在人在环路上的工作量太巨大。）

这段讨论的实质是：Garrity 和评论者其实共享同一个模型——发现数量已经不再受限于模型的聪明程度，而是受限于验证和修复的吞吐量。分歧只在于这个瓶颈该算在 Anthropic 头上还是算在维护者头上。

### 二、37,966 比 217：AI 拆得比建得快

第二个主题是这个比值本身。delichon 把问题抽象成了一条比例：

> "The current stat from this experiment is 37,966 to 217. Lots of false positives, but not enough to change the big picture. I hope they didn&#x27;t apply equivalent tokens to both sides, or AI may be better at demolition than construction." — delichon [c:50447517]
> （译文：目前这个实验的数据是 37,966 比 217。假阳性很多，但还不足以改变大局。我希望他们在两边用了等量的算力，不然 AI 可能是更擅长爆破而不是建造。）

ASalazarMX 接着追问 Anthropic 的产品线：

> "Anthropic needs to teach their systems to propose a fix too. Detecting a coding problem and proposing a patch is what we should expect from a company with supposedly the best coding LLM." — ASalazarMX [c:50448086]
> （译文：Anthropic 也得教会自己的系统提修复方案。定位代码问题并给出补丁，应该是一家号称有最强代码 LLM 的公司的基本要求。）

shiandow 把这个趋势讲得更宽：

> "So far the trend is pointing to AI being better at finding problems than designing software to avoid them." — shiandow [c:50447893]
> （译文：到目前为止的趋势是，AI 更擅长找出问题，而不是设计出不会出问题的软件。）

但「让模型顺便提个补丁」这条建议被 loeg 泼了盆冷水：

> "It doesn&#x27;t mean a project (1) wants to take an LLM-generated fix at all, or (2) can immediately commit an LLM-generated fix without review (which takes time)." — loeg [c:50448231]
> （译文：但这不意味着一个项目（1）愿意接收 LLM 生成的修复，或者（2）能把 LLM 生成的修复不经审查直接提交（审查是要花时间的）。）

ameliaquining 补上了更现实的一层——瓶颈可能不在能力，而在信任：

> "The reason Anthropic isn&#x27;t proactively sending patches is, I suspect, that those patches would not be welcomed, because trust in the models isn&#x27;t currently at the point where maintainers are willing to merge them without human review, which takes approximately as much effort as writing the patches themselves." — ameliaquining [c:50448211]
> （译文：我猜 Anthropic 不主动送补丁的原因是，这些补丁不会被欢迎——目前对模型的信任还不足以让维护者不经人工审查就合并，而审查的花费和自己写补丁差不多。）

于是这一节的结论收得有点冷：模型端能批量产出发现，也能批量产出补丁，但人工审查那一环的吞吐量一点也没涨。

### 三、curl 的 55.9%：还有一部分是抄来的旧账

curl 这个案例是最具体的一击，但评论区没有照单全收，反而扒出了更难看的细节。MBCook 提到上一次 Anthropic 报告的「漏洞」里有重复项：

> "The last time we went through this, curl reported not only that a bunch of them weren’t bugs, but some of the bugs were listed previously on their mailing list, and that’s probably where the LLM got them." — MBCook [c:50448538]
> （译文：上一次我们走这个流程时，curl 报告的不只是有一堆根本不是 bug，还有些 bug 之前就出现在他们自己的邮件列表里，那个 LLM 大概是从那儿拿到的。）

如果连「发现了新东西」这一步都掺着旧货，那 55.9% 的假阳率还得再往上加。eqvinox 正在处理同一批扫描器的报告，他的关注点在附带的补丁上：

> "It&#x27;s not helped by the fact that a good amount (20~30%, maybe more) of the issues is also junk themselves." — eqvinox [c:50448558]
> （译文：更糟的是，有相当一部分（20~30%，可能更多）问题本身就是垃圾。）

munchbunny 用自己的项目经验给了一个略低但更有参照系的数字：

> "what I&#x27;ve seen is closer to 50% being false positives, and then maybe 20% of the remainder being bugs but not vulnerabilities (aka lower priority bugfixes). The suggested patches have a much worse hit rate though, to the extent that I accepted only a small fraction after reviewing." — munchbunny [c:50449452]
> （译文：按我看到的，接近 50% 是假阳性，剩下的里大概还有 20% 是 bug 但算不上漏洞（也就是优先级较低的修复）。不过建议补丁的命中率差得多，我审完之后只接受了很小一部分。）

wonnage 则把严重度这件事补上了——curl 收到的那批里只有 1 个 medium：

> "Even the batch that was sent to curl was one medium and 39 low severity. One can only assume that the vast numbers of findings that haven’t been sent are even lower severity." — wonnage [c:50448258]
> （译文：连发到 curl 的那批里都只有一个 medium、39 个 low。那只能假设，尚未发出去的那海量的发现严重度只会更低。）

### 四、但也别急着说「AI 没找到什么大问题」

有一部分评论者把矛头掉转来，替 Glasswing 说了几句公道话，理由是「没出事」不等于「没用」。snowwrestler 用 PHP2Shell 举例：

> "In short, it was indeed a major vulnerability, but not magic (in the Arthur C Clarke sense)." — snowwrestler [c:50448290]
> （译文：简而言之，它确实是个重大漏洞，但不是魔法（阿瑟·克拉克意义上的那种魔法）。）

timr 用「百万猴」这个说法描述这批 agent 漏洞的能力上限：

> "Thus far, these agent vulnerabilities are all demonstrating million-monkey intelligence, rather than &quot;super&quot; intelligence, in the sense of some swarm of robo-Neo super hackers." — timr [c:50448499]
> （译文：到目前为止，这些 agent 挖出的漏洞展示的都是百万猴级别的智能，而不是某种成群的机器 Neo 式超级黑客所代表的「超级」智能。）

但 tptacek 对「这个洞不算大」的说法很不客气：

> "People say this vulnerability was &quot;not super large easy to exploit&quot; because of one poorly-informed skeptical blog post that hit the top of HN, but the evidence strongly suggests that post was simply wrong" — tptacek [c:50448029]
> （译文：人们说这个漏洞「不算大、不容易利用」，是因为一篇冲上 HN 首页的、认知不足的怀疑派博客，但证据强烈表明那篇文章纯粹是错的。）

「漏洞」和「可利用的漏洞」被评论区反复分开来讲。plorkyeran 承认 PHP2Shell 是真漏洞，只是没看到灾难性利用：

> "While I&#x27;m not going to claim the PHP thing wasn&#x27;t a real vulnerability, it... doesn&#x27;t seem to have actually been catastrophically exploited?" — plorkyeran [c:50448436]
> （译文：我不打算说 PHP 那件事不是真漏洞，它……看起来确实没有被灾难性地利用过，对吧？）

fny 的语气最接近原始帖里那种「等一个超级炸弹」的期待落空：

> "I think the most obvious chicken little sign has been that we&#x27;ve had no catastrophic exploits in the past year due these findings." — fny [c:50447420]
> （译文：我认为最明显的「唱衰者」式迹象就是，过去一年里并没有因为这些发现而出现灾难性的利用。）

### 五、数据集看不到的那一半

另一批评论者指出，这张报表的采样本身有系统性偏差——能被公开披露、能拿到 CVE 编号的洞，永远只是全部问题里最容易被看见的那一小撮。

> "Public datasets of CVEs being underwhelming doesn&#x27;t mean much if all of the issues are in private company codebases that will never get a CVE number assigned and will never get a fancy blog post." — enthuseyourcurb [c:50448590]
> （译文：如果所有问题都在私有代码库里——永远拿不到 CVE 编号、也不会有专门博客文章的那种——那 CVE 公开数据集显得平平无奇就说明不了什么。）

pixl97 把企业软件的实际体量摆出来：

> "An F100 company has thousands, maybe tens of thousands of applications that you&#x27;ve never heard of and never will unless you work for them." — pixl97 [c:50449005]
> （译文：一家财富 100 强公司有成千上万、甚至数万个你从没听过、除非你在那家公司上班否则永远不会听说的应用。）

顺着这个思路，kennywinker 认为开源项目未必比闭源软件更安全：

> "I suspect open source projects are better off than proprietary software - they already have many eyes on them, whereas commercial software that’s not a prominent and profitable target (e.g. windows, ios) hasn’t had much attention until LLMs made attacking them significantly easier" — kennywinker [c:50448837]
> （译文：我怀疑开源项目比专有软件处境更好——它们本来就有很多双眼睛盯着，而那些不够显眼、不够赚钱的商业目标（比如 Windows、iOS）在 LLM 把攻击成本大幅拉低之前，是没怎么被盯过的。）

DenisM 立刻拿历史反驳：

> "This has been disproven by the sordid history of OpenSSL. It was open source, critical, and full of holes." — DenisM [c:50449165]
> （译文：OpenSSL 那些不光彩的历史已经证伪了这一点。它当时是开源的、关键性的，而且满是洞。）

### 六、VulnCheck 也是生意人

一篇把某家厂商的项目说成「名不副实」的追踪博客，评论者自然会去查作者的商业模式。jrflo 的质疑很直白：

> "Very interesting that the conclusion of the article is so tightly aligned with the VulnCheck&#x27;s business model! It&#x27;s almost as if this is just a thinly veiled advertisement..." — jrflo [c:50447507]
> （译文：很有意思，这篇文章的结论跟 VulnCheck 的商业模式高度对齐！简直就像一篇披着薄纱的软文……）

janalsncm 找了个更早的先例：

> "The common thread is asking humans to do the verification work, which is the hard part." — janalsncm [c:50448565]
> （译文：共同点在于把验证工作甩给人类，而这恰恰是最难的部分。）

他类比的是 DeepMind 的 GNoME 项目——那个项目找到的「新材料」后来大部分被证明已经存在或是垃圾。而 jknoepfler 顺着这个思路替 Anthropic 找了个台阶：

> "If they actually were sitting on a PR gold mine of vulnerabilities they wouldn&#x27;t be throttled on review resources while artificially inflating&#x2F;misreporting their numbers. They would be diverting resources to clear the review queue." — jknoepfler [c:50448229]
> （译文：如果他们手上真握着一座漏洞金矿，就不会在人工审核资源上被卡住、同时还在人为抬高或误报数字。他们会调资源去清审核队列才对。）

也就是说，「数字虚高」和「真的挖到了但修不动」这两种解释，在只看台账数字的时候是无法区分的。

### 七、能不能证明安全：绕不开形式化验证

讨论的最末尾漂到了哲学层面。有评论者从 halting problem 出发，认为「代码能不能被保证安全」这个问题本身就问错了。

soulofmischief 认为真正缺的不是模型，是一套形式化工具：

> "what&#x27;s missing is the security equivalent of Lean, a real formalized effort to prove security." — soulofmischief [c:50448518]
> （译文：真正缺的是安全领域的 Lean——一次真正形式化的安全证明努力。）

Paracompact 则给出了 halt 问题在这件事上的边界：

> "There is. But it will only be reliable if every transitive dependency of your codebase, all the way down to the hardware level, has been formally verified." — Paracompact [c:50448947]
> （译文：有的。但只有在你的代码库每一个传递依赖——一直到硬件层面——都被形式化验证过之后，它才可靠。）

xelxebar 提醒形式化验证并不是银弹：

> "Formal verification is not magic. It can execute deductive proofs, but the relevance and utility of those results is a question of human values. Spec bugs are a thing. Bad design is a thing. Out-of-scope usage is a thing. Even a halting oracle won&#x27;t help with those." — xelxebar [c:50449279]
> （译文：形式化验证不是魔法。它能执行演绎证明，但这些结果到底有多大相关性和用处，取决于人的价值判断。规格 bug 是一回事，糟糕的设计是一回事，超出范围的使用又是一回事。就算有个停机预言机也救不了这些。）

bee_rider 把这节收在 AI 预期上：

> "The expectations of AI models in security really do seem to be magical in a way that, I think, obscures what needs to be done." — bee_rider [c:50448774]
> （译文：我认为，对 AI 模型在安全上的期待确实带上了某种魔法色彩，而这种魔法感恰好遮住了真正该做的事。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 样本有偏 | dfee | 已公开的只是幸存者，禁运期里的那批说明不了问题 |
| 延迟源于人力 | ASalazarMX | 剩下 80% 排不上队，是人肉负载不是统计规律 |
| 比例是结构性的 | delichon | 37,966 比 217，AI 更像拆迁队而不是建筑队 |
| 该教模型提补丁 | ASalazarMX | 最好的代码模型不该只会报问题 |
| 补丁不会白送 | loeg | 生成补丁容易，审查补丁一样费人 |
| 根子是不被信任 | ameliaquining | 模型补丁不被欢迎，审查成本和手写差不多 |
| 一半报告不是漏洞 | MBCook | curl 上次就发现里面有从邮件列表抄来的旧账 |
| 附带补丁更差 | eqvinox | 补丁是垃圾，问题本身也有两到三成是垃圾 |
| 30% 真阳仍有 ROI | munchbunny | 关键变量是人工排查假阳性花掉的时间 |
| 没等到大新闻 | fny | 去年没出现灾难性利用，预期落空 |
| 只是百万猴 | timr | agent 挖洞是「持续平庸加无限知识」，不是超人 |
| PHP2Shell 不神 | snowwrestler | 重大漏洞，但受利用链长度和 PHP 配置多样性限制 |
| 数据集外才是重头 | enthuseyourcurb | 私有代码库里那些永远拿不到 CVE 编号的问题不在这张表里 |
| 企业软件面更大 | pixl97 | F100 公司有上万个没人听过的应用在内网里跑着 |
| 开源未必更安全 | DenisM | OpenSSL 的历史已经证过一次 |
| 作者有商业动机 | jrflo | 结论跟 VulnCheck 的商业模式高度对齐 |
| 验证工作才是瓶颈 | janalsncm | GNoME 的教训：难的是让人来验证 |
| 数字虚高还是修不动 | jknoepfler | 两种解释光看台账数字无法区分 |
| 缺形式化工具 | soulofmischief | 安全领域缺一个真正的 Lean |
| 形式化不是魔法 | xelxebar | 规格 bug、坏设计、超范围使用，停机预言机也救不了 |

## 总体情绪

这场讨论的分歧其实不在「AI 能不能找漏洞」，而在「这张报表该怎么读」。一派把 442 个 CVE、0.5% 的年度占比、2 个在野利用当成宣传破产的证据；另一派指出，能被公开披露、能拿到 CVE 编号追踪的，本来就是筛过一遍的幸存者，真正让大公司睡不着的那些洞既不会出现在 GitHub 仓库里，也不会出现在 VulnCheck 的表格里。两边其实共享同一个模型——发现的边际成本已经塌了，验证和修复的边际成本没有动。

最尖锐的对照来自维护者本身。curl 收到 45 份报告，19 份不是漏洞，附带补丁被形容为垃圾；而同一批评论里，另一拨人正在为 PHP2Shell 到底算不算魔法吵得不可开交。吵的是两个方向，底色却是同一个比值：报告在涨，修复没涨。三万七千九百六十六比二百一十七，这不只是 Anthropic 的账，它是所有打算用 AI 挖洞的团队会先撞上的那面墙。

洞会越来越多，补丁不会自己长出来。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | After 7 months, Glasswing overwelms maintainers with underwhelming findings（HN 主帖） | <https://news.ycombinator.com/item?id=50447074> |
| 2 | 原文：Tracking Anthropic-discovered vulnerabilities（VulnCheck，2026-11-10） | <https://www.vulncheck.com/blog/anthropic-glasswing-november-update> |
| 3 | Anthropic OSS Scanner（评论 50448528 中给出的仓库地址） | <https://github.com/anthropics/oss-scanner> |
| 4 | PHP2Shell 讨论帖（tptacek 在评论 50449376 中引用） | <https://news.ycombinator.com/item?id=50191174> |
| 5 | GNoME 的材料发现被指大量重复或为垃圾（janalsncm 引用） | <https://pmc.ncbi.nlm.nih.gov/articles/PMC11044265/> |
| 6 | OpenSSL 与 Heartbleed 的历史（DenisM 引用） | <https://www.mend.io/blog/how-the-heartbleed-vulnerability-shaped-openssl/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 357 分、167 条评论，归档快照 2026-11-11 05:05 UTC，入库 100 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN Algolia 接口核验评论存在与作者一致。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。文中关于 442 个 CVE、37,966 个 findings、217 个修复、55.9% 假阳率等数据均引自 VulnCheck 原文，本站未做独立复现；台账中「已公开」计数存在虚增的说法来自原文作者本人，尚未见官方确认。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
