function [ie, ip, il, qe, qp, ql] = tracking_correlator(signal_i, signal_q, weil_early, weil_prompt, weil_late)
    ie = sum(signal_i.*weil_early);
    ip = sum(signal_i.*weil_prompt);
    il = sum(signal_i.*weil_late);
    qe = sum(signal_q.*weil_early);
    qp = sum(signal_q.*weil_prompt);
    ql = sum(signal_q.*weil_late);
end

