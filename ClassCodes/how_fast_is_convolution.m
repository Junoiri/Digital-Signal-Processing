% How fast is convolution in the frequency domain.

N = 1024;
x = randn(N,1);
h = randn(N,1);
MC = 1000; % Monte Carlo simulation
tic; % stopwatch
for n = 1 : MC
    conv(x,h);
end
CPU_time_t = toc;
%
tic;
for n = 1 : MC
    ifft(fft(x).*fft(h)); % ifft - inverse fast Fourier transform
end
CPU_time_f = toc;
disp([CPU_time_t CPU_time_f CPU_time_t/CPU_time_f])