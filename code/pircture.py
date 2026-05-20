import matplotlib.patches as patches
import matplotlib.pyplot as plt


def draw_corrected_circuit(
    filename, num_lines, gates, labels, title="", has_ellipsis=False
):
    """
    通用多级受控量子线路绘制工具
    """
    # 动态调整画布比例以适应高密度绘制
    fig, ax = plt.subplots(figsize=(15, max(num_lines * 1.5, 4)))
    ax.axis("off")
    ax.set_xlim(-2, 14)
    ax.set_ylim(-num_lines, 1)

    # 1. 绘制水平量子线路与比特标签
    for i in range(num_lines):
        if has_ellipsis and i == 2:  # 专门为 n-qubit 图留出的纵向省略号占位
            ax.text(-0.5, -i, r"$\vdots$", fontsize=24, va="center", ha="right")
            continue
        ax.plot([0, 13], [-i, -i], color="black", lw=2, zorder=1)
        ax.text(
            -0.5, -i, labels[i], fontsize=20, va="center", ha="right", family="serif"
        )

    # 2. 绘制 n-qubit 专用的横向省略号（逻辑截断）
    if has_ellipsis:
        for i in range(num_lines):
            if i == 2:
                continue
            ax.text(
                7.0,
                -i,
                r"$\cdots$",
                fontsize=28,
                va="center",
                ha="center",
                bbox=dict(facecolor="white", edgecolor="none", pad=2),
                zorder=2,
            )

    # 3. 绘制带有受控条件逻辑门的阵列
    for gate in gates:
        target, x_pos, text, width, controls = gate

        # 寻找该门的纵向跨度以绘制垂直线
        min_y, max_y = -target, -target
        for ctrl, _ in controls:
            min_y = min(min_y, -ctrl)
            max_y = max(max_y, -ctrl)

        # 绘制垂直逻辑连线
        if controls:
            ax.plot([x_pos, x_pos], [min_y, max_y], color="black", lw=2, zorder=3)

        # 绘制控制节点 (0 为空心，1 为实心)
        for ctrl_line, ctrl_type in controls:
            if ctrl_type == 1:
                ax.plot(
                    x_pos,
                    -ctrl_line,
                    marker="o",
                    color="black",
                    markersize=14,
                    zorder=4,
                )
            else:
                circle = patches.Circle(
                    (x_pos, -ctrl_line),
                    0.18,
                    facecolor="white",
                    edgecolor="black",
                    lw=2.5,
                    zorder=4,
                )
                ax.add_patch(circle)

        # 绘制目标位上的酉矩阵 Box
        box_x = x_pos - width / 2
        box_y = -target - 0.45
        rect = patches.Rectangle(
            (box_x, box_y),
            width,
            0.9,
            facecolor="white",
            edgecolor="black",
            lw=2.5,
            zorder=5,
        )
        ax.add_patch(rect)
        ax.text(
            x_pos,
            -target,
            text,
            fontsize=18,
            fontweight="bold",
            family="serif",
            ha="center",
            va="center",
            zorder=6,
        )

    plt.title(title, fontsize=22, pad=20, fontweight="bold", family="serif")
    plt.tight_layout()
    plt.savefig(filename, format="pdf", bbox_inches="tight")
    plt.close()
    print(f"成功导出正确构型的量子线路图: {filename}")


# =========================================
# 绘制图 2：三量子比特正确物理构型
# =========================================
# 仅展示 Alice 端的局域参数调制矩阵 U_A 的完整解构
labels_3q = [r"$A_1$", r"$A_2$", r"$A_3$"]
# gates 格式: (目标线, X坐标, 标签, 框宽, [(控制线, 控制类型0/1), ...])
gates_3q = [
    (2, 2.0, r"$R_y(2\theta_1)$", 2.4, [(0, 0), (1, 0)]),  # |00> 触发
    (2, 4.5, r"$R_y(2\theta_2)$", 2.4, [(0, 0), (1, 1)]),  # |01> 触发
    (2, 7.0, r"$R_y(2\theta_3)$", 2.4, [(0, 1), (1, 0)]),  # |10> 触发
    (2, 9.5, r"$R_y(2\theta_4)$", 2.4, [(0, 1), (1, 1)]),  # |11> 触发
    (2, 12.0, r"$Z$", 1.2, [(0, 0), (1, 1)]),  # 核心：针对 |011> 的局部相位翻转修正
]
draw_corrected_circuit(
    "Corrected_Fig2_3_qubit.pdf",
    3,
    gates_3q,
    labels_3q,
    "Corrected Subcircuit: Local Modulation $U_A$ (3-qubit)",
)

# =========================================
# 绘制图 1：n 量子比特推广正确物理构型
# =========================================
labels_nq = [r"$A_1$", r"$A_2$", "", r"$A_{n-1}$", r"$A_n$"]
gates_nq = [
    (4, 2.0, r"$R_y(2\theta_1)$", 2.5, [(0, 0), (1, 0), (3, 0)]),
    (4, 4.5, r"$R_y(2\theta_2)$", 2.5, [(0, 0), (1, 0), (3, 1)]),
    # X=7.0 位置已被代码底层设定为省略号 \dots
    (4, 9.5, r"$R_y(2\theta_{2^{n-1}})$", 3.0, [(0, 1), (1, 1), (3, 1)]),
    (4, 12.0, r"$Z$", 1.2, [(0, 0), (1, 1), (3, 1)]),  # 代表广义的受控相位条件修正矩阵
]
draw_corrected_circuit(
    "Corrected_Fig1_n_qubit.pdf",
    5,
    gates_nq,
    labels_nq,
    "Corrected Subcircuit: Multiplexed Modulation $U_A$ ($n$-qubit)",
    has_ellipsis=True,
)
