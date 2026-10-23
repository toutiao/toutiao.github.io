---
layout: post
title: >-
  Switch 2 被越狱了：Codex 找到整数溢出，Amazon 蓝牙灯开关负责按电源
date: 2026-10-23
hn_id: 50192536
categories: [articles]
excerpt: >-
  越狱 Switch 2 的入口是一款 25 美元的 BASIC 解释器，真正的活儿是两条溢出路径：
  数组删除时的 32 位整数回绕，加上 fs 里 0x301 字节的路径规范化缓冲区。而按下电源键的那个执行器，
  是从 Amazon 上买的蓝牙灯开关。
tagline: >-
  一条 memmove 越界读取，一个 25 美元的游戏，一个从 Amazon 寄来的灯开关。
---

## 原文概要

pepsipu 在博客里放出了 `ns2jb`——作者所知范围内，Switch 2 的第一个越狱，**纯软件、但 tethered（需要连着主机）**。它能做到的事情包括：以任意普通 sysmodule 的身份运行原生代码、以内置 fs sysmodule 的身份运行原生代码、跑 homebrew、逆向和改 Switch 2 游戏、备份存档、通过 MMIO 访问大部分外设。

演示用的作品是让 Codex 改了一款 Switch 2 独占游戏 **Mario Kart World**，加进了 cinnamoroll、red 和 tole tole 三名角色。角色是 Dabney House 的朋友们帮忙挑并试玩的。

整条路线的物理部分很有画面感：作者为 Switch 1 和 Switch 2 各搭了一套实验台，用两台 JetKVM 通过 USB 发手柄输入、通过 HDMI 回视频流；而 Switch 2 一旦崩溃需要按键重启，电源键怎么按？答案是从 Amazon 买来的蓝牙灯开关——拉杆压下时按下电源键，压到底之后开关自身的扭矩再把机构顶起来。博客里那句被无数人转发的说明就是："Switch 2 在 Switch Flicker 的帮助下被越狱了。"

技术路线比物理部分更值得看。Codex 一上来选了 WebKit 这个主机越狱的标准目标，通过自建 Wi-Fi 热点投放一个 WebKit 的 n-day，声称拿到了"原生控制流劫持"。但这条路被三道防线堵死：WebKit 有 XOM（执行-only 内存），即便拿到任意读写也不知道 gadgets 在哪；`PAC` 让签名指针难以构造；`CFI` 又对调用点做类型检查。作者把它标为"侧注押注"，重置了目标。

转机来自作者自己的思路：去攻击 Switch 1 的游戏。两个理由——Switch 1 不支持 `PAC`，而且 Switch 1 的信任根已被拿捏，可以直接解密代码阅读。具体目标是 **SmileBASIC**，因为它在 3DS 上已经被 `smilehax` 破过一次，而且那是个巨大的 C++ 代码库。Codex 在 BASIC 解释器里找到一个 32 位整数溢出：执行 `REMOVE R, &H60000000, &H3FFFFFFF` 时，`position + count` 回绕成 `0x9fffffff`，作为有符号 32 位整数它小于数组长度，检查被绕过，随后那次 `memmove(backing, backing - 8, 32)` 把数组前面 8 字节拖了进来。命令虽然报了 out of memory 错误，但拷贝已经发生。关键在于 SmileBASIC 里任何数组前面恰好 8 字节存着一个指向数组自身的指针，于是 `R[0]` 会把数组底层内存当成字符串来读，长度字段是个巨大的指针值——越界读写就到手了。

从用户态 ROP 到内核态，走的是内置 fs sysmodule：`IFileSystem` 句柄的 IPC 命令 `GetEntryType` 会用 `Path::Normalize` 规范化路径，而带反斜杠的父目录成分（形如 `/..\`）会走进一个分配 0x301 字节临时堆缓冲区的辅助函数，路径却可以比缓冲区长。Codex 找到 `BufferedStorage` 对象里那个为文件分配的缓存项：脏位置 1 时读写会跟随一个指向缓存数据的指针，改掉它就得到任意读写。接着作者在内存里找到 SmileBASIC 的连接对象，把保存的 PID 改成 1，进程直接拿到 `FullPermission`，把内部存储和所有普通 sysmodule 的代码全部 dump 出来交给 Codex 做离线分析。

剩下的结论是：dump 里唯一有权限映射可执行内存的普通 sysmodule 是 `ro`。整篇文章最后的注解是作者那句澄清——"set a goal to jailbreak the switch 2. make no mistakes"只是个搞笑标题，他实际设的 `/goal` 是用户态代码执行，没成功；越狱本身花了大约两周，而那个 Mario Kart 改造是一天 vibecode 出来的纯玩票。

## 讨论焦点

### AI 到底出了多少力：帖子先写成了分歧题

讨论从第一层就开始错位：多数人先处理"这是不是 AI 干的"这个问题。

> "i think it's really neat how modern tooling (the KVMs, bluetooth light switch flicker, and usb controller support out of the box) enables this level of automation." — KeplerBoy [c:50193712]
> （译文：我觉得很有意思的是，现代工具（KVM、蓝牙灯开关、开箱即用的 USB 手柄支持）让这种程度的自动化成为可能。）

这条评论刻意把"AI 和人各占多少功劳"这个显眼话题先放在一边，转而讨论实验台。也有人没打算绕开：

> "I suppose we can let AI write the entire blogpost :)" — amelius [c:50193987]
> （译文：我猜我们可以让 AI 把整篇博客也写了 :)）

> "please point me to an LLM that can write like that without extensive handholding" — monegator [c:50195397]
> （译文：谁能给我指一个不需要大量手把手引导、就能写出这种东西的 LLM？）

另有读者直接下判断："这明显是人写的。"两种读法最后被同一句话收住：

> "Also what's 2 weeks of real work (in tandem with an agent) compared to a few hours for the blog?" — KeplerBoy [c:50194046]
> （译文：而且，和博客那几小时相比，和 agent 并行干的两周真实工作量算什么？）

值得注意的是博客本身已经提前做了澄清：作者明说那句 prompt 是搞笑标题，越狱靠两周手工努力，Mario Kart 改造才是一天 vibecode。但社区还是先吵了一圈分工——这大概说明"作者自证"在读者心里并不生效。

### 入口是一款 25 美元的游戏

> "It's unfortunate that this requires a specific $25 game (SmileBASIC 4)" — Velocifyer [c:50193992]
> （译文：遗憾的是，这需要一款特定的 25 美元游戏（SmileBASIC 4）。）

这条不满马上被当成惯例辩护：

> "It turns out that opening locks is a hell of a lot easier when you have a key." — unrented7977 [c:50194187]
> （译文：事实证明，手里有一把钥匙，开锁就容易得多。）

> "Though Nintendo has been stripping down the OS every new console so there's less interesting stuff to exploit outside of games." — Gigachad [c:50194012]
> （译文：不过任天堂每代主机都在削减 OS，所以游戏之外能下手的地方也越来越少。）

真正的后续收益也被点出来了——这份越狱最重要的副产品不是越狱本身，而是它 dump 出来的代码：

> "This gives visibility to a lot more unencrypted code, so just give it time. More bugs will be found quickly now that the code is inspectable." — StilesCrisis [c:50194150]
> （译文：这让大量未加密代码变得可见，给点时间吧——代码现在可被审阅了，会有更多 bug 很快被找到。）

门槛还有更省事的绕法：注册日区账号下载试玩版即可，不必买整份游戏。

### 给 agent 装上手和眼睛：这才是帖子的真正主角

评论区最热烈的一支完全不谈越狱，谈的是实验台本身。

> "Giving LLMs arms and eyes via KVM (or webcam) is a very strong paradigm for this sort of hardware work, as it allows things to be parallelised and run 24/7." — hturan [c:50194001]
> （译文：通过 KVM（或者摄像头）给 LLM 装上手和眼睛，对这类硬件工作是非常强的范式，因为它让事情可以并行、可以 24 小时运转。）

一堆读者当场分享自己搭的台子。一位在公司的 IoT 项目里给 agent 当"实验室里的手"：

> "I'm working on a IoT device at work and have been the "hands in the lab" for my agent this week." — gcoakes [c:50194252]
> （译文：我这周在公司做一个 IoT 设备，担任我那个 agent 的"实验室里的手"。）

他卡在反复拔插 SD 卡做故障注入上，评论区当场给出方案：在 SD 卡和被测设备之间串一级电平转换器、用 MCU 控制它通断，或者 3D 打印一个夹具加一个廉价 RC 舵机。有人的方案更糙也更有效：

> "Janky setup with two ESPs for the serial terminal and to control a servo taped to some microswitches to power cycle the board." — hgoel [c:50195568]
> （译文：土味配置：两个 ESP，一个接串口终端，另一个控制一个舵机，舵机上贴着微动开关给板子断电重启。）

还有人把这套做法搬到了别的领域——用 Claude 给树莓派做 osdev，用 `usb4vc` 当手、用 HDMI/VGA 采集卡当眼睛、用一个老 Wemo 开关负责开关机和重启、用 ftp/appleshare 传文件，再让 Claude 写了个 `vcctrl` 把这些串起来，配 MCP、skills 和 webkvm。结论被总结成一句：

> "I bet we'll see more KVM-for-X type products appearing, basically multiplexers for various storage devices and peripherals, as ways of giving agents control over them." — mikepurvis [c:50197859]
> （译文：我猜以后会冒出更多"KVM 化的 X"产品，本质上是各种存储设备和外设的多路复用器，用来把控制权交给 agent。）

### 赏金该给谁：一个没人预料到的问题

> "Worth noting too that this would have easily fetched >$50k via Nintendo's HackerOne" — hturan [c:50194001]
> （译文：另外值得一提，凭这个走任天堂的 HackerOne 轻轻松松能拿到 5 万美元以上。）

有人按分类纠了数字：

> "More like $30k, no ("system processes allowing piracy")?" — TuxSH [c:50194134]
> （译文：更像是 3 万美元吧，而且不是"允许运行盗版进程"那个类别的？）

然后有人问了整场讨论里最扎人的一句：

> "Who gets the bounty money in that case? By the looks of the article, Codex did all of the work actually finding a bug. Shouldn't the money go to OpenAI?" — voidUpdate [c:50194333]
> （译文：那种情况下赏金归谁？看文章的意思，找 bug 这部分实际全是 Codex 干的，钱不该归 OpenAI 吗？）

回复只有一句，但把整件事的性质说清了：

> "The person running it obviously. How is that even a real question? Since when did an AI lab have the right to anything a paid user generated?" — TaLiTr [c:50194856]
> （译文：当然是跑它的那个人。这也算个问题？AI 实验室从什么时候起有权支配付费用户产出的东西了？）

讨论里另一条被广泛引用的注释也指向同一个方向：与其担心 Nintendo 派律师函，不如想想这次破解到底算不算"安全漏洞"。多数读者的判断是，等价于 Switch 1 时代密钥材料泄露那一类，而不是 bootROM 级别的 PSC 漏洞。

### Game Key Card：越狱之外最长的分支

评论区的第二大分支和破解毫无关系，是 Switch 2 的 Game Key Card。

> "Game keycards keep the appearance of physical ownership without delivering what people expect from a cartridge." — _imnothere [c:50193988]
> （译文：游戏钥匙卡保留了实体拥有权的样子，却没有交付人们对卡带所期待的东西。）

反对这个批评的人不少：卡带本身仍然可以二手转卖，省下的是出厂就过时的那些容量，成本上的赢家；而且在首发补丁成为常态之后，卡带上的游戏本来也未必开箱即玩。最扎到点上的一句是：

> "I think the point is that X years from now, when the servers are turned off, you don't actually have the game." — drdexebtjl [c:50195283]
> （译文：我觉得重点是：X 年以后服务器关停时，你其实并没有那个游戏。）

数字被另一位读者摆了出来：

> "The game ends up taking a lot more storage space as updates are usually tiny when compared to the base game. For reference, the Switch 1 version of Zelda Tears Of the Kingdom takes 16 GB while the latest update takes only 500 MB." — bilkow [c:50195640]
> （译文：游戏最终占用的存储空间要大得多，因为更新相对本体通常很小。举个例子，Switch 1 版《塞尔达传说：王国之泪》本体 16 GB，而最新更新只有 500 MB。）

另一支则把成本直接算到了 AI 头上：

> "Game key cards are cheaper to make because normal cartridges with the full game cost a fortune right now. And guess why? AI data centers buying up all the memory chips." — roli64 [c:50194853]
> （译文：游戏钥匙卡更便宜，是因为现在装完整游戏的普通卡带贵得离谱。猜猜为什么？AI 数据中心把存储芯片全买走了。）

而保存问题上的分歧点其实一致：反对者不否认服务器关停后的损失，只是认为实体媒介早已不再提供这种保障。

> "Official physical media has not been a reliable method for future accessibility for at least a decade now. It's way past time to start using other methods of preservation." — coldpie [c:50195721]
> （译文：至少十年以来，官方实体媒介都不是可靠的未来可访问性方案。是时候彻底转向别的保存方法了。）

### 破解之后会发生什么：dump 还是重编译移植

> "If this is true decrypted `fs` r/w, I wouldn't be surprised if we start seeing Switch 2 game dumps appear in a few hours." — hturan [c:50194001]
> （译文：如果这个 `fs` 读写解密是真的，我不惊讶几小时内就开始出现 Switch 2 的游戏 dump。）

这条预测下面立刻分叉成两种未来。短期的判断是"盗版存在但不影响 Steam 销量"这个论点还撑得住：

> "Long term when someone makes emulating Switch 2 on your Steam Deck a 1-click install I'm not so sure." — mentos [c:50194044]
> （译文：长期来看，当有人把 Switch 2 模拟器做成 Steam Deck 上一键安装的时候，我就不确定了。）

而路径可能不是模拟：

> "More likely to happen via recompilation, if anything." — lsbussell [c:50195400]
> （译文：如果真会发生，更可能走的是重编译这条路。）

因为近一个月重编译移植一路做到了 PS5 和 Switch 1 那个年代，开销远低于模拟。反过来也有人把这看成任天堂的硬件销量问题：先看到 Switch 2 游戏跑在别的设备上，而不是先看到本机上跑盗版的 CFW/加解密栈。

### HN 用户不是任天堂的目标客户

这个线程里出现频率最高的一个判断，是关于"谁会去用这些东西"的自我认知：

> "Internet nerds like us aren't really Nintendo's target market, I don't think." — joenot443 [c:50194288]
> （译文：我觉得像我们这样的互联网 nerd 并不是任天堂的目标市场。）

> "It's dangerous to form world views based on "What HN thinks"." — glimshe [c:50194738]
> （译文：拿"HN 怎么想"去形成对世界的看法是很危险的。）

支撑这个判断的是销量：

> "According to wikipedia, they sold over 23 million units of the switch 2 and over 155 million of the switch." — nope1000 [c:50194330]
> （译文：根据维基百科，Switch 2 销量超过 2300 万台，Switch 超过 1.55 亿台。）

反驳也各有各的角度：有人提醒 PSP 时代的教室里人手一台破解机，破解机销量远超游戏销量；有人说家里小孩要玩的是 Minecraft 而不是别的，所以锁死反而受欢迎；也有人承认偏爱触摸屏、便携和实体手柄这些体验是模拟换不来的，并顺带承认自己这套判断不适用于每个读者。最简短的一个提醒是：

> "all it takes is 1 TikTok trend" — doctorpangloss [c:50195072]
> （译文：只要有一条 TikTok 潮流就够了。）

### 那个按电源键的灯开关

最后回到最有记忆点的硬件细节：

> "The Switch 2 jailbroken with the help of a Switch Flicker. Really funny." — xacky [c:50193991]
> （译文：Switch 2 是在 Switch Flicker 的帮助下被越狱的。真有意思。）

> "The flicker in question is switchbot, I have plenty of them I use for.. things." — tamimio [c:50194539]
> （译文：这里说的 flicker 是 switchbot，我有一堆，拿来干……某些事情。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|---------|
| 功劳先不谈，工具链才是重点 | KeplerBoy | KVM 加灯开关加开箱手柄，才让这种自动化成立 |
| 博客该交给 AI 写 | amelius | 我猜我们可以让 AI 把整篇博客也写了 |
| 肯定是人写的 | monegator | 哪个 LLM 不需要手把手就能写出这种东西 |
| 两周真活 vs 几小时博客 | KeplerBoy | 和并行的两周相比，博客那几小时算什么 |
| 入口游戏是门槛 | Velocifyer | 需要一款特定的 25 美元游戏 |
| 这是主机破解的老规矩 | unrented7977 | 手里有钥匙，开锁就容易得多 |
| OS 越做越薄 | Gigachad | 游戏之外能下手的地方越来越少 |
| 真正的收益是 dump | StilesCrisis | 代码可审阅了，会有更多 bug 很快被找到 |
| 试玩版就够了 | haunter | 不必买游戏 |
| 给 LLM 装手和眼是强范式 | hturan | 可以并行，可以 24 小时运转 |
| agent 需要的是手 | gcoakes | 我这周在公司给 agent 当实验室里的手 |
| 自动化每次都赢 | mosura | 自动化永远赢，每一次 |
| 也可能翻车 | esseph | 未知的故障模式会让人瞬间把事情搞砸 |
| 台子造一次就够 | Crosseye_Jack | 自动化只需搭一次，之后每个项目复用 |
| 会冒出通用产品 | mikepurvis | 会出现更多"KVM 化的 X"，把控制权交给 agent |
| 赏金该归 OpenAI | voidUpdate | 找 bug 的活实际全是 Codex 干的 |
| 钱归跑它的人 | TaLiTr | AI 实验室什么时候有权支配付费用户的产出了 |
| 赏金没 5 万 | TuxSH | 更像 3 万，而且不属于那个类别 |
| 钥匙卡只是外观 | _imnothere | 保留了实体的样子，没交付卡带该有的东西 |
| 服务器关停才致命 | drdexebtjl | 多年以后服务器一关，你其实并没有那个游戏 |
| 存档才是大头 | bilkow | 王国之泪本体 16 GB，最新更新只有 500 MB |
| 实体媒介早已不可靠 | coldpie | 至少十年了，早该换别的保存方法 |
| 卡带变贵是 AI 的锅 | roli64 | 数据中心把存储芯片买走了 |
| 短期销量不受影响 | mentos | "盗版不影响 Steam 销量"短期仍成立 |
| 长期看一键模拟器 | mentos | 等模拟器变成 Steam Deck 上一键安装就不一定了 |
| 未来是重编译 | lsbussell | 更可能通过重编译发生，开销远低于模拟 |
| HN 不是目标市场 | joenot443 | 像我们这样的人不是任天堂的目标客户 |
| 别拿 HN 当民意 | glimshe | 拿 HN 的看法形成世界观很危险 |
| 销量摆在这里 | nope1000 | Switch 2 两千三百万台，Switch 一点五五亿台 |
| PSP 已经证明过一次 | gambiting |  PSP 时代同学里人手一台破解机 |
| 一条 TikTok 就够了 | doctorpangloss | 只要有一条潮流就够了 |
| 灯开关是真正的功臣 | tamimio | 这里说的 flicker 是 switchbot，我有一堆 |

## 总体情绪

这场讨论最整齐的一点，是几乎所有人在技术上都服气，在功劳归属上都不服气。文章把作者写得像个编剧，Codex 写成主角，于是每个读者都在重写分镜：一个说工具链才是真正的新东西，一个说两周手工才是真活，两个小时写出来的博客反而不像人写的。唯一没人争的是结果本身——两个整型溢出加一次 PID 改写，把一台没被公开破过的消费主机打开了。

第二个整齐的地方，是"这会不会让任天堂亏钱"这个问题被算得比想象中更实际。多数人的判断分成两派：技术派认为先出现的是 dump，重编译移植会比模拟更早把独占内容搬到别的硬件上；市场派认为 Switch 已经卖了两亿多台，真正会折腾的用户是极小的一批，多一个 TikTok 潮流就够改写这个前提。两派在"任天堂一直这么做也确实有效"这一点上没有分歧。

而这个帖子里最被低估的一句判断来自硬件细节：JetKVM 加蓝牙灯开关加开箱即用的 USB 手柄支持，把"让一个 AI 独立操作一台真实主机"这件事的搭建成本压到了几十美元。有人已经在 IoT、树莓派 osdev 和 DOS 移植上复制了这套做法，还有人指出成本论正在反转——"会冒出更多 KVM 化的 X，把控制权交给 agent"。作者那台需要人守着的实验台，正在变成一种可以照着复制的模板：越狱只是第一个用上它的项目。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Jailbreaking the Switch 2 | https://pepsipu.com/blog/2026-10-switch2-jailbreak-ns2jb/ |

---

<div class="disclaimer">
本文根据 Hacker News 热门讨论自动整理，不代表本站观点。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>