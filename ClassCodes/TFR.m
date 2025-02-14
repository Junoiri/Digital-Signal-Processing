% TFR for ECG signal
[t,~,~,ECG] = get_AD_file;
s = detrend(ECG);
fs = 100;
sa = hilbert(s);
figure
subplot(311);plot(t,s);grid on;xlim([0 3]);
xlabel('Time [s]')
ylabel('ECG')
subplot(312);plot(t,real(sa));grid on;xlim([0 3])
xlabel('Time [s]')
ylabel('Re(sa), ECG')
subplot(313);plot(t,imag(sa));grid on;xlim([0 3])
xlabel('Time [s]')
ylabel('Im(sa), ECG')

%% Wigner-Ville distribution
N = length(s);
NFFT = 1024;
T = 1:N;
tic;TFR_wv = tfrwv(sa,T,NFFT);
cpu_time_wv = toc;
xax = T/fs;
yax = (0:NFFT-1)/NFFT/2*fs;
noise_floor_level = 0.05;
ind = TFR_wv < TFR_wv/max(TFR_wv(:))*noise_floor_level;
TFR_wv(ind) = 0;
figure;surf(xax,yax,abs(TFR_wv))
shading interp
xlabel('Time [s]')
ylabel('Frequency [Hz]')
title('Wigner-Ville distribution')
view(2) % bird's-eye view
ylim([0 10])
colormap hsv

%% Choi-Williams time-frequency distribution


tic;
TFR_cw = tfrcw(sa,T,NFFT,hanning(NFFT/8+1),hanning(NFFT/2+1));
cpu_time_cw = toc;
xax = T/fs;
yax = (0:NFFT-1)/NFFT/2*fs;
noise_floor_level = 0.05;
ind = TFR_cw < TFR_cw/max(TFR_cw(:))*noise_floor_level;
TFR_cw(ind) = 0;
figure;surf(xax,yax,abs(TFR_cw))
shading interp
xlabel('Time [s]')
ylabel('Frequency [Hz]')
title('Choi-Williams distribution')
view(2) % bird's-eye view
ylim([0 10])
colormap hsv

disp([cpu_time_wv cpu_time_cw])

%% ZAM distribution

tic;
TFR_zam = tfrzam(sa,T,NFFT,hanning(NFFT/8+1),hanning(NFFT/2+1));
cpu_time_zam = toc;
xax = T/fs;
yax = (0:NFFT-1)/NFFT/2*fs;
noise_floor_level = 0.05;
ind = TFR_zam < TFR_zam/max(TFR_zam(:))*noise_floor_level;
TFR_zam(ind) = 0;
figure;surf(xax,yax,abs(TFR_zam))
shading interp
xlabel('Time [s]')
ylabel('Frequency [Hz]')
title('Zhao Atlas Marks distribution')
view(2) % bird's-eye view
ylim([0 10])
colormap hsv

%% Spectrogram

NOVERLAP = NFFT/4;
tic;
[S,F,T] = spectrogram(s,hamming(NFFT),NOVERLAP,NFFT,fs);
cpu_time_spec = toc;
figure;surf(T,F,abs(S))
shading interp
xlabel('Time [s]')
ylabel('Frequency [Hz]')
title('Spectrogram')
view(2)
ylim([0 10])
colormap hsv

disp([cpu_time_wv cpu_time_cw cpu_time_spec])

%% CWT
tic;
[WT,F] = cwt(s,fs);
cpu_time_wavelet = toc;
figure;surf(T,F,abs(WT)); shading interp
view(2)
xlabel('Time');
ylabel('Frequency')
title('Scalogram')


disp([cpu_time_wv cpu_time_cw cpu_time_spec cpu_time_wavelet])