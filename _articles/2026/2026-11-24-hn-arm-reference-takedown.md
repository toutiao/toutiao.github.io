---
layout: post
title: >-
  Arm 的律师函与一个 AArch64 文档站：11 天倒计时里的商标、版权与文档可达性 — HN 讨论摘要
date: 2026-11-24
hn_id: 50617499
categories: [articles]
excerpt: >-
  772 分、158 条评论。Jon Palmisc 维护的 AArch64 指令集文档站收到 Arm 律师通知，12 月 4 日关站，理由是商标与手册版权。评论区真正争的不是「该不该关」，而是「为什么非得关」——律师函打在了比 Arm 官网更好用的那份文档上。
tagline: >-
  被下架的那份，比官网那份好用。
---

> 来源：HN 讨论主帖 [Per Arm's request, this site will be discontinued on 4 December 2026 :(](https://news.ycombinator.com/item?id=50617499)（772 分，158 条评论），指向 Jon Palmisc 的 [Jon's Arm Reference](https://arm.jonpalmisc.com/)。本篇为 single post 模式（HN 首页 /best 与 /news 近 48 小时列表中无同主题高分开帖）。主帖 2026-11-23 19:17 UTC 提交，归档快照 2026-11-23 23:41 UTC（772 分 / 158 条评论），入库 102 条评论，归档分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。引文按归档评论原文截取，原文中的 `<p>` 分段以 `<br>` 呈现，HTML 实体按归档原文保留；少数未进入归档上限的评论（作者本人置顶说明、部分高赞回复）按 Algolia items 接口逐条比对原文与作者。

## 原文概要

帖子本身就是一份停站公告。站点是 Jon Palmisc 的 arm.jonpalmisc.com，标题是 Jon's Arm Reference，内容是 AArch64 指令集与系统寄存器的参考文档，覆盖 Armv8-A 与 Armv9-A 架构。公告原文很短：

> **PER ARM'S REQUEST, THIS SITE WILL BE DISCONTINUED ON 4 DECEMBER 2026. :(**<br>Arm's lawyers have notified me to take down this site or face legal action.<br>To all of the fans of this site over the years (even the ones at Arm): thank you for your support! I'm glad I could provide a resource so many people found value in. I will look into solutions that can potentially keep bookmarks and links working.<br>— Jon

按帖子时间算，停站日距公告只有 11 天。

站点本身的技术细节也说明了它为什么被人依赖。首页是两份索引：指令侧分 Base、SIMD、SVE、SME 四块，寄存器侧分 AArch64 与 AArch32 两块，每页顶部和每个页面都有搜索框，可以直接搜指令名或寄存器名。整套页面靠 WebAssembly 渲染——站点底部专门留了一句提示，说浏览器不支持或禁用了 WebAssembly（举的例子是 Apple 的 Lockdown Mode）就会看到这条说明而不是搜索框。

作者本人在评论区置顶补充了 Arm 的具体诉求，这是全帖信息量最大的一条。

> "Hi, didn&#x27;t expect to see this here, so adding a bit of info:<br>They are requesting removal stating that I am using their trademarks and IP by hosting their documentation, which seems hard to work around while still keeping the site useful.<br>People have contacted me offering to host mirrors, or suggesting I lawyer up or release the source code (sans Arm IP) to generate the same site for personal use. I&#x27;ll be looking into all of these options.<br>For those unfamiliar with this site until now: it&#x27;s the ISA documentation, but with search and without all the popups and bloat. The aim has always been to make it the most comfortable and bullshit-free browsing experience for people who need these docs daily.<br>Thanks for the support, everyone! :)" — jonpalmisc [c:50618088]
> （译文：没想到会在这里看到这个帖子，补充一点信息：<br>他们要求下架的理由是，我托管他们的文档时使用了他们的商标与 IP，而这在保持站点有用的前提下很难绕开。<br>已经有人联系我表示愿意托管镜像，也有人建议我请律师，或者把源代码（不含 Arm IP）开源出来，让每个人自己生成同样的站点。我会把这些方案都考虑进去。<br>给此前不熟悉这个站的人一句话：它是 ISA 文档，但带搜索，而且没有那些弹窗和臃肿代码。这个站的目标一直是给每天需要查这些文档的人，提供最舒服、最少废话的浏览体验。<br>谢谢大家的支持！）

## 讨论焦点

### 一、Arm 为什么要动真格：文档公开是一种竞争策略

最早的问题来自一位读者，问的是动机而非法律。

> "I have only one question: why does this bother ARM (and its layers) at all?" — whydoyouasking [c:50617653]
> （译文：我只有一个问题：为什么这件事会让 ARM（以及它的层层下属）这么在意？）

有人接着抛出一个更具体的猜测：Arm 是不是在防 RISC-V。

> "I&#x27;ve personally noticed in the last ~5 years or so, ARM has become increasingly closed off with the information they have available about their architecture and internals. I wonder if it&#x27;s to stave off RISC-V people?" — dbl000 [c:50617671]
> （译文：我个人注意到过去大约五年里，ARM 对外公开的架构与内部信息越来越封闭。我怀疑这是为了防 RISC-V 那批人？）

这条猜测很快被同一位读者自己否掉了。

> "Why RISC-V? Doesn&#x27;t make much sense." — ACCount39 [c:50617928]
> （译文：为什么是 RISC-V？这讲不通。）

他随后把「封闭」这件事放进了 2026 年的语境里。

> "But I think it might just be the usual corporate brainrot.<p>It&#x27;s 2026, AI agents are loose upon the world - and yet, companies still love to hide the documentation people (and AIs) need to make better use of their products behind &quot;contact sales&quot;, &quot;sign the NDA&quot; and &quot;forsake the rights to your immortal soul&quot;." — ACCount39 [c:50617928]
> （译文：但我觉得这多半就是惯常的企业脑腐。<br>现在是 2026 年，AI agent 已经在世界上四处游荡了——可公司仍然热衷于把人们（以及 AI）真正需要用好自家产品的那部分文档，藏在「联系销售」「签 NDA」「放弃你不朽灵魂的权利」后面。）

把这条和文档站的对照放在一起，评论区里最阴的那条推论就出来了。

> "Cynic in me thinks the reason you would gate valuable information in the age of AI is to offer that valuable information behind an MCP paywall. But first you need to shut down anyone offering it for free. I hope I&#x27;m wrong" — hakanito [c:50618258]
> （译文：我心里那句刻薄话是：你想在 AI 时代把有价值的信息变成门禁，动机大概是想把这些信息放进 MCP 付费墙后面。但第一步得先关掉所有免费提供它的人。希望我想错了。）

这条推论没有证据，但它精准命中了一个事实：Arm 自己的文档站并不好使——后面第五节会看到具体有多难使。

### 二、版权：内容是手册的逐字复制，fair use 在这里站不住

讨论里最硬的一块事实，是这个站的内容到底是什么做的。

> "It&#x27;s probably due to the fact that the content is verbatim copies from ARM manuals.<p>(Not expressing an opinion on the need&#x2F;utility of this site or what ARM should do, but it&#x27;s legally a copyright violation)<p>Edit: Also, the ARM disclaimers&#x2F;patent&#x2F;copyright&#x2F;export control legalese has been stripped. That&#x27;s going cause issues with the lawyers." — sam1714 [c:50617714]
> （译文：很可能是因为内容是 ARM 手册的逐字复制。<br>（我不对这个站点的必要性与价值、以及 ARM 该怎么做发表意见，但从法律上说这是版权侵权。）<br>补充：另外，ARM 那套免责声明／专利／版权／出口管制的法务文字被剥掉了。这会让律师那边出问题。）

被质疑的是「逐字」这个说法。有人给出了站方一侧的完整论证：组织方式和导航与官方文档完全不同，描述部分才不得不引用原文。

> "The organization of the information and the navigability are very different from the Arm documentation.<p>For the actual descriptions of instructions and registers there is no alternative for quoting the exact descriptions from the Arm documentation.<p>I cannot consider this site as anything else but fair use, because it does not provide financial gains to the author and it does not cause any financial losses to the Arm company, because the quoted documentation is freely available." — adrian_b [c:50618597]
> （译文：信息的组织方式和可导航性与 Arm 官方文档非常不同。<br>但对于指令和寄存器的实际描述，除了引用官方文档的原文之外没有别的选择。<br>我只能把这个站点视为合理使用：作者没有从中获利，也没有给 Arm 公司造成经济损失，因为被引用的文档本来就是免费公开的。）

这条论证被两处反驳。第一处是「换种说法」——描述可以重写。

> "That&#x27;s not true. Things can always be phrased differently, at least in English. There might be languages in which things can&#x27;t be rephrased, but this site seems to be in English." — joemi [c:50618955]
> （译文：这不对。事情总可以换个说法，至少英语可以。也许有些语言没法改写，但这个站看起来是英语的。）

第二处更致命：逐字、整份的搬运会让 fair use 这条抗辩整体崩掉。

> "Fair use tends to fall apart when you take copyrighted material verbatim and in its entirety. There&#x27;s more to the analysis than &quot;does it provide financial benefits to the author&quot;!" — tptacek [c:50619183]
> （译文：当你把受版权保护的材料逐字、完整地拿走时，合理使用这套抗辩基本就散架了。分析要比「是否给作者带来经济收益」复杂得多！）

还有一句更朴素的提醒：同样的文档在 Arm 官网本来就免费。

> "You&#x27;re aware that the same documentation is available on ARM&#x27;s website for free?" — smallpipe [c:50619005]
> （译文：你知道同一份文档在 ARM 官网上是免费提供的吧？）

但「免费可得」这一点本身，在商业逻辑里未必成立。有人把 Arm 的商业模式摊开讲，这是全帖最反直觉的一段。

> "The manuals <i>are</i> ARM&#x27;s main product!<p>They don&#x27;t make CPU&#x27;s...     They don&#x27;t even really design CPU&#x27;s anymore.     Instead they make available a <i>reference design</i> - which isn&#x27;t used by many people because it isn&#x27;t very efficient - and a <i>manual</i> for how the instruction set works." — londons_explore [c:50618861]
> （译文：手册<i>才是</i> ARM 的主要产品！<br>他们不造 CPU……现在甚至已经不怎么设计 CPU 了。他们提供的是一个<i>参考设计</i>——效率不高，所以用的人不多——以及一本说明指令集怎么运作的<i>手册</i>。）

按这个说法，站方做的不是「偷走文档」，而是把 Arm 真正在卖的东西（手册，以及照手册实现 CPU 的权利）绕过了价格与条款。

### 三、商标：naked licensing 与「不维权就丢商标」

法律讨论的另一支在商标上，而这条线内部也分裂了。

一派认为 Arm 有维权的法定义务，理由是 naked licensing doctrine。

> "The Lanham Act and common-law &quot;naked licensing doctrine&quot; requires companies to defend their trademark in order to keep it.   And if they license it out, they are required to quality control how it is used, or they will lose their trademark.<p>If you simply let other people use your trademark, either implicitly or explicitly, you lose it.<p>They could license it out, but they&#x27;d have to do it in an official capacity and actively police the content on the site.  It would honestly be more simple to just hire the guy." — kube-system [c:50619312]
> （译文：《兰哈姆法》和普通法上的「naked licensing（裸授权） doctrine」要求企业维护自己的商标，否则商标就不保得住。而且一旦授权出去，就必须对使用方式做质量管控，否则也会失去商标。<br>如果你只是默许或明许别人使用你的商标，你就会失去它。<br>他们当然可以授权出去，但那就得以官方名义授权、还得主动巡查站点上的内容。老实说，直接把这个作者招进来更简单。）

另一派认为这根本不需要走到发律师函这一步。

> "They don&#x27;t need to license their trademark to someone providing information on their product. If he was selling his own chips then he would need a license, but that isn&#x27;t at all what was happening. They could have requested he put a note saying &quot;arm is a trademark of arm inc&quot;. Nothing beyond that was necessary." — f33d5173 [c:50620137]
> （译文：向一个在提供自家产品信息的人授权商标，他们根本不需要这么做。如果他在卖自己的芯片，那才需要授权，而事实完全不是这样。他们只要要求他加一行「arm 是 arm inc 的注册商标」就够了，别的都不必要。）

还有更直白的一条：没有任何法律要求公司发下架通知。

> "There are no laws that require a company to issue copyright and trademark takedowns; they could have easily granted permission instead." — cwillu [c:50618435]
> （译文：没有任何法律要求公司发出版权或商标下架通知；他们本来完全可以给个许可。）

而商标注册本身的口径，把「文档」直接写进了类别里。

> "ARM is trademarked in the goods and services categories of &quot;Electronic downloadable materials, namely, electronic downloadable instruction and development manuals, datasheets and brochures&quot;" — kube-system [c:50620253]
> （译文：ARM 在「电子可下载材料，即电子可下载的指令与开发手册、数据手册与宣传册」这个商品与服务类别下有注册商标。）

也就是说，站方在做的事情——把电子版指令手册抓下来挂到自己的域名下——正好落在 Arm 自己注册的保护范围里。

### 四、法务流程：律师该向谁汇报

讨论里最有共鸣的一支不谈法律，谈的是公司内部谁说了算。

> "This is why in most companies lawyers should report to an engineer (or someone who understands the business) who signs off on these things.<p>Going after this merely makes life harder for people ultimately providing value&#x2F;income to ARM." — chmod775 [c:50617833]
> （译文：这就是为什么在大多数公司里，律师应该向工程师（或者真正懂业务的人）汇报，由他们来签字拍板。<br>追究这件事，只是让那些最终为 ARM 创造价值／收入的人更难受。）

同一位读者补了一句更刺的。

> "It&#x27;s really embarrassing that ARM didn&#x27;t instead offer to buy it out from you or a job. Some lawyer got wind of it and did the lawyer thing, instead of the useful thing of suggesting someone consider bringing you in to modernize their solution." — giancarlostoro [c:50618683]
> （译文：ARM 没有提出买断你的站、或者给你一份工作，而是这样收场，真的很难看。只是某个律师听到了风声，然后做了律师该做的事，而不是做有用的事：建议有人考虑把你请进来，帮他们把方案做得更现代。）

还有一条来自处理过这类案件的人的判断，把这件事还原成了流程事故。

> "having dealt with these low level trademark cease and desist orders, often it’s just &quot;another case&quot; on the junior lawyers desk to process and bill the client (ARM, in this case).<p>In other words, arm is probably not aware of this case specifically." — xyst [c:50619026]
> （译文：处理过这类低层级商标停止侵权函之后会发现，它常常只是初级律师桌上「另一个案子」，流程是处理掉、然后给客户计费（这里就是 ARM）。<br>换句话说，ARM 大概并不具体知道这个案子。）

### 五、镜像与存档：关站公告本身就是一份索引

停站公告发出后几小时内，最实际的反应是抢存档。

> "I expect a dozen mirrors of this to exist by tomorrow morning." — space_ghost [c:50617590]
> （译文：我预计明天早上就会有十二个这样的镜像出现。）

> "Streisand-ing already at full pump." — supersimpleguy [c:50617614]
> （译文：反向操作（Streisand effect）已经全速开动了。）

有人直接贴出了 archive.org 的快照链接。

> "https:&#x2F;&#x2F;web.archive.org&#x2F;web&#x2F;20261123180652&#x2F;https:&#x2F;&#x2F;arm.jonpa..." — h3lp [c:50617665]
> （译文：https://web.archive.org/web/20261123180652/https://arm.jonpa...）

真要自己存一份，技术上比想象中简单——有人在评论区问怎么本地归档，答案是一行命令。

> "What is an easy way to archive this website locally? I&#x27;m not a Web guy so this is obviously a dumb question -- Save as doesn&#x27;t work, right? Because of the scripts and such. Time to pull out an LLM..." — ferguess_k [c:50617912]
> （译文：把这个网站在本地归档，有什么简单的办法吗？我不是搞 Web 的，所以这个问题显然很蠢——另存为不行吧？因为那些脚本之类的。要不要让 LLM 上场……）

> "seems to be a static site. &quot;wget -m&quot; will do" — dmitrygr [c:50617943]
> （译文：看起来是个静态站，`wget -m` 就够了。）

更尴尬的是，这类替代品早就存在——Stanford 的服务器上已经有一份同类的 AArch64 指令页。

> "I don&#x27;t see much difference between this: https:&#x2F;&#x2F;arm.jonpalmisc.com&#x2F;latest_aarch64&#x2F;abs<br>And this: https:&#x2F;&#x2F;www.scs.stanford.edu&#x2F;~zyedidia&#x2F;arm64&#x2F;abs.html<br>Are people using variants of the same conversion tool to extract this from the Arm documentation?" — fweimer [c:50617738]
> （译文：我看不出这两个页面有什么区别：https://arm.jonpalmisc.com/latest_aarch64/abs<br>和这个：https://www.scs.stanford.edu/~zyedidia/arm64/abs.html<br>大家是不是在用同一个转换工具的不同变体，从 Arm 文档里提取出来的？）

玩笑也被提了出来：既然要关，不如换个架构继续做。

> "Thanks for hosting this for so long.  I say this in jest (because it&#x27;s not functionally filling the same need), but if you wanted to host https:&#x2F;&#x2F;riscv.jonpalmisc.com&#x2F; none of us in the RISC-V community would be upset at all. :grin:" — thebeardisred [c:50618935]
> （译文：感谢你这么多年的托管。我这是开玩笑说的（毕竟功能上并不是同一件事），但如果你想托管 https://riscv.jonpalmisc.com/，我们 RISC-V 社区没人会不高兴的。😉）

真有人接了话，用的是最朴素的那种基础设施。

> "If it would be useful to you in any way, even tangentially, you can email us for a free-forever account." — rsync [c:50618215]
> （译文：如果你觉得这个站在任何意义上、哪怕只是顺带有用，可以发邮件给我们申请一个永久免费账号。）

> "Can confirm, even after having paid substantially more than free for my forever rsync.net account, useful doesn&#x27;t even begin to describe it. This offer would totally make me feel better." — boomskats [c:50618831]
> （译文：可以作证：我那个永久 rsync.net 账号付的钱比免费多得多，好用程度根本没法形容。这个提议让我感觉好多了。）

### 六、官方文档有多难使，以及作者打算怎么办

要理解这场争论为什么这么热烈，得看被诉的文档和官方文档之间的差距。评论者把两边的体验并排放了出来。

> "It used to be a tediously-converted extraction from a 2000 page PDF.<br>Now Arm has realized people like to access it like this, so it&#x27;s available on their website:<br>https:&#x2F;&#x2F;support.arm.com&#x2F;documentation&#x2F;ddi0487&#x2F;md&#x2F;-Part-C-The...<br>They&#x27;ll track you and push you to log in and accessing the site requires accepting terms about what you&#x27;re allowed to do with the documentation, but if your browser looks reasonable and you click the right dialog box options you can see the content without generating an account." — LeifCarrotson [c:50617907]
> （译文：它过去是从一份 2000 页的 PDF 里费劲转换出来的。<br>现在 Arm 意识到大家喜欢这样访问了，于是官网上也有了：<br>https://support.arm.com/documentation/ddi0487/md/-Part-C-The...<br>他们会追踪你、催你登录，访问时还要接受一份关于你能怎么使用这些文档的条款；但只要你的浏览器看起来正常、并且在对话框里点对选项，不注册账号也能看到内容。）

> "And force you to wait 30 seconds to load all their crapware JS apparently" — pastel8739 [c:50618076]
> （译文：而且据说到还得等 30 秒让他们那堆垃圾 JS 加载完。）

对照之下，被诉的那个站的卖点很清楚：有搜索、无弹窗、无臃肿。评论区里也有人拿更早的行业记忆作比。

> "How odd, when I was a kid intel sent me a while suite of books documenting their architecture<p>It seems like chip companies would want folks to know how to use their products..." — arwineap [c:50617725]
> （译文：我小时候 Intel 曾经免费寄给我一整套讲自家架构的书，这事想起来多奇怪。<br>芯片公司看起来是希望人们了解怎么用自家产品的……）

作者本人给出的退路是开源——去掉 Arm 的 IP，只留工具。

> "Not at the moment, no, but open sourcing (sans Arm IP) is an option I am considering." — jonpalmisc [c:50618099]
> （译文：目前还不算，但把源码（去掉 Arm IP）开源，是我正在考虑的一个选项。）

社区则替他出了个看起来很聪明的馊主意：用 LLM 把手册重写一遍，绕开逐字复制。

> "Another idea could be to feed their manuals into an llm with the job to &quot;rephrase&quot; the content, making it have the same meaning but different words, thus not breaking copyright." — Anoian [c:50619021]
> （译文：另一个思路是把他们的手册喂给 LLM，让它负责「改写」内容，意思不变但换用不同的词，这样就不算侵犯版权了。）

这条被当场否掉，理由是版权法管的不只是字面。

> "The holder of a copyright is granted some measure of control over &quot;derivative works&quot;, and what is considered a &quot;derivative work&quot; is left to the judgment of a court.  Such a rephrase is all but guaranteed to be adjudicated as a &quot;derivative work&quot;." — rectang [c:50620061]
> （译文：版权人对「衍生作品」拥有一定程度的控制权，而什么算「衍生作品」要由法院认定。这样的改写几乎必然被判定为「衍生作品」。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 文档本该自由可用，发律师函是过度反应 | cwillu、f33d5173 | 没有法律要求发下架通知；给个许可就行 |
| 维权是商标义务，不维权就丢商标 | kube-system、robertkarl | 裸授权 doctrine 会让 Arm 的商标失效 |
| 内容是手册逐字复制，fair use 抗辩站不住 | sam1714、tptacek、joemi | 逐字全文搬运会让合理使用崩盘；描述总能换个说法 |
| 站点价值在检索与导航，不在正文 | adrian_b、smallpipe | 原文本来就免费，差别在能不能搜 |
| 手册与实现权才是 Arm 真正的产品 | londons_explore | 他们早就不怎么设计 CPU 了，卖的是手册 |
| Arm 是普遍封闭化，不是冲 RISC-V | dbl000、ACCount39 | 真正的动因是惯常的企业脑腐 |
| 这可能是 AI 时代的门禁 | hakanito | 先关掉免费提供者，再把信息放进 MCP 付费墙 |
| 法务流程失灵，责任在汇报线 | chmod775、giancarlostoro、xyst | 律师该向工程师汇报；初级律师桌上的「另一个案子」 |
| 镜像早就该建，关站不影响使用 | space_ghost、ferguess_k、dmitrygr、fweimer | 明天早上十二个镜像；静态站 `wget -m`；Stanford 已有同类页 |
| 作者会自己走开源（去掉 Arm IP） | jonpalmisc、rectang | 换词改写也会被认定为衍生作品，开源工具才是出路 |

## 总体情绪

这场讨论的分裂点很清楚，而且几乎不看法律条文就能看出来：一半人认为 Arm 在小题大做，另一半人认为 Arm 在维护自己真正的商品。中间还夹着一支把整件事读成「文档闸门」的人，他们给出的证据不是阴谋论，而是 Arm 官网本身的体验——要登录、要同意条款、要等三十秒跑完一堆 JS。这三样东西叠在一起，就足以解释为什么有人愿意自己维护一份更好用的镜像。

法律讨论本身倒意外地扎实：谁也没能证明 fair use 站得住，逐字复制这一条几乎是共识；真正的分歧在商标上，而商标这一支的分歧又是程序性的——「必须维权否则丢商标」与「维权前可以先给许可」两条路径都能自洽。评论者甚至把流程问题挖到了最底层：这可能只是初级律师桌上的一张待办单，ARM 具体谁都不知道。

所以最后留在这场讨论里的，不是法条，而是一个可验证的对照：被 Arm 指控下架的那份文档，其实一直免费挂在 Arm 自己的官网上，只是没人替它加上搜索框。真正稀缺的从来不是内容，是有人愿意替它做索引——而这件事的代价，是 11 天后没人再替你维护。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Per Arm's request, this site will be discontinued on 4 December 2026 :(（HN 主帖） | <https://news.ycombinator.com/item?id=50617499> |
| 2 | Jon's Arm Reference（被要求下架的站点） | <https://arm.jonpalmisc.com/> |
| 3 | archive.org 快照（评论区贴出的存档） | <https://web.archive.org/web/20261123180652/https://arm.jonpalmisc.com/> |
| 4 | Arm 官方 AArch64 指令集文档（支持站，需登录与条款同意） | <https://support.arm.com/documentation/ddi0487/md/-Part-C-The-AArch64-Instruction-Set> |
| 5 | Stanford 上的同类 AArch64 页面（评论者指出的既存替代品） | <https://www.scs.stanford.edu/~zyedidia/arm64/abs.html> |
| 6 | USPTO 商标检索：ARM 75713165 | <https://tmsearch.uspto.gov/search/search-results/75713165> |

<div class="disclaimer">

本摘要由 AI 辅助生成，基于 HN 归档评论（主帖 772 分、158 条评论，归档快照 2026-11-23 23:41 UTC，入库 102 条）。引文后的 `[c:<id>]` 为对应 HN 评论 ID，可在原帖页搜索定位；引文文本与作者已与归档评论逐条比对，截取的段落均为原评论中的连续片段，HTML 实体按原文保留，原评论自带的链接锚标签已去除、保留其可见文本。未进入归档上限的评论（作者本人置顶说明、部分回复）按 Algolia items 接口逐条比对原文与作者，该接口与 CI 校验使用同一数据源。归档评论的分数字段均为 0（Algolia 不返回评论分），引文选择依据为内容本身与讨论价值而非评论分数。

原文为 Jon Palmisc 个人站点 arm.jonpalmisc.com 的停站公告。文中关于「Arm 的律师已通知我下架否则面临法律行动」「2026 年 12 月 4 日停站」「将继续寻找让书签与链接保持可用的方案」「Arm 的诉求是商标与 IP」「已经有人联系他愿意托管镜像、或建议开源去掉 Arm IP」「站点是带搜索、无弹窗的 ISA 文档」等表述均出自该公告及其在评论区置顶的补充说明。

评论中转述的第三方主张与数据（Arm 已把「电子可下载的指令与开发手册」列入商标注册类别、Arm 官网文档需登录并接受条款、rsync.net 提供永久免费账号、Stanford 站点已存在同类页面、Intel 当年免费寄送架构手册等）由评论者自行给出，本文未核实；引文中出现的第三方链接来自评论者原帖。文中关于商标法、naked licensing doctrine、fair use、衍生作品认定的法律讨论均为 HN 评论者的个人判断，不构成法律意见。

本文对原文观点的转述不构成对 Arm 与站点作者的立场认可或反驳；文中所有判断均为 HN 评论者的立场，归纳与判断由本文完成。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
