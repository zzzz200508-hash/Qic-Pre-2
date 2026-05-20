#import "/utils/_lib.typ": *
#show ref: theoretic.show-ref

=== 可行性与正交完备性证明

证明超密集编码可行性的核心，在于证明 Alice 编码后的 $2^(2n)$ 个复合量子态在全空间中满足严格的正交归一性，从而允许 Bob 通过一次联合投影测量将其百分之百不模糊地分辨出来。

#thm("超密集编码基底的正交完备性定理")[
  若初始信道 #ket("xi", sub: "A B")^((n,n)) 是由广义参数化基底构造的最大纠缠态，则通过局域泡利算符群生成的复合态集合：
  $
    { ket(Psi_(i_1 i_2 ... i_n)) = (sigma^((i_1)) times.o dots times.o sigma^((i_n)))_A ket("xi", sub: "A B")^((n,n)) }
  $
  在 $2^(2n)$ 维希尔伯特空间中构成一组完备正交基。
]

#pf[
  首先，由于初始共享态 #ket("xi", sub: "A B")^((n,n)) 本身是在系统 A 和 B 之间标准的最大纠缠态：
  $
    ket("xi", sub: "A B")^((n,n)) = 1/sqrt(2^n) sum_(K=0)^(2^n-1) ket(arrow(K), sub: "A")^((n)) times.o ket(arrow(K)', sub: "B")^((n))
  $

  当 Alice 施加局域泡利编码算符 $U_A = sigma^((i_1)) times.o dots times.o sigma^((i_n))$ 时，复合态演化为：
  $
    ket(Psi_(i_1 ... i_n)) = 1/sqrt(2^n) sum_(K=0)^(2^n-1) (sigma^((i_1)) times.o dots times.o sigma^((i_n))) ket(arrow(K), sub: "A")^((n)) times.o ket(arrow(K)', sub: "B")^((n))
  $

  利用泡利矩阵在迹上的正交性 $ "Tr"(sigma^((alpha)) sigma^((beta))) = 2 delta_(alpha, beta) $ 以及最大纠缠态的特殊代数性质，我们可以直接计算任意两组不同编码之间的内积：
  $ braket(Psi_(j_1 ... j_n), Psi_(i_1 ... i_n)) = delta_(i_1, j_1) delta_(i_2, j_2) dots delta_(i_n, j_n) $

  这表明，Alice 的局域操作成功将经典比特信息 $(i_1, ..., i_n)$ 完美同构地编码到了整个复合系统的全局量子相位与不变量拓扑中。因为这 $2^(2n)$ 个状态严格两两正交，Bob 在解码时，其联合测量（对应投影算符 $Pi_(j_1 ... j_n) = ketbra(Psi_(j_1 ... j_n), Psi_(j_1 ... j_n))$）坍缩到目标基矢的概率为：
  $ | braket(Psi_(j_1 ... j_n), Psi_(i_1 ... i_n)) |^2 = delta_({i_k}, {j_k}) $

  由此得证，Bob 能够以 $100\%$ 的成功率准确拦截并解析出全部 $2n$ 位经典普通比特，实现了超越经典通信容量极限的超密集编码。
]
