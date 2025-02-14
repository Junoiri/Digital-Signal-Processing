function [fir_hamming, fir_blackman, iir_butter, iir_chebyshev] = apply_filters(noisy_signal, original_ecg, fs)
% APPLY_FILTERS - Applies FIR and IIR filters to remove noise from ECG.
%
% INPUT:
%   noisy_signal - Noisy ECG signal (contaminated with Gaussian & 50Hz noise)
%   fs - Sampling frequency in Hz
%
% OUTPUT:
%   fir_hamming - FIR Hamming window filtered signal (normalized)
%   fir_blackman - FIR Blackman window filtered signal (normalized)
%   iir_butter - IIR Butterworth filtered signal (normalized)
%   iir_chebyshev - IIR Chebyshev filtered signal (normalized)

% Define filter cutoff frequency
cutoff = 45; % Hz (low-pass filter)
order = 40;  % FIR filter order

% Create time vector
T = length(noisy_signal) / fs;
t = linspace(0, T, length(noisy_signal));

% 1️. FIR Filters
[b_hamming, a_hamming] = fir1(order, cutoff/(fs/2), 'low', hamming(order+1));
[b_blackman, a_blackman] = fir1(order, cutoff/(fs/2), 'low', blackman(order+1));
fir_hamming = filtfilt(b_hamming, a_hamming, noisy_signal);
fir_blackman = filtfilt(b_blackman, a_blackman, noisy_signal);

% 2️. IIR Filters
[b_butter, a_butter] = butter(4, cutoff/(fs/2), 'low');
[b_cheby, a_cheby] = cheby1(4, 0.5, cutoff/(fs/2), 'low');
iir_butter = filtfilt(b_butter, a_butter, noisy_signal);
iir_chebyshev = filtfilt(b_cheby, a_cheby, noisy_signal);

% Get min and max values of original ECG
original_max = max(abs(original_ecg));  

% Apply true normalization to match the original ECG range
fir_hamming = fir_hamming / max(abs(fir_hamming)) * original_max;
fir_blackman = fir_blackman / max(abs(fir_blackman)) * original_max;
iir_butter = iir_butter / max(abs(iir_butter)) * original_max;
iir_chebyshev = iir_chebyshev / max(abs(iir_chebyshev)) * original_max;


% Plot Filtered Signals
figure;
subplot(3,2,1);
plot(t, noisy_signal, 'k');
grid on;
xlim([0 10]);
ylim([-1 1.2]);
title('Noisy ECG Signal');
xlabel('Time [s]');
ylabel('ECG Amplitude');
legend('Noisy ECG');

subplot(3,2,3);
plot(t, fir_hamming, 'b');
grid on;
xlim([0 10]);
ylim([-1 1.2]);
title('FIR Filtered (Hamming, Normalized)');
xlabel('Time [s]');
ylabel('ECG Amplitude');
legend('Hamming');

subplot(3,2,4);
plot(t, fir_blackman, 'g');
grid on;
xlim([0 10]);
ylim([-1 1.2]);
title('FIR Filtered (Blackman, Normalized)');
xlabel('Time [s]');
ylabel('ECG Amplitude');
legend('Blackman');

subplot(3,2,5);
plot(t, iir_butter, 'r');
grid on;
xlim([0 10]);
ylim([-1 1.2]);
title('IIR Filtered (Butterworth, Normalized)');
xlabel('Time [s]');
ylabel('ECG Amplitude');
legend('Butterworth');

subplot(3,2,6);
plot(t, iir_chebyshev, 'm');
grid on;
xlim([0 10]);
ylim([-1 1.2]);
title('IIR Filtered (Chebyshev, Normalized)');
xlabel('Time [s]');
ylabel('ECG Amplitude');
legend('Chebyshev');
end
