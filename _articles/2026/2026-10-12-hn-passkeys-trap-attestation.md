---
layout: post
title: >-
  「Passkeys 是个陷阱」 — HN 讨论：抗钓鱼的护身符，怎么就变成了「被网站反向锁号」的入场券
date: 2026-10-12
hn_id: 50048312
categories: [articles]
excerpt: >-
  一篇 Substack 长文把 WebAuthn 的 attestation 机制剥开给普通用户看——你登录用的「钥匙」可能被网站要求只能由指定硬件生成，备份和迁移都归厂商管。HN 评论区技术派反击 Apple 不会配合、银行场景才是真威胁；工程派则拿 YubiKey 摔过跟头、1Password 把 userVerification 改 required、买房时银行冻款等真实经历，回怼「passkey 是钓鱼终极解」。
tagline: >-
  抗钓鱼的设计，反过来成了不让你登录的理由。
---
## 原文概要

2026 年 10 月 11 日，HN 用户 laurex 投递了 Substack 通讯《Non-Functional》（署名 The Hack，开通一天）上一篇长文 [Passkeys are a trap](https://nonfunctional.substack.com/p/passkeys-are-a-trap)，到 12 日上午它已经拿到 393 分、219 条评论。标题很挑衅，但作者在评论里讲清楚了真正目标读者——还没用 passkey、或者刚开始用的人。整篇文章的核心不是「passkey 不能用」，是「passkey 现在能用，但 attestation 部署条件会一步步成熟」。

原文把 WebAuthn 的 attestation 机制拆给普通用户看：网站在注册阶段可以要求你提供「这把 passkey 是哪个软件栈、哪块硬件生成的」这条证明。一旦「attested passkey」普及，网站就可以把登录资格限定在厂商批准的设备、操作系统、密码管理器上——你换 Linux 桌面、换 GrapheneOS、换 KeePassXC，统统过不了审；公钥密码学「私钥你说了算」这条核心承诺在 web 登录场景就失效了。

文中用了一个具体场景说明这个 trap：先给用户一个看上去正常、跨设备可备份的 passkey，等覆盖率达到「绝大多数」，再悄悄加上 attestation 校验——典型的「温水煮青蛙」。作者在文章最后一段（addendum 之外）特别强调 passkey 真正好的地方是「domain-bound，天然抗 MITM」，但补一句「我自己这篇文章通篇没怎么提这一点」——这反而成为评论区技术派反击的一个支点。

讨论的真正分裂不是「passkey 是不是钓鱼终极解」，而是「attestation 会不会真的被部署、谁会先动手、银行 vs 消费互联网服务谁会先推」。两个阵营的争论还顺手把 1Password 最近的 `userVerification: required` 改动、Reddit 上周开始拒绝自定义域名邮箱、银行冻款等近期事件都拽进了战场。

## 讨论焦点

### 文章的真正警告：attestation 是「被网站反向锁号」的入口

> "I like the writing in this article. The author did warn us, but the punchline takes a while to get to: 'I'd like to be clear that there are legitimate uses of remote attestation. By using a website that requires attested passkeys you can be sure you stay safe from accidentally installing a scammer's fake passkey application that steals your data — the website will reject such a passkey. You might want an attested Passkey even if the website doesn't require it, since you can use attestation to verify that your software has not been tampered with by a hacker while you weren't looking. As for reasons to not want attestation: you might want to be able to use software that Twitter (formally X) doesn't specifically approve of, such as Linux. Or a phone with a refurbished operating system.'" — MathMonkeyMan [c:50050194]
> （译文：我喜欢这篇文章的写法。作者确实在警告我们，但「点睛之笔」藏在很后面——「我想说清楚，远程 attestation 有合法用途……而不想用 attestation 的理由是：你可能想用 Twitter（前 X）不批准的 Linux，或者一台刷过非官方 ROM 的手机。」）

作者本人 nonfunctional 也在评论里回了一条「温水煮青蛙」的实际部署路径：

> "Be that as it may, they can still roll out the passkey attestation requirement gradually, — 'flip the switch' just a few thousand users at a time — so that at no one point in time is there a large blip in users. Truth be told, tech platforms don't even really need to measure what portion of users' devices support remote attestation, since the overwhelming majority of devices will support it. They just need to know that users are passkey-capable in the first place; once enough users have passkeys in any form, they can start requiring remote attestation. As for the browser permission prompt: Firefox simply warns you that the site is 'requesting extended information about your security key which may affect your privacy.' It does not make it at all clear to the user that what's really happening is the website is gating access behind a specific approved software stack." — nonfunctional [c:50050610]
> （译文：尽管如此，他们仍可以分批逐步上线 attestation 要求——每次「切开关」只影响几千用户，任何时间点都不会出现明显异常。说实话，平台甚至根本不需要先统计用户设备对远程 attestation 的支持率，因为绝大多数设备会支持；他们只需要先确认「用户已经在用 passkey」，一旦存量够大，就可以开始要求远程 attestation。至于浏览器的权限提示，Firefox 只是温和地警告用户「网站正在请求关于您安全密钥的扩展信息，可能会影响您的隐私」——完全没有讲清楚实质上是网站在用一个特定软件栈做门禁。）

tavavex 把这条进一步推到底：

> "This is already in the spec. It's not some faraway hypothetical, they could start requiring this tomorrow if they wanted to. And if you're capable of seeing any trends wrt the 'attestation' and 'securing' everything that are already here, you will know that all they're waiting for is for a significant enough portion of users to get passkeys on their platforms naturally, and then just force everyone else." — tavavex [c:50050321]
> （译文：这条已经在 spec 里了，不是「远期假设」，他们想的话明天就能开始要求。只要你能看到 attestation 和「把一切上锁」这些已经在发生的大趋势，就会明白他们等的只是「足够多的用户自然把 passkey 装上」，然后强制推给剩下的人。）

### 技术派：attestation 不会发生，Apple 已经把门关上了

最高赞的 top-level 评论（agwa）直指文章前提有问题：

> "Note that attestation can only be required during credential registration; at login time it's not possible to retroactively require attestation if it wasn't obtained during registration. And browsers will throw up a permission prompt if a website requests attestation. Are Netflix and Twitter currently requesting attestation when people register passkeys, and rejecting the registration if the user declines the permission prompt? I very much doubt it, since Apple's passkey implementation doesn't support attestation. Therefore, the author's scenario that sites will wait until most of their users are using attested passkeys and then 'flip the switch and start rejecting non-attested passkeys' isn't very plausible. Attestation is certainly a stain on the WebAuthn spec, and it would have been better if Chrome and Firefox didn't support attestation (unless perhaps the browser is enrolled in enterprise management), but this blog post is presenting a hypothetical and unlikely scenario." — agwa [c:50048830]
> （译文：注意 attestation 只能在凭证注册阶段被要求；登录阶段不可能追溯要求注册时没拿到的 attestation。网站如果请求 attestation，浏览器会弹权限提示。Netflix 和 Twitter 现在是不是在用户注册 passkey 时就强制要 attestation、用户拒绝就拒绝注册？我很怀疑，因为 Apple 的 passkey 实现根本不支持 attestation。所以作者「等大多数用户都用上 attested passkey 再开开关、拒绝非 attested」这个剧本不太成立。Attestation 确实是 WebAuthn spec 上的污点，最好 Chrome 和 Firefox 别支持它（除非浏览器处于企业管控下），但这篇博客在讲一个假设性、概率不高的场景。）

WorldMaker 强调 Apple 的态度是公司级立场：

> "Also worth point out that Apple consumer devices intentionally do not support attestation at all, and only support it for devices under enterprise management. That's still a dominant enough number of devices in the US at least that a consumer site seems unlikely to want to disable/break logins for all iOS and iPadOS users." — WorldMaker [c:50050744]
> （译文：还要指出，Apple 消费级设备有意完全不支持 attestation，只有企业管控的设备才支持。仅在美国这一块市场就仍然占很大比例，任何消费类网站都不太可能想直接打掉/弄坏所有 iOS 和 iPadOS 用户的登录。）

djfergus 把矛头转向 Google：

> "Attested passkeys are a dream for Apple. While google is sliding down this slippery slope fastest (eg MEETS_STRONG_INTEG..." — djfergus [c:50050148]
> （译文：Attested passkey 对 Apple 是天上掉馅饼。真正沿这条滑坡滑得最快的是 Google（比如 MEETS_STRONG_INTEG……）

不过 throwawayffffas 立刻把反例拽出来——银行才是真正可能「先动手」的：

> "> It's going to be the banks first." — throwawayffffas [c:50049153]
> （译文：银行会先动手。）

### 巨头推 passkeys 的真正动机：生态护城河

反对派把争论从技术层面拉到巨头商业动机。throwawayffffas 抓住 agwa 反驳中的「自由选择」逻辑反打：

> "I kind of agree, the problem is not individual sites consuming passkeys. The main problem in my mind is on the side of the vendors, attestation, secure hardware, etc is all an excuse to lock you in to their device/ecosystem." — throwawayffffas [c:50050214]
> （译文：我部分同意，问题不是单个网站如何使用 passkey。我看来真正的问题在厂商这一侧——attestation、安全硬件这些都是把你锁进他们设备/生态的借口。）

supertrope 把银行场景讲得更具体：

> "Banks want attested terminals and for the customer to pay for them. An even better deal for the bank than ATMs, kind of like of how cable TV boxes enforce DRM on the customer and are paid for by the customer." — supertrope [c:50049869]
> （译文：银行想要带 attestation 的终端机，费用还要用户承担。这比 ATM 对银行还划算，就像有线电视的机顶盒——DRM 让用户付费、自己买单。）

crote 补充 cloud 端锁定的角度：

> "Because the various cloud providers want to lock you into their own proprietary ecosystem, of course. How else could the..." — crote [c:50050547]
> （译文：因为各家云厂商想把你锁进自己的专有生态。不然还能为什么？）

dingaling911 已经先动起来：

> "I just got a LLM to write a user script that blocks pass key requests: (() => { // Sites check `wi..." — dingaling911 [c:50051092]
> （译文：我刚让 LLM 写了个 user script 拦截 passkey 请求……）

### 温水煮青蛙剧本：从可选到强制的 5 步

xg15 把 passkey 的推广路径写成了一个标准剧本：

> "Sorry, bit this is just the standard 'boil the frog' playbook that tech companies always use for user-hostile features. It's usually: 1) There is this new entirely optional feature, but it's not relevant to you, so feel free to ignore it. 2) The feature is now active by default, but no worries, there is a simple button for you to opt-out. 3) The feature is active by default, but because we value our users, there is an option in the advanced settings to deactivate it. 4) Our data shows that 99.9% of users activated the feature, but if you belong to the handful of diehards who still refuse to use it (rolls eyes), you can use this obscure command line flag or about:config entry to turn it off 5) Managing opt-out infrastructure for the feature has significant maintenance and security cost that we feel, we can no longer justify. Therefore, effective in three months, the opt-out flags will stop working and the feature will become mandatory. According to our metrics, this will affect 0.0001% of our users, so no disruption is expected." — xg15 [c:50050554]
> （译文：抱歉，这就是科技公司对待敌对用户功能的标准「煮青蛙」剧本。通常是：1）新功能完全可选，跟你无关，请随意忽略。2）功能默认开启，没关系，有一个按钮可以 opt-out。3）功能默认开启，但「我们重视用户」，高级设置里可以关。4）数据显示 99.9% 的用户已经开启了，但如果你属于那少数坚持不开的（翻白眼），可以用这条隐藏的命令行 flag 或 about:config 项关掉。5）管理 opt-out 基础设施的维护和安全成本太高，我们觉得无法继续承担。因此三个月后 opt-out flag 失效、功能变成强制。指标显示这只会影响 0.0001% 的用户，预计无任何影响。）

aidenn0 给出了 2026 年的两个近期案例做佐证：

> "The 'there is something wrong with you if you are at all off the beaten path' has cropped up a lot more for me recently; two examples both from 2026: 1. You can't use Firefox with our website (when I got this popup, I thought I had been transported back in time 20 years, but with Chrome substituted for IE). 2. You can't sign up for accounts with an e-mail from a 'custom domain' 2a. I ran some tests; it's the domain itself, not the host, so e.g. foo@gmail.com is allowed but not a foo@somewhereelse.com, even if hosted by google). 2b. After a bit of back-and-forth with support: 'No, we won't tell you the list of allowed domains, but gmail and hotmail both will work.'" — aidenn0 [c:50050110]
> （译文：「只要你不走寻常路，平台就觉得你有问题」——这种逻辑我最近撞到的频率高多了，2026 年的两个例子：1）你不能用 Firefox 上我们的网站（看到弹窗我以为自己被送回了 20 年前，只是 IE 换成了 Chrome）。2）你不能用「自定义域名邮箱」注册账号。2a）我做了些测试，问题在域名本身而非 host，比如 foo@gmail.com 允许，但 foo@somewhereelse.com 不允许，即便它托管在 Google。2b）跟客服来回几轮：「不，我们不告诉你白名单，但 gmail 和 hotmail 都行。」）

adithyassekhar 补充 Reddit 刚刚的变化：

> "Reddit used to allow that till last week and now they started rejecting those emails. RIP temporary mail services and throwaway accounts." — adithyassekhar [c:50050530]
> （译文：Reddit 之前一直允许自定义域名邮箱，上周开始也拒绝了。临时邮箱服务和一次性账号要完了。）

stavros 被这套剧本说服了：

> "Oof, this comment convinced me to go from loving passkeys to 'maybe I should be careful'. However, I don't think these are technological issues, I think they're policy issues. We need to vote for freedom of computing, and against corporations doing whatever the hell they want." — stavros [c:50049773]
> （译文：哎，这条评论让我从「passkey 真香」变成了「我得小心点」。但这些不是技术问题，是政策问题。我们得为「计算的 freedom」投票，反对企业为所欲为。）

### 文章没说的事：passkey 真正解决的钓鱼/MITM/TOTP 共享密钥问题

但单纯批 passkey 也被骂——danpalmer 把文章最大的「漏讲」拎出来：

> "The very last thing, past the conclusion, the very last footnote is: > Addendum: I feel I have made a compelling case for passkeys in this article. And I haven't even pointed out one of their best security features: they are (in most use cases) domain-bound, meaning they are resistant to what are called Man-In-The-Middle attacks. I made a compelling case... but didn't point out the most important security feature that motivated passkeys in the first place. Honestly I don't think this post did make a compelling case. There's a lot of assuming bad faith on the part of the FIDO alliance, while completely missing that preventing MITM attacks was a key design feature. The FIDO alliance members deal with stolen accounts all the time, and passkeys largely solve that. Stealing accounts is almost always done with phishing or social engineering, and passkeys solve the former and reduce the surface for the latter." — danpalmer [c:50048888]
> （译文：在结论之后、最后一条脚注，文章自己写了：「Addendum：我自认为在文章里为 passkey 提出了有说服力的论据。但我居然没提它们最好的安全特性之一——在大多数场景下，passkey 跟域名绑定，能抗所谓的中间人攻击。」……我得说，这篇文章并没有提出有说服力的论据。它大量假设 FIDO 联盟有恶意，但完全漏掉了「抗 MITM 是核心设计目标」这件事。FIDO 联盟的成员每天都在处理账号被盗，passkey 大幅缓解了这一点。盗号绝大多数都靠钓鱼或社工，passkey 解决了前者、压缩了后者的攻击面。）

MBCook 顺手把「数据库泄露」这条加进来：

> "If the credentials get stolen from a website database, they're useless for every other website on earth. No matter how poorly they're stored, it's just a public key and is not useful. Hell, they can get code executing on the webserver that collects full login information, and it's not useful. Passwords always require full transmission. Hashing for storage requires a proper implementation, which we've seen does not happen. 100% of the time. There's a reason hackers are still stealing passwords from websites after three decades. Passkeys solve that. Nothing else available to the average user does." — MBCook [c:50050832]
> （译文：如果凭证从网站数据库里被偷出来，对地球上其他所有网站都毫无用处。不管它怎么存的，都只是公钥、没用。就算攻击者在 web 服务器上跑代码拿到完整登录信息也没用。密码必须完整传过去，存储哈希需要正确实现——而我们 30 年来看到的是这从来都没做到位。黑客 30 年来还在偷密码，是有原因的。Passkey 把这件事解决了，普通用户能用的其他方案一个都没做到。）

ttul 用一句话总结核心优势：

> "TOTP is susceptible to man in the middle attacks. Passkeys are not. That alone is a solid reason to favor Passkeys!" — ttul [c:50049418]
> （译文：TOTP 抗不住中间人攻击，passkey 可以。光这一条就是支持 passkey 的充分理由。）

但 tgma 又把数据抬出来：

> "Hard disagree. Phishing is a major problem. Passwords+OTP are phishable[1]--passkeys are not (the signature is bound to the domain and cannot be forwarded). That alone makes passkeys worthwhile for the vast vast majority of consumers. This is not a theoretical threat model. You simply cannot realistically expect even a savvy consumer to be able to save themselves from phishing all the time. One mistake and they are fucked. If you write a long article about the merit of passkeys and there is no occurrence of the string 'phish' in your article, I am afraid I cannot take your rant seriously. Again, this stuff is not merely theoretical. YubiKeys have been a thing at Google and other major tech companies for almost two decades now and the effects are well-studied." — tgma [c:50049083]
> （译文：强烈反对。钓鱼是主要威胁。密码+OTP 都能被钓，passkey 不行（签名跟域名绑定、不能被转发）。光这一条就值得为绝大多数消费者上 passkey。这不是纸面威胁模型——你没法指望哪怕熟练的消费者次次躲过钓鱼，一次失误就完蛋。你写一篇长文讨论 passkey 的价值，文章里居然没有「phish」这个词，抱歉我没法把你的吐槽当回事。这套东西不是假设，Google 等大厂用 YubiKey 快二十年了，效果是有研究背书的。）

kccqzy 反过来把 Cisco Talos 2026 Q1 数据摆上来：

> "That's not correct - more than 1/3 of initial access is by phishing at present, according to Cisco Talos (and others major security publications largely agree with this). Ref: https://blog.talosintelligence.com/ir-trends-q1-2026/" — kccqzy [c:50050223]
> （译文：这个判断不对——Cisco Talos（以及其他主要安全媒体）数据显示，目前超过三分之一的初始入侵入口都是钓鱼。参考：https://blog.talosintelligence.com/ir-trends-q1-2026/）

（这就是 kccqzy 跟 tgma 之间数据口径的拉锯——前者把 cookie stealing 列为头号、把 phishing 排到三成；后者坚持钓鱼是头号，给的是 Q1 2026 入侵趋势报告。这场数据之争没分出胜负，但把文章「钓鱼不重要」的暗线逼成了显线：原博客作者确实在长文里没出现「phish」这个词，tgma 拿这一点当文章「不可信」的证据——这跟 passkey 本身的设计初衷是反着来的。）

### 个人用户的真实痛点：备份、迁移、UX 割裂

工程派拿出来的不是论文，是真摔过的跟头。bmitch3020 把最扎心的一段写出来：

> "I've yet to voluntarily enable passkeys, for the main reason that I want portability, and not to be tied to any single device that can be lost. I want to be able to backup and lock my credentials in a safe. I also want to control the strength of my credentials for different services, and I don't consider my thumbprint used to unlock my phone to be as strong as a long password in a password manager. The first time I was forced to use a passkey implemented within the vendor's app (3rd party password managers were not an option). I quickly closed that account. The second time was an app that popped up a passkey opt-in in the middle of a bunch of transaction screens. I quickly realized the error, but there was no easy undo. The opt in was one green button in the middle of the screen. Turning it back off required digging through settings to find the security option to disable, and then confirm my choice multiple times. That process also signed out all my other devices. The fact that companies are resorting to dark patterns and forced requirements, where my money is held hostage, should be pretty good evidence of how poorly the passkey rollout is going." — bmitch3020 [c:50048775]
> （译文：我到现在还没主动开过 passkey，主要因为我要可移植性，不想被绑在任何一台会丢的设备上。我要把凭证备份锁进保险箱。我还要能控制不同服务的凭证强度，不认为我手机指纹解锁的强度顶得上密码管理器里 30 位长密码。第一次被强制用某个 app 内置的 passkey（不能用第三方密码管理器），我立刻关掉了那个账号。第二次有个 app 在一堆交易页面中间弹了个 passkey 开通提示，我意识到不对但没有简单的撤销——开通按钮就在屏幕中间一颗大绿点，关掉它要钻进设置找到安全选项、再点几次确认。这过程还把我所有其他设备都登出了。企业用 dark pattern 和强制要求来推，钱被扣着不让走——这就是 passkey 推广有多糟的最好证据。）

crote 直接给技术细节：

> "There is no truly secure options for this, unfortunately. Passkeys have to be online to enroll additional keys, so any kind of software or smartphone solution is going to depend completely on cloud sync. Any form of offline copy stored in a physical safe will quickly be outdated. It gets even worse when you want to have separate passkeys, so that you have the possibility of knowing which one was compromised and doing a partial revocation: the cloud sync now requires every device to have access to every copy, so that you can individually enroll them during registration." — crote [c:50050328]
> （译文：很不幸，目前根本没有真正安全的办法。Passkey 必须在联网状态下才能注册新 key，所以任何软件或手机方案都得完全依赖云同步。任何离线副本锁进保险箱都会很快过时。更糟的是——如果你想给每个账号备多把 passkey、希望出问题时知道是哪一把泄露、单独吊销，云同步需要每台设备都拥有所有副本，注册时再单独登记。）

tonymet 报实际产品体验：

> "Passkeys are a pretty terrible UX on their own, in that you have no control over managing them. And every site has a custom experience. Epic for example has at least 3 different ways to load the pass key e.g. username first, passkey first, username + password, then passkey. Luckily their app lets you in with Passkeys alone. Walmart prompts for username first, then passkey, then it sends you a verification code to your email address. The issue is that every site has a random flow of username, password, oauth (then a few oauth screens), passkey, 2fa and so on. Authentication has become absurd. None of this is making people safer. If sites are seeing less fraud reports, it's likely they are harder to detect rather than less frequent." — tonymet [c:50050559]
> （译文：Passkey 本身的 UX 极差，你没法管理自己。每个站点的体验都不一样。Epic 至少有三种加载 passkey 的方式——先用户名、先 passkey、用户名+密码再 passkey。还好 Epic 的 app 只用 passkey 就能进。Walmart 先要用户名、然后 passkey、再给邮箱发验证码。问题是每个站都自己一套流程——用户名、密码、OAuth（中间还来几个 OAuth 页面）、passkey、2FA……验证已经变成一场闹剧。这些东西没让用户更安全，如果站点收到的诈骗投诉变少，更可能是它们更难被发现、而不是更少发生。）

oefrha 把 1Password 最近一次配置改动钉在墙上：

> "I'm an advocate for passkeys and I abolished passwords and embraced discoverable passkeys for our org's key internal systems exclusively. So the battle cry of a title immediately put me on the defensive, unfortunately. The urge to not read is strong. A more measured title may help here. But there's definitely a kernel of truth here. 1Password recently began to enforce userVerification: required, and suddenly on the desktop without TouchID I have to enter my login password to use the passkey on a good number of websites. I didn't sign up for 1Password 15 years ago so that I have to enter both my very complex master password and very complex login password to sign into websites, the 'one password' contract is suddenly broken after 15 years." — oefrha [c:50049311]
> （译文：我是 passkey 的拥趸，我把我们公司关键内部系统全切到了 discoverable passkey、彻底干掉了密码。所以「陷阱」这个标题一上来我就有戒心，看下去的冲动都被压下去了——标题温和点可能更好。但这里确实有真的东西。1Password 最近开始强制 `userVerification: required`，结果在桌面端没 TouchID 的时候，我每用一次 passkey 都要把登录密码再敲一遍。15 年前我注册 1Password，不是为了登录网站时既要敲超复杂的主密码、又要敲超复杂的登录密码——「一个密码」这个承诺 15 年后被打破。）

### 银行场景：钓鱼解药 vs 冻款现实

grebc 把 passkey / attestation 推到「真要落地会出什么事」的边界——他讲自己买房的亲身经历：

> "I bought a house earlier this year and the bank froze my deposit I sent to the real estate agent. I rang the bank straight away and badgered them to unlock it ASAP in case the sale fell through for their BS fraud department to sift it. They blamed the fact the real estate they'd never transacted with before, I politely told them they're based in one state while I was purchasing in another. It took 2 hours of back and forth to get them to send it, even after they did all their security questions. It's all a fugazi, they/governments do not want you having large amounts of money - it's as simple as that." — grebc [c:50050728]
> （译文：我今年买了套房，银行把我打给房产中介的押金冻了。我马上打给银行催他们尽快解冻，怕交易因为他们那帮「风控部门」拖流程而崩。他们说原因是从没跟这个房产中介交易过，我礼貌地告诉他们房产中介在外州而我在另一个州买。即使他们所有安全问题都走完了，前后也花了 2 小时才把钱放出来。这一切都是演戏，他们/政府不想让你持有大额资金——就这么简单。）

somerandom2407 反驳这是 passkey 的好处而不是坏处：

> "Actually it's kind of the opposite. Right now the banks know how easy it is for someone to end up getting scammed, so they try to be really strict on picking up on potentially fraudulent transactions precisely because they can't trust endpoint security. If they have something like this in place, they will have greater confidence in the transaction being genuine and less likely to block it." — somerandom2407 [c:50050857]
> （译文：其实正好相反。银行现在很清楚用户被骗有多容易，所以才会对潜在欺诈交易极严——因为他们不能信任端点安全。如果他们有了这套机制（passkey），对交易真伪就更有信心，也就不那么容易冻款。）

grebc 冷冷回一句：

> "Yes, that's what they've told you. Good that you listen to them." — grebc [c:50051213]
> （译文：对，那是他们告诉你的。挺好，你信了。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题夸张但 attestation 在 spec 里是真的 | tavavex [c:50050321] | 不是远期假设，他们想推明天就能推 |
| attestation 不会发生，Apple 把门关了 | agwa [c:50048830] / WorldMaker [c:50050744] | Apple 消费设备不支持、强制要 attestation 等于打掉 iOS 用户 |
| 银行会先动手 | supertrope [c:50049869] / throwawayffffas [c:50049153] | 银行想要带 attestation 的终端、用户买单 |
| 巨头护城河动机 | throwawayffffas [c:50050214] / crote [c:50050547] | attestation、secure hardware 都是锁生态的借口 |
| 温水煮青蛙剧本 | xg15 [c:50050554] / aidenn0 [c:50050110] | 五步把 opt-in 推到强制；2026 已经出现禁 Firefox、禁自定义域名邮箱 |
| 文章漏讲 MITM | danpalmer [c:50048888] / MBCook [c:50050832] / ttul [c:50049418] | passkey 抗 MITM、跟域名绑定，数据库泄露公钥无用 |
| 钓鱼仍是头号威胁 | tgma [c:50049083] / kccqzy [c:50050223] | Cisco Talos 2026 Q1：1/3+ 初始入侵走钓鱼 |
| 个人用户备份痛点 | bmitch3020 [c:50048775] / crote [c:50050328] | 要把凭证锁进保险箱，但 passkey 必须联网注册新 key |
| 1Password 打破「one password」承诺 | oefrha [c:50049311] | userVerification: required 让 desktop 端用 passkey 也要重输密码 |
| 银行冻款才是真问题 | grebc [c:50050728] | 买房打款被冻 2 小时，所谓「更安全」未必更宽松 |

## 总体情绪

整场讨论的真正分裂不是「passkey 是不是钓鱼终极解」，是「attestation 这条线会从 spec 走到生产、被谁先推、推到谁头上」。技术派（agwa、WorldMaker、MBCook）的主线是「spec 写得丑，但 attestation 部署条件不成熟——Apple 不支持、用户覆盖率还不够、银行/消费互联网谁先动手没定论」；工程派（throwawayffffas、crote、tavavex、grebc）的主线是「Apple 顶住不等于 Google/Microsoft/银行会顶住，spec 里有就一定会有人启用，等用户覆盖率够了就是温水煮青蛙的终局」。

最有意思的暗线是「钓鱼是不是头号威胁」这条边角争论。tgma 和 kccqzy 在评论区里直接拉出 Cisco Talos 2026 Q1 数据互砍——前者把钓鱼推上第一、拿 Google 二十年 YubiKey 部署背书；后者把 cookie stealing 列为头号、说钓鱼实际是三成上下。这场数据口径之争没分出胜负，但把文章「钓鱼不重要」的暗线逼成了显线：原博客作者确实在长文里没出现「phish」这个词，tgma 拿这一点当文章「不可信」的证据——这跟 passkey 本身的设计初衷是反着来的。

最后一句话大概是——「陷阱」这个标题一上来就把读者分流了：本来就是 passkey 拥趸的人不读了，本来就对 passkey 持保留意见的人找到弹药，本来没立场的人被「温水煮青蛙」和「银行冻款」两段具体故事拽进怀疑那一侧。HN 评论区没争论出「attestation 会不会发生」，它争论出的是「如果发生，第一波受害者是哪些人」。原博客最狠的地方不是论据多硬，是它让一群做密码学、做安全研究的人停下来承认——这件事确实有「先上车后补票」的可能。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Passkeys are a trap | <https://news.ycombinator.com/item?id=50048312> |

## 免责声明

<div class="disclaimer">

本文为摘要与讨论整理，不构成任何安全建议或技术决策依据。passkeys 适用性因人而异，请在评估自己风险模型后做决定。原始文章版权归原作者所有。文中引用的 Cisco Talos 数据为评论者引用，未做独立核验。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
