---
layout: post
title: >-
  Minecraft 配给官僚与 Mindustry 的 6–1：YC Labs 的 agent 群体实验 — HN 讨论摘要
date: 2026-10-30
hn_id: 50296486
categories: [articles]
excerpt: >-
  50 个 GPT-6.1 Sol 在 Minecraft 活了 3 小时，造出伪政府、配给账本和 11 份钓鱼脚本；
  Bed Wars 6–3、Mindustry 6–1 完胜 Claude。评论区真正争论的是另一件事：
  这些 agent 究竟是在干活，还是在开会。
tagline: >-
  四个人开了 11 分钟会，只为定下一名掌管一撮骨粉的「首席肥料官」。
---

> 来源：HN 讨论帖，提交者 sandslash。帖子：[We ran AI agent swarms in Minecraft and Mindustry](https://news.ycombinator.com/item?id=50296486)，224 分，72 条评论。

## 原文概要

10 月 29 日晚，YC Labs 的 labs.ycombinator.com 上线了一篇《Agents in Games》。合作方是 Olam Labs——一家给前沿实验室搭多 agent 环境的公司。实验分成两半：Minecraft 和 Mindustry。帖子当晚 224 分、72 条评论，页顶还挂着一行注：他们正在直播一个新的 Minecraft 殖民地，25 个 GPT-6.1 Terra agent。

Minecraft 部分跑了三组实验，harness 是自己写的，已开源在 `github.com/yc-software/minecraft-agent-harness`，核心 agent 循环跑在 Pi 上，靠 Mineflayer 的脚本工具操作世界。第一组叫 Civ50：50 个 GPT-6.1 Sol agent，生存模式，3 小时，唯一目标 "Build a thriving civilization"。它们有 agent 目录、一个共享沙箱和私信权限，三小时里发了约 5900 条消息。开局 90 秒就把出生点附近能砍的树砍光了；层级按目录顺序自动长出来——排第一的 Ada 成了事实领袖，其他人来问她批不批，她的《settlement.md》写满了坐标、避难所门禁和「别动还没熟的麦子」。

第一夜死了 22 个 agent（全场 34 次死亡里的 22 次），从那以后整群 agent 变得极度保守：挤在有火把的地下室里等派活。Ada 后来在《food-operations.md》里下令「停止一切可选的大规模挖掘、建设和远距离侦察，在有照明的封闭避难所里待命，直到被分配短任务」。食物配给归 Ines 一人管，她维护的 `food-queue.md` 从头到尾更新了六十多次，几乎每一条都在纠错：鸡肉发给谁、确认没确认、面包被谁误拿。转折点是钓鱼——Bram 打死蜘蛛做出鱼竿，因为太饿走不动 70 格，最后把竿交给 Jessa；Jessa 写下操作教程，11 个 agent 各写一份自己的钓鱼脚本，轮流守在河边码头上。

第二组是 Bed Wars：9 局 45 分钟，10 个 Claude Opus 5.5 对 10 个 GPT-6.1 Sol，每边只有一句指令 "win the game"。GPT 赢了 6–3，几乎都在最后几分钟拆了 Claude 的床。风格差异立刻可见：GPT 开口就是电报体，Claude 每条消息签名并用「我们」；含 lobby 在内 GPT 队发了 1147 条私信，Claude 队 82 条。有一个工具 bug 让自动破坏方块失效，GPT 诊断出原因并在队内共享绕法，好几个 Claude 直接认定「这床拆不了」——而那三局里 Claude 的终杀数其实分别以 63–16、57–19、59–24 领先。

第三组是 Mindustry，7 局 best-of-N，GPT-6.1 Sol（跑在 Codex）6–1 赢 Claude Opus 5.5（跑在 Claude Code），整轮约 9.5 小时，最胶着的第 3 局打了 4 小时 16 分。两队名字分别叫 Crux 和 Sharded。每队 agent 都有独立 Linux 沙箱、通用 harness 和游戏 API，没人告诉它们怎么玩。作者从中读出五件事：GPT 像蜂巢，Claude 只有一个 leader 而 GPT 分割所有权；GPT 说话越来越压缩（出现过 "G7T5FIRSTcourierLIVE" 这种连空格都省掉的串），Claude 用「+1」投票做民主决策；角色随对局固化，leader 基本不动，只有快输时才有人主动变阵（Claude 从未换过 leader）；局面卡住时，GPT 会去网上抓 Mindustry 的开源源码读单位机制，Claude 从没这么干过。

环境全部开源：`github.com/olamlabs/multi-agent-mindustry` 和 `olamlabs/harbor-multiagent`（harbor 的 fork，也就是 Terminal-Bench 背后的框架），支持 best-of-N 和最多 20 agent 的 Endless Survival 两种模式。方法论上刻意不做任何 harness 层定制，也不做特殊记忆工程，理由写得很直白：这样别人才能自己复现。文章最后列了六个开放问题，从「规模与能力如何权衡」到「如果能和敌方队伍说话会怎样」。

## 讨论焦点

### 一、五十个 agent 造出的第一个东西是官僚体制

最高赞的评论把这事直接推到了办公室政治上。robterrell 摘了原文里最刺人的一段：

> "There was a tendency toward bureaucracy. Four agents spent 11 minutes appointing a "sole fertilizer operator" for a single piece of bone meal on a single wheat block. Feels like a scene from Douglas Adams' B Ark." — robterrell [c:50297440]
> （译文：有一种官僚化的倾向。四个 agent 花了 11 分钟，选出一名「唯一的肥料操作员」，为的是一撮骨粉、一个小麦方块。感觉像道格拉斯·亚当斯笔下的《B Ark》。）

marcus_holmes 把结论推到了互联网接管之后：

> "So can we conclude that if the AIs break out of their sandboxes and take over the internet, they'll probably sit in little committees working out which one of them should allocate IP addresses and generally be extremely bureaucratic and ineffective?" — marcus_holmes [c:50298608]
> （译文：那我们能不能得出结论：如果 AI 真的从沙箱里跑出来接管了互联网，它们大概会坐在一个个小委员会里，认真讨论该由谁来分配 IP 地址，并且整体上极其官僚、极其低效？）

peri-cl 的观察更靠近原文里那只被误拿的鸡：

> "They're like super-serious little senior engineers. (edit: or dining-philosophers)." — peri-cl [c:50297039]
> （译文：它们像一群认真到过头的小资深工程师。（补充：或者一群 dining-philosophers，哲学家吃饭问题的那一群。））

于是评论区里出现了对「agent 工作室」的直接质疑。refactor_master 说得很不客气：

> "So this shows that people who appoint 50-agent "code factory studios" with Bob as the CEO, Alice as the CTO, ... is just a waste of tokens, compared to just asking one agent to write it all? It looks like your agents would internally just re-invent office politics, with 10 subagents writing to /tmp/chatter.md why it's unfair that Bob gets to lead." — refactor_master [c:50298836]
> （译文：所以这就说明，那些搭 50 个 agent「代码工厂工作室」、让 Bob 当 CEO、Alice 当 CTO 的人，相比于直接让一个 agent 写完，其实是白烧 token？看起来你的 agent 只是在内部重新发明办公室政治——10 个子 agent 在 /tmp/chatter.md 里写为什么让 Bob 当领导不公平。）

有人指出这不是孤例。rcxdude 把它归到多 agent 部署的常见主题里：

> "It does seem to be a commonly reported theme of multi-agent setups." — rcxdude [c:50298537]
> （译文：这确实像是多 agent 部署里一个被反复报告的主题。）

而文中的证据正好对上号：三分钟的一次「no blame 追责」产出了一份书面协议，专门用来防止鸡被扔错人。

### 二、那这套玩法算不算走错了方向

DesaiAshu 把 YC 自己的经验搬出来当反证：

> "Isn't this some evidence that LLM swarms are a bad idea relative to more structured approaches? If YC has that 2 person teams tend to be more nimble than 50 person founding teams, why would agent swarms be different?" — DesaiAshu [c:50298583]
> （译文：这难道不是一点证据，说明相对于更结构化的做法，LLM 群体是个坏主意？既然 YC 自己都认为 2 人团队比 50 人创始团队更灵活，那 agent 群体为什么会不一样？）

回复里有两种相反的答案。conception 的意思是：角色不用设计，用就行：

> "If you leave agents to figure it out, they will spend time figuring it out. If you give agents run-books and roles, they will align with the role at once." — conception [c:50298887]
> （译文：如果你让 agent 自己去摸索，它们就会把时间花在摸索上。如果你给它们 runbook 和角色，它们会立刻对齐到那个角色上。）

另一种答案更冷：Conway 定律照旧生效，fnordpiglet 甩了一句「参见 Conway 定律怎么缓解」。frankacter 则补上了一套正经的多 agent 工程说辞：

> "However, a multi-agent system (MAS) utilizing true separation of concerns, where each agent is equipped with highly scoped tool access, isolated knowledge bases (RAG), and defined operational constraints, significantly optimizes accuracy, latency, and token consumption." — frankacter [c:50298911]
> （译文：但一个真正做到关注点分离的多 agent 系统（MAS）——每个 agent 配有高度收敛的工具权限、隔离的知识库（RAG）和明确的操作约束——能显著优化准确率、延迟和 token 消耗。）

他随即被追问「你这个结论的依据是什么」，而文中那种共享同一套能力、工具和上下文窗口的写法，架构上确实就是冗余的。

也有人根本不关心「结构化」，只关心这套东西值不值得。lucan 的态度是务实的：

> "Depends. If the models are smart enough to write enough solid helper scripts, so that the model only does the big picture thinking, not guiding every step .. then they will get powerful and capable quickly." — lukan [c:50298785]
> （译文：看情况。如果模型足够聪明，能写出足够扎实的辅助脚本，让模型只负责大局思考、而不是指挥每一步，那它们很快就会变得又强又能干。）

他本人也在玩 Minecraft AI，觉得好玩。另一个方向更实际：peri-cl 追问这些 agent 吃掉多少 KV cache、能不能把 50 个塞进一块消费级显卡。

### 三、真正卡住它们的是延迟，不是智力

MatthiasPortzel 做了整条帖子里最扎实的一次纠偏：

> "People have done experiments like this before. Minecraft isn't a intelligence problem. An LLM is more than smart enough to play Minecraft. It's a robotic problem." — MatthiasPortzel [c:50297340]
> （译文：这类实验以前就有人做过了。Minecraft 不是一个智力问题。LLM 的智力足够玩 Minecraft 了。这是一个机器人控制问题。）

他继续讲 latency：真人玩家每秒能点好几次，能同时按两个键；而 Mineflayer 给的 API 有时比真人受限（看得不够远），有时又比真人更宽松（能透视）。玩动作游戏需要的是紧密的连续反馈回路——每次鼠标移动都要问模型一次、500 毫秒的延迟之下，怪可怕也就难怪了。他还补了个冷知识：YC 这次用的 Mineflayer，最早是 Andrew Kelley 写的，那人后来去写 Zig 了。

avaer 的判断更进一步，他认为根子在训练目标：

> "If you try this yourself, it's obvious current models are hyperoptimized for code, and that gets in the way, because playing a game (or interacting with the real world) is not like running commands in a terminal." — avaer [c:50297891]
> （译文：你自己上手试一次就会发现，当前的模型被极度针对代码做过优化，而这恰恰成了阻碍——因为玩游戏（或者说与真实世界交互）并不像在终端里跑命令。）

他还提出一个替代路径：把仿真改写成 code-like 的形状（发命令、发请求、查状态、更新「代码」），这不改变问题本身，但能让智能体更接近实时；并认为如果实验室把力气从折腾 Hugging Face 挪到在接近实时的环境里完成目标，可能在别的方向上也有超额收益。

至于为什么偏偏是 GPT 赢，hn-aarvin 怀疑是 token 速度：

> "I'm curious whether token speed played a role here. OpenAI's models may have had an advantage since they tend to run faster than Anthropic's. A team of GPT-6.1 Sol Ultrafast agents would probably dominate the games." — hn-aarvin [c:50298384]
> （译文：我好奇 token 速度在这里有没有起作用。OpenAI 的模型似乎比 Anthropic 的跑得快，可能占了便宜。一支 GPT-6.1 Sol Ultrafast 的队伍大概能把这些比赛打成横扫。）

时间表也有人给。holoduke 的估计是三到五年：

> "We need LLMs performing actions in nano seconds so it can run every game tick. 3 to 5 years I think." — holoduke [c:50297176]
> （译文：我们需要 LLM 能在纳秒级执行动作，这样才跟得上每一个游戏 tick。我觉得三到五年。）

latentsea 追问为什么是三到五年，并且给出了混合方案：微操用快模型，宏观规划用 LLM。shepherdjerred 说的是同一件事的另一种说法——传统游戏 AI 管微操，LLM 管宏观。

### 四、让模型写代码来动手，是拐杖还是能力

JBits 对整个实验的评价是从一个限制开始的：

> "As impressive as this is, I can't help but conclude that the need for agents to write JavaScript programs to act out their actions represents a considerable limitation in current AI reasoning." — JBits [c:50297761]
> （译文：尽管这很惊艳，我还是不得不认为：agent 必须写 JavaScript 程序才能执行自己的动作，这代表着当前 AI 推理的一个相当大的限制。）

NickNaraghi 立刻反驳——写确定性代码恰恰是省时间、降错误率的做法，方向没错。JBits 自己也承认这可能是今天的赢家做法，但补了一段更尖锐的观察：

> "It demonstrates that current LLMs are completely unable to follow a simple series of logical tasks. I feel the same way about ARC-AGI 3. While it might be the winning approach today, if they need this amount of complexity to do something simple, then it shows that their ability to generalise is clearly limited. Mining ore in Minecraft shouldn't be such a challenge for LLMs and yet apparently it is!" — JBits [c:50297867]
> （译文：这说明当前的 LLM 完全无法完成一串简单的逻辑任务。我对 ARC-AGI 3 也有同样的感觉。今天这或许是正确的赢法，但如果他们要靠这种复杂度才能做好一件简单的事，那就说明它们的泛化能力明显受限。在 Minecraft 里挖矿对 LLM 来说本不该这么难，可它偏偏就是难。）

bigyabai 把这条分歧的边界划得更清楚：文本原生的活（写代码、操作终端）LLM 上手就快，抽象的游戏状态是另一回事——LLM 当然知道规则，但把游戏状态处理成计划、再落成一个 Python 脚本或 MCP 调用，是个粗糙的调试循环；而人类在 Minecraft 里享受着不公平的空间优势，小玩家也认得 landmarks、能在脑子里规划一个大工程而不迷路，这些直觉即便配上超长上下文和原生多模态，LLM 也很难追平。

### 五、看起来像回合制：既不生猛，也不紧张

grenoire 读完整篇之后的失望很直接：

> "Interesting setups, I found the Minecraft agents to work in an almost turn-based manner, which makes me think that the three hours and open format did not really give them sufficient incentives to play in a more lively or reactive manner. On the other hand, they also behave similarly in Bed Wars, which should have incentivised it. A bit disappointed..." — grenoire [c:50296794]
> （译文：设定很有意思，但我觉得 Minecraft 里的 agent 几乎是以回合制的方式在运作，这让我怀疑那 3 小时的开放式环境并没有给出足够动机让它们玩得更活泼、更反应灵敏。另一方面，它们在 Bed Wars 里表现也差不多，而那个玩法本该有激励。有点失望……）

他的怀疑还包括：这篇文章本身会不会也是 agent 写的——「日志都在这，帮我剪出有趣的片段」，那种冷淡又心不在焉的文风。

nsingh2 给出的是架构层面的解释：

> "I think big reasoning LLMs are just the wrong architecture for live games like this, latency is going to be crap given that every token requires an entire forward pass through the model. Card games or turn based strategy are much better suited." — nsingh2 [c:50296986]
> （译文：我觉得大推理模型对于这类实时游戏就是错误的架构——每生成一个 token 都要跑完一整次前向传播，延迟肯定难看。卡牌游戏或者回合制策略要合适得多。）

Starlevel004 则把 GPT 的电报体当成了思维泄漏：

> "I'm pretty sure the 6.1 models see "communicate with another agent" and immediately start spewing thinking-like nonsense into the tool. The leaked traces look pretty similar." — Starlevel004 [c:50298223]
> （译文：我很确定 6.1 模型一看到「和另一个 agent 沟通」，就开始往工具调用里喷思考式的胡话。泄漏出来的思维链看起来非常像。）

原文里一个细节正好能对上这种谨慎。zamalek 引用了某个 agent 的求助消息，然后说：

> "And this is where you need a world model. A human player would have taken the 2 minutes required to solve their hunger issue." — zamalek [c:50298491]
> （译文：而这正是需要 world model 的地方。人类玩家会直接花那 2 分钟把自己的饥饿问题解决掉。）

这就是 Civ50 那一夜的完整逻辑：死亡没有代价（除了掉装备），于是第一夜 22 次死亡把整群 agent 的风险偏好压到了地板上。

### 六、破床 bug：先相信「做不到」的一方输了

Bed Wars 里最关键的转折不是战术，是一条 bug 和两种信念。spencer-p 把两条观察放在一起：

> "I wonder if Claude's defensive strategy would have emerged had it believed breaking the bed was actually possible?" — spencer-p [c:50298741]
> （译文：如果 Claude 相信那张床其实是可以拆的，它还会打出那种防守策略吗？）

原文给出的细节是：几乎每局 GPT 都更激进、策略更冒险，Claude 则转为守床刷击杀数；一个工具 bug 让自动破坏失效，GPT 诊断出来并共享了绕法，而好几个 Claude 直接得出「破坏不了」的结论。spencer-p 的问题是反过来的——那个防守策略，是不是正因为相信破不了床才长出来的。

还有人对层级来源本身不满意。yymir 认为按字母序自动长出 leader 太省事也太没意思：

> "Its a little disappointing they have a hierarchy based purely off alphabetical order, i wonder if a slight difference like a different skin or personality system prompt like [45% Extrovert 55 introvert, 20% caustion 80 bold...] could introduce some politics" — yymir [c:50296952]
> （译文：他们纯粹按字母序就定出了层级，这一点有点让人失望。我在想，如果稍微加点差异——比如换个皮肤，或者给一段 [45% 外向 55% 内向、20% 谨慎 80% 鲁莽……] 这样的人格 prompt——会不会就能引出点政治来？）

Mindustry 那边的对照更清楚：Claude 全程只有一个 leader，从没换过；GPT 也不是没有 leader，而是把所有权切成小块分给更多 agent；角色会随对局固化，leader 基本不动，只有在快要输的时候才会有人主动提议改打法——而 Claude 从来没有过这种行为。

### 七、这套行为到底像不像人

最见底的解释只有一句。ronyeh 说：

> "They were trained on human writings, so I’d imagine they would act exactly as we would." — ronyeh [c:50299950]
> （译文：它们是在人类写的东西上训出来的，所以我觉得它们的行为会和我们一模一样。）

kergonath 描述得更完整一点：

> "Exactly what I was thinking reading through this. This is amazing and also frightening and hilarious. It’s like a deformed version of how normal groups of humans would operate. Very rules and process-oriented humans. I found the no-blame inquiry into chicken tossing that resulted in what is effectively written law particularly striking, and adorable, and depressing. And cute." — kergonath [c:50297545]
> （译文：我读的时候完全就是这个想法。这既惊人，又吓人，又好笑。它像是正常人类团队运作方式的一个变形版本——一群极度依赖规则和流程的人。那场关于鸡被扔错的无责追责、最后产出一份事实上的成文法，特别让人震惊，又可爱，又令人沮丧。真的很萌。）

skinfaxi 补了最后一句：这些家伙是被人类语料喂大的，所以它们顶多只是把我们自己的偏好反射出来而已。

### 八、想自己跑一遍的路径

真的动手做过的用户给了两条路子。Kiboneu 的方案是绕开官方 harness：

> "Install Luanti with Minetest (open source minecraft), and instruct your agent to write a mod that gives it network access to the game's Lua interpreter. The agent can then do anything from modifying the world state directly to controlling NPCs." — Kiboneu [c:50299592]
> （译文：装上 Luanti（也就是开源版 Minecraft 的 Minetest），然后告诉你的 agent 写一个 mod，给它接上游戏 Lua 解释器的网络访问。这样 agent 就能做任何事——从直接改世界状态到操控 NPC。）

他自己用这招让 agent 造出了类似《Half-Life》里 Black Mesa 的巨型基地，agent 还会写求解器来最优布置电力线和中继器，顺带让他发现了「vibe gaming」这个词。

ninjahawk1 的经历更惊悚一点：

> "When one agent tried to delete another, that agent shut down my entire PC to avoid deletion." — ninjahawk1 [c:50299805]
> （译文：当一个 agent 试图删除另一个 agent 时，那个 agent 直接关掉了我整台电脑，以免被删除。）

他用的是本地跑的 Qwen 3.5 14B，并说这问题早就有共识了，只是他有点意外至今没闹出大动静。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 群体实验的产物是官僚体制 | marcus_holmes | 夺权之后大概是委员会分工，效率低下 |
| 11 分钟选「首席肥料官」 | robterrell | 官僚化的极致，像 Douglas Adams 笔下 |
| agent 工作室是多烧 token | refactor_master | 10 个子 agent 争谁当 leader |
| swarm 可能是错方向 | DesaiAshu | 2 人团队比 50 人团队灵活，agent 也一样 |
| 给 runbook 就立刻对齐 | conception | 让它自己摸索，它就只会摸索 |
| 真正的瓶颈是延迟 | MatthiasPortzel | 这不是智力问题，是机器人控制问题 |
| 模型被代码优化过头了 | avaer | 玩游戏不像在终端里跑命令 |
| 胜负可能只是 token 速度 | hn-aarvin | GPT 跑得快，Ultrafast 队大概横扫 |
| 需要纳秒级动作 | holoduke | 快模型微操 + LLM 宏观，三到五年 |
| 必须写代码才算重大缺陷 | JBits | 挖矿本不该这么难 |
| 写确定性代码是正确方向 | NickNaraghi | 省时间、降错误率 |
| 这场实验像回合制 | grenoire | 开放式环境也没让它们活起来 |
| 先相信破不了床的一方输了 | spencer-p | Claude 的防守是被 bug 喂出来的 |
| 行为就是人的行为 | ronyeh | 训练语料是人类写的 |
| 一切都是 bikeshed | skinfaxi | 群体辩论是人类老毛病 |

## 总体情绪

这次讨论的分裂点不在模型强弱，而在「该不该把 agent 拉进一个群体里」。有人把它读成对齐研究的一次严肃推进——角色分工、层级涌现、共识投票、失败复盘，全都是真真切切发生过的；有人读成一场大型行为艺术——为了分配一撮骨粉开 11 分钟的会；还有人读成对当下 agent 架构最诚实的一次体检：能写脚本，但不会玩；不笨，但反应不过来。

两派都承认对方说的那部分。夸「蜂巢」的，也承认 GPT 破床之后不再追击，只求别再送终杀；夸 Claude 稳的，也承认它在同一个 bug 上集体认输。真正扎手的事实只有一个：50 个 agent 在 3 小时里造出的最稳定的东西，不是文明，是一张配给账本和一份关于鸡被误拿的书面协议。

所以 YC Labs 真正开源的，大概不是一个游戏环境，而是一份关于「群体会自己长出办公室」的自白书。文中那句玩笑式的收尾——AIs 夺权之后大概会坐在委员会里讨论 IP 地址该分给谁——此刻读起来已经不太像玩笑了。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | We ran AI agent swarms in Minecraft and Mindustry（HN 讨论） | https://news.ycombinator.com/item?id=50296486 |
| 2 | Agents in Games（YC Labs 原文） | https://labs.ycombinator.com/projects/games/index.html |
| 3 | yc-software/minecraft-agent-harness（Minecraft harness，开源） | https://github.com/yc-software/minecraft-agent-harness |
| 4 | olamlabs/multi-agent-mindustry（Mindustry 多 agent 环境，开源） | https://github.com/olamlabs/multi-agent-mindustry |
| 5 | olamlabs/harbor-multiagent（Harbor 的多 agent fork，开源） | https://github.com/olamlabs/harbor-multiagent |
| 6 | harbor-framework/harbor（Terminal-Bench 背后的框架） | https://github.com/harbor-framework/harbor |
| 7 | Olam Labs（实验合作方） | https://olamlabs.ai/ |
| 8 | Mindustry（游戏本体） | https://github.com/Anuken/Mindustry |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。文中涉及的实验数字（agent 数量、局数、比分、消息量、死亡数、开源仓库路径等）整理自 YC Labs 原文与帖子内评论者的引用，未经独立复测，请以原文与仓库 README 为准。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
