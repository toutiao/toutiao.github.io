---
layout: post
title: >-
  Apple Music 404：给一个不存在的网址，做了一台能转的 iPod
date: 2026-10-24
hn_id: 50207910
categories: [articles]
excerpt: >-
  返回 404 的链接里藏着一台点轮 iPod，1,029 首歌、682 位艺人、15 张歌单，
  外加一个 334KB 的前端包。评论区吵得最凶的问题不是怀旧，
  是这东西到底是不是 AI 写的。
tagline: >-
  Apple 用一个 404 页面，换回 770 分和一次集体怀旧。
---

## 原文概要

2026 年 10 月 23 日，一个叫 frizlab 的账号把一条链接扔上 HN 热门榜（/best），标题只有五个词：Apple Music 404 Not Found。链接本身是 https://music.apple.com/this-url-doesnt-exist——一个诚实的坏地址。到 10 月 24 日，它拿到 770 分、233 条评论。

链接的诚实之处恰恰是它的全部内容。用普通方式抓取，它返回标准的 HTTP 404，响应体只有 2,748 字节的 HTML 外壳，加载 `/assets/index~ea66e33958.js`（3.3MB）和 musickit 组件。但这条 404 路由在运行时被切到另一个分块 `assets/NotFoundPage~3bdc0538ef.js`，里面塞着 13 处 iPod 字样和一组专用的元数据键（`ASE.Web.Music.Meta.iPod.Title`）。真正干活的是另一个包：https://music.apple.com/includes/ipod/web-music-ipod.esm.js，334,809 字节。

页面里那台 iPod Classic 样式的播放器有真的点轮，评论区反复提到按下时那声 click。音乐也不是占位符：曲库是一个公开的 JSON，`https://music.apple.com/includes/ipod/data/us/en-US.json`，536,507 字节，里面是 1,029 首歌、682 位艺人、15 张歌单，歌单名字包括 “Songs From iPod Ads”、“Alternative Hits: 2001”、“Rock Hits: 2001”、“2000s Indie Essentials”。换地区就是换路径，英国版 `gb/en-GB.json` 是 1,156 首、727 位艺人。

这份 404 页面本质上是一次产品侧的怀旧投放：把一个必然失败的 URL，换成一个能被玩坏的播放器。于是讨论分成两半——一半在讨论这台 iPod 的意义，另一半在追问它是不是 AI 写的。

## 讨论焦点

### 一、一个 404 页面，里面是一台可以点的 iPod

发帖人自己给的第一条评论很短：

> "I love Easter eggs like those." — frizlab [c:50207914]
> （译文：我喜欢这种彩蛋。）

把点轮形容得最具体的，是一位把“用不上的好界面”当成损失的人：

> "Really is heartbreaking that the click wheel is such an incredible and satisfying user interface but technology has evolved such that we have no need for it anymore." — sherburt3 [c:50213526]
> （译文：点轮明明是这么漂亮、这么让人满足的交互界面，可技术已经发展到我们再也不需要它了，这事真的很令人难过。）

而最直接的诉求只有一句：

> "Make this the default Apple Music interface" — paxy [c:50213414]
> （译文：把这个做成 Apple Music 的默认界面吧。）

用 30 Rock 的梗解释这波怀旧的人，给出的解释比怀旧本身更有意思：

> "Maybe there's truth to the Dennis Duffy joke on 30 Rock: “technology is cyclical” :)" — lukifer [c:50213301]
> （译文：也许 30 Rock 里 Dennis Duffy 那个梗有点道理：“技术是循环的” :)

### 二、这台 iPod 放的到底是什么

有人顺手把曲库数据贴了出来：

> "Playlist data below for anyone interested:" — illwrks [c:50213467]
> （译文：下面是需要的人可以拿的曲库数据。）

他后来又跑了五个地区，把三列数字贴了出来：

> "There appears to be different URLs for different territories." — illwrks [c:50213669]
> （译文：不同地区似乎对应不同的 URL。）

按他贴的表，US 是 1,029 首、682 位艺人、GB 是 1,156 首、727 位艺人，FR、DE、ES 各有 1,217、1,062、1,155 首。这两组数字可以自己复核：`us/en-US.json` 解析出来确实是 1,029 首歌、682 位艺人、15 张歌单，`gb/en-GB.json` 是 1,156 首、727 位艺人，两组都与评论一致。

更微妙的一层是：它放的不是你自己的歌单。曲库里那 15 张歌单——“Songs From iPod Ads”、“Alternative Hits: 2001”、“Country Hits: 2001”、“Hip-Hop/R&B Hits: 2001”——是一份编辑部式的策展清单，不是用户的 Apple Music 库。有人因此既惊喜又有点失落：

> "Huh! Alright, that explains why this damned thing had so much music from my own Apple Music library yet was missing so much more!" — brirec [c:50215440]
> （译文：嚯！行吧，这就解释了这个该死的东西为什么从我自己的 Apple Music 曲库里拿到那么多歌，却又缺了更多。）

至于每首歌有多长，评论区有人凭印象猜了个数：

> "I think most (if not all?) of the songs are 90 second clips. I imagine for licensing purposes." — dmtroyer [c:50213296]
> （译文：我猜大部分（甚至全部？）歌曲都是 90 秒的片段。我猜是为了授权的原因。）

这个猜测和数据对不上。JSON 里 `durationInMillis` 记的是完整时长，中位数约 236 秒，最长 12 分半；每首歌另带一个 `previewUrl`，指向的 AAC 文件实测正好 30.024 秒。有人注意到的重复条目则是另一回事：

> "Interesting that “Do You Realize??” by The Flaming Lips is listed twice under Songs, but its actually two sequential 90 second clips." — mslev [c:50213192]
> （译文：有意思的是 The Flaming Lips 的“Do You Realize??”在 Songs 里列了两次，其实是前后相接的两段 90 秒片段。）

### 三、这是 AI 做的吗

页面做得出这个精度，评论区自然要问是谁做的。答案来得很快，而且很短：

> "This page was conceived by and implemented by an AI." — sampaio96 [c:50213249]
> （译文：这个页面是由 AI 构想并实现的。）

反对意见给的依据是工程层面的：

> "They're all in regards to design choices or why something is needed when it's not obvious. And such a level of polish in the interface isn't something you attain through prompting. Not AI." — dieulot [c:50216803]
> （译文：这些都是关于设计选择，或者为什么某个不明显的东西必须存在。这种程度的界面打磨，不是靠提示词能得到的。不是 AI。）

他把话说明白了：代码注释里的每一条“为什么需要这个”，对应的是决策记录，不是生成。而 334,809 字节的 `web-music-ipod.esm.js` 就在 `music.apple.com/includes/ipod/` 下，谁都能拉下来读。

不过也有人把这类怀疑推广成了一种普遍感受：

> "I suspect a lot of superfluous stuff implemented in recent software is implemented by an agent." — marcelox86 [c:50213654]
> （译文：我怀疑现在很多软件里多余的东西都是由 agent 实现的。）

他同时说明这没法举证，自己也没形成结论——这恰好说明这类判断在扩散：一次针对具体页面的怀疑，会很快变成对整个行业的泛化怀疑。

### 四、点轮还在供货

怀旧不是纯情绪，它有真实的市场，而且型号比想象中具体。

> "It's really cute. I wonder if we'll see a significant market for plain MP3 players with the whole digital detox fad lining up with the nostalgia." — ashleyn [c:50213139]
> （译文：它真的很可爱。我在想，配合数字排毒这股风潮和怀旧情绪，会不会催生一个可观的纯 MP3 播放器市场。）

> "I think I asked in HN last year if anything was happening in this space now that the click wheel patent expired. I ended up buying a $50 Chinese knockoff for one of my kids. It...feels like a $50 knockoff, haha." — Brendinooo [c:50213472]
> （译文：我觉得去年我在 HN 上问过，点轮专利过期之后这个领域还有没有动静。我最后给一个孩子买了个 50 美元的中国山寨货。它……手感就是 50 美元的山寨货，哈哈。）

真买过的人给出了具体型号：

> "I got myself a couple. A Mechen M30 and a FiiO M21. First one is pretty low-end in terms of interface and firmware capabilities, but both sound superb, and being able to listen music without a connection to somewhere and not interrupted by notifications." — bayindirh [c:50214357]
> （译文：我自己买了两个。一台 Mechen M30，一台 FiiO M21。第一台在界面和固件能力上相当低端，但两台声音都非常好，而且听歌时不需要连到任何地方，也不会被通知打断。）

老机器也还在被救活，甚至有产品专门做这件事：

> "There's even a product that lets you retrofit an old iPod with a modern motherboard" — vostrocity [c:50213637]
> （译文：甚至有产品能把现代主板装进老 iPod 里。）

不过老玩家的判断是，光有硬件不够：

> "Part of the appeal of the iPod is that it only had just as much hardware and software as it needed and was simple, which lends to its extreme mod potential that's fueling its continuing popularity today." — cosmic_cheese [c:50213722]
> （译文：iPod 的迷人之处在于它只有刚好够用的硬件和软件，并且足够简单，这才有极高的改装潜力，也才有了今天持续不衰的热度。）

副线里还有一整段 iPod 维修经验。有人的二代 iPod 上周罢工了，屏幕只剩一个带警告标志的文件夹图标：

> "It was truly a work of art, that device." — jmathai [c:50214198]
> （译文：那台设备真的一件艺术品。）

给出的抢救方案是物理系的：

> "If you put the iPod in a freezer bag and get it very cold, it may spin up long enough for you to make a backup." — functionmouse [c:50214534]
> （译文：把 iPod 放进冷冻袋里冻到足够冷，它可能会转起来，够你做个备份。）

### 五、抵触的不是 iPod，是 AI 音乐

评论区里最有情绪的一批评论，说的其实不是 iPod。有人解释自己为什么不再信任音乐服务上的歌单，把原因指向了平台上的内容来源：

> "I have a hard time trusting random playlists on music services because I don't know if it is genuinely new music made by real people, or ai the platform is pushing so they can make more money." — tarentel [c:50214119]
> （译文：我很难相信音乐服务上的随机歌单，因为我分不清那是真人做的真新歌，还是平台为了多赚钱在推的 AI 音乐。）

比这更普遍的是另一件事——听腻。有人把最喜欢的歌设成闹钟，用了 15 年，得出一个悲观的结论：

> "If there's anything I've learned from using my favorite tracks as a daily alarm: there is no music that I won't eventually start to hate :(" — lossyalgo [c:50216663]
> （译文：如果用我最喜欢的歌当闹钟有什么心得的话，那就是：不存在一首歌，是我最终不会开始讨厌的 :（）

连歌单分享都带上阵营感：

> "I know someone in my group who moved from Apple Music to Spotify because everyone else was using Spotify and she didn't wanna feel left out." — eddythompson80 [c:50216279]
> （译文：我认识一个人，因为她朋友圈里所有人都在用 Spotify，就从 Apple Music 挪到了 Spotify，因为她不想觉得自己被排除在外。）

### 六、买设备是一种社交信号

再往下一层，是把怀旧当消费行为来读的观点：

> "My lukewarm take is that it's conspicuous consumption." — doublepg23 [c:50215236]
> （译文：我这不温不火的看法是：这就是炫耀性消费。）

> "It's hard to socially signal when everyone can afford to stream and the search bar can show you Sabrina Carpenter just as easily as RYM or /mu/core." — doublepg23 [c:50215236]
> （译文：当人人都付得起流媒体、搜索框里点一下 Sabrina Carpenter 和 RYM 或 /mu/core 一样容易的时候，就很难再做社交信号了。）

而花钱买设备，恰好能把信号重新立起来。反驳也立刻出现，问得很直白：

> "who am I socially signaling to if I have physical media in my basement? my wife?" — footy [c:50215430]
> （译文：如果我实体唱片都堆在地下室里，我是在向谁发社交信号？我老婆吗？）

最终有人给出了全场最冷的一句：

> "Music listening has become so atomized and private, with the vast majority of people listening through earbuds and unaware of even what close friends are listening to." — TFNA [c:50216158]
> （译文：音乐聆听已经变得极度原子化和私密，绝大多数人戴着耳机听，甚至不知道亲近的朋友在听什么。）

所以话题又回到那台 iPod：它当然可以是一台播放器，但它也是少数还能被看见的听歌姿势。

### 七、副线：车机会替你选歌

讨论后期跑出一条完全独立的支线，主题是插上手机之后车机自动开始播放。谁的品味最差，成了另一个梗：

> "My car plays “Africa” by toto every time I plug in the iphone to charge. It was a trifling inconvenience, then over years it became rage inducing, and now it's reached all the way back around to funny." — QuadmasterXLII [c:50214604]
> （译文：我每次把 iPhone 插上充电，车机都会放 toto 的《Africa》。一开始只是小麻烦，过了几年变成让人恼火，现在绕了一圈，反而挺好笑了。）

> "Mine was A-Punk by Vampire Weekend. Used to annoy me to no end, but it turned out it was a “feature” of the car stereo to just default to playing alphabetically. Buying a new car fixes that little issue. Easy!" — guywithabike [c:50214920]
> （译文：我的是 Vampire Weekend 的《A-Punk》。以前烦得要命，后来发现这其实是车机的“功能”——默认按字母顺序播放。换个新车就解决了，轻而易举！）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 这是彩蛋，值得 | frizlab | 我喜欢这种彩蛋 |
| 应该做成默认界面 | paxy | 把这个做成 Apple Music 的默认界面吧 |
| 页面是 AI 做的 | sampaio96 | 这个页面是由 AI 构想并实现的 |
| 不是 AI 写的 | dieulot | 这种界面打磨不是提示词能得到的，代码注释里全是决策记录 |
| 90 秒片段是猜的 | dmtroyer | 我猜大部分歌都是 90 秒片段，大概为了授权 |
| 怀旧有真实市场 | ashleyn | 数字排毒加怀旧，也许能撑起一个纯 MP3 播放器市场 |
| 山寨货手感就是山寨货 | Brendinooo | 50 美元的中国山寨货，手感就是 50 美元的山寨货 |
| iPod 的灵魂是刚好够用 | cosmic_cheese | 只装刚好够用的软硬件才简单，而简单才有改装空间 |
| 抵触的根源是 AI 音乐 | tarentel | 分不清平台推的是真音乐还是 AI 音乐，所以不信任歌单 |
| 听歌终会听腻 | lossyalgo | 不存在一首歌，是我最终不会开始讨厌的 |
| 怀旧是炫耀性消费 | doublepg23 | 我这不温不火的看法是：这就是炫耀性消费 |
| 社交信号已经失效 | TFNA | 音乐聆听已经原子化、私密化，没人在意别人在听什么 |

## 总体情绪

评论区的正面情绪比想象中具体：不是“好怀念啊”，而是型号、价格、改装方案、硬盘故障，回忆被拆成可操作的清单。一个坏掉的 URL 被 Apple 换成了可以按的点轮，配上 1,029 首按年代和地区策展过的歌——有人把它当成该做成默认界面的产品，有人顺手讲起自己的旧 iPod 怎么坏、怎么被冷冻袋救回来。连“点轮专利过期了”这种细节都有人记得。Apple 把彩蛋放在一个必然失败的 URL 上，这个位置选得精准：没人会因为想不起歌名而离开那个页面。

另一条情绪线是对 AI 的不信任，位置比预想的更靠前。有人怀疑整个页面的实现方式，有人顺着怀疑去质疑最近软件里所有多余的功能，也有人根本不是在怀疑技术，而是在躲避平台推荐里真假难辨的 AI 曲目。同一场讨论里，“这页是不是 AI 写的”和“我不想听 AI 写的歌”其实是同一个焦虑的两个出口。

最后收束在一个有点反讽的事实上：一台把音乐还给人的机器，功能是在一个返回 404 的页面上实现的。而评论区自己也说了实话——真正稀缺的不是播放，是被看见。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Apple Music 404 Not Found（页面本身） | https://music.apple.com/this-url-doesnt-exist |
| 2 | Apple Music 404 Not Found（HN 讨论） | https://news.ycombinator.com/item?id=50207910 |
| 3 | iPod 曲库数据（US / en-US.json） | https://music.apple.com/includes/ipod/data/us/en-US.json |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
