---
layout: post
title: >-
  OpenAI 撤回 3 篇数学论文 — HN 讨论摘要
date: 2026-10-08
hn_id: 50003107
categories: [articles]
excerpt: >-
  OpenAI 数学团队一次性撤回 3 篇论文，原因是 Hodge 猜想方向上发现一处符号错误。但真正让 HN 炸锅的不是撤回本身，而是：错误是靠另一个 LLM 找出来的、300/719 的形式化进度意味着 4/5 顶级结果仍未验证、整套动作发生在 IPO 叙事窗口期之前。
tagline: >-
  OpenAI 用自家模型找出自家模型的错，再让数学家免费买单。
---

## 原文概要

OpenAI 在 10 月 7 日更新 `openai/math` 仓库的 `history.md`，宣布一次性撤回 3 篇数学论文。直接导火索是《Algebraicity of Weil classes on split abelian eightfolds》中的一处符号错误——它让该文赖以成立的 stabilization-trace 论证失效，进而牵连两篇依赖其结论的手稿（Kuga–Satake 对应与 K3 曲面有理 Hodge 猜想）。被撤回的 3 篇 README 链接到归档版本，并附有"缺陷说明"。

同一次更新里，OpenAI 还修复了 14 篇论文：Lipschitz heights 与 Ashkin–Teller currents 系列（4 篇）补充了 crossing、boundary-attachment、conditioning 与收敛性论证；Kähler 极小模型与 abundance 系列（6 篇）扩展了正性与收缩论证、澄清了作为输入的结果及其假设；Taming 与 hypersymplectic deformation 系列（2 篇）修正了锥等式声明并加入严格包含反例；Box Transport 一文修订了 torus-projection 与 common-clock 估计；BSD 公式一文删除了一处过时的引文。此外还有 13 篇随附论文被同步更新引用新版本。

文章页脚附了一组进度数字：6 篇新增形式化 + 5 项补充结果，使顶级结论的形式化比例升至 **300 / 719 = 约 42%**——意味着约 58% 的顶级结果仍处于"未形式化"状态。截至 HN 截图时，这条 278 分的讨论已积累 224 条评论。

## 讨论焦点

### 仓促上线、IPO 叙事与"故意不查错"

> "The bigger question is why there was internal pressure to rush such a historic launch without having someone in the company, anyone, check the proofs first.<p>This concerns the Hodge conjecture (millennium prize related) paper." — oliculipolicula [c:50004962]
>
> （译文：更大的问题是，为什么在如此历史性的发布中存在赶工压力，却没有公司内部的任何人对证明做过检查。这涉及霍奇猜想（与千禧年奖相关）的论文。）

评论者把矛头直接指向"赶工"。Hodge 猜想是克雷数学研究所公布的 7 个千禧年奖问题之一，单题奖金 100 万美元——被拿来当作"AI 攻克世纪难题"的标题素材。然而一篇基础符号错误就能让三条相互依赖的结论链同时崩盘，连带撤回。

> "Because people are finding errors using other LLMs. This implies that if they spent a minuscule fraction of the enormous pile of money they spend making this pile of slop they'd find the errors. They didn't want to find errors. They want to build hype for an IPO." — idiotsecant [c:50005353]
>
> （译文：因为人们现在用别的 LLM 找到了错误。这意味着只要花他们制造这一堆劣质品所用金钱中极小的一部分，就能发现错误。他们不想找错，他们想要为 IPO 制造声势。）

> "But they are the ones releasing an unverifiable (no model release) and massive and unchecked body of mathematics into the public while making exaggerated claims about its capabilities to replace human work. And they are the ones doing it in advance of a fractional sale of the company to the public." — svnt [c:50005955]
>
> （译文：但是，正是他们（OpenAI）在向公众发布一堆不可验证（模型未开源）、庞大且未经核查的数学成果，同时夸大其替代人类工作的能力。而他们这样做，恰好在把公司股权分批卖给公众之前。）

两条线索叠加起来就是节奏问题。模型权重未公开、证明细节以 Markdown 静态发布，验证方式只有重新跑一遍或人工核查；IPO 前的时间窗口天然适合"先占位、再修小错"的发布策略——反正发现问题是之后的事，市场已经消化完了"AI 突破千禧年难题"的叙事。

### 错误是另一个 LLM 找出来的，不是社区

> "Have you got a link to someone pointing it out? It looks like they're still going through formal proofs so likely found the problems that way." — viraptor [c:50004723]
>
> （译文：有人指出这个问题吗？看起来他们还在走形式化流程，可能是这样才发现问题的。）

> "Yes: https://x.com/ElliotGlazer/status/2108026240582246600" — sanxiyn [c:50004774]
>
> （译文：有的，链接在此。）

> "So someone ran a different LLM to find an issue they'd find anyway during formalisation? That's not the same as relying on thriving community." — viraptor [c:50004807]
>
> （译文：所以是有人跑了一个不同的 LLM 找到一个本来在形式化过程中也会被发现的错？这跟依赖活跃共同体不是一回事。）

最早的告警来自 X（原 Twitter）用户 Elliot Glazer，他用 OpenAI 自家的 Astra 跑了一遍被指控的三篇。讽刺之处在这里闭环：OpenAI 的数学成果用 OpenAI 的另一款产品找出了错。如果 Astra 没有这个能力，错误会留到 Lean 形式化阶段才发现——按 OpenAI 自己公布的数据，58% 的顶级结果还没轮到这一步。

> "I can throw Opus 5.5 at my code three times for code review and get three different sets of things it considers to be issues. I imagine all of them were checked with Astra at least once, but were they checked enough times?" — Hamuko [c:50005745]
>
> （译文：我让 Opus 5.5 跑代码审查三遍，每次列出来的"问题"都不一样。我猜这些论文至少被 Astra 查过一次，但他们查够次数了吗？）

另一条线则讨论 LLM 评审本身的可靠性。`dragonwriter` 指出 LLM 输出受随机种子与微小 prompt 差异影响，因此"用 Astra 找到了错"并不等价于"Astra 之前没跑过这篇"；`computerex` 反驳称现代基础模型通过多次自洽采样可平均掉扰动。这场小辩论的实质是：把"用 LLM 自查"作为质量门禁，本身就是有缝的证据链。

### 陶哲轩的担忧：共同体被自身工具淘汰

> "Without a thriving mathematical community to point out these things it would have stayed broken. With automated math that community as tao pointed out is at risk." — qoez [c:50004661]
>
> （译文：没有活跃的数学共同体，这些问题不会被发现，错误会继续埋着。陶哲轩说过，自动化的数学让这种共同体面临风险。）

Terence Tao（陶哲轩），2006 年菲尔兹奖得主、加州大学洛杉矶分校教授，几周前公开评论过 AI 在数学研究中的角色与风险（链接指向他在 Hacker News 上一次 ChatGPT 会话的讨论，ycombinator.com/item?id=49010345）。他的核心论点不是"AI 不能做数学"，而是当数学成果的生产端被自动化之后，对应的审核端也在萎缩——下一代数学家从哪来？

> "Based on what I've heard from my math friends in academia, every talented undergrad who was set on going to grad school for math has switched to something like consulting internships or fintech, even if they were really passionate about math, because they don't want to spend another 7 years or so just to wind up jobless." — viccis [c:50005950]
>
> （译文：据我从学术界数学圈朋友那里听来的情况，每个本来打算读数学研究生的优秀本科生都转去做咨询实习或金融科技了——即使他们对数学充满热情——因为不想再花 7 年时间最后换来一份失业。）

> "> AI obliterating your field of study was most definitely not considered a risk with majoring in math 10 years ago." — viccis [c:50006299]
>
> （译文：10 年前，"AI 把你的专业彻底干趴"绝不会被列入读数学的风险清单。）

反驳者 `done_lurking` 提出读数学一直就有极高的机会成本——这话成立，但 viccis 的回应点中了关键差异：以前是高机会成本，现在是"毕业即失业"，量级不一样。共同体萎缩是个负反馈循环：人少 → 同行评审效率下降 → 已发表成果更难被验证 → 学科吸引力进一步下降。

### "反向半人马"：让数学家免费当质检员

> "A little sad if that's the future of math. It kind of reminds me of when tech giants open source a project as a means of putting a positive spin on abandonware. 'Here's the source! Any problems are yours to fix now. You're welcome'" — afavour [c:50004803]
>
> （译文：如果这就是数学的未来，有点可悲。这让我想起科技公司开源项目的做法——给遗留项目披上"开放"的外衣。"源码给你了！任何问题你自己修，多谢捧场"。）

> "We are all reverse centaurs now." — rubyfan [c:50004969]
>
> （译文：我们如今都是反向半人马。）

> "OpenAI isn't paying mathematicians to verify all these papers. It's dumping the papers trying to nerd snipe them into checking it for free." — _aavaa_ [c:50005071]
>
> （译文：OpenAI 没付钱让数学家核查这些论文。它是把论文甩出去，想"书呆子陷阱"式地引诱数学家免费检查。）

"反向半人马"是这场讨论里最具传播力的造词。原版 "centaur"（半人马棋手）出自 1997 年 Garry Kasparov 对人机协作棋手的描述——人脑做战略，AI 做战术；"反向"则是 AI 出活、人审核。`afavour` 的弃坑开源比喻更尖锐：PR 风险被转嫁给社区，错误成本被分散到全球数学家的业余时间里。

### 讽刺底色：宣布过时之后又来求助

> "OpenAI: 'Here are the answers to every math problem. Now mathematicians are obsolete. Just send the prize money and prestige to Sam Altman. BTW gonna need some mathematicians to check these answers.'" — RunSet [c:50006388]
>
> （译文：OpenAI："这是所有数学问题的答案。数学家现在过时了。把奖金和荣誉寄给 Sam Altman。顺便一提——还得麻烦数学家核查一下这些答案。）

这条评论被点了很多赞。它用一句话把整件事的核心悖论摆出来——"过时"的宣告本身就需要被过时的人来背书。

### 不止数学：初级岗位的管线正在塌

> "This is not a problem unique to the mathematical community.<p>What about software developer community? AI has eliminated the need for junior software engineers. Almost no one is hiring junior software engineers. But companies still need senior software engineers. Without junior engineers how will there be senior software engineers in the future?<p>What is the solution? I don't think the solution is to say AI progress in software, mathematics etc. should be halted." — flowerlad [c:50006289]
>
> （译文：这并非数学共同体独有的问题。软件开发者社区呢？AI 已经消灭了对初级软件工程师的需求。几乎没人招初级了，但公司仍然需要高级工程师。没有初级，将来哪来高级？<p>解法是什么？我觉得不能说"那就把 AI 在软件、数学等领域的发展停掉吧"。）

> "Those abstractions are deterministic. LLMs are not." — thayne [c:50006524]
>
> （译文：那些抽象层是确定性的，LLM 不是。）

讨论自然外溢到软件行业。编程语言从汇编到高级语言的抽象化是确定性的——编译器把同样的源码编译成同样的机器码，每个抽象层都建立在前一层之上、能被验证；LLM 不具备这种性质，所以"高级抽象替代初级"这条路径在数学里更不可控。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 撤回是好事 | malux85 | 撤回本来就是科学循环的一部分（假设、声明、测试、反驳、撤回）。 |
| 撤回 = 没内部审 | oliculipolicula | 千禧年奖级论文赶工发布，却无内部任何人查证明。 |
| 是 IPO 营销 | idiotsecant | 不想找错，只想要为 IPO 制造声势。 |
| 数学共同体不能省 | qoez | 没共同体就没人挑错，陶哲轩已警告。 |
| 共同体在被自身淘汰 | viccis | 优秀本科生正大批转行读数学的研究生院。 |
| AI 评审不可靠 | dragonwriter | 随机种子和小 prompt 差异会让 LLM 漏掉错。 |
| AI 评审可补救 | computerex | 现代基础模型多次自洽采样能平均掉扰动。 |
| 数学家被甩锅 | _aavaa_ | OpenAI 把审稿甩给数学家，靠 nerd snipe 让他们免费干。 |
| 不止是数学问题 | flowerlad | 初级软件工程师岗位已经消失，管线塌方。 |
| 别停 AI 发展 | flowerlad | 倒退不是答案，需要找到新的人机分工方式。 |

## 总体情绪

讨论分叉成两股力量，**但没有真正乐观的声音**。一派站在"撤回是好事"这一边：科学循环本来就有撤稿机制，OpenAI 主动承认错误并修正反而是健康的；但几乎每个持这种观点的评论者都会在下一句加一个"但是"——但是撤回比例是被动发现、主动发生的；错误是外部 LLM 找出来的而非内部审稿机制；形式化覆盖率仍只有 42%。

另一派在担忧更长远的事：**数学共同体的再生能力**。当顶尖本科生的职业预期从"数学教授"变成"被 AI 替代的求职者"，从"读数学"切换到"读金融工程/咨询"，管线塌方比论文撤稿更难修补。HN 上反复出现的两个名词——陶哲轩的共同体论、`rubyfan` 的"反向半人马"——指向同一个判断：工具可以替代产出，但替代不了共同体。

讨论结束时的语气是带着刺的冷静——没有人骂 OpenAI，但几乎所有人都在等 OpenAI 给出比"我们撤回了"更深一层的解释。如果下一次发布前 OpenAI 内部跑一遍 Lean 验证、公开验证脚本与门槛标准、让陶哲轩或同等级别的数学家署一份外部审稿声明，这场讨论的攻守形势会立刻翻转。在那之前，"IPO 前抢占叙事"是最经济的解释。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | OpenAI Withdraws 3 Math Papers | <https://news.ycombinator.com/item?id=50003107> |
| 2 | history.md (撤回与修复明细) | <https://github.com/openai/math/blob/main/history.md> |

<div class="disclaimer">

本文由 AI 自动整理自 Hacker News 公开讨论。引文为评论者个人观点，与原帖作者立场一致不代表本文立场。所有评论 ID 均可在 HN 原帖中追溯。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
