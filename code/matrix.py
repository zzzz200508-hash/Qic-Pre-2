from sympy import symbols, cos, sin, sqrt, Matrix, simplify
import sympy as sp

a1,a2,a3,b1,b2,b3 = symbols(r'\alpha_1 \alpha_2 \alpha_3 \beta_1 \beta_2 \beta_3', real=True)

def build_basis_sym(th1, th2, th3):
    c1,s1 = cos(th1), sin(th1)
    c2,s2 = cos(th2), sin(th2)
    c3,s3 = cos(th3), sin(th3)

    # Level 1
    v0_1 = Matrix([c1, s1])
    v1_1 = Matrix([-s1, c1])

    # Level 2
    v0_2 = sp.kronecker_product(v0_1, Matrix([cos(th2), sin(th2)]))
    v1_2 = sp.kronecker_product(v0_1, Matrix([-sin(th2), cos(th2)]))
    v2_2 = sp.kronecker_product(v1_1, Matrix([cos(th2), sin(th2)]))
    v3_2 = sp.kronecker_product(v1_1, Matrix([-sin(th2), cos(th2)]))

    # Level 3
    basis = []
    for v in [v0_2, v1_2, v2_2, v3_2]:
        basis.append(sp.kronecker_product(v, Matrix([cos(th3), sin(th3)])))
        basis.append(sp.kronecker_product(v, Matrix([-sin(th3), cos(th3)])))
    return Matrix.hstack(*basis).T  # 8x8, rows are basis vectors

UA = build_basis_sym(a1,a2,a3)
UB = build_basis_sym(b1,b2,b3)

C = simplify(UA * UB.T) / sqrt(8)

print("Matrix shape:", C.shape)
C

from sympy import latex
print(latex(C))
