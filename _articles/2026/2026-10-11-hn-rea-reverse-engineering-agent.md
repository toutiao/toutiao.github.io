---
layout: post
title: >-
  REA 把"逆向工程"塞进 coding agent 后,HN 在吵什么
date: 2026-10-11
hn_id: 50028275
categories: [articles]
excerpt: >-
  给 AI agent 装上 Ghidra、capstone、调用约定视角,让它自动拆 Windows 计算器的 % 按钮——rea.tools 上线后,讨论很快滑进三个老问题:用 AI 拆二进制算不算干净室、商业克隆的边界在哪、AI 公司自己的安全护栏为何要挡 RE。
tagline: >-
  你以为自己在掘金,其实你只是在给 AI 训练数据洗钱。
---
> 来源:HN 热门榜(/best),REA — Reverse Engineering for Your Coding Agent(https://news.ycombinator.com/item?id=50028275)。

## 原文概要

REA(morluto 团队)在 rea.tools 发布了一款把"逆向工程"工作流打包给 coding agent 的工具链。安装方式不再是手把手配 Ghidra,而是把下面这一行塞给你的 agent 让它自己去接:

```
Install REA and connect it to this coding agent using npx rea-agents@latest setup.
Show me the setup plan for approval, then verify the installation.
```

REA 网站放了两段完整 case study,展示恢复出的真实机器码:

- Windows 计算器 `%` 按钮:200 + 10% 为什么是 220。关键不在于百分比是什么,而是按下了 `+` 之后,`%` 实现走的是 `current * previous / 100`,而不是 `previous * 0.10`。页面把对应 x64 汇编贴了出来,并注明 `IDC_MUL = 0x5c`、`IDC_DIV = 0x5b`、`IDC_PERCENT = 0x76`、`0x64 = 100`。
- Chrome 恐龙游戏:加速规则是 `if (this.currentSpeed < this.config.MAX_SPEED) this.currentSpeed += this.config.ACCELERATION;`,即初始 6,每帧 +0.001,上限 13。代码标注 BSD,作者 Chromium Authors。
- 网站自己再留一句挑衅:让 REA 拆 rea.tools 自己,然后 clone。

它不是新逆向引擎,它是一份给 agent 的"操作手册 + 工具集 + 示例 prompt",目标是把需要几年积累的 RE 经验压缩到几次对话里。

## 讨论焦点

### 一、比 Claude 直装 Ghidra 强在哪儿

最常见的第一个反应是这层工具到底有什么必要——直接让 Claude 装个 Ghidra 不就行了吗?

> "I might be missing something but... How exactly is this better than telling Claude for example to "install and set up a full RE environment including Ghidra" on my local system and get to work? Like what does this do that my current RE methodology doesn't?" — ethin [c:50028470]
> （我可能漏了什么……直接让 Claude 在本机装一套完整的 RE 环境包括 Ghidra 然后干活不就完了吗?这个工具比我现在的方法到底强在哪?）

> "Everybody has their own set of skills and specific scripts and tools to do this stuff. You might use Ghidra as the the kernel of those workflows, but you still want something more than just Claude freestyling, at least for now.<p>(Who knows if this'll be true 6 months from now.)" — tptacek [c:50028484]
> （每个人都有自己的脚本和工具链,Ghidra 可能只是工作流的内核,但你还是要比 Claude 自由发挥多一点东西,至少目前如此。<p>(半年后是不是还这样不好说。)）

> "Probably it is not better. I think this is aimed at people who do not have a "current RE methodology", do not know enough to specify things like Ghidra, etc., but who do have a desire to feel like they reverse-engineered and can reliably predict that a conversation with a chatbot will make them feel that way." — fwlr [c:50028840]
> （可能也没多强。我的理解是它面向的是那些没有自己现有 RE 方法、不知道该怎么用 Ghidra 之类东西,但仍然想体验一下"我自己逆向过了"这种感觉、并相信跟聊天机器人聊一聊就能拿到那种感觉的人。）

> "Vibe-reverse-engineering" — garyfirestorm [c:50029045]
> （氛围逆向工程。）

讨论到这里把 REA 的市场定位说清了:它不是给老手的更强工具,而是给"想体验 RE 的人"的打包套装——产品形态跟 vibe coding 一脉相承。

### 二、闭源 RE:法律雷达还罩得住吗

也有人立刻把视角拉到 NVIDIA、Nintendo 这类终极对手上,问 REA 是不是把这些护城河都刨了。

> "Now there are no excuses to reverse engineer the most notorious closed source binaries out there including from Nintendo's system software to CUDA, and nvcc from Nvidia and make it all "open source". The only problem is the lawyers at all those companies will be readying their lawsuits, and given they have tons of money; they do not care and will come after anyone." — rvz [c:50028933]
> （现在没有任何借口不去把最臭名昭著的闭源二进制拆了开源,从 Nintendo 系统软件到 NVIDIA 的 CUDA 和 nvcc。唯一的问题是这些公司的律师已经在磨刀了,他们有钱,不在乎,谁搞就告谁。）

> "Why wait months for Nvidia to fix their compiler bugs when its far more faster to do it in the open? Libraries that invoke nvcc don't want to wait either.<p>So really closed-source compilers are a hindrance and you're subject to unspecified time-frames to even get to fix your issue rather than doing it yourself.<p>Intel and AMD have already open up theirs without question. Nvidia is the one who claims to be supporting openness in AI but can't even open up nvcc let alone CUDA." — rvz [c:50030335]
> （为什么要等几个月等 NVIDIA 修编译器 bug?开源干更快。<p>调用 nvcc 的库也不想等。<p>所以闭源编译器就是个累赘,你得忍受不可预期的时间表才能修自己的问题,而不是自己动手。Intel 和 AMD 都开源了,NVIDIA 嘴上说支持 AI 开放,自己 nvcc 甚至 CUDA 都不开。）

> "What do you plan to do with a reverse engineered nvcc?" — saagarjha [c:50030204]
> （你打算拿反编译的 nvcc 干什么?）

> "I think you will spend far longer trying to fix all the bugs introduced by your AI decompilation." — saagarjha [c:50030381]
> （我觉得你花在修 AI 反编译引入的 bug 上的时间会更久。）

> "And then you can use Claude-Magnum to fix the issues.<p>And then you can use Claude-Oeuvre to fix the issues.<p>And then you can use GPT-Cosmos to fix the issues.<p>And then you can use Claude-Omnibus to fix the issues.<p>And then you can use Claude-Logos to fix the issues." — docjay [c:50032883]
> （然后你可以用 Claude-Magnum 修这些问题。<p>然后用 Claude-Oeuvre 修。<p>然后用 GPT-Cosmos 修。<p>然后用 Claude-Omnibus 修。<p>然后用 Claude-Logos 修。）

这条线从"自由软件运动"退化成"嵌套调用越来越长的子型号名字",讽刺意味跟讽刺本身的语义滑在一起。

### 三、"干净室"概念的死亡

更深的争议在 copyright 这一层:很多人用 REA 生成的产品声称是"clean room",但 AI 的训练数据是否包含原始源码,根本无从证实。

> "I have CVP with the new program (including mythos access) and still get constant denials for silly situations. Most recently I fed a URL to my agent from a security blog and asked if to add it to my obsidian vault with appropriate tags-- cyber flagged. You're not missing much. OpenAI and/or most Chinese models are much more lax in their restrictions." — papascrubs [c:50029134]
> （我在新项目里有 CVP,包括 mythos 访问权限,仍然经常被拦住做各种傻事。最近一次:我把安全博客的 URL 喂给 agent 让它加进 Obsidian 加点标签——就被 cyber 标记了。你也没错过啥。OpenAI 和大多数中国模型在这类限制上要宽松得多。）

> "It doesn't matter. It's likely had access to the knowledge of somebody who worked on that source code. I have worked at companies that have done clean-room implementations. I was not permitted to look at their source or interact with those teams, because I had been exposed to the source of what they were re-implementing in a prior job. As a human with a mushy brain I was never going to remember the source, but the fact I had been proximate to it was enough to lock me out. You have no idea what the LLM trained on, so you can't prove a LLM derived clone is a "clean-room" implementation." — objclxt [c:50031845]
> （这不重要。它很可能接触过某位曾经写过那份源代码的人的知识。我待过的公司做过干净室实现:我不能去看他们的源码,也不能跟那些人交流,因为我在前一份工作里接触过他们正在重写的源码。人类脑子一团浆糊,根本不会记住具体代码,但只要我曾经"在那个源码旁边出现过",就足以被隔离。你不知道 LLM 拿什么训练的,所以根本无法证明 LLM 派生的克隆是"干净室"实现。）



> "Doesn't clean room typically apply to cases where the "dirty" team has legitimate access to copyrighted code, like the IBM PC BIOS which was published in the technical reference manual, and uses this access to write a functional specification for the "clean" team? I'm not sure how clean room would apply to commercial applications distributed in binary form, as there's no way to look at even disassembled code without violating the license agreement and therefore being in breach of contract and subject to potential copyright infringement claims for copying or even continuing to use the software, let alone cloning it, and surely you're not going to be subject to a copyright claim based on familiarity with the application from merely using it." — jasomill [c:50029467]
> （干净室通常不是用在"脏团队"对受版权保护代码有合法访问权的场景吗,比如 IBM PC BIOS 在技术参考手册里公开发布,然后基于它给"干净团队"写功能规范。分发成二进制的商业应用我怎么也想不出干净室适用:看一眼反汇编代码就违反许可协议,违约,还可能挨版权侵权——更别提克隆了。你仅仅因为"用过"这个应用就吃版权官司,这显然不是法律该有的样子。）

> "Using an LLM is not a clean room, imo. Its just IP laundering. Which is fine I guess if everyone is doing it, including the companies you're stealing from. I just dont know what the implications will be for progress.<p>Licensing/copyrighting encouraged people to think up of new things, and new ways of doing something. Now we're just all copying eachother." — lifeisloving [c:50029264]
> （用 LLM 不是干净室,在我看来就是 IP 洗钱。如果大家都在这么干——包括你正在"偷"的那家公司——那可能也无所谓。我只是不知道这对创新意味着什么。<p>许可和版权曾经逼大家想新点子、想新方法,现在我们都只是在互相抄。）

> "The reason why 'reverse engineering' has gotten so good is because what we're actually seeing is fully automated luxury plagiarism" — 20k [c:50029689]
> （"逆向工程"变这么强的真正原因是,我们看到的本质上是全自动豪华剽窃。）

这条讨论揭示的不只是 REA 本身,而是一个结构性变化:过去"干净室"的成立前提是你能隔离接触过源码的人;现在 LLM 的训练数据无法审计,这个隔离在原理上就破防了。一旦版权方真的想举证"侵权",反向工程的中间地带被抽走了。

### 四、连 Anthropic 的 safety 网自己都挡 RE 工作流

讽刺最有意思的落点在自己:REA 用户要拿 AI 拆二进制,结果 AI 公司自家的安全策略成了最大障碍。

> "I love such work. I hope to roll it into a package that anyone can use in the future. This work is only going to get more important because frontier models getting locked down will make this a lot harder over time." — areoform [c:50028478]
> （我喜欢这类工作。希望以后能把它集成成大家都能用的包。这事只会越来越重要,因为前沿模型越来越封闭会让这类工作难上加难。）

areoform 接下来贴了一段他跟 Claude 的对话:他试图讨论 17 USC 1201 的合理使用豁免(DMCA 例外条款),Opus 5.5 直接拒答,理由是"cyber"。言下之意:你连讨论 RE 是不是合法的,都过不了自家模型的护栏。

> "I wanted to see if CVP approval changed this response, but it appears that with the release of Opus 5.5, Anthropic silently dropped me from the program, and has some strict new criteria in place to apply again, such as being credited for a CVE! I was only approved last month, too -- sad!" — LoganDark [c:50028987]
> （我本来想看看有了 CVP 批准后这个回答会不会变,但 Opus 5.5 发布后 Anthropic 静默把我从这个项目里踢出来了,要重新申请条件更严,比如必须有挂名的 CVE。我上个月才刚批下来——叹气。）

> "A funny, but slightly chilling safety violation I once got was ChatGPT being unwilling to recite the full text of Article I Section 2 of the US Constitution, aborting as soon as it hit the passage about "three fifths of all other persons".<p>Another funny one was Claude's refusal to provide the original untranslated text of a passage from Dante’s Inferno on copyright grounds, though in this case pointing out that no 14th century literature was subject to copyright anywhere in the world was sufficient to override its objection." — jasomill [c:50029520]
> （我遇到过一件好笑但有点发毛的安全违规:ChatGPT 拒绝朗读美国宪法第一条第二节的全部文本,读到"另外所有人的五分之三"那段就停了。<p>还有一个:Claude 拒绝提供但丁《神曲》原文一段,理由是版权;指出 14 世纪文学在任何地方都不受版权保护后,它才让步。）

> "This kills the talent pipeline, and it'll create a spam problem for the other folks because now people will try to github PR spam their way to getting on a CVE." — areoform [c:50029095]
> （这会断掉人才培养通道,而且会给其他人造成 spam 问题,因为现在人们会疯狂推 PR 试图拿到 CVE 挂名。）

这条副线把 REA 的讨论推到一个 meta 高度:工具能帮你拆二进制,但工具的供应商——Claude、GPT——自己就把"讨论如何拆"也拦在门外。前沿模型越来越封闭,RE 工具越来越好,但使用它们的入口越来越窄。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 工具意义在打包工作流不在技术 | tptacek [c:50028484] | Ghidra 之外还应该有"非让 Claude 自由发挥"的引导层。 |
| 这是给非老手的"氛围 RE" | fwlr [c:50028840] | 给没自己方法的人一种"自己逆向过了"的体验。 |
| REA 直接打开了对 NVIDIA / Nintendo 闭源的法律死角 | rvz [c:50028933] | 律师已经在磨刀。 |
| AI 反编译出来的代码 bug 量也很大 | saagarjha [c:50030381] | 你会花更长时间修 AI 引入的 bug。 |
| "干净室"在 LLM 时代已死 | objclxt [c:50031845] | 你无法证明模型没接触过原始源码,所以根本没法宣称干净室。 |
| 这就是"自动化豪华剽窃" | 20k [c:50029689] | "逆向工程"变强,本质是全自动剽窃变强。 |
| 模型公司自家 safety 网反而挡 RE 工作流 | areoform [c:50028478] / jasomill [c:50029520] | 连讨论 DMCA 例外条款都被 opus 5.5 拒绝。 |

## 总体情绪

REA 是一个不起眼的开发者工具,但它把三个长期悬而未决的工业议题压进了同一条对话里:RE 工具进步的速度、闭源法律的防御能力、AI 模型的封闭度。这三件事过去各自有节奏,现在汇聚到一个点——一个 coding agent,可以拆一个二进制,生成新的商业软件,没人能证明它到底有没有看过原版源码,模型供应商自己也不让你讨论怎么拆。

情绪曲线第一段是兴奋(终于有人把 Ghidra 拼装易用了),第二段是冷峻(干净室没了,法律差距也被填上了),第三段是沉默的反讽——讽刺的顶点不在 REA,而在于讨论 REA 时,AI 公司的安全策略已经替对手把门关上了。

讨论里没有一个具体到能预测未来走向的答案,但情绪的共识是清晰的:工具越来越好,入口越来越窄。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | REA — Reverse Engineering for Your Coding Agent | https://news.ycombinator.com/item?id=50028275 |
| 2 | (工具主页) REA Reverse Engineering for Your Coding Agent | https://rea.tools/ |
| 3 | (示例追踪) PhotoCraft | https://github.com/storytold/photocraft |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要,所有引文与数据点均尽力保持原意,不代表本站观点。原文由众多匿名 HN 用户贡献,译文为转述。<br>本文涉及前沿 AI 模型安全策略讨论与商业软件版权问题,相关议题具有时效性,引用时建议核对原帖最新更新。<br><br><em>本摘要由 AI 模型辅助生成:Anthropic/claude-sonnet-4.5</em>
</div>
