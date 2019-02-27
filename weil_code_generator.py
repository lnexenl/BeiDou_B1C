import scipy.io as sio

def weil_code_generator(N, N0, w, p):
    residue = []
    for i in range(int((N + 1) / 2)):
        res = i ** 2 % N
        if res not in residue:
            residue.append(res)
    legendre = [0] * N
    for i in range(1, N):
        if i in residue:
            legendre[i] = 1
    weil_code = [0] * N
    for i in range(N):
        weil_code[i] = (legendre[i] + legendre[(i + w) % N]) % 2
    weil_out = []
    # for i in range(N0):
    
    #     weil_out = weil_out + 5*[weil_code[(p - 1 + i)]]
    if (N0 + p - 2) < N:
        weil_out = weil_code[p - 1: p - 1 + N0]
    else:
        weil_out = weil_code[p - 1:] + weil_code[:(p - 1 + N0) % N]
    return weil_out

r = weil_code_generator(10243, 10230, 4318, 341)
s = weil_code_generator(3607, 1800, 269, 1889)
t = weil_code_generator(10243, 10230, 796, 7575)
# print(r[0:24])
# print(r[-24:])
# print(s[0:24])
# print(s[-24:])
sio.savemat('weil.mat', {'data':r, 'child':s, 'pilot':t})
