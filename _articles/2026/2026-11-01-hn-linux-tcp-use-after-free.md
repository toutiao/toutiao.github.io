---
layout: post
title: >-
  Linux 内核 TCP 握手的 use-after-free：CVSS 9.8，Ubuntu 和 RHEL 还没修 — HN 讨论摘要
date: 2026-11-01
hn_id: 50319143
categories: [articles]
excerpt: >-
  一个四行补丁就能关掉的 IPv4 TCP 握手 UAF，内核 CNA 打出 CVSS 3.1 9.8，Anthropic 说 Claude
  写出了 root 级 PoC。上游 10 月 15 日就修了，Ubuntu 和 RHEL 到 10 月 31 日仍标着「Vulnerable」。
tagline: >-
  上游四行补丁，发行版排了两周队。
---

> 来源：HN 讨论帖，提交者 oger。帖子：[TCP Use-After-Free: CVE-2026-98432 / CVSS 9.8](https://news.ycombinator.com/item?id=50319143)，411 分，190 条评论。原文：[Linux's October 2026 TCP Use-After-Free: CVE-2026-98432 — Atlas](https://atlasum.net/blog/cve-2026-98432-linux-ipv4-tcp-uaf)（Atlas Security，2026-10-29 发布，10-31 更新）。

## 原文概要

一个远程、无需认证、只要机器开着 IPv4 TCP 监听就能摸到的内核漏洞，编号 CVE-2026-98432。Linux 内核自己的 CNA 给它打的是 CVSS 3.1 9.8，Critical，攻击向量 `AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H`。漏洞类型是 IPv4 TCP 握手中的 use-after-free，影响范围从 Linux 4.4 一路到今天，修复版本是 5.10.272、5.15.223、6.1.190、6.6.159、6.12.113、6.18.56、7.2.10 和 7.3。

触发机制很朴素。服务器收到 IPv4 握手包时，内核先把半开连接挂在一个轻量的 request socket 上，握手完成后再转成完整 socket；如果对端的 IPv4 头里带了 options，内核会把这些选项留着，好在回包里回显。问题出在交接：这些选项没有复制过去，连接一结束就被 `kfree()` 立刻释放，而另一颗 CPU 可能正在读它来拼握手回包——读已释放的内核内存，就是 UAF。攻击者不需要账号，整件事发生在内核握手处理里，应用代码还没上场。触发的载体是 SYN 包里的 IPv4 Record Route 或 Timestamp 选项。

修复是 Eric Dumazet 的提交 e3f33b0，标题就叫「ipv4: free inet_opt and ireq_opt after an RCU grace period」，把两处普通的 `kfree()` 换成 `kfree_rcu()`，等所有读者读完再释放；同一个提交还顺手修了 request socket 迁移路径（`net.ipv4.tcp_migrate_req=1` 或 `BPF_SK_REUSEPORT_SELECT_OR_MIGRATE`），IPv6 的类似问题声明「另开一个补丁处理」。报告人是 Anthropic 的 Xinyang Ge，评审是 Kuniyuki Iwashima。

真正让这件事变麻烦的不是代码，是分发。上游 10 月 1 日提交，10 月 11 日和 15 日各批一批 stable 内核，10 月 15 日 CVE 记录公开。但到 10 月 31 日下午 5:15 CDT，Ubuntu 的 tracker 上每一个发行版的 `linux` 包仍然写着「Vulnerable」——26.10、26.04、24.04、22.04 只是多了几条「work in progress」的 proposed 内核（`7.3.0-10.10`、`7.0.0-43.43`、`6.8.0-149.149`、`5.15.0-203.213`），20.04 以后连这个都没有；RHEL 8、9、10 连同 OpenShift Container Platform 4 和 5 全部无补丁，Red Hat 自己承认正在加急。倒是别家跑在前面：Debian 的 bookworm 和 trixie 已修（SUSE LE 16.0 与 15 的 LTSS、openSUSE Leap 16.0、Oracle 的 UEK、10 月 30 日补齐的 Amazon Linux 全部内核都算），AlmaLinux 的 `kernel-4.18.0-553.180.2.el8_10`、`kernel-5.14.0-687.61.2.el9_8`、`kernel-6.12.0-211.69.2.el10_2` 从 10 月 30 日起躺在测试仓库里等社区测试，Red Hat 10 月 30 日把评级从 Important 8.1 抬到 Critical 9.8，并在公告 RHSB-2026-016 里给了 nftables 缓解规则。

还有一条把 AI 拉进故事线的信息：Anthropic 的 Frontier Red Team 说，Claude 在实验里写出了一个可用的远程 root PoC，在「带 multipath TCP 监听的 Linux 服务器」上不需要任何凭据和交互就能执行命令，原文给的数字是 48 分钟泄露一个内核指针、再 5 分钟走到 shell；PoC 没有公开。10 月 29 日 Go Security Team 补了关键一刀：Go 1.24 起，Linux 上的 listen socket 默认启用 MPTCP——也就是说这个 PoC 需要的配置，在 Go 生态里是默认状态，不是边缘玩法。同一天起 GitHub 上开始冒出引用该 CVE 的仓库，到 10 月 31 日 36 个，其中至少 6 个声称带 race trigger 或 PoC，最早的一个在 10 月 29 日晚上 7:22 创建；CISA 的 KEV 目录当时还没有收录。

## 讨论焦点

### 一、上游两周修完，发行版又拖了两周

这个洞最刺眼的地方是时间差。上游从提交到批量出 stable 内核只用了两周，从 CVE 公开到 10 月 31 日又过去了两周半，而 Ubuntu 每一个发行版还是「Vulnerable」。讨论里最先炸开的就是这个：

> "How are Ubuntu and RHEL not fixed? Few operating systems market themselves more as suitable for servers. What are they doing over there?" — swinglock [c:50319570]
> （译文：Ubuntu 和 RHEL 怎么还没修？把自己定位成服务器用得最顺手的两家操作系统，它们到底在忙什么？）

对比着 Debian 看更荒诞：

> "It seems particularly crazy for Ubuntu given that Debian released their fix something like a couple weeks ago." — kqgnkqgn [c:50321131]
> （译文：考虑到 Debian 两周前就放出了修复，Ubuntu 这样尤其离谱。）

Red Hat 的理由在评论区被解释成一种版本管理的副作用：

> "RHEL runs with MP-TCP disabled by default, they initially listed it as Important only to later raise it to Critical." — xorcist [c:50321419]
> （译文：RHEL 默认关掉了 MP-TCP，最初把它评为 Important，后来才提到 Critical。）

Ubuntu 自己给这个洞定的优先级是 High，不是 Critical——按 Ubuntu 的定义，Critical 意味着「默认安装下几乎所有用户都能利用的重大问题」；Red Hat 却在 10 月 30 日把它抬到了 Critical 9.8。两家对同一个洞给出两套风险口径，评论区直接吵到发行品类的信用上：

> "IMNSHO this makes them unfit for purpose. I think this is the nail in the coffin for Ubuntu for me." — 1over137 [c:50321069]
> （译文：以我之见，这让他们不再适合其本来用途。我觉得这是 Ubuntu 的棺材板上的最后一颗钉子。）

现实里运维的选择不多，等、从 proposed 仓库手动拉、或者自己编内核：

> "I pulled in from -proposed this time." — tln [c:50321108]
> （译文：这次我是从 -proposed 仓库拉的内核。）

顺带说，影响面本身也被质疑过一遍。NVD 的受影响版本字段写得没法用：

> "We do have versions, branch names and tags for a reason." — rurban [c:50320134]
> （译文：我们有版本号、分支名和 tag 就是为了这个。）

于是有人把范围直接摊开：

> "Wrong. Every kernel from 4.4 onward is affected until the fixed releases (5.10.272, 5.15.223, 6.1.190 and so on)." — pizza234 [c:50320203]
> （译文：不对。从 4.4 开始的每一个内核都受影响，直到那些修复版本（5.10.272、5.15.223、6.1.190 等等）。

### 二、multipath TCP 这个关键词，报道用错了地方

原文强调 PoC 需要「multipath TCP 监听」，评论区立刻指出这是两回事：漏洞在 IPv4 选项（IP options）的释放时机，而 MPTCP 用的是 TCP 选项字段。

> "MPTCP uses TCP options fields, the vulnerability is in IP options." — peanut-walrus [c:50319853]
> （译文：MPTCP 用的是 TCP 选项字段，而这个漏洞在 IP 选项里。）

那 MPTCP 到底是什么？wahern 给了一段定义：

> "It's an extension to TCP that, similar to QUIC, allows you to use multiple address/port pairs to transmit data over a single logical stream." — wahern [c:50319704]
> （译文：它是 TCP 的一个扩展，思路类似 QUIC，允许你用多个地址/端口对在一条逻辑流上传输数据。）

> "Both client/initiator and server/listener have to opt into the extension." — wahern [c:50319704]
> （译文：客户端/发起方和服务端/监听方都得显式选择启用这个扩展。）

问题在于「显式」这件事在 Go 里被自动化了：

> "Go 1.24 does that by default, so does Caddy, these would be the big ones." — dist-epoch [c:50319595]
> （译文：Go 1.24 默认就开，Caddy 也是，大头都在这两家。）

再往深一层，MPTCP 本身还有两种形态，stingraycharles 做了区分：

> "There are two types of multipath TCP and they are not at all the same." — stingraycharles [c:50322800]
> （译文：multipath TCP 有两种形态，它们完全不是一回事。）

> "The more traditional server side multipath is that you have a network card with 4 ports (eg 4x 25gbit) and connect them to a router, and make those 4 physical ports (paths) behave like a single interface." — stingraycharles [c:50322800]
> （译文：传统那种服务端 multipath，是你有块 4 口的网卡（比如 4x 25G），全插到一台路由器上，让这 4 条物理路径表现得像单个接口一样。）

Apple 的 iPhone 走的是另一条路（WiFi 与 5G 同时用），而这个漏洞吃的是服务器那种多网卡聚合形态。顺带一提 IPv6 不受主问题影响，wiskinator 拿这个开了个玩笑：

> "Also, since IPv6 isn't affected, wouldn't it be funny if this is what it took to get everyone to switch." — wiskinator [c:50319519]
> （译文：另外既然 IPv6 不受影响，这件事要是能逼所有人切 IPv6，倒也挺有意思。）

### 三、Claude 写的那个 PoC，是真的吗

争议最大的一段是「UAF 到底能不能变成 root」。marcosscriven 的疑问很具体——他自己给家里的封闭设备做 root，日常用 AI 找漏洞，但真要变成可利用的 exploit 就卡住：

> "Can anyone explain how user after free results in a practical exploit?" — marcosscriven [c:50319762]
> （译文：谁能解释一下 use-after-free 怎么就变成一个能实际用的 exploit？）

> "In the end it usually ends up there’s no exploit it can find, because it can’t actually influence the affected memory in a useful way." — marcosscriven [c:50319762]
> （译文：最后的结果通常就是它找不到可用的 exploit，因为它没法用有用的方式影响那块内存。）

cowlevel 从防守方角度补了同样的话：

> "Getting the right thing allocated in the right place to exploit a UAF is usually very very tricky." — cowlevel [c:50320183]
> （译文：要让正确的东西被分配到正确的位置，从而利用一个 UAF，通常非常非常棘手。）

fguerraz 描述的是一旦成功之后的破坏力：

> "If it’s freed it can be reallocated, so then you have pointers to the same area of memory used for completely different data structures, and this can go very wrong" — fguerraz [c:50320108]
> （译文：这块内存被释放后可以被重新分配，于是你就有了指向同一片内存的指针，而那里放着完全不同的数据结构，这会出大问题。）

另一边的怀疑更直接，怀疑的是那篇文章本身：

> "It reads like it was LLM generated though so who knows." — grey-area [c:50319678]
> （译文：不过读起来像是 LLM 生成的，谁知道呢。）

同一个人后来自己给出了一个折中的判断——原文没错，但前提被讲小了：

> "Anthropic only exploited multipath TCP, but the bug is deeper and also affects TCP connections, but it looks like this path is harder to exploit, and it's unclear if anybody managed to." — dist-epoch [c:50319701]
> （译文：Anthropic 只在 multipath TCP 上做了利用，但这个 bug 更深，也影响普通 TCP 连接，只是这条路径更难利用，而且不清楚有没有人真的做到过。）

所以合理的结论是分层的：Anthropic 那个 PoC 有具体数字兜底（48 分钟泄露内核指针，再 5 分钟到 shell），Go 团队又确认 Go 1.24 默认开 MPTCP，前提比看上去普遍；但「普通 TCP 路径也能打出 root」这件事，公开信息里既没有证实也没有否证——PoC 至今没有公开。

### 四、真正暴露的，是那些永远不更新的机器

服务器这一侧其实相对乐观。有人的 VPS 早就自动更新并重启过：

> "My VPS was auto-updated and restarted more than 14 days ago. The logs have rolled already." — exyi [c:50320655]
> （译文：我的 VPS 14 天前就自动更新并重启过了，日志都轮转没了。）

难办的是消费级和网络设备。最新的 OpenWrt 也中招：

> "Note that even the latest OpenWRT is vulnerable to this, I'm running OpenWRT 25.12.6 and the kernel version is 6.12.112" — FredFS456 [c:50320782]
> （译文：注意就算是最新的 OpenWrt 也中了这个，我跑的是 OpenWrt 25.12.6，内核版本 6.12.112。）

而这类设备的补丁基本属于玄学：

> "IoT devices will get fixes delivered on the 12th of never." — rwmj [c:50320044]
> （译文：IoT 设备的补丁会在「永远never 十二号」那天送到。）

所以务实的做法是提前假设它已经被拿下：

> "You should assume your IoT junk is already compromised, that's why your IoT junk runs on a dedicated VLAN." — eterm [c:50320086]
> （译文：你应该假设你那堆 IoT 已经被攻陷了，这也正是你那堆 IoT 要跑在独立 VLAN 上的原因。）

也有人指出 OpenWrt 默认不对外开端口，暴露面比想象的窄：

> "OpenWrt doesn't open ports by default so I think the impact is minimal, unless this can breach nftables as well." — lunar_rover [c:50319995]
> （译文：OpenWrt 默认不开放端口，所以我觉得影响很小，除非这个洞能顺带突破 nftables。）

还有一条硬件层面的安慰——利用路径要竞争两颗 CPU，单核设备反而躲过：

> "If this requires a multi-core system to exploit, it's good news for most of the consumer routers that will never get updates. Saved by cheap single-core hardware." — mrob [c:50319518]
> （译文：如果利用需要多核系统，那对大多数永远等不到更新的消费级路由器来说反而是好消息，被便宜的单核硬件救了一命。）

但同一批人也补了刀：便宜的消费级路由器往往有两颗或四颗 ARM 核，问题是内核老到石头时代（Unifi UCG Fiber 跑的还是 2022 年 9 月的 5.4.213）。

### 五、云厂商挡在前面，挡得住多少

AWS 的公告说 WAF、ALB、CLB、NLB 的 TLS 监听、CloudFront、API Gateway 这类服务不会让客户直接接到不可信来源的 TCP 连接，底层设施由 AWS 自己更新，用户不需要立刻动手，只需在 30 天内更新这些服务后面的自管实例。有人对此表示乐观：

> "At least if you’re on Amazon Web Services behind a load balancer you probably aren’t really that impacted enough to spend Halloween patching." — Shank [c:50319571]
> （译文：至少如果你在 AWS 后面挂个负载均衡器，你大概没那么受影响，不至于为了万圣节去打补丁。）

但同一条讨论里立刻有人指出 NLB 的例外：

> "Note: AWS NLB doesn't terminate TCP for TCP listeners." — lysace [c:50320865]
> （译文：注意：AWS 的 NLB 对 TCP 监听是不做连接终结的。）

也就是说 raw TCP 会原样穿过负载均衡器打到后面的机器——云厂商的补丁保护的是云厂商那部分机器，你自己那些跑在实例里的内核照样中招。

### 六、还没打上补丁的这段时间

临时缓解手段在讨论里被拆得很细。Red Hat 的 nftables 规则丢的是带 IPv4 options 的 TCP 包，Atlas 给的等价规则挂在 prerouting、priority -300，判据是 `ip hdrlength gt 5`（IPv4 头超过 20 字节最小长度就说明带了选项）；iptables 那边用 raw 表加 xt_u32 匹配同一个头长度字段，但 RHEL 9/10 的内核没编这个模块，只能走 nft。

前提是这确实只是一层缓解：

> "MPTCP is not a requirement, it is a generic use-after-free." — peanut-walrus [c:50319726]
> （译文：MPTCP 不是必要条件，这是一个通用的 use-after-free。）

> "At least according to Red Hat, dropping packets with IP options yourself helps, but is not a full mitigation." — peanut-walrus [c:50319726]
> （译文：至少按 Red Hat 的说法，自己丢掉带 IP options 的包是有用的，但这不是完整的缓解措施。）

把丢包放在 XDP 层更彻底，tptacek 给的理由很短：

> "Dropping packets with IP options from XDP should be a more complete mitigation (also more performant)." — tptacek [c:50320242]
> （译文：在 XDP 层丢掉带 IP options 的包，应该是更彻底的缓解（性能也更好）。

> "tl;dr: eBPF programs that run hot off the DMA buffers, before skbufs are created, that can XDP_DROP packets." — tptacek [c:50322203]
> （译文：一句话：在 skbuf 创建之前、直接从 DMA 缓冲区跑起来的 eBPF 程序，可以直接 XDP_DROP 掉这些包。）

至于「ISP 路由器会丢掉带 options 的包，所以公网上打不着」这个说法，被 wahern 直接顶了回去——因为 iPhone 是 MPTCP 的重度用户，而 MPTCP 用的是 TCP 选项不是 IP 选项：

> "That doesn't track. Apple iPhones are a major user of MPTCP and they report the majority of requests supporting MPTCP, IIRC 70+%." — wahern [c:50319811]
> （译文：这说法讲不通。苹果 iPhone 是 MPTCP 的重度用户，他们报告说大多数请求都支持 MPTCP，好像是 70% 以上。）

IP options 被丢弃本身是有历史包袱的，pigggg 讲的是二十多年前的教训：

> "There's lots of obvious reasons as they're generally an old school ddos path to knock out routers" — pigggg [c:50321615]
> （译文：有很多显而易见的理由，因为它们一般来说就是打垮路由器的经典老派 DDoS 路径。）

### 七、AI 找洞之后，是变多还是变便宜

这个 CVE 很快成了「AI 时代安全成本」的引子。api 的判断干脆：

> "2027 is going to be the year of two to three major CVEs per day." — api [c:50319657]
> （译文：2027 年会是一天两三个重大 CVE 的一年。）

> "These are mostly pre-existing bugs, some very old, and they’ve been lurking." — api [c:50319657]
> （译文：它们大多是一直存在的老 bug，有些非常老，一直潜伏着。）

jstanley 认了前半句，补了后半句：

> "I agree, but as yet we have no idea how much pain we have to pass through to get to the other side." — jstanley [c:50320561]
> （译文：我同意，但到现在我们还不知道，在到达彼岸之前要承受多少痛苦。）

而 grey-area 担心的方向是反的——PoC 本身会被 AI 快速改写：

> "Expanding exploits is something LLMs seem pretty good at so I’d expect people to manage a more general exploit soon if not already." — grey-area [c:50319739]
> （译文：扩展利用这件事，LLM 好像挺擅长的，所以我预计人们很快就能搞出更通用的利用，可能已经有了。）

收尾的那句最像整段的题眼：

> "On the other side we have a Linux networking stack written in Rust." — Gigachad [c:50320680]
> （译文：等我们到了彼岸，网络协议栈就该是 Rust 写的了。）

### 八、要不要换发行版

这场讨论的后半段滑向了运维人的自保方案。最常见的一条是换发行版：

> "I'd be seriously considering Debian or, hear me out, NixOS." — linsomniac [c:50321963]
> （译文：我会认真考虑 Debian，或者——听我说一句——NixOS。）

立刻有人拦住：

> "No legit enterprise is running that clownware — ever." — lakeviewterrace [c:50322167]
> （译文：没有一家正规企业会跑那套 clownware——永远不会。）

而在 LTS 这个概念上，kev009 说得最狠：

> "LTS is kind of a myth, it trades ABI and API stability for a lot of other issues." — kev009 [c:50320357]
> （译文：LTS 某种意义上是个神话，它拿 ABI 和 API 的稳定换掉了其他一大堆问题。）

更多的人是在说自己被逼到哪一步了：

> "I don't think I can recall an instance where there was an issue this bad (a box being vulnerable just by virtue of being connected to the internet, or exposing nothing other than ssh) and I didn't have timely patches for it." — ashleyn [c:50322014]
> （译文：我想不起来有哪一次问题有这么严重（一台机器仅仅因为连着互联网、或者只开着 SSH 就中招），而我手上却没有及时补丁。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 上游两天修完，发行版在拖后腿 | swinglock、kqgnkqgn | Debian 两周前就放了修复，Ubuntu 却还没 |
| 同一洞两套风险口径 | codegeek、xorcist | Ubuntu 定 High，Red Hat 从 Important 抬到 Critical 9.8 |
| 发行版信用受损 | 1over137、lakeviewterrace | 「这让 Ubuntu 不再适合其用途」「没有企业会跑那套 clownware」 |
| 报道的关键词用错了 | peanut-walrus、dist-epoch | MPTCP 用 TCP 选项，漏洞在 IP 选项；Anthropic 只在 MPTCP 上做了利用 |
| PoC 可能是真的，也可能只是博客生成的 | grey-area、marcosscriven | 一个说读起来像 LLM 写的，一个说 UAF 很难变成实际 exploit |
| 通用 UAF 意味着关掉 MPTCP 不够 | peanut-walrus | 「MPTCP 不是必要条件，这是一个通用 use-after-free」 |
| 消费级设备才是重灾区 | rwmj、eterm、mrob | IoT 的补丁永远不来，单核路由器反而躲过 |
| 云能挡一部分但挡不住全部 | Shank、lysace | AWS NLB 对 TCP 监听不终结连接，raw TCP 照样穿过去 |
| AI 让漏洞变多也变便宜 | api、Gigachad | 一天两三个重大 CVE，另一边是 Rust 写的网络栈 |

## 总体情绪

这不是一场恐慌，更像一次集体算账：算上游修了几天、算发行版拖了几天、算自己手上那台机器有没有补丁、算要不要为了这次洞把整个系统换成别的发行版。最扎人的两个数字都不是漏洞本身，而是 Anthropic 那个 PoC 的 48 分钟泄露内核指针加 5 分钟拿到 shell，和 Ubuntu tracker 上从 10 月 15 日到 10 月 31 日一直不变的「Vulnerable」。

值得记住的是，评论区对「AI 挖洞」的两种担心最后合流了：一边怕洞变多、PoC 变强（一天两三个重大 CVE），一边怀疑那个 PoC 本身可能就是一篇 LLM 生成的稿子。可这两条都不影响眼下要做的三件事——打上发行版的内核并重启、确认 `ss -Mlnp` 里有没有 MPTCP 监听、在没法打补丁的机器上先把带 IP options 的包丢掉。

洞很快被找到，补丁很快被写出来。上游 10 月 15 日就修好了，Ubuntu 和 RHEL 到 10 月 31 日还在排队——这段路上没有 Claude，也没有 PoC，只有发行版的排期表，和一屋子没人催的单子。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | TCP Use-After-Free: CVE-2026-98432 / CVSS 9.8（HN 主帖，411 分） | https://news.ycombinator.com/item?id=50319143 |
| 2 | Linux's October 2026 TCP Use-After-Free: CVE-2026-98432 — Atlas（原文） | https://atlasum.net/blog/cve-2026-98432-linux-ipv4-tcp-uaf |
| 3 | CVE-2026-98432 记录（cve.org） | https://www.cve.org/CVERecord?id=CVE-2026-98432 |
| 4 | Anthropic：Discovering and exploiting vulnerabilities in critical, real-world software with Claude | https://www.anthropic.com/research/discovering-vulnerabilities-with-claude |
| 5 | Red Hat 安全公告 RHSB-2026-016 | https://access.redhat.com/security/vulnerabilities/RHSB-2026-016 |
| 6 | AlmaLinux 公告（修复内核进入测试仓库） | https://almalinux.org/blog/2026-10-30-cve-2026-98432/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中的 CVSS 评分、修复版本号、各发行版补丁状态、时间线与缓解规则，均来自 Atlas Security 于 2026-10-29 发布、10-31 更新的原始披露，以及文中链接的 CVE 记录、Red Hat 公告、AlmaLinux 公告与 Anthropic 研究文章；本文未做独立复核，且这些状态在发布后可能已经变化。文中涉及的 Go 默认启用 MPTCP、Anthropic 的 PoC 表现、GitHub 上引用该 CVE 的仓库数量等均为特定时间点的信息，不代表当前状况。讨论中提到的「丢掉带 IP options 的包」「关闭 MPTCP」「改用 Debian 或 NixOS」等做法均为评论者个人方案，是否有效取决于具体内核版本、网络拓扑与业务形态，本文不建议读者照搬，请以自己发行版的跟踪页为准。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
