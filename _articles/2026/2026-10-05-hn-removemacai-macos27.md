---
layout: post
title: >-
  12GB 不让卸载：HN 用户用 curl|bash 把 Apple Intelligence 从 macOS 27 里抠出来
date: 2026-10-05
hn_id: 49957116
categories: [articles]
excerpt: >-
  一款带 provenance attestation 的开源小工具，想把 macOS 27 占用的 12GB+ Apple Intelligence 模型和功能关掉；讨论一边拆它的 curl|bash，一边骂 Apple 越走越像微软。
tagline: >-
  想卸载的卸不掉，想删的删不了，最后大家都在 curl|bash。
---
## 原文概要

2026 年 10 月 4 日，HN 用户 [privacyisntdead](https://news.ycombinator.com/item?id=49957116) 投递了一款叫 [RemoveMacAI](https://github.com/omlahore/RemoveMacAI) 的开源小工具，专门对付 macOS 27 里的 Apple Intelligence：它关闭 Siri（含"Hey Siri"和菜单栏图标）、Writing Tools、Genmoji、Image Playground、ChatGPT 扩展、Mail/Messages/Safari/Notes 的摘要、智能回复、文本预测、Spatial Photos、Photos Clean Up 以及 Xcode 预测式代码补全，并删除对应的 Apple Intelligence 基础模型、图像生成/Genmoji/Spatial Photos/Photos Clean Up/Xcode 模型。

这条脚本的卖点是「一次性、可逆、可审计」：它通过一条 `mobileconfig` 配置描述文件应用 Apple 官方的限制键，把模型下载重定向到一个本地端口，阻止 macOS 再次下载；System Integrity Protection 保持开启，`/System` 不被直接改动。仓库 [README](https://github.com/omlahore/RemoveMacAI) 明确写着「Every release is built from its tag by GitHub Actions and carries a build provenance attestation」——也就是说每次发版都带 GitHub 出处的可验证证明。

装回的方法一样一条命令：`curl -fsSL .../install.sh | bash -s revert`。它也支持 `brew install omlahore/tap/removemacai`。

HN 上的讨论不是关于工具本身够不够好用，而是这个工具的存在到底说明了什么——macOS 27 已经不再提供「一键关闭 Apple Intelligence」的开关，模型又持续驻留磁盘。一个 12GB+ 的 AI 模块，由 OS 默认下载、没有 OS 级卸载入口、必须靠第三方脚本（包括 `curl|bash`）才能彻底摘除。这件事在 HN 评论里被反复比作 Windows 时代用 [O&O ShutUp10](https://www.oo-software.com/en/shutup10) 反向关停各种「贴心功能」。

## 讨论焦点

### Apple Intelligence 不再是「可选」：被当成 Siri 强塞

RemoveMacAI 之所以需要存在，根因是 macOS 27 把 Apple Intelligence 的开关从「系统设置」里抹掉了。hypfer 直接拿 O&O ShutUp10 做类比，把整个 macOS 27 的策略往「Windows 风格贴心」上贴：

> "This is stuff on the level of O&O ShutUp10. Which is a good tool, but also, a Windows tool for very (back in the day) Windows-specific nonsense. What's going on at Apple product strategy?" — hypfer [c:49957589]

在 [c:49959229] 这条支线里，nozzlegear 反驳说「Siri 一直是 macOS 的功能，不是什么随手塞进去的 AI 模型」；jtbayly 反过来说「Siri 早就存在了十年，Apple Intelligence 没有」——这正是触发工具需求的那条缝。

> "Like it or not, Siri is one of the features of macOS and has been for a long time. It's not just some arbitrary AI model that Apple decided to store on your disk." — nozzlegear [c:49959229]
>
> "Siri" has existed for a long time, yes. Apple Intelligence, not so much. It really is just an arbitrary AI model, since I've had Siri for a decade and not needed whatever this extra 13GB model is." — jtbayly [c:49959629]

sajithdilshan 把这套逻辑延伸到 Mac 工作流：

> "Do people actually use Siri AI on the Mac? Whenever I need something done that needs AI on a mac I just use Claude Code. I can imagine Siri AI being useful on iOS because of its deep integration to the OS. But for MacOS there's better tools" — sajithdilshan [c:49958234]

这两条支线说的是同一件事：Apple 把 Apple Intelligence 当成「Siri 升级版」统一切换，但用户既不需要这层「新 Siri」，也找不到原生卸载入口。

### 12GB 占盘：256GB Mac mini 用户最先遭殃

trollbridge 用一个具体数字把问题落到最敏感的人群上：

> "People with 256GB laptops care when the 27 AI stuff burns up 10-20% of their storage." — trollbridge [c:49957605]

nvme0n1p1 顺着这条线把矛头对准 Apple 的存储溢价策略：

> "Also 'those who can't accommodate the storage' is funny. What's that? You didn't pay Apple's 1200% markup on storage, just so you can have enough room for your actual work after the OS fills your disk with a bunch of bloatware?" — nvme0n1p1 [c:49957988]

GeekyBear 的反驳很 Windows 范：「不装 Chrome 不就完了」：

> "So don't install Chrome." — GeekyBear [c:49957649]

trollbridge 在底下把回击拆得很具体：

> "Most people want Chrome for the inevitable site that doesn't work in Safari. The problem is Apple intelligence is decent, but not worth 20% of your storage decent." — trollbridge [c:49957766]

bigyabai 干脆扔了句「它当然要好用，吃了 14GB+ 的存储呢」：

> "It damn well better, for using 14gb+ of storage." — bigyabai [c:49958105]

这不是「功能不好」的问题，而是「硬件定价与软件占用之间的失衡」：Apple Silicon 的 SSD 不让用户升级，OS 却在背后默认塞 12GB+ 模型，连关闭入口都没留。

### `curl|bash` 是怎么变成行业标配的

RemoveMacAI 的安装命令恰好踩在 HN 最敏感的神经上——`curl|bash`。前 1/3 的高赞评论基本都在攻击这条命令。

arialdomartini 直接开骂，把讨论炸到第一楼：

> "Stop the curl | bash insanity." — arialdomartini [c:49957394]

bigyabai 在另一条主线上反讽：

> "Something horrible must have happened, if macOS users are curling shell scripts from the internet to make their desktops more like Linux." — bigyabai [c:49957397]

把战线拉得最清楚的是 nailer——他没否认 `curl|bash` 的风险，但点出了 RemoveMacAI 自己做了什么：

> "Every release is built from its tag by GitHub Actions and carries a build provenance attestation. Huh cool. They're doing curl | bash properly." — nailer [c:49957927]

woodruffw 紧接一句提醒：

> "That doesn't seem to do much in the `curl | bash` setting, given that you're not verifying the attestation in that case. You still need to download it separately and run `gh attestation verify` first." — woodruffw [c:49958044]

maccard 把这条线推回「行业惯例」：

> "What's your suggested installation method instead? Unless it's 'download and read the source before running it' this is no worse than npm install, or pip install, or clicking 'trust' on a git repo in VSCode" — maccard [c:49957592]

mingus88 反驳说，正因为没人觉得安全比方便重要，才需要大声喊：

> "It is actually worse than those examples. Pip and npm may be insecure, and that is a fault of those tools, but most user expect secure package managers and should demand it. Telling users it's fine to raw dog arbitrary commands directly into their shell is just normalizing laziness." — mingus88 [c:49957686]

Terr_ 把问题从「能不能审查」升到「普通用户的认知成本」：

> "I think that's missing the forest for trees. The problem with these curl-to-bash approaches is not that you are literally unable to intercept and inspect them with enough effort and planning. The problem is that: 1. The effort and care needed to tell which ones are dangerous is way beyond what 99.99% of users will apply. 2. Even for technical users, the chance of doing this consistently on every update is near zero." — Terr_ [c:49957901]

jtrueb 用一句玩笑把讨论收尾：

> "Lol, thinking the exact same thing. No, we don't read next to 0.0001% of the code we run." — jtrueb [c:49957497]

jacquesm 是少数承认「理想主义」立场的人，但给出的是务实版本——至少要下载下来读一遍：

> "Code from trusted repositories is an entirely different thing compared to running 'wget some_github_repo_shell_script | sh'. That said, the likes of Tailscale are setting a bad example." — jacquesm [c:49957722]

这条支线最后甚至被 LLM 安全审计话题接管——anonymzz 演示了一种「把脚本交给本地模型审查再决定是否执行」的现代玩法：

> "curl -fsSL https://raw.githubusercontent.com/omlahore/RemoveMacAI/main/install.sh | pi -p 'Security-audit this shell script; output the script unchanged ONLY if safe to execute, otherwise output nothing and explain why.'" — anonymzz [c:49958175]

nunez 在底下回了句一针见血的：

> "there's no way to guarantee that the model won't change the script after processing it..." — nunez [c:49959122]

Dylan16807 把这条线收到一个尴尬的真相：

> "If I trust it to do this analysis in the first place, it can probably manage the copy+paste?" — Dylan16807 [c:49959495]

信任前提不变，把审查外包给 LLM 并不解决根本问题。

### macOS 越来越像 Windows：用户在迁移

讨论里多次出现「macOS 正在 Windows 化」的论调。trollbridge 把 curl|bash 的流行归到同一个根因：

> "curl|bash is now standard way to install packages on both macOS and Linux. It's maddening, but it is now." — trollbridge [c:49957599]

pjmlp 在底下补了一刀：

> "Meanwhile on Windows we mostly use the store or winget, funny times." — pjmlp [c:49957634]

drnick1 干脆判了 macOS 「正在被毁」：

> "Uncomfortable, but true. GNOME has reached maturity and hasn't changed significantly in years, while Apple is busy destroying macOS." — drnick1 [c:49957624]

neya 把这顶帽子扣到了苹果粉丝世界观的崩塌上：

> "Their world view that 'Apple can do no wrong' is slowly shattering, it seems" — neya [c:49958639]

Angostura 是少数反驳者，从另一个角度给出「苹果做对了」的注脚：

> "Personally, my limited experimentation with Apple AI has left me quite liking it. The contents of the Exportable 'Privacy Report' are interesting to look through." — Angostura [c:49958041]

### macOS 27 的「隐私/安全」措施：开发者越走越窄

behnamoh 在第一条主线里给出了更深层的担忧——macOS 的新一轮「隐私/安全」措施会进一步压缩自动化工作流的空间：

> "Oh, things are about to get worse with the new macOS 'privacy/security' measures. They are going to curb agentic workflows even more. I don't know how Apple just finds new ways to annoy developers, but we're in a minority after all." — behnamoh [c:49957430]

fmajid 把这条线接到 Apple 的竞争对手策略上：

> "It's not about privacy, it's about kneecapping competitors, just like when they blocked the advertising ID but exempted themselves from this because 'Apple is not a third-party, we're a second-party'. Apple is an advertising company and thus inherently conflicted about privacy." — fmajid [c:49957716]

NamlchakKhandro 用一句话钉死结论：

> "Apple hates developers" — NamlchakKhandro [c:49957517]

ultrarunner 在底下补了一句更隐晦的：

> "With LLMs, everyone's a developer now. Welcome to the mainstream." — ultrarunner [c:49957690]

这句把两件事并在一起——Apple 的「开发者友好」在缩水，而「开发者」的定义在被 LLM 强行扩张；两个变量互相挤压。

### 升级到 27 之前先想清楚

neuroelectron 一开头就泼冷水：

> "Not a lot of good reasons to upgrade to 27. They removed Rosetta and you have to reinstall that if you want it. So is MacOS turning into something that more regular people are going to have to maintain in the future or end up with something like Windows 11? I switched to MacOS 3 years ago because of stability, security, and not having to do maintenance on it." — neuroelectron [c:49957930]

2muchcoffeeman 在底下反驳——向后兼容总是有代价的：

> "The alternative is maintaining backwards compatibility forever and then everyone will complain about some weird behaviour that still happens to retain that compatibility. Keep in mind this is the second time they have switched arches and the second round of people complaining about it." — 2muchcoffeeman [c:49958243]

idontwantthis 反过来说——这次的 Apple Silicon 不是 x86，不存在「会过时」的风险：

> "I think they have a lot more reason to keep it around this time. PowerPC was a dead-end and x86 is most definitely sticking around." — idontwantthis [c:49958308]

这条支线最终落到一个微妙的岔路口：Apple 砍 Rosetta 是不是在为 Apple Intelligence 这种「强制下载」腾硬盘空间？讨论里没有人直接说出口，但 [c:49957930] + [c:49958243] + [c:49958308] 三条并排放，意思已经在了。

### 文件系统不可变性的真伪

gumby 一上来就抛出 macOS 现代安全模型的真实代价——你想把预装应用卸掉也卸不掉：

> "It's hard to strip it down these days as the OS image and its core, immutable filesystem cannot be edited. Admittedly this helps keep idiots from destroying their filesystem and also blocks many malware attacks on the system, but, for example. I don't want Chess." — gumby [c:49957854]

codys 在底下展示了关掉封印的命令——Apple 自带的工具就能做到：

> "The sealing of the filesystem can be disabled trivially, though, via a command line tool that Apple ships with MacOS that you run from recovery mode. And then you can remount / as read-write, and create a new blessed snapshot with your changes merged in." — codys [c:49959078]

odo1242 进一步澄清：整个系统仍然受 SIP 与启动校验保护，所以「普通用户删了关键系统文件」的场景不存在：

> "The entire system is signed and verified at boot. Any change to a macOS system outside of /Users, /Applications, and whatever else the OS lets you edit can't really be edited without disabling System Integrity Protection (which isn't recommended)" — odo1242 [c:49960201]

RemoveMacAI 不动 SIP、不动 `/System`，恰好走在 Apple 安全边界之内——这也是 nailer 说「they're doing curl|bash properly」的更细一层含义。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Apple 战略偏离 | hypfer | 这工具到了 O&O ShutUp10 级别，Apple 战略出问题了 |
| Apple Intelligence 不是 Siri | jtbayly | Siri 十年了不需要 13GB 模型，Apple Intelligence 才是那个新增量 |
| Apple Intelligence 是 Siri 升级 | nozzlegear | 不要把 Apple 早就在做的功能叫「强塞」 |
| 256GB 用户最先遭殃 | trollbridge | Apple Intelligence 直接吃掉 10-20% 存储 |
| 存储定价策略是根源 | nvme0n1p1 | Apple 自己收 1200% SSD 溢价，却塞 12GB 模型占满 |
| curl|bash 应该被禁 | arialdomartini | Stop the curl|bash insanity |
| curl|bash 是行业惯例 | maccard | 没比 npm install 更糟，凭什么这一条不行 |
| curl|bash 风险被低估 | mingus88 | 普通人没法每次审查，不能用方便美化 |
| curl|bash 可审计 | nailer | RemoveMacAI 每次发版带 provenance attestation |
| LLM 审计脚本不解决问题 | nunez | 模型审查后照样能改脚本 |
| macOS 在被毁 | drnick1 | 跟 GNOME 比，Apple 一直在破坏 macOS |
| Apple AI 其实不错 | Angostura | 试过 Apple AI，可导出的「隐私报告」很有意思 |
| Apple 在砍自动化工作流 | behnamoh | 新 macOS 隐私/安全措施会进一步限制 agentic workflow |
| Apple 在打压竞争对手 | fmajid | 不让追踪广告 ID，但豁免自己，本质是商业策略 |
| 升级 27 没必要 | neuroelectron | Apple 砍了 Rosetta，维护负担越来越像 Windows 11 |
| macOS 文件系统可改 | codys | Apple 自带 recovery 命令就能 disable sealing |
| 普通用户删不动 | gumby | 想卸 Chess 都卸不掉，代价是普通用户失去控制 |

## 总体情绪

整场讨论的核心矛盾不是「要不要用 Apple Intelligence」，而是「谁有权决定它装在用户的硬盘上」。Apple 把 12GB+ 的 AI 模型设为系统级默认下载，又不再提供单独的关闭开关；用户在 256GB Mac mini 上最先撞上这道墙。RemoveMacAI 这种带 provenance attestation、靠 `mobileconfig` 描述文件+SIP 不动的工具，本来正是 Apple 自己应该提供的能力——HN 上一边骂它的 `curl|bash`，一边默认它的存在是合理的。

另一条隐线更刺眼：macOS 在 27 上变得更像 Windows 11——系统级预装、不可卸载、强推 AI、关闭入口被悄悄抹掉，而 Windows 至少还有 `winget` 和 store 这种「用户能选」的退路。trollbridge 说得最准：「People with 256GB laptops care」。硬件不可升级、模型不可卸载、磁盘定价按 GB 翻倍——三方夹击之下，curl|bash 反而成了「最后能用的开关」。

OpenAI 在训练模型，Apple 在训练用户。训练方向是：「你想卸载？自己写脚本。」

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 主 | Turn off Apple Intelligence on macOS 27 and get its disk space back | https://news.ycombinator.com/item?id=49957116 |

<div class="disclaimer">
本文讨论涉及 macOS 27 系统策略与第三方安全审计，引文为 HN 用户公开发布的内容（CC BY-SA 3.0 / HN Terms），仅作讨论脉络呈现，不代表原作者或本摘要立场。涉及的所有产品名、品牌与链接归各自所有者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
