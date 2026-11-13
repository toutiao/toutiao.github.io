---
layout: post
title: >-
  300 美元绣花机被订阅锁住，他用 Rust 写了个带 MCP 的替代品 — HN 讨论摘要
date: 2026-11-14
hn_id: 50470488
categories: [articles]
excerpt: >-
  300 美元买来的绣花机，软件按月收费。作者用 Rust 写了个替代品 ZigZag，AI agent 直接画花样，
  还逆向出蓝牙协议直连机器——评论区一半在骂订阅制，一半在吵 AI 到底该不该干这活。
tagline: >-
  一次性付费的软件才叫软件，订阅只是租。
---

> 来源：HN 讨论主帖 [Show HN: My $300 embroidery machine needed a subscription, so I built my own app](https://news.ycombinator.com/item?id=50470488)（607 分，203 条评论），指向 GitHub 仓库 [simpsoka/zigzag](https://github.com/simpsoka/zigzag)。本篇为 single post 模式。主帖归档抓取于 2026-11-13 14:05 UTC，入库 152 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。归档文章正文为 README 前 8000 字符，其后的功能说明、Status 章节与 NOTICE 授权信息于成文时从仓库最新版本补全。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

> ⚑ **模型立场对比**：本文引用的评论涉及各家模型的拒答边界（逆向工程、绕过订阅、下载受版权保护的旧电影），以及不同来源模型在这类请求上的行为差异。所引观点按原帖立场呈现，不代表本项目立场。⚠ Review recommended.

## 原文概要

事情的起点很朴素：一台 300 美元的绣花机，和一套按月收费的软件。发帖人 simpsoka 选的是 Brother Skitch PP1，「在亚马逊上大概 300 美元」，评价很差——但他认为差评大多不是机器的问题，而是软件做得烂加上订阅费：免费版能做的事非常有限，颜色数、工具都被卡着；他还提到订阅里附赠了一些 clip-art，「挺糟的」。

他的解法叫 ZigZag，一个用 Rust 写的可视化刺绣编辑器，开源在 GitHub，官网是 zigzag.diy。它内置 MCP（Model Context Protocol）支持，让 AI agent 能和你一起创建、修改花样；导入 SVG，转成针迹，导出 PES、DST、EXP、JEF、VP3 等格式；还可以直接通过蓝牙把花样送到 Brother Skitch（PP1）——协议是逆向来的，所以 README 里明确写着不要升级固件。仓库里的 NOTICE 文件把来路交代得很清楚：Brother PP1 的蓝牙协议和缝制流程移植自 jhbruhn 的 respira（Apache-2.0），PES/PEC/DST 的文件布局和 Brother 线号表来自 pyembroidery（MIT），图像描摹（Image Trace）整段 vendored 自 VectorCraft（MIT 或 Apache-2.0），平铺填充（tatami）、缎面与短针的处理思路则参照 InkStitch。

工程量不小。针法表列了填充（tatami）、缎面、运行针、轮廓、毯式、贴布、手工针、meander、ripple、十字绣和 tartan 十一种；planner 负责去重叠（保留 0.5 毫米）、盖布顺序、路径规划（走针尽量不出现在看得见的地方，实在没办法才剪线，最多容忍 50 毫米的空程）、每个对象的起止针与剪线/停机控制、面料预设（标准、薄棉帽、有结构帽、针织）、以及窄填充、小字号、过小缝隙、绣框尺寸等一整套数字化检查；宽度超过 7 毫米的缎面会自动拆成错落的短针，密度图能看出哪里针脚堆叠。README 的 Status 章节写着 136 个库测试、153 个编辑器与 MCP 测试，外加 vendored 描摹代码自带的 222 个测试，并且「已在真实的 Brother Skitch（PP1）上测试」。Mac 版是签名并做过 Apple 公证的 DMG，Windows 版解压即用、但第一次会被 SmartScreen 拦一下。

而 AI 不是一个附加功能，是它的地基。Studio 里的 MCP 服务跑在 `http://127.0.0.1:7878/mcp`，工具包括 `add_svg`、`set_object`、`export`、`trace_image`、`send_to_skitch` 等等；侧边栏还有一个「Ask an agent」面板，会在后台拉起 Claude Code 或 Codex 连到这个服务上——它只能用设计相关的工具，不能碰 shell、不能改文件。命令行那边是 `zigzag convert`、`zigzag info`、`zigzag fabrics`、`zigzag skitch send`。

最后是这场讨论真正的走向：一件用来反抗订阅锁的工具，本身是被 AI 写出来的。「ChatGPT，差不多了！」发帖人自己这么答——如果全靠手写，他大概不会启动这个项目，但用 AI 做「相当容易」，而且内置了 MCP，「个性化软件的时代到了」。于是评论区分成两半：一半在骂订阅制和硬件厂商的 DRM，另一半在争 AI 该不该干这种事——而这个项目本身成了证据：有人贴出 Claude 拒绝为刷写自家摄像头而伪造服务器的经过，说 Codex 一分钟就搞定了；也有人指出这个项目的帖子和 README 里都没写 respira 的名字，暗示这类「自己写」在自由软件精神里站不住脚。

## 讨论焦点

### 一、订阅才是原罪：300 美元买来的机器，软件按月租

先把机器和软件的关系摆清楚，是这一帖里多数人默认的前提。

> "I went with the Brother Skitch PP1. It&#x27;s right around $300 on amazon. It has sub-par reviews, but I realized that most of those were because of the poorly built software and subscription fee..." — simpsoka [c:50472427]
> （译文：我选的是 Brother Skitch PP1，在亚马逊上大概 300 美元。它的评价很差，但我后来意识到那些差评大多是因为软件做得烂、以及订阅费。）

发帖人这句话等于给整场讨论定了性：机器的评价差，责任在软件和订阅上。

真正让人痛的是那些已经在这件事上栽过跟头的人：

> "Back when I was trying to do embroidery with my $300 machine, I found that Hatch was the only software that would consistently give me good results. The only problem was that Hatch (at the time) was over $1,000 USD. I am a hobbyist, I refuse to pay that much for a hobby I hardly engage with. The saving grace there was that Hatch had a 30 day free trial, which I could continue to renew with a different email.<p>About a year into doing this, they patched it so the license server would save your HWID and would not run in a VM anymore. I decided to just give up on the hobby right there." — thedellmonitor [c:50472840]
> （译文：我当年想玩刺绣的时候，也是用的 300 美元那档机器，那时候只有 Hatch 这套软件能稳定出好结果。问题是 Hatch 当时要 1000 多美元。我只是个爱好者，不愿意为一个几乎不怎么玩的爱好花这么多钱。它唯一的救赎是有 30 天免费试用，我靠换个邮箱一直续下去。<p>大概做了一年之后，他们打了补丁，许可证服务器会记住你的硬件 ID，也不再允许在虚拟机里跑。我当场就决定放弃这个爱好了。）

「许可证记住硬件 ID」这一句是整段最沉的地方：不是不能破解，而是破解到某个程度就该收手，于是爱好者直接把机器搬进车库。

订阅的怨气也不止绣花：

> "I&#x27;d love a replacement for Cricut&#x27;s software. You don&#x27;t <i>need</i> a subscription for it but a few features are locked behind a subscription, and they nag a lot, and it&#x27;s just <i>so bad</i>." — Rohansi [c:50472834]
> （译文：我很想要一个能替代 Cricut 软件的东西。你其实<i>不需要</i>订阅，但有几个功能被锁在订阅后面，而且他们没完没了地弹窗提醒，而且它<i>就是</i>那么糟糕。）

### 二、AI 写的算不算「写」：归属、支持，和一次性买断

这条线的火药味不亚于订阅之争，而且是从「作者到底干了什么」开始的。

> "ChatGPT, but close! You&#x27;re right, I likely wouldn&#x27;t have approached the project if I had to write it all by hand. But it was fairly easy with AI, and I was impressed with the results. The days of personalized software are here. I built it exactly to my spec - similar to Adobe suite, and with built in MCP support." — simpsoka [c:50472718]
> （译文：ChatGPT，差不多了！你说得对，如果要全部手写，我大概根本不会启动这个项目。但用 AI 做相当容易，而且结果让我挺满意的。个性化软件的时代到了。我完全按自己的规格把它做出来了——类似 Adobe 套件那种，而且内置了 MCP 支持。）

紧接着就有人指出这笔账没算清：

> "Well, you did build part of it (and, technically, claude did that), but the groundwork was the existing respira by someone else.<p>So.. eh.<p>I mean it&#x27;s cool and all, and at least claude did do proper attribution in the code, but your post kinda does not and neither does the readme.<p>That&#x27;s not exactly in spirit of FOSS." — hypfer [c:50474815]
> （译文：你确实做了一部分（严格说是 claude 做的），但地基是别人已经写好的 respira。<p>所以……也就那样吧。<p>我的意思是，这东西确实挺酷，而且至少 claude 在代码里做了正当的署名，但你的帖子没有写，README 也没写。<p>这可不符合作自由软件的精神。）

被点名的那个人自己出来作证：

> "The reverse engineering of the protocol was actually done with Claude Opus 4.8 last year. Source: me [0], but also noted in the source here and at least also in some separate file." — jhbruhn [c:50474839]
> （译文：协议的逆向工程其实是去年用 Claude Opus 4.8 做的。来源：我自己[0]，不过在代码里也写了，另外至少还有一个单独的文件记着。）

于是自由软件的旧账被翻了出来——软件值不值钱，取决于还有没有人在维护它：

> "What is the point of &quot;support&quot; if the LLM can do it cheaper if not for $0?<p>The FSF also did not think about another freedom that is included when work becomes so cheap it is essentially free:<p><i>&quot;The freedom to not pay for your software or for support.&quot;</i>" — rvz [c:50476938]
> （译文：如果 LLM 能更便宜地做，甚至免费做，「支持」还有什么意义？<p>FSF 也没想到还有另一种自由，它会在工作变得如此廉价以致近乎免费时一并出现：<p><i>「不为你自己的软件付费、也不为支持付费的自由。」</i>）

而对「我自己的东西」的渴望，是这帖里少见的正面情绪：

> "What are you talking about. This software is like the old paid-once Photoshop. Once you have it, _it&#x27;s yours_. I find that so incredibly liberating, I&#x27;m finally making software that I own at the end." — gambiting [c:50473275]
> （译文：你在说什么呢。这个软件就像当年一次性付费的 Photoshop。一旦拿到手，它<i>就是你的了</i>。我觉得这太让人解脱了，我终于在做一个我最终拥有的软件。）

### 三、护栏：Claude 不肯干的活，有人自己干了

讨论从绣花滑向 AI 政策，而且滑得很快。批评者盯着的不是这个项目，而是同一类事情在别处被拒绝。

> "Claude seems to be backing out of doing this kind of thing. It didn&#x27;t want to create a fake server so I could flash <i>my</i> camera. I argued with it about how where I live I have the legal right to do this. It agreed but still wouldn&#x27;t do it.<p>Codex did it and flashed it in 1 minute.<p>I&#x27;m all for AI safety, but this sounds more like corpo preference safety to me.<p>The more people do stuff like this, the better. Subscription based e-waste is awful." — jsLavaGoat [c:50473668]
> （译文：Claude 好像正在退回去，不做这类事了。它不愿意为我刷写<i>我自己</i>的摄像头而搭一个假服务器。我跟它据理力争，说我所在的地方我有这么做的合法权利。它同意，但还是不肯做。<p>Codex 做了，一分钟就刷进去了。<p>我支持 AI 安全，但这听起来更像「企业偏好式安全」。<p>越多的人做这种事越好。基于订阅的电子垃圾太糟了。）

有人立刻把担忧说成了时间表：

> "&gt; I&#x27;m all for AI safety, but this sounds more like corpo preference safety to me.<p>When I&#x27;m doing stuff like this, I always have this thought in the back of my head like &quot;man, this is awesome- I bet they try to stop people from doing stuff like this soon&quot;. Like there&#x27;ll be an in-built &quot;do not assist in reverse engineering or circumventing subscription-based services&quot; instruction." — RankingMember [c:50474100]
> （译文：> 我支持 AI 安全，但这听起来更像企业偏好式安全。<p>我做这类事的时候，脑子里总有个念头：「哇，这个太棒了——我敢打赌他们很快就会想办法阻止大家做这类事。」比如内置一条「不得协助逆向工程或绕过订阅服务」的指令。）

也有人已经遇到了模型变卦：

> "&gt; Claude seems to be backing out of doing this kind of thing.<p>Claude now refuses to reverse engineer games to fix compatibility issues on Linux&#x2F;Proton, particularly in relation to anti-cheat software. Codex still works, and while Claude is still useful for other types of work, I am considering a migration to GLM and DeepSeek." — drnick1 [c:50474119]
> （译文：> Claude 好像正在退回去，不做这类事了。<p>Claude 现在拒绝为了修复 Linux/Proton 上的兼容问题去逆向游戏，尤其是涉及反作弊那部分。Codex 还能用，而 Claude 在别的活上仍然有用，但我正在考虑迁移到 GLM 和 DeepSeek。）

把各家模型摆在一起比较的评论更直接：

> "US models are getting put on a leash in the direction of intellectual property.<p>Recently both Claude and ChatGPT refused to help me download a &quot;backup&quot; of an old movie you couldn&#x27;t get elsewhere.<p>Chinese models had no qualms." — dachris [c:50479444]
> （译文：美国这边的模型在知识产权这件事上正在被套上缰绳。<p>最近 Claude 和 ChatGPT 都拒绝帮我下载一部「别处拿不到」的旧电影的备份。<p>中国的模型就没有这些顾虑。）

反对「纯度检验」的人也不在少数：

> "<i>Have you</i>, though?<p>Will this stop operating if you unsubscribe from claude?<p>Will add-on work from chatgpt or Kimi or Qwen require starting from scratch?<p>Obviously, the answer is &#x27;no&#x27;. So regardless of the &quot;do you understand the code&quot; purity test, this is still a net good, both for this customer, and others who can make use of this work..." — hex4def6 [c:50473211]
> （译文：<i>话说回来</i>，你懂吗？<p>取消 claude 订阅之后这东西还能用吗？<p>用 chatgpt 或 Kimi 或 Qwen 做的这些活，需要从头再来一遍吗？<p>显然答案都是「不」。那么不管「你是否理解代码」这种纯度检验怎么说，这对这位客户、以及其他能用上这份工作的人，都仍然是净收益……）

而最实际的一条路，直接绕过了模型：

> "I don’t know if this still works but when Claude Code refuses something like this I have quit the session, edited the jsonl history to turn the denial into an acceptance, resumed the session and carried on with my task" — moonsu [c:50481194]
> （译文：不确定现在还有没有用，但当 Claude Code 拒绝这类事时，我会退出会话，把 jsonl 历史里的「拒绝」改成「接受」，然后恢复会话继续干我的活。）

### 四、拦不住：封锁只会催生更多的绕过

有人担心这类项目活不长，理由是厂商会用同一批模型加固自家设备。

> "We should kill subscription models with LLMs app by app (and possibly server by server) until hardware is sold as standalone hardware with no strings attached. I don&#x27;t care if this slows down r&amp;d or makes printers more expensive. Hardware vendors have abused the subscription model to a point that they can&#x27;t be trusted with it." — curtisblaine [c:50472714]
> （译文：我们应该用 LLM 一个应用一个应用地（甚至一个服务器一个服务器地）把订阅制干掉，直到硬件以不附带任何条件的独立硬件形态出售。我不在乎这会拖慢研发、或者让打印机更贵。硬件厂商滥用订阅模式到了不值得被信任的地步。）

> "Love this type of stuff but afraid it won&#x27;t last. Only a matter of time before OEMs ask same LLM to setup secure boot with signed firmware with anti-rollback and pinned certs.<p>There is already prior art like anything Google (phones, Fitbit)" — nijave [c:50474205]
> （译文：喜欢这类东西，但怕它长不了。OEM 让同一个 LLM 去搭安全启动、签名固件、反回滚和固定证书，只是时间问题。<p>已经有先例了，比如 Google 的那些东西（手机、Fitbit）。）

但评论区的判断是，屏障从来不是技术难度，而是厂商故意的阻拦：

> "The primary barrier is not the difficulty of writing some drivers for a piece of hardware, it&#x27;s the intentional barriers that the mfg puts in your way so that that is harder to do -- lack of docs, obfuscation, various kinds of drm. A win is a win, but the same will happen in this new world. The barriers will just have to be built a bit higher until most users give up." — topaz0 [c:50482018]
> （译文：主要的障碍从来不是「给一件硬件写点驱动」有多难，而是厂商故意竖在你面前、让这件事变得更难的那些障碍——没有文档、混淆、各式各样的 DRM。赢是赢了，但在这个新世界里同样的事还会发生。障碍只会垒得更高，直到大多数用户放弃。）

屏蔽模型权重这条路线也被判了死刑：

> "Hugging face is a repository for models others make. If they want to play cop, it will be about as effective as trying to stop people from torrenting movies (because the weights will just end up on torrents)." — dghlsakjg [c:50477490]
> （译文：Hugging Face 是个存放别人做的模型的仓库。如果他们想当警察，那效果大约等同于阻止人们下载电影种子（因为权重最后只会出现在种子上）。）

> "&gt; because the weights will just end up on torrents<p>They already are.<p>...I&#x27;ve also recently seen here on HN an initiative to torrent &quot;rare&quot; models, but I can&#x27;t manage to find it back." — ale42 [c:50481978]
> （译文：> 因为权重最后只会出现在种子上<p>已经在了。<p>我最近还在 HN 上看到一个专门传「稀有」模型的计划，只是没能再翻出来。）

### 五、同类项目：InkStitch、NewHat、stitchslop，还有林纳的一个驱动

评论区里不缺同行的名字，而且多半不是新面孔。

> "For anyone interested in this space, I&#x27;d also recommend looking at InkStitch[0], which is a plugin for InkScape. It allows you to take SVGs and export them into file types that an embroidery machine can use. It&#x27;s not without its faults (there is a surprising amount of care needed for any design - stitch placement, size, type, layering, etc), but it&#x27;s been a fun experience to take an SVG and turn it into something real." — rocmcd [c:50473413]
> （译文：给对这块感兴趣的人，也建议看看 InkStitch，它是 Inkscape 的插件，可以把 SVG 导出成绣花机能用的文件格式。它也不是没有毛病（任何一个设计都需要出人意料的细致功夫——针迹摆放、尺寸、类型、层次等等），但把一个 SVG 变成真正能缝出来的东西，这经历挺有意思。）

> "Inkstich is the best option right now, but I can&#x27;t wait to see the new possibilities now with AI. Inkstitch feels very disadvantaged by being a plugin, everything you do requires navigating multiple layers deep in the inkscape plugin menu.<p>A from scratch embroidery program could lift all of these options to the top layer UI where they belong, but understandably rebuilding the whole editor part is a lot of code." — Gigachad [c:50475163]
> （译文：眼下最好的选择还是 InkStitch，但我等不及 AI 带来的新可能了。InkStitch 身为插件太吃亏了，干什么都得在 Inkscape 的插件菜单里翻好几层。<p>一个从零写起的刺绣程序能把这些选项全提到最上层的界面上，那才是它们该待的地方，不过重写整个编辑器部分显然是个大工程。）

> "Interesting. I have been having fun working on &quot;NewHat&quot; for a while - meant for Toyota&#x2F;Tajima machines...<p>I used to use the Melco and Pantagrams digitizing software and operated kiosks doing custom embroidery." — itomato [c:50472886]
> （译文：有意思。我玩 NewHat 有一阵子了，它是给 Toyota/Tajima 的机器用的。……<p>我以前用 Melco 和 Pantagrams 的制版软件，还经营过做定制刺绣的柜台。）

> "William Osman built a browser app that works pretty well too: ...<p>I think that one was built with Claude (he wanted to embroider cats on merch, and didn&#x27;t like the expensive subscription software&#x27;s ancient UX)." — geerlingguy [c:50473199]
> （译文：William Osman 也做了一个浏览器里的应用，效果相当不错：……<p>我想那个是用 Claude 写的（他想在周边商品上绣猫，受不了那套昂贵订阅软件的老派交互）。）

> "Interesting, Youtuber William Osman is also working on something similar, but for full size industrial machines. I&#x27;m not sure if its public released yet though.<p>Also don&#x27;t forget Linus him self wrote one of the embroidery machine drivers for Linux." — mmmlinux [c:50472695]
> （译文：有意思，YouTuber William Osman 也在做一个类似的东西，只不过是给工业级大机器用的，还不确定有没有公开发布。<p>另外别忘了，林纳本人就写过 Linux 上的一个刺绣机驱动。）

### 六、能不能真跑起来：文件合法性、机器安全，和那条被改掉的 Status

越是看起来越好的项目，评论区越要检查它到底跑不跑得起来。

> "I&#x27;m curious, how do you make sure that the embroidery files are valid of the file type (.exp) for example, and that B) things aren&#x27;t done in such a way that cause the needle to break, stiches to overlap too much, etc etc that would otherwise harm a machine that reads the file?" — ssgodderidge [c:50473840]
> （译文：我好奇一个问题：比如 .exp 这种文件格式，你怎么保证生成出来的是合法的；还有，怎么保证不会做出那种会把针弄断、针脚重叠过密之类的事，反过来伤害读取这个文件的机器？）

作者的答复是关于密度和字节布局的：

> "Every format is written from the same list of stitch commands using byte layouts from pyembroidery. For machine safety, the defaults use standard densities and stitch lengths. There’s also a density map that shows where stitches pile up. If you give it a try and experience any problems, create a GH Issue and i&#x27;ll look into it!" — simpsoka [c:50474076]
> （译文：每种格式都是从同一份针迹指令表写出来的，用的是 pyembroidery 的字节布局。为了机器安全，默认值采用标准的密度和针长。另外还有一张密度图，能看出针脚堆在哪儿。你要是试了之后遇到什么问题，去 GitHub 提个 issue，我来查！）

质疑来自一个更朴素的观察——直接读了 README 的 Status 章节：

> "The Status section on the github page says:<p>&gt; Not yet run against a real Skitch.<p>So it possibly doesn&#x27;t work on anything." — masfuerte [c:50473634]
> （译文：GitHub 页面的 Status 章节写着：<p>> 还没在真实的 Skitch 上跑过。<p>所以它可能压根儿什么都不管用。）

（作者随后补了一条更正。）

> "Sorry, this needs to be updated. It does work, and works well." — simpsoka [c:50473709]
> （译文：抱歉，这条得更新一下。它确实能用，而且很好用。）

### 七、这软件该值多少钱，谁会买

最后一轮讨论回到生意上。

> "Embroidery has a lot of hobbyists who pay absolutely ridiculous money for digitizing software. It is in dire need of cheap and easy solutions. I worked on this problem about 10 years ago with a friend. We built out fairly sophisticated digitization library for a good amount of embroidery formats. We ended up booking a booth at an embroidery roadshow to show our work and unfortunately things fizzled out before we got there. Good to see this niche getting disrupted." — sakopov [c:50475323]
> （译文：刺绣圈有大量爱好者，为制版软件付着荒唐的价钱。这个领域极其需要便宜又好用的方案。我十年前和朋友做过这个问题，我们给相当多种刺绣格式写了一套挺像样的制版库。我们当时订了展位想去刺绣展展示成果，可惜没到开展就黄了。很高兴看到这个细分领域被搅动起来。）

> "I did not know you could get an embroidery machine for $300!! This seems very cool. T-shirts with an embroidered logo always look so much nicer than any others. I could see myself getting into this." — mosselman [c:50475344]
> （译文：我居然不知道绣花机 300 美元就能买到！这也太酷了。T恤上绣个 logo 永远比印的好看太多，我都能想象自己入坑。）

> "So how much would you pay to be able to do that? $30, 40, 100? Once they IPO, they&#x27;ll find out exactly how much they can sell the same things back to you for." — tencentshill [c:50473054]
> （译文：那你能做这些事，愿意付多少钱？30 美元、40 还是 100？等他们上市，就知道这些东西他们能卖回给你多少钱了。）

反对者则指出，能自己干这活的人本来就少：

> "Sure, but that requires a skilled engineer to own the embroidery machine, and have sufficient free time and interest to devote to reverse engineering the embroidery machine. The overlap of skills and expertise there is vanishingly small for niche products, which, most discontinued products are....<p>Any reduction in e-waste and user empowerment is a cause to be celebrated. The catalyst for GNU was not being able to fix printer drivers. For all its evils and ills, I am so happy to see useless objects essentially being “repaired” by normal people using LLM assisted coding." — Fwirt [c:50476968]
> （译文：话是这么说，但这要求一个熟练的工程师拥有这台绣花机，还得有足够的空闲时间和兴趣去逆向它。对这类小众产品来说，技能与经验的重叠小得可以忽略，而大多数停产的机器正是这种。……<p>任何减少电子垃圾、让用户更有自主权的努力都值得庆祝。GNU 的催化剂正是不打不了打印机驱动。就算它有那么多恶行与弊病，我还是很高兴看到无用的物件在实质上被普通人用 LLM 辅助的编程「修好」了。）

还有一条更不留情面的：

> "This is some insane self aggrandizement of the work of a software engineer.<p>20$ Claude making some app that a skilled engineer could make in a few weekends doesn’t change the face of earth. Actually if Claude made the world’s greatest embroidery software that no human could ever make, it still doesn’t matter because frankly most software does not matter much. Your average house has more meaning and longevity than a piece of software." — sashank_1509 [c:50476821]
> （译文：这是对软件工程师工作的一种疯狂自我吹捧。<p>20 美元的 Claude 做出了一个熟练工程师几个周末就能做出来的 app，这并没有改变地球的面貌。其实就算 Claude 做出了人类永远做不出的世界上最伟大的刺绣软件，也依然无关紧要，因为坦白说大多数软件都没那么重要。你家平均而言比一段软件更有意义、更经久。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 订阅是原罪 | curtisblaine | 硬件厂商把订阅用到不值得被信任 |
| 一次买断才算拥有 | gambiting | 软件终于归我，而不是租用 |
| 旧订阅把人逼走 | thedellmonitor | 许可证记住硬件 ID，我当场放弃这个爱好 |
| 订阅蔓延到别的设备 | Rohansi | Cricut 的软件同样烂，还一直弹窗 |
| 归属必须写清 | hypfer | README 里没有 respira 的名字 |
| 协议逆向是去年的事 | jhbruhn | 用的是 Claude Opus 4.8，作者是我 |
| AI 写的也有价值 | hex4def6 | 有需求、解决了、分享了，就该记一功 |
| 支持不再是必需品 | rvz | 不为软件付费、也不为支持付费的自由 |
| 工具只是自我吹捧 | sashank_1509 | 20 美元的 Claude 改不了地球 |
| 护栏是企业偏好 | jsLavaGoat | 拒绝是企业偏好，不是 AI 安全 |
| 护栏会继续收紧 | RankingMember | 他们迟早会写死「不得协助绕过订阅」 |
| 护栏正在收紧 | drnick1 | Claude 连 Linux/Proton 逆向都拒了，正考虑迁移到 GLM 和 DeepSeek |
| 绕过拒答有办法 | moonsu | 把 jsonl 里的「拒绝」改成「接受」 |
| 屏蔽挡不住人 | dghlsakjg | 拦下载就像拦种子 |
| 现有方案仍最好 | Gigachad | InkStitch 眼下仍是最好的选择 |
| 同一片林子里 | mmmlinux | 林纳自己就写过 Linux 的刺绣机驱动 |
| 真机测试有人核实 | masfuerte | Status 说还没在真 Skitch 上跑过 |
| 项目已经过验证 | simpsoka | 它确实能用，而且很好用 |
| 定价是个问题 | tencentshill | 你会定价 30、40 还是 100 美元？ |

## 总体情绪

这一帖最反常的地方在于：一台 300 美元的绣花机，居然成了 AI 围栏、订阅制和自由软件归属三方混战的现场，而真正的刺绣工艺只占了很小一部分。讨论的情绪是分裂的：一半人把 ZigZag 当作「硬件归我」的样板工程，看到的是一个终于能被拆开、重新写一遍、还能让 AI 一起动手的旧机器；另一半人盯着它是用 Claude 写的、协议是逆向来的、作者自己都承认「手写的话根本不会启动这个项目」，于是把矛头转向更大的问题——模型该不该写这类代码，模型什么时候会拒绝，厂商会不会用同一批模型把门重新锁上。

值得注意的是，第三种声音始终没有缺席：既有已经买了 Hatch 又被锁硬件 ID 劝退的爱好者，也有十年后仍然记得展位没去成的老玩家。他们对「软件成本」这件事的判断，比对「模型能不能写」清楚得多——刺绣制版软件的价格离谱了十年，现在终于有人用开源加 AI 把它压了下来。反倒是那些讨论「这软件该卖多少钱」的评论，很快就会发现一个更难的问题：能自己干这活的人太少，所以这东西最后很可能免费，而免费意味着没人维护。

把这一帖的两端接起来看，最有意思的顺序其实是反的：先是有人抱怨机器被订阅锁住，然后是有人用 AI 把它砸开，再然后是有人担心下一个版本的模型会不肯再砸。机器的控制权先被厂商用订阅收走，再被用户用大模型夺回来——只是这一次，夺回来还得多一道手续，得看哪家模型那天心情好。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Show HN: My $300 embroidery machine needed a subscription, so I built my own app（HN 主帖） | <https://news.ycombinator.com/item?id=50470488> |
| 2 | ZigZag 仓库（GitHub） | <https://github.com/simpsoka/zigzag> |
| 3 | ZigZag 官网 | <https://zigzag.diy/> |
| 4 | NOTICE：授权与来源说明（Apache-2.0，含 respira / pyembroidery / VectorCraft） | <https://github.com/simpsoka/zigzag/blob/main/NOTICE> |
| 5 | respira：Brother PP1 蓝牙协议逆向（jhbruhn） | <https://github.com/jhbruhn/respira> |
| 6 | pyembroidery：PES/PEC/DST 文件格式实现 | <https://github.com/EmbroidePy/pyembroidery> |
| 7 | VectorCraft：图像描摹（Image Trace）代码来源 | <https://github.com/storytold/vectorcraft> |
| 8 | InkStitch：Inkscape 刺绣插件 | <https://inkstitch.org/> |
| 9 | NewHat：面向 Toyota/Tajima 机器的生成式设计 | <https://github.com/wjkennedy/NewHat> |
| 10 | stitchslop：William Osman 的浏览器版刺绣工具 | <https://www.stitchslop.com/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 607 分、203 条评论，归档快照 2026-11-13 14:05 UTC，入库 152 条评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。本文关于 ZigZag 功能范围、针法与 planner 行为、测试数量、授权与移植来源、以及「已在真机测试」的叙述，依据仓库 README 与 NOTICE 于成文时取到的版本；README 的 Status 章节在讨论期间发生过更新，评论区中「尚未在真机跑过」的说法与作者更正是同一件事的前后两版。文中关于各家模型拒答边界、以及不同来源模型行为差异的表述，均为评论者个人观察，本站未做独立核实，读者亦应注意这些说法带有时效性。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
