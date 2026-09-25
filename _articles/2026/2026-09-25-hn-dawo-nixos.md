---
layout: post
title: >-
  荷兰政府用 NixOS 自建办公套件 —— HN 讨论纪要
date: 2026-09-25
hn_id: 49841563
categories: [articles]
excerpt: >-
  荷兰政府推出 DAWO：用 NixOS 拼出可审计、可替换的办公底座，绕开微软。HN 读者一边叫好，一边吵 AI 代码政策、欧盟协同、NixOS 工程现实。
tagline: >-
  DAWO：政府终于想自己装电脑了。
---

## 原文概要

荷兰政府内部事务部（BZK）下属的 DAWO 社区上线了名为“数字自主工作空间”的开放蓝图，目标很直白：替代政府部门对微软办公套件的依赖。DAWO 把整套工作环境拆成五块可独立替换的积木——AI、操作系统、云、协作软件，以及一整套可被第三方审查的部署配置，五大目标分别是数字自主、协作、安全、创新、可审计。

底层操作系统选了 NixOS。HN 用户 solarkraft 一句话点透了选型理由：NixOS 的“可复现构建”特性天然适合政府这种“装好就尽量别动”的场景——一次配置，处处一致，想升级或回滚都有迹可循。

不止荷兰。solarkraft 在帖子里顺手点名了两个同类项目：德国的 `openDesk` 和法国的 `La Suite`。法国政府其实更早就开源了 Securix——一款基于 NixOS 的安全加固操作系统——以及 Bureautix-example 办公部署样板，覆盖 Linux 内核、自托管文档套件到终端协作工具的完整路径。

DAWO 的代码托管在荷兰政府自建的 `code.overheid.nl` 平台，同时把社区协作部分镜像到 Codeberg。这种“政府自建 + 开源社区参与”的双轨安排，本身就是这次讨论的引爆点之一。

来源：HN 热门榜（/best）。

---

## 讨论焦点

### NixOS 选型：为什么不是 Guix 或 Lix

有用户问，为什么荷兰政府选 NixOS 而不是 Guix 这种更“自由软件纯血”的发行版。TheFuzzball 的回答是 NixOS 可以直接换用 Lix 运行时（Nix 包的替代实现，他自己就这么用），而 Guix “比 *ix + nixpkgs 更加 opinionated，成熟度也差一截”。anthk 给 Guix 用户指了一条路：添加 Fearware Guix channel 就能拿到非自由固件和主流 Linux 内核，跑硬件不成问题。

> "You can run NixOS with Lix (I do). Because Guix is less mature and more, ehm, opinionated, than *ix + nixpkgs" — TheFuzzball [c:49842495]
> （译文）

讨论很快跑偏到“是不是干脆把发行版都换成 NixOS 或 Guix System 的系统配置文件”。opan 感叹：“大多数发行版都可以被一个 NixOS/Guix System 的系统配置替代”——这恰好对应 DAWO 蓝图里“可审计、可替换”的核心理念。

### 欧盟各国各自为战：是浪费还是必要的竞争？

mastermage 提议把这股劲拧成“一个欧盟范围内的独立生态系统，绕开微软”。steinwinde 反问：每个有余力的欧洲国家都开发自己的开源软件栈，是不是反而互相抵消？Forgeties79 觉得协调多国不同官僚体系的成本，可能比独立开发加开源的总成本还高，最后大家互相“借用”反而更现实。

> "I'm hardly an expert, quite the opposite, but I imagine coordinating all those groups across multiple countries that don't have a unified bureaucratic system would undo any disadvantages of just working on them independently and open sourcing at all." — Forgeties79 [c:49843924]
> （译文）

tweetle_beetle 把这比作“两个初创公司抢在大企业前面出产品”——并行试点、互相检验，再统一规划，比欧盟从零开始走需求评审流程更可能跑通。mastermage 立刻澄清自己其实想要的就是一个 EU 范围内的协作。

### Codeberg 政策与“AI 生成代码”的边界

ricardobeat 给 DAWO 开发者留言：你们镜像到 Codeberg 的代码可能违反 Codeberg 新发布的“反 AI 生成代码”政策。多位用户随即指出，他显然没读完政策原文。

> "Codeberg does not forbid AI-generated code. It forbids AI-generated projects. You would know this if you read the policy." — mitxela [c:49843757]
> （译文）

llimllib 翻出政策原文，发现关键词是 `projects that mostly consist of code written by "generative AI"-tools`。tcfhgj 把它解读为 `>50%` 的门槛，ricardobeat 的“几乎所有提交都像 LLM 协助”的判断显然站不住。embedding-shape 进一步解释：Codeberg 真正反对的是 slop 和 AI spam，而不是任何被 LLM 碰过的代码。

> "Did you actually read through that post you linked? You realize not every project that was ever touched by a LLM is being thrown off? [...] They're targeting slop and essentially spam, not everything that could possibly have been built by LLMs." — embedding-shape [c:49842210]
> （译文）

lucideer 透露：DAWO 主仓在 `code.overheid.nl`，Codeberg 只是社区镜像；考虑到政府项目要管控 agentic 贡献量，这种“双轨”是合理的设计。Muromec 担心的则是“硬政策 + 软执法”会催生一份不公开的“影子政策”，对依赖 Codeberg 的政府项目尤其危险。

顺着这条线，schnebbau 抛出更大胆的预言：未来所有代码都会是 AI 生成，手写代码只会像铁匠打装饰剑那样变成小众爱好。

> "Because no one is going to hire developers who write code by hand, apart from a few niches. For the same reason that no one hires a courier who delivers by horse anymore, or a miller who uses windmills to grind their grain, or a cooper who continues to use wooden staves and iron hoops instead of forming plastic or metal containers, or..." — schnebbau [c:49842343]
> （译文）

applfanboysbgon 回怼：vibecoded 软件到现在没有真正颠覆任何市场，最多形成一层 vibecoding 工具的金字塔。gspr 警告 schnebbau 的话术和加密货币布道者一模一样：

> "Your analogy is terrible. [...] I find it extremely worrying that people like you keep reiterating this point as if it's a fact. If it's true, then surely we'll very soon see the evidence. The way you speak of the 'near future' with certainty, as if everyone agrees, gives me the same sour taste as cryptobros or MLM conmen. Yuck." — gspr [c:49843908]
> （译文）

rvz 预测 Codeberg 最终会因现实压力放松立场；TiredOfLife 反驳：意识形态驱动的平台很少主动改弦更张——除非失去执行手段。

### NixOS 的工程现实：immutable 与 bleeding-edge 冲突

skohan 分享自己用 Nix 做 agent 沙盒的经历：Nix 哲学是“软件不可变”，但 llama.cpp 这种每天都在更新的前沿项目，频繁换版本或打补丁反而被这套哲学卡住，最后他只能把 llama.cpp 放到 Nix 体系外管理。

> "I recently got my feet wet with Nix for the purpose of agent sandboxing, and it's a really great concept! [...] experimenting with different versions/configs/patches etc. was fighting with the Nix philosophy of immutable software" — skohan [c:49843173]
> （译文）

kevincox 觉得这是没找到套路：llama.cpp 仓库自带 flake，换分支、改 build 号、加 CMake flag 都直接在 nixpkgs 构建里改，门槛比上游构建还低。fsiefken 推荐 `nix-direnv` + `flake.nix` 的组合，既保留可复现性，又让本地二进制可变。

另一边，bialyalibaba 抱怨：unbound 出了 CVE，等 nixpkgs 合并补丁等了 2 天，这在企业环境里完全不能接受。amarshall 直接让你切到 `nixos-unstable-small` 分支或者自己 backport。shim__ 抛出更激进的方案：nixpkgs 应该只留核心库和系统应用，其余“宽松标准”的包放到另一个仓库，让安全敏感的合并走快车道。

> "There needs to be another repository with less stringent standards, nixpkgs should be for core libs and system applications" — shim__ [c:49843972]
> （译文）

### 自托管 Forgejo vs. 联邦化 forge

gagik_co 问：如果目标是数据主权，DAWO 是不是该有自己的 Forgejo 实例（而不是依赖 Codeberg）？cornedor 答：DAWO 主仓在 `code.overheid.nl`，社区镜像在 `codeberg.org/DAWO`，两边都用。但 lucideer 紧接着补充：DAWO 核心代码已经从 overheid.nl 迁移到 Codeberg 以“促进社区协作”——这两个说法在 HN 上撞车，没人能确认哪个是当前事实。

> "They use both. https://code.overheid.nl/MinBZK?q=dawo&sort=alphabetically as the official source, and https://codeberg.org/DAWO for the community parts." — cornedor [c:49842352]
> （译文）

utopiah 借机呼吁联邦化 forge：每个实例自己定规矩，但仍能跨实例协作。amiga386 泼冷水：fediverse 的巴尔干化教训摆在那里，每个实例都有自己的“黑名单”和封禁理由，drama 无穷。

> "That's likely to end up Balkanized like the fediverse, where every instance has a list of other instances they refuse to federate with, often because politics or petty drama." — amiga386 [c:49842340]
> （译文）

numpad0 把这个老问题一针扎穿：

> "Doesn't work. People from different geographical areas just can't agree on categories. You'd think 'no lolis' would be reasonable. It falls apart when people look 14 into 50s, to you and your local police, but not to themselves." — numpad0 [c:49843866]
> （译文）

跨地域连“哪些内容需要标注”都无法达成共识，联邦化 forge 注定只是个技术乌托邦。

---

## 典型观点一览

| 立场 | 用户 | 一句话 |
|------|------|--------|
| 看好 | solarkraft | NixOS 天然适合政府“装好就别动”的系统，可复现性是最大卖点 |
| 看好 | TheFuzzball | NixOS + Lix 兼顾自由软件纯度和成熟度，比 Guix 更实用 |
| 谨慎 | steinwinde | 欧洲各国各自开发可能反而互相抵消，缺少统一协调 |
| 务实 | Forgeties79 | 多国协调的协调成本可能比独立开发更高，最后互相借鉴反而是路径 |
| 批评 | ricardobeat | DAWO 镜像到 Codeberg 的代码可能违反反 AI 生成政策 |
| 澄清 | mitxela | Codeberg 禁的是“AI 生成的项目”，不是“被 AI 碰过的代码” |
| 担忧 | Muromec | 硬政策 + 软执法会催生不公开的影子政策，对政府项目尤其危险 |
| 乐观 | schnebbau | 未来所有代码都将由 AI 生成，手写代码变成铁匠式小众爱好 |
| 反对 | applfanboysbgon | vibecoded 软件没有真正颠覆任何市场，最多形成工具金字塔 |
| 反思 | gspr | 预言“AI 取代一切代码”的语气和加密货币布道者一模一样 |
| 务实 | skohan | NixOS 的不可变哲学与 bleeding-edge 项目（如 llama.cpp）会打架 |
| 解决 | kevincox | 用 in-repo flake + 改 nixpkgs 构建属性，可以无痛切换上游版本 |
| 激进 | shim__ | nixpkgs 应该拆库，只留核心包，安全敏感合并走快车道 |
| 工程 | numpad0 | 联邦化 forge 的根本难题：跨地域根本无法就内容分类达成共识 |

---

## 总体情绪

讨论热度集中在三条主线：对荷兰政府这一举措的普遍叫好，对 NixOS 可复现性在政府场景价值的认可，以及围绕 Codeberg AI 政策的技术辨析。技术派（llama.cpp、nixpkgs CVE、Nix flake）提供了大量干货；政治派虽然发言多，但大多滑向意识形态站队，没能产出可执行的方案。

一个有意思的暗流是：DAWO 几乎没有被批评“做错了什么”，被讨论的是它背后揭示的结构性问题——欧盟为什么不能联合开发？为什么 Codeberg 这种联邦化平台注定巴尔干化？为什么 AI 工具普及后，infra 层的可复现性反而成了稀缺品？

把政府办公套件从微软换成 NixOS，看起来是技术决策，本质上是主权决策——你选谁的可复现性，就决定了你未来的可审计性。

---

## 引用帖子

| # | 标题 | URL |
|---|------|-----|
| 1 | Dutch governments builds alternative for Microsoft based on NixOS | https://news.ycombinator.com/item?id=49841563 |
| 2 | DAWO.community | https://www.dawo.community/en/ |
| 3 | DAWO-NixOS（官方仓库） | https://code.overheid.nl/MinBZK/DAWO-NixOS |
| 4 | openDesk（德国） | https://www.opendesk.eu/en |
| 5 | La Suite（法国） | https://lasuite.numerique.gouv.fr/ |
| 6 | Securix（法国 SecNumCloud 加固 OS） | https://github.com/cloud-gouv/securix |
| 7 | Bureautix-example（法国办公部署样板） | https://github.com/cloud-gouv/bureautix-example |
| 8 | Codeberg 关于 AI 生成代码的政策声明 | https://blog.codeberg.org/protecting-our-floss-commons-from-llms.html |

---

## 免责声明

<div class="disclaimer">

本文为 AI 辅助整理的 HN 讨论摘要。引文均尽量保留原文；如有出入，以 HN 原文为准。原文链接见“引用帖子”一节。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
