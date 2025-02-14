% the FIR filter from lecture 7
b = [-1 2 -1];
a = 1;
omega = linspace(0,pi,100);
H = -1 + 2*exp(-1i*omega) -exp(-1i*2*omega);
figure;
subplot(211)
plot(omega,abs(H))
xlabel('Normalized Frequency')
ylabel('Amplitude Speectrum')
subplot(212)
plot(omega,angle(H))
xlabel('Normalized Frequency')
ylabel('Phase Speectrum')

% use of freqz function (creating the frequency response of a filter)
[H,W] = freqz(b,a,100);
subplot(211)
hold on
plot(W,abs(H),'r--')
subplot(212)
hold on
plot(W,angle(H),'r--')