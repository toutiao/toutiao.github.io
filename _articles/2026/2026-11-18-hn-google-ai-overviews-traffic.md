---
layout: post
title: >-
  AI 摘要吃掉了七成流量：柏林独立站 All About Berlin 的困境与 HN 上的争论
date: 2026-11-18
hn_id: 50542705
categories: [articles]
excerpt: >-
  柏林生活指南 All About Berlin 的作者说，Google AI Overviews 一年吞掉他七成流量；另一份随机对照实验测出 40%
  的点击降幅。评论区真正吵起来的不是流量，是「这算不算偷」。
tagline: >-
  八年柏林指南，七成流量蒸发，剩下的是「没有网站，只有一个带广告的聊天框」。
---

> 来源：HN 热门榜主帖 [AI is killing All About Berlin](https://news.ycombinator.com/item?id=50542705)（归档快照 397 分、347 条评论，入库 100 条），原文指向 [nicolasbouliane.com/blog/death-by-ai](https://nicolasbouliane.com/blog/death-by-ai)；同日关联帖 [Google's AI answers reducing search traffic by 40%](https://news.ycombinator.com/item?id=50540178)（437 分、311 条评论，入库 125 条），原文为 [revscope.co/blog/search-seo-geo-2026/](https://revscope.co/blog/search-seo-geo-2026/)（作者 slashdev，在评论区声明文章为自己所写）。归档评论分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值。引文保留 HN 原文的 HTML 实体与标签，逐条与归档评论比对。

## 原文概要

All About Berlin 是个柏林本地生活指南站点：2017 年建站，2020 年起线上运营，作者 Nicolas Bouliane 一个人写了 8 年。七年增长之后，它被 Google AI Overviews 拿走了七成到七成半的流量。搜索结果的顺序变了：以前搜到东西，点一下就进他的页面；现在先是一屏广告，然后是一段用他内容训练出来的 AI 答案，最后才是他的链接。作者说得很直白——他原本靠搜索流量养活站点，现在只剩四分之一的读者，「很快我就得找另一种付房租的方式」，所以他已经不写新指南，转而开始为那个「未来」做准备。

不只是钱的问题。这份工作有具体的公共用途：地方政府和联邦政府的办公机构会把人转介到他的指南上，柏林的移民局直接使用他整理的数据，两个政府门户和另外几个城市的同类网站都受他启发。原文里有一句被评论区反复引用的话——如果他的文字只是被混进一段 AI 答案里，他就失去了声音和受众，「没人会跟我握手、请我喝啤酒，也没人会告诉我他的入籍申请办得怎么样」。

原文还提到 Google 的一项新公告：AI 生成的答案将彻底取代搜索结果，并且答案里带广告。作者的结论是：「这就是互联网的未来。没有网站，只有一个带广告的聊天框。」他同时在 Mastodon、HN、LinkedIn、Twitter 上同步了这篇文章，并请其他受影响的站主联系他。

同日上榜的关联帖给出的是可量化的版本，作者是 slashdev（他在评论区三处声明「这篇文章是我写的」）。DataForSEO 的月度面板覆盖 2000 万关键词：带 AI Overview 的结果比例从 2024 年 9 月的 5.93% 涨到 2026 年 8 月的 61.43%；同一时期，featured snippet 从 8.96% 掉到 0.44%，discussions and forums 板块从 21.13% 掉到 7.42%——AI 摘要抢走的位置，原本正是这两块。

最硬的一条证据是一次随机对照实验：研究者给美国桌面 Chrome 用户装了个扩展，把人随机分组，一组隐藏 AI Overview，然后观察 2026 年 1 月到 2 月两周的真实搜索。在会显示 Overview 的搜索上，能看到它的组平均每次产生 0.37 次外链点击，看不到的组是 0.62 次，降幅 39.8%；完全没有外链点击的搜索比例从 54% 涨到 73%；广告点击则没有变化——说明 Google 刻意没有蚕食自己的广告收入。折算到整体，站点从 Google 拿到的自然点击损失约 18.5%。CTR 层面，2000 多个网站的样本里，桌面端首位结果的点击率从 17.83%（2025 年 9 月）掉到 7.43%（2026 年 8 月），一年跌 58%；移动端从 25.17% 掉到 20.80%。行业差异很大：健康 69.68%、金融 68.80%，服装 37.48%、餐饮 29.37%、房地产 22.27%。至于行业给出的应对办法 GEO（生成式引擎优化），作者的评价是它目前像占星术；数据佐证是 3 月份 AI 助手只给网站带来了 0.3% 的流量。

## 讨论焦点

### 一、这是 Google 滥用垄断，还是搜索本来就该这样

最常见的第一反应是把矛头指向垄断。有人直接给主帖的定性是 Google 在滥用垄断地位：

> "This here is about google, abusing their monopoly." — lukan [c:50543107]
> （译文：这件事说到底就是 Google 在滥用它的垄断。）

立刻有人反问，换成更多竞争者会怎样：

> "You see the issue as abusing monopoly? If there were more competitors with more chat bots, you think the situation would be better for All About Berlin?" — threatofrain [c:50543216]
> （译文：你把问题看成滥用垄断？如果有更多竞争者、更多聊天机器人，你觉得 All About Berlin 的处境会更好吗？）

lukan 的补充把这个区分讲清楚了——他反对的不是所有 AI，而是「不要聊天框，我是在找一个链接」：

> "I don&#x27;t want a chat box, when I am looking for a link. On the other hand, when I am looking for information, I do ask claude nowdays to find me sources. But I ain&#x27;t the majority." — lukan [c:50543272]
> （译文：当我在找一个链接时，我不想要聊天框。另一方面，当我在找信息时，我现在确实会让 Claude 帮我找来源。但我不是多数。）

关联帖里有人把这归结为 Google 自己的选择，而不是外力：

> "This is a Google search problem, and they could have defeated SEO sites if it weren&#x27;t more profitable for them. SEOs didn&#x27;t force Google to put 8 ads between the search bar and the first non-ad result, Google did.<p>Whatever Google is now, nobody would actually choose it if there were alternatives that competed on product, but there aren&#x27;t.<p>We all live in duopoly land where every extremely high margin software and hardware role is taken up by 2 of 7 companies." — taurath [c:50541154] [thread 2]
> （译文：这是 Google 搜索自身的问题；如果 SEO 站不是更赚钱，他们本来早就能把 SEO 站打掉。不是 SEO 逼 Google 把 8 条广告塞进搜索框和第一条自然结果之间的，是 Google 自己。<p>现在的 Google 长什么样，如果存在在产品层面竞争的产品替代品，没人会真的选它。但没有。<p>我们都活在双头垄断的世界里：每一个超高毛利的软件和硬件岗位，都被 7 家公司里的 2 家占着。）

而另一种看法把 AI 摘要说成是回归 Google 的初心：

> "Seems a lot closer to Google&#x27;s original mission... organising the world&#x27;s information and making it universally accessible and useful.<p>I suspect advertisers might disagree." — whh [c:50540954] [thread 2]
> （译文：这看起来更接近 Google 最初的目标——组织全世界的信息，让它普遍可得且有用。<p>我猜广告主不会同意。）

### 二、免费的是劳动：到底算不算偷

评论区最响的一组情绪是道德层面的。一条高赞提问把所有情绪拧成了一句话：

> "Is it just okay that these humongous companies just took all our work without paying us a dime?" — jeppester [c:50543020]
> （译文：这些巨头公司白白拿走我们的劳动、一分钱不付，这样就 OK 吗？）

针对「你既然公开了就该被拿走」的反驳，反方给出的理由是服务与价格：

> "Feel?  What do feeling have to do with it?  It is a service being offered.  Relatively fast T&#x2F;s without having to own the hardware and pay for the cooling.  How good the deal is is another question." — lynx97 [c:50543218]
> （译文：感觉？感觉跟这事有什么关系？这是一项被提供的服务：不用自己买硬件、不用付散热电费，就能有相对快的算力。这笔买卖划不划算是另一个问题。）

支持者立刻把「付费」和「署名」拆开：

> "It&#x27;s not the paying, it&#x27;s the fact that the &quot;provider&quot; stole the work without attribution." — tripledry [c:50543321]
> （译文：问题不在于付钱，在于「服务商」把劳动拿走了却没有署名。）

他把话说得更宽，指向整个契约：

> "Because 3 years ago, everyone had a reasonable expectation that any publicly available work would be appropriately credited and&#x2F;or compensated for, in accordance with both copyright law and open source software licenses.<p>You realize that even very permissive software licenses, like MIT or Apache-2.0, still require attribution? Now a few companies are making big bucks selling your ideas (and sometimes verbatim code) without adhering to the terms of that license.<p>The social contract is utterly broken. The legal situation is utterly questionable." — simonask [c:50543352]
> （译文：三年前，所有人都有一个合理的预期：任何公开的作品都会按版权法和开源许可证得到应有的署名或者补偿。<p>你意识到吗，连最宽松的开源许可证，比如 MIT 或 Apache-2.0，都要求署名？现在有几家公司靠卖你的想法（有时是逐字的代码）赚大钱，却没有遵守那些许可证的条款。<p>社会契约彻底崩了，法律状况极其可疑。）

老账被翻了出来——当年鼓吹「信息应当自由」的人，如今搬出同一套论证：

> "I find this line of argument hilarious given how much time was spent arguing copyright infringement isn&#x27;t stealing and &quot;information wants to be free!&quot; and intellectual property rights are corporate capture... when everyone wanted to pirate movies and games.<p>Sure came to bite these people back in the butt, didn&#x27;t it." — drstewart [c:50543197]
> （译文：考虑到当年花了多少时间论证「版权侵权不算偷」「信息应当自由」、知识产权是公司政治捕获……而那时人人都想盗版电影和游戏——我真觉得现在这套论证很可笑。<p>果然，报应来了，对吧。）

也有人做了区分：

> "I mean it&#x27;s probably fair to make a distinction between someone sitting at home pirating a movie for their own enjoyment, and a huge company using it&#x27;s already mear-absolute control over the internet ignoring copyright to further entrench itself as our digital overlord." — schubidubiduba [c:50543261]
> （译文：我觉得，把「有人坐在家里盗版电影自娱」和「一家公司凭借对互联网近乎绝对的控制无视版权、进一步把自己固化成我们的数字霸主」区分开来，应该是公平的。）

法律视角则更冷：

> "No theft or copyright infringement has been commited in the process.<p>Do we need new laws or taxes to retribute people who produce content being scraped and encourage people for providing knowkedge? Maybe." — prmoustache [c:50543857]
> （译文：这个过程里没有发生盗窃，也没有侵犯版权。<p>我们需不需要新的法律或者税收，来回报那些被抓取内容的产出者，并鼓励人们继续提供知识？也许吧。）

对这套「法律上没问题」的说法，反驳是拿诉讼结果当证据：

> "If that stance was so clear cut as you present it, I am sure  a ton of copyright holders would already have won their lawsuits.   Apparently not." — lynx97 [c:50543412]
> （译文：如果像你讲的那么斩钉截铁，我敢肯定一大堆版权持有人早就赢得诉讼了。显然没有。）

### 三、被摘要先杀掉的其实是内容农场

一派观点认为 Google 早就在自己动手毁掉搜索了，问题不在 AI：

> "Exactly, Google search declined because Google embraced SEO instead of fighting it." — account42 [c:50544339]
> （译文：正是。Google 搜索变差，是因为 Google 拥抱了 SEO 而不是与之对抗。）

最常被举的例子是菜谱站。菜谱站为了排名堆了大量无用前言，AI 摘要反而把它削干净了：

> "Recipe sites did that to themselves with their cancerous AEO shenanigans. Three pages of useless background drivel before I get to the recipe just so it ranks." — danielbln [c:50543150]
> （译文：菜谱站是自己作的——那种为了 SEO 而搞出的恶性 AEO 手段。为了让排名靠前，先给我三页没用的废话，才轮到真正的菜谱。）

用户视角里有人对这类站点被清退表示欢迎：

> "As a user, I am happy to see content spam trash to die and burn in hell." — miohtama [c:50540478] [thread 2]
> （译文：作为用户，我很高兴看到内容垃圾在烈焰中烧成灰。）

这句被反复引用的总结，则把 SEO 与 AI 摆成一条接力链：

> "SEO killed the web, AI killed SEO, and so it goes…" — pcarolan [c:50540597] [thread 2]
> （译文：SEO 杀死了互联网，AI 杀死了 SEO，然后就这样……）

### 四、来源枯竭：没有源头，答案从哪来

另一派的焦虑不在钱，在供给端。只要源头停更，摘要本身就会烂掉：

> "But in this case, AI can serve good answers because it takes them from All About Berlin (and other sources). By killing All About Berlin, it kills the source. Where will the answers come from then?" — palata [c:50543289]
> （译文：但在这个例子里，AI 能给出好答案，正是因为它从 All About Berlin（和其他来源）那里拿东西。杀掉 All About Berlin，就等于杀掉源头。那答案将从哪来？）

时间线被写得很具体：

> "Of course it does. It the info in their archive is not up to date, then the AI output is first less reliable, then outdated, finally entirely wrong. With policies, rules, laws, processes etc. changing all the time, that won&#x27;t take long. Then users will have to ignore the AI summary again, and look for human-input posts on reddit and other pages, like this one." — Bishonen88 [c:50543489]
> （译文：当然有影响。如果他们存档里的信息不新鲜，AI 输出会先变得不可靠，然后过时，最后完全错误。而政策、规则、法律、流程一直在变，这个过程用不了多久。到那时用户会不得不再次无视 AI 摘要，转而去 Reddit 之类的页面找真人写的帖子，就像这个页面一样。）

模型崩塌通常被当成技术问题，这里被换成了供给问题：

> "You don’t need a model collapse if you lose the sources for new data." — croes [c:50544153]
> （译文：当你失去新数据的来源时，根本不需要模型崩塌。）

也有人指出这场竞赛其实已经结束，因为筹码早就被收走了：

> "There is no race. Openai et al have sucked up all the information available and have them stored privately years ago. The worlds reaction was to remove some of the source information from the net and at the same time flood it with ai slop. So the process can&#x27;t be copied anymore, there is no way to build another openai, anthropic, meta or google ai." — ahofmann [c:50543451]
> （译文：这里没有比赛这回事。OpenAI 之类早就把所有可得信息吸进去、私下存了好几年。全世界的反应是把一部分源头信息从网上撤掉，同时用 AI 垃圾把它灌满。所以这个过程没法被复制了，再造一个 OpenAI、Anthropic、Meta 或 Google AI 是没有可能的。）

「人蜈蚣」的比喻说的是训练数据自我循环的问题：

> "But the centipede is LLMs training on LLMs regurgitations." — sph [c:50543350]
> （译文：但这只蜈蚣，是 LLM 训练在 LLM 的反刍物上。）

关联帖里则把矛头指向现实世界的地面真相：

> "Google doesn&#x27;t have feet on the ground, real world reviews, reports, testing of products, material ground truth comes from people who rely on traffic. This is self-defeating in the end because Google won&#x27;t have anyone to syphon data from." — Barrin92 [c:50540791] [thread 2]
> （译文：Google 没有双脚站在地面上——真实世界的评测、报道、产品测试，具体的地面真相来自那些依赖流量的人。到最后这是自我拆台，因为 Google 将再也没有人可以抽取数据。）

### 五、流量没了之后，独立站还能怎么活

偏向「适应」的评论者认为，旧模式本来就不可持续：

> "The status quo of small websites scraping together revenue that largely depends on Google sending traffic their way is, for better or worse, no longer valid." — jillesvangurp [c:50544468]
> （译文：小网站靠拼凑内容、主要靠 Google 导流来挣钱的现状，无论如何都已经不再成立了。）

他补了一句更冷的事实：很多小网站本来就不是为了钱：

> "A lot of small websites were never about the money to begin with. I never got a single dollar for putting anything on stack overflow, Github, various public forums, etc. and I still did that." — jillesvangurp [c:50544468]
> （译文：很多小网站从一开始就不是为了钱。我往 Stack Overflow、GitHub、各类公开论坛上放东西，从来没拿到过一分钱，而我一直在放。）

但现实对新产品的发现几乎全靠搜索：

> "But websites launch in the dark, practically invisible. If I search for it&#x27;s exact good&#x2F;service, no chance I&#x27;ll find it (even pre-AI). It&#x27;s pretty much a field of dreams with a sad ending, or a whole lot of work and money to buy traffic." — conductr [c:50541955] [thread 2]
> （译文：但网站是在黑暗里上线的，几乎没人看得见。就算在 AI 之前，我精确搜索某项商品或服务，也根本没机会找到它。这基本上就是一个有着悲伤结局的「阿甘的梦」，或者花一大笔钱去买流量。）

小众社区则给出了另一种活法——不靠可被搜索，而是靠临界规模：

> "As long as it’s something popular enough to have a certain critical mass —- maybe one thousand dedicated fans world wide —- there’s going to be places to hang out.<p>Who cares if it isn’t googleable.  There’s other ways to build community and other avenues to be recognized for your work." — bitmasher9 [c:50541643] [thread 2]
> （译文：只要它足够流行、有一定的临界规模——也许全球一千个铁粉——就总会有地方可以聚集。<p>搜不到又怎么样。还有别的办法建立社区，别的途径让你的工作被看见。）

也有人报告了相反的个案——流量没减少，只是换了个来源：

> "Yes this sucks for the open web but anecdotally we&#x27;ve been getting new clients cold off of, apparently, chatgpt. I guess it ingested info about our co-op and has been recommending it to people that ask it for agencies?" — komali2 [c:50540969] [thread 2]
> （译文：对开放网络来说这确实很糟，但就我们合作社的经验而言，新客户似乎是直接从 ChatGPT 来的。我猜是它摄入了我们合作社的信息，然后向那些来问「有哪些代理机构」的人推荐了我们。）

而数量级并不只有 40%：

> "40% if you&#x27;re lucky.  Our content-based market efforts (i.e. SEO clicks) are down more than 80% over the last 2 years." — jgalt212 [c:50540906] [thread 2]
> （译文：40% 就算你走运了。我们靠内容获客的努力（也就是 SEO 点击）过去两年掉了超过 80%。）

最终形态也许是把数据直接喂给模型：

> "Businesses will feed companies their info (like they always have done with directories) to keep things up to date. But it will increasingly once again just turn into mass-media advertising where the businesses expose just what they want to expose, and human-curation-at-large-scale will probably go mostly extinct in favor of small-scale networks not big enough to pop up in the AI searches and answers." — majormajor [c:50543777]
> （译文：企业会把自己的信息喂给这些公司（就像过去用黄页目录那样），好让内容保持新鲜。但它会再一次变成大众广告：企业只暴露它们想暴露的部分；而大规模的人工整理大概会基本消亡，只留下规模小到不会出现在 AI 搜索和答案里的网络。）

### 六、摘要里的广告：下一块战场

原帖作者预告的那个「带广告的聊天框」，在关联帖评论区被反复放大。第一个反应是简单的怀疑：

> "No, you will get ads. It will be all ads eventually. It always turns into ads." — Eddy_Viscosity2 [c:50540845] [thread 2]
> （译文：不，你会拿到广告的。最终全是广告。它总会变成广告。）

更细的忧虑是，模型里的广告比搜索广告更难识别、也更容易被定向：

> "Companies&#x2F;politicians&#x2F;wealthy people can simply pay for a model to be <i>generically favorable</i> to them, where positive words&#x2F;events are mentioned and negative aspects are given dynamically-generated excuses or buried. (Or unfavorable to opponents, if the model-company thinks they can avoid lawsuits over it.)<p>3. Broad bias is easier to purchase, where a consortium or political party can pay to favor one entire class of thing over another, without developing individual ads for specific products or candidates.<p>In the end, the risk-profile is similar to hiring a human &quot;personal assistant&quot;... who takes secret bribes to manipulate you." — Terr_ [c:50541226] [thread 2]
> （译文：公司、政客、有钱人可以直接付钱，让一个模型「总体上偏向」自己：好话被提及，负面部分被现场生成的借口掩埋（或者反过来对付对手，只要模型公司觉得自己能躲过诉讼）。<p>3. 广义的偏向更容易购买：某个联盟或政党可以付钱，让模型偏向整整一类事物，而不必为具体产品或候选人单独开发广告。<p>最终的风险画像类似于雇一个人类「私人助理」……而这个助理在收秘密贿赂来操纵你。）

于是「去广告」这个老问题在新的语境下重演了一遍：

> "The only way to strip all ads is to deliver no information.  They&#x27;re not going to all be as obvious as &quot;If you&#x27;re hungry, why not try the new Bacon BaconBacon from Wendy&#x27;s?&quot;" — fwip [c:50541684] [thread 2]
> （译文：唯一能彻底去掉广告的办法，就是什么都不提供。广告不会都长得那么明显——未必都是「饿了吗，不如试试 Wendy&#x27;s 新的 Bacon BaconBacon」这种。）

> "And if the AI folk have their way, it won&#x27;t stay in the chatbot either. When your day-planning agent or personal shopper gets ads, you won&#x27;t even see the text." — fwip [c:50541684] [thread 2]
> （译文：而且如果 AI 那帮人如愿，这事也不会只发生在聊天框里。当你的日程规划 agent 或者代购助手开始收到广告时，你连文字都看不见。）

主帖这边，有人直接把「谁来买下答案」说成了竞价问题：

> "The example search query given by nicolas is &quot;Best german bank account for foreigners&quot;. One of the banks will just pay Google to be the designated, erm, &quot;sponsored&quot;, response." — antiloper [c:50544372]
> （译文：Nicolas 举的那个搜索词是「Best german bank account for foreigners」。总会有一家银行付钱给 Google，成为那个指定的、呃、「赞助」答案。）

而关于广告收入本身，评论区的判断是还没到时候：

> "It grew because turned the lever to screw advertisers. Once they realize they don’t make money, Google ad business will crash." — skeptic_ai [c:50542345] [thread 2]
> （译文：它增长是因为拧了拧压榨广告主的那颗螺丝。等他们意识到自己赚不到钱了，Google 的广告业务就会崩。）

### 七、用户其实不怎么在乎

这是整场讨论里最尴尬的一层：一大半用户根本不觉得这是问题。

> "I don&#x27;t really care who&#x27;s behind the answer as long as it is right (which 99% of the time it is) so there is no loyalty at all, no need to switch, no need to try the competition, nothing. AI is the answer and it will get better with time" — Kuyawa [c:50540625] [thread 2]
> （译文：只要答案是对的（99% 的时候都是），我根本不在乎答案背后是谁。所以完全不存在忠诚度，不需要切换、不需要尝试竞品，什么都不需要。AI 就是答案，而且会随时间变得更好。）

另一些人正好相反，他们要的是原始信息：

> "Every time I do a google search to cross check something, the AI answer has been incomplete or incorrect.<p>I can only assume the answers I don&#x27;t know are the same.<p>I don&#x27;t want the AI answer, I want the <i>actual</i> information." — icehawk [c:50542340] [thread 2]
> （译文：我每次用 Google 搜索做交叉验证，AI 给的答案都不完整或者不正确。<p>我只能假设那些我没法核对的答案也一样。<p>我不想要 AI 的答案，我要的是<i>真实</i>信息。）

一位站主的观测则说明，现在的访问量里有多少是人：

> "My homepage gets about 400 hits a day, but when I look into it, about 370 are scraping bots and 30 are actual people." — jdw64 [c:50540760] [thread 2]
> （译文：我的主页每天大概有 400 次访问，但我查了一下，其中约 370 次是抓取机器人，30 次才是真人。）

而关于「你的工作被拿走了」，最现实也最无奈的一条回复，是把它当成人人都会遇到的历史进程：

> "It&#x27;s ok, though, because if a big tech corporation decides to do it then that&#x27;s just inevitable progress making the world better and you should change jobs. Except, according to them, all jobs will soon become obsolete and you&#x27;re destined to be ruled by a feudalistic god-emperor." — mrtesthah [c:50542935]
> （译文：不过没关系，反正如果某个大科技公司决定这么做，那就是不可避免的进步，世界会变好，你应该换工作。只不过按他们的说法，所有工作很快都会过时，而你注定要由一位封建神皇统治。）

说到底，多数人的判断很朴素：

> "It&#x27;s fucked<p>But it&#x27;s here now, and that&#x27;s not going to change. There is too much to gain, and the wider public doesn&#x27;t care. Or even understand." — jaapz [c:50543196]
> （译文：这事糟透了。<p>但它已经来了，不会再变。可赚的太多了，而且更广泛的公众不在乎，甚至不理解。）

### 八、这其实是一笔五月的旧账

最后有个插曲：有评论者发现，这篇文章和它提到的那次 Google 公告都是五月的旧事，这次是重新浮上首页：

> "What? Why is this being posted? This post and the respective announcement by Google are from May!?" — ShadowOfThePit [c:50542943]
> （译文：什么？为什么现在发这个？这篇帖子和 Google 相应的公告都是五月的！）

原文的「Mentions」列表印证了这一点：最早一批报道是 2026 年 5 月 24 日的 Telegraph、5 月 25 日的 Forbes、5 月 27 日的 Stockhouse，列表里还留着 7 月 14 日（NPR 的 The Indicator）和 8 月 4 日（The Ringer）的更新链接——说明这篇博客首发于 5 月并在此后持续修订；作者自己也把 5 月那次 HN 讨论的链接贴在了文末。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 这是 Google 滥用垄断 | lukan | 说到底就是 Google 在滥用垄断 |
| 换个竞争者也无济于事 | threatofrain | 更多聊天机器人并不会让 All About Berlin 更好 |
| 反对的是聊天框，不是 AI | lukan | 我在找链接时不想要聊天框 |
| 是 Google 自己选择的结果 | taurath [thread 2] | 本来能打败 SEO 站，只是那样不赚钱 |
| 更接近 Google 的初心 | whh [thread 2] | 组织全世界的信息，让它普遍可得 |
| 拿走劳动不付钱 | jeppester | 巨头公司白白拿走我们的劳动 |
| 服务成立，感觉无关 | lynx97 | 这是一项被提供的服务，感觉算什么呢 |
| 关键在署名不在付费 | tripledry | 「服务商」偷走了劳动却没有署名 |
| 社会契约已崩 | simonask | MIT 都要署名，这几家公司不遵守 |
| 当年的「信息应当自由」 | drstewart | 报应来了 |
| 公司垄断与个人盗版有别 | schubidubiduba | 数字霸主和无害的自我盗版不是一回事 |
| 法律上不构成偷 | prmoustache | 抓取不等于盗窃，也没有侵犯版权 |
| 诉讼结果最诚实 | lynx97 | 真那么清楚，一堆版权持有人早就赢了 |
| Google 拥抱了 SEO | account42 | 搜索变差是因为它没跟 SEO 作对 |
| 菜谱站自作自受 | danielbln | 那些恶性 AEO 手段 |
| 内容垃圾该烧掉 | miohtama [thread 2] | 作为用户我很高兴 |
| SEO 杀死了互联网，AI 杀死 SEO | pcarolan [thread 2] | 一棒接一棒 |
| 杀源头就是杀供给 | palata | 答案将从哪来 |
| 存档一过时，答案就烂 | Bishonen88 | 先不可靠，再过时，最后全错 |
| 失去来源就不需要模型崩塌 | croes | 新数据没了，别的都无所谓 |
| 这场竞赛其实已结束 | ahofmann | 筹码早被私下收走了 |
| LLM 训练在 LLM 反刍物上 | sph | 蜈蚣 |
| Google 没有脚站在地面上 | Barrin92 [thread 2] | 地面真相来自依赖流量的人 |
| 靠 Google 吃饭的旧模式已失效 | jillesvangurp | 无论好坏都不再成立 |
| 很多小站从来不为钱 | jillesvangurp | 我在 Stack Overflow 从没拿到过一分钱 |
| 网站在黑暗里上线 | conductr [thread 2] | 一个有着悲伤结局的阿甘的梦 |
| 靠临界规模活着 | bitmasher9 [thread 2] | 全球一千个铁粉就够 |
| 新客户来自 ChatGPT | komali2 [thread 2] | 我们合作社就是这么接到客户的 |
| 实际跌幅远超 40% | jgalt212 [thread 2] | 我们的 SEO 点击两年掉了 80% 以上 |
| 未来是企业直接喂数据 | majormajor | 大规模人工整理会基本消亡 |
| 最终全是广告 | Eddy_Viscosity2 [thread 2] | 它总会变成广告 |
| 模型可以被定向成「友好」 | Terr_ [thread 2] | 相当于雇了个收 bribes 的私人助理 |
| 去广告等于不提供信息 | fwip [thread 2] | 你的代购助手拿到广告时连文字都看不见 |
| 答案可以被竞价买下 | antiloper | 总有银行买下那个「赞助」答案 |
| 广告收入迟早崩 | skeptic_ai [thread 2] | 等他们赚不到钱 |
| 用户不在乎答案是谁给的 | Kuyawa [thread 2] | AI 就是答案 |
| 我要真实信息 | icehawk [thread 2] | AI 答案一直不完整或不正确 |
| 访问量里七成是机器人 | jdw64 [thread 2] | 400 次访问里只有 30 次是人 |
| 不可避免的进步 | mrtesthah | 你应该换工作 |
| 已经回不去了 | jaapz | 可赚的太多，公众不在乎 |
| 这是五月旧帖 | ShadowOfThePit | 公告也是五月的 |

## 总体情绪

这帖表面上是两个帖子——一个柏林站长讲自己的生存危机，一个数据公司用随机对照实验把同一件事量化——实际清算的是一份旧账：开放网络靠「Google 导流、网站变现」这条单腿走路走了十几年，现在这条腿正在被抽掉。评论区没有分出胜负，但分歧的形状很清楚：一半人认为这是垄断者对内容生产者的系统性掠夺，另一半人认为这只是一个早已该到来的产品替换周期，真正的错误在站长自己——把商业模式押在别人的流量上。

有意思的是，两边都同意了一件事：AI 摘要对「问一个问题」这件事是净改善。多数用户根本不关心谁写的原文，他们只关心答案在不在。这种冷漠不是评论区发明的，而是数据本身说明的——最高点击率的行业是健康和金融，最先被清退的是菜谱站和内容农场。

真正让讨论变调的是「以后谁来提供答案」这个问题。一家写了八年指南的柏林站点掉七成流量，在财务上是坏消息，在结构上是坏消息：它同时意味着下一代摘要会少一个可靠来源。有人把它说成模型崩塌的另一种形式——不需要模型坏掉，只需要源头停止更新。还有人指出更冷的一层：这些数据早就被收进私人档案，这场竞赛没有后来者。

原帖作者那句「没有网站，只有一个带广告的聊天框」，在评论区被拆成了三段各自成立的话：广告是确定会来的；模型的偏向是可以被买来的；而用户是不在乎的。三段合起来，就是这场讨论最不好听、也最接近事实的结论。

摘要可以复制一个站长八年的经验，却复制不了那次握手——而这正是 Google 不需要付账的那一部分。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | AI is killing All About Berlin（HN 主帖） | <https://news.ycombinator.com/item?id=50542705> |
| 2 | 原文：AI is killing All About Berlin — Nicolas Bouliane | <https://nicolasbouliane.com/blog/death-by-ai> |
| 3 | Google's AI answers reducing search traffic by 40%（HN 关联帖） | <https://news.ycombinator.com/item?id=50540178> |
| 4 | 原文：Google's AI Overviews cut clicks to websites by 40%（revscope） | <https://revscope.co/blog/search-seo-geo-2026/> |
| 5 | 5 月那次 HN 讨论（作者在原文文末贴出） | <https://news.ycombinator.com/item?id=48283127> |
| 6 | 原文提到的同类案例：Google and AI Are Killing Travel Blogs Like Mine | <https://www.dangerous-business.com/how-google-and-ai-are-killing-travel-blogs-like-mine/> |
| 7 | 原文提到的同类案例：StackOverflow's traffic down 99% from its peak | <https://ppc.land/stack-overflow-drops-to-1-442-questions-in-july-down-99-from-2014-peak/> |
| 8 | 关联帖评论区引用的 Google Zero 报道（The Verge） | <https://www.theverge.com/24167865/google-zero-search-crash-housefresh-ai-overviews-traffic-data-audience> |
| 9 | 关联帖评论区引用的 BBC 报道 | <https://www.bbc.com/news/articles/cm9jzdqpxy48o> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 50542705 归档快照 397 分、347 条评论，入库 100 条；关联帖 50540178 为 437 分、311 条评论，入库 125 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，并经 HN 评论接口复核（ID 存在、作者一致），保留 HN 原文的 HTML 实体与标签。归档评论的分数字段均为 0（HN 未返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。带 `[thread 2]` 的引文来自关联帖。

原文事实（All About Berlin 的建站时间与流量跌幅、公共用途、Google 公告；DataForSEO 的关键词面板数据、Agarwal 与 Sen 的随机对照实验数据、Pew 与 CTR 面板数据、各行业 Overview 覆盖率、GEO 定义）转述自两篇原文；评论中涉及「没有比赛」「模型会被定向付费」「法律上不构成偷」等说法属于评论者个人判断，本文按原帖立场并列呈现，不做事实判定。文中「七成流量」为主帖作者自述，「40%」为关联帖所引随机实验结论。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
