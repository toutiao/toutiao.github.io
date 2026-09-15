---
layout: post
title: >-
  Claude Fable 5.1 解开 370 年古密码 — HN 集体发现「给 AI 鼓劲」意外有效
date: 2026-09-15
categories: [articles]
excerpt: >-
  Fable 5.1 用 44 分钟、17.6 万 token 解出 Sir Thomas Urquhart 留下的 Cyphral Distich。HN 评论区里没人细究密码学，反而集体跑题去争论「对 AI 说『你能行』到底有没有用」。
tagline: >-
  答案不在密码学里，在那本书里——前人漏掉的不是技术，是读书。
---

## 原文概要

8 月 31 日，AI 评测机构 Vals AI 的 Geby Jaff 在博客发文，宣布用 Claude Fable 5.1 解开了苏格兰作家 Sir Thomas Urquhart 在《Logopandecteision》（1653）末尾留下的一道 370 年未解的密码——Cyphral Distich。

密码本身就是两行共 64 个数字：  
`5.3.27.38.32.14.21.8.66.8.70.39.5.9.12.18.2.3.56.5.1.7.3.2.13.19.3.25.9.3.16.6.`  
`25.15.13.6.11.20.5.1.2.12.1.20.20.49.20.20.35.33.4.6.8.35.5.33.5.5.18.10.3.11.32.42.`  
这道题 1899 年在《Notes and Queries》上以公开问题形式抛出，20 世纪又出现在多本密码学文献里，长期被列入密码史研究者 Klaus Schmeh 的「未解 Top 50」。

历史上的人类破解者大多尝试频率分析、替换密码、同音替换——全都失败。Fable 5.1 的解法只有两步核心洞察：  
第一，Urquhart 在密码之前有 32 段 Proquiritations，并反复强调「32」这个数字；第二，每段 Proquiritation 都以「是……的愿望」「希望」之类的话结尾。  
把这两条线索并起来，规则呼之欲出——密码里第 i 个数字指向第 i 段 Proquiritation 中那个位置的词，取首字母。

明文是：  
`O GOD UPHOLD KING CHARLS THE SECOND AND`  
`MAKE HIM THE SUPREME RULER OF THIS LAND`

这是一首 32 字母、两行押韵的短诗（distich），藏着一句为查理二世祈祷的保皇派口号——与 Urquhart 的政治立场完全吻合。Fable 5.1 用了 44 分钟、17.6 万 token 解出，无人工干预。同一思路接着套到 Urquhart 在《The Jewel》（1652）留下的更大版本——285 个数字的 Cyphral Octastich——解出 275 个位置的明文，剩余 9 个字母仍需物理原书核对。

Jaff 强调，这并非密码学奇迹，答案本身就是「明摆着的」。他列了两条筛选原则：避开已解或能无限套答案的题，也避开 CIA 那种几千人啃过的问题。他告诉 Fable「你做过更难的事」，Fable 自己识别到「这道题的线索异常直接」，然后一锤定音。

帖子在 HN 热门榜（/best）冲到 1180 分，529 条评论。但评论区没几个人继续讨论密码学本身——大部分跑题去争论一个更尴尬的问题：他们也在给 AI 鼓劲吗？

## 讨论焦点

### 「激励式提示」真的有用，而且不只是迷信

Jaff 在文章里写了这样一句：「我告诉它看看 Fable 最厉害的成就，尤其是它解过的数学题，跟它说这种问题对你来说应该很简单。」这条操作细节被评论区反复拎出来。一位用户看完之后先愣住：

> "Wait. Wait wait wait. Are we supposed to be giving them pep talks?" — flir [c:49689186]
>
> （等等。等等等等。我们现在是要给它们鼓劲吗？）

听起来很傻，但讨论下去反而有了合理解释。另一位用户指出：现代 AI 的元认知（metaknowledge）能力很有限——它不知道自己能力的边界在哪里，结果就会出现在「能做」的任务面前退缩的情况。

> "Modern AIs have very limited metaknowledge - they don't know exactly where the limits of their capabilities lie. So you can get things like 'a task is doable for an AI, but the AI thinks it's impossible, so it doesn't try hard enough'." — ACCount37 [c:49689866]
>
> （现代 AI 的元认知非常有限——它不知道自己的边界在哪。于是会出现「这题 AI 能做，但 AI 觉得不可能，就不去努力」的情况。）

这并不是给 AI「加油」就完事的玄学。上下文窗口里塞进「这种问题 AI 已经解过」之类的句子，会改变接下来输出的统计分布——「这太难了做不了」这类延续被打折，更可能走上「试试这个方向」的延续。和它是否「感受到」鼓励没关系，是 token 级别的统计现象。另一位用户更直接：

> "If we filter out the pep tone, it is doing something useful: framing. Problem framing will always be important." — Nevermark [c:49692664]
>
> （剥掉那层「鼓劲」外壳，它实际做的事叫「框定问题」。问题框定永远重要。）

把这句话对照 Jaff 的实际操作就懂了：他不是单纯说「加油」，而是先给定方向（解未解密码、避开已解的）、再给定预期（「比那些数学题简单」）、最后给定许可（「你可以创造性思考」）。这是 prompt engineering 的老把戏，但被「对 AI 鼓劲」这种说法包装出来，反而显得像新现象。

### 「370 年无解」的真正瓶颈：人类注意力

Fable 的解法让一位用户想起自己压了十年的业余项目——19 世纪初爱尔兰「未登记」正式园林的位置考据。

> "I often find myself swinging between 'It's so over' and 'We're so back' - some days I roll out of bed thinking I could have Claude solve some random unproven OEIS sequence before breakfast; other days, I wake up in a cold sweat worried about the fate of humanity and what the world might look like in a decade." — redfloatplane [c:49689080]
>
> （我经常在「彻底完了」和「我们回来了」之间来回摆——有时候我起床觉得可以让 Claude 早饭前帮我解一条未证 OEIS；有时候又在冷汗里醒来，担心十年后世界会是什么样。）

他用了一个周末，让 Claude 写出工具来手动标注几十块历史地图瓦片，再跑 CV 模型处理剩下的瓦片。这本来是一项历史学家不会做的事——数据录入太枯燥，回报太小。GPT 把这种任务从「不可行」降级到「有点烦」，做完之后他学到了几件以前不知道的事。

顺着这条线，评论区把「370 年无解」重新解读：不是密码学难，是这道题从未被认真盯着看过。历代破解者花几小时、几天试几个想法就放弃，是因为没有 17.6 万 token 的耐心。试错成本被打到零之后，那些原本「乏人问津」的题目会被批量重做——历史悬案、遗忘的猜想、档案学冷门谜题全部暴露在 AI 的火力之下。

### 「Fable 你倒是把话说人话啊」——主线之外的支线

帖子的真正主线在密码，评论区的真正主线在吐槽。一位用户贴出 Astra 的回复原文：

> "Astra told me yesterday: > The run baseline was captured without a physical MAC; the current device is not durably bound to it. > Engineering mode confirmation is the ESPHome component read-back; the LD2410 UART acknowledgement is not observed, so this is not proof the radar itself applied the sensitivity change. No clue what the fuck any of it means." — stavros [c:49689584]
>
> （Astra 昨天跟我说：「运行基线是在没有物理 MAC 的情况下捕获的；当前设备并未持久绑定到该基线。工程模式确认来自 ESPHome 组件回读；LD2410 UART 应答未被观测，因此不能证明雷达本身已应用灵敏度变更。」这他妈到底在说什么。）

这条吐槽下面延展出一整片「Fable/Opus 5+ 行话症」专题：模型越来越倾向于甩出含混、堆砌术语的英文，读起来要花三倍时间。一位用户试着让 Fable「再解释一遍，简单点」，得到的还是同样的术语堆。

> "Sometimes when I get frustrated reading Opus/Fable 5+ output I pause my rage out briefly to wonder if it's because I'm just too dumb for the model or if the model is just terrible at English." — baron3dl [c:49689870]
>
> （每次读到 Opus/Fable 5+ 的输出气到不行，我会停下来冷静一下——是我太笨配不上这个模型，还是这个模型英语本来就很烂。）

症状被多人确认：甚至有用户开了个 GitHub 仓库 `claudish-to-english`，专门把 Opus 输出转给本地模型「翻译」成正常人话。另一位用户的解法更朴素——他手动把 Claude 的 `/* 注释 */` 粘到 ChatGPT 里说「精简一下」。

这条支线之所以和 Fable 解密码的故事同框，是因为发帖人 Jaff 自己也用了 Claude「做完整研究」——Fable 既能在密码学里写出完美的逻辑链，也能在解释一件简单事时把读者埋进 jargon 堆。同一个能力光谱，两端都能跑。

### 验证还在门外：物理原书缺失，9 个字母悬而未决

Jaff 在文章末尾写了三个词：「Caveats, stated plainly」（说明白点，注意事项如下）。一位用户对这三个词产生了「内脏反应」：

> "'Caveats, stated plainly'. You should have seen the discussion of this on the Schneier blog a few days ago. Someone had their agent check the solution, presumably it emailed a librarian to check that it was correct for the original edition. Then their comments read like 'The BL/EEBO witness lacks it, so the discrepancy is copy-specific, not a disproof of the cipher.' and 'A complete 285-coordinate physical replication is still pending.' arghhhhh" — elahieh [c:49689444]
>
> （「说明白点，注意事项如下」。你应该看看几天前 Schneier 博客上关于这件事的讨论。某人让 agent 去验证解法，大概是给图书管理员发了邮件核对原版。然后评论里写着「大英图书馆/EEBO 副本缺这一段，所以差异是副本特有的，不是对密码的证伪」「285 个坐标的完整物理复现仍未完成」。唉。）

Schneier 那边的讨论稍微冷静些：解法本身漂亮，但 EEBO-TCP（Early English Books Online 的转录版）副本本身就不全，关键几页或缺，9 个字母对不上到底是 Urquhart 自己写错、还是现代转录错位——必须拿到 1652 年原书或 1983 年 Jack & Lyall 编辑版才能结案。在那之前，Fable 给出的「明文」仍然是一个「极高概率正确的假说」，不是定论。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 鼓劲有用，是统计现象 | jgilias [c:49692400] | 上下文窗口里的「鼓劲」会改变后续 token 的统计分布，不是玄学。 |
| 鼓劲有用，元认知有限 | ACCount37 [c:49689866] | AI 不知道自己能做什么，「你能行」能改变它的尝试强度。 |
| 别光说「加油」，要给方向 | Nevermark [c:49692664] | 真正起作用的是「框定问题」，不是语气。 |
| 瓶颈从来不在能力 | redfloatplane [c:49689080] | Claude 解 OEIS、考据爱尔兰园林，瓶颈是注意力，不是智力。 |
| Fable/Opus 行话难读 | stavros [c:49689584] | 输出越来越像内部 jargon，「再解释一遍」也不顶用。 |
| 不是你笨，是模型烂 | baron3dl [c:49689870] | 读到 Opus 5+ 输出怀疑人生很正常，因为你没问题。 |
| 验证不能少 | elahieh [c:49689444] | Schneier 那边在等 1652 年原书或 1983 年编辑版才能定案。 |
| 答案本来就在书里 | Nevermark [c:49692664] | 简化版问题期望「大量零进展 + 一次命中」，和密码锁一样。 |
| LLM 不是简单模式匹配器 | red75prime [c:49692508] | LLM 内部是复杂系统，简单「统计延续」解释不了所有现象。 |
| 末日感每天摇摆 | genxy [c:49690143] | 「小鞋子，从未警告。这是威胁。我们得跑。」 |

## 总体情绪

评论区跑题方向出奇一致——一个关于 370 年密码的帖子，最后被讨论最多的是「给 AI 鼓劲到底有没有用」和「Fable 你为什么说话不像人」。这两条支线都不是小事：第一条意味着整个「激励式提示」的工作机制被一张新案例重新激活讨论；第二条意味着 Claude Opus 5 / Fable 5+ 在专业任务上更强了，但在「日常能用的话」上越来越远。一个有意思的对比是——用户拿 GPT 系列做日常对话、拿 Claude 做深度任务，模型市场在能力曲线上悄悄分裂出两个生态位。

更微妙的是「解出 370 年悬案」本身的分量。Jaff 强调这「不是密码学奇迹」——模型没做任何花哨的破解，它只是能读完一本 1653 年的书、读完相关密码学评论、再读完 Urquhart 的其他暗示段落，然后在 44 分钟里把每条线索交叉引用一遍。难的不是密码，是这种「读完一吨文本后还愿意再读一遍」的苦力。

Schneier 那边的谨慎是对的。物理原书没核、9 个字母未定、Schmeh 的「Top 50」还剩 49 道题。但只要「按书索字」这种解法思路被验证，Fable / Opus / Astra 这一档模型的下一步就很清楚：把所有「明摆着但没人看」的题再过一遍——OEIS 未证序列、地方志里失踪的园林、被遗忘的猜想、档案学冷门密码。人类注意力的瓶颈正在被一次性抹平。

最后一句话送给还在摇摆的人——HN 用户总结得最准：「Don't think it's worth using even if it scores 2 points higher in some bs benchmark」（哪怕它在某个狗屎 benchmark 上高 2 分，也不值得用），但同时「I find myself swinging between 'It's so over' and 'We're so back'」。同一群人，同一个帖子，得出完全相反的结论。这就是当下。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Fable 5.1 Solves the Cyphral Distich, a 370-year-old cipher | https://news.ycombinator.com/item?id=49688695 |
| 2 | Schneier on Claude Fable solves a historical cipher（外部讨论） | https://www.schneier.com/blog/archives/2026/09/claude-fable-solves-a-historical-cipher.html |
| 3 | Cyphral Distich 原文与 Octastich 同方法扩展（Vals AI 博客） | https://www.vals.ai/blogs/fable-solves-cyphral-distich |

<div class="disclaimer">
本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3<br>
引文均为 HN 评论原话，已校对。评论 ID（[c:xxxxx]）可对应到 HN 评论锚点。Cyphral Octastich 的 9 个悬空字母尚未物理核验，文中已注明。
</div>
