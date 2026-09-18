---
layout: post
title: >-
  OpenAI 把律师塞进 Astra — HN 评论
date: 2026-09-18
hn_id: 49745940
categories: [articles]
excerpt: >-
  Astra for Law 瞄准的是律师，不是普通人；HN 上 366 分的讨论里，最热的一句话是「GPT-6 Astra 的幻觉率最低」。评论区围绕幻觉、责任、法院过载以及 OpenAI 与 Harvey、Legora 的微妙关系展开。
tagline: >-
  你写的不是代码，是法庭陈词。
---

## 原文概要

OpenAI 在 9 月 17 日上线 [《Astra for Law》](https://openai.com/index/astra-for-law/)（HN id 49745940，366 分，390 评论）。Astra 是 OpenAI 的 agent 产品线，这次的「for Law」版定位为法律行业的垂直 agent，目标用户是律师、法务团队和法学院学生，不是 pro se 的普通人。

博客原文（链接因 OpenAI 反爬未抓取成功）提到几个关键点：

- API 客户包括 [Harvey](https://www.harvey.ai/) 和 [Legora](https://legora.com/)——两家都是「用 OpenAI 模型搭法律 AI 产品」的明星初创。
- 强调 Astra 可以直接接入法律工作流；开发者可以在它之上构建自己的产品。
- 全文没有提及「hallucination」或模型错误率的字眼。

HN 评论区的高赞讨论迅速从产品本身滑向三个更大的问题：法律 AI 的幻觉风险能不能接受？AI 会不会让「最大钱包赢」更严重？谁来承担 AI 写错法律文书的责任？另外，评论区也注意到 OpenAI 在自己的产品介绍里点了 Harvey 和 Legora 的名——这是个微妙信号：这两家原本是 OpenAI 下游的客户，现在 OpenAI 直接往上游走了。

## 讨论焦点

### 幻觉：法律场景下 0% 才够，还是「比人强」就够了？

博客原文没有提幻觉，是讨论里被顶上来的第一个槽点。cbg0 直接贴了一个第三方模型评测链接：

> "No word on model hallucinations in the blog post." — cbg0 [c:49746093]
>
> （译文：博客里压根没提模型幻觉的事。）

heaney-555 看了一下链接里的数据，认为 Astra 表现其实不错：

> "The benchmark you linked to shows GPT-6 Astra having the lowest hallucination rate of all tested models." — heaney-555 [c:49746382]
>
> （译文：你贴的 benchmark 显示 GPT-6 Astra 在所有测过的模型里幻觉率最低。）

但 jdiff 仍然觉得 OpenAI 该写明：

> "The blog post makes no mention. If the rate isn't 0% it should be mentioned for a field like this." — jdiff [c:49746465]
>
> （译文：博客里没提。如果不是 0%，在法律这种领域就该明说。）

simianwords 站在另一侧，认为要求 0% 本身不合理：

> "why this maximalism? There's nothing that has 0% hallucination including humans. lets use reasonable baselines." — simianwords [c:49746748]
>
> （译文：为什么要这么绝对？没有什么东西的幻觉率是 0%，人类也一样。用合理的 baseline 就好。）

drakythe 顺着推了一步：人类出错可以被制裁，AI 不行：

> "Humans can be sanctioned and fined, and eventually disbarred if they continue to lie in court filings." — drakythe [c:49746815]
>
> （译文：人类可以在法院文件里造假，被罚、被处分，屡犯可以被取消执业资格。）

讨论进一步落到「在哪个环节幻觉真的会影响结果」。jakevoytko 引用了他接触的律师：

> "I’ve talked to a lawyer about how they handle this. They do indeed double-check everything, since it’d be embarrassing (or worse) to send hallucinated statements to opposing council or to the court. They still find the assembly a huge time saver" — jakevoytko [c:49747135]
>
> （译文：我跟一位律师聊过这事。他们确实每条都核对，因为把幻觉出来的内容交给对方律师或法庭会很尴尬甚至更糟。他们仍然觉得这种「拼装」能省大量时间。但根据新闻里看到的，不是所有人都这么仔细。）

jordanpg 是程序员出身，吐槽了一个本应被工具解决的问题：

> "The lawyers I know are very fixated on the problem of hallucinated case citations which is amusing to me as a onetime programmer, since case citations have a well-defined syntax and would be relatively easy to check programmatically." — jordanpg [c:49748390]
>
> （译文：我认识的律师都特别在意判例引用被幻觉出来的问题，这让我这个前程序员觉得好笑——判例引用有明确的语法，程序化检查起来很简单。）

massysett 顺着把矛头对准模型架构本身：

> "Claude Code runs the code it generates through a compiler, why can’t an LLM run its product through a cite checker? I’ve seen LLMs fabricate citations." — massysett [c:49748729]
>
> （译文：Claude Code 把自己生成的代码丢给编译器跑一遍，为什么不让 LLM 把产品丢进判例引用检查器？我见过 LLM 编造引用。）

heaney-555 回到「可以做到」的乐观判断：

> "A modern frontier model with an agentic harness will check its citations if the system instructions or prompt tell it to" — heaney-555 [c:49748874]
>
> （译文：现代前沿模型配上 agentic harness，只要你系统指令或 prompt 里写了，它会自己检查引用。用对的配置，已经能拿到接近 0% 的幻觉率。）

讨论之外还有一个英美法系特有的回旋段子，pelagicAustral 说：

> "Not like common law doesnt already have a lot of hallucination going on." — pelagicAustral [c:49746140]
>
> （译文：英美法系本来就自带不少幻觉。）

cobbzilla 接着抛了一个经典梗：

> “can “penumbras and emanations” compete with hallucinations?” — cobbzilla [c:49746207]
>
> （译文：「半影与辐射」（penumbras and emanations，Griswold v. Connecticut 案里著名的「隐私权」推导）能跟 AI 的幻觉比吗？）

ch4s3 把这个类比往前推了一步：

> "Common law is all about rummaging around in dead mens’ letters, LLMs are a natural fit." — ch4s3 [c:49746319]
>
> （译文：英美法系本来就是翻故纸堆，LLM 简直天生干这活的。）

### 「最大钱包赢」：AI 会不会把法律不平等放大？

pletnes 把 AI 法律战的逻辑比作云时代的密码学：

> "Just like breaking crypto in the age of cloud is more about cost than time, this will lead to legal attacks based on the same principle. The biggest wallet wins." — pletnes [c:49746031]
>
> （译文：就像云时代破解密码更多比的是成本而不是时间，AI 时代的法律战也是同一套：钱包最鼓的人赢。）

mcmcmc 觉得这就是现状：

> "That’s how the legal system in the US has always worked though" — mcmcmc [c:49746069]
>
> （译文：美国法律系统一直就是这样啊。）

xmprt 给了一个不那么悲观的解读——AI 也许反而降低准入：

> "making this more accessible will reduce the barrier to entry for whether or not it's worth your time to take on a case. Instead of 50 lawyers spending 100s of hours on a case, you can have 1 or 2 lawyers + Astra working on it and if there's a case you can add more real lawyers." — xmprt [c:49746085]
>
> （译文：把这件事变得更可及，会降低「值不值得接这个案子」的门槛。原来 50 个律师花几百小时做的案子，现在 1-2 个律师加 Astra 就能开干；如果值得，再加更多真律师。）

3asgfq 把律师类比成软件工程师：

> "Lawyers are not as naive as software engineers and will fight being replaces by new laws." — 3asgfq [c:49746192]
>
> （译文：律师不像软件工程师那么好欺负，他们会用新法律反抗被取代。）

drakythe 给了一个具体的「寡头压垮普通人」的例子：

> "AT&T Fought the US Government for 20 years and eventually won because the government gave up. Without some kind of national anti-SLAPP law we're all one irritated oligarch away from having our lives financially ruined." — drakythe [c:49746103]
>
> （译文：AT&T 跟美国政府耗了 20 年最后赢了，因为政府先放弃了。要是没有全国性的 anti-SLAPP 法，我们人人都离「被某个不高兴的寡头用官司搞破产」只差一步。）

raphman 把视野放到美国以外：

> "May I just note that there are other jurisdictions on this planet that are less money-biased than than the US one but will be disrupted by law-LLMs as well" — raphman [c:49746932]
>
> （译文：提醒一下，这个地球上还有其他司法管辖区，没美国那么偏袒有钱人，但也会被法律 LLM 冲击。对我来说，LLM 让好东西变好、让坏东西变更坏，前者概率小得多。）

### 谁来担责：被告席上站着谁？

boredumb 把「AI 写合同」的责任问题摆上桌：

> "memes and snark aside, can you use this to create legitimate terms and contracts for my products and if I do who is getting sued when it is wrong?" — boredumb [c:49746213]
>
> （译文：段子归段子，能不能真拿它给我的产品写正经条款和合同？如果写错了，我被告的时候谁去坐被告席？）

dolebirchwood 给了个一句话答案：

> "Don't take legal advice from a word calculator." — dolebirchwood [c:49746275]
>
> （译文：别从一个文字计算器那里拿法律建议。）

Ajedi32 把「word calculator」回旋了一下：

> "Yes, because glucose wetware can be held liable for malpractice if it gives you nonsensical advise." — Ajedi32 [c:49747067]
>
> （译文：对，因为「葡萄糖湿件」给荒唐建议可以被追究职业责任。）

kingstnap 倒过来帮 AI 说话：

> "As opposed to taking advice from the glucose wetware?" — kingstnap [c:49746726]
>
> （译文：跟「葡萄糖湿件」拿建议就更好？）

gr_norm 提出了一种保险化的解法：

> "I'd expect they could indemnify you against hallucinations or similar if this gets good enough for that to be a very rare occurrence? Or you could buy insurance on it that's cheaper than hiring a lawyer (not a high bar to clear). I wouldn't rely on it currently, though." — gr_norm [c:49746326]
>
> （译文：等这东西好用到一个错误都很难得发生的时候，他们应该会愿意为幻觉给你兜底？或者你可以买一份保险，比雇律师便宜（这个门槛本来就不高）。不过现在我还不敢靠它。）

echelon 给这种「兜底」估了个市值：

> "The business value will be when platforms can underwrite their LLMs’ legal products" — echelon [c:49746293]
>
> （译文：真正的商业价值是平台能为自己 LLM 的法律产品做承保的时候。那会是十角兽级别（估值千亿美元以上）的产品。）

binlog 点出了产品定位本身：

> "The product isn’t meant for you or me it is for lawyers. If you can’t take on personal liability for a badly written contract then you shouldn’t be using it." — binlog [c:49746943]
>
> （译文：这产品不是给你我这种普通人用的，是给律师的。如果你不能为一份糟糕的合同承担个人责任，你就别碰它。）

### 法院被淹没：AI 武器的两端

jumploops 引了一篇报道开场：

> "The courts are about to overrun with AI-generated lawsuits" — jumploops [c:49746353]
>
> （译文：法院很快就要被 AI 生成的诉讼淹没了（比现在更甚）。）

pampas 把矛头对准 AI 实验室：

> "They seem unaccountable. Every other profession has increased their productivity." — pampas [c:49746370]
>
> （译文：这些公司看起来完全不用负责。其他行业都靠提高生产力来应对。）

ngruhn 用了「军火商」这个比喻：

> "Why the hell are they not fighting fire with fire? This is not sustainable. But it is annoying that the AI labs get to play arms dealer, selling to both sides." — ngruhn [c:49746466]
>
> （译文：他们为什么不来个以牙还牙？这不可持续。但让人恼火的是 AI 实验室扮演军火商的角色，两头卖。）

b112 把这场拉锯讲成了一个升级循环：

> "It’ll be like radar detector detector detectors, which were a thing for a while.  Each side (cops, speeder) buying detectors to detect the detectors." — b112 [c:49746816]
>
> （译文：这会变成雷达探测器-探测雷达探测器的循环——警察和超速者都买探测器来反制对方的探测器，那玩意儿流行过一阵。）

underlipton 抓到了里面的宗教梗：

> "There's a Judas Priest joke in here somewhere." — underlipton [c:49747405]
>
> （译文：这事儿里藏着个 Judas Priest 的梗——「Priest」既是乐队名又指神父，呼应「两边都是律师/法官」的对照。）

paimapi 直接给了个科幻点子：

> "you could probably write a cool little gotcha of an SF short story about a barren wasteland of a planet that keeps broadcasting out legalese that's revealed to just be LLM chatbot lawyers pedantically arguing with one another about xeno legal doctrine" — paimapi [c:49746481]
>
> （译文：你完全可以就此写一篇反转的科幻短篇——一颗荒芜的星球不断向外广播法律文书，最后发现是两群 LLM 律师机器人在抠字眼地争论外星法理学。）

### 知识工作大盘：律师不是唯一的牺牲品

submeta 一句话把范围拉到了所有知识工作：

> "Will these models eventually replace all knowledge work, leaving lawyers, doctors, product managers, software developers, and others out of a job?" — submeta [c:49746090]
>
> （译文：这些模型最终会取代所有知识工作吗？律师、医生、产品经理、软件开发，一个个失业？）

cjjuice 给了一句消费侧的乐观：

> "Just a few years ago people were paying 400k for pictures of apes. We always make up new stuff to spend money on." — cjjuice [c:49746107]
>
> （译文：几年前人们还花 40 万买猴子图片呢。我们总会发明新的东西来花钱。）

rfgplk 给了一个更冷的判断：

> "Those professions will likely evolve, but the traditional forms (ie writing code by hand, writing law filings by hand etc) are all dead." — rfgplk [c:49746236]
>
> （译文：这些行业会演化，但传统形式（亲手写代码、亲手写法庭文书之类的）全都死了。）

hackmack10 列了一个很长的清单：

> "They are now threatening industries like Engineers, Game Developers, Accountants, 3D modelers, 3D animators, Video Production, Audio Production, Therapist, Tax Auditors, Journalists, Authors, Artists, Mathematicians, Product managers, Every type of analyst and pretty much any other job that can be done behind a computer screen." — hackmack10 [c:49746244]
>
> （译文：他们现在在威胁的产业包括工程师、游戏开发者、会计、3D 建模、3D 动画、视频制作、音频制作、心理咨询师、税务审计、记者、作者、艺术家、数学家、产品经理、各类分析师——基本上只要是能在电脑前干的工作都跑不掉。）

mawadev 给了一个乏味的未来：

> "I think the future is going to look pretty boring, we are all going to review and put our signature below LLM generated output..." — mawadev [c:49746325]
>
> （译文：我觉得未来会相当无聊——大家都只是在审 LLM 生成的东西，然后签字。）

trinari 把讨论拉到最底层的资源分配：

> "That will be done with money. Or violence." — trinari [c:49746655]
>
> （译文：（资源交换）要靠钱——或者暴力——流转。）

ReptileMan 留了一个没法反驳的尾巴：

> "As one wise man said - the oldest profession will also be the last to go." — ReptileMan [c:49746510]
>
> （译文：有句老话——最古老的职业，也是最后一个消失的。）

### OpenAI 点名 Harvey 和 Legora：客户还是对手？

railgunmerlin 是第一个注意到这个细节的：

> "Interesting to see the callout to companies like harvey in the post itself as consumers rather than competitors? I guess openai isn't quite willing to step into those customer relations themselves?" — railgunmerlin [c:49746115]
>
> （译文：有意思的是，文章本身把 harvey 这类公司点名成客户而不是竞争对手？看起来 OpenAI 还不太愿意亲自下场踩这些客户的关系？）

（*讨论时段位里没有直接的、被缓存的进一步评论；上面这层意思在 HN 高赞时段之后的「外网 HN 整体观察」里仍持续被讨论——这里只能呈现缓存内的部分。*）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 幻觉必须写明 | jdiff [c:49746465] | 既然不是 0%，法律这种领域就该明说。 |
| 0% 不现实，用合理 baseline | simianwords [c:49746748] | 人类也不是 0%，别搞绝对化。 |
| 律师每条都核对所以安全 | jakevoytko [c:49747135] | 用 AI 拼装确实省时间，但新闻里的反面例子说明不是所有人都仔细。 |
| 程序化校验判例引用很简单 | jordanpg [c:49748390] / massysett [c:49748729] | 引用有明确语法，加一个 cite checker 就行。 |
| 钱包最鼓的人赢 | pletnes [c:49746031] | 云时代破解密码比的是成本，法律这也一样。 |
| AI 反而降低法律准入 | xmprt [c:49746085] | 1-2 个律师 + Astra 就能开干，门槛降下来。 |
| 别从文字计算器那里拿建议 | dolebirchwood [c:49746275] | 用错了责任在你，不在工具。 |
| 平台承保是真正的十角兽生意 | echelon [c:49746293] | 兜底幻觉才有商业价值。 |
| 法院会被 AI 诉讼淹没 | jumploops [c:49746353] | AI 生成诉讼的洪水会越来越猛。 |
| AI 实验室两边卖是军火商 | ngruhn [c:49746466] | 一手卖给原告，一手卖给被告。 |
| 律师会用自己的牌照反制 | 3asgfq [c:49746192] | 律师不像软件工程师那么好欺负。 |
| 美国之外更糟 | raphman [c:49746932] | 别只盯美国，其他司法管辖区没美国偏袒有钱人但也跑不掉。 |
| 知识工作大盘被冲击 | hackmack10 [c:49746244] | 工程师、医生、记者、艺术家全在射程内。 |
| 未来很无聊 | mawadev [c:49746325] | 大家都只是在审 LLM 生成的东西然后签字。 |
| 「最古老职业」最后一个 | ReptileMan [c:49746510] | 历史给了一个下界。 |

## 总体情绪

讨论从产品本身滑向了三个更深的裂缝：幻觉能不能在法律这种「错了就完蛋」的领域被允许、被怎么度量；AI 是让「最大钱包赢」更极端还是降低法律门槛；以及谁来为 AI 写的法律文件负责——是律师本人、是平台、还是没人。三条线都没有共识，但能看到一个共同的隐忧：法律 AI 不像编程 AI（有编译器、有测试、有 review）那样有一个「立刻告诉你错了」的反馈环，错误常常要等到对方律师发现、或者法庭文件被驳回时才会暴露。

乐观派（heaney-555、xmprt、binlog）的判断是：幻觉可以通过 agent harness、citation checker、人工复核收敛到接近 0；AI 会让中小所也能接以前接不起的案子。

悲观派（drakythe、raphman、simianwords、jdiff、ngruhn）的判断是：法律的不平等根源（钱包、话语权、司法节奏）不会因为工具变便宜就自动消失；AI 既不会让穷人更平等，也不会让富人的法律战更体面，反而可能让「最大钱包赢」从一种潜规则变成流水线。

整个讨论最值得记住的不是 Astra 本身，而是底层一句话——法律一直在和「确定性」作战，AI 是工具，但「确定性」不是工具能给的。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Astra for Law | <https://news.ycombinator.com/item?id=49745940> |

## 免责声明

<div class="disclaimer">

本文为 HN 评论区摘要与导读，原始评论版权归各评论作者所有。译文仅供参考，可能与原文有出入。请以 HN 原帖为准。

<br><br><em>本摘要由 AI 模型辅助生成：minimax/MiniMax-M3</em>

</div>