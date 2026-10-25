---
layout: post
title: >-
  他给自家三星电视刷出 root shell，然后 OpenAI 封了他的号 — HN 讨论摘要
date: 2026-10-25
hn_id: 50218633
categories: [articles]
excerpt: >-
  一台 2025 款三星电视，固件被 AES 加密，研究者用 AI 找到零日漏洞拿到 root shell，
  顺带发现电视会借你外接音箱的麦克风听狗叫。459 分、172 条评论，
  讨论分成两半：一半在算三星的账，一半在算 OpenAI 封号的账。
tagline: >-
  拿到 root shell 只要一个零日，把报告递出去却要过一遍内容安全审查。
---

## 原文概要

10 月 21 日晚上 9:06，X 上的研究者 @log4j 发了一条推文。全文不长，但每个词都在干活：

> i own a relatively new (2025) samsung tv. i kept getting weirdly targeted ads. i tried reversing the firmware but it was aes encrypted and no keys unless tear it apart and do uart/jtag magic. zero days it is. root shell on new samsung TVs! discovered PRIVACY HORROR. write up?

推文配了一张截图，120 万次浏览，407 条回复。整件事的技术链条是：他有一台 2025 年的三星电视，老是弹出精准广告；他去逆向固件，发现固件被 AES 加密，不拆机走 UART/JTAG 就拿不到密钥；于是他不走这条路，改走零日漏洞，在新三星电视上拿到了 root shell——推文里的原话是 "root shell on new samsung TVs!"，最后一句 "discovered PRIVACY HORROR"，再一句 "write up?"。报告还没写。

HN 上这条帖是 10 月 24 日由 testing22321 转贴的，标题取了推文里最硬的那半句：「Root shell on Samsung TV」，459 分、172 条评论。

而评论区在几小时之内补出了推文里没有的两件事。

第一件是「谁在听」。评论区有人引用了研究者自己另一条推文：型号不带麦克风的三星电视会去找连着的其他设备上的麦克风，比如 soundbar 或者蓝牙设备，采到的数据送给 Bixby。dog bark 和 baby crying 检测是 SmartThings 集成里明码标牌的功能，门铃声和敲门声也算在列。

第二件才是真正引爆讨论的：研究者用 AI 解密这堆固件数据的过程，撞上了 OpenAI 的账号封禁。评论区把他的号被封这件事复述了不止一次，理由写得很具体——"Cyber Abuse"。而他做的是拆自己的电视。

## 讨论焦点

### 一、推文很短，报告根本还不存在

最先把这个事实摆平的是 fdw：

> "The headline is misleading, but the \"article\" is only five screenshots of Twitter posts. Someone used AI to decrypt the Samsung TV's firmware and found always on listening, classification, lots of privacy nightmares. Then their (the hacker's, not Samsung's) OpenAI got suspended for \"Cyber Abuse\"." — fdw [c:50219877]
> （译文：这个标题有误导性，因为那篇「文章」不过是五张推文截图。有人用 AI 解开了这台三星电视的固件，发现了常开监听、分类识别，以及一堆隐私噩梦。然后被封号的，是那个黑客的 OpenAI 账号，不是三星的。）

wtch98 的抱怨指向同一个缺口：

> "They could have started with actually decrypting what was sent rather than a breathless 2 hours of monetised nonsense. Show me the http posts with the data that's actually sent." — wtch98 [c:50222631]
> （译文：他们本可以先把真正发出去的数据解密出来，而不是搞两小时让人喘不过气的流量生意。给我看看那些带着数据的 HTTP 请求。）

也就是说，到目前为止所有「隐私恐怖」的结论都还是推文里的断言，没有解密后的报文、没有抓包、没有可复现的步骤。有人补了一句更家常的背景：

> "He bought a whole bunch of TVs and he’s testing them right now. Check out his YT channel." — gessha [c:50220489]
> （译文：他买了一大堆电视，现在正在逐台测试。可以看看他的 YouTube 频道。）

### 二、谁在听：电视会借你音箱的麦克风

这部分细节是评论区里传播最广的，因为它足够具体。

tkel 直接引用了研究者自己的另一条推文：

> "if your samsung TV model doesnt have a microphone, it will look for connected devices with one, such as a soundbar or a connected bluetooth device. this gets shipped off to bixby." — tkel [c:50219120]
> （译文：如果你的三星电视型号没有麦克风，它会去找连着的其他设备上的麦克风，比如 soundbar 或者蓝牙设备。这些数据会被送到 Bixby。）

luma 补上了功能清单，这解释了很多人在评论区大惊小怪的原因：

> "Dog bark and baby crying detection are advertised features for SmartThings integrations. Door bell and door knocking are also included, this is surfaced directly if you hook the TV or sound bar into SmartThings." — luma [c:50219137]
> （译文：狗叫和婴儿哭的检测，是 SmartThings 集成里宣传的功能。门铃声和敲门声也包含在内；你把电视或 soundbar 接进 SmartThings 之后，这些功能就会直接显示出来。）

batrat 从自家那四台三星电视说起，把隐私之外的实际体感也倒了出来：

> "They are all advertised in the Smart Things app." — batrat [c:50223090]
> （译文：它们全都在 SmartThings 应用里写着。）

> "I hate 2 things about my samsung tv's (I have 4 only samsung): the simplistic remote and ads on home screen. Even with custom dns sometimes they get through." — batrat [c:50223090]
> （译文：我最恨我那几台三星电视的两点（我家里四台全是三星）：简陋的遥控器，还有主页上的广告。就算换了自定义 DNS，有时候广告还是能漏进来。）

一句评论把这事总结成了评论区最热的表情包：

> "I haven’t been able to sleep since I found out that Samsung knows my dog barks." — tiahura [c:50221250]
> （译文：自从知道三星知道我家的狗在叫，我就没睡着过。）

而早就买过「笨电视」的人，只留下三个字：

> "so glad i bought a dumb tv." — znpy [c:50219303]
> （译文：真庆幸我当时买了台笨电视。）

### 三、「PRIVACY HORROR」有多少水分

反对方最硬的一条，来自 pawelduda，他说他自己去查过：

> "I had to check this and it's true. Not saying Samsung or 3rd parties don't take advantage of any data they can collect, but the story the tweets tell is super biased against them. Here, the detection seems limited to specific pattens required for a particular feature." — pawelduda [c:50219521]
> （译文：我去查了一下，确实是真的。我不是说三星或第三方不会利用他们能收集到的任何数据，但这几条推文讲的故事对他们极度不公。这里的检测看起来只限于某个特定功能所需要的那几种模式。）

> "Still, calling it \"PRIVACY HORROR\" as per original post is typical twitter-style sensation seeking. It's an opt-in dog barking detection that causes local chip to listen for... dog barking" — pawelduda [c:50221812]
> （译文：不过，按原帖的说法把它叫成「PRIVACY HORROR」，典型的推特式猎奇。这是一项需要主动开启的狗叫检测，让本地芯片去听……狗叫。）

「用 Bixby 不就是这个功能吗」也是常见质疑：

> "Is this not the expected function when you use bixby?" — throwa356262 [c:50219221]
> （译文：你用 Bixby 的时候，这不是本来就该有的功能吗？）

但也有人指出这是全行业惯例，不是三星独有：

> "I'm curious if someone has started cataloging these cases. These spying TVs seem like a common industry practice." — Hugsun [c:50219107]
> （译文：我好奇有没有人开始把这些案例整理成册。这些会窥探的电视似乎是整个行业的普遍做法。）

### 四、真正让评论区炸开的，是那个被封的号

这一段撑起了评论区大半的火力，而且非常集中。

ada-h00k 的判断干脆：

> "If OpenAI really banned him for that reason, that would be pretty stupid. If you can no longer use an LLM for reverse engineering without worrying about your account, that drastically reduces its value." — ada-h00k [c:50219068]
> （译文：如果 OpenAI 真的因为这个理由封了他，那这事就挺蠢的。如果你在做逆向工程的时候还得担心账号被封，那 LLM 的价值就被大幅削减了。）

williamdclt 给了一个反驳角度，不是替 OpenAI 辩护，而是算账：

> "...for a niche of customers, from whom the revenue is probably entirely negligible to OpenAI. Not saying it's right, ethical or anything like that, but it's not \"stupid\"" — williamdclt [c:50220169]
> （译文：……对一小撮客户来说，他们带来的收入对 OpenAI 大概完全可以忽略。我不是说这事对、对得起伦理或者别的什么，但称不上「蠢」。）

tintor 的类比往生活层面推了一步：

> "This looks very bad on OpenAI." — tintor [c:50219099]
> （译文：这在 OpenAI 身上看起来非常难看。）

> "What is next? Power and water company suspending your account if your home and car are not streaming enough telemetry." — tintor [c:50219099]
> （译文：那接下来是什么？电力公司和供水公司因为你家和车上传的遥测数据不够多，就暂停你的账号。）

真正经历过这类误伤的人，给出了操作层面的经验。spockz 讲的是自己逆向 LG 固件去验证 GamersNexus 的说法时踩过的坑：

> "In my efforts to reverse engineer the LG firmware to validate Gamers Nexus claims, I got a warning very quickly." — spockz [c:50219456]
> （译文：当初我为了验证 GamersNexus 的说法去逆向 LG 固件，很快就收到了一次警告。）

他随即申诉，而且申诉成功了。此后他换了个做法：

> "Then I applied for daybreak blue and haven’t had any issues since." — spockz [c:50219456]
> （译文：后来我申请了 daybreak blue，就再没出过问题。）

> "It also a matter of phrasing. Say what you want to achieve not how if it is approaching defensive or cyber stuff. Also state you are working on your own devices and software. (If that is the case of course.)" — spockz [c:50219456]
> （译文：这也在于措辞。如果事情开始接近防御性或安全方向，就说你想达到什么目标，而不是怎么做。还要说明你研究的是自己的设备和软件（如果事实确实如此）。）

> "Yes a personal subscription. Individuals can also request it. only blue for defensive questions. Red for offensive is gated to organisations that are proven to be using it for protecting." — spockz [c:50220069]
> （译文：是的，个人订阅。个人也可以申请。只有蓝色（防御类问题）是对个人开放的；红色（进攻类）只对被证明是在做防护的组织开放。）

而误伤的反面案例更多。emdash 说的是另一个模型：

> "Claude is so absurdly bad about false triggers for security. It kept triggering when I asked it questions about how to plant some tree saplings I got because somehow that was a security risk. Anthropic is a joke of a company." — emdash [c:50222246]
> （译文：Claude 在安全类误触发上简直离谱。我问它怎么种自己拿到的树苗，它就一直拦，说不知怎么就成了安全风险。Anthropic 就是个笑话公司。）

LoganDark 的经历更荒诞：

> "I'm in the new CVP, and even Mythos gave me a cyber stop just for creating an MCP server that can remotely connect to my Steam Frame to run commands. It must've thought I was trying to create a centralized malware or something." — LoganDark [c:50220141]
> （译文：我在新的 CVP 里，连 Mythos 都给了我一个安全拦截，理由只是我创建了一个可以远程连到我的 Steam Frame 执行命令的 MCP 服务。它大概以为我在造什么集中式的恶意软件。）

### 五、那就换个模型：逆向这件事正在迁移

封号挡不住活，于是评论区很自然地转向了替代方案。

3abiton 的判断很直接：

> "Right now you can fairly do lots of reverse enginnering or \"hacking\" with off the shelf Chinese models, and they are very capable (GLM3 for example) which can be run locally if you stomach the hardware." — 3abiton [c:50219100]
> （译文：现在用现成的中国模型就能做不少逆向或者「黑客」的事了，而且它们相当能干（比如 GLM3），只要你能接受本地跑模型的硬件开销。）

locknitpicker 把这件事说得更大：

> "Chinese models don't need to stay open. The open weight ones just need to have nearly the same capabilities as the models sold by US companies. When that's the case, no one will have a reason to continue paying anything to any US company, thus destroying their business model and business case." — locknitpicker [c:50220735]
> （译文：中国模型并不需要一直保持开放。开放权重的那批只要做到能力接近美国公司卖的那些模型就够了。到那时，没人还有理由继续付钱给任何一家美国公司，它们的商业模式和商业逻辑就都被摧毁了。）

alfiedotwtf 给出的办法更粗糙也更诚实：

> "Even if there were stop flags, you simply get one of the ABLITERATED models that have all the guards NOP’d out" — alfiedotwtf [c:50221644]
> （译文：就算真有拦截开关，你随便找一个把所有护栏 NOP 掉的 ABLITERATED 模型就行了。）

最扎实的证据来自 nekitamo，他正好做了一组实测——用 GhidraSQL（把 AI 的工具调用表示成虚拟 SQL 表的框架）当 harness，让模型去逆向一个简单的 crackme，覆盖了近三十个模型：

> "The Qwen3.8-Flash-Next model is ok for reverse engineering. It can definitely solve simple tasks, but it gets easily confused, and burns tokens like crazy." — nekitamo [c:50220395]
> （译文：Qwen3.8-Flash-Next 做逆向工程还行，简单任务肯定能解，但很容易被绕晕，而且烧 token 烧得吓人。）

他贴出来的表格里，几个数字值得单独拎出来：最快最省的是 Xiaomi MiMo v2.6 Flash，22.5 万 token、5 美分，一次做对；DeepSeek Flash 直连 API 跑了 76 秒解出，花 3 美分；Claude Opus 5.5 以 31 万 token、24 美分拿到全场最高评价；Gemini Flash 直接拒绝了逆向任务；Thinking Machines Inkling Small 一上手就卡住被终止；而 MiniMax M3 烧掉了 454 万 token、花 20 美分，被评为「最不聪明的一档，走过很多弯路、反复犯小错」。他的结论是，最新的 DeepSeek Flash 是开放模型里最让人满意的。

### 六、三星和 LG 的旧账

讨论之所以这么难收尾，是因为它接着一笔更老的账。

luma 提到的那组测试，测的正是「拒绝同意之后还在发多少数据」：

> "These folks recently did tests on major TV brands, not accepting the on-device consent forms, and then recording how much data they continued to send after consent was denied (which itself is not always possible)." — luma [c:50220829]
> （译文：这帮人最近对各大电视品牌做了测试：不在设备上点同意，然后记录在你拒绝之后它们还继续发送多少数据（这本身也不总能做到）。）

> "Samsung was the single brand reviewed which actually stopped sending data after the user told it to do so." — luma [c:50220829]
> （译文：在被测的品牌里，三星是唯一一个在你告诉它别发之后真的停下来的。）

同一个人的另一条评论把法律层面的旧账也翻了出来：

> "In February Samsung agreed to stop collecting the data when opted out in the US after a few lawsuits were lining up." — luma [c:50222868]
> （译文：今年二月，在几起诉讼即将成形的当口，三星同意在美国对选择退出的用户停止收集数据。）

> "LG was the target of a different lawsuit in Texas which they settled and then wrote up a forced arbitration clause and doubled-down on data collection, even when opted out. Don't buy LG TVs." — luma [c:50222868]
> （译文：LG 那边是德州另一起诉讼，他们和解之后写了一条强制仲裁条款，然后加倍收集数据，连用户选择退出也一样。别买 LG 电视。）

tosti 把两个话题接在了一起：

> "Right, but still: OpenAI provided a service and it's up to them to determine acceptable use. Samsung sells a $3000 (or actually $2999,95) TV and you get big brother watching you." — tosti [c:50219899]
> （译文：话是这么说，但 OpenAI 提供了服务，合规边界由他们自己划。三星卖的是 3000 美元（准确说是 2999.95 美元）的电视，你得到的是一个无时无刻不在看着你的「老大哥」。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 报告还不存在，只有五张截图 | fdw | 「文章」只是推文截图，真正的数据没解密出来 |
| 该先贴报文，别炒热度 | wtch98 | 给我看实际发出去的 HTTP 请求 |
| 电视会借外接设备的麦克风 | tkel | 没有麦克风就去找 soundbar 或蓝牙设备，数据送 Bixby |
| 狗叫和婴儿哭是官方功能 | luma | 这是 SmartThings 集成里宣传的能力 |
| 隐私噩梦被推文叙事夸大 | pawelduda | 查过了，是真的，但推文讲的故事对三星不公 |
| 这是全行业惯例 | Hugsun | 这些会窥探的电视是普遍做法 |
| 封号很蠢，逆向是刚需 | ada-h00k | 担心账号被封，LLM 的价值就大打折扣 |
| 不算蠢，只是收入占比小 | williamdclt | 这批客户的收入对 OpenAI 来说几乎可以忽略 |
| 有办法绕开误伤 | spockz | 申请 daybreak blue，并且只说目标不说方法 |
| Claude 误触发更离谱 | emdash | 问它怎么种树苗都被拦 |
| 换个本地模型继续干 | 3abiton | GLM3 这类模型现在很能打 |
| 开放模型会吃掉付费模型 | locknitpicker | 能力接近之后，没人再愿意付钱 |
| 护栏可以直接 NOP 掉 | alfiedotwtf | 用去护栏的 ABLITERATED 模型 |
| 三星比 LG 收敛 | luma | 被测品牌里只有三星在你说停之后真的停 |
| 别买 LG 电视 | luma | 和解之后还写强制仲裁条款，照收不误 |

## 总体情绪

这个帖子的形状很怪：一场关于智能电视隐私的讨论，中途变成了关于 AI 厂商内容审查的控诉，又变成了关于中美模型价差的辩论，最后落回一句「别买 LG 电视」。三个话题挤在同一条推文下面，因为它们确实挤在一起——一个手握 root shell、想公开自己电视在偷听的研究者，先被 AI 厂商的过滤器拦了一下。

情绪的重心在中段：怀疑「电视在偷听」的人其实不多，大家更愤怒的是「发现了也说不出口」。spockz 那段经验被反复引用，因为它给出了可操作的办法——申请 daybreak blue、说目标不说方法、声明是自己的设备。这套规矩本身就说明问题：在一个以安全为名审查技术内容的行业里，「合规地做安全研究」已经变成一门需要学习的技能。

而真正的证据仍然缺席。推文里那句 "discovered PRIVACY HORROR" 到 HN 收盘时也没有配套的抓包、报文或可复现步骤。评论区吵得最凶的两派人，一派在替三星说「没你们想的那么糟」，另一派在替 OpenAI 说「这是它该拦的」——两派都还没有材料。

一台 2025 年的电视，为了识别家里的狗在叫，需要一个麦克风，需要一个连着 soundbar 或蓝牙音箱的麦克风，需要把这些数据送进 Bixby。技术上的每一步都平平无奇，平平无奇到没人写报告，直到有人拿 root shell 把它翻出来，然后发现连报告都递不出去。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | 研究者的原推文（X / @log4j，2026-10-21 21:06） | https://x.com/log4j/status/2113014142600953868 |
| 2 | 各大电视品牌数据采集测试（评论区引用） | https://www.youtube.com/watch?v=t_GK06_3UY8 |
| 3 | HN 讨论 | https://news.ycombinator.com/item?id=50218633 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
