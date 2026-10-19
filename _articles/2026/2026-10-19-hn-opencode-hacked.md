---
layout: post
title: >-
  OpenCode Console 用户凭证泄露 — HN 上"我早说过"与"先废 key"的拉扯
date: 2026-10-19
hn_id: '50133401'
categories: [articles]
excerpt: >-
  OpenCode 承认一起针对 Console 用户的"蒸馏攻击"，1.4% 账户的 OpenAI/Anthropic key 暴露；HN 上既有"早被警告过"的旧账重提，也有"为什么不替用户直接 revoke"的现实拷问。
tagline: >-
  用户的 key 进了厂商的网关，厂商又把 key 送给了攻击者。
---
## 原文概要

OpenCode 在 10 月 17 日下午发推公开了一起针对 OpenCode Console 的安全事件：一次"大规模蒸馏攻击"（distillation attack）让大约 1.4% 的 Console 用户受到影响，被影响用户已通过邮件收到通知，事件仍在进行中，因此官方暂时不能披露更多细节，目前在和 Anthropic、OpenAI、Google 一起做修复。

事件的关键事实随后由 OpenCode 团队在 HN 一楼的回复里补齐：突破口是一个"正在退役中的遗留系统"，用户在 Console 工作区里保存的第三方 provider 密钥（OpenAI、Anthropic 等）可能被外泄，建议受影响用户到对应 provider 控制台 revoke 并替换密钥，并检查近期用量异常。

要分清两件事：被外泄的是 Console（一个类似 OpenRouter 的 BYOK 网关，托管在 dev.opencode.ai）里存储的 provider key，不是开源 OpenCode CLI 本地用的那份。同一个密钥用于本地 CLI 的话理论上不受牵连，但实际攻击结果要等官方事后报告。OpenCode 本身是 YC 投资的公司，背后是 anomaly.co（同 sst.dev 团队）。

推文贴出来 24 小时内拿到 900 多分，但排名被压在第 10 名附近，发帖人在 HN 上公开抱怨"被 flag 了很多次"。一周前 HN 上还有人发过 OpenCode v2.0 的功能讨论（带安全回归清单），这一波恰好接上。

## 讨论焦点

### 1.4% 的口径与"密钥到底存哪儿"的初始困惑

事件最初的困惑点不是发生了什么，而是密钥为什么会"在厂商手里"——很多人没意识到 Console 是个独立的托管服务。

> "I don't use OpenCode but I would like to know who this impacts. Surely people who are just using OpenCode locally with their own credentials wouldn't be impacted, right? This sounds like something where you have a hosted service and you put your keys into that." — jchw [c:50133753]

> （译文：我不怎么用 OpenCode，但我想知道这次到底影响谁。仅仅是本地用自己凭证跑 OpenCode 的人应该没受影响吧？听起来是那种你把 key 放进托管服务的场景。）

另一条评论又把范围进一步扩散：

> "Turns out even if you used credentials locally, you could've have been impacted as the .env files were also consumed by the agents. This is from some comments on Reddit / Google, so take it with a grain of salt." — neya [c:50134117]

> （译文：结果发现，就算你用的是本地凭证，`.env` 文件也曾被 agent 读取过。这是 Reddit/Google 评论区里看到的，先打个折听。）

官方目前口径只承认 Console 受影响，CLI 本地运行的报告还没承认。两者之间一旦官方事后报告里出现第二条 .env 的受影响路径，"1.4% 比例"就要重写。一条 HN 评论附带了一份 [stats 页面](https://news.social-protocols.org/stats?id=50133401) 显示该帖在 raw 排名 #1，但从未突破过第 10 名，与"被大规模 flag"的怀疑相吻合。

### 攻击结果先从账单上显形

攻击一旦得手，第一波可见的后果不是公告，而是被刷爆的 API 额度。

> "I saw the email this morning from OpenCode about my key being compromised alongside an email from Anthropic stating that I used up my $20 in API credits for the month. I hope they built something cool with those tokens!" — jprokay13 [c:50134785]

> （译文：今早我收到了 OpenCode 关于我的 key 被泄露的邮件，紧跟着又收到 Anthropic 的，说我这个月的 $20 API credit 用完了。希望他们拿这些 token 干了点有意思的事！）

> "Probably another tool help steal more tokens. Or to probe more controversial topics without fear of getting banned." — NewsaHackO [c:50136024]

> （译文：大概率又是个工具帮忙偷更多 token，或者拿不被封禁的安全去试探各种争议话题。）

攻击具体拿这些 key 做了什么，OpenCode 没在公告里讲，只说"在进行中"。这正是 verdverm 后来追问"是否愿意公开原始 query 数据集"的原因——"distillation attack"这个说法目前只有厂商一面之词，Anthropic / OpenAI 自己过去几个月也一直在用这面鼓吹竞争威胁。

### 旧的警告贴被重新翻出来

攻击的消息出来后，HN 上立即有人贴出 68 天前自己发过的同类警告，标题里写"OpenCode 会把你的数据泄露给他们自己和一些不透明的第三方，作者装傻不修"。

> "I told you so: <https://news.ycombinator.com/item?id=49243119><br>Me, 68 days ago:<br>> Beware of the author of tweet, who happens to be author of OpenCode - OpenCode will leak all your data to themselves and to shady 3rd parties. Author feigned ignorance and never fixed the issue. OpenCode among other harnesses is the shadiest of all." — bewareofscams [c:50133643]

> （译文：我早说过：<br>68 天前的我：<br>> 小心这条推文的作者，他恰好是 OpenCode 的作者——OpenCode 会把你的数据泄露给他们自己和一些不透明的第三方。作者装傻不修。OpenCode 在所有 harness 里算最黑的。）

值得对位的是 Reyonlds96 的反驳：所谓"泄露"只是给一个默认 title-gen 用的小模型走 ZDR 通道，可以关闭，现在也已经被移除，默认还是私密的。

> "All it ever did was give people free model for title gen, if they didn't set one themselves. Feature you could disable or set on your own model. That was since removed, so now there is no free fallback model. That is it. It is still private by default." — Reyonlds96 [c:50135782]

> （译文：它干的全部事情就是给那些没自己设模型的人一个免费的 title-gen 模型。这功能可以关掉，也可以自己设个模型。后来已经被移除，所以现在没有免费 fallback 模型了。就这些。默认仍然是私密的。）

反驳的反驳同样来自同一条 thread：

> "All it 'ever did' was send your entire prompt/context to a 'free' model for harvesting. The astroturfing in this thread is absurd." — anonymous908213 [c:50135829]

> （译文：它"干的全部事情"就是把你的整段 prompt / 上下文送给一个"免费"模型去收割。这条贴里的水军实在离谱。）

Reyonlds96 进一步澄清：发出去的是 GPT-5-nano 走 ZDR，目的只是 title-gen，但这条路径在很短一段时间里确实存在；后来很快就被下掉了。技术细节上没问题，但"曾经走过"本身就是另一回事——"vibe 出来的 fallback"在 attacker 看来跟"故意的数据通道"长得一模一样。

verdverm 给出的第三方观察更不客气：

> "As the person who worked with the OpenCode team on the CLI security regression this last week, I do not think they are *unrelated*, though there is no direct connection. My read is too much vibemaxxing, not enough critical analyses of the Ai output and (re)designs of various systems in their code base." — verdverm [c:50137077]

> （译文：作为上周跟 OpenCode 团队一起处理 CLI 安全回归的那个人，我不认为它们*无关*——虽然没有直接关联。我的判断是 vibe 做得太多，对 AI 输出和代码库各处 (重) 设计的批判性分析太少。）

把一周前的安全回归清单跟这次的 Console 事件摆在一起读：配置加载、插件热重载、permission 各自被开了洞，附带 .env 里有 credentials 走云端这一事实——"vibecoded 的 bug"已经成为这次事件的口径模板。

### 推文标题与"flag 大军"

事件另一个被反复讨论的支线，是这条推文本身在 HN 上的可见度。

> "I am the author of this post. Looks like OpenCode fans / team is not happy with this post coming on the first page of HN. It has already been flagged by many. I never ask for upvotes, but would be great if you can upvote it. Thanks!" — pranshuchittora [c:50133838]

> （译文：我是这条贴的作者。看起来 OpenCode 粉丝 / 团队不希望这条贴出现在 HN 首页，已经被 flag 很多次。我不求点赞，但如果能 up 一下就好。谢谢！）

> "The title should say 'OpenCode Console' not 'OpenCode'. The post was visible when I am logged in. But when I opened the /newest page on incognito the post wasn't there." — ShowalkKama [c:50133948] / pranshuchittora [c:50134130]

> （译文：标题应该写"OpenCode Console"而不是"OpenCode"。我登录时能看到这条贴，但用隐身模式打开 /newest 页面时就看不到了。）

> "Yeah that's a big difference." — canadiantim [c:50136096]

> （译文：是的，这是个很大的区别。）

> "Pretty pathetic if true. Imagine if they spent as much effort securing their systems as they spend brigading and astroturfing after getting 0wned." — ryandrake [c:50136230]

> （译文：如果是真的话，挺可悲的。想象一下，他们把搞定自己系统的精力拿来搞事后公关和五毛刷屏会怎样。）

把"flag 多"这件事本身成立起来的是 [stats 页面](https://news.social-protocols.org/stats?id=50133401)——raw rank #1、HN 排名从未突破 #10。flag 是超级 down-vote，HN 上点不出普通 down-vote，flag 操纵排名的事情最近几个月被多次曝光。这条讨论里同时也是给将来读者一个时间戳："这件事发生时，HN 上有人正在为它抢排名。"

### 为什么没人替用户直接 revoke

事件里另一个被反复追问的工程问题是：能不能由 OpenCode 直接通知各家 provider 把外泄 key 失效，省得每个用户自己跑一遍？

> "I think every API key system should have endpoint 'invalidate_api_key' this way whitehat hackers or the party who stored them could invalidate all keys in the case they leak. Now it is race against the time, and everybody got email, and everyone must act themselves." — Ciantic [c:50133904]

> （译文：我认为每个 API key 系统都应该有个 `invalidate_api_key` 端点，这样白帽黑客或者存 key 的一方在泄露发生时可以批量作废所有 key。现在是跟时间赛跑，所有人收到邮件，每个人都得自己动手。）

> "There's no self-serve endpoint, but OpenCode could send the inference providers the leaked keys and ask for them to be revoked, which is a thing the inference providers can do. It's possible that this'll happen, apparently remediation is still in progress." — ameliaquining [c:50134244]

> （译文：没有自助式的端点，但 OpenCode 可以把泄露的 key 发给各家推理 provider、要求他们撤销，这是 provider 都能做的事。理论上可以做，看起来修复还在进行中。）

> "FWIW they invalidated my key in the middle of a session this morning." — weknowbetter [c:50138113]

> （译文：顺带一提，他们今早在我会话进行到一半的时候把我的 key 撤了。）

支持端点化的声音遭到了 orf 的反对——他把整个"invalidate_api_key"方案当成一个"凭证泄露→DoS"放大器来反对：

> "That just turns a credential leak into a denial of service - one that can be triggered from anywhere." — orf [c:50134994]

> （译文：那不过是把凭证泄露变成一个 DoS——一个任何人都能触发的 DoS。）

orf 进一步解释：如果攻击者手里有 key，他能选"自己用"或"让别人用不了"。前者显然对他更有利，所以这条机制不会让攻击者主动 revoke，只会让他多一个"合法把别人服务搞挂"的工具。tptacek 那条"graph layout 是著名难题"在这里没出现，但同一类型的"看起来无害的安全设计其实把问题搬家"模式几乎是同一回事。

支持端点化的 shepherdjerred 用一个具体场景把这条论证反向推翻：

> "In this case you'd probably prefer your key to be disabled rather than spending $$$ on tokens for everyone else." — shepherdjerred [c:50135261]

> （译文：在这件事里，你大概宁可 key 被作废，也不想让别人刷你的 token。）

最终结论是：OpenCode 自己无法自助替用户 revoke，但是 OpenCode 可以"把外泄 key 发给 provider 让 provider 撤销"。这条路径在 OpenAI / Anthropic 那边虽然有人工流程，但没有自动化 API 入口。所以最后落地形态仍是"用户收到邮件，自己去 revoke"——这件事从用户端看是 lazy，从设计上看是行业级缺位。

### 退款与责任归属

事件相关的金钱问题几乎是同时被打开：

> "It's a little more than that. It seems that keys for OpenAI / Anthropic APIs that were STORED on OpenCode's OpenRouter-like backend got leaked – which additionally means that OpenCode has no ability to refund people for their losses." — tekacs [c:50135111]

> （译文：事情比那严重一点。看起来存在 OpenCode 这个 OpenRouter-like 后端里的 OpenAI / Anthropic API key 被泄露——这还意味着 OpenCode 没有能力给用户赔损失。）

> "If they took payment, they are liable and they must have the ability to refund." — cassianoleal [c:50135884]

> （译文：如果他们收了钱，他们就有责任，必须能退款。）

> "I guess Anthropic and OpenAI might refund based on good will." — pranshuchittora [c:50136021]

> （译文：我猜 Anthropic 和 OpenAI 可能会基于 goodwill 退款。）

cassianoleal 后来发现 OpenCode 没有 resell 模型，只是 BYOK 网关，所以"收了钱就有责任"这条不直接适用。但 OpenCode 收的是 Console 服务费，不是 provider key 的钱——他们收钱的服务（让用户能在同一面板调度多家模型）现在出现安全事件，因此退款责任落到谁头上，目前没有清晰答案。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 分清 CLI 和 Console | jchw [c:50133753] | 本地 CLI 用户不受牵连，事件针对托管 Console |
| 扩散到本地 .env | neya [c:50134117] | .env 被 agent 读过的传言扩散了受影响面 |
| 账单先爆 | jprokay13 [c:50134785] | 一晚上 Anthropic $20 月度 credit 用完 |
| "我早说过" | bewareofscams [c:50133643] | 68 天前就警告过"OpenCode 会泄露数据给第三方" |
| 反驳是水军 | anonymous908213 [c:50135829] | 默认 fallback 走云端就是 prompt 被收割 |
| 厂商公关注脚 | Reyonlds96 [c:50135782] | 走的是 ZDR 通道，已经下掉，默认仍私密 |
| vibemaxxing 后果 | verdverm [c:50137077] | 跟上周 CLI 安全回归无关但同根，都是 vibe 太多 |
| 标题被 flag | pranshuchittora [c:50133838] | 24 小时 900+ 分但从未突破第 10 名 |
| 推文标题不准 | ShowalkKama [c:50133948] | 应该写 Console 不是 OpenCode |
| 应支持 revoke API | Ciantic [c:50133904] | 每家 provider 都该有 `invalidate_api_key` 端点 |
| revoke 是 DoS 放大器 | orf [c:50134994] | 给攻击者多一个合法把服务搞挂的工具 |
| OpenCode 可代 revoke | ameliaquining [c:50134244] | 把外泄 key 发给 provider，provider 能手动撤 |
| 退款无门 | tekacs [c:50135111] | BYOK 模型下 OpenCode 没能力赔用户损失 |

## 总体情绪

这次事件把两件原本分开的事情压到了一起：密钥的存放位置（厂商网关 vs 本地 CLI）和事件发生时的归责路径（OpenCode 公告 → 用户自查 → provider 无自助 API）。前者决定了"影响谁"，后者决定了"出了事谁做什么"。两边在 HN 上被同时翻出来，加上 68 天前那条"我早说过"的旧贴被搬回来，构成了这次讨论的底色——不是单一的"OpenCode 坏了"，而是"这件事连同它之前的所有信号一起被重新评估了"。

> 用户的 key 进了厂商的网关，厂商又把 key 送给了攻击者；剩下唯一能做的就是等用户自己去 provider 控制台点那个 revoke 按钮——而这件事本可以被设计成"一键"。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | OpenCode Hacked: User credentials leaked | https://news.ycombinator.com/item?id=50133401 |
| 2 | HN 帖子排名统计 | https://news.social-protocols.org/stats?id=50133401 |
| 3 | 68 天前的预警贴 | https://news.ycombinator.com/item?id=49243119 |
| 4 | OpenCode 团队早期公告（推文） | https://twitter.com/opencode/status/2111516673953935833 |
| 5 | OpenCode Console 入口 | https://dev.opencode.ai/console/ |
| 6 | OpenCode 公司页 | https://www.ycombinator.com/companies/opencode |

## 免责声明

<div class="disclaimer">

本文为 AI 辅助整理的 HN 讨论摘要，仅反映所引用用户发言在抓取时刻的内容与立场，不代表本站观点。所有引文与 ID 均对应 HN 原帖评论，事实校验请直接前往原帖。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
