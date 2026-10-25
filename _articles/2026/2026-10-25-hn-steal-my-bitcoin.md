---
layout: post
title: >-
  他在故意留漏洞的 PHP 服务器上藏了 502 美元比特币，等着人来偷 — HN 讨论摘要
date: 2026-10-25
hn_id: 50224916
categories: [articles]
excerpt: >-
  奖金自己涨到 2018 美元，却没人宣布得手。这台 PHP 服务器给 AI 时代的漏洞恐慌标了个价。
tagline: >-
  一个 PHP 零日的真实市价：500 美元，还是 15000 美元？
---

## 原文概要

2026 年 10 月 24 日 20:30 UTC，一位叫 cloudlandsdev 的用户把一个站点丢上 HN，标题只有五个词：Show HN: Steal My Bitcoin。站点在 stealmybitcoin.com。这条帖在 HN 拿到 424 分、260 条评论。

页面正文很短，规则只有四条：服务器上藏着一枚约 502 美元的比特币私钥，能通过 PHP 用户账号下的 `print-flag` 二进制读到；这台机器的 PHP 版本是特意从 PHP2Shell 那批 CVE 公开之前挑的；第一个拿到钱包的人赢；所有流量都记录在案，页面自己写明「这是一台已知有漏洞的机器，无法保证隐私，其他攻击者可能访问或监控我们控制不了的活动和数据，不要提交任何你不想被看到的东西」。标题下面有一行计数器，写「多少小时无人成功下手」；页面底部的挑战钱包地址是 `bc1qlnu50y4zm0nwxkckxu09thn5xdcz8aw6t3cxqy`，旁边挂着一个区块浏览器链接；描述里另有一行小字：不需要这笔钱的话，考虑捐给 givewell.org。

然后没有人得手。21:09 UTC，也就是这道题开放 39 分钟后，nayuki 在评论区贴出页面的完整副本，计数器写着 0.65 hours without a successful hack —— 差不多正好是从发布到现在的全部时间。到 22:20，有人往钱包里又打进一笔钱，xmcp123 的反应是「有人往基金里加钱，现在它是 1004 美元了」。00:11，johanyc 贴出余额：0.02500416 BTC，约合 2,018.29 美元。奖金自己翻了四倍，被偷走的仍然是零。

这台服务器究竟跑的是什么配置，评论区自己摸了一遍。randomblock1 报出是 PHP 8.4.26 加 nginx，并提醒「我找到的页面都是静态的，不是真正的 PHP 入口」；jackdecker 指出 nginx 后面还压着 1MB 请求体上限；LZ2DMV 提出，`expose_php` 是开着的，只是在用合法 HTTP 方法时把 `X-Powered-By` 从响应里滤掉了，非法方法那部分没管。

背景在评论里被反复提到：PHP2Shell 那批 PHP 远程执行漏洞公开才几天，舆论已经在喊「AI 让漏洞利用变得廉价，几千个 AI 代理会自动扫网」。所以这道题真正的目的，是给这种恐慌标一个价。

## 讨论焦点

### 一、这道题不是考漏洞，是在给恐慌标价

这是评论区读出来的第一层意思，也是讨论的主线。cortesoft 把它说得最干净：

> "The entire exercise is to counter the claim that AI means every script kiddie with tokens can just have their AI create an exploit, and then have their AI scour the internet for vulnerable endpoints." — cortesoft [c:50226322]
> （译文：整个练习就是为了反驳这样一句话：AI 意味着任何一个手里有 token 的脚本小子，只要让 AI 写个漏洞利用，再让 AI 扫遍互联网找漏洞目标就行。）

fwlr 用一个数字把这层意思钉死：

> "If the actual price tag behind the “AI can trivially automate exploits, be afraid” narrative is more like $15,000 and not like $150, that puts the narrative in a very different light." — fwlr [c:50225545]
> （译文：如果「AI 能把漏洞利用自动化，别怕」这套叙事背后的真实标价其实是 15000 美元，而不是 150 美元，那这套叙事的观感就完全不一样了。）

> "Great way to inject some price information into the “AI automates exploits at scale” narrative. “AI can now chain complex exploits, it’s point-and-click pwnage, you say? Over or under $500 a pop?”" — fwlr [c:50225617]
> （译文：这是往「AI 规模化自动化漏洞利用」这套叙事里注入价格信息的好办法。「所以 AI 现在能串联复杂漏洞利用了，点一下就沦陷，是吗？一次多少钱，500 美元以上还是以下？」）

但 fwlr 自己也说了，这个实验提供的信息其实很少，价值在于「在叙事现状里算是个明显的改善」：

> "It’s not very much information, I agree. Even such scant information, however, is a significant and refreshing improvement on the current state of the narrative. Kudos to the servermaster, I say." — fwlr [c:50225819]
> （译文：我同意，信息量确实不大。但哪怕这么点信息，对当下这套叙事的现状来说，也是显著且让人耳目一新的改善。我得向站主致敬。）

jgalt212 则把「没人得手」直接当成结论读：

> "That's part of the point.  $500 or $1000 is a trivial amount.  Since the money is still there, there's currently no trivial exploit." — jgalt212 [c:50226198]
> （译文：这正是重点所在。500 美元或 1000 美元都是小钱。既然钱还在那儿，那就说明目前不存在「随便谁都能用的」漏洞利用。）

站在反方向的人也不少。snailmailman 的提问被重复引用：

> "I'm seeing a few comments that say $500 isn't enough, and its not worth it for them to try to hack it." — snailmailman [c:50225765]
> （译文：我看到有几条评论说 500 美元不够，对他们来说不值得动手。）

他追问的是同一件事的另一面：如果 AI 干这件事的 token 成本低于 500 美元，那这笔账立刻就算得过来。TacticalCoder 从另一个角度提了同一个期待：

> "Nice CTF! I hope if it's captured by a LLM we'll get a write up as to how it did it." — TacticalCoder [c:50225197]
> （译文：漂亮的 CTF！希望要是被 LLM 拿下了，能出一篇它是怎么做到的复盘。）

uFMace 在当天最后补了这段观察，理由是 PHP2Shell 的补丁放出才三天：

> "I think the point is that this is completely the opposite of the narrative that was pushed about this bug - that there would be thousands+ of AI agents actively compromising every vulnerable site automatically regardless of value within minutes of the fix being released into the wild." — ufmace [c:50226684]
> （译文：我认为重点在于，这跟围绕这个漏洞被推起来的那套叙事完全相反——那套叙事说，补丁一放出去，几千个以上的 AI 代理就会在几分钟内自动攻陷每一个有漏洞的站点，不管值不值得。）

### 二、500 美元买不到一个零日：一场经济学口水战

评论区最长的一段争论，是关于这笔奖金到底够不够。jerrythegerbil 是「不够」这一派最完整的表达：

> "The value proposition here is so hilariously low for what is required to demonstrate stealing the bitcoin at all." — jerrythegerbil [c:50225383]
> （译文：就「证明自己能把那比特币偷走」所需要的投入而言，这里的性价比低得可笑。）

> "Make it $15-25k and it’ll get yoinked instantly, most likely without using PHP2Shell at all." — jerrythegerbil [c:50225383]
> （译文：把奖金提到 1.5 万到 2.5 万美元，它会立刻被顺走，而且多半根本用不上 PHP2Shell。）

他的论证是机会成本：这个漏洞是有价值的资产，扔在一个已知会记录一切、可能是蜜罐的机器上换 500 美元，等于把真本事白送。

oofbey 立刻反驳，而且把问题推回了出题人身上：

> "I’d say you’re the one who doesn’t understand the economics at play here. To me and I’m guessing the OP it’s quite simple. Have the exploits become common/simple enough to be worth $500 yet?" — oofbey [c:50225711]
> （译文：我要说，不懂这场博弈里经济学的是你。对我、对出题人（我猜）来说，这事很简单：漏洞利用是不是已经普及到值 500 美元的程度了？）

zulban 把期望值算给所有人看：

> "You may need to brush up on your game theory. It's worth it to spend $1 for a 1% chance to win a million dollars. You don't need to be certain the key is there for it to be worth it to do a supposedly trivial exploit." — zulban [c:50225777]
> （译文：也许你该补补博弈论。花 1 美元买 1% 概率中一百万美元是值得的。你不需要确定私钥真的在那儿，「据说很简单」的漏洞利用就值得一试。）

echoangle 顺着这条线往下算，得出一个具体数字：

> "Shouldn’t the expected value of attempting this somehow include the likelihood of the key actually being on the machine? Surely the probability is much higher than 0? I would guess the expected value for actually being the first one is around $300, not 0" — echoangle [c:50225902]
> （译文：尝试这件事的期望值，不是应该把私钥真的在机器上的概率也算进去吗？这个概率总不至于低到 0 吧？我猜第一个拿到手的期望值在 300 美元左右，而不是 0。）

janalsncm 则把这道题和真实世界的比例关系摆了出来：

> "Every reason you just gave for not hacking this server is also true for servers which don’t have a $500 prize, which is almost all of them out there." — janalsncm [c:50226025]
> （译文：你刚才给出的每一个「不去打这台服务器」的理由，对那些没有 500 美元奖金的服务器同样成立——而外面的服务器几乎都是这种。）

paulpauper 用一句话收尾了「不够」这一派：真正的职业选手不会为 1000 美元亮出手里的牌。

而 fwlr 干脆编了个段子把这套争论变成了行为经济学的教材：

> "Two economists walk past $500 lying on the ground. “I know nobody leaves hundred dollar bills lying on the ground, but that really did look like five hundreds bucks back there, should we go back for it?” Says the first. The second replies “I don’t turn around for less than $15,000.”" — fwlr [c:50226692]
> （译文：两个经济学家路过地上躺着的一张 500 美元。「我知道没人会把百元大钞扔在地上，但刚才那确实看着像五百块，我们回去看看？」第一个说。第二个回：「低于 15000 美元我不回头。」）

### 三、这台服务器比想象中难打

另一条线是纯技术。msm_ 指出 PHP2Shell 那一类漏洞利用并没有一个「一招通吃」的现成 PoC：

> "The only problem is that (as of now) exploiting PHP requires some knowledge about the server configuration, and we don't have that here." — msm_ [c:50225576]
> （译文：唯一的问题是（就目前而言），利用这个 PHP 漏洞需要对服务器配置有一定了解，而这里我们并不掌握这些信息。）

jerrythegerbil 在另一条回复里说得更具体：GitHub 上那个现成 PoC 对这台机器不通用。

> "Exactly. This server is exploitable, but not with an off-the-shelf PHP2Shell PoC someone found on GitHub." — jerrythegerbil [c:50226104]
> （译文：没错。这台服务器是可利用的，但用不了有人在 GitHub 上找到的那个开箱即用的 PHP2Shell PoC。）

评论区最实在的贡献来自几位动手摸过的人。randomblock1 测出了版本，也顺手指出一个可能致命的细节：

> "It runs PHP 8.4.26 (and nginx). Might be useful for others." — randomblock1 [c:50225405]
> （译文：它跑的是 PHP 8.4.26（外加 nginx）。对别人可能有用。）

> "Also, the only pages I found are static and not an actual PHP entry point. If it doesn't run any PHP, it's not vulnerable to PHP2Shell. At least I think that's how it works." — randomblock1 [c:50225405]
> （译文：另外，我找到的那些页面都是静态的，不是真正的 PHP 入口。如果它根本不跑 PHP，那它就不受 PHP2Shell 影响。至少我是这么理解的。）

jackdecker 补的是防护这一侧：

> "Made tough here as you’re behind nginx w/ a 1MB request body cap! Sweet idea :)" — jackdecker [c:50225351]
> （译文：这里是加固过的，因为你在 nginx 后面，还有 1MB 请求体上限这个限制。好想法。）

LZ2DMV 则发现了一个配置上的不一致：

> "So expose_php is On and he filters X-Powered-By in the response when legal HTTP verbs are used, but nothing catches the illegal ones? Interesting." — LZ2DMV [c:50225979]
> （译文：所以 `expose_php` 是开着的，他在合法 HTTP 方法下把 `X-Powered-By` 从响应里滤掉了，但非法方法那部分没管？有意思。）

randomblock1 顺着这个发现给出了 PHP 内部的解释：

> "No, PHP's static handler (php_cli_server_begin_send_static) doesn't emit X-Powered-By but the error page handler (php_cli_server_send_error_page) always does." — randomblock1 [c:50226159]
> （译文：不是这样。PHP 的静态文件处理器（`php_cli_server_begin_send_static`）不会发出 `X-Powered-By`，但错误页处理器（`php_cli_server_send_error_page`）总是会发。）

也就是说，这台机器到底有没有真的 PHP 入口，页面探测给不出确定答案——而这恰恰是「能不能利用」的第一道门槛。

### 四、蜜罐质疑：服务器可以撒谎

评论区第二长的争论，是这道题在方法论上到底能证明什么。akerl_ 给出了最常被引用的一条：

> "A reminder that this cannot falsify the existence of an exploit, trivial or otherwise." — akerl_ [c:50225334]
> （译文：提醒一句，这个实验无法证伪漏洞存在这件事，无论漏洞是不是「简单」。）

> "It can only show you if someone has used an exploit against this server." — akerl_ [c:50225334]
> （译文：它只能告诉你，是否有人用漏洞利用攻击过这台服务器。）

muvlon 说得更直接：

> "It cannot even show that. The server can lie (trivially)." — muvlon [c:50225391]
> （译文：它连这个都证明不了。服务器可以撒谎（而且很容易）。）

从博弈论角度，Stevvo 给出的是同一件事的另一面——如果私钥不在，那所有「不值得动手」的理由都自动成立：

> "You have not proven the key really is on the server. From a game-theory point of view I have no reason to believe it is there, and thus no reason to attack." — Stevvo [c:50225481]
> （译文：你并没有证明私钥真的在服务器上。从博弈论角度看，我没有理由相信它在那儿，于是也没有理由动手。）

hau 的那条评论，则被当成这个设计的原始立意：

> "That's a good way to make claims about existence of a trivial exploit in the wild falsifiable." — hau [c:50225251]
> （译文：这是让「野外存在简单漏洞」这类说法变得可证伪的好办法。）

### 五、奖金自己涨到 2018 美元：石头汤的阴影

奖金自己涨到四倍这件事，引出了评论区最尖锐的一问：这是不是钓鱼。A1kmm 写下了那条最完整的分析，并且明确说这不是在指控出题人，而是在分析这种结构本身为什么危险：

> "This could be a 'stone soup' scam where the OP has the wallet keys (obviously), and puts this up to bait the addition of more funds into the wallet by other interested people." — A1kmm [c:50227882]
> （译文：这可能是一场「石头汤」骗局：出题人自己掌握着钱包私钥（这是显而易见的），把这个架子搭出来，引诱其他感兴趣的人往钱包里追加资金。）

他还提出了两个变体：把机器做得比真实部署更难利用，可以用来对外宣称「这漏洞其实没那么容易打」；反过来，如果漏洞其实很好打，出题人从钱包里自己把钱提走，就能对外宣称「这漏洞太容易打了」。无论哪个方向，操作舆论都能给真正握着利用的人争取时间。

A1kmm 也给出了替代方案，用可验证执行来替代信任：让攻击者在一个 ZKVM 里跑真实漏洞代码，交出零知识证明，由以太坊合约在超时后退款。

> "I think an alternative scheme that is less vulnerable to scams would be to have a ZKVM (Risc0 or similar) executing vulnerable code, such that the attacker needs to produce a zero knowledge proof transcript of getting the ZKVM into a particular state that would not be possible if they didn't have an exploit." — A1kmm [c:50227882]
> （译文：我认为一种更不容易被骗的替代方案，是让一个 ZKVM（比如 Risc0 之类）执行真实的漏洞代码，攻击者必须提交一段零知识证明记录，证明自己把 ZKVM 推进到了某个特定状态——而没有漏洞利用是做不到这件事的。）

而当时帖子的实际走向，已经有人在现场记录了：

> "Bahaha someone added to the fund. It’s now $1004" — xmcp123 [c:50225975]
> （译文：哈哈哈有人往基金里加钱了，现在它是 1004 美元。）

Stevvo 顺势把怀疑挑明：

> "For all I know, it's a straight up scam. Someone already sent more bitcoin to the address to double the bounty." — Stevvo [c:50226488]
> （译文：在我看来这就是一场彻头彻尾的骗局。反正已经有人往那个地址又转了比特币，把奖金翻倍。）

### 六、日志悖论：所有攻击者都在给站主免费打工

页面那行「所有流量都被记录」，被评论区反复拿出来当作另一种风险。zoeysmithe 的说法最直白：

> "For $500 he can look in the logs and find all manner of new exploits, or new deviations of the existing ones, he can then sell for thousands. Clever business model lol" — zoeysmithe [c:50225515]
> （译文：花 500 美元，他就能从日志里翻出各种新漏洞，或者是现有漏洞的各种变形，然后转手卖几千美元。真是个聪明的商业模式。）

devkit1 站在白帽的角度，把这层顾虑讲完整了：

> "You, the white-hat hacker would be concerned that your attack exploits payload will be logged either by the potentially malicious site operator who could be using this to gather various working exploits, or by other bad actors who already exploited the site before you." — devkit1 [c:50226113]
> （译文：作为白帽黑客，你会担心你的攻击载荷被记录下来——要么记在可能有恶意的站主手里，他可能正好用这个来收集各种可用漏洞；要么记在那些在你之前已经攻破过这台服务器的其他坏分子手里。）

### 七、普通 PHP 站长其实该关心的部分

讨论最后落回一个更实际的结论：对绝大多数低价值 PHP 站点来说，被打穿的期望收益本来就很低。ufmace 是这条线的代表：

> "If nobody thinks it's worth the risk of exposure for a quick and easy $1k in Bitcoin (at the time I'm writing this), why would anybody bother hacking a site that's basically worthless, like the dinky little Wordpress blog I run?" — ufmace [c:50226200]
> （译文：如果连「为了搏一把 1000 美元的比特币，冒着暴露自己的风险」都不值得，那么谁会去黑一个基本不值钱的站点，比如我那个破破烂烂的 WordPress 博客？）

testaccount28 补了一句常被忽略的风险差异：普通站点不认真记日志，这台机器却一定会记：

> "random sites generally don't log carefully, or watch their logs if they do. so the risk to hacking them is low. this site almost certainly logs very aggressively. so the risk to hacking it is high." — testaccount28 [c:50226298]
> （译文：普通网站通常不认真记日志，或者记了也不看。所以黑它们的风险很低。而这台机器几乎肯定在非常激进地记日志，所以黑它的风险很高。）

至于为什么漏洞公开几天之后还没被大规模收割，三条理由凑在一起就完整了。ncruces 记得舆论转向的速度：

> "80h ago everyone was advising everyone else to take all their websites immediately down." — ncruces [c:50226225]
> （译文：80 小时前，人人还在劝彼此立刻把所有网站下线。）

> "Now it's only worth it to hack a website that's asking to be hacked if the prize is $15k." — ncruces [c:50226225]
> （译文：现在，只有当奖金是 1.5 万美元时，打一台主动求打的网站才值得。）

ls612 提醒大家注意漏洞的生命周期阶段：

> "It’s not a 0day it’s now 5 days and counting since disclosure. Nobody is gaining value sitting on an exploit for a vulnerability which is being actively patched." — ls612 [c:50226232]
> （译文：它已经不是零日漏洞了，从公开到现在已经第 5 天。对一个正在被积极修补的漏洞，握着利用代码不动作是没有任何收益的。）

gbingles 补上最后一环：

> "You would have a point if it was still a 0 day. The patch is out, and open source. Anyone who cares has a bunch of the pieces for putting together their own exploit." — gbingles [c:50226286]
> （译文：如果它还是零日，你的论点才成立。但补丁已经放出，而且是开源的。任何在乎的人手里都有足够的零件去拼出自己的利用代码。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 这道题是给「AI 批量攻破」恐慌标价 | cortesoft | 整个练习就是为了反驳「脚本小子让 AI 写利用、再让 AI 扫全网」 |
| 漏洞的真实标价是 15000 美元 | fwlr | 如果标价是 15000 而不是 150，这套叙事就完全不同了 |
| 没人得手就是结论 | jgalt212 | 钱还在那儿，说明目前没有「随便谁都能用」的利用 |
| 信息量不大，但比叙事现状好 | fwlr | 哪怕这么点信息，也是对当下叙事的明显改善 |
| AI 成本低于奖金就值得试 | snailmailman | 如果 token 花不到 500 美元，这笔账就赚 |
| 500 美元不值得动用真本事 | jerrythegerbil | 性价比低得可笑，提到 1.5 万就会被顺走 |
| 出题人要问的是「利用是否已经普及」 | oofbey | 这才是简单的那个问题 |
| 期望值约 300 美元 | echoangle | 私钥在机器上的概率不该按 0 算 |
| 没奖金的服务器同样没人打 | janalsncm | 你说的每个理由对外面绝大多数站点都成立 |
| 现成 PoC 打不了这台机器 | jerrythegerbil | 需要针对具体应用配置调整 |
| 需要知道服务器配置才能利用 | msm_ | 这正是题目没给的信息 |
| 服务器跑 PHP 8.4.26 + nginx | randomblock1 | 而且他找到的页面都是静态的，不是 PHP 入口 |
| nginx 后面有 1MB 请求体上限 | jackdecker | 难度是被刻意抬上去的 |
| `expose_php` 开着但滤了响应头 | LZ2DMV | 合法方法滤掉了，非法方法没滤 |
| 这个实验无法证伪漏洞存在 | akerl_ | 它只能证明有人攻击过这台服务器 |
| 服务器可以撒谎 | muvlon | 连「有人攻过」都证明不了 |
| 私钥不在，就没有动手的理由 | Stevvo | 从博弈论看，没人相信它在那儿 |
| 这是可证伪设计，不是自说自话 | hau | 让「野外存在简单漏洞」变得可证伪，是好办法 |
| 可能是石头汤骗局 | A1kmm | 出题人掌握私钥，等着别人往钱包里追加资金 |
| 替代方案是 ZKVM 加合约 | A1kmm | 用零知识证明替代对出题人的信任 |
| 奖金已经自己涨到 2018 美元 | xmcp123 | 有人往基金里加钱，钱包余额翻了四倍 |
| 站主能从日志里捞漏洞卖钱 | zoeysmithe | 花 500 美元进货，几千美元出货 |
| 白帽的攻击载荷会被记录 | devkit1 | 站主或者其他攻击者都在看着你的日志 |
| 普通站点其实风险很低 | ufmace | 不值得为 1000 美元去打一个破博客 |
| 风险差异在日志 | testaccount28 | 普通站点不记日志，这台机器疯狂记 |
| 现在打已经不值 | ncruces | 80 小时前人人还在劝人下线，现在只值 1.5 万 |
| 漏洞已公开 5 天，不再是零日 | ls612 | 漏洞在被积极修补，握着利用代码没收益 |

## 总体情绪

这帖讨论的形状很特别：一道悬赏 502 美元的漏洞题，最后变成了一场关于「漏洞利用到底该值多少钱」的成本辩论。参与者的水平相当高，但真正吸引人的不是技术细节，而是那些精确到有点冷的推理——500 美元买不到一个零日，1% 概率配 100 万回报就值得花 1 美元，80 小时前人人催你下线，补丁开源之后握着利用代码就等于握着废纸。这些算术把「AI 时代人人皆可为黑客」的口号拆成了几个具体数字，然后发现数字对不上。

情绪的分裂点也在数字上：认为这道题是给恐慌标价的人，看到的是「没人得手」这一个事实；认为它是蜜罐的人，说的也是同一个事实，只是给出的解释相反。真正把两边分开的是另一个更朴素的问题——私钥到底在不在服务器上，而这个问题在帖子结束的时候，依然没有人能证明。评论区自己也承认了这一点：服务器可以撒谎，测试只能证明有人攻过，不能证明漏洞简单。

它最有价值的地方，可能在于把「被打了会怎样」这件事从抽象的安全焦虑换算成了一次公开竞价。一台故意留洞的机器、一个公开的计数器、一份给所有人的日志——这套东西比任何一份漏洞通告都更能说明真实世界里的攻防成本：漏洞不是不存在，自动化也不是不存在，只是自动化的边际收益在大多数站点上算不过账。

没有人宣布得手。那个计数器还挂在页面上，钱包里的 2018 美元还躺着，像一张没人肯兑付的收据。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | 挑战站点 stealmybitcoin.com | https://stealmybitcoin.com/ |
| 2 | 挑战钱包（区块浏览器） | https://mempool.space/address/bc1qlnu50y4zm0nwxkckxu09thn5xdcz8aw6t3cxqy |
| 3 | 参与条款 | https://stealmybitcoin.com/terms.html |
| 4 | HN 讨论：Show HN: Steal My Bitcoin | https://news.ycombinator.com/item?id=50224916 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论摘要，所引用户评论不代表译者立场。文中涉及的安全话题仅用于说明讨论背景，请勿用于任何未授权测试。所有引文 ID 已在 HN 原文核验。
<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
