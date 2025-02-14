% Spectral leakage
% v0.1 22.11.2024

c = 2; A = 2; f =3 ; phi = pi/3;
ts = 0; te = 1;
fs = 50;
Ts = 1/fs;
SNR = 40;
[s, sn, t] = generate_cos_sig(c,A,f,phi,ts,te,Ts, SNR);

N = length(s);
S = fft(detrend(s));
L = te - ts;
faxis = (0:1/L:fs-1/L) - fs/2;

figure
subplot(211)
plot(t,s); grid on
xlabel('Time [s]')
ylabel('Signal Amplitude')

subplot(212)
stem(faxis, fftshift(abs(S/N)))
xlabel('Frequency [Hz]')
ylabel('Amplitude Spectrum')

% case 2
te1 = 1.13;

[s1, sn1, t1] = generate_cos_sig(c,A,f,phi,ts,te1,Ts, SNR);

N1 = length(s1);
S1 = fft(detrend(s1));
L1 = te1 - ts;
faxis1 = (0:1/L1:fs-1/L1) - fs/2;

subplot(211)
hold on
plot(t1,s1, 'r--'); grid on
subplot(212)
hold on
stem(faxis1, fftshift(abs(S1/N1)))

% Use a window for diminishing the spectral leakage.
w = hanning(N1);
S1w = fft(detrend(s1).*w);

stem(faxis1, fftshift(abs(S1w/N1)), 'k')
