---
layout: post
title: >-
  终端边框不占格子了：Ratatui 维护者把线条画在单元格边缘 — HN 讨论摘要
date: 2026-11-15
hn_id: 50491423
categories: [articles]
excerpt: >-
  终端里的边框一直是字符，字符就意味着占格子。Ratatui 维护者 joshka 做了个补丁，
  把边框变成单元格属性：每个格子最多承载 12 段线条，画在格子边缘而不是格子中央。评论区一半在夸好看，
  一半在问——既然都要动终端协议了，为什么不干脆重写整个终端。
tagline: >-
  为了省下一格边框，他们打算改写整个终端。
---

> 来源：HN 讨论主帖 [Terminal borders that don't cost a cell](https://news.ycombinator.com/item?id=50491423)（312 分，136 条评论），指向 joshka 的博客 [joshka.net/cell-borders](https://www.joshka.net/cell-borders/)。本篇为 single post 模式。主帖抓取于 2026-11-14 13:07 UTC，入库 111 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。归档文章正文为博客前 8000 字符，其后的 Styles and joints 章节未入库。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

终端里的边框从来都是字符。Unicode 的 Box Drawing 区（U+2500–257F）提供了 128 个画线、转角、接头的字形，但每个字形都要占满一整格。Ratatui 维护者 joshka 在自己 16 寸笔记本上的终端大概是 200×50，列数还够，行数不够——布局里嵌两层面板，光边框就能吃掉 50 行里的 6 到 8 行。字符边框还有两个更麻烦的毛病：圆角字符只有一个背景色，面板底色和周围不一致时，每个角上会留下一小块错色的方块；框里选中一段文字复制出去，粘到聊天窗口还会带上那根竖线，于是人人都会做一遍「擦竖线」的动作。

他的解法是引入一种新的终端协议：在单元格的边缘画细线，而不是在格子里摆字符。一格最多携带 12 段线条——四条边的两半，加上从格子中心伸出的四条臂，每段有自己的颜色、粗细、位置和样式，终端把它们叠在格点网格上绘制。边框存在格子里，所以滚动、擦除、插入、reflow 的行为跟背景色一样，早就有现成答案。边之所以拆成两半，是为了和 `▖▗▘▝` 这类象限块字符对齐——可以先在离网格半格的位置画一个形状，再给它套上规整的边框。

实现有两条：给 Ghostty 打的补丁，以及更早的 Rio PR #1947；demo 用 Ratatui 写——一个平铺窗口管理器，标签挂在面板上边缘、输入框直接在文字底下画下划线、按钮只有一行高；还有一个设置表单和图表 demo，btop 那种 braille 点阵图里，网格线和平均线可以画在点与点的缝隙上，不必再让出一行。终端不支持这套协议时回退到 box-drawing 字符：面板每边少一行一列，日志区少两行，文字的换行位置也变了。作者是 Ratatui 的维护者 joshka（他在评论里提到自己此前在 OpenAI 参与过 Codex TUI），帖子开头明确写了「这篇东西（和背后的代码）大量借助 AI 完成，不打算为此道歉」。

帖子发出后，讨论很快分成几条线：有人嫌省掉格子之后边框「没有呼吸空间」，有人觉得圆角按钮更顺眼；更多人问的是更根本的问题——如果终端协议都要改，那为什么不直接做一个为界面而生、信息密集的单色终端？也有人指出替代路线早就存在（overstrike、SGR 53/55），多路复用器 tmux 会不会把新序列丢掉，CJK 用户在双宽渲染下会不会被错位。最后还有一条副线：作者在开头披露用了 AI，评论区因此吵起「这算不算 slop」。

## 讨论焦点

### 一、省下来的那一格，是不是真的省下来了

先说直觉上最正面的反应。

> "This is gorgeous and I need it in trunk for both kitty and ghostty" — ganelonhb [c:50492263]
> （译文：这太漂亮了，我需要 kitty 和 ghostty 都尽快合进主干。）

但审美上的反对意见同样具体：省下格子之后，边框贴着内容，就不再有「留白」这回事了。

> "I appreciate the innovation happening with TUIs in these modern times.  But, aesthetically, I have to say, I like my borders to have some breathing room, which gets lost in this particular treatment." — montroser [c:50491626]
> （译文：我很欣赏当下 TUI 方面的这些创新。不过从审美上说，我更喜欢边框周围留一点呼吸空间，而这种处理方式把这一点抹掉了。）

同一位用户后来补充了更实际的理由——边框是要花屏幕的，所以必须省着用。

> "Borders costing a cell means you are forced to be frugal with them, lest you run out of space or have to do ugly and clumsy &quot;pwease make ur window biggr :3&quot; messages" — wpm [c:50495219]
> （译文：边框要花一格，就意味着你必须对它省着点，不然要么空间不够，要么就得打出「求求你把窗口开大一点 :3」这种又丑又笨的消息。）

有意思的是，反对者自己也承认这套东西有它的道理：

> "I kinda like the examples without the native borders…<p>The charm of the terminal is that you can do whatever you want, as long as it fits in one cell." — pkulak [c:50493993]
> （译文：我有点喜欢没有原生边框的那些例子……<p>终端的魅力就在于，你想怎么折腾都行，只要它能塞进一个格子。）

这句话正好点出这套方案的位置：它不是要取代字符，而是给字符做不到的事情补一块。评论区里也真有人给出了具体用法——markdown 表格不用再为分隔线让出格子。

> "Having markdown tables render with zero-cell spacing (use underlines for horizontal and different background shades for vertical) is just one of the billion reasons I will never, ever, ever go back to closed-source coding agents." — octoberfranklin [c:50493180]
> （译文：markdown 表格能以零间距渲染（横向用下划线，纵向用不同深浅的背景色），这只是我永远、永远、永远不会回到闭源编码 agent 的无数个理由之一。）

### 二、更大的野心：既然要改协议，为什么不重写整个终端

讨论最激烈的一段，是 tptacek 提出的那个问题。

> "I love this work and everything else Ratatui does but I have to ask: if you&#x27;re changing the terminal protocol and the terminal itself to do this, why not do something more ambitious; a full monospaced information-dense UI framework, a terminal <i>designed</i> for user interfaces, rather than one designed to replicate the limitations of dumb terminals?" — tptacek [c:50491720]
> （译文：我很喜欢这个工作，也喜欢 Ratatui 做的其他一切。但我得问一句：如果你为了做这个已经在改终端协议、也在改终端本身，那为什么不做得更彻底一点——一个信息密集的完整单色 UI 框架，一个为界面而设计的终端，而不是一个用来复刻 dumb terminal 局限的终端？）

作者的回答是：标准已经堆成山，不如整个掀掉重来，写成一套语义协议。

> "Yep,and I want to do that too :)<p>I&#x27;ve written about it before, but in brief the mountain of standards is worth ripping out wholesale and doing write as a semantic protocol. It&#x27;s needed to solve several things that work really poorly in terminals because their unit of compatibility is cells rather than a higher primitive. It&#x27;s hard to bake something on top that works well." — joshka [c:50492355]
> （译文：对，我也想做那个 :)<p>我以前写过这件事，简单说就是：这座标准的山值得整个掀掉，改写成一套语义协议。终端里有些事情做得非常差，根子在于它的兼容单位是「格子」而不是更高的抽象；在这种地基上再堆东西，是很难堆好的。）

他把最痛的几处点得很具体：无障碍、文本换行、滚动缓冲区（让 scrollback 可编辑、而不是一堆死文本）。至于「这很难吧」这种反对，他直接指向 Codex、Gemini、Claude 等项目里那些几个月都没解决的 issue——闪烁、滚动、按键处理、IME。

> "I think I mostly just want to see someone do it so I can see what it looks like; it just feels like something that should exist. You&#x27;re taking baby steps towards it! :)" — tptacek [c:50493012]
> （译文：我主要是想看到有人真把它做出来，这样我能看到它长什么样；它就是那种「应该存在的东西」。你正在朝那个方向迈小步！:)

也有人不接这个茬。限制之所以是限制，正是终端的价值所在。

> "I can only speak for myself but I use the CLI and TUIs specifically because of the limitations those modalities impose on software that uses them as the primary method for interfacing with the end user. If you want a full featured UI and all that comes with it why not just use QT or GTK or modern HTML or etc?" — fc417fc802 [c:50492342]
> （译文：我只能代表我自己说话，但我用 CLI 和 TUI，恰恰是因为这些形态对软件施加了限制，而软件正把它们当作面向终端用户的主要交互方式。你要是想要功能齐全的界面和随之而来的一切，为什么不干脆用 QT、GTK 或者现代 HTML 之类的？）

真要动土，这类工程提案先要一份问题说明书。

> "... Write up a more complete spec of the problem and I could be tempted to throw some tokens at it. But before I do, can you write up a more complete description of the problem with existing terminal protocols? I don&#x27;t think I understand the issues well enough to make a good solution." — josephg [c:50494001]
> （译文：……你把这个问题写一份更完整的问题说明书，我或许会被吸引过来投点资源进去。但在那之前，你能先用现有终端协议把这个问题描述得更完整一点吗？我觉得自己对这些问题的理解还不够深，做不出好的方案。）

作者也认领了这条：语义层他写过，但问题说明书还没写。

### 三、HTML over SSH，以及「终端正在变成浏览器」

另一种更省事的思路是：干脆别修终端，把网页送过去。

> "What if, dare I say it, we just served HTML over ssh, and let the browser render a proper UI, instead of layering hacks on top of hacks?" — 0c3ca83 [c:50491755]
> （译文：我说句可能不太受欢迎的：如果我们干脆把 HTML 通过 ssh 服务出去，让浏览器渲染一个像样的界面，而不是在 hack 之上再叠 hack 呢？）

反驳者指出，HTML 本身就是 hack 叠 hack。

> "Afraid that’s a contradiction. In this role, HTML <i>is</i> a pile of hacks upon hacks that was not originally intended for UIs.<p>But, yeah, people are trying to reinvent GUIs. By layering hacks over TTYs. If only there’d be some protocol for widgets and events over a stream connection…" — drdaeman [c:50491796]
> （译文：恐怕这是个自相矛盾的说法。在这个角色里，HTML <i>就是</i>一堆叠着 hack 的 hack，它本来就不是为界面设计的。<p>不过确实，人们在试图重新发明 GUI，方式是在 TTY 之上继续叠 hack。要是有一个能在流连接上传输控件和事件的协议就好了……）

那位提问者并不买账，把话题引到了更缺的东西上：一个真正高层、能自己排版的协议。

> "what we are missing is a really high level protocol&#x2F;system that takes really high level data and figures out the presentation on its own.<p>take a list of files for example. you can run <i>ls -l</i> in a terminal and it will attempt a crude text based formatting of the output. or you can run a full gui filemanager.<p>what if there was a command that would produce ls output as a table data structure, run in a sort of terminal that knows how to format a table nicely without the ls command having to include any formatting instructions?" — em-bee [c:50492310]
> （译文：我们真正缺的是一套很高层的协议／系统：它接收高层数据，然后自己决定怎么呈现。<p>拿文件列表来说。你可以在终端里跑 <i>ls -l</i>，它会尝试用粗糙的文本方式排版输出；你也可以直接跑一个图形界面的文件管理器。<p>那如果有一个命令，把 <i>ls</i> 的输出产出成一张表的数据结构，再交给某种懂排版的终端，由终端自己把表格排漂亮，而命令本身完全不带任何排版指令呢？）

这个想法当场被拆了台：把 <i>ls</i> 的输出变成机器可读，本身就是多余的复杂度。

> "Because that&#x27;s just complexity for its own sake. What&#x27;s simpler is to just create a shell alias for a particular view you want. The shell is for interactive usage, with some capabilities for automation. If something better is needed, you write a real program for it." — skydhash [c:50493099]
> （译文：因为那只是为复杂而复杂。更简单的做法是为你想要的某个视图写个别名。shell 是用来交互使用的，也具备一定的自动化能力；如果需要更好的东西，那就为它写一个真正的程序。）

「终端正在变成浏览器」这个担心也被摆上台面。

> "As awesome as this is, but I can&#x27;t shake the feeling terminals are becoming lightweight browsers..." — matheusmoreira [c:50493761]
> （译文：这东西固然 awesome，但我总觉得终端正在变成轻量浏览器……）

而确实有人在做类似的事——把界面做成终端里的 SPA：程序向终端申请一个「视图」，双方在普通字节流里交换几条小消息，不开端口、不多开连接，所以在没有 GPU 的机器上走普通 ssh 就能用。

> "The SPA itself is a set of Lua scripts that runs in a sandbox inside the terminal. The application on the host that communicates with the SPA can be implemented in any language (preferably Lua to keep it simple). With this approach, all SPAs (plugins) adhere to the user&#x27;s color palette preferences." — tdgunes [c:50495725]
> （译文：这个 SPA 本身就是一组 Lua 脚本，在终端内部的沙箱里运行；宿主机上和它通信的程序可以用任何语言实现（最好也用 Lua，简单些）。这样一来，所有 SPA（插件）都会遵循用户自己的配色偏好。）

不过这条路的历史包袱也很清楚：X11 转发那条老路，当年就是被延迟拖垮的。

> "However, most X11 apps will have utterly abysmal performance on WAN SSH connections. Ancient apps will be slow because they block waiting for every response (this is unavoidable in Xlib) and less than ancient apps will be slow because they send full pixel data." — cowlevel [c:50496325]
> （译文：不过，多数 X11 程序在广域网的 ssh 连接上性能会糟糕透顶。老程序慢，是因为它们阻塞着等每一个回应（这在 Xlib 里无法避免）；没那么老的程序慢，是因为它们直接传全量像素数据。）

### 四、另一条技术路线：overstrike 与 SGR 53/55

有人提醒：想在字符上画线这件事，老早就有人做过了。

> "A much better alternative to this would be to for more terminal emulators to implement overstrike mode (DECSET 20, as available on the VK100). That way you could just draw border characters over existing text cells to achieve the same thing.<p>Unfortunately mintty is the only terminal emulator I&#x27;m aware of which supports overstrike [0], as this would open up a world of new possibilities for TUI apps if more widely supported." — joouha [c:50491778]
> （译文：更好的替代方案，是让更多终端模拟器实现 overstrike 模式（DECSET 20，VK100 上就有）。这样你只要用边框字符覆盖已有的文本格子，就能达到同样的效果。<p>可惜据我所知只有 mintty 这一个终端模拟器支持 overstrike [0]，要是能广泛支持，对 TUI 应用来说会打开一个全新的世界。）

overstrike 的软肋也被指出来了。

> "I’m not against overstrike, but I can think of one drawback of that solution: it becomes significantly harder to have rounded corners with a filled interior.<p>But I’m not trying to argue for nor against either solution." — hnlmorg [c:50491891]
> （译文：我并不反对 overstrike，但我想得到它的一个缺点：用这个方案要做带填充的圆角会难得多。<p>不过我不是要在两个方案之间站队。）

两边各有拥趸，也有人给出第三条路——标准的 SGR 序列。

> "which is much more different than mitty&#x27;s Control Sequence, but supports much more emulators" — NSPG911 [c:50495492]
> （译文：这跟 mintty 的控制序列差得挺多，但支持它的模拟器多得多。）

### 五、tmux 拦得住吗：CSI、DCS 和 APC

这套边框用 DCS 序列下发，于是多路复用器成了焦点。质疑来自一个很实用的观察。

> "Why wouldn’t this work over tmux? The authors claims don’t make a whole lot of sense because if this were a cell property, like any other CSI, then it’ll get rendered in the terminal emulator exactly as intended." — hnlmorg [c:50491858]
> （译文：为什么这在 tmux 下不行？作者的说法不太说得通：如果这是一个像其他 CSI 一样的格子属性，那它就应该像设计意图那样被终端渲染出来。）

作者的答复分两层：tmux 会丢弃自己不认识的 DCS；即便保留，每个格子多一份状态，得由终端自己去跟踪和重绘。

> "Tmux drops DCS that it doesn&#x27;t know like this. That aside, this is extra state per cell that needs to be tracked, handled, understood from a rendering perspective etc. It can work, but would require maybe a thousand lines of code or so to support storing and handling state, redraw etc. and all the various edge cases." — joshka [c:50492475]
> （译文：tmux 会丢弃它不认识的 DCS，就像这个。除此之外，这是每格多出来的一份状态，需要被跟踪、处理、从渲染角度理解等等。它能跑通，但大概需要一千行左右的代码来支持状态的存取与重绘，以及各种边界情况。）

这条又被顶了回去——tmux 其实不丢 CSI、OSC 和 APC，而且既然是格子属性，CSI 才是更合适的位置。

> "Really? That surprises me. Not saying it’s untrue, just that I’m surprised. I’ve found tmux doesn’t drop CSI, OSC nor APC.<p>I wouldn’t recommend APC because Apple Terminal doesn’t follow spec with APC parsing (one of the reasons I switched some of my custom sequences from APC to OSC).<p>Regarding the extra state to be tracked, tmux wouldn’t handle that cell state. That would be down to the terminal emulator.<p>Since these are cell properties, it does feel like CSI would be the right place (like Kittys undercurl)." — hnlmorg [c:50495422]
> （译文：真的？这让我意外。我不是说它不对，只是意外。我实测下来 tmux 不会丢 CSI、OSC 也不丢 APC。<p>我不建议用 APC，因为 Apple Terminal 不按规范解析 APC（这也是我把一部分自定义序列从 APC 换成 OSC 的原因之一）。<p>至于要跟踪的那份额外状态，tmux 不会处理每格的这些状态，那是终端模拟器的事。<p>既然这些是格子属性，CSI 确实是更合适的位置（就像 Kitty 的 undercurl）。）

### 六、CJK 用户会先撞上什么

这一段是全场技术密度最高的地方，来自一位把 Unicode 宽度问题讲透了的评论。

> "One benefit worth calling out: the box-drawing fallback is worse than it looks for CJK users. U+2500-257F and the half&#x2F;full block elements are East Asian &quot;Ambiguous&quot; in UAX #11, so in a terminal configured to render ambiguous as double width (xterm&#x27;s cjkWidth, iTerm2&#x27;s checkbox) every line glyph takes two cells and the whole frame lands in the wrong place. Cell borders aren&#x27;t text, so that failure class just disappears." — favori995749721 [c:50493340]
> （译文：有一点值得单独拎出来：对 CJK 用户来说，box-drawing 回退方案比看上去更糟。U+2500–257F 以及半块／全块元素在 UAX #11 里属于东亚「Ambiguous」，在把 ambiguous 渲染成双宽的终端里（xterm 的 cjkWidth、iTerm2 的那个勾选框），每个画线字形都会占两格，整个框就落错了位置。而 cell border 不是文本，这一类失败直接消失了。）

他还在追一个更要命的问题。

> "Does the border attach to the cell or to the grapheme cluster?" — favori995749721 [c:50493340]
> （译文：那么，边框是挂在格子上，还是挂在字素簇上？）

在他的展开里，现状是：CJK 字符占两格外加一个续位占位符，组合符号和 ZWJ emoji 序列占几格取决于你问谁的 `wcwidth` 表，程序和终端经常在 Unicode 版本上各执一词——今天表现为竖线偏一列，换成 cell border，就变成线没能顶到角上。

### 七、AI 写的算不算 slop

作者在开头披露用了 AI，这成了评论区一条独立的支线。

> "“That don’t cost a cell.” Can’t stand AI bro speak." — movingimage [c:50493319]
> （译文：「『那不花一个格子。』」受不了这种 AI 兄弟的说话腔。）

> "I probably missed on something, but I stopped there" — charles_f [c:50492857]
> （译文：我大概漏看了什么，但我看到那句就关掉了。）

也有人读完文章后改了主意。

> "Normally I would too, but after reading the article, I really don&#x27;t have any complaints. Disclosure is appreciated too.<p>Whatever the author is doing works reasonably well to be readable and inoffensive." — oasisbob [c:50494336]
> （译文：通常我也会这样，但读完整篇文章之后，我确实没什么可抱怨的。披露这件事本身也值得肯定。<p>作者在做的事效果相当不错，读起来没问题，也没冒犯到人。）

作者自己也承认，披露带来了额外的麻烦。

> "It&#x27;s kind of funny, I posted this here and there at similar times. Expected to be spam flagged there due to the anti-AI brigade, but my submission here was the one that actually got hit (likely because I disclosed AI use in the post body is my guess)." — joshka [c:50492651]
> （译文：说来也有点好笑，我差不多同时在两边发了这篇。预期会被那边因为反 AI 阵营举报成垃圾帖，结果真正挨打的是这边这一篇（我猜是因为我在正文里披露了用 AI）。）

更大的争议其实在措辞上。有人在同一篇里既夸方案，又骂它像生成物。

> "One of the top 5 &quot;smells&quot; of LLM generated websites that I can&#x27;t stand is everything has to have its own round-rect. Everything in a box. Every button, label, header, subheader, so much fucking <i>noise</i> everywhere. You shouldn&#x27;t need that many." — wpm [c:50495219]
> （译文：我最受不了的 LLM 生成网页五大特征之一，就是什么东西都得配一个圆角矩形。什么都在框里，每个按钮、标签、标题、副标题，到处都是他妈的<i>噪音</i>。你根本不需要那么多。）

也有人把这场口水战本身当成了问题。

> "Same here. Alas, it&#x27;s the zeitgeist that everything runs along tribal or political lines these days, but it doesn&#x27;t have to be that way.<p>I like seeing different points of view, and maybe controversial topics should be discussed (<i>) more than others, not less." — hobo123 [c:50495394]
> （译文：我也一样。唉，如今什么东西都沿着部落或政治的界线走，这是时代的氛围，但它本不必如此。<p>我喜欢看到不同的观点，也许有争议的话题应该被讨论得（<i>）比其他话题更多，而不是更少。）

以及那句被反复引用的吐槽——AI 时代的产品反而不适应 1972 年的电传终端。

> "It&#x27;s amusing that the flagship products of the post-2023 AI era can&#x27;t fully handle 1972s teletype interfaces :-)" — oblio [c:50496057]
> （译文：挺有意思的，2023 年后 AI 时代的旗舰产品，反而没法完整支持 1972 年的电传终端接口 :-)

### 八、能不能落地：内存、兼容、采用率

最后是工程账。第一个问题很朴素——这东西费内存吗。

> "Nothing really - Ghostty has a bit of padding that&#x27;s unused per cell - 16 bits. The implementation stores an ID into a lookup table with border combinations. If all of those were used and never cleaned up, 65535 at around 100 for each combination used, order of magnitude 25MB absolute worst case assuming no real optimization in place for this." — joshka [c:50492548]
> （译文：基本不费——Ghostty 每个格子有一些没用上的填充位，16 位。实现上是把边框组合的 ID 存进一张查找表。假设所有组合都被用到而且从不清除，65535 个组合、每个大约 100 字节，在完全不做优化的情况下，最坏情况也就是 25MB 这个量级。）

第二个问题是兼容性，而这也是最多人泼冷水的地方。

> "Compatibility will always be the hard part with new standards like this. Given that most terminals already have some special handling of box drawing characters, I don&#x27;t know if it&#x27;s completely dead on arrival for implementors, but I don&#x27;t love as an application author with ratatui, not knowing how the padding on my app will look. I might honestly rather disable this and know it&#x27;ll be more consistent, than enable it and fragment my UI." — nixpulvis [c:50493939]
> （译文：兼容性永远是这类新标准最难的部分。鉴于多数终端对 box drawing 字符已经有一些特殊处理，我不知道对实现者来说这是不是一出生就死了；但作为 Ratatui 的应用作者，我不喜欢不知道自己的 app 的留白在别人屏幕上会是什么样。说实话我宁愿关掉这个功能、知道效果一致，也不想开启它然后让自己的 UI 支离破碎。）

作者把话说得很清楚：Ratatui 那边的改动只是 PoC 分支，甚至不在 Ratatui 仓库里；能进 Ghostty、Rio、Kitty，Terminal.app 永远不可能。

> "The ratatui change was a pure PoC, isolated branch, my own fork, not the ratatui repo even. This would likely never ship as a default approach as it would be way too breaking." — joshka [c:50494013]
> （译文：Ratatui 那边的改动纯粹是 PoC，放在一个隔离的分支上，是我自己的 fork，甚至都不是 Ratatui 仓库里的东西。这种做法作为默认方案大概永远不会发布，因为破坏性太大了。）

> "But yeah, compat is key. It would probably go out to ghostty, rio, kitty pretty easily, terminal.app never, other terminals much slower." — joshka [c:50494013]
> （译文：不过兼容性确实是关键。它大概很容易就能进 Ghostty、Rio、Kitty，Terminal.app 永远不会，其他终端会慢很多。）

即便是 Ratatui 的前维护者，也只肯给出一句「会有阻力」。

> "I used to be an active maintainer for Alacritty. I expect uphill resistance to this there, though that won&#x27;t surprise anyone who uses it." — nixpulvis [c:50494092]
> （译文：我以前是 Alacritty 的活跃维护者。我预感那边会有阻力，不过用过它的人都不会觉得意外。）

质疑者的总结更干脆。

> "This is pretty cool but this does feel like we are just reinventing another GUI display at this point." — kodoman [c:50492598]
> （译文：这挺酷的，但总感觉我们只是在重新发明另一种 GUI 显示方式。）

而那条最实际的反驳，来自一个天天跟终端较劲的人。

> "Do they? Last time I checked you still couldn&#x27;t select text via the keyboard in the Claude Code TUI." — nottorp [c:50495547]
> （译文：它们会发现吗？我上次看的时候，你在 Claude Code 的 TUI 里还是没法用键盘选中文本。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 想要进主干 | ganelonhb | kitty 和 ghostty 都该尽快合 |
| 审美上要有留白 | montroser | 贴着内容的边框少了呼吸空间 |
| 省格子能防手滑 | wpm | 边框费格子，就该被省着用 |
| 终端的魅力在格子内 | pkulak | 只要塞进一格，你想怎么折腾都行 |
| 零间距 markdown 表格 | octoberfranklin | 不为分隔线让格子，就不用回闭源 agent |
| 改协议不如重写终端 | tptacek | 为什么不做一个为界面而生的终端 |
| 语义层才是解法 | joshka | 掀掉标准的山，改写成语义协议 |
| 限制正是终端的价值 | fc417fc802 | 我用 CLI 就是因为它施加限制 |
| 先写问题说明书 | josephg | 描述清楚问题，才谈得上方案 |
| HTML over ssh | 0c3ca83 | 把网页送过去让浏览器渲染 |
| HTML 本身就是 hack 堆 | drdaeman | 它本来就不是为界面设计的 |
| 缺的是高层协议 | em-bee | 让终端自己把表格排漂亮 |
| 别为复杂而复杂 | skydhash | 写个 alias 不就行了 |
| 终端在变成浏览器 | matheusmoreira | 总觉得终端正朝轻量浏览器走 |
| APC 帧走普通 ssh | kalaomer | 程序申请视图，双方在字节流里交换消息 |
| SPA 沙箱统一配色 | tdgunes | 插件都跟着用户的配色偏好走 |
| X11 转发被延迟拖垮 | cowlevel | 老程序阻塞等回应，广域网下惨不忍睹 |
| overstrike 更优雅 | joouha | DECSET 20 早就有，可惜只有 mintty 支持 |
| overstrike 难做圆角 | hnlmorg | 带填充的圆角会难得多 |
| cell border 更精准 | zem | 针对性强，overstrike 听着就乱 |
| SGR 53/55 另一条路 | NSPG911 | 标准序列支持的模拟器多得多 |
| tmux 拦不住 CSI | hnlmorg | 我实测 tmux 不丢 CSI、OSC、APC |
| 每格多一份状态 | joshka | 支持起来大概要一千行代码 |
| CJK 双宽会错位 | favori995749721 | Ambiguous 宽度让整个框落错位置 |
| 边框挂在格子还是字素簇 | favori995749721 | 这是要提前定下来的规范问题 |
| AI 腔调被反感 | movingimage | 这种说话腔受不了 |
| 读完文章没有不满 | oasisbob | 披露本身也值得肯定 |
| 披露招来举报 | joshka | 反 AI 阵营把我这篇打了举报 |
| slop 有具体特征 | wpm | 什么都要一个圆角矩形 |
| 讨论要基于事实 | hobo123 | 部落化可以，但别相互指责 |
| AI 产品反噬电传终端 | oblio | 旗舰产品处理不了 1972 年的接口 |
| 内存代价可忽略 | joshka | 16 位一格，最坏 25MB 量级 |
| 兼容性是死穴 | nixpulvis | 宁愿关掉，也不要 UI 支离破碎 |
| 只是 PoC 分支 | joshka | 不在 Ratatui 仓库里，破坏性太大 |
| 阻力来自实现者 | nixpulvis | Alacritty 那边肯定有阻力 |
| 又在重造 GUI | kodoman | 总感觉只是换个方式重画界面 |
| TUI 仍有硬伤 | nottorp | Claude Code 的 TUI 里还选不了文本 |

## 总体情绪

这一帖的分歧并不在「好不好看」上——那几乎没人反对，评论区里最直接的一句是「这太漂亮了，我需要 kitty 和 ghostty 都赶紧合」。分歧在「该不该为这件事动终端协议」。一边觉得既然都要改协议，就该顺手把终端整个重写：不是复刻 dumb terminal 的局限，而是做一个信息密集、为界面而生的终端，最好还能有语义层、可编辑的 scrollback、像样的无障碍支持。另一边觉得终端的价值恰恰来自它的笨拙和限制，而 HTML over SSH、GUI over SSH、浏览器化这些方向要么是拿 hack 叠 hack，要么是拿延迟换像素。

真正把讨论拽回地面的是几个很具体的问题：tmux 会不会丢序列、CJK 用户在双宽渲染下会不会错位、每格多 16 位状态的内存账、以及 Alacritty 和 Terminal.app 这些实现者的态度。这些问题没有漂亮答案，作者的回应也相当诚实——Ratatui 那部分只是个 PoC 分支，能进 Ghostty、Rio、Kitty，Terminal.app 永远没戏。

而第三种声音穿插在整场讨论里，几乎没人接得住：作者在开头披露用了 AI，评论区立刻分成「AI 腔调」派和「披露值得肯定」派，连作者自己都在吐槽措辞太像生成物。有意思的是，方案本身越具体，反对的火力越集中在措辞和姿态上，而不是技术细节。技术层面争议最大的其实只有一处——边框到底挂在格子上还是挂在字素簇上，而这个问题的答案，可能要等到 CJK 和 emoji 用户第一次撞上它的时候才会浮出来。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Terminal borders that don't cost a cell（HN 主帖） | <https://news.ycombinator.com/item?id=50491423> |
| 2 | joshka 博客原文：Terminal borders that don't cost a cell | <https://www.joshka.net/cell-borders/> |
| 3 | Ghostty 的 cell borders 补丁分支 | <https://github.com/joshka/ghostty/tree/joshka/cell-borders> |
| 4 | Rio 的早期实现（PR #1947） | <https://github.com/raphamorim/rio/pull/1947> |
| 5 | Ratatui 端的 PoC 与说明（CELL-BORDERS.md） | <https://github.com/joshka/ratatui/blob/joshka/cell-borders/CELL-BORDERS.md> |
| 6 | Ratatui 官网 | <https://ratatui.rs/> |
| 7 | mintty 的 overstrike（DECSET 20）说明 | <https://github.com/mintty/mintty/wiki/CtrlSeqs#overstrike> |
| 8 | SGR 53/55 overline 说明 | <https://vtdn.dev/docs/sgr/sgr-overline> |
| 9 | bateri 终端与 pencere 规范草案 | <https://github.com/bateri/pencere/blob/main/spec/draft/pencere.md> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 312 分、136 条评论，抓取快照 2026-11-14 13:07 UTC，入库 111 条评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。本文关于协议机制（每格 12 段线条、16 位填充位、tmux 对 DCS 与 CSI 的处理、UAX #11 的 Ambiguous 宽度）的叙述，依据博客原文、作者本人在评论区的说明以及评论区其他参与者的事后核实，不代表本项目立场。引用帖表中除 HN 主帖与博客原文外，其余链接均取自主帖正文或归档评论；文中提及的 Ghostty、Rio、Ratatui、bateri 等项目仍在早期阶段，其实现与规范可能继续变化。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
