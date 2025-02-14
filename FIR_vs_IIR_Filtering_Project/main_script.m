clear; clc; close all;

% Define Sampling Frequency
fs = 250; 

% 1️. Load ECG Signal using get_AD_file()
[TS, Resp, BP, ECG] = get_AD_file();
t = TS; 
ecg_signal = ECG; 

% Display confirmation message
disp('ECG data successfully loaded using get_AD_file().');

% Detrend the signal to remove baseline drift
ecg_signal = detrend(ecg_signal);

% Normalize the signal
ecg_signal = ecg_signal / max(abs(ecg_signal));

% Plot the loaded ECG signal
figure;
plot(t, ecg_signal, 'b');
grid on;
xlim([0 10]);
ylim([-0.6 1.2]);
xticks(0:0.5:10); 
yticks(-0.6:0.2:1.2); 
xlabel('Time [s]');
ylabel('Normalized ECG Amplitude');
title('Loaded ECG Signal');
legend('ECG Signal');



% 2️. Add Noise
noisy_signal = add_noise(ecg_signal, fs);

% 3️. Apply FIR & IIR Filters
[fir_hamming, fir_blackman, iir_butter, iir_chebyshev] = apply_filters(noisy_signal, ecg_signal, fs);

% 4️. Compare in Time Domain
compare_time_domain(t, ecg_signal, noisy_signal, fir_hamming, fir_blackman, iir_butter, iir_chebyshev);

% 5. Compare in Frequency Domain
compare_frequency_domain(ecg_signal, noisy_signal, fir_hamming, fir_blackman, iir_butter, iir_chebyshev, fs);

