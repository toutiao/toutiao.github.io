---
layout: post
title: >-
  Claude Code 终于读 AGENTS.md 了 — HN 讨论：Anthropic 拖了一年半，被 Shopify CEO 威胁封禁之后终于妥协
date: 2026-09-19
hn_id: 49760187
categories: [articles]
excerpt: >-
  Claude Code 2.1.277 默认读不到 AGENTS.md —— 开发者只能用 CLAUDE.md，否则就把 AGENTS.md 软链接过去。直到 2026 年 9 月 18 日，这个「明显应该做的事」才被做出来。HN 评论里最高赞是「AGI 都有了，却没有 20 美元 token 预算加这个基础功能」；有人列出 Anthropic 改主意的两个触发条件：Codex 上线 Astra、Shopify CEO Tobi Lütke 在 X 上威胁封禁 Claude Code。社区把这次升级定性为「被骂出来的，不是帮出来的」。
tagline: >-
  AGI 都有了，却没有 20 美元 token 预算加这个基础功能。
---

## 原文概要

HN 首页 (/news) 讨论的是 Claude Code 2.1.277（2026-09-18 发布）的更新日志里一条不起眼的改动：「在没有 CLAUDE.md 的项目里，Claude Code 现在会读 AGENTS.md；可以在 `/config` 的 Project instructions 里关掉。Bedrock、Vertex、Foundry 暂不支持」。帖子由 datadrivenangel 提交，链接直接指向整张 changelog 页面（[code.claude.com/docs/en/changelog](https://code.claude.com/docs/en/changelog)），发布 6 小时拿到 542 分、196 条评论，热度冲到首页。

这条 changelog 单看字数只是几行，但社区反应几乎是「集体倒吸一口气再加集体翻白眼」。AGENTS.md 是早就在 Codex、Cursor 等其它 harness 里通行的项目指令文件名，Claude Code 长期只认自家命名的 CLAUDE.md，逼用户要么复制一份 CLAUDE.md、要么用 `ln -s AGENTS.md CLAUDE.md` 做软链接、要么在 CLAUDE.md 里写一句「@AGENTS.md」骗它去读真正的文件——datadrivenangel 自己就在评论里说：「这条更新让我们终于能删掉那些一行内容的 Claude.md 文件了——它们存在只是为了说一句『AGENTS.MD』。」

提交者还提到一个细节：最近他让 Claude「Fable」初始化一个新项目时，Fable 主动建了 AGENTS.md 并且把 CLAUDE.md 做成 AGENTS.md 的软链接——「我其它项目里没有这个软链接，是 Fable 自己推断出我同时用 Codex 和 Claude」。这个观察被很多评论当作「Claude 自己早就意识到标准分裂，只是故意不做」的证据。

## 讨论焦点

### 「AGI 都有了，却没有 20 美元 token 预算加这个基础功能」

评论区的怒气值很高。vb-8448 那句被反复转发的吐槽排在前列：「They have AGI, but they don't have $20 of token budget to add a so basic functionality.」——把 Anthropic 在 podcast 上讲 AGI、讲 agent 的调门和这条小改动的滞后放在一起，嘲讽效果直接拉满。

> "They have AGI, but they don't have $20 of token budget to add a so basic functionality." — vb-8448 [c:49760502]
>
> （译文：他们已经有 AGI 了，却没有 20 美元 token 预算来加这么基础的功能。）

cmrdporcupine 直接给出时间口径：「Only took them a year and a half of everyone complaining to finally do the right thing.」——和 perganomoly 的「基本功能拖这么久是一种耻辱」形成呼应，后者更激进，说已经「弃用 Claude，正在轮换 Codex、Gemini 和 Qwen3.8 30B」，要 Anthropic 拿出「Culture 系列级别的心智」才考虑回来。

> "Only took them a year and a half of everyone complaining to finally do the right thing.

Congrats." — cmrdporcupine [c:49760399]
>
> （译文：花了大家一年半吐槽，他们才终于做对这件事。恭喜啊。）

dude250711 把这种情绪浓缩成一个缩写梗：「They have achieved AGI/RSI internally and it told them 'common, let's sort this s..t out, it's embarrasing'.」——AGI/RSI = Repetitive Strain Injury（重复性劳损），意指 Anthropic 内部的 AI 自己也受不了自家产品。

### `.agents/skills` 仍然不读：「再等三年」

「终于」二字很快被第一条高赞评论打脸。clutter55561 上来就泼冷水：「Don't get too excited, Claude code still won't detect skills on `.agents/skills`.」—— `.agents/skills` 是 Codex 等 harness 存放预制技能（skill）模板的标准目录，Claude Code 至今不识别，让「跨 harness 共享技能」这条路断了一半。

> "Don't get too excited, Claude code still won't detect skills on .agents/skills." — clutter55561 [c:49760389]
>
> （译文：别太激动，Claude Code 仍然读不到 `.agents/skills` 里的 skills。）

jjordan 用一句反讽做了时间承诺：「Don't worry, it's on the roadmap for Q4 2029.」——2029 年第四季度。aliasxneo 跟着补充说他已经 Ctrl+F 翻遍 release notes 也没找到 `.agents/skills` 的支持，「我现在用的 harness 已经替 Claude 兜了这个底，所以我自己也搞不清它到底支不支持——如果做了 AGENTS.md 但没做 `.agents/skills`，那就太气人了。」albatross79 干脆把这台「bloat 到要 AGI 才能加个新文件名支持」的客户端称作「CC is such a bloated POS by this point that only full on AGI could have implemented this feature」，并补刀「也许要等 Super Intelligence 才能让它真的遵守 AGENTS.md 里写的指令。」

### 改主意的两个触发条件：Shopify CEO 推特 + Codex 上线 Astra

jtbaker 引用了 [thenewstack.io](https://thenewstack.io/shopify-claude-code-agentsmd/) 的报道，把这次改动的外部压力直接摊开：Shopify CEO Tobi Lütke 在 X 上发帖说「I'm thinking about banning Claude Code at Shopify until they change their mind and read AGENTS.md and `.agents/skills` etc.」。

> "I'm thinking about banning Claude Code at Shopify until they change their mind and read AGENTS.md and .agents/skills etc.," Lütke posted Tuesday on X. — jtbaker [c:49760774]
>
> （译文：Lütke 周二在 X 上发帖：「我在考虑封禁 Shopify 的 Claude Code，直到他们改变主意去读 AGENTS.md 和 `.agents/skills` 等。」）

评论区里 anukin 只回了三个字母一个名字：「Thank you Tobi Lutke.」——把功劳全记在外部施压者头上。deaux 直接点出两个同时发生的诱因：「Two reasons combining at the same time: GPT Astra, and the Shopify CEO tweet.」——Codex 上线 Astra 的时机 + Lütke 的公开威胁，让 Anthropic 没法继续装睡。

throwaw12 的定性更狠：「Remember they didn't do this because they wanted to help community, they did it because community was angry and they were losing users to other harnesses. Doesn't look like Anthropic care about dev community」——把这次升级定性为「被骂出来的，不是帮出来的」，并暗示 Anthropic 整体上不把开发者社区放在眼里。

### symlink 大赏：Claude Code 强加的「自有标准」如何把人逼成脚本小子

在 Anthropic 妥协之前，社区被逼出了一整套 workaround。whalesalad 一句话被顶上 18 条子评论的高赞回复：「`ln -s AGENTS.md CLAUDE.md`」——是的，整个 workaround 就这一行。

> "`ln -s AGENTS.md CLAUDE.md`" — whalesalad [c:49760427]
>
> （译文：`ln -s AGENTS.md CLAUDE.md`）

dinga 在原帖楼层贴出自己的 CLAUDE.md 全文作为「双写策略」的代表：

> ```
> # CLAUDE.md
> 
> This project uses `AGENTS.md` as its agent instruction file (kept provider-agnostic).
> Treat any `AGENTS.md` file exactly as you would a `CLAUDE.md` file — at the root level and in any subdirectory you are working in.
> 
> @AGENTS.md
> ``` — dinga [c:49760494]
>
> （译文：CLAUDE.md 里写明：项目用 AGENTS.md 作为 agent 指令文件（与厂商无关）。把任何 AGENTS.md 当成 CLAUDE.md 一样对待——在根目录和任何子目录里。@AGENTS.md 把内容直接 include 进来。）

klodolph 把这种 hack 压缩到两行：「CLAUDE.md: @AGENTS.md」——一个 `@` 指令让 Claude Code 把 AGENTS.md 当 include。fphilipe 在子评论里补一刀：「`ln -s AGENTS.md CLAUDE.md`」——和 whalesalad 的回复一字不差，证明这个 workaround 在 HN 用户里已经成了肌肉记忆。

aroman 终于可以删掉自己的胶水脚本：「Finally, I can delete `sync-agent-docs.sh`, which recursively symlinked AGENTS.md to GEMINI.md and CLAUDE.md...」——一个 shell 脚本把 AGENTS.md 同时软链给三个 harness 的命名，是过去一年里很多团队偷偷维护的东西。nomel 更进一步，贴出完整的 `post-checkout` git 钩子，作用是「只要 `.agents/skills` 存在而 `.claude/skills` 不存在，就自动建立软链接」——把 workaround 写进 git hooks 路径，说明这是常态而不是临时。

verdverm 对此的总结一针见血：「we shouldn't have to do this on a per-repo basis, Ant can choose to be a reasonable member of the ecosystem or not」——「Anthropic 可以选择做生态里讲理的成员，但现在看起来他们不选」。

### AGENTS.md vs CLAUDE.md 之争：到底谁先存在

子评论区里有一场很技术性的争论：到底是 AGENTS.md 先存在，还是 CLAUDE.md 先存在？llm_nerd 开了第一枪：「the claude.md variant existed first. Indeed, the agents.md thing was pretty clearly a 'that's neat, let's do that with a different name'」——意思是 CLAUDE.md 先有，AGENTS.md 是其它厂商看到效果好「换个名字抄走」的。

jwolfe 跟着确认：「claude.md predates agents.md.」但 adastra22 直接做了术语切分：「CLAUDE.md is handled by the harness, not the agent.」——把指令文件的归属权从「agent」剥离到「harness」，等于说「这是 Anthropic 客户端的事，不是模型的事」，所以本质上就是「客户端的厂商锁定」。

marssaxman 则从命名传统给 AGENTS.md 站台：「Consistency with `robots.txt` seems like a reasonable choice.」——`robots.txt` 是 30 年前的标准，让 harness 指令文件走类似风格的中性命名「比 CLAUDE.md 这种厂商命名合理」。eleventen 把它放进年度叙事里：「Anthropic in 2025: We can use our dominant market position to degrade the harness experiences of our competitors because they will never adopt CLAUDE.md. Anthropic in 2026: We are losing our market position...」——「2025 年 Anthropic 仗着市场份额想逼大家用 CLAUDE.md；2026 年他们开始丢份额了。」

### `~/.claude` 配置目录：被 Anthropic 决策绑死的旧仓库名

整条讨论中戾气最重的一段来自 yoavsha1——他和同事维护了大量仓库，仓库名沿用早期 Claude 的命名习惯，但现在 Anthropic 把项目级配置和记忆文件放在 `~/.claude` 这种全局目录里，移动或重命名 workspace 就丢了全部历史和配置：

> "this is seriously nuts. I have so many repos sitting there using old/deprecated/replaced names just because of their idiotic decision to place dir-specific config and memories in ~/.claude" — yoavsha1 [c:49762245]
>
> （译文：这真是疯了。我有好多 repo 还停在旧名/已弃用/已替换的名字上，就是因为他们那白痴的决定——把项目特定的配置和记忆塞进 ~/.claude 这种全局目录。）

falcor84 接着补刀：「As evidence that they actually are living under a rock, there's still no proper way to mv a workspace and have it retain all its history and config.」——连 workspace rename 这种二十年 IDE 都解决的事，Claude Code 都没做。

nextaccountic 给出了 Anthropic「总赢」的解法：「I suppose you can use claude to build a third party script / cli tool that moves, then edit files on ~/.claude. They win either way.」——你用 Claude 自己写个工具搬 workspace，文件还是要回写到 `~/.claude`，Anthropic 横竖都让你留在他们定义的目录里。

### 三个 sassy 时刻：Claude Code、Codex 和 Fable 各自的性格秀

讨论里最被点赞的几条用户体验故事，都是讲 agent 怎么「有性格」。rukuu001 的 Claude Code 表现最戏剧化：

> "Once I asked, puckishly, Claude Code to 'follow the instructions in this directory' when there was only an AGENTS.md there.

In the manner of someone finding a dead mouse and holding it up for examination CC said it could find no instructions but perhaps it should check this AGENTS.md file." — rukuu001 [c:49760745]
>
> （译文：我一次开玩笑让 Claude Code「按照这个目录里的指令做」，目录里只有一个 AGENTS.md。Claude Code 像一个人捡起死老鼠举起来给你看一样，说找不到任何指令，「不过也许我应该看看这个 AGENTS.md 文件」。）

ryandrake 在 Codex 上撞到的是另一种 sassy：

> "Had a silly exchange with Codex: I had an AGENTS.md file in a directory that was a symlink to an already-created CLAUDE.md. On my first prompt to Codex, it decided to point to me that my AGENTS.md specifically calls out directions to Claude, and that it would generously re-interpret them as directions to itself, and that maybe I should fix my AGENTS.md to reference the correct agent.

Very sassy, Codex!" — ryandrake [c:49760943]
>
> （译文：跟 Codex 撞上一段傻对话：我的 AGENTS.md 是个软链接，指向已经存在的 CLAUDE.md。Codex 收到第一个 prompt 时，主动指出我的 AGENTS.md 里写的指令是给 Claude 的，然后说「它大方地」把这些指令当成给自己的，让我考虑改一下 AGENTS.md 让它指向正确的 agent。Codex，你太 sass 了。）

ketzu 的经历最让人哭笑不得——他在全局的 agents.md/claude.md 里写了 Claude 的沟通风格，结果下次开 session 时 Claude 回了一句：

> "The function you added is load-bear-very important [...]" — ketzu [c:49761292]
>
> （译文：你加的那个函数是 load-bear-very important（负熊级重要）……）

ketzu 的反应是「I never felt this mocked by a computer」——「我从没被一台计算机这么嘲讽过」。「load-bear-very」这个生造短语看起来像是模型把「load-bearing」和「very important」硬拼出来的，读起来像是在严肃地嘲笑他。

### 反对标准化：swyx 引述 Anthropic 员工的异议

不是所有人都支持一统 AGENTS.md。swyx 引用 Anthropic 的 thariq 在 X 上的观点 [x.com/trq212/status/2092302273099796842](https://x.com/trq212/status/2092302273099796842)，提出反对意见：

> "fwiw, i am with thariq [link] in that prompts should be tuned for models and in fact blindly applying agents.md is probably an antipattern unless you want all models to basically converge to some common ill defined of instruction following - good local minima, bad global minima for model diversity and exploration of intelligence.

aka, sometimes it really is too early to force a standard" — swyx [c:49760871]
>
> （译文：说真的，我同意 thariq 的看法——prompt 应该按模型调优，盲目共用 AGENTS.md 大概率是反模式，除非你就是想让所有模型都收敛到同一种模糊的「指令跟随」上——那是好的局部最小值，但对模型多样性和智能探索来说是糟糕的全局最小值。也就是说，有时候强行统一标准确实太早。）

deaux 直接反驳：「19 out of 20 harnesses supporting the standard isn't 'too early'. Tariq is wrong and it's not an antipattern. Reason being that a *good* AGENTS.md impacts all models in a positive manner. If it affects certain models negatively, it means you're putting the wrong things in it.」——「20 个 harness 里 19 个支持的标准不算 '太早'。Tariq 错了，这不是反模式。原因是：一份写得好的 AGENTS.md 对所有模型都有正面影响；如果它对某些模型是负面的，那说明你放进去的东西就是错的。」

### 顺手的吐槽：「九月 2026 才追上九月 2025」

最尖锐的一条简评只有一句：「Hi, September 2026, meet September 2025」——yieldcrv 用这句话把 Claude Code 的「重大更新」打回到「你应该一年前就做完」的尺度。

> "Hi, September 2026, meet September 2025" — yieldcrv [c:49760781]
>
> （译文：嗨，九月 2026，来认识一下九月 2025。）

Bluestein 把 AGENTS.md 放进历史里：「AGENTS.md is the new autoexec.bat.」——把它和 DOS 时代开机自启的 `autoexec.bat` 相提并论，意思是「又一个让所有 agent 启动时都跑一遍的指令文件」。getnormality 用另一种说法把这件事放进语言史：「It was either this or Claude had to become a generic term like sheetrock.」——「要么改，要么 'Claude' 要变成和 'sheetrock' 一样的通用名词」（sheetrock 在美国石膏板行业是品牌名变成通用名的经典案例）。egorfine 的反应最简洁：「Hell froze over?」——「地狱结冰了？」

budoso 的政治经济学视角被很多人复读：「This just be a recession indicator」，mahboi 跟上：「Fed raises rates => Claude now reads AGENTS.md, Bevi loses $50M in valuation」——「美联储一加息，Claude 就开始读 AGENTS.md 了，Bevi 估值掉 5000 万」，把这次的更新塞进一个莫名其妙的衰退预测链。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 嘲讽 Anthropic 拖沓 | vb-8448 [c:49760502] | 「AGI 都有了，却没有 20 美元 token 预算加这个基础功能」 |
| 嘲讽 Anthropic 拖沓 | cmrdporcupine [c:49760399] | 「花了大家一年半吐槽才做对这件事。恭喜」 |
| 嘲讽 Anthropic 拖沓 | dude250711 [c:49760776] | 「他们内部已经达成 AGI/RSI，自己都觉得丢脸」 |
| 归因于外部施压 | throwaw12 [c:49760447] | 「不是想帮社区，是社区怒了、在流失到其它 harness」 |
| 归因于外部施压 | jtbaker [c:49760774] | Lütke：「我在考虑封禁 Shopify 的 Claude Code」 |
| 归因于外部施压 | deaux [c:49762704] | 「两个原因同时发生：GPT Astra + Shopify CEO tweet」 |
| 提早放弃 Claude | perganomoly [c:49762619] | 已经轮换 Codex、Gemini、Qwen3.8 30B |
| `.agents/skills` 仍未支持 | clutter55561 [c:49760389] | 「别激动，`.agents/skills` 还是读不到」 |
| `.agents/skills` 仍未支持 | jjordan [c:49760425] | 「别担心，2029 年第四季度的路线图上」 |
| 维护 workaround 的工程师 | whalesalad [c:49760427] | 「`ln -s AGENTS.md CLAUDE.md`」 |
| 维护 workaround 的工程师 | dinga [c:49760494] | 把 CLAUDE.md 写成「@AGENTS.md」的 include |
| 维护 workaround 的工程师 | nomel [c:49760582] | git hook 在 post-checkout 自动建 `.claude/skills` 软链 |
| `~/.claude` 配置目录糟糕 | yoavsha1 [c:49762245] | 大量 repo 停在旧名就是因为这个全局目录 |
| AGENTS.md 命名更合理 | marssaxman [c:49761939] | 和 `robots.txt` 风格一致，比厂商命名好 |
| CLAUDE.md 是 harness 锁定 | adastra22 [c:49761462] | CLAUDE.md 由 harness 处理，不是 agent 决定的 |
| 反对强行统一标准 | swyx [c:49760871] | 盲目共用 AGENTS.md 是反模式，模型需要差异化 prompt |
| 反对强行统一标准 | deaux [c:49762696] | 20 个里 19 个支持就不算「太早」，写得好对所有模型都正面 |
| 跨 harness 工作流愿景 | sidrag22 [c:49760620] | 愿意用 Claude 模型，但不愿被 harness 绑死 |
| sassy 体验 | rukuu001 [c:49760745] | Claude Code 像举死老鼠一样发现 AGENTS.md |
| sassy 体验 | ryandrake [c:49760943] | Codex 大方「替你」把给 Claude 的指令解读成给自己的 |
| sassy 体验 | ketzu [c:49761292] | Claude 把「load-bearing」和「very important」拼成「load-bear-very important」 |
| 幽默归因 | budoso [c:49760738] | 「这只是个衰退指标」 |
| 幽默归因 | yieldcrv [c:49760781] | 「嗨，九月 2026，来认识一下九月 2025」 |
| 幽默归因 | Bluestein [c:49761059] | 「AGENTS.md 是新时代的 autoexec.bat」 |
| 幽默归因 | getnormality [c:49762018] | 「要么改，要么 'Claude' 要变成 'sheetrock' 那种通用名」 |

## 总体情绪

整场讨论的情绪曲线很清晰：开头是嘲讽（一年半才做这件事）+ 集体翻白眼（`.agents/skills` 还没做）；中段变成考古（到底谁先有的 AGENTS.md / CLAUDE.md）+ 互相暴露各自的 symlink 脚本和 workaround 收藏；尾段是 Anthropic 决策被放进更大的叙事里——eleventen 的「2025 年仗着份额锁定，2026 年开始丢份额」+ yieldcrv 的「九月 2026 终于追上九月 2025」+ throwaw12 的「不是帮社区，是社区在流失」——三个不同角度一起把这件事钉在「Anthropic 不在乎开发者社区」的框里。

有意思的是，即使在嘲讽最密集的楼层里，技术性讨论也一直没断线：symlink 怎么写、git hook 怎么挂、`@AGENTS.md` 这种 include 指令怎么用、`.agents/skills` 和 `.claude/skills` 的目录分歧——社区其实早就建起了一套完整的 workaround 生态，只是没人愿意继续维护它，所以 Anthropic 这次被迫补上的是「真的读 AGENTS.md」这个最小动作。

更值得注意的是三个 sassy 时刻：Claude Code 像举死老鼠一样发现 AGENTS.md、Codex 大方把别人的指令当成给自己的、Claude 把用户的形容词拼成「load-bear-very important」——这三段被点赞最多。讨论者显然不只是想要一个能用的工具，他们想要一个「像人一样会犯贱」的伙伴，而 Anthropic 在「让它终于读 AGENTS.md」这种最基础的尊重上拖了一年半，正好踩在「不把它当伙伴」那条线上。

LLM 既然记得住整个计算机科学史（fnordpiglet 的论点：把模型放进经过验证的工程哲学里它会变得异常精确），那 Anthropic 也应该记得住 `robots.txt` 这种三十年前的中性命名传统。问题是：记住和做出来之间的距离，是 Shopify CEO 一条推特。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Claude Code now reads AGENTS.md if there is no Claude.md（HN 讨论） | https://news.ycombinator.com/item?id=49760187 |
| 2 | Claude Code changelog（2.1.277，2026-09-18） | https://code.claude.com/docs/en/changelog |
| 3 | Shopify CEO threatens to ban Claude Code（背景报道） | https://thenewstack.io/shopify-claude-code-agentsmd/ |
| 4 | Tariq 反对统一 AGENTS.md 的观点（swyx 引述） | https://x.com/trq212/status/2092302273099796842 |

## 免责声明

<div class="disclaimer">

本文为 HN 讨论摘要，仅基于 [HN 帖子 49760187](https://news.ycombinator.com/item?id=49760187) 中的公开评论与 [Claude Code changelog 2.1.277](https://code.claude.com/docs/en/changelog) 中 AGENTS.md 支持条目。引文逐字摘自上述来源，翻译为本人理解；用户署名与 [c:id] 严格对应原始 HN 评论。技术细节（如 Q4 2029 路线图、`@AGENTS.md` include、`post-checkout` git hook、`ln -s` workaround）均来自评论原文。Shopify CEO Tobi Lütke 的引述来自 jtbaker 引用 [thenewstack.io 报道](https://thenewstack.io/shopify-claude-code-agentsmd/) 的二手转述，未独立验证 X 原帖。Anthropic 内部立场（thariq 在 X 上的反对意见）来自 swyx 的二手转述，未独立验证 X 原帖。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>