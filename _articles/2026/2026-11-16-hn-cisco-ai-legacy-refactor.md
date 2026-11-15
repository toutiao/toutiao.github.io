---
layout: post
title: >-
  Cisco 让 27 岁工程师用无限 AI token 重写 98% 遗留代码 — HN 讨论摘要
date: 2026-11-16
hn_id: 50304122
categories: [articles]
excerpt: >-
  Cisco 总裁把不限量的 AI token 交给一个 27 岁、埋在组织第五层的前创业者，
  目标是 24 个月重写 98% 遗留代码。387 条评论里最先被问住的不是能不能写出来，
  而是文章从头到尾没写过为什么要重写。
tagline: >-
  token 不限量，理由没人问：文章里从没交代 98% 为什么值得重写。
---

> 来源：HN 讨论主帖 [Cisco gives engineer unlimited AI tokens to rewrite legacy code](https://news.ycombinator.com/item?id=50304122)（318 分，抓取时点 387 条评论），指向 Fortune 报道 [Cisco is letting a 27-year-old refactor 98% of its legacy code with unlimited AI tokens: 'Go nuts'](https://fortune.com/2026/10/30/cisco-president-jeetu-patel-gen-z-27-year-old-unlimited-ai-tokens-rewrite-legacy-code-entry-level-jobs/)（2026-10-30，作者 Orianna Rosa Royle）。本篇为 single post 模式。主帖发布于 2026-10-30 14:08 UTC，归档入库 115 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。归档文章正文为 Fortune 页面前 8000 字符，本次补抓全文核对，抓取结果与归档一致（原页抓取上限 8000 字符，止于 Josh Kushner 段落中途）。2026-11-14 该帖新增一条评论，是本次回热的来源。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

2026 年 10 月 30 日，Fortune 刊出一篇报道：网络设备巨头 Cisco 的总裁兼首席产品官 Jeetu Patel，把公司最好的一份工作交给了一个 27 岁的人。Padmanabhan Krishnamurthy，昵称 "Paddy"，2023 年联合创办实时语音翻译创业公司 EzDubs，2025 年 Cisco 收购 EzDubs 后他随之加入。按 Patel 的说法，这个人原本"被埋在组织里做不战略的事"——在组织图上位于 Patel 下方五层。Patel 说，连他团队里最拥抱 AI 的人都没往这个方向想。

给的是不限量的 AI token，原话很直接："I've given him unlimited tokens because he's going to refactor code. So I'm like, you can go, you can go nuts."（我给他无限 token 是因为他要重构代码，所以，去吧，敞开了干。）Krishnamurthy 的判断是自己能靠一个两人小团队重写 Cisco 的遗留代码，Patel 给了他四周时间验证，最终目标是 24 个月内重写 Cisco 98% 的遗留代码。

Patel 的管理哲学是报道的另一半。他反对 Gen Z 只配做数据录入，理由是资深员工能想出新点子，但提不出只有零经验的人才会问的问题；他说自己把每个实习生都当"反向导师"，还跑到各大学找"hungry"的学生。他举的例子是一位拿到 Stanford 奖学金的 17、18 岁学生 Baya：别人都在抢着提问，她站到一边听，等所有人问完才开口；Patel 让她每月给自己发邮件汇报学到的 AI 知识，那是一次测试——"Everyone can go out and have one good conversation. But are they going to stick with their commitments?"（谁都能出去聊一次好的，但能不能坚持承诺是另一回事。）她一次没漏，后来在 Cisco 拿到实习，重做了一个资深员工没能啃下来的东西。对这套做法，Patel 的总结是："Tension is good."（有张力是好事。）报道里还提到 OpenAI 投资人 Josh Kushner 明确偏好招工龄少于四年的人，以及"40% 的雇主打算减少校招"这项调查。文中把 Cisco 的体量写成 4290 亿美元。

HN 上这条帖子拿到 318 分、387 条评论（归档入库 115 条），并在 11 月 14 日又冒出一条新评论，因此被热度引擎标成"回热"。讨论分成几条清晰的线：文章里根本没交代重写的目标；AI 是否把"重写不划算"这笔旧账算反了；AI 会不会把几十年的老 bug 当成规范照抄；Cisco 这家公司的口碑旧账；以及这到底是一篇 PR 稿，还是一次押注人才。

## 讨论焦点

### 一、最先被问住的那句：为什么要重写

评论区冒出来的头两句话，都指向同一处空白——目标。

> "There&#x27;s no goal mentioned in this article as why 98% of the code needs rewriting." — williadc [c:50304827]
> （译文：文章里根本没提到重写这 98% 的代码是为了什么。）

> "Rewrite it in service of… what exactly?" — alwa [c:50304910]
> （译文：为了什么才重写？究竟是为了什么？）

接着有人把重写这件事的经典风险完整讲了一遍。

> "Yeah - code rewrites are generally a thing to be avoided since the requirements of older production code is typically not fully documented, even if it originally had been. Production code accumulates bug fixes, performance tweaks, special cases, additional requirements, etc, with documentation and test suites not always being updated in sync.<p>Your rewritten codebase will presumably look much cleaner and more maintainable that what it&#x27;s aiming to replace, but it&#x27;s easy to miss the purpose&#x2F;necessity of all of the old &quot;cruft&quot; which need not be just poor coding but rather later enhancements not anticipated by the original design whose implementation was therefore crufty.<p>Does anyone here work at Cisco, and have any insight as to why a rewrite is considered necessary and might be expected to succeed?" — HarHarVeryFunny [c:50304948]
> （译文：是啊——重写代码通常是应该避免的事，因为老生产代码的需求通常没有完整记录过，即便当初有记录过。生产代码会不断积累 bug 修复、性能调优、特殊情况、额外需求，而文档和测试套件并不总能同步更新。<p>你重写出来的代码库大概会比它要替换的东西更干净、更易维护，但很容易漏掉那些老"沉淀"的用意——那未必只是糟糕的编码，而是原始设计没预料到的后续增强，正因如此实现方式才显得很糙。<p>这里有人在 Cisco 工作吗？能否说明为什么重写被认为是必要的，又凭什么预期它会成功？）

一条更实际的顾虑是：重写的第一份账单，是给一个正在稳定运行的东西制造 bug。

> "The problem with rewrites are that even if the rewrites are ultimately good it will tend to first create bugs on an existing thing that are presently churning in a stable state." — Aperocky [c:50305224]
> （译文：重写的问题在于，即便重写的结果最终是好的，它也往往会先在一个目前正稳定运行的东西上制造出 bug。）

而最要命的问题不是技术，是知识。

> "Does this one engineer have the domain knowledge to know WHY the old code was written the way it was, and what the graybeards would have done differently if they could start again now?<p>Otherwise he&#x27;s just going to replicate all the legacy bugs and questionable design decisions." — Taikonerd [c:50305003]
> （译文：这一个工程师有没有那种领域知识，能知道老代码当初为什么那么写，以及老手们若能从头再来会怎么做不同的选择？<p>否则他只会把遗留的 bug 和那些可疑的设计决策原样复制一遍。）

### 二、AI 把"重写不划算"这笔旧账算反了

另一派人认为 AI 真正改变的不是能力，是成本结构，重写第一次从"默认不做"变成了"值得一问"。

> "A rewrite is a slam dunk for any decent frontier AI. It has a penchant for maintaining API&#x2F;etc contracts to a fault in the absence of instructions to the contrary. It can easily validate its work and loves building exhaustive test cases. You can tell it to get 100% code coverage if you want. It will laborously accurate document every accumulated edge case and help you find a better overall cohesive structure.<p>A rewrite has historically been a huge mistake in many situations, some of which I&#x27;ve personally had the agony of witnessing firsthand, powerless to stop it. But AI completely changes the calculus because it doesn&#x27;t waste significant developer time or energy crawling back to the previous working state, it just does it while you go get coffee. And this I&#x27;ve found to be a huge benefit, that I can continue making my codebases nicer to work with and better documented&#x2F;integrated with bugs stamped out for free. There are upsides to a rewrite, and they&#x27;re now much more likely to be worth it as the downsides are automated away." — jimmaswell [c:50312131]
> （译文：对任何像样的前沿 AI 来说，重写都是稳赢的场面。在没有相反指示时，它有一种近乎死板地维持 API 等契约的倾向。它很容易自我验证，还热衷于构建穷尽式的测试用例。你想要 100% 代码覆盖率都行，它会辛辛苦苦地把每一个积累下来的边界情况都准确记录下来，并帮你找出更整体的、更连贯的结构。<p>重写在历史上很多场合都是巨大的错误，有些我本人还眼睁睁见过、无力阻止。但 AI 完全改变了这笔账，因为它不会把开发者的时间和精力浪费在爬回上一个可用状态上——它在你去喝杯咖啡的时候就把活干了。而这正是我看到的一大好处：我可以顺手把自己的代码库修得更顺手、文档写得更清楚，顺带把 bug 顺手消掉。重写有它的好处，而现在这些劣势被自动化掉了，它也就更可能值得做。）

有人把这当成一次亲身证伪的旧经验。

> "While I certainly don&#x27;t work at Cisco, I&#x27;ve come to the conclusion that I need to re-examine my priors when it comes to code rewrites and general maintainability.<p>AI makes these projects significantly more feasible, at least in my domain. We have some critical-path software I wouldn&#x27;t touch with such an approach, but the vast majority of our code is internal and&#x2F;or supporting tooling.<p>For those cases, burning it down and rewriting via AI tooling has proven far more productive than anything we have attempted in the past. This is for old technical debt laden stuff everyone has been afraid to touch for well over a decade.<p>It&#x27;s not perfect, but it moves the needle where before a lot of such projects were stuck on the backburner for years.<p>It certainly introduces new bugs and such, but at least this way forward momentum is happening vs. just being stuck in decision&#x2F;analysis paralysis forever.<p>This also assumes some very senior SME folks are driving the process. I would not expect similar results with junior or even mid-level folks in these specific domains." — phil21 [c:50312231]
> （译文：我当然不在 Cisco 工作，但我已经得出结论：在代码重写和可维护性这件事上，我得重新审视自己的先验。<p>至少在我的领域里，AI 让这类项目变得可行得多。有些关键路径上的软件我不会用这种方式碰，但绝大部分代码是内部的，或是支撑性的工具。<p>对那些代码，用 AI 工具链烧掉重写，被证明比我们过去尝试过的任何做法都高效得多。那是些背了十几年技术债、谁都不敢碰的东西。<p>它不完美，但它能推动事情往前走，而过去很多这类项目一放就是好几年。<p>它当然也会带来新 bug 之类的东西，但至少前进的势头出现了，而不是永远卡在决策与分析瘫痪里。<p>前提是这件事由非常资深的领域专家推动；在这些特定领域里，我不指望初级甚至中级的人能拿到类似结果。）

把这件事讲成机会成本变化的，也不少。

> "One of the reasons to avoid rewriting has long been that the time spent rewriting code that works is time not spent writing code to meet new business needs. In other words, it&#x27;s usually a huge opportunity cost, rarely balanced out by sufficient gains to be net positive.<p>I do think AI does challenge this prior, as the time needed to do a rewrite shrinks dramatically. It&#x27;s not zero, of course, but it now becomes worth asking if it&#x27;s worth doing, rather than defaulting to avoiding rewrites in nearly all cases." — anyonecancode [c:50312317]
> （译文：长期以来人们避免重写的一个理由是，花在重写能跑的代码上的时间，就是没花在满足新业务需求上的时间。换句话说，这通常是巨大的机会成本，很少能被足够的收益抵消到净正。<p>我确实认为 AI 挑战了这个先验，因为做一次重写所需的时间大幅缩水。当然不是零，但现在值得问的是"这么做值不值"，而不再是几乎一律默认不重写。）

还有人认为这压根不是新观念，只是旧观念没跟上。

> "Not necessarily, a rewrite can just move to a language that&#x27;s easier to maintain (off C &#x2F; cobol).<p>Honestly though, it&#x27;s pretty clear the AI rewrites work, we have a ton of high profile examples. It&#x27;s just a holdover attitude about rewrites from before AI. In reality, AI is going to make the code better when it rewrites" — habitue [c:50312356]
> （译文：未必，重写也可以只是换到一种更容易维护的语言（离开 C / cobol）。<p>不过说实话，AI 重写能成，这很清楚，我们有一大堆高知名度的例子。这只是 AI 之前时代对重写的那种残留态度。现实是，AI 重写的时候会让代码变好。）

### 三、AI 的盲区：它会把老 bug 当规范抄下来

支持方的乐观建立在"AI 有耐心、上下文够大"上，反方的反驳是：耐心和上下文恰恰解决不了"哪些行为是故意的"这个问题。

> "Each line of new code they write is compared against <i>every</i> relevant line of code in the original, which they treat as a spec.<p>My main issue in my experience is that that AIs tended to reproduce the legacy behaviour &quot;bug for bug&quot;, which was not my intention." — jiggawatts [c:50312224]
> （译文：它们写的每一行新代码，都会跟原代码里<i>每一行</i>相关代码做比对，并把原代码当作规格。<p>以我的经验，我主要的问题是 AI 往往会连老行为的 bug 都"逐个照抄"，而那并不是我的本意。）

> "The older the code, the bigger the issues with baked-in assumptions about transactions, stateful sessions, data types, string formats, etc.<p>This trips up AIs just as much as humans. You can&#x27;t trivially maintain backwards compatibility <i>and</i> modernise the codebase! Those are conflicting goals, no matter what." — jiggawatts [c:50312224]
> （译文：代码越老，关于事务、有状态会话、数据类型、字符串格式之类的隐含假设问题就越大。<p>这些坑绊倒 AI 的程度和绊倒人一样。你不可能既轻松地保持向后兼容，<i>又</i>把代码库现代化！这是两个互相冲突的目标，无论如何都是。）

问题被概括成一句话。

> "An LLM doesn&#x27;t have enough context to know what you so and don&#x27;t want. If you give it call logs for every function that was called and how, maybe, but a seasoned engineer will have more context around what the company needs." — stavros [c:50312278]
> （译文：LLM 没有足够的上下文去知道你要什么、不要什么。就算你把每个函数被怎么调用、调用路径如何的日志都喂给它，也许有点用，但一个资深工程师对公司真正需要什么，会有更多上下文。）

被直接点名反驳"AI 会维护好契约"的乐观派，也说了同一件事。

> "AI has no magic powers to figure out what the “API&#x2F;etc contracts” are in a nasty old codebase.  This problem is fundamentally hard and not always well defined." — amluto [c:50313100]
> （译文：AI 没有魔法，能搞清楚一个糟糕的老代码库里的"API 等契约"到底是什么。这个问题本身就很难，而且未必有清晰定义。）

> "But ancient code like in the article is probably an enormous buggy mess full of accidental behaviors and implementing protocols in ways that do not fully match the spec. Some, but not all, of the mismatches will be cases where the spec is wrong. Sure, an AI can probably generate a new implementation with a similar set of bugs, but is this what is actually wanted?" — amluto [c:50313100]
> （译文：但像报道里那种老代码，很可能是一大坨塞满意外行为的 bug 巢穴，协议实现方式也跟规格不完全对得上。不匹配的地方里有一些（但不是全部）是规格本身错了。当然 AI 大概能生成一份带着类似 bug 集合的新实现，但那是真正想要的吗？）

这里还牵出一个工程上最麻烦的活：把老 bug 当成"特性"搬过去。

> "Defining the legacy bugs and porting them as features during the rewrite is actually one of the most difficult parts of enterprise rewrites.<p>You don&#x27;t get to pick what parts of the API you&#x27;re porting during something like that, it has to work the same or some of the ecosystem around it will break." — literalAardvark [c:50312530]
> （译文：把遗留 bug 定义清楚、再在重写时当作特性搬过去，其实是企业级重写里最难的部分之一。<p>这种事上你没法挑着搬 API 的哪一部分，它必须照原样工作，否则周围的一部分生态就会崩。）

在实操层面，给出的方案是双模型互查。

> "What works for me is that I do have a different model (if possible) to review and check against the diff vs the original ask&#x2F;requirement. Because a rewrite will just cleanup the code even if something look &#x27;not right&#x27; but it is actually on purpose due to the requirement, so the second model is the one that can check and catch." — quantbuilder [c:50313442]
> （译文：对我有效的做法是，尽量换一个不同的模型来 review，并拿 diff 去对照最初的需求。因为重写会把代码清理干净，哪怕某些东西看着"不对劲"，但其实是需求本身有意为之——这时候能看出来、能抓住的是第二个模型。）

也有完全相反的判断：AI 更适合改而不是写。

> "I&#x27;d even argue AI is better for maintaining&#x2F;moderninzing existing code than writing it, just because there is so much less input from developer about architecture it requires, as it has it in the code itself.<p>But there is pretty big risk of false positives and negatives; some &quot;bugs&quot; <i>are</i>  design decisions that were not documented well&#x2F;at all, and inevitably some new ones will appear when it reasoned something wrong." — InsidiousWombat [c:50312627]
> （译文：我甚至会说，AI 用于维护/改进已有代码，比用它写代码更合适，因为架构信息它能从代码本身拿到，对开发者的输入要求低得多。<p>但误报和漏报的风险相当大；有些"bug"<i>就是</i>没被好好记录的设计决策，而它推理错的时候，也必然会冒出新问题。）

至于回归测试，一位老手认为 AI 最该干的其实是解释代码库。

> "Regression tests?<p>I think people are assuming the worst but AIs most helpful contribution beyond churning out code is explaining the code base.<p>Who knows if they will do a good or bad job that&#x27;s down to the engineers and not the tools imo." — rustyhancock [c:50305040]
> （译文：回归测试？<p>我觉得大家是往最坏处想了，但 AI 除了批量产出代码之外，最有用的贡献其实是把代码库讲明白。<p>至于他们最后干得好不好，我觉得这取决于工程师，而不是工具。）

关于测试本身，有一条带论文的补充：LLM 写测试很强，但判断哪些测试有效就弱多了，而且会把老 bug 编码成测试要求。

> "I think this is actually the opposite in practice. LLMs generate better tests than they are at assessing which tests are effective (and, inferentially, how a system should behave)." — paimapi [c:50306713]
> （译文：我觉得实践上恰恰相反。LLM 生成测试的能力，强于它评估哪些测试有效的能力（以及由此推断出的、对系统应当如何表现的判断力）。）

最后是老硬件从业者的底线：AI 至少不会比现在更差。

> "As much as I dislike AI, having worked on Cisco gear for years, I can&#x27;t imagine AI can put out a <i>worse</i> product. If the re-write is full of bugs and security holes and static SSH keys, then it has not changed at all." — Refreeze5224 [c:50304936]
> （译文：尽管我讨厌 AI，但跟 Cisco 设备打了多年交道，我无法想象 AI 能做出一个<i>更差</i>的产品。如果重写出来的代码满是 bug、安全漏洞和写死在里面的 SSH key，那也就等于什么都没变。）

### 四、Cisco 的旧账：当年到底好在哪

重写理由说不清，讨论就自然滑向另一条线：为什么大家都觉得 Cisco 的代码烂成这样。老工程师们给出了两边都站得住的理由。

先说 IOS 当年的立身之本——纯文本配置。

> "…As someone who worked Cisco gear over thirty years I still remember why us networking did want cisco instead of many other brand devices and it hadn&#x27;t anything to do with marketing and sales people did.<p>The Cisco IOS text based configuration was in early days of internet which made it so popular.<p>Many other manufacturers like HP, 3Com, Cabletron, Madge (IBM), Bridge, etc. did not get why we wanted and complained “give us textual configuration format like IOS has”.<p>With a plain text based configuration it was easy to adapt configuration from one model to have ready made templates for each model, upgrades and migration to new models were easier, you could use version controls (rcs,cvs, svn,... long before git) and then when RANCiD came it was easy to automate config backups, revert and rollback changes, pass audit with human readable configs and what was in production even long time after etc. In short text based configs made it possible to build large network scale configurations management tools." — mesrik [c:50314137]
> （译文：……作为一个用了 Cisco 设备三十多年的人，我还记得我们网络圈当初为什么非要 Cisco 而不是别家设备，这跟营销和销售一点关系都没有。<p>Cisco IOS 的纯文本配置出现在互联网早期，这正是它流行的原因。<p>HP、3Com、Cabletron、Madge（IBM）、Bridge 等很多厂商当时不理解我们为什么要这个，还抱怨"给我们一个像 IOS 那样的文本配置格式"。<p>有了纯文本配置，把配置从一个型号适配到另一个型号、做成现成模板就很容易，升级和迁移到新型号也更容易；你还可以用版本控制（rcs、cvs、svn……那还远早于 git），后来有了 RANCiD，配置备份、回滚、审计全都容易了，人能读懂的配置也让"生产环境当时到底是什么"长期可查。简而言之，文本配置让大规模配置管理工具成为可能。）

而在 Junos 那一代，这条优势已经被拿走了。

> "Working on Cisco always just felt like going back to the 18th century, I mean the whole candidate and active config thing alone in Junos was insanely valuable:" — traceroute66 [c:50315065]
> （译文：用 Cisco 永远感觉像是回到 18 世纪，我是说，单是 Junos 里 candidate 配置和 active 配置这一套，就值钱到离谱：）

> "Meanwhile, back in 18th century iOS land, a fat finger on the ACL would leave you with a bad day in the office until you rebooted the box via OOB." — traceroute66 [c:50315065]
> （译文：与此同时，在 18 世纪的 iOS 地盘上，ACL 上手滑打错一个字符，就够你在办公室难受一整天——直到通过带外口把设备重启。）

至于为什么今天的 Cisco 代码会烂成这样，评论者讲得更直接。

> "It’s been a while, but configuring their hardware manually in 2016 was bug ridden ridiculousness. Awful UI&#x2F;UX. Their own techs had specific field notebooks for our make and firmware version that we couldn’t access unless persuaded, detailing various land mines to avoid while working. Literal “don’t click these things in this order” kinds of notes.<p>A critical security firmware update once brought down redundant pair of firewalls we used because the bug didn’t manifest until a counter buffer overflowed months after application. Three hours into the outage the tech power cycles the thing and our services came back to life.<p>Cisco is only doing this because some other alternative is more expensive. They had more than a decade to get started." — schainks [c:50312963]
> （译文：那是多年前的事了，但 2016 年手工配置他们的设备仍是一团 bug -ridden 的荒唐事。UI/UX 糟糕透顶。他们自己的技术支持人员有针对我们那个型号和固件版本的专门现场笔记本，我们不软磨硬泡根本拿不到，里面写满了要避开的地雷，字面意义上的"千万别按这个顺序点"。<p>有一次关键的安全固件更新把我们用的那对冗余防火墙直接搞挂了，因为那个 bug 要几个月后计数器缓冲溢出才显形。故障三小时后，技术人员把设备断电重启，服务才活过来。<p>Cisco 会这么干，只是因为别的替代方案更贵。他们有十多年时间本该开始改。）

而最近的一次大规模"变砖"，跟 AI 无关。

> "They didn&#x27;t even need the AI to make thousands of hot bricks nationwide. Here&#x27;s just one of the latest hits..." — kotaKat [c:50307059]
> （译文：他们甚至不需要 AI 就能造出全国范围内成千上万台变砖的设备。这是最近的一个例子……）

这位评论者随后贴出的是 Cisco 自己的现场通知：部分 AP 固件会耗尽 flash 空间导致无法升级，恢复办法要么逐台工厂重置，要么逐台进 bootloader 敲秘密应答刷回恢复镜像。

关于"当年到底好在哪"，还有更不客气的说法。

> "It doesn&#x27;t, but Cisco <i>was</i> great and they&#x27;ve just evolved into a laughing stock. Their stuff is really bad these days.<p>And they&#x27;ve overstretched their product line to too many things, trying to be the &quot;be all&quot; company. Fortinet is making the same mistake, but they&#x27;re earlier in that process.<p>I mean, it&#x27;s not really a mistake on their parts, their primary goal is to get rich and they are succeeding.<p>Citation: I&#x27;ve been working with Cisco technologies since the mid-1990s. At my current job, we are a few weeks away from phasing out the last of our Cisco junk. And since people will ask: to Juniper&#x2F;Mist and Arista." — runjake [c:50307238]
> （译文：倒不是，但 Cisco <i>曾经</i>很出色，他们只是演变成了一个笑柄。这些年他们的东西真的很糟。<p>而且他们把产品线拉得太宽，什么都想做，试图当一家"什么都是"的公司。Fortinet 正在犯同样的错，只是他们还早一些。<p>但这其实也不能全算他们的错，他们的主要目标就是赚钱，而且他们成功了。<p>证据：我从 90 年代中期起就在用 Cisco 的技术，在我现在这份工作里，我们再过几周就要把最后一批 Cisco 的破烂替换掉。既然肯定会有人问：换成 Juniper/Mist 和 Arista。）

> "It&#x27;s sad to hear how Cisco has fallen. I remember working on some early ISP networks in the 90&#x27;s. Cisco was everywhere!" — icedchai [c:50305645]
> （译文：听到 Cisco 变成这样挺让人难过的。我记得 90 年代在几家早期 ISP 网络里干过活，Cisco 无处不在！）

被点名批评的，还有近二十年的新产品质量和 Smart Licensing。

> "Back then they only really did routing and switching, and those are still the only things that Cisco kind-of does well.<p>Almost every new product of theirs I’ve touched in the last 20 years has been trash, and even the R&amp;S golden goose is being dragged in that direction with customer-hostile functionality like Smart Licensing and a general decline in quality." — bigfatkitten [c:50312482]
> （译文：那会儿他们真正做的只有路由和交换，而这两样到现在也还是 Cisco 唯一算是做得好的东西。<p>过去 20 年里我接触过的他们几乎每一款新产品都是垃圾，连 R&S 这只下金蛋的鹅，也被 Smart Licensing 这种对客户不友好的功能和整体质量下滑拖进了同一条道。）

最后，有人从部署现场给出了一句挺具体的期待。

> "Because it&#x27;s Cisco?<p>We had to turn off a bunch of on-by-default features in the system I&#x27;m deploying now because IOS matches too aggressively and decides that arbitrary UDP datagrams are DHCP requests or PTP packets that need rewriting (and then dropping when they turn out to not be DHCP&#x2F;PTP).  I have to think that an AI rewrite with a today-good model would recognize the lax checks and do them better." — entrope [c:50311440]
> （译文：那还能为什么？就是 Cisco 而已。<p>我们现在部署的这套系统里，有一堆默认开启的功能不得不关掉，因为 IOS 的匹配太过激进——它会把任意 UDP 报文判定成 DHCP 请求或 PTP 包，然后去改写（发现并不是 DHCP/PTP 之后又给丢掉）。我得想，用今天够好的模型做一次重写，至少能认出这些宽松的检查，并处理得更好。）

### 五、这是 PR 稿，还是一次押注人才

关于这篇报道本身，怀疑者的意见毫不客气。

> "It does sound strange, like it was written by PR people. Tools are good but usually it is more subtle than asking one guy to rewrite everything. And of course any code written yesterday is legacy but it does not mean it should be rewritten." — koskokos [c:50305188]
> （译文：听上去确实很奇怪，像是 PR 部门写的东西。工具是好工具，但通常事情比"让一个人重写一切"要微妙得多。而且，昨天的任何代码都是遗留代码，但这不意味着它就该被重写。）

> "Is this like a PR piece for the guy? It&#x27;s odd to see him singled out in a piece that would be normally be about the company, the CEO or the decision itself." — piker [c:50305010]
> （译文：这算是给这个人的一篇 PR 稿吗？通常这种文章会写公司、写 CEO 或者写这个决定本身，把他单独拎出来挺怪的。）

至于他怎么被发现的，评论区有人替文章补了一行没写的注脚。

> "You forgot to mention the translation company he helped found was also acquired by this same CEO. :))" — sleepyguy [c:50311927]
> （译文：你忘了他参与创办的那家翻译公司，也是被同一位 CEO 收购的。:))）

质疑者的判断里还夹着一层人事上的警惕。

> "Looks like his startup was some kind of translation service. So yeah he is totally qualified. It&#x27;s a miracle how Jeetu Patel was able to find Padmanabhan Krishnamurthy or even know that he was under employed languishing somewhere in the bowels of CISCO. I wonder if they know each other from India?" — sleepyguy [c:50305249]
> （译文：看他的创业公司像是某种翻译服务。所以他完全够格。Jeetu Patel 能找到 Padmanabhan Krishnamurthy，甚至知道他在 Cisco 组织深处闲着不被重用，简直是个奇迹。我不禁想，他们是不是在印度就认识？）

（注：原文最后一句的 "I wonder if they know each other from India?" 是这条评论的猜测，评论区并未证实其与岗位安排存在关联。）

但资格问题被更实在地提了出来：翻译创业公司的创始人，凭什么去重写网络设备的基础设施代码。

> "His startup was acquired by Cisco so not weird for Cisco&#x27;s CPO to know the startup&#x27;s founder&#x2F;CEO. That said, not sure how knowledge on speech translation means he&#x27;s <i>totally qualified</i> on rewriting infra&#x2F;networking&#x2F;cybersecurity (Cisco&#x27;s primary fields of operation) code. Unless the legacy code expected to be rewritten is constrained on related services&#x2F;solutions, e.g. CVP or&#x2F;and WebEx." — forgotpwd16 [c:50311446]
> （译文：他的创业公司被 Cisco 收购了，所以 Cisco 的 CPO 认识这位创始人/CEO 并不奇怪。但我不太确定，做语音翻译的经验怎么就意味着他在重写 Cisco 主业范围内的基础设施/网络/安全代码时<i>完全够格</i>。除非要重写的遗留代码其实局限在相关服务/解决方案上，比如 CVP 或者 WebEx。）

最重的一句评价出现在讨论早期。

> "So there&#x27;s a real risk that Cisco might become history in just a few years. Taking that kind of risk with a rather unproven technology has to be psychosis. Or is that kind of belief a form of Religion?" — classified [c:50304993]
> （译文：所以 Cisco 真有可能在几年内就成为历史。用一个相当未经证实的技术去冒这种险，那一定是疯狂。或者说，这种信念算是一种宗教？）

而在工程可行性上，有人给的时间表比 24 个月更悲观。

> "You don’t have very good imagination then.  Cisco code is such a mess that there’s basically 0 chance he can even make a harness in 24 months, much less rewrite production code." — tw04 [c:50311389]
> （译文：那你的想象力可真不够。Cisco 的代码乱成这样，他能在 24 个月内搭出一个测试框架的可能性基本是零，更别提重写生产代码了。）

### 六、24 个月、98%，还有一条迟到的新评论

支持 98% 这个数字的人，理由集中在"以前的工具链做不到"和"有 oracle 可以对照"两件事上。

> "It&#x27;ll be done in 6 months with a cots harness.<p>Being a mess isn&#x27;t a problem when you have more than 6 items context." — literalAardvark [c:50312696]
> （译文：用现成的测试框架，6 个月就能做完。<p>当你有超过 6M tokens 的上下文时，代码乱成一团根本不是问题。）

（注：原文的 "more than 6 items context" 疑为 "6M tokens context" 的笔误，此处按原样引用。）

在日常研发里用 AI 写测试的人，给出了另一种可行性证据。

> "At my previous place, we had to write unit tests to cover each and every line of code. So if you add 10 lines of code, you ended up writing 100 lines of unit tests, mocking this service and that service, etc.<p>Once AI came along, I became like Captain Picard (RIP) and would just sit back and let the AI write all unit tests. &quot;Try harder, make sure coverage is 100%&quot;. It was very exhilarating to sit back and watch the models churn away, creating 100s of lines of unit tests. Of course, I checked them all manually before submission ;-)" — mlmonkey [c:50310473]
> （译文：以前那家公司要求单元测试覆盖每一行代码。加 10 行代码，就要写 100 行单元测试，把这个服务那个服务都 mock 掉。<p>AI 出现之后，我就像皮卡德舰长（RIP）一样坐在那儿让 AI 写全部单元测试。"再努力点，确保覆盖率 100%"。看着模型呼呼地生成几百行单元测试，非常带劲。当然，提交之前我还是全都人工检查过;-)）

技术路线上，比较靠谱的一条是切片替换。

> "Usually you’d choose to port features in slices end to end so that you don’t have to pull in bugs as side effects. Strangler fig.<p>Obviously this fails if this is a large org with many teams and microservices, but for a leaner org this isn’t really a problem.<p>I realize this thread is about Cisco so my comment doesn’t apply here haha." — beardbandit [c:50312882]
> （译文：通常你会选择端到端切片地搬功能，这样就不用把 bug 作为副作用一起带进来——绞杀者模式。<p>当然，如果这是个多团队、多微服务的大组织，这招会失灵，但对更精简的组织这不是问题。<p>我意识到这个帖子讲的是 Cisco，所以我的评论在这儿不太适用，哈哈。）

而"为什么 Python 没被这样重写"这个反问，是这条线上最完整的一次反驳。

> "If this was true then Python would already have been rewritten to be GIL-free, and the entire ecosystem of Python packages would have been rewritten to respect its API." — amelius [c:50312419]
> （译文：如果这个说法成立，Python 早就被重写成没有 GIL 了，整个 Python 包生态也早就被重写成尊重它的 API 了。）

> "Absence of evidence is not evidence of absence! We&#x27;re on this thread because <i>Cisco</i> is sponsoring piles of tokens at the problem. No such megacorp sponsor exists for this problem for Python. The megacorps have decided not to sponsor that specific problem." — solyin [c:50312618]
> （译文：缺乏证据不等于证据缺失！我们这个帖子存在，是因为<i>Cisco</i>正在往这个问题上砸 token。Python 那边没有这样的巨头赞助者。那些巨头决定不赞助这个具体问题。）

> "I imagine it has been, but they didn&#x27;t release it because the diff is too big to be accepted into regular Python and it would cost more to fix it than use it as is.<p>With the current sota models code is free." — noosphr [c:50313546]
> （译文：我猜做过，但他们没放出来，因为 diff 太大，Python 官方不会接受，而且修到能合入的成本比就这么用着还高。<p>在当前 SOTA 模型下，代码是免费的。）

> "Bun obviously: they swapped the engine under claude code from zig bun to rust bun and it worked fine.<p>pgrust, high profile rewrites all over the place.<p>When you have an oracle to check behavior against, it is really easy to build a robust testing machine with property tests against the original." — habitue [c:50319852]
> （译文：Bun 显然算一个：他们把 claude code 底下的引擎从 zig bun 换成 rust bun，一切照常。<p>pgrust 也是，高知名度的重写到处都是。<p>当你有一个可以对照行为的 oracle 时，用 property test 对着原实现搭一套健壮的测试机器，就非常容易。）

而这条帖子在 11 月 14 日新来的那条评论，把整场争论拉回了一个更基础的问题：这类"不可能"的论证，本身就不成立。

> "It&#x27;s ridiculous because &quot;If X were possible, Super Duper X would already have happened! Therefore X is obviously impossible!&quot; is pretty much always a terrible argument. It trivializes the effort and incentives required to go from X to Super Duper X, which are obviously very real and in this case very meaningful.<p>Put another way: in freshman economics, they&#x27;ll teach you &quot;arbitrage doesn&#x27;t exist because if you could do it, someone else already would have done it, and therefore it doesn&#x27;t exist.&quot; And yet, there are whole ass companies that exist simply to exploit market arbitrage opportunities. It&#x27;s a useful abstraction for getting up the learning curve, but you&#x27;re expected to figure out or be taught eventually about the actual underlying nitty gritty. As they say, the devil is in the details." — heylook [c:50492007]
> （译文：这很荒谬，因为"如果 X 是可能的，那 Super Duper X 早就发生了！所以 X 显然不可能！"这种论证几乎总是糟糕的。它把从 X 走到 Super Duper X 所需的努力和激励一笔带过，而那些努力和激励显然是真实存在的，在这件事上尤其有意义。<p>换个说法：大一经济学课上会教你"套利不存在，因为如果你能做，别人早就做了，所以它不存在"。然而，纯粹为了利用市场套利机会而存在的公司多得是。这是个帮人爬学习曲线的有用抽象，但最终你得自己去搞清楚、或者被人教会底下那些实打实的门道。都说细节里藏着魔鬼。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 文章没写重写理由 | williadc | 全文没交代 98% 为什么值得重写 |
| 重写为了什么 | alwa | 为了什么才重写？究竟为了什么 |
| 老代码的需求没记录 | HarHarVeryFunny | 那些"沉淀"可能是后续增强，不是烂代码 |
| 重写先制造 bug | Aperocky | 稳定运行的东西会先被弄出 bug |
| 领域知识从哪来 | Taikonerd | 否则只会复制老 bug 和可疑设计 |
| AI 让重写变稳赢 | jimmaswell | 它去喝咖啡的工夫就把活干了 |
| 重写重新可行 | phil21 | 十多年没人敢碰的债，动起来了 |
| 机会成本被重算 | anyonecancode | 从"默认不做"变成"值得一问" |
| 这是旧观念残留 | habitue | AI 之前对重写的惯性态度 |
| 先记录行为再挑 | ravishi | 把所有行为写下来，然后挑着留 |
| AI 会照抄老 bug | jiggawatts | 它把原代码当规格，逐个照抄 bug |
| 兼容性 vs 现代化 | jiggawatts | 两个目标本身互相冲突 |
| LLM 不知道你要什么 | stavros | 老工程师对公司需要什么更有上下文 |
| AI 搞不清老契约 | amluto | 这个问题本身就很难，未必有定义 |
| 老 bug 得当特性搬 | literalAardvark | 搬 API 不能挑，周边生态会崩 |
| 双模型互查 | quantbuilder | 第二个模型才抓得住"看着错其实对" |
| AI 更适合改不是写 | InsidiousWombat | 架构信息在代码里，推理错也会出新问题 |
| AI 最该干的是解释 | rustyhancock | 干得好不好取决于工程师，不是工具 |
| LLM 会写测试但不会评估测试 | paimapi | 还会把老 bug 编码成测试要求 |
| 至少不会更差 | Refreeze5224 | 满是 bug 和写死 SSH key 就等于没变 |
| IOS 文本配置是当年立身之本 | mesrik | 文本配置让大规模配置管理成为可能 |
| Junos 已经赢了这一代 | traceroute66 | iOS 像回到 18 世纪 |
| 现场笔记本与地雷 | schainks | "千万别按这个顺序点" |
| 变砖跟 AI 无关 | kotaKat | 固件耗尽 flash，全国成千上万台变砖 |
| Cisco 已成笑柄 | runjake | 正在把最后一批 Cisco 换成 Juniper/Arista |
| 新产品质量下滑 | bigfatkitten | 近二十年几乎每款新产品都是垃圾 |
| IOS 匹配太激进 | entrope | 任意 UDP 都被当成 DHCP/PTP |
| 报道像 PR 稿 | koskokos | 昨天写的代码也是遗留代码，但不该重写 |
| 单独捧一个人很奇怪 | piker | 这种文章通常会写公司或写 CEO |
| 收购关系值得一提 | sleepyguy | 翻译公司也是同一位 CEO 收购的 |
| 翻译经验≠懂网络代码 | forgotpwd16 | 除非只重写 CVP、WebEx 这类服务 |
| 这叫疯狂 | classified | 用未经证实的技术冒这种险 |
| 24 个月搭不出框架 | tw04 | 更别提重写生产代码 |
| 6 个月能做完 | literalAardvark | 上下文够大，乱不是问题 |
| AI 写测试人做检查 | mlmonkey | 提交前还是人工全查一遍 |
| 切片替换 | beardbandit | 绞杀者模式，大组织失灵 |
| Python 早该被重写 | amelius | 按这逻辑生态早变了 |
| 缺的不是证据 | solyin | Cisco 在砸 token，Python 那边没人赞助 |
| 代码已经免费 | noosphr | diff 太大官方不收，修不如直接用 |
| 有 oracle 就能验 | habitue | zig bun 换 rust bun 就成了 |
| "不可能"论证不成立 | heylook | 套利公司真的存在，细节里藏着魔鬼 |

## 总体情绪

这条帖子最奇特的地方，是它同时踩中了三种情绪：对管理层套路的本能警惕，对 AI 重写技术的真好奇，以及老工程师对 Cisco 这家公司的复杂旧账。318 分和 387 条评论说明关心的人不少，但讨论从第一分钟起就跑偏了——不是因为有人带节奏，而是因为报道本身就留了一个巨大的洞：为什么是 98%，重写之后要达成什么。文章里给了 token、给了期限、给了"你去吧，敞开了干"，唯独没给目标。于是"重写是为了什么"成了整场讨论的锚点，后面所有分支都从这里长出来。

技术上，支持与反对的分歧比想象中小。支持方说的其实是一句朴素的话：重写的成本结构被 AI 改了，从此值得一问；反对方说的也是一句朴素的话：AI 会把老 bug 当规范抄下来，而这需要有人告诉它哪些 bug 该留。有人两句话都说了——AI 让重写变可行，但前提是资深领域专家在驱动流程，而不是一个 27 岁、此前做实时翻译的创业者。至于 24 个月 98% 这个数字，评论区给出的可信区间，从"6 个月就够"到"连测试框架都搭不出来"，跨度极大。

而最让人感慨的还是那批老工程师。他们的火气不冲着 AI，冲着 Cisco：一个 2016 年还要靠现场笔记本提醒"别按这个顺序点"的设备商，一份让全国 AP 变砖的固件通知，一套把任意 UDP 当成 DHCP 请求的 IOS 匹配逻辑，还有"admin"这个词当年能把整台设备锁死的老故事。这些才是"98% 遗留代码"四个字下面真实的东西。到最后，这条帖子在 11 月 14 日又冒出来一条新评论，把整场争论收回最朴素的地方：拿"别人早就做到了"来论证"这事不可能"，从来就不是个成立的论证。

这场讨论最后落在一句玩笑上：目标定死 98%，理由留白，token 不限量——账单和理由，等 24 个月后再对账。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Cisco gives engineer unlimited AI tokens to rewrite legacy code（HN 主帖） | <https://news.ycombinator.com/item?id=50304122> |
| 2 | Fortune：Cisco is letting a 27-year-old refactor 98% of its legacy code with unlimited AI tokens | <https://fortune.com/2026/10/30/cisco-president-jeetu-patel-gen-z-27-year-old-unlimited-ai-tokens-rewrite-legacy-code-entry-level-jobs/> |
| 3 | Cisco 现场通知 743：AP 固件耗尽 flash 空间导致无法升级（评论引用） | <https://www.cisco.com/c/en/us/support/docs/field-notices/743/fn74383.html> |
| 4 | TechCrunch：Cisco 收购实时翻译创业公司 EzDubs | <https://techcrunch.com/2025/11/17/cisco-acquires-translation-startup-ezdubs/> |
| 5 | Josh Kushner：专挑工龄少于四年的人（报道引用） | <https://fortune.com/2024/11/15/why-josh-kushner-the-lead-investor-in-openai-likes-to-hire-people-with-less-than-4-years-of-experience/> |
| 6 | 论文：LLM 生成测试 vs 评估测试有效性（评论引用） | <https://arxiv.org/abs/2410.21136> |
| 7 | 论文：LLM 把既有 bug 编码为测试要求（评论引用） | <https://arxiv.org/abs/2607.05139> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 318 分、387 条评论，抓取快照 2026-11-15 18:35 UTC，归档入库 115 条；HN 未返回评论分，评论分数字段均为 0，引文选择依据为内容本身与讨论价值而非评论分数）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。原文为 Fortune 报道，归档正文为页面抓取上限 8000 字符，止于 Josh Kushner 段落中途；文中关于 4290 亿美元市值、40% 雇主计划减少校招、Baya 的 Stanford 奖学金与每月邮件等细节均出自该报道正文，本摘要未做独立核实。文中"重写理由""资格""98% 可行性"等判断均为评论者观点，不代表事实；sleepyguy 关于两人是否早已相识的猜测评论区无任何佐证。引文中的 "more than 6 items context" 疑为原评论笔误，按原样保留并加注。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
