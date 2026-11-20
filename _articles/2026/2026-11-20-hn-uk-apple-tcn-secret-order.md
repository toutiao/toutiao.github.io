---
layout: post
title: >-
  英国法庭逼政府承认秘密加密令：2025 年 1 月给苹果的 TCN、约 22 个月，与一场关于「保密」的争论 — HN 讨论摘要
date: 2026-11-20
hn_id: 50562113
categories: [articles]
excerpt: >-
  英国调查权力法庭只裁了一件事：政府必须承认 2025 年 1 月给苹果发过秘密加密令。评论区最激烈的争论不是后门，是「保密」本身能不能成为常态。
tagline: >-
  约 22 个月里，这道命令在纸面上一直不存在。
---

> 来源：HN 讨论主帖 [UK government forced to admit it issued Apple a secret encryption order](https://news.ycombinator.com/item?id=50562113)（513 分，215 条评论），原文指向 MacAnorak 的 [UK Government Forced to Admit It Issued Apple a Secret Encryption Order](https://macanorak.com/uk-government-forced-to-admit-it-issued-apple-a-secret-encryption-order/)。评论者 fweimer 贴出了判决书全文 [Apple Inc and Secretary of State for the Home Department and (1) Privacy International (2) Liberty (3) Ian Hosein (4) Ben Wizner vs Secretary of State for the Home Department](https://investigatorypowerstribunal.org.uk/judgement/1-mr-vincent-kearney-2-british-broadcasting-corporation-v-1-chief-constable-of-the-police-service-of-northern-ireland-2-chief-constable-of-durham-constabulary-3-security-service-4-governme/)（中性引注 [2026] UKIPTrib 9，2026 年 11 月 19 日）。归档快照 2026-11-20 02:04 UTC，入库 120 条评论（未触及抓取上限），评论分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值。

> ⚑ **政治背景**：本文涉及英国《调查权力法案》下的秘密技术能力通知（TCN）、政府「不承认也不否认」政策与国家安全评估的合法性；含英美政治立场、政府保密与基本权利争议、Apple 在中国区密钥安排的评论区说法等敏感话题。⚠ Review recommended.

## 原文概要

11 月 19 日，英国调查权力法庭（Investigatory Powers Tribunal, IPT）公布判决，案号 IPT/26/191/CH 与 IPT/25/83-86/CH，中性引注 [2026] UKIPTrib 9，审判长是 Lady Carmichael，另有 Chamberlain 与 Johnson 两名法官，审理日期是 2026 年 9 月 17 日。判决只有一句话的结论：内政大臣没有证明，公开承认「政府确曾向苹果发出技术能力通知（Technical Capability Notice, TCN）」会损害国家安全。

它裁的其实不是 TCN 本身合不合法。判决明确写了三处「没有裁」：没有裁定这份通知在实体上违法；没有裁定政府是否有权要求苹果改动其加密系统；没有公开通知的技术内容。真正被拆掉的，是政府长达 22 个月维持的那套「不承认也不否认」的操作。

这条线索的起点是《调查权力法案 2016》第 253 条——它允许内政大臣向「相关运营者」发出 TCN，要求科技公司作出技术改动，以便配合调查权的行使。按 MacAnorak 的梳理，2025 年 1 月英国政府签发了第一份 TCN（据《华盛顿邮报》2025 年 2 月的报道），要求苹果交出加密 iCloud 数据的访问能力；命令的范围不限于英国用户，波及全球客户，包括美国人。苹果的回应是撤下面向英国新用户的「高级数据保护」（Advanced Data Protection, ADP），同时声明不会在任何产品里造后门或主密钥——但因为被法律禁止提及 TCN，这句声明当时读起来像是凭空表态。2025 年 8 月，在特朗普政府施压之下，第一份通知被撤回；2025 年 9 月签发了第二份新通知；苹果 2025 年的诉讼随之因情势变更被驳回，2026 年 7 月重新起诉。

判决把政府那套「不承认也不否认」（neither confirm nor deny, NCND）的逻辑拆成了三段。政府的证据来自两份证人陈述：内政部国土安全司调查权力部门主管 Lucy Montgomery-Pott（仅在 PRIVATE 部分提交），以及国土安全司技术、数据与创新总监 Andrew Scurry 2026 年 9 月 11 日的陈述。Scurry 的核心论点是「NCND 原则只有在被始终如一地维持时才有效力」，并声称部长与内政部官员一贯不承认也不否认任何一份 TCN 的存在、内容、范围或实际效果。

法庭不买账，理由很具体。第一，《泰晤士报》和《金融时报》各自报道过称有政府官员确认了 TCN 的存在，而内政部对这两篇报道启动的泄密调查只给出一句「未找到政府消息源」，既没说调查做了什么，也没说调查了谁。第二，法庭推断：多个政府消息源同时向记者放风而不对外承认，「极不可能」是未经授权的——否则这些人不必冒纪律处分和刑事追究的风险。第三，英国政府曾授权苹果向美国行政与立法部门通报此事，却明令禁止苹果再向美国国会透露细节，而美国参议员 Wyden 与众议员 Davidson 的公开信已经把它写了出来。法庭把这称为「对 NCND 的重大偏离」。

法庭还点出一个细节：代表法庭出庭的 Jason Beer KC 指出，内政部解释真实立场的那批文件标注的是「OFFICIAL SENSITIVE」，而不是「SECRET」或「TOP SECRET」。此外法庭认为，高端行为体从公开报道里早就能推出答案，「把这个是非题输进 Google 的聊天机器人」就能找到肯定答案，因此官方确认不会增加低端行为体的信息量。

结果是 22 个月后，这道命令第一次在纸面上存在了。判决同时说明：通知的具体内容仍不公开，实体审理预计推迟到 2027 年上半年，苹果的五项诉因中，前三项（境外定向截获令的权限、该权限能否用于监管科技公司向用户提供的安全与隐私服务、以及协商程序）大概率可以在公开听证中审理。

## 讨论焦点

### 一、凭什么要保密

> "can anyone justify the idea that governments can keep these orders secret? it seems to me that a government trying to hide this kind of thing is doing so maliciously and should not be holding power over it's citizens, who deserve to know that this kind of thing is happening." — slopinthebag [c:50562820]
> （译文）有谁能论证政府可以保守这类命令的秘密。在我看来，一个试图隐瞒这种事情的政府这样做就是出于恶意，它不该继续凌驾于自己公民之上——公民有权知道这种事正在发生。

这是全帖最早的一批回复之一，也是评论区最直白的态度：保密本身需要理由，而「国家安全」不是自动生效的理由。

> "The key finding seems to be that the media learned of the technical capability notice through confidential security briefings, and not a leak (“one of those irregular verbs”)." — fweimer [c:50562828]
> （译文）关键认定似乎是：媒体是通过机密安全简报得知这份技术能力通知的，而不是靠泄露（「泄露」是那类不规则的动词）。

fweimer 贴出了判决书原文，并顺手指出判决书自己也留了伏笔：通知的内容至今仍然保密。这句话把「公开了什么」和「公开到什么」切成了两件事。

> "Given the legalese these extra steps are all that matters. Keep in mind that Apple could just update the software to do whatever it wants it to do, too. It's not like Apple customers are in control of what runs on their phones." — hrncn [c:50563665]
> （译文）既然有这些法律术语兜着，多出来的这些步骤才是关键。别忘了，Apple 同样可以只发一次软件更新，想让它做什么就做什么。反正 Apple 的用户也控制不了自己手机上跑的是什么。

这句提醒是整条讨论里少见的、冷静的技术判断：保密制度一旦成立，改动本身就可以藏在一份例行更新里，用户没有任何察觉的余地。

### 二、「不承认也不否认」是一项政策，不是一次失言

讨论里最扎实的一段是把政府理由的最强版本先说出来，再拆掉它。

> "The steelman is that if forced to make this public, then bad actors/criminals and their enterprises can take steps to remove/expunge their operations from their existing locations so that nothing is found. Often these investigations take place over the course of years so they need to be able to keep production orders secret or else they will lose the investigative progress they have made." — chunky1994 [c:50562874]
> （译文）最强版本的理由是：一旦被迫公开，犯罪分子和他们的企业就能把痕迹从现有据点撤走或销毁，最后什么都查不到。很多调查要持续数年，所以他们需要能把生产环节的命令保密，否则已经取得的调查进展就白费了。

> "I don't agree with the thesis that this needs to be forever secret. Every law I've seen keeps the secret requirement indefinite." — chunky1994 [c:50563212]
> （译文）我不同意「这需要永远保密」这个说法。我见过的每一部法律，都把保密条款设成无限期。

同一个人的两层回答：先把最强理由摆出来，再指出法律里的保密条款全是无限期，没有哪部法会写「只保密三个月」。

> "You are completely correct, nothing more to explain. They want power because they are the government, that's only justification they need, everything else PR \"ye we will totally use it against bad guys and not against guy that made govt look bad\"" — InsidiousWombat [c:50563047]
> （译文）你说得完全对，没什么好补充的。他们想要权力，因为他们就是政府，这就是他们需要的全部理由，其余都是公关：「是的，我们肯定会拿它去对付坏人，绝不会拿去对付让政府难堪的人。」

这则回应把整套说辞拆成了两层：法律基础是权力本身，「反制坏人」才是拿来解释的部分。

> "Someone claims a specific law would allow the government to do a specific thing, this claim is rebutted, and then it becomes \"how naive to think the law ever mattered.\" Just reflexive abject cynicism. No the US government isn't perfectly lawful, yes the content of the laws does nonetheless matter a whole lot. Nuance." — equinoxnemesis [c:50565101]
> （译文）有人宣称某部具体法律允许政府做某件具体的事，这个宣称被驳回之后，就变成了「居然天真到以为法律还管用」。纯粹的条件反射式犬儒主义。不是说美国政府完全守法，而是说法律的内容确实依然非常重要。要有分寸。

这句反对意见把讨论从「保密合不合法」拉回「法律文本还剩多少分量」，而这恰恰是这场判决所处的位置：它没有裁定 TCN 实体违法，只是要求政府承认自己发过。

> "I don't agree with the policy either, but come on. After the fact discussion causes exactly the same notional harm as contemporaneous discussion: people learn what you're doing, and move their records somewhere safer." — thaumasiotes [c:50563467]
> （译文）我同样不同意这项政策，但说真的：事后公开和当时公开造成的名义伤害完全一样——人们都会知道你在做什么，然后把记录挪到更安全的地方。

> "The same argument applies for secret laws, which usually go hand in hand with secret surveillance programs. If we discussed why the court found some person guilty, then people would just avoid breaking the law." — hedora [c:50563886]
> （译文）同样的论证也适用于秘密法律，它们通常与秘密的监控项目手挽手。如果我们讨论法院为什么判某人有罪，人们只会避开违法而已。

> "I could but the justification is secret too. /s" — joe_the_user [c:50565551]
> （译文）我可以，但理由本身也是保密的。/s

这一句是整条讨论里最锋利的讽刺：要求别人守口如瓶的理由，同样属于不能说的那部分。

### 三、错的是政府，还是 Apple 把加密说过头了

讨论里出现了一条与主流相反的支线：Apple 自己也该挨批。

> "I do not think there is any justification, but it is not hard to think of reasons that are less malicious than you suggest. For example, Apple has made privacy and encryption part of its marketing strategy and news about governments ordering Apple to decrypt data and hand it over undermines their business. The government would likely prefer a non-adversial relationship with Apple and not undermining their business is obviously part of that." — betterunix2 [c:50563008]
> （译文）我不认为有什么正当理由，但也不难想到一些比你说的动机没那么恶意的解释。比如，Apple 已经把隐私和加密写进自己的营销策略，而「政府命令 Apple 解密并交出数据」这种新闻会砸掉它的生意。政府多半更希望和 Apple 保持非对抗关系，不砸它的生意显然是其中一部分。

> "Apple oversold encryption and should be criticized for that. The government did not take action against \"encryption,\" it ordered Apple to do something that Apple has the ability to do despite what their marketing suggests." — betterunix2 [c:50563191]
> （译文）Apple 把加密吹过头了，这点就该被批评。政府并没有对「加密」动手，它是命令 Apple 做一件 Apple 本来就做得到的事——尽管它的营销说法暗示它做不到。

这个反驳的技术支点是 iCloud 的密钥分层：默认的「标准数据保护」里，密钥存在 Apple 的数据中心、方便数据恢复，只有部分数据是端到端加密的。

> "Your iCloud data is encrypted, the encryption keys are secured in Apple data centers so we can help you with data recovery, and only certain data is end-to-end encrypted." — calibas [c:50565072]
> （译文）你的 iCloud 数据是加密的，加密密钥保存在 Apple 的数据中心，以便我们协助你恢复数据，并且只有部分数据是端到端加密的。

> "I think that's just for Advanced Data Protection, which apparently isn't offered in the UK." — calibas [c:50565072]
> （译文）我觉得这只涉及高级数据保护（ADP），而据说英国并不提供这个选项。

而怀疑论的回应是：默认状态本来就没那么强，所以 Apple 的营销承诺从一开始就需要打折。

> "Whatever Apple claims they are doing today, and even what they are actually doing today, could change tomorrow. My phone just got an iOS update overnight. Do I know what changed? No I do not." — SoftTalker [c:50565097]
> （译文）不管 Apple 今天声称自己在做什么，哪怕它今天真的在做的事情，明天也可能变。我的手机昨晚刚更新了 iOS。我知道改了什么吗？不知道。

### 四、措辞变了：从「没有人能访问」到「Apple 不能访问」

评论区最精细的一段技术讨论，指向的是一句宣传语。

> "Apple has significantly weakened its security assurances in a way that is arguably deceptive. They used to say nobody can access your data, not even Apple. Now they say Apple cannot access your data." — natch [c:50563168]
> （译文）Apple 明显削弱了自己的安全承诺，而且可以说是有欺骗性的。他们以前说的是「没有人能访问你的数据，Apple 也不能」，现在说的是「Apple 无法访问你的数据」。

> "Your key is likely a KEK (key encryption key) that opens another key (not “your” key, let’s call it the actual key) that your data is secured with. There can be other parties (UK government) with their own KEK that opens a copy of the actual key. In this scenario, Apple can have no access to a KEK that opens the actual key, but they are forced to make the wording change they did, if they want to stay honest." — natch [c:50563168]
> （译文）你的密钥很可能是一把 KEK（密钥加密密钥），它能打开另一把密钥（那不是「你的」密钥，我们姑且叫它真正的密钥），你的数据就是用它保护的。可能存在其他方（英国政府）持有自己的 KEK，能打开真正密钥的一份副本。在这种情形下，Apple 自己拿不到能打开真正密钥的 KEK，但如果它想保持诚实，就不得不改成现在这句说法。

这段把「端到端加密」这件事拆成了两层：真正的密钥和包裹它的 KEK。端到端成立不代表没人持有能打开它的第二把 KEK。

> "Well, if Apple provided the KEK to the UK government then Apple is capable of generating another KEK for its own use. That means Apple can in fact access customer data on its own, just after a couple extra steps." — sandworm101 [c:50563603]
> （译文）好吧，如果 Apple 把 KEK 交给了英国政府，那它就有能力为自己再生成一把 KEK。也就是说，Apple 其实也能访问用户数据，只不过多两道手续。

也有人认为这是过度解读：

> "This isn't related to the article, and it's not true? iCloud ADP still exists in its original form, there was no modification allowing 3rd parties access to ADP decryption keys." — s3p [c:50563692]
> （译文）这跟文章无关，而且这说法不对吧？iCloud 的 ADP 仍然以原本的形式存在，并没有做出任何允许第三方访问 ADP 解密密钥的改动。

而追问措辞出处的人拿到的回答是文档本身：

> "Where exactly do they say this, where is this wording change?" — chunky1994 [c:50563497]
> （译文）他们到底在哪儿这么说的？这句措辞变化出自哪里？

> "\"This specifies no one, not even apple.\" I.e they don't store the keys you use for e2e encryption. They've systematically been against introducing backdoors here. Now, is it possible they have and they've been lying through their teeth? Surre, but its unlikely they would be so brazen." — chunky1994 [c:50563497]
> （译文）文档里写的是「这不指定任何人，Apple 也不在内」。也就是说，他们不保存你用于端到端加密的密钥。他们在这件事上一直系统性地反对引入后门。当然，他们有可能已经在做，而且一直在睁眼说瞎话——那当然；但不太可能如此明目张胆。

### 五、跑题：中国区的密钥

讨论最早的一批回复就拐到了另一件事上，而且拐得理直气壮。

> "When it comes down to \"Privacy\" vs \"Profit\" they certainly know which side they stand on." — bigyabai [c:50562751]
> （译文）说到「隐私」对「利润」，他们当然知道自己站在哪一边。

这位用户紧接着放了一条路透社的链接，主题是 Apple 把 iCloud 加密密钥迁入中国；链接本身在 HN 页面显示为截断的 URL，此处不逐字收录。

> "Lets call a spade a spade here. They didn't weaken their e2e encryption, they moved keys (that were always accessible via U.S court order) to China for Chinese located accounts. That's different from weakening their e2e stance or building a backdoor which they haven't done." — chunky1994 [c:50562837]
> （译文）这里就事论事：他们并没有削弱自己的端到端加密，而是把密钥（本来就能通过美国法院命令拿到的那批）挪到了中国，交给中国区账户。这跟削弱端到端加密立场、或者造后门是两回事，他们没干后门那件事。

> "Let's be real, there's no path by which Apple could deliver privacy to Chinese users. Option 1 is they comply with the Chinese government and give them iCloud keys for Chinese users. Option 2 is they refuse to comply and they're not allowed to operate in the Chinese market. Either way, Chinese users get spied on." — AlexandrB [c:50562851]
> （译文）现实点说，Apple 不存在任何一条能给中国用户带来隐私的路。要么它配合中国政府，把中国区用户的 iCloud 密钥交出去；要么它拒绝配合，然后被禁止在中国市场经营。两条路都是一样的结果。

这段岔路很快被拉回主线，但它留下的疑问贯穿全文：如果连中国区账户的加密承诺都要打折，凭什么要求政府相信 Apple 对所有用户的承诺？

### 六、美国对照：FISA 能不能逼 Apple 闭嘴

> "Not sure about the extent of UK investigative powers, but I would assume that FISA in the US could indeed force Apple to lie to keep a change secret." — gmueckl [c:50564076]
> （译文）我不清楚英国调查权的边界有多宽，但我会认为美国的 FISA 确实能强制 Apple 就保密一项改动而说谎。

> "Does FISA force silence/lies about backdoors? I am not versed in any FISA cases being tested in court against e2e practices." — chunky1994 [c:50564464]
> （译文）FISA 会强制就后门问题保持沉默或说谎吗？我不熟悉任何在法庭上针对端到端加密实践受审的 FISA 案例。

> "I believe FISA can force silence but not lies (“compelled speech”)." — fn-mote [c:50564607]
> （译文）我认为 FISA 能强制你沉默，但强制不了你说谎（「被迫的言论」）。

> "It's one thing to say \"hand over what you have access to on user X\", it's another for \"re-architecture your system to break E2E\"." — throw0101c [c:50564888]
> （译文）「交出你在 X 名用户身上能访问到的东西」是一回事，「重新设计你的系统以打破端到端加密」是另一回事。

而最直接的类比落在 Lavabit 上：

> "The legality of the FISA order to Lavabit is untested. My understanding is that that included restricting documentation changes to not reveal the key handoff." — gmueckl [c:50564971]
> （译文）针对 Lavabit 的那份 FISA 命令是否合法，还没有经过检验。据我理解，那份命令包括限制修改文档，以免暴露密钥交接这件事。

这里有个明显的落差：判决书里写明了美国的动作（Gabbard 在 X 上发帖、FT 的两篇报道、授权苹果向美国行政与立法部门通报），但美国这边是否有同等强度的强制保密机制，至今没有判例。

### 七、不做英国生意，行不行

> "Exit the UK market and reveal the letter in a US court." — buckle8017 [c:50564404]
> （译文）退出英国市场，然后到美国法院把那封信亮出来。

> "Can it decide to not operate in a country?" — g-b-r [c:50567932]
> （译文）它能不能决定不在某个国家开展业务？

反对意见更实际：

> "So Apple should simply… not comply with local law? Then you can complain that Big Co doesn’t respect the law?" — rightnutwingjob [c:50563214]
> （译文）所以 Apple 就该干脆……不遵守当地法律？然后你再去抱怨大公司不尊重法律？

> "it appears apple has done this in response to government interference which they cannot even legally disclose. what would you have apple do here?" — slopinthebag [c:50563408]
> （译文）看起来 Apple 是因为政府干预才这么做的，而它连这件事都不能合法披露。那你倒说说，这种情况下 Apple 该怎么做？

这句提问其实命中了整件事的死结：苹果被法律禁止说明自己为什么要改措辞，所以任何解释都只能靠读者自己拼。

而要拼出答案，只能靠法律原则：

> "If a law is unjust, a man is not only right to disobey it, he is obligated to do so." — andai [c:50563492]
> （译文）如果一部法律不正义，一个人不只有权利不服从它，还有义务不服从它。

### 八、办案本来就没那么难

讨论里最乐观的一支，是认为政府这套保密的说辞站不住脚，是因为调查其实没那么依赖后门。

> "The problem is that if they can't break the encryption, it makes investigation less easy. I deliberately wrote \"less easy\" as opposed to \"impossible\", because authorities love to pretend it's completely impossible to do an investigation without persistent remote root access to everybody's devices, when that is obviously not true." — brokenmachine [c:50567300]
> （译文）问题在于，如果他们没法破解加密，调查就会变得「没那么容易」。我刻意写「没那么容易」而不是「不可能」，因为当局总爱假装不做调查就完全不可能，除非能持续远程拿到每个人设备的 root 权限，而这显然不是真的。

> "There are 1000x more ways to catch criminals nowadays than ever before in history, even without scanning innocent people's devices. But that means it would take some work and is harder to automate. In my opinion, in a free society, that would be a good thing." — brokenmachine [c:50567300]
> （译文）如今抓罪犯的办法比历史上任何时候都多出一千倍，哪怕不扫描无辜者的设备也是如此。但那意味着要费更多功夫，也更难自动化。在我看来，在一个自由社会里，这反而是件好事。

评论区还自己吵了一轮谁在护谁：

> "so you see an article about governments trying to hide actions they took against encryption, and your first thought is how can you criticise Apple? classic HN..." — slopinthebag [c:50562832]
> （译文）你看到一篇讲政府试图隐瞒自己对加密所做之事的文章，第一反应居然是「怎么能批评 Apple」？典型的 HN……

另一部分讨论则迅速转成了英国国内政治：

> "Loathe to give a political opinion on here, but I actually think when it comes to authoritarian overreach, Labour are the worst option we have. They've been the party pushing ID cards for decades, and it seems likely this iteration is going to get them in by the back door." — cs02rm0 [c:50563403]
> （译文）我本不想在这里发表政治观点，但说到越权的蔓延，我确实觉得工党是我们能选的最差选项。他们推动身份证件已经几十年了，这一届很可能从后门把他们送上台。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 保密需要理由 | slopinthebag | 有谁能为政府保守这类命令的秘密辩护 |
| 泄密不是泄密 | fweimer | 媒体是靠机密安全简报知道的，不是靠「泄露」 |
| 秘密不该无限期 | chunky1994 | 我见过的每部法律，保密条款都是无限期 |
| 官方理由最强版本 | chunky1994 | 公开后犯罪分子会销毁证据，但事后公开同样会暴露 |
| 保密一旦成惯例 | joe_the_user | 要求别人保密的理由，本身也是保密的 |
| 秘密法律类比 | hedora | 讨论判决理由，人们只会避开违法 |
| 追责 Apple | betterunix2 | Apple 把加密吹过头了 |
| 替政府找台阶 | betterunix2 | 政府不愿砸掉以隐私做营销的苹果的生意 |
| 默认状态没那么强 | calibas | 密钥在 Apple 数据中心，只有部分数据端到端加密 |
| 措辞变化 | natch | 从「没有人能访问」到「Apple 不能访问」，只是换了个说法 |
| 密钥可再生 | sandworm101 | 能把 KEK 交给英国政府，就意味着能给自己再生成一把 |
| 不需要第三方密钥 | s3p | iCloud 的 ADP 仍是原样，没有为第三方留口子 |
| 中国区密钥 | bigyabai | 说到「隐私」对「利润」，Apple 知道站哪边 |
| 端到端没被削弱 | chunky1994 | 挪密钥跟造后门不是一回事 |
| FISA 能逼沉默 | gmueckl | 我想 FISA 也能强制 Apple 就保密改动而说谎 |
| 强迫的是沉默不是谎言 | fn-mote | FISA 属于「被迫的言论」 |
| 交出数据 ≠ 重构系统 | throw0101c | 交出 X 号用户的数据是一回事，重构系统打破端到端是另一回事 |
| 退出英国市场 | buckle8017 | 退出英国，然后到美国法院把信亮出来 |
| 不服从当地法律 | rightnutwingjob | 然后大家去抱怨大公司不守法 |
| 法律义务 | andai | 不正义的法律，不只有权利不服从，还有义务不服从 |
| 调查没那么难 | brokenmachine | 是「没那么容易」，不是「不可能」 |
| 护错了对象 | slopinthebag | 看到政府隐瞒，第一反应居然是「怎么能批评 Apple」 |

## 总体情绪

分歧极大，但几乎没有人替保密本身辩护。真正的争论全在「应该怎么办」：继续保密、事后公开、退出英国市场、还是在法庭上硬扛。有人把最坏的情况说得很直白——保密一旦成为默认选项，民主的每一部分都得绕着它长；也有人认为保密的理由早已在判决书里塌了：政府一边在正式场合守口如瓶，一边私下把同一件事告诉记者、外国官员和国会议员，然后在法庭上坚称自己什么都没说过。

另一半注意力落在 Apple 自己身上，而且是不利的：默认的 iCloud 加密本来就不是端到端的，Apple 撤下 ADP 又改不掉措辞，还被反复提起中国区的密钥安排。于是这条讨论出现了一种奇特的形状——人们一边认为政府不该逼出后门，一边认为不值得相信 Apple 承诺自己没有后门。

这场判决真正的杀伤力不在那一句「我们确实发过」，而在它顺带拆掉了另一个说法：政府可以在正式场合守口如瓶，同时私下把同一件事告诉记者、外国官员和国会议员——然后在法庭上坚称自己什么都没说过。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | UK government forced to admit it issued Apple a secret encryption order（HN 主帖） | <https://news.ycombinator.com/item?id=50562113> |
| 2 | UK Government Forced to Admit It Issued Apple a Secret Encryption Order（MacAnorak） | <https://macanorak.com/uk-government-forced-to-admit-it-issued-apple-a-secret-encryption-order/> |
| 3 | Apple Inc and Secretary of State for the Home Department and (1) Privacy International (2) Liberty (3) Ian Hosein (4) Ben Wizner vs Secretary of State for the Home Department（判决书全文，[2026] UKIPTrib 9） | <https://investigatorypowerstribunal.org.uk/judgement/1-mr-vincent-kearney-2-british-broadcasting-corporation-v-1-chief-constable-of-the-police-service-of-northern-ireland-2-chief-constable-of-durham-constabulary-3-security-service-4-governme/> |
| 4 | Two-Tier Encryption in the UK（MacAnorak 前作） | <https://macanorak.com/two-tier-encryption-in-the-uk/> |
| 5 | Apple encryption backdoor UK（The Washington Post，2025-02-07） | <https://www.washingtonpost.com/technology/2025/02/07/apple-encryption-backdoor-uk/> |
| 6 | UK tribunal confirms government order demanding access to Apple data（Reuters，2026-11-19） | <https://www.reuters.com/business/retail-consumer/uk-tribunal-confirms-government-order-demanding-access-apple-data-2026-11-19/> |

## 免责声明

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 513 分、215 条评论，归档快照 2026-11-20 02:04 UTC，入库 120 条，未触及抓取上限）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，HTML 实体按 HN 页面显示形式还原。归档评论的分数字段均为 0（Algolia 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

判决书正文通过公开链接取得（[2026] UKIPTrib 9，公开的 OPEN 部分）。该判决另有同时下达的 PRIVATE 与 CLOSED 两份判决，因涉及公开利益未予公布；本文「原文概要」中的时间线、证人陈述与推理均来自公开判决，对通知内容、当事人提交的全部证据以及闭门部分不作任何陈述。

MacAnorak 原文经 `hn-fetch.rb --fetch-article-url` 抓取时只取到文末推荐链接，正文经网页抓取取得。首份 TCN 签发于 2025 年 1 月、第二份签发于 2025 年 9 月，均依 MacAnorak 与《华盛顿邮报》等公开报道转述，未获官方文件确认；苹果撤回面向英国新用户的 ADP、以及苹果关于不造后门的公开表态，按原文口径转述。

评论区中关于 Apple 将中国区 iCloud 密钥迁至中国、FISA 对 Lavabit 命令的效力、以及英国各政党立场的内容，均为评论者个人判断或转述，本摘要按发言者立场转述，不作事实认定。

本文涉及政府保密、监控权限与基本权利的争议性话题，立场部分均已标注发言者与 HN 评论 ID，不代表本站立场。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
