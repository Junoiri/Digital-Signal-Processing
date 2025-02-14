% Time and Frequency representation of physiological signals
% 08.11.2024 -v0.1
% 22.11.2024 -v0.2, Power spectral analysis

clear
[t,s_Resp,s_BP,s_ECG] = get_AD_file;
figure;
subplot(311)
plot(t, s_Resp);
grid on
xlim([0 10])
xlabel('Time [s]')
ylabel('Signal Amplitude [mV]')
title('Respiration')

subplot(312)
plot(t, s_BP);
grid on
xlim([0 10])
xlabel('Time [s]')
ylabel('Signal Amplitude [mV]')
title('Blood pulse')

subplot(313)
plot(t, s_ECG);
grid on
xlim([0 10])
xlabel('Time [s]')
if mean(abs(s_ECG)) > 1
    ylabel('Signal Amplitude [{\mu}V')
else
    ylabel('Signal Amplitude [mV]')
end
title('ECG')

%% Frequency domain representation
% Periodogram
S_Resp = fft(detrend(s_Resp)); % remove the trend of the data. clearing the spectrum around the zero.
S_BP = fft(detrend(s_BP));
S_ECG = fft(detrend(s_ECG));

N = length(t);
fs = 1/(t(2) - t(1));
L = t(end) - t(1);
faxis = (0: 1/L :fs); % -fs/2; Go to the last frequency through fs.

figure
subplot(311)
plot(faxis, (abs(S_Resp)/N).^2);
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('Respiration (Periodogram)')

subplot(312)
plot(faxis, (abs(S_BP)/N).^2);
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('Blood puls (Periodogram)')

subplot(313)
plot(faxis, (abs(S_ECG)/N).^2);
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('ECG (Periodogram)')


%% Frequency domain representation
% Smoothed periodogram

w = hanning(N);
Sw_Resp = fft(detrend(s_Resp).*w); % remove the trend of the data. clearing the spectrum around the zero.
Sw_BP = fft(detrend(s_BP.*w));
Sw_ECG = fft(detrend(s_ECG).*w);

figure
subplot(311)
plot(faxis, (abs(Sw_Resp)/N).^2, 'r');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('Respiration (Smoothed Periodogram)')

subplot(312)
plot(faxis, (abs(Sw_BP)/N).^2, 'r');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('Blood puls (Smoothed Periodogram)')

subplot(313)
plot(faxis, (abs(Sw_ECG)/N).^2, 'r');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title('ECG (Smoothed Periodogram)')

%% Frequency domain representation
% (Welch's method)

nfft = 1024;
noverlap = nfft/2; % 50% overlap
window = hanning(nfft); % window has to be of the same size as the segment we choose.
[Pxx_Resp,F] = pwelch(detrend(s_Resp),window,noverlap, nfft,fs);
Pxx_BP = pwelch(detrend(s_BP),window,noverlap, nfft,fs);
Pxx_ECG = pwelch(detrend(s_ECG),window,noverlap, nfft,fs);

figure
subplot(311)
plot(F, Pxx_Resp, 'k');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title("Respiration (Welch's method)")

subplot(312)
plot(F, Pxx_BP, 'k');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title("Blood puls (Welch's method)")

subplot(313)
plot(F, Pxx_ECG, 'k');
grid on
xlim([0 10])
xlabel('Frequency [Hz]')
ylabel('Power Spectrum')
title("ECG (Welch's method)")
