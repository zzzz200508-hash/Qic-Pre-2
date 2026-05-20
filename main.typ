#import "/utils/_lib.typ": *

#set page(paper: "a4", numbering: "1")
#set text(font: ("Canela Text Regular Trial", "Source Han Serif SC"))
#set heading(numbering: "1.1")

//#let title = "从等概率到完美隐形传态"
#let title = "？"
#let subtitle = "？"
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
#lorem(100)

*关键词*：最大纠缠态；量子隐形传态；冯·诺依曼熵；SLOCC；施密特分解；过滤算符

= 理论推导与数学核心 (Theoretical Derivation)
== 论文思路概要
- 定义文章符号：纠缠态为：$bra(psi)$ ，任意未知纯态为：$bra(phi)$
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

= 综述对比 (Synthesis)
#include "different states/mhr.typ"

= 结论

#lorem(100)

#bibliography("ref/refs.bib", style: "ieee")
