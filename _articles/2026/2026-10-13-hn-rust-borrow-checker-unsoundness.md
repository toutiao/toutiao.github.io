---
layout: post
title: >-
  Rust 借用检查器里潜伏了 11 年的 unsoundness bug —— HN 讨论摘要
date: 2026-10-13
hn_id: 50069499
categories: [articles]
excerpt: >-
  一段十几行代码就能让 Rust 编译器放过一个本不该存在的内存安全违规：用协变字段赋值绕过 `T: 'static` 约束。最早的复现版本可追溯到 Rust 1.4（2015 年），但直到 2026 年 10 月才被人发现。
tagline: >-
  救火的人被奖励，写类型系统的人被遗忘 11 年。
---

## 原文概要

来源：[HN 热门榜](https://news.ycombinator.com/item?id=50069499)

2026 年 10 月 13 日，rust-lang/rust 仓库里的 issue [#164250](https://github.com/rust-lang/rust/issues/164250) 被公开：Rust 类型系统在 11 年里漏掉了一个 unsoundness bug。它的核心机制是利用`Option<T>` 的协变性，把一个生命周期很短的引用塞进了结构体里那个声明自己需要 `'static` 的字段，编译器接受了这份赋值，等到 `Drop` 真正去读这个引用时，源数据早已被回收。

把原报告的最小复现代码压缩到极致，大致长这样：

```rust
struct Q<T: 'static>(Option<T>);
impl<T: 'static> Drop for Q<T> {
    fn drop(&mut self) { /* 以为里面是 &'static String */ }
}
fn main() {
    let l = String::new();
    let mut q = Q(None);
    q.0 = Some(&l);
}
```

这段代码不应该编译通过，但它确实通过了。开启 ASan 运行后，程序会以 `stack-use-after-scope` 崩溃；关闭 ASan，则会读到已被回收栈帧里的字符串残骸。报告者 theemathas 给出的简化版本自 Rust 1.18（2017 年）起就能编译，而 Rust 团队成员 maxdexh 给出的另一个版本更是可以追溯到 Rust 1.4（2015 年）。

issue 被官方标记为 `P-critical` 与 `I-unsound`（类型系统层面最严重的那一类），并加上了 `A-borrow-checker`、`A-destructors`、`A-lifetimes`、`A-variance` 四个相关标签。@lcnr 在补充说明里强调：这段代码看起来容易触发，但想要真正"利用"它造成内存不安全，需要一个故意为之的 `Drop` 实现，"误打误撞触发的概率很低"。

## 讨论焦点

### 为什么一个这么小的 bug 能藏 11 年

> "What the hell. This is not the esoteric, crazy, impractical constellation I expected to find with a title like this. The minimal example is so simple and is definitely something you'd easily come across in normal code." — vincent-uden [c:50069748]

> （翻译：看到这个忍不住骂了句脏话。原本以为标题党、点进来会看到一坨复杂到没边的偏门写法，结果最小复现就这么几行 —— 而且普通业务里完全会自然地写出来。）

这种反差是讨论里反复出现的张力：代码看起来"朴素"，但 11 年没人撞到它。fg137 的反驳也很典型 ——

> "The fact that nobody reported this before means it's not, by definition." — fg137 [c:50070514]

> （翻译：既然 11 年没人报告，那就说明这种写法根本不常见。）

vincent-uden 的回应是这种"少见"具有误导性：Rust 的生命周期系统能表达的合法场景远多于它能拒绝的非法场景，"也许坏代码一直在跑、行为看起来还对，只是寿命碰巧没出岔子"。foldr 在子帖里把这个观点推到了底 ——

> "Simplified, the point is that a lot of badly typed code that this bug lets through might be mostly harmless (or even fully semantically correct, in some instances). So you can't conclude that 'normal' code wouldn't trigger this bug just because no-one's noticed it until now." — foldr [c:50072184]

> （翻译：bug 放过去的代码大多无伤大雅，甚至语义上完全正确。所以"没人发现"不能等于"普通代码不会触发" —— 它可能一直在悄悄通过编译，运行时也安然无恙。）

这是一个反直觉的发现：语言设计上"严格"，并不等于现实里被严格使用。

### 这到底算类型系统的 bug，还是编译器的 bug

这是整场讨论里最有技术含量、也最容易绕进去的一根线。csande17 给出了一个颇为"扎心"的判断 ——

> "Yes. When people describe Rust as 'a memory-safe programming language' they are describing an aspirational vision, and not a programming language that has actually been designed with sufficient rigor to guarantee memory safety. Any failure of rustc to actually guarantee this is just a bug in rustc itself, a failure to properly implement the Rust spec, because the closest thing Rust has to a spec is literally just the vague ideal that the compiler should guarantee safety somehow.

> Rust cannot fail, it can only be failed." — csande17 [c:50070420]

> （翻译：把 Rust 称为"内存安全语言"其实是在描述一个愿景，而不是一个已经达到严谨设计目标的产品。rustc 任何一次违反内存安全的失败，都只能被解读为"实现 spec"的失败 —— 因为 Rust 离真正的 spec 最近的东西，只不过就是"编译器应当保证安全"这个模糊理想。

> Rust 本身不可能失败，只能是被失败。）

DriverDaily 用客户和供应商的关系打了类似的比方："客户让我做一个完美的系统，完美是他的定义，实现里任何不完美都是我的责任 —— 这种 brief 我得拒掉。"支持者阵营里，mcherm 站出来为 csande17 "纠偏" ——

> "It is true that Rust does not have a complete formal specification for its type system which has been analyzed and proven to be sound.

> You seem to be implying that because of this, Rust has no definition of its type system (other than whatever happens to be implemented in the current compiler). I would disagree.

> As evidence, I would like to point out that not a single person argued that this flaw was not a bug, but was in fact the officially defined behavior. Clearly, the community has a shared understanding of what Rust's type system 'ought' to do." — mcherm [c:50072136]

> （翻译：Rust 的类型系统确实没有一份完整的、可被证明 sound 的形式化 spec。但你似乎在暗示，因为没有 spec，Rust 的类型系统除了"编译器此刻在做什么"以外没有别的定义。这点我不能同意。

> 证据是：没有一个人声称这个 bug 不是 bug，反而是"官方明确定义的行为"。显然，社区对类型系统"应该"做什么有共识。）

这一段对话把"spec 是谁"这个哲学问题留在了桌面上。Rust 团队自己一边修 bug 一边被指控"语言本身没定义" —— 但只要社区一致认为这是 bug，"被定义"就不只是编译器的事。

### "YOLO" 一词引发的形式化验证之争

vrighter 的发言把火引到了更大的命题上：

> "so what I take from this is that the rust compiler does not guarantee the stuff it claims to. Because new features of the type system is just being yolod instead of formally proven" — vrighter [c:50070268]

> （翻译：我从这里得出的结论是，Rust 编译器并没有保证它声称要保证的东西。新的类型系统特性没经过形式化证明就直接放出来，就是 yolo。）

这句话被反驳得最多，也最密集。roblabla 先给出技术事实 ——

> "There never was formal verification of the entire rust compiler, or even its complete borrow checker/type system. There has been verifications on _subsets_ of them.

> Also, a lot of those soundness issues aren't related to new features _at all_, but usually due to poor assumptions made in optimizations." — roblabla [c:50070456]

> （翻译：从来没有过对整个 rust 编译器、或者完整的借用检查器 / 类型系统的形式化验证。已验证的都是子集。

> 而且很多 unsoundness 问题和新特性毫无关系，往往是某个优化里做了一个不当假设。）

afdbcreid 把未来的目标摆了出来 ——

> "The eventual goal is verification of the full system. Not the implementation, yes, that's infeasible. But this will mean all soundness bugs will be either found and fixed or we'll know how to fix them once they're found. In any way they won't be fundamental (which is believed to be the case today, but not proven)." — afdbcreid [c:50071344]

> （翻译：长期目标是验证整个系统。验证实现不现实，但这意味着所有 unsoundness bug 都会被找到并修复，或者我们知道发现后该怎么修。无论如何，它们不会是无法修的"原理性 bug"（这是当前的猜想，但还没证明）。）

最击中要害的反驳来自 cscheid ——

> "These were Turing-award caliber people figuring it out and, according to your definition, 'yolo'ed it. This stuff is _hard_, and these driveby comments truly aren't helpful." — cscheid [c:50072574]

> （翻译：当年解决 SML 协变问题的是图灵奖级别的人物。按你的定义，他们当时也是 yolo 的。这事儿真的很难，这些路过的评论没多大帮助。）

"yolo" 这个词能在这里引爆，是因为它把"工程实践"和"形式化证明"这两个不同等级的要求强行压到了同一个维度上。cscheid 的潜台词是：批评"没有形式化证明"很容易，但站在 SML 的历史肩膀上，谁也没资格嘲笑前人。

### C/C++/Java 阵营 vs Rust 阵营的拉锯

讨论后半段几乎演变成小型阵营战。代表 Rust 阵营的是 vlovich123 的一段"数据论证" ——

> "Rust code does achieve the memory safety goals over C++ even though there's bugs in the compiler. That's why Rust is very quickly eating all things C and C++. A huge amount of value that the industry would just be unable to access for a long time if you waited for everything to be formally proven." — vlovich123 [c:50072670]

> （翻译：哪怕编译器有 bug，Rust 在内存安全这件事上仍然明显胜过 C++。这就是 Rust 正在迅速吃掉 C/C++ 地盘的原因。如果非要等到形式化证明全部完成才用，业界很多价值要等很久才能拿到。）

反对阵营则拿 Java 做挡箭牌。UncleMeat 的反问很直接 ——

> "Would you say the same thing about Java? It's type system is also unsound." — UncleMeat [c:50070619]

> （翻译：Java 的类型系统也 unsound，你会用同样的话评价它吗？）

afdbcreid 给出了一个相当精彩的反向反驳 ——

> "While true, there are two important differences: 1) Unsoundnesses in Java's type system are checked at runtime. 2) They (or at least some) are intentional or at least won't-fix bugs. Both are not true for Rust." — afdbcreid [c:50070761]

> （翻译：你说的没错，但有两点关键不同：第一，Java 类型系统的 unsoundness 是运行时检查的；第二，至少有一些是故意的或不会修复的 bug。这两点对 Rust 都不成立。）

言下之意，Rust 走的是更难的那条路：编译器在自己身上挑 bug，并且真的修。bcjdjsndon 则是把"安全 = 文化产物"这个论点搬了出来 ——

> "If you could be trusted to do that, we wouldn't need rust in the first place.... The basic contradiction of the rust fad, coders can't be trusted to be memory safe so those same coders must use rust and then all of a sudden they can be trusted not to make common mistakes." — bcjdjsndon [c:50073227]

> （翻译：如果你值得被信任，那就根本不需要 Rust。Rust 流行的根本矛盾在于：程序员既然不能被信任写出内存安全的代码，那为什么同一个程序员又能被信任写出"安全"的 unsafe Rust？）

这条论点犀利但回避了一个关键点：Rust 的目标不是让 unsafe 变得不可能，而是把"程序员会用 unsafe"这件事压缩到一个非常局部的、可审计的边界里。

### 一个意外出现的 LLM 支线

议题本来和 AI 没关系，但 wg0 顺手做了一件小事 ——

> "DeepSeek v4.1 Flash thinks it should NOT compile. Whereas in reality it DOES compile which is why it is filed as a bug." — wg0 [c:50069924]

> （翻译：我让 DeepSeek v4.1 Flash 看了看，它认为这段代码不应该编译 —— 但实际上它能编译，所以这才是 bug。）

ChickeNES 紧接着吐槽了一句 ——

> "chatgpt and grok linked to the the soundness issue, claude I am in usage timeout, and gemini shit the bed as usual: \"The compiler rejects the program with error[E0597] on the assignment q.0 = Some(&l)\"" — ChickeNES [c:50070387]

> （翻译：ChatGPT 和 Grok 直接链接到了这个 unsoundness issue，Claude 我这边调用超时，Gemini 像往常一样翻车：它说"编译器会用 E0597 报错拒绝这段代码"。）

LLM 集体翻车这件事意外地提供了一个反向证据：所有主流模型都"学过" Rust 不允许把非 `'static` 引用塞进 `'static` 字段，所以它们才会一致地说"应该报错"。模型学到的恰恰是 Rust 设计上的意图，而不是 Rust 当前的实现 —— 这是个挺讽刺但也说明问题的细节。

## 典型观点一览

| 立场 | 用户 | 一句话 |
| --- | --- | --- |
| 维护者视角 | afdbcreid | 这是 borrow checker 的实现 bug，不是类型系统的"原理性"漏洞，最终目标是把整套系统形式化 |
| 强辩护 | cscheid | 11 年才被发现恰恰证明 Rust 是有效的，SML 当年同样问题也是图灵奖级人物"yolo" 出来的 |
| 哲学攻击 | csande17 | Rust 没有 spec，所谓"soundness"只是编译器此刻在做什么，所以"Rust 本身不能失败，只能被失败" |
| 实操辩护 | vlovich123 | 即便编译器有 bug，Rust 在内存安全上仍然明显胜过 C++，这是经验事实 |
| 温和反对 | mcherm | 承认没完整 spec，但社区对类型系统"应该"做什么是有共识的，这不是空概念 |
| 反讽阵营 | bcjdjsndon | Rust 的核心矛盾：程序员既不被信任写内存安全代码，又被信任写"安全"的 unsafe Rust |
| 文化旁观 | meltyness / afdbcreid | 已有 verify-rust-std 这样的项目，验证工作在推进，但范围仅限于 std |
| LLM 旁注 | wg0 / ChickeNES | 把代码喂给主流 LLM，它们一致认为不该编译 —— 反而印证了 Rust 的设计意图 |

## 总体情绪

讨论从"这 bug 怎么藏了 11 年"出发，很快分裂成两条主线。一条是技术线：borrowing checker 的实现细节、`'static` 约束的语义、`Drop` 调用顺序，结论大多是"这是实现 bug、不是设计缺陷、修掉就行"。另一条是哲学线：没有形式化 spec 的语言能叫"安全语言"吗？这个 bug 是类型系统的失败还是 Rust 营销叙事的失败？

分歧最大的是"yolo" 这个词：批评者说"放出来没证明就等于 yolo"，辩护者说"SML 那个年代连 yolo 这个词都没有，问题照样推进去"。到收尾阶段，两边逐渐让步 —— 维护者承认长期目标是验证整个系统，批评者承认已经验证的部分是有意义的。两边都没赢，也都没输，因为这个 bug 既证明了 Rust 不是完美的，也证明了 11 年才被人撞见这件事本身就是一种设计成功。

整个讨论最值得记住的一句话反而来自 bcjdjsndon 的反讽：把同一个程序员先否定、再肯定，恰恰是 Rust 这个生态之所以存在的理由。救火的人会被奖励，写类型系统的人可以被遗忘 11 年 —— 但只要最后有人记得去找，那张网就能接住它。

## 引用帖子

| # | 标题 | URL |
| --- | --- | --- |
| 1 | struct's lifetime requirements can be bypassed via covariant field assignment · Issue #164250 · rust-lang/rust | <https://github.com/rust-lang/rust/issues/164250> |
| 2 | 11 year old unsoundness bugs found in Rust borrow checker（Hacker News 讨论） | <https://news.ycombinator.com/item?id=50069499> |
| 3 | SML history（被 cscheid 引用，含协变与可变性那一段） | <https://smlfamily.github.io/history/SML-history.pdf> |
| 4 | RustBelt（thayne 引用的部分形式化验证工作） | <https://plv.mpi-sws.org/rustbelt/popl18/> |
| 5 | verify-rust-std（meltyness 提到的 std 形式化验证项目） | <https://github.com/model-checking/verify-rust-std> |

<div class="disclaimer">

本文为 HN 热门讨论的中文摘要，原始链接与作者归属均已标注。摘要中引用的代码片段仅用于技术说明。如有事实性错误，欢迎在留言区指出。

<br><br><em>本摘要由 AI 模型辅助生成：minimax-cn-coding-plan/MiniMax-M3</em>

</div>