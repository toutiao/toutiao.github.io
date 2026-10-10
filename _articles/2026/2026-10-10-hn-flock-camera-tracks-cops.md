---
layout: post
title: >-
  加拿大小哥造了台反向 Flock 盯警车，警察上门了
date: 2026-10-10
hn_id: 50026555
categories: [articles]
excerpt: >-
  Flock 摄像头泛滥后，第一个被警察上门"提醒"的，是那个造了同款设备反向记录警车的人。
tagline: >-
  你被盯的时候是公民，盯回去就成麻烦了。
---

## 原文概要

> 来源：HN 热门榜 (/news)

一位加拿大 YouTuber 自己动手搭了一套 Flock 风格的摄像头，装在车流经过的位置，目的是记录每一辆警车的车牌、时间和方向——本质上是把执法机关用来盯公民的工具反过来用。几天后，几名便衣警员敲开了他的家门，对设备本身和他本人做了一番"友好提醒"。

Flock Safety 是过去两年扩张最快的车牌识别（ALPR）供应商。它原本讲的故事是"社区安全"：摄像头装在路口，扫到失窃车辆、被通缉人员、被失踪人口家庭登记的牌照就推送给当地警察。公司体量小到可以靠市政合同与州/联邦拨款铺开，Marc Andreessen 是主要投资人之一。

但 Flock 的实际能力和官方叙事差得很远。警方文件与外泄数据反复显示，摄像头不仅识别车牌，还会做人脸识别、嗅探附近设备的蓝牙 MAC、做步态分析，配合 pan-tilt-zoom 可以专门盯行人。查询入口也不限于执法机关——Linework 的本地门店 Home Depot 和 Lowe's 都买过自家型号，跨州联网搜索。

Reddit、Deflock.org、Flockstats.org 这些年攒下来的统计显示，地方警员用 Flock 查"感情纠纷"已不是孤例：IJ 整理过 81 起被举报的案例，其中包括性侵和绑架；CNN 报道的肯塔基案中，一名警员两年内用 Flock 查他的前伴侣超过 2000 次。

讽刺的细节在于这件事发生地：在加拿大安大略省的 Peel 区域（Brampton 所在），北美 ALPR 部署最密集的地方之一。这位 YouTuber 选这里做的实验，本身就是想凸显执法机关口口声声"公共空间无隐私期待"被反向套用时，是什么表情。

## 讨论焦点

### 双标叙事的浓缩

> "Tracking for thee but not for me" — LadyCailin [c:50026731]

> （译文："盯你可以，盯我不行。"）

> "I can see some nuance to this one. Flock is intended to be searchable by law enforcement, not Joe Average. Tracking cops and then publishing that information is not exactly the same as turning Flock back on the Flockers." — rootusrootus [c:50026783]

> （译文："我能看出这事有点微妙。Flock 设计上只供执法机关查询，不是给普通人 Joe 用的。盯警察再把信息发出去，和把 Flock 反过来对 Flock 自己用，是两码事。"）

> "What nuance though? Did everyone give the state permission to sniff after them? Because I did not. And I am almost certain a majority would not be ok with it either. There is a reason people hate flock sniffers." — shevy-java [c:50026822]

> （译文："什么微妙？大家都同意国家来盯自己了吗？我可没同意，而且我相当确定多数人也不会同意。人们讨厌'Flock 嗅探'不是没原因的。"）

讨论从一句六个字的吐槽起头，接着就是"这事是否真的需要微妙的考虑"。原帖作者 rootusrootus 试图为警察的反对反应留点余地，但后续几乎所有回帖都拒绝这份"微妙"——大家的核心观点是：你能在公共场所摄像是公民权利，我没有理由相信你给警察的特权会比给我自己的更多。

### 一段被到处引用的对话

> "\"You have no expectation of privacy in public, citizen.\"<p>\"Officer, do you have any expectation of privacy in public?\"<p>\"That's different.\"" — RunSet [c:50026854]

> （译文："'公民，你在公共场所没有隐私期待。'<br>'警官，请问您在公共场所也没有隐私期待吗？'<br>'那不一样。'"）

这是讨论里被引用最频繁的桥段。RunSet 把最高法院那句关于"公共场所无合理隐私期待"的判例压成三句对话，最后那句"That's different"在没有上下文的前提下显得如此熟悉——它就是这套逻辑被拿来解释一切监控扩张时，最常听到的那句话。

### 监控=骚扰，只是规模替它洗了名

> "what flock is effectively doing would be considered stalking by any other execution method, and the way they're getting around that is because they're stalking <i>everyone at the same time</i> and calling it surveillance instead." — ToucanLoucan [c:50027077]

> （译文："Flock 做的事，换个执行方式就是骚扰。他们能绕开是因为他们同时在骚扰所有人，并把这件事改名叫'监控'。"）

> "If you attach a GPS to your wife's car without her knowledge, you can (and should) be prosecuted. Flock cameras collect the same data (rough location of a vehicle) and they do it for <i>every single vehicle</i> passing their sensor. Then, through analysis of that massive dataset, you can now effectively stalk anyone, in the past, for the cost of a database search." — ToucanLoucan [c:50027077]

> （译文："如果你背着老婆往她车上装 GPS，可以（而且应该）被起诉。Flock 摄像头对每一辆经过的车收集的是同样的数据（车辆大致位置）。然后靠分析这个数据库，你只要花一次搜索的钱，就能有效盯任何人的过去轨迹。"）

ToucanLoucan 的这条被回复最多。她/他把"骚扰"的法律定义拆开，指出 Flock 的整个辩护就靠"批量"二字——同一行为对小群体是非法，对全体就改名叫基础设施。后续讨论里这条思路反复出现，包括为什么不能先看警察数据：因为你一旦看到，所有人都会变得可被回溯。

### 警务滥用是默认状态

> "There's a list of 81 known instances of police stalking romantic interests, sometimes querying Flock hundreds of times:" — redwall_hp [c:50028701]

> （译文："已记录到 81 起警察用 ALPR 跟踪感情对象的案件，有时一次查询就刷几百遍车牌。"）

> "Police officers can stalk their exes over 2000 times:" — ajsnigrutin [c:50028513]

> （译文："警察可以为了盯前任用 Flock 查询超过 2000 次。"）

> "Flock do more than just ALPRs. and have done for a while now. I'm not sure why people keep pointing to the ALPRs while remaining silent on actual facial recognition and tracking." — Intermernet [c:50029213]

> （译文："Flock 早就不只是 ALPR 了。我不懂为什么大家还在提 ALPR，对真正的人脸识别和跟踪反而避而不谈。"）

几个数据点把"执法用途"打回原形。IJ 的 81 起只是被发现的，CNN 报道肯塔基案两年查 2000 次也只是被报道的；讨论里另一个案例是 Flock 自己的文职员工用查询权限盯熟人——这种内控松弛一旦跨部门、跨州展开，几乎不可能被发现，更不可能被追责。Intermernet 提醒别只盯着 ALPR：Flock 的人脸、步态、蓝牙嗅探、PTZ 行人追踪都没有在公开材料里被同等讨论。

### 法律先例其实留了门

> "I would take these attributes of GPS monitoring into account when considering the existence of a reasonable societal expectation of privacy in the sum of one's public movements. I would ask whether people reasonably expect that their movements will be recorded and aggregated in a manner that enables the Government to ascertain, more or less at will, their political and religious beliefs, sexual habits, and so on." — Sotomayor in US v. Jones, quoted by monocasa [c:50027244]

> （译文："在判断一个人是否对其'全部公开行踪总和'具有合理隐私期待时，我会把 GPS 监控的这些属性纳入考量。我会问：当一个人的行动被以这种方式记录、汇聚，并让政府大体上随时可以推断其政治倾向、宗教信仰、性习惯等，普通人是否仍然'合理地预期'这种监控会发生。"）

> "US v. Knotts is the forty-year-old case that is the source of the 'You've no right to privacy when you're on public roads' idea... In addition to establishing that principle, it <i>also</i> considered a possible future where the electronic surveillance... would become sufficiently advanced as to permit 24/7 <i>dragnet</i> surveillance... at which time, courts would need to reconsider what was just and right in light of such dreadfully advanced mass surveillance capabilities." — simoncion [c:50027322]

> （译文："US v. Knotts 这桩 40 年前的案子，是'你在公共道路上没有隐私权'这个说法的源头。判决在确立该原则的同时，<i>也</i>想到了未来一种可能——电子监控技术会发展到足以进行 24/7 全网撒网式监控的程度——届时法院需要基于这种'让人害怕'的大规模监控，重新审视什么是公正和正确的。"）

monocasa 和 simoncion 各自挖出了最相关的两位先例。Sotomayor 在 US v. Jones（2012）的协同意见里明确说，"公共空间无隐私期待"这个框架在大规模监控下应该重新评估；Knotts 案本身在脚注里就承认，如果技术进化到允许 24/7 撒网监控时，法院必须重新审查。现在的处境基本就是 Knotts 那段脚注描述的场景——只是没人去重写判决。

### 反方：操作风险与战术暴露

> "I see no reason for random citizens (especially these self-appointed idiot 'citizen auditors') to know what police are up to, where they are, what they are seeing or saying at every moment of the day." — ButlerianJihad [c:50028984]

> （译文："我看不出普通市民（尤其是那些自封的'公民审计员'）有任何理由去知道警察每时每刻在做什么、人在哪里、看到什么、说什么。"）

> "Police just sitting in their squad car looking at a computer display is not for public consumption. Police inventory of weapons and ammunition, and tallying of shots fired, and who fired them when: that is not public information. Police offering a towel or a garment to a nude woman who's just been raped: why do you want to 'track cops', again?" — ButlerianJihad [c:50028984]

> （译文："警察坐在巡逻车里看显示屏的画面不属于公开内容。警械弹药清单、当次出警谁开了几枪、什么时候开的——这些不是公开信息。警察把毛巾或衣物递给刚被强奸的裸身女性：这种情况下，你为什么还想'盯警察'？"）

少数派立场，主要是 ButlerianJihad 的长帖。论点集中于操作层面：盯警员等于泄露出现场、受害人位置、临检节奏，让有组织犯罪和大规模抗议都能反向调度资源；这种反对的对面是真实受害者权益——警察到场时带的"隐私"是为了保护刚被强奸的人，不是为了给警察自己遮丑。

### 情绪叙事 vs 不对称现状

> "This is one of those emotionally satisfying stories... if you don't think about it very hard. It's symbolically rich, it fits the simplistic narratives of good vs evil we're all raised with, but this isn't a great example of a 'gotcha' moment.<p>Do I like Flock cameras? No. Do I like mass surveillance? No. Do I see a difference between an agent of the state doing something involving law enforcement or surveillance activities, and a private individual doing the same? Yes. You can't run around in uniform handcuffing people either." — EA-3167 [c:50026803]

> （译文："这是一个情绪上很爽的故事……如果你不去深想的话。它象征意义丰富，符合我们从小被灌输的善恶二元叙事，但它并不是一个漂亮的'抓到你了'瞬间。<br>我喜不喜欢 Flock 摄像头？不喜欢。我喜不喜欢大规模监控？不喜欢。但一个国家代理人做涉及执法或监控的事，和一个普通人做同样的事——我看到这两者之间有区别。你也不能随便穿着制服去铐人。"）

EA-3167 这一支在讨论里不算主流，但确实存在：他承认自己也反 Flock、反监控，但强调"警察的执法权和公民的记录权"是不对称设计的产物。后续他进一步补充——只要人们继续投票给公开监控他们的政客，这种事就会继续发生。这条支线让讨论不至于只回响在"全员反对监控"的合唱里，留了一点必要的复杂。

候选方案层面，HN 上讨论得最多的"现有法规对照"是新罕布什尔州 ALPR 法（每 3 分钟删一次无命中车牌图像、上传必须取得搜查令），配上查询日志加密签名、命中记录采用法官持有的解密密钥。共识是：纸面规则对没有执行力的滥用者无效；HN 上跑出来最一致的方案反而是技术护栏，不是法律。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 双标被点名 | LadyCailin, shevy-java, saltwatercowboy | "盯你可以，盯我不行"是最小公约数 |
| 不需要微妙 | rootusrootus 提微妙，几乎所有回帖拒绝 | 警察的反对不能享受"微观考虑" |
| 一句话浓缩双标 | RunSet | "公民没隐私期待，警官呢？""那不一样" |
| 监控=骚扰的换名版 | ToucanLoucan | 同样是 GPS 数据，对一个人是犯罪，对所有人叫基础设施 |
| 警务滥用成常态 | redwall_hp, ajsnigrutin, nalekberov | 81 起、2000 次、"LOL" 备注列 |
| Flock 远不止 ALPR | Intermernet | 人脸/步态/蓝牙/PTZ 才是真正的能力 |
| 法律先例留了门 | monocasa, simoncion | Sotomayor 协同意见与 Knotts 脚注都预设了重审场景 |
| 盯警察会害真实受害人 | ButlerianJihad | 强奸受害者在场也变成公开内容 |
| 情绪爽点 ≠ 理性论据 | EA-3167 | 反 Flock 但拒绝把"公民跟踪警察"当成漂亮反转 |
| 技术护栏优先 | HN 多帖 | 新罕布什尔模式可参考，但缺真实后果 |

## 总体情绪

评论区从一开始就分成了两派，但罕见的是这次连中间地带都很薄。少数像 rootusrootus 这样试图给"警察上门"一点理解的发言被快速回绝；多数讨论直接进入"监控系统现在和过去的差别只在于批量"这一论证。Sotomayor 的协同意见与 Knotts 的脚注被反复引用，恰好说明讨论者并非单纯发泄——他们是在找判例能撬动的缝隙。

Flock 这一波扩张最让技术圈不安的不是"摄像头变多了"，而是"批量"如何替一项原本违法的行为洗白成基础设施。这条线一旦画完，今天是 ALPR，明天就是面部和步态，后天就是 IoT 设备的蓝牙指纹，每一次扩张都用同一套话术："无合理隐私期待、规模不算区别"。讨论里真正的反击不是要求警察拆掉 Flock，而是要求把每一条查询都放进可独立审计的密码学记录——这是技术人对"先上车再补票"的回答。

这位加拿大 YouTuber 选择把实验地点定在 Peel 区，警员上门问话这件事本身就是他的实验结果：能不能反向盯，几天内就知道。最后，问题不是"Flock 还能不能扩张"，而是当公民把同一工具反过来用，执法机关会派便衣上门那一刻，到底是谁在用"公共场所无隐私期待"这条规则。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | YouTuber Says Cops Visited Him After He Built a Flock-Style Camera to Track Cops | https://gizmodo.com/youtuber-says-cops-paid-him-a-visit-after-he-built-flock-style-camera-to-track-cops-2000824306 |
| 2 | HN 讨论 | https://news.ycombinator.com/item?id=50026555 |

## 免责声明

<div class="disclaimer">本文为 HN 讨论摘要，所引用户评论不代表译者立场。所有引文 ID 已在 HN 原文核验。</div>

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
