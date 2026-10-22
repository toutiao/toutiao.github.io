---
layout: post
title: >-
  eMudhra 退出全球 SSL/TLS：1% 的收入，100% 的信任
date: 2026-10-23
hn_id: 50195110
categories: [articles]
excerpt: >-
  董事会说全球 SSL/TLS 只占收入约 1%，社交媒体关注度与业务分量不成比例。
  五年发过六千万张证书的公司，最后靠一条承认错误都懒得写进去的声明收场。
tagline: >-
  十四小时吊销证书，六天退出市场。这中间只隔着一句“社交媒体放大”。
---

## 原文概要

2026 年 10 月 22 日，印度班加罗尔的 eMudhra Limited（BSE: 543533 | NSE: EMUDHRA）发布新闻稿，宣布董事会已决议自愿退出全球 SSL/TLS 证书业务。董事长 V. Srinivasan 在声明中说，公司在发现事故后 14 小时内吊销了受影响的 CA 并及时披露，受影响的 CA 没有签出任何终端实体证书，基础设施未被攻破，也没有数据泄露，所有物理和逻辑安全控制均保持完好。

要理解这个决定的分量，得先说清楚五天前发生了什么。10 月 17 日，安全研究者 Wayne 向 Apple、Google、Microsoft、Mozilla 和 eMudhra 同时报告：eMudhra 八张中间 CA 证书的 P-384 私钥已泄露。证明方式直接到不需要信任——用每张证书的私钥签一句话，把签名和公钥一起公布。八张证书里有六张 TLS 签发 CA（DV/OV/EV 各两代）和两张代码签名 CA，全部创建于 2025 年 4 月，还被 Sectigo 的 AAA Certificate Services 根交叉签名过。研究员 Scott Helme 把 16 份密钥材料拉下来暴力枚举，全部瞬间解开：这些本该是 384 位随机数的私钥 d，实际是 47 个字节的零加一个字节，取值 4、56、115 等，单字节总共只有 256 种可能。这批 CA 从 2025 年 4 月到 10 月 17 日存在了 17 个月。

这 17 个月里，浏览器侧几天之内就封完了：Chrome 当晚推 CRLSet，Firefox 几小时后在 OneCRL 拦截，Mozilla 10 月 20 日发 NSS 更新移除 eMudhra 根证书。但 curl、Python、Node、Go、Java、git 和各包管理器这些非浏览器客户端既不读吊销信息也不查证书透明日志，eMudhra 撤销证书对它们毫无作用——研究者签了一张伪造的 `api.stripe.com` 证书测试，curl 报 `SSL certificate verify ok`，Python 完成握手。真正止血的不是 eMudhra 的动作，而是 Go 1.27.3、certifi 2026.10.19、curl CA bundle 2026-10-20、Ubuntu ca-certificates 20260816 等几十个语言和发行版各自排好的发版队列。

退出声明给出的商业理由有三条：全球 SSL/TLS 只占 eMudhra 全球收入的约 1%；数据主权与合规要求逐年推高这条线的复杂度和成本；一些大机构免费发放 SSL/TLS，挤压了业务潜力和投资回报。承诺部分写得很实在：G1 RSA 根继续服务直到过渡完成，与浏览器计划和客户逐个对接，过渡期内从合作方免费换证，吊销与证书状态服务一直运行到所有已签证书过期或被替换，并会完成对根计划的全部承诺，包括一份完整的根因报告。核心业务不受影响：全球数字签名证书 DSC、eSign、企业 PKI 方案（emCA、CertiNext）、emSigner 电子签名套件、SecurePass 和 emAS 身份认证产品照常运行。这家做了 17 年、服务 35 个以上国家的公司，剩下的是签名和身份，扔掉的是信任。

真正点燃评论区的是声明里的另一句话：社交媒体对此事的放大，让公司承受了与 SSL/TLS 在其业务中分量不成比例的审视。这句话把一场安全事故的因果关系整个倒了过来。

## 讨论焦点

### “社交媒体放大”这句话，比退出本身更致命

> "What a weak minded statement. Just admit you messed up and call it a day." — g_a_a_s [c:50195643]
> （译文：多没脑力的一句话。老老实实承认搞砸了，然后收摊，不行吗。）

这条被顶到前面的批评指向的是结构问题，不是措辞问题。声明先花三段讲业务只有 1%、数据主权成本上升、别人免费发证，把一条由自己密钥生成缺陷引发的事故，包装成了一次理性的商业收缩决定；然后用“关注度不成比例”来解释为什么公司要主动放弃一块业务。这在因果上说不通：如果关注度真的不成比例，最省事的做法是闭嘴发根因报告，而不是花公关预算宣布退出。

更直白的一版：

> "yea sure, blame social media cause you are incompetent. nice" — AdvitXSingh [c:50195454]
> （译文：对啊，没错，因为你自己没本事所以怪社交媒体。妙。）

而技术圈看得更远一层——他们认为这根本不是一次商业决策：

> "Yes they didn't close down the business, it was already gone." — ErikCorry [c:50196549]
> （译文：他们并没有关掉这项业务，它早就已经没了。）

 ErikCorry 的意思是：一个浏览器和操作系统都不认的证书签发方，名下不存在“业务”这回事。退出是把既成事实补上一份文件。另一批人的判断更靠前，在事故刚曝光时就下了结论：

> "Let's be real - there was no way for them to recover their way out of that after this ridiculously bad screw-up." — mschuster91 [c:50195571]
> （译文：现实点说，发生了这种离谱的失误之后，他们不可能翻身了。）

这句话的分量在于它出现在 Chrome 的 CRLSet 推送之前。当晚的读者就已经判定这家公司死刑了，五天后的退出公告只是确认。

### 换个名字，是不是就能重开一局

> "If they wanted to continue to make money, they could: exit the business, wait a bit, change the company name, and re-enter the business." — ahartmetz [c:50195270]
> （译文：如果他们还想继续赚钱，可以这样：退出这门生意，等一阵，改个公司名字，再重新进来。）

这是评论区最长的一条质疑线，而且它不是指责，是技术性推演。顺着这条线往下走的人补了很多细节——最关键的是对客户群体的判断。买商业证书的决策者往往不是工程师：

> "No, the customers for commercial certs are mid-level managers, who believe paying thousands of dollars for something you can also get for free means you are getting a higher quality" — crote [c:50195731]
> （译文：不，买商业证书的客户是中层管理者，他们相信花几千美元买一个本来免费的东西，就意味着质量更高。）

对这类人来说，“不信任的根”配上“ISO 认证的私有专属云端 PKI 即服务”这样的说法，完全能卖出去。而真正的工程师早就装上 certbot 用 Let's Encrypt 默认配置了。这条线很快被反向压回去：

> "Not so easy. They're a publicly traded company, the regulations are quite stringent." — NordStreamYacht [c:50195533]
> （译文：没那么容易。他们是上市公司，监管相当严格。）

上市公司身份是这个计划的硬约束——换名字要走披露、换主体要走监管批准，不像 Meta 改名那么轻：

> "Facebo...I mean Meta did it to distance themselves from the Cambridge Analytica scandal (among others)." — giantrobot [c:50195669]
> （译文：Facebo……我是说 Meta 就改名了，为了跟剑桥分析事件之类的东西撇清关系。）

还有一层现实顾虑压在改名方案上：即使名字换了，浏览器和根计划也不会因为舆论降温就恢复对他们的信任。真的重新进来，还是要过一次比第一次更严的审核。

### 该负责的可能不在这家公司，而在根计划

把矛头指向 CA/Browser Forum、Apple、Google 和 Mozilla 的评论在事故当天就开始了，退出公告只是给了他们新的弹药：

> "CA Forum, Apple, Google and Mozilla are to be blamed for just giving license to random no security background far away company." — jesuswasjew [c:50195220]
> （译文：CA Forum、Apple、Google 和 Mozilla 该负责，他们就这么把信任给了随机找来的、一家远在天边没有安全背景的公司。）

针对“远”这个字，评论区吵了一整条支线。有个读者专门把责任从国籍上摘了下来：

> "Clearly there is a fundamental problem with the overarching approval and monitoring process which means it could have happened anywhere. This time it just happened to be India." — traceroute66 [c:50195459]
> （译文：显然整个审批和持续监控流程有根本性问题，这意味着它完全可能发生在任何地方。这次刚好发生在印度而已。）

这个人的论证还有后半段：印度对外资公司注册和合规的门槛极高，本地业务需要本地 CA 并不是天方夜谭，所以“远”和“印度”这两个词本身不构成事故原因，审批门槛太低才是。他举的历史反例也很有分量——Mozilla 当年被警告不要把 CNNIC 加进信任列表，官方以缺乏证据为由拒绝，直到 CNNIC 误签了 Google 域名的证书才被摘掉。

另一条线指向治理方式的失效：

> "like most governance body, they check independent audit reports, not the actual operation." — j16sdiz [c:50195545]
> （译文：就像大多数治理机构一样，他们核查的是独立审计报告，而不是真实的运行情况。）

证书生命周期的关键环节——HSM 配置、密钥生成、CSR 到根签名之间的传递——全都不在第三方审计的可见范围内。Chrome 团队在 Mozilla bug 2083449 里公开提交的那份问题清单之所以被反复转发，就是因为它逐条问的正是这些审计报告回答不了的问题：

> "They're being asked some very pointed questions about why they encountered problems with the key generation process at the time but didn't properly investigate." — Khoth [c:50196043]
> （译文：他们正在被问一些非常尖锐的问题：当时在密钥生成环节已经出了问题，为什么没有认真调查。）

根计划要承担的其实不只是审核责任。中间 CA 是根签的，一个下游中间 CA 出事，根就可能被摘掉——所以“你的中间 CA 出了问题，你得为别人的根负责”这条约束条款本来就在 CA/Browser Agreement 里。

### 全场在玩同一个数字的梗

这次讨论的独特之处在于，评论区没有停留在愤怒和追责，而是集体玩起了 `4`。源头是那次事故最出圈的一个事实：泄露的八张私钥里，有一个的 d 就是 4。于是新闻稿出现的当天，第一条热评是：

> "This press release was brought to you by the number 4" — gamegod [c:50195202]
> （译文：这份新闻稿是由数字 4 赞助播出的。）

有人直接伪造了一把私钥贴在评论区：

> "-----BEGIN RSA PRIVATE KEY----- 4 -----END RSA PRIVATE KEY-----" — luispa [c:50195618]
> （译文：-----BEGIN RSA 私钥----- 4 -----END RSA 私钥-----）

有人统计了全部八个弱密钥的取值，试图反推它们的生成逻辑：

> "The other keys were 56, 66, 115, 155, 156, 230, 237." — xienze [c:50198459]
> （译文：其他的密钥是 56、66、115、155、156、230、237。）

从统计上其实可以排除“随机撞上”的可能：如果这八个值都在 0–384 之间均匀分布，全部小于 256 的概率大约只有 1/17。更合理的猜测是程序生成了一字节长度的随机数：

> "There's only a ~1 in 17 chance that they'd all be below 256 if 384 was the limit." — jefftk [c:50199014]
> （译文：如果上限是 384 的话，它们全部小于 256 的概率只有大约十七分之一。）

还有一条更像事故报告的诊断：

> "Maybe it was just a mistake and they intended to generate a `--bitsize 4` thinking it was in kilobyte units." — alias_neo [c:50197135]
> （译文：也许只是个失误，他们本想生成一个 `--bitsize 4`，以为单位是 KB。）

底下跟着一整层技术纠错：RSA 私钥必须含两个数、模数和指数；RSA 的私钥指数 d 取 4 完全合法，只要模数 n 足够大，看上去还像那么回事；EC 私钥则必须标注曲线。这些纠错最后被一句玩笑收尾——有人认真分析了“d=4 这把 RSA 私钥是合法的”这件事，然后被回了一句“你给一个笑话做了尸检”。玩笑能玩得这么顺，说明讨论已经从追责滑向了告别。

### 谁来查，查到什么程度

> "Terrible company, such evasive statements. Seems ripe for disruption." — seatac76 [c:50195267]
> （译文：一家糟糕的公司，满嘴躲闪的措辞，看起来很适合被拆了。）

已经有读者指出了监管程序的具体位置：

> "Yes, they are being investigated by the Ministry of Electronics and Information Technology." — adithyareddy [c:50195601]
> （译文：是的，印度电子和信息技术部已经在调查他们了。）

而在司法层面，期待值被拉得更高：

> "There must be criminal matter here." — vlfig [c:50195418]
> （译文：这里面一定有刑事问题。）

八张 CA 私钥在一个 HSM 批量生成过程中变成一字节随机数，中间经过批准偏差、代码缺陷、CSR 生成、根签名、交叉签名五个环节，每个环节都有一次签字确认。要认定这不是单纯的技术事故，需要的解释比“手滑”长得多。而真正让讨论不安的是这个问题的后半段：

> "I think this opens bigger questions on who and how people get access to these capabilities." — sambull [c:50195458]
> （译文：我认为这引出了更大的问题：谁在获得这些能力，以及这些能力是怎么被分发出去的。）

一家公司内部的一台机器误操作，和一批能力被广泛分发的中间 CA，在事故的可见度上是一样的。

### 有人把这件事读成了面子问题

评论区里最不像技术讨论的一支，把整件事归到了文化上：

> "aspects of Indian culture, I can state with clarity that the statement they put out is completely in character." — abixb [c:50196108]
> （译文：在印度文化的那一面，我可以明确地说，他们发出的这份声明完全符合他们的行事风格。）

这条解读在下面引发了两个很短的追问。一个词被反复引用——“izzat”，印地语、孟加拉语、乌尔都语里都有的那个“尊重／体面”：

> "Major loss of izzat here" — profdevloper [c:50196193]
> （译文：这里是一次 izzat 上的重大损失。）

> "TIL too. Sounds like aura." — johanyc [c:50196670]
> （译文：也是新知识。听起来像 aura。）

如果把这条线当回事，它给出的解释是：退出公告本身才是那次事故里最贵的一步。承认失误、公开根因、接受几年治理整改，需要公司集体承认判断力不足；而宣布退出可以把这件事转写成一次战略收缩——不是我们做错了，是这块生意不值得做。声明里那句“关注度与业务分量不成比例”，正是这种修辞的典型形态。有意思的是，两个互不相干的读者各自用不同语言做出了同一个判断。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|---------|
| 退出只是补文件 | ErikCorry | 浏览器和系统都不认的证书签发方，名下本来就不存在业务 |
| 退出算轻的 | mschuster91 | 事故刚曝光时就没了翻身的可能，五天后的公告只是确认 |
| 声明在推责 | g_a_a_s | 承认搞砸然后收摊就行，把责任推给社交媒体是最蠢的写法 |
| 改名即可重来 | ahartmetz | 退出、等待、换名字、再进入，人和办公室都不换 |
| 改名会生效 | crote | 客户是中层管理者，“ISO 认证专属云 PKI”这种说法照卖 |
| 改名难执行 | NordStreamYacht | 上市公司，改名和换主体都得走监管 |
| 责任在根计划 | jesuswasjew | 给一家远在天边、没有安全背景的公司开通行证，错在准入 |
| 事故与国籍无关 | traceroute66 | 审批流程有根本漏洞，这次是印度，下次可以是任何地方 |
| 审计有结构性盲区 | j16sdiz | 治理机构核查的是审计报告，不是真实运行情况 |
| 承诺要能验证 | Khoth | Chrome 问的问题正是审计报告回答不了的那些 |
| 该走刑事程序 | vlfig | 五个环节每一步都有签字，这不是手滑能解释的 |
| 监管已在进场 | adithyareddy | 印度电子和信息技术部已成立调查组 |
| 签发量不等于影响 | Reubachi | 六千万张里可能大半是极短有效期或重复签发 |
| 这是面子损失 | abixb | 退出公告比事故本身更说明问题，修辞是文化层面的 |

## 总体情绪

两场分裂的讨论挂在同一个问题上：损失到底有多大。技术这边给出的答案很具体——八张证书、17 个月窗口、几十个语言和发行版各自排期的信任库发版，事故的实际影响面比“八张中间 CA”这个标题看起来要窄。商业这边给出的答案同样具体——1% 的全球收入、四条产品线毫发无损、17 年积累换一个数字换来彻底清零。

真正让人不适的是第三种读法，它同时否掉了前两种。一个读者说“没人会原谅一个签发不被信任证书的公司”，另一些读者说“他们只需要换个名字”。这两种判断指向的都不是这家公司值不值得信任，而是整个 Web PKI 里“信任”到底是什么——它被写进根证书文件里、由浏览器厂商维护、却可以在几天之内全部收回。当一家公司可以在几天之内失去一整块业务，也可以用一份把责任推给舆论的声明把这次失去描述成主动选择，那么“信任”这个词的定价机制其实从来没被写进任何一份 CA/Browser Agreement 里。

而在所有讨论的底下，还压着一个没有被回答的问题：那台生成出一字节随机数的机器，本来应该由谁来检查。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | eMudhra to Exit global SSL/TLS Certificate Business | https://emudhra.com/en/press-release/emudhra-to-exit-global-ssl-tls-certificate-business |
| 2 | eMudhra Statement on distrust of select Global TLS Intermediate and one Root CA | https://emudhra.com/en/press-release/emudhra-statement-distrust-global-tls-intermediate-root-ca |

---

<div class="disclaimer">
本文根据 Hacker News 热门讨论自动整理，不代表本站观点。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>