---
layout: post
title: >-
  所有 AI 生成的代码都应该开源吗 — HN 讨论摘要
date: 2026-11-16
hn_id: 50507303
categories: [articles]
excerpt: >-
  一篇主张「AI 写的代码必须开源」的博客拿到 639 分。评论区的反驳更狠：如果代码本身不可版权，
  那许可证就无从谈起；而 GPL 的四条自由恰恰建立在版权之上。
tagline: >-
  他想绕开版权，结果连开源的许可证也一起绕没了。
---

> 来源：HN 讨论主帖 [All AI-generated code should be Open Source](https://news.ycombinator.com/item?id=50507303)（639 分，339 条评论），指向博客 [jakub.jankiewicz.org/blog/ai-code-open-source](https://jakub.jankiewicz.org/blog/ai-code-open-source/)。本篇为 single post 模式。主帖于 2026-11-15 14:46 UTC 发布，归档抓取于 2026-11-15 18:34 UTC，入库 100 条评论（HN 未返回评论分，评论分数字段均为 0），引文选择依据为内容本身与讨论价值而非评论分数。引文保留 HN 原文的 HTML 实体，逐条与归档评论比对。

## 原文概要

jakub.jankiewicz.org 上的一篇短博客，标题直接摊牌：所有 AI 生成的代码都应该开源。作者自己知道这是个 hot take，开头就写「This may be a hot take」。文章给了三条理由。

第一条是训练数据。AI 模型是在 RMS 宣布 GNU 项目、自由软件运动以来积累的庞大开源代码语料上训练的，这些代码被从互联网上直接抓走，没有许可，也没有署名；模型还训练了 Stack Overflow 和 Stack Exchange 的姊妹站，那些内容发布在要求署名的 CC 许可证下。把这些集体知识变成专有的闭源代码，作者称之为 license laundering——洗许可证。

第二条是法律。纯 AI 生成的代码没有人写，就不应享有版权。他援引美国著名的「猴子自拍」纠纷（Monkey Selfie），说那个判例确立了非人类不能持有版权，后来被美国版权局在 AI 相关议题上引用；顺着同样的逻辑，维基共享资源要求纯 AI 生成的图像标注为公有领域。

第三条是司法辖区不一致。英国等国对计算机生成作品给有限版权保护。作者说，为了在所有地方都公平，也为了回报那个养出 AI 的开放生态，开发者和公司应当主动用开源许可证发布 AI 生成的代码，或者干脆用 CC0 放进公有领域。结尾他补了一段务实的注脚：代码很少有 100% 手工或 100% 自动化，但现在越来越多开发者用 AI 连输出都不看，更别说改造成合自己需求的样子——这种「人只出了提示词」的代码，更应该开源。

主帖 2026 年 11 月 15 日 14:46 UTC 发布，归档抓取时（当日 18:34 UTC）已经积到 639 分、339 条评论——在同期归档的 HN 帖子里分数排在第四。入库的 100 条评论全部挤在发布后三个多小时内，讨论密度远高于平均。

评论区的火力没有对准结论，而是对准推理。有人指出主帖在逻辑上自我矛盾：如果代码不可版权，许可证这种「版权人授权他人使用」的工具就管不了它，GPL 的四条自由恰恰依赖版权才能存在；有人指出「猴子自拍」和 Thaler v. Perlmutter 被读错了——后者问的是机器能不能当作者，不是输出能不能受保护；还有人说法律不是代码，不能做朴素的传递推理。

另一条线更现实：即便主张成立，它在现实里既不可执行，也不划算。评论区里有人搬出 Truth Social 和 Revolt 这两个 AGPLv3 违规实例，说明没有钱打官司的许可证持有者根本守不住自己的权利；也有人认为 AI 生成的代码让「开源」这件事本身贬值——没人愿意为工具付钱，因为 AI 能近乎零成本补上缺失的功能。

## 讨论焦点

### 一、主帖的核心悖论：不可版权，就没有许可证可谈

这是全场最一致的一条批评，而且是从主帖自己的前提里推出来的。

> "The article contradicts itself.<p>It&#x27;s important to remember that the purpose of the license is to allow the copyright owner to exercise their rights in a manner they deem fit. Even if they choose to give the code away, that choice is captured in the form of a specifically worded license (MIT, BSD, etc.).<p>This means that licenses exist because code is copyrightable in the first place, with the license governing the use of said copyright. If AI code is not copyrightable, then no license can govern it." — glitchc [c:50507718]
> （译文：这篇文章自相矛盾。必须记住，许可证存在的意义，是让版权人以自己认可的方式行使权利。即便他们选择把代码送出去，这个选择也是以一份措辞具体的许可证（MIT、BSD 等）来表达的。这意味着许可证之所以存在，前提就是代码本身受版权保护，由许可证来规范这份版权的使用。如果 AI 代码不受版权保护，那就没有任何许可证能管得住它。）

最早给出这条反驳的用户 ubercow13 用一句话把悖论点破了。

> "If AI generated code is not copyrightable, releasing it under an open source license is meaningless." — ubercow13 [c:50507523]
> （译文：如果 AI 生成的代码不受版权保护，把它按开源许可证发布就没有意义。）

wiremine 则把这个问题称为全篇的关键，并且追问了一个作者没回答的问题。

> "&gt; If AI code is not copyrightable, then no license can govern it.<p>This is the crux of the issue. A license controls usage of copyrighted intellectual property. Until the underlying copyright&#x2F;ip issues are resolved, it seems a moot point to discuss licensing.<p>That said, if AI code is _not_ copyrightable, does it automatically go into the public domain? Or is there a third category?" — wiremine [c:50507827]
> （译文：「如果 AI 代码不受版权保护，那就没有任何许可证能管得住它。」这就是问题的关键。许可证控制的是对受版权保护的知识产权的使用。在底层的版权／知识产权问题解决之前，讨论许可看来是白费力气。话虽如此，如果 AI 代码确实不可版权，它就自动进入公有领域了吗？还是存在第三种类别？）

最后那个追问是整段讨论里最少人接住、也最要紧的一个：不可版权不等于已公有领域，中间那层空白，主帖直接跳过了。

jonathanstrange 把这一点推到了 GPL 的立场上。

> "No, the four freedoms rely on copyright. If there is no copyright, any company can take the open source code, modify it as they like, and never give back the modifications to anyone. It&#x27;s the equivalent of an MIT license (technically, it&#x27;s more like public domain but let&#x27;s ignore this detail here). That&#x27;s fine for many but far from the goals of the GPL.<p>No copyright doesn&#x27;t mean you can&#x27;t keep your source code a tightly kept business secret. You can even combine it with NDAs and contracts to re-institute something akin to copyright." — jonathanstrange [c:50508022]
> （译文：不对，GPL 的四条自由依赖版权。没有版权，任何公司都可以拿走开源代码，随心所欲地修改，然后永远不把修改还回去。那相当于一份 MIT 许可证（严格说更像公有领域，但这里先不纠这个细节）。对很多人来说这样也行，但离 GPL 的目标差得远。没有版权，并不意味着你就不能把源码当成严加看守的商业秘密；你甚至可以把它和 NDA、合同打包，重新造出某种类似版权的东西。）

这段话把主帖的整个方案拆穿了：想用公有领域废掉版权，结局可能是任何人拿走随便改——而这正是 GPL 当初要防的事。

### 二、「我也读过开源代码」：一个到处都在用的类比

主帖的第一条理由（模型训练自开源语料，所以输出该开源），评论区用同一个句式做了最直白的反驳。

> "&gt; First of all, AI models were trained on a massive corpus of Open Source code written since RMS announced the GNU Project and the Free Software Movement.<p>I too have trained on the massive corpus of open source code. Should everything I code also be open source? Or only if I leverage an artificial neural network as a prosthesis to enhance the capabilities of my natural neural network?" — delichon [c:50507574]
> （译文：「首先，AI 模型是在 RMS 宣布 GNU 项目和自由软件运动以来积累的庞大开源代码语料上训练的。」我也是在这份庞大的开源代码语料上训练出来的。那我写的代码是不是也该开源？还是说，只有当我把人工神经网络当作假肢、增强自己天然神经网络的能力时才算？）

这条类比被反复复读，每一遍都更短更狠。

> "This is like saying: All humans who learned from open source code should only produce open source code." — sqreept [c:50507707]
> （译文：这等于说：所有从开源代码里学习过的人，此后只许产出开源代码。）

> "I have learnt to read by training on a lot of books, I should then open source all future things I write. I&#x27;ve learnt to walk by watching other people, I probably should publish videos of me whenever I walk." — bakwan44 [c:50507769]
> （译文：我通过读大量书学会了识字，那我此后写的一切是不是都该开源？我通过看别人走路学会了走路，那我大概该把自己每次走路的视频都发出去。）

g-b-r 正面接住了这个类比，给出的区分是：许可证管的是分发，不是学习。

> "No, because open source licenses don&#x27;t cover that, and artificial neural networks are very different from your &quot;natural neural network&quot;.<p>You&#x27;re also unlikely to output what you trained on verbatim." — g-b-r [c:50507742]
> （译文：不是的，因为开源许可证并不覆盖这一块，而且人工神经网络和你那个「天然神经网络」是很不一样的东西。你多半也不会把你训练过的东西逐字背出来。）

而把开源的价值说清楚的是另一条评论：开源的价值从来不在「代码是免费的」，而在「代码被人验证过」。

> "you could also do this before, but only with infinite time. open source value is shifting. open source is human-validated code. just OSSing generated code has no value." — sturza [c:50507671]
> （译文：这些事你以前也能做，只不过需要无限长的时间。开源的价值正在转移。开源是被人验证过的代码。把生成的代码直接开源，没有任何价值。）

这句话其实是整场讨论的暗线：主帖默认「开源」是目标，而评论区认为开源的稀缺性不在代码本身。

### 三、Monkey Selfie 之外：几个真实判例，和一份被读错的判决

主帖的法律论证核心是「猴子自拍」先例。这条线索在评论区被逐个案件拆开。

viraptor 指出作者援引的方向正好和当前判例相反。

> "Doe v. GitHub already decided (I&#x27;m simplifying, read the actual thing yourself) that LLM output is not automatically open source - or specifically it doesn&#x27;t infringe on the open source training material and doesn&#x27;t inherit the oss copyright notice.<p>Thaler v. Perlmutter (again simplified) showed 100% AI output can&#x27;t be given any copyright.<p>The directions the current cases are going are very much opposed to that idea and I wouldn&#x27;t expect things to change in the opposite direction." — viraptor [c:50507593]
> （译文：Doe v. GitHub 已经判过了（我在简化，读原文的话请自己读）——LLM 输出不会自动变成开源；更准确地说，它不侵犯开源训练材料的权利，也不继承开源的版权声明。Thaler v. Perlmutter（同样简化）确立的是 100% 的 AI 输出无法被赋予任何版权。当前这些案子演进的方向与主帖的观点恰恰相反，我不认为事情会朝反方向变化。）

carllerche 挑出了主帖法律论证里更具体的一处误读。

> "That is not the Thaler v. Perlmutter conclusion. That case was about whether the machine itself could be made an author under copyright law. That is very different than whether AI output can be protected by copyright law. I am not aware of any cases that test that question yet." — carllerche [c:50508163]
> （译文：那不是 Thaler v. Perlmutter 的结论。那个案子问的是机器本身能不能被当成作者。这跟「AI 输出能不能受版权保护」是完全不同的问题。我不知道目前有哪个案子在检验后一个问题。）

tkdb 补上了这条战线上的实际节点。

> "This is very much still working it&#x27;s way through the courts (in the US at least).<p>The first major precedent was in 2023 with Zarya of the Dawn comic book, where the US Copyright Office rules the midjourney-generated images were not protected, but the human-written text was.<p>The active front is Allen v. Perlmutter." — tkdb [c:50507967]
> （译文：这事（至少在美国）还远没走完司法程序。第一个重要先例是 2023 年的《Zarya of the Dawn》漫画案，美国版权局认定 Midjourney 生成的图像不受保护，但人类撰写的文字受保护。当前的主战场是 Allen v. Perlmutter。）

有人则搬出版权局自己的表态，作为「AI 参与不等于不可版权」的依据。

> "AI generated art with human steering is copyrightable [1,2].<p>Agentic code development is human steering, thus copyrightable under the same grounds per the language used by the US Copyright Office.<p>Open source code is copyrighted, otherwise we would be talking about public domain.<p>When you edit something in the public domain to enrich it, that derived work then becomes copyrightable again." — echelon [c:50507638]
> （译文：有人类引导的 AI 生成艺术是受版权保护的。agent 式的代码开发就是人类引导，因此按照美国版权局所用的同一套理由，它同样受版权保护。开源代码是受版权保护的，否则我们谈的该叫公有领域而不是开源。当你对公有领域里的东西做修改、把它充实起来之后，这个衍生作品就重新受版权保护了。）

这条评论后面还附了版权局自己的原话：认定作品含有足够的人类原创作者性，因此准予登记版权；并且强调版权局的行政认定与法院诉讼是两套体系，法院在审判中会区别对待已获登记的作品。echelon 随后又补了一句，回答「版权局说了不算」这类反驳。

> "The USCO is the regulatory and administrative authority and will inform the decisions of judges. They provide expert legal opinion that carries substantial weight.<p>It would be a surprising result for the courts to overturn the USCO. The courts routinely side with the USCO.<p>What the USCO is saying is a temperature check on how this will play out." — echelon [c:50508240]
> （译文：美国版权局是监管和行政机构，它的意见会影响法官的判决。它提供的是有分量的专家法律意见。法院推翻版权局结论会是相当意外的结果，法院经常站在版权局一边。版权局现在在说的，是给这场走势定个温度。）

### 四、律师派：法律不是代码，不能做朴素的传递推理

这是评论区里最专业的一组发言，也是对主帖推理方式最直接的批评。

> "You can&#x27;t apply naïve transitive reasoning to law. Law is not code. Your assertions are meaningless and unsupported noise until they&#x27;re actually tried in a court." — unrented7977 [c:50507679]
> （译文：你不能把朴素的传递推理套用到法律上。法律不是代码。你的这些断言在真正上过法庭之前，都是没有支撑的噪音。）

> "Was your assertion tried in court? legal reasoning is naïve transitive reasoning." — partloyaldemon [c:50507790]
> （译文：你的断言上过法庭吗？法律推理不是朴素的传递推理。）

rookienumbers30 把这条区分讲得更细：关于法律体系的陈述可以是真的，同时并没有在法律体系里被诉讼过。

> "a statement *about* the legal system can be true without being litigated *in* the legal system. Courts rely on precedent in addition to logical argument, so their rulings cannot be deduced from rational argument alone." — rookienumbers30 [c:50507876]
> （译文：一个关于法律体系的陈述，可以为真而并未在法律体系内经过诉讼。法院除了逻辑论证之外还依赖先例，所以它们的判决不能单靠理性推演推导出来。）

而最扎人的一击来自 antonvs——他把主帖第一条理由的前提（语料够庞大）当成了靶子：真正决定法律后果的从来不是数据量。

> "So if future models are able to generalize better from much smaller amounts of data, you think that all the current concerns disappear? It doesn’t seem like a very good argument if it’s purely based on the amount of data needed to train a model.<p>What matters are things like where the data comes from, how similar the output is to the input, how close the result is to existing (copyrighted) work, and so on.<p>Simply using copyrighted work, even <i>all</i> copyrighted work, to train a model doesn’t, by itself, trigger any <i>legal</i> consequences. In that respect at least, the comment you called “child like” was correct." — antonvs [c:50508271]
> （译文：那么，如果未来的模型能以少得多的数据更好地泛化，你就认为现在这些顾虑都会消失吗？如果整个论证只建立在「训练一个模型需要多少数据」上，这看起来不是一个很好的论证。真正要紧的是：数据从哪里来、输出跟输入有多相似、结果跟已有的（受版权保护的）作品有多接近，等等。仅仅使用受版权保护的作品——哪怕是全部受版权保护的作品——来训练一个模型，本身并不会触发任何法律后果。至少在这一点上，你称之为「幼稚」的那条评论是对的。）

这等于指出了主帖的根本问题：它论证的是「训练数据从哪来」，而版权争议真正落在「输出跟已有作品有多像」上。

### 五、实践派：AI 只是工具，出力的人承担所有权

另一派不谈法律，直接谈日常怎么干活。

> "There is so little value to most code produced with models these days I just don’t see the point.<p>The real value ends up being found in software where there is a person behind it continuously refining it into something others will look at and say “Someone clearly paid attention to this.” Models can’t (yet) reproduce that because they can’t&#x2F;don’t go interacting with users or asking bigger picture questions.<p>Whether someone is producing that software with a model or not doesn’t change much about the ownership picture to me:  it’s the person that owns the project, and the LLM is a tool.<p>Once again, it all comes down to it being a tool and how it’s used, and there are no useful blanket statements that can be made about it (or how the tool’s output should be classified, legally or otherwise)" — wolttam [c:50507630]
> （译文：如今用模型产出的大多数代码价值极低，我看不出这有什么意义。真正的价值落在那种背后一直有个人在打磨的软件上，别人看一眼会说「这人显然上心了」的那种。模型（目前）还做不到这一点，因为它不会去跟用户交互，也不问更大的问题。对我来说，是用模型还是不用模型来做出这个软件，几乎不改变归属这幅图景：拥有这个项目的是人，LLM 只是一件工具。再说一遍，一切归根结底在于它是一件工具、怎么被使用，关于它（或者它的输出在法律上、或其他方面该如何归类）做不出任何有用的笼统断言。）

anself 讲的是 agent 编程里真实的时间账。

> "Strongly disagree.<p>Just because AI was involved doesn’t mean <i>significant</i> human thought and effort didn’t go into the production of those artifacts.<p>My agentic software development loop requires heavy involvement of real-world feedback. The ratio is huge. 20 mins of agentic software coding against hours or days of testing, trying it out, real-world contact, thinking about what feature is next or what tweak would make it more usable, smooth, intuitive. That feedback is baked into the product." — anself [c:50507700]
> （译文：强烈不同意。仅仅因为有 AI 参与，并不意味着那些产物就没有投入大量的人类思考与努力。我的 agent 式软件开发流程需要大量真实反馈的介入。这个比例悬殊：20 分钟的 agent 式编码，对上几小时甚至几天的测试、试用、接触真实世界、思考下一个该做什么功能、或者怎样改一个参数能让它更顺手顺眼。这些反馈是烧进产品里的。）

jph 则是已经照着这个思路在做了。

> "I agree with the spirit of this. I&#x27;m a longtime open source developer and generally prefer GPL for my manual code. For my AI-generated code I&#x27;m using a multiple choice license of Apache, BSD, GPL, MIT." — jph [c:50507598]
> （译文：我认同这个主张的精神。我是长期的开源开发者，手写的代码一般偏好 GPL。对 AI 生成的代码，我用的是一份多选许可证：Apache、BSD、GPL、MIT 都可以选。）

当然也有人连这一条都做不到，直接给出了例外。

> "I mostly agree and have pretty much every one of my projects open source. One in particular, though, is not. And that is because the design of it is heavily domain specific and is built on loads and loads of experience. Not sure how to reconcile that..." — sicher [c:50507563]
> （译文：我大体同意，我几乎每个项目都是开源的。但有一个不是。原因在于它的设计高度依赖特定领域的知识，建立在大量经验之上。我不太知道这个该怎么调和……）

### 六、现实主义：就算成立，也执行不了，也没人买单

讨论的后半程越来越现实。

> "The author needs to realize that this is unenforceable.<p>In fact I&#x27;d argue that free software and open source is economically dead and unsustainable because of AI generated code and almost no one wants to pay for their tools because an AI can generate the missing feature for them close to $0.<p>Maintaining it is another thing, but assuming that the cost of tokens get cheaper, why wait for open source developers to maintain it when a frontier AI model can do it for far cheaper and quicker?<p>I am just saying what the average manager turned vibe coder would say who will refuse to donate or pay for established open source projects that they use for free." — rvz [c:50507648]
> （译文：作者得意识到这件事执行不了。我甚至会说，自由软件和开源在经济上已经死了、不可持续，因为有了 AI 生成的代码，几乎没人愿意为自己的工具付钱——AI 能以接近 0 美元的成本替他们生成缺的那个功能。维护是另一回事；但只要 token 成本继续下降，为什么还要等开源开发者去维护，直接让前沿模型以便宜得多、快得多的方式做掉？我只是替那个典型的、被 vibe coding 改造过的经理说一句罢了：他们会拒绝给那些自己在白嫖的成熟开源项目捐钱或付费。）

rvz 随后给出他认为真正发生过的例子。

> "They don&#x27;t have to release anything and most of these companies don&#x27;t care about openly violating the license terms even if they are caught.<p>Unless the license holder has a lot of money for litigation, it is unenforceable." — rvz [c:50508471]
> （译文：他们根本不需要公开任何东西，而且这些公司大多不在乎即使被抓到也在明目张胆地违反许可证条款。除非许可证持有者有钱打官司，否则根本不可执行。）

> "Truth Social is a clone of Mastodon (AGPLv3) and all they did was disclose the <i>vanilla source code</i> and not the <i>modifications</i> which that is required by the license." — rvz [c:50509148]
> （译文：Truth Social 是 Mastodon（AGPLv3）的克隆，而他们所做的只是公开了原版源码，没有公开许可证要求的那些修改。）

在这个帖子的语境下，AGPL 的「必须公开修改」条款被拿来做反例，恰恰说明主帖讲的「强制开源」早就存在，而且守不住。

更务实的一派则讨论软件商业模式本身怎么变。

> "Open source people have had half a century to figure out how to make money with fairly little success (aside from a dozen or so very notable projects, and looking at all my AI slop, I don&#x27;t see one of these hiding in there).<p>I don&#x27;t particularly care about copyright or whatever ethical arguments yo may come up with -- I write code mostly for money, as do my competitors -- if you can figure out a way to stop them from using AI, I&#x27;m fine with not using it either. I&#x27;m fairly skeptical you can close Pandora&#x27;s box though." — sorrywhat [c:50507717]
> （译文：开源的人花了半个世纪摸索怎么赚钱，成功率相当有限（除了那么十几个特别著名的项目；翻遍我手头这些 AI 垃圾代码，我没看到其中一个藏在这里）。我不太在乎版权，也不在乎你能提出什么伦理论点——我写代码主要是为了钱，我的同行也是。你要是能想出办法阻止他们用 AI，那我也不用 AI 无所谓。不过我相当怀疑潘多拉的盒子还能被关上。）

还有一条把「生成即开源」跟内容洪水挂上了钩。

> "We already have a growing discoverability problem in many areas of content and throwing more slop into the mix is not the solution. This place for example has become a dumping ground for people, usually with no other activity here, to advertise their shovelware AI projects." — add-sub-mul-div [c:50507693]
> （译文：我们在很多内容领域已经面临越来越严重的可发现性问题，再往里掺更多垃圾货不是解法。就拿 HN 本身来说吧，这里已经变成了一个垃圾场——那些通常在这上面没有别的活动的人，跑来推销他们的铲子级 AI 项目。）

### 七、GPL 派：copyleft 本来就在强制开源

还有一批人认为，主帖想要的「强制开源」根本不是新东西——GPL 早就在这么做了。

> "Right. Nobody must violate copyleft licences either!" — Insimwytim [c:50507715]
> （译文：没错。也没人可以不遵守 copyleft 许可证！）

> "&gt;First of all, nobody must force OpenSource.<p>No, GPL and copyleft licenses very much do and should force OpenSource by its nature. If someone uses GPL or AGPL and doesn&#x27;t open source, they should be forced to Open Source." — TZubiri [c:50507759]
> （译文：「首先，没人必须强制开源。」不对，GPL 和 copyleft 许可证从本质上就非常、也应该强制开源。如果有人用了 GPL 或 AGPL 却不开源，那就应该被强制开源。）

ada-h00k 把这件事说得最讲道理：GPL 当初写的时候没想过 LLM，但它的精神仍然成立。

> "That’s not an extreme view. Anyone who uses software under a copyleft license should also release any derivatives under the same license. While this isn’t currently the case legally since the GPL was never written with the possibility in mind that LLMs might be trained on it in the future it still aligns with the spirit of the license." — ada-h00k [c:50507772]
> （译文：那不是极端观点。任何使用 copyleft 许可证软件的人，都应该以同样的许可证发布其衍生作品。虽然从法律上讲目前并非如此——GPL 写下的时候从没考虑过 LLM 可能会拿它来训练——但这仍然符合许可证的精神。）

blagie 则把话说到了道德层面。

> "I don&#x27;t see extreme views in this article. When LLMs take creative content from copyleft code, the license says the output has to be copyleft. Otherwise, it&#x27;s theft.<p>If LLMs weren&#x27;t trained on AGPL&#x2F;GPL&#x2F;LGPL code, it&#x27;d be different. But they are." — blagie [c:50507743]
> （译文：我没觉得这篇文章里有极端观点。当 LLM 拿走了 copyleft 代码里的创造性内容时，许可证规定输出也必须是 copyleft，否则就是偷。要是没有用 AGPL／GPL／LGPL 代码训练 LLM，那就另说了。但事实是训练了。）

ozgung 给出的是这条路线上最冷静的反向推演。

> "This means “all software should be Open Source unless written fully by humans”, which practically means almost all software in the near future, which is a terrible idea for multiple reasons." — ozgung [c:50507654]
> （译文：这等于说「所有软件都该开源，除非完全由人类手写」——实际意味着不久的将来几乎所有软件都该开源，而这在多个理由上都是个糟糕的主意。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 主帖自相矛盾 | glitchc | 许可证存在的前提就是代码受版权保护 |
| 悖论一句话 | ubercow13 | 代码不可版权，按开源许可证发布就没意义 |
| 还有第三种类别 | wiremine | 不可版权不等于自动进入公有领域 |
| GPL 依赖版权 | jonathanstrange | 没有版权，任何人都能拿走随便改 |
| 类比失当 | delichon | 我也是在开源语料上「训练」出来的 |
| 同句复读 | sqreept | 这等于说学过开源代码的人此后只许产出开源代码 |
| 极端类比 | bakwan44 | 我通过看书学会识字，难道写的东西都得开源 |
| 许可证管分发不管学习 | g-b-r | 你多半不会把训练过的东西逐字背出来 |
| 开源价值在人工验证 | sturza | 开源是被人验证过的代码，OSS 生成的代码没有价值 |
| 判例方向相反 | viraptor | 当前这些案子演进的方向与主帖恰恰相反 |
| 误读 Thaler | carllerche | 那个案子问的是机器能否当作者，不是输出能否受保护 |
| 真实节点 | tkdb | 第一个重要先例是 2023 年的《Zarya of the Dawn》案 |
| 版权局已在准予登记 | echelon | agent 式开发是人类引导，按同一套理由可获版权 |
| 版权局有分量 | echelon | 法院经常站在版权局一边 |
| 法律不是代码 | unrented7977 | 朴素的传递推理套不到法律上 |
| 主张未过法庭 | partloyaldemon | 你的断言上过法庭吗 |
| 陈述可为真但未诉讼 | rookienumbers30 | 法院除了逻辑论证还依赖先例 |
| 训练量不是关键 | antonvs | 关键在数据从哪来、输出跟已有作品有多像 |
| AI 只是工具 | wolttam | 拥有项目的是人，LLM 只是一件工具 |
| 反馈烧进产品 | anself | 20 分钟编码对几小时测试，比例悬殊 |
| 已经这么做了 | jph | AI 代码用 Apache／BSD／GPL／MIT 多选许可证 |
| 有例外 | sicher | 高度领域特定、靠大量经验堆出来的那个不开源 |
| 根本执行不了 | rvz | 开源在经济上已经死了，没人愿意为工具付钱 |
| 除非有钱打官司 | rvz | 被抓到违规也无所谓，除非你有诉讼的钱 |
| 真实违例 | rvz | Truth Social 公开了原版源码，没公开修改 |
| 半个世纪的教训 | sorrywhat | 开源摸索了五十年赚钱，成功率相当有限 |
| slop 与可发现性 | add-sub-mul-div | 再往里掺更多垃圾货不是解法 |
| 没人必须违反 copyleft | Insimwytim | 也没人可以不遵守 copyleft 许可证 |
| copyleft 本就强制开源 | TZubiri | 用了 GPL 或 AGPL 却不开源，就该被强制开源 |
| 符合许可证精神 | ada-h00k | GPL 没想过 LLM，但精神仍然成立 |
| 否则就是偷 | blagie | 拿走 copyleft 代码的创造性内容，输出必须是 copyleft |
| 结论太激进 | ozgung | 等于说几乎所有软件都该开源，这是个糟糕主意 |

## 总体情绪

这场讨论的分歧不在结论，在方法。一个「AI 代码应该开源」的主张听起来温和、正确、无害，但评论区几乎没有人直接讨论它成不成立——大家拆的是它背后的每一个零件：许可证为什么要有版权才能存在，Monkey Selfie 到底判了什么，法律推理能不能像代码推理那样传递，模型输出跟训练语料的关系和版权保护的实际边界在哪里。

拆完之后的画面是：这条主张即使全部成立，也换不来任何东西。主帖自己就承认各国法律不一致；而评论区指出，不一致意味着没人执行；执行不了意味着主帖设想的那种「用许可证洗掉私有化」的机制根本不运转——Truth Social 已经演示过一遍了。而更实际的一层是，就算全世界的 AI 代码明天都开源，开源也不再是稀缺资源，因为没人再愿意为工具付钱。

最有意思的分歧藏在最后：主帖想用公有领域来换取公平，但 GPL 的支持者指出，四条自由恰恰是靠版权撑起来的。主张「AI 代码不该受版权保护」的阵营，很可能顺手拆掉了自己脚下最结实的地板。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | All AI-generated code should be Open Source（HN 主帖） | <https://news.ycombinator.com/item?id=50507303> |
| 2 | All AI-generated code should be Open Source（原文博客） | <https://jakub.jankiewicz.org/blog/ai-code-open-source/> |
| 3 | USCO 为 AI 生成艺术作品授予版权登记（评论中引用） | <https://journals.law.harvard.edu/jsel/2025/03/u-s-copyright-office-grants-registration-to-ai-generated-artwork/> |
| 4 | Invoke 因 AI 图像版权被诉（评论中引用） | <https://news.artnet.com/art-world/invoke-snags-first-ai-image-copyright-2608219> |
| 5 | Truth Social 的开源披露说明（评论中引用） | <https://help.truthsocial.com/legal/open-source/> |
| 6 | Revolt 的 AGPLv3 合规指控（评论中引用） | <https://insrt.uk/post/andrew-tate-stealing-software-revolt/> |
| 7 | axa：用 Axum 构建 Rust web 服务（jph 的项目） | <https://github.com/publicprojects-io/axa> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 639 分、339 条评论，归档抓取快照 2026-11-15 18:35 UTC，入库 100 条评论）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。文中关于判例（Doe v. GitHub、Thaler v. Perlmutter、Allen v. Perlmutter、Zarya of the Dawn）、美国版权局立场、GPL 与 copyleft 条款、以及 Truth Social、Revolt 等许可证合规实例的叙述，均为评论区参与者各自的观点，不代表本项目立场，也不构成任何法律意见。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
