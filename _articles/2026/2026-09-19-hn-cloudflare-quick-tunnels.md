---
layout: post
title: >-
  Cloudflare Quick Tunnels 不再要求账号 — HN 讨论：免费隧道好用，但 Cloudflare 看得见所有明文
date: 2026-09-19
hn_id: 49754785
categories: [articles]
excerpt: >-
  Cloudflare 把 Quick Tunnels 拆出账号墙，新增结构化 stdout 给 coding agent 用；HN 焦点在 vibe-coded 落地页、TOS 限制（不能用于视频流，Quick Tunnel 并发上限 200）以及明文/信任问题。
tagline: >-
  他们说「零账号、零端口」；没说零明文。
---

## 原文概要

9 月 18 日，Cloudflare 在 [try.cloudflare.com](https://try.cloudflare.com/) 上线了「Quick Tunnels」产品的独立落地页。过去在 [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/) 体系下，跑 `cloudflared tunnel --url http://localhost:8000` 就能拿到一条 `*.trycloudflare.com` 公网 URL，但当时还是需要登录账号。这次的新页把这条路径彻底拽出账号墙：

- 一行命令 `cloudflared tunnel --url http://localhost:8000`，**3 秒左右**出一个公网 URL；
- 不需要账号、不需要 DNS 配置、**本地零入站端口**；
- 走的是 Cloudflare 全球 Anycast 网络，**335+ 城市**就近接入，自动 HTTPS + DDoS 防护；
- URL 形态像 `quiet-marble-otter-canyon.trycloudflare.com`，进程退出即销毁。

页面还专门为「agent 时代」做了两件事：终端 stdout 直接吐 JSON（hostname / edge 节点 / 健康检查），webhook 和 eval harness 可以直接接；明确列出三个目标用户——截图服务、Stripe/GitHub webhook、人类想点开的临时预览。

帖文在 HN 拿到 319 分、152 条评论。讨论热度集中在四个话题：落地页本身像是 vibe-coding 样本、Cloudflare 看明文是否还能信任、TOS/并发上限不够用的具体场景、以及历史爱好者指出「这事其实不新」。

## 讨论焦点

### 落地页本身就是 vibe-coding 样本

> "Looks like they straight up vibe coded the landing page lol." — xeornet [c:49756205]
>
> （译文：他们这落地页就是 vibe code 直出的。）

> "Claude worked overtime on this webpage" — altmanaltman [c:49755654]
>
> （译文：Claude 在这个网页上加班到爆。）

> "what a sloppy website, did cloudflare fired bunch of ui/ux designer? Every text is slop lol." — cute_boi [c:49756191]
>
> （译文：这网站也太草率了，Cloudflare 是把一批 UI/UX 设计师都裁了吗？每段文案都是 AI 口水。）

> "I swear if I see one more \"pill-badge callout -> header -> subtitle\" with gradient background and hover-cards landing page I'm going to crash out" — cub-creature [c:49756996]
>
> （译文：我再看到「pill-badge 小徽章 → 大标题 → 副标题」+ 渐变背景 + 悬浮卡片的落地页真的要崩溃。）

Cloudflare 这种体量的公司被自家用户当面吐槽「连落地页都是 vibe code」，这次有点意外。评论里没人质疑功能本身，反而把抱怨集中在「文案几乎是 LLM 直出、设计师显然没看过这页」。一家做安全/网络基础设施的公司，演示页却像模板生成，被反复当作「agent 时代一切页面都开始 slop」的具象证据。

### Cloudflare 看明文：Tailscale / ngrok 老用户立刻警觉

> "Is this their version of <https://tailscale.com/tailcat> ? I can't tell if you need to auth. edit: yeah, it says no account creation, neat!" — kincl [c:49755662]
>
> （译文：这是他们版的 Tailscale Funnel 吗？我不确定要不要登录。编辑：嗯，确实不要账号，挺有意思。）

> "I believe with tailscale you don't have to trust a 3rd party with your cleartext traffic" — Tepix [c:49756574]
>
> （译文：我相信用 Tailscale 你不需要把明文流量托给任何第三方。）

> "That can't be right. If they're hosting on a different DNS they have an absolute need to MITM ssl/tls traffic. Can't work otherwise. So cloudflare sees your plaintext. Btw: tailscale does not (but ssl errors and warnings are unavoidable)" — spwa4 [c:49757678]
>
> （译文：那不对。如果他们用另一套 DNS 解析，就必然要 MITM 你的 SSL/TLS 流量，否则做不到；所以 Cloudflare 看得见你的明文。顺便说 Tailscale 不会（但它会有 SSL 错误和警告，这点不可避免）。）

> "They see all the traffic in cleartext. Plus you have to trust them not to maliciously alter your traffic. As a US company, their options may be limited if they are coerced by their government to do so." — Tepix [c:49756532]
>
> （译文：他们看得见所有明文流量。你还得相信他们不会恶意改你的流量。作为一家美国公司，一旦被政府要求配合，他们的腾挪空间也不大。）

> "Cloudflare want you to push traffic through their systems. This is yet another traffic generator to drive up Cloudflare's leverage when negotiating peering with carriers & service providers, in order to drive down the marginal cost of bandwidth for Cloudflare's actual product viz. the enterprise DDoS protection." — inopinatus [c:49756565]
>
> （译文：Cloudflare 希望你把流量灌进他们的网络。这是又一个流量发生器，用来在跟运营商和 ISP 谈 peering 时多压点筹码，把带宽边际成本压下去，好让他们的主营——企业 DDoS 防护——卖得更便宜。）

> "Just use TLS / mTLS over the tunnel, no?" — insanitybit [c:49756573]
>
> （译文：自己在隧道上跑一层 TLS / mTLS 不就行了？）

明文是绕不开的话题。所有走 Cloudflare 边缘的隧道都要让 Cloudflare 拿到 TLS 终结能力（拿到你 origin 的证书或自动签发一张 Cloudflare 自己的），否则做不到 HTTP/3、不能做缓存、也不能做 DDoS 清洗——这是这套架构的物理代价。Tailscale Funnel/pangolin/wireguard 这类走 P2P 或自托管反代的方案在「不托付明文」这件事上是另一个物种。也有回复指出可以自己再叠一层 mTLS，但这就把「一行命令拿 URL」的卖点给抵消了。

集中化是更深的暗线：评论里至少四位独立指出，把所有 quick demo 都灌给同一家公司，等于给它加杠杆；swzey 直接把 Cloudflare 称为「事实上的 walled garden」（自 [c:49757608]）。

### TOS 限制与并发天花板：Jellyfin 用户当场破防

> "I like Cloudflare Tunnels a lot, but something that annoys me is that officially you're not allowed to use them for streaming video, meaning I can't put it in front of my Jellyfin without breaking TOS." — tombert [c:49756235]
>
> （译文：我很喜欢 Cloudflare Tunnels，但有个恼人的点：明文规定不能用来视频流，所以我也不能把它放在我的 Jellyfin 前面——那就违反 TOS 了。）

> "I discovered and set this up the other day, added jellyfin, immich and forgejo and was really happy about the result for five minutes, before I discovered that limitation in the TOS. Now I only use it for forgejo. Have you found a different solution to exposing jellyfin?" — TonyStr [c:49756371]
>
> （译文：前几天我搭了这个，把 Jellyfin、Immich、Forgejo 都接进去，开心了五分钟就撞上 TOS 这条。现在只拿它跑 Forgejo。你找到别的暴露 Jellyfin 的方案没？）

> "Bandwidth costs money and streaming video costs several orders of magnitude more than just your random web/dev apps. Asking CF to foot the bill for entertainment streaming is really quite a lot." — bityard [c:49756561]
>
> （译文：带宽要钱，视频流比普通 web/dev 应用的带宽开销高好几个数量级。让 CF 替你付娱乐流的账单实在有点多。）

> "These are the limitations mentioned on the docs [1]. Quick Tunnels are subject to a hard limit on the number of concurrent requests that can be proxied at any point in time. Currently, this limit is 200 in-flight requests. If a Quick Tunnel hits this limit, the HTTP response will return a 429 status code. Quick Tunnels do not support Server-Sent Events (SSE)." — raahelb [c:49756652]
>
> （译文：文档里其实写了这些限制。Quick Tunnels 对同时在飞的请求数有硬上限，目前是 200；超过就返回 429。另外 Quick Tunnels 不支持 Server-Sent Events（SSE）。）

> "There are people who turn off their computer?" — sophacles [c:49756531]
>
> （译文：还有人关电脑的吗？）

「不能流视频」是 Quick Tunnels TOS 里最刺痛自托管用户的一条。Cloudflare 自己的解释是带宽成本——视频流比一般 web 应用贵几个数量级。但评论里也立刻给出技术性补丁：tamimio 推荐自托管的 [pangolin](https://github.com/marhyl/pangolin)（VPN + 反代合一，支持对私资源加访问码），[c:49756511]；guluarte 的方案是 wireguard/tailscale + 自签 SSL + 解析到 NAT IP，[c:49757036]。还有一条更硬的天花板藏在文档里：Quick Tunnel 并发请求上限 200，不支持 SSE——这意味着任何走长连接的 agent / LLM 流式输出都不能直接挂在 Quick Tunnel 后面，只能用配置型 Tunnel。整件事的潜台词是：Quick Tunnel 适合的是「截图服务 / webhook / 给客户看一眼」，不是「个人生产部署」。

### 滥用面与 Tor 老用户的反向补充

> "Don't all these free proxy services always fall prey to blacklists because scammers,etc abuse them until they're useless?" — whizzter [c:49755726]
>
> （译文：这些免费代理服务最后不都是被骗子滥用，最后整个被拉黑、再也没人能用吗？）

> "Yes they actually do, but because its cloudflare which is offering this, blacklisting it might lead to blacklisting can be more negative and cloudflare has a much incentive to not make these tunnels useless. They are also more powerful and can fix things which would be harder for smaller companies to handle" — Imustaskforhelp [c:49755779]
>
> （译文：确实会。但因为这次是 Cloudflare 自己做的，把它拉黑等于把 Cloudflare 一起拉黑，Cloudflare 自身更有动机不让这些 tunnel 变成废品。它也有能力去修小公司修不掉的问题。）

> "Wow, exfiltrating data has never been easier!" — axus [c:49755898]
>
> （译文：现在数据外泄简直前所未有地容易。）

> "Can confirm. Coming from ngrok, the main reason we had to make tunneling not anonymized etc was because of scammers, etc on the internet. Other players in the space bypass this by open sourcing the tech, or separating the architecture entirely. This is cool and all, but ultimately gives nefarious actors on the internet more opportunities." — srichard16 [c:49757377]
>
> （译文：可以确认。我从 ngrok 那边过来，当初必须把隧道做成不可匿名之类，主要就是被网络上的骗子逼的。这个领域里其他玩家要么开源，要么架构上把流量隔开。这东西酷是酷，但确实给网络上的坏人多开了一扇门。）

> "Cool but the obvious flaw with this is that CF leaks DNS-records. So bots will find these urls instantly. Not sure why they have not fixed that or if it is even possible to fix." — AtNightWeCode [c:49756732]
>
> （译文：挺酷，但有个现成的漏洞——Cloudflare 的 DNS 记录会泄漏出去，机器人能瞬间扫到这些 URL。不知道他们为什么没修，也不确定技术上能不能修。）

> "If your a hobbiest or dev just testing your services, it makes more sense to utilize onion services imho. It does the exact same thing, except supported by a global network of volunteers around the world. Sure, you get some latency, but this is actually ideal for testing. You should know how your service operates in non optimal lightning fast conditions." — smalltorch [c:49755944]
>
> （译文：如果是爱好者或者开发者只是想测自己的服务，用 onion 服务更合适我的看法。它做的是完全一样的事，只是底层是全球志愿者网络在撑。延迟确实会有，但对测试来说这其实是好事——你该知道你服务在不那么理想的网络条件下表现如何。）

> "I honestly can't tell if you're trolling or this is an HN out of touch moment. The obvious difference (and thus massive advantage) of the cloudfare product is that it is accessible over the normal internet without needing to install a tor client." — thenewnewguy [c:49756083]
>
> （译文：说真的分不清你是在钓鱼还是这是 HN 的失忆瞬间。Cloudflare 这产品最显眼的差异（也是最大的优势）就是它在正常互联网上就能用，不需要装 Tor。）

滥用风险这条线有两组声音。一组是 ngrok/Cloudflare 老用户，立场是「我们当年也踩过这坑，必须做实名/限速/限地区」；另一组是 Cloudflare 自己的辩护——这次是 Cloudflare 自己下场，滥用成本会比小公司更被重视，所以上限会更克制。技术上更硬的一个漏洞：trycloudflare.com 域名下所有子域的 DNS 记录对全网泄漏，机器人能批量爬出来，所以「随机 URL」这件事本身是纸糊的。onion 的反向推荐看起来很理想主义，立刻被反驳：要给客户预览时让对方装 Tor 浏览器不现实。这是个反复出现的张力——「隐私最佳实践」和「真实可分享」经常站在两边。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 看好 | nullbyte [c:49756830] | 「我以前一直用 ngrok，Cloudflare 自己也做一个真的很香。」 |
| 看好（agent 角度） | usewik [c:49756881] | 「什么时候会出现一个 agent 把用户最私密的工作草稿直接 tunnel 到公网。」 |
| 警惕 | Tepix [c:49756532] | 「Cloudflare 看明文，作为美国公司被政府施压时腾挪空间有限。」 |
| 警惕 | inopinatus [c:49756565] | 「Cloudflare 在意的不是帮你跑隧道，是借你的流量去谈 peering。」 |
| 老用户补丁 | bakugo [c:49755875] | 「这事其实不新，只是这次页做得比较醒目，trycloudflare.com 免账号 tunnel 早就有。」 |
| 老用户补丁 | user3939382 [c:49755595] | 「我刚花一周自己写了个 harness 干这事，结果它官方直接送了。」 |
| 替换方案 | smalltorch [c:49755944] | 「爱好者测试用 onion 更合适。」 |
| 替换方案 | tamimio [c:49756511] | 「自托管 pangolin 就行，VPN + 反代合一。」 |
| 反对套用 | thenewnewguy [c:49756083] | 「让客户装 Tor 浏览器看预览不现实。」 |
| 滥用风险 | srichard16 [c:49757377] | 「cool 是 cool，但确实给坏人多开了一扇门。」 |

## 总体情绪

Quick Tunnels 在 HN 上的态度是「值得用、不值得托付」。讨论普遍承认这条命令的体感非常顺——3 秒出 URL、零账号、零端口——但同时把怀疑拉回到了一个被反复确认过的事实：所有走 Cloudflare 边缘的隧道，本质都是把代理明文付给一家美国公司。这件事对于「截图 / 临时预览 / 给同事看一眼」完全可以接受，对于「长期生产部署 / 敏感数据 / 受合规约束的服务」就不行。TOS 排除视频流、200 并发、无 SSE 这三条硬限制，进一步把 Quick Tunnel 钉死在「临时调试 / 一次性 webhook / agent 外部回调」这三个用例上。

情绪曲线上，落地的兴奋很快被对集中化的警惕压住，然后被「TOS + 并发上限 + DNS 泄漏」三条技术补丁浇到冷静。最后留下的不是「Cloudflare 好不好」，而是「你打算用这一行命令干什么」——回答是截图或 webhook 就用；回答是生产或敏感数据就别用，文档里也写了。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Cloudflare Quick Tunnels | <https://news.ycombinator.com/item?id=49754785> |
| 2 | try.cloudflare.com 落地页 | <https://try.cloudflare.com/> |
| 3 | Cloudflare Tunnel 官方文档（含 Quick Tunnels 限制说明） | <https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/do-more-with-tunnels/trycloudflare/> |

<div class="disclaimer">

本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3。引文均直接来自 HN 评论原文，已与缓存的 `comments.yaml` 逐字核对（author / verbatim text / [c:id] 对应一致）。翻译为意译，不替代原始语境。立场归原评论者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>