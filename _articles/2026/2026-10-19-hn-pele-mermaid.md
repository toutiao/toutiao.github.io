---
layout: post
title: >-
  Pele 把 Mermaid 渲成纯 SVG — HN 上"终于不用 Chromium 了"的集体舒气
date: 2026-10-19
hn_id: '50132193'
categories: [articles]
excerpt: >-
  Obsidian 团队 kepano 把 Mermaid 渲成可主题化的纯 SVG 输出，靠 CSS 变量控制色板，不再需要 headless browser；HN 一边赞美"服务端终于能跑"，一边挑刺"示例不够多 dark-mode 友好"。
tagline: >-
  一个把浏览器从管线里拆下来的库，听上去不算大事，但你被它坑过就不这么想了。
---
## 原文概要

Pele 是 Obsidian 创始人 kepano（Erica Chrise）放出的一个新开源库，目标很窄：把 Mermaid 语法的图直接渲染成 SVG，关键卖点是整套输出可以走 CSS 变量主题化，无需启动浏览器内核。仓库在 [github.com/obsidianmd/pele](https://github.com/obsidianmd/pele)，安装用 `npm install pele`，API 只有一句 `render(mermaidText)`，返回 `{ svg }`，直接把 SVG 字符串塞进 DOM 即可。

官网 [pele.run](https://pele.run/) 上展示了用法和颜色变量：`--pele-bg`、`--pele-fg`、`--pele-muted`、`--pele-line`、`--pele-surface`、`--pele-surface-alt`、`--pele-border`，改完不需要重渲染——颜色变化即时生效。Playground 里有 Compare 模式可以直接对照 Mermaid 和 Pele 的输出，作者明确说 Pele 跟 Mermaid 的语法一致，但故意走不同的布局算法，理由是 Mermaid 在复杂图上的布局"经常让人抓狂"。

最大的现实痛点是 Mermaid 至今依赖 headless Chromium 来排版布局，这让任何想"服务端静态生成"或者"在小项目里嵌进构建管线"的人面临一个荒谬的依赖：为了渲染一段文本，要拉起一整个浏览器。Pele 在这个具体点上解决了问题——这是 HN 上最大的一块共识。

## 讨论焦点

### 不再需要 Chromium：服务端嵌入的集体解套

Pele 在 HN 上最一致被夸的卖点，是它把浏览器从渲染管线里拆下来。

> "Does the official Mermaid library still require a full or headless browser environment in order to lay out the SVG? If so, Pele is great news for embedding Mermaid rendering in other places." — nickmain [c:50133359]

> （译文：官方 Mermaid 库是不是仍然需要完整或 headless 浏览器才能排版出 SVG？如果是，Pele 对在其他场景嵌入 Mermaid 渲染是个大新闻。）

> "It still boggles my mind that mermaid's devs think you need an entire freakin' browser to render an SVG. Sometimes I think people need to be reminded of the fundamentals." — dont__panic [c:50140265]

> （译文：mermaid 的开发者认为渲染一个 SVG 需要一整个浏览器，这事我至今想不通。有时候觉得得有人提醒大家一下基本功。）

这条痛点直接表现在两类用户身上：写文档站 / 静态博客的人，要在构建期把 Mermaid 块替换成 SVG；做浏览器插件 / IDE 插件的人，要在沙箱里跑渲染。前者用 mermaidx 之类的 Python 包装绕开，后者经常被"沙箱不能起 Chrome"的限制卡住。

bilibali 是把这件事落到具体代码量上的那一类：

> "Thank you very much for this! I use a build script for my static website that renders markdown files into HTML files and swaps out any mermaid codeblocks with rendered SVGs. I used mermaidjs for this but it is very heavy for this purpose (needs an entire chromium instance for the rendering). This seemed like a perfect fit for my use case and I already swapped it in." — bilibali [c:50141905]

> （译文：非常感谢！我给我的静态站写了个构建脚本，把 markdown 渲染成 HTML，并把 mermaid 块替换成 SVG。以前用 mermaidjs 来做这事，对这种用途太重了（要拉一整个 Chromium 实例）。Pele 看着正好合适，我直接换上了。）

不过 [Pele playground 里](https://pele.run/playground) 的 Mermaid 对照模式被 kinduff 实测出是 broken 的，附了 [错误日志 gist](https://gist.github.com/kinduff/7eb14bf348fdec4e664b59e758d1d0ec)，作者回应说正在调查——这是一个早期开源项目常见的"宣传页本身还在修"的状态。

### CSS 变量主题化与暗色模式

主题化是另一块被集中讨论的卖点，特别是暗色模式下的可读性。

> "Thank goodness. Theming mermaid and using it server side is such a nightmare. I had many issues trying to get it to work competently with CSS variables for dark mode / light dark. This seems way better." — haburka [c:50138796]

> （译文：谢天谢地。把 mermaid 主题化、又在服务端用，一直是噩梦。我之前为了让它在 CSS 变量下同时支持暗色 / 浅色踩了很多坑。这个看起来好多了。）

> "Amazing. I just migrated the diagrams on the docs site of a project of mine, and they just look great. Before, I had a combination of mermaid, panzoom, and some minor workarounds to get integrated styling and dark theme work right. Pele not only takes care of all of that, but also manages a nicer layout!" — 9dev [c:50139527]

> （译文：太棒了。我刚把一个项目文档站上的图全迁过来，效果非常好。之前我是 mermaid + panzoom + 各种补丁才能搞定集成样式和暗色主题。Pele 不仅包揽了这些事，布局还更好看。）

但同一组人里也有反向意见——`shellerik` 直接说"examples 不够暗色友好"，暗示作者给的官方示例在深色背景里对比度不够：

> "The examples are not very dark-mode friendly." — shellerik [c:50136733]

> （译文：这些示例在暗色模式下不太友好。）

这条意见的份量在于：Pele 的卖点之一就是 CSS 变量驱动的主题化，官方示例本身没把这件事演示好，等于把"你买的东西"和"你看到的样品"拉开了一道口子。

### 布局差异：作者说不一样，用户拿出反例

Pele 的第二大卖点是"同样的语法，不同的布局"，作者说复杂图上 Pele 的布局更不让人抓狂。但这条主张在 HN 上是被当场验证的：

> "I've tested a couple of diagrams that I found on some website and I couldn't see any major differences in the layout. Can you point to some systematic differences?" — nkmnz [c:50140005]

> （译文：我测了几个从某个网站上找到的图，看不出布局上有明显差异。你能指出一些系统性的区别吗？）

> "FYI, first two examples are identical here: https://pele.run/examples/timeline<br>Edit: So is #7 (and almost #8), #9, 10, 11, 12 are identical as well." — WhrRTheBaboons [c:50143185]

> （译文：顺带一提，头两个示例在 Pele 这边是一样的。<br>编辑：#7（以及几乎 #8）、#9、10、11、12 也都一样。）

作者给出的答案——"我故意只走语法、不走 Mermaid 的布局"——在 playground 里被并列对比，但官方 examples 那一页里前 12 个里有 7 个 Pele 输出跟 Mermaid 一样。卖点跟样品出现直接冲突，HN 的反应不是拒绝而是要求解释——这点对一个新工具来说是早期口碑的关键窗口。

### 命名与文化巧合

一个意外但占用大量 thread 长度的支线，是名字 "Pele" 在多种语言里的含义。

> "Just FYI, 'pele' is 'mouse' in Latvian. :)" — druvisc [c:50133945]

> （译文：顺带一提，"pele" 在拉脱维亚语里是"老鼠"。）

> "and 'skin' in portuguese :)" — hmokiguess [c:50134162]

> （译文：葡萄牙语里是"皮肤"。）

> "and a football player in brazil :D" — apodik [c:50134218]

> （译文：还有，巴西的足球运动员。）

> "and 'd*ck' in slovak..." — mtros [c:50134501]

> （译文：还有，斯洛伐克语里是"那玩意儿"。）

> "Spade in French." — aslakhellesoy [c:50134703]

> （译文：法语里是"铁锹"。）

> "No meaning in german." — Duke64 [c:50138792]

> （译文：德语里没这词。）

> "Brazilian me thought it was an homage to Pelé. I'm glad the text explains the name." — dkga [c:50138074]

> （译文：我作为巴西人以为是致敬 Pelé。很高兴正文解释了名字由来。）

> "Only with an accent on the final é." — mixmastamyk [c:50134596]

> （译文：只有带 é 这个重音的才是。）

> "I'm not Brazilian but i grew up in a world where EVERYONE knew who Pele is (maybe i'm a little old?)...So, i also thought the same, that this was named after him! :-)" — mxuribe [c:50142164]

> （译文：我不是巴西人，但我小时候全世界都知道 Pelé 是谁（可能我有点老？）……所以我也以为是致敬他！）

名字来源 kepano 在另一条 thread 里没明说，但从工具语义（轻量渲染）+ 项目风格看，更可能是拉脱维亚语 "mouse" 路径——小、灵活、嵌入。这条文化支线在 HN 上被自然消费掉了，没人对品牌营销做严肃讨论，但它在客观上把帖子顶得更久——这是 Pelé 名字的延伸效应，工具作者应该感谢。

### 它跟 Merman、elk、d2、Mermaid 的关系

最后被反复问到的，是 Pele 跟现有 Mermaid 替代品之间的关系。

> "There is also Merman on Github that outputs a SVG. https://github.com/Latias94/merman" — falsaberN1 [c:50135431]

> （译文：GitHub 上还有个 Merman 也是输出 SVG 的。）

> "I have had good luck with D2 and elk or dagre. If you get into the nitty gritty of elk you can do a lot with it." — thegagne [c:50135970]

> （译文：D2 配 elk 或者 dagre 我用得很顺。elk 抠细节能做很多事。）

> "The tala layout engine for d2 is now included it provides a very good layout." — jhoechtl [c:50137947]

> （译文：d2 的 tala 布局引擎现在内置了，布局效果很好。）

> "Could you not make Pele part of Mermaid or they wont accept a contribution like this?" — CrimsonRain [c:50136362]

> （译文：能不能让 Pele 并入 Mermaid，他们不会接受这种贡献吗？）

CrimsonRain 的问题背后是 kepano 自己在 Twitter 上发过的话：Mermaid 已经转去 mermaid.ai 这个方向，最新版本（12.1）换了第三套布局引擎，CVEs 安全记录也让人担心，Obsidian 1.13 不得不加个新开关来警示不安全 Mermaid 图。意思是"上游合并"基本不现实，Pele 单独存在是必然。

跟 D2 / elk / dagre 这条线相比，Pele 的差异是"保留 Mermaid 语法"。这是产品决策：保留语法意味着 Obsidian 用户、VS Code 用户、GitLab / GitHub README 用户已有的图不用改写，可以直接走 Pele 渲染。换 D2 等于让人重画图。这个 trade-off 是 Pele 真正吃到红利的入口，不是"另一个 Mermaid 替代品"。

> "A flowchart subgraph keeps its own direction even when it links to nodes outside the subgraph. This, in and of itself, is sufficient reason for me to switch, even if it were slower than Mermaid.js. I've not even made it through the list yet and I'm sold." — Ancapistani [c:50137419]

> （译文：flowchart 子图能保留自己的方向，即使它链到子图外的节点。光是这一条就够我换了，哪怕它比 Mermaid.js 慢。我还没看完列表就决定用 Pele。）

这条反馈反过来回答了 CrimsonRain 的疑问：Mermaid 在子图方向处理上是一个具体而持续的痛点，Pele 在这里"故意行为不同"恰好成了卖点。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 服务端渲染解放 | nickmain [c:50133359] | 不用浏览器就能跑 Mermaid 是大事 |
| 痛批 Chromium 依赖 | dont__panic [c:50140265] | 渲染 SVG 不该要一整个浏览器 |
| 静态站直接换 | bilibali [c:50141905] | 构建脚本用 Pele 替掉 mermaidjs，依赖瘦一大圈 |
| 暗色模式赞 | haburka [c:50138796] | 主题化+mermaid 服务端化是噩梦，Pele 解套 |
| 文档站实测好 | 9dev [c:50139527] | Pele 包揽了暗色主题、样式集成、布局 |
| 示例暗色翻车 | shellerik [c:50136733] | 官方 examples 在暗色下不够友好 |
| 布局差异存疑 | nkmnz [c:50140005] | 测了几张图，看不出明显布局差异 |
| examples 雷同 | WhrRTheBaboons [c:50143185] | 官方 examples 里 7 张和 Mermaid 一样 |
| 命名致敬 Pelé | dkga [c:50138074] | 巴西人都以为致敬球王 Pelé |
| 命名小语种梗 | druvisc/hmokiguess/apodik/mtros/aslakhellesoy [c:50133945-50134703] | 拉脱维亚/葡/巴/斯洛伐克/法各自的意思 |
| 并入 Mermaid 不现实 | CrimsonRain [c:50136362] | Mermaid 已经跑去 mermaid.ai，不会接受这种贡献 |
| 替代品对比 | thegagne [c:50135970] | D2 + elk/dagre 是另一条路，layout 更可控 |
| 子图方向为卖点 | Ancapistani [c:50137419] | 保留子图方向就够换工具 |

## 总体情绪

讨论的中心议题很集中——Mermaid 的"headless browser 依赖"是真实痛点，Pele 在这一点上正面回应，"CSS 变量驱动主题化"是配套惊喜。围绕这两点的赞是 HN 上最大块的声音。批评集中在三处：playground 里的对照模式 broken、官方 examples 在暗色模式下不够友好、Pele 自称的"布局不同"在官方示例里看不出明显差异——前两条是修起来很快的事，第三条是产品定位与样品呈现不一致的口径问题。

值得注意的是，命名带来的多语言闲聊把帖子顶了相当久——这通常意味着 HN 用户对一个工具的"立场分歧"还没形成，主流情绪仍在"体验一下"的阶段。等到一周后有真实用户反馈"用 Pele 替掉了 X"或"用例上不如 X"，讨论才会从氛围转向判断。

> 一个把浏览器从管线里拆下来的库，听上去不算大事，但你被它坑过就不这么想了——而 HN 上这次被打动的，多数是已经被坑过的人。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Pele – Mermaid diagrams as themeable SVG | https://news.ycombinator.com/item?id=50132193 |
| 2 | Pele 项目主页 | https://pele.run/ |
| 3 | Pele 源码 | https://github.com/obsidianmd/pele |
| 4 | Playground Compare 模式 | https://pele.run/playground |
| 5 | Mermaid 12.1 上下文（kepano 推文） | https://x.com/kepano/status/2111575190081847776 |
| 6 | Playground 错误日志（kinduff） | https://gist.github.com/kinduff/7eb14bf348fdec4e664b59e758d1d0ec |

## 免责声明

<div class="disclaimer">

本文为 AI 辅助整理的 HN 讨论摘要，仅反映所引用用户发言在抓取时刻的内容与立场，不代表本站观点。所有引文与 ID 均对应 HN 原帖评论，事实校验请直接前往原帖。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
