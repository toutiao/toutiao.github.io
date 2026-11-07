---
layout: post
title: >-
  Libghostty 1.0：终端引擎被拆成 C 库，JetBrains 换了内核，Neovim 还在等发布 — HN 讨论摘要
date: 2026-11-08
hn_id: 50399933
categories: [articles]
excerpt: >-
  Ghostty 作者把终端内核抽成独立的 C 库并发布 1.0：JetBrains IDE 的终端换成了它，
  Neovim 的替换 PR 排着队等发布，KDE 在拿它做 Konsole 的替代品。原文最反直觉的一句是：
  现在靠 libghostty 跑终端的人，已经远远多于用 Ghostty 应用本身的人。
tagline: >-
  Ghostty 只是个 demo：真正在跑的是它拆出来的库——JetBrains 的 IDE 终端已经换了内核。
---

> 来源：HN 讨论主帖 [Libghostty 1.0](https://news.ycombinator.com/item?id=50399933)（912 分，145 条评论），原文是 Mitchell Hashimoto 在自己博客上写的 1.0 发布说明。本篇为 single post 模式；归档快照 2026-11-07 17:32 UTC，入库 116 条评论。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

2026 年 11 月 6 日，Mitchell Hashimoto 在博客宣布 libghostty-vt 1.0。libghostty 是从 Ghostty 核心抽出来的终端模拟 C 库，1.0 意味着库本身和 C ABI 都稳定了。一年前他写过一篇文章说 libghostty 要来了——那时 Zig 模块刚并进主仓，C API 还不存在，除了 Ghostty 自己没有第二个使用者。

现在的使用者名单是最硬的部分。JetBrains IDE 内置的终端已经换到 libghostty 上（2026 年 10 月官方宣布），按 JetBrains 自己的报告覆盖 1250 万以上活跃用户；Neovim 有一个已批准的 PR 用 libghostty-vt 替换 libvterm，顺手关掉了那个开了十年的 #4997（resize 时滚动缓冲重排），维护者在等一个打了标签的发布，好让发行版把依赖单独打包——这次 1.0 大概就是解锁点；KDE 的开发者用它做 Konsole 的替代品 Kwi；Vercel 的 Turborepo 用它渲染任务输出的 TUI；devenv 用它驱动 shell；Antithesis 拿它 fuzz TUI 程序，在 btop 等项目里找出真 bug；Emacs 侧有 Ghostel；ghostty-web 是 WASM 构建，API 兼容 Xterm.js；OrbStack 也嵌了它；还有一批「agentic」编程工具 herdr、cmux 直接建在它之上，而不是自己再写一个模拟器。社区绑定覆盖 Rust、Go、JavaScript、Swift、Python、.NET、Elixir、Dart、Java。

1.0 的重点是 ABI 稳定性，做法写得很细：每个对象都是不透明句柄，几百个可读可写的值都走枚举键的 getter/setter，新头文件链到旧库会拿到 GHOSTTY_UNSUPPORTED，而不是崩溃或未定义行为；少数非不透明的结构体带自己的 size 并留了保留填充，枚举在各编译器上钉死为 int。CI 用 libabigail 对着提交进仓库的基线做检查，macOS 和 WebAssembly 上比对的则是黄金类型清单；ELF 平台上导出的符号还做了版本化，动态链接器会直接拒绝加载名字对不上的库。

打包是给发行版看的那部分。libghostty 有独立于 Ghostty 应用的发布节奏，每个发布同时给签名源码 tarball 和一个依赖 tarball（Zig 包按 Zig 自己的缓存布局打包，好让发行版完全离线构建）；安装会放好 SONAME、头文件、pkg-config 和 CMake package config，支持 `--prefix`、`DESTDIR` 和 `lib64`，调试信息默认保留以便拆包，`PACKAGING-LIBGHOSTTY.md` 随 tarball 一起发。许可证是 MIT，运行时除了 libc 什么都不需要，甚至可以完全 freestanding 构建。编译期依赖是 simdutf 和 Google Highway（SIMD）、一份紧凑的 Unicode 字素表、Wuffs（Kitty 图形协议的图片解码），simdutf 和 Highway 都不带 libc++，依赖树里没有 copyleft，所有依赖都列在机器可读的清单里（版本、SPDX 许可证、hash）。

覆盖面也顺带列了：CI 里跑全量测试和所有示例的平台有 Linux（glibc 和 musl）x86_64/aarch64、macOS 13+、iOS 13+、FreeBSD、Windows x86_64、Android（aarch64/x86_64/arm）和 freestanding WebAssembly；只构建不跑测试的还有裸机 riscv32/thumb、WASI、Windows arm64、illumos。反差在于，这张表比大多数终端应用都宽，但评论区最先吵起来的既不是 ABI 也不是覆盖面，而是「这到底算 C 还是 Zig」。

## 讨论焦点

### 一、1.0 到底承诺了什么：一笔押在 ABI 上的赌注

先庆祝 1.0 本身，这是评论区最直接的一层反应。Sparkle-san 说得很轻：

> "In the age of perpetual 0.x software, it&#x27;s nice to see a well-known project get to 1.0" — Sparkle-san [c:50400605]
> （译文：在软件永远卡在 0.x 的年代，看见一个知名项目走到 1.0 真好。）

有人接着把话说得更尖：

> "Agreed. I feel like too much projects are too reluctant to take the responsibility to say &quot;this is production ready&quot;." — xiaoyu2006 [c:50400637]
> （译文：同意。我觉得太多项目太不敢承担责任去说一句「这个已经可以上生产了」。）

再往下就成了一句玩笑：

> "Software is either 0.0.12 or 20x6.99" — bombcar [c:50401114]
> （译文：软件要么是 0.0.12，要么是 20 美元又 6.99。）

真正定调的是 kyrofa 的一句：

> "Wow. This is how you write a library." — kyrofa [c:50401206]
> （译文：哇，这才是写库该有的样子。）

但 1.0 在这里不是版本号，而是一句承诺。hujun236 追问的是这句承诺的边界：

> "Curious how stable the public ABI is intended to be now that JetBrains and others are embedding it this quickly. Is the 1.0 promise closer to &quot;API surface won&#x27;t break&quot; or more &quot;we won&#x27;t break you without a major version&quot;?" — hujun236 [c:50401150]
> （译文：JetBrains 这些人这么快就嵌进去了，我很好奇公开的 ABI 到底打算有多稳定。这个 1.0 的承诺更接近「API 表面不会变」，还是更接近「不变的话我一定先升大版本」？）

jherskovic 回到原文找依据：

> "He mentions semantic versioning in the post, so major version." — jherskovic [c:50404509]
> （译文：他在原文里提到了语义化版本，所以是大版本。）

真正被当作教材读的是接口设计的细节。spacechild1 举了 libopus 的版本化结构体做例子：

> "One example that comes to my mind is libopus: <a href="https:&#x2F;&#x2F;github.com&#x2F;xiph&#x2F;opus" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;xiph&#x2F;opus</a><p>If you have structs that might need to be extended, you can use &quot;versioned structs&quot;. One popular technique is to include the struct size as the first field. The struct size is set to `offsetof(mystruct, lastmember) + sizeof(lastmember)` and the receiver of the struct can use this to check if a member exists." — spacechild1 [c:50402503]
> （译文：一个我能想到的例子是 libopus：<https://github.com/xiph/opus>。如果你的结构体以后可能要扩展，可以用「版本化结构体」。一个常见做法是把结构体大小放在第一个字段，大小设为 `offsetof(mystruct, lastmember) + sizeof(lastmember)`，接收方就能靠它判断某个成员存不存在。）

smj-edison 正在给自己的 Zig 项目设计 C 接口，这段描述让他当场反省：

> "I&#x27;m currently working on my own Zig project (an interpreter) and right now I&#x27;m working on designing a C interface for it. Seeing things mentioned like having objects as opaque handles, or enum-keyed getters and setters, made me think about how clunky my current API is, since I leak too many details to callers.<p>What really caught my attention was this: &quot;So from the start, I took inspiration from C libraries I enjoyed working with and designed the API to have a strong, stable ABI that allows for future additions.&quot; What are good examples of this? I feel like I just don&#x27;t have enough experience with well-designed C libraries to know what to look for." — smj-edison [c:50401618]
> （译文：我现在在给自己的 Zig 项目（一个解释器）设计 C 接口。看到「对象是不透明句柄」「用枚举键的 getter/setter」这些说法，才意识到我现在的 API 有多笨——我往调用方那边漏了太多细节。真正抓住我的是这句：「所以从一开始，我就参考自己喜欢的 C 库来设计，做成有强 ABI 保证、以后还能继续扩展的 API。」有哪些好例子？我大概是 C 库设计经验太少，还不知道该看什么。）

这段的落点其实很明确：1.0 不是「版本升级」，是把「以后不破坏你」写成了可被机器检查的规则——不透明句柄、`GHOSTTY_UNSUPPORTED`、libabigail 基线、ELF 符号版本化，缺一不可。

### 二、C 还是 Zig：一段被反复问起的出身问题

有一个问题在评论区被问了至少五次，答案每次都更短。第一个是 Decabytes：

> "I’m curious why they chose to use C for this as opposed to Zig with a c like interface." — Decabytes [c:50400653]
> （译文：我好奇他们为什么选 C，而不是 Zig 加一个类 C 的接口。）

nektro 一句话答了：

> "it&#x27;s Zig with a C ABI" — nektro [c:50400677]
> （译文：它就是 Zig 加一个 C ABI。）

但紧接着有人给出了更实际的版本：

> "It’s Zog with a C ABI. Zig bindings are a bit of a moving target still." — trollbridge [c:50400946]
> （译文：是 Zig，配一个 C ABI。Zig 的绑定多少还有点不牢靠。）

devy 干脆把原文那句复制出来对照：

> "Yeah, Mitchell&#x27;s description is very confusing.<p><pre><code>   libghostty-vt 1.0 is here. libghostty is a portable, high-performance C library for terminal emulation, extracted directly from the core of Ghostty.</code></pre>" — devy [c:50401376]
> （译文：是的，Mitchell 的描述让人很困惑。）

ksec 的怀疑更具体：

> "I came to check and say the same as well. I was thinking if they used AI to convert Zig to C.<p>And that is with me and everyone else knew it was coded in Zig in the first place. Had anyone not knew what Ghostty were I seriously think they would have thought it was a &quot;C Library&quot;." — ksec [c:50403480]
> （译文：我也是来看一眼、说同样的话的。我当时想的是，他们是不是用 AI 把 Zig 转成 C。而且是那种——大家都知道 Ghostty 本来就是用 Zig 写的。假如没人知道 Ghostty 是什么，我敢打赌他们会以为那是个「C 库」。）

这场小争论底下其实压着一个真问题：C ABI 是给谁用的。发行版、IDE 厂商、C/C++ 老代码要的是 ABI 稳定和能被工具链链接；而 Zig 的绑定方要的其实是源码级 API。库选了前者，等于宣布它先服务打包者和嵌入者，服务的是别人的产品经理而不是终端用户自己。

### 三、谁在用：JetBrains 的 1250 万用户，和一堆还没合上的 PR

原文列了一长串使用方，评论区则负责验证这些说法。最直白的一条：

> "As of recently, the embedded terminal in Jetbrains IDEs is also based on libghostty." — chuckadams [c:50400675]
> （译文：最近，JetBrains IDE 里内嵌的终端也换成了 libghostty。）

用过的 JetBrains 用户补上体验：

> "And it has been such an upgrade.<p>There was so many little things that bugs me with JediTerm, unsupported escape sequences, bugged visualization, truncated output, you name it.<p>Now it just work, like it supposed to." — AnggaSP [c:50400799]
> （译文：而且这升级幅度很大。之前 JediTerm 有太多小毛病让我难受：不支持的转义序列、可视化乱掉、输出被截断，什么都有。现在它就是能正常工作，本来就该这样。）

KDE 那边的人在同步自己的进度：

> "Great stuff, congrats to mitchellh and the other Ghostty devs!<p>Kwi&#x27;s (a KDE embedder) CI&#x2F;CD and its Flatpak builds&#x2F;repo have moved to the new version." — sho_hn [c:50401771]
> （译文：好消息，恭喜 mitchellh 和其他 Ghostty 开发者！Kwi（KDE 的一个嵌入方）的 CI/CD 和它的 Flatpak 构建与仓库都已经切到新版本了。）

Emacs 用户那边的对比更不留情面：

> "Ghostel is the first Emacs terminal emulator I&#x27;ve used that really just worked. Vterm and EAT were nice at for time but it&#x27;s like night and day to Ghostel." — Conscat [c:50401755]
> （译文：Ghostel 是我用过的第一个真正「能用」的 Emacs 终端模拟器。vterm 和 EAT 曾经也都不错，但跟 Ghostel 相比简直是白天和黑夜。）

至于它相对老牌方案差在哪，pekim 给的是一份技术对照：

> "libghostty provides terminal emulation, without any UI. An application embedding it will need to provide the UI.<p>libvte provides terminal emulation complete with a gtk UI.<p>In terms of terminal emulation, libghostty implements several protocols that libvte does not. For example kitty keyboard, kitty graphics, and desktop notification." — pekim [c:50403558]
> （译文：libghostty 提供的是终端模拟，不带任何 UI。嵌入它的应用得自己提供 UI。libvte 提供的是带 GTK UI 的完整终端模拟。就终端模拟本身而言，libghostty 实现了若干 libvte 没有的协议，比如 kitty 键盘、kitty 图形和桌面通知。）

不过也有人泼了冷水，而且泼得很有分寸。VadimPR 是真去用了的人：

> "Tried libghostty-vt 1.0 as Mudlet&#x27;s ANSI decoder - no measurable speed gain in tests and its terminal grid doesn&#x27;t suit a MUD client (UTF-8 only, scrollback can&#x27;t be edited), but I reckon it&#x27;d make a great terminal pane for cursor-addressed game screens." — VadimPR [c:50401419]
> （译文：我把 libghostty-vt 1.0 拿去做 Mudlet 的 ANSI 解码器——测试里测不出速度提升，而且它的终端网格不适合 MUD 客户端（只支持 UTF-8，滚动缓冲也不能编辑），但我敢肯定它很适合做那种用光标寻址的游戏画面终端面板。）

这句提醒很重要：库好不好是一回事，你的场景是不是它擅长的又是另一回事。1250 万这个数字是 JetBrains 终端的用户数，不是「因为 libghostty 才有人换 IDE」的转化率。

### 四、引擎与终端：为什么大家开始想自己造一个

评论区最热闹的一段是「为什么要自己造终端」，zem 给出的类比最完整——他把终端拆成引擎和外壳两层，和浏览器一模一样：

> "think of it as the split between a browser engine (renders and handles interactions with webpages) and a browser (provides the user interface and everything other than rendering the webpage, e.g. bookmarks, tabs, clipboard interaction, etc.)<p>similarly, a terminal conceptually consists of a terminal engine, which handles text rendering and interaction, and then a terminal which handles tabs, splits, sessions, etc.<p>now one key point is that you can get a terminal engine right according to a bunch of reasonably objective criteria, so it&#x27;s a problem well worth solving once and for all. the terminal itself is a lot more subjective and idiosyncratic; different people want different things out of their terminals and the reason is very often that it fits the way they work, or they enjoy some particular features, and even the absence of other features. it is wonderful that libghostty can solve the part that everyone agrees needs to be objectively correct, and lets people concentrate on building the subjective part in the way they like best." — zem [c:50403324]
> （译文：把它想成浏览器引擎（负责渲染和处理与网页的交互）和浏览器（提供用户界面，以及渲染网页之外的一切，比如书签、标签页、剪贴板交互等）之间的分工。同样地，终端在概念上分成终端引擎——处理文本渲染和交互——和终端本身——处理标签页、分屏、会话等等。关键一点是，终端引擎可以按一大堆相当客观的标准做对，所以这是一个值得一劳永逸解决一次的问题；而终端本身非常主观、非常个性化，不同的人想要的东西不一样，原因往往只是它合不合自己的工作方式，或者他们就喜欢某个特定功能，甚至喜欢它没有某个功能。libghostty 能解决大家都同意需要客观做对的那部分，同时让人们专注去按自己的方式建主观的那部分，这太好了。）

azertify 则把话拉回工程现实：

> "I think the point isn&#x27;t that everyone should create their own standalone terminal, but apps that embed terminals (like IDEs, cloud portals etc) can make much better integrated terminals with less code.<p>It&#x27;s like a better alternative to xterm.js, and better than existing terminal emulator libraries." — azertify [c:50402991]
> （译文：我认为重点不是每个人都该自己造一个独立终端，而是像 IDE、云控制台这类嵌终端的应用，可以用更少的代码做出集成度好得多的终端。它就像 xterm.js 更好的替代品，也比现有的终端模拟库更好。）

而 swyx 替没跟上的人问了那个最朴素的疑问：

> "can i just get you people to slow down a bit and explain: why are you guys building your own terminal? whats the deep pain here?<p>(i&#x27;m not at all being skeptical, i respect you guys enough to understand that there&#x27;s something here I don&#x27;t get and it&#x27;s my skill issue, so I am trying to learn)" — swyx [c:50402793]
> （译文：能不能请你们慢一点，解释一下：你们为什么要自己造终端？这里的深层痛点到底是什么？（我一点都不怀疑，我尊重你们到愿意弄明白你们说的东西里有什么我没想到的地方，这是我的水平问题，所以我在努力学。））

答案在回帖里其实已经给出了两条：文档好到让人想动手，以及成本低到可以塞进任何产品。lioeters 正在读文档：

> "The documentation for libghostty is great, I&#x27;m reading through the guides and examples. It feel like a fun way to build your own terminal emulator GUI in C, Zig, or other languages with C bindings.<p><a href="https:&#x2F;&#x2F;lib.ghostty.org&#x2F;vt&#x2F;example-programs.html" rel="nofollow">https:&#x2F;&#x2F;lib.ghostty.org&#x2F;vt&#x2F;example-programs.html</a><p>It also looks useful for testing and developing text interfaces (TUI), like file navigator, editor, dashboard, etc." — lioeters [c:50401237]
> （译文：libghostty 的文档很棒，我在读那些指南和示例。感觉用 C、Zig 或其他有 C 绑定的语言做一个自己的终端模拟器 GUI 是件挺好玩的事。看起来对测试和开发 TUI 界面也很有用，比如文件浏览器、编辑器、仪表盘之类。）

已经动手的人给出了战果：

> "Used it to for a terminal emulator plugin for sublime text, works flawlessly, better than Terminus, tmux and interactive programs works out of the box, only limitation came from the poor sublime text plugin API related to mouse events (there is none, so you have to hack)<p>If you thought building a terminal emulator too hard to add for your project, you no longer have an excuse, libghostty makes it very easy to implement" — WhereIsTheTruth [c:50402586]
> （译文：我用它给 Sublime Text 写了个终端模拟器插件，完美运行，比 Terminus 好，tmux 和交互式程序开箱即用，唯一的限制来自 Sublime Text 插件 API 太差——它没有鼠标事件，你得自己 hack。如果你以前觉得给项目加一个终端模拟器太难，那你现在没有借口了，libghostty 让这件事变得非常容易实现。）

### 五、Ghostty 与 iTerm2 的旧账，谁也没结清

库的话题热闹，但评论区最分裂的还是终端应用本身。留在 iTerm2 的人理由很具体。sick_of_slop 是那种典型的「想去但没去成」：

> "I think Ghostty is great for the most part but I keep going back to iTerm2, personally.<p>iTerm just feel less buggy.  For example I was running Claude in a container the other day and the slash command complete wasn’t rendering properly with Ghostty but worked perfectly fine with iTerm.<p>I <i>want</i> to switch to Ghostty because I prefer how simple Ghostty is overall and I think the project itself is very cool and an important piece of software (libghostty) but it doesn’t <i>quite</i> get there for _for my use cases_." — sick_of_slop [c:50400974]
> （译文：整体上我觉得 Ghostty 很棒，但我个人还是反复回到 iTerm2。iTerm 就是感觉 bug 更少。比如前几天我在容器里跑 Claude，斜杠命令补全在 Ghostty 里渲染不对，在 iTerm 里完全正常。我<em>想</em>换到 Ghostty，因为我喜欢它整体的简洁，也觉得这个项目本身很酷、是很重要的一块软件（libghostty），但它对我<u>来说</u>就是<u>还</u>差那么一点。）

理由可以小到一个细节。turadg 说的是新标签页的工作目录：

> "I used iTerm2 until I noticed that Ghostty’s New Tab opens at the current working directory.<p>Haven’t gone back since." — turadg [c:50401164]
> （译文：我用 iTerm2 直到注意到 Ghostty 的新标签页会开在当前工作目录，然后就再也没回去过。）

但也有人承认 iTerm2 仍有长处，ashton314 的说法最公道：

> "Search and tmux integration are where iTerm2 really shines imo. I use Ghostty 99% of the time now though. (Search did get a lot better with the latest release.) What features specifically keep you on iTerm2?" — ashton314 [c:50401502]
> （译文：搜索和 tmux 集成是 iTerm2 真正强的地方，我觉得吧。不过我现在 99% 的时间在用 Ghostty。（搜索在最近的版本里确实好多了。）是什么具体功能让你留在 iTerm2？）

留下的理由其实集中在「窗口管理」和「设置界面」两处，isomorphic 列了一份清单：

> "Aside from the outstanding tmux integration (and search):<p><pre><code>  - Font rendering (and cell size control) is still better on iTerm2, although Ghostty has been rapidly gaining
>   - Compact theme with thin titlebar tabs
>   - Profiles
>   - Window arrangements
>   - In-terminal API (which Mitchell has acknowledged as a useful feature)
> </code></pre>
> The iTerm2 settings&#x2F;preferences are a mixed bag. On the one hand, discoverability and settings search. On the other hand the panel is insane. Also iTerm2 doesn&#x27;t have Ghostty&#x27;s straightforward prefs file. I guess I want the best of both worlds: A well-organized settings UI, with search; and a file I can easily neovim." — isomorphic [c:50401805]
> （译文：除了无可争议的 tmux 集成（还有搜索）之外：字体渲染（以及单元格尺寸控制）还是 iTerm2 更好，虽然 Ghostty 一直在快速追上来；紧凑主题配细标题栏标签页；配置文件（profiles）；窗口排布；终端内 API（Mitchell 也承认这是有用的特性）。iTerm2 的设置面板是个混合体：一方面，可发现性和设置搜索都不错；另一方面，那个面板简直疯了。而且 iTerm2 没有 Ghostty 那种直白的 prefs 文件。我想我想要的是两者的结合：一个组织良好、还能搜索的设置界面，加上一个我能用 neovim 轻松编辑的配置文件。）

换过去的人各有各的痛点。rafram 换的理由是 iTerm2 的更新和功能：

> "I switched from iTerm to Ghostty because:<p>- iTerm started pushing a ton of updates to add features that absolutely no one wanted. AI chat in the terminal emulator (not within the terminal), integrated web browser, etc.<p>- Some of those features turned out to introduce major vulnerabilities, so they had to push even more frequent updates to patch them. It’s extremely annoying to have your work interrupted by multiple update prompts in a day from your <i>terminal</i>.<p>- iTerm has visual glitches (line artifacts appearing when windows are opened&#x2F;closed) on non-Retina monitors.<p>That said, I miss the GUI for changing settings. Ghostty’s settings file format requires looking up keys every time you want to change something, and it isn’t nearly as powerful as iTerm profiles." — rafram [c:50404503]
> （译文：我从 iTerm 换到 Ghostty 是因为：iTerm 开始推送大量根本没人想要的功能更新，比如终端模拟器里的 AI 聊天（不是终端内的），还有内置浏览器之类；其中一些功能还带来了严重漏洞，于是他们只能更频繁地打补丁更新。一天被你的<em>终端</em>弹好几次更新提示打断工作，实在太烦；iTerm 在非 Retina 显示器上还有视觉瑕疵（窗口开关时出现线条残留）。话虽如此，我还是怀念用 GUI 改设置。Ghostty 的设置文件格式要求你每次改东西都去查键名，而且远没有 iTerm 的 profiles 强大。）

Myrmornis 的理由只有一条，但足够硬：

> "A big reason I gave up iTerm2 was that it didn&#x27;t use a plain text file as its native configuration format -- I was just too obsessive about wanting my config in git to be able to handle it!" — Myrmornis [c:50405896]
> （译文：我放弃 iTerm2 的一个主要原因，是它不用纯文本文件做原生配置格式——我只是太执着于想把配置放进 git 里，好方便自己处理！）

当然，也不是所有人都认为 Ghostty 赢了。nigehban 是从 Ghostty 迁到 kitty 的人：

> "I was using ghostty since its beginning, then Mitchell has shown the capability of rendering for kitty and I installed the kitty, dropped everything else. maybe statistically is not correct but I feel the transitions, animations, rendering of the kitty terminal is superior than ghostty. I only miss some fancy window&#x2F;pane layout settings (not sure kitty does have a window at all) and naming. Other than that kitty is my daily driver for any Agentic env.<p>PS: FMPOV Mitchell is a relentless performance addict. I have been seeing this since the vagrant days (this also makes me sad because it reminds me I am getting old)" — nigehban [c:50402685]
> （译文：我从一开始就一直在用 ghostty，后来 Mitchell 展示了为 kitty 做渲染的能力，我就装了 kitty，把其他的都扔了。也许这在统计上不成立，但我觉得 kitty 终端的过渡、动画和渲染比 ghostty 更棒。我只怀念一些花哨的窗口/分屏布局设置（不确定 kitty 到底有没有窗口）和命名。除此之外，kitty 是我做任何 Agentic 环境的日常主力。附：FMPOV，Mitchell 是个不折不扣的性能狂热者，我从 vagrant 时代就在看这一点了（这也让我有点难过，因为它提醒我正在变老）。）

到这里可以看出，这帖的技术主角是库，但情感主角一直是终端本身——因为库的价值最终要靠终端的胜负来兑现。

### 六、谁来买单：开源项目的钱，和一个叫 Rex 的影子

只要有人问「这东西谁养」，答案通常先指向作者本人。markstos 问得很直接：

> "I wonder how the author makes the work financially sustainable." — markstos [c:50401143]
> （译文：我想知道作者怎么让这份工作在财务上可持续。）

blactuary 记得他说过什么：

> "He posted here a while back, paraphrased &quot;My revenue model is my bank account has 10 digits&quot;. He&#x27;s wealthy and likes to code and is giving back to the community" — blactuary [c:50404834]
> （译文：他前一阵子在这里发过帖，大意是「我的收入模式是我的银行账户有十位数」。他有钱，喜欢写代码，也愿意回馈社区。）

但真正有信息量的是 rvz 那份清单，他把开源项目的五种活法排了个序：

> "Many common ways for the financing of an free and open source project to be <i>sustainable</i> (The main keyword) in the mid to long term:<p>1) A non-profit company that has full-time employees but supported via sponsorships: (gnu project, mastodon, omarchy, zig)<p>2) Multiple for-profit companies that each have full-time employees contributing to an open source project that they all use: (ocaml, linux, rust)<p>3) An ultra high net worth individual that has full-time contributors to open source and supported via a non-profit (signal, ghostty)<p>4) A for-profit company that has dedicated full-time employees that have full support and own the direction of the open source project (go, swift, java)<p>5) VC funded open source projects (Herdr, Bun, Deno, Burno, Atuin)<p>All other options such as low donations like &quot;buy me a coffee&quot;, ko-fi, are <i>completely unsustainable</i>, now that AI agents exist." — rvz [c:50401845]
> （译文：一个免费开源项目在中长期<em>可持续</em>（关键词）的常见融资方式有很多：1) 非营利公司，有全职员工，靠赞助维持（GNU 项目、mastodon、omarchy、zig）；2) 多个营利公司各自派全职员工贡献给它们都在用的开源项目（ocaml、linux、rust）；3) 一个超高净值个人，有全职贡献者做开源项目，并通过非营利组织支持（signal、ghostty）；4) 一家营利公司，有专职全职员工全职投入并且掌握开源项目的方向（go、swift、java）；5) 风投支持的开源项目（Herdr、Bun、Deno、Burno、Atuin）。其他所有选项，比如「买杯咖啡」这种小额打赏、ko-fi，在 AI agent 存在的当下都<em>完全不可持续</em>。）

zem 指出他漏了占比最大的那类：

> "you missed the 99% case, which is some random person who has a reasonably well paying day job and develops the project in their spare time. AI agents make that <i>more</i> sustainable, not less. vim is a good example, as are a lot of popular programming languages." — zem [c:50403363]
> （译文：你漏掉了占 99% 的那种情况：某个有份不错工作的普通人，在业余时间做这个项目。AI agent 让这种模式<em>更</em>可持续，而不是更不可持续。vim 就是个例子，还有很多流行编程语言也是。）

tmtvl 立刻反驳：

> "That&#x27;s not sustainable. If $DAYJOB becomes too busy the project will stall because the random person won&#x27;t have enough time to work on it anymore." — tmtvl [c:50404439]
> （译文：那不可持续。如果 $DAYJOB 太忙，项目就会停摆，因为那个人没有足够时间继续做了。）

这套争论的真正焦点，是作者手上那个商业产品。原文提到了「agentic 编程工具」herdr、cmux，jdorfman 立刻注意到了那层关系：

> "&gt; “And a whole wave of new terminals and &quot;agentic&quot; coding tools, such as herdr and cmux, have been built on it rather than writing yet another emulator.”<p>Mitchell could have easily snuck his competing product Rex in there but resisted. Respect." — jdorfman [c:50401480]
> （译文：「还有一整波新的终端和『agentic』编程工具，比如 herdr 和 cmux，都是建在它之上，而不是自己再写一个模拟器。」——Mitchell 完全可以顺手把自己的竞品 Rex 也塞进去，但他忍住了。值得尊敬。）

但怀疑的声音同样存在：

> "Would be some serious 4d chess if you were his sockpuppet account." — howunfortunate [c:50401624]
> （译文：如果你是他的马甲账号，那这招「四步棋」可就太狠了。）

而用家则完全不在乎背后的动机，只关心产品本身。9dev 的类比最传神：

> "I suspect Ghostty is to Rex what Chromium is to Google Chrome (without all the negative connotations that is, I’m a happy Rex user!): both something of a tech demo for libghostty, and an open source, basic-but-fully-featured terminal emulator. Rex, then, will possibly be a paid product at some point, and adds features like the server, agent integration, and persistent session management on top.
>  If you had asked me two years ago if I was ready to pay for my terminal and quit my jetbrains subscription, I’d have laughed. Now I’m earnestly ready for that if Superlogical were to announce a paid plan." — 9dev [c:50402576]
> （译文：我怀疑 Ghostty 对 Rex 的关系，就像 Chromium 对 Google Chrome 的关系（不带那些负面含义，我是 Rex 的满意用户！）：两者都是 libghostty 的某种技术演示，也都是开源的、基础但功能完整的终端模拟器。那么 Rex 将来可能是收费产品，在上面加服务器、agent 集成和持久会话管理之类的功能。如果两年前你问我，愿不愿意为终端付钱、还要退掉我的 JetBrains 订阅，我会笑出来。但现在 Superlogical 真要宣布收费方案，我是认真愿意的。）

aroman 直接给出了跨三端的使用报告：

> "No, he does, and it&#x27;s extremely good. It&#x27;s completely replaced herdr for me and I run it on Linux (server), macOS, and my iPhone. I&#x27;ve yet to run into a bug. Access is being controlled via Discord and TestFlight - you can find the link to apply on their site." — aroman [c:50402234]
> （译文：不，他确实有，而且极其出色。它已经完全取代了 herdr，我用它在 Linux（服务器）、macOS 和我的 iPhone 上跑。我到现在还没遇到一个 bug。访问通过 Discord 和 TestFlight 控制，网站上能找到申请链接。）

把这些放在一起看，这一段的分歧不是技术分歧：库是 MIT、免费的，谁用都能用；争论的是这个生态最终会长成「一个免费内核加一堆付费外壳」的样子，还是「靠一个富豪的个人钱包支撑的项目」的样子。

### 七、AI 时代：自己造终端的理由和账单

评论区里有一批人是从 agent 的角度重新算这笔账的。didip 的提问很直接：

> "In the world of AI (slop or not),<p>why won’t people write their own subset of terminal emulators, just for their own need?<p>Probably faster without waiting for 3rd party to fix bugs and merge patches, no?" — didip [c:50402513]
> （译文：在 AI 的世界里（就算它满是垃圾），为什么人们不自己写一个终端模拟器的子集，只为自己需要的那部分？这样大概更快，不用等第三方修 bug、合补丁，不是吗？）

9dev 给出的回答比提问更冷静：

> "Most people are in some way constrained in their AI usage, be it a session&#x2F;week limit or the token pricing. So while you now can definitely build apps on your own you couldn’t before, you still have to make some economic considerations like before: My company is <i>still</i> not in the business of building terminal emulators. Even if an agent takes on the majority of the work to build one for me, I still have to invest some time and focus into directing it where I want it to go; it’s using up a big chunk of my usage limits if I want something anywhere near as polished as ghostty; and like all software, it wants permanent maintenance, bug fixes, and updates. AI doesn’t change any of that.<p>It’s time for the industry to realize that the weights may have shifted toward <i>build</i> vs. <i>buy</i>, but the general SaaS calculus is still in effect." — 9dev [c:50402662]
> （译文：大多数人的 AI 使用总是受某种限制，要么是每周/每会话的额度，要么是 token 价格。所以虽然你现在确实能自己写以前写不出来的应用，但经济上的考虑还是和以前一样：我公司<em>仍然</em>不打算做终端模拟器。即使有 agent 承担了大部分工作，我仍然要投入时间和精力去引导它到我想要的方向；要做到接近 ghostty 那样打磨的程度，会吃掉我很大一块使用额度；而且和所有软件一样，它需要长期维护、修 bug 和更新。AI 并没有改变这一点。是时候让这个行业意识到，重心可能已经从<em>买</em>转向了<em>造</em>，但 SaaS 的基本算术依然成立。）

gls2ro 认为真正的未来是「积木」：

> "My opinion is that this idea that seems to be in the same direction of all SaaS is dead because everyone will just build their own products is true only for a subset of people.<p>I do agree in case of terminals this subset of people might overlap a lot with the entire market -&gt; developers.<p>I see the future a bit different as in many people&#x2F;companies will offer to the market some kind of building blocks that will be extra configurable by agents and then we are combining them.<p>In this case libghostty is such a component that can be integrated in a lot of things and people building those things want to work at a higher level of abstraction than building the terminal emulator. To be honest is among the best example of such a component that I see in the future that I think about." — gls2ro [c:50402744]
> （译文：我认为「因为大家都自己造产品，所以所有 SaaS 都会死」这个想法只对一小部分人成立。我同意，就终端而言，这一小部分人可能刚好覆盖了整个市场的大部分——也就是开发者。我看到的未来有点不一样：很多人/公司会向市场提供一些由 agent 额外配置的积木，然后我们把它们组合起来。就这个案例而言，libghostty 就是这样一个能被集成进很多东西的组件，而造这些东西的人想在比「造一个终端模拟器」更高的抽象层上工作。老实说，这是我见过的这类组件里最好的例子之一。）

而真正天天在终端里跑 agent 的人，给出的是体感层面的理由。spudlyo 说的是 pi agent 和 Kitty 图形协议：

> "One area where Ghostty really shines is with fancy TUI programs like the pi agent. Pi has a relatively recent tuiMode &quot;fullscreen&quot; feature, and it&#x27;s been exceptional. Showing inline images with the Kitty graphics protocol has been a huge improvement too -- I love it when a model calls `read` on an image file and I get to see the results in my terminal. The OSC-8 hyperlink support very handy too. Viewport scrolling is super fast, and pi can hide&#x2F;show the scrollbar as you need it." — spudlyo [c:50401356]
> （译文：Ghostty 真正发光的一个领域是那种花哨的 TUI 程序，比如 pi agent。Pi 最近加的 tuiMode「全屏」特性非常出色。用 Kitty 图形协议显示内联图片也是巨大的改进——我喜欢那种模型调用 `read` 读了一个图片文件，我就能在终端里看到结果的感觉。OSC-8 超链接支持也很方便。视口滚动非常快，pi 还能按需隐藏/显示滚动条。）

整场讨论下来，库那一层的争议其实都收敛了：ABI 是硬承诺、有 CI 兜底、打包清单齐整、依赖树干净。剩下没解决的，是两个更大的问题——「引擎」和「外壳」分家之后，外壳那一层会不会被少数人垄断；而当造一个终端的成本降到「agent 帮我写」，用户到底会更在意终端本身，还是更在意跑在终端里的 agent。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 0.x 时代里的 1.0 值得庆祝 | Sparkle-san | 知名项目肯走到 1.0，真好 |
| 太多项目不敢说「可以上生产」 | xiaoyu2006 | 承认生产就绪需要承担责任的勇气 |
| 版本号只有两种极端 | bombcar | 要么 0.0.12，要么 20 美元又 6.99 |
| 这是写库该有的样子 | kyrofa | 1.0 的意义在 ABI，不在版本号 |
| 1.0 承诺的边界要问清 | hujun236 | 「API 不变」还是「不变先升大版本」 |
| 语义化版本已经写在原文里 | jherskovic | 说了 semver，那就是大版本 |
| 版本化结构体是 C 库的标准做法 | spacechild1 | libopus 的 size 字段技巧可以直接抄 |
| 照着 libghostty 反省自己的 API | smj-edison | 不透明句柄这一套我全没做 |
| 到底为什么选 C | Decabytes | 为啥不是 Zig 加类 C 接口 |
| 答案：Zig 加 C ABI | nektro | 一句话版本 |
| Zig 绑定还不够稳 | trollbridge | 所以才导出 C ABI |
| 原文描述让人困惑 | devy | 「portable, high-performance C library」读起来像 C 写的 |
| 怀疑是 AI 把 Zig 转成了 C | ksec | 大家都以为是 C 写的 |
| JetBrains 的终端已经换了内核 | chuckadams | IDE 里嵌的就是 libghostty |
| JediTerm 用户体感升级明显 | AnggaSP | 不支持转义、输出截断，这些都没了 |
| KDE 的 Kwi 已切到新版本 | sho_hn | CI/CD 和 Flatpak 仓库都换了 |
| Ghostel 碾压 vterm | Conscat | 第一个真正「能用」的 Emacs 终端 |
| libghostty 与 libvte 的分工 | pekim | 一个不带 UI，一个带 GTK UI |
| 库好不代表场景合适 | VadimPR | 拿去做 Mudlet 的 ANSI 解码器没有速度收益 |
| 引擎与终端该分开 | zem | 像浏览器引擎和浏览器那样 |
| 重点是让应用内嵌终端 | azertify | 比 xterm.js 更好的替代品 |
| 造终端的痛点没人说清 | swyx | 能不能慢一点解释深层痛点 |
| 文档好到让人想动手 | lioeters | 用 C 或 Zig 写个自己的终端 GUI |
| 嵌入成本低到没有借口 | WhereIsTheTruth | 两天写了个 Sublime 插件 |
| 留下的理由是具体的小差异 | sick_of_slop | 斜杠命令补全在 Ghostty 里渲染不对 |
| 一个细节就够换终端 | turadg | 新标签页开在当前工作目录 |
| 搜索和 tmux 仍是 iTerm2 强项 | ashton314 | 但我 99% 时间在用 Ghostty |
| 讨厌 iTerm2 的更新和功能 | rafram | 一天弹几次更新提示，还带浏览器 |
| 配置要能用 git 管 | Myrmornis | 不用纯文本配置是我放弃的理由 |
| iTerm2 仍有它赢的地方 | isomorphic | 字体渲染、profiles、窗口排布 |
| 有人是从 Ghostty 迁到 kitty 的 | nigehban | 渲染和过渡确实更好 |
| 作者怎么养活这件事 | markstos | 先问财务可持续性 |
| 作者不缺钱 | blactuary | 「我的收入模式是我的银行账户有十位数」 |
| 开源项目有五种活法 | rvz | 个人富豪 + 非营利组织是其中一种 |
| 业余维护才是 99% 的情况 | zem | AI 让这种模式更可持续 |
| 业余维护撑不住 | tmtvl | 白天班一忙，项目就停摆 |
| 作者没把竞品塞进自己的库 | jdorfman | 本可以顺手推 Rex，他忍住了 |
| 怀疑这是一种布局 | howunfortunate | 四步棋，马甲账号 |
| Ghostty 对 Rex 像 Chromium 对 Chrome | 9dev | Rex 可能是收费的外壳 |
| 跨三端在用 Rex | aroman | Linux 服务器、macOS、iPhone |
| 为什么不自己写个够用的终端 | didip | 不用等第三方修 bug |
| AI 降低了门槛，但账照旧要算 | 9dev | 额度、维护、引导成本一样要付 |
| 未来是「积木」而不是各自造轮子 | gls2ro | libghostty 就是这样一块积木 |
| agent 场景是终端的真需求 | spudlyo | 模型读图，我立刻在终端里看到 |

## 总体情绪

这是一场读者比作者更兴奋的发布。原文是一份相当克制的技术文档：ABI 规则、依赖清单、平台表格，每一项都写得像在跟发行版维护者交代。但评论区不太在乎这些，反而抓住两个更有戏剧性的点——一个技术出身问题（这到底是 C 还是 Zig），和一笔商业账（作者手上还有一个收费终端 Rex）。前者让同一件事被解释了五遍，后者让「他会不会把竞品也塞进自己的库里」成为一个真问题。

情绪底色是分裂的乐观：一半人已经在自己的产品里用上了它，另一半人还在 iTerm2 里因为斜杠命令补全不肯走；一半人相信这是终端生态十年里少有的好消息，另一半人立刻开始算「谁出钱、谁赚钱」。而关于 1.0 本身，评论区的判断出奇一致——版本号不重要，重要的是那句「以后不破坏你」有没有被机器守着。

libghostty 真正改变的可能不是谁赢谁输的终端之争，而是让「终端」第一次有了一个可以像 libc 那样被别的软件引用的部分：引擎归大家，界面归自己。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Libghostty 1.0（HN 主帖） | <https://news.ycombinator.com/item?id=50399933> |
| 2 | 原文：Libghostty 1.0（Mitchell Hashimoto） | <https://mitchellh.com/writing/libghostty-1-0> |
| 3 | libghostty 文档站 | <https://lib.ghostty.org/> |
| 4 | JetBrains：IDE 终端改用 Ghostty | <https://blog.jetbrains.com/platform/2026/10/jetbrains-terminal-now-uses-ghostty/> |
| 5 | Neovim：用 libghostty-vt 替换 libvterm 的 PR | <https://github.com/neovim/neovim/pull/39773> |
| 6 | Neovim issue #4997（滚动缓冲 resize 重排） | <https://github.com/neovim/neovim/issues/4997> |
| 7 | KDE：Kwi（基于 libghostty 的 Konsole 替代品） | <https://blogs.kde.org/2026/11/01/introducing-kwi/> |
| 8 | PACKAGING-LIBGHOSTTY.md | <https://github.com/ghostty-org/ghostty/blob/main/PACKAGING-LIBGHOSTTY.md> |
| 9 | libopus（versioned struct 的参考实现） | <https://github.com/xiph/opus> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 912 分、145 条评论，归档快照 2026-11-07 17:32 UTC，入库 116 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。原文正文在归档中被截断至约 8000 字符，可移植性表格结尾及其后的内容未覆盖，本篇未据此展开。文中「1250 万活跃用户」系原文转述 JetBrains 的报告，非本文独立核实；Neovim PR 状态、KDE Kwi、Vercel Turborepo、devenv、Antithesis、Ghostel、ghostty-web、OrbStack、herdr、cmux、Rex 等项目与链接均由原文或评论者给出，本站未做可用性核验。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。本站与 libghostty、Ghostty、JetBrains、Neovim、KDE、Kitty 等项目无利益关系。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
