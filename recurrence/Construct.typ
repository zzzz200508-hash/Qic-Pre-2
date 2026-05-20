#import "/utils/_lib.typ": *
#show ref: theoretic.show-ref

=== 目标
构建泛用的三量子比特完备正交基，并证明基于该完备正交基构造的六量子比特纠缠态可用于完美传输未知的三个量子比特。

#def("广义参数化三量子比特基底的构造")[
  通过在两量子比特完备正交计算基底 $ket(00), ket(01), ket(10), ket(11)$ 上引入局域幺正旋转算符，可将基矢空间通过张量积扩展至三量子比特空间。定义一组参数化的基矢集合如下：

  $
    ket(arrow(0))^(3) & = ket(00) times.o (cos theta_1 ket(0) + sin theta_1 ket(1)) \
    ket(arrow(1))^(3) & = ket(00) times.o (-sin theta_1 ket(0) + cos theta_1 ket(1)) \
    ket(arrow(2))^(3) & = ket(01) times.o (cos theta_2 ket(0) + sin theta_2 ket(1)) \
    ket(arrow(3))^(3) & = ket(01) times.o (sin theta_2 ket(0) - cos theta_2 ket(1)) \
    ket(arrow(4))^(3) & = ket(10) times.o (cos theta_3 ket(0) + sin theta_3 ket(1)) \
    ket(arrow(5))^(3) & = ket(10) times.o (-sin theta_3 ket(0) + cos theta_3 ket(1)) \
    ket(arrow(6))^(3) & = ket(11) times.o (cos theta_4 ket(0) + sin theta_4 ket(1)) \
    ket(arrow(7))^(3) & = ket(11) times.o (-sin theta_4 ket(0) + cos theta_4 ket(1))
  $

  其中，控制角参数满足严格的数学约束：$0 <= theta_i <= pi/2 quad (i = 1, 2, 3, 4)$。
]

#thm("广义团簇类基底的完备性与隐形传态")[
  由上述定义的矢量集合 ${ket(arrow(K))^(3)}_(K=0)^7$ 在三量子比特希尔伯特空间中构成一组完备正交基。此外，以该基底构造的复合纠缠态 $ket(psi, sub: A B)^(3,3)$ 作为共享资源时，可实现对任意未知三量子比特纯态 $ket(phi, sub: A')^(3)$ 的完美量子隐形传态（传态保真度为 1）。
]

#pf[
  *1. 完备正交性证明*

  约定将构成的这组基矢量统一标记为 $ket(arrow(K))^(3)$。当所有的参数 $theta_i = 0$ 时，该结构自然退化为标准的三量子比特计算基底。通过内积计算，可以轻易验证其满足正交归一条件：
  $ ""^(3) bra(arrow(K)) ket(arrow(K'))^(3) = delta_(K,K') $
  $ sum_(K=0)^7 ket(arrow(K'))^(3) bra(arrow(K))^(3) = I^(3) $
  由此证明，所构造的矢量集合确实构成了一组完备正交基。

  *2. 完美隐形传态证明*

  Alice与Bob共享的纠缠态可用该基矢量描述为：
  $ ket(psi, sub: A B)^(3,3) = 1/(2 sqrt(2)) sum_(K=0)^7 ket(arrow(K), sub: A)^(3) times.o ket(arrow(K)', sub: B)^(3) $
  显然，该态构成系统 A 与 B 之间的最大纠缠态。

  待传输的未知态 $a$ 可直接用 B 端的基底展开表示：
  $ ket(phi, sub: a)^(3) = sum_(K=0)^7 a_K ket(arrow(K)', sub: a)^(3) quad (sum_(K=0)^7 |a_K|^2 = 1) $

  对于 Alice 最初拥有的待传输未知态系统 $A'$ 与纠缠子系统 $A$，构造如下联合测量基底：
  $
    ket(Pi_(000), sub: A' A)^(3,3) = 1/(2 sqrt(2)) sum_(K=0)^7 ket(arrow(K)', sub: A')^(3) times.o ket(arrow(K), sub: A)^(3)
  $

  联合测量后系统发生扰动坍缩，对应的基矢态视为 $ket(Pi_(i j k))$，其映射的测量结果即为经典比特 $(i,j,k)$：
  $
    ket(Pi_(i j k), sub: A' A)^(3,3) = (sigma^{(i)} times.o sigma^{(j)} times.o sigma^{(k)})_(A') ket(Pi_(000), sub: A' A)^(3,3)
  $

  在量子隐形传态过程中，系统的联合演化方程内积可展开推导。为简化符号体系，采用 $K, L, M, J$ 等大写字母标识测量基矢量的数字索引，且省略一维基矢量的上标（即 $ket(0)^(1) equiv ket(0)$）。基于此，三量子比特未知态可降维展开为：
  $ ket(phi)^(3) = sum_(K=0)^3 sum_(M=0)^1 a_(K plus.o M) ket(K)^(2) times.o ket(M) $

  回顾两量子比特隐形传态框架下的基本结论：
  $
    ket(phi, sub: A')^(2) &= sum_(J=0)^3 a_J ket(J', sub: A') \
    ket(overline(Pi)^(00), sub: A' A)^(2) &= 1/2 sum_(K=0)^3 ket(K', sub: A') times.o ket(K, sub: A) \
    ket(overline(Pi)^(i j), sub: A' A)^(2) &= [(sigma^i_(A'_1) times.o sigma^j_(A'_2)) times.o I_A] ket(overline(Pi)^(00), sub: A' A)
  $
  且必然满足如下推论：
  $
    ""^(2) bra(overline(Pi)^(i j), sub: A' A) (ket(phi, sub: A')^(2) times.o ket(overline(psi)^(00), sub: A B)^(2)) \
    &= ""^(2) bra(overline(Pi)^(00), sub: A' A) (sigma^i_(A'_1) times.o sigma^j_(A'_2)) ket(phi, sub: A')^(2) times.o ket(overline(psi)^(00), sub: A B)^(2) \
    &= 1/4 (sigma^i_(B_1) times.o sigma^j_(B_2)) ket(phi, sub: B)^(2)
  $

  为证明三量子比特情形下的普遍成立性，仅需将其展开为两量子比特与一量子比特张量积的线性组合形式：
  $
    ""^(3) bra(overline(Pi)^(i j k), sub: A' A) ket(phi, sub: A')^(3) \
    &= 1/(2 sqrt(2)) sum_(K=0)^7 sum_(J=0)^7 a_K bra(K, sub: A)^(3) times.o [bra(K', sub: A')^(3) (sigma^i_(B_1) times.o sigma^j_(B_2) times.o sigma^k_(B_3)) ket(J', sub: A')^(3)] \
    &= 1/(2 sqrt(2)) sum_(K=0)^7 sum_(M,N=0)^3 sum_(L,O=0)^1 a_K bra(K, sub: A)^(3) times.o [bra(M', sub: A')^(2) (sigma^i_(B_1) times.o sigma^j_(B_2)) ket(N', sub: A')^(2) bra(L', sub: A') sigma^k_(B_3) ket(O', sub: A')] \
    &= 1/(2 sqrt(2)) sum_(K=0)^7 a_K (sigma^i_(B_1) times.o sigma^j_(B_2) times.o sigma^k_(B_3)) bra(K, sub: A)^(3)
  $

  将此部分推导结果代入系统总态，可得：
  $
    bra(overline(Pi)^(i j k), sub: A' A) (ket(phi, sub: A')^(3) times.o ket(overline(psi)^(000), sub: A B)^(3)) \
    &= 1/(2 sqrt(2)) sum_(K=0)^7 a_K (sigma^i_(B_1) times.o sigma^j_(B_2) times.o sigma^k_(B_3)) bra(K, sub: A)^(3) ket(overline(psi)^(000), sub: A B)^(3) \
    &= 1/8 (sigma^i_(B_1) times.o sigma^j_(B_2) times.o sigma^k_(B_3)) ket(phi, sub: B)^(3)
  $

  最终，上述证明证实初始总态可严格表达为：
  #boxed[$
    ket(phi, sub: A')^(3) times.o ket(overline(psi)^(000), sub: A B)^(3) \
    &= sum_(i,j,k) ket(overline(Pi)^(i j k), sub: A' A)^(3) ""^(3) bra(overline(Pi)^(i j k), sub: A' A) (ket(phi, sub: A')^(3) times.o ket(overline(psi)^(000), sub: A B)^(3)) \
    &= 1/8 sum_(i,j,k) ket(overline(Pi)^(i j k), sub: A' A)^(3) times.o (sigma^i_(B_1) times.o sigma^j_(B_2) times.o sigma^k_(B_3)) ket(phi, sub: B)^(3)
  $]
]
