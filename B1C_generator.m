clear all;
clc;
load('weil.mat')
f_a = 1.023e6;
f_b = 6*f_a;
tau = 0.1 / f_a;
sp = 20;
tau0 = tau / sp;


t = zeros(1, sp*10*10230);
B1C_data = zeros(1, sp*10*10230);
B1C_pilot = zeros(1, sp*10*10230);
D = zeros(1, sp*10*10230);
cnt = 1;
data = double(data);
pilot = double(pilot);
t_e = 0:tau0:tau-tau0;
for i = 1:10
    if child(i) == 0
        p = ~pilot;
    else
        p = pilot;
    end
    for k = 1:length(data)
        data_e = data(k)*ones(1, sp);
        pilot_e = p(k) * ones(1, sp);
%         B1C_data(cnt) = m(k);
%         B1C_data(cnt + 1) = m(k);
        B1C_data(cnt:cnt+sp-1) = data_e;
%         B1C_pilot(cnt) = main(k);
%         B1C_pilot(cnt + 1) = main(k);
        B1C_pilot(cnt:cnt + sp-1) = pilot_e;
        r = round(rand(1)) * ones(1, sp);
        D(cnt:cnt + sp-1) = r;
%         D(cnt + 1) = r;
%         B1C_data = [B1C_data m(j) m(j)];
%         B1C_pilot = [B1C_pilot main(j) main(j)];
        if cnt ~= 1
            t0 = t(cnt - 1);
            t(cnt:cnt + sp-1) = t0 + tau0+t_e;         
%             t = [t t0 + tau0 t0 + tau];
        else
            t(cnt:cnt + sp-1) = t_e;
        end
        cnt = cnt + sp;
    end
    
end
B1C_pilot = -2*B1C_pilot + 1;
B1C_data = -2*B1C_data + 1;
sinf_a = sin(2*pi*f_a*t);
f = (sinf_a < 0.0001);
g = (sinf_a > -0.0001);
f = f&g;
sinf_a(f) = 0;
sinf_b = sin(2*pi*f_b*t);
sa = sign(sinf_a);
sb = sign(sinf_b);
f = (sinf_b < 0.0001);
g = (sinf_b > -0.0001);
f = f&g;
sinf_b(f) = 0;
s_B1C = D .* B1C_data.*sign(sinf_a)/2+sqrt(1/11).*B1C_pilot.*sign(sinf_b)+1i*sqrt(29/44).*B1C_pilot.*sign(sinf_a);
% s = sign(sin(2*pi*f_b*t));
hold on;
plot(t(1:1000), real(s_B1C(1:1000)));
% plot(t(1:1000),sa(1:1000));
% plot(t(1:1000),sb(1:1000));

