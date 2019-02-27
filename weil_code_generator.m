% N = 10243;
% N0 = 10230;
% w = 1470;
% p = 2128;
function weil_out = weil_code_generator(N, N0, w, p)
    residu = [];
    for i = 0 : (N - 1) / 2
        res = mod(i^2, N);
        if ~ismember(res, residu)
            residu = [residu res];
        end
    end
    i = 0:N - 1;
    l = ismember(i, residu);
    weil_code = zeros(1, N);
    weil_code(1:N - w) = mod(l(1:N - w) + l(w + 1:N), 2);
    if w ~= 0
        weil_code(N - w + 1:N) = mod(l(N - w + 1:N) + l(1:w), 2);
    end
    if N0 + p - 1 < N
        weil_out = weil_code(p:p + N0 - 1);
    else
        weil_out = [weil_code(p:end) weil_code(1:mod(p+N0 - 1, N))];
    end
end
% r = "";
% for i = 1:24
%     if weil_out(i) == 0
%         r = r + "0";
%     else
%         r = r + "1";
%     end
% end 
%  disp(dec2base(bin2dec(r), 8));
%  r = "";
%  for i = length(weil_out) - 23:length(weil_out)
%     if weil_out(i) == 0
%         r = r + "0";
%     else
%         r = r + "1";
%     end
% end 
%  disp(dec2base(bin2dec(r), 8));
%     for i = 1 : N - 1
%         if ismember(i, residu)
%             l(i) = 1;
%         end
%     end