#import "/utils/_lib.typ": *
#show ref: theoretic.show-ref

我们编写了程序，基于 SymPy 精确计算，得到如下密度矩阵的结果：
$
  C = sqrt(2)/4 mat(
    c_1 c_2 c_3, c_1 c_2 s_3, c_1 s_2 c_3, c_1 s_2 s_3, s_1 c_2 c_3, s_1 c_2 s_3, s_1 s_2 c_3, s_1 s_2 s_3;
    -c_1 c_2 s_3, c_1 c_2 c_3, -c_1 s_2 s_3, c_1 s_2 c_3, -s_1 c_2 s_3, s_1 c_2 c_3, -s_1 s_2 s_3, s_1 s_2 c_3;
    -c_1 s_2 c_3, -c_1 s_2 s_3, c_1 c_2 c_3, c_1 c_2 s_3, -s_1 s_2 c_3, -s_1 s_2 s_3, s_1 c_2 c_3, s_1 c_2 s_3;
    c_1 s_2 s_3, -c_1 s_2 c_3, -c_1 c_2 s_3, c_1 c_2 c_3, s_1 s_2 s_3, -s_1 s_2 c_3, -s_1 c_2 s_3, s_1 c_2 c_3;
    -s_1 c_2 c_3, -s_1 c_2 s_3, -s_1 s_2 c_3, -s_1 s_2 s_3, c_1 c_2 c_3, c_1 c_2 s_3, c_1 s_2 c_3, c_1 s_2 s_3;
    s_1 c_2 s_3, -s_1 c_2 c_3, s_1 s_2 s_3, -s_1 s_2 c_3, -c_1 c_2 s_3, c_1 c_2 c_3, -c_1 s_2 s_3, c_1 s_2 c_3;
    s_1 s_2 c_3, s_1 s_2 s_3, -s_1 c_2 c_3, -s_1 c_2 s_3, -c_1 s_2 c_3, -s_1 s_2 s_3, c_1 c_2 c_3, c_1 c_2 s_3;
    -s_1 s_2 s_3, s_1 s_2 c_3, s_1 c_2 s_3, -s_1 c_2 c_3, c_1 s_2 s_3, -c_1 s_2 c_3, -c_1 c_2 s_3, c_1 c_2 c_3;
  )
$
其中简记符号为：
- $c_1 = cos(alpha_1 - beta_1)$，$s_1 = sin(alpha_1 - beta_1)$
- $c_2 = cos(alpha_2 - beta_2)$，$s_2 = sin(alpha_2 - beta_2)$
- $c_3 = cos(alpha_3 - beta_3)$，$s_3 = sin(alpha_3 - beta_3)$


经过严格计算：
$ C C^dagger = frac(1, 8) I_8 $

#boxed([
  Schmidt 系数与纠缠熵结果：
  由于 $rho_A = frac(1, 8) I_8$，其 $8$ 个特征值均为 $lambda_i = frac(1, 8)$。这意味着：
  Schmidt 秩：$Rank(C) = 8$，系统处于全空间满秩纠缠。
  由此证明，无论 Alice 和 Bob 的局域调控参数 $alpha_i, beta_i$ 取何值，该状态始终是一个严格的 3-qubit 最大纠缠态。
])

由此，我们也可以证明如该三量子比特纠缠态并非三个贝尔态的简单张量积。
#thm("共享资源态的非平凡纠缠特性")[
  由广义参数化基底构造的三量子比特纠缠态 $ket(psi, sub: A B)^(3,3)$ 并非三个贝尔态（Bell states）的简单张量积。
]
#pf[
  通过计算可知，在一般参数 $theta_i$ 下，其密度矩阵的秩不为 1，即它不再是一个纯态。由于贝尔态的张量积 $times.o_(i=1)^3 1/sqrt(2) (ket(00) + ket(11))_(A_i B_i)$ 在求偏迹后必然仍为纯态，因此所构造的 $ket(psi, sub: A B)^(3,3)$ 严格不等价于贝尔态的张量积。此外，当参数取特定值时，该态可自然转化为六量子比特簇态。
]
