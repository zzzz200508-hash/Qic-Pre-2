import matplotlib.pyplot as plt
import numpy as np
from matplotlib.widgets import Slider

# ==========================================
# 1. 基础物理量定义
# ==========================================
k0 = np.array([[1], [0]], dtype=complex)
k1 = np.array([[0], [1]], dtype=complex)

I = np.array([[1, 0], [0, 1]], dtype=complex)
X = np.array([[0, 1], [1, 0]], dtype=complex)
Y = np.array([[0, -1j], [1j, 0]], dtype=complex)
Z = np.array([[1, 0], [0, -1]], dtype=complex)
paulis = [I, X, Y, Z]
pauli_names = ["I", "X", "Y", "Z"]


def tensor(*args):
    """计算张量积"""
    from functools import reduce

    return reduce(np.kron, args)


# ==========================================
# 2. 三量子比特广义正交基底生成器
# ==========================================
def generate_basis(thetas):
    t1, t2, t3, t4 = thetas
    return [
        tensor(k0, k0, np.cos(t1) * k0 + np.sin(t1) * k1),
        tensor(k0, k0, -np.sin(t1) * k0 + np.cos(t1) * k1),
        tensor(k0, k1, np.cos(t2) * k0 + np.sin(t2) * k1),
        tensor(k0, k1, np.sin(t2) * k0 - np.cos(t2) * k1),
        tensor(k1, k0, np.cos(t3) * k0 + np.sin(t3) * k1),
        tensor(k1, k0, -np.sin(t3) * k0 + np.cos(t3) * k1),
        tensor(k1, k1, np.cos(t4) * k0 + np.sin(t4) * k1),
        tensor(k1, k1, -np.sin(t4) * k0 + np.cos(t4) * k1),
    ]


# ==========================================
# 3. 初始化固定参数与未知态
# ==========================================
# 这里我们将 unprime 固定，开放 prime 给用户拖动
thetas_unprime = [np.pi / 4, np.pi / 4, np.pi / 4, np.pi / 4]
thetas_prime = [0.0, 0.0, 0.0, 0.0]

np.random.seed(1024)
a_K = np.random.randn(8) + 1j * np.random.randn(8)
a_K = a_K / np.linalg.norm(a_K)

# ==========================================
# 4. 可视化 GUI 设置
# ==========================================
fig = plt.figure(figsize=(15, 10))

if fig.canvas.manager is not None:
    fig.canvas.manager.set_window_title("3-Qubit Teleportation Simulator")
fig.suptitle("3-Qubit Teleportation Simulator", fontsize=16, fontweight="bold", y=0.96)

plt.subplots_adjust(bottom=0.30, top=0.88, hspace=0.4, wspace=0.3)

ax1 = fig.add_subplot(221)
ax2 = fig.add_subplot(222)
ax3 = fig.add_subplot(223)
ax4 = fig.add_subplot(224)

state_labels = [f"|{bin(i)[2:].zfill(3)}>" for i in range(8)]


def setup_bar_axis(ax, title):
    ax.set_title(title, fontsize=12, pad=10)
    ax.set_ylim(0, 1.0)
    ax.set_ylabel("Probability |a_K|^2")
    ax.set_xticks(range(8))
    ax.set_xticklabels(state_labels, rotation=45)
    ax.grid(axis="y", linestyle="--", alpha=0.7)


setup_bar_axis(ax1, "1. Original State |φ>_A'")
setup_bar_axis(ax2, "2. Bob's State (Collapsed) |φ>_B")
setup_bar_axis(ax3, "3. Bob's State (Recovered) |φ>_B")

# 初始化画图占位（会在 update 中立即被填满）
bars1 = ax1.bar(range(8), np.zeros(8), color="#3498db")
bars2 = ax2.bar(range(8), np.zeros(8), color="#e74c3c")
bars3 = ax3.bar(range(8), np.zeros(8), color="#2ecc71")

# 矩阵热力图初始化
ax4.set_title("4. Recovery Matrix $U_{Bob}$", fontsize=12, pad=10)
ax4.set_xticks(range(8))
ax4.set_yticks(range(8))
ax4.set_xticklabels(state_labels, rotation=45)
ax4.set_yticklabels(state_labels)
matrix_img = ax4.imshow(np.zeros((8, 8)), cmap="Blues", vmin=0, vmax=1, alpha=0.6)

matrix_texts = []
for row in range(8):
    row_texts = []
    for col in range(8):
        text = ax4.text(
            col, row, "", ha="center", va="center", color="black", fontweight="bold"
        )
        row_texts.append(text)
    matrix_texts.append(row_texts)

fid_text = fig.text(
    0.5, 0.91, "Fidelity: 1.0000", ha="center", fontsize=14, fontweight="bold"
)
op_text = fig.text(0.5, 0.87, "Bob Unitary: I ⊗ I ⊗ I", ha="center", fontsize=12)

# ==========================================
# 5. 交互控件设置 (双列 UI Elements)
# ==========================================
axcolor = "lightgoldenrodyellow"

ax_i = plt.axes((0.10, 0.18, 0.35, 0.02), facecolor=axcolor)
ax_j = plt.axes((0.10, 0.12, 0.35, 0.02), facecolor=axcolor)
ax_k = plt.axes((0.10, 0.06, 0.35, 0.02), facecolor=axcolor)

# 修改为 theta' (Prime 参数)，它们会直接改变未知的量子态波函数
ax_t1 = plt.axes((0.55, 0.22, 0.35, 0.02), facecolor=axcolor)
ax_t2 = plt.axes((0.55, 0.16, 0.35, 0.02), facecolor=axcolor)
ax_t3 = plt.axes((0.55, 0.10, 0.35, 0.02), facecolor=axcolor)
ax_t4 = plt.axes((0.55, 0.04, 0.35, 0.02), facecolor=axcolor)

slider_i = Slider(ax_i, "Measure i (A1)", 0, 3, valinit=0, valstep=1, valfmt="%d")
slider_j = Slider(ax_j, "Measure j (A2)", 0, 3, valinit=0, valstep=1, valfmt="%d")
slider_k = Slider(ax_k, "Measure k (A3)", 0, 3, valinit=0, valstep=1, valfmt="%d")

slider_t1 = Slider(
    ax_t1, r"State $\theta^\prime_1$", 0, np.pi / 2, valinit=0, valfmt="%.2f rad"
)
slider_t2 = Slider(
    ax_t2, r"State $\theta^\prime_2$", 0, np.pi / 2, valinit=0, valfmt="%.2f rad"
)
slider_t3 = Slider(
    ax_t3, r"State $\theta^\prime_3$", 0, np.pi / 2, valinit=0, valfmt="%.2f rad"
)
slider_t4 = Slider(
    ax_t4, r"State $\theta^\prime_4$", 0, np.pi / 2, valinit=0, valfmt="%.2f rad"
)


# ==========================================
# 6. 核心更新逻辑
# ==========================================
def update(val):
    i, j, k = int(slider_i.val), int(slider_j.val), int(slider_k.val)

    # 获取新的 theta' 参数
    thetas_prime[0] = slider_t1.val
    thetas_prime[1] = slider_t2.val
    thetas_prime[2] = slider_t3.val
    thetas_prime[3] = slider_t4.val

    basis_A = generate_basis(thetas_unprime)
    basis_prime = generate_basis(thetas_prime)

    # 动态重构未知态（因为基底变了，整个态的波函数发生了偏移）
    phi_Aprime = np.sum([a_K[idx] * basis_prime[idx] for idx in range(8)], axis=0)
    phi_target = np.sum([a_K[idx] * basis_prime[idx] for idx in range(8)], axis=0)
    prob_target = np.abs(phi_target) ** 2

    # 同步重绘子图 1 (Original State)
    for bar, h in zip(bars1, np.real(prob_target.flatten())):
        bar.set_height(h)

    # 重新构建系统并隐形传态
    psi_AB = np.sum(
        [tensor(basis_A[idx], basis_prime[idx]) for idx in range(8)], axis=0
    ) / (2 * np.sqrt(2))
    Psi_Total = tensor(phi_Aprime, psi_AB)
    Pi_000 = np.sum(
        [tensor(basis_prime[idx], basis_A[idx]) for idx in range(8)], axis=0
    ) / (2 * np.sqrt(2))

    U_Alice = tensor(paulis[i], paulis[j], paulis[k])
    Pi_ijk = tensor(U_Alice, np.eye(8)) @ Pi_000

    bra_Pi_ijk = tensor(np.conjugate(Pi_ijk).T, np.eye(8))
    bob_collapsed = 8 * (bra_Pi_ijk @ Psi_Total)
    prob_collapsed = np.abs(bob_collapsed) ** 2

    U_Bob = tensor(paulis[i], paulis[j], paulis[k])
    bob_recovered = U_Bob @ bob_collapsed
    prob_recovered = np.abs(bob_recovered) ** 2

    # 同步重绘子图 2 和子图 3
    for bar, h in zip(bars2, np.real(prob_collapsed.flatten())):
        bar.set_height(h)
    for bar, h in zip(bars3, np.real(prob_recovered.flatten())):
        bar.set_height(h)

    matrix_img.set_data(np.abs(U_Bob))
    for row in range(8):
        for col in range(8):
            v = U_Bob[row, col]
            if np.abs(v) < 1e-6:
                txt = ""
            elif np.abs(np.real(v)) > 1e-6:
                txt = f"{int(np.real(v))}"
            else:
                sign = "-" if np.imag(v) < 0 else ""
                txt = f"{sign}i"
            matrix_texts[row][col].set_text(txt)

    fidelity = np.abs(np.conjugate(phi_target).T @ bob_recovered)[0, 0] ** 2

    fid_text.set_text(f"Fidelity: {fidelity:.6f}")
    fid_text.set_color("green" if np.isclose(fidelity, 1.0) else "red")
    op_text.set_text(
        f"Bob Unitary: {pauli_names[i]} ⊗ {pauli_names[j]} ⊗ {pauli_names[k]}"
    )

    fig.canvas.draw_idle()


# 绑定所有滑块的监听器
slider_i.on_changed(update)
slider_j.on_changed(update)
slider_k.on_changed(update)
slider_t1.on_changed(update)
slider_t2.on_changed(update)
slider_t3.on_changed(update)
slider_t4.on_changed(update)

update(0)
plt.show()
