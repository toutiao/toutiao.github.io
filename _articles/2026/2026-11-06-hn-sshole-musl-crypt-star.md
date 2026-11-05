---
layout: post
title: >-
  一个星号，十年后门：musl 的 crypt() 让 OpenSSH 认了所有密码 — HN 讨论摘要
date: 2026-11-06
hn_id: 50378228
categories: [articles]
excerpt: >-
  Alpine 上一个本该没有密码的账户，接受任何 257 到 1024 个字符的密码。起点是 1980 年
  Bill Joy 写在 /etc/passwd 里的一个星号，中间是 2012 年 musl 的两次提交，终点是
  2026 年 11 月的一次拼接。十年里没人看见，是因为没人把这些碎片放在一起。
tagline: >-
  musl 少写了一个 NULL，于是 OpenSSH 替全世界记了十年账。
---

> 来源：HN 讨论主帖 [*sshole](https://news.ycombinator.com/item?id=50378228)（1760 分，465 条评论），原文是 sshhole.com 上的一篇交互式长文。关联帖：[OpenSSH 10.6p2 has been released with a workaround for a critical vulnerability](https://news.ycombinator.com/item?id=50377221)（165 分，78 条评论），原文是 OpenSSH 开发者 Damien Miller 的 Mastodon 公告。本篇为 cluster 模式，主帖为 sshhole 的复盘长文（thread 1），OpenSSH 官方发布与紧急公告为 thread 2。
>
> 归档快照：主帖 2026-11-05 19:37 UTC（100 条评论），thread 2 为 2026-11-05 19:38 UTC（78 条）。

## 原文概要

sshhole.com 的开场只有一句话：OpenSSH 跑在 musl libc 上（Alpine、OpenWrt、Buildroot、Yocto，以及大量你拉过的 Docker 镜像），从 2016 年起就有了一个小问题——那些本不该接受任何密码的账户（root、只用密钥的部署用户、LDAP 用户、Alpine 云镜像里的默认用户），会接受任何长度超过 256 字符的密码。站名叫 *sshole，那个星号既是标题也是漏洞本身。

漏洞的历史从 1980 年开始。Bill Joy 在 3BSD 的 `/etc/passwd` 里给 `daemon` 账号放了一个 `*`，真实名字写着“the devil himself”。`*` 不是哈希，任何密码都匹配不上，所以它成了“此账号不可登录”的通用写法，一直沿用到今天。哈希后来搬进 `/etc/shadow`，长成 `$6$abc$k2P9…` 这样的形式，sshd 用同一个 salt 算一遍再比对。

但 POSIX 有个规矩：`crypt()` 失败要返回 NULL（1997 年的 Single UNIX Specification 原文如此）。问题在于很多程序根本不检查 NULL，直接拿返回值去比较，撞上 NULL 就崩。于是 2012 年 8 月 musl 提交 b3c4cc12，把 `crypt()` 失败时的返回值从 NULL 改成单字符 `"*"`——commit message 写的是“always "succeeding" but giving an unmatchable hash is reportedly a better behavior than failing on error”，diff 里删掉了那句 `Should not happen.` 和 `return NULL;`，换成了 `return (setting[0]=='*') ? "x" : "*";`。原文特意引用了这句“reportedly”，把评论留在了那里。

二十天后，2012 年 8 月 29 日，musl 提交 88bf5a8a 加入 sha256/sha512 版 `crypt()`。sha512crypt 的计算量随密码长度增长，是个天然的 DoS 面，所以 musl 把它限制在 256 字节：`#define KEY_MAX 256`，超过就直接 `return 0`。而 musl 的 sha512 实现里那句“on error "*" is returned”从头到尾就写在注释里——错误路径返回的，正是那个用来表示“不可登录”的星号。

2016 年，CVE-2016-6210 给 OpenSSH 打了补丁：不存在的用户也会拿别人的 salt 算一遍密码，把时序差抹平，注释写的是“for invalid users”。而 shadow 里存着 `*` 的真实用户，走的正是这条“借盐”路径。2019 年 CVE-2019-5021 之后，Alpine 把 root 锁成 `!`；但没有 PAM 时，`!` 会连 SSH 密钥登录一起干掉，而云镜像恰恰靠密钥登录。2022 年 Alpine 3.16 把 root 改回 `*`——锁着，密钥又能用了。原文在这里只有一句:narrator: it did not。

于是是十年安静。原文明说：也许有人把一整段 SSH 私钥粘进了密码提示框，也拿到了登录权，只是没人把它当成漏洞报出来。也有几次擦肩而过：2013 年 Debian 的 libc-alpha 邮件列表里有人请求 glibc 抄 musl 的 `"*"`，六年后 Debian 换用 libxcrypt，它返回的是 `"*0"`——差一个字符；2024 年 12 月 musl 邮件列表讨论 busybox `passwd` 处理 257 字符密码出错，同一个 `"*"`，同一个长度上限，帖子里没人提 sshd；2026 年 10 月 30 日的 openssh-commits 邮件里，一次安全评审修掉了 `pick_salt()` 的 bcrypt 问题，真正的洞在它下面四行——作者是四天后才发现的。

作者自己撞上的过程更像个笑话。他把 sshd 用 glibc / musl / PAM / 无 PAM / shadow / 无 shadow 各种方式编译，扔了大约 17600 次奇怪的登录进去——怪哈希、坏账号、超长密码。然后他补了一句：oh did i say “i”? sorry. i had agent swarms. a lot of them. 所有构建在所有登录上答案一致，除了 musl 且无 PAM 的那一个。站名 *sshole 就是这么来的。

触发条件是五个条件的 AND：sshd 链到 musl、没走 PAM、密码登录开着、shadow 里至少有一个密码字段是 `*` 的账号、再加至少一个真正有密码的账号。缺任何一个都安全。glibc、走 PAM 的发行版、Dropbear、OpenBSD 都不受影响；Alpine 官方 AWS/Azure 镜像里的默认 `alpine` 用户配免密 `doas`，等于 root。修法两条：升级 OpenSSH 10.6p2，或者 `PasswordAuthentication no`。原文最后给了一个自查方法——翻日志，看有没有哪次“带密码的账号登录成功”根本不该存在。

thread 2 是 OpenSSH 开发者 Damien Miller 的公告：10.6p2 是一个 workaround，根因在 OpenSSH 之外；受影响的是使用 musl libc 且不使用 PAM 的 Linux 系统；之所以发得这么快，是因为他们前一天才知道这件事：

> We are making this release as fast as possible (we learned of the problem yesterday) because we have recently observed multiple cases of rapid bug rediscovery by AI agents, sometimes within hours, and so now consider long embargo periods to be a dangerous practice that primarily benefits attackers.
> （译文：我们之所以这么快就发布（昨天才得知这个问题），是因为我们最近观察到 AI agent 多次在几个小时内重新发现了同一个 bug，因此现在认为漫长的保密期是一种危险做法，它主要便宜了攻击者。）

公告里还致谢了报告人 Özgün Kültekin（Wakefield）和 Alpine 开发者。

## 讨论焦点

### 一、这台机器到底有多严重：五个条件必须同时成立

先降温的是 thread 2 里的一条提醒。dpoloncsak 把 sshhole 首页那句“任何 256 到 1024 字符的密码都能进”拆成了一串限定条件：

> "Maybe I’m misunderstanding, but u/tonnydourado pointed out on another thread https://news.ycombinator.com/item?id=50378228#50380029 &quot;It starts with a bold claim: &quot;ssh accounts that should not accept a password will accept any password between 256 and 1024 characters&quot;. But then it keeps adding qualifiers: - sshd compiled with musl - not using PAM - password logins enabled - at least one account with '*' as the password &quot;hash&quot; - at least one OTHER account with a valid password The conditions are all ANDed, miss a single one and you’re fine.&quot; This doesn’t seem to be nearly as big as an issue as they’re making it out to be" — dpoloncsak [c:50380189] [thread 2]
> （译文：也许是我理解错了，但 u/tonnydourado 在另一个帖子里指出……它一开始抛出一个大胆的说法：“本不该接受密码的 ssh 账户会接受 256 到 1024 字符之间的任何密码。”但随后它不断追加限定条件——用 musl 编译的 sshd、不使用 PAM、开着密码登录、至少有一个密码“哈希”是 `*` 的账户、再加上至少一个拥有真实密码的其他账户。这些条件是逻辑与的关系，缺一个你就没事。这件事没被吹得那么严重。）

但 bombcar 的反驳同样具体，他逐条评估每个条件在现实里有多容易凑齐：

> "Alpine matches the first. Disabling PAM has been &quot;generally good security advice&quot; for decades; I remember suggestions to not use it in the 2000s. Password logins are often enabled, especially on multi-user and default setups. If alpine uses the * feature, it’s going to be pretty common. Gentoo has it, as does Ubuntu. If password logins are enabled, you’re almost guaranteed to have at least one user with a password (root on all my boxes has one, even if I never use it and it’s random garbage). So the cheese lines up pretty well, this affects quite a bit. If password logins are enabled, someone almost certainly has a password." — bombcar [c:50380335] [thread 2]
> （译文：Alpine 满足第一条。“不用 PAM”几十年来一直是公认的安全建议，我记得 2000 年代就有人这么建议。密码登录通常还开着，尤其是多用户和默认配置下。如果 Alpine 用的是 `*` 这个特性，那它会相当普遍，Gentoo 有，Ubuntu 也有。只要密码登录开着，你几乎必然会至少有一个带密码的用户（我所有机器上的 root 都有一个，哪怕我从来不用，而且是一串随机垃圾）。所以这套cheese 摆得很齐，影响面相当大。只要密码登录开着，几乎肯定有人是有密码的。）

主帖里最尖锐的一问来自 hypfer，他不接受“理论上存在”，只问“实际上有什么在跑”：

> "What is out there that uses musl without PAM and hosts an OpenSSH SSHd with PasswordAuthentication? As in: &quot;Actually out there&quot; The hypothetical Alpine exists, yes, but what runs that like that?" — hypfer [c:50378417]
> （译文：外面到底有什么东西在用 musl、不用 PAM，同时还跑着开了密码认证的 OpenSSH sshd？我是说“真的在外面跑着”。假设中的 Alpine 当然存在，但那到底什么在这么跑？）

答案是“比想象的多”，但给出的例子往往经不起追问。jbyers 说基数够大，小众比例乘以 Alpine 容器的总量就是个很大的绝对数：

> "A large number of Docker containers? Edit: Sure, a small minority presumably run sshd under these conditions. But a small minority times the number of Alpine containers running in the world gets to a large absolute number. Edit 2: You really don’t need to look very hard to find public container examples at million-download scale." — jbyers [c:50378440]
> （译文：大量 Docker 容器？补充：跑 sshd 的肯定是少数，但少数乘以全世界 Alpine 容器的数量，就是个很大的绝对数。再补充：你根本不用费力就能找到百万下载量级的公开容器案例。）

同一串里 ekidd 指出大部分容器根本不需要 sshd：

> "Many, many Docker containers rely on &quot;docker exec&quot; or the kubectl equivalent to gain CLI access when needed. To have sshd in an Alpine Docker container, you’re generally need to be running init and a bunch of demons, not just a single standalone service. I’m guessing in practice relatively few people are actually exposed. But if they are, it’s catastrophic." — ekidd [c:50378469]
> （译文：很多很多 Docker 容器靠 `docker exec` 或者 kubectl 的等价命令来拿命令行权限。要在 Alpine 容器里跑 sshd，通常你得同时跑 init 和一堆守护进程，不是单个独立服务就行。我猜实践中真正暴露的人相对不多。但如果暴露了，就是灾难性的。）

Good4boothee 的回应更直接：

> "No one runs sshd in containers, at least I hope so. What would even be the point when you have docker/kubectl commands available?" — Good4boothee [c:50378676]
> （译文：没人在容器里跑 sshd，至少我希望没有。都有 docker/kubectl 命令了，跑 sshd 还有什么意义？）

blueflow 补上事实：Alpine 镜像里 sshd 根本没预装，得自己写进 Dockerfile 还不管配置；Dwedit 给出反例——用 LXC 而不是 Docker，在容器里跑 OpenSSH 是真事。figassis 给出的是最现代的一类：agent 沙箱。

真正拿出实例的是 Bender，他干脆开了一台机器请人试：

> "I will activate one for people to play around with for today: sftp hn@ping.ohftp.org There’s no firewall and no password. Hack away HN." — Bender [c:50378503]
> （译文：今天我开一台给大家随便玩：sftp hn@ping.ohftp.org。没有防火墙，没有密码。来 hack 吧，HN。）

不过也有人当场怀疑默认配置根本不是这样。MPSimmons 说 Alpine 默认用的是 `!` 而不是 `*`，照着教程打并不奏效：

> "Is this actually effective against Alpine? The default install seems to use ! as the placeholder in /etc/shadow instead of * and trying the attack doesn’t seem to work." — MPSimmons [c:50378747] [thread 2]
> （译文：这招对 Alpine 真管用吗？默认安装看起来在 /etc/shadow 里用的是 `!` 而不是 `*` 当占位符，我试着打了一次似乎没用。）

这一节的分歧最后落在“容器里到底装了什么”这种最朴素的地方：

> "You’d be surprised by the amount of people using containers that don’t know/care what is inside." — dormento [c:50378991] [thread 2]
> （译文：你会对“根本不知道自己容器里装了什么、也不在乎的人有多少”感到惊讶。）

### 二、musl 那个决定，是罪魁还是替罪羊

主帖里第一个真正的技术分支，是回头审判 musl 2012 年那个提交。cube00 的提问带着火气：

> "Considering it’s been accepted that crashing if malloc returns a NULL is your fault, did musl really feel the need to accommodate bad implementations like this or is this just AI speculation?" — cube00 [c:50378451]
> （译文：既然“malloc 返回 NULL 你就崩，这是你自己的错”已经被公认，那 musl 是不是非要迁就这种烂实现？还是说这只是 AI 的臆测？）

Good4boothee 给出了防御性的答案——兼容性永远要有人买单：

> "I don’t know about this specific case but in general? Yes, totally. No one is going to fix all existing software that depends on libs behaving exactly as glibc, you have to accept some trade-offs. Either your new implementation stops being perfectly simple and clean, or no one uses it." — Good4boothee [c:50378657]
> （译文：这个具体案例我不知道，但一般来说：是的，完全如此。没人会去修所有那些依赖“库的行为和 glibc 完全一致”的既有软件，你必须接受一些权衡。要么你的新实现不再简单干净，要么没人用你的实现。）

Palomides 则直接搬规范：

> "it’s not &quot;glibc behavior&quot;, returning null on error is in the spec" — Palomides [c:50379041]
> （译文：这不叫“glibc 的行为”，出错返回 NULL 是写在规范里的。）

red75prime 把 musl 当年的 commit message 原文贴了出来，其中“reportedly”四个字被作者自己抓了个正着：

> "&quot;unfortunately, a large portion of programs which call crypt are not prepared for its failure and do not check that the return value is non-null before using it. thus, always &quot;succeeding&quot; but giving an unmatchable hash is reportedly a better behavior than failing on error.&quot;" — red75prime [c:50378659]
> （译文：“不幸的是，很大一部分调用 crypt 的程序没有为它的失败做好准备，使用返回值前也不检查是否为 null。因此，总是‘成功’但给出一个永远匹配不上的哈希，据说比失败时返回错误是更好的行为。”）

更有意思的争论是：这些单看都合理的决定是怎么凑到一起的。trebligdivad 列出三条动机——别让一堆程序崩、别有时间差攻击、让账号可以没有密码：

> "Each one relies on a perfectly valid argument - that * can’t match because we all know it’ll be rejected by the other thing." — trebligdivad [c:50378712]
> （译文：每一条都建立在一个完全站得住脚的论证上——`*` 不可能匹配，因为众所周知它会被另一头拒掉。）

Retr0id 的反驳只有半句，却把整条论证掀了：

> "But that’s not a perfectly valid argument, and it never was." — Retr0id [c:50378809]
> （译文：但那根本不是个站得住脚的论证，而且从来都不是。）

有人补上了这条链的名字：

> "See also: Hyrum’s Law" — vova_hn2 [c:50379474]
> （译文：另见：海勒姆定律。）

结论派则把话说到 reputational 的份上。nxobject 说的是审计缺失，semiquaver 直接掀桌：

> "Above all, I’m a little sad that the musl developers decided to make a lot of “well it’s convenient” changes to core crypto functions ... It’s tarnished their reputation in my eyes a little." — nxobject [c:50378559]
> （译文：最让我难过的是，musl 开发者对核心加密函数做了一堆“反正方便”的改动……这多少让他们的名声在我眼里受损。）

> "A little?!? I’m sorry, but musl is a joke, this is yet another proof of that fact, and I have no idea why anyone uses it in production, they have only themselves to blame after the many warning signs." — semiquaver [c:50378704]
> （译文：一点？！抱歉，musl 是个笑话，这不过是又一个证明。我完全不知道还有谁在生产环境用它，在那么多预警信号之后，他们只能怪自己。）

thread 2 里也有人把责任往 OpenSSH 那边分。mpyne 的技术判断最细：musl 的防御逻辑本身没错，错在 OpenSSH 为了掩盖时序差而“借盐”，最后拿 musl 的结果去跟真实账号比：

> "Well, OpenSSH contributes to this by mixing hashes from the shadow file. The musl code would be correct if OpenSSH passed in the hash from the user account that is being logged-in. They instead pass in a different user’s hash (to avoid timing attacks) but end up comparing the result from musl against the actual user account, defeating musl’s simplistic safeguard to avoid this very issue. I’d probably still call this a musl thing. Errors should result in a NULL return even if the application crashes from there, but at the very least a return value intended to not match any actual hash in /etc/shadow should be a random string or predefined UUID or something other than *." — mpyne [c:50379447] [thread 2]
> （译文：OpenSSH 对此也有份，因为它把 shadow 文件里的哈希混着用。如果 OpenSSH 传的是正在登录那个账号的哈希，musl 的代码就是对的。他们为了避免时序攻击，传入的是另一个用户的哈希，最后却拿 musl 的结果去和真实账号比较，正好把 musl 那点简陋的防护绕过去了。我大概还是会说这是一件 musl 的事。出错就该返回 NULL，哪怕应用因此崩掉；但至少，一个注定匹配不上 /etc/shadow 里任何真实哈希的返回值，应该是一段随机字符串、一个预设 UUID，或者干脆不是 `*` 的东西。）

amluto 的总结更不留情面：

> "Wow, what a bug. I expect the exploit is literally as simple as trying to ssh in as a user with the password has ‘*’ in /etc/shadow and typing anything as the password. ... P.P.S. The musl code in question is nuts. The API it implements is awful. ... You can’t call this function correctly." — amluto [c:50378099] [thread 2]
> （译文：嚯，这 bug。我猜利用方式简单到只需要用一个 /etc/shadow 里密码是 `*` 的用户 ssh 登录，然后密码随便填。……再补一句：涉及的这块 musl 代码简直离谱。它实现的那个 API 糟透了。……这个函数你没法正确调用。）

规范角度的判决来自 thread 2：

> "musl libc violates the POSIX documented behavior of `crypt()` ... Musl returns '!' or '*', not null." — SAI_Peregrinus [c:50380199] [thread 2]
> （译文：musl libc 违反了 POSIX 对 `crypt()` 的成文规定……musl 返回的是 `!` 或 `*`，不是 null。）

### 三、C 语言的账：哨兵值、和类型、以及改不了的 ABI

主帖最大的一条支线，是把这个洞继续往语言层面追。zarzavat 一句话定了性：

> "The real problem here is the C language. Our industry should have dumped it a long time ago and we’re now paying the price of prevarication." — zarzavat [c:50378830]
> （译文：这里真正的问题是 C 语言。我们这个行业早就该把它扔了，现在只是在为当初的虚言付出代价。）

理由不是“C 有内存管理 bug”，而是 C 没有把错误表达成类型。nh2 说得很干净：

> "Any use of sum types would have prevented this immediately. The whole thing exists because APIs that return a NULL value that &quot;nobody checks&quot;, plus a string that you shouldn’t use if you actually did check the null value. In languages with sum types, this cannot happen. Either you get your hash, or no result at all. You couldn’t get eg NULL and *." — nh2 [c:50379008]
> （译文：任何和类型（sum type）的使用都能立刻避免这件事。整个问题的存在，是因为 API 返回一个“没人检查”的 NULL，同时又返回一个“就算你真去检查了也不该用”的字符串。在有和类型的语言里这不可能发生。你要么拿到哈希，要么什么结果都没有。你不可能同时拿到 NULL 和 `*`。）

muvlon 把这个机制展开成语言学：多返回值、异常、和类型三样都没有，C 的 API 只能靠带内哨兵值报错。

> "C’s lack of all of - sum/union types - multiple return values/tuple types - exceptions means that most ways of returning an error from a function are not available in C. Because of this, many C APIs, including `crypt` in this case, resort to in-band error signalling by using a sentinel value (like NULL, a negative integer, &quot;*&quot; etc.). Most other languages lack one or two of the above, but very few lack all three, and so most have developed a different culture around error reporting (Result in Rust, multiple return values in Go, exceptions in Java, Python etc.)." — muvlon [c:50379062]
> （译文：C 同时缺了这三样——和类型/联合类型、多返回值/元组、异常——意味着函数报错的大多数常见方式在 C 里都用不了。因此很多 C API，包括这里的 `crypt`，只能退而用带内信号报错，也就是用一个哨兵值（NULL、负数、`"*"` 之类）。大多数语言只缺其中一两样，很少有三种全缺的，所以它们大多发展出了不同的报错文化（Rust 的 Result、Go 的多返回值、Java 和 Python 的异常等等）。）

但“C 有联合类型”这句话立刻招来反驳。jppittma 说 tagged union 在 C 里早就有了：

> "C has unions. C has sum types. People have been doing tagged unions in C for longer than rust has been a language" — jppittma [c:50379519]
> （译文：C 有联合类型。C 有和类型。人们在 C 里写 tagged union 的历史，比 Rust 这门语言存在的时间还长。）

creata 承认事实，但指出那不是能用的东西：

> "It is extremely unidiomatic to use tagged unions in C for error handling. It’s definitely possible, but awkward, and the compiler doesn’t check that you checked the tag." — creata [c:50380895]
> （译文：用 tagged union 在 C 里做错误处理极其不地道。确实可行，但很别扭，而且编译器不会检查你有没有检查那个 tag。）

aliceryhl 补上关键一刀：写 `crypt` 的人压根没用：

> "Yet the authors of crypt did not use them. The C language is not designed in a way to encourage people to write code that correctly uses tagged unions (or nullable pointers for that matter)." — aliceryhl [c:50379758]
> （译文：可 `crypt` 的作者们并没有用。C 语言的设计本身，就不会鼓励人们写出正确使用 tagged union（或者可空指针）的代码。）

争论随即滑向“C 是不是弱类型语言”这条老战场。uecker 说不然：

> "C is not a weakly typed language, this is just nonsense. There is also [[nodiscard]] which you can use to make sure a return value is handled." — uecker [c:50380868]
> （译文：C 不是弱类型语言，这纯属胡说。C 里还有 `[[nodiscard]]`，你可以用它确保返回值被处理。）

muvlon 同意这个词本身没有定义，但给出了自己对弱类型的理解：

> "What is a weakly typed language to you? To me, implicit type conversions are a big part of the definition, and C is flush with those ... However, I also think &quot;weakly typed&quot; is not a well-defined concept, everyone seems to apply it differently. In particular, it seems to mostly mean &quot;playing it loose with types in a way that I don’t like&quot;." — muvlon [c:50381398]
> （译文：对你来说，什么叫弱类型语言？对我来说，隐式类型转换是定义里很重要的一部分，而 C 里到处都是这类转换……不过我也认为“弱类型”不是一个定义良好的概念，每个人好像都在用不同的方式套它。尤其它似乎主要意味着“用一种我不喜欢的方式随意对待类型”。）

真正卡住这条路的是 ABI 契约。dolmen 解释了为什么 libc 不能顺手把返回值换掉：

> "The function signature is enforced by the linker. The semantic of strings that go through isn’t. ... The main issue here is that libc is a strong API contract based on C function signatures, that nobody can change, only augment with new symbols. Such strong API compatibility constraints happen in any programming language, and workaround to fit new behaviours in old APIs happens everywhere." — dolmen [c:50380017]
> （译文：函数签名是由链接器强制执行的，但字符串的语义不是。……这里的核心问题是 libc 是基于 C 函数签名的强 API 契约，没人能改它，只能加新符号。这种强 API 兼容性约束在任何语言里都存在，为了把新行为塞进旧 API 而做的变通，也到处都有。）

xorcist 则抓住了“`*` 这个具体取值”的荒谬性——errno 一直在，载荷字段总得填点东西，为什么偏偏是 `*`：

> "This argument is weak. C, and specifically libc, has errno. The error code is there. Not in band. But there has to be something in the payload field when it is not applicable. A null is perfectly fine. ... If you are convinced it was it would still have been better to select a less trivial dummy value (such as &quot;*:ERROR:*&quot;)." — xorcist [c:50382029]
> （译文：这个论证站不住。C，尤其是 libc，是有 errno 的。错误码在那儿，不是带内的。但载荷字段在不适用的时候总得放点东西，NULL 完全可以。……如果你确信那真是必要，那也该选一个不那么trivial的哑值，比如 `*:ERROR:*`。）

而 Rust 派指出 Rust 之所以不同，不在于编译器更严，而在于类型本身不同。ninkendo 说得很细：

> "Rust and go still make it pretty easy to not check results if you don’t care about the success value ... The problem is when the compiler says “NULL is a valid instance of T”, which go lets you do, and rust doesn’t ... Go lets you write code like `var hash string; hash, _ = hashfn()` and it compiles and now you have null instead of a valid hash." — ninkendo [c:50379095]
> （译文：如果你不关心成功值，Rust 和 Go 一样很容易让人不检查结果……问题出在编译器说“NULL 是 T 的一个合法实例”的时候——Go 允许，Rust 不允许……Go 里你可以写 `var hash string; hash, _ = hashfn()`，它能编译，然后你拿到的就是 null，而不是一个有效的哈希。）

有人点了这句的名：

> "This by the way is Tony Hoare’s famous &quot;Billion Dollar Mistake&quot;" — tialaramex [c:50379409]
> （译文：顺带一提，这就是 Tony Hoare 那个著名的“十亿美元错误”。）

f1shy 不接受“这锅是语言的”：

> "I understand that other languages could help avoiding the semi-predicate problem. That being said, in C there are better ways around semi-predicates, as inelegant as they may be, is possble, is not an inherent problem of the language, but may a bad habit/idiom of it." — f1shy [c:50380876]
> （译文：我理解别的语言有助于回避半谓词（semi-predicate）问题。即便如此，在 C 里也有绕开半谓词的办法，虽然可能不够优雅；这不是语言的固有缺陷，可能只是它的坏习惯/坏惯例。）

最后这一节由 uecker 收口，他把责任从语言挪到了人和钱：

> "I do not think the issue here is caused by not having a pre-defined result type. Checking for null would have been fine. The issue was that to accommodate old and broken code a compromise was made. ... The real issue is that nobody wants to spend money or effort maintaining the old code. No language can fix this." — uecker [c:50383210]
> （译文：我不认为这里的问题源于缺少预定义的结果类型。检查 NULL 本来就够了。问题是为了迁就又老又破的代码而做了一个妥协。……真正的问题是没人愿意花钱花力气去维护那些老代码。没有哪种语言能解决这个问题。）

同一个人还有一句更冷的话，被另一个人当成整条线索的注脚：

> "There is no industry, it’s just people" — 01HNNWZ0MV43FF [c:50378924]
> （译文：哪有什么行业，只有一群人。）

> "It’s always a people problem. Doing a bad patch on my side is easier than bothering anyone else to fix their code" — 01HNNWZ0MV43FF [c:50378971]
> （译文：这永远是一个人的问题。在我这头打一个烂补丁，比去麻烦别人修他的代码要省事。）

### 四、AI 在这里扮演什么角色

这个洞是 agent 群找到的，于是评论区自然分成两派：一派认为 AI 找洞被高估了，一派认为披露窗口正在被压缩。

rustyhancock 属于前者，他描述的是“脚枪”而不是“黑魔法”：

> "I think everyone is over fixated on AI finding complex bugs beyond a typical person’s understanding either to locate or exploit. I think for any one of those bugs there might simply be half a dozen footguns or bugs that once it’s spelled out you wonder how anyone let it slide. ... It’s challenging though as the current AI audits produce so many false positives it’s hard to know when it’s being pedantic or when it’s genuinely caught a human being a bone head" — rustyhancock [c:50378679]
> （译文：我认为大家都过度执着于 AI 能找出超出普通人理解能力的复杂 bug，不管是定位还是利用。我倒觉得，对这样一个 bug，可能只是有半打子脚枪式的坑，一旦被说明白，你就会想当初怎么没人当回事。……不过这事很难说，因为现在的 AI 审计会冒出大量误报，你很难分辨它是在吹毛求疵，还是真抓到了个蠢货。）

jamal-kumar 站在相反方向，讲的是现实后果：

> "Finding more and more that these complex bugs people gloss over like you are now are being used in exploit chains and the end result is still my clients getting hacked" — jamal-kumar [c:50378917]
> （译文：我越来越多地发现，像你们现在这样被人一笔带过的复杂 bug，已经被用进 exploit 链子里，最终结果还是我的客户被黑。）

svnt 则指出这个洞在真实世界其实不难找，只是作者的方法不适合野外：

> "This one might be hard to find using the author’s approach of throwing everything at various builds of ssh. It is not really that hard to find in the wild if you had a device built this way, when overflowing buffers on embedded devices is a standard attack vector. It might be hard to root cause, but it would not be that hard to find." — svnt [c:50380416]
> （译文：用作者那种“把各种 ssh 构建版本都拿来试一遍”的方法，这个洞可能确实难找。但如果有一台这么造出来的设备，在野外找它并不难——在嵌入式设备上溢出缓冲区本来就是标准攻击向量。定位根因也许难，但找到它不会那么难。）

真正的分水岭在 thread 2：OpenSSH 官方把“AI agent 在几个小时内重新发现同一个 bug”写进了发布说明的理由。dust42 的评价很短：

> "I think this will likely become standard. Nevertheless, a few stormy months are ahead." — dust42 [c:50378682] [thread 2]
> （译文：我觉得这很可能会成为常态。不过，接下来几个月会不太平静。）

至于“这到底算谁的锅”，thread 2 里吵得最凶。bigbadfeline 认为标题有误导性：

> "You became a victim of a very misleading post title. This isn’t an OpenSSH problem at all, it’s a musl problem. ... I’m pretty sure the misleading wording is deliberate" — bigbadfeline [c:50382288] [thread 2]
> （译文：你被一个极具误导性的标题骗了。这根本不是 OpenSSH 的问题，是 musl 的问题。……我确信这种误导性的措辞是故意的。）

另一些人直接指认 OpenBSD 和 glibc 阵营：“他们做对了什么”：

> "No, the bug is in musl but manifests in OpenSSH when compiled against it." — heavensteeth [c:50379084] [thread 2]
> （译文：不，bug 在 musl 里，只是当 OpenSSH 对着它编译时才显形。）

> "OpenBSD is not affected, so apparently they are doing something right. But also glibc linux is not affected and pam linux is not affected, so it is only musl linux with the remote hole." — somat [c:50379649] [thread 2]
> （译文：OpenBSD 没中招，所以他们大概做对了什么。但 glibc 的 Linux 没中招，走 PAM 的 Linux 也没中招，所以只有 musl Linux 身上有那个远程洞。）

### 五、这个网站本身：讲得清楚，但读起来像 AI 写的

主帖还有一大半篇幅在讨论站点本身，这个站做得相当用力，于是也招来了一整片批评。

正面评价只有一句，但很具体：

> "I liked that this site explained the vulnerability in an easy-to-understand way." — jdw64 [c:50378476]
> （译文：我喜欢这个站把漏洞讲得容易理解。）

负面评价从“这是一个好站，但我毫无感觉”开始：

> "That’s a well-made site, yet I feel nothing." — neuroticnews25 [c:50378449]
> （译文：这站做得挺用心，可我一点感觉都没有。）

> "LLM output fatigue?" — cpach [c:50378475]
> （译文：LLM 输出疲劳？）

追问 AI 味的人给出了数量判断：

> "Slop, no question. There’s at least 10 Claudisms on the page, and I’m not that good at smelling them. Some of the sentences might have been human-written." — fwip [c:50383164]
> （译文：毫无疑问是 slop。这页上至少有 10 处 Claude 腔，而我闻香气的本事没这么好。其中有些句子可能是人写的。）

内容层面的批评更硬：

> "It has a crap load of text but says very little and is very bad at conveying the details because it thinks it has to tell some weird story." — mrguyorama [c:50380980]
> （译文：它塞了一大堆文字却几乎没说什么，而且因为自认为必须讲一个奇怪的故事，把细节传达得很糟。）

> "I dunno, there were some strange discrepancies in the explanation (and captions). Didn’t really hang together." — phyzome [c:50379017]
> （译文：不知道，解释（还有图注）里有几处奇怪的出入，读起来对不上。）

也有替它辩护的：bonplan23 认为这类“AI 味”恰恰说明作者反复调过提示词：

> "I do actually. My guess is that this was not just one-prompted, but someone took the time to refine it based on their tastes and expectations until it matched something they would actually like. ... if someone already developed a strong AI-slop-tingle it will still be triggered by some telltale signs and let their subconsciousness know that they can’t possible enjoy this." — bonplan23 [c:50379920]
> （译文：我确实有。我的猜测是，这不是一次提示词写出来的，而是有人花时间按自己的口味和期待反复调，直到它变成自己真的会喜欢的东西。……如果你已经对 AI slop 形成了强烈条件反射，那么某些特征还是会触发它，让你的潜意识告诉你：这个你不可能喜欢。）

xnorswap 的问题更扎人：既然洞是 agent 群找到的，为什么这个站要手工做这么大工程量？

> "It would be weird to spend this much effort doing the site by hand, for a bug that the author says was found by a swarm of agents." — xnorswap [c:50379092]
> （译文：为一个作者说是 agent 群找到的 bug，花这么大功夫手工做这个站，挺奇怪的。）

另一半的批评跟 AI 无关，是交互设计：滚动动画劫持了阅读。ordu 从注意力角度说了两句最实在的：

> "I can’t understand it. All this scrolling and pictures are distracting me, can’t concentrate really." — ordu [c:50378699]
> （译文：我理解不了。全是滚动和图片，太干扰，根本没法集中注意力。）

> "With static text it is easier to fix, you have just to jump back a bit, when you notice that you’ve forgot to read while you were reading. ... But with all this scrolling it is hard to jump backward/forward at will. It feels tiring and annoying." — ordu [c:50381012]
> （译文：静态文本更容易补救——你发现自己在读的时候其实没读进去，只要往回跳一点就行。……但满屏滚动之下，很难想回跳就回跳、想前跳就前跳。这很累人，也很烦。）

ChrisRR 说得更直接：

> "Can we just have a site with the text and images without the awkward scrolling crap? Hijacking basic features is an instant click away from sites for me" — ChrisRR [c:50378553]
> （译文：能不能就给我一个只有文字和图片的站，不要那套别扭的滚动花活？劫持浏览器基础功能，对我来说就是一次点击就再也不回来了。）

vavkamil 补上了动画最实际的毛病——不能重放：

> "Yep, scrolling through my phone and reading slowly to understand. I’m seeing distracting animations below what I’m reading. And when I go to them, there is no way to restart them. So it completely misses the point." — vavkamil [c:50378895]
> （译文：我确实是在手机上慢慢往下滚、慢慢读。我正在读的内容下方还有干扰性的动画，等我滚到它们那儿，又没有办法重新播放一遍。所以这完全没打中要点。）

还有人对名字本身不满意。tasuki 注意到星号后面两个 h 一个明一个暗：

> "How is anyone[0] obsessive enough to find this and write it up and yet not obsessive enough to make the amount of `h` consistent?" — tasuki [c:50378612]
> （译文：怎么会有人[0] 执着到能把这个洞找出来、还写成文章，却又不执着到把 `h` 的数量弄一致？）

还有人嫌那页 tl;dr 是画蛇添足：

> "I really like creativity in the name, the way website built and the content &quot;tl;dr&quot; was a bit of a downgrade though, but that’s fine it’s a nice way to promote the company behind it" — gosen [c:50378437]
> （译文：我很喜欢名字上的创意、网站的搭法和内容，&quot;tl;dr&quot; 那段稍微有点掉价，不过也行，这是给背后公司做宣传的好方式。）

### 六、运维侧：那条“不要用密码登录”的建议有多难执行

公告给的第一条建议是 `PasswordAuthentication=no`。但 thread 2 里立刻有人提醒，这条指令并不像字面意思那么彻底：

> "PasswordAuthentication=no usually means that ssh stops directly reading /etc/passwd to authenticate, not that it stops accepting passwords completely. You’ll still be able to log in with a correct password, provided KbdInteractiveAuthentication is still on, PAM is available, and the PAM policy allows for it." — gfv [c:50378753] [thread 2]
> （译文：`PasswordAuthentication=no` 通常只意味着 ssh 不再直接读 /etc/passwd 来做认证，而不是彻底不接受密码。只要 KbdInteractiveAuthentication 还开着、PAM 可用、并且 PAM 策略允许，你仍然可以用正确的密码登录。）

而现实中，有相当多的客户不打算配合：

> "We have clients (regulated banks and insurers of various sizes) that send us feeds via SFTP. You might be surprised what proportion of them ignore our “we strongly recommend key based authentication” and ask for password auth instead." — dspillett [c:50378870] [thread 2]
> （译文：我们有一些客户（受监管的银行和保险公司，规模不一）通过 SFTP 给我们送数据。你可能会惊讶，有多大比例的人无视我们“强烈建议使用密钥认证”的说法，直接要求密码认证。）

于是有人提议干脆把 SSH 从公网撤走，换成 WireGuard。理由不是 WireGuard 更难攻，而是它可配的旋钮少：

> "Wireguard allows effectively no configuration around auth, and so it’s more likely that it is configured in a secure manner. Openssh allows: password auth with weak passwords, PAM with potentially insecure PAM modules, gssappi, configurable ciphers, etc. Wireguard has none of those. Each of those auth methods adds more possible vulnerable code paths and accidentally insecure configurations." — TheDong [c:50380234] [thread 2]
> （译文：WireGuard 在认证上基本不给配置空间，所以更可能被配成安全的样子。OpenSSH 则允许：弱密码认证、可能配得不安全的 PAM 模块、gssapi、可配置的加密算法等等，WireGuard 这些都没有。每多一种认证方式，就多一条可能出问题的代码路径，多一种不小心配错的机会。）

连报错信息都是攻击面的问题：

> "Not only that, wireguard doesn’t even reply if they don’t have the right key, while SSH does so the attacker knows there is at least a target." — vadansky [c:50380286] [thread 2]
> （译文：不只是这样，WireGuard 在对方没有正确密钥时连回应都不给，而 SSH 会回，于是攻击者至少知道这里有个目标。）

至于“到底还有多少人在用密码登录”，疑问和现实互相打脸：

> "Who does PasswordAuthentication=yes in this day and age anyway." — asdfsa32 [c:50378097] [thread 2]
> （译文：都这个年代了，还有谁在用 PasswordAuthentication=yes 啊。）

最后一节讨论偏离了漏洞本身，变成一场关于“密码登录是否必要”的哲学推演。有人提出极端场景：醒来在一个陌生地方，所有设备都丢了，只能靠一台能上网的笔记本，怎么找回你的数字生活？

> "How do you break back into your digital life? You wake up in a strange place. Something happened. Everything’s gone. No wallet/keys/smartphone/tablet/laptop. How would you get back into your digital life given only a laptop with access to the Internet, unless something, somewhere is passwordauthenticate=yes." — solyin [c:50378101] [thread 2]
> （译文：你怎么找回自己的数字生活？你在陌生地方醒来，出了什么事，什么都没了：钱包、钥匙、手机、平板、笔记本。你手上只有一台能上网的笔记本，你怎么回到你的数字生活？除非某个地方某台机器是 passwordauthenticate=yes。）

答案分两派，一派认为密码认证的场所是物理世界：

> "The somewhere for password authentication is a place you have physical access. Not ssh." — fn-mote [c:50378370] [thread 2]
> （译文：那个“某个地方某台机器”，应该是你有物理访问权的地方。不是 ssh。）

另一派从“正常”的定义出发：

> "at this point the _last_ thing i care about is my email. where am i? am i ok? how are my friends/loved ones? once those are in place, it becomes clearer how to get back to &quot;normal&quot;" — jareklupinski [c:50378274] [thread 2]
> （译文：到这一步，我最后才在乎邮件。我在哪儿？我还好吗？我的朋友和亲人怎么样？这些都确认了，才谈得上回到“正常”。）

而运维上的一个真实疏漏也在这时被提出来：OpenSSH 把“critical security workaround”写进了 release notes，安全公告页上却什么都没有。

> "Seems slightly confusing that the OpenSSH release notes page says: ... But that there’s nothing about it on their security page. Even if it’s not technically a bug in their code, the fact that they’ve made a &quot;critical&quot; release to address it suggests that it should probably be listed on the security page as well." — entuno [c:50378061] [thread 2]
> （译文：OpenSSH 的发布说明页写着“本次发布包含一个针对使用 musl libc 且禁用 PAM 的 Linux 系统的关键安全变通”，但他们的安全页面上却什么都没写。就算技术上不是他们代码的 bug，既然他们为解决它发了一个“关键”版本，那大概也应该在安全页面上列出。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 条件是 AND，缺一不可 | dpoloncsak | musl、无 PAM、开着密码登录、`*` 账号、另一个真密码账号 |
| 条件其实很容易凑齐 | bombcar | 不用 PAM 是老建议，密码登录默认开着，几乎必然有人有密码 |
| 现实里到底有什么在跑 | hypfer | “The hypothetical Alpine exists, but what runs that like that?” |
| 容器不是重灾区 | ekidd | 容器靠 `docker exec`，真要跑 sshd 得连 init 一起 |
| 容器里没人知道自己装了什么 | dormento | 干脆自己 `FROM scratch` 造镜像 |
| 默认配置未必中招 | MPSimmons | Alpine 默认是 `!` 不是 `*`，照教程打没用 |
| musl 的取舍有正当理由 | Good4boothee | 没人会去修所有依赖 glibc 行为的旧软件 |
| 规范站在 NULL 这边 | Palomides | 出错返回 NULL 是写在 POSIX 里的 |
| 决定单看都合理 | trebligdivad | 三条动机各自成立 |
| 但论证从来都不成立 | Retr0id | “that’s not a perfectly valid argument, and it never was” |
| 这是海勒姆定律 | vova_hn2 | 兼容性妥协的经典形态 |
| musl 声誉受损 | semiquaver | musl 是个笑话，早有无数预警 |
| OpenSSH 也有份 | mpyne | 借盐比对，正好绕开 musl 的防护 |
| 根子在 C 语言 | zarzavat | 行业早该扔掉 C，现在在付代价 |
| 和类型能一劳永逸 | nh2 | “要么拿到哈希，要么什么结果都没有” |
| C 的错误表达靠哨兵值 | muvlon | 缺多返回值、异常、和类型，只能带内报错 |
| C 有和类型，只是不用 | creata | tagged union 极其不地道，编译器也不管 |
| libc 的 ABI 改不了 | dolmen | 链接器强制签名，只能加符号不能改行为 |
| 哑值不该是 `*` | xorcist | 换成 `*:ERROR:*` 会好得多 |
| Go 也有同一个坑 | ninkendo | `hash, _ = hashfn()` 编译通过，然后你拿到 null |
| 这不是语言的固有缺陷 | f1shy | 半谓词在 C 里也能绕开 |
| 真正的问题是不想维护老代码 | uecker | “No language can fix this.” |
| AI 找复杂 bug 被高估 | rustyhancock | 一堆脚枪罢了，只是 AI 审计误报太多 |
| 但这类洞正在进 exploit 链 | jamal-kumar | 结果还是我的客户被黑 |
| 野外其实不难找 | svnt | 嵌入式设备上缓冲区溢出本就是标准攻击面 |
| 保密期已经不管用了 | dust42 | AI agent 几小时内就能重新发现，会成为常态 |
| 不是 OpenSSH 的锅 | bigbadfeline | 这是 musl 的问题，标题故意误导 |
| OpenBSD 和 glibc 做对了 | somat | 只有 musl Linux 有那个远程洞 |
| 站点讲得清楚 | jdw64 | 把漏洞讲得容易理解，这部分很讨喜 |
| 但整站像 AI 写的 | fwip | 页面上至少有 10 处 Claude 腔 |
| 手写这么大的站很奇怪 | xnorswap | 洞是 agent 群找到的，站为什么手工做 |
| 滚动动画干扰阅读 | ordu | 静态文本里你只要往回跳一点就行 |
| 劫持基础功能即失去读者 | ChrisRR | 一次点击就再也不回来了 |
| `PasswordAuthentication=no` 不彻底 | gfv | KbdInteractive 和 PAM 还在，密码仍可能通 |
| 客户不听劝 | dspillett | 银行和保险公司的 SFTP 客户要密码认证 |
| SSH 不该暴露在公网 | TheDong | WireGuard 的旋钮少，配置不容易出错 |
| 安全公告页漏了一条 | entuno | “critical”版本却没在安全页面列出 |

## 总体情绪

这帖的底色不是恐慌，是拼图。技术细节其实只有几行：`*` 被当成“不可登录”的标记用了四十六年，musl 在 2012 年为了不让老程序崩溃，把失败时的返回值也变成了 `*`，而 OpenSSH 恰好会把真实用户的哈希拿去做比对。每一块单独看都合理，连起来就是一把万能钥匙。真正让人后背发凉的不是这个洞有多深，而是十年里它离公开只差几个字符：Debian 的 libxcrypt 差一个字符，busybox 的邮件列表差一个话题，一次 OpenSSH 安全评审差四行代码。

而讨论的重心又悄悄滑到了别处。musl 该不该背锅，C 语言该不该被扔掉，密码登录还有没有必要存在，WireGuard 是不是更该取代 SSH——这些都不是漏洞本身，是一整个技术社区在用十年时间慢慢偿还的旧账。评论区里最见血的那句话是“没有哪种语言能解决这个问题”：问题从来不是语言不够安全，而是没人愿意为旧代码付钱。

最后还留着一个更大的变量。找到这个洞的是 agent 群，OpenSSH 也因此取消了长达数月的保密期，只用一天就发了版本。有人觉得这是安全流程的进步，有人看到的却是另一种节奏的加速：当同一个洞可以在几小时内被反复重新发现，窗口期的意义就要重写了。这个洞本身是一次意外——一个星号，撞上另一个星号。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | sshole | <https://news.ycombinator.com/item?id=50378228> |
| 2 | OpenSSH 10.6p2 has been released with a workaround for a critical vulnerability | <https://news.ycombinator.com/item?id=50377221> |
| 3 | 原文：\*sshole · sshhole.com | <https://sshhole.com> |
| 4 | 原文：OpenSSH 10.6p2 发布公告（Damien Miller） | <https://hachyderm.io/@damienmiller/117563026759098135> |
| 5 | 原文：OpenSSH 10.6p2 release notes | <https://openssh.com/releasenotes.html> |
| 6 | musl 提交 b3c4cc12（crypt 不再返回 NULL） | <https://git.musl-libc.org/cgit/musl/commit/?id=b3c4cc121f70faea45389fe7ddc1127ed5cbd8bb> |
| 7 | musl 提交 88bf5a8a（sha512 crypt，KEY_MAX 256） | <https://git.musl-libc.org/cgit/musl/commit/?id=88bf5a8a8d7d796f63cca8589f4de67aa8345f1a> |
| 8 | musl 邮件列表：busybox passwd 与 257 字符密码（2024-12） | <https://www.openwall.com/lists/musl/2024/12/31/2> |
| 9 | Debian bug #714219（请求 glibc 抄 musl 的 `*`） | <https://bugs.debian.org/714219> |
| 10 | Alpine aports fbe926af（root 从 `!` 改成 `*`） | <https://gitlab.alpinelinux.org/alpine/aports/-/commit/fbe926afc76de76e07d078f266badc4144dde8e3> |
| 11 | POSIX crypt() 规范 | <https://pubs.opengroup.org/onlinepubs/9799919799/> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（thread 1 共 100 条，快照 2026-11-05 19:37 UTC；thread 2 共 78 条，快照 2026-11-05 19:38 UTC）及原文抓取内容（sshhole.com、OpenSSH 10.6p2 发布公告、musl 相关提交与邮件列表）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。文中漏洞影响范围、受影响系统清单与修复状态截至 2026-11-05，原文与官方公告中的条件限定请以原文为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
