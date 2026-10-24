---
layout: post
title: >-
  Docker is weird：容器不是容器，是五个内核特性穿了一件雨衣 — HN 讨论摘要
date: 2026-10-24
hn_id: 50202681
categories: [articles]
excerpt: >-
  作者写博客拆解 Docker 的怪，结果把 Docker 的创造者喊来了。
  847 分、356 条评论里，Solomon Hykes 当场更正了他的两处硬伤，
  还承认这家公司「不擅长商业化」是自己作的。
tagline: >-
  容器不存在。五个内核特性穿了件雨衣，大家叫它 Docker。
---

## 原文概要

10 月 22 日，一位叫 psxuaw 的开发者把自己的博客链接丢上 HN，文章标题就叫《Docker is weird》。动机极其朴素：他决定为了好玩自己写一个容器运行时，写着写着发现 Docker 处处奇怪，于是把怪的地方列了出来。文章在 HN 拿到 847 分，356 条评论。

文章一共六节，密度很高。容器不是真的——容器只是被加了限制的普通进程，你的内核照跑不误，在 `/proc` 里就能找到它。容器「真的不是真的」——Linux 内核里压根没有「容器」这个功能，容器是 5 个内核特性穿雨衣：namespaces 决定谁能看到谁，cgroups 限制资源占用，网络那一套作者自己也说「我不太懂」。镜像只是文件夹——Docker 把镜像放在某个路径，然后 `chroot` 或 `pivot_root` 把它变成新根目录，所以 `docker run -it --rm ubuntu /bin/bash` 实际做的是三件事：下载 ubuntu 镜像、放到某个地方、跑 `/some/weird/docker/path/bin/bash`。

最有意思的是第四节，作者说 Go 是个挺糟糕的容器运行时语言。Docker 的运行时 `runc` 用 Go 写，Go 的运行时天生多线程，而容器运行时需要做的很多 Linux 系统调用必须在单线程环境里完成，于是 `runc` 挂了一个「疯狂的 C 模块」——`libcontainer/nsenter`，在 Go 运行时初始化之前就先跑起来干这些活。Go 也没有 fork，fork 只能 fork 主线程，容器运行时真正想要的是 fork → 设一堆限制 → exec 目标进程，所以 `runc` 只能 exec `/proc/self/exe` 加一个特殊命令行参数来近似 fork。第五节是「Docker 需要 root」：很多内核 API 要求 root，daemon 通常就以 root 跑，rootless 方案则要把整个网络栈在用户态重写一遍。

作者没料到的是评论区。他写的是技术随笔，来的却是这家公司本身的创造者——Solomon Hykes（ID shykes）现身说法：「我是 Docker 的创造者，路过这篇帖子。」然后他回答了十几个问题。对话从「容器到底是什么」一路滑到「Docker 早期其实是 Python 写的，为什么换 Go」「为什么商业化失败」「Moby 开源那年到底发生了什么」「你现在做什么」。

讨论因此裂成两半：一半是技术细节的当场纠正，作者关于 Go 和 lxc 的两处说法被一一更正；另一半是关于 Docker 这个产品的争论——语法还有没有人学、root 是不是原罪、企业需求为什么被忽略、以及一家定义了容器时代的公司为什么始终赚不到钱。

## 讨论焦点

### 一篇技术随笔，喊来了创造者本人

shykes 的开场只有一句，但把整条讨论的性质改了：

> "Hi, I'm the creator of Docker and came across this post." — shykes [c:50202931]
> （译文：你好，我是 Docker 的创造者，路过这篇帖子。）

于是评论区立刻变成一场 AMA。有人在下面感慨「这是这个月 HN 上最精彩的一串贡献」。作者写的是自己刚起步的运行时项目，来的却是一个已经把这件事做成产业的公司创始人的记忆。

### 容器到底是不是容器：五个内核特性和一段历史

作者说容器不是真正的容器，创造者点头，但顺手纠正了文章里的历史细节：

> "Docker in its earlier incarnations was based on openvz, which predates lxc." — shykes [c:50203555]
> （译文：Docker 早期几个版本是基于 openvz 的，而 openvz 比 lxc 更早。）

> "The original open-source release of Docker wrapped lxc for low-level container operations." — shykes [c:50203555]
> （译文：Docker 最初开源的那个版本，是把 lxc 包起来做底层容器操作的。）

关于 lxc 到底算不算 Docker 的祖宗，创造者本人给了同一段历史里的另一半：lxc 项目最初是一个内核开发项目，收集了一批给内核加容器支持的补丁，用户态工具只是个附属品；而围绕 lxc 的出身，评论区吵得更热闹：

> "Docker was basically a commercialisation of lxc and now we got nspawn going full circle." — bijmtir [c:50203397]
> （译文：Docker 基本就是把 lxc 商业化了，现在我们又有了 systemd-nspawn，转了一圈回来了。）

更早一代的人记得另一条技术路线。Fortune 500 系统组的 ecliptik 回忆，那时他们在 Solaris Zones 和 cgroups 上自己造轮子，进展有限：

> "When Docker came out it solved so many issues we were having." — ecliptik [c:50203211]
> （译文：Docker 出来的时候，把我们遇到的很多问题都解决了。）

### Go 是不是写容器运行时的糟糕选择

文章里那句「Go 是个挺糟糕的容器运行时语言」被拎出来单独讨论。创造者承认这个批评在技术上完全成立，但坚持这个选择在当时是对的：

> "The article's point that Go is a bad fit for some of the low-level interactions with the kernel, is absolutely correct though." — shykes [c:50204922]
> （译文：文章说 Go 在跟内核做底层交互上不太合适，这一点完全正确。）

理由写在下一段：`We had to do a lot of juggling to get it to work properly. But in the end it was fine.`（我们费了很大劲才把它调通，但最后确实没问题。）他强调当时的考虑是吸引贡献者——Go 的语法足够「vanilla」，比 Erlang、Haskell、Clojure 这样的语言门槛低，Docker 因此吸来大量第一次参与开源贡献的人。

一位只贡献过一个小功能的工程师用自己的经历佐证了这个说法：

> "Go made it MUCH easier for a fly-by-night contributor such as myself to join the party." — bmurphy1976 [c:50209464]
> （译文：Go 让像我这样临时起意的贡献者参与进来变得容易了太多。）

相对的视角也有人补充：

> "That's a good answer that effectively rebuts the article's claim that Go was a bad choice imo." — julianeon [c:50204565]
> （译文：这是个很好的回答，实际上反驳了文章里「Go 是个糟糕选择」的说法，在我看来。）

### 起源：一个在法国写了五年、没人理解的东西

创造者对成功原因的解释，比「运气好」复杂得多：

> "Docker launched in 2013, but it was one of many iterations of the same project, which I had been working on continuously since 2008." — shykes [c:50203071]
> （译文：Docker 是 2013 年上线的，但它只是同一个项目的众多迭代之一，而这个项目我从 2008 年起就在持续做。）

> "Over those 5 years, virtually nobody cared or understood what the hell I was working on. I lived in France and had no connection to the tech industry." — shykes [c:50203071]
> （译文：那 5 年里，几乎没人在乎，也没人明白我到底在搞什么。我当时住在法国，跟科技行业没有任何联系。）

语言的选择也是同一段历史的一部分：

> "The first versions of what became Docker were written in Python." — shykes [c:50203120]
> （译文：后来变成 Docker 的最初几个版本，是用 Python 写的。）

> "back then devops tools were segmented by language runtime: ruby, python or Java mostly. Shipping a compiled binary allowed us to be adopted by all tribes." — shykes [c:50203120]
> （译文：那时候 devops 工具是按语言运行时割裂的：主要是 ruby、python 或 Java。出一个编译好的二进制文件，就能被所有阵营接受。）

有人把这段历史压缩成一句：

> "Not luck: pay attention to what the community needs, and be in a position to execute when you spot it." — DANmode [c:50204935]
> （译文：不是运气：留意社区需要什么，然后在看到机会时有能力执行。）

### Dockerfile 语法，还有多少人真的在写

「学不学 Docker 语法」是评论区最实际的一段。一种回答是这东西简单到一晚上就能学完：

> "There are only 18 directives, and the average Dockerfile uses like 6 of them." — craftkiller [c:50203484]
> （译文：它只有 18 条指令，而平均一个 Dockerfile 大概只用其中 6 条。）

另一种回答更干脆——没人需要会写：

> "No one needs to know docker syntax." — xyzzy_plugh [c:50203501]
> （译文：没人需要知道 Docker 语法。）

> "I haven't hand-written a Dockerfile in at least six years." — xyzzy_plugh [c:50203501]
> （译文：我至少六年没手写过一个 Dockerfile 了。）

被问到 LLM 会不会把这一切自动化，这位作者的回答是别把锅甩给模型：

> "LLMs have not loved the needle here in my sphere, it was already bouncing off of the zero on the gauge." — xyzzy_plugh [c:50203501]
> （译文：在我的领域里，LLM 并没有把针扎到点上，指针早就一直在零的位置上弹来弹去了。）

学生的视角则更乐观：

> "I find myself very rarely debugging or handwriting dockerfiles nowadays!" — Tenemo [c:50203155]
> （译文：我现在很少调试或者手写 dockerfile 了！）

至于「语法不重要」这个说法，有一条反向意见：新手真正的坑不在语法，而在顺序。

> "the one mistake I keep seeing new people make when writing Dockerfiles is writing them in a way that doesn't optimize for caching." — craftkiller [c:50208046]
> （译文：我反复看到新手写 Dockerfile 时犯的一个错误，就是写成了不利于缓存优化的顺序。）

> "Docker is much more than memorising a handful of Dockerfile directives." — subscribed [c:50207921]
> （译文：Docker 远不止是记住几条 Dockerfile 指令。）

### root 与被让出来的空白

作者那句「Docker 需要 root」引出了企业侧的账。dralley 说得直接：

> "they just ignored a lot of the needs of enterprise users (rootless, not punching holes in the firewall, not fighting with systemd, private registries) for long enough that other projects (e.g. Podman, Quay) filled the void." — dralley [c:50203990]
> （译文：他们长期无视了企业用户的很多需求（无 root、不在防火墙上开洞、不跟 systemd 打架、私有镜像仓库），久到别的项目（比如 Podman、Quay）把这些空白填上了。）

创造者没有否认，但把原因指向内部：

> "Docker's difficulties in commercializing were self-inflicted." — shykes [c:50206124]
> （译文：Docker 在商业化上的困难是自己作的。）

他给出的解释是企业团队和开源团队文化上互相隔离，做出来的东西不是「原生的」，也没有一个能拍板产品设计的单一权威。

### 为什么一家开创了赛道的公司赚不到钱

这是全场最尖锐的一段。stingraycharles 把原因归到商业模式本身：

> "Unless you have an option to do private cloud hosting (like all these databases and other platforms do), it’s incredibly difficult to monetize." — stingraycharles [c:50203719]
> （译文：除非你也能提供私有云托管（像那些数据库和其他平台那样），否则这件事极难变现。）

> "Best you can do is enterprise support contracts, but those aren’t good enough to justify all that VC funding." — stingraycharles [c:50203719]
> （译文：最好的办法也就是卖企业支持合同，但那点收入撑不起当年那轮 VC 融资。）

最有画面感的证据来自一位注册表页面的打开过程——他顺手用浏览器的 Network 面板打开了 hub.docker.com：

> "368 requests, 9.62MB, Finish: 4.50s." — justsomehnguy [c:50204799]
> （译文：368 个请求，9.62MB，耗时 4.50 秒。）

而这还只是今天的状态，这位作者补了一句更早的版本「能卡 30 秒才加载出来」。创造者自己其实早就认过这件事：

> "Docker was famously bad at commercializing anything, we open sourced so much (maybe too much) and still people complained that we were not open enough." — shykes [c:50203555]
> （译文：Docker「出了名的不擅长商业化任何东西」这句话是我自己说的——我们开源了太多（也许太多了），结果还是有人抱怨我们开得不够。）

### 替代品，以及一场没人收尾的架

真要用容器而不想 root，还有一堆选项。有人把 Incus 当成更完整的答案：

> "I'm a huge fan of Incus. VMs, LXC, and OCI containers all under the same Docker-like CLI interface." — radlad [c:50203750]
> （译文：我非常喜欢 Incus。虚拟机、LXC、OCI 容器，都在同一个类似 Docker 的命令行界面之下。）

有人连容器都不用：

> "I just run programs in my OS. If I want to isolate them I give them their own account and home directory or maybe chroot." — SoftTalker [c:50210473]
> （译文：我直接在操作系统里跑程序。如果需要隔离，我就给它们各自的账号和主目录，或者干脆用 chroot。）

评论区后半段则滑进了另一件事：有人对 Docker 团队的措辞不满，被人当面指出语气问题：

> "I think there are some interesting points there, but your rude, arrogant, and aggrieved tone overwhelms them." — zbentley [c:50211495]
> （译文：我觉得那里确实有几个有意思的观点，但你那粗鲁、傲慢、满腹委屈的语气把它们盖过去了。）

这场架从「Docker 是不是太固执」一路升级到「你对 Docker 有多了解」，最后以一句人身攻击收场，没有一方退让。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| Go 在容器运行时上确实是糟糕选择 | shykes | 跟内核底层交互不合适这点完全正确，只是当时仍然是对的 |
| Go 的价值在于拉人进来 | bmurphy1976 | 让临时起意的贡献者也能上手，Docker 因此吸来大量新人 |
| Docker 源自 lxc，但换掉了它 | shykes | 早期是 openvz，后转 lxc，又因为太不稳定换成自研的 libcontainer |
| 容器是 lxc 商业化后的循环 | bijmtir | 现在有了 systemd-nspawn，转了一圈又回来了 |
| 成功不是运气 | DANmode | 留意社区需要什么，并能在看到机会时执行 |
| Dockerfile 语法一晚就能学完 | craftkiller | 18 条指令，平均只用 6 条 |
| 没人需要会写 Dockerfile | xyzzy_plugh | 六年没手写过，LLM 也没帮上什么忙 |
| 新手真正的坑是缓存顺序 | craftkiller | 先拷代码再装依赖，是最常见的浪费 |
| 企业需求被长期忽略 | dralley | 无 root、私有仓库这些空白，被 Podman 和 Quay 填了 |
| 商业化失败是自己作的 | shykes | 企业与开源团队文化隔离，没有能拍板产品的人 |
| 难变现是模式决定的 | stingraycharles | 没有私有云托管这条路，就只能卖企业支持合同 |
| 换个容器运行时更省心 | radlad | Incus 把虚拟机、LXC、OCI 收进同一个命令行 |
| 连容器都可以不要 | SoftTalker | 给独立账号和主目录，或者 chroot 就够了 |

## 总体情绪

这场讨论的情绪落差大得离谱。一边是作者在博客里安静地拆解 Docker 的怪，创造者出现后两个人互相补充技术细节，气氛友好得像在工作坊；另一边是评论区对 Docker 这个产品的清算——root、语法、企业功能、商业化，每一项都被翻出来重判一遍，还捎带了一场谁也不肯先低头的口水战。

真正让人意外的是创造者几乎全程在自我批评：Python 起家、Go 的语言崇拜、五年无人问津、停在 2008 年住在法国、Moby 开源时的「skunkworks 项目」、以及那句自己说出口的「出了名的不擅长商业化任何东西」。一个把容器变成行业基础设施的公司，创始人在评论区把自己的每一处失手都摊开给一堆陌生工程师看。

而作者那篇博客最狠的一句其实没被讨论：容器根本不是容器，镜像根本不是镜像，Docker 只是五个内核特性加一个文件夹，套了件雨衣叫了个好记的名字。所有人都知道，也都继续用。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Docker is weird（原文博客） | https://codeandcake.dev/posts/2026-10-22-docker-is-weird |
| 2 | runc 的 C 模块 libcontainer/nsenter | https://github.com/opencontainers/runc/tree/main/libcontainer/nsenter |
| 3 | Dagger（shykes 现在做的项目） | https://dagger.io |
| 4 | Docker is weird（HN 讨论） | https://news.ycombinator.com/item?id=50202681 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
