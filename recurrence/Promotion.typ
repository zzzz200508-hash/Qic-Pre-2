#import "/utils/_lib.typ": *
#show ref: theoretic.show-ref

== 3qubit到nqubit的推广

=== 递归构造与广义形式

#def("n量子比特广义完备正交基的递归构造")[
  假设 $n-1$ 量子比特的完备正交基 $ket(arrow(K))^(n-1)$ 已经构建完成，其中 $K in {0, 1, ..., 2^(n-1)-1}$。通过向第 $n$ 个量子比特引入局域幺正旋转（控制角为 $theta_i$），我们可以递归地将基底张量积扩展出 $n$ 量子比特的正交基底。

  对于任意索引 $K$，定义其向 $n$ 维空间的映射法则如下：
  $
      ket(arrow(2K))^(n) & = ket(arrow(K))^(n-1) times.o (cos theta_(K+1) ket(0) + sin theta_(K+1) ket(1)) \
    ket(arrow(2K+1))^(n) & = ket(arrow(K))^(n-1) times.o (-sin theta_(K+1) ket(0) + cos theta_(K+1) ket(1))
  $
  同理，目标接收端的基底 $ket(arrow(K)')^(n)$ 亦可通过带有参数 $theta'_(K+1)$ 的相同法则构造。
]

#thm("n量子比特隐形传态定理")[
  基于上述递归法则构造的 $2^n$ 个矢量 ${ket(arrow(K))^(n)}$ 构成 $n$ 量子比特空间的完备正交基。若 Alice 与 Bob 共享 $2n$ 量子比特最大纠缠态 $ket(psi, sub: A B)^(n,n)$，则存在一种基于局域测量与经典通信（LOCC）的确定性操作，使得任意未知的 $n$ 量子比特态 $ket(phi, sub: A')^(n)$ 能够被完美传输至 Bob 端。
]

#pf[
  *1. 归纳假设与系统初始化*

  已知当 $n=2, 3$ 时，该基底构造法则及传态方案成立。现假设对于 $n-1$ 个量子比特，完备性与完美传态依然成立。我们将在此基础上证明其对 $n$ 量子比特同样适用。

  系统初始共享的 $2n$ 量子比特最大纠缠态为：
  $
    ket(psi, sub: A B)^(n,n) = 1/sqrt(2^n) sum_(K=0)^(2^n-1) ket(arrow(K), sub: A)^(n) times.o ket(arrow(K)', sub: B)^(n)
  $

  未知态系统 $A'$ 与纠缠子系统 $A$ 的联合测量基底，以及加入测量扰动后的坍缩态分别定义为：
  $
    ket(Pi_(00...0), sub: A' A)^(n,n) &= 1/sqrt(2^n) sum_(K=0)^(2^n-1) ket(arrow(K)', sub: A')^(n) times.o ket(arrow(K), sub: A)^(n) \
    ket(Pi_(i_1 ... i_n), sub: A' A)^(n,n) &= (sigma^{(i_1)} times.o ... times.o sigma^{(i_n)})_(A') ket(Pi_(00...0), sub: A' A)^(n,n)
  $

  *2. 归纳步进推导*

  待传输的 $n$ 维未知态可展开为 $ket(phi, sub: A')^(n) = sum_(J=0)^(2^n-1) a_J ket(J', sub: A')^(n)$。在推演中，我们将 $n$ 维空间拆解为 $(n-1)$ 维与 $1$ 维的张量积空间，即索引关系满足分解。

  计算 Alice 投影测量操作导致的系统联合演化内积：
  $
    ""^(n) bra(overline(Pi)^(i_1...i_n), sub: A' A) ket(phi, sub: A')^(n)
    &= 1/sqrt(2^n) sum_(K=0)^(2^n-1) sum_(J=0)^(2^n-1) a_K bra(K, sub: A)^(n) times.o [bra(K', sub: A')^(n) (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_n)_(B_n)) ket(J', sub: A')^(n)] \
    &= 1/sqrt(2^n) sum_(K=0)^(2^n-1) sum_(M,N=0)^(2^(n-1)-1) sum_(L,O=0)^1 a_K bra(K, sub: A)^(n) times.o \
    & quad [bra(M', sub: A')^(n-1) (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_(n-1))_(B_(n-1))) ket(N', sub: A')^(n-1) bra(L', sub: A') sigma^(i_n)_(B_n) ket(O', sub: A')]
  $

  利用归纳假设中 $n-1$ 维系统算符的对易与正交性关系，上式可大幅化简为：
  $
    ""^(n) bra(overline(Pi)^(i_1...i_n), sub: A' A) ket(phi, sub: A')^(n) = 1/sqrt(2^n) sum_(K=0)^(2^n-1) a_K (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_n)_(B_n)) bra(K, sub: A)^(n)
  $

  将此推导结果代入包含接收端 Bob 系统 $B$ 的完整闭合态：
  $
    bra(overline(Pi)^(i_1...i_n), sub: A' A) (ket(phi, sub: A')^(n) times.o ket(overline(psi)^(00...0), sub: A B)^(n))
    &= 1/sqrt(2^n) sum_(K=0)^(2^n-1) a_K (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_n)_(B_n)) bra(K, sub: A)^(n) ket(overline(psi)^(00...0), sub: A B)^(n) \
    &= 1/2^n (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_n)_(B_n)) ket(phi, sub: B)^(n)
  $

  *3. 结论*

  由此得证，当 Alice 得到测量结果 $(i_1, ..., i_n)$ 后，系统整体坍缩状态严格演化为：
  #boxed[$
    ket(phi, sub: A')^(n) times.o ket(overline(psi)^(00...0), sub: A B)^(n) = 1/2^n sum_(i_1...i_n) ket(overline(Pi)^(i_1...i_n), sub: A' A)^(n) times.o (sigma^(i_1)_(B_1) times.o ... times.o sigma^(i_n)_(B_n)) ket(phi, sub: B)^(n)
  $]

  Bob 仅需根据经典信道接收到的 $n$ 比特测量结果，对其手中的粒子施加对应的联合泡利操作 $(sigma^{(i_1)} times.o ... times.o sigma^{(i_n)})^(-1)$，即可完美恢复出未知的 $n$ 量子比特纯态，归纳证明完毕。
]
