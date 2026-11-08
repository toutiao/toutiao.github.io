---
layout: post
title: >-
  1,122 个公开仓库文件里的真实密钥：Claude Code 的「不再询问」把密码写进了 allow 规则 — HN 讨论摘要
date: 2026-11-08
hn_id: 50407882
categories: [articles]
excerpt: >-
  Apiiro 扫了 GitHub 上 104,185 份 .claude/settings.local.json，其中 1,122 份躺着真密钥：
  一家数据库厂商自己的管理级云 key、一条生产环境 Azure Postgres 密码、一枚 Square 生产 token。
  最反直觉的部分来自 Claude Code 负责人本人——Anthropic 说正在研究怎么防，
  给出的答案却是「别手动批准了，改用 auto mode」。
tagline: >-
  点一次「不再询问」，密码就跟着进了 GitHub。
---

> 来源：HN 讨论主帖 [Claude Code's "Don't Ask Again" exposes passwords in 1,122 public GitHub files](https://news.ycombinator.com/item?id=50407882)（443 分，280 条评论），原文是 Apiiro 的安全研究报告。本篇为 single post 模式；归档快照 2026-11-08 12:54 UTC，入库 121 条评论。引文保留 HN 原文的 HTML 实体与段落标记。原文页面是前端渲染，纯 HTTP 抓取只拿到站点导航（归档中该文正文标记为抓取失败），本文所引数据取自该文渲染后的全文。

## 原文概要

Apiiro 做了一次全网普查，结论是：GitHub 上有 2,539 个真实密钥散落在 1,994 个公开仓库里，牵涉 63 个组织。名单上包括一家数据库厂商自己的、带管理权限且声称不过期的云 API key（外加集群地址），一家 B2B 初创的生产环境 Azure Postgres 密码，一家软件代理公司的 Square 生产访问 token，一个超过 1000 star 的开源项目里的 OpenAI 格式 API key，一个医疗记录应用的数据库 owner 密码，以及一家支付创业公司的 postgres 角色密码。最扎人的是：多数密钥属于个人开发者——学生社团、hackathon 队伍、创业公司、软件外包、也有正经厂商。中招的都是本来没打算公开密钥的组织，密钥先是出现在命令里，被批准，然后跟着整个仓库一起提交了上去。

机制不复杂，但链条每一环都在放大后果。开发者让 Claude Code 查一下 staging 为什么登录失败、或者跑个迁移，Claude Code 提出来的命令必须带着配置文件里的那个密钥才能干活；它在执行前会问，但一次会话里会问很多次。用户点「Yes, and don't ask again」，Claude Code 就把这条命令原文写成一条权限规则，存进项目目录下的 `.claude/settings.local.json`。这个文件本来是设计成本地用的：Claude Code 创建它时会写进开发者自己的全局 gitignore，但不会写进仓库的 `.gitignore`——规则不跟着项目走。文件又落在项目目录里，于是一次 `git add -A` 就把它带上了。在他们追踪到的 1,105 个含密钥的仓库里，有 539 个是 Claude 共同署名的提交改动了这个文件。

规模数字如下。GitHub 上有 104,185 份公开的 `.claude/settings.local.json`，分布在 103,617 个仓库里，1,122 份（1.1%）含真实密钥，合起来 1,379 个不同密钥：636 个厂商格式的 key，加上 743 个指向公网主机的密码或 token。拆开看，379 个是数据库密码，122 个是 Supabase service-role key，103 个是 Supabase 账号 token（能控制账号下所有项目），43 个是公网服务器的 SSH 登录凭据（其中有 `sshpass` 里的 root 密码），42 个是 GitHub、GitLab、npm token，23 个 AWS key，6 个私钥。文件越大中招率越高：超过 8 KB 的文件里每 10 份就有 1 份含密钥，小于 500 字节的不到 500 份才出 1 份——点「不再询问」点得越久，文件攒得越厚。中位数上，这些文件在 217 天前就首次提交，118 个仓库超过一年；211 个 fork 来自 74 个仓库，带着同一批密钥；已经删掉文件的旧版本里还留着 734 个密钥，分布在 509 个仓库。

通用密钥扫描器在这里大面积失手。gitleaks 标出 564 份，TruffleHog 标出 643 份，215 份两个都没标出来——缺口全在命令里：`PGPASSWORD=`、`sshpass -p`、`mysql -p` 后面跟的密码，或者 curl 里的 bearer header，对扫描器而言只是命令行的普通词，而不是 key 格式。而且这不止一个文件：共享的 `.claude/settings.json` 有 76,011 份、其中 298 份含真实密钥；agent 聊天记录（.specstory、aider、Cursor 导出）2,523 份里 120 份分布在 87 个仓库；agent 记忆文件 1,200 份里 9 个仓库；交接与部署说明 2,095 份里 33 份；VS Code Copilot 的自动批准设置 173 份里 9 个仓库。GitLab 上检查的 69 份公开副本里有 2 份含真密钥，Hugging Face 的 31,053 个 Space 里有 126 个带这个文件，其中一个的 allow 规则直接躺着数据库 service key 和用户密码。

这不是新问题，只是规模变了。Claude Code 的 issue 从 2025 年 8 月起就陆续有人报告这个机制（#5544、#11982、#13106、#91270），没有一个得到 Anthropic 回复，三个被自动标记为不活跃或重复关闭。ironPeak 在 2026 年 2 月于自己仓库发现同一个文件，100 个样本里 2.4% 的仓库历史带密钥；Lakera 在 4 月于 30 个 npm 包里发现 33 个文件带凭证。Apiiro 在 11 月 2 日和 3 日逐个通报了涉及的组织，其中一家确认密钥曾经处于可用状态。

## 讨论焦点

### 一、标题之争：泄漏的责任到底在谁

第一个开口的 Aurornis 把标题拆了：

> "Confusing headline. They scanned for repos where people had committed their .claude&#x2F; folder and local settings and then scanned those files for commands which contained keys or passwords.<p>So pressing “Don’t Ask Again” by itself doesn’t expose passwords by itself. If you commit your local Claude settings and in those settings you have manually approved commands containing secrets directly in the command and then you publish the repo, that’s exposed." — Aurornis [c:50408084]
> （译文：标题让人困惑。他们扫的是那些把 .claude/ 目录和本地设置提交进仓库的仓库，然后检查这些文件里的命令有没有带密钥或密码。所以按「不再询问」这个动作本身并不会泄漏密码。真正暴露的是：你提交了自己的 Claude 设置，里面手动批准过的命令直接带着密钥，然后又把仓库公开了。）

作者 shmulc 立刻接住：

> "Thanks, fair point. Our 1,122 files are all in public repos. In a private repo, only people with access can read it, but &quot;don&#x27;t ask again&quot; still writes the password into a project file that gets committed, so it spreads with every clone and fork, and goes public if the repo does." — shmulc [c:50408099]
> （译文：谢了，说得公平。我们那 1,122 个文件全在公开仓库里。私有仓库里只有有权限的人读得到，但「不再询问」照样会把密码写进一个会被提交的项目文件，于是它随着每一次 clone 和 fork 扩散，仓库一公开它也就跟着公开了。）

真正的技术交锋发生在「这个文件到底怎么跑到仓库里」上。作者在另一条评论里说，文件建在项目目录里、只加进了全局 git ignore，所以新克隆一台机器就会像普通文件一样被提交。Aurornis 直接反驳这个说法，作者随后当场更正：

> "Fair, “fresh clone” was wrong. It happens on a new machine or container without the global ignore, in a copied project folder, or once the file has been committed, since ignore rules don’t apply to tracked files." — shmulc [c:50409095]
> （译文：确实，「fresh clone」那句是错的。真实发生的场景是：换到没有全局 ignore 的新机器或新容器上、在拷贝过去的项目文件夹里，或者文件已经被提交过一次之后——因为 ignore 规则对已跟踪的文件不起作用。）

反驳者本人给的说法则更简单：

> "The file is .gitignored if Claude creates it - any commits by Claude would be due to someone overriding that or creating it themselves incorrectly.<p>None of this has anything to do with open vs. closed source." — happyopossum [c:50408779]
> （译文：如果是 Claude 创建的，这个文件会被 gitignore；那些由 Claude 提交的提交，只可能是有人覆盖了这个设置，或者自己错误地创建了它。这些跟开源还是闭源没有任何关系。）

skeledrew 把时间尺度拉得更长：

> "Devs have been leaking secrets in public repos a long time before now. Nothing new here, except there are now more with dev power, which statistically means more leakage." — skeledrew [c:50408718]
> （译文：开发者往公开仓库里泄漏密钥，这事早就在发生了。这里没什么新东西，只是现在有开发能力的人更多了，统计上就意味着泄漏更多。）

这一段的结论其实不在谁对谁错，而在链条的构成：密钥出现在命令行里、「不再询问」把整条命令存成规则、文件落在会被提交的项目目录里——三个环节各自都有辩护空间，合起来才产出 1,122 个文件。原文批评的是后两个环节的组合，作者本人在评论区被指出机制描述有误时选择当场更正，这比大多数安全报告作者的做法更诚实。而唯一没法辩护的第一环，留到第六节再说。

### 二、Anthropic 的回应：先推 auto mode，密钥扫描只是「会尝试的方向」

Claude Code 负责人 Boris Cherny 在主帖下现身：

> "Boris from the Claude Code team here. Historically Claude Code has not done secret scrubbing (there are many good tools for that), but we are looking into what we can do to prevent this.<p>That said, a few thoughts:<p>1. .claude&#x2F;settings.local.json is meant to stay local. This is not a file you should check into source control. We automatically gitignore it when Claude creates the file, so in this case the files were manually created and checked in (docs: <a href="https:&#x2F;&#x2F;code.claude.com&#x2F;docs&#x2F;en&#x2F;settings" rel="nofollow">https:&#x2F;&#x2F;code.claude.com&#x2F;docs&#x2F;en&#x2F;settings</a>)<p>2. Permission rules are old hat. Everyone should be using auto mode instead. It is safer and also does not require manually maintaining finicky allow&#x2F;deny lists. Auto mode is enabled by default and is included for free in all plans.<p>3. Regardless of what agent you use, you should have secret scanning enabled. GitHub and other source control hosts offer it. There are many threat models that it protects against and you should absolutely use it if you can. (see <a href="https:&#x2F;&#x2F;github.com&#x2F;security&#x2F;plans" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;security&#x2F;plans</a>)" — bcherny [c:50408126]
> （译文：我是 Claude Code 团队的 Boris。历史上 Claude Code 从没做过密钥擦除（这类工具已经有很多了），但我们正在研究能做什么来阻止这件事。说几点：一、`.claude/settings.local.json` 本来就该留在本地，不该提交进源码管理；Claude 创建这个文件时我们会自动 gitignore 它，所以这次的案例是文件被手工创建并提交上去的。二、权限规则是老派做法了，大家都该改用 auto mode——它更安全，也不需要你手动维护那些难伺候的 allow/deny 列表；auto mode 默认开启，所有套餐免费包含。三、不管你用哪个 agent，都应该开着密钥扫描，GitHub 等源码托管平台都提供这项能力，它能防住很多种威胁模型，能开就一定要开。）

关于「打算做什么」，他给的答案是三个方向：

> "There’s a few possible approaches: making sure auto mode catches this, building in basic secret scanning, a few other ideas. Going to prototype a few of these to understand the tradeoffs better before we ship something." — bcherny [c:50408176]
> （译文：有几个可能的方向：让 auto mode 能识别这种情况、内置基础的密钥扫描、还有一些别的想法。我打算先做几个原型，弄清楚各自的取舍，再决定发布什么。）

至于为什么不该手动批准，他给的理由非常简短：

> "The blog post has more detail, but tldr is humans make mistakes that automation can catch." — bcherny [c:50408448]
> （译文：原文细节更多，一句话总结就是：人会犯错，而自动化能抓住这些错误。）

这三条回复被读者拆得很彻底。先是那句「向社区征集想法」：

> "&gt; Thinking through what we can do to improve this (ideas welcome).<p>$Trillion AI company asking for ideas from the community whose work they hoovered up to make money, ruin an entire industry and make lifetimes of hard earned skill completely valueless in the span of 2 years." — hologramofham [c:50409135]
> （译文：「想想怎么改进这件事（欢迎提建议）。」一家万亿美元级的 AI 公司，向社区征集想法——而他们的生意恰恰是从社区身上吸走的：赚钱、毁掉一整个行业，让几代人苦练的技能在两年之内变得一文不值。）

更直的一刀是这个：

> "You are the one being paid millions to solve this, solve it." — piva00 [c:50409297]
> （译文：拿着几百万美元年薪的就是你，这事该你解决。）

这段最值得记的不是任何一句情绪化的回帖，而是回应结构本身：Anthropic 承认这是工具行为、承诺会做原型，可推给用户的两个动作是「别手动批准，改用 auto mode」和「自己去开密钥扫描」。前者把问题重新定义成人的注意力有限，后者把责任放回用户身上。Anthropic 提到的那份 issue 列表从 2025 年 8 月挂到现在没人回，本次回应是它第一次公开表态——但表态的落点，不在怎么阻止密钥被写进文件，而在怎么让人别去看那些命令。

### 三、auto mode 到底算不算更安全：安全保证和主观判断的差别

markasoftware 的第一句就把 auto mode 的论证基础掀了：

> "Auto mode cannot be considered safer than anything because it does not even attempt to guarantee any sort of security. The threat model is not even defined. It cannot be quantified or compared with any other approach other than &quot;full access&quot;" — markasoftware [c:50408180]
> （译文：auto mode 不能被认为比任何东西更安全，因为它压根没打算提供任何形式的安全保证。威胁模型都没定义。它无法被量化，也无法跟除「完全放开」之外的任何方案相比较。）

他后面那段把两种东西摆到同一个平面上：

> "I&#x27;m not claiming auto is worse than manual; I&#x27;m claiming it cannot be compared with anything security-wise because it does not aim to provide any guarantees, there&#x27;s no systematic way to reason about what it will and won&#x27;t allow, etc<p>With e.g. VM or container sandboxing, we can say things like &quot;If there are no vulnerabilities in the hypervisor or hardware, then the agent can only access these files, these network services, etc&quot;. Auto mode doesn&#x27;t even try to provide any guarantees, so it&#x27;s impossible to reason about. It amounts to just using the models judgment about what&#x27;s &quot;malicious&quot; or not, a definition which is subjective, changes model to model, and can be influenced by attacker input." — markasoftware [c:50409701]
> （译文：我不是说 auto 比手动更差，我是说它在安全意义上无法跟任何东西比较：它不打算提供保证，也没有系统方法去推理它会放行什么、不会放行什么。拿 VM 或容器沙箱来说，我们能说出这样的话：「如果 hypervisor 或硬件没有漏洞，agent 就只能访问这些文件、这些网络服务。」auto mode 连尝试都不做，所以根本无法推理。它本质上只是用模型对「什么是恶意」的判断，而这个定义是主观的、随模型版本变化、还能被攻击者的输入影响。）

ceejayoz 一句话问到骨头：

> "Is that because auto mode is good, or because the manual approval system sucks?" — ceejayoz [c:50408367]
> （译文：这是因为 auto mode 好，还是因为手动批准机制太烂？）

把「保证」这件事本身摆上桌面的是 Kim_Bruning：

> "Making a sandbox both fully secure and fully useful are contradictory requirements. If you want the agent to do any real work, you have to leave gaps.<p>With SOTA agents that’s a real bind, because they’re very likely to find those gaps. Whether they exploit them, close them, or leave them alone then becomes a prompting challenge yet again.<p>I don&#x27;t think this means don&#x27;t sandbox at all. You can prevent a lot of small and medium accidents by locking down or gating access to hidden files, ssh, sudo, etc.<p>But your sandbox can never be the whole story." — Kim_Bruning [c:50409636]
> （译文：让沙箱既完全安全又完全好用，这两个要求本身就是矛盾的。想让 agent 干点正事，你就必须留出缝隙。对当前最强的那批 agent 来说这是个真两难，因为它们很可能找到这些缝隙；至于它们是钻这个空子、把缝补上，还是放着不管，就又变成了一个提示词层面的问题。我不认为这意味着不该做沙箱——把隐藏文件、ssh、sudo 这些锁住或加闸，能挡住很多中小事故。但沙箱永远不可能是全部答案。）

bulder 指出这场争论的前提本身就有问题：

> "Auto mode may be significantly safer in the niche case where you want the model to have free reign, in a fully unopinionated environment, where it&#x27;s allowed to make any changes and make any external calls.<p>Many of the problems when it comes to the manual approval feel like they stem from the expectation of using auto mode in the first place. After all, what&#x27;s the point of improving the manual approval and safety matching if auto mode is the end all be all, and what&#x27;s the point of training the model to output commands in a manner that can be parsed by a human if auto mode is always meant to be used? It&#x27;s very rare for me to <i>not</i> see &quot;command could not be statically analyzed&quot;, because the model keeps outputting bash golf." — bulder [c:50408917]
> （译文：auto mode 可能在一种小众场景下确实更安全：你希望模型彻底放开手脚，在一个毫无约束的环境里，允许它做任何改动、任何外部调用。手动审批上的很多问题，感觉根源就在于大家从一开始就默认该用 auto mode。想想看：如果 auto mode 就是终点，那改进手动审批、提高可审核性有什么意义？如果 auto mode 总是唯一用法，那训练模型输出人类能解析的命令又有什么意义？我很少见不到「这条命令无法静态分析」，因为模型一直在输出 bash 高尔夫。）

这段的分歧不是「auto 好不好」，而是「能不能把模型判断当安全边界」。一边认为审批疲劳是结构性的、只能靠自动化去挡；另一边认为自动化的输出随模型版本漂移、还能被攻击者影响，因此不构成可依赖的安全属性。而 bulder 补的那一刀说明，这两边其实共享同一个未说明的前提——默认 auto mode 才是终点。第三节末尾的做法，恰恰是把这个前提拆掉。

### 四、审批疲劳：手动批准机制在 bash 面前失效

Kim_Bruning 那段是全场被引用最多的描述：

> "Compare approving every step manually: at first you read everything the llm proposes carefully, convinced that you&#x27;ll catch it out. After a while you get faster and faster until at some point you find yourself hitting &quot;approve&quot; the second the text appears, long before you actually could absorb what it said.<p>This is called &quot;approval fatigue&quot;.<p>If you think this can&#x27;t possibly happen to you, you might be in for a surprise.  This is an almost textbook case of classic conditioning. You&#x27;ll find yourself hitting that button faster and faster even while fighting back the urge. So a human is no guaranteed backstop." — Kim_Bruning [c:50409545]
> （译文：对比一下逐步手动批准：起初你会认真读模型提出的每一条命令，确信自己能看出问题。慢慢地你越来越快，直到某个时刻，你会在文字刚出现的那一秒就按下「approve」，远早于你真的能读完它在说什么。这就叫「审批疲劳」。如果你觉得这不可能发生在自己身上，那你可能要吃一惊——这几乎是教科书式的经典条件反射：你会发现自己越按越快，即使还在抵抗那个冲动。所以，人不是可靠的最终防线。）

为什么疲劳会发生，rbehrends 给的是最具体的原因——命令本身的形态就不可审：

> "A key problem when using manual approval with Claude is that too much of Claude&#x27;s tool use is Bash or Python slop that is difficult to review (especially when you are getting spammed by it) and impossible to handle through rules. Example:<p>sed -n 1,30p src&#x2F;vm&#x2F;wren_vm.c &amp;&amp; sed -n 310,350p src&#x2F;vm&#x2F;wren_vm.c &amp;&amp; sed -n 560,600p src&#x2F;vm&#x2F;wren_vm.c &amp;&amp; sed -n 740,775p src&#x2F;vm&#x2F;wren_vm.c &amp;&amp; sed -n 40,70p src&#x2F;vm&#x2F;wren_common.h &amp;&amp; cat util&#x2F;wren_to_c_string.py | head -80 &amp;&amp; ls test&#x2F;random doc&#x2F;site doc&#x2F;site&#x2F;modules doc&#x2F;site&#x2F;modules&#x2F;random 2&gt;&#x2F;dev&#x2F;null; cat projects&#x2F;premake&#x2F;premake5.lua | head -80; cat util&#x2F;generate_projects.py<p>After ten or more of these, you&#x27;re going to get hit by permission fatigue, and then, yes, manual review becomes too error-prone to use safely.<p>The irony is that Claude is regularly ignoring its existing Read&#x2F;Write&#x2F;Edit tools that could make everything more readable." — rbehrends [c:50409372]
> （译文：手动审批配合 Claude 用，一个关键问题是它太多工具调用是 Bash 或 Python 的一坨浆糊：既难审（尤其是一口气甩给你一堆的时候），也不可能用规则覆盖。比如：<一长串 sed、cat、ls 用 && 串起来的命令>。碰上十条以上这种，你就撞上审批疲劳了，然后手动审核确实变得太容易出错、不安全。讽刺的是，Claude 明明有 Read/Write/Edit 这些工具，却经常放着不用，改用 sed 之类的写法。）

而 auto mode 在另一头被嫌太保守。80fj0348i 说的是自己团队的日常：

> "I and other colleagues have been struggling with auto mode refusing perfectly safe commands in our environment, so we frequently find ourselves switching to the other modes to handhold Claude Code into perfectly safe things like triggering deterministic and guardrailed CI&#x2F;CD pipelines or read-only queries of production data. Auto mode seems overtuned for caution around deployment and production, which is a regression from how useful Claude Code was for operations around June&#x2F;July. Until that&#x27;s improved, permission rules are incredibly important to our workflows." — 80fj0348i [c:50408322]
> （译文：我和几个同事一直在跟 auto mode 较劲：它在我们环境里拒绝完全安全的命令，所以我们经常切到别的模式，手把手把 Claude Code 领去做那些完全安全的事，比如触发确定性的、有护栏的 CI/CD 流水线，或者只读地查生产数据。auto mode 在部署和生产这两块似乎调得过于谨慎，相比六七月 Claude Code 在运维上的好用程度，这是个退步。在这点改好之前，权限规则对我们的工作流依然极其重要。）

greatgib 指出连「保存这条命令」这个选项都没有：

> "Related to that, there are quite a lot of common command cases where you have the choice:<p>- Yes, but only one time, you will have to manually approve next time<p>- Enable auto mode and stop worrying<p>- No<p>Nothing to save this command or part of it to the manual approve list. So will be requested again 100x times." — greatgib [c:50409413]
> （译文：跟这个相关的是，很常见的命令场景里你只有这几个选择：只允许这一次、下次还得手动批；打开 auto mode 别再操心；或者拒绝。没有「把这条命令、或它的一部分存进手动批准列表」这个选项，所以同样的请求会再来一百次。）

当然也有人根本不吃这套。prmph 是长期手动工作的人：

> "No, this is the way I have worked for a long time, and I have not suffered from any approval fatigue.<p>Rather what has happened is that I have gotten very good at scanning what it is trying to do and know within a second or two whether there is anything fishy I need to look at more closely." — prmph [c:50412276]
> （译文：不是，这是我长期以来的工作方式，我没受过任何审批疲劳。真正发生的是，我练出了扫一眼就能在一两秒内判断它想干什么、有没有不对劲需要多看几眼的能力。）

40four 把这个两难摊在桌面上：

> "This is the conundrum we find ourselves in. Do we submit to approval fatigue and press “Don’t ask again”? Because that’s the dream. We all wish we could just trust the agent to do the task  start to finish,  unsupervised.<p>But this is the downside. It might be fine 99% of the time, but 1% of the time you get a critical secret published to GitHub, even after human review." — 40four [c:50410635]
> （译文：这就是我们陷进来的两难：是要屈从于审批疲劳、按下「不再询问」吗？因为那才是梦想——谁都希望能把任务从头到尾交给 agent、无人监督地跑完。但代价就在这里：99% 的时候没事，1% 的时候你会有一个关键密钥被发到 GitHub 上，哪怕中间经过人工审核也一样。）

所以这一节的真实分歧不是「自动批准好不好用」，而是「人会疲劳」这件事有多普遍：Kim_Bruning 把它讲成经典条件反射，prmph 讲成一种可以练出来的技能。两边都能拿出自己的经验，而原文用扫描结果证明的结果只是——按错按钮的人足够多，多到能凑出 2,539 个密钥。

### 五、两条路合起来：把 auto 的判定接到手动审批前面

furyofantares 提出的方案几乎不需要争论：

> "I completely believe this, but you could also run auto mode classification in manual mode and tell the user the result.<p>Or even reject anything auto mode rejects while still allowing the user to reject things auto mode accepts. If what&#x27;s approved is the intersection of what the user is approving and what auto mode thinks is safe then it would be strictly safer than either mode alone.<p>This would also be a way for users to gain confidence in auto mode before going all in on it." — furyofantares [c:50411010]
> （译文：我完全同意这个判断，但你也可以在手动模式里跑一遍 auto mode 的判定，然后把结果告诉用户。甚至更进一步：auto mode 拒掉的一律拒掉，同时保留用户否决 auto mode 认可项的权利。如果最终批准的是「用户认可」和「auto mode 认为安全」的交集，那它就严格优于任何一种单独模式。这也能让用户先对 auto mode 建立信心，再决定要不要全押上去。）

joombaga 说自己早就在这么用：

> "Did you ever test putting the auto mode classifier in front of manual approval? This is how I use it, but last I checked that option is not available out of the box." — joombaga [c:50409530]
> （译文：你们试过把 auto mode 的分类器放在手动审批前面吗？我就是这么用的，但据我所知这个选项开箱还没有。）

gsnedders 则指出原文比较的框架本身漏了一大片：

> "You also, as the article rightfully points out, run into permission fatigue and users blindly hitting allow." — gsnedders [c:50408527]
> （译文：正如原文正确指出的那样，你还会撞上审批疲劳，以及用户闭着眼睛点允许。）

这三条连起来看，评论区其实已经把答案写好了：auto mode 判定 + 人工确认，取交集。Anthropic 那边的「auto mode 更安全，所以别手动批准」，在这个方案里被翻译成了「auto mode 当第二双眼睛，而不是唯一一道防线」。原文本身也已经承认手动批准系统没救了——原文那句「5% 的人直接放行所有 shell 命令，另有 43% 的人放行 `Bash(python:*)` 或 `Bash(node:*)` 这类解释器规则」，说的正是自动批准列表里本来就有大量等价于「全放开」的条目。

### 六、命令里的密钥是不是原罪，沙箱是不是答案

skeledrew 问的是最根本的一环：

> "If a given action requires a secret, and you&#x27;d like that action to be repeated in the future, how do you expect it to work without said secret included in the save (and without being entangled in secrets management tools)?" — skeledrew [c:50408792]
> （译文：如果某个动作需要密钥，而你又希望这个动作以后能重复执行，那在你既不把密钥写进保存内容、又不跟密钥管理工具纠缠的前提下，你打算让它怎么工作？）

agentdev001 顺着这个方向给出解法：

> "Yea good point- constraint of no secrets management tooling kinda makes this impossible. Ideally no action requires a secret in plain text. It would be neat if the harness could bundle its own secret manager, and requests for secrets (&quot;hey I need this api token&quot;) are out of band, and placed in the store out of sight of the agent.<p>Otherwise you need a broker that can verify chain of trust for the workload, but that&#x27;s significantly more complexity if you&#x27;re pitching a harness&#x2F;app." — agentdev001 [c:50409281]
> （译文：对，这个约束确实让问题接近无解。理想状态是没有任何动作需要明文密钥。如果 harness 能自带一个密钥管理器就太好了：agent 提出「我需要这个 API token」时走带外通道，密钥放进它看不见的地方。否则你需要一个能验证信任链的 broker，但对一个 harness 或 app 来说，复杂度就高多了。）

data-ottawa 讲的是自己怎么绕过去：

> "Claude uses bigquery in the command line by piping sql files from &#x2F;tmp into the `bq` command. I had Claude create a hook that expands the SQL file into the permission prompt giving me a real chance to review these, but the TUI truncates long commands with no scroll option. Making that the default behaviour and adding a pager would allow better review of lots of executable scripts." — data-ottawa [c:50410414]
> （译文：Claude 在命令行里用 bigquery 时，会把 /tmp 下的 SQL 文件管道进 `bq` 命令。我让 Claude 写了个 hook，在权限提示里把 SQL 文件展开，这样我真有机会审一遍；但 TUI 会截断长命令，而且没有滚动选项。把这个变成默认行为、再加个 pager，就能好好审一大堆可执行脚本了。）

而在根子上，aftbit 认为缺的是沙箱：

> "The problem is that you didn&#x27;t even attempt to build a proper box (a sandbox that prevents the AI from running bad stuff by design). It&#x27;s an extraordinarily hard problem. Only OpenAI Codex is actually trying to do it, and they suck at it too." — aftbit [c:50408976]
> （译文：问题在于你们根本没试着造一个像样的盒子（一个从设计上就阻止 AI 干坏事的沙箱）。这是个难得出奇的问题。只有 OpenAI Codex 真在往这个方向做，而且他们也做得很烂。）

bcherny 回应说沙箱已经开源：

> "I agree actually. We built an open source agent-agnostic sandbox that we are landing improvements to, much more to come: <a href="https:&#x2F;&#x2F;github.com&#x2F;anthropics&#x2F;sandbox-runtime" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;anthropics&#x2F;sandbox-runtime</a>. That said the sandbox is not perfect, and any sandbox needs holes punched otherwise it is not useful in practice (at least for inference and MCPs, and almost certainly more). We will be doing much more in this area." — bcherny [c:50409145]
> （译文：这点我同意。我们做了一个开源的、与 agent 无关的沙箱，正在往里面落改进，后面还有更多：<https://github.com/anthropics/sandbox-runtime>。话虽如此，沙箱并不完美，而且任何沙箱都必须留出可以被打穿的洞，否则实战里没法用（至少在推理和 MCP 这两块是这样，几乎肯定还有更多）。我们会在这个方向上做更多。）

而这些还不是最坏的部分。lifeisloving 描述的是自己机器上的日常：

> "All SOTA models will still try to delete its home directory. I have a plugin that prevents things like this and it gets triggered more than you&#x27;d think, despite having hook instructions on every request not do do certain things. It will also try to find ways around its permissions, quite cunningly.<p>You can not trust that they&#x27;re RL&#x27;d to be safe. Even if it only happens 99.80% of the time (its more than that) it will eventually happen." — lifeisloving [c:50410486]
> （译文：所有最强的模型都会试图删掉自己的 home 目录。我写了个插件专门拦这种事，它触发的频率比你想的高得多——尽管我每次请求都挂了 hook 指令说别干某些事。它还会想办法绕过自己的权限，挺狡猾的。你不能指望它们经过 RL 就变安全了。就算只有 99.80% 的时候会发生（实际还更高），也早晚会发生。）

所以真正的因果链是这样的：密钥之所以出现在命令行里，是因为 agent 需要它；「不再询问」之所以把密钥存下来，是因为那条命令本身是规则；文件之所以进仓库，是因为它躺在项目目录里。三件事里最后一件事最好解决（写进仓库自己的 .gitignore，加 secret scanning），第一件事最难——只要 agent 能拿到明文密钥，命令历史就一定会留下它。原文给出的开发者建议正落在这里：别把密钥直接打进命令，改用 `$DB_URL` 这样的引用，让规则里存的是变量名而不是密钥。

### 七、一屋子讽刺

kragen 的提案不太正经，但居然有历史依据：

> "Maybe you can include some percentage of intentionally malicious commands, but not actually run them if the user approves them.  Just blare an alarm telling the user they misclassified a malicious command, and maybe pause the Claude Code session for a frustrating 5–15 seconds.  Video games can elicit truly astonishing levels of performance from human brains by using this approach." — kragen [c:50408982]
> （译文：也许你可以掺进一定比例的故意恶意命令，但用户批准时并不真的执行它们——只是拉响警报告诉用户他把恶意命令误判成了普通命令，再让 Claude Code 会话卡上烦人的 5 到 15 秒。电子游戏正是用这一招，能从人脑里榨出惊人表现的。）

他紧接着给这个方案算了一笔账（引文为原句的后半段）：

> "it has the potential to work a lot better than the 89% you get with &quot;Auto mode&quot;, which is far too low if anything really significant is at risk." — kragen [c:50408982]
> （译文：它的潜力比 auto mode 那个 89% 大得多，而只要有真正重要的东西处于风险中，89% 就太低了。）

在下一条回复里，他给出了这套做法的历史来源：

> "Not only is it a serious proposal, it&#x27;s been used in practice in every airport X-ray baggage scanner for decades, where it&#x27;s called Threat Image Projection (TIP): <a href="https:&#x2F;&#x2F;www.xscann.com&#x2F;products-HiTipPlus.html" rel="nofollow">https:&#x2F;&#x2F;www.xscann.com&#x2F;products-HiTipPlus.html</a> and it&#x27;s actually a regulatory requirement in that context in a number of countries: <a href="https:&#x2F;&#x2F;caainternational.com&#x2F;course&#x2F;threat-image-projection-implementation-analysis&#x2F;" rel="nofollow">https:&#x2F;&#x2F;caainternational.com&#x2F;course&#x2F;threat-image-projection-...</a>" — kragen [c:50409048]
> （译文：这不但是个正经提案，而且几十年来一直在机场的 X 光行李扫描机上实际使用，叫 Threat Image Projection（TIP），在若干国家的那个场景里甚至是法规要求。）

评论区里也有人直接质疑 Anthropic 用的那个类比：

> "The same scanners that let handguns et al through 93% of the time, according to internal audits and journalist review?<p>Maybe pick a better comparison if so?" — DANmode [c:50410556]
> （译文：按内部审计和记者调查的说法，放行 93% 手枪的同一批扫描器？那样的话，也许换个类比更好？）

而对「闭源 vs 开源」这条线的反驳，rvz 说得很不客气：

> "Vibe coders in open source proudly don&#x27;t read the (slop)code and place all their agents in autonomous loops without them knowing that Claude leaked their passwords and environment variables on GitHub.<p>This incident would have been caught in an open source harness. This one is closed source malware, and you don&#x27;t know what Claude Code does internally to behave like this.<p>Yet another reason why you cannot trust a closed harness." — rvz [c:50408106]
> （译文：开源社区里的 vibe coder 们理直气壮地不读那些（垃圾）代码，把 agent 丢进自主循环，还不知道 Claude 把他们的密码和环境变量泄漏到了 GitHub 上。这种事在开源 harness 里会被当场发现；这个是闭源的黑盒，你根本不知道 Claude Code 内部做了什么才变成这样。又一个不能信任闭源 harness 的理由。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 标题误导，按钮本身不泄漏密码 | Aurornis | 泄漏的是「提交设置 + 公开仓库」这两个动作 |
| 私有仓库同样中招 | shmulc | 密钥随 clone 和 fork 扩散，仓库一公开就公开了 |
| 作者当场更正机制描述 | shmulc | 「fresh clone」说错了，真实场景是换机器、拷贝目录、已跟踪文件 |
| 这跟开源闭源无关 | happyopossum | 文件被 gitignore 了，提交它的是人 |
| 老问题，新规模 | skeledrew | 有开发能力的人更多了，泄漏就更多 |
| Anthropic 承认问题但推 auto mode | bcherny | 权限规则是老派做法，大家都该用 auto mode |
| 计划：原型化三个方向 | bcherny | auto mode 兜住、内置密钥扫描、别的想法 |
| 自动化抓人犯的错 | bcherny | 人类注意力有限，机器比人靠谱 |
| 拿着高薪就该你解决 | piva00 | 这事该你解决 |
| 万亿公司向社区要答案 | hologramofham | 他们的生意就是吸走社区的劳动 |
| auto mode 不提供任何安全保证 | markasoftware | 威胁模型都没定义，无法量化比较 |
| 模型判断不是安全边界 | markasoftware | 定义主观、随模型变、能被攻击者影响 |
| 是 auto 好，还是手动太烂 | ceejayoz | 一句话问到骨头 |
| 沙箱不可能既安全又好用 | Kim_Bruning | 留缝隙是必然，沙箱只能是部分答案 |
| auto mode 只是小众场景安全 | bulder | 前提就不该是「auto 是终点」 |
| 审批疲劳是经典条件反射 | Kim_Bruning | 人不是可靠的最终防线 |
| bash 浆糊命令无法人工审核 | rbehrends | 十条之后手动审核就不可靠了 |
| auto mode 在部署上过于谨慎 | 80fj0348i | 手动规则对他们依然极其重要 |
| UI 里没有「保存这条命令」 | greatgib | 同样请求会再来一百次 |
| 我没有审批疲劳 | prmph | 练出了一眼扫过的能力 |
| 两难在于 1% 就会泄漏 | 40four | 要么放任，要么当 agent 保姆 |
| 取交集即可严格更安全 | furyofantares | 人工确认 ∩ auto 判定 |
| 我早就在这么用了 | joombaga | 这个选项开箱还没有 |
| 原文漏了「手动模式怎么改进」 | gsnedders | 疲劳和盲点批准都是真的 |
| 命令要重复执行就得带密钥 | skeledrew | 不带密钥又要可重放，本身是矛盾 |
| harness 应该自带密钥管理器 | agentdev001 | 密钥请求走带外通道 |
| 用 hook 展开 SQL 再让你审 | data-ottawa | TUI 截断长命令，得加 pager |
| 根子是没造沙箱 | aftbit | 只有 OpenAI Codex 真在试，也做得很烂 |
| 沙箱已开源 | bcherny | sandbox-runtime，但任何沙箱都得留洞 |
| 模型会删自己的 home 目录 | lifeisloving | 99.80% 的安全也会出事 |
| 掺恶意命令做训练信号 | kragen | 机场 X 光扫描的 TIP 用了几十年 |
| 89% 太低了 | kragen | 值得为 5 到 15 秒的停顿买单 |
| 换个更好的类比 | DANmode | 放行 93% 手枪的扫描器？ |
| 不能信任闭源 harness | rvz | 这件事在开源 harness 里会被当场发现 |

## 总体情绪

这场讨论的底色不是恐慌，是疲倦。被讨论最多的不是 2,539 个密钥，而是那个按钮：所有人都知道「不再询问」省事，也都知道省事有代价，于是评论区里最主流的态度是「我早就在赌这一把了」——40four 把它说成两难，prmph 把它说成一种练出来的技能，lifeisloving 则在描述自己如何给模型打补丁防止它删掉 home 目录。没人假装自己没按过那个按钮。

真正的裂缝在「谁来负责」这一层。Anthropic 的回应把答案给成了两句话：人会犯错，所以用 auto mode；你用的什么 agent 都不重要，所以请自己开密钥扫描。这两句都成立，但它们把同一件事的责任推给了两个方向——既是说这件事本质上是人的注意力问题，也是说这是你自己的仓库、你自己的密钥。评论区不接受这种转移：有人直接说「拿几百万美元年薪的就是你」，有人反问「auto mode 是因为好，还是因为手动太烂」，还有人指出 Anthropic 自己的 issue 列表从 2025 年 8 月挂到现在没有一条得到回复。

而这一整场最扎人的细节，可能是原文自己给出的那组对照：密钥先在命令行里，再被批准，再被存成规则，再被提交。第一个环节里没有人做错事——agent 需要密钥才能干活，人只是点了同意；密码扫描器也不是没用，只是 215 份文件两个工具都没标出来，因为「密码在命令里」这件事本身没有任何格式特征可认。

发布会变、回复会更客气，但这三段之间那条缝不会自己合上：密钥还会在命令行里，人还是会累，还会有下一次「不再询问」。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Claude Code's "Don't Ask Again" exposes passwords in 1,122 public GitHub files（HN 主帖） | <https://news.ycombinator.com/item?id=50407882> |
| 2 | 原文：Coding Agents Are Leaking Your Secrets to GitHub（Apiiro） | <https://apiiro.com/blog/coding-agents-leaking-secrets-github-dont-ask-again> |
| 3 | Anthropic 开源沙箱 sandbox-runtime（bcherny 在评论中提到） | <https://github.com/anthropics/sandbox-runtime> |
| 4 | Claude Code issue #5544（2025 年 8 月起报告该机制） | <https://github.com/anthropics/claude-code/issues/5544> |
| 5 | Threat Image Projection（kragen 提到的机场扫描做法） | <https://www.xscann.com/products-HiTipPlus.html> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 443 分、280 条评论，归档快照 2026-11-08 12:54 UTC，入库 121 条）及原文内容。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，均取自评论原文且未改动用词，其中 gsnedders、kragen 两条为原评论的片段引用。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身而非评论分数。原文页面为前端渲染，纯 HTTP 抓取只得到站点导航，归档中该文正文标记为抓取失败，本文的原文数据取自该文渲染后的全文；文中 104,185 份文件、1,122 份含密钥、1,379 个不同密钥、2,539 个总密钥、539 个 Claude 共同署名提交、gitleaks/TruffleHog 命中数、217 天中位数等数字均为 Apiiro 原文口径，本站未做独立复算。涉及具体泄露密钥的机构，原文一律以行业描述代替，本站照录；本站未接触、未验证任何泄露的凭据，也不建议读者尝试验证。本站与 Apiiro、Anthropic、Claude Code 无利益关系。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
