function [s, sn, t] = generate_cos_sig(c,A,f,phi,ts,te,T, SNR)
%
% Function for generating a sinusoidal function.
% [s,sn, t] = generate_cos_sig(c,A,f,phi,ts,te,T, SNR)
% INPUTS:
%       c - DC value
%       A - signal amplitude
%       ...
%       SNR - signal to noise ratio [dB]
% OUTPUTS:
%       s - sinsusoidal signal
%       sn - noisy version of s
%       t - corresponding values of t

% 04.10.2024 (ver. 0.1)
% 11.10.2024 (ver. 0.2) added sn
% 18.10.2024 (ver. 0.3)

t = (ts:T:te - T)'; % setting t as a vector with starting point at ts and goes through T to te.
s = c + A*cos(2*pi*f*t + phi);
N = length(t);
Ps = A^2/2;
Pn = Ps*10^(-SNR/10);
n = sqrt(Pn)*randn(N, 1); % (,1) to make it a column (rows, column) simple matrix creation.
sn = s + n;