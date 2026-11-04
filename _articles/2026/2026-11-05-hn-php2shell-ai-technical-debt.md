---
layout: post
title: >-
  PHP2Shell 与 40 年技术债：AI 两周挖出漏洞，补丁却要两个月 — HN 讨论摘要
date: 2026-11-05
hn_id: 50364336
categories: [articles]
excerpt: >-
  一个 2024 年就报过的 OOM 崩溃，两年内没人当真；今年 AI 帮它变成了可以在服务器上
  执行任意代码的路径，四个工程师花两个月打补丁。Wiz 的遥测显示披露一周后仍有近一半
  暴露面没关。技术债的账算清了，付账的人还没出现。
tagline: >-
  找洞的是 AI，补洞的是四个工程师，剩下的账没人认领。
---

> 来源：HN 讨论主帖 [AI is forcing us to pay off 40 years of technical debt](https://news.ycombinator.com/item?id=50364336)（810 分，493 条评论），原文是 IEEE Spectrum 的一篇报道。关联帖：[PHP Foundation 'under-funded' with one full-time staff member, director says](https://news.ycombinator.com/item?id=50224074)（149 分，103 条评论）、[PHP2Shell: Exploitation attempts and remediation trends](https://news.ycombinator.com/item?id=50259343)（192 分，52 条评论）、[Tell HN: I unknowingly broke the PHP RCE embargo. I am sorry](https://news.ycombinator.com/item?id=50193416)（719 分，247 条评论）。原文：[IEEE Spectrum](https://spectrum.ieee.org/ai-in-cybersecurity-php2shell-vulnerability)、[Wiz 博客](https://www.wiz.io/blog/php2shell-exploitation-so-far)、[Reuters](https://www.reuters.com/technology/php-foundation-under-funded-with-one-full-time-staff-member-director-says-2026-10-23/)。本篇为 cluster 模式，主帖为 IEEE Spectrum 报道讨论（thread 1），PHP 基金会人力与资金为 thread 2，Wiz 攻击与暴露面数据为 thread 3，保密期破裂始末为 thread 4。
>
> 归档快照：主帖 2026-11-04 19:28 UTC（100 条评论），thread 2 为 2026-10-26 14:51 UTC（103 条），thread 3 为 2026-10-29 04:41 UTC（52 条），thread 4 为 2026-10-24 03:35 UTC（101 条）。

## 原文概要

IEEE Spectrum 在 11 月 2 日刊出一篇报道，主标题《PHP2Shell 漏洞预告网络安全地狱》，副标题是「AI 正在逼我们还清 40 年的技术债」，作者 Dina Genkina。

漏洞本身并不复杂。它是一类内存分配错误（out-of-memory）：给一段数据分配的内存装不下数据，正常情况下只会让程序崩溃，谈不上危险。而 PHP 基金会早在 2024 年就收到过这个 bug 的报告，此后一直没人处理，原因朴素得让人无话可说——每天都有一堆只造成崩溃的 bug 排队等人修，没人当回事。

今年年初，安全公司 Calif 在 OpenAI 出资赞助下对 PHP 做独立审计。两周之内，Calif 的研究员借助 AI 工具，把这个崩溃级的 OOM 错误变成了可以在服务器上执行任意代码的路径：从崩溃升级成 RCE。Calif 立刻通报 PHP 基金会，Wiz 随后确认并扩展了漏洞范围。10 月 21 日公开披露时，可能受影响的名单里有 NASA、Wikipedia、白宫，以及所有跑 WordPress 或 Drupal 的站点。同一个月还涌出 Brotli 库的 Node.js RCE（CVE-2026-111497）、Ruby 正则引擎的三个 bug、CA 私钥在几毫秒内被拆开等一串事故。

报道里最重的一句来自 Tolmo 的 AI 安全研究负责人 Matt Suiche：“我们眼下看到的，是过去 40 年人类写下的全部遗留软件正在被暴露出来。现在是时候把技术债还清了。”哥伦比亚大学计算机科学副教授 Suman Jana 把门槛说得更具体——难的不是危险不危险，而是“非常具体的推理非常痛苦”。Jana 说：“这纯粹是非常具体、非常费劲的推理，而 AI 在这件事上做得非常好。”Calif 那个研究员两周干完的，正是这件费劲事。

但发现和修复之间有根本的不对称。Jana 说：“找 bug 和修 bug 存在根本的不对称，因为你修的时候必须确认攻击的所有路径都堵上了，同时还不能弄坏任何已有功能。”为此 PHP 基金会派了四名工程师，用了两个月赶出补丁。Jana 对修复侧的期待是形式化验证，Anthropic 在 10 月 22 日发布的工具是这条线上最关键的一块拼图。他的描述是：“补丁是 LLM 生成的，然后由 LLM 生成补丁正确的证明。唯一不由 LLM 完成的是证明检查器，因为总得有人来检查证明——LLM 会产生幻觉。所以你要的是形式化的东西。”

约翰霍普金斯大学信息安全研究所的 Matthew Green 不乐观：“在真的出大事之前，没人会去解决这个问题。而 PHP2Shell 还不够‘真的很大事’。所以等真的大事发生——大概是 2027 年初——人们突然就会开始做了。到时候什么都会拿到钱。”他给个人用户的建议倒是很实在：手机上弹出安全更新，别拖到下周。

数字层面，Wiz 的遥测记录了这场补丁战的进度：10 月 21 日公开披露后几天，公网暴露且易受攻击的独立主机数量每天下降约 67%，至少有一台暴露实例受影响的组织数量下降约 47.9%，披露一周后仍带漏洞的组织比例低于 53%。作为参照，Wiz 数据集中有 65% 的组织在用 PHP。

真实攻击也被抓到了。Wiz 看到两个开源 exploit kit 变种：老的那条链用 1,005 个 multipart 分段加约 12 MB 填充去撑爆内存，在默认 8 MB `post_max_size` 下被 PHP 直接拒收，日志里留下 `POST Content-Length of 12655437 bytes exceeds the limit of 8388608 bytes`；新链能稳定把 PHP 内存耗尽，日志是 `Allowed memory size of 134217728 bytes exhausted (tried to allocate 81920 bytes)`，但每一步都卡在“拿到需要的内存地址”上。Wiz 还注意到一批挂着 PHP2Shell 名号的工具其实走的是会话投毒加另一个 LFI，与本漏洞无关。

不过补丁发出去不等于债务清零。PHP 基金会本身只有一名全职员工，同期 HN 上一条讨论的标题就是《PHP 基金会“资金不足”，只有一名全职员工，负责人说》。同一批评论里，替代方案被摆上桌：干脆让 PHP 退休、把语言降级成“只维护”模式、或者用 AI 重写迁移。而 10 月 22 日那场保密期破裂的插曲说明另一件事——当任何人都能把 AI 指向一个模糊方向就找出一个洞时，人工协调披露的时间成本，本身正在变成安全成本。

## 讨论焦点

### 一、AI 把找漏洞变便宜了，人类还剩下什么

主帖里最尖锐的判断来自一个把“技术债”标题拆开的人。提问者的前提是：AI 帮我们还技术债。反对者把因果关系倒过来——先有囤洞，才有 vulnpocalypse：

> "This is the real reason for the vulnpocalypse, not &quot;technical debt&quot;. NSA spent 20 years stockpiling vulns and pushing the industry towards half-assed solutions like address sanitization and pointer tagging when they could have put the industry on memory-safe languages instead." — octoberfranklin [c:50364646]
> （译文：真正的 vulnpocalypse 原因在这里，不是“技术债”。NSA 花 20 年囤积漏洞，把行业推向地址消毒、指针标记这类半吊子方案，而他们本来可以让整个行业转向内存安全的语言。）

反驳者也不让：

> "Why do you think the NSA could have put the industry on memory-safe languages? Even if they wanted to, I highly doubt they could push the industry to do that. The industry does what it wants to do, and rewriting tons of software was far from its priorities." — FartyMcFarter [c:50364698]
> （译文：你以为 NSA 能让整个行业转向内存安全的语言？就算他们想，我也很怀疑他们推得动。产业界想做什么就做什么，把海量软件重写一遍从来不在他们的优先事项里。）

那么 AI 到底改变了什么？一篇最实操的回答是：它只是把 linter 变强了。

> "Also they are unable to fix them, if you ask them to fix a bug they probably introduce 3 other more, and so on, and you arrive quickly at the point that the code is a mess of spaghetti that needs to be rewritten completely (by a human, this time). On the opposite side AI is good at finding bugs, so I use it more as an advanced linter that tells me if I'm doing something wrong." — alerighi [c:50368556]
> （译文：而且它们修不了 bug，你让它修一个，它大概会再引入三个，然后没完没了，很快代码就成了一团需要人类彻底重写的意大利面。反过来，AI 很擅长找 bug，所以我更多把它当一个高级 linter，用来告诉我哪里写错了。）

另一派把 AI 的价值押在“证明”上：

> "The logical extrapolation of AI capabilities stress-testing human software is all bugs being discoverable. Hence, you have to aim for actually bug-free software. The only way to do that is to make your code provable. That again is only realistically doable using AI." — Loquebantur [c:50366124]
> （译文：把 AI 对人类软件做压力测试的能力往外推，结论是所有 bug 都会被发现。所以你必须以真正无 bug 的软件为目标，唯一的办法是让你的代码可被证明。而这件事现实中也只有用 AI 才做得到。）

这句立刻被拆台，因为“可证明”要么有前提，要么只是修辞：

> "No software of normal complexity can be &quot;provable&quot;. There will always be bugs no matter the strength of the AI." — doug_durham [c:50368511]
> （译文：正常复杂度的软件没有一个能被“证明”。不管 AI 多强，总会有 bug。）

> "While I whole-heartedly support the goal of actually bug free software and treating software engineering as a serious engineering discipline, as an experienced software engineer who also studied physics, I have to challenge your base premise about what it means to make engineering explicit." — dbingham [c:50368136]
> （译文：我完全支持“真正无 bug 的软件”这个目标，也支持把软件工程当成严肃的工程学科；但作为一个有经验、还学过物理的软件工程师，我必须质疑你那个“把工程显式化”的基本前提。）

还有一条把话说得更冷：资源投多少，得看场景。

> "The problem here is that the correct amount of resources is context-dependent. Suppose you're a small business and you're putting up a website to display the menu for your restaurant and directions to get there. Do you want it to get compromised? Of course not. Does it matter very much if it does? Eh. Should you spend $50M in formal verification to make sure it doesn't? Definitely not." — AnthonyMouse [c:50369826]
> （译文：问题在于，合适的资源投入是依场景而定的。假设你是个小生意人，上线一个网站放餐馆菜单和到店路线。你当然不希望它被黑。被黑了要紧吗？也就那样吧。你该花 5000 万美元做形式化验证来保证它不被黑吗？绝对不用。）

### 二、内存安全是不是银弹：Ada、指针标记和那些囤起来的洞

内存安全是这一帖的默认共识，也是最容易被过度推销的东西。有人翻出历史：

> "The U.S. government had pushed Ada for years and it never worked out. The government was forced to accept C++ because industry was rebelling against ADA, even though ADA was memory safe. Well, Ada did have the ability to be memory unsafe. It was much better by default." — bluGill [c:50364842]
> （译文：美国政府推了 Ada 很多年，最后没成。因为产业界在反抗 ADA，政府被迫接受了 C++——哪怕 Ada 是内存安全的。当然 Ada 也能写出不安全的代码，只是默认行为好得多。）

也有人提醒，编译器本身就是漏洞来源：

> "But even in memory-safe languages, compiler bugs are still an issue. The theory is perfect but the implementation is flawed. In such case once the compiler bugs are found, the software would have to be rewritten to compile." — terminalcommand [c:50364807]
> （译文：但就算在内存安全的语言里，编译器 bug 依然是问题。理论是完美的，实现是有缺陷的，这种情况下编译器 bug 一被发现，软件就得改写才能编译。）

对这一派最直接的反驳是：内存安全早就不是新鲜事，问题在别处。

> "I think we'll have flying cars before we have to start focusing on compiler bugs. Most software is already written in memory safe languages and their vulnerabilities are unrelated to memory safety, they're just plain old logic bugs." — dns_snek [c:50369800]
> （译文：我觉得在轮到我们操心编译器 bug 之前，飞行汽车都会先出现。大多数软件已经写在内存安全的语言里了，它们的漏洞跟内存安全无关，就是普普通通的逻辑 bug。）

于是讨论落到设计上，而不是语言上：

> "This doesn't necessarily require proving everything mathematically, it also helps to design things in a way that doesn't rely on discipline to avoid gaping holes. For example, languages that allow pointer arithmetic, unchecked array access, or use-after-free have huge opportunities to make security errors that don't exist in languages without them." — svachalek [c:50370285]
> （译文：这不一定要靠把一切都数学化地证明，它也有助于把东西设计成不依赖自律去避免大洞的样子。比如允许指针运算、未检查的数组访问或者 use-after-free 的语言，制造安全错误的机会要比不具备这些的语言大得多。）

而“囤洞”的另一面，有人读出了不一样的结论：

> "I hope some of these backdoors and/or 0-days being kept under wraps by nation states or corporate espionage companies (Pegasus et al) are being found incidentally through all this. It’s frustrating to have all these 0days and CVEs to patch for now, but in the long run perhaps we’ll leave with more robust software." — Arbortheus [c:50364549]
> （译文：我希望那些被各国政府或商业间谍公司（Pegasus 之类）藏起来的后门和 0-day，能在这波风潮里被顺手挖出来。现在要补的 0-day 和 CVE 多到烦人，但长期看，也许我们会留下一批更结实的软件。）

### 三、KISS 被 AI 违反：防御性编程、代码熵和 vibe slop

如果 AI 帮我们还债，那么 AI 顺手写的代码本身也在制造债。这一节的共识比内存安全那节更强。

有人先给 AI 的毛病下了定义——它不是不简洁，是防御性过头：

> "People complain about LLMs not respecting KISS, but fail to address why = LLMs being defensive and coding for situations that either do not happen or are unlikely to happen." — eithed [c:50365847]
> （译文：大家抱怨 LLM 不尊重 KISS，却不去说清楚为什么：它们太爱防御，专写那些根本不会发生、或几乎不可能发生的情况。）

有人拿自己的项目当证据：

> "I vibe-slopped a small and local forms application for my family. I explicitly mentioned that fact to the LLM. Yet, I removed 2/3s of the code, because it triple-checked that every file really existed and was valid, that the input form was less than a million bytes in size, that there were propper HTTP status codes for everything, that every possible error from reading data was eagerly checked and caught, and so on." — ShadowOfThePit [c:50366485]
> （译文：我给我家写了个本地小表单应用，纯粹 vibe 出来的，我也明说了这一点。结果我还是删掉了三分之二的代码，因为它把每件事都检查三遍：文件是不是真的存在、输入表单是不是小于一兆字节、每种情况都有正确的 HTTP 状态码、读数据的每种可能错误都被提前检查并捕获……）

最完整的诊断来自把“修漏洞”拆成两种做法的人：

> "You can eliminate the source of it, which often involves refactoring but tends to result in less code and cleaner, more comprehensible logic. Or you can leave the gap there, but attempt to render it safe by adding extra logic to detect and handle the error condition. ... But LLMs don’t do that. They always choose option B: slap a bandage on it. Keep on adding more epicycles." — bunderbunder [c:50367913]
> （译文：你可以消除漏洞源头，这通常意味着重构，代码量往往更少、逻辑更干净也更好懂；也可以把洞留着，改为加一层额外逻辑去检测和处理错误状态。……但 LLM 不这么干。它们永远选 B：贴个创可贴，继续加更多补丁式的小装置。）

一个更简短但同样不留情面的观察是，编码 agent 现在的品味还配不上它们的产量：

> "But right now coding agents just love writing code, and they don't have a lot of taste for boundaries and architecture, so we have the loop-unrolled, big-pile-of-ifs kind of logic that isn't good." — titzer [c:50368378]
> （译文：但现在编码 agent 就是爱写代码，它们对边界和架构没什么品味，于是我们得到的是那种把循环展开、一堆 if 堆起来的逻辑，不怎么样。）

于是核心问题被摆到了台面上：写代码便宜之后，熵怎么办。

> "Yeah, so far coding agents haven't been good at reducing entropy at a large scale. That's the area where we need to push hardest in my opinion. Writing code is cheap now, but that makes it easier than ever to inflate codebases to millions of lines of unnecessary complexity that are impossible to work with and maintain." — renehsz [c:50366734]
> （译文：到目前为止，编码 agent 还不太擅长在大规模上做减法。至少在我看来，这才是最该使劲的方向。现在写代码很便宜，这也就让把代码库膨胀成几百万行不必要复杂度变得前所未有地容易，而那样的代码库没人能维护。）

还有一条把 KISS 和安全直接连起来：

> "KISS usually leads to less surface area. Someone not following KISS, might install Windows Server + tons of bloated applications, in order to serve a .asp server, which serves JSON that never changes, or something similarly stupid." — embedding-shape [c:50368646]
> （译文：KISS 通常意味着更小的攻击面。不遵守 KISS 的人可能为了跑一个只输出固定 JSON 的 .asp 服务，装上一台 Windows Server 外加一堆臃肿应用……）

### 四、怎么证明软件是对的：形式化验证的前提

从“能不能证明”这个问题出发，评论区分成三派。

第一派认为这只是工具问题：

> "You’re describing vibe coding and GP is describing systems for proving correctness. If you ask an AI to generate a novel math proof, it will inevitably produce garbage. If you give it the tools to do this (e.g. Lean), evidence is that it can in fact generate meaningful proofs." — dpark [c:50368603]
> （译文：你说的是 vibe coding，而 GP 说的是一套证明正确性的系统。让 AI 生成一段全新的数学证明，它必然产出垃圾；但给它合适的工具（比如 Lean），证据表明它确实能生成有意义的证明。）

有人立刻把“工具问题”这几个字贬下去：

> "“tooling problem” makes it sound trivial, its a tooling problem like building a quantum computer is a tooling problem. Ie something that probably won’t be solved in our lifetime" — icantevenhold [c:50369659]
> （译文：“工具问题”这说法听着很简单，但它就像“造量子计算机是工具问题”那种工具问题——大概这辈子都解决不了。）

第二派质疑证明本身的适用范围：

> "Proofs are a mathematical concept. They only work in the abstract world of mathematics where everything is perfectly logical. Engineering exists in the real world. The physical realm where our mathematics are only imperfect models of what actually exists." — dbingham [c:50368136]
> （译文：证明是个数学概念，只在数学那个一切都完美自洽的抽象世界里成立。而工程发生在真实世界，物理世界里我们的数学只是对现实的、不完美的模型。）

第三派则把瓶颈指认得极其具体——不是模型不够强，是合格的人不够：

> "I don't think so. The article refers to formal verification, but also notes that proof checking should be done by humans. We don't have enough capable humans for that." — Yokohiii [c:50368167]
> （译文：我不这么看。文章提到了形式化验证，但也说了证明检查得由人来做。而我们没有足够多的、有这个能力的人。）

Knuth 的老话被翻出来当注解：

> "Just because you have proven the correctness of your code, that does not mean that it is infallible. Especially -- as a lot of HN users point out -- there's intricate complexity that is likely to cause erroneous behavior if several interfaces/complexities get combined." — Quimoniz [c:50366924]
> （译文：你证明了代码正确，并不意味着它不会出错。尤其正如很多 HN 用户指出的，几个接口/复杂度组合起来时那些微妙的复杂度很可能导致非预期行为。）

还有一个类比，把“工程标准”这个词说清楚了：

> "Buildings and bridges have very large safety margins, to account for design errors, construction errors, damage, poor materials, etc. Airplanes have much smaller safety margins, meaning a lot more calculation is done, and there's a high emphasis on double checking everything. Spacecraft have tiny safety margins, which amps up the design rigor to 11." — WalterBright [c:50368928]
> （译文：建筑和桥梁有非常大的安全余量，用来覆盖设计错误、施工误差、损伤、劣质材料等等。飞机的安全余量小得多，意味着要算更多东西，也格外强调反复复核。航天器的安全余量极小，这会把设计严谨度直接拉满。）

### 五、谁来付钱：PHP 基金会只有一个人

漏洞修好了，维护还在继续，而 PHP 基金会只有一名全职员工。thread 2 的标题就是这个事实，评论区则把账算到了具体的人头上。

最省事的一个方案是让钱往下流：

> "The solution is obvious: pour trillions of dollars into Anthropic and OpenAI, and security will trickle down." — Hamuko [c:50224244] [thread 2]
> （译文：解决方案很明显：往 Anthropic 和 OpenAI 里灌几万亿，安全就会涓流下来。）

也有人注意到“一名全职”这五个字的真实含义：

> "She says the full-time member is herself, and looking at her Linkedin (in/elizabethn) she isn't exactly the person who would patch PHP for the two CVEs." — sam_lowry_ [c:50224299] [thread 2]
> （译文：她说那一名全职就是她自己，而看她 LinkedIn（in/elizabethn），她不太像是会去给这两个 CVE 打 PHP 补丁的人。）

放弃派则干脆利落：

> "Presumably it makes sense to sunset PHP especially with how cheap code migrations are nowadays." — smashers1114 [c:50224302] [thread 2]
> （译文：既然现在代码迁移这么便宜，让 PHP 退休大概才是合理选择。）

立刻有人算迁移的账：

> "Beating the dead horse, as you are: the Bun Rust migration cost millions of dollars in tokens and took an additional 3.5 months of labor after the widely-marketed &quot;11-day rewrite&quot; before being shipped as a release, and in the process introduced hundreds of new issues." — anonymous908213 [c:50224486] [thread 2]
> （译文：你在打一匹死马：Bun 的 Rust 迁移在被大张旗鼓宣传为“11 天重写”之后，又花掉了数百万美元的 token 和额外 3.5 个月的人工才出货，而且过程中引入了几百个新问题。）

> "How cheap are code migrations nowadays? Vibe-migrations, you mean?" — glimshe [c:50224345] [thread 2]
> （译文：现在代码迁移有多便宜？vibe-migration 那种吗？）

维护派给出的答案是别折腾：

> "What's easier, maintaining PHP or migrating/breaking every single PHP-based site? And who's to say whatever sites are migrated to won't be &quot;sunsetted&quot; in a few decades too? Seems like a no-brainer to maintain it." — jmull [c:50224438] [thread 2]
> （译文：维护 PHP 和迁移（或者搞坏）每一个 PHP 站点，哪件更容易？再说，谁敢说迁移过去的站点几十年后不会被“退休”？看起来维护它是明摆着更划算。）

但也有人给“维持现状”派泼冷水：下一个 CVE 不会因为你换了语言就不来。

> "migrating to what? just take a look at the newest CVEs, https://www.tenable.com/cve/newest , and you will see that no technology is spared by high or critical reports." — thinkindie [c:50224644] [thread 2]
> （译文：迁到哪去？去看看最新的 CVE 列表，你会看到没有哪种技术能躲过高危或严重级别的报告。）

“让它死”派里最完整的一版，是把它降级而不是直接扔掉：

> "There are countless applications out there still running on PHP, but if the community interest can't raise the required resources to maintain the tool, maybe it's time for it to die, or at least downgrade into maintenance mode so in time it'll become a legacy language." — gchamonlive [c:50224616] [thread 2]
> （译文：外面还有数不清的应用在跑 PHP，但如果社区的意愿撑不起维护它所需的资源，也许它就该死了；至少也该降级成维护模式，让它慢慢变成一门遗留语言。）

这场讨论的底色其实很绝望——开源项目的商业模式本身有问题：

> "And then people complain about &quot;bait and switch &quot; or &quot;pulling the rug&quot; when an OSS project becomes successful and tries to fund itself in some way. &quot;But that should be free&quot; shouts everyone." — grokys [c:50224618] [thread 2]
> （译文：然后当一个开源项目做起来了、想给自己找点 funding 方式时，大家又开始抱怨“ bait and switch ”或者“抽走地毯”。“但这应该是免费的”——所有人都这么喊。）

### 六、真实世界：两个 exploit kit，一次都没成功

thread 3 的数据是全篇最冷的一节。Wiz 抓到的攻击尝试看上去很热闹，但针对真实生产环境的成功利用一例都没有。

最先被质疑的是“没人成功利用”这个说法本身：

> "&quot;No successful PHP2Shell exploits seen so far&quot;... in the wild, specifically in Wiz's honeypot. The vulnerability itself has been successfully exploited, most notably for the &quot;Steal my Bitcoin&quot; challenge [1] as one example. Dan Guido, of Trail of Bits, claims they have an &quot;universal&quot; exploit [2]." — xx_ns [c:50259562] [thread 3]
> （译文：“目前没有看到成功的 PHP2Shell 利用”……在真实世界里没有，具体说是在 Wiz 的蜜罐里没有。这个漏洞本身被成功利用过，最典型的例子就是“Steal my Bitcoin”挑战。Trail of Bits 的 Dan Guido 称他们有一个“通用”的利用。）

最出圈的那次“成功利用”，环境其实是个玩具：

> "The author didn't even have an accessible PHP server at first. When they actually added one, it got cracked in 2 hours." — Tadpole9181 [c:50260313] [thread 3]
> （译文：那位作者一开始甚至没有一台能被访问的 PHP 服务器。等他真加上一台，两个小时后就被攻破了。）

> "As far as I know, there has been no proven vulnerability on a modern PHP (production) stack. The &quot;Steal my Bitcoin&quot; challenge was a toy project. The &quot;lab&quot; target used the embedded PHP server (`php -S`) which is for development only." — idoubtit [c:50260748] [thread 3]
> （译文：据我所知，在现代 PHP（生产）栈上还没有被证实的漏洞。“Steal my Bitcoin”挑战是个玩具项目，它的“实验目标”用的是内嵌的 PHP 服务器（`php -S`），那东西只用于开发。）

> "The steal my Bitcoin challenge was nothing like a realistic common PHP setup. It was a extremely unrealistic and stupid setup, using the built in php dev server. It's even explicitly stated that it should never be exposed to the internet." — NorwegianDude [c:50260685] [thread 3]
> （译文：“Steal my Bitcoin”挑战跟现实里常见的 PHP 部署完全不是一回事。那是个极不现实、极蠢的部署，用的是 PHP 内置开发服务器，文档里明确写着它不该暴露在互联网上。）

专业视角把话说得更准：

> "A successful universal exploit is all about making it land on the correct memory address for each set up, and that is nigh impossible. As was stated by many groups that do this for a living (E.g., Crowdstrike) &quot;PoC yes, RCE no&quot;" — ericol [c:50261853] [thread 3]
> （译文：成功的通用利用，关键在于让利用在每种配置上都落到正确的内存地址上，而这几乎不可能。正如许多以此为生的团队（比如 CrowdStrike）所说：“PoC 可以，RCE 不行”。）

自己搭环境复现的人，给出了最硬的一条经验：

> "PHP-FPM recycled OOM workers, so there were no corrupted state to exploit and then when I switched to &quot;php -s&quot;, glibc with ASLR made it not very practical to exploit. Changed my lab to use the same alpine + php = tada working exploit." — 0x457 [c:50262303] [thread 3]
> （译文：PHP-FPM 会回收触发 OOM 的 worker，所以没有残留的损坏状态可以利用；后来我换成 `php -s`，glibc 的 ASLR 又让利用变得不实用。我把实验环境换成同样的 alpine + php，就成了，成了。）

于是最实际的问题不是“漏洞有多严重”，而是“你到底打了没有”：

> "For teams still working through the patching, the practical first step is an inventory of which internet-facing hosts and containers actually run an affected PHP version, since that list is often incomplete. Patching also does not remove anything already planted, so on exposed hosts it is worth checking web roots and upload directories for new or modified PHP files and reviewing access logs from before the patch date." — CircuitsFit44 [c:50260970] [thread 3]
> （译文：对还在打补丁的团队来说，第一步是清点到底哪些面向公网的主机和容器跑着受影响版本的 PHP，因为这份清单往往不全。打补丁也清不掉已经落地的后门，所以在暴露的主机上值得检查 web 根目录和上传目录里有没有新增或被改动的 PHP 文件，并回看补丁日期之前的访问日志。）

而遥测数据本身是要打折的：

> "Both of those are coming from telemetry, and mainly show attempts. Those telemetry are generally heuristic based so they overcount and are most often unsuccessful" — makmanalp [c:50263169] [thread 3]
> （译文：这两个数字都来自遥测，主要反映的是尝试。遥测一般是启发式的，会高估，而且绝大多数都没成功。）

这场戏的真正代价，有人指出是信任：

> "2 hours after it the server was fixed there was a successful exploit but because it was originally misconfigured a huge number of people walk away thinking the vulnerability was not serious. At the least we now know a good way to convince large swarths of technical folks to not take new vulns seriously!" — vikramkr [c:50261141] [thread 3]
> （译文：服务器修好两小时后就有了成功利用，但因为它一开始配置就是错的，大量人因此转身就认为这个漏洞不严重。至少我们现在知道了一个能让大批技术人认真对待新漏洞的好办法——反着来。）

对于最初那波“AI 十五分钟就能拿下一切”的说法，thread 3 里的反驳很集中：

> "The main kickback was against the hype and it was &quot;so easy for AI&quot; and would take &quot;15 minutes to compromise everything&quot;. Either way, this was not true." — syshyk [c:50260046] [thread 3]
> （译文：主要的反弹是冲着那些炒作去的——“对 AI 来说太容易了”“15 分钟就能拿下一切”。不管怎样，这话不成立。）

至于为什么偏偏是 PHP，有人给了一个很朴素的解释：

> "It is an old, bad language and interpreter, so it's widely used and lacks an investment of money, effort and talent. Perfect target for exploitation." — smolder [c:50261877] [thread 3]
> （译文：它是一门又老又差的语言和解释器，用得极广，却缺钱、缺投入、缺人才。完美的利用目标。）

### 七、保密期是怎么崩的

thread 4 的主角是 petecooper——他在 HN 上发帖捅破了自己并不知情的 PHP 漏洞保密期，然后回来道歉。

他自己的表述是：

> "That's fair. For clarity: I take responsibility for posting on HN, without knowing the facts." — petecooper [c:50194000] [thread 4]
> （译文：这话有道理。澄清一下：我在 HN 上发帖这件事，我承担责任，当时我并不知道实情。）

> "I posted something that -- in hindsight -- I shouldn't have, and it had repercussions for a lot of people. An action that I took had considerable knock-in effects around the world. Some outlets are reporting that my action of posting something that I believed to be in good faith was an indicator or catalyst for the embargo to be tossed out and a previously-agreed schedule to change in short order." — petecooper [c:50200054] [thread 4]
> （译文：我发了某个事后看不该发的东西，它对很多人造成了后果。我这个动作在全世界范围内产生了相当大的连带影响。据一些媒体报道，我这个自认为出于好意的发帖，成了保密期被提前掀掉、原定时间表被临时打乱的一个诱因或推手。）

社区里有人不接受这份道歉：

> "Don't be silly, you can't possibly be responsible for breaking an embargo you weren't subject to or informed about." — cwillu [c:50193835] [thread 4]
> （译文：别犯傻，你不可能对一个自己既没被要求遵守、也没被告知的保密期负责。）

> "What does “take full responsibility” mean in the present context? Are you forfeiting all your assets and pledging the next twenty generations of your descendants into peonage? (For clarity, I’m being facetious, but it’s a really meaningless and empty phrase to commit to the written record.)" — qubex [c:50199396] [thread 4]
> （译文：在这里，“承担全部责任”到底是什么意思？你是要放弃全部财产，把之后二十代人都抵押出去做苦役吗？（说明一下，我是在开玩笑，但把它写进记录里实在是一句毫无意义又空洞的话。）

更多人担心的是法律风险：

> "Do not ever do what you just did. It makes you an easy target for a frivolous lawsuit in the US or in other countries because of the potential liabilities in your message, they are real. Even if you didn't do anything wrong, you are painting a target on your back, for no reason." — throw_m239339 [c:50200172] [thread 4]
> （译文：千万别做你刚做的那件事。这会让你在美国或别国成为一桩无谓诉讼的现成目标，因为你那段话里潜藏的责任是真的。就算你什么都没做错，你也是在毫无必要的情况下给自己身上画了个靶子。）

至于事件本身有多严重，评论区两边吵得很凶。一方觉得被夸大了：

> "Not sure what you are apologizing for. It's a severely overblown bug that ended up on the front page of New York Times and the Japan Prime Minister had to get involved too. The bug itself is non trivial to exploit from just public requests to a web server so I am not sure what the hysteria is about." — Onavo [c:50194712] [thread 4]
> （译文：我不确定你在为什么道歉。这是个被严重夸大的漏洞，却上了纽约时报头版，连日本首相都得出面。光是靠公开请求去打一个 web 服务器，这个 bug 本身并不好利用，我真不知道大家在大惊小怪什么。）

立刻有人纠正了其中一个细节：

> "The Japanese PM did not “have” to get involved." — Klonoar [c:50195092] [thread 4]
> （译文：日本首相并没有“不得不”介入。）

另一方则完全相反：

> "What does &quot;non trivial to exploit from just public requests&quot; mean? It's known to be exploitable on more than one stock PHP application. This really is a 5-alarm fire." — tptacek [c:50200730] [thread 4]
> （译文：“单靠公开请求不好利用”这话是什么意思？已经确认在不止一种标准 PHP 应用上可利用。这真的是五级警报。）

> "Right, that's what's worrying me. It is not interesting that the most widely circulated public POC/demos don't work. All you should care about is the (currently) non-public POCs that do work, of which there are apparently several." — tptacek [c:50201018] [thread 4]
> （译文：对，让我担心的就是这个。流传最广的公开 PoC/演示跑不通，这本身不重要。真正该关心的是那些目前非公开、而且确实能用的 PoC，据说有好几个。）

最后压轴的，是一条把 AI 和披露流程绑在一起的观察：

> "I'm more annoyed by the fact the fixes and exploits themselves are being artificially delayed in misguided attempts to coordinate disclosure, in world where anyone can just point AI at vague direction of the bug and just find it" — InsidiousWombat [c:50365176]
> （译文：更让我恼火的是，补丁和利用本身被人为拖住了——出于那些 misguided 的披露协调企图。在一个谁都能把 AI 指向 bug 的模糊方向、然后就把它找出来的世界里，这个代价很实在。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 债不是技术债，是囤洞 | octoberfranklin | NSA 囤了 20 年漏洞，内存安全本可以替代地址消毒 |
| 政府推过 Ada | bluGill | 内存安全的 Ada 被产业界逼退，政府只好接受 C++ |
| 洞不都是内存安全 | dns_snek | 大多数软件已经是内存安全语言，剩下的是普通逻辑 bug |
| AI 只是高级 linter | alerighi | 它很会找 bug，但修 bug 会引入三个新的 |
| 目标是可证明 | Loquebantur | 所有 bug 都会被发现，所以只能追求可证明 |
| 普通软件不可证明 | doug_durham | 正常复杂度的软件没有一个能被证明 |
| 人比工具更缺 | Yokohiii | 证明检查得由人做，而这样的人不够 |
| KISS 被违反的根因 | eithed | LLM 太爱防御，专写几乎不会发生的情况 |
| 补丁式修法不可持续 | bunderbunder | LLM 永远选“贴创可贴”，早晚堆出臃肿代码库 |
| 写代码便宜了，熵更贵 | renehsz | 希望看到 LLM 把百万行代码压到十分之一 |
| 钱往下流 | Hamuko | 往 Anthropic 和 OpenAI 灌几万亿，安全会涓流下来 |
| 让 PHP 退休 | smashers1114 | 迁移这么便宜，退休才是合理选择 |
| 迁移并不便宜 | anonymous908213 | Bun 的“11 天重写”之后又花了数百万 token 和 3.5 个月 |
| “没被攻破”不等于安全 | idoubtit | 到现在为止，现代生产栈上还没有被证实的漏洞 |
| PoC 可以，RCE 不行 | ericol | 通用利用要落到每种配置的内存地址上，几乎不可能 |
| 先清点再打补丁 | CircuitsFit44 | 打补丁不会清掉已经落地的后门 |
| 遥测要打折 | makmanalp | 遥测是启发式的，会高估，而且大多没成功 |
| 没人该为不知情的 embargo 负责 | cwillu | 你没被要求遵守，也没被告知 |
| 这事真的很严重 | tptacek | 真正该关心的是那些非公开、而且确实能用的 PoC |
| 披露协调本身就是成本 | InsidiousWombat | 谁都能让 AI 找出洞了，人工协调披露的时间就成了代价 |

## 总体情绪

这帖的底色不是恐慌，是算账。IEEE Spectrum 那篇报道把账摆出来：2024 年就报过的 OOM 崩溃，拖了两年，是因为它不致命；今年两周之内，同一个洞被 AI 变成了可以在服务器上执行任意代码的路径。发现的速度和修复的速度之间，隔着四名工程师和两个月。

评论区里最尖锐的分歧，不是“该不该修”，而是“修到什么程度算够”。一派主张内存安全加形式化验证，把代码变成可证明的东西；另一派主张先承认工程就是在物理世界里试错，把资源花在 QA 上；两派之外还有一派更实际：按场景配资源，一个放菜单的网站不值得 5000 万美元的验证，而航天器值得。三种立场各有各的证据，评论区没有合流，只有把话题越推越细的追问。

真正让人不适的是第三件事：漏洞本身修掉了，账却没人认领。PHP 基金会只有一名全职员工，补丁要靠四个工程师的两个月，防御侧的安全预算要靠“等真的出大事”才会到位——而 Green 说的“真的出大事”，大概在 2027 年初。Wiz 的遥测显示暴露面在一周内关掉了一半，剩下那一半靠社区自觉补齐，个体服务器上的入侵痕迹则要靠各家公司自己清点日志去发现。

AI 在这里被同时当成加速器和债主：它把找洞的成本压到近乎为零，也顺手把写代码的熵推到天上。发现漏洞变得更便宜，修漏洞仍然要人坐在那里读内存、写证明、盯合规。而披露这套人肉流程，在 AI 面前第一次显出了它的折旧速度。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AI is forcing us to pay off 40 years of technical debt | <https://news.ycombinator.com/item?id=50364336> |
| 2 | PHP Foundation 'under-funded' with one full-time staff member, director says | <https://news.ycombinator.com/item?id=50224074> |
| 3 | PHP2Shell: Exploitation attempts and remediation trends | <https://news.ycombinator.com/item?id=50259343> |
| 4 | Tell HN: I unknowingly broke the PHP RCE embargo. I am sorry | <https://news.ycombinator.com/item?id=50193416> |
| 5 | 原文：The PHP2Shell Vulnerability Heralds Cybersecurity Hell（IEEE Spectrum） | <https://spectrum.ieee.org/ai-in-cybersecurity-php2shell-vulnerability> |
| 6 | 原文：PHP2Shell — Exploitation attempts and remediation trends（Wiz） | <https://www.wiz.io/blog/php2shell-exploitation-so-far> |
| 7 | 原文：PHP Foundation 'under-funded'…（Reuters） | <https://www.reuters.com/technology/php-foundation-under-funded-with-one-full-time-staff-member-director-says-2026-10-23/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（thread 1 共 100 条，快照 2026-11-04 19:28 UTC；thread 2 共 103 条，快照 2026-10-26 14:51 UTC；thread 3 共 52 条，快照 2026-10-29 04:41 UTC；thread 4 共 101 条，快照 2026-10-24 03:35 UTC）及两篇原文抓取内容（IEEE Spectrum、Wiz）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中漏洞影响范围、暴露面数据与各版本补丁状态截至原文发布时点，之后可能变化。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
