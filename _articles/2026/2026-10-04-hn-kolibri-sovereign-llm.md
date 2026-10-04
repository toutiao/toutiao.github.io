---
layout: post
title: >-
  78B 总参 3B 激活：德国发布主权开源模型 Kolibri，HN 吵起来了
date: 2026-10-04
hn_id: 49943034
categories: [articles]
excerpt: >-
  一个 78B 总参、3B 激活的 MoE 模型，以「主权」和德语为卖点登上 HN，却把关于「主权模型到底要不要做」的争论推上了台面。
tagline: >-
  主权不是技术问题，Kolibri 真正想卖给谁？
---
## 原文概要

2026 年 10 月 3 日德国统一日，德国 AI 公司 [Aleph Alpha](https://aleph-alpha.com/) 发布 [Kolibri](https://huggingface.co/Aleph-Alpha/Kolibri-1)：一款 Apache 2.0 开源权重的英语-德语 [mixture-of-experts (MoE)](https://huggingface.co/blog/moe) Transformer。模型总参数 78.1B，每个 token 仅激活 3.46B（约 4.4%），原生上下文 262144 tokens，可外推到 1M。

Kolibri 主打两个特性：自研硬件与「主权」叙事。它在德国用 768 张 NVIDIA B200 训练约 24T tokens，其中超过 1/5 为德语，并配套开发了 128,000 词表的 [UniBPE](https://huggingface.co/Aleph-Alpha/Kolibri-1) tokenizer，能把 [Bundesverfassungsgericht](https://www.bundesverfassungsgericht.de/EN/)（联邦宪法法院）切成 2 个 token，而 GPT-5 的 `o200k_base` tokenizer 需要 6 个。在 18 万字德语基本法上，Kolibri 比 GPT-5 tokenizer 省 15% token，优于 9 个对照 tokenizer。模型还内建 4 档推理强度（none/low/medium/high）、工具调用与基于 Merlin-Arthur 协议的「拒答」训练，让它在汽车、航空、公共部门等垂直基准上的得分曲线一路攀升（如汽车供应商 0.72 → 0.99）。

Aleph Alpha 给「主权」下的定义是双重的：一是「在德国和芬兰境内、用欧洲和德国法律训练、无外国控制」；二是客户拿到「完整部署自由与知识产权安全」，合规变成模型的「先天属性」。Kolibri 还签署了欧盟 [GPAI Code of Practice](https://digital-strategy.ec.europa.eu/en/policies/contents-code-gpai)。

与发布同步，Aleph Alpha 技术报告 [tej.as 的解读](https://tej.as/blog/aleph-alpha-kolibri) 和 [官方博客](https://aleph-alpha.com/en/blog/kolibri-has-landed-a-sovereign-open-weight-model/) 同时出现在 HN 热搜，随后被 [dang](https://news.ycombinator.com/item?id=49946358) 合并到一条主线。

## 讨论焦点

### 「主权」到底是什么意思

「主权」是这轮讨论里最拧巴的词。9dev 把 Aleph Alpha 描述为「a sad joke by now」，认为他们早就追不上其它玩家、兑现不了承诺，只是给投资人收尾：

> "Aleph Alpha is just a sad joke by now. The talent isn't there anymore, they never managed to catch up to the other labs, failed to deliver on several projects, and by now are just a cash grab for the investors." — 9dev [c:49943940]

gchamonlive 用 5/10/20 年的时间尺度反驳——短期的「差」不重要，关键是要在 5、10、20 年后拥有「好的」主权模型：

> "Only if you think in terms of short term gains, but thinking in the long run, doesn't really matter if these models are crap today, all models will eventually be obsolete, unless we plateau hard on every aspect of the tech. What matters is to have *good* sovereign models in 5, 10, 20 years time." — gchamonlive [c:49944080] [thread 2]

roncesvalles 顺势追问：那开源权重模型已经存在，为什么还要做「主权模型」？

> "I'm curious why you think sovereign models matter that much if open source ones exist (unless that stops at some point). Sovereign model *hosting services*, yes." — roncesvalles [c:49944138] [thread 2]

三个答案在这条支线上叠加：

- **偏见可被内置**：hypfer 认为「主权模型」可以把价值观和文化烙印写进权重里，是真正的本土化。> "The first thought that comes to mind is biases that are baked into the weights. The next thought is culture-specific workflows, requirements etc that are best trained into weights by people that actually understand those needs." — hypfer [c:49944149] [thread 2]
- **主权不能止步于权重**：HotHotLava 主张国家级 AI 主权应该是一条完整训练流水线，否则当 Kimi K4 停止开源时就被卡住；并指出 EU 级别的主权模型在融资上更现实。> "Just open weights are not enough, I think as a nation state you'd at least want a whole sovereign training pipeline. Otherwise you are stuck when Kimi K4 stops releasing their weights. But I don't see why this needs to be done on a state-by-state level, a sovereign EU model seems to be much more realistic in terms of funding." — HotHotLava [c:49944257] [thread 2]
- **国家安全与现代战争**：HarHarVeryFunny 把它放到战争与监控国家语境里，认为自建 SOTA 能力是无法替代的。> "Like it or not, AI has become part of modern warfare and well as part of the surveillance state (good for crime fighting, not for privacy), so it is an important part of national security, and you'd prefer to be as much self-sufficient for that as you can be." — HarHarVeryFunny [c:49944348] [thread 2]

这一组反应踩到了 mistrial9 的「警觉」神经：

> "amazing to see blunt unfiltered commentary about making war and society level propaganda as important and necessary for a political state." — mistrial9 [c:49944384] [thread 2]

HN 是技术论坛，不是国防白皮书；把 LLM 摆在「现代战争工具」的位置上，并不总能换来一片掌声。

### 78B 模型、3B 激活：一个悖论

Kolibri 推销的「身板 78B、脑力 3B」结构在讨论里被反复拆解。martianvoid 用 RTX PRO 6000 跑 FP8 推理速度约 170 tkn/s，但抱怨模型在「想太多」：

> "I just tried to play around with it on my RTX pro 6000 setup, it spends way too many tokens on overthinking stuff even if it's able to catch the correct approach. Its speed is pretty good on the other hand with only 3B active parameters I am getting around 170 tkn/s on fp8" — martianvoid [c:49943869] [thread 2]

gizajob 在底下扔了一个「德国模型当然过度思考」的玩笑：

> "Yeah. It's a German model." — gizajob [c:49943876] [thread 2]

这个本意轻松的梗引发了一长串「德国人幽默感」的子线——hypfer 把它定性为「bad faith disrespect / casual racism」，jamiek88 则回呛「你们自己国家的人在自嘲，怎么还来护不住」：

> "Jesus Christ you're a sensitive little sunflower aren't you? All over this thread swooning at mild jokes made mostly by Germans themselves. Chill out man. Three comments crying is enough. You are personally reinforcing the 'no sense of humour' German stereotype you rail against. Using words like 'racist' for that like in your other comments is in incredibly poor taste." — jamiek88 [c:49946402] [thread 2]

这串张力最终被 jijijijij 升格为「官方德式幽默」：

> "Nothing flies anywhere, we use superior high speed trains. I faxed a Humorgenehmigungsantragantrag to our Bundesunterhaltungsministerium analyst, immediately. Laugh now, but you are merely lucky the reply got delayed. As soon as the leaves on the rails are dealt with, you will get a formal response that has washed itself! Let us see who is laughing then. It is nobody!" — jijijijij [c:49945183] [thread 2]

fph 立刻把它接到 tokenizer 主线上——把一个超长复合词扔进 Kolibri 的 tokenizer 看看是不是单 token：

> "But, most importantly, is Bundesunterhaltungsministerium a single token in Kolibri? This could make a huge difference for the model's performance in German." — fph [c:49946581] [thread 2]

这恰恰是 Kolibri 的卖点之一——德国法律语言里那些吓人的复合词，在它词表里被尽可能保留为整体。

### 传真机的当代意义

Kolibri 在基准上「不像最强编码 agent、记忆较弱、工具调用也偏弱」这一点，让 sajithdilshan 直接问「它到底擅长什么，发传真？」：

> "It knows less from memory, Multi-turn tool calling is weaker, It's not the best coding agent. Then what does it good at? Sending faxes?" — sajithdilshan [c:49943617] [thread 2]

skrebbel 顺着玩笑接了一句：

> "Well that's a pretty important skill for German users!" — skrebbel [c:49943840] [thread 2]

27 岁、在德国出生长大的 moooo99 罕见地替德国辩护：

> "I know this is a long standing joke, but I am 27 now, born and raised in Germany, and genuinely never had the opportunity to use a Fax machine. It honestly kind of bums me out because there is something that seems cool about Fax (being fully aware that it should be fully obsolete by now)" — moooo99 [c:49944144] [thread 2]

这条支线扯出了一个真正的产品问题：Kolibri 强在哪儿？pettijohn 给了一个偏肯定的回答：

> "Seems like it's good at reading German documents and reasoning over them. Custom German-language tokenizer, and one of the least hallucinating models." — pettijohn [c:49944226] [thread 2]

mhitza 则把它推向另一个角度——「被训练成说『我不知道』」本身就有价值：

> "I don't have the hardware to test this, but being trained to say \"I don't know\" instead of misleadingly talking confidently about what it does not know is interesting in itself." — mhitza [c:49943877] [thread 2]

hasley 把这个能力映射到一个具体的工作场景——企业内部几千份德语说明书的阅读：

> "I suspect there are a lot of German companies that have thousands of documents that describe their software/product. Adding or changing a feature means you have to ask 20 people whether there might something that can break some edge case behavior for which no (automatic) test exists. In this case, it would be nice to have a virtual employee who knows the content of all documents." — hasley [c:49946152] [thread 2]

### 预训练数据：是不是「翻译」套壳

sbinnee 怀疑所谓「按德国人方式思考」只是把英文/中文材料翻译成德语：

> "It is a good approach to promote it as a German model. But I wonder if it really thinks like the German think. I speculate they just translated texts in other languages, likely English and Chinese, into German." — sbinnee [c:49944323] [thread 2]

这条质疑很快被一位预训练团队成员直接回应：

> "Hey, I worked on pre-training data Kolibri. We spent considerable time and effort to go beyond just translating. For example by building a pipeline that processes Common Crawl dumps specifically for German. You might be interested in a related blog post: sauerkraut-not-burgers-why-german-llms-need-german-data. We also talk more about German pre-training data in the tech report, section 2.3.2.2." — ivo-42 [c:49946371] [thread 2]

「Sauerkraut not burgers」这个标题本身是一句话的承诺——德语 LLM 需要真正的德语食材，不是英美快餐翻个面。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 反对主权叙事 | 9dev | Aleph Alpha 是「a sad joke by now」，只是给投资人收尾 |
| 长线看好主权 | gchamonlive | 短期强弱不重要，10/20 年后能自主才重要 |
| 主权=控制偏见 | hypfer | 权重里写进本土价值观，是真正的主权 |
| 主权=完整链路 | HotHotLava | 只开源权重不够，国家需要训练流水线 |
| 主权=国家安全 | HarHarVeryFunny | AI 已成现代战争工具，必须自建 SOTA 能力 |
| 用户实测快慢参半 | martianvoid | FP8 170 tkn/s，但「overthinking」明显 |
| 严肃的反「德国人笑话」 | hypfer | 多次指出这是 casual racism |
| 反「不许开玩笑」 | jamiek88 | 多数玩笑是德国人自己说的，别太玻璃心 |
| 团队自证清白 | ivo-42 | 我们专门做德语 Common Crawl 流水线，不是翻译 |

## 总体情绪

讨论呈现出一种并不依赖定义的双向分裂。一边把「主权模型」当成对抗大型科技公司依赖、抵御政治偏见和现代战争风险的盾牌，逻辑扎实但容易被指控为「国家级宣传工具」；另一边则嘲笑 Aleph Alpha 一次次错失节奏、只配做投资人的退出选项。两边都有自己的愤怒，没有一方占据上风。

另一条隐线更微妙：HN 上的德国用户对「德国人没有幽默感」这类玩笑极其敏感，多人公开护栏；非德国用户又嫌这种敏感过度自我强化了刻板印象。Kolibri 在技术上完成的事情——把 Bundesverfassungsgericht 切成 2 个 token、把德语基本法少用 15% token——是真的；它在文化上撞到的事情——把「德国」当成模型卖点宣传出去——也是真的。两件事并行，互不取消。

主权模型到底卖给谁？答案藏在 Aleph Alpha 那张 [Pareto frontier] 图里：横轴是吞吐量，纵轴是质量，Kolibri 落在大多数同尺寸模型的右上。汽车供应商、半导体、公共部门、航空航天——五个内部基准把分从 0.14 抬到 0.59——他们要的不是聊天能力，是部署在自己的机柜里、用德语思考、敢说「我不知道」的合规模型。

主权不是技术问题，Kolibri 真正想卖给谁，是 HN 始终没人正面回答的问题。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 主 | Aleph Alpha Kolibri: How the sovereign German LLM works | https://news.ycombinator.com/item?id=49943034 |
| 相关 | Kolibri: A Sovereign Open-Weight Model | https://news.ycombinator.com/item?id=49942706 |

<div class="disclaimer">
⚠ 本文涉及「主权」「监控国家」「现代战争工具」等敏感政治语境，相关引文为 HN 用户的原话，仅作讨论脉络呈现，不代表本摘要或原作者立场。

本摘要由 AI 模型辅助生成，仅根据公开 HN 评论反映讨论脉络；不代表原作者及 HN 用户立场。引文为 HN 用户公开发布的内容（CC BY-SA 3.0 / HN Terms）。摘要中涉及的所有链接、产品名与品牌归各自所有者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>