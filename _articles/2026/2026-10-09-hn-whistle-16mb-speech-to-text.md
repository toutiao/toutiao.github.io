---
layout: post
title: >-
  16.9 MB 的端侧语音转文字模型 — HN: 比 Whisper 小一个数量级，但 30 秒后断气
date: 2026-10-09
hn_id: 50008427
categories: [articles]
excerpt: >-
  Cactus Compute 把 Whisper 145.3 MB 的模型砍到 16.9 MB、CPU 跑、首字 5.9 ms，7 种语言全在端上。HN 工程圈拿 Parakeet、Moonshine、Whisper、Handy 一齐对比，结论：能塞进任何设备、隐私零担忧，但 30 秒上限 + 不支持流式让它只能做「按段」转写，跟实时听写应用还差一截。
tagline: >-
  把 145.3 MB 砍到 16.9 MB，是 Whisper 重新发明自己。
---
> 来源：HN 热门榜（`/best`）。帖子：[Whistle: Speech to Text in 16.9 MB](https://news.ycombinator.com/item?id=50008427)，336 分，75 条评论。原博客：[cactuscompute.com/blog/whistle](https://cactuscompute.com/blog/whistle)。本文事实基于缓存的 75 条评论 + 原博客全文。

## 原文概要

Cactus Compute（来自 Jakub Mroz 和 Henry Ndubuaku）2026-10-08 发布 Whistle：一个 16.9 MB 的语音转文字模型，跑 CPU、无外部依赖、跟自家 Needle 大模型共享同一个 C++ 引擎。它专为手机、可穿戴、机器人、智能家居、汽车和微控制器设计——目标场景一句话讲清楚：「按一下麦克风，说句话，第二个字已经开始打字」。

能力分三类，都跑在端上：

- **转写**：16 kHz 单声道、一次最长 30 秒、支持 7 种语言（英、德、法、西、意、荷、波），自动检测语言（除非手动指定）。
- **词级时间戳**：每个词带起止时间和概率，对齐自 decoder 的 attention。
- **语音嵌入**：encoder 输出，按 80 ms 一帧，不解码文本。

模型架构跟 Needle 大模型共用部件——8 个 Simple Attention block encoder（4 个 mHC 残差通道 + Monarch Hadamard MLP 替换 FFN），8 个 Laddered Simple Attention block decoder（512 宽、8 query head / 2 KV head、48 维 query/key、64 维 value、Q/K/V 上 3-tap causal conv、layer 3 和 7 上的 engram lookup 跨 18,432 slots）。decoder 跟 encoder 之间用 gated cross attention，gate 每层学一个。

Benchmarks 是这场讨论被围观的原因——Whistle 在 LibriSpeech test-clean / test-other、SPGISpeech、Earnings-22、FLEURS 上超过 Whisper base（后者 145.3 MB）。Whisper base 仍在 TED-LIUM、AMI、MLS 上领先。

延迟侧数据更显眼——Apple M4 Pro CPU 上：5 秒音频首字 5.9 ms、10 秒首字 11.1 ms、30 秒首字 36.3 ms。Whisper 把每个输入都补到 30 秒所以首字延迟恒定；Whistle 跟着音频走，短音频短延迟。

部署面也压得宽——引擎为 17 个目标预编译（macOS / Linux / Android / iOS / watchOS / Windows on ARM / RISC-V / MIPS / 浏览器 / WASI 组件），每个目录里有 `needle` 二进制、`libneedle.a`、`needle.h`，能加载任意 `.cact` 模型。

装法：`pip install cactus-needle`。Playground：`needle whistle playground`，对比模式：`needle whistle compare`（同一段音频跑 Whistle / Whisper / Moonshine 三家）。

## 讨论焦点

### 「把它塞进任何设备」：16.9 MB 真正的吸引力

讨论第一波集中在「能跑在哪」这件事上。mrkn1 把这件事跟同类工具体系拉到一起：

> "love seeing more sub-20MB, CPU-first models. if anyone wants a CLI built on the same ethos (no GPU, no cloud), been using yapsnap streaming Zipformer ASR, plus diarization and timestamps all on CPU! It supports 10 languages. Unlimited transcription for free." — mrkn1 [c:50009122]
> （「很高兴看到又一款 20MB 以下、CPU 优先的模型。想要同理念（无 GPU、无云）CLI 工具的可以看看 yapsnap——流式 Zipformer ASR，加上 diarization 和时间戳，全跑 CPU，10 种语言，免费无限转写。」）

yymir 把 16.9 MB 这个数字真正能做的事点透——

> "i mean for something this small, it can be fit into a l3 cache on a cpu and be essentially always on various purposes" — yymir [c:50009447]
> （「这么小的东西，可以塞进 CPU 的 L3 cache，本质上常驻随时调用。」）

kamranjon 的实测是最直接的背书——

> "Sooo I haven't really been super impressed with the needle models before, but this is very impressive. It transcribed multiple sentences I gave it with complex timing and words and in such a small footprint, I'm super impressed. Excited to see what types of things can be built with something like this, the performance seems very good." — kamranjon [c:50009247]
> （「我以前对 Needle 那几个模型没太大感觉，但这个真的强。复杂时间戳、复杂词汇、几段句子、超小体积，全能跑。性能看上去非常好，很期待能用它造什么。」）

——mrkn1 + yymir + kamranjon 这条线把 Whistle 真正的卖点讲清楚了：不是「比 Whisper 准」，而是「能塞进 CPU L3 cache、本地无限调用、零云依赖」这条工程边界。一旦这条边界达成，16.9 MB 就不是「小」，而是「可以常驻任何设备、随时按需调用」——这是大模型给不了的能力档位。

### 「30 秒上限」：按段 vs 流式的硬分水岭

讨论里被反复吐槽的是 30 秒上限。mo2art 第一时间就撞墙——

> "RuntimeError: audio limit is 30 s" — mo2art [c:50009409]
> （「运行时错误：音频超过 30 秒。」）

jjice 把这个错误直接归到使用方式上——

> "Did you record over 30 seconds?" — jjice [c:50009547]
> （「你是不是录了超过 30 秒？」）

但真正的不满来自想做「实时听写」的人——albert_e 把这条线拉到 Whistle 没支持的能力上：

> "What the demo does not do is show streaming output of transcribed text as we are speaking and recording (before we hit stop). That is an essential feature IMO for most general purpose live STT apps." — albert_e [c:50009740]
> （「Demo 没有做我们还在说话、还在录音（按 stop 之前）时的流式输出。绝大多数通用 STT 实时应用在我看来需要这个。」）

iforgotmypasswo 直接把「不流式」当成选择 Deepgram 的理由——

> "This is the main reason I lean on Deepgram over local services." — iforgotmypasswo [c:50010199]
> （「这是我现在选 Deepgram 而不是本地服务的核心原因。」）

paynedigital 用一个反例打破「本地一定不支持流式」的假设——Nemotron 3.5 Streaming 可以做到低延迟、本地、多语种流式：

> "You can absolutely do high quality, low latency, even multilingual local streaming nowadays. As the commenter above says, Nemotron 3.5 Streaming is awesome. We make heavy use of it in our transcription app." — paynedigital [c:50011071]
> （「本地完全能做到高质量、低延迟、多语种流式。就像楼上说的，Nemotron 3.5 Streaming 很强，我们自己的转写 app 重度依赖它。」）

——mo2art + albert_e + iforgotmypasswo + paynedigital 这条线说明 Whistle 的能力边界画得很清楚：单段 ≤ 30 秒、按下 stop 才出文字、不做流式——这是设计选择，不是 bug。HN 的反应是「这工具的用武之地是按段转写」，实时听写要用别家。

### 「把音频模型集成进 app」：Whistle vs Parakeet 的取舍

讨论里最深的一条对比是 Whistle vs Parakeet。wkcheng 提了一个工程现实——

> "How does this compare with Parakeet? I've been using that locally in my projects on an M-series macbook and it's been working great. It's fast and accurate enough for my use cases (meeting transcription, audio transcription for demo videos, etc.) This definitely seems lighter and faster. How does accuracy compare?" — wkcheng [c:50009751]
> （「跟 Parakeet 怎么比？我在 M 系列 MacBook 上用过 Parakeet，效果很好。我这种场景（会议转写、demo 视频音频转写）又快又准。这个明显更轻更快，准确率怎么比？」）

theturtletalks 把 Whistle 的真正定位说成「能嵌入 app」，而不是「比 Parakeet 准」——

> "Parakeet is the gold standard. With models like moonshine and koroko (TTS model), it's more about embedding the model in the application itself. If you're using Parakeet, embedding it in the application is not feasible. I use parakeet with superwhisper, and I'm making another app that has SST and TTS built in, and I want to use my downloaded parakeet model, but it seems there's so many different implementations from ONNX to whisper, it's not easy to use your downloaded models. So models like moonshine and this one allow you to just embed it into your application simply. It might not be as good as parakeet, but it gets you 80% of the way there." — theturtletalks [c:50010166]
> （「Parakeet 是金标准。但 moonshine、koroko（TTS 模型）这一类模型真正的价值是能嵌入 app 里。Parakeet 你没法直接嵌进 app——我自己的 app 想用下载好的 Parakeet 模型，从 ONNX 到 whisper 各家实现都不一样，很难集成。moonshine 和 Whistle 这种就能直接嵌进去。可能没 Parakeet 那么强，但能做到 80%。」）

jwr 把这种取舍绑到「准确率 vs 可用性」上——

> "People keep praising Parakeet, but I've found it to be worse than Whisper Large. Yes, it is much, much faster and smaller, but accuracy matters a lot if you are to use dictation regularly and seriously." — jwr [c:50010763]
> （「大家都在夸 Parakeet，但我觉得它不如 Whisper Large。是的，快很多、小很多，但要真把听写当日常工具用，准确率很重要。」）

weitendorf 把整张取舍表分成四档——

> "It's really domain dependent I think. If you are doing anything conversational interfacing with less AI-familiar users, latency matters a lot. If you're feeding the results into a very smart LLM, it will figure out what you meant (but crucially ONLY if you warn it or tell it to do so, in some cases!). If you're writing code directly or creating something for public consumption, you can't tolerate mistakes. If you're taking notes for yourself you just want it to work cheaply." — weitendorf [c:50011060]
> （「完全看场景。跟不熟 AI 的用户做对话界面，延迟最重要。把结果喂给很强的 LLM，它能补对——但关键是要事先告诉它！直接写代码或者做公开发布，错字不能忍。自己做笔记，便宜能用就行。」）

——wkcheng + theturtletalks + jwr + weitendorf 四句话把 STT 工具的取舍画得很清楚：Parakeet 准但难集成，Whistle 集成容易但准确率不是金标准；用户挑哪个完全看场景——做会议转写 demo 选 Parakeet，把 STT 塞进自己的硬件产品选 Whistle，写代码容忍不了错字选 Whisper Large。

### 「我父亲中风后说话」：端侧 STT 的真正救命场景

讨论里最沉的一段是 INTPenis 提的个人场景——他给中风后口齿不清的 84 岁克罗地亚父亲装 Windows STT：

> "I don't think the challenge with speech to text was size of the binary. In my experience the challenge is understanding my 84 year old Croatian father with a sagging mouth after a stroke, when he's trying to write his autobiography. I just setup Windows speech to text for him last week and it's great to see how he can write an entire page in 10 minutes, it would take him days using the keyboard. But every single sound he makes with his mouth ends up on the page too." — INTPenis [c:50008908]
> （「我不觉得语音转文字的挑战是模型大小。我的体验是——能不能听懂我 84 岁、中风后嘴部肌肉下垂的克罗地亚父亲说话，他在写自传。我上周给他装了 Windows STT，看到他 10 分钟能写一整页、键盘上写要好几天，这很棒。但他嘴巴发出的每个声音都跑到纸上了。」）

ComputerGuru 立刻指出——这种场景需要的不是通用 STT，而是带「过滤填充词」和「自我修正」能力的听写模型：

> "He needs a dictation model, not a general purpose speech-to-text model. They ignore umms and ahhs, change things like 'an elephant, no a monkey, went up the tree' to 'a monkey went up the tree,' support saying punctuation aloud sometimes, etc." — ComputerGuru [c:50009019]
> （「他需要的是听写模型，不是通用 STT。听写模型会过滤 um / ah 这种填充词、把『一只大象、不对一只猴子、上了树』改成『一只猴子上了树』、有时还能念出标点。」）

yu3zhou4 把这个场景的工程难度讲出来——核心是「数据稀缺 + 个人化语言模式 + 患者之间差异大」三个同时难的问题：

> "I was researching STT for people with speech disorders two years ago and essentially everything was boiling down to three problems at the end of the day - data scarcity, irregularity of way of speaking and thus constant ambiguity in translation, and individual differences in speech patterns among patients." — yu3zhou4 [c:50010645]
> （「两年前我研究过给语言障碍患者做的 STT，到最后所有事都归结到三个问题——数据稀缺、说话方式不规律导致翻译永远模糊、患者之间个人差异巨大。」）

islewis 把这类场景跟 Whistle 的能力边界对齐——「小模型适合在隐私敏感或低延迟场景，但代价是品质」：

> "The usecase for small models like this is making on-device STT/TTS more accessable. This is important if your usecase is sensitive to either privacy or latency, but this comes at the cost of quality. My experience has been that these small TTS models are unexpectedly good if your audio is in distribution (western accents, higher quality audio, common vocabulary), but pretty quickly degrade as you move outside of that." — islewis [c:50011221]
> （「小模型的用例是让端侧 STT/TTS 更可达。如果你的场景对隐私或延迟敏感这很重要，但代价是品质。我的经验是这些小 TTS 模型在音频分布内（西方口音、较高音质、常用词）异常好，但稍微超出分布就快速劣化。」）

——INTPenis + ComputerGuru + yu3zhou4 + islewis 四句话把「端侧 STT 真正的救命场景」讲明白：Whistle 这种 16.9 MB 模型对中风、ALS 等运动性语言障碍患者来说，正是「数据不出设备、不靠云、不依赖网络」这个能力档位；通用 STT 模型对健康人准，对这类人不仅没用，反而把每个错误的发声都忠实地写下来变成噪音。

### 「Thank you」幻觉：训练数据留下的指纹

讨论里最让人会心一笑的一段——zimpenfish 拿 Whistle 跑了一集电视剧，发现模型会卡在「Thank you」上：

> "Tried it on a random TV episode and it seems to get stuck sometimes where it just outputs 'Thank you.' as a default - at one point emitting that for 60s of dialogue (and no, the episode does not have someone repeating 'Thank you.' for 60s.) Happens several times during the transcription." — zimpenfish [c:50010298]
> （「跑了一集随机电视剧，模型有时候会卡在默认输出『Thank you』——有一处甚至对 60 秒对话都输出这句（不，那集没人在 60 秒里重复『Thank you』）。转写里这种情况出现好几次。」）

jwr 一句话把这个 bug 讲得通透——

> "It's funny how so many models tend to generate 'Thank you. Don't forget to subscribe' or 'Thanks for watching' if there is silence. Shows you what they've been trained on :-)" — jwr [c:50010492]
> （「好笑的是很多模型一遇到静音就生成『Thank you. Don't forget to subscribe』或者『Thanks for watching』——你就知道它们训练数据里有什么了。」）

——zimpenfish + jwr 把这一段总结成「训练数据指纹」：YouTube 上「别忘了订阅」这种结尾词在静音段出现频率极高，模型在置信度低的时候就会回到训练数据的「默认结尾」。这不是 Whistle 独有的问题，所有在 YouTube 字幕数据上训练的 STT 都会掉进同一个坑——但 16.9 MB 砍掉参数后这个指纹就更明显。

### 「把整个对话栈跑在本地」：硬件产品的拼图

讨论收尾的方向是「我能不能用这些工具做个本地语音硬件」。amelius 把整张拼图摆出来——

> "Let's say I want to build a hardware product now, voice-controlled, with voice feedback, so STT, LLM, and TTS. All local. What are the best libraries to do this now, say with 8GB of GPU memory available?" — amelius [c:50012184]
> （「假如我现在想做个语音控制的硬件产品，本地 STT + 本地 LLM + 本地 TTS 闭环。8GB 显存能跑的前提下，哪些库最好？」）

contingencies 端出他的实际组合——Parakeet Unified EN 0.6B 做 STT、整个栈本地——

> "For speech to text UX I currently use handy.computer as it's cross platform and open source. With that I am currently using Parakeet Unified EN 0.6B and finding it excellent. Often I use it to talk to AIs without giving them audio, which works very well. Honestly, I would never go back to typing now. Promised since ~Y2K, the tech is finally here. You really notice it when you wake up at 2AM and don't want to wake people ... it can get really annoying reverting to key-tapping. My long-gnawing fear of losing my hands to RSI is no longer a thing, and I can focus on losing them to another hobby: like sailing or machining!" — contingencies [c:50011280]
> （「我用 handy.computer 做语音 UX，跨平台开源，搭配 Parakeet Unified EN 0.6B，效果非常好。我经常用它跟 AI 对话但不让它们直接听音频。真的不打算回到键盘了——Y2K 时代就承诺的技术现在终于到了。凌晨两点不想吵人的时候特别明显——再回去敲键盘真的烦。RSI 伤手的长期担忧现在没了，我可以把注意力放到别的爱好上了，比如航海和金属加工。」）

skolos 进一步把 Whistle 用在 Echo Show 上——它不再往 Amazon 拨号，所有处理本地：

> "Interesting that this is here. I used whistle (and bunch of other things) to take ownership of my echo show. It now doesn't dial to Amazon at all - it does all processing locally with its own CPU and connects to my homeassistant for home automation. My initial setup involved qwen asr (1.7b model) running on rtx 5080. Compared to that whistle was really bad (out of 170 messages, qwen recognized correctly 168, whistle - 70), but I adjusted whistle to work like jev - instead of free form transcription it recognizes only select set of templates (I trained tiny network with 10,000 generated utterances to translate whistle final state to probabilities within templates). The precision went up to 164/170 - almost matching qwen." — skolos [c:50011633]
> （「有意思这个发出来了。我用 Whistle（外加其它一堆东西）接管了我的 Echo Show。它现在完全不往 Amazon 拨号——CPU 本地全跑，接 HomeAssistant 搞自动化。最初我装的是 rtx 5080 跑 qwen asr（1.7B 模型），跟它比 Whistle 差很多（170 条消息，qwen 认对 168，Whistle 70），但我把 Whistle 改成 jev 那种模式——不自由转写，只识别模板集（我训了个 10,000 句生成语料的小网络把 Whistle 输出转成模板内的概率）。精确度提升到 164/170，几乎追平 qwen。」）

——amelius + contingencies + skolos 把 Whistle 在 2026 年的真正应用场景串起来：硬件产品本地语音栈、键盘替代、隐私设备接管。16.9 MB 这个数字在这些场景里不是「小」，而是「够用 + 不联网 + 永远在线」——这正是端侧模型相比云端 STT 的核心差异化。

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 又一款 CPU 优先小模型 | mrkn1 | yapsnap 是同类，10 语言 |
| 能塞进 L3 cache 常驻 | yymir | 这种大小才能真正随时在线 |
| 实测强过 Needle 前作 | kamranjon | 复杂时序 + 复杂词都跑通 |
| 30 秒上限直接报错 | mo2art | RuntimeError |
| 流式才是 STT 必备 | albert_e | Demo 没做边说边出字 |
| 不流式就用 Deepgram | iforgotmypasswo | 本地 STT 的关键缺位 |
| Nemotron 3.5 Streaming 也能本地流式 | paynedigital | 不是技术做不到 |
| 跟 Parakeet 怎么比 | wkcheng | 速度更小，准确率呢 |
| 真正价值是嵌入 app | theturtletalks | Parakeet 难集成，Whistle 易集成 |
| Parakeet 不如 Whisper Large 准 | jwr | 听写当日常用，准确率关键 |
| 场景决定取舍 | weitendorf | 笔记本 / 写作 / 对话界面需求不同 |
| 我给中风父亲装的 STT | INTPenis | 84 岁、口齿不清、写自传 |
| 他需要听写模型不是通用 STT | ComputerGuru | 要过滤 um / ah 这种 |
| 三难问题：数据 / 个体差异 / 不规律 | yu3zhou4 | 语言障碍 STT 的结构性困难 |
| 小模型代价是质量 | islewis | 出分布快速劣化 |
| 静音卡在 Thank you | zimpenfish | 60 秒对话只输出这一句 |
| 训练数据指纹 | jwr | YouTube 字幕训练就有这毛病 |
| 本地语音硬件栈怎么搭 | amelius | 8GB 显存本地 STT + LLM + TTS |
| 听写已经替代键盘 | contingencies | RSI 担忧解除，转去航海 |
| 把 Whistle 用在 Echo Show 上 | skolos | 接管 Amazon 设备，170/170 接近 qwen |

## 总体情绪

整场讨论的情绪分裂在三条平行线上，互相不交叉，但都围着 Whistle。

第一条是「能力线」——mrkn1 + yymir + kamranjon + skolos：把 STT 从云端拽下来、塞进 L3 cache、塞进 Echo Show、塞进硬件产品，这条线对 Whistle 的真正价值定位很清楚：不是「比 Whisper 准」，而是「能塞进任何设备且永远在线」。Cactus Compute 这次发布的核心卖点不是 benchmark，而是 17 个部署目标和 16.9 MB 这两个数字。

第二条是「边界线」——mo2art + albert_e + iforgotmypasswo + wkcheng + jwr：30 秒上限、不支持流式、不如 Parakeet 准——HN 工程圈对 Whistle 的能力边界画得很清楚。这条线不是「负面」，是「预期管理」：Whistle 的设计目标是按段端侧转写，不是会议实时听写；用错场景是用户的问题，不是工具的问题。

第三条是「人性线」——INTPenis + ComputerGuru + yu3zhou4 + islewis：84 岁中风父亲写自传、贴满整个键盘的发声错误、无障碍场景对 STT 工具的真实需求。这条线让 Whistle 16.9 MB 这个数字脱离「技术炫技」框架，落到一个更具体的判断：端侧模型对隐私敏感、健康受限、低网络依赖人群才是真正的「能救命」能力档位。

整体情绪是「真有用，但不是这一波 STT 工具的终局」。Cactus Compute 把 Whisper base 砍到 1/9 大小、CPU 可跑、17 个部署目标——这件事本身已经够工程圈消化。但 HN 同时看清了三个限制：30 秒按段、不流式、不如大模型准。这场讨论最重要的副产物是 skolos 那段——一个用户在 Echo Show 上把 Whistle 改造成模板匹配的小模型，让 170 条消息的准确率从 70/170 提到 164/170。模型小到能塞进设备不是「省资源」，是「可以被任意改造塞进用户自己的应用」——这才是 16.9 MB 真正的革命性。

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | HN 原帖 | https://news.ycombinator.com/item?id=50008427 |
| 2 | Whistle 原博客 | https://cactuscompute.com/blog/whistle |
| 3 | Needle 大模型仓库 | https://github.com/Cactus-Compute/needle3 |
| 4 | yapsnap（同类 CPU 工具） | https://github.com/kouhxp/yapsnap |
| 5 | Handy（听写 UI） | https://handy.computer/ |
| 6 | ZWhispr（macOS 三模型组合） | https://zwhispr.com/ |
| 7 | Nemotron 3.5 Streaming 模型 | （NVIDIA Hugging Face 仓库） |
| 8 | Wispr Flow（同类闭源产品） | https://wisprflow.ai/ |
| 9 | SuperWhisper（Mac 听写） | https://superwhisper.com/ |
| 10 | dsh-stt（DeepSeek Harness 的 STT 插件） | https://github.com/try-works/dsh-stt |

<div class="disclaimer">

本文为 HN 热门帖的讨论摘要，非原文翻译，不代表本站立场。所有引文均标注原作者与 HN comment ID，可在原帖核对。原博客的所有 benchmark 数据（LibriSpeech / SPGISpeech / Earnings-22 / FLEURS / TED-LIUM / AMI / MLS）、延迟数据（M4 Pro 5/10/30 秒音频首字延迟）、架构细节（Simple Attention / Laddered Simple Attention / gated cross attention）来自 cactuscompute.com 原文。HN 评论区补充的实测体验（西班牙语 / 波兰语准确率、30 秒上限、流式输出缺位、训练数据指纹「Thank you」现象）由各 HN 用户单独报告，与 Cactus Compute 官方数据无直接对应关系。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>
