---
layout: post
title: >-
  eMudhra 八张证书的私钥，是 4、56 和 115
date: 2026-10-22
hn_id: 50166579
categories: [articles]
excerpt: >-
  八张中间 CA 的 P-384 私钥只有一个字节，d=4 也在其中。Chrome 当晚封杀，curl 和 Python 只能等各自发版；
  17 个月的窗口里，谁也不知道有没有人签过一张假证书。
tagline: >-
  47 个字节的零，后面跟一个 4。这就是整条信任链的锁。
---

## 原文概要

2026 年 10 月 17 日，一个安全研究者 Wayne 向 Apple、Google、Microsoft、Mozilla 和 eMudhra 同时报告：eMudhra 八张中间 CA 证书的私钥已泄露。这八张证书链到 Mozilla、Microsoft、Apple 和 Chrome 根计划信任的根，也链向大量下游信任库。证明方式很直接——用每张证书的私钥签同一句话 `We have a problem here - Wayne`，把签名和公钥一起打包公布，任何人可以用 OpenSSL 复现。

反应速度差异极大。Chrome 当晚推送 CRLSet 封掉这批证书，Firefox 几小时后在 OneCRL 里拦截，Apple 设备 19 号生效，Microsoft 平台 20 号生效。20 号 Mozilla 公开通报并发布 NSS 更新移除 eMudhra 根证书，Chrome Root Store v43 也确认会移除。

而真正让人后背发凉的部分在后面。Mozilla bug 2083449 里的初步评估说，问题出在一段 `KGC`（密钥生成中心）脚本：当天为测试 wrap/unwrap 流程引入了一个批准的偏差，代码缺陷导致第二批更弱的密钥被顺手创建出来；因为标签相似，这批弱密钥被误用来生成 CSR，又被根签了名，还照样送到 Sectigo 做交叉签名。八张证书里有六张 TLS 签发 CA（DV/OV/EV 各两代）和两张代码签名 CA，全部创建于 2025 年 4 月，每张都被 Sectigo 的 AAA Certificate Services 根交叉签名过。

安全研究员 Scott Helme 把全部 16 份（8 个密钥，每个被 eMudhra 和 Sectigo 各签一次）拉下来暴力枚举，全部瞬间解开。这些是 P-384 曲线密钥，私钥 d 本该是 384 位随机数，实际却是 47 个字节的零加一个字节：`d = 4`、`56`、`115`。单字节只有 256 种取值，算 `1×G` 到 `255×G` 最多 255 步就撞上了。证书结构上没有任何异常——公钥是完全合法的曲线点，编码正确，每项检查都通过，只有真去试才知道。

时间窗口有 17 个月。这批中间 CA 从未在证书透明日志里出现过记录，所以强制 CT 的 Firefox、Chrome、Edge、Safari 大概率没被攻击过。但 curl、Python、Node、Go、Java、git 和各个包管理器这些非浏览器客户端既不读吊销信息也不查 CT——eMudhra 撤销证书对它们毫无作用。Scott 在自己的机器上签了一张 `api.stripe.com` 的伪造证书测试：curl 报 `SSL certificate verify ok`，Python 完成握手，Node 报 `authorized: true`，每一台 Linux 和 macOS 都一样；Windows 上 CryptoAPI 默认也接受这条链。

对应的修复清单长得像包管理器发版日志：Go 1.27.3 / 1.26.10、rustls-webpki 0.103.16、certifi 2026.10.19、curl CA bundle 2026-10-20、Electron 44.9.1、Node 22.23.4、Ubuntu ca-certificates 20260816、Arch 3.131.1-1，而 Java、Bun、Erlang 仍是 pending。

## 讨论焦点

### 私钥不是被偷的，是从来没锁过

这是全帖最扎眼的一句总结，来自 thread 2 的一句短评：

> "Their other keys are also in 0..255 range." — thesz [c:50181981] [thread 2]
> （译文：他们的其他密钥也都落在 0 到 255 这个区间里。）

单看一个 4 还可能是手滑，八个密钥全在单字节区间，性质就变了。有人把猜测写得更具体：

> "The sequence number idea is supported by the fact that two of the G3B private keys are consecutive numbers." — muvlon [c:50178723] [thread 2]
> （译文：两个 G3B 私钥是连续的，这个事实支持了“序列号被误当成私钥”的猜测。）

连续这个细节有意思：如果密钥真是随机取样，8 个 0..255 的数撞出两个相邻的概率大约 18%；如果是从某个序列号开始递增，这个现象就是必然。这条线最终没有定论，但方向已经很清楚：这不是入侵，是生成环节。

### KGC 脚本：一次批准过的“测试”，留下一把真锁

Mozilla bug 里的那段自述被完整搬到了 thread 2：

> "there appears to be a flaw in the KGC script that was used on that specific day to create these ECC issuers" — mminer237 [c:50180736] [thread 2]
> （译文：似乎用于当天生成这些 ECC 签发证书的 `KGC` 脚本存在缺陷。）

完整链条是 a) 原始密钥按预期生成，b) 为导出测试引入了批准偏差，c) 代码缺陷导致又生成了一对更弱的密钥，d) 因为标签相似，误用弱密钥生成 CSR 并由根签名，e) 弱密钥的 CSR 还被发给了 Sectigo 做交叉签名。有人顺着这句话去追 HSM 的设计问题：

> "its actually satisfying to see someone get burned by this because such a feature should never exist and this is the reason why" — benmmurphy [c:50181599] [thread 2]
> （译文：看到有人因此栽跟头其实挺解气的，正因为这个功能本就不该存在，这才是它存在的理由说明。）

他的意思是：HSM 能生成落在远小于群阶区间的密钥，这事本身就没有意义，如果有厂商支持这种“生成弱密钥”的测试功能，被烧到是迟早的。这里暴露的审计问题很清楚——密钥生成时有没有人真的看一眼审计日志。

### 止血路径分叉：浏览器几小时，其余生态等发版

主帖最刺的一句抱怨：

> "Web PKI is cursed. Why should anyone have to ship a new version of Go, Electron, webpki-roots, etc. (possibly over a now-compromised TLS connection!) just to revoke a certificate?" — quotemstr [c:50167158]
> （译文：Web PKI 真是被诅咒了。为什么任何人还得专门发一版 Go、Electron、webpki-roots（而且可能是通过一条此刻已被攻破的 TLS 连接发的！）就为了吊销一张证书？）

Mozilla 的 galadran 把落差讲得客气但清楚：

> "for the rest of the ecosystem, there has been little to no investment in revocation and for those clients, this is a massive problem" — galadran [c:50167244]
> （译文：对生态里的其余部分来说，在吊销机制上的投入几乎为零，而对这些客户端来说，这是个大问题。）

技术细节在 mook 那条里：Go 干脆没法用系统吊销列表，只能在自己的信任库里把中间证书拉黑；而很多语言的设计里根本没有“不信任某个东西”这个概念，除了从根证书里删掉：

> "the design didn't have a way to distrust anything other than removal from the root store" — mook [c:50171442]
> （译文：这套设计里除了从根证书库里移除之外，没有别的办法表示不信任。）

这句话解释了为什么修复清单是一长串版本号：吊销不是一次广播，是几万份根证书包各自的一次发版。

### Firefox Android 也差点没拦住

主帖里有几个人报告自己的移动端没有被封住：

> "Firefox Mobile 158.0 on Android 17 (Pixel 7) connects to all the demo sites with zero warnings." — crote [c:50167787]
> （译文：Android 17 上的 Firefox Mobile 158.0（Pixel 7）访问所有演示站点，零警告，全部连上。）

有人试了重装浏览器、禁用 Android 设置里的 eMudhra CA，都没用。当天晚些时候，同一个人回来更新：

> "Update: properly blocked now. Seems like it takes a few hours (days?) for the CRL update to propagate." — crote [c:50172304]
> （译文：更新：现在正常拦截了。看来 CRL 更新要传播几个小时（几天？）。）

几个小时的传播延迟，在这件事上就是几个小时的敞口。这也顺带说明：浏览器那套“几小时止血”并不是全局同时生效，只是比包管理器快得多。

### CT 是免疫，还是只是统计安慰

thread 2 里最有价值的一段攻防，围绕 CT 到底能不能兜底：

> "If 90% of clients did SCT validation, an attacker can still succeed against the 10% that don't, there's no herd immunity." — Scott_Helme_ [c:50182938] [thread 2]
> （译文：就算 90% 的客户端都做了 SCT 校验，攻击者在剩下那 10% 上照样能成功，没有群体免疫这回事。）

对面的观点是覆盖率会改变攻击者的收益计算：

> "Right now CT support is rough for things outside of browsers; it's a pretty fair bet that if you pick up a command line tool or library, it is not checking SCTs" — akerl_ [c:50182512] [thread 2]
> （译文：目前浏览器之外对 CT 的支持很粗糙；你随手拿一个命令行工具或库，它多半没在校验 SCT。）

两边其实都对，只是分母不同：一个在算单个客户端是否安全，一个在算攻击者的期望收益。而 CT 只检测误签、不阻止误签，这层含义双方也都承认——它把“没人知道”变成了“所有人都知道”。

### 该杀掉 CA，还是该杀掉 TLD

架构之争从这次事故一路烧到 DANE。tptacek 的判断很直白：

> "Nobody is switching domain names as a result of this eMudhra thing; they're just going to switch CAs, when eMudhra is murdered by the root programs. But switching domain names would be the only thing you could do if a DANE key was mishandled." — tptacek [c:50183074]
> （译文：这次 eMudhra 事件没有一家网站会换域名，它们只会换 CA，等着根计划把 eMudhra 处决掉。但如果是 DANE 的密钥出了同样的事，你能做的只有换域名。）

支持 Web PKI 的一方强调 CA 有死刑：

> "If a CA does something stupid or malicious, the browsers remove that CA from their root stores, effectively ending that CA’s existence as a going concern." — akerl_ [c:50175523]
> （译文：一家 CA 干了蠢事或坏事，浏览器就会把它从根证书库里移除，等于让这家 CA 作为持续经营主体就此结束。）

反对方的核心反驳是信任该分布而不是集中：不该让 Google、Microsoft、Apple、Mozilla 四家成为决定谁可信的仲裁者，也不该让每个 TLD 运营者掌握全网加密密钥。这场争论在 HN 上从十年前的 DNSSEC 一直吵到现在，本次事故只是给了它一张新面孔。thread 2 里有人用一句话把结构问题说完了：

> "Each CA is like a padlock locked in series with other padlocks. The weakest padlock is the only one that matters." — epanchin [c:50179179] [thread 2]
> （译文：每家 CA 都像一把和其他挂锁串在一起的挂锁，最弱的那把才决定一切。）

### 懒，还是故意留门

事故定性上，thread 2 的一串回复最放松也最真实：

> "They literally were too lazy to type more than just a single '4'." — MiroslavPokorny [c:50175672] [thread 2]
> （译文：他们真的是懒到只敲了一个 '4' 就完事。）

另一个人补了键盘上的规律：

> "All the numbers also have digits going from left to right on a keyboard." — account42 [c:50178872] [thread 2]
> （译文：这些数字在键盘上都是从左到右递增的。）

也有人在结构层面找补：100 家受信 CA 是不是太多了，答案是该有个最小能力检查。

> "In retrospect, not having a tiny competency check may have been an oversight." — tclancy [c:50178482] [thread 2]
> （译文：现在回头看，没有一道哪怕极小的能力检查，可能是个疏漏。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|---------|
| 懒到离谱 | MiroslavPokorny | 只敲了一个 `4` 就当私钥，这不是攻击，是手滑 |
| 事故是系统性能力缺失 | tclancy | 100 家 CA 的门槛里，缺一道最小能力检查 |
| 浏览器之外全是裸奔 | galadran | 浏览器几小时解决，其余生态几乎没投过吊销 |
| 根证书包发版即止血 | mook | 设计里除了从根里删掉，没有别的“不信任”手段 |
| CT 只是统计安慰 | Scott_Helme_ | 10% 客户端不校验，攻击照样成立，没有群体免疫 |
| 覆盖率能改变博弈 | akerl_ | 命令行工具默认校验 SCT，攻击收益会大幅下降 |
| 保留 CA 的死刑 | akerl_ | 出了事根计划直接把 CA 摘掉，这是最强的约束力 |
| 该换 DANE / DNSSEC | quotemstr、account42 | 信任应该分层到 DNS，而不是集中在少数浏览器厂商手里 |
| 换不掉 CAs | jcranmer | 用户不想也没有能力自己做信任判断，委托出去是理性选择 |
| 传播延迟就是敞口 | crote | Firefox Android 上，封锁生效前那几个小时谁也不知道 |

## 总体情绪

两场讨论的分裂点很清楚。一场在技术上：私钥只有 8 位这件事让整批人愤怒，但愤怒很快转成了具体的版本号清单——Go 升到哪个版本、certifi 什么时候发、Java 什么时候跟上，谁都在认真抄。另一场在制度上：这次事故被反复当作论据，证明 Web PKI 该被 DANE 取代，而反对方的回应也同样老练——你没法把一个 TLD 运营者从用户的信任列表里摘掉。

最让人不安的其实不是这八张证书，而是它们背后那个 17 个月的窗口。没有入侵痕迹，没有时间点，CT 日志里一片干净，所有能证明“没人干坏事”的证据都只能证明“没人被发现干坏事”。这正是 thread 2 那句“no herd immunity”的意思：CT 让作弊留了痕迹，但痕迹只对会看的人有意义。而这个生态里，绝大部分客户端连看都不会看。

值得记住的对比是修根证书的成本结构：eMudhra 已经撤销了证书，这一步没用，因为默认不查吊销的客户端照单全收。同一场事故里，真正起作用的是几十个语言和发行版各自的信任库发版，而它们的节奏完全不由任何人统一调度。

一把只值 8 位的锁，配上了需要几万次发版才能关上的门。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | eMudhra Intermediate CA Compromise | https://emudhra.we-have-a-problem.com/ |
| 2 | Eight Bits of Trust; eMudhra's CA keys cracked in milliseconds | https://scotthelme.co.uk/eight-bits-of-trust-emudhras-ca-keys-cracked-in-milliseconds/ |

---

<div class="disclaimer">
本文根据 Hacker News 热门讨论自动整理，不代表本站观点。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>