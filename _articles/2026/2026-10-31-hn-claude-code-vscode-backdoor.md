---
layout: post
title: >-
  官方 Claude Code 插件在 Cursor 市场被植入 SSH 后门 — HN 讨论摘要
date: 2026-10-31
hn_id: 50300683
categories: [articles]
excerpt: >-
  2700 万安装量的官方 Claude Code 插件被塞进一把 SSH 后门，在 Cursor 市场活了 11 小时。
  评论区一半在追问到底是谁的密钥被偷，一半在研究怎么把自己的开发环境关进笼子。
tagline: >-
  插件顺手替陌生人留了把家门钥匙，注释写着 svc-telemetry。
---

> 来源：HN 讨论帖，提交者 _chall。帖子：[Backdoor in Claude Code for VS Code extension on the Cursor Marketplace](https://news.ycombinator.com/item?id=50300683)，908 分，490 条评论。原文：[Official Claude Code Extension Compromise: Security Advisory](https://phorion.io/blog/offical-claude-code-vsx-compromise/)（Phorion，作者 Calum Hall，2026-10-30 发布，10-31 更新）。关联帖：[Backdoors in official Claude Code extensions](https://news.ycombinator.com/item?id=50302334)（655 分）、[Claude Code VS Code extension with backdoor released on Cursor marketplace](https://news.ycombinator.com/item?id=50301983)（389 分）。

## 原文概要

2026 年 10 月 30 日，macOS 端点安全厂商 Phorion 的 Calum Hall 发出安全通告：Cursor 市场里的官方 Claude Code for VS Code 插件被植入了 SSH 后门。10 月 31 日更新时，Cursor 的公告把受影响版本从 2.1.313 扩到 2.1.312 与 2.1.313，覆盖 macOS 与 Windows。

被动手的是插件打包后的 `extension.js`：一段 IIFE 被插到压缩代码最前面，Node 一加载文件就执行，连扩展自己的 `activate` 回调都还没轮到，用户不需要点任何按钮。而扩展进程跑在 IDE 权限之下，等于一装上就把本地文件、源码、开发工具链一并交出去。

第一阶段是铺钥匙。载荷把一把攻击者的 Ed25519 公钥追加进 `~/.ssh/authorized_keys`，目录权限 0700、文件 0600，公钥注释写着 `svc-telemetry`。去重逻辑查的是注释字符串而不是密钥本身，所以排查时要比对指纹 `SHA256:0Z6R+DF64Do2nwQic8a7kkfDLNNk4IiK+2U2Rci4htk`。接着它尝试把 SSH 打开：Linux 走 `systemctl`/`service`，macOS 走 `sudo -n systemsetup -setremotelogin on`，Windows 用 PowerShell 装 OpenSSH Server。全程没有提权漏洞，`sudo -n` 只在用户本来就有免密 sudo 时才有效。

第二阶段是回连。载荷内嵌一把未加密的 Ed25519 私钥（注释 `svc-telemetry-tun`），把它写到系统临时目录，文件名是 `.stk_` 加「主机名 + 家目录路径」的 MD5 前 10 位十六进制，然后用 `ssh -R *:0:localhost:22` 连到 `134.209.82[.]225` 的 `tunnel` 用户。端口写 0 表示让攻击方服务器动态分配端口，流量再经隧道回到本机 22 端口。隧道用 `-N` 只挂转发不执行命令，关掉主机密钥校验，启用 `BatchMode` 与 `IdentitiesOnly`，`ServerAliveCountMax=3`；装了 `autossh` 就用 autossh，没有就用 ssh，外面套一层 detach 的重试循环，每 60 秒重试一次，用 `pgrep` 防止重复起进程。用户关掉 IDE，隧道照样在。

第三阶段是持久化，三平台各一套。macOS 写 `~/.config/.smt` 与 `~/.config/.smtk`，再丢一个 `~/Library/LaunchAgents/com.apple.sysmond.plist`，`RunAtLoad` 和 `KeepAlive` 都为 true——注意是用户级 LaunchAgent，不是 root LaunchDaemon。Linux 用同样的 `.smt`/`.smtk` 加一条 `@reboot` crontab，通告指出这里的 crontab 检查有 bug，重复执行可能清掉用户原有的定时任务。Windows 写 `~/.config/smt.cmd` 与 `smtk`，先尝试创建名为 `SysMon` 的 SYSTEM 计划任务（需要管理员），失败就退回启动目录里的 `sysmon.cmd`。

第四阶段是主机侦察与信标：收集主机名、用户名、系统平台与架构、家目录、当前工作目录、全局 git 邮箱、公网 IP（查 `ifconfig[.]me`，回退 `api[.]ipify[.]org`）、各阶段执行状态，外加最多 40 个匹配 `/KEY|TOKEN|SECRET|PASS|AWS|GCP/i` 的环境变量**名字**——只取名字不取值，等于给攻击者发了一份「这台机器上有哪些类型的凭证」的地图。之后它把 JSON 以明文 HTTP POST 到 `134.209.82[.]225:8099` 的 `/beacon`，同时也往 `127.0.0.1:8099` 发一份（脚本并没有在本地起监听，原因不明）。

通告里最反直觉的一段是 macOS 的实现 bug：`systemsetup -getremotelogin` 不带提权跑，输出是 `You need administrator access to run this tool... exiting!`，退出码还是 0，而脚本只认 `/Off/i`，于是永远不执行开启 Remote Login 的那一步——它把「没权限查」当成了「已经开着了」。所以在没有预开 SSH 的 Mac 上，入站通道是断的；但密钥和持久化照样落地。通告明确说，别拿这个当防线。

另外那个 389 分的关联帖，评论区被官方合并到了主帖下，所以 490 条讨论几乎全在主帖里展开；本文除标注 [thread 2] 的引用外，其余引文均来自主帖。

处置建议只有一句话：卸载插件不够。要杀掉连着 `134.209.82[.]225` 的 ssh/autossh 进程，删掉 LaunchAgent、cron 或计划任务以及 `~/.config/.smt`、`.smtk`，从 `authorized_keys` 摘掉 `svc-telemetry`，清掉 `/tmp/.stk_*`，确认 Remote Login 没被莫名打开，并轮换该用户能触达的全部凭证——尤其是那些匹配上述环境变量过滤器的。样本 `extension.js` 的 SHA-256 是 `ecb58cb29078d9646ad1dcdbe51526f2d9cfea06be5fb2ab183e8ecc3ab6bf15`。

## 讨论焦点

### 一、三个市场，一份责任：到底是谁的密钥被偷了

讨论一开场就卡在归因上，因为通报里提到的市场不止一个。Hackbraten 把名单列了出来：

> "If I understand this thread correctly, then #1 and #3 had compromised versions, and nobody has made a statement yet about the status of #2." — Hackbraten [c:50303071]
> （译文：如果我理解得没错，1 号和 3 号存在被投毒的版本，而 2 号至今没人表态。）

投 Anthropic 一票的最直接证据来自版本号。K0nserv 写道：

> "Version 2.1.313 is also missing from the official VS Code marketplace ( https://marketplace.visualstudio.com/items?itemName=anthropi... ). This suggest to me that it was published and pulled, which means it was Antrophic that was hacked." — K0nserv [c:50302650]
> （译文：2.1.313 在官方 VS Code 市场上也消失了。这在我看来说明它被发布过又被撤下，也就是说被黑的是 Anthropic。）

而 tyingq 担心的是另一个方向：

> "Sort of hoping it's Anthropic and their specific OpenVSX account credentials. As opposed to the worse case of an OpenVSX flaw that's broader. A ton of AI-enabled IDEs are VsCodium forks pointed at OpenVSX...Cursor, Anti Gravity, Kiro, Trae, Devin, etc." — tyingq [c:50302595]
> （译文：我希望是 Anthropic 他们那个具体的 OpenVSX 账号凭证被偷，而不是更糟的、范围更大的 OpenVSX 本身有洞。大量 AI 驱动的 IDE 都是指向 OpenVSX 的 VSCodium 分支……Cursor、Antigravity、Kiro、Trae、Devin 等等。）

Anthropic 的人后来下场了。ddworken 的说明很干脆：

> "Dworken from Anthropic here: This only impacted the extension as it was hosted on the Cursor marketplace. It did not impact the official VS Code extension marketplace or OpenVSX. Users of Claude Code on VS Code are not impacted by this issue." — ddworken [c:50304977]
> （译文：我是 Anthropic 的 ddworken。这只影响了托管在 Cursor 市场上的那个扩展，没有影响官方 VS Code 扩展市场，也没有影响 OpenVSX。在 VS Code 上使用 Claude Code 的用户不受此问题影响。）

于是评论区立刻出现「那你说说 Cursor 为什么用 OpenVSX」的追问：

> "Hi Dworken from Anthropic, how is that possible if Cursor uses OpenVSX?" — arm32 [c:50309931]
> （译文：Anthropic 的 ddworken 你好，如果 Cursor 用的是 OpenVSX，这怎么可能？）

谨慎cat 干脆说没跟上：

> "A lot of this is turning into “well other company said” but Anthropic claims OpenVSX is fine?[1] And that Cursor has their own market place. I’m confused." — cautiouscat [c:50306246]
> （译文：这讨论大半变成了「别人是这么说的」，可 Anthropic 说 OpenVSX 没问题？又说 Cursor 有自己的市场？我已经糊涂了。）

zbentley 把可能性拆成三种，一件都没排除：

> "However, statements around the internet (and in these comments) are less than definitive as to whether a) that proxy has a cache that was compromised; b) that proxy has select extensions which can be published directly to it by hand (one of which was compromised); c) other." — zbentley [c:50312209]
> （译文：不过网上（以及这些评论里）的说法都不足以确定：a) 那个代理有缓存被攻破；b) 那个代理允许手工直接发布某些扩展（其中一个被攻破）；c) 其他原因。）

tyingq 后来改了口：

> "Edit: Ah, guess it was not open-vsx, but a in-house Cursor marketplace." — tyingq [c:50309070]
> （译文：编辑：啊，估计不是 open-vsx，而是 Cursor 自建的市场。）

最后两句话把整个归因难题点破了：

> "Not very transparent. Whose key was used to push this extension update?" — Rapzid [c:50313368]
> （译文：非常不透明。推这个扩展版本用的到底是谁的密钥？）

> "Nobody seems to be taking responsibility yet for what exactly was compromised, how, and what steps are being taken to prevent it." — Rapzid [c:50313395]
> （译文：到现在没人愿意认领：到底什么东西被攻破了、怎么被攻破的、又要采取什么措施防止重演。）

### 二、处置很完整，归因缺席：Cursor 那份公告的问题

关联帖里对 Cursor 公告的批评很集中。sharpshadow 的评价是「补救到位，来源不明」：

> "Looks like a solid response with instructions and scripts how to get rid of the infection, but it doesn’t explain how it got there." — sharpshadow [c:50302882] [thread 2]
> （译文：看起来是个扎实的回应，给了清除感染的操作步骤和脚本，但完全没解释它是怎么进来的。）

justusw 追问了更深一层：

> "Agreed, it doesn't offer a root cause analysis. Remedies are good but how do you prove that it won't happen again? Remember that these are never singular incidents but part of a bad security culture." — justusw [c:50303811] [thread 2]
> （译文：同意，它没给根因分析。补救措施是好的，但你拿什么证明它不会再发生一次？记住，这些从来不是孤立事件，而是某种糟糕安全文化的一部分。）

而 Cursor 那句「这个恶意版本并非 Anthropic 开发」的措辞，恰好成了全场最被嘲的一句。stingraycharles 拆得最细：

> "It means that Anthropic did not intentionally develop a malicious version, obviously. But it’s a bit disingenuous and tries to suggest that it wasn’t Anthropic that uploaded it and/or wasn’t published under Anthropic’s name, which isn’t true." — stingraycharles [c:50303283] [thread 2]
> （译文：它的意思显然是 Anthropic 并没有故意开发一个恶意版本。但这有点不老实，它在暗示不是 Anthropic 上传的、和/或不是以 Anthropic 的名义发布的，而这并不属实。）

LastTrain 一句话定了性：

> "It means we are from now on in an era of plausible deniability." — LastTrain [c:50303341] [thread 2]
> （译文：这意味着我们从此进入一个「合理推诿」的时代。）

dgellow 则把它变成了一个 AI 笑话：

> "It would be hilarious if that’s an obfuscated way to say Claude developed it." — dgellow [c:50303519] [thread 2]
> （译文：如果那句话其实是「Claude 开发了它」的含蓄说法，那就太好笑了。）

也有人抓住了公告里的一个细节并据此改了归因。mirashii 说：

> "Given they mentioned taking down and rebuilding the marketplace registry in that post, it seems equally likely that Cursor’s infrastructure was the source of the intrusion and a folks are jumping the gun on attribution." — mirashii [c:50303297] [thread 2]
> （译文：鉴于他们提到要下线并重建市场注册表，同样有可能是 Cursor 自己的基础设施才是入侵源头，大家在归因上抢跑了。）

评论区还有一句俏皮话，把「厂商说自己被黑」这件事说透了：

> "we got hacked by someone other than ourselves this time" — internet_points [c:50303469] [thread 2]
> （译文：这次我们是被别人黑，而不是被自己人黑。）

### 三、活了 11 小时，2700 万安装量：暴露面到底有多大

最先被引用的事实是安装量：

> "The extension has over 27 million installs, ouch" — mindracer [c:50301110]
> （译文：这个扩展的安装量超过 2700 万，呃。）

数字吓人，但暴露窗口比想象的短。entrope 指出 VS Code 扩展默认有延迟更新机制：

> "Yes, but they normally have a 12-hour delay (it was 2 hours at the beginning of June and got extended sometime after that, maybe later in June) and require some human action to reload extensions or restart the editor before the new version runs." — entrope [c:50302848]
> （译文：是的，但他们通常有 12 小时的延迟（6 月初还是 2 小时，之后某时候延长的，大概 6 月底），而且还需要用户手动重载扩展或重启编辑器，新版本才会真正跑起来。）

> "Edited: This update was live for only 11 hours, so hopefully the default delay limited the blast radius, as it is meant to do." — entrope [c:50302848]
> （译文：编辑：这次更新只上线了 11 小时，希望默认的延迟机制像它本来的设计那样限制了爆炸半径。）

这解释了为什么 Cursor 那份「上架前有自动化恶意软件与供应链分析、不合格就拦下」的声明听上去格外刺耳——因为检查确实跑过了，只是坏版本活了 11 小时。同一件事的另一位评论者把这两句摆在一起说：

> "However, the bad extension was live for ~11 hours." — no-name-here [c:50305403]
> （译文：然而，那个坏版本上线了大约 11 小时。）

mrweasel 提醒的是另一半：

> "How will they communicate and fix that. The affected version has been yanked from the marketplace: https://marketplace.visualstudio.com/items?itemName=anthropi... but that doesn't clean up infected machines." — mrweasel [c:50301846]
> （译文：他们要怎么通知和修复？受影响版本已经从市场上撤下了，但撤下版本救不回已经被感染的机器。）

最初的问题甚至不是技术问题，而是「这事可不可信」。richrichardsson 的追问很朴素：

> "How legit is this? Seems low on details." — richrichardsson [c:50302141]
> （译文：这消息有多可信？细节看起来太少。）

ale42 则代表了大批普通 VS Code 用户：

> "Is this affecting only people using Cursor or all VS Code users? The article specifically mentions the Cursor marketplace. But the affected version is indeed missing on the official VS Code marketplace, was it compromised too?" — ale42 [c:50302053]
> （译文：这只影响用 Cursor 的人，还是所有 VS Code 用户？原文明确提的是 Cursor 市场。但受影响版本在官方 VS Code 市场上确实也不见了，它也被黑了吗？）

### 四、「官方构建」这四个字，现在一文不值

最扎心的一条评论来自 properbrew，它指出了供应链攻击的新常态：

> "Wasn't this an official build though? A signed updated version of a package released by the same developer as the one you've already installed, the supply chain was hacked." — properbrew [c:50304575]
> （译文：这不本来就是官方构建吗？一个由你已安装的同一个开发者发布的、签名过的更新版本——是供应链被黑了。）

而 OpenVSX 这个市场本身就被反复点名。darkwi11ow 说得很不客气：

> "Yeah OpenVSX security is a joke, they also have dumb search algorithm which allows for easy squatting of similar-looking extension names so they show up in search first when you look for official extensions. There were quite a few prominent hacks done that way. I think Microsoft likes OpenVSX situation because it allows them to claim their proprietary VSCode marketplace to be more secure." — darkwi11ow [c:50302943]
> （译文：是啊，OpenVSX 的安全性就是个笑话，他们那个搜索算法还很蠢，可以轻易抢注名字相似的扩展，让你搜官方插件时它们排在前面。有好几次高调的攻击就是这么干的。我觉得微软乐见 OpenVSX 现在的局面，因为这样他们就能宣称自家专有的 VS Code 商店更安全。）

AdrianCX 的疑问更直接：

> "OpenVSX has no extension signing?, no verifications?, what year is this..." — AdrianCX [c:50302919]
> （译文：OpenVSX 没有扩展签名？没有验证？现在都什么年代了……）

> "This could have been avoided by having extensions signed by company doing them with keys and review" — AdrianCX [c:50302919]
> （译文：这本来可以避免——让开发扩展的公司用自己的密钥签名并做审查。）

tyingq 给出了两边防护水平的对照：

> "On publishing, I do see that the MS marketplace has much better typosquatting and rogue publisher protection. It's unclear to me how much better their SAST/scanning is than OpenVSX. Both have something, but both have been fooled many times, and recently." — tyingq [c:50303855]
> （译文：在发布这一环，我确实看到 MS 商店对抢注和恶意发布者的防护要好得多。但他们的 SAST／扫描比 OpenVSX 强多少，我看不出来。两边都有点东西，但两边都被骗过很多次，而且最近才被骗过。）

至于最初的入口，darkwi11ow 在自己的编辑里补上了 Binance 通报中最关键的一条：

> "The affected Open VSX extension is owned by Anthropic employee Igor Kofman, but it is unclear whether his account or another part of the publishing process was compromised." — darkwi11ow [c:50302513]
> （译文：Binance 通报的说法是：受影响的 Open VSX 扩展归 Anthropic 员工 Igor Kofman 所有，但不清楚是他的账号被攻破，还是发布流程中的其他环节被攻破。）

fn-mote 还专门去核实过这条通报不是玩笑：

> "^^ Had to verify that this was a real quote from the chain and not a joke. It is accurate." — fn-mote [c:50302573]
> （译文：上面那条我得专门核实一下是链上（Chain）里的真实引用还是玩笑。结果是真的。）

### 五、能自救的只有三板斧：延迟更新、冻结更新、把 diff 交给便宜模型

既然归因要等事后复盘，用户能做的就是把更新节奏握在自己手里。dash-44 给的是最朴素的做法：

> "You disable extension auto updates and then manually install every so often (and only update/install when the version has been out for 3+ days)." — dash-44 [c:50303759]
> （译文：把扩展的自动更新关掉，然后隔一段时间手动装一次（而且只在版本发布满 3 天以上时才更新／安装）。）

darkwi11ow 补充了 VS Code 现在内置的开关：

> "To anyone who might be reading this exchange, actually there is recently added builtin setting for delayed auto-update, `extensions.autoUpdateDelay`, see https://github.com/microsoft/vscode/issues/316867 and https://github.com/microsoft/vscode/pull/321039" — darkwi11ow [c:50307913]
> （译文：给可能正在读这串讨论的人：其实最近新增了一个内置的延迟自动更新设置 `extensions.autoUpdateDelay`，见 https://github.com/microsoft/vscode/issues/316867 和 https://github.com/microsoft/vscode/pull/321039。）

至于「不更新」到底算不算好习惯，koolba 给出了另一种立场：

> "Not updating air gapped systems is a security feature, not a bug." — koolba [c:50302679]
> （译文：不更新离线隔离的系统是安全特性，不是 bug。）

第二板斧是审 diff，但 mrweasel 认为这基本不可能靠人力完成：

> "That is a really good question, because you almost can't do it. You could download the extension, diff it against the previous version and read all the code. Expecting people to do that it just a bit much. At some point we have to trust someone and in this case it will be interesting to see if it's the marketplace or Anthropic we couldn't trust." — mrweasel [c:50302809]
> （译文：这是个好问题，因为几乎做不到。你当然可以下载扩展、和上一个版本 diff、把代码全读一遍。但指望人们真这么干就有点太过了。到某个点我们总得信一个人，而这次有意思的地方在于，看看我们信不了的是市场还是 Anthropic。）

toyg 立刻把这件事翻译成了 AI 的使用场景：

> "This would actually be an exceptionally good use-case for AI. You don't need a super-duper frontier model to download a bit of source-available code and check for suspicious signs, any cheap model would do well enough. Heck, it's effectively virus scanning, we've had that for decades." — toyg [c:50303034]
> （译文：这其实是个极好的 AI 用例。你不需要什么顶尖前沿模型，只要下载那点源码可得的代码、让它检查有没有可疑迹象，任何便宜模型都够用。说白了这就是病毒扫描，我们干这行几十年了。）

jeromechoo 则把它延伸到了安装脚本：

> "The CTA flavor of the year for dev tools is cURLing some arbitrary install script and run it immediately which always sounded ridiculous to me. If instead that script first pipes into claude -p for a basic vulnerability scan before continuing, I would be delighted." — jeromechoo [c:50303381]
> （译文：开发工具今年最流行的 CTA 风格是「curl 一个随便什么安装脚本然后立刻执行」，这在我看来一直很荒唐。如果那个脚本改成先 pipe 给 `claude -p` 做一遍基础漏洞扫描再继续，我会很高兴。）

至于「我半年没更新，是不是就没事了」，fn-mote 泼了盆冷水：

> "Emphasis on guessing . If/when there is an actual postmortem, you’ll know when the back door was introduced." — fn-mote [c:50302576]
> （译文：重点在于「猜」。等真的有事后复盘时，你才会知道后门是什么时候被引入的。）

### 六、把开发环境关进笼子：容器、VM 与「干脆别用插件」

既然扩展在 IDE 进程里以你的身份运行，隔离就成了主战场。airhangerf15 描述了自己的做法：

> "Lately I've been using a script that mounts my current working directory in a container and I put all my build tools in a Dockerfile. I also map the harness config (~/.config/opencode or whatever) to a named volume to minimize the chance a harness could grab other things off my host." — airhangerf15 [c:50302307]
> （译文：最近我在用一个脚本，把当前工作目录挂进容器里，构建工具全放进 Dockerfile。我还把 harness 的配置（`~/.config/opencode` 之类）映射到一个具名卷上，尽量降低 harness 从我宿主机上顺手抓别的东西的概率。）

> "I sure I could use a full QEMU VM or some other type of isolation for such devops tasks, but I haven't really looked into it yet." — airhangerf15 [c:50302307]
> （译文：这类 devops 任务我完全可以用完整的 QEMU 虚拟机或者别的隔离方式，但我还没认真研究过。）

DanielHB 的方案更完整——换 VSCodium，把扩展跑在容器里的 vscode-server 上：

> "I recommend moving to VSCodium and using this extension: https://github.com/jeanp413/open-remote-ssh and run vscode-server inside a VM or container" — DanielHB [c:50303203]
> （译文：我建议换成 VSCodium 并使用这个扩展：https://github.com/jeanp413/open-remote-ssh，然后把 vscode-server 跑在虚拟机或容器里。）

他也清楚容器不是圣杯：

> "Of course anything you put into the container can be compromised, like git ssh keys or cloud provider keys/auth-tokens. But at least it keeps your PC from becoming a botnet and your browser credentials out of reach." — DanielHB [c:50303876]
> （译文：当然，你放进容器里的东西照样可能被攻破，比如 git 的 ssh 私钥或者云厂商的密钥／认证令牌。但至少它让你的 PC 不会变成肉鸡，也让浏览器里的凭证够不着。）

> "If you have a Containerfile/Dockerfile with everything you need you can quickly wipe everything and re-create your dev environment from scratch (which I do every once in a while), wiping any malware you might have gotten in there." — DanielHB [c:50303876]
> （译文：如果你有一份装齐了所有东西的 Containerfile／Dockerfile，你就能很快把一切抹掉、从零重建开发环境（我隔一阵就这么干一次），顺手把可能混进去的恶意软件一起抹掉。）

bhubert 提出了一个折中：两个容器互相通信，但不把 docker socket 给出去。

> "You could also start whichever container it needs (the docker work) yourself and just have the two containers container with eachother (e.g. docker compose, without granting access to docker socket), provided that the docker work is static enough that this would work." — bhubert [c:50303845]
> （译文：你也可以自己起它需要的那个容器（干 docker 活的那个），然后让两个容器互相通信（比如用 docker compose，但不授予 docker socket 权限），前提是 docker 那部分的工作足够静态，能这么干。）

> "You could also look into user gVisor runtime for extra security." — bhubert [c:50303845]
> （译文：为了额外的安全性，你也可以考虑用户态的 gVisor 运行时。）

最省事的答案是干脆别装插件。AdrianCX 提了一个直击要害的问题：

> "Why not use claude code directly?" — AdrianCX [c:50303251]
> （译文：为什么不直接用 claude code？）

> "Why risk getting compromised like that?" — AdrianCX [c:50303251]
> （译文：何必冒这种被攻破的风险？）

axus 就是这么做的：

> "Now I'm glad I've not opened VSCodium in a few weeks; I prefer using Claude as a separate application anyways, will have to remove the extensions." — axus [c:50304693]
> （译文：现在我很庆幸自己有几个星期没开 VSCodium；反正我更喜欢把 Claude 当独立应用用，扩展回头得卸掉。）

而 darkwi11ow 描述了另一种心态——把「安装」当成和「升级」一样需要警惕的事：

> "I knew about OpenVSX situation with the search, so when installing extensions I always did triple-checking to verify the extension being really submitted by upstream and not by squatter; but now given upgrades can also deliver a compromise I am thinking of developing an extension that will act in similar manner to pnpm minimum release age." — darkwi11ow [c:50303416]
> （译文：我早就知道 OpenVSX 在搜索上那些事，所以装扩展时我总是反复核对，确认确实是上游提交的、不是被抢注的。但现在既然升级本身也可能递交付恶意代码，我在考虑做一个类似 pnpm「最小发布年龄」的扩展。）

### 七、被偷的不只是那把钥匙：Anthropic 自己的承诺

这次事件最扎心的地方，是它和 Anthropic 员工几个月前公开说的话直接撞上了。stymaar 记得那条评论：

> "I read a few month ago a comment from an Anthropic or OpenAI employee saying that the security problem of prompt injection was a solved problem at this point, as the frontier models where rejecting 98% of attacks." — stymaar [c:50303008]
> （译文：几个月前我读到一位 Anthropic 或 OpenAI 员工的评论，说提示注入这个安全问题在这个时点已经被解决了，因为前沿模型能拒绝 98% 的攻击。）

> "It tells you all you need to know about how unserious these people are about computer security." — stymaar [c:50303008]
> （译文：这足以让你知道这帮人在计算机安全上有多么不认真。）

malfist 用一句话把同一个论证拆穿：

> "I'm glad no one can steal from my bank, they stop 98% of thieves" — malfist [c:50303022]
> （译文：那我很高兴没人能抢我的银行了，他们能拦下 98% 的小偷。）

gr_norm 记着账：

> "Prominent Anthropic employees keep claiming to have solved prompt injection [2] and quickly get proved wrong [3]. They've burned my goodwill on this front." — gr_norm [c:50304232]
> （译文：Anthropic 的高管们不断宣称已经解决了提示注入，然后很快被打脸。他们在这件事上已经耗光了我的信任。）

skinfaxi 还把 Simon Willison 前一天的推文搬了出来：

> "I've recently talked to people at Anthropic who are very confident that they have effectively solved the prompt injection risks that cause lethal trifecta attacks with their latest models." — skinfaxi [c:50303735]
> （译文：我最近和 Anthropic 的一些人聊过，他们非常自信地认为，用他们最新的模型已经有效解决了那种会导致「致命三连击」攻击的提示注入风险。）

而这次事件最讽刺的地方在于：争议的核心恰好是 Anthropic 员工名下那个扩展的发布权限。darkwi11ow 把两条推文并排放了出来——一条是 Boris 说到 2025 年冬天自己的代码 100% 由 Claude Code 写成、一行手写都没有，另一条是 Kofman 说自己已经不手写任何代码——然后总结：

> "Turns out if you are not writing the code, then North Koreans might do it for you" — darkwi11ow [c:50303981]
> （译文：结果就是，你如果不写代码，那也许会有人替你写——比如朝鲜人。）

glimshe 的问题则是最不留情面的那一个：

> "Why didn't Claude detect the hack and prevent it from affecting customers using its superhuman AGI reasoning?" — glimshe [c:50302653]
> （译文：为什么 Claude 没有用它的超人级 AGI 推理能力发现这次攻击、并阻止它影响到用户？）

eviks 认为这本来是件小事：

> "That's literally impossible, with all the access to the frontier software development tools at their disposal they can ship features securely at 100x" — eviks [c:50302649]
> （译文：那在字面意义上根本不可能——他们手上有全部前沿软件开发工具，安全感足以降 100 倍地发布功能。）

mirekrusin 给出了一个更冷静的换算：

> "To be fair it’s not like screwups were not happening before, but if you move 100x faster and are 50x more secure than before you’re still 2x more exposed." — mirekrusin [c:50303148]
> （译文：公平地说，搞砸的事以前也不是没发生过；但如果你跑得快 100 倍、同时安全 50 倍，那你暴露的倍数仍然是 2 倍。）

b112 则拒绝了「理解，但零借口」的说法：

> "It may be the cause, but zero excuse." — b112 [c:50303548]
> （译文：这可能是原因，但一点借口都没有。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 三个市场要分清 | Hackbraten | 1、3 号被投毒，2 号至今没人表态 |
| 版本号指向 Anthropic | K0nserv | 2.1.313 从官方市场消失，说明发过又被撤 |
| 更怕 OpenVSX 本身有洞 | tyingq | Cursor、Antigravity、Kiro、Trae 全指过去 |
| 官方市场是干净的 | ddworken | 只影响 Cursor 市场，VS Code 用户无恙 |
| 那 Cursor 为什么用 OpenVSX | arm32 | 当场追问 Anthropic 员工 |
| 到底哪一环被动手脚 | zbentley | 代理缓存／手工直发／其他，三种都可能 |
| 最终是 Cursor 自建市场 | tyingq | 事后改口：不是 open-vsx |
| 撤下版本救不回机器 | mrweasel | 已感染的机器不会被自动清理 |
| 补救没给根因 | justusw | 拿什么证明它不会再发生一次 |
| 官方构建不再等于安全 | properbrew | 签名照旧，只是供应链被偷 |
| OpenVSX 搜索可被抢注 | darkwi11ow | 搜官方插件时先搜到仿冒品 |
| 签名加审查本可避免 | AdrianCX | OpenVSX 连签名都没有 |
| 两边都被骗过 | tyingq | MS 商店防护更好，但也屡次翻车 |
| 曝光窗口只有 11 小时 | entrope | 延迟更新机制限制了爆炸半径 |
| 但安装量 2700 万 | mindracer | 数字本身够吓人 |
| 自保第一招：冻结更新 | dash-44 | 版本发布满 3 天再装 |
| VS Code 内置延迟开关 | darkwi11ow | extensions.autoUpdateDelay |
| 不更新是安全特性 | koolba | 离线机器就该冻着 |
| diff 交给便宜模型 | toyg | 本质是病毒扫描，几十年的老生意 |
| 装脚本前先 claude -p 扫一遍 | jeromechoo | 换个 CTA 风格就顺手了 |
| 「半年没更新就安全」靠猜 | fn-mote | 得等事后复盘才知道何时被植入 |
| 开发环境关进容器 | airhangerf15 | 工作目录进容器，配置进具名卷 |
| 容器也挡不住一切 | DanielHB | 但至少你的 PC 不会变肉鸡 |
| 两个容器互连不给 socket | bhubert | 再加一层 gVisor 用户态运行时 |
| 干脆别用插件 | AdrianCX | 直接用 claude code 就行 |
| 升级也可能是投毒 | darkwi11ow | 想做类似 pnpm 最小发布年龄的扩展 |
| Anthropic 早说过注入已解决 | stymaar | 听听他们多不把安全当回事 |
| 98% 拦截率 | malfist | 那银行也不安全了 |
| 信任被反复消耗 | gr_norm | 吹完就被打脸 |
| 快 100 倍仍多暴露 2 倍 | mirekrusin | 速度换来的暴露是算术题 |
| 事故该追责而非找借口 | b112 | 换成食品厂也一样，零借口 |
| 无人认领 | Rapzid | 什么被偷、怎么被偷，没人说明白 |

## 总体情绪

这场讨论的分裂点只有一个，但被拉成了很长的形状：**那把钥匙是谁的**。Cursor 说不是 Anthropic 开发的，Anthropic 说不是 OpenVSX 干的，两边都给了处置脚本，却都没给出入侵路径；而真正能回答问题的材料——谁用的密钥、密钥从哪来、缓存还是直发——一句没说。评论区里那句「我们从此进入一个合理推诿的时代」被反复顶上来，不是玩笑，是描述。

另一条情绪线是自保。归因等不来，那就自己降风险：关自动更新、把版本号放三天再装、装脚本前先让便宜模型扫一遍、把开发环境整个关进容器。这些做法都便宜，也都有效——但它们的共同前提是「用户有耐心管住自己的更新节奏」，而 2700 万安装量说明大部分人没有。

还有一个更冷的后遗症：几个月前就有人记录下 Anthropic 员工宣称提示注入「已解决 98%」，而这次被偷走的恰恰是他们自己名下一个扩展的发布账号。评论区里的毒舌（「银行也不安全了」「朝鲜人替你写代码」）并不是在讨论技术，而是在清算一笔信任账。这笔账的记账人不是攻击者，是那些把话说得太满的人。

一个被装下 2700 万次的官方插件被塞进了 SSH 后门，11 小时后撤下；48 小时过去，唯一确定的事实是：没人知道那把钥匙是谁的。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Backdoor in Claude Code for VS Code extension on the Cursor Marketplace（HN 主帖，908 分） | https://news.ycombinator.com/item?id=50300683 |
| 2 | Backdoors in official Claude Code extensions（HN 关联帖，655 分） | https://news.ycombinator.com/item?id=50302334 |
| 3 | Claude Code VS Code extension with backdoor released on Cursor marketplace（HN 关联帖，389 分） | https://news.ycombinator.com/item?id=50301983 |
| 4 | Official Claude Code Extension Compromise: Security Advisory（Phorion 原文） | https://phorion.io/blog/offical-claude-code-vsx-compromise/ |
| 5 | Cursor 安全公告 | https://cursor.com/blog/claude-code-extension-security-notice |
| 6 | Binance Square：Claude Code VS Code 扩展 2.1.313 被投毒通报 | https://www.binance.com/en/square/post/10-30-2026-claude-code-vs-code-extension-2-1-313-found-with-ssh-backdoor-on-open-vsx-382784682398730 |
| 7 | Anthropic 员工 ddworken 的说明（HN 评论） | https://news.ycombinator.com/item?id=50304977 |
| 8 | Anthropic 的 Felix 就此事作答（HN 评论） | https://news.ycombinator.com/item?id=50304129 |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中涉及的受影响版本号（2.1.312／2.1.313）、攻击者基础设施（134.209.82[.]225 的 22 与 8099 端口）、样本哈希与密钥指纹、持久化文件路径等均来自 Phorion 的原始通告及其更新，未做独立复核，请以原文与厂商公告为准。文中「2700 万安装量」「11 小时上线窗口」等数字来自 HN 评论区转述，其准确性与统计口径未经核实。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
