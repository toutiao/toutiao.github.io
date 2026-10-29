---
layout: post
title: >-
  Emacs 50 岁了：AI 让它更好改，也让懂它的人变少 — HN 讨论摘要
date: 2026-10-29
hn_id: 50273171
categories: [articles]
excerpt: >-
  1976 年在 MIT AI Lab 跑起来的 Emacs 满 50 岁，纪念文章一路追到 1962 年的 TECO。
  评论区最热闹的却不是怀旧：把 Claude 塞进 Emacs，让它当场写扩展、当场注入运行中的进程。
  配置里还躺着三十年前片段的老用户，和第一次上手就能指挥 AI 的人，在同一串评论里互相打量。
tagline: >-
  五十岁，不重启。
---

## 原文概要

MIT 科技评论在 10 月 20 日刊发长文《Emacs Turns 50》，从一个反常识的对比切入：编程曾经完全是另一回事。1946 年，宾夕法尼亚大学 ENIAC 的六位女程序员不写代码，而是用开关、电缆和插线板物理地配置这台机器；几年后 MIT 工程师在 Whirlwind 上把代码打成纸带再送进内存，再往后是一行一张的穿孔卡片；到 1960 年代初，交互式计算机的程序员已经在电传打字机上用「行编辑器」一行一行敲代码，代码存在一台现代洗衣机那么大的旋转硬盘上。全屏编辑器——那种能同时看到并修改很多行的东西——当时还不存在。

EMACS 的根是 Dan Murphy '65 在 1962 年为 PDP-1 写的 TECO，最初叫 Tape Editor and Corrector，命令全是单个大写字母：敲 `I` 插入文本，敲 `D` 删掉一个字符。磁带换成共享硬盘上的文件后，TECO 里的那个 T 从 Tape 变成了 Text，而 TECO 也慢慢长成一门完整的语言，程序员用它写宏来创造新的编辑命令。1971 年秋天，Carl Mikkelsen '76 做出 Control-R 这个 TECO 插件，用上了带视频显示的「玻璃电传打字机」终端：改动立刻显示在屏幕上，不必重新打印整行。代价是屏幕一次只能显示几行代码。

1976 年，Richard M. Stallman 在斯坦福 AI Lab 看到一台叫 E 的全屏编辑器，回到 MIT 改造 Control-R，做出的关键改动是每个按键按下就跑自己的宏，于是自定义变得容易。实验室的黑客们立刻开始动手加命令，这给研究生 Guy Steele Jr. 带来麻烦：他常要帮同门调试，发现「别人用的是带这些扩展的版本」比自己用纯 TECO 难帮得多，于是他去促成一套大家都能接受的 Control-R 标准命令集，David Moon '75 和 Stallman 前后帮忙，最终用上了早期键盘上的 Meta 键：Meta-F 前进一个词，Meta-B 后退一个词。产品定名 EMACS，即 Editor Macros 或 Editing Macros。Steele 后来解释自己的动机：「我的目标不是造一个伟大的文本编辑器，我是在试图解决一个社会问题。」

但 EMACS 确实是个好编辑器。Bernard S. Greenberg 的历史记载里，「完全没有技术经验」的用户几分钟到一小时就能学会编辑字母、邮件甚至程序；而「经验丰富、老练的用户发现 EMACS 比此前任何一种编辑形式都好用得多」。Stallman 用磁带分发：寄回邮资信封就能换到磁带。1981 年的手册写着：「EMACS 不收费；相反，你是在加入 EMACS 软件共享公社，成员条件是把你对 EMACS 的改进寄回来。」

商业化几乎立刻跟上：Greenberg 在 Honeywell 工作期间为 Multics 写的 EMACS 拿了 1980 年 International Honeywell Software Conference 的一等奖，Honeywell 开始卖它；James Arthur Gosling（在 CMU 读研、后来领衔 Java）做的版本也卖成了商业产品。这次「从免费到付费」的转变，最终促使 Stallman 去造一个可以被自由分享、由用户共同改进的操作系统——GNU Project，名字来自「GNU's Not Unix」。GNU Emacs 是它的第一个主要应用。

Apple 在 2001 年 Mac OS X 首发时把 GNU Emacs 一起预装，2019 年停止预装，但留了一个叫 mg 的程序（Micro GNU Emacs）——支持大部分 EMACS 命令，却缺少集成式的编程语言，被人称作「冒牌 EMACS」。Mac OS 至今仍藏着 Emacs 键位：没有 Meta 键，但 Control-Option-B 前进一个词，Control-Option-F 后退一个词。HN 上这条帖子拿到 338 分、140 条评论。

## 讨论焦点

### 一、五十年没死，靠的不是功能清单，是架构

最有解释力的一条评论来自 badr47，他直接给出了答案：

> "The reason Emacs survived 50 years while countless modern IDEs rose and died is architectural: Emacs isn't just a text editor with a plugin API—it's an interactive Lisp runtime that treats text buffers as first-class citizens." — badr47 [c:50274421]
> （译文：Emacs 撑过五十年、而无数现代 IDE 升起又死掉，原因是架构层面的：Emacs 不只是一个带插件 API 的文本编辑器，它是一个把文本缓冲区当作一等公民的交互式 Lisp 运行时。）

他把现代编辑器的做法讲成反例：现代编辑器一层层叠加 IPC、JSON-RPC 协议和沙箱化扩展，目的是把用户挡在核心之外；Emacs 反着来，直接把运行中的执行状态交到用户手上。同一串评论里，knome 给出了更朴素的说法：

> "most of the editor is written in elisp. only the primitives are in c." — knome [c:50276808]
> （译文：编辑器的大部分是用 elisp 写的，只有原语在 C 里。）

skydhash 补了半句：「Most of emacs is lisp. The actual C part is quite small considering the capabilities of the system.」（Emacs 大部分是 Lisp，考虑到这套系统提供的能力，真正的 C 部分其实很小。）而 pjmlp 干脆换了个定义：

> "Some of us would say it is a Lisp programming environment, with influences from Lisp Machines (Zmacs), having a text editor as sample application." — pjmlp [c:50275296]
> （译文：我们有些人会说，它是一个 Lisp 编程环境，受 Lisp 机（Zmacs）影响，把文本编辑器当作示例应用而已。）

这句话把纪念文章里的那句「我的目标不是造一个伟大的文本编辑器」变成了整场讨论的底色：文本编辑只是入口，运行时才是本体。

### 二、AI 把 Emacs 变成「许愿池」

用满 30 年的 jwr 说得最完整：

> "Recently, AI completely changed how I use Emacs, and in a very good way. I now treat AI as a fairy that can fulfill any wish. I describe how I want my editor to work, and boom! it works that way." — jwr [c:50273757]
> （译文：最近 AI 完全改变了我使用 Emacs 的方式，而且是往好的方向。我现在把 AI 当成一个能实现任何愿望的精灵。我描述我想要编辑器怎么工作，啪，它就那样工作了。）

他随即补上更关键的一半：

> "What is most important, however, goes back to Stallman's original ideas. I am in control of my editor and my environment. I decide how it will look and behave. No corporation decides for me. No corporation builds in a new AI assistant. Nobody introduces ads or tracking." — jwr [c:50273757]
> （译文：但最重要的那一点，还是回到了 Stallman 的原始想法：我掌控我的编辑器和我的环境。我决定它长什么样、怎么表现。没有公司替我做决定，没有公司往里塞一个新的 AI 助手，也没有人插进广告或追踪。）

技术细节上，gpderetta 描述了最硬核的用法：

> "It is is unreal how I can ask claude, from within emacs, to implement an extension for me on the fly, inject it into the running process, have it observe the results, and quickly iterate to a working solution." — gpderetta [c:50275019]
> （译文：我在 Emacs 里让 Claude 即席给我实现一个扩展、把它注入正在运行的进程、让它观察结果、再快速迭代到能跑，这件事有多不真实就不用说了。）

tetraodonpuffer 把 Emacs 装进容器，让 AI 无头调试：「Saying "I want my editor to do X" and have it happen basically realtime on an editor I fully control is incredible.」（说「我要我的编辑器做 X」，在我完全掌控的编辑器上它基本实时就做到了，这很不可思议。）而 iLemming 的结论更激进：

> "Now is the best time to try Emacs. If people before could complain that Lisp is weird and not easy to grok, it's not a valid complaint anymore." — iLemming [c:50276333]
> （译文：现在是尝试 Emacs 的最好时机。以前的人如果抱怨 Lisp 古怪、不容易理解，这已经不是个成立的抱怨了。）

注意这里的分寸：这些人并没有放弃 Stallman 那一套，反而是把「编辑器归我所有」贯彻得更彻底——只是现在动手的人换成了 AI。

### 三、不学 Elisp 也能用 Emacs，这算不算问题

gspr 在周年帖里做了一次公开自白：

> "Yet I don't know LISP (any LISP!) at all, I barely use any packages beyond "whatever it is that Debian ships by default", and I'm quite bad at fancy Emacs shortcuts. My Emacs config file is a hodge-podge of little snippets I don't properly understand – and it measures in at just about 100 lines, including comments and whitespace" — gspr [c:50274714]
> （译文：可我完全不懂 LISP（任何一种 LISP！），几乎不用 Debian 默认之外的东西，复杂的 Emacs 快捷键我也用得很差。我的 Emacs 配置文件是一堆我并没有真正理解的小片段拼起来的——算上注释和空白，也不过 100 行左右。）

他这 15 年「代码、邮件、笔记、数据处理全在 Emacs 里干」，最后却说：「Despite all of this, Emacs is still fantastic for me! Here's to the next 50!」（尽管如此，Emacs 对我来说依然棒极了！敬下一个 50 年！）worik 的用法更极端，用了 25 年几乎零配置，理由是「My point is it is very usable with no config」（我的意思是，它零配置就已经很好用了。）到了 LLM 出现，他不用学 Elisp 也开始大规模改配置。

反方向的担心由 jimbokun 一句话兜住：

> "You can always read the generated code and spruce it up or have the LLM refactor it to your liking." — jimbokun [c:50280473]
> （译文：你随时可以读一遍生成的代码，把它收拾干净，或者让 LLM 按你的意思重构。）

也就是说门槛降低了，但「读得懂」这件事并没有被免掉，只是从「会写 Elisp」变成了「会读、会验收」。

### 四、配置到底该不该「精简」

marttt 是反方，他的失败经验很具体：

> "I always gave up eventually because the complexity of addons, the org-mode-can-do-everything-so-I-should-do-everything-with-it etc just grew over my head." — marttt [c:50274224]
> （译文：我每次最后都放弃了，因为各种扩展的复杂度、还有「org-mode 什么都能干所以我应该什么都用它干」这类东西，很快就超过了我能驾驭的范围。）

iLemming 是正方，而且把数字全摊开：

> "My config since then has grown to 26K LOC + 35K of tests. I consume 250 third-party packages, plus about 100 built-in libs." — iLemming [c:50275869]
> （译文：从那以后我的配置涨到了 2.6 万行代码，外加 3.5 万行测试。我消耗 250 个第三方包，还有大约 100 个内置库。）

他还说自己的 Emacs 启动一秒内完成，Mac 上内存占用和 Slack 应用一个量级、约 500MB，并甩出一句「What's the point of keeping a colossal beast under a mountain and feeding it a low-calorie diet?」（把一头巨兽压在山下、喂它低热量口粮，到底有什么意义？）但 gspr 的立场是同一个硬币的另一面：

> "I'd rather leave it unconfigured than have a massive configuration I don't understand." — gspr [c:50278807]
> （译文：比起拥有一堆我并不理解的庞大配置，我宁愿什么都不配。）

分歧不在「要不要配置」，而在「配置由谁负责」：是用户自己维护一份看得懂的，还是交给一个会写但你看不懂的过程。

### 五、「Eight Megabytes and Constantly Swapping」这个玩笑还在流传

BeetleB 的遭遇是全场最有画面感的一段：

> "My manager came to me and said "Your Emacs is taking 8GB of RAM?!"" — BeetleB [c:50275035]
> （译文：我老板跑来问我，「你的 Emacs 占了 8GB 内存？！」）

他自己也笑了：这下该叫 EGACS（Eight Gigabytes And Constantly Swapping）。查下来是 macOS 上的 GUI 相关对象没释放，他干脆让 LLM 写了个清理包，「After cleanup, it's taking "only" 1.5 GB of RAM.」（清理之后，它「只」占 1.5GB 内存。）manithree 则顺手纠正了一个历史细节：

> "GNU Emacs really didn't start until 1984, but I keep thinking it would be interesting to compare Emacs' resource usage to Zed (or Gram)." — manithree [c:50275808]
> （译文：GNU Emacs 真正起步其实是 1984 年，但我一直觉得拿 Emacs 的资源占用跟 Zed（或者 Gram）比一比会很有意思。）

他最后那句调侃很传神：「Compared to VSCode, Eight Meg And Constantly Swapping does sound ridiculously parsimonious in 2026.」（跟 VSCode 比起来，Eight Meg And Constantly Swapping 在 2026 年听起来确实俭朴得可笑。）schoen 补了来源：GNU 官网那篇 1991 年的 ed 笑话把 Emacs 描述成极度浪费资源，「but I guess trends elsewhere were so keen on adding abstractions that now Emacs is an efficient, parsimonious choice by comparison.」（不过我猜别处的趋势太热衷于叠加抽象层，以至于如今 Emacs 反倒成了高效、节俭的选择。）

### 六、真正的隐患不是软件，是人

TFNA 提的问题和整个帖子的怀旧气氛相反：

> "I worry AI is not going to encourage any growth in that small elite that seems kinda important for Emacs' long-term future." — TFNA [c:50273964]
> （译文：我担心 AI 不会促成那批真正深入理解 Emacs Lisp 和 Emacs 内部的人成长——而这批人似乎对 Emacs 的长期未来挺重要。）

他把话说得更重：

> "It is no secret that a number of Emacs ecosystem core devs are middle-aged, and so the project is a few heart attacks or whatever away from losing the experience and competence that has sustained it so well." — TFNA [c:50274381]
> （译文：生态里有不少核心开发者已经中年，这不是秘密；这个项目离「失去那份让它一直运转良好的经验与能力」大概只隔着几次心梗之类的。）

cyrialize 给出了一个部分相反的证据：新包正在往 Emacs 内部靠，而不是各自造轮子——`eglot` 已经随 Emacs 打包，`corfu` 与 `company` 的对比说明后端可以共用 capf，「packages that hook into Emacs more don't necessarily mean that they're better」，但你从 Emacs 本身能白拿的东西也更多（「it's more like you get a lot more things for free」）。这场分歧的实质是：AI 让更多人用 Emacs，会不会同时让更少人懂 Emacs。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| Emacs 活下来靠架构，不靠功能表 | badr47 | 它是交互式 Lisp 运行时，文本缓冲区是一等公民 |
| 文本编辑器只是它的示例应用 | pjmlp | 本质是 Lisp 编程环境，受 Lisp 机影响 |
| 大部分代码是 elisp，原语才在 C | knome / skydhash | 运行时可被随手查看、替换、注入 |
| AI 把 Emacs 变成许愿池 | jwr | 「我描述我想要什么，啪，它就那样工作了」 |
| Claude 就是在 Emacs 里跑的 REPL | gpderetta | 实现扩展、注入进程、观察结果、快速迭代 |
| AI 之后才是尝试 Emacs 的最好时机 | iLemming | 「Lisp 古怪」已经不是个成立的抱怨 |
| 不懂 Elisp 也能用得很爽 | gspr | 15 年、100 行配置，Emacs 依然棒极了 |
| 配置该膨胀，不必刻意精简 | iLemming | 2.6 万行配置 + 3.5 万行测试，跑得很稳 |
| 配置该保持小而可控 | marttt / gspr | 复杂度一旦越过头顶，人就退场了 |
| 内存流言是真的，但可修 | BeetleB | 8GB 变 EGACS，清理后只剩 1.5GB |
| 真正的风险在核心开发者的年龄 | TFNA | 离失去那份经验只隔着几次心梗 |

## 总体情绪

这篇纪念文章本身是一份相当扎实的口述史，但评论区几乎没有人在读史。多数人是在借五十周年这个由头，重新回答一个更实际的问题：一个从 1976 年活到今天的软件，凭什么还能继续用下去。

答案被拆成了两半。一半是架构：Lisp 运行时 + 文本缓冲区 + 几乎整个编辑器都在 elisp 里，导致它可以被随时检查、随时替换、随时注入。这是 1976 年的设计，恰好也是今天 agent 最能发挥的形态——写一段代码，插进正在运行的进程里，看结果，再改。另一半是控制权：AI 让「定制编辑器」这件事的门槛塌了，于是配置里还躺着三十年前片段的老用户，和第一次上手的人挤到同一块屏幕上，各自看见了对方的用法。

真正的裂缝只有一处，而且不在软件里。AI 正在批量制造 Emacs 用户，也正在批量制造「让 AI 替自己改 Emacs」的人；前者让生态变大，后者让懂得 Emacs 内部的人变少。而 TFNA 担心的事情——生态核心开发者已到中年、AI 不再逼着新一代人下沉到 internals——恰好是这个变大过程中最难被补上的缺口。

所以这场周年讨论最终落在一件很 Emacs 的事上：五十年后它还活着的理由，和它接下来可能死掉的理由，是同一个东西——一切都在你手里，包括那些你还没学会的部分。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Emacs Turns 50（MIT Technology Review） | https://www.technologyreview.com/2026/10/20/1145399/emacs-turns-50/ |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50273171 |
| 3 | GNU 官网 ed 笑话（1991 年，评论中引用的出处） | https://www.gnu.org/fun/jokes/ed-msg.html |
| 4 | An introduction to Canvas in Emacs（评论区提到的 Canvas 支持） | https://monadicsheep.org/blog/an-introduction-to-canvas-in-emacs.html |
| 5 | exc.el（评论中提到的 Emacs Canvas 实现） | https://github.com/yibie/exc.el |
| 6 | Emacs 本体（GNU 官网） | https://www.gnu.org/software/emacs/ |

## 免责声明

<div class="disclaimer">

本文为 Hacker News 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。原文概要部分转述自 MIT Technology Review 于 2026 年 10 月 20 日发表的《Emacs Turns 50》，涉及 TECO、Control-R、EMACS 命名、1981 年软件共享公社手册、Honeywell 商业化、GNU Project、Apple 预装与停止预装等史实，均未经独立核实，具体年份与人物关系以原文为准。文中提到的 Emacs 版本特性（如原生编译默认开启、tree-sitter、Canvas 支持已进入 master、eglot 已内置）来自评论区说法，可能随版本变化，请以官方文档为准。引文均带有 `[c:id]` 形式的评论编号，可在原帖通过 `item?id={id}#{c_id}` 形式定位；引文为逐字摘录，仅省略了标注链接等非正文内容。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
