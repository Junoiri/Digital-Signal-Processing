function compare_time_domain(t, ecg, noisy, fir_hamming, fir_blackman, iir_butter, iir_chebyshev)
% COMPARE_TIME_DOMAIN - Plots ECG signals to analyze filter effects in time domain.
%
% INPUT:
%   t - Time vector (s)
%   ecg - Original ECG signal (clean)
%   noisy - Noisy ECG signal
%   fir_hamming - FIR (Hamming) filtered ECG
%   fir_blackman - FIR (Blackman) filtered ECG
%   iir_butter - IIR (Butterworth) filtered ECG
%   iir_chebyshev - IIR (Chebyshev) filtered ECG
%
% OUTPUT:
%   Time-domain visualization of all signals

figure;
subplot(3,2,1);
plot(t, ecg, 'k');
grid on;
xlim([0 10]);
ylim([-0.6 1.2]);
xticks(0:0.5:10);
yticks(-0.6:0.2:1.2);
title('Original ECG Signal');
xlabel('Time [s]');
ylabel('Amplitude');
legend('Original');

subplot(3,2,2);
plot(t, noisy, 'r');
grid on;
xlim([0 10]);
xticks(0:0.5:10);
title('Noisy ECG Signal');
xlabel('Time [s]');
ylabel('Amplitude');
legend('Noisy ECG');

subplot(3,2,3);
plot(t, fir_hamming, 'b');
grid on;
xlim([0 10]);
xticks(0:0.5:10);
title('FIR (Hamming) Filtered ECG');
xlabel('Time [s]');
ylabel('Amplitude');
legend('FIR - Hamming');

subplot(3,2,4);
plot(t, fir_blackman, 'g');
grid on;
xlim([0 10]);
xticks(0:0.5:10);
title('FIR (Blackman) Filtered ECG');
xlabel('Time [s]');
ylabel('Amplitude');
legend('FIR - Blackman');

subplot(3,2,5);
plot(t, iir_butter, 'm');
grid on;
xlim([0 10]);
xticks(0:0.5:10);
title('IIR (Butterworth) Filtered ECG');
xlabel('Time [s]');
ylabel('Amplitude');
legend('IIR - Butterworth');

subplot(3,2,6);
plot(t, iir_chebyshev, 'c');
grid on;
xlim([0 10]);
xticks(0:0.5:10);
title('IIR (Chebyshev) Filtered ECG');
xlabel('Time [s]');
ylabel('Amplitude');
legend('IIR - Chebyshev');

sgtitle('Time Domain Comparison of ECG Filtering');
end