---
layout: post
title: >-
  Anthropic 把代码审查交给 Claude：90% 代码、30k 改动/天，revert 率反降 40% — HN 讨论摘要
date: 2026-10-17
hn_id: 50122951
categories: [articles]
excerpt: >-
  单个 PR 上百次往返才合并不稀奇，但当团队让 Claude 评估 Claude 写的代码，并将 merge 后事故直接喂入 review AI 的每日回归集，revert 率反而压到比人审时还低。这套 pipeline 普通团队能照抄吗？
tagline: >-
  Claude 审 Claude 然后批准 Claude：Anthropic 的反向 centaur 实验。
---

## 原文概要

文章来自 Anthropic 官方工程博客 claude.dev，作者是 Addy Osmani、Morgan Westlee Lunt 和 Qing Wang，发表于 2026 年 10 月 15 日。HN 由用户 pretext 提交，7 小时内拿到 256 分、243 条评论，目前排在热门榜前列。

Anthropic 此前公开过数字：Claude 写 Claude Code 大约 90% 的代码。这篇文章回答一个具体问题：审不过来怎么办？

他们给出一组时间序列数据做底：6 月到 9 月，Claude Code 自身的代码库里合并的 PR 数翻了一倍以上，被 revert 的比例却下降超过 40%。同期内部 monorepo 单日落地改动从约 2500 涨到 30000 以上。

整套流程拆成 7 层，分别是：PR 开启前的自动验证（让 Claude 真的跑测试、编译、截图比对，而不是嘴上报完成）、强制 CI（lint、类型、跨平台测试与打包）、AI review（多个 agent 并行找 bug，另有一组 verifier 对每条发现投票）、安全 review（与上一条独立通道）、按风险分级的人工批准（low/medium/high 对应 0/1/2 人，且高风险路径如 auth/billing/CI 永远需要人）、merge queue 加 feature flag 加灰度、出了问题一键回退。

为了让审查 AI 自己越变越好，团队把过去每一次被 revert 或引发 incident 的 PR 都收进评测集，工程师逐条人工确认 bug 真实存在；评价指标跑回归集，把人改过的 prompt、tool、model 都拿去重打分。

## 讨论焦点

### 可理解的代码 vs 可被搜索的代码

对 Anthropic 文章最具体的反驳，落在「读代码」和「搜代码」的区别上。status_quo69 抓住原文中的一句话——团队成员想理解某段代码时，让 Claude 当场生成一份针对该切片的解读——质问这究竟算不算知识：

> "the system verifies itself" which is cool and is something that automated testing has done for decades, but they eschew the mental model of how the system works as a whole and prefer instead to have the LLM focus and summarize a slice of the system when they need to know about it or ask for it. But.... That's not knowledge? That's just search a la google? [c:50124637]

> （译文：让 LLM 在你需要时聚焦并概括系统的一片，而不是让人建立对系统整体的心智模型。但……这叫知识吗？这不就是谷歌式的搜索？）

随后 jonahx 顺着这条线往下走，把现状描述得更直白：

> There is no longer anyone to turn to if this system breaks by, eg, having a critical bug that no one can figure out. No causal model in anyone's head that can be appealed to, to slowly and methodically debug. By design, the system is too large for that, and everything hinges on Claude itself being able to find and understand the right slice of the system in any situation. As long as that very new invariant holds, everything will be all right. If it fails catastrophically, there is no recovery. You are the owner of a recovered alien spacecraft with tech you have no hope of understanding. [c:50125128]

> （译文：等这个系统真出了无法定位的 critical bug，再没人可求助了。没人脑子里有能召之即来的因果模型，能一步一步调试。系统设计上就大到没人能装下，一切赌在 Claude 自己随时能找到并理解正确的系统切片上。这个新不变量只要成立，就一切太平；一旦灾难性失效，没有兜底。你变成了回收飞船外星科技的人，自己根本不可能理解那玩意儿。）

这类讨论里反复出现 Terr_ 援引的比喻：

> A centaur is a synergistic combination of two things, but now those things are in the wrong position: The human is the computer's tool. [c:50124736]

> （译文：人马座的「半人马」本来是两种力量的协同，现在位置反过来了：人是计算机的工具。）

讨论里也有人打补丁：几十年历史的大型遗留系统也从来没人真正搞懂过，所以并不新鲜。jonahx 自己承认这一点，但他坚持「态度」上不一样——这次是把理解能力整体外包出去，而且规模是新的。

### 30k 改动/天，这还能叫 review 吗

grey-area 直接对数字发起挑战：

> At 30k commits a day, is there anything that can meaningfully be called review? [c:50124243]

> （译文：单日 3 万次提交，什么东西还能被有意义地叫作 review？）

接下来的支线讨论演变成「代码 review 是否能类比制造业产线 QA」。stillpointlab 举 YouTube 上看到的产线高速自动化质检视频作类比，认为代码可以往同一个方向走。grey-area 反驳说这是类别错配：

> That's a category error. Software isn't stamping out the same part again and again; if it were review would be simple. Analogies often mislead. [c:50124578]

> （译文：这是类别错配。软件不是一遍遍冲压同一个零件；如果是，review 反而简单。类比经常误导人。）

fipar 顺着 Quinn 的「Reflections on Trusting Trust」（Ken Thompson 1984 讲编译器植入后门的那篇）那条线做了补充：黑箱 QA 几乎查不出 backdoor，靠 AI 写代码 + AI 测代码会带来全新攻击面——人读代码这件事不光是质量门槛，也是一道安全门槛。

### 这篇文章本身到底是不是 AI 写的

HN 评论里一个显眼的主题是怀疑文章本身就出自 Claude 之手。mk12 引用了一条外部传闻并给出文章内部的两个例子：

> I saw someone say the other day (in response to another blog post being well written) that Anthropic employees have a rule against using AI for writing/external comms? That seems clearly not the case here, normal people don't write like this:
> > Most of the path is automated; a person's attention goes where the risk is
> > The eval grows with every incident, and every change to the reviewer is scored against all of it. [c:50124719]

> （译文：我前两天看到有人说 Anthropic 员工有规定不准用 AI 写对外沟通文本？显然不是这么回事。普通人不会这么写：（上面两个例句））

更实证一派引外部检测工具：

> Pangram reports 80% of the text is AI-generated: [https://www.pangram.com/history/...] [c:50124937]

jazzyjackson 给出了一个更温和的解释：

> if people are getting 90% of their interaction from a robot, one may start to pick up some vocal tics and colloquialisms from machine world. a kind of robo-pidgin. [c:50124874]

> （译文：如果一个人 90% 的文字往来对象是机器人，人会染上机器世界的口头禅和腔调，算是机器 pidgin。）

这股讨论对 Anthropic 文章的可信度起了部分折损作用。

### 这套流程别人能照搬吗

第 4 个焦点是「Anthropic 的实践是样本还是营销」。avinoth 写了最长的一段吐槽：

> This is like one of Google's infrastructure blog. Google scale things are only relevant and appropriate for them. We had lots of bitter lessons from smaller engineering teams following the process with the justification that "this is how Google does it".
> Similarly, Anthropic can afford to do this because they have virtually unlimited tokens and labs to train models for their specific usecase. The rest of us need code comprehension lest we become dependent on continuous supply of tokens (which is a state these labs badly want to achieve) [c:50127080]

> （译文：这就和 Google 的基础设施博客一个样。Google 那个规模才有意义、才适用。多少小工程团队照抄，得到的全是血的教训。
> Anthropic 能这么干是因为他们有几乎无限的 tokens，和专门为自己的用例训模型。其余团队需要代码理解能力，不然会变成对 tokens 持续供应的依赖——这恰恰是这些实验室最想达成的一种状态。）

紧接着 thatsabadlook 把同一类质疑收紧到财务面：

> Even then do we really have evidence that what they are doing is reasonable or practical for them at all? They are edging on like 3 9s uptime, what leaked of Claude code looked like soup, tons of security issues, they can't build a sandbox to save their company, and last I heard they aren't even profitable without adjusting their numbers for arbitrary things.
> Think I'm good on taking advice from companies that aren't making money. [c:50127108]

> （译文：话说回来，他们到底干得合理不合理、有没有实效？可用性在三个 9 边缘晃，泄漏出来的 Claude Code 看起来像一锅粥，大量安全问题，沙箱也搭不起来，而且上次听说他们盈利还得靠剔除条目才能做平。
> 在还没赚钱的公司那里取经，我兴趣不大。）

vinoth 最后引文中一句「agent 也能解决 uptime、安全、代码理解」成为后续评论中反复被揶揄的一句话，被提炼为「Anthropic 的解法：再烧点 token」。

### vibe coding 的真实代价

最贴近读者实操体验的一段讨论集中在大项目上。zeroonetwothree 在一个「试试 vibe-coded 副业项目」话题下写了很长的现身说法：

> I've been working on a large (~10MLOC) mostly vibe-coded project for months now. It's actually quite frustrating:
> * The agent will fix a bug when I tell it to, but only in exactly one place. I'll notice that another place has that bug later and have to redo it. It's the sort of thing that I would know to check for if I were fixing it myself.
> * The user-facing text it generates is just as awkward as ever. I have to rewrite all of it...
> * It doesn't have a good model of what kind of information is relevant to humans... For example, it doesn't understand that $0 can logically mean "null" in terms of how humans think about things (e.g. "This item is free" vs. "This item is $0").
> I kind of wish I hadn't gone down this path but now it's far too late, I can't really manually maintain this amount of slop. I'm quite sad if this is going to be the end state of this profession. [c:50127426]

> （译文：我已经连续几个月做一个大约 1 千万行、几乎全 vibe-code 的项目。过程让人沮丧：
> * agent 只会在你指出的那一个位置修 bug，下次你会发现别处同样的 bug 又出现，又得重来一遍。这种事我自己写就能记得顺带检查别处。
> * 用户能看到的所有文本，现在还是一样笨，我得全部重写……
> * agent 对「人类觉得什么信息相关」是没有模型的……比如它不知道 $0 在人类语义里可以等于「null」（「这个商品免费」与「这个商品 0 美元」是两件事）。
> 我有点后悔走上了这条路，但现在已经太晚了，1 千万行代码我手动维护不了。如果这就是这行的归宿，挺让人难过的。）

72deluxe 的回应则是更冷的版本：

> I did this, but now I have a useful piece of software that I have zero clue regarding how it works. My only chance of "maintaining" it is giving it to another LLM to explain. [c:50125975]

> （译文：我是这么干的，结果现在我手上有个挺有用的软件，但完全不懂它怎么工作。要「维护」它，唯一的办法是把它交给另一个 LLM 让它给我讲一遍。）

也有正面例子。visarga 列了一套公式：

> For intent realignment I like to have the agent re-read all user messages posted in that project... Then use this fresh derivation of user intent to check code and tests. For long spans of work I prefer to generate a todo list which remains as a document in the project... So the formula is - review agents - tests - user message logs. [c:50124513]

但紧随其后的几个高赞回复几乎一边倒：「又是分享你那一套 agent 配置」「我对我自己做的梦都不感兴趣，对别人的 agent 配置更没兴趣」。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 反对：read ≠ search | status_quo69 [c:50124637] | 让 LLM 现生成切片解读，本质是「搜」不是「懂」，依然要靠 Claude 自己理解 Claude。 |
| 反对：理解能力整体外包 | jonahx [c:50125128] | 系统大到没人能 debug 是设计如此；哪天 Claude 自己定位不到，没有兜底。 |
| 反对：类比失当 | grey-area [c:50124578] | 拿工厂产线类比代码 review 是类别错配。 |
| 质疑：营销 vs 实操 | avinoth [c:50127080] | 无限 tokens + 自家模型才能这么干，缺这两样的小团队照抄必死。 |
| 质疑：财务可信度 | thatsabadlook [c:50127108] | 三个 9 边缘、沙箱搭不起来、盈利靠剔除条目，没资格当榜样。 |
| 经验：vibe coding 的代价 | zeroonetwothree [c:50127426] | 1 千万行的 vibe-code 项目无法手动维护，文本仍然笨拙。 |
| 经验：单纯维护都做不到 | 72deluxe [c:50125975] | 软件运行良好但作者完全不懂其内部结构，「维护」只能再交给 LLM。 |
| 中立：旧难题换新包装 | dmd [c:50126696] | 银行那种叠了 60 年的遗留代码也没人真懂过，这不是新问题。 |
| 中立：流程而非理解 | visarga [c:50124513] | 关键不是让人懂代码，是让 agent 持续 re-derive 用户意图 + 跑测试。 |
| 观察：人类工具位反转 | Terr_ [c:50124736] | 「Reverse centaur」—— 人变成计算机的工具。 |

## 总体情绪

整体情绪分裂得很利落。一端是「这是 Anthropic 在做软件工程的未来」的实操派，承认 40% revert 下降、78% 一轮 PR 就过这种数字不是凭空捏造；另一端是「vibe coding 终究要付学费」的工程派，集中在 Claude 自己 review Claude 的可持续性、依赖锁定、bug 在多个位置同时出现的维护灾难。

贯穿两端的暗流，是文章本身被 AI 写过的现实—— 这条本身并不致命，但叠加上文章鼓励的工作流，让人很难判断眼前的论证是经过人类编辑的判断，还是把 Claude 的高置信模板话放进了人脑里。

正如 Andrex 一句话的总结，最值得带走：

> Humans don't operate at AI speeds. We're making the car go from 0 to 5000 mph in 1 second and the drivers are turning to goo in the seat. [c:50123506]

> （译文：人类不在 AI 那个速度上工作。我们把车从 0 加速到 5000 mph，只用了 1 秒，而驾驶员在座椅上化成了泥。）

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | How the Claude Code team does code review | https://claude.dev/blog/solving-code-review-at-anthropic/ |
| 2 | HN discussion | https://news.ycombinator.com/item?id=50122951 |

## 免责声明

<div class="disclaimer">
本文为 Hacker News 讨论摘要，原始版权归原作者及 Hacker News 社区所有。
引文原文遵循原作者授权（CC-by-3.0 引文豁免）；中文译文部分基于原文意义译出，仅供阅读参考。

<br>
<br>
<em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
