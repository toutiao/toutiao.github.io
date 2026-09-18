---
layout: post
title: >-
  「我不喜欢 passkeys」 — HN 讨论：反钓鱼的最佳实践，撞上单设备用户的锁号灾难
date: 2026-09-19
hn_id: 49753211
categories: [articles]
excerpt: >-
  一篇博客吐槽 passkeys 把企业安全方案硬塞给个人用户——服务端不存私钥确实抗钓鱼，但锁号风险被严重低估。HN 评论区里 CS 博士说自己也讲不清「换了设备怎么登录」，掉手机就可能丢全部账号，硬件密钥不能备份要每个网站逐一登记，被吐槽「企业完美，个人灾难」。
tagline: >-
  反钓鱼的英雄，单设备用户的锁号制造机。
---

## 原文概要

Ethan Hawksley 在博客 [I don't like passkeys](https://hawksley.dev/blog/i-dont-like-passkeys)（HN id 49753211，605 分，590 条评论）里把 passkeys 拆成一句核心对比：服务端不存私钥、跟网站域名绑定，确实抗钓鱼；但「不能跨设备无缝迁移」「不能服务端重置」「绑死单一硬件/账号」这三条放在个人用户身上是致命的。

他给的具体数字：硬件密钥（YubiKey 这类）每个能注册的账户上限通常只有 25–100 个，顶级型号 300 个；超过就要么删账号、要么再买一套。Google 把设置项命名为「Skip password when possible」，Microsoft 直接喊「make your account passwordless」——两家公司都在用 OS 级别的同步把用户身份绑回自家生态：账号被自动化封了之后，所有挂在 iCloud Keychain / Google Password Manager 上的第三方 passkey 也跟着一起永久丢失。

博客还列举了几个现实痛点：在同事电脑上登录，要么插 USB 密钥（不一定有端口），要么用「Hybrid Transport」扫 QR 码同时开蓝牙——后者在实际使用里「edge-case 一堆，蓝牙直连很多设备根本不支持」；Bitwarden、KeePassXC 这类第三方密码管理器虽然能存 passkey，但 OS 给的 API 太新，浏览器外和原生应用里的自动填充体验远不如密码时代成熟。

Hawksley 的结论是——对个人用户，「第三方密码管理器里的随机生成密码 + 独立 TOTP 应用」仍然是更可控的方案，passkeys 不是不能用，但「目前不适合个人」。对一直重复用同一个密码的人来说 passkey 是一次升级，对其他所有人是一次降级。

## 讨论焦点

### 连 CS 博士都讲不清「换了设备怎么登录」

原文的核心痛点是营销失败，评论区里最被点赞的回应之一是 Al-Khwarizmi 那段「我硕士博士都是 CS，写代码几十年，从 gopher 一直用到 LLM，我仍然回答不了几个基础问题」：

> "I have a Master's and PhD in CS, code regularly, and have followed and used all the cool technologies from the days of gopher, telnet and Mosaic to crypto, and lately LLMs. And I still don't have a clear enough picture of passkeys to know really basic things like 'what if we have a family computer but each wants to access their private accounts and keep the others from accessing?', 'what do I need do to login from an airport computer?' or 'what should I do if my phone is stolen?'" — Al-Khwarizmi [c:49754007]
>
> （译文：CS 硕士博士，写了几十年代码，从 gopher、telnet、Mosaic 一路用到 crypto、最近用到 LLM，我仍然对 passkeys 没有清晰到能回答几个基础问题的认识——比如「家里共用一台电脑，怎么各自登录自己的账号同时不让别人进？」「在机场电脑上怎么登录？」「手机被偷了怎么办？」）

top-level 评论里 kenrick95 直接点名 passkeys 的营销问题：

> "Passkeys have a marketing problem where no one is able to describe simply what it is without having to use technical jargon. There's also the problem where each OS tries too hard in pushing this to the face of end-user" — kenrick95 [c:49753463]
>
> （译文：Passkeys 有一个营销问题——没人能用大白话讲明白它是什么。还有个问题是每个 OS 都太急着把 passkeys 推到用户面前。）

microenchanting 的反驳是「用户没那么笨」，但 alt227 直接回他：「你显然没跟不懂电脑、也不想懂电脑的人打过交道。」

更具体的失败案例来自 alt227 提的一个场景：

> "ok cool so when somebody logs into a site on their phone and sets up a passkey, then goes to their laptop and tried to log into the same account, how do you easily explain how to deal with this situation?" — alt227 [c:49754694]
>
> （译文：好的，那么一个用户在手机上登录网站、设了 passkey，然后跑到笔记本上想登录同一个账号，你怎么用大白话把流程讲清楚？）

stetrain 给了一个具体的「还行」的回答：

> "What I have seen is that the site gives you a QR code to scan with your phone. People are already used to needing their phone to sign in via an Authenticator app or SMS code." — stetrain [c:49755573]
>
> （译文：我看到的做法是，网站给一个 QR 码让你用手机扫。大家已经习惯了登录时拿手机配合 Authenticator 应用或者短信验证码。）

### 「存哪儿？」—— 普通用户没人答得清

rcxdude 提的那个问题是整场讨论里最被反复引用的：

> "Cool, where are they stored? (I know the answer: 'it depends', and that's the big problem with their usability: most users haven't a clue what the answer is and most tech support can't answer that question straightforwardly because it depends on some decisions the user probably didn't even realise they made)." — rcxdude [c:49753656]
>
> （译文：「好，那它们存在哪儿？」（我知道答案是「看情况」，而「看情况」本身就是可用性的大问题：大多数用户根本不知道答案，大多数技术支持也没法一句话答清楚，因为答案取决于用户做过的一些自己都没意识到的决定。））

wolvoleo 给的简化版答案是「在你手机的安全保险库里」，rcxdude 立刻顶回去——一个设备上可以有多个 vault，这种回答不是「安抚用户的废话」，是「用户丢了账号之后要面对的实际问题」。

mystifyingpoi 把这个痛点直接变成一个具体场景：

> "So if I drop my phone to the toilet, I will forever lose access to everything? Since the vault is on my phone." — mystifyingpoi [c:49753765]
>
> （译文：那我要是把手机掉进马桶，是不是就永远登不上任何东西了？毕竟 vault 在我手机上。）

faust201 的回应是把责任推回「你需要保护好 Google 账号」：

> "A majority have more than one phone. Or at least they can get a new SIM card and sign into the iCloud account. Then all passkeys are synced from cloud. Yes, if you are edward snowden then not for you. For rest of us - it is useful" — faust201 [c:49755099]
>
> （译文：大多数人有不止一部手机，或者至少能搞一张新 SIM 卡登回 iCloud 账号，然后所有 passkey 就从云端同步回来了。对，如果你爱德华·斯诺登那确实不适合你，对我们剩下的人很有用。）

这条立刻被 recursive 和 chrystalkey 各打一拳：

> "This is crazy.  I have one phone and zero iCloud.  I don't think I'm that unusual." — recursive [c:49755467]
>
> （译文：这说法太离谱了。我只有一部手机、零 iCloud，我不觉得自己算异类。）

> "Idk how much money you must be having, but all of my bubbles only ever go with one device" — chrystalkey [c:49755346]
>
> （译文：我不知道你得多有钱，但我身边所有普通人一辈子只用一台设备。）

### 单设备用户的真正噩梦：掉手机就是丢全部

makeitdouble 展开了一个具体的旅行场景：

> "Nothing wrong with your answer itself, but having to be Apple or Google is a PITA. These account are ultra critical already and you will want maximum security to access them. This means if you go on a trip somewhere you absolutely need two devices. If you kill your phone and want to buy another one ASAP, you wont be able to do anything with the new device until you can convince the platform it's you. With passkeys you're just SOL. Imagining if you needed a phone to get back from your trip - e.g. etickets, auth needed etc. - it becomes a nightmare scenario." — makeitdouble [c:49757413]
>
> （译文：你回答本身没错，但只能依赖 Apple 或 Google 是真的烦。这些账号本身已经极其关键，你还会想给它们最高强度的访问保护。这意味着你出门旅行一定要带两台设备。如果你手机坏了想买一台新的应急，你在那台新设备上什么都干不了，除非你能让平台相信你是你本人。Passkey 这种情况下你就是完蛋。想象一下你出远门回来需要用手机——比如电子票、登录各种账号——那就是个噩梦场景。）

Aerroon 把这个责任直接落到 IT 顾问/家庭技术支持角色身上：

> "Until they lose access to that account and then it becomes my problem to solve." — Aerroon [c:49756273]
>
> （译文：直到他们丢了账号访问权，最后就变成我的问题要去解决。）

### 硬件密钥的备份梦魇

原文在硬件密钥那部分提了一句「不能备份，每个 site 都要重新登记」，UltraSane 把它展开成更具体的问题：

> "The biggest issue with passkeys is that since most USB tokens that support them don't allow syncing the private key to a backup device you have to enroll ALL of them to every site that supports passkeys. This is annoying but it makes storing backups in secure offsite locations impractical." — UltraSane [c:49755106]
>
> （译文：Passkeys 最大的问题是，因为大多数支持 passkey 的 USB 令牌不允许把私钥同步到备份设备，你得把每一个令牌都在每一个支持 passkey 的网站上注册一遍。这很烦，也让「把备份存到安全的异地位置」这件事不现实。）

EvanAnderson 直接写了一整套理想中的硬件密钥设计：

> "I'd love a hardware sold in multi-packs and 'born' at the factory with identical internal device key encryption keys (DKEK). I'd love, even more, if a token just allowed you to 'commission' new ones w/ a user-specified DKEK on first use. I'd use one token as a daily driver and store the other(s) in safe location(s), empty of my personal key material. (Or, if I can just commission a new token w/ my DKEK, store a printed copy of my DKEK in a safe location.) Give the token a mechanism to 'type' a backup of its internal state, encrypted with the DKEK, as a USB HID keyboard. That gives me an easy way to backup the token each time I enroll a new website. If I lose my daily-driver token I just pull a spare from storage, import my last backup, and I'm up and running. That would kick ass. No 'You just need to buy two tokens and enroll them in every website' bullshit." — EvanAnderson [c:49755759]
>
> （译文：我想要的是一组出厂就共享同一套内部设备密钥加密密钥（DKEK）的硬件密钥套装。更理想的是，让我能在第一次使用时给一个新令牌「指定」一个 DKEK。日常用一个，其它存在保险柜里，里面不存我个人的密钥材料。（或者，如果我可以用我的 DKEK 直接给新令牌初始化，把 DKEK 的纸质副本存在保险柜。）给令牌一个能把它内部状态「敲出来」备份的机制，用 DKEK 加密，走 USB HID 键盘。这样每次注册新网站我都能方便地备份一次令牌。丢了主力令牌，我从保险柜拿一个备用的，导入上次备份，就直接能用了。这才叫好用。不用再跟我说什么「买两个令牌、每个网站都注册一遍」的废话。）

iamnothere 觉得这类问题只能靠监管来推：

> "There needs to be industry and government leadership on this to gradually require hardware token usage, for at least critical financial and government applications. Right now everyone is putting their energy behind passkeys, but those are much harder to understand than a physical token. I don't know any non-technical people who understand how passkeys are normally tied to the device (or the manufacturer-provided cloud account in some cases), how to set them up on a second device, why you might want to do that, etc. And many technical people still don't get it either!" — iamnothere [c:49755004]
>
> （译文：这件事需要行业和政府牵头，至少在关键金融和政府应用上逐步要求硬件令牌。现在大家都在推 passkeys，但 passkeys 比一个物理令牌难理解多了。我认识的不懂技术的人里没人知道 passkeys 通常怎么跟设备绑定（或者跟厂商提供的云账号绑定）、怎么在第二台设备上设置、为什么要这么做。很多懂技术的人也没搞清楚！）

EvanAnderson 还有一个尖锐的反问——大多数 FIDO2 令牌默认只要物理接触就能用：

> "I haven't used a FIDO2 token other than playing around with it on a Yubikey. There, at least, I have to have the PIN to unlock the Yubikey before I can use the FIDO2 credentials (if I'm remembering correctly). Are there hardware token implementations where mere possession of the token is all that's necessary to use the passkeys stored on it? That's incredibly stupid, and should have been disallowed by the standard, if that's the case." — EvanAnderson [c:49756682]
>
> （译文：除了拿 Yubikey 玩玩之外我没用过别的 FIDO2 令牌。在 Yubikey 上至少要有 PIN 才能解锁、才能用 FIDO2 凭证（如果我没记错的话）。有没有硬件令牌实现是只要拿到令牌本身就能用它里面存的 passkey？这也太蠢了，如果真是这样，标准就不该允许这种事。）

iamnothere 确认了 Yubikey 上 PIN 是可选的，UltraSane 进一步补充大多数标准 FIDO2 令牌就只要求你按一下电容感应。

### 「另一组不能背的密码」+ 厂商护城河

wg0 的 top-level 吐槽被反复引用：

> "They really are bad. Passkeys have turned out to be just another password that you cannot even memorize." — wg0 [c:49753466]
>
> （译文：它们真的很糟糕。Passkeys 最后变成另一种密码，而且是你连背都背不下来的密码。）

john_strinlai 的反驳是「不能背恰恰是 feature」：

> "there's some issues with passkeys, but not being able to memorize them is a feature" — john_strinlai [c:49753618]
>
> （译文：Passkeys 确实有些问题，但「你背不下来」恰恰是个 feature。）

drdexebtjl 顺着这条把话接下去：

> "That is the point. They stop you from memorizing it 'just in case' and reusing it, and they force you to use a password manager. For the average user, which doesn't use a password manager, this is great. It means they can't get phished. And it's also great for the average password manager user, who keeps dozens of insecure and reused passwords in their vault because they manually thought of a password when signing up instead of randomly generating one. If you're already using a password manager and random passwords, the UX is designed to be the same. It's just a way to get regular people to do this." — drdexebtjl [c:49754119]
>
> （译文：这就是重点。它阻止你「以防万一」把密码背下来、再拿去复用，逼你用密码管理器。对不用密码管理器的普通用户来说这是好事，他们不会再被钓鱼。对用密码管理器、但里面存了几十个弱密码和复用密码的人来说也是好事（因为他们当初是手动设的密码，不是随机生成的）。如果你已经在用密码管理器加随机密码，UX 设计上就跟原来一样。这只是让普通人也走到这条路上的一种办法。）

但 elteto 提出了一个反向的「厂商动机论」：

> "While the technology itself may be great (I don't really know since I don't use them) it has been co-opted by the tech conglomerates as another form of isolating and walling off users into their ecosystems. And honestly, nowadays, if tech companies are pushing really hard for something then that is an immediate red flag for me and it bears more scrutiny. One of those 'if you see them running that way you run the opposite way'." — elteto [c:49753481]
>
> （译文：技术本身可能很棒（我不怎么用，所以我不确定），但它已经被科技巨头挪用成把用户进一步圈进各自生态的另一种手段。说实话，现在科技公司如果对什么东西推得特别猛，对我来说就是一个立刻的红旗，需要更仔细审视。就是那种「看它们跑那个方向，你就往反方向跑」的事。）

dingaling 给这个动机论补了一刀技术细节：

> "That's more because attestation breaks their passkey cross-device sync process, rather than out of benevolence." — dingaling [c:49754633]
>
> （译文：[Apple 不支持 device attestation] 更多是因为 attestation 会破坏它们的 passkey 跨设备同步流程，而不是出于什么善意。）

### 关于「passkey 需不需要定期轮换」

pirates 提了一个直觉得反常识的问题：

> "Doesn't this mean that a compromised device with passkeys on it is worse than a compromised password since the passkeys can't be rotated? I feel like the answer is obvious so there must be another angle I'm missing" — pirates [c:49754036]
>
> （译文：这岂不是说设备被入侵、passkey 跟着泄露的情况比密码泄露更糟，因为 passkey 没法轮换？我觉得答案很明显，但肯定有我没看到的另一面。）

hannasanarion 给了一个比较完整的反驳：

> "Passkeys can be rotated, of course. The question was whether they should be rotated on a regular basis. What kind of compromise are we talking about? Was the device stolen? Then yeah, you need to rotate passkeys (and all your passwords, and remotely cancel all your live sessions, none of which is new). Was the device hacked from afar and the data read off of it? The passkey is probably fine. You can rotate it if you want to, it's not a bad idea, I probably would to be certain, but you're not pwnd even if a bad guy got a shell for a while, heck even if they got a root shell. ... Rotation defends against secrets that leak through normal use and without your knowledge, like a password entered into a phishing page or snooped over your shoulder or cracked from a breached hash. Passkeys aren't vulnerable to those things because they never travel over a network, are never seen by the server, are never seen by their own users. You change the locks on your house when a key goes missing, or is known to be in the hands of somebody you don't want getting in, it's not something you do every three months just in case. Same with passkeys." — hannasanarion [c:49755344]
>
> （译文：Passkey 当然可以轮换，问题在于该不该定期轮换。我们说的是哪种入侵？设备被偷了？那你确实要轮换 passkey（以及所有密码、远程吊销所有活动会话，这些都不新鲜）。设备被远程攻破、数据被读走了？Passkey 大概率没事。你想轮换也行，不算坏主意，为了稳妥我也会轮换，但即使坏人拿了一段时间 shell，甚至拿到了 root shell，你也不算 pwnd。……轮换是为了防止「正常使用过程中不知不觉泄露出去」的密钥——比如密码被输进钓鱼页、被肩窥、被从泄露的 hash 暴力破解。Passkey 不受这些威胁影响，因为它从不上网、服务器从没见过、自己用户也从没见过。家里的锁是钥匙丢了或者确认落到不该拿到的人手里才换，不是每三个月预防性换一次。Passkey 也一样。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 营销彻底失败 | kenrick95 [c:49753463] | 没人能用大白话讲清楚 passkey 是什么，每个 OS 还在硬推 |
| 连 CS 博士都讲不清 | Al-Khwarizmi [c:49754007] | 几个基础场景（家庭共用电脑、机场电脑、手机被偷）回答不上 |
| 「存哪儿？」问题无解 | rcxdude [c:49753656] | 答案是「看情况」，普通用户没概念，技术支持也一句话答不清 |
| 掉手机 = 锁号 | mystifyingpoi [c:49753765] | vault 在手机上，手机掉马桶是不是永远登不上 |
| 单设备用户被忽略 | recursive [c:49755467] / chrystalkey [c:49755346] | 只有一部手机、零 iCloud 的人不稀奇，「多带一台设备」不是普通人生活 |
| 旅行场景是噩梦 | makeitdouble [c:49757413] | 出门一定要两台设备，新设备在说服平台前什么都干不了 |
| 家庭 IT 顾问背锅 | Aerroon [c:49756273] | 家人丢了账号访问，最后都是「我」要去解决 |
| 硬件密钥要每个网站逐一登记 | UltraSane [c:49755106] | 不能同步私钥到备份设备，异地备份不现实 |
| DKEK 是真正需要的 | EvanAnderson [c:49755759] | 想要工厂同密钥套装，或首次使用时指定 DKEK，丢了直接换备用 |
| 物理令牌默认无 PIN | EvanAnderson [c:49756682] / UltraSane [c:49757548] | 大多数 FIDO2 令牌只要求按一下，标准就该禁 |
| 「不能背」是 feature | john_strinlai [c:49753618] / drdexebtjl [c:49754119] | 逼普通人用密码管理器、对抗钓鱼和复用密码 |
| 巨头护城河动机 | elteto [c:49753481] / dingaling [c:49754633] | 推得越凶越可疑；Apple 不支持 attestation 是因为破坏跨设备同步 |
| 设备被入侵 ≠ passkey 泄露 | hannasanarion [c:49755344] | passkey 从不上网也不被服务端看到，passkey 不需要定期轮换 |
| 设备被入侵后更糟 | pirates [c:49754036] | passkey 没法轮换，被入侵是不是比密码泄露更严重 |

## 总体情绪

整体是技术派和工程派的双重不信任，但没有「passkey 应该被全面抛弃」的极端立场——争论的是「企业 vs 个人」的适配问题、「巨头生态 vs 第三方」的护城河问题、「抗钓鱼 vs 锁号风险」的取舍问题。

技术派的共识比较一致——passkey 抗钓鱼这件事确实成立（hannasanarion 那条「passkey 从不上网、服务器看不到、用户自己也看不到」是被反复引用的技术事实），但这条安全收益是在跟「锁号」做交换。原博客的核心论点是企业能承担这条代价（IT 部门能帮你恢复账号、有多个物理密钥、有备份流程），普通用户承担不起。

工程派的情绪更尖刻也更具体。Aerroon 那条「直到他们丢了账号访问，最后就变成我的问题要去解决」是整场讨论里被引用最多的真实痛点——passkey 的失败模式不是「密码泄露」，是「设备丢失 + 平台账户锁定 + 没有任何救济通道」，这个失败模式直接落到家庭 IT 支援的活上。EvanAnderson 那段对「DKEK + 可初始化新令牌」的设想，本质是在承认现有标准没有给个人用户留一条可行的备份路径。

最有意思的暗线是「不能背是 feature」这条。wg0 的吐槽（passkey 是一组你连背都背不下来的密码）拿到不少赞同，但 john_strinlai 和 drdexebtjl 把这条翻译成一种对普通用户的保护机制——passkey 的整个设计就是在剥夺你「自己记住、自己复用、自己安全」的选项，把你推给密码管理器。这两条立场在评论区里都没说服对方，但它们指向同一个事实：passkey 是一个对企业 IT 友好、对个人用户不友好的方案。

最后一句话大概是——passkey 不是错的技术，是一个被推得过快、过广的解决方案。它在企业场景里基本是对的，在「只有一部手机、零 iCloud、零 IT 部门」的个人用户身上大概率是错的。原文作者把这个分裂讲得很清楚，评论区在做的事只是把这种分裂的每一面都展开成具体的失败场景。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | I don't like passkeys | <https://news.ycombinator.com/item?id=49753211> |

## 免责声明

<div class="disclaimer">

本文摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3

引文来源：Hacker News 公开评论（thread id 见正文）。所有英文引文已与原帖逐字核对，作者归属与原文一致。如发现错误，欢迎在原帖下方或评论区指出。

本文为摘要与讨论整理，不构成任何安全建议或技术决策依据。passkeys 适用性因人而异，请在评估自己风险模型后做决定。原始文章版权归原作者所有。

</div>