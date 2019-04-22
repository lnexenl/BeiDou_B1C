
function [PRN, freq, phase] = acquisition()
    load PRNList.mat PRNList;
    IF = 0;
    fs = 10.23e6;
    time_chip = 0.01;
    Ts = 1/fs;
    doppler_freq = 5e3;
    freq_interval = 5e2;

    % read data
    fid = fopen('B1C_Signal_IQ_INT8.dat', 'r');
%     signal = fread(fid, 4*fs, 'int8');
    signal = zeros(10, 204600);
    for i = 1:10
        signal(i, :) = fread(fid, 2 * fs * time_chip, 'int8');
    end
    fclose(fid);

    % fft and acquire the signal
    signal = signal(:, 2:2:length(signal));
    t = Ts:Ts:time_chip;
    for PRN = 32:32
        res = zeros(11, 5*20460);
        B1C = weil_code_generator(PRN);
        B1C = kron(B1C, ones(1, 10));
        i = 0;
        for f = IF:freq_interval:IF + doppler_freq
            i = i + 1;
            cos_t = kron(cos(2 * pi * f * t), ones(10, 1));
            sin_t = kron(sin(2 * pi * f * t), ones(10, 1));
            signal_cos = signal .* cos_t;
            signal_sin = signal .* sin_t;
            signal_f = fft(signal_cos + 1i * signal_sin, [], 2);
            B1C_f = kron(conj(fft(B1C)), ones(10, 1));
            res(i, :) = sum(abs(ifft(signal_f .* B1C_f, [], 2)) .^ 2);
        end
    end
    [freq, phase] = find(res == max(max(res)));
end