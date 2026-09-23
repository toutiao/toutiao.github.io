---
layout: post
title: >-
  修一座 1877 年的钟楼——HN 讨论精华
date: 2026-09-24
hn_id: 49817469
categories: [articles]
excerpt: >-
  一位作者用一台 2001 年的微控制器，帮一座 1877 年的警局钟楼重新对时。HN 评论把工程债、修复定义、社区情怀全聊了一圈。
tagline: >-
  揭尘封电路板的工程师，一把螺丝刀打到 25 年前的 PIC。
---

## 原文概要

2026 年 4 月 11 日，作者收到朋友转来的求助——爱丁堡 Portobello 当地社区组织 Action Porty 通过 Scottish Land Fund 把镇上废弃的 Portobello Police Station 买了下来，准备改作社区用途；可他们接手的钟塔不会对时，他们也不知道该怎么按那位前任留下的微控制器。求助帖里点名要人帮忙。

两人一合计，决定周六下午爬上钟塔实地看看。Portobello Police Station 1877 年动工，最早是 Portobello 自治市镇的会议和法庭厅，后来依次改成过图书馆、警局，如今归社区所有。钟楼里的机芯大概率就是 1877 年的原件，后人追加过电机与控制盒。电机的控制是一块"绝不是 1877 年的"电路板，核心是一颗 PIC `16F628` 微控制器（带继电器、电源和一块标着疑似 2001 年的铅酸电池）。

设时间：他们发现齿轮上有一只 pawl，抬起来就能让电机脱开，手动转轴就改得了时间——指针每根对面带配重，靠看不见的镜像就能直接读。差一点闹乌龙：在钟塔里往外看觉得指针在倒着转，下楼才发现其实是反向看错了。下午 4 点，回到街面确认时间正确，到点敲 4 下，任务完成。他们最后还是切掉了敲钟电机，怕附近居民抱怨夜色太吵。

收工去了马路对面的 Portobello Tap 吃饭，还列了一份"酒后改进清单"——可调敲钟时段、远程敲钟、门铃接入钟声等。本以为一小时搞定，最后搞成一下午。

## 讨论焦点

### "Status" LED 闪的是摩尔斯还是二进制？

那块电路板上的"Status"LED 闪出 `long-long-short-short-short` 一段，作者苦于没时间破译就下了塔。HN 上最活跃的副线就是：这一串到底是什么意思？

> "long-long-short-short-short is 7 in morse code. They don't say what time they tried this or if it ever changed, though, so that's just a hypothesis." — user [c:49817810]
> （`long-long-short-short-short` 用摩尔斯码解码是数字 7。不过作者没说尝试的具体时间，所以这只是猜测。）

> "As an engineer i would never think that complicated - morse code? Couldn't it be just binary long-long-short-short-short 11000 Which is - to everyones surprise - 24 as in hours." — user [c:49821016]
> （作为工程师，我不太会先想到摩尔斯码；换二进制读 `11000` 反而是 24——正好对应小时数。）

> "It's almost certainly this. I suspect the advance button can be used to advance the time via morse code LED flashes and only then committed when you get to the right hour. Perhaps the long-press commits the hour, which is why it rang once initially." — user [c:49817937]
> （几乎可以肯定就是这个思路：`advance` 按住再松手就会敲一次钟，LED 把候选小时数"闪"出来，长按确认即落到下一小时。）

> "I used to use Morse to blink out status codes in similar things but I think by the mid-2000s I'd moved from PIC16F628s to atmega328. I didn't build the chime box but it looks like the sort of thing I used to do back then." — user [c:49819514]
> （我以前确实用摩尔斯闪状态码，但 2005 年前后我已经从 PIC16F628 换到 ATmega328 了。这块电路板一看就是 2000 年代初 DIY 的味道。）

### "算修复吗？"——会的，因为这是工程

一篇轻松博客下面，照例有读者拿标题挑刺。

> "I dunno if setting the time counts as fixing..." — user [c:49818266]
> （只是改个时间而已，这算"修复"？）

> "sure it does. the mechanism was no longer functioning properly. and its a repair even moreso considering the unknown nature of the system. sometimes you get paid because you know things, sometimes you get paid because you know how to figure things out." — user [c:49818346]
> （当然算。机制本来就不在正常状态，系统还完全是个黑盒，靠"知道怎么搞清楚"——这正是工程师吃饭的本事。）

> "Yeah I repair old cameras these days. The amount of cameras I've fixed by just poking at random stuff until it unjams is surprisingly high. Even more so the number I've \"fixed\" by just replacing the batteries." — user [c:49818852]
> （我现在修老相机，靠"乱戳直到不卡"修好的占比高得惊人，而其中更大一部分是——换电池。）

### 25 年的工程债：那块标着 "090323" 的电池

原文说"电池大概快四分之一世纪了"，但网友顺着电池侧面那行油性笔字反推了一下。

> "It's a standard sealed lead acid battery... Design spec is up to 5 years. The one in the photo looks like it may have a date written in Sharpie on the side. I don't think it's 25 years old though. The \"090323\" on top could be DDMMYY indicating a battery from 2023." — user [c:49818289]
> （这是一颗标准的密封铅酸电池，规格寿命 5 年。顶上用油性笔写着 `090323`——按"日-月-年"格式读，那是 2023 年 3 月 9 日，并不是 25 年前的原件。）

> "If someone knew to replace the battery just three years ago, I would expect they also would have enough knowledge to set the clock itself." — user [c:49819220]
> （如果 2023 年真的有人换电池，他应该也知道怎么调时间才对。可他似乎没把方法传下来。）

> "I would GUESS that someone tried figuring it out in 2023 and replaced the battery as troubleshooting. If it were me, I'd probably do the same then stop when I hit a wall so I didn't damage it further. I don't wanna be the guy who damages a 100+ year old public clock" — user [c:49820656]
> （我猜那人 2023 年试过一阵，实在撞墙就停了。我也一样——怕一时手滑，把 100 多年的钟弄坏，那责任谁背得起？）

### "我的家乡上 HN 了"

Portobello 这种小镇上 HN 头条，留言区立刻变成邻里相认大会。

> "Such a pleasant surprise to wake up and see my hometown at the top of hackernews!" — user [c:49818149]
> （一觉醒来，家乡登上了 HN 头条，这种惊喜太罕见了。）

> "Wild seeing local stuff on HN. My dad used to work in that police station, probably the first (and only) HN story I'll send him." — user [c:49820816]
> （HN 上看到本地新闻太不可思议了。我爸以前就在那所警局上班，这大概是我转发给他的第一条（也是唯一一条）HN 链接。）

> "Gorgeous building and a nice wee pub across from it! A couple of friends of mine used to stay not far from there. I've half an idea I did some networky stuff for the Community Wardens probably around the time that chime box was fitted - if you see anything marked Alvarion or Ceragon, it's probably got my real name on it somewhere." — user [c:49819497]
> （建筑很美，对面那家小酒吧也好。我隐约记得那块控制盒装上前后，我给社区守望员做过网络——如果看到标着 Alvarion 或 Ceragon 的设备，上面八成有我名字。）

> "One of many old clocks in Edinburgh that needs fixing. The one on the Balmoral Hotel had to get a lot of work done. There were three identical street clocks in Edinburgh that the council there have tried to remove. They succeeded with the one at Tollcross." — user [c:49819136]
> （爱丁堡有问题的钟不止这一座。Balmoral 酒店的钟刚做过大修，全市本来有三座一样的街钟，市议会已经成功拆掉了 Tollcross 那一座。）

### 老派手艺：请把它拍成视频

原文勾起一连串"我也想爬上去"的留言，也引出一批志同道合的钟楼频道。

> "Obviously, the next logical step is a Home Assistant integration." — user [c:49819345]
> （下一步当然是接进 Home Assistant。）

> "If you enjoyed this, here's Fred Dibnah exploring Big Ben and discussing some of the engineering details... Fred Dibnah was a treasure." — user [c:49819017]
> （喜欢这种内容的话，强烈推荐 Fred Dibnah 拆大本钟那段——聊工程细节很有意思，他本人也是一代匠人。）

> "Next time you're in Baltimore, be sure to visit the Bromo Seltzer Arts Tower where you can see its gravity-driven pendulum clock. It's a beautiful mechanism with a very specific claim to fame: \"The clockworks is the largest four dial gravity driven non-chiming clock in the world with the magnificent 24ft dials.\"" — user [c:49820706]
> （下次去巴尔的摩，记得去 Bromo Seltzer 艺术塔看它的重力摆钟——4 个表盘、24 英尺表径，是世界上最大的非报时式重力驱动钟。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| LED 闪的是摩尔斯码 | SaberTail [c:49817810] | `long-long-short-short-short` = 数字 7 |
| LED 闪的是二进制 | MacNCheese23 [c:49821016] | `11000` 读成 24，正合小时数 |
| 调时间就是"修复" | superxpro12 [c:49818346] | 工程师靠"搞清楚"吃饭，这活儿算 |
| 2023 年那拨人是被卡住了 | fusslo [c:49820656] | 老物件怕失手，宁可停下来也不做"屠夫" |
| 调钟值得传家 | bigmadshoe / ad133 [c:49818149] [c:49820816] | HN 上看到家乡/父辈工作地，意义特殊 |
| 把老钟搬上 Home Assistant | BHSPitMonkey [c:49819345] | 修理完的下一步必须是智能家居集成 |

## 总体情绪

开篇是温馨的旧建筑探险；中段是工程债的考古——一节标着 `090323` 的铅酸电池交代了 2023 年那波介入者的犹豫与保守；后半段弥漫着一种"我的家乡居然上 HN 了"的相认感。技术调钟是稀松平常的小事，但 1877 年的机芯、2001 年的微控制器、2023 年换过的电池、2026 年的动手，再加上一个在空荡荡的钟塔里按住 `advance` 等钟声的志愿者，整件事变成了小型社区工程的样本。HN 编辑 dang 在评论中确认这篇是被选进了 SCP（Second Chance Pool），不是被自然顶上去的——事实证明，那些远离 LLM / 创业关键词的"互联网最初的样子"，依然能拿下头名。

修钟很难吗？按下 `advance` 就行；但知道这块板子里住着一颗 25 岁的 PIC，再决定爬上 14 米高的阁楼去面对它——这件事本身，就值得被一篇博客留住。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Fixing the Portobello Police Station Clock | https://news.ycombinator.com/item?id=49817469 |

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3。

免责声明：本摘要由 AI 辅助生成，仅用于信息整理与观点提炼。原文观点与数据应以原帖为准。
</div>
