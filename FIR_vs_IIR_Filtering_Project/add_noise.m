function noisy_signal = add_noise(ecg_signal, fs)
% ADD_NOISE - Adds realistic noise (Gaussian + 50Hz powerline) to an ECG signal.
% 
% INPUT:
%   ecg_signal - Original clean ECG signal
%   fs - Sampling frequency in Hz
%
% OUTPUT:
%   noisy_signal - ECG signal with added noise

% 1️. Add Gaussian noise (simulating sensor/biological noise)
gaussian_noise = 0.05 * randn(size(ecg_signal));

% 2️. Add 50Hz powerline interference
T = length(ecg_signal) / fs; % Total duration in seconds
t = linspace(0, T, length(ecg_signal)); % Time vector
powerline_noise = 0.1 * sin(2 * pi * 50 * t'); % 50Hz sinusoidal interference

% 3️. Combine original ECG with noise
noisy_signal = ecg_signal + gaussian_noise + powerline_noise;

% Plot the original and noisy signals
figure;
subplot(2,1,1);
plot(t, ecg_signal, 'b');
grid on;
xlim([0 10]);
ylim([-0.6 1.2]);
xticks(0:0.5:10); 
yticks(-0.6:0.2:1.2); 
xlabel('Time [s]');
ylabel('ECG Amplitude');
title('Original ECG Signal');
legend('ECG');

subplot(2,1,2);
plot(t, noisy_signal, 'r');
grid on;
xlim([0 10]);
ylim([-0.6 1.2]);
xticks(0:0.5:10); 
yticks(-0.6:0.2:1.2); 
xlabel('Time [s]');
ylabel('ECG Amplitude');
title('Noisy ECG Signal (Gaussian + 50Hz)');
legend('Noisy ECG');


end