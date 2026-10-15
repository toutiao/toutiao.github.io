---
layout: post
title: >-
  患癌后才知道的几件事 —— HN 讨论摘要
date: 2026-10-15
hn_id: 50093568
categories: [articles]
excerpt: >-
  一位 HN 用户把患癌经历总结成 8 条和医疗系统打交道的经验。218 条评论里延伸出 AI 偏差、医生是不是敌人、要不要录音、以及"为什么美国医疗这么贵还这么慢"。
tagline: >-
  你付钱最多的人，可能是最不在意你死活的那个。
---
> ⚑ 本篇含敏感语境提及 (China 仅作为医疗旅游目的地比较出现).

## 原文概要

JJ Maxwell 在 2026 年 5 月被确诊口腔鳞状细胞癌 (squamous cell carcinoma). 他把自己这段经历总结成了 8 条经验, 发表于 [HN 热门榜](/best), 不是医学建议, 是和医疗系统打交道时的"操作手册".

最核心的几条:

- **预约要凶**: 原本要等 4 周的耳鼻喉科, 妻子逼他打电话问有没有人取消, 当周就看上了.
- **AI 会淡化严重性**: 他问多个模型, 多数把他推向"你没有癌".
- **争取全套基因检测**: 外科医生答应做, 但拖了好几个月, 最后转诊给肿瘤科医生才做——而且第一次测的是手术取出的样本, 不是活检样本.
- **标准疗法流程图**: NCCN (美国国立综合癌症网络) 指南任何人都能注册账号看. 他让 AI 帮他挑该看哪一版.
- **手术前找做过的人聊聊**: 他没做, 后悔了.
- **尽快要第二意见**: 他后来去 MD Anderson (美国顶级癌症中心), 医生当场打电话给病理学家, 20 分钟内得到答案——本地肿瘤科医生只会耸耸肩.
- **建一个文件夹, 录音+AI 总结**: Mac 上录音, 每次门诊后让 AI 生成文档并提下次的问题.
- **Sijbrandij 基金会**: GitLab 联合创始人 Sid 自己治癌时建的资源库.

帖子火了之后, 作者在原博客追了一段: "如果你在 2-3 小时车程内能到大癌症中心, 去那儿, 别去社区医院. 我最大的收获是速度."

## 讨论焦点

### AI 倾向于"你没有癌": 一个真实的偏差方向

文章里 JJ Maxwell 提到他问 AI 多个模型, 多数把他推向"你没有癌". 讨论里最先跳出来的是统计学解释:

> "Statistically, it makes sense- most people asking AI if they have cancer don't have cancer, so a model that is lacking detailed information should basically be returning based on the basal rate of cancer in the population with a threshold applied." — dekhn [c:50094775]

> (译文: 统计上说得通——大多数问 AI 的人其实没癌, 所以信息不足的模型理应基于人群基础发病率加一个阈值来回答.)

接着有人反驳:

> "Should it? Or should it say it can't be sure and to ask a doctor? Doctors might do the same thing, of course, but at least then there's a real (accountable) person responsible for deciding that 'threshold.'" — jacobgkau [c:50094835]

> (译文: 它应该这样吗? 还是应该说"我无法确定, 去问医生"? 医生可能也这样, 但至少有一个真实 (要负责) 的人来决定那个"阈值".)

但这条路径马上被堵死了:

> "It's an extremely slippery slope to having it say that about even the most basic medical information. If you don't believe me, try any google search related to something as simple as hangover tips. The AI summary will tell you to call SAMHSA and then brutally stonewall you on anything else even tangential to alcohol." — sublinear [c:50094913]

> (译文: 让它对哪怕最基本的医疗信息都这么说, 是非常滑的滑坡. 不信你去搜任何"宿醉小贴士", AI 摘要会让你打 SAMHSA (美国药物滥用与精神卫生服务管理局) 的电话, 然后对任何哪怕擦边的酒精话题都残忍地拒绝回答.)

另一边则有人早就烦透了"问医生"这种万能推脱:

> "AIs often keep blabbering 'ask a doctor' after every medical question and I absolutely despise this behavior. 99% of the time I'm asking the AI medical advice questions because (1) there is no specialist available on short notice (2) most specialists I actually see do not give me the sense they take things seriously enough (3) a lot of specialists are just incompetent." — qurren [c:50095154]

> (译文: AI 在每个医疗问题后都唠叨"去问医生", 我对此深恶痛绝. 我 99% 的情况下问 AI 医疗建议都是因为: 1) 短期内没有专科医生; 2) 大多数专科医生让我感觉他们没认真对待; 3) 很多专科医生就是不行.)

更扎心的反例来自一个基因学家, 他直接做了实验:

> "I work in genetics, and we did an investigation a few months back, by asking various AIs whether a particular mutation causes $DISEASE. Invariably they were very strongly biased towards saying yes, even for completely obviously benign variants." — mnw21cam [c:50095208]

> (译文: 我做基因学工作, 几个月前我们做了个调查, 问各种 AI 某个突变是否导致疾病. 它们无一例外都强烈倾向于说"是", 哪怕是完全明显良性的变异.)

为什么? 训练数据偏向: 写论文的人会写致病变异, 不会专门写良性变异. 所以 AI 的偏差方向取决于它的语料——不是"统一淡化", 是"语料说什么就倾向什么".

作者本人最后回到中间立场:

> "You should pressure test anything an AI says with your doctors, and anything a doctor says with AI." — jjmaxwell4 [c:50095858]

> (译文: 你应该用医生去压力测试 AI 说的, 用 AI 去压力测试医生说的.)

### 医疗系统是台机器, 你得自己当刺头

最震撼的是脑瘤那则亲历:

> "I was having trouble using my left arm. Like, couldn't lift or type or do much of anything with it. Was told it was a pinched nerve by physiatrists and orthopedists, despite having no pain. Only when I specifically requested for a referral to a second neurologist did he order the head MRI which exposed a brain tumor in my motor cortex." — baggachipz [c:50094836]

> (译文: 我的左臂出问题了, 举不动也敲不了键盘, 被物理治疗师和骨科医生诊断为神经压迫, 但根本不痛. 只有当我主动要求转诊到第二个神经科医生, 他才安排了头部 MRI, 结果发现我运动皮层里有一个脑瘤.)

还有人把"坐诊室当刺头"写成方法论:

> "I had to quite literally sit in a doctor's office and make a public nuisance of myself to get a referral for a family member to a specialist for cancer when the regular doctor said it was just back pain. Then I drove the 2 hours to their office to get the appointment. It was lymphoma." — Loughla [c:50094937]

> (译文: 我真的坐在医生办公室里, 当众让人烦, 才给家人要到一个癌症专科转诊——普通医生一直说只是背痛. 后来我开车两小时去专科, 结果是淋巴瘤.)

helterskelter2 把这条推到极致:

> "Also, if you've got scary symptoms, demand they write down what your symptoms are on your record and why they aren't concerned, then demand a copy of all relevant records (it's your property) -- this often gets them to reevaluate your risk in terms of their career." — helterskelter2 [c:50095239]

> (译文: 还有, 如果你症状吓人, 要求他们把你的症状和不担心的理由写在病历里, 然后要求复印所有相关记录 (那是你的财产)——这常常会让他们从自己的职业生涯角度重新评估你的风险.)

Aboutplants 一句话点透:

> "Don't forget, Doctors are just well read mechanics." — Aboutplants [c:50095279]

> (译文: 别忘了, 医生只是读过很多书的修理工.)

评论里甚至出现了商业想法:

> "I've been daydreaming about starting a US company around the idea of being able to hire a 'medical coach'. Not a doctor, and not a case worker, but someone with a deep knowledge of the American health care system and infinite patience. A trusted person to take you to and from appointments, to chat with you about how things are going, and handle paperwork." — alexose [c:50098496]

> (译文: 我一直想做一家美国公司, 专门雇"医疗教练". 不是医生, 不是社工, 而是对美国医疗系统了解很深、又有耐心的人. 陪你去门诊, 跟你聊进展, 处理文书.)

### 医生也是被这套系统压垮的人

讨论里另一种声音是: 把医生当敌人是误判.

> "What's the difference for a physician today vs. 30 years ago? Among other things, today's physicians struggle because they're being crushed: continuously squeezed by the financialization of their hospital/practice, carrying larger debt, more time spent fighting the insurance machine just to get basic treatments approved. On top of all of that, they are less respected in general and often face outright hostility from patients... all while being paid relatively less than their predecessors." — HelloMcFly [c:50095194]

> (译文: 今天的医生和 30 年前有什么不同? 今天的医生挣扎是因为被压垮了: 医院/诊所不断被金融化挤压, 背着更大的债, 更多时间花在和保险公司搏斗只为让基本治疗获批. 除此之外, 他们普遍不受尊重, 还常常被病人公开敌视——而他们的相对收入却比前辈低.)

longerthoughts 提出一个更尖锐的反问:

> "But how much suffering are patients supposed to absorb to subsidize the stress budget of their doctors? I wouldn't go as far as drawing an analogy here, but it reminds me of debates surrounding police violence in high stress situations. Is there a higher standard when you're accountable for other peoples' lives?" — longerthoughts [c:50097127]

> (译文: 但病人应该承受多少痛苦, 去补贴医生的压力预算? 我不想画类比, 但这让我想起关于高压情境下警察暴力的争论. 当你对别人的生命负责时, 是不是应该有更高的标准?)

这条没人反驳, 因为太尖锐了.

### 录音门诊: 一个意外的争议

文章里 JJ 提到录音+AI 总结. 结果录音这件事在评论里炸开了.

> "No, do not ever do this. In the USA, providers are openly hostile to being recorded. You had better ask at the front desk if you can record anything first. They will tell you no. If you covertly record, then they have every right to refuse you service and eject you from the exam room. They will tell you that it is a violation of HIPAA. It is actually a violation of CYA." — ButlerianJihad [c:50096255]

> (译文: 不, 永远别这么做. 在美国, 医疗提供者公开敌视录音. 你最好先问前台能不能录, 他们会说不. 如果偷偷录, 他们完全有权拒绝给你看病、把你赶出诊室. 他们会告诉你这违反 HIPAA (美国健康保险可携性与责任法案). 其实违反的是 CYA (自我保护).)

DannyBee 直接拿出数据反驳:

> "16% of all appointments are recorded by patients, and the number is increasing all the time. It's up like 20-30% year over year. Only 3% of those recorded are done covertly. Basically all medical associations have issued guidance on this and the guidance is not 'kick people out of the office'. I have never once had a provider become hostile or care." — DannyBee [c:50096716]

> (译文: 所有门诊中 16% 被病人录音, 而且每年增长 20-30%. 其中只有 3% 是偷偷录的. 基本所有医疗协会都就此发了指引, 没有一条是"把人赶出去". 我从未见过任何一个医生因此发火.)

ButlerianJihad 拿出亲身经历反证:

> "My state, Arizona, is a 'one-party recording' state. I have interacted over the phone with two major clinic systems who have busied out my line and hung up on me, just because I activated Call Recording on my Pixel." — ButlerianJihad [c:50098533]

> (译文: 我所在的亚利桑那州是"单方同意录音"州. 我和两家大型诊所通电话时, 因为开了 Pixel 的通话录音, 他们直接让我的线路占线然后挂断.)

### 美国之外: 医疗旅游 vs 系统性比较

评论里很快出现一个分支: 为什么不出去看?

> "My only submission will be to consider India, which is fast becoming a hub for medical tourism. You can get any test you want and meet specialists in hours, not even days." — akshaydeshraj [c:50094680]

> (译文: 我唯一的建议是考虑印度, 那里正快速成为医疗旅游中心. 任何检测你想做就能做, 几个小时就能见到专科医生, 不是几天.)

> "Also China...China is generally better for advanced medical technology and complex hospital-based treatments." — toephu2 [c:50095131]

> (译文: 还有中国……中国在先进医疗技术和复杂住院治疗方面总体更好.)

来自墨西哥的 xtracto:

> "Here in Mexico, i can get to doctoralia and make an appointment with a high specialist, like a Vascular Neurosurgeon. All by myself. The first visit will to maybe $200 usd (and that's very high) and normally it's a week away at most." — xtracto [c:50095329]

> (译文: 在墨西哥, 我上 doctoralia (医生点评网站) 就能自己预约高级专科医生, 比如血管神经外科. 第一次门诊大概 200 美元 (这已经算贵的了), 通常最多等一周.)

但 louthy 提醒: 所谓"美国更慢"是误读.

> "As someone who has seen many health services up close (from founding a health tech company and literally visiting myriad health establishments around the world, over the past few decades), the US hospitals and clinics always struck me as the most run down. But as soon as I walked in the boardroom at UHG or HCA, it suddenly all became a lot more glamorous. And whilst the US does ok with cancer outcomes, so do other nations like Germany, Switzerland, Japan, South Korea, Singapore, Canada, and the United Kingdom. Most advanced nations have universal healthcare with similar outcomes to the US, but for significantly less money. They also don't leave citizens destitute for having the unmitigated gall to impose an unexpected health emergency on themselves. The US system funnels profit, it doesn't provide better healthcare." — louthy [c:50095502]

> (译文: 我近距离看过很多医疗服务 (创办过医疗科技公司, 过去几十年里实地考察过世界各地的医疗机构), 美国的医院和诊所总是给我一种最破旧的感觉. 但一走进 UHG 或 HCA (联合健康集团、哥伦比亚医院集团) 的董事会会议室, 瞬间又金光闪闪. 美国癌症结果还行, 但德国、瑞士、日本、韩国、新加坡、加拿大、英国也一样. 多数发达国家都有全民医保、结果跟美国相当, 但花钱少得多. 他们也不会让公民因为胆敢突发急病而破产. 美国的系统是抽水, 不是提供更好的医疗.)

snapetom 用经济学框架收尾:

> "Health care is a scarce good. There's only so many doctors, so much medicine, so many beds. You have to control access to the goods somehow, otherwise you have a Tragedy of the Commons. In the rest of the world, it's controlled by extended wait times. In the US, it's cost." — snapetom [c:50095534]

> (译文: 医疗是稀缺资源. 医生就那么多, 药就那么多, 床位就那么多. 你得用某种方式控制获取, 否则就是公地悲剧. 在世界其他地方, 是用漫长的等待时间控制. 在美国, 是用钱.)

### 保险的"沉默拒赔"

一条独立支线被 sehugg 抛出来, 几乎所有回帖都在骂.

> "Also beware of the 'Coordination of Benefits (COB) Questionnaire' required by your insurance company. They want to confirm your other coverage (e.g. Medicare) once a year, and sometimes the only way you know they are expecting it is when you get a call from your doctor's office that your claims are being silently denied. The insurance company won't send you an email, a call, or a ding in the portal, the language is buried at the bottom of a page of one of those PDFs you have to explicitly download." — sehugg [c:50094793]

> (译文: 还要小心保险公司要的"福利协调问卷" (COB). 他们每年要确认你的其他保险 (比如 Medicare). 有时候你知道他们要这个的唯一方式是: 医生办公室打电话告诉你, 你的理赔正在被默默拒掉. 保险公司不会发邮件、不会打电话、不会在门户上提示你, 关键的话被埋在一份必须主动下载的 PDF 最后一页.)

datlife 用财报回敬:

> "Looking at financial reports of the major health insurance stocks in the US makes me wonder if they are really 'incompetence'. Take United HealthCare (UNH) for example, they reported $112.7 billion and net income of $4.11 billion in Q3/2026." — datlife [c:50094912]

> (译文: 看美国主要医疗保险公司财报, 让我怀疑这真的只是"无能"吗? 比如 United HealthCare (UNH), 2026 年 Q3 营收 1127 亿美元, 净利润 41.1 亿.)

## 典型观点一览

| 立场 | 用户 | 一句话 |
|---|---|---|
| AI 应该能比大多数医生更值得信任 | qurren [c:50095154] | 99% 时候我就是因为找不到好医生才问 AI |
| AI 整体不靠谱 / 不该信 | ValueTheory [c:50094745] | 又一个"永远别信 AI 聊天机器人"的例子 |
| 必须自己当刺头 | baggachipz [c:50094836] | 不主动要 MRI, 脑瘤就漏了 |
| 医生也是被系统压垮的 | HelloMcFly [c:50095194] | 今天医生比 30 年前更累、更被敌视、相对收入更低 |
| 美国医疗不如其他国家 | louthy [c:50095502] | 同等结果, 花钱多十倍, 还可能让你破产 |
| 美国速度比其他地方快 | snapetom [c:50095534] | 稀缺资源的获取控制: 美国用钱, 其他地方用时间 |
| 该录音 | DannyBee [c:50096716] | 16% 门诊已录音, 主流做法, 不是偷偷摸摸 |
| 别录音 | ButlerianJihad [c:50096255] | 美国医生公开敌视录音, 可能被赶出诊室 |
| 保险是故意沉默拒赔 | datlife [c:50094912] | UNH 一个季度净利 41 亿, 不像"无能" |
| 标准疗法可能过时 | dsign [c:50098651] | 弟弟的"标准疗法"来自 1980 年代, 比新药落后 20 年 |

## 总体情绪

讨论大致分成四条河, 但都流向同一个方向: 你不能把"被治好"这件事外包出去.

一条河是 AI 派: 模型在医疗问题上既可能淡化也可能夸大 (取决于训练语料), 但它至少能 24 小时在线、不会烦、能读你六年六家医院的病历. 另一条河是"刺头派": 医生不是敌人, 但系统是, 要 MRI 就开口, 要第二意见就订机票. HelloMcFly 那条给"刺头派"留了余地——医生被金融化的系统挤得喘不过气, 病人吞下去的苦有一部分是结构性的.

最有冲击力的是 dsign 那条长回帖. 弟弟得了 NPC (鼻咽癌), 美国"标准疗法"是 1980 年代的方案, 到免疫治疗被考虑时已经太迟. "标准疗法"这个词在这个帖子里第一次显出裂缝——它不是医学共识, 是历史遗留.

整场讨论收束在一个不那么英雄主义的句子: 医疗系统是被动的, AI 是被动的, 保险是被动的, 唯一主动的变量是你自己.

## 引用帖子

| # | 标题 | URL |
|---|---|---|
| 1 | Things to know when you get cancer | https://news.ycombinator.com/item?id=50093568 |

## 免责声明

<div class="disclaimer">

本文是对 HN 讨论的摘要, 不构成任何医疗建议. 原文作者 JJ Maxwell 在文中明确指出, 他写的不是医学建议, 而是和医疗系统打交道的"操作手册". HN 上的讨论含有大量个人经历, 每个人的情况不同, 请勿直接套用.

引文已尽量与原始评论核对, 但翻译可能存在偏差. 如发现引文错误, 请通过 GitHub issue 反馈.

**敏感语境说明**: 本文中"中国"一词仅作为医疗旅游目的地出现在一条用户评论中 (与印度、墨西哥并列比较), 不涉及任何政治立场或敏感议题. 保留原文是为如实呈现讨论原貌.

<br><br><em>本摘要由 AI 模型辅助生成: minimax-cn-coding-plan/MiniMax-M3</em>

</div>
