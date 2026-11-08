---
layout: post
title: >-
  10 美元的 OpenStick 家用服务器：512MB 内存里塞进 DNS 过滤、监控和一个 AI agent — HN 讨论摘要
date: 2026-11-08
hn_id: 50406670
categories: [articles]
excerpt: >-
  一根含运费 10 美元的 4G 调制解调器，作者在它上面跑起 AdGuard Home、Beszel、Fusion RSS，
  还装了一个能通过 Telegram 回答「磁盘还剩多少」的 AI agent，并把 root shell 交给了它。
  评论区真正吵起来的不是配置清单，而是「一个能读你全部日志的 root shell，
  是不是离被一次 prompt injection 攻破只差一步」。
tagline: >-
  10 美元买到 root shell，然后亲手交给 AI。
---

> 来源：HN 讨论主帖 [What I run on my $10 USD OpenStick homelab](https://news.ycombinator.com/item?id=50406670)（449 分，96 条评论），原文是 LaurensBER 写在自己博客上的一份 OpenStick 自托管清单。本篇为 single post 模式；归档快照 2026-11-08 04:55 UTC，入库 96 条评论。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

OpenStick 是 2022 年 Hackaday 上的「Hackable 2.0」——把 4G 调制解调器和 Pi Zero W2 的供电部分合进一根 USB-A 形状的棒子。作者 LaurensBER 某天一时兴起在 AliExpress 买了它，含运费 10 美元。10 美元买到的是：512MB 内存（约 450MB 可用）、4 核 1GHz ARM Cortex-A53、4GB eMMC、150 Mbit/s Wi-Fi、4G 调制解调器加 GPS、无风扇被动散热因此完全静音，外加一颗可编程 LED。他自己承认「你的手表可能比它更强」，但这点体积确实适合拿来入门自托管。

装起来并不轻松。出厂不是预装 Debian，而是「一个古怪的 Linux/Android 混合体」（作者原话），要靠 EDL 模式和刷机流程才能换成 Debian；跑起来之后是 Debian + systemd + Podman。内核是 2024 年的主线 6.6，作者认为升到 7.3 不会有障碍，甚至可以把镜像里的内核换成 postmarketOS 的新版本。

然后是服务清单，每一项作者都标了内存占用：CastSponsorSkip 5–10MB，连上 Google Cast 设备自动跳过 YouTube 赞助片段；AdGuard Home 用的是他自己的 fork（AdGuardHome-Next-Gen），40MB 且内存占用与 blocklist 大小无关，加上几份规则后 60% 的 DNS 查询被拦掉；Zeroclaw 64MB，空闲时 RSS 约 3MB，是个 AI agent harness，支持 30 个通道（Telegram、邮件、WhatsApp 等）；Cloudflare Tunnel 8–20MB，免费把服务暴露到公网而不用开端口；Beszel 20MB（agent 10MB + server 10MB），画内存和 CPU 图并把告警推到 Telegram；Dozzle 负责 Podman 容器界面，截图里同时跑着 8 个容器；Gatus 10MB 做服务存活监控；Fusion RSS 22MB，一个自建的 RSS 阅读器（三栏布局、63 篇未读），动机很直白——Feedly Pro 要 7 美元；Shiori 10MB 做书签管理和网页自动存档；Diun 9MB，在容器有新镜像时推一条消息到 Telegram。

真正引爆评论区的是 Zeroclaw 那一条。作者对比说自己在 Kubernetes 上跑过 OpenClaw，那玩意儿「能用，但吃掉 1GB 以上内存，每次更新都会坏，功能够改到把我已有的工作流弄坏」；Zeroclaw 让他觉得耳目一新。他给了这个 agent 对 OpenStick 的访问权——「本质上就是 root shell，但因为爆炸半径有限，我认为可以接受」，主要用途是问「日志里有没有需要我注意的东西」「磁盘空间还剩多少」，而它通过 Telegram 回答，所以在山里信号差的时候也能问。另外他的备份方案是 restic 每晚推到 Backblaze，本来想装 NixOS，但硬件撑不住。

## 讨论焦点

### 一、10 美元的东西，现在还买得到吗

帖子最直接的回帖来自作者自己，他先交代了购买渠道和风险：

> "It can be a bit of a gamble (the sellers usually don&#x27;t specify the exact SOC on the description) but given the price you&#x27;re not taking that much of a risk." — LaurensBER [c:50407293]
> （译文：多少有点赌的成分——卖家通常不在描述里写明具体是哪颗 SoC——但考虑到价格，风险也不算大。）

但价格本身已经变了：

> "When I click the link it says $20 not $10" — jamienk [c:50407694]
> （译文：我点进去那个链接，写的是 20 美元，不是 10 美元。）

> "Can&#x27;t buy those opensticks any more.  They were from 2022." — throwaway81523 [c:50409291]
> （译文：现在买不到那些 openstick 了。它们是 2022 年的东西。）

> "$10 on AliExpress today" — msephton [c:50409762]
> （译文：今天在 AliExpress 上就是 10 美元。）

三句话把「10 美元」这个前提拆成了三种说法：链接标价 20 美元、卖家不写 SoC、货还在但只剩 AliExpress 上的库存。这大概是全文最实用的信息——价格标签比配置表更容易过期。

还有人翻出存货：

> "If anyone’s interested in have about 300 of these that I need to sell." — dools [c:50408183]
> （译文：有兴趣的话，我手上有大约 300 个这样的要卖。）

他手上这批是同一块板子、SIM 卡可用、带原始 IMEI 和固件，还配套了一套能把固件存到 GCS 再刷回来的「工厂」软件。围观群众立刻开始起哄：

> "Make them available while this post is up and you&#x27;ll sell out in days." — qmr [c:50409278]
> （译文：趁这篇帖子还在的时候放出来，你几天就能卖光。）

而真正劝退人的是刷机过程。有人跟着教程走完，删掉热点连接之后设备就失联了：

> "I got it working and can ssh in, till I delete the hotspot connection following the instruction on the site:<p>nmcli connection delete hotspot<p>Now the device is bricked. Well I guess linux is running on it, but there is no way to get to it." — polycancel [c:50408849]
> （译文：我装好了也能 ssh 进去，直到我照着站点说明删掉了热点连接：<p>nmcli connection delete hotspot<p>现在设备变砖了。嗯，Linux 大概还在跑，只是没法再连上它。）

这句把「安装过程有点麻烦」具体化了：设备没坏，但唯一进不去的通道被自己删了。出厂状态也不是 Debian，作者自己澄清过：

> "Its not pre-installed, it comes with a weird Linux&#x2F;Android hybrid if I remember correctly." — LaurensBER [c:50408466]
> （译文：它不是预装的，我记得出厂是个古怪的 Linux/Android 混合体。）

而十年前，2GB 内存的 ARM 小板子就能跑起同样一套东西：

> "my home lab started with my own mail server, git, file sync and few other things years ago served by a 2gb ram arm sbc." — z3ratul163071 [c:50407063]
> （译文：我的家用实验室多年前就是从一台 2GB 内存的 ARM 小板子起步的，跑自己的邮件服务器、git、文件同步之类的东西。）

### 二、不是这个就是那个：Chromebox、旧 Xeon 和 PoE 幻想

评论区的第二个方向是「便宜设备」的通用规律——凡是被设计来做别的事的机器，都适合拿来跑服务。有人拿 Chromebox 举例：

> "Years ago I grabbed an inordinate amount of used Chromeboxen on ebay (some Celeron, mostly i7, Haswell), flashed with MrChromeBox, upgraded SSD and RAM." — jprd [c:50407026]
> （译文：几年前我在 eBay 上收了数量夸张的一批二手 Chromebox（有些是 Celeron，多数是 i7 Haswell），刷了 MrChromeBox，又换了 SSD 和内存。）

他用这批机器在本地 K8s 里跑出了双位数的节点，「跑不了 LLM，但当家用实验室的容器和服务依然很棒」。也有人走的是工作站路线：

> "For anyone who wants a way more beefy homelab but still at a bargain price, I think it&#x27;s hard to beat used Xeon workstations." — TacticalCoder [c:50407631]
> （译文：对于想要一台强得多的家用实验室机器、但又还想便宜的人来说，我很难想到比二手 Xeon 工作站更划算的。）

他补了一句成本对比：「我没花 10 美元，大概是 200 美元。」他还有一台从 Debian 9 时代用到现在、只负责跑 `unbound` DNS 的树莓派——那台 24×7 开着，几乎不耗电。

真正被讨论最多的还是形态。有人想要 PoE：

> "What I’d love to see is a stick that plugs into an Ethernet switch with PoE so you assemble a cluster just by literally plugging nodes to a cluster." — rbanffy [c:50408058]
> （译文：我最想看到的是一根能直接插进带 PoE 的以太网交换机的棒子，这样拼一个集群就只需要把节点插进去。）

不过懂行的人立刻泼冷水：

> "It involves a lot of custom kit (like male right-angle PC-mount 8P8C connectors are contrary to the natural order and don&#x27;t seem to exist at all), and it misses the mark on the main advantage of adopting the complexity of 802.3af PoE" — ssl-3 [c:50408721]
> （译文：这需要大量定制件（比如公头直角 PC 端 8P8C 连接器违反自然规律，似乎根本不存在），而且它错过了采用 802.3af PoE 复杂度的主要好处。）

另一个方向是干脆跳过铜缆：

> "a full blown computer in the SFP module is yesteryear news" — justsomehnguy [c:50409525]
> （译文：把一台完整电脑塞进 SFP 模块，早就是过时玩法了。）

至于更老的 HDMI 小盒子，Intel Compute Stick 被翻了出来：

> "You could look into Intel Compute Sticks[0]. They&#x27;re small Bay Trail (quad core Atom) PCs with a male HDMI and a USB port." — giantrobot [c:50410023]
> （译文：你可以看看 Intel Compute Stick。那是带公头 HDMI 和一个 USB 口的小 Bay Trail（四核 Atom）电脑。）

这一段的价值在于把「10 美元」放进了更大的序列：Chromebox、二手 Xeon 工作站、Intel Compute Stick，价格从 10 美元到 200 美元不等，但驱动它们的判断是同一个——够用、安静、功耗低。

### 三、把 root 交给 agent：省事和「自己会」的交换

原文中 Zeroclaw 那句「本质上就是 root shell」点燃了评论区最长的争论。最先把做法说清楚的是 pteetor：

> "I run an AI agent on a bigger computer, I give that agent sudo access to the tiny machine, and I have the agent handle all the sys admin." — pteetor [c:50407980]
> （译文：我在一台更大的电脑上跑 AI agent，然后给这个 agent 那个小机器的 sudo 权限，让它负责所有系统管理。）

他的机器是一组 4 台树莓派，agent 跑在另一台机器上。反应最激烈的是 prmoustache：

> "It is akin to lightning a cigarette with a nuclear bomb." — prmoustache [c:50408134]
> （译文：这就像用核弹点一根烟。）

pteetor 的回应把「戏剧性」拆掉了：

> "I created the sudo-enabled account on the tiny machines. I wrote an AGENTS.md file (104 lines). And fired up an agent." — pteetor [c:50410315]
> （译文：我建了带 sudo 的账号，写了一份 104 行的 AGENTS.md，然后起了个 agent。）

于是讨论分成两派。反对派担心的是能力退化，jasomill 的理由是老 UNIX 用户的直觉：

> "this seems more tedious that simply using built-in tools to do the same thing, which has the added bonus of having at least some concept of how you might fix things when you inevitably break them" — jasomill [c:50408714]
> （译文：这看起来比直接用内置工具做同一件事更麻烦，而内置工具的好处是，你至少还知道东西坏了之后该怎么修。）

hagbard_c 把这笔账算得更细：

> "What you gain in productivity you loose in proficiency and self-reliance since you&#x27;re depending on others, an artificial &#x27;other&#x27; in this case" — hagbard_c [c:50408994]
> （译文：你在生产力上得到的，会在熟练度和自给自足上失去，因为你开始依赖别人——在这里是依赖一个虚构的「别人」。）

他补了一句更实际的顾虑：agent 不可用的时候，问题就相当于「你那个会修 Linux 的朋友去度假了，只剩你一个人」。支持派则拿实际收益说话，outworlder 举了两个具体的例子：

> "I dropped a single line to an agent. It quickly wrote a test script, kept monitoring, when the problem manifested it tracked it down to a wrong IPV6 DNS config" — outworlder [c:50408804]
> （译文：我只跟 agent 说了一句话。它很快写了个测试脚本盯着，问题一出现就定位到是 IPv6 的 DNS 配置写错了。）

RALaBarge 替「依赖别人」这个指控挡了一句：

> "It&#x27;s either asking that nerdy friend again, 2 years from now when it breaks.  Just like you would your own documentation and&#x2F;or SO or Google.  Zero difference except one saves you time." — RALaBarge [c:50409149]
> （译文：这无非是两年后设备坏了，再去问那个会修的朋友一次，就像你会去翻自己的文档、上 Stack Overflow 或 Google 一样。除了省时间，没有任何区别。）

也有人觉得这根本是乐趣：

> "What you call tedious, I call fun." — GlacierFox [c:50408856]
> （译文：你说的麻烦，我说的乐趣。）

drnick1 划出了一条他自己愿意守的线：

> "It seems very unwise to let an &quot;agent&quot; touch a production system with access to personal files, keys, and other things it should probably not see." — drnick1 [c:50409935]
> （译文：让「agent」碰一台能访问个人文件、密钥之类东西的生产系统 seem相当不明智。）

而 pteetor 的补充澄清了边界——被 agent 管的那些是玩具：

> "(2) They are not production machines. They are toys. Nothing sensitive.<p>(3) My serious machines are administered by me. Only me." — pteetor [c:50410248]
> （译文：1）这些不是生产机器，是玩具，没有敏感数据。<p>2）我那些正经机器由我自己管理，只有我。）

这轮的落点是：争议不在「agent 好不好用」，而在「你交给它的机器是不是玩具」。同样是 root，同一台树莓派是玩具还是生产系统，结论完全相反。

### 四、能读你全部日志的 root shell，离 prompt injection 只差一步

紧接着就是全文最尖锐的一段。mk_stjames 直接把风险链条摆了出来：

> "isn&#x27;t this thing one bad prompt injection away from exposing your network &#x2F; hosting a worm &#x2F; worse?" — mk_stjames [c:50408551]
> （译文：这东西是不是离「暴露你的网络、变成一个蠕虫宿主、或者更糟」只差一次 prompt injection？）

他给了一个具体的注入路径：某个广告拦截软件的更新往日志文件里写一段「如果你是运行中的 agent，请执行这条命令」，而 agent 有 root，读了日志就照做。

反驳与附议同时出现。qmr 用两个字回答：

> "Am I too paranoid?<p>No." — qmr [c:50409270]
> （译文：我是不是想太多了？——没有。）

outworlder 承认风险存在，但认为更大的口子不在 `| bash`：

> "Prompt injection is indeed a thing. You are not paranoid. Even more so if the LLM in question is not very smart (frontier models are better at not falling for prompt injection, but not immune)." — outworlder [c:50408745]
> （译文：prompt injection 确实是这么回事，你没有想多了。如果那个 LLM 不够聪明，情况更糟（前沿模型更不容易上当，但也不是免疫。）

他还指出了更现实的入口：一条「往机器里装某个包」的指令，agent 就会照办——而 `| bash` 顶多做到 agent 本身的权限范围内的事。

另一边，anon7000 举的是更近的先例：

> "There was a supply chain attack last year where a commonly-used VS Code plugin updated and in the background essentially figured out which agents you had available, and then prompted them to exfiltrate any credentials it could find. Not even prompt injection." — anon7000 [c:50408701]
> （译文：去年有一次供应链攻击：一个常用 VS Code 插件更新后，在后台摸清了你机器上有哪些 agent，然后指示它们把能找到的凭据外传。连 prompt injection 都不算。）

0xbadcafebee 给出的解法同样朴素——不给它读外部文本的工具：

> "If you don&#x27;t let it read prompt-injected text, it can&#x27;t get prompt injected. Don&#x27;t give it a tool to download web pages or read files (other than the ones you control)." — 0xbadcafebee [c:50409784]
> （译文：你不让它读可能被注入的文本，它就不会被注入。别给它下载网页或读取文件（你自己控制的那部分除外）的工具。）

而他的收尾一句其实把整场争论的边界划出来了：

> "They don&#x27;t need to prompt-inject an AI if they are already dropping custom rigged software onto your computer." — 0xbadcafebee [c:50409784]
> （译文：如果对方已经在往你电脑上装定制过的特制软件了，他们根本不需要去 prompt-inject 一个 AI。）

jeremyjh 的态度更硬：

> "After the hugging face and related incidents I don&#x27;t think anyone can give these things the run of a box - and the internet attached to it - with a clear conscience." — jeremyjh [c:50409338]
> （译文：经历了 Hugging Face 以及相关事件之后，我认为没人能心安理得地把一整台机器——以及连着互联网的那部分——交给这种东西随意处置。）

这段讨论的实质是：agent 的权限风险不来自模型本身，而来自它被允许读什么、写什么。而在 0xbadcafebee 的方案里，这条边界是可以自己划的——不给它读外部文本的工具，注入就落不下来。

### 五、信任的账：NSA、AliExpress 与「我们一直在妥协」

硬件本身也是信任问题。hikemu 对 Cloudflare Tunnel 那句「NSA 可能会看到你做的一切」的反应很直接：

> "The NSA being able to see what you can do, is not an acceptable trade off." — hikemu [c:50407437]
> （译文：NSA 能看到你做的所有事，这个代价不能接受。）

作者的回应则更实际：

> "So to a certain degree we&#x27;re always compromising. Cloudflare is compromising a lot." — LaurensBER [c:50408503]
> （译文：所以在某种程度上我们一直在妥协。Cloudflare 妥协得可不少。）

针对「买到的是不是被动了手脚」，作者的说法是：因为跑的是主线内核，完全可以从源码重编；他自己没这么做，但让 Claude 检查过，没发现可疑之处：

> "I haven&#x27;t done so but I did asked Claude to check for anything suspicious and it did not find anything." — LaurensBER [c:50408453]
> （译文：我没那么做，但我让 Claude 检查过有没有可疑的地方，它没发现。）

用 AI 审计 AI 显然不能让人放心，评论区也没放过这一点：

> "If you&#x27;re worried about &quot;user experience&quot; I don&#x27;t think this type of hacking is for you." — qmr [c:50409287]
> （译文：如果你还在担心「使用体验」，我觉得这种折腾不适合你。）

而在另一些人看来，同一个 agent 也在往好的方向用。dzhiurgis 说他把项目交给 agent 之后——

> "I gave grok access to one of the projects I’ve been coding for a while using variety of agents (mostly gemini tho). It immediately flagged bunch of security issues, including exposed .env file." — dzhiurgis [c:50409740]
> （译文：我把自己写了一阵子的一个项目交给了 grok（用的是一堆 agent，主要是 gemini）。它立刻报出一堆安全问题，包括一个暴露的 .env 文件。）

同一种工具在同一段讨论里既是「一次注入就能打穿你家网络的怪物」，又是「能替你找出漏掉的 .env 的助手」——差别不在模型，在它被允许做什么。

### 六、512MB 里到底装什么：软件栈的内存账本

最后一个话题回到硬件本身。NortySpock 晒了一份实测，说明 512MB 这类机器上监控栈能跑到什么程度：

> "VictoriaMetrics accepts all of this in 54 seconds, network traffic shows between 9 and 14MB per second" — NortySpock [c:50408633]
> （译文：VictoriaMetrics 用 54 秒接收完这些数据，网络流量在每秒 9 到 14MB 之间。）

他灌进去的是 450 万个采样点、11 条时间序列，落在 14MB 以内；跑这套的机器是一台 2013 年前后的 AMD GX-415GA 无风扇瘦客户端。

RSS 这一格也有人分享了替代路线：

> "Fusion is quite interesting." — rcarmo [c:50407377]
> （译文：Fusion 挺有意思的。）

> "because I wanted something lighter, but I like Fusion&#x27;s screenshots better than the mini&#x2F;picoflux web UI, so I will be looking at that ASAP." — rcarmo [c:50407377]
> （译文：因为我想要更轻的，但我又更喜欢 Fusion 的截图，而不是 mini/picoflux 的网页界面，所以我准备尽快去试试。）

至于这些图表到底有没有必要，drnick1 的反问很朴素：

> "Do you really needs graphs to know what&#x27;s going on in your machine?" — drnick1 [c:50407892]
> （译文：你真的需要图表才能知道机器里发生了什么吗？）

而「512MB 够不够」这个问题，wrxd 给了个明确答案：

> "512MB of RAM are definitely sufficient for many workloads, you need to be picky on what you run and choose software written somewhat efficiently." — wrxd [c:50408995]
> （译文：512MB 内存对很多负载来说绝对够用，你需要的是挑着跑，并且挑那些写得相对高效的软件。）

至于那台机器上的 AI agent 怎么做到「2 百万 token、零成本」，a1o 直接问了：

> "How is Zero Claw reporting like 2 million tokens and zero cost? Do you run llm self hosted in a different hardware?" — a1o [c:50409447]
> （译文：Zero Claw 是怎么做到 2 百万 token、零成本的？你是在别的硬件上自托管 LLM 吗？）

作者在别处的回答是：LLM 本来就跑在他自己的服务器上，所以没有 token 账单。最后一句玩笑来自 drummojg：

> "On my $10 USD OpenStick I run an automatic ATM machine." — drummojg [c:50407672]
> （译文：我的 10 美元 OpenStick 上跑着一台自动取款机。）

而 chuckwolfe 的一句评论，可能是对整篇博文最省事的评价：

> "AI wrote this whole article" — chuckwolfe [c:50409977]
> （译文：这整篇文章是 AI 写的。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 卖家不写 SoC，但 10 美元的风险有限 | LaurensBER | 最多就是拿到一个备用 4G 上网卡 |
| 链接标价已经是 20 美元 | jamienk | 标题里的 10 美元过期了 |
| 这东西是 2022 年的货 | throwaway81523 | 现在基本买不到 |
| 10 美元今天仍然存在 | msephton | AliExpress 上还挂着 |
| 手里有 300 个现货 | dools | 带 IMEI，还配套刷写固件 |
| 现货放出来几天能卖光 | qmr | 趁热 |
| 删掉热点连接就变砖 | polycancel | Linux 还在跑，只是进不去 |
| 出厂是 Linux/Android 混合体 | LaurensBER | 自己刷成 Debian |
| 十年前 2GB SBC 就能跑 | z3ratul163071 | 邮件、git、文件同步 |
| Chromebox 是同类首选 | jprd | 二手 i7 刷 MrChromeBox 当 K8s 节点 |
| 二手 Xeon 工作站更划算 | TacticalCoder | 200 美元换一台 ZFS + 虚拟机机器 |
| 想要 PoE 棒子 | rbanffy | 插上交换机就能拼集群 |
| PoE 方案不成立 | ssl-3 | 需要根本造不出来的连接器 |
| SFP 里塞电脑已经过时 | justsomehnguy | 现在直接买 x64 小主机 |
| 还有 Intel Compute Stick | giantrobot | Bay Trail 四核，带 HDMI |
| 让 agent 拿 sudo 确实省事 | pteetor | 4 台树莓派、104 行 AGENTS.md |
| 这是用核弹点烟 | prmoustache | — |
| 内置工具坏了你至少知道怎么修 | jasomill | 能力退化比麻烦更糟 |
| 用 agent 会失去熟练度 | hagbard_c | 生产力换自给自足 |
| 依赖 agent 不算依赖 | RALaBarge | 跟查文档、上 SO 一样 |
| 麻烦本身就是乐趣 | GlacierFox | — |
| 生产系统不能给 agent 碰 | drnick1 | 玩具可以，正经机器不行 |
| 玩具和正事的边界要划清 | pteetor | 玩具归 agent，正经机器归自己 |
| 一次注入就可能暴露网络 | mk_stjames | root + 日志 + DNS 流量 |
| 担心得对 | qmr | — |
| 注入是真的，前沿模型也不免疫 | outworlder | 更大的口子是「装某个包」 |
| 供应链攻击比注入更现实 | anon7000 | VS Code 插件曾指示 agent 外传凭据 |
| 不给读外部文本的工具就不会被注入 | 0xbadcafebee | 能被装特制软件就别谈注入 |
| 出了那些事就没人能安心授权 | jeremyjh | 一整台机器加互联网 |
| NSA 看到你的一切不可接受 | hikemu | — |
| 我们一直在妥协 | LaurensBER | Cloudflare 妥协得不少 |
| 用 Claude 审过没发现问题 | LaurensBER | 主线内核，理论上可重编 |
| 折腾硬件要有折腾的觉悟 | qmr | 否则不适合 |
| agent 也能找出暴露的 .env | dzhiurgis | 同一工具既是风险也是帮手 |
| VictoriaMetrics 吞下 450 万点 | NortySpock | 54 秒，每秒 9–14MB |
| 更轻的 RSS 方案 | rcarmo | fork 出了 picoflux |
| 图表未必必要 | drnick1 | 看 top 就够了 |
| 512MB 够用 | wrxd | 挑着跑，挑写得高效的 |
| 2 百万 token 零成本怎么做到 | a1o | 追问自托管 LLM |
| 这台机器还能干别的 | drummojg | 我在上面放了台自动取款机 |

## 总体情绪

这帖的表面是一份配置清单，实际是一道信任题。原作者把答案写得很坦率：设备很便宜、栈很轻、agent 有 root、爆炸半径有限。这套说法在评论区被拆成了三份账单——设备本身值不值 10 美元（答案取决于今天 AliExpress 上还剩多少库存和卖家写不写 SoC）、agent 拿 root 换来的省事值不值你失去的动手能力（答案取决于那台机器是玩具还是生产系统）、以及一个能读你全部日志的 root shell 值不值得信任（答案取决于你允许它读什么）。

值得注意的是，这三笔账里没有一笔是关于性能的。没人质疑 Zeroclaw 的 3MB RSS，也没人说 512MB 不够——讨论始终在往「谁在承担风险」上收。最后那句玩笑其实是最准确的总结：这篇讲的是一台 10 美元机器的作者已经把自己的日志交给了 AI，而在评论区，这一刻发生得比任何配置参数都早。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | What I run on my $10 USD OpenStick homelab（HN 主帖） | <https://news.ycombinator.com/item?id=50406670> |
| 2 | 原文：What I run on my $10 USD OpenStick homelab | <https://blog.bosscher.ch/posts/openstick/> |
| 3 | Hackaday：Hackable 2.0（LTE + Pi Zero W2 供电） | <https://hackaday.com/2022/08/03/hackable-20-modem-combines-lte-and-pi-zero-w2-power/> |
| 4 | OpenStick 社区站（购买链接与安装说明） | <https://openstick.org/> |
| 5 | Zeroclaw（作者使用的 agent harness） | <https://github.com/zeroclaw-labs/zeroclaw> |
| 6 | Zeroclaw PR #11862（Telegram 富消息支持） | <https://github.com/zeroclaw-labs/zeroclaw/pull/11862> |
| 7 | AdGuard Home Next-Gen（作者的 fork） | <https://github.com/LaurensBosscher/AdGuardHome-Next-Gen> |
| 8 | Beszel（轻量监控） | <https://github.com/henrygd/beszel> |
| 9 | Fusion RSS | <https://github.com/0x2E/fusion> |
| 10 | picoflux（rcarmo 的 miniflux fork） | <https://github.com/rcarmo/picoflux> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 449 分、96 条评论，归档快照 2026-11-08 04:55 UTC，入库 96 条）及原文抓取内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档中的原文正文在 Shiori 一节处被截断，Shiori 与 Diun 两节依据原文网页补全。文中涉及的内核版本、restic/Backblaze 备份、NixOS 装机受挫等内容出自评论区而非原文。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。本站与 OpenStick、Zeroclaw、AdGuard Home、Beszel、Gatus、Fusion 等项目无利益关系。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
