---
layout: post
title: >-
  二十年后，兄弟俩在浏览器里重开《极品飞车：地下狂飙 2》——静态重编译与一场版权审判 — HN 讨论摘要
date: 2026-11-08
hn_id: 50403052
categories: [articles]
excerpt: >-
  作者把游戏本体的 x86 机器码静态重编译成 C，塞进 Chrome 和 Firefox：120 帧、开放世界、多人同场。性能吵成两派，但 157 条评论的真正焦点只有一个——服务器上放的那份游戏素材，到底算不算偷。
tagline: >-
  哥哥，二十年了，我们再跑一次科西嘉。
---

> 来源：HN 讨论主帖 [Need for Speed Underground 2 online in the browser](https://news.ycombinator.com/item?id=50403052)（496 分，157 条评论），提交站点 <https://nfsu2.xyz/>。归档快照 2026-11-07 17:32 UTC，入库 100 条评论（HN 全量 157 条）。引文保留 HN 原文的 HTML 实体与段落标记。

## 原文概要

站点是 nfsu2.xyz，页面标题叫 Underground 2 Revived——2004 年 EA 的《Need for Speed Underground 2》（《极品飞车：地下狂飙 2》）现在完整跑在浏览器里。技术路径不是模拟器，而是静态重编译：把游戏原本的 x86 机器码静态翻译成 C 代码，再编译成浏览器能跑的 WebAssembly。血统写得清清楚楚——底座是 Talha Müderrisoğlu 的 NFSU2Recomp（x86 → C 静态重编译器），路线承自 N64: Recompiled 与 XenonRecomp，本项目从 2026 年 10 月 16 日那个 MIT 授权版本 fork 出来，只用了该版本的代码。

站点自称 "The PC game's own code, recompiled for Chrome and Firefox: up to 120 fps in widescreen, free roam and Online races with friends, and controllers, wheels, and touch controls."（游戏本体的代码，为 Chrome 与 Firefox 重编译：宽屏最高 120 帧，自由漫游，与朋友联机竞速，兼容手柄、方向盘与触屏。）首页有实时在线人数（总数 / 自由漫游），存档走云同步，换台设备登录能接着玩。触屏布局做得比想象中细：哪根拇指管转向、油门键旁边那块永远避开屏幕边缘、倾斜转向时保持地平线、菜单按钮自动放大到手指尺寸。

起因比技术更朴素。作者写道："My brother and I played this game together about 20 years ago. Because of that I tried porting it to the browser so we could play together again."（我和哥哥大约二十年前一起玩过这款游戏。就因为这个，我想把它移植到浏览器，这样我们能再一起玩一次。）他自己也说这事后来有点失控："It worked surprisingly well, and it got a bit out of hand."（效果出乎意料地好，然后就有点失控了。）二十年前兄弟俩的联机愿望，最后长成了带实时人数计数器的公共站点。

变现方式轻描淡写：页面放一个 buy me a coffee，附一句 "Everyone gets the same game, with no microtransactions or paid perks. Supporters just get a Discord role."（所有人拿到的都是同一个游戏，没有微交易、没有付费特权；赞助者只多一个 Discord 身份组。）同时留了权利人邮箱：Rights holders: legal (at) nfsu2.xyz。语言支持比很多官方重制还全：KyoriAsh 的 Multi 13 languages mod 带来了配音、过场动画和 13 种语言文本，Lee-Ryo 补上泰语；另有巴西葡语（TraduMix、MixMods）、波兰语（PLProjekt）、土耳其语、匈牙利语、乌克兰语、捷克语、斯洛伐克语、希腊语，外加 VileStuff 的英文字幕修复版。

门槛有两道：你要自备一份游戏本体（评论明确指出需要特定版本的 .exe 文件），部分系统还得手动打开 WebGPU 与 Vulkan 旗标，否则跑不起来。

## 讨论焦点

### 一、"这合法吗？"——有人开口问的第一句

最早把话挑明的是 tevlon，问得很客气也很直接：

> "serious question: how is this legal?" — tevlon [c:50403642]

> （认真问一句：这合法吗？）

回答只有三个字母：

> "It&#x27;s not" — hobofan [c:50403659]

> （不合法。）

支持项目、同时在法律上替作者捏把汗的 rustyhancock 说得很克制：

> "Huge fan of bringing back older games and updating.<p>But I think it&#x27;s highly dubious to accept let alone solicit donations for copyrighted content." — rustyhancock [c:50404031]

> （我特别喜欢把老游戏搬回来、翻新这类事。<p>但我认为，为受版权保护的内容接受——更不用说主动索取——捐赠，是极其可疑的。）

rvz 的判断更冷：他认为作者根本无权分发这份素材，而"收捐赠"这一步等于把权利人直接招来：

> "&gt; Huge fan of bringing back older games and updating.<p>Just because <i>this game</i> is old, does not mean they (nfsu2 [dot] xyz) own the rights to redistributing it which is what they are doing. Both the copyright for this game and the company is still live.<p>Even asking for donations is going to get them into trouble as well as inviting the rights holders to contact them directly." — rvz [c:50404991]

> （> 我特别喜欢把老游戏搬回来、翻新这类事。<p>仅仅因为<i>这个游戏</i>老了，并不意味着他们（nfsu2 [dot] xyz）拥有重新分发的权利，而他们干的正是这事。这款游戏的版权和公司都还活着。<p>哪怕只是收捐赠，也会给他们惹上麻烦，同时等于邀请权利人直接联系他们。）

结论在 rvz 看来已经写好了：

> "So I don&#x27;t think this site will survive for long. EA&#x27;s lawyers have access to insurmountable funds which make this cat-and-mouse game disadvantageous to projects like this who are even showing the intention of asking for some form of financial contribution of support (money through donations)." — rvz [c:50404991]

> （所以我不认为这个站点能撑太久。EA 的律师手里有压倒性的资金，这使得猫鼠游戏对这类项目极为不利——哪怕他们只是表现出想收一点支持（通过捐赠）的意思。）

玩家 popcar2 已经在开着玩了，结论一样：

> "The only downside is that this website isn&#x27;t legal and now that it&#x27;s popular it&#x27;s probably getting a takedown soon." — popcar2 [c:50404555]

> （唯一的缺点是这个网站不合法，而它现在火了，大概很快就会被下架。）

倒是有玩家早就在为它准备后路：

> "Can I selfhost this game locally? I have the suspicion it won&#x27;t stay online for long." — andix [c:50404050]

> （能自己本地部署一份吗？我怀疑它在线上待不了多久。）

更微妙的是"收钱"这一步本身带来的额外风险，jimmyjazz14 把它讲得很明白——过去就有先例：

> "Yeah I believe taking donations was the legal downfall of some otherwise legal emulators on the market." — jimmyjazz14 [c:50406168]

> （我确实认为，收捐赠是市面上一些本来合法的模拟器的法律死因。）

至于作者是否知情，blensor 注意到一个细节——站点主动把权利人邮箱摆在页面上：

> "Interestingly they kinda already expect that due to their contact details" — blensor [c:50405075]

> （有意思的是，光看他们的联系方式，他们大概早就有心理准备了。）

### 二、EA 不卖，也不承认它存在过

合法性讨论的真正地基，其实是"EA 已经放弃这款游戏"这个事实。MayeulC 一上来就点明了这款游戏消失的原因：

> "This is great, I have been thinking about revisiting this old game. Unfortunately, it is not available for sale anywhere (probably for music licensing issues, see other games such as Alan Wake), and older versions don&#x27;t run as well as they could." — MayeulC [c:50403473]

> （这太棒了，我一直想重温这款老游戏。可惜它在任何地方都买不到了（很可能是音乐授权问题，就像 Alan Wake 那样），而且老版本跑起来也没这么舒服。）

MayeulC 补充说 Alan Wake 是同类案例：当年因为授权到期被从商店下架，如今重新上架，但被删掉了一首曲目（"space oddity"）。而 NFSU2 的灵魂就是它的原声带，连主打曲目都拿不回来，这游戏基本没法重新卖。

Grombobulous 则去翻了 EA 官网的 Need for Speed 页面：

> "It&#x27;s rightfully romanticized when companies fail to make their products easily available for purchase and usable far into the future.<p>Will EA sell me Need for Speed Underground 2? Nope! They won&#x27;t even acknowledge it exists on their website:" — Grombobulous [c:50404802]

> （当公司既不肯让自己的产品能被轻易买到、也不能被用到遥远的未来时，人们浪漫化它就再正常不过了。<p>EA 会卖给我《Need for Speed Underground 2》吗？不会！他们甚至不承认它在自己的网站上存在：）

他没有停在这里，顺手写出了一份著作权法修正案：

> "I think copyright law should be modified to have more consideration for the rights holder&#x27;s commercial abandonment. I would change it to add these parameters:" — Grombobulous [c:50404802]

> （我认为著作权法应当修改，要更多考虑权利人的"商业弃置"。我会加上这些条款：）

条款大意是：作品只要曾经公开发售过，而权利人后来不再以一个理性消费者会购买的方式出售它（或者改变了售卖形态，比如从一次性购买改成订阅，或者把 50 美元的价格改成 3000 美元），那么人们就可以自由复制与再分发，前提是仅限非商业用途，且可以为分摊分发成本接受捐赠，但不得把捐赠设为准入门槛，也不得冒充原始权利方。

也有人当场反驳这套说辞。vel0city 指出这个"旧电影也有人卖"的对照站不住脚：

> "So I can go to the store and buy any of these? No? Huh. Sounds like this is <i>largely</i> untrue for <i>most films ever produced commercially</i>." — vel0city [c:50406084]

> （所以我能去店里把这些全买到吗？不能？嗯。那"多数商业电影都能被买到"这个说法，听起来对<i>绝大多数商业电影</i>其实并不成立。）

### 三、静态重编译到底有多神：WebGPU、WebGL 与 WASM 的能耐

真正让评论区兴奋的技术线，是这条路能不能撑起 3D 游戏。sgt 泼了盆冷水，点名了 WASM 的 GC 问题：

> "I still am not sure whether wasm&#x2F;webgl is suitable for 3d games with some complexity. You&#x27;ll eventually have some GC pauses during game play. This one included, despite the rest of the game being smooth." — sgt [c:50403436]

> （我一直不确定 wasm/webgl 是否适合有一定复杂度的 3D 游戏。游玩中迟早会出现 GC 停顿。这一款也有，虽然其余部分都很流畅。）

但从工具链的角度看，这条路线的成熟度超乎想象。评论里提到的社区基础设施已经很完整：MayeulC 推荐的 recomp.gg 是静态重编译项目的索引站；[th0mk/nfsu2-web](https://github.com/th0mk/nfsu2-web) 是另一个独立的浏览器端口；leni536 则发现 Linux 上的 Lutris 安装脚本已经把这游戏整得很稳：

> "I was pleasantly surprised recently with the lutris install scripts on Linux for NFSU2. I remember a few years ago struggling with it, it ran but often crashed in the middle of the game." — leni536 [c:50404655]

> （最近 Linux 上 Lutris 的 NFSU2 安装脚本让我 pleasantly surprised。我记得几年前折腾这游戏很痛苦，能跑，但经常在玩到一半时崩掉。）

而在触屏与手柄这条线上，还有别人在推自己的浏览器 3D 引擎。theropost 顺手分享了自己的作品：

> "This stuff is fun lately, I&#x27;ve been working on an engine for a while and ported a little game over to the browser here." — theropost [c:50403843]

> （最近这类事情挺有意思的：我一直在做一个引擎，前阵子把一个小游戏移植到了浏览器里。）

### 四、性能两极：一半人卡成幻灯片，一半人在四年前的手机上跑满帧

性能是本帖吵得最凶的分歧点，因为几乎每个人都报了实测，而且结果完全相反。

卡党这边，senfiaj 一上来就是"跑不动"：

> "For me performance is poor, it&#x27;s unplayable. To run the game, I had to turn on Chrome&#x27;s enable-unsafe-webgpu setting." — senfiaj [c:50403802]

> （对我来说性能很差，没法玩。为了跑起来，我不得不打开 Chrome 的 enable-unsafe-webgpu 设置。）

不过他后来自己解决了——加两个 Vulkan 旗标之后世界就正常了：

> "Just enabled a couple of flags (#enable-vulkan, #default-angle-vulkan), now it&#x27;s good." — senfiaj [c:50403909]

> （刚开了两个旗标（#enable-vulkan、#default-angle-vulkan），现在就正常了。）

gbraad 的体验最具体，也最难反驳——除了卡顿，还有个设计问题：

> "I guess this was made with automatic shift in mind? There are no controls for manual shifting on-screen. Did not find an easy way to enable this. Stutters often due to asset loading. Not a very pleasant experience... and likely very illegal to distribute&#x2F;host (though I &#x27;own&#x27; this game)." — gbraad [c:50403521]

> （我猜这是按自动挡设计的？屏幕上没有手动换挡的控制，也找不到简单开启的办法。经常因为资源加载而卡顿。整体体验并不愉快……而且分发/托管这份素材大概非常违法（虽然这游戏是我的）。）

流畅党这边，tap-snap-or-nap 的评价最短：

> "It played perfectly for me, very nostalgic. Amazed how it just worked." — tap-snap-or-nap [c:50403986]

> （对我来说完美运行，怀旧感十足。惊讶于它居然直接就能跑。）

然后是各种刁钻的设备。lbreakjai 在 M2 MacBook Air 上用 Firefox 跑：

> "It&#x27;s odd, it worked flawlessly on a M2 Macbook air running Firefox. I usually have to switch to Chrome for anything fancier than just browsing." — lbreakjai [c:50404511]

> （挺奇怪的，它在一台跑 Firefox 的 M2 MacBook Air 上毫无瑕疵地跑了起来。我平时但凡看点稍微复杂点的东西都得切到 Chrome。）

KMnO4 的对照更狠：

> "For comparison, I get a perfect frame rate on an iPhone 14.<p>Whatever computer you’re using must be slower than a 4 year old phone." — KMnO4 [c:50403887]

> （作为对比，我在 iPhone 14 上拿到了完美帧率。<p>你用的那台电脑一定比一部四年前的手机还慢。）

手机党还有一票证词：graso 的是老 Android（A525G）：

> "It is surprising that it works decently on an old Android phone (A525G)" — graso [c:50404464]

> （在一台老 Android 手机（A525G）上跑得还不错，这让人意外。）

redbell 的是六年前的 S20+：

> "Oh, I really didn&#x27;t expected it to play smoothly on my six years old phone (Samsung S20+),Kudos!" — redbell [c:50404223]

> （我真没想到它能在我这台六年前的手机（三星 S20+）上跑得这么顺，干得漂亮！）

catoc 则是 Safari：

> "For me it worked fine - even on an iPhone running Safari" — catoc [c:50404706]

> （对我来说没问题——在跑 Safari 的 iPhone 上都行。）

Jon-wood 顺手给这个项目找了个更有力的参照系：

> "This game ran smoothly on a PlayStation 2, which is massively less performant than even the cheapest phones these days." — jon-wood [c:50404572]

> （这游戏当年在 PlayStation 2 上跑得很顺，而 PS2 的性能比今天最便宜的手机还差得远。）

至于画面，bajard 提了一个老生常谈的问题：

> "It&#x27;s 2026, and we still haven&#x27;t solved the aliasing problems." — bajard [c:50403878]

> （都 2026 年了，锯齿问题还是没解决。）

### 五、怀旧是有保质期的

技术之外，是本帖最柔软也最分裂的部分：二十年后重开这款游戏，还剩下什么。

donatj 讲的是光线：

> "Something about the like soft almost dream like lighting of this era of games just feels so much more comforting and inviting than todays hyper realistic graphics." — donatj [c:50404519]

> （这个时代的游戏那种柔软、几乎像梦一样的光线，比今天这种超写实画面让人舒服、亲切太多了。）

72deluxe 记得的是科西嘉教学关：

> "I found the Corsica training map to be incredibly difficult when they were trying to train you how to do S-curves and I kept trying to drove around the bends instead of doing a straight line. Ever since then, I&#x27;ve taken roundabouts in the UK like S-curves." — 72deluxe [c:50405224]

> （我发现科西嘉的训练图难到离谱——他们想教你怎么过 S 弯，我却在弯道里绕来绕去，不肯走直线。从那以后，我在英国的环岛都是当 S 弯过的。<p>谢谢你，EA。）

他还记得当年在一台借来的 Elonex 笔记本上反复玩演示关，以及 3dfx 时代雾效和水面的惊艳；还有那位为 EA 做过这游戏音乐的音乐人几年前去世的消息——菜单音乐依然在他记忆里响着。

另一些人则很坦白地承认自己已经不是当年那个小孩了。anal_reactor 的两难最诚实：

> "On one hand I&#x27;m all for preservation of video games. If the publisher refuses to sell it for a reasonable price, then that&#x27;s moral permission for piracy. On the other one... the magic isn&#x27;t there anymore. I&#x27;m not a kid. There are very, very few games I can revisit and actually have fun." — anal_reactor [c:50405162]

> （一方面我完全支持保存电子游戏。如果发行商拒绝以合理价格出售，那在道德上就是给了盗版许可。可另一方面……魔法已经不在了。我不是小孩了，能让我反复重玩并且真的玩得开心的游戏，已经非常非常少了。）

坚持"它就是好游戏"的那派，Xirdus 的说法最简单：

> "To me, NFS Underground 2 is one of those games I can revisit time and time again. It&#x27;s one of the most fun arcade racing games ever made." — Xirdus [c:50406210]

> （对我来说，《NFS Underground 2》属于那种我可以一再重玩的游戏。它是有史以来最好玩的街机向竞速游戏之一。）

多人带来的荒诞感，是这游戏此刻独有的部分。Dries007 一句话概括：

> "The chaos of all of the other players joining in career mode is really funny." — Dries007 [c:50403542]

> （所有其他玩家涌进战役模式时的那种混乱，真的很好笑。）

而 macNchz 已经开始畅想下一个了：

> "I played this when it was new, taking turns at the keyboard of my friend’s gaming PC. Kind of wild to revisit on my phone today and have it work perfectly.<p>I wish the circumstances around abandonware games weren’t so tenuous, there’s so much great stuff out there and reverse engineering with AI unlocks all sorts of cool possibilities. The multiplayer features here have me thinking about other old games that could be brought online and how fun it could be. SimCity 2000 where all the neighboring cities are real and operated by other players…" — macNchz [c:50404449]

> （这游戏刚发行时我玩过，和朋友轮着用他游戏 PC 的键盘。今天在手机上重温而且完美运行，真是 wild。<p>我希望遗作（abandonware）的处境不要这么脆弱，外面还有太多好作品，而用 AI 做逆向工程能打开各种各样新可能。这里的多人功能让我开始想别的老游戏上线会是什么样：比如 SimCity 2000，所有相邻城市都由真人玩家运营……）

### 六、"机器神"和版权：真正会被拷打的可能不是这个网站

本帖最深的一条暗线，是评论区自发地把这件事接到了 AI 上。Ampersander 抛出了那个更大的命题：

> "It could become legal in the future. I don&#x27;t see how we can have machine god and copyright, and it&#x27;s clearly copyright that has to budge." — Ampersander [c:50403870]

> （将来它可能就合法了。我看不出我们怎么可能同时拥有机器神和版权，而显然该让步的是版权。）

thrownawaysz 说得更直接：

> "Steal a game and you are a pirate.<p>Steal 1000 games and you are OpenAI&#x2F;Anthropic&#x2F;Google&#x2F;[insert big tech company name here]" — thrownawaysz [c:50403908]

> （偷一款游戏，你就是海盗。<p>偷一千款游戏，你就是 OpenAI／Anthropic／Google／[在此处填入大科技公司名字]。）

Forgeties79 则泼了盆冷水——盗版从来不主要是为了保存文化：

> "Piracy has never been about the culture or game preservation or whatever. It’s about getting free stuff for 99% of pirates." — Forgeties79 [c:50404982]

> （盗版从来都不是为了什么文化或游戏保存之类的。它就是让 99% 的盗版者免费拿到东西。）

而真正让开发者睡不着觉的是另一头。krapp 担心的是自己的游戏明天就被 AI 抄一百份：

> "I worry more about how this affects smaller and indie developers. As soon as you put out a trailer or any footage a hundred clones of your game will appear on Steam." — krapp [c:50404832]

> （我更担心这对小型和独立开发者意味着什么。你刚放出一个预告或任何片段，Steam 上就会冒出一百个你游戏的克隆。）

xpct 说得更悲观：

> "I think it&#x27;s already very disappointing how badly the systems held against web-wide theft, and how they continue to fail as the tools get better. We built license laundering machines, and the internet is becoming a digital looting playground, where theft is being normalized." — xpct [c:50404856]

> （我觉得这些体系在全网规模的盗取面前的表现已经令人失望透顶，而且随着工具变强，它们还在继续失守。我们造出了洗白许可证的机器，而互联网正在变成数字化的 plunder 乐园，偷窃正在被正常化。）

hombre_fatal 的结论几乎与 krapp 一致，只是方向更狠：

> "Piracy didn&#x27;t kill the gaming industry. I think the bigger threat is indie games that are trivial to clone with AI." — hombre_fatal [c:50405799]

> （盗版并没有杀死游戏行业。我觉得更大的威胁是那些能被 AI 轻易克隆出来的独立游戏。）

而反对派也真的存在：jon-wood 认为版权恰恰是小型独立工作室能活下来的前提：

> "Copyright is a part of what allows small indie studios making fun things possible because it means it’s viable to sell those things and pay people’s salaries." — jon-wood [c:50404605]

> （版权是小工作室能把有趣东西做出来的原因之一，因为只有这样卖东西才养得起人。）

他的完整论点是：著作权让无数人往作品里投入上千小时却得不到保护，这种未来太 bleak；就 NFSU2 这个 EA 都不肯卖的游戏而言，把免费版本扔到网上他没意见，但别把洗澡水和孩子一起倒了。cite_please 顺口补了一句更刻薄的：

> "Having game designers rather than film school hacks might have something to do with it." — cite_please [c:50404618]

> （让游戏设计师来干，而不是电影学院出来的混子，这事可能有点关系。）

### 七、版权法该怎么改，以及这个生态会长成什么样

"商业弃置"这个说法被很多人接住，并且被推到了制度层面。KronisLV 给出了一个更硬的版本：

> "This might be daydreaming and wholly unreasonable, but I think that it should go like this: “As a developer&#x2F;publisher you either provide a product available for purchase for a reasonable price (not larger than release price, adjusted for inflation) OR you are not allowed to take down game preservation efforts.”" — KronisLV [c:50404032]

> （这可能是白日梦，也完全不合理，但我觉得应该这样：「作为开发者／发行商，你要么以合理价格（不高于发行价，并按通胀调整）提供可购买的产品，要么你就不被允许下架游戏保存 efforts。」）

在企业这侧，jareklupinski 讲的是一种更务实的判断标准：

> "i agree, a suit should only be taken seriously if the company can demonstrate that they are actively losing revenue because of the game preservation effort, otherwise toss it in the bin" — jareklupinski [c:50404730]

> （我同意：只有当公司能证明自己因为游戏保存 efforts 而确实在损失收入时，法务才值得被认真对待，否则直接扔进垃圾桶。）

rvz 补充了厂商真正在乎的东西——不是私人重编译，而是未授权分发：

> "These companies don&#x27;t care about ripped and recompiled games if it is done for <i>private</i> use. They only care if the game and its assets are redistributed in an unauthorized manner." — rvz [c:50405279]

> （这些公司不在乎被拆包重编译的游戏，只要是自己私下用就行。他们只在乎游戏和素材被以未经授权的方式重新分发。）

那么这个生态会长成什么样？jareklupinski 给了一条相当务实的生存法则：

> "its not a definite, but it seems that the projects that get taken  down the quickest are the ones that try to run ads &#x2F; monetize the work<p>the people that just put out a cute site and stay low tend not to attract lawyers" — jareklupinski [c:50403926]

> （这不是定论，但看起来被下架最快的项目，都是那些想挂广告／想变现的作品。<p>那些只是摆出一个好看小站、保持低调的人，往往不会招来律师。）

nonethewiser 认为真正的分水岭还没到——如果连素材都是新做的，事情就不一样了：

> "If you actually recreated entirely new assets then it would get interesting. I suppose we will get there, and perhaps sooner rather than later." — nonethewiser [c:50404744]

> （如果你是真的把素材全部重做一遍，那才叫有意思。我猜我们会走到那一步，而且可能比想象中更早。）

sheepscreek 已经开始畅想那一步的样子：

> "Second that, and we&#x27;d get higher quality assets. Game engines could be rewritten&#x2F;rewired to support ray-tracing and what not. Exciting." — sheepscreek [c:50405401]

> （附议，而且素材质量会更高。游戏引擎可以被重写／重接，以支持光线追踪之类的东西。令人兴奋。）

至于音乐授权，Forgeties79 提醒还有另一个更麻烦的权利人：

> "I think they should be far more worried about the music rights holders than EA. When I fired it up I was greeted to a menu playing The Doors &amp; Snoop Dogg lol" — Forgeties79 [c:50405398]

> （我觉得比起 EA，他们更该担心音乐版权方。我一启动，迎接我的菜单音乐是 The Doors 和 Snoop Dogg 合作的歌，笑死。）

讨论的最后，mag7269 用一段模仿 EA 发言体的对白收尾，成了整条帖子的定调：

> "EA: “You software pirates lack honor, you do it just to make a quick buck, just for money! We do it, for glory, for integrity, for respect!”<p>Us, Pirates: “We each do it for what we lack most.”" — mag7269 [c:50404679]

> （EA：「你们这些软件盗版没有荣誉感，你们盗版只是为了赚快钱、只是为了钱！我们是为了荣耀、为了Integrity、为了尊重才这么做的！」<p>我们这些盗版：「我们每个人，只是为了自己最缺的那样东西。」）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 直接追问合法性 | tevlon | 「认真问一句：这合法吗？」 |
| 一句话定性 | hobofan | 不合法 |
| 支持保存但反对收捐赠 | rustyhancock | 为受版权保护的内容收捐赠，极其可疑 |
| 断言站点活不久 | rvz | EA 的律师有压倒性资金，收捐赠等于招人来告 |
| 已经在开玩 | popcar2 | 唯一缺点是不合法，红了估计很快被下架 |
| 建议本地部署 | andix | 先自己备一份，以防哪天没了 |
| 指出捐赠是模拟器的死因 | jimmyjazz14 | 过去就有合法模拟器因为收捐赠翻车 |
| 指出作者其实有心理准备 | blensor | 敢把权利人邮箱摆出来，就是知道会来 |
| 解释游戏为何消失 | MayeulC | 音乐授权到期，Alan Wake 是同类案例 |
| 主张 EA 已商业弃置 | Grombobulous | EA 连官网都不承认这游戏存在过 |
| 提出弃置条款 | Grombobulous | 权利人不再合理售卖时，人们可非商业再分发 |
| 反驳电影类比 | vel0city | 多数商业电影其实也买不到 |
| 质疑 WASM 承载 3D | sgt | 迟早会有 GC 停顿，这一款也有 |
| 给出硬指标 | KMnO4 | iPhone 14 满帧，你的电脑比四年前的手机还慢 |
| 报告卡顿与换挡缺失 | gbraad | 资源加载就卡，屏上还没有手动换挡 |
| 报告跨平台流畅 | lbreakjai | M2 MacBook Air + Firefox，完美运行 |
| 报告手机可玩 | catoc | iPhone 上跑 Safari 也没问题 |
| 给出参照系 | jon-wood | 当年 PS2 上跑得比现在的手机还流畅 |
| 坚持怀旧价值 | donatj | 那个年代柔和得像梦的光线最让人舒服 |
| 承认自己老了 | anal_reactor | 魔法已经不在了，我不是小孩了 |
| 给出制度性方案 | KronisLV | 要么合理定价卖，要么不许下架保存项目 |
| 给出商业标准 | jareklupinski | 证明不了收入损失，法务就不值得被认真对待 |
| 拆穿盗版神话 | Forgeties79 | 盗版从来不是为保存文化，就是免费拿东西 |
| 指出真正威胁 | krapp | 独立游戏一放预告，Steam 上就有一百个克隆 |
| 判定盗版非死因 | hombre_fatal | 真正威胁是能被 AI 轻易克隆的独立游戏 |
| 为版权辩护 | jon-wood | 版权让小工作室能靠卖东西发工资 |
| 提出分水岭 | nonethewiser | 真正重做素材，那才叫有意思 |
| 给出生存法则 | jareklupinski | 想变现的项目死得最快，低调的小站没人管 |

## 总体情绪

这 157 条评论的主轴，并不是"跑得顺不顺"。技术讨论在四五个来回里就分成了两派——一派是 M2、iPhone 14、A525G、S20+ 上的满帧报告，另一派是开了两个 Vulkan 旗标才肯松口的加载卡顿；真正把整条帖子点燃的是"这份东西到底属不属于谁"。几乎所有人都默认了一个前提：EA 已经不卖 NFSU2，甚至不承认它存在。于是这场审判的标的从"偷"滑向了"弃置"——一个把著作权法改了才有的新概念，被人在评论区现场写了出来。

而在合法性之外，另一条更现代的暗线浮出水面：讨论里反复出现的不是 EA，而是 OpenAI、Anthropic、Google。至少有一半人认为，把一份 22 年前的游戏素材重新分发根本不是新闻，真正的新闻是模型可以重新生成一切却不承担同样的义务。"偷 1000 款游戏你就是 OpenAI"这句话被顶到了讨论中央，比"我玩到了 NFSU2"更有力。

至于那个最初的动机——哥哥和二十年前的那个下午——在评论区几乎被彻底淹没了，只在几处缝隙里浮出来：72deluxe 记得科西嘉教学关的 S 弯、macNchz 记得和朋友轮着用键盘、senfiaj 说自己终于能和朋友们再跑几场。EA 至今没在自己的 Need for Speed 菜单里承认过 NFSU2 存在过——这不妨碍它此刻正跑在陌生人的浏览器里，带着二十年前那首菜单音乐，等一个不一定还会回来的下架通知。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Need for Speed Underground 2 online in the browser（主帖，496 分，157 条评论） | <https://news.ycombinator.com/item?id=50403052> |
| 2 | 原文站点：Underground 2 Revived | <https://nfsu2.xyz/> |
| 3 | 底座项目：NFSU2Recomp（x86 → C 静态重编译器） | <https://github.com/TalhaMudo/NFSU2Recomp> |
| 4 | 另一个浏览器端口：nfsu2-web | <https://github.com/th0mk/nfsu2-web> |
| 5 | 静态重编译案例索引：recomp.gg | <https://recomp.gg/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（归档快照 2026-11-07 17:32 UTC，入库 100 条；HN 全量 157 条）及 nfsu2.xyz 站点页面。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中提到的帧率、设备型号、旗标开关与移植项目均为评论区用户的个人实测与陈述，未经独立核实；站点在线人数、下载量等动态数据随时变化，本文未引用。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
