load("PRNList.mat");

SR = 10.23e6;
Ts = 1/SR;
doppler_freq = 5e3;
freq_interval = 5e2;

% generate B1C code for each PRN
B1C = [];
for i = 1:60
    B1C = [B1C; weil_code_generator(10243, 10230, PRNList(i, 2), PRNList(i, 3))];
end
B1C = kron(B1C, ones(1, 10));


% read data
fid = fopen('B1C_Signal_IQ_INT8.dat', 'r');
signal = fread(fid, 1000000, 'int8');
signal = fread(fid, 2 * SR * 0.01, 'int8');
fclose(fid);


signal_I = signal(1:2:length(signal));
signal_Q = signal(2:2:length(signal));
t_10ms = Ts:Ts:0.01;
for freq = -doppler_freq:freq_interval:doppler_freq
    cos_10ms = cos(2 * pi * freq * t_10ms);
    sin_10ms = sin(2 * pi * freq * t_10ms);
    signal_Id = signal_I' .* cos_10ms;
    signal_Qd = signal_Q' .* sin_10ms;
    
end
