#set page(paper: "a4", numbering: "1")
#set text(font: ("Canela Text Regular Trial", "SimSun"))
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

= 论文复现与补充
// 论文复现部分
#include "recurrence/cqc.typ"

#pagebreak()
// 论文补充
== 论文未提及证明补充

#include "supplement/cqc.typ"
= 一些计算（不知道叫啥）
#include "calculation/yzh.typ"
= 一些不同的态辨析（后面再改）
#include "different states/mhr.typ"

= 结论

#lorem(100)

#bibliography("ref/refs.bib", style: "ieee")
