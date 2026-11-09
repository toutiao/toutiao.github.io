---
layout: post
title: >-
  KetchUp：Rust + WebGPU 写的开源 SketchUp 替代品，评论区吵成了「以后都自己造工具」
date: 2026-11-09
hn_id: 50418176
categories: [articles]
excerpt: >-
  MIT 开源的 SketchUp 替代品 KetchUp 用 Rust 写成、跑在浏览器里，12 小时从 115 分涨到 519 分；讨论很快越过建模器本身，落在「以后是不是该自己造工具」上。
tagline: >-
  项目简介里作者自己写着：100% vibe-coded，only the finest slop。
---

> 来源：HN 讨论帖，提交者 dcoulmbe。帖子：[KetchUp – Open-source SketchUp alternative built with Rust and WebGPU](https://news.ycombinator.com/item?id=50418176)，519 分，149 条评论（抓取时快照）。原文：[KetchUp 应用页](https://ketchup3d.github.io/app/)（现已改名为 BenchUp，编辑器搬到 [benchup3d.github.io/editor](https://benchup3d.github.io/editor/)，仓库 [BenchUp3D/editor](https://github.com/BenchUp3D/editor)）。

## 原文概要

KetchUp 是一个 MIT 协议、Rust 编写的 3D 建模应用，目标用户是木工和家具制作者：在动锯子之前，先把搁板、桌子、橱柜、工作台的尺寸在三维空间里排一遍。它既能装成原生程序（Windows x64 安装包、macOS Apple Silicon 的 `.pkg`、Linux 的 AppImage），也能直接在桌面浏览器里跑——浏览器版走 WebAssembly，优先用 WebGPU，硬件不支持时退回 WebGL2。代码仓库 2026 年 10 月 23 日创建，到 11 月 9 日积累 414 个 star、17 个 fork、10 个 open issue。

工具栏排得很满：Select、Line、Rectangle、Circle、Polygon、Freehand、Push/Pull、Scale、Offset、Move、Rotate、Paint、Tape Measure、Protractor、Dimensions、Union、Erase、Orbit，另有自动几何吸附、填充平面、尺寸标注、组与组件、几何剪贴板、撤销重做、浏览器本地自动保存。发帖时的项目文件后缀是 `.ketchup`（现已改成 `.bup`，同时兼容旧的 `.k3d`）。导入导出只有两条路：导入 SketchUp 的 `.skp` 几何，导出 Wavefront `.obj`；官方页面明说 SketchUp 的贴图、场景和部分特性不支持，OBJ 导出不含材质。后续版本补上了木工榫卯（mortise-and-tenon、half-lap、tongue-and-groove、rabbet、dovetail、finger joint）、木纹方向标注，以及把切割清单和工时成本估算导出成 PDF。

项目的自我定位相当坦率。仓库简介写着「Built with Rust, WebAssembly and WebGPU」，最后一句是「100% vibe-coded, only the finest slop, with great emphasis on rendering speed and UI/UX」——整个项目是 vibe coding 出来的，作者自己承认。提交者 dcoulmbe 也在楼里回帖，说项目刚做出来时他也没太当回事，直到 GitHub 上 star 涨起来才认真对待，还开玩笑说要改名成 Dovetail3D。

热度的爬升很快。帖子 2026 年 11 月 8 日 22:35 UTC 提交，本地归档在 11 月 9 日 00:36 UTC 抓到的快照是 115 分、18 条评论；到 11:01 UTC 变成 516 分、149 条评论，之后继续爬到 519 分。

## 讨论焦点

### 1. 名字：KetchUp 还是 BenchUp

讨论的第一个岔路口是名字，不是功能。

> "That name is really close to ask to be sued... remember the Mikerowsoft vs Microsoft." — xlayn [c:50418793]
> （译文：这名字离被起诉只差一步……还记得 Mikerowsoft 告微软那案子吗。）

> "It&#x27;s not a pun if you use the exact word. SketchUp was the pun." — navane [c:50423073]
> （译文：直接用同一个词就不算双关了，有双关的是 SketchUp。）

> "Seems to have been renamed to BenchUp now?" — globular-toast [c:50421764]
> （译文：现在好像改名成 BenchUp 了？）

名字焦虑最后以改名收场：仓库、编辑器、Linux 的 AppImage 包名都已换成 BenchUp。但从讨论走向看，没人真的做完了商标判断——先把双关拆开，再把法律问题留在桌上。

### 2. 好不好用：SketchUp 的手感输在最后 20%

> "Great work!<p><i>Feedback</i>: every time I draw a rectangle it asks me to name the object; seems like the wrong default behavior." — yboris [c:50418852]
> （译文：干得漂亮！反馈一条：每画一个矩形都要我给这个物体起名字，这个默认行为不太对。）

> "Yeah, this falls well short of Sketchup&#x27;s intuitiveness.<p>Every interaction I try on KetchUp has some kind of gotcha. It doesn&#x27;t snap to grid by default, and as you say, it&#x27;s insane that I have to name every rectangle. I can&#x27;t extrude a face with a single click-and-drag of the push&#x2F;pull tool; instead I&#x27;ve got to select it first with the arrow tool (which strangely does not match how the Move tool behaves), then extrude." — LinguaBrowse [c:50420631]
> （译文：这跟 SketchUp 的直觉性差得远。我在 KetchUp 上每一步交互都有点什么坑：默认不吸附网格，每画一个矩形都要起名字，推拉工具不能一键拖拽出厚度，得先用箭头工具选中——而箭头工具的手感又跟移动工具对不上。）

> "Impressive how good that rust UI feels in a browser though. Even the text rendering is impressive. Maybe rust really is the future of cross platform web+mobile apps." — elxr [c:50419015]
> （译文：不过这个 Rust UI 在浏览器里的手感确实好，连文字渲染都很惊艳。也许 Rust 真是跨平台 web + 移动应用的未来。）

批评集中在同一处：这个项目的宣传页把「画完第一个形状」拆成三步（画矩形、推拉给厚度、换个视角），但每一步背后都藏着需要先设置、再选中、再确认的额外操作。仓库简介里 `100% vibe-coded` 那句自陈，正好解释了这种手感差是怎么来的。

### 3. 真正的议题：以后都自己造工具

nico 的开头把整条讨论的调子定了。

> "This is awesome. At the same time I wonder if we are entering an era in which it’s just better to build your own tools<p>Need a 3D modeler? Use Claude or codex to build the 3D model first, then build the modeler around it as you iterate towards what you want to build<p>So many times I’ve had to spend hours learning a software, reading docs, doing tutorials, only to later be able to do a small basic idea of what I actually wanted to do in the first place" — nico [c:50419327]
> （译文：这太棒了。同时我在想，我们是不是正进入一个「自己造工具更好」的时代？需要 3D 建模器？那就让 Claude 或 codex 先把模型建出来，再围绕它迭代出建模器。我有过太多次这样的经历：花几小时学软件、读文档、看教程，最后才做出那个一开始就想做的小东西。）

> "I think the value of adapting full tools to your own workflow far outweighs the maintenance costs nowadays. The tool above for instance took my agent a couple hours and it was good to go. It wasn’t a small slice by any means either: it supports edit&#x2F;obj mode, extrude, loop cuts, modifiers like subdiv, save&#x2F;load, undo&#x2F;redo, bones, auto rig, posing, and more." — dyarosla [c:50419547]
> （译文：我认为当下，把完整工具改造成适配自己工作流的价值，远远大于维护成本。上面那个例子，我的 agent 花了几个小时就搞定了。它可不是什么小切片：编辑/物体模式、挤出、环切、细分修改器、存读档、撤销重做、骨骼、自动绑骨、摆姿势，全都有。）

> "Interesting perspective for me I find it more interesting to learn the transferable skill set behind using this kind of software. Sure I can make a software that does exactly what I want when poked but then I do not learn any transferable skills." — mastermage [c:50422141]
> （译文：我倒觉得更有意思的是掌握用这类软件背后的可迁移技能。我当然能让软件按我的要求被戳出一个精确版本，但那之后我一个可迁移的技能也没学到。）

> "Why are people suddenly entirely unwilling to invest effort into their projects...<p>Wat is the point of personal projects if in the end you learned nothing" — burgerone [c:50421679]
> （译文：人们怎么突然就完全不愿意在自己的项目上花功夫了……个人项目要是最后什么都没学到，那意义在哪？）

于是 KetchUp 这个项目本身被当成了引子：它证明「一个人 + AI」确实能在一周内端出一个能用的建模器，但要造的东西到底该是软件，还是造软件这件事本身，成了争点。

### 4. 反方：给成熟底座加一层，而不是从零重写

反方的核心主张是：现成的开源底座加一层自动化，比自己造一个通用工具划算。

> "To offer a counterpoint, I’m currently spending a lot of time on the other side of this: having my agent use blender in the background and build on top of it. My agent can drive it well and I’ve benefited from its import capability, renderers, layering, and simulation. I get a lot from blender, even though I don’t ever see its UI." — wilted-iris [c:50419777]
> （译文：作为反例，我这段时间正好站在另一边：让 agent 在后台驱动 Blender，在它之上继续搭。我的 agent 驱动得很顺，我用上了它的导入能力、渲染器、图层和模拟。就算我从来不见它的界面，我也从 Blender 身上拿到很多。）

> "You might be surprised just how much you can rewrite of Blender&#x27;s UI if you want to.<p>And you get battle-tested software and a <i>huge</i> collection of existing plugins, operational modes, export formats, all that. Fully bespoke software for everything you want is a way toward losing interoperability between people and platforms." — t-writescode [c:50419959]
> （译文：你可能会惊讶于 Blender 的 UI 到底能被改写多少。同时你还能拿到久经考验的软件、一大堆现成插件、各种操作模式和导出格式。为所欲求地做完全定制的软件，等于放弃人和平台之间的互操作性。）

> "We have existing tools for this. You fork the repo of the closest thing and have AI tune it to exactly what you want." — Gigachad [c:50421326]
> （译文：这类事我们已经有现成工具了。fork 最接近的那个仓库，让 AI 把它调成你正好想要的样子。）

> "It doesnt have to be one or the other: you can have custom software that still works within existing&#x2F;interoperable formats, as I’m doing here (im not planning to reinvent OBJ&#x2F;FBX&#x2F;BLEND)<p>But building up as opposed to building down or rewriting is freeing." — dyarosla [c:50420113]
> （译文：这不必二选一：定制软件照样能用既有的、可互操作的文件格式，就像我现在这样（我没打算重新发明 OBJ/FBX/BLEND）。但往上搭，比推倒重写或者换皮要自由得多。）

> "I&#x27;m coming to think that a hybrid of vibe-coding but with an existing substrate is the right way to go.<p>For instance in the context of this SketchUp clone that might mean using AI to generate an addon for Blender." — Teever [c:50422400]
> （译文：我越来越觉得，vibe coding 加上一个现成的底座，这种混合路线才对路。就拿这个 SketchUp 克隆来说，可能该做的是用 AI 生成一个 Blender 插件。）

顺带一提，也有人把 KetchUp 当成现成底座来用：nico 说希望能有 agent 驱动 KetchUp，评论里还提到了 SolidCraft（配 MCP 和 Codex）、Ingetrazo 等同类 vibe coding 建模器。同一场讨论里，「自己造工具」和「工具互相调用」是同时成立的。

### 5. 复杂度才是天花板，不是 AI

反对派把矛头从 AI 转向了复杂度本身。

> "My experience is it&#x27;s short to get a working tool and long to finish. Many 3D modulers (blender for example) have literally 1000s of features. Yes, you might not need all of them but you probably need 100s, each with quirks and UI&#x2F;UX decisions. Just iterating on camera controls can take days." — socalgal2 [c:50420310]
> （译文：我的经验是，拿到一个能用的工具很快，把它做完却很长。像 Blender 这样的 3D 建模器有上千个功能，你可能用不到全部，但大概要用到几百个，每个都有自己的怪癖和界面决策。光是调相机控制就能耗上几天。）

> "Once you cross a certain complexity in your project, it becomes quite work intensive even using AI to do the coding. All the back and forth and cleaning up, exploring ideas and starting from scratch again takes time and effort and maybe most importantly, extensive human thinking." — kristophph [c:50422798]
> （译文：项目一旦越过某个复杂度阈值，即使有 AI 写代码也会变成很重的工作量。来回对话、清理代码、试想法、重新开始，都要花时间精力，更重要的是要花大量的人类思考。）

> "CAD is about the worst case (<i>and</i> very complicated).<p>But you could easily vibe code, e.g. an H.265 decoder, even though it is super complex." — IshKebab [c:50423630]
> （译文：CAD 差不多就是最坏情况（而且非常复杂）。但你完全可以 vibe code 一个 H.265 解码器，哪怕它超级复杂。）

这句反驳点出了真问题：能不能 vibe coding，看的不是复杂度，而是「目标是否明确、可否自动验证正确」。CAD 恰好两项都不占——设计意图没有规范，也没有自动判分器。

> "Yep having the same experience right now with some curve&#x2F;spline tessellation into triangle strips. There are many degenerate edge cases and when you ask the &quot;ai&quot; to handle one it breaks something else etc." — samiv [c:50423514]
> （译文：我现在就在踩同样的坑，做曲线/样条细分到三角面片。这里有一堆退化边界情况，你让 AI 处理一个，它就会弄坏另外一处。）

### 6. 开源协作正在碎成叉叉

话题从建模器滑向了开源社区的结构问题，而且带着火气。

> "now half a dozen people each run their own race using AI, each solution misses 30% of the features and has x-amounts of bugs." — 4ggr0 [c:50423273]
> （译文：现在有五六个人各自用 AI 跑自己的赛，每个方案都缺 30% 的功能，还各带一堆 bug。）

> "But I think this is coming from the fact that PR review is incredibly costly to the maintainer while generating code is fast. I&#x27;ve submitted PRs to open source projects which claim to welcome contributions but the PRs just never get reviewed" — Gigachad [c:50423311]
> （译文：但我认为根源在于，对维护者来说 review PR 的成本极高，而生成代码却很快。我给那些声称欢迎贡献的开源项目提过 PR，结果从来没人 review。）

> "Sigh... are we really just going to re-invent plugins?" — guhidalg [c:50419466]
> （译文：唉……我们是真的要把插件也重新发明一遍吗？）

> "Plugins have long been troubled. It’s hard to make a plugin interface that is actually useful while also not breaking on every app update. And plugins have been such a massive vector for distributing malware." — Gigachad [c:50421335]
> （译文：插件这事儿一直很麻烦。插件接口既要好用、又不至于每次应用更新就崩，很难做；而且插件一直是分发恶意软件的大通道。）

写代码变快了，维护者的时间没变，于是 fork 比贡献更划算——这是本帖最被低估的一条结论，它同时解释了 KetchUp 为什么会有 17 个 fork。

### 7. AI 生成的 3D 几何，质量还差一截

「用 AI 造建模器」和「用 AI 造模型」是两件事，讨论里被清楚地分开了。

> "Ask any 3D creative and you’ll know that AI is not yet sufficient to generate 3D models at the quality that most industries need them at." — dyarosla [c:50420230]
> （译文：随便问一个 3D 从业者，就知道 AI 目前还达不到多数行业要求的模型质量。）

> "Their models are horribly topoligized, which will matter for most use cases for models; and if you’re just using it to make a cube, it’d be better to learn the related program to do that." — t-writescode [c:50420337]
> （译文：它们生成的模型拓扑结构很糟糕，这对大多数建模用途是要命的；而如果你只是想造个立方体，学一下对应软件会更好。）

> "In 3d art, there is a gulf between the easy stuff and the hard stuff." — t-writescode [c:50420337]
> （译文：在 3D 艺术里，简单的部分和难的部分之间隔着一道鸿沟。）

不过「从零建模」这条路已经有人跑通了，只是换了形态：

> "I&#x27;ve been using SolidCraft with MCP and Codex to model things. Pretty wild. I gave it a photo of a pencil sketch and a paragraph; a few minutes later I had a 3D model." — pettijohn [c:50420951]
> （译文：我一直在用 SolidCraft 配 MCP 和 Codex 来建模，相当野。给它一张铅笔草图照片加一段文字，几分钟后我就有了 3D 模型。）

> "I&#x27;ve had some good luck with using Claude (Opus 5.5) for making models for 3D printing just by describing the thing I want (with measurements if you&#x27;ve got em) and having it create an OpenSCAD file." — dceddia [c:50420499]
> （译文：我用 Claude（Opus 5.5）做 3D 打印模型挺顺的：描述我想要的东西（有尺寸就带上尺寸），让它生成一个 OpenSCAD 文件。）

### 8. 谁来买单：FreeCAD 的劝退现场与商业化悬案

讨论里还有一批人，是被 SketchUp 的手感养大、又被 FreeCAD 劝退的普通用户——他们才是这个项目的真实目标用户。

> "SketchUp 8 was the easiest software for me to learn, and it just clicks with me. I really wanted to learn FreeCAD, but there&#x27;s something about the way it works that I just can&#x27;t get along with, so I keep going back to SketchUp." — 4ff618 [c:50419162]
> （译文：SketchUp 8 是我学过的最容易上手的软件，用起来就是顺手。我真的想学 FreeCAD，但它的工作方式里有那么点东西我实在合不来，所以还是回头用 SketchUp。）

> "I have the same problem with FreeCAD: I really want to uae FreeCAD. But after some weeks or months I cannot even remember simple things like how to add a new object (or hole) to a face of an object." — hasley [c:50421902]
> （译文：我也有同样的 FreeCAD 问题：我真的很想用 FreeCAD，但过了几周几个月，连「给一个面加个新物体（或者打个洞）」这种简单操作都记不住怎么做。）

商业化的另一面则完全没被回答：

> "But then one person on our CSM team spent a week building an alternative to Gainsight, saving the company like $90k a year. Granted, it required a technical person to do it even with vibe coding, but it doesn’t take much of his time to maintain it." — cael450 [c:50420326]
> （译文：不过我们 CSM 团队里有个人花一周做了个 Gainsight 的替代品，每年给公司省下差不多 9 万美元。当然，即便有 vibe coding，也还是需要一个技术的人来做，但维护它花不了他多少时间。）

> "Weird that they are all giving the source code away for free and failing on the whole to even ask for donations." — andybak [c:50423495]
> （译文：奇怪，他们全都在免费送源码，却连开口要赞助都做不出来。）

> "I believe the goal of most of these people is to make money." — Rapzid [c:50423412]
> （译文：我相信这些人里大多数的目标是赚钱。）

一端是「9 万美元一年」的内部省钱账，另一端是「MIT 白送还不敢收赞助」，中间没人算出过这种项目靠什么活着——这是本帖从头到尾没被解决的问题。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 名字是雷 | xlayn | KetchUp 这个名字离被起诉只差一步 |
| 手感不行 | LinguaBrowse | 80% 做到了，最后 20% 的打磨全崩 |
| 该自己造工具 | nico | 需要建模器就让 Claude 现写一个 |
| 造工具要还技术债 | mastermage | 按需求戳出的软件不给你留下可迁移的技能 |
| 该用成熟底座 | wilted-iris | 让 agent 在后台驱动 Blender，你照样拿到它的渲染和模拟 |
| 复杂度是硬约束 | socalgal2 | 相机控制一项就能调几天，几百个功能乘起来就是无底洞 |
| 开源在碎 | 4ggr0 | 各自造轮子，每个方案都缺 30% 功能 |
| AI 造 3D 不够格 | dyarosla | 3D 从业者不会同意 AI 出的模型质量 |
| 生意人 | Rapzid | 大多数人做这些的动机是赚钱 |

## 总体情绪

这是一场由一个 3D 建模器引出、但很快就不再谈 3D 建模器的讨论。前半段是常规的产品评审：名字像番茄酱、默认不给吸附网格、画个矩形要起名字、push/pull 得先选中再拖——批评具体、且多半成立，作者自己在仓库简介里写的 `100% vibe-coded` 就是这些毛病的来源。后半段是另一回事：当有人把这个项目读成「一个人加 AI 就能端出一个通用工具」的证据，讨论的落点就转向了造工具本身值不值、该不该从零写、以及 open source 的 fork 与协作正在被写代码的速度冲垮。

两派都没赢。说自己造工具的人，给出的最好例子是「agent 花了几个小时」，而反驳者立刻能指出：CAD 恰好是最不适合 vibe code 的那类活——没有规范，没有自动验证，还得先有审美。反过来，说该用成熟底座的人，解释不了一个个新项目为什么还是从空目录开始。中间那批 FreeCAD 的用户只关心一件事：能不能像 SketchUp 那样上手就能画个盒子，而这个问题从头到尾没人替他们验证。

项目最后还是改了名，从 KetchUp 变成 BenchUp——番茄酱那个 pun 拆掉了，可「BenchUp」本身也未必能让人放心。真正没拆掉的那个问题还挂在讨论里：一周就能写出来的软件，和需要十年才能长出生态的软件，之间的账没人算清。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | KetchUp – Open-source SketchUp alternative built with Rust and WebGPU | https://news.ycombinator.com/item?id=50418176 |
| 2 | KetchUp 应用页（现已更名为 BenchUp） | https://ketchup3d.github.io/app/ |
| 3 | BenchUp 浏览器版编辑器 | https://benchup3d.github.io/editor/ |
| 4 | BenchUp3D/editor 源码仓库（Rust, MIT） | https://github.com/BenchUp3D/editor |

<div class="disclaimer">
声明：本文讨论内容源自 Hacker News 热门讨论，文中引用的用户观点仅代表原作者个人立场。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
