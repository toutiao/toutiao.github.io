---
layout: post
title: >-
  125B 模型跑在 RTX 4090 上 100 t/s，HN 撕的是 2-bit 量化到底行不行
date: 2026-10-05
hn_id: 49953495
categories: [articles]
excerpt: >-
  一款叫 Strata 的开源推理引擎，把 Qwen3.8-Flash-Next 这个 125B 总参、6B 激活的 MoE 模型塞进消费级显卡；HN 上一边贴实测 124 t/s，一边追问：跑到 100 t/s 的代价，是不是把模型量化到 Q2？
tagline: >-
  「100 tok/s」其实是个量化等级，不是性能等级。
---
## 原文概要

2026 年 10 月 4 日，HN 用户 [snehesht](https://news.ycombinator.com/item?id=49953495) 投递了 GitHub 仓库 [Niko1221/Strata](https://github.com/Niko1221/Strata)——一个面向 Windows / Linux 消费级显卡的 [Qwen3.8-Flash-Next](https://huggingface.co/Qwen/Qwen3.8-Flash-Next) 一键安装包。它主打两个数据：在 [RTX 5070](https://www.nvidia.com/en-us/geforce/graphics-cards/50-series/rtx-5070/) 等 12GB+ 显存的 NVIDIA 或 AMD 显卡上「写入 60 t/s、读取 32K prompt 文档 100 t/s」；以及一个明确的设计目标——[Qwen](https://huggingface.co/Qwen) 3.8 Flash-Next 的 125B 总参、6B 激活 [MoE](https://huggingface.co/blog/moe) 模型，普通游戏 PC 也能跑起来。

Strata 的安装路径分两种：一种是把 [AI_SETUP.md](https://github.com/Niko1221/Strata/blob/main/docs/AI_SETUP.md) 喂给 Claude Code、Cursor、Codex、GitHub Copilot 等任意 AI 编程助手，让 agent 自己装；另一种是手动跑 `START-HERE.bat` 或 `./setup.sh`。仓库自带 MCP server，AI 工具可以通过它启停 Strata。模型下载约 70GB，启动时占用 35-55GB 系统内存并锁定一部分给显卡。

`README.md` 给出的速度表（NVIDIA Q2_0 引擎 0.1.36，其它 0.1.26，4K 答案、32K prompt）显示：在 [RTX 2060](https://www.nvidia.com/en-us/geforce/graphics-cards/20-series/rtx-2060/) 这种入门卡上也能跑 Q2_0 33 t/s + ~600 t/s prompt processing；社区结果里 RTX 3090 大约 100-140 t/s。仓库同步开源了一个 919 fork、10.4k star 的 [Coder 版本](https://github.com/Niko1221/Strata#coder-quantization)：把一半专家砍掉，保留 91% SWE-bench Verified 分数（按作者自测），能塞进 32GB 内存。

HN 的讨论没有停留在「能不能跑」，而是把整个对话拖进了一个更刺眼的问题：跑出 100 t/s 的代价是什么——是 Q2 量化。一个 125B 模型被压到 2-bit 权重，磁盘占用降到 ~80GB，速度翻倍，质量呢？

## 讨论焦点

### 实测：124 t/s 在 RTX 4090 上是真的

snehesht 的投递本身就是一段实测：

> "I tried it and it worked surprisingly well. On my machine (Nvidia 4090, 128GB DDR5, Ryzen 7950x3d) I'm getting 124 tokens per sec, thought to share it here." — snehesht [c:49953496]

prettyblocks 在 RTX 3090 上跑 PHP 代码安全审计：

> "I've been playing with this on a 3090 and it FLIES. Does a pretty good job too on the tasks I've thrown at it (php code base security audits)." — prettyblocks [c:49953844]

latentsea 给出了一组关键的对比——同样的 4-bit 量化下，Strata 比 llama.cpp 快近 3 倍：

> "You can run IQ3_XXS, IQ3_S, and IQ4_XS too. I've switched to IQ3_XXS and am running at 60 t/s on Strata vs the 21 t/s I was getting in llama.cpp. Better outputs too." — latentsea [c:49955250]

roscas 在 3080 这种已经「过气」的卡上跑 Coder 版本仍然能写：

> "Coder version with 30t/sec on a Ryzen 3600x with 48GB of RAM with a nvidia 3080.This is not a very fast desktop. Memory speed is around 2000mhz only. My SSD is some of the worst SSD I've seen and 3080 had its days of glory.I still have code, chromium, librewolf and many other programs running. I have video streams running while I also watch tv and many times youtube videos.I use it with the browser that has a great dashboard and with hermes agent and that it really makes this amazing.Only change I made is to set thinking to low.This is a coding model. Any other task, I still use Ornith 1.5 35B that throws 20t/sec and Laguna.XS-2.0." — roscas [c:49954026]

merbanan 给了一组 RTX 2060（8GB VRAM）的入门数字：

> "Q2_0 does 33 tok/s decode and ~600t/s prompt processing at 128k context on RTX2060 8GB VRAM.ISTA IQ3_XXS does ~21 tok/s decode and ~240t/s prompt processing" — merbanan [c:49953978]

数据摆在那里，速度确实到了。但讨论很快转向——这些速度是在什么量化档位上跑出来的？

### 「100 tok/s」背后是 Q2：讨论里第一条分裂线

Tepix 一句话把分歧标了出来：

> "Q2 quantization. Not interested." — Tepix [c:49953980]

0xbadcafebee 把这个怀疑延伸到他们推出的 Coder 版本：

> "Lol, sure, if you quant it to hell (Q2) it'll go real fast...They even link to a Q1 quant (Qwen3.8-Flash-Next-GSQ-RCO-Coder-GGUF) with half the experts ripped out. The idea is it'll go much faster and supposedly benches to not-terrible results. But the problem is you can't rely on it for real world long-horizon coding because that's where reasoning comes in, which is why you want the other layers.It turns out there's still no free lunch. Either get enough VRAM for a Q4, or use a much smaller model. Lobotomizing a larger model just to say you can run it fast isn't useful." — 0xbadcafebee [c:49953945]

tcdent 把整条线升到行业惯例层级：

> "All of these projects targeting low spec systems and "100 tok/s" are the same 2 bit quant without much else. Conveniently none of them include any mention of accuracy in their published numbers. 4 bit is the floor." — tcdent [c:49954153]

esafak 直接把这场讨论改名为「effective intelligence」问题：

> "Has anyone calculated the effective intelligence of these quantized models?I think publishing benchmarks with quantized models should become standard practice." — esafak [c:49953669]

mapontosevenths 用信息论给 Q2 设了一条硬上限：

> "À 2 bit quant will (at best) get you about 80% of the full models memories. That's from a purely information theoretical sense. IRL it's worse than that.Capability can still be better than 80%, but that depends on extensive post-quant recovery training to essentially rebuild the models internal manifold to route around the damage.So, 3.8 Flash Next is better than GLM 5.3 for some things. This version is not.FP4 is as low as you want to go if you want to retain most function and recall. Below that the noise gets too high and information becomes unretrievable. If it's a full quant you don't get to choose which info is lost. Just 20% randomly.One interesting thing about this model is that it uses engrams. Meaning you can separate much of the storage from the compute and quantize them differently. That's not what they did here though. Here it was indiscriminate." — mapontosevenths [c:49954549]

这条线上的反对者也不手软。latentsea 在 4-bit 上跑出比 27B 更好的输出：

> "You can run a 4 bit quant with this. Personally, I switched to running IQ3_XXS and am getting better outputs than 27B and at faster speeds." — latentsea [c:49955260]

bitexploder 拿官方 DeepSWE harness 跑 IQ3_XXS，到一半还稳定：

> "I am benching Flash next on a 3 bit XXS quant and it is holding just fine against published benchmarks. Using DeepSWE official harness and Pi with absolutely zero benchmaxx or harness config. Install stock Pi and running my agents in it. I am halfway through DeepSWE (it takes FOREVER, even at 125 t/s) and it is neck and neck with Opus 4.7 and Sonnet 5.On a 3 bit quant btw.I was skeptical but these results are simply reality now. People have figured out how to selectively quantize the tensors that matter less and shrink these models without losing quality or reasoning. This little Flash Next model just gets things done and is honestly pretty pleasant in terms of its mannerisms :)It is so surprising to me I don't begrudge people their skepticism but these models from Alibaba represent a fundamental and irreversible shift in what local models can do. Qwen 3.8 27B and Flash Next 3.8 are simply different. But people will catch on. I am doing this on $1500 of data center leftover GPUs (V100)" — bitexploder [c:49955352]

nsagent 引用了一篇量化退化的论文给出更细的边界：

> "See this recent paper: Quantization Degradation in Large Language Models: A Signal–Noise Perspective [1]. We observe that such degradation varies substantially across these factors: 4-bit quantization usually preserves performance, 2-bit often causes broad degradation This repo uses 2-bit quantization and removes some of the experts for its smallest fastest model. Make of that what you will.[1]: https://arxiv.org/abs/2608.08188" — nsagent [c:49953976]

sigbottle 把问题反过来问：

> "It's interesting though that Q4 seems to be enough, is there a reason that 4 bit floats are good enough for inference?" — sigbottle [c:49954158]

MaxikCZ 顺着这条线回答——现代模型在训练阶段就已经考虑了量化：

> "New models are trained with 8/4bit quantization in mind. Going from "native" 8 to 4 isnt as big of a step as going from 8 to 4 if native is full bf16." — MaxikCZ [c:49954210]

这条支线的真正分歧点不在「Q2 跑不跑得起来」，而在「Q2 跑出来的还是不是同一个模型」。Tepix 一句 "Not interested" 把价值判断顶到桌面上；mapontosevenths 的 80% 是理论上限；latentsea 和 bitexploder 用实测回应——三个声音都没有被对方说服。

### Flash Next vs 27B：MoE 的胜利还是 dense 的复辟

kennywinker 把这场对比量化到了一个很干净的数字：

> "125b at q2 is ~80gb27b at q4 is ~16gbSo from a raw amount of data, qwen3.8-flash-next wins easily. But flash-next is an MoE model, so it only has 6b parameters active per token, vs 27b's dense 27b per token. So 27b@q4 uses ~16gb of weights per token, and flash-next uses about 4gb of weights (125/80 * 6).But those numbers don't really tell us anything useful, because there is an interplay between total model size and active parameters and intelligence that isn't obvious or simple.(sizes are based on the unsloth quants, not the coder variant, but the idea holds - this isn't calculatable with simple math, you gotta test them and see)" — kennywinker [c:49956595]

「每 token 实际加载 ~1.5GB 权重 vs 27B 的 ~16GB」——这个数字在工程上几乎重写了什么叫「本地能跑」。但同样的仓库页在另一条支线上引起另一种判断。

incognito124 给出了最极端的用户视角：

> "Qwen 3.8 flash next is way better than 27B. It's so good I dont even use claude anymore" — incognito124 [c:49953722]

a11r 把「更好」落到具体工作流上：

> "We recently moved from 27B to Flash Next. The quality is superior for coding. Our workload is primarily well-defined coding tasks that need to be attempted a few times before the model gets it just right. FlashNext is also better at finding issues in generated code than Gemini 3.8" — a11r [c:49955529]

geye1234 是少数反方，而且带着具体复现路径：

> "I find 27B more accurate -- maybe because I'm running at FP8 instead of NVFP4? Flash Next starts making spelling mistakes when I get to 150K context or so. Also it sometimes ignores .md file instructions. Not sure if others have found that." — geye1234 [c:49953970]

anon373839 在底下给了一个可能的根因：

> "Yep, can confirm that is NOT normal. Are you using Nvidia’s NVFP4 quant? There are other NVFP4s floating around but they are not as good. The quality of the calibration data really matters.Qwen Flash Next is just excellent, all the way to the very end of the native 262k context. (I haven’t tried YaRN scaling to 1M, so I don’t know about that.)" — anon373839 [c:49954383]

mickeyp 给 27B 一个不太一样的辩护——他把它定位为「可交办任务的最小模型」：

> "I have not tried Flash Next yet; but 27B is a cracking, little model. It is the first small model that I, as someone with 30 years of experience, can finally say is good enough to hand off small and mid-sized tasks and expect a pretty good result.It is also a competent tool caller when quantised to NVFP4 for use with ninfer; my own harness only reports the occasional hiccup and it is only because the model will sometimes emit tool calling tokens in its reasoning loop." — mickeyp [c:49953771]

proc0 直接追问上游：

> "Do you know how it compares to Qwen 3.8 27B? I really want to compare the distilled ones with harness versus the full MoE versions." — proc0 [c:49953575]

这条线最后被 cycomanic 给出最接近「外部基准」的实测：

> "I've run 3.8 flash next k4_xl on my Strix halo box (128GB). And in the work I have done so far it was not significantly worse than recent GPT (running default model on pro plan). Admittedly I was not doing complex work (reorganizing a jupyterbook), but I could not see significant difference in the quality of the work. It was a striking difference to Laguna s 2.1 which I had tried just before (much faster and much better quality)." — cycomanic [c:49955771]

这场对比没有赢家。Flash Next 在「能跑大模型」上赢，在「原生精度」上偶尔输给 27B；27B 在「稳定性」和「30 年老兵愿意交办」上赢，在「成本下的能力天花板」上落后。两个模型的真正战场，是用户能用什么样的硬件做哪种任务。

### 硬件门槛：RTX 4090 是「99% 买不起」吗

panny 一上来就把讨论拉到这个张力最大的地方：

> "I'm far less interested in how good a big expensive model is on hardware 99% of people can't afford and would rather see what runs best on a chromebook or mobile phone with 8GB of RAM." — panny [c:49953933]

somenameforme 用具体数字反驳——4090 三年前的 MSRP 是 $1600：

> "The card in question here had an initial MSRP of $1600. It's been bumped up by the market, probably because it turned out it's nice for things like this, but it's hardly in the 99% can't afford domain, especially if you're using it to replace a never-ending rent at which point it will pay for itself very rapidly, especially for heavy LLM users.In any case, we've gone from requiring supercomputers, to requiring very high end computers, to requiring $1600 video cards. It's tracking the exact same path that image rendering systems took (which if you haven't been keeping up there, now run excellently on pretty much any plain old computer), and we'll probably be there within a couple of years if not much sooner." — somenameforme [c:49954087]

the__alchemist 把 MSRP 神话戳破——那张卡现在卖 3-4k USD：

> "It was available at this MSRP 3 years ago, direct from Nvidia. It now goes for 3-4k USD, as you point out. MSRP stopped being a useful value for graphics card around that time. You realize the price hike, but still mentioned that 1.6k figure after.No normal person is spending 3-4k on a GPU from 3 years ago. The availability is also of questionable provenance." — the__alchemist [c:49954851]

panny 第二次出击用了更硬的数字：

> ">The card in question here had an initial MSRP of $1600.63% of Americans can't come up with $400 in an emergency.https://www.investopedia.com/here-s-how-many-americans-can-t...The richest country in the world. Where all 50 states consume more than any other country in the world.https://x.com/cremieuxrecueil/status/2102889196000256219Can't come up with %25 of that in an emergency. (Even though the real price is something like 2-3x more than MSRP)It must be nice, up there where you are so incredibly disconnected from reality." — panny [c:49956040]

MrDrMcCoy 替低显存用户给了一个真实可用的替代：

> "Ternary Bonsai 2 might be for you." — MrDrMcCoy [c:49953964]

liuliu 用更冷静的语气给这场讨论泼冷水——「便宜的本地模型有物理上限」：

> "Because that's not possible (to have a GPT 5.6 Sol level model). People won't believe this and will keep dreaming, but intelligence is not free and 8GiB (shared with OS and other processes) is too small to be useful. Whether it is possible for 48GiB or 64GiB (meaning useful for model would be ~16GiB to 24GiB) with external fast storage (SSD), OTOH, is a question mark." — liuliu [c:49954942]

ivanjermakov 用一个段子收掉整条线：

> "These 'revelations' are getting closer and closer to 'download RAM for free' each day." — ivanjermakov [c:49954791]

这条线最终归结到一个尴尬的事实：今天能让本地 AI 推理变得「够用」的硬件门槛，差不多就卡在 $1600 那条线上。对美国 63% 的人来说，这条线等于天堑；对另外 37% 的人来说，它是「节约下来的云端账单」。Strata 没有解决门槛问题——它只是让跨过门槛之后的体验变得更好。

### AI 编码替代 Claude 的现实

thatsabadlook 直接抛出一个对比：「比 Anthropic 快 2.5 倍、有数据主权、还强」：

> "Why is this surprisingly well? It's 2.5x faster than anthropic models, you have data sovereignty, privacy,and that's a strong model. Sounds like a best case scenario to me" — thatsabadlook [c:49953905]

hdjrudni 把这个观察校了一下准：

> "Not sure you understand the term 'surprisingly well'. It means 'better than expected'. I suspect they parent poster didn't actually expect to get >= 100 T/s." — hdjrudni [c:49955594]

StumpChunkman 给出了一类 HN 用户关心的细节：

> "How much VRAM on your 3080? I've got an early 10gb model. I've been thinking of exploring local coding models, but everyone seems to use much better GPUs than I have access to. Yours is one of the first I've seen with maybe similar hardware on some level." — StumpChunkman [c:49954219]

roscas 回应时给了具体的工程上下文——一边跑 AI 一边跑 Chromium 还能工作：

> "Yes, 3080 with 10GB, forgot to mention that.Mine is at the moment writting some cpp code for some SBOM tests.I have loads of terminals open. Librewolf, Chromium and you know how this crap likes ram, I have also a vm with 4gb of ram running and doing stuff while I wait for the results but hey, while I wrote this the program is done. Wow! That was 29.x tokens per second most of the time.Oh I will run some other tests with hermes now because hermes is amazing too." — roscas [c:49954438]

这条线其实在重新画「开发者工作站」的边界——以前写代码、跑 IDE、刷浏览器，现在还要本地挂一个 6B-激活的 MoE 模型。这条路的尽头，是 [agent 自主接管开发机](https://docs.anthropic.com/en/docs/claude-code/overview) 的可能性，mrinterweb 在 curl|bash 主线里把这条隐线连上了：

> "And yet people will let AI agents run autonomously on their machines. I feel like we're reaching peak YOLO with security." — mrinterweb [c:49956142]

### curl|bash 又来了：安全辩论的复刻

RemoveMacAI 那一篇刚刚吵完的事情，Strata 几乎原样复刻了一次——「让 AI agent 帮你跑安装命令」和「`curl foo | bash`」本质上是同一个动作。deadbunny 一句话钉死：

> "> Set up Strata on this PC for me: https://github.com/Niko1221/Strata - follow docs/AI_SETUP.md in that repository.And I thought piping to bash was bad" — deadbunny [c:49953792]

IshKebab 把整场安全讨论打成「reflex reactions」：

> "There is no argument. It's just people's reflex reactions.The technical excuses they come up with (e.g. that the server can detect it and send different content) are just post-hoc justifications for their instinct.Just ignore them." — IshKebab [c:49956587]

Skunkleton 反对 IshKebab 的同时承认了同样的事实：

> "I've never understood the security argument people are making when they complain about `curl foo | bash`. I get that these scripts sometimes mess up your bashrc or whatever, but from a security perspective I see no issue. You are already installing software from the same domain" — Skunkleton [c:49954524]

layer8 在底下把反驳做实：

> "I push binaries from untrusted sources through VirusTotal before running them. Piping a Bash script from curl bypasses that. Furthermore, such Bash scripts, when they aren’t self-contained, make security checks more difficult than a self-contained archive, installer, or binary, even when downloading the script without immediate execution." — layer8 [c:49954669]

ffsm8 把这条线接到「服务端可检测 curl 攻击」的具体 PoC：

> "You can detect the use of curl|bash server side, hence it's an essentially undetectable attack vector. People have shown poc attacks of that kind all the way back in the 2010s" — ffsm8 [c:49954888]

Iolaum 把这件事直接推给 LLM 审计：

> "Nothing is stopping anyone from pointing their agent to that script to review and audit it before running it." — Iolaum [c:49954698]

bee_rider 把「intended workflow」说出来：

> "The intended workflow is to download the install scripts, download the source code, read them both, and then start running things. That’s how Open Source is secured. Piping from bash to curl is just the most obvious warning flag." — bee_rider [c:49955765]

majorchord 紧接着把「intended workflow」打成现实主义笑话：

> "And practically zero people are actually using this 'intended workflow' in the real world." — majorchord [c:49955965]

thomastjeffery 在这条线的最远端给出根因诊断：

> "The real problem is that we just aren't using package managers. We should be using package managers. Package managers are really really good." — thomastjeffery [c:49954779]

rlpb 指出真正刺眼的不是「curl|bash」，而是「curl|sudo bash」：

> "It's `curl foo | sudo bash` that's the bigger objection. Running software usually shouldn't require root, and then the equivalence argument you make doesn't hold." — rlpb [c:49955061]

这场辩论的真正分歧和 RemoveMacAI 一模一样——信任前提没变，把审查外包给 LLM、把命令喂给本地 agent、用 hash 比对、用 package manager，都不能解决「你信任的源今天是不是还值得信任」的根本问题。Strata 和 RemoveMacAI 的存在，本身就是「信任前提」已经无法成立的证据。

### llama.cpp 与新引擎之争

nialv7 在 #1 主线外补了一条工具链观察：

> "There are so many AI generated inference engine for local models now, each of them are generally narrower but they are all faster than llama.cpp. Maybe llama.cpp needs to rethink their strategies..." — nialv7 [c:49954083]

bitexploder 是个有意思的样本——他在 V100 上自己 fork llama.cpp：

> "Not sure I have a strong opinion but I am sort of okay with current state of affairs. I am optimizing for V100. EOL cards on EOL CUDA. Llama is a good enough base for this. A couple weeks of grunting at Claude has gotten the inference /fast/ for my uses. 150-160 t/s" — bitexploder [c:49955472]

这条支线说的是：Strata 这种「窄而快」的推理引擎 vs llama.cpp 这种「全而稳」的基础设施，二者并不在同一价位上。Strata 让 12GB 显存的卡能用 Qwen3.8-Flash-Next，llama.cpp 让「任何卡都能跑任何模型」。这两条线将来大概率不会合并。

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| 实测可用 | snehesht | RTX 4090 + 128GB DDR5 跑到 124 t/s，比预期好 |
| 入门卡也能跑 | merbanan | RTX 2060 8GB VRAM 跑 Q2_0 33 t/s |
| Q2 是作弊 | Tepix | Q2 quantization. Not interested. |
| Q2 必丢能力 | mapontosevenths | 信息论上 2-bit 最多保留 80% 记忆 |
| Q4 才是真甜点 | tcdent | 4 bit 是地板，100 t/s 项目都在隐瞒精度损失 |
| 4-bit 仍有惊喜 | latentsea | 切到 IQ3_XXS 后输出比 27B 还强 |
| 现代模型抗量化 | MaxikCZ | 新模型在 8/4bit 训练，量化损失比旧模型小 |
| Flash Next 强 | incognito124 | 比 27B 还强，已经不用 Claude 了 |
| Flash Next 编码强 | a11r | 团队从 27B 迁到 Flash Next，编码质量明显提升 |
| 27B 仍稳 | mickeyp | 30 年经验里第一次愿意交办任务的「小」模型 |
| 150K 上下文有 bug | geye1234 | Flash Next 在 150K 之后开始拼错，27B 不会 |
| 4090 不是 99% 买不起 | somenameforme | MSRP $1600，三年前直接 Nvidia 卖 |
| 4090 现在是 3-4k | the__alchemist | 2026 年没人会花 3-4k USD 买显卡 |
| 99% 真买不起 | panny | 63% 美国人掏不出 $400 应急 |
| 替代 Claude 已成现实 | thatsabadlook | 比 Anthropic 快 2.5 倍、有主权、还强 |
| curl|bash 安全讨论是 reflex | IshKebab | 没真正的技术论点，只是本能 |
| 应该用 package manager | thomastjeffery | 真正的问题是我们不用包管理器 |
| curl|sudo bash 才是 | rlpb | 大多数人忽略的是要 root |
| 应该用本地 LLM 审计脚本 | Iolaum | 让 agent 帮你审脚本再跑 |
| llama.cpp 该反思 | nialv7 | 这么多窄引擎都比它快，需要重新设计 |

## 总体情绪

整场讨论的核心不在「Strata 跑得多快」，而在「把 125B 模型压到 2-bit 跑出来的还是不是同一个东西」。snehesht 的「124 t/s」和 Tepix 的「Not interested」是这场讨论的两个极点——前者是工程胜利，后者是质量审判。中间被 mapontosevenths、MaxikCZ、nsagent 这几条支线切割成「信息论上限」「现代模型抗量化」「实测退化模式」三块，三块都没有被任一方完全说服。

第二条隐线更刺眼：HN 用户已经在认真讨论用本地 125B MoE 模型替代 Claude 做日常编码。incognito124 直接说「I don't even use Claude anymore」，a11r 描述团队级迁移到 Flash Next，cycomanic 在 [Strix Halo](https://www.amd.com/en/products/processors/ryzen/ai-strix-halo) 上跑 K4_XL 量化觉得不输 Pro 计划默认模型。AI 编码的「本地化替代」已经跨过了工程门槛，但成本、硬件、信任三条护城河没消失——只是把云端账单换成了 $1600 的 RTX 4090 和一个会读 Bash 脚本的本地模型。

100 t/s 真正意味着什么？是 Qwen 3.8 Flash Next 在 Q2 量化下被「快」出来的那一刻，也是用户开始认真思考「我是不是该把整个开发机交给它」的临界点。Strata 不是终点，是一个门槛的标记。

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 主 | Run Qwen 3.8 Flash Next (125B) on consumer hardware (RTX 4090) at 100T/s | https://news.ycombinator.com/item?id=49953495 |

<div class="disclaimer">
本文讨论涉及模型量化等级、性能基准与本地推理工具链，引文为 HN 用户公开发布的内容（CC BY-SA 3.0 / HN Terms），仅作讨论脉络呈现，不代表原作者或本摘要立场。涉及的所有产品名、品牌、基准数字与链接归各自所有者所有。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>
</div>
