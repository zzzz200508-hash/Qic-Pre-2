
#let bra(x, sub: none) = $""_#sub chevron.l #x |$
#let ket(x, sub: none) = $| #x chevron.r_#sub$
#let braket(x, y) = $chevron.l #x | #y chevron.r$
#let ketbra(x, y, sub: none) = {
  if sub == none {
    $ket(#x) bra(#y)$
  } else {
    $ket(#x)_(#sub) bra(#y)$
  }
}

#let Rank(x) = $"rank"(#x)$

#let boxed(x) = align(center, box(stroke: black + .5pt, inset: 10pt)[#x])
