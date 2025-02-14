% Wavelet analysis of nonstationary signals
A = [3 2 1];
f = [10 20 30];
phi = 2 * pi * rand(1,3) - pi ; % ensure it is between minus pi and pi
c = 0;
ts = 0;
te = 3;
fs = 100;
Ts = 1/fs;
SNR = 40;
[s1, sn1 ,t1 ] = generate_cos_sig_multi(c,A(1),f(1),phi(1),0,1,Ts,SNR);
[s2, sn2 ,t2 ] = generate_cos_sig_multi(c,A(2),f(2),phi(2),1+Ts,2,Ts,SNR);
[s3, sn3 ,t3 ] = generate_cos_sig_multi(c,A(3),f(3),phi(3),2+Ts,3,Ts,SNR);
L = length(s1);
sns = [sn1;sn2;sn2];
t = [t1;t2;t3];

% CWT
[WT,F] = cwt(sns,fs);
figure;surf(t,F,abs(WT)); shading interp
view(2)
xlabel('Time');
ylabel('Frequency')
title('Scalogram')