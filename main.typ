#import "/utils/_lib.typ": *

#set page(paper: "a4", numbering: "1")
#set text(font: ("Canela Text Regular Trial", "Source Han Serif SC"))
#set heading(numbering: "1.1")

//#let title = "从等概率到完美隐形传态"
#let title = "从特殊纠缠三量子比特到 n 量子比特"
#let subtitle = "递归构造、通信协议与电路级逆向仿真验证"
#let author = "颜子涵(组长), 张智铭, 曹秦畅, 马豪嵘"
#let authors = ("颜子涵(组长)", "张智铭", "曹秦畅", "马豪嵘")

#align(center)[
  #block(text(weight: "bold", size: 3em)[#title])
  #v(1em)
  #block(text(size: 1.5em, fill: luma(100))[#subtitle])
  #v(2em)
  #align(center)[#authors.join(h(2em))]
  #v(1em)
  #block(datetime.today().display("[year]年[month]月[day]日"))
  #v(4em)
]

#outline()
#pagebreak()
= 摘要
本文研究了一类连续参数化的 3 量子比特多体最大纠缠态，进而将其推广到 n 量子比特情形。本文涵盖理论构造、协议实现、线路设计与数值仿真。构建了 $n$ 量子比特广义完备正交基。以此纠缠态为共享信道，可确定性地完美隐形传态任意未知 $n$ 量子比特纯态，并实现成功率 100% 的超密集编码。同时设计了包含多级受控旋转与多比特受控相位修正门的物理线路实现该纠缠态，并利用 SymPy 验证了系统的全空间满秩非平凡纠缠特性。基于 Python 开发的交互式可视化仿真程序，在数值层面证实了协议对任意状态调制与局域扰动的普适性与鲁棒性。最后，通过与 EPR 对、GHZ 态、W 态及簇态的系统对比，揭示了该参数化状态在抗局域噪声、灵活调控与容错纠错方面的独特优势。

*关键词*：最大纠缠态；量子隐形传态；密集编码；逆向工程；多级受控门；交互式仿真

= 理论推导与数学核心 (Theoretical Derivation)
== 论文思路概要
- 定义文章符号：纠缠态为：$ket(psi)$ ，任意未知纯态为：$ket(phi)$
- 背景介绍：以传输一个量子比特为目的：EPR 对，三量子比特GHZ态， W态可完美传输一量子比特。
  以传输两个量子比特为目的：两贝尔态的张量积、真正的四量子比特态、某不知名五量子比特纠缠
  以传输三量子比特为目的：一个真正的六量子纠缠态、
- n 量子比特：2n 量子比特纠缠传输通道必须满足传递 n 量子比特的要求。
- 目标：提出来一种用于n量子比特完美传输的2n量子比特纠缠态。

== 3 Qubit基的构造
#include "recurrence/Construct.typ"

== 从 3 Qubit到 n Qubit的推广
#include "recurrence/Promotion.typ"

== 纠缠性质与等价性证明
#include "recurrence/Entanglement&Equivalence.typ"

#pagebreak()

= 算法验证与仿真构造 (Algorithm & Simulation)
== 量子门线路的逆向工程
#include "calculation/Reverse Eengineering.typ"
== 算例支持与代码验证
#include "calculation/Verification.typ"
== 密集编码的协议实现
#include "calculation/Dense Coding.typ"

#pagebreak()

= EPR对、GHZ态、W态、四量子比特纠缠态、簇态及2n-qubit态的对比研究
#include "different states/mhr.typ"

= 结论
本文成功完成了广义参数化 $2n$ 量子比特最大纠缠态从数学推导、协议设计、线路映射到数值仿真的完整闭环验证，主要结论如下：

1. 通过向低维基底递归引入局域幺正旋转，构建了广义完备正交基。SymPy 代数计算证实该状态在全空间满足满秩纠缠。以此为共享信道，不仅能以 1.0000 的保真度确定性传态任意未知纯态，还能实现成功率 100% 的 $2n$ 位经典信息超密集编码。
2. 利用逆向工程将系统酉演化严格解耦为信道分配、Alice 端局域调制与 Bob 端局域调制三阶段。设计了包含多级受控旋转门的普遍线路拓扑，并通过多比特受控相位翻转门消除了非对称负号，确保了叠加相位的合法性。
3. 基于 Python 开发的交互式仿真程序在 512 维复合空间中精确重现了传态全过程。数值结果证实，系统恢复保真度始终等于 $1$，有力验证了协议的极强鲁棒性。
4. 横向研究表明，相比退相干环境下具有“全有或全无”脆弱性的 GHZ 态及易被破坏的 EPR 对，该态族引入的连续可调角度参数赋予了其极高的噪声调控灵活性与容错纠错空间。

#bibliography("ref/refs.bib", style: "ieee")
