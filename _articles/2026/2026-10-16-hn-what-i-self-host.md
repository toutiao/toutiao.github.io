---
layout: post
title: >-
  「我没用 Docker」——一台 180 欧元的 Beelink 撑起 28 个服务的 HN 辩论
date: 2026-10-16
hn_id: 50109715
categories: [articles]
excerpt: >-
  一台 180 欧元（rampocalypse 之后同款 359 欧元）的 Beelink Mini PC，CGNAT + IPv6，不暴露任何服务到公网，Podman 跑 11 个、原生 systemd 跑 17 个。AI 泡沫、单二进制 vs Docker、Pets vs Cattle、邮件自托管 20 年史，几条战线同时开战。
tagline: >-
  别人买云，他买了一个不被买的盒子。
---

## 原文概要

[HN 热门榜](/best)（2026-10-15）：viceconsole.fyi 的作者贴出自家 homelab 的完整清单——一台 Beelink S12 Pro Mini PC（N100、16 GB RAM、512 GB SSD + 6 TB HDD），去年 EU 没几个月时花 180 欧元入手，同款现在 359 欧元。文章标题是《What I Self-Host, What I Don't, and Why》，他在开头给了背景：曾在印度住过几年，回欧美后不想为流媒体付西方价格，又被"为你推荐 / 自动下一集"的成瘾机制烦到——于是从 Jellyfin 入手，"切线"切了别的方向。

硬件之外，他的两条铁律：(a) 除了路由器上的 VPN，不暴露任何服务到公网——理由是 AI 辅助黑客让这件事不再"安全就好"，加上 ISP 给的 IPv4 是 CGNAT，VPN 只在 IPv6 上对外可达（"公共 Wi-Fi 几乎永远跑不了"）；(b) 能原生跑就原生跑，能单文件胜过"compose + MySQL + Redis + 三个容器"。Podman 和 systemd 的集成现在已经够好，他"不再用 Docker"——这不是原则问题，是不想再多维护一套服务控制系统。

跑在上面的服务按字母排序 28 个：Actual Budget（理财）、Audiobookshelf（有声书/播客）、Automatic Ripping Machine（"2026 年我还在翻 DVD，英文法文双语"）、Backrest（伴 Restic 的备份 Web UI）、Beszel（监控）、Caddy（反代 + LetsEncrypt）、Cockpit、Forgejo、FreshRSS、Frigate（8 个 IP 摄像头，跑低分辨率避 Wi-Fi 拥塞）、Gonic（两实例给小孩和成人分开音乐）、Gotify（通知）、Home Assistant、Homepage（"服务太多，需要另一个服务来记住服务"）、Immich（"妻子的 Google Photos 终于不爆了"）、Jellyfin（只跑 720p，4K 电视也能看）、MPD、Snapcast、PocketBase（SQLite 当摆设，"前端供老婆用，我还能跑任意查询"）、Readeck、Samba、Syncthing、Transmission、Uptime Kuma、Vaultwarden、Vikunja（Trello 多日宕机后换的）、Yubal。"非服务"一栏是反向清单：*arr 栈（"听起来就太重"）、Collabora、Firefly III（太多容器）、Owntracks、Dawarih（最少四容器，"资源换价值不划算"）、Music Assistant、邮件（"终有一天要从 Gmail 走，但还没想好接谁"）。

收尾处，他给出 `htop` 数字——17 原生 + 11 Podman，内存约 7.5 GB，CPU 30%~40%——并留了一句话给那些被 RAM 涨价劝退的人："希望继续看到把简洁和效率放在第一位的可自托管项目。" 文末他自己列了 Docker vs 原生选择的几个引用帖。

## 讨论焦点

### 自托管是 AI 泡沫的对立面

最热门的根评论把整件事和当下的 AI 估值挂上了钩。

> "People twist themselves into a knot talking about AI as the future. Its more of a bubble waiting to pop. Self hosting is the real disruptive future. The hardware to accomplish most things that we rely on from cloud vendors is absolutely trivial. My own home server is a used super cheap and tiny machine. The hard disks don't even fit in the box and yet it has plenty of CPU and memory to spare. The software is getting easier to configure year after year eventually creeping to the point where elderly people too lost to use a remote will be running this stuff. The real challenge will be solving for easy access to private networks from public spaces across the internet. Right now everybody seems to be centering on vendor solutions like TailScale for this." — austin-cheney [c:50110135]

> （译文：人们一谈 AI 就要把它说成未来。但它更像一个等着破的泡沫。自托管才是真正具有颠覆性的未来。我们交给云厂商的那些事，要跑的硬件根本不值一提。我自己的家用服务器就是一台又旧又小、便宜得要死的机器，连硬盘都装不进盒子里，但 CPU 和内存仍然绰绰有余。软件一年比一年好配，最终会好到连不太会用手机的长辈都能跑起来。真正的难题是——怎么从公网任何地点安全地访问私有网络；现在大家都在围着 Tailscale 这类厂商方案转。）

这条评论把整场讨论钉在了一个更大的叙事上：austin-cheney 把"自托管 vs 云"和"AI 估值"摆在了天平两端，认为前者的颠覆性被严重低估。但下一条回复马上把节奏拉回来了：

> "And believing that the current AI economy might have a period of rapid devaluation in the near future is pretty reasonable. But, much like the original .com bubble, the idea that AI as a technology will not survive and thrive through such a pop, and become an ever more important part of our future, is a belief that I can't comprehend. Anthropic and OpenAI very well may go belly up. AI as a technology isn't going anywhere. And as much as I'd like to believe that more people may self host more things in the future, self hosting will never, even if it was adopted by literally everyone, become as big a deal as AI, even if AI hit a wall tomorrow and didn't get any better than the current frontier models." — MostlyStable [c:50110452]

> （译文：相信 AI 经济会有一轮快速贬值，这很合理。但像当年的 .com 泡沫一样，认为"AI 作为技术"会熬不过这一轮、不会变得更重要——这种判断我理解不了。Anthropic 和 OpenAI 完全可以倒闭，AI 作为技术不会消失。就算 AI 明天撞墙、不再进步，自托管就算被所有人采用，也永远不可能有 AI 那么大的体量。）

中间立场的人最后占了上风：

> "Self hosting is mostly a hobby like home brewing beer or woodworking. It's more accessible than ever but there's still little incentive for the average person to do it. The average user is much safer putting their photos on iCloud than a home server unless they are tech inclined and personally invested in keeping it secure and backed up." — Gigachad [c:50112176]

> （译文：自托管基本上就是个爱好，像自己酿酒、做木工。可及性比以往任何时候都高，但对普通人来说仍然没有动力去做。普通用户把照片放在 iCloud 上比放在家里服务器上安全得多——除非他是技术派，并且愿意亲自去保证安全和备份。）

另一边也有人报喜：

> "&gt; Self hosting is the real disruptive future. Self-hoster reporting in. I got into it about a year ago. Bought a refurbished old Dell mini PC for 300 bucks and turned it into a home server. Debian + several docker containers. I don't know if this is the future, but it feels disruptive. I think it is amazing that I can run my private home streaming service alongside a bunch of other cool things on old hardware and the experience is in many ways superior to actual services that I am charged to use." — surgical_fire [c:50111921]

> （译文：> 自托管才是真正具有颠覆性的未来。自托管人来报个到。我一年前才入坑，花 300 美元买了台翻新的旧 Dell mini PC，改成了家用服务器，Debian 加几个 docker 容器。我不知道这是不是未来，但感觉确实有颠覆性。在旧硬件上同时跑私有流媒体和一堆别的东西，体验在很多方面比我付费用的真实服务还要好。）

> （一条原文带 `&gt;` 引用标记：> Self hosting is the real disruptive future.）

这组讨论的真正底色不是"自托管会不会取代云"，而是"自托管到底给谁用"——austin-cheney 把它写成了普通人的未来，Gigachad 把它说成爱好，surgical_fire 把它当成"惊喜发现"，MostlyStable 干脆说"体量就不在一个量级"。

### 单二进制 vs Docker Compose 之争

作者那句"Love: a service that's a single Go binary"像一根引线，被 mtlynch 当成战场起点：

> "All things being equal, why prefer Docker Compose? From my perspective, a single binary strictly dominates any Docker Compose solution." — mtlynch [c:50110604]

> （译文：其他条件相同时，为什么要选 Docker Compose？在我看来，单二进制在任何 Docker Compose 方案之上严格占优。）

这条评论下面是一个四十多层的子讨论，分成四个互相缠绕的论点。

第一条是"隔离收益"：

> "Some isolation is nice. I say some because I'm told it's security is not to be trusted, but I still like that even a non nefarious binary has ootb boundaries on what state will persist." — unshavedyak [c:50110643]

> （译文：有点隔离挺好。说"有点"，是因为隔离的安全性听说不太可信；但我仍然喜欢——哪怕不是恶意的二进制，至少在默认情况下对什么状态会被持久化是有边界的。）

Gigachad 同意这条，但限定了条件：

> "Docker isolation is likely good enough if you keep your kernel up to date and aren't allowing 3rd parties to run code. If you are running a CI service or something you need micro VMs. But to host your nextcloud server, docker is good enough, it's unlikely someone will both exploit nextcloud and the kernel if you are keeping them up to date." — Gigachad [c:50111048]

> （译文：只要你内核够新、不允许第三方跑代码，Docker 的隔离基本够用。CI 服务那种才需要 micro VM。host 一个 Nextcloud 服务器，docker 够了——只要你的内核保持更新，同时攻破 Nextcloud 和内核的概率不大。）

第二条是把单二进制塞进容器——solid_fuel 把这层讨论上升到了"分发形态决定一切"的高度：

> "Well yes, but that's the point entirely - you can easily put a binary into a docker container, or a jail, or on a VM. But when something is shipped as 5 different docker containers it is MUCH harder to extract it into something you can run without docker or in a different configuration (like sharing a postgres instance between multiple applications). One distribution method is flexible and can be deployed however you want, the other prescribes solutions and makes any customization difficult." — solid_fuel [c:50112257]

> （译文：对，你说得没错，这正是重点——你可以很容易地把一个二进制塞进 docker 容器、jail 或 VM。但当一个东西被发成 5 个 docker 容器，想把它抽成"不用 docker 也能跑"就难得多（比如让多个应用共用一个 postgres）。一种分发方式灵活到你想怎么部署都行；另一种只给方案，不给你改的余地。）

第三条来自一个长篇吐槽，几乎成了整场讨论的"最高赞金句"：

> "docker isolation is nice just as a management boundary. It's nice to be sure applications don't accidently shit all over each other. Like an application that decides to clear /tmp because reasons, or 2 random ones that both store temp state in a /tmp/state.dat for some odd reason. My favorite is applications that conflict on ports. So you go to change the port an application is listening on, the docs say PORT env var so you set it, but it doesn't work. You look through the code (and this is before LLMs) but the config is just a labyrinth of values flowing from god knows where. So you search the repo for PORT and eventually find a PR from 2 weeks ago that changes PORT to ENDPOINT, so you set ENDPOINT, but it still doesn't work. Then you find an issue that was opened last night that the new `ENDPOINT` value doesn't load from env vars because it conflicts with another ENDPOINT_ prefix on another value, instead you need to create a config.toml and set an `endpoint =` in that, so you do that. Then you realize that creating an empty config.toml has now overridden all the previously defaulted values into nulls or empty strings, instead you need to run `foo config-defaults &gt; config.toml` and go edit the endpoint one. Only to realize that there is a secret that the tool uses to encrypt an ephemeral session. if you don't specify one, the tool would auto generate one on startup. The only downside is restarting it logs your client out which isn't a big deal. But now that you switched to config.toml you must set some value there and it can't be empty. Then you're just wondering why the hell did I want to change the port?" — eddythompson80 [c:50112053]

> （译文：docker 隔离好就好在它是"管理边界"——至少能保证应用不会互相踩踏。比如有的应用就因为某种理由决定清空 /tmp，或者两个互不相干的应用偏偏都把临时状态存到 /tmp/state.dat 里。我最爱的还是端口冲突。你想改端口，文档说设置 PORT 环境变量，你设了，没用。你去看代码（LLM 还没出现的时候），配置就是一团乱麻。你去搜 PORT，搜到一个两周前的 PR 把 PORT 改成了 ENDPOINT，你设 ENDPOINT，还是没用。然后你找到一个昨晚开的 issue，说新的 `ENDPOINT` 因为和另一个 `ENDPOINT_` 前缀冲突，不能从环境变量读，得自己写一份 config.toml，在里面设 `endpoint =`。你照做了。结果空 config.toml 把所有默认值覆盖成 null 或空字符串，得跑 `foo config-defaults &gt; config.toml` 再去改那个 endpoint。最后发现工具要一个密钥来加密临时会话——不设也行，启动时自动生成。重启时只是客户端会被踢下线，也没什么大不了。但现在你切到了 config.toml 模式，这个值不能留空。折腾完你只想问一句：我他妈到底为什么要改这个端口？）

> （原文里的 `&gt;` 在终端展示时还原为 `>`，整段是这个用户对"配置地狱"的怒吼。）

最后，steezeburger 把"统一界面"的论点推到极端：

> "I like to have consistent architecture across all my services, and I like to see and configure everything in (mostly) one place. If you're running a single go binary, sure do whatever, but if you're running a go binary, and a *arr stack, and a bookmarking service, home assistant, frigate, etc, it gets out of hand pretty quickly. You're trade a bit of upfront setup (I mean barely now in the age of LLMs) for easier automation and flexibility down the road." — steezeburger [c:50113016]

> （译文：我喜欢所有服务都用一致的架构，所有配置（基本）都集中在一个地方。跑单个 Go 二进制你随意，但当你同时跑 Go 二进制、*arr 栈、书签服务、Home Assistant、Frigate 的时候，没多久就会失控。你前期多花点配置时间（LLM 时代已经基本不值钱），换后期自动化和灵活性的大便宜。）

整条战线说到底没争论"单二进制是不是更省资源"，争论的是"可移植性"和"管理边界"——一边说"被发成 5 个容器就锁死了"、另一边说"被发成单二进制就锁死了配置格式"。这条线下面还附带一个补论：JamesLeonis 指出 `systemd` 可以叫起 `docker compose`，"两边可以一起用"——这条评论点出了本文最被忽视的解法。

### Pets vs Cattle：28 个手工服务是艺术还是反模式

作者末尾说 28 个服务、内存 7.5 GB、CPU 30%~40%，最后一句留给那些"方便却被困住"的读者——但帖子里恰好有一条评论把"Pets vs Cattle"的老梗翻了出来。

> "Pets are OK sometimes! They do need care and feeding, though; some of us don't see that as chores, instead delightful hobbies. I can definitely see the perspective of 'there are better things to do', especially if you don't like those things." — threecheese [c:50111589]

> （译文：Pets 有时候也挺好！它们确实需要照料，但有些人并不把它当琐事，而是愉快的爱好。"还有更重要的事要做"这种视角我能理解，尤其是你不喜欢这些事情的话。）

最短的反对意见：

> "28 is a lot of pets." — usefulcat [c:50112221]

> （译文：28 只宠物可不少。）

但站在 Cattle 那侧的人并不是要否定"爱好"，他们想要的是"爱好 + 自动化"：

> "There is something satisfying in handling a home server as cattle though! I don't do it because I don't care; I do it because it is super satisfying when it has been boringly running for weeks without me doing anything to keep it up beyond paying the electricity bill, upgrades are extremely predictable, etc. Boredom is a feature :D" — surgical_fire [c:50111849]

> （译文：把家用服务器当 Cattle 也挺有满足感的！我这么做不是因为不在意，而是因为它已经好几周什么都没发生、除了交电费什么都不用管，升级也非常可预期——无聊是一种特性：D）

ravenstine 把整个 declarative 阵营都否了：

> "In my experience, when something involves words like 'declarative', 'deployment', 'docker', 'k8s', that's a sign that it will actually involve more fiddling rather than less. But that's just me." — ravenstine [c:50112260]

> （译文：依我看，凡是带"声明式 / 部署 / docker / k8s"这类词的，往往预示着更多"摆弄"而不是更少。只是我个人看法。）

steezeburger 给了完整的反驳——他把 SSH、自动化重启、PR QA 环境都摆出来：

> "I'm running like 10 services on a VPS. I'm a professional software engineer. Do you think I want to ssh into my server and find a bunch of single binaries all over the place to run them? What if a service stops, how do you automatically restart it? How would you automate creation of a qa environment when you create a PR on github so that you can test your changes before they go to prod? Gonna ssh into the server and pull down your repo and build the app and run it? It takes like a day to figure out docker compose and like a week to figure out k8s at a level where you can get things done. Honestly, you can get something working now with LLMs and have them help you understand it in probably less time. Of course I want a declarative deployment for my complex home server. Do you run like 1 app on your home server? It's not 'fiddling' if you know how these things actually work." — steezeburger [c:50113122]

> （译文：我在 VPS 上跑大约 10 个服务，我是职业软件工程师。你觉得我会想 SSH 进服务器、到处找一堆散落的单二进制来跑吗？服务挂了怎么办，怎么自动重启？想在 GitHub 上开 PR 时自动创建一个 QA 环境、让你在上线前先测一下，难道要 SSH 进去拉仓库、构建、运行？学 docker compose 大概一天，学 k8s 大概一周能干实事。说实话，有了 LLM，今天你就能很快上手，让它帮你理解。你当然会想要一个"声明式"的部署来管你复杂的家用服务器。你是不是只跑一个应用？懂行的话这根本不叫"调调"。）

最后是 LLM 把"琐事"门槛一脚踹开的版本：

> "That's what I've been doing. Managing this stuff by hand is awful and I'm not a sysadmin who is good at it. I just added single sign on to my home network for a wide variety of various services. Some of them didn't even support SSO but a quick AI patch fixed that. There is no way I would even attempt that by hand let alone succeed. I saw statements to the effect of 'this would be nice but it's a lot of work' several times in the post. I don't understand why that has to be a blocker anymore. All this tedium is gone." — qwerpy [c:50111313]

> （译文：这就是我一直在做的。手工管这些东西太痛苦了，我又不是能干好的 sysadmin。我刚给我的家庭网络加上了单点登录，覆盖一大票服务，有的根本不支持 SSO，但 AI 改一下就修好了。手工我连试都不会试，更别说成功。我看到帖子里好几次"这挺好但太花时间"，我不懂这怎么还能算障碍——这种琐事已经没了。）

三条轴：手工（爱好）派、声明式派（"无聊是特性"）、LLM 代理派（"把工作踢给模型"）。作者本人显然在第一派，但第二派在这条帖子下的声音也很大。

### 邮件自托管：被夸大的"可怕"和 20 年战斗的真实代价

作者把邮件划进"非服务"清单，理由是"我承担不了发不出去邮件的风险"。这条引出了一段几乎平行于主题讨论的小辩论——但和本文主线共享同一组前提。

> "Self-hosting email fully is tedious/unnecessary, but what you can do is mirror your various inboxes (Gmail, iCloud, proton, non-corporate outlook) with mbsync and use roundcube or some other frontend to view emails and compose. I use this to easily access mail from different services, and I can also send from any of them." — ebrahimh [c:50110744]

> （译文：完全自托管邮件确实繁琐 / 不必要，但你可以用 mbsync 把各家的收件箱（Gmail、iCloud、Proton、非企业 Outlook）镜像过来，再用 Roundcube 或别的 Web 前端收发邮件。我就这么做，几个服务的邮件都能从一处访问，也能从任何一家发出去。）

反驳帖里 caymanjim 把"自托管邮件"这件事拆到了可执行级别：

> "You'll know from bounced email and logs, which you should have monitoring setup on. It's not trivial to run your own email stack, but it's not hard either. It's more tedious than anything. Once it's up and running, it's low-maintenance. And it's fairly trivial to avoid spam. I get vastly more spam in my Gmail than I do on my self-hosted domains. The biggest challenge with self-hosted email is getting an IP address that's not blocked or carrying low reputation. Most VPS IPs from e.g. Digital Ocean, Linode, Hetzner, AWS, etc. are going to get blocked from Google (the strictest) and Yahoo, Hotmail/Live/MS, etc." — caymanjim [c:50111611]

> （译文：从退信和日志就能看出来——前提是你装了监控。跑自己的邮件栈不轻松，但也不难，主要是繁琐。跑起来之后几乎不用维护。避垃圾邮件也容易——我自托管域名上收到的垃圾比 Gmail 还少。最大的挑战是搞到一个没被拉黑、信誉分不低的 IP。DO、Linode、Hetzner、AWS 的 VPS IP 大概率会被 Google（最严的）、Yahoo、Hotmail/Live/MS 拉黑。）

真正的反对声音来自一个"自托管邮件二十年"的人：

> "I self-host e-mail, because I am stubborn - I have done it for 20 years. I would not recommend anyone do it if they aren't already, or if they well-and-truly want to be on call for their homelab. ... My brand-new ISP wouldn't allow TCP port 25 inbound, and wouldn't relent. I had to go back to the old ISP. SPF became mandatory at Gmail, but I didn't get the memo, and Google started bouncing my mail one random day. My residential IP ended up on a 'policy blacklist', one it could never get off because it's blacklisted by virtue of being a residential IP, not that it did something bad." — don-code [c:50112046]

> （译文：我自托管邮件，因为我倔——我已经自托管 20 年了。但我不推荐任何人去搞，除非你本来就在搞、或者你真的愿意为你那个家用服务器随时待命。 ... 我的新 ISP 不让 25 端口入站，连商量都不商量。我只能换回老 ISP。SPF 在 Gmail 变成硬性要求那天，我没收到通知，Google 突然就开始退我的邮件。我住宅 IP 进了一个"政策性黑名单"，怎么都出不来——不是因为它干过什么，而是因为就因为它是住宅 IP。）

dhrnick1 给出了简洁的反向总结：

> "Certainly not unnecessary if you care about privacy and Google not reading your mail. Is it tedious? Not really for someone with a basic command of Linux and computer networking. Even in the pre-AI days, it only took me an afternoon to set up Postfix/Dovecot, and a few more days to refine various aspects of the setup and to write a bash script that can rebuild the whole thing on a new machine. There is basically no ongoing maintenance at all. The Dovecot syntax changed in Debian 13, and Claude translated the old config file in less than a minute. If you are willing to use a Dockerized solution, it's even less work, but I personally like to run this kind of thing bare metal and control every aspect of the setup." — drnick1 [c:50113463]

> （译文："完全自托管邮件没必要"这话不对——如果你在乎隐私、不想被 Google 读信，那就有必要。繁琐吗？对 Linux 和网络基础有基本了解的人来说，不繁琐。LLM 出现之前我搭 Postfix/Dovecot 也只用了一个下午，再花几天调一调、写个 bash 脚本就能在新机器上重建。基本不需要任何持续维护。Debian 13 里 Dovecot 语法变了，Claude 一分钟就把旧配置翻完了。愿意用 docker 化方案的话工作量更少，但我是个人喜欢裸金属、想控制每一个环节。）

整条小战线的真相取决于"你在不在乎那 25 端口能不能进"——在乎的人和不在乎的人根本不在同一个问题空间。

### 不暴露公网，LetsEncrypt 怎么签

这条短但技术含量高——是作者规则一（"我不暴露任何服务到公网"）和 Caddy 用法之间的实际漏洞。jamesstidard 一眼就指出来了：

> "Heya, nice read. I'm wondering how you managed to get LetsEncrypt certs minted when your caddy isn't exposed to the public internet. Doesn't LetsEncrypt need to make a request back as part of the handshake to mint/refresh the certificate? Would love to know as I wanted to do the same in the past and ended up self signing certs." — jamesstidard [c:50110764]

> （译文：你好，写得不错。我有个疑问——你的 Caddy 没暴露到公网，是怎么拿到 LetsEncrypt 证书的？证书签发 / 续签不是需要 LetsEncrypt 反过来访问一下吗？我以前想这么做，最后只能签自签名证书。）

答案一句话：

> "Use the DNS-01 challenge." — hexfish [c:50110781]

> （译文：用 DNS-01 校验。）

短、干脆、对——LetsEncrypt 的 HTTP-01 必须能访问到你的服务器，但 DNS-01 只需要一条能被 Let's Encrypt 公共 DNS 看到的 TXT 记录，对没公网 IPv4 的家用服务器刚刚好。这条短线程说明了本文里没明说但隐含的全套策略：Caddy + Cloudflare DNS 插件 + IPv6 only VPN + DNS-01。

### *arr 栈"重 / 脆弱"的反驳

作者把 *arr 栈列入"非服务"，理由是"听起来就太重、太容易崩"。这条理由被至少两条评论直接反驳。

> "I just checked on my *arr stack. Sonarr and Radarr idle at 157MB and 159MB of memory and approximately no CPU. Jellyfin currently idles at 330MB. I'm not sure where you got this impression from. I grant these tools are complicated and have somewhat clumsy UX, but they aren't especially heavy to run and are not fragile. OP, point your :robot: at https:&#x2F;&#x2F;github.com&#x2F;subdavis&#x2F;selfhosted&#x2F;blob&#x2F;main&#x2F;docker-compose.yml and ask for an explanation. It's a single compose file that illustrates how the *arrs, transmission, and jellyfin all work together. I'm sure you can set it up :)" — eleventen [c:50110986]

> （译文：我刚查了一下我的 *arr 栈。Sonarr 和 Radarr 闲置时分别吃 157 MB、159 MB 内存，CPU 几乎不动。Jellyfin 闲置 330 MB。不知道你这印象从哪来的。我承认这些工具复杂、UI 有点笨，但它们既不重也不脆。楼主，把你的 `:robot:` 指到 https://github.com/subdavis/selfhosted/blob/main/docker-compose.yml 让它给你讲一遍。这是一个 compose 文件演示了 *arr、transmission 和 jellyfin 怎么连起来。我相信你能跑起来 :)）

Cyph0n 给出了推荐的栈组合：

> "Indeed. The other thing to point out is that, once you have set them up, they will chug along fine for years with near zero input. Here is the stack I recommend: * Radarr (movies) with optional second instance for 4K versions * Sonarr (shows) with optional second instance for 4K versions * Sonarr (anime), separate instance to have control over quality settings * Prowlarr (tracker/indexer management) * SABnzbd (Usenet) * qBittorrent (torrents) I would also recommend consulting the TRaSH guide to tune your setup and ensure you're grabbing quality releases. From there, the next logical step is Profilarr :)" — Cyph0n [c:50111148]

> （译文：确实。另一件事——一旦设好，它们可以几乎零输入跑几年。我推荐的栈：* Radarr（电影）可选第二实例跑 4K * Sonarr（剧集）可选第二实例跑 4K * Sonarr（动画）独立实例以控制质量 * Prowlarr（tracker/indexer 管理）* SABnzbd（Usenet）* qBittorrent（torrent）。另外建议看一下 TRaSH guide 调你的配置，保证拿到的是高质量版本。下一步自然的进阶是 Profilarr :)。）

作者的"听起来太重"是一条典型印象流——被反驳之后，Cyph0n 给出了和原作者 Vaultwarden 选型同样的"先看一周数据再说"的反向建议。

### Snapdragon ARM Mini PC 异军突起

最意外的一条评论和清单无关、和辩论无关、和硬件习惯都无关：

> "I recently bought a Lenovo Mini PC (01Q8X10) for under £300 that has a Snapdragon X1 CPU (and 32GB LPDDR5 RAM!) and it's turning out to be perfect for self-hosting running the newly released WSL Containers on Windows 11 with WSL 3 (it doesn't fully support Linux yet). Podman had some issues with WSL 3 that they're still releasing fixes for, but it's all working with that too." — jordand [c:50110722]

> （译文：我最近买了一台 Lenovo Mini PC（01Q8X10），300 英镑不到，CPU 是 Snapdragon X1（32GB LPDDR5 RAM！），跑 Windows 11 的 WSL Containers（WSL 3 刚发布），结果意外地非常适合自托管（WSL 3 还没完全支持 Linux）。Podman 在 WSL 3 上还有些问题，官方一直在发补丁，但也都能跑。）

这条评论把本文一直隐含的硬件前提——x86、Intel N100、Beelink S12 Pro——打开了一个新的口子。Snapdragon X1 是 ARM，WSL 3 还在路上，Podman 兼容还在补——但 32 GB RAM、300 英镑以下，意味着"homelab 硬件"已经不再绑定 x86。这条评论没得到太多直接回复，但和文章开头"rampocalypse 把 Beelink S12 Pro 价格从 180 打到 359"形成了一个几乎没人明说的对仗：DRAM 和 x86 小盒子涨价的同时，ARM Windows mini PC 的另一条线正在悄悄进入同样的位置。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 自托管是 AI 泡沫的真正对立面 | austin-cheney [c:50110135] | "Self hosting is the real disruptive future." |
| 自托管是爱好，不是替代品 | Gigachad [c:50112176] | "Self hosting is mostly a hobby like home brewing beer or woodworking." |
| 单二进制严格优于 Docker Compose | mtlynch [c:50110604] | "A single binary strictly dominates any Docker Compose solution." |
| 容器化的价值在于"管理边界" | eddythompson80 [c:50112053] | docker 隔离让应用不会互相踩踏，端口冲突能少一半 |
| 单二进制灵活性被高估 | steezeburger [c:50113016] | 多服务跑久了，需要一致的界面而不是各自一套 |
| 28 个手工服务是艺术 | threecheese [c:50111589] | "Pets are OK sometimes! They do need care and feeding, though" |
| 28 个手工服务太多 | usefulcat [c:50112221] | "28 is a lot of pets." |
| 邮件自托管被夸大可怕 | ebrahimh [c:50110744] | mbsync 镜像各路邮箱，Roundcube 一处收发 |
| 邮件自托管的真实代价 | don-code [c:50112046] | 20 年里被 ISP 锁 25 端口、SPF 强制、住宅 IP 上政策性黑名单 |
| *arr 栈"重 / 脆弱"印象被反驳 | eleventen [c:50110986] | Sonarr / Radarr 闲置 157–159 MB，CUP 几乎不动 |
| LetsEncrypt 在无公网下的解法 | hexfish [c:50110781] | "Use the DNS-01 challenge." |
| ARM Mini PC 进入 homelab | jordand [c:50110722] | Snapdragon X1 + 32 GB LPDDR5、300 英镑、WSL 3 / Podman 兼容中 |

## 总体情绪

整场讨论没有收敛到任何一派胜出。作者的"28 个服务、零记忆 API"被一些读者当成 homelab 的最高境界、被另一些读者当成"28 只 Pet 需要 28 倍照料"的不等式，被 steezeburger 用来反问"为什么不用 docker compose 一份配置管所有服务"。Docker vs 单二进制的争论则从来没走出过"我承认有道理，但……"的循环，双方都承认对方说得对、但都不愿意把"自我说明"这件事交出去。

邮件自托管、*arr 栈、ARM 硬件这三条支线都共享同一个底层态度：作者给出的不是"最优解"，而是一份自洽的"个人答案"。讨论的价值不在于纠正这个答案，而在于用各种边缘场景把这个答案顶到变形——mbscript 等住宅 IP 进政策性黑名单、Sonarr 等 *arr 在闲置时只占 160 MB、Snapdragon X1 跑 WSL 3 还没完全打通但已经在跑。

这种讨论的真正结果是清单本身不重要，重要的是清单背后那条规则——"我承担得了失败"——而这条规则才是作者和整个讨论之间的真正公约数。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | What I Self-Host, What I Don't, and Why | [item?id=50109715](https://news.ycombinator.com/item?id=50109715) |
| 2 | What I Self-Host（原文博客） | [viceconsole.fyi](https://viceconsole.fyi/blog/2026/10/10/what-i-self-host/) |
| 3 | Tarvis.io（自托管安装助手，scottydelta 在帖中提及） | [item?id=50109715](https://news.ycombinator.com/item?id=50109715) |
| 4 | Cyph0n *arr 栈推荐 | [item?id=50109715](https://news.ycombinator.com/item?id=50109715) |

<div class="disclaimer">

本文内容综合自 HN 讨论及被引用博客，引用评论均保留英文原文与作者署名 / 帖内链接。所有事实陈述以 HN 评论与原作者博客为准；译文与解读为编辑整理。讨论归焦点、立场及数据点引用条目请见文中 `典型观点一览` 与 `讨论焦点` 章节。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>