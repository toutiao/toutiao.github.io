---
layout: post
title: >-
  PHP 紧急修复两个未授权 RCE，协同披露链彻底崩盘
date: 2026-10-21
hn_id: 50182987
categories: [articles]
excerpt: >-
  PHP 8.5.12 / 8.4.27 / 8.3.36 / 8.2.35 同步发布，修复 CVE-2026-109618 与 CVE-2026-109619；
  协同披露过程中，petecooper、Chainguard、Calif 先后单方面打破 embargo，
  PHP Foundation 自己也是一周前才立项补的 2024 年已知漏洞。
tagline: >-
  Calif 给 PoC 视频配了首抖腿神曲，PHP 那边还在开共识会议。
---

## 原文概要

2026 年 10 月 21 日，PHP 项目一次性放出四个安全版本：8.5.12、8.4.27、8.3.36、8.2.35，修复两个严重等级 `CRITICAL` 的远程代码执行漏洞，**实际 CVSS 得分 9.2（泄露版本误标 10.0）**：

- **CVE-2026-109618 / GHSA-w8hw-w9fx-j79w，RCE via OOM corruption**：当请求恰好在 PHP 的 `memory_limit` 触发时碰上临界时机，PHP 会留下部分初始化的内部数据并在后续当作合法数据使用——也就是说，**内存被污染**。在 Apache + `mod_php` 默认配置下，未认证请求就能在应用代码跑之前直接触发，研究者已演示完整 RCE。PHP-FPM 上也通过应用层路径复现。
- **CVE-2026-109619 / GHSA-6wmf-4rv5-p3rp，RCE via stale state**：致命错误发生在错误节点，会让内部状态指向属于上一个请求的内存，**典型 use-after-free**；同一 worker 之后处理的请求能踩到这块已释放的内存。研究者拿真实应用跑出了 RCE。

两个洞都落在 PHP 几乎每个请求都要走的内存管理与错误处理路径——这把它们直接顶到最高优先级，也正是**修起来不能影响兼容性、性能，又不能逼第三方扩展改 API**的最难位置。**PHP 官网呼吁所有运行 PHP 的服务器立刻升级**。

这是一篇由 PHP 基金会发的复盘博文，作者 `ejohnso49`。重点不是“怎么打补丁”，而是这俩洞**怎么被发现、为什么拖了两年才修、以及基金会过去几个月怎么重组人手**。发布于 HN 热门榜（`/best`），36 小时内冲到 **396 分、187 条评论**。

---

## 讨论焦点

### 1. 一句话总结：到底哪一步走错了

> "Sounds like a lot went wrong, the 2024 issue not being patched and then multiple parties leaking stuff before the scheduled release date." — cubefox [c:50183057]
> （听着就是一路走岔：2024 年那个问题没修，到了该统一披露的时候又有多方提前泄露。）

这是评论区的总基调——**没人质疑漏洞严重性，所有火力都对准协同披露过程**。

### 2. 协同披露至少破了三道口子：HN 用户、安全公司、研究机构

最早破口其实在 HN 自己。10 月 20 日下午，两个 CVE ID 在网上流传，附带的发布时间和 CVSS 都**写错**（标成 10.0，实际 9.2）。一位 HN 用户 `petecooper` 自己站出来认账：

> "This was partly me. I take responsibility for posting it on HN. I am truly sorry for the disruption this has likely caused.
> My contact had informed me there was no embargo, and told me her contact had told her the same. It transpired this morning that was a lie." — petecooper [c:50183326]
> （这事儿我有责任。我在 HN 上发了那条，我很抱歉可能造成的混乱。
> 我的线人说没有 embargo，她的线人也跟她这么说，今早才发现这是假的。）

紧接着是两家挨打：

- **Chainguard**——10 月 21 日 07:41 UTC（比协调发布时间早了 6 个多小时）单方面放出**内置修复的镜像**，攻击者可以从二进制反推补丁内容；其他人还在等官方版本。
- **Calif**——参与审计的安全公司，发布了一个**配动画音乐的 PoC 演示视频**，比 embargo 早了超过 24 小时，视频上线后即被索尼音乐以版权投诉下架，但已被 reshare。`yreg` 一句总结：`This is not the dancing anime girl video, is it?` [c:50183418]，下面 `atymic` 直接回 `That's the one` [c:50183438]。

### 3. Chainguard：是“止损”还是“夹带私货”

贬的一方把它定性为对整个 PHP 生态的背叛：

> "This single-handedly assures that I will never, ever do business with Chainguard or any member of its C-suite executive team." — blantonl [c:50183714]
> （这事儿让我这辈子都不会再跟 Chainguard 或它的 C 套间打交道。）

> "They released some binaries, built for their own docker image based on their own Linux distro. Other people couldn't use Chainguard's 'fix' to patch their own systems. The only people who seem to have benefited from the stunt are the hackers who used AI to reverse-engineer the binaries and write exploits.
> That was a giant fuck-you to the rest of the PHP ecosystem, nothing more." — kijin [c:50184727]
> （他们只发了自己的 Linux 发行版上 docker 镜像的二进制，其他人根本用不了他们的“修复”。真正受益的反而是那些拿 AI 把二进制反向回推、写 exploit 的黑客。
> 这就是对整个 PHP 生态的一记重锤，仅此而已。）

褒的一方则把它读作“漏洞已经在野外被利用时的止损”：

> "Nah, Chainguard should be praised for this. It was a different company that leaked the POC early, and then PHP, Wiz, OpenAI, and Calif sat on their hands doing nothing while the vuln was being actively exploited in the wild." — cobolcomesback [c:50184111]
> （Chainguard 该被表扬。POC 是另一家公司提前泄的；PHP、Wiz、OpenAI、Calif 这边漏洞在野外被利用了还在坐着不动。）

但 `bawolff` 直接开炮：

> "[citation needed]
> By which i mean, this seems untrue. If you mean the anime video, that is not a leak of a PoC." — bawolff [c:50184892]
> （出处呢？动画那段视频根本不是 PoC 泄漏。）

### 4. 受害者其实是下游 Docker 用户

披露提前后，最直接的连锁反应是：embargo 一破，所有人涌向 Docker Hub，但**官方 PHP 镜像直到发博时还没更新**。

> "Step 1: Ensure that docker images are available when the embargo is released. We're 2 hours in, and they still aren't available." — bowersbros [c:50183409]
> （披露时第一步就该保证 docker 镜像就位。现在过两小时，还没见。）

`lol768` 直接建议 PHP 基金会自己管镜像，别再走 Docker “Official Images” 流程 [c:50183667]。但 `dofm` 提示了一句可能的事实：

> "FWIW, Docker images are a nice-to-have, but OCI containers are not how most PHP users get their PHP. For all the long-tail users, PHP is a distro package. That route needed the most work instead, and it got it." — dofm [c:50185621]
> （OCI 容器不是大多数 PHP 用户拿 PHP 的方式；长尾用户走发行版包，发行版那边才是真正的苦力。）

`berkes` 也回了一句：“官方 PHP 镜像**每月三百万次下载**，他们不把它当主分发渠道是判断失误” [c:50186655]。

### 5. 两年延迟：共识机制 vs. 资源不足

基金会自己的复盘承认，OOM 这个问题在 **2024 年首次外部审计（Quarkslab 经 OSTIF 拿到 Sovereign Tech Agency 资助）期间就发现苗头**。当时已经有人提出过可能的攻击路径，但当时没有具体复现路径，又赶上别的更紧急的 CVE，修补就一路停滞重启。

> "To fix the OOM problem, the PHP security team developed several competing approaches, but each came with its own trade-offs: backward compatibility breaks, new denial-of-service potential, or requiring changes to many third-party extensions which seemed impossible to coordinate. The PHP security team, operating on consensus, struggled to choose between these and feared the repercussions of shipping the wrong choice." — 基金会博文
> （团队给出了几种互相竞争的方案，**每种都有代价**：要么破坏向后兼容、要么引入新的 DoS 面、要么要改大量第三方扩展。靠共识决策的安全团队在选项之间卡壳，怕选错承担后果。）

评论区也戳到了“共识陷阱”这层：`emilburzo` 拿出整套论证解释开源项目**在公开代码库与公开构建流水线之间**做 embargo 有多难 [c:50183741]；`modeless` 一句话拍桌：

> "Making a cloud CI/build/release system whose behavior can't be reproduced locally requires some kind of brain damage. I can't believe people tolerate this." — modeless [c:50184106]
> （构建系统无法本地复现，这就跟脑损伤没区别。我不敢相信大家居然能忍。）

但 `Leherenn` 给出了另一面：

> "I don't know about PHP, but at work our artifacts are signed, and you certainly cannot have the signing certificate on your laptop. It's stored in some secure server, and only accessible from some allowlisted build nodes, for specific builds (release branch, ...)." — Leherenn [c:50186384]
> （我这边的工件是签名的，签名证书绝不可能放笔记本上。它只在受信任的构建节点、特定分支构建时被允许调用。）

### 6. Calif 的“动画 PoC”是这整起事故的转折点

PoC 视频本身已二次发酵：有人补刀说 Calif 公关“先发视频再删”本身就是营销事故 [c:50183651]；有人吐槽：

> "wow, okay. yes, that really does look like a 'my first PoC' video made by an early teenager. hard to believe that this was produced by a company that wants to be taken seriously." — john_strinlai [c:50183982]
> （天哪，这看起来就像青少年第一次交 PoC 作业的视频。很难想象是想正经做事的公司做出来的。）

更有人点穿：`numpad0` 借用数学 CS 的比喻感叹安全圈“离不开这些又作又不可靠的人” [c:50185204]。但 `lenerdenator` 抛出一个更现实的判断：

> "It's the age of LLMs. Exploits go from theoretical to real fairly quickly. PHP's open source, it's not impossible to conceive of someone seeing that video, getting the general idea of what to do, and working the rest out with a decent model." — lenerdenator [c:50185651]
> （LLM 时代，从理论漏洞到实战利用就那么几秒。PHP 是开源的，看到视频拿到大致思路，剩下 AI 给补全完全可能。）

这条恰好对接基金会博文里提到的工具链升级：和 Alpha-Omega 合作扫 PHP 用的是 **Anthropic Claude Mythos**，验证报告与 exploit 用的是 **OpenAI 的 Daybreak Red**。

### 7. 长尾 PHP 才是真正的隐患

基金会这次同步打补丁的版本号段是 8.5 / 8.4 / 8.3 / 8.2。**5.x、7.x 不在列**。`Scaled` 直接补一刀：

> "Keep in mind that some of the organizations are presumably patching ancient versions of PHP like 5.6. I am sure this is a process which takes considerable time, especially as upstream PHP has washed their hands of such old versions and the downstreams are effectively on their own." — Scaled [c:50184146]
> （不少公司还在跑 5.6 这种古董版本。这是个不小的工作量，尤其是上游早就不管这么老的版本，下游只能靠自己。）

`dylan604` 顺着话题往下延：

> "I've experienced similar to this. I know I shouldn't be, but I still get amazed every time I hear that some small company is still using an old DOS machine running core software based on dBase that nobody has any clue on how works and the developer has since moved on to a higher plane." — dylan604 [c:50185558]
> （我也见过。每次听说小公司还在跑 DOS 上的 dBase，原开发者早登极乐，我都不该惊讶，但每次还是震惊。）

这是这类紧急披露的真正底色：**修不打在长尾上，影响不断**。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 维护者反思 | cubefox [c:50183057] | 多方都出错：2024 没修、披露前又泄漏 |
| 用户自责 | petecooper [c:50183326] | 在 HN 提前发帖是我的责任 |
| 强烈批评 Chainguard | blantonl [c:50183714] | 永不再用 Chainguard |
| 激烈反对表扬 Chainguard | kijin [c:50184727] | 它只发了自家二进制，是给生态的一记重锤 |
| 支持 Chainguard 止损 | cobolcomesback [c:50184111] | PHP/Wiz/OpenAI/Calif 坐视利用不动 |
| 反驳“表扬 Chainguard” | bawolff [c:50184892] | 出处呢？动画视频根本不是 PoC 泄漏 |
| 吐槽 Docker | bowersbros [c:50183409] | embargo 破了两小时 Docker 镜像还没好 |
| 替发行版说话 | dofm [c:50185621] | OCI 容器不是大多数 PHP 用户的渠道 |
| 质疑“AI 可逆” | lenerdenator [c:50185651] | LLM 时代漏洞几秒就能变实战 |
| 担忧长尾 PHP | Scaled [c:50184146] | 5.6 这种古董版本才是现实重灾区 |

---

## 总体情绪

**高度聚焦**在协同披露本身——几乎没有人在这次讨论中认真质疑漏洞的严重性或补丁的有效性。社区共识非常一致：当一个 9.2 分的洞按计划走 **14:00 UTC** 就该完成统一披露时，只要 embargo 在 07:41 与 14:00:44 之间被提前击穿，两小时窗口就足够让全球所有安全研究员开始复现、足够让攻击者反过来利用被打好的补丁。

但分歧在**责任分配上**：是 Chainguard 越线在先、还是 Calif 把 PoC 视频送出去在前、还是 PHP 自己的共识机制拖了两年在后。三派对骂的同时，很多人把矛头指向更深的现实——**在 AI 加速的时代，依赖人守口如瓶的传统 embargo 机制正在失效**。

事情的讽刺点在于：修复这俩洞的 patch 居然比讨论本身更具技术含量，整场事故的爆点**不是漏洞本身**。

---

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Today's PHP security release, and how we're strengthening security | <https://news.ycombinator.com/item?id=50182987> |
| 2 | Chainguard CEO 解释提前发镜像 | <https://news.ycombinator.com/item?id=50176735> |
| 3 | PHP 公告页（含 CVE 详情） | <https://www.php.net/archive/2026.php> |

---

<div class="disclaimer">

本文为 HN 热门讨论的摘要，意在提炼多方观点，不代表本站立场。引文为英文原文，中文译文为意译。具体技术细节请以 [PHP 官方公告](https://www.php.net/archive/2026.php) 和 [基金会博文原文](https://thephp.foundation/blog/2026/10/21/todays-php-security-release-and-how-were-strengthening-php-security/) 为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
