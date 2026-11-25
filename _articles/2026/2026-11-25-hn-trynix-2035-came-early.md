---
layout: post
title: >-
  2035 提前到来：浏览器里跑起 Linux 和 30 万个 Nix 包 — HN 讨论摘要
date: 2026-11-25
hn_id: 50624497
categories: [articles]
excerpt: >-
  把 Linux 编译成 WebAssembly 之后，作者在浏览器里跑起了任意 Nix 包，还让 Firefox
  在 Firefox 里再套一层 Firefox——全程花了 4 个多小时。978 分、106 条评论吵的不是这件事
  本身，而是这算不算 Gary Bernhardt 当年那个预言的兑现。
tagline: >-
  预言 2035 年 JavaScript 统一天下，作者用 4 小时让 Firefox 在 Firefox 里再套一层 Firefox。
---

> 来源：HN 讨论主帖 [2035 came early](https://news.ycombinator.com/item?id=50624497)（978 分，归档入库 106 条评论，原帖累计 370 条），指向作者 Farid Zakaria 的博客 [2035 came early](https://fzakaria.com/2026/11/23/2035-came-early)（2026-11-23 发布，主帖 2026-11-24 06:30 UTC 提交，归档快照 2026-11-25 03:58 UTC）。本篇为 single post 模式：候选池内无同议题帖（关键词 trynix、unkernel、2035 在整个 registry 中均只此一帖）。归档分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文按归档评论原文截取，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。

## 原文概要

2026 年 11 月 23 日，Farid Zakaria 在自己的博客上贴出一篇短文，标题只有一句：2035 came early。起点是 Gary Bernhardt 的那场演讲《The Birth & Death of JavaScript》，以及 Jeff Atwood 2009 年那句被反复引用的断言——任何能被 JavaScript 写的程序，最终都会用 JavaScript 写。Bernhardt 在演讲里把这条时间线推到了 2035 年，而 Zakaria 的论点很简单：大型语言模型把这张时间表整个往前拽了，于是 2035 提前到了。

具体的东西是 trynix.dev：把任意一个 Nix 包直接跑在浏览器里，而且不是某个版本——底座是 nixpkgs-multiverse，覆盖 30 万个以上互不相同的包版本。最早的形态是在浏览器里跑 QEMU 模拟（qemu-wasm），作者自己承认那速度慢到「更偏向奇观而不是实用」。转折发生在 11 月 19 日：Pooya Parsa 发布 unkernel.dev，把 Linux 编译成 WebAssembly，内核和系统组件以 WASM 速度运行，只有用户态程序被模拟。第二天（11 月 20 日）Zakaria 在 TacoSprint 的 Discord 频道里看到 Domen Kožar 贴的那条链接，当天就换掉了引擎，顺手补上了一堆早想做没做的功能。结果是 2 倍到 32 倍的速度提升（视负载而定），trynix.dev/bench 上一直在追踪两套引擎的对比曲线。

引擎之外的部分也都齐了：Wayland 界面由 wland 合成，直接浮在你启动它的终端上方；图形是一份只带 virgl 驱动的最小 Mesa 构建，经 WebGL2 渲染，es2gears 跑出大约 60 帧；声音是一张 ALSA 声卡，espeak-ng 能说出 "Hello from the Nix multiverse"；网络方面 curl、git clone、pip install 都能用，只是每条 TCP 连接都要经由一个 WebSocket 送到 Wisp 中继。压轴的是嵌套浏览器：在 trynix 里启动 Firefox，让这个 Firefox 打开 trynix.dev，再让 trynix.dev 在里面再启动一个 Firefox。整个过程花了 4 个多小时——内层 Firefox 关掉了 JIT，中间那层没有 GL，最外层页面用的是作者笔记本上的 Wisp 中继，因为 wisp.unkernel.dev 访问不了自己。

## 讨论焦点

### 一、「2035 提前到来」，指的是哪件事

最早的一句反对就抓到了逻辑漏洞：那个预言说的是 JavaScript，而这篇演示的是 WebAssembly。

> "Well.. the prediction was about JavaScript. This is WebAssembly. A big part of the reason the timeline accelerated is that the goal post was moved. A lot." — boxed [c:50625490]
> （译文：这个预言说的是 JavaScript，而这是 WebAssembly。时间线之所以提前，很大一部分原因是标准被挪了位置，而且挪得厉害。）

说得更狠的是把原文自己引用的句子摆出来反问。

> "Written in meaning shipped in. JavaScript is irrelevant to WASM. They are not interchangeable. It has literally zero relevance to the projects it uses to demonstrate its point.<br>Like, just a few quotes from the article (some of which are quotes to support the argument)-<br>&quot;JavaScript will come to dominate all software.&quot;<br>&quot;inevitability of JavaScript’s dominance&quot;<br>&quot;how JavaScript came to be the defacto language for all software&quot;<br>With an old video about someone saying that eventually we&#x27;ll compile everything to JavaScript by 2035, ergo 2035 came early. Then trying to twist that such that...well...a browser hosts something, and it also hosts JavaScript, therefore prediction came early!<br>I, uh...guess." — llm_nerd [c:50627672]
> （译文：所谓「用 JavaScript 写」，意思只是「用 JavaScript 交付」。JavaScript 对 WASM 毫无意义，两者不可互换。它跟作者用来证明自己观点的那些项目没有任何关系。<br>比如，原文里引的几句话（其中几句本来就是用来支持论点的）——<br>「JavaScript 将统治所有软件。」<br>「JavaScript 主导地位的不变性。」<br>「JavaScript 如何成为所有软件事实上的语言。」<br>拿一个老视频，里面有人说最终我们会把一切都编译成 JavaScript，到 2035 年，于是 2035 提前到了。然后再硬拗成这样：浏览器里跑了个东西，而浏览器里也跑 JavaScript，所以预言应验了！<br>我，呃……好吧。）

反驳的一方是从 asm.js 一路做到 WASM 的人，他的切入点是「那个演讲从头到尾讲的就是转译」。

> "Nobody ever claimed that? The whole Birth &amp; Death of JavaScript talk is explicitly about transpiling code from other languages.<br>At the time the transpilation target was (the limited asm.js subset of) Javascript, since WASM didn&#x27;t exist yet, but the overall &quot;transpile everything to run in the browser&quot; still holds." — swiftcoder [c:50627524]
> （译文：谁说过那种话？《JavaScript 的诞生与死亡》整个演讲讲的就是把别的语言转译过来。<br>当时的转译目标是（受限的 asm.js 子集的）JavaScript，因为那时 WASM 还不存在，但「把一切转译到浏览器里跑」这个整体说法仍然成立。）

他后来又补了一条更具体的，指明这个「老视频」到底在讲什么。

> "The &quot;old video&quot; is very specifically talking about asm.js, the direct precursor of WASM.<br>WASM was built because asm.js proved that transpiling native software to the browser was a viable model, and by many of the same people behind asm.js" — swiftcoder [c:50628820]
> （译文：那个「老视频」讲的非常明确就是 asm.js，也就是 WASM 的直接前身。<br>WASM 之所以被造出来，正是因为 asm.js 证明了「把原生软件转译到浏览器」是一条可行的路，而造 WASM 的人里有很多就是 asm.js 背后那批人。）

这场架子的实质，是两组命题被搅到了一起：一边是「JavaScript 终将一统所有软件」，另一边是「浏览器终将成为通用运行时」。trynix 演示的是后一个。至于前一个，在评论区看来，它跟 WASM 没有一毛钱关系。

### 二、Wasm 的血统：asm.js、真字节码，还有「通用运行时」

关于 WASM 到底是什么，有一段相当干净的技术澄清。

> "asm.js was a subset of JS that other languages could be compiled to and was optimized so it would run faster. Ok, it was minified and unreadable, but still JS. WASM is real bytecode, no JS involved anymore." — rob74 [c:50625791]
> （译文：asm.js 是 JS 的一个子集，其他语言可以编译到它，然后被优化得跑得更快。好吧，它被压缩过、读不懂，但它仍然是 JS。WASM 是真正的字节码，已经跟 JS 没关系了。）

> "asm.js is a subset of javascript, Webassembly is its own bytecode format." — Alghranokk [c:50625722]
> （译文：asm.js 是 JavaScript 的子集，WebAssembly 是它自己的字节码格式。）

而 asm.js 那边的历史同样要讲清楚。

> "We ported plenty of existing executable programs to asm.js before WASM was even conceived of - the whole emscripten project was built around this. WASM was designed from the start to be a drop-in replacement for asm.js" — swiftcoder [c:50627476]
> （译文：在 WASM 还没被构想出来之前，我们就已经把大量现成的可执行程序移植到 asm.js 上了——整个 emscripten 项目就是围绕这个建立的。WASM 从设计之初就被定位成 asm.js 的即插即用替代品。）

egeozcan 的补充把「同一个运行时」和「同一门语言」之间的差别说清楚了。

> "Same OS thread, same event loop and it shares its memory, but a completely different runtime. I really love JS but OP has a point.<br>So philosophically yes, its the same thing, but that talk has so much emphasis on something so quirky being the universal runtime. WASM isn&#x27;t JS-level quirky." — egeozcan [c:50625601]
> （译文：同一个 OS 线程、同一个事件循环、共享同一块内存，但运行时完全不同。我很喜欢 JS，但楼主说得有道理。<br>所以从哲学意义上说，是同一件事；但那个演讲有太多篇幅在强调「这么古怪的东西」要当通用运行时。而 WASM 并没有 JS 那种古怪劲。）

### 三、实用性：这是演示，是玩具，还是工具

喜欢这条帖子的人不少，但几乎所有人都承认实用性存疑。

> "While I&#x27;m not sure about the practical utility of this, I love it as a demonstration of what is possible." — Cu3PO42 [c:50625503]
> （译文：我不确定这东西有什么实用价值，但我很喜欢它作为「可能性演示」的意义。）

反对者则指出，这个方向本来就不解决任何人的问题。

> "I know there is some use of webassembly in the browser, but I&#x27;m not sure what the last time I actually used it was. I really hate using the browser if I can avoid it and pretty much everything that can be compiled to webassembly works fine natively.<br>Plus, with LLMs, the advantage of having a single mediocre common ground disappears. Anything with actual user interfaces will benefit from native targeting." — throwaway27448 [c:50625585]
> （译文：我承认浏览器里的 WebAssembly 有些用处，但我说不上上次真正用到它是什么时候。能不用浏览器我就不用，而几乎所有能编译成 WebAssembly 的东西，原生跑也都好好的。<br>而且有了 LLM 之后，「大家共用一个平庸的公分母」这个优势也没了。凡是有真界面的东西，做成原生目标更划算。）

最扎眼的是自己动手试的那几条反馈。

> "None of that thing is loading. I don&#x27;t see anywhere &quot;browser inside a browser&quot;. Do I need 2k EUR of RAM for it?" — lifestyleguru [c:50625798]
> （译文：那东西根本没加载出来。我到处都看不到「浏览器里的浏览器」。难道要 2000 欧元的内存吗？）

> "Firefox launched in about 5 minutes (much of which appeared to be spent downloading dependencies) in Firefox for Android on my phone with 8 GB RAM. It didn&#x27;t react to input, though. Not sure whether that&#x27;s because the CPU is too slow or simply touch input not being wired up." — yorwba [c:50625989]
> （译文：在我手机的 Firefox for Android 上（8 GB 内存），Firefox 启动花了大约 5 分钟（看起来大部分时间花在下载依赖上）。不过它不响应输入。不知道是 CPU 太慢，还是触屏输入根本没接上。）

也有人顺手纠正了一个常见误解：trynix 并不是从零写起的，它只是 unkernel.dev 的一层壳，真正的引擎是 Pooya Parsa 那套。

> "UPDATE: for context, trynix had been around until unkernel showed up and the author switched to it from qemu." — sheepscreek [c:50625701]
> （译文：补充背景：trynix 本来早就有了，直到 unkernel 出现，作者才从 qemu 换过来。）

### 四、Wisp：一个高中生做的、用来绕过校园网络的代理协议

读到这里会注意到，浏览器里的 Linux 想联网，就得有一条出站隧道。作者选的是 Wisp，于是评论区炸了——markasoftware 一口气写了三千多字，从它的出身讲到流控缺陷。

> "Wisp is a component of a sketchy but impressive pre-AI project created by high schoolers to develop state of the art html5 based proxies to bypass restrictions on school networks that block game sites, etc." — markasoftware [c:50625792]
> （译文：Wisp 是一个「不靠谱但令人佩服」的前 AI 项目的组件，这个项目由一群高中生创建，目的是开发基于 HTML5 的顶级代理，用来绕过那些屏蔽游戏网站等内容的校园网限制。）

> "Anyway, WISP is a bad protocol. Its essentially meant to be a very shitty http2-like protocol that multiplexes tcp streams over a single tcp&#x2F;websocket stream." — markasoftware [c:50625792]
> （译文：总之，WISP 是个烂协议。它本质上就是一个「很糙的 http2 类协议」，作用是在单条 TCP/WebSocket 流上复用多条 TCP 流。）

这段插曲的价值在于：trynix 那套图形、声音、网络之所以能跑起来，底下垫着的并不是什么成熟基础设施，而是一群高中生当年为了在校园网里偷玩游戏顺手做的东西。据说他们后来的代理 Scramjet 好到能通过 GeForce NOW 网页串流桌面游戏——用来给浏览器里的 Linux 转发网络流量，其实是最奢侈的一种用法。

### 五、最大的一条支线：JavaScript 到底是不是「癌症」

帖子的正文里那句「JavaScript 将统治所有软件」，把 HN 上积攒多年的私人恩怨全招来了。

> "I think Javascript is so awful, and until recently so prevalent in the roles available to me, that it made me want to not be a Software Engineer anymore. I felt that Javascript was some sort of joke that stayed around long enough until it became a cancer to Software Engineering." — glimshe [c:50625806]
> （译文：我觉得 JavaScript 太糟糕了，而直到最近它在可选岗位里都无处不在，以至于让我一度不想再当软件工程师。我感觉 JavaScript 是个玩笑，开了太久，最后变成了软件工程的一道癌症。）

同一个人的后半段则把 AI 和 JS 摆在了跷跷板的两头。

> "But I feel the complete opposite about AI. In fact, <i>AI brought back the fun that was stolen from my life by Javascript</i>. I&#x27;m now retired and spend a good amount of my day working my own programming projects. And I&#x27;m absolutely happy to vibecode all the Javascript parts (which isn&#x27;t a lot in my projects) so I don&#x27;t ever have to see this damn thing in front of me again." — glimshe [c:50625806]
> （译文：但我对 AI 的感觉完全相反。事实上，AI 把被 JavaScript 从我生活里偷走的乐趣还给了我。我现在退休了，每天花不少时间做自己的编程项目。而我非常乐意把 JS 那部分全部 vibe 掉（我项目里 JS 部分并不多），这样就再也不用看见这玩意了。）

火气最旺的一句是这句。

> "JavaScript is such a curse (or possibly a joke) on humanity" — amosj [c:50625824]
> （译文：JavaScript 真是人类的一场诅咒（或者干脆说是个玩笑）。）

但骂归骂，理由并不总是那么硬。有靠业务痛点说话的。

> "I make living off js, but I have to say, I cane to learn that the most important thing in engineering is consistency. And js before ts and the last years improvements is so inconsistent, to the point it&#x27;s another problem you have to solve that has nothing to do with the real business problems you&#x27;re solving." — yard2010 [c:50627111]
> （译文：我靠 JS 吃饭，但我得说，我慢慢明白工程里最重要的事是一致性。而 TS 之前的 JS、以及这几年的那些改进，实在太不一致了，不一致到你得额外解决一个问题，而这个问题的实质跟真正的业务问题毫无关系。）

为 JS 辩护的人也不让步，理由大致是「你们根本没搞懂它」。

> "People think JavaScript is bad language simply because they never bother to learn how it works. As an example of why JS sucks people often give examples such as &#x27;if you XOR a float and an array you get the string &quot;false&quot;&#x27; as if that operation even makes sense. JavaScript has had for years pretty much the same feature set as every other major equivalent language (like Python)." — xdennis [c:50626124]
> （译文：人们觉得 JavaScript 是门烂语言，只是因为他们从来没打算搞懂它到底怎么工作。举它有多烂的例子时，大家爱说「你把一个浮点数和一个数组做异或，会得到字符串 "false"」，仿佛这个操作本身有意义似的。而 JavaScript 这么多年来，特性集跟其他任何主流同级语言（比如 Python）基本一样。）

> "I think Js is.. okay? I can name some strengths and weaknesses,both of the language itself and the culture&#x2F;ecosystem, but I certainly don&#x27;t hate it." — torginus [c:50626127]
> （译文：我觉着 JS……还行？我能列出它的优点和缺点，语言本身和它的文化／生态都是，但我肯定不恨它。）

amelius 给出了最具体的一条辩护：闭包。

> "Javascript is actually a great language. Its garbage-collected closures made it easy to do GUI programming.<br>The C&#x2F;C++ world where browsers came from didn&#x27;t have this (closures). So it is actually a miracle we got a language as (relatively) great as Javascript." — amelius [c:50626145]
> （译文：JavaScript 其实是门很棒的语言。它那套带垃圾回收的闭包让 GUI 编程变得容易。<br>浏览器诞生出来的那个 C／C++ 世界没有闭包这回事。所以我们能拿到一门（相对）这么出色的 JavaScript，本身就是个奇迹。）

而 lukan 的说法是「丑，但简单，所以赢了」。

> "Javascript is ugly, but simple and got the job done. That&#x27;s the reason for its success." — lukan [c:50626102]
> （译文：JavaScript 丑，但简单，而且把活干成了。这才是它成功的原因。）

资历最老的那位直接给出一条时间线。

> "People hate and bad-talking about languages they haven&#x27;t even used or used briefly. I am writting Javascript since 1997 and the language has evolved and with the TypeScript superset it can scale up without type safety issues." — LytraX [c:50626167]
> （译文：人们憎恶、说坏那些他们根本没用过、或者只用了一下的语言。我从 1997 年开始写 JavaScript，这门语言一直在演进，再加上 TypeScript 这个超集，它可以扩展到很大规模而不存在类型安全问题。）

反方的反击则把 JavaScript 当年的缺点一条条数给 Node 时代的人听。

> "So you chose an environment that was slow, single-threaded, had an immature ecosystem, callback hell, and was difficult to debug. To each their own I guess." — bhaak [c:50626926]
> （译文：所以你选的是一个慢、单线程、生态不成熟、回调地狱、还难调试的环境。每个人自己的选择吧，我猜。）

连「到底该怪谁」都被重新分配了一遍。

> "I felt mostly the same with much of the same career trajectory. But where I differ is I felt like dynamically typed scripting languages as a whole were the cancer that metastasized with the rise of Python as the de facto language chosen for machine learning. I can’t stand Python. JavaScript and its entire ecosystem is filthy but Python is the ultimate Pee Wee’s ball of foil." — cheschire [c:50626121]
> （译文：我的经历大致相同，职业轨迹也差不多。但我不同的地方在于，我觉得真正的那道癌症是动态类型脚本语言这一整类，而它的扩散点，是随着机器学习选 Python 作为事实语言。我受不了 Python。JavaScript 及其整个生态是脏，但 Python 是终极的小丑球——锡箔做的。）

### 六、AI 是不是毁掉了手艺

JS 骂到一半，讨论自然拐到了 AI 上——因为原文里那句「LLM 加速了时间线」，本来就不只是修辞。

> "I would go further, AI destroys the work of people who want to be a master craftsman. Like the Japanese Sushi master, who spends his entire life mastering a skill down to its very small details, reminds me of the book “Zen and the Art of Motorcycle Maintenance”<br>AI is great for those who always wanted to be managers. They can achieve their dream right out of college now, no need to grind for years to reach a managerial position." — sashank_1509 [c:50630906]
> （译文：我还要更进一步：AI 摧毁的是那些想成为手艺人的人的工作。比如日本的寿司师傅，一生都在把一门手艺打磨到极细微处，这让我想起《禅与摩托车维修艺术》那本书。<br>AI 对那些一直想当管理者的人倒是好事，他们现在大学一毕业就能实现梦想，不用熬几年才爬到管理岗。）

回应是用一个类比：不用 AI 就好。

> "Those people can simply not use AI. They probably didn&#x27;t like IDEs either, and it&#x27;s still totally possible to create software with a text editor and a Makefile.<br>I can get furniture by either buying it from someone else, buying a kit from Ikea, or devoting a few decades to learning how to build it myself. None of those choices prevent anyone from choosing differently." — SoftTalker [c:50632449]
> （译文：那些人干脆不用 AI 就行了。他们大概当年也不喜欢 IDE，而且用文本编辑器和 Makefile 写软件照样完全可行。<br>我想要家具，可以买成品，可以买宜家的组装件，也可以花几十年学会自己做。这几个选择都不妨碍任何人做不同的选择。）

反对这种「你自己选」的思路的，是把 AI 和工业化的关系摊开讲的那条。

> "But whatever the opinion is, I think we can all agree that <i>it is destroying something</i>, whether we care or not. Saying &quot;they can simply not use AI&quot; feels like lacking any kind of empathy to me." — palata [c:50632769]
> （译文：不管观点如何，我想我们都能同意：<i>它确实在摧毁某种东西</i>，不管我们在不在乎。说「他们干脆不用 AI 就行」，在我看来是缺少某种共情。）

还有一条更冷的目光：讨论「AI 让程序员少写代码」，但同时也在讨论「AI 让公司里多了一层传话的官僚」。

> "The manager&#x27;s manager got some request through a LLM and passed it down, your manager passed LLM generated questions to a different department, who responded with an LLM answer which resulted in the developer having a LLM written ticket on their board which they will solve with an LLM." — xydone [c:50625926]
> （译文：经理的经理用 LLM 拿到一个需求然后往下传，你的经理把 LLM 生成的问题转给另一个部门，那个部门用 LLM 给出回答，于是开发人员手板上就多了一张 LLM 写的工单，而他们会用 LLM 来解决这张工单。）

palata 那句则是全场最尖的一句归纳。

> "AI destroys the work of those who like to write the code. And it makes it fun for people who don&#x27;t like to code, because they don&#x27;t have to. And you&#x27;re in the second group. Lucky you, I guess." — palata [c:50625999]
> （译文：AI 摧毁了那些喜欢写代码的人的工作。而它让那些不喜欢写代码的人觉得有趣，因为不用写了。你属于第二组。恭喜你，我猜。）

### 七、被埋在最底下的真分歧：闭包、RAII 与 Rust 的生命周期

再往下还有一条更技术的支线，主题是闭包和资源生命周期。这条支线跟 trynix 没什么关系，但它占的篇幅说明了一件事：HN 的语言设计区，斗的是真问题。

> "I think it was the right call by the C++ people to explicitly list what objects are captured and how, even if the syntax&#x27;s not the best.<br>RAII is a fact of life unfortunately, not just in C++ or Rust, but if you talk over some high level protocol over the internet you go  TCP socket-&gt;HTTP connection-&gt;your stream protocol; and have to do the exact reverse.<br>Closures break RAII hard." — torginus [c:50626316]
> （译文：我认为 C++ 那批人明确列出捕获了哪些对象、怎么捕获，是正确的决定，尽管语法不怎么样。<br>可惜 RAII 是现实存在的事实，不光在 C++ 或 Rust 里——你在网络上跑一个高层协议时，走的是 TCP socket → HTTP 连接 → 你的流协议，回程还得原路反着来一遍。<br>闭包严重破坏 RAII。）

Xirdus 认为这属于误解。

> "I&#x27;m confused by the point about RAII. Why are you saying that closures break it? Personally, I found that closures complement RAII very well - the closure owns its resources, and when it goes out of scope they&#x27;re all cleaned up automatically." — Xirdus [c:50626666]
> （译文：我不明白 RAII 那点的意思。你为什么说闭包破坏了它？就我个人经验，闭包跟 RAII 是很好的互补——闭包持有自己的资源，出了作用域就自动清理干净。）

pjmlp 给了折中方案。

> "You can simulate RAII with closures though, that is what the <i>with-something</i> pattern is all about." — pjmlp [c:50627642]
> （译文：不过你确实可以用闭包模拟 RAII，这正是 <i>with-something</i> 这个模式要做的事。）

真正的分歧落在 Rust 的生命周期上：klodolph 和 Xirdus 就「上界能不能表达」吵了四个来回。

> "Rust, unfortunately, lets you express lower bounds on lifetimes but not upper bounds. There is no way in Rust to express “this object must be released by that point in the program,” a guarantee which is extremely useful." — klodolph [c:50629313]
> （译文：遗憾的是，Rust 只能表达生命周期的下界，不能表达上界。在 Rust 里没有办法表达「这个对象必须在程序某处之前被释放」——而这个保证非常有用。）

> "I assure you this is not pedantry or a nitpick. The classic case here is if you want to borrow a local variable inside a thread… you need to ensure that the thread lifetime is bounded from above by the lifetime of the borrowed variable. This is why we have weird workarounds like std::thread::scope. If we could just express an upper bound on lifetime, it wouldn’t be necessary." — klodolph [c:50630221]
> （译文：我保证这不是吹毛求疵、也不是抠字眼。经典的场景是：你想在线程里借用一个局部变量……那就必须保证线程的生命周期从上方被那个被借用变量的生命周期框住。这正是我们会有 std::thread::scope 这种怪异变通方案的原因。要是能直接表达生命周期的上界，就不需要它了。）

qalmakka 把这场争论拉回了更大的图景：GC 不是终点。

> "RAII may be rudimental but it can potentially fix <i>all</i> classes of leaks by introducing deterministic lifetimes and scopes which aren&#x27;t tied with the resource itself." — qalmakka [c:50627813]
> （译文：RAII 也许粗糙，但它有可能修掉<i>所有</i>种类的泄漏——办法是引入确定的生命周期和作用域，而它们不与资源本身绑定。）

支线里还夹着一段 Go 社区的旧案：anal_reactor 因为当年在 Go 社区说「语言不该无理由偏离既有标准」而被驱逐，理由是他嫌 `go` 这个词被英语单词霸占了。

> "I was banished from golang communities when I said that a language should deviate from already established standards only when it has a good reason to do so." — anal_reactor [c:50626651]
> （译文：当年我说「一门语言只有在有充分理由时才应该偏离既有标准」，然后就被 Go 社区驱逐了。）

> "I have plenty of issues with how much of a giant leap backward in expressiveness golang represents, but your entire contribution was to troll the golang communities about the language&#x27;s name.  You deserved the ban." — chuckadams [c:50628952]
> （译文：Go 在表达能力上退步得这么厉害，我有一大堆意见；但你的全部贡献就是在 Go 社区里 troll 这个语言的名字。你被封是该的。）

### 八、附带收获：作者和 CNN 那位同名记者不是一个人

> "There is a guy on CNN with the same name. And I initially was surprised that his blogs were making the rounds here. Turns out to be a completely different Farid Zakaria.<br>I was reminded of that scene from &quot;Office Space&quot;, where the character Michael Bolten laments about having to share his name with a &quot;no-talent ass clown&quot;." — cheema33 [c:50630968]
> （译文：CNN 上有个人跟他同名。所以我一开始看到他的博客在 HN 上流传时挺惊讶的——结果完全就是另一个 Farid Zakaria。<br>这让我想起《办公室空间》里的一个场景，角色 Michael Bolten 抱怨自己不得不跟一个「没本事的小丑」共用同一个名字。）

这条没什么可争的，却说明了一件事：作者在这个社区里是被当作「技术博客写手」在追更的，而不是什么新闻人物。同一批评论里还有人说「Farid 最近产率惊人」，以及顺着这篇去翻他别的博客。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 「2035 提前」是偷换概念 | boxed / llm_nerd | 预言说的是 JS，演示的是 WASM，标准被挪了 |
| 演讲讲的就是「把一切转到浏览器」 | swiftcoder | asm.js 是 WASM 的前身，路线本身没变 |
| WASM 是真字节码，跟 JS 无关 | rob74 / Alghranokk / egeozcan | 同一个运行时不等于同一门语言 |
| 这是演示，不是有用的工具 | throwaway27448 / Cu3PO42 | 实用价值存疑，但把可能性摊开了 |
| 实测很慢，很难用 | lifestyleguru / yorwba | 手机上启动 5 分钟，还不响应输入 |
| trynix 只是 unkernel 的壳 | sheepscreek | 真正干活的是 Pooya Parsa 的引擎 |
| 底下垫着高中生的野路子协议 | markasoftware | Wisp 用来绕过校园网，流控还有缺陷 |
| JS 是毒瘤 | glimshe / amosj / yard2010 | 让人不想当工程师，代价大于收益 |
| JS 被冤枉了 | xdennis / torginus / amelius / LytraX | 没人搞懂就骂；闭包让 GUI 编程变简单 |
| JS 丑但简单，所以赢了 | lukan | 它的成功来自简单，不来自优雅 |
| Node 时代选错了环境 | bhaak | 慢、单线程、回调地狱、难调试 |
| AI 摧毁了手艺 | sashank_1509 | 寿司师傅式的精工被替代 |
| 不用 AI 就好 | SoftTalker | 就像你可以自己造家具 |
| AI 确实在摧毁某种东西 | palata | 与其喜不喜欢，不如承认它在拆什么 |
| AI 只是多了一层传话官僚 | xydone | 工单由 LLM 写，也由 LLM 解决 |
| 闭包破坏 RAII | torginus / pjmlp / Xirdus | 捕获语义与资源生命周期之争 |
| Rust 表达不了生命周期上界 | klodolph / Xirdus | std::thread::scope 就是被逼出来的变通 |

## 总体情绪

这场讨论最有意思的地方，是它的重心几乎没有落在那篇文章的主体上。trynix 到底能不能跑、有多快、嵌套 Firefox 是不是真的——这些问题加起来占的篇幅不到四分之一。剩下的部分被两件事瓜分：一是「JavaScript 到底是不是癌症」这场持续了三十年的老账，二是「AI 是不是在毁掉手艺」这场刚开始的新账。原文那句「JS 将统治所有软件」，等于把两个火药桶同时点着。

而真正被讨论得最多、最细的那个问题——Wasm 和 JS 到底是什么关系——反而是最没有争议的技术问题：asm.js 是前身，WASM 是它的字节码后代，演讲讲的是转译路线，这三条一摆出来就没什么可争的了。剩下能争的只剩「统一运行时」和「统一语言」是不是同一件事，而大多数人在这一点上其实各说各话。

最后那句吐槽给这场讨论定了调：作者 Farid Zakaria 和 CNN 上那位同名记者完全是两个人，还有人想起了《办公室空间》里那个抱怨自己要跟一个「没本事的小丑」同名的桥段。帖子本身，则像是 2035 提前到来的一个小小注脚——预言说的是让全世界写 JavaScript，而真正提前到来的，是让全世界在浏览器里跑 Linux，顺便还捎带了一个由高中生为绕过校园网而发明的代理协议。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | 2035 came early（HN 主帖） | <https://news.ycombinator.com/item?id=50624497> |
| 2 | 2035 came early（Farid Zakaria 博客原文） | <https://fzakaria.com/2026/11/23/2035-came-early> |
| 3 | trynix.dev（浏览器里的 Nix 运行时） | <https://trynix.dev/> |
| 4 | unkernel.dev（Linux 编译到 WebAssembly） | <https://unkernel.dev> |
| 5 | The Birth & Death of JavaScript（Gary Bernhardt 演讲） | <https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript> |
| 6 | nixpkgs-multiverse：每一个曾经存在过的版本 | <https://fzakaria.com/2026/08/09/nixpkgs-multiverse-every-version-that-ever-existed> |
| 7 | Wisp protocol（MercuryWorkshop） | <https://github.com/MercuryWorkshop/wisp-protocol> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 978 分，归档快照 2026-11-25 03:58 UTC，入库 106 条评论，原帖累计 370 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，截取的段落均为归档评论中的连续片段，归档中的 `<p>` 与换行以 `<br>` 呈现，其余 HTML 实体按归档原文保留。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文概要中的事实（trynix.dev 可运行 30 万个以上 Nix 包版本、2026-11-19 发布 unkernel.dev、2026-11-20 在 TacoSprint Discord 频道得知并切换引擎、相对 qemu-wasm 快 2 倍至 32 倍、wland 合成 Wayland 界面、仅带 virgl 驱动的最小 Mesa 构建经 WebGL2 渲染、ALSA 声卡与 espeak-ng 语音、TCP 连接经 WebSocket 送到 Wisp 中继、嵌套 Firefox 用时 4 小时以上及内层关 JIT／中层无 GL／外层用笔记本 Wisp 中继等）均取自归档的原文正文。原文引用的 Gary Bernhardt 演讲《The Birth & Death of JavaScript》与 Jeff Atwood 2009 年的断言，以及 nixpkgs-multiverse、Wisp protocol、wland 等外部链接，均由原文正文给出。

评论者给出的第三方数据与主张（包括「qemu-wasm 慢到偏奇观」「演讲当年指的是 asm.js」「WISP 流控设计存在缺陷」「Go 社区封禁事件」等）由评论者自行给出，本文未逐条核实。文中所有判断与立场均属于原文评论者，归纳与判断由本文完成。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
