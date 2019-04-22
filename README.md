# B1C_generator
generate B1C code of BEIDOU

1. generate weil code with weil_code_generator.py
2. use B1C_generator.m to get B1C signal

---

1. 锁频环

锁频环输出：
$$
y[n]=2\omega_{nf}^2T^2_s\sum\limits_{j=1}^n\sum_{i=1}^jx[i]+(2a_2\omega_{nf}T_s-2\omega_{nf}^2T_s^2)\sum_{i=1}^nx[i]+(\cfrac{1}{2}\omega_{nf}^2T_s^2-a_2\omega_{nf}T_s)x[n]
$$
其中$x[n]=atan2(p_{cross}/p_{dot})/t_{coh}/2\pi$

2. 锁相环

锁相环输出：
$$
y[n] = 2\omega_{np}^3T_s^2\sum\limits_{j=1}^n\sum_{i=1}^nx[i]+(2a_3\omega_{np}^2T_s-2T_s^2\omega_{np}^3)\sum_{i=1}^nx[i]+(\cfrac{1}{2}T_s^2\omega_{np}^3-a_3\omega_{np}^2T_s+b_3\omega_{np})x[n]
$$
其中$x[n]=atan2(qp/ip)$

