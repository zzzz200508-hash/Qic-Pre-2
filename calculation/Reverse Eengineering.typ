#import "/utils/_lib.typ": *
#show ref: theoretic.show-ref

=== 线路演化的三阶段解耦

#def("物理演化算法")[
  构建该六量子比特系统（Alice 端的 $A_1, A_2, A_3$ 与 Bob 端的 $B_1, B_2, B_3$）的完整酉演化过程 $U_"total"$，需在逻辑上严格解耦为三个递进阶段：

  + *第一阶段：初始最大纠缠信道分配 (Bell Pairs)*
    对系统初始态 $ket(0)^(times.o 6)$ 的三个 A 端比特施加 Hadamard 门，并通过三个跨系统的 CNOT 门，生成三对无偏的贝尔态：（也就是两个人的初始信道分配就是三个EPR对）
    $
      ket(Psi_0) = (product_(i=1)^3 "CNOT"_(A_i, B_i) H_(A_i)) ket(0)^(times.o 6) = 1/(2 sqrt(2)) sum_(K=0)^7 ket(K, sub: A) times.o ket(K, sub: B)
    $

  + *第二阶段：Alice 端的局域参数化调制 ($U_A$)*
    在纠缠分发后，以 $A_1, A_2$ 为控制寄存器，对 $A_3$ 施加带有参数 $theta_i$ 的多级受控旋转，并针对特定基矢注入符号修正：$U_A = U_("phase")^A dot U_("rot")^A$。

  + *第三阶段：Bob 端的局域参数化调制 ($U_B$)*
    同理，以 $B_1, B_2$ 为控制寄存器，基于目标态参数 $theta'_i$ 对 $B_3$ 施加调制：$U_B = U_("phase")^B dot U_("rot")^B$。
]

=== 核心调制算符的数学解析

在第二阶段中，Alice 端的量子线路必须包含多级受控旋转门与条件相位门，这是保证其约化密度矩阵呈现预期混合态性质的核心。

#thm("局域调制算符 $U_A$ 的解析表达与基底符号修正")[
  为精确映射到论文所定义的正交基底 $ket(arrow(K))^(3)$，Alice 端的旋转算符 $U_"rot"^A$ 必须是一个基于组合状态展开的受控门阵列：
  $
    U_"rot"^A & = ketbra(00, 00, sub: A_1 A_2) times.o R_y (2theta_1)_(A_3) \
              & + ketbra(01, 01, sub: A_1 A_2) times.o R_y (2theta_2)_(A_3) \
              & + ketbra(10, 10, sub: A_1 A_2) times.o R_y (2theta_3)_(A_3) \
              & + ketbra(11, 11, sub: A_1 A_2) times.o R_y (2theta_4)_(A_3)
  $

  符号修正：对于 $K=3$ 的展开态：
  $
    ket(arrow(3))_A^(3) = ket(01) times.o (sin theta_2 ket(0) - cos theta_2 ket(1)) = - ket(01) times.o R_y(2theta_2)ket(1)
  $
  与之对比，Bob 端的 $ket(arrow(3)')_B^(3) = + ket(01) times.o R_y(2theta'_2)ket(1)$。
  为了消除这唯一的一处非对称负号，保证总初态 $ket(psi, sub: A B)$ 中所有项的叠加相位合法，必须在 Alice 端施加一个针对 $ket(011)$ 态的局部对角相位翻转算符：
  $ U_("phase")^A = I^(times.o 3) - 2 ketbra(011, 011, sub: A_1 A_2 A_3) $
]

#pf[
  将总酉操作 $U_"total" = U_A times.o U_B$ 作用于初始贝尔对系统 $ket(Psi_0)$：
  $
    U_"total" ket(Psi_0) &= 1/(2 sqrt(2)) sum_(K=0)^7 (U_A ket(K, sub: A)) times.o (U_B ket(K, sub: B)) \
    &= 1/(2 sqrt(2)) sum_(K=0)^7 ket(arrow(K), sub: A) times.o ket(arrow(K)', sub: B) = ket(psi, sub: A B)^(3,3)
  $
  由此证毕。正确的物理合成路径必须依赖于内部的局域受控门逻辑。
]

#figure(
  image("../code/Corrected_Fig2_3_qubit.pdf", width: 90%),
  caption: [三量子比特 Alice 端局域参数调制线路$U_A$],
) <fig_corrected_3q>

#figure(
  image("../code/Corrected_Fig1_n_qubit.pdf", width: 90%),
  caption: [$n$ 量子比特 Alice 端的普遍物理演化架构。前 $n-1$ 个量子比特严格作为控制寄存器，唯一目标比特 $A_n$ 接受条件化的 $R_y$ 旋转与相位翻转。],
) <fig_corrected_nq>

=== $n$ 量子比特物理线路拓扑
在真实的量子物理硬件中，Alice 端的 $n$ 量子比特准确物理演化逻辑应遵循如下操作流：
+ *控制寄存器初始化*：仅在前 $n-1$ 个物理量子比特上施加 $H^times.o(n-1)$ 门，制备 $2^{n-1}$ 维计算基底的均匀叠加。
+ *多级受控旋转*：将第 $n$ 个量子比特作为唯一的局域目标位，前 $n-1$ 个比特作为控制位。这是一个由 $2^{n-1}$ 个条件分支组成的庞大受控门阵列。当且仅当控制寄存器处于特定基态 $ket(K)$ 时，在第 $n$ 个比特上触发对应的 $R_y(2theta_(K+1))$ 旋转。
+ *多级受控相位修正 (Multiplexed Phase Corrections)*：与三比特情形的 $C^2 Z$ 类似，根据基矢公式中特定的负号展开项，施加多比特受控的相位翻转门 $C^(n-1)Z$，以修正局部相位。
+ *信道纠缠分发*：最后，通过 $n$ 对并行的跨系统 CNOT 门，将 Alice 端的 $n$ 个比特状态一一映射给 Bob 端的 $n$ 个比特，完成 $2n$ 纠缠信道的搭建。
