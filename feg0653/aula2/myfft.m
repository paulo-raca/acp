function [y, f] = myfft(x, t)
    L = length(x);
    sample_rate =  (L - 1) / t(L);
    y = fft(x);
    y = abs(y) / L;
    y = y(1:L/2 + 1);
    y(2:end-1) = 2*y(2:end-1);
    
    f = sample_rate *(0:(L/2)) / L
end