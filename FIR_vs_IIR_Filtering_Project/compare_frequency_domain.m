function compare_frequency_domain(original_ecg, noisy, fir_hamming, fir_blackman, iir_butter, iir_chebyshev, fs)
% COMPARE_FREQUENCY_DOMAIN - Analyzes FFT & Power Spectral Density (PSD) to evaluate filtering performance.
%
% INPUT:
%   original_ecg - Original ECG signal (clean)
%   noisy - Noisy ECG signal
%   fir_hamming - FIR (Hamming) filtered ECG
%   fir_blackman - FIR (Blackman) filtered ECG
%   iir_butter - IIR (Butterworth) filtered ECG
%   iir_chebyshev - IIR (Chebyshev) filtered ECG
%   fs - Sampling frequency in Hz
%
% OUTPUT:
%   Frequency-domain analysis plots

N = length(noisy); % Signal length
half_N = floor(N/2); 
faxis = linspace(0, fs/2, half_N); 

% Compute FFT of each signal
fft_original = abs(fft(original_ecg)/N);
fft_noisy = abs(fft(noisy)/N);
fft_hamming = abs(fft(fir_hamming)/N);
fft_blackman = abs(fft(fir_blackman)/N);
fft_butter = abs(fft(iir_butter)/N);
fft_chebyshev = abs(fft(iir_chebyshev)/N);

% Adjusting axes based on visible data
freq_limit = 125; 
y_limit = max([max(fft_original), max(fft_noisy), max(fft_hamming), max(fft_blackman), max(fft_butter), max(fft_chebyshev)]); 
y_limit = y_limit * 1.1; 

% Plot FFT results
figure;
subplot(3,2,1);
plot(faxis, fft_original(1:half_N), 'k'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('Original ECG FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

subplot(3,2,2);
plot(faxis, fft_noisy(1:half_N), 'r'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('Noisy Signal FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

subplot(3,2,3);
plot(faxis, fft_hamming(1:half_N), 'b'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('FIR (Hamming) FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

subplot(3,2,4);
plot(faxis, fft_blackman(1:half_N), 'g'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('FIR (Blackman) FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

subplot(3,2,5);
plot(faxis, fft_butter(1:half_N), 'm'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('IIR (Butterworth) FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

subplot(3,2,6);
plot(faxis, fft_chebyshev(1:half_N), 'c'); grid on;
xlim([0 freq_limit]);
ylim([0 y_limit]);
yticks(0:y_limit/5:y_limit);
xticks(0:5:freq_limit);
title('IIR (Chebyshev) FFT'); xlabel('Frequency [Hz]'); ylabel('Magnitude');

sgtitle('Frequency Domain Comparison of ECG Filtering');

figure;
subplot(3,2,1);
pwelch(original_ecg,[],[],[],fs);
xticks(0:10:fs/2);
title('Original ECG PSD');

subplot(3,2,2);
pwelch(noisy,[],[],[],fs);
xticks(0:10:fs/2);
title('Noisy Signal PSD');

subplot(3,2,3);
pwelch(fir_hamming,[],[],[],fs);
xticks(0:10:fs/2);
title('FIR (Hamming) PSD');

subplot(3,2,4);
pwelch(fir_blackman,[],[],[],fs);
xticks(0:10:fs/2);
title('FIR (Blackman) PSD');

subplot(3,2,5);
pwelch(iir_butter,[],[],[],fs);
xticks(0:10:fs/2);
title('IIR (Butterworth) PSD');

subplot(3,2,6);
pwelch(iir_chebyshev,[],[],[],fs);
xticks(0:10:fs/2);
title('IIR (Chebyshev) PSD');

sgtitle('Power Spectral Density Comparison');
end
