---
layout: post
title: >-
  Safari 27.3 会自动把浅色网页改成深色，评论区争的是浏览器能不能替你改 — HN 讨论摘要
date: 2026-11-04
hn_id: 50358562
categories: [articles]
excerpt: >-
  40% 的人已经在暗色模式下浏览网页，只有 10% 的页面真正支持暗色。
  Safari 27.3 的解法是剩下的那些，由浏览器直接改色。
  评论区真正吵起来的不是效果，而是浏览器第一次公开对网站撒了谎——脚本读到的颜色和眼睛看到的颜色，不再是同一个。
tagline: >-
  它不是给浏览器加了暗色模式，是把浅色网页藏了起来。
---

> 来源：HN 讨论帖，提交者 paddingtone。帖子：[Safari introduces Adaptive Dark Mode in 27.3](https://news.ycombinator.com/item?id=50358562)，264 分，167 条评论（抓取时快照）。原文是 WebKit 官方博客的 Introducing Adaptive Dark Mode，作者为 Simon Fraser、Luming Yin、Lily Spiniolas、Joanne Pan、Veda Periwal 和 Jen Simmons。

## 原文概要

2026 年 11 月 3 日，WebKit 博客放出 Safari 27.3 beta 的新特性：Adaptive Dark Mode，自适应暗色模式。用户侧的流程短得出奇——把系统外观设成深色，然后访问一个亮背景的网页，Safari 会主动弹出预览，点一下「Try」就生效。

依据是 Chrome Status 上的两份统计：约 40% 的网页加载来自使用暗色模式的用户，而真正支持暗色的页面加载只占 10%。Safari 12.1 在 2019 年春就已经是第一个支持网页暗色模式的浏览器，这一次 Apple 选了另一条路——不改网页，改渲染。

实现分两类。如果网页用 `<meta name="color-scheme" content="light dark">` 或 CSS 的 `color-scheme: light dark` 声明过支持，Safari 一个字节都不动。其余网页交给浏览器现场分析：先判断页面整体是亮是暗，若本来就是深底浅字就保持原样，若整体偏亮则做颜色变换。团队为此做了一套颜色矩阵，反转明度但保留色相，文本对比度对齐 WCAG 的 4.5:1，浅色 CSS 渐变也会被转暗。SVG 图标逐个检查后再决定是否调整颜色，位图则看像素直方图，只反转简单的黑白 logo；mask 和 `mix-blend-mode` 在某些情况下被直接关掉，`<canvas>` 内容一律不动。博客强调，这套东西跑在引擎深处，所以能做得快、省电，而且不牺牲隐私。

退出机制是 `color-scheme: light only`，可以写在 HTML meta 里，也可以只作用于页面某一段 CSS。博客自己注明了一个坑：`only` 这个关键字在 Safari 27.3 beta 1 里还不支持，要等 beta 周期继续推进。

隐私条款是整篇文章里最被讨论的部分：网站无法探测 Adaptive Dark Mode 是否生效，JavaScript 读到的 CSS 颜色仍是作者写下的原色，画进 canvas 的图片也是原样。给站主的建议清单同样具体——位图换成 SVG、平铺背景图换成 CSS 渐变、图片雪碧图改用现代 CSS、内容图做透明背景而不是把底色烤进图里；并且强调用 meta 或 `:root` 声明，不要等 JS 跑完再注入。

## 讨论焦点

### 一、浏览器第一次公开对网站撒谎

吐槽最直接的是 _boffin_，他盯着博客里的隐私条款：

> "So… the browser is now intentionally lying now. Ain’t that great." — _boffin_ [c:50358701]
> （译文：所以……浏览器现在是故意在说谎了。真是好棒。）

kvuj 立刻把这句话拆成了两个方向：

> "To the server. I'm 100% behind this. The unholy amount of control websites have over our web browser should go down, not up." — kvuj [c:50358745]
> （译文：是对服务器说的。我百分之百支持这个。网站对我们浏览器施加的那一大堆邪恶控制应该减少，而不是增加。）

这层分歧其实不在隐私，而在「撒谎」这个词的落点：对用户是保护，对服务器是撒谎。kccqzy 找出了浏览器对网站说谎的老传统——访问过的链接会显示不同颜色，网站本来就能借此判断你有没有点过：

> "Browsers lie all the time. Browsers also prevent sites from getting the color of a link because visited links can be shown in a different color and this can be used by the site to tell if a user has ever visited a link." — kccqzy [c:50358801]
> （译文：浏览器一直在说谎。浏览器也会阻止网站拿到链接的颜色，因为访问过的链接会显示成另一种颜色，网站可以据此判断用户是否点过这个链接。）

mirashii 补上的是动机：

> "Browsers already intentionally lie all the time, and have had to for years, because fingerprinting and tracking by various ad networks and bad actors has been rampant." — mirashii [c:50358780]
> （译文：浏览器早就一直在故意说谎，而且多年来不得不这么做，因为各种广告网络和坏行为者已经把指纹识别和跟踪搞得无处不在。）

而 neilalexander 用四个字把收益结清：

> "One less thing to fingerprint." — neilalexander [c:50358779]
> （译文：少了一样可以被指纹识别的东西。）

### 二、开发者噩梦，还是用户代理的本职工作

讨论一开场就把三种身份摆在一行：

> "As a web developer: what a nightmare, now your website will look different to different people, as if having to support multiple browser engines and multiple screen rations, and multiple platforms, etc. was not a big pile of problems already." — guessmyname [c:50358660]
> （译文：作为 web 开发者：简直是噩梦，现在你的网站在不同人眼里长得都不一样了，就好像要同时支持多个浏览器引擎、多个屏幕比例、多个平台之类的事还不够多一样。）

（原文的 screen rations 应为 screen ratios，此处照录。）

isityettime 的反驳是这条线里最长的一段，他列了一串用户早就自行改造网页的例子：

> "That's what the web has always been. People don't all have the same display types, the same subpixel layouts, the same display sizes, the same DPIs, the same fonts, the same zoom levels... People use reader modes, global restyling extensions, per-site custom style sheets, full screen magnifiers, bounded/partial magnifiers, screen readers, OS high-contrast modes... the web has never been a fixed canvas that you get to paint on and then hand to users." — isityettime [c:50359015]
> （译文：网页一直都是这样。每个人的显示器型号不一样、子像素布局不一样、屏幕尺寸不一样、DPI 不一样、字体不一样、缩放比例也不一样……人们用阅读模式、用全局重排扩展、用站点自定义样式表、用全屏放大镜、用局部放大器、用屏幕阅读器、用系统的高对比度模式……网页从来不是一块固定的画布，画完就交到用户手里。）

JoshTriplett 把这件事归回浏览器的基本身份：

> "Browsers are user-agents, not website-agents. By way of example, if a website shows ads or does tracking, I will absolutely alter it to my liking." — JoshTriplett [c:50359023]
> （译文：浏览器是用户的代理，不是网站的代理。举个例子，如果一个网站弹广告或者搞跟踪，我绝对会按我自己的喜好去改它。）

有人干脆欢迎这种越界。Spivak 说开发者身份也不妨碍他举双手赞成：

> "Even as a developer I'm all for it, go even harder." — Spivak [c:50358722]
> （译文：即使作为开发者，我也完全支持，再狠一点更好。）

而 apsurd 从专业角度给出了反对理由：

> "disagree. the web specifically is built as a dynamic medium for consumption. The fluid nature is the point. Yes, it is harder for developers to force a consistent experience, but as a professional web dev, we should not treat the web as a fixed medium." — apsurd [c:50358733]
> （译文：不同意。网页在本质上就是为消费而建的动态媒介，流动性才是重点。是的，这让开发者更难强推一种固定体验，但作为专业 web 开发者，我们不该把网页当成固定媒介。）

### 三、改坏了怎么办：出口在哪里

另一支队伍更务实，只问出口在哪。kevincox 给出了两条：

> "It's opt-in. The user is choosing the occasional broken site over light themes." — kevincox [c:50358930]
> （译文：这是用户主动开启的。用户是在拿偶尔坏掉的页面去换浅色主题。）

sheept 把责任推给应用侧：

> "Even if it were, it’s easier and more reasonable to fix your app to work with your users, than fixing your users to work with your app." — sheept [c:50358928]
> （译文：就算真会这样，让应用去适配用户也比让用户去适配应用更容易、更合理。）

kps 把这条建议压缩成一行代码：

> "As a web developer, all you have to do is support `:prefers-color-scheme`." — kps [c:50359041]
> （译文：作为 web 开发者，你要做的只有一件事：支持 `:prefers-color-scheme`。）

marcellosso 作为重度暗色模式用户，给的是双赢版本：

> "I use dark mode for everything, so I'm pretty happy about this. Some sites were clearly designed to be light, and forcing dark on them could break the experience, but that's exactly what `color-scheme: light only` is for, and it's good that Safari respects it." — marcellosso [c:50358941]
> （译文：我所有东西都用暗色模式，所以对这个特性很满意。有些站点明显是为亮色设计的，硬转成深色可能破坏体验，但这正是 `color-scheme: light only` 存在的意义，Safari 尊重这个标记很好。）

风险提示由 vinnymac 提出，他举了 Gmail 的旧账：

> "If this ends up working anything like the Gmail Dark Mode implementations on iOS and Android that have drove developers insane and users mad, then I expect both parties to become upset." — vinnymac [c:50358912]
> （译文：如果最终效果像 iOS 和 Android 上那些让开发者抓狂、让用户生气的 Gmail 暗色模式实现一样，那么我预计双方都会不满。）

（Wikipedia 的默认 Vector 2022 皮肤本身就支持暗色模式，所以对它来说这套变换根本不会触发。）

### 四、散光与深色模式：一场比 Safari 老得多的争论

评论区里有一批人根本不在讨论功能，而是在算自己的眼睛账。JulianPaul 的疑问像一句求助：

> "Am I still the only one who doesn't use dark mode? My astigmatism can't take it" — JulianPaul [c:50358864]
> （译文：现在还在用明色模式的人是不是只剩我一个了？我的散光受不了暗色模式。）

nsoam 直接要反向功能：

> "I want the opposite. I suffer from astigmatism, which makes white on black hard to read. I wish Safari could turn dark mode websites into light mode websites." — nsoam [c:50358886]
> （译文：我想要相反的东西。我有散光，白底黑字——准确说是黑底白字——很难读。我希望 Safari 能把暗色模式的网站变回明色模式的网站。）

kps 用一句比喻描述这种阅读体验：

> "The average dark mode site looks like I'm driving the Las Vegas strip in the rain." — kps [c:50358996]
> （译文：平均水平的暗色模式网站，看起来就像我在雨夜里开车穿过拉斯维加斯大道。）

loloquwowndueo 的症状描述更具体：

> "No, you’re not the only one, I can’t read dark mode, it’s all blurry, makes me squint and gives me a headache. Light colors all day long. Light mode is not a mode - it’s the default." — loloquwowndueo [c:50359103]
> （译文：不，你不是唯一的一个，我读不了暗色模式，全都糊成一团，逼得我眯眼还头疼。我要一整天的浅色。明色模式不是一种模式，它是默认值。）

也有人嫌暗色模式做得太黑。nozzlegear 属于这一派：

> "I especially dislike the ones that are pitch black instead of the cool grey/dark grey." — nozzlegear [c:50359198]
> （译文：我尤其讨厌那种纯黑的，而不是冷灰/深灰的。）

cj00 的解法是自己动手写扩展：

> "Yeah I can’t do dark mode websites because they leave an after image for some time after reading. So I made a Force Light Mode extension that just applies an inverse to any site that forces dark mode on me." — cj00 [c:50360203]
> （译文：是啊我没法用暗色模式的网站，因为读完一段之后画面会留下一阵残影。所以我写了一个 Force Light Mode 扩展，对任何强行暗色化的站点施加一次反相。）

不过暗色模式并不是只有受害者一方。redwall_hp 的散光问题刚好相反：

> "The preference, either way, is an important accessibility feature." — redwall_hp [c:50359068]
> （译文：无论偏向哪一边，这个偏好本身就是一项重要的无障碍功能。）

反对者的观点则更接近纸面阅读。MBCook 的话里带着二十年的怨气：

> "No. It’s stupid. There’s a reason we don’t write white text on black paper. There’s a reason the first Mac showing black text on a white background was such an improvement." — MBCook [c:50359538]
> （译文：不。这是蠢事。我们不在黑纸上写白字是有道理的。第一台把黑字放在白底上显示的 Mac 是如此大的进步，也是有道理的。）

kalleboo 立刻拿历史反驳这段历史：

> "Apple soon started offering a dark mode as an accessibility feature" — kalleboo [c:50360206]
> （译文：Apple 很快就把暗色模式作为一项无障碍功能提供出来了。）

### 五、`light-dark()` 这个名字惹恼了一群人

讨论里少见的、纯技术规格层面的争执，出现在 `light-dark()` 这个 CSS 函数上。akersten 的火气来自命名：

> "It makes me so angry that they named the CSS function `light-dark` instead of leaving the door open to allowing generic user- or site-specified color schemes." — akersten [c:50359275]
> （译文：让我非常生气的是，他们把这个 CSS 函数命名为 `light-dark`，而不是给通用的、由用户或站点指定的配色方案留一扇门。）

have_faith 讲的是同一件事的抽象版本：明与暗在规范里被当成了特殊物种，而它们本来只是主题。

> "It’s always irked me that light and dark are given privileged positions in the namespace. They’re just themes (or schemes if you like), like all the other possible themes." — have_faith [c:50359378]
> （译文：一直让我不满的是，light 和 dark 在命名空间里享受了特权位置。它们不过是主题（叫配色方案也行），跟其他所有可能的主题一样。）

### 六、顺手把 Chrome 的 `prefers-color-scheme` 也审一遍

有人把这篇博客当成引子，翻出了 Chrome 的旧争议：浏览器的配色设置到底该不该管网页。jansan 引用了规范原文：

> "So if the user sets dark mode in the browser, do they not explicitly express their preference for websites? How could they be more explicit about the setting?" — jansan [c:50359370]
> （译文：那如果用户在浏览器里设了暗色模式，这难道不就是明确表达了对网站的偏好吗？还能怎么更明确地表达这个设置？）

omer_balyali 承认自己之前的说法不准确，并给出了 Chrome 的实际行为：

> "But again, Chrome doesn't have a feature that lets users to choose which color-scheme they want to browse the web (so there is no bug, but it's a UX issue because their Appearance settings doesn't make it clear to the users what this setting changes) other than the setting they gave to developers." — omer_balyali [c:50359769]
> （译文：但再说一次，Chrome 并没有让用户选择用哪种配色浏览网页的功能（所以这不是 bug，而是 UX 问题：它的外观设置没让用户清楚这个设置会改变什么），除了它给开发者的那个设置之外。）

这段支线的结论有点反讽：Safari 的新特性是浏览器单方面替用户决定，Chrome 的老毛病是浏览器不把自己和网页的关系说清楚。

### 七、先驱们、插件的旧账，和一点历史回声

功能本身并不新。greazy 提醒大家同类东西早就存在：

> "Everyone should checkout Dark Reader extension, it's been doing adaptive dark mode for many years, and it's customisable. It even does light mode too. Using it in Firefox on HN right now!" — greazy [c:50359073]
> （译文：大家都该去看看 Dark Reader 扩展，它做自适应暗色模式已经很多年了，而且可以自定义。它甚至也能做明色模式。我现在就在 Firefox 上用它看 HN！）

但插件和原生实现的区别，在 jordand 的观察里恰恰是隐私：

> "I was looking through 'Dark Mode' browser plugins for viewing websites last week, and the options aren't great. The 'Dark Reader' plugin that's everywhere sends a lot of silent web requests in the background that seems strange given its mostly just CSS tweaks." — jordand [c:50358704]
> （译文：上周我在挑看网页用的暗色模式浏览器插件，选项都不怎么样。那个无处不在的 Dark Reader 插件会在后台发出大量无声的网络请求，这很奇怪，因为它基本上只是改改 CSS。）

figmert 追问得很具体：

> "I'd be curious to know more about this. Dark Reader, at least on Firefox, is a recommended addon, which means it gets additional scrutiny by Mozilla. I do agree though that if it does additional web requests, it seems fishy." — figmert [c:50358973]
> （译文：我很想知道更多细节。Dark Reader 至少在 Firefox 上是推荐扩展，这意味着它会受到 Mozilla 额外审查。我确实同意，如果它真的发出额外的网络请求，那看起来就可疑。）

Android 那边也有人早就做过类似实验：

> "There's a mode like this in an Android Chrome fork called Cromite that works surprisingly well. Most of the other options do suck though." — arcanemachiner [c:50358867]
> （译文：有一个 Android Chrome 分支叫 Cromite，里面的模式跟这个很像，效果出奇地好。不过其他大多数选项确实都很烂。）

性能方面有人给出了一条直白的代价：

> "Slows down loading of websites a lot though." — ckdot [c:50359172]
> （译文：不过这会让网页加载慢很多。）

Telaneo 认为这笔交易划算：

> "A slowly loading website is preferable to a quick flashbang." — Telaneo [c:50359510]
> （译文：慢悠悠加载的网页，好过一瞬间的闪瞎。）

至于「深色模式」本身的历史，cosmotic 从 Windows 时代讲起：

> "Windows 3 through windows 7 had pervasive support for dark mode as long as application developers didn't custom paint their user interfaces. Application developers started out almost all supporting system colors and gradually over the next 25 years or so started implementing their own custom-drawn interfaces, accelerated by embedded IE/mshtml views and then later even more by Electron. This concluded with practically zero interfaces supporting the system color scheme." — cosmotic [c:50359118]
> （译文：从 Windows 3 到 Windows 7，只要应用开发者不自己绘制界面，深色模式是一直有普遍支持的。应用开发者起初几乎都使用系统颜色，之后二十五年左右逐渐开始实现各自绘制的界面，被内嵌的 IE/mshtml 视图推快，后来 Electron 又进一步加速。结果是几乎没有界面还支持系统配色方案。）

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|-------|
| 浏览器故意对网站撒谎 | _boffin_ | 「浏览器现在是故意在说谎了」 |
| 但撒谎的对象是服务器 | kvuj | 网站对浏览器的邪恶控制应该减少 |
| 浏览器撒谎是老传统 | kccqzy | 访问链接变色，浏览器早就在瞒网站 |
| 隐藏状态就是防指纹 | neilalexander | 少一样可以被指纹识别的东西 |
| 开发者视角是噩梦 | guessmyname | 你的网站在不同人眼里长得都不一样 |
| 网页从来不是固定画布 | isityettime | 用户早就在自己改造网页 |
| 浏览器是用户的代理 | JoshTriplett | 有广告有跟踪的站，我会照自己意思改 |
| 开发者也不反对 | Spivak | 即使作为开发者，我也完全支持 |
| 反对强制一致外观 | apsurd | 网页是动态媒介，流动性才是重点 |
| 用户主动开启，承担风险 | kevincox | 用户是在拿偶尔坏掉的页面换浅色主题 |
| 该修的是应用不是用户 | sheept | 让应用适配用户比反过来容易得多 |
| 开发者只需支持一行 CSS | kps | 支持 `:prefers-color-scheme` 就行 |
| 用户与开发者双赢 | marcellosso | 加个 `light only`，其余交给 Safari |
| Gmail 是前车之鉴 | vinnymac | 双方都会不满，最后谁都输 |
| 散光者读不了暗色模式 | JulianPaul | 现在还在用明色模式的只剩我一个了吧 |
| 想要反向功能 | nsoam | 希望 Safari 能把暗色网站变回亮色 |
| 暗色模式像雨夜里的拉斯维加斯 | kps | 那种光污染感 |
| 纯黑比深灰更难读 | nozzlegear | 讨厌纯黑而不是冷灰/深灰 |
| 自己写扩展反相 | cj00 | Force Light Mode，站点强制暗色就反相回去 |
| 明暗偏好是双向无障碍 | redwall_hp | 选哪边都是重要的无障碍功能 |
| 反对深色模式的物理理由 | MBCook | 我们不在黑纸上写白字是有道理的 |
| 暗色模式本就是无障碍功能 | kalleboo | Apple 很快就把它当无障碍功能提供了 |
| 命名锁死了未来 | akersten | `light-dark()` 抹掉了自定义配色的可能 |
| 明暗不该有特权 | have_faith | 它们只是主题，跟其他主题一样 |
| 浏览器设置也是用户偏好 | jansan | 在浏览器里设暗色就是明确表达偏好 |
| Chrome 的问题是 UX 不是 bug | omer_balyali | 没有让用户选网页配色，是没说清楚 |
| 同类方案早已存在 | greazy | Dark Reader 干了很多年了，还能做明色 |
| 插件会偷偷发请求 | jordand | Dark Reader 后台发出大量无声请求 |
| 第三方扩展受额外审查 | figmert | Firefox 推荐扩展，审查更多 |
| Android 上已有类似实现 | arcanemachiner | Cromite 的效果出奇地好 |
| 代价是加载变慢 | ckdot | 这会让网页加载慢很多 |
| 慢一点更好 | Telaneo | 慢加载好过一瞬间闪瞎 |
| 深色模式有三十年历史 | cosmotic | 自绘界面的时代把系统配色彻底终结 |

## 总体情绪

这场讨论有两条线在同时跑。一条是功能线的：深色模式在 WebKit 里被做成了引擎级能力，配色矩阵、WCAG 对比度、SVG 逐个检查、像素直方图、canvas 不动、探测不到——这套清单本身挺扎实，评论区也从工程细节一路吵到了 `light-dark()` 的命名和 `color-scheme` 命名空间的设计。

另一条是旧账线：暗色模式这场内战早就开打。Windows 3 到 7 的深色模式、Dark Reader、Cromite、Firefox 用户的 stylus 样式表，散光患者和偏头痛患者各自的需求，以及那句「我们不在黑纸上写白字是有道理的」——每一代都有每一代的战场，而 Apple 这次等于把战场搬到了浏览器默认设置里。

真正的分歧落在一个问题上：网页对最终外观的所有权。三十年来用户一直用扩展、阅读模式、自定义 CSS 从网站手里把外观抢回来，这次 Apple 做的事是把这份抢夺收进引擎，同时保证网站看不见、也告不了状。多数人接受了「浏览器是用户的代理」这个前提，少数人担心 Gmail 式的翻车会落到开发者头上，而真正被这次更新伤害到的人——那些在深色模式下读不了字的人——发现自己连一个能退出的开关都还拿不到，因为 `only` 关键字在 beta 1 里根本没生效。

当「深色模式」从插件变成浏览器的默认动作，最后被改掉的是网页对界面拥有所有权这个前提。

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Safari introduces Adaptive Dark Mode in 27.3（HN 主帖，264 分，167 条评论） | https://news.ycombinator.com/item?id=50358562 |
| 2 | Introducing Adaptive Dark Mode（WebKit 官方博客原文） | https://webkit.org/blog/18541/introducing-adaptive-dark-mode/ |
| 3 | ChromeStatus：暗色模式下的网页加载占比（约 40%） | https://chromestatus.com/metrics/feature/timeline/popularity/3580 |
| 4 | ChromeStatus：支持暗色模式的网页加载占比（约 10%） | https://chromestatus.com/metrics/feature/timeline/popularity/3707 |
| 5 | Understanding WCAG 2.1 Contrast Minimum（4.5:1 对比度标准） | https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html |
| 6 | MDN：color-scheme（含 light only 与 light-dark()） | https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/color-scheme |
| 7 | CSS Media Queries Level 5：prefers-color-scheme 规范原文 | https://drafts.csswg.org/mediaqueries-5/#prefers-color-scheme |
| 8 | Dark Reader（讨论中被反复提到的先驱扩展） | https://darkreader.org/ |

## 免责声明

<div class="disclaimer">
本文为 HN 讨论的中文摘要，所有引文归原作者所有，本文仅作整理。正文涉及的功能细节、比例数字、WCAG 对比度标准与 `only` 关键字的支持状态，均来自 WebKit 官方博客原文；文中关于评论者个人视力状况的描述为个人陈述。评论数与分数为抓取时快照，实际数值随时间变化。引文均带有 <code>[c:id]</code> 形式的评论编号，可在原帖通过 <code>item?id={id}#{c_id}</code> 形式定位。读者应自行判断各方立场与解读。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
