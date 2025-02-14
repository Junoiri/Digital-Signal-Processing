% %Relationships between the signals
[t,~,s_BP,s_ECG] = get_AD_file;
s1 = detrend(s_ECG);
s2 = detrend(s_BP);
% normalize the signals
s1 = s1/max(abs(s1));
s2 = s2/max(abs(s2));
figure;
subplot(211)
plot(t,s1);
hold on
plot(t,s2,'r')
xlim([0 10])
grid on
xlabel('Time [s]')
ylabel('Normalized Signal Amplitude')
legend('ECG','Blood pulse')

%% Estimate time delay
fs = 100;
[Rxy,lags] = xcorr(s1,s2);
[~,ind_max] = max(Rxy);
tau = lags(ind_max)/fs;
subplot(212)
plot(lags/fs,Rxy)
xlabel('${\tau}$ [s]')
ylabel('Cross-correlation')
title(['${\tau}$ = ' num2str(tau)])

%% Let us filter both signals using an FIR filter
Hd1 = LPF_10_Hz_1_40_M71;
%Hd1 = FR_LPF_3_Hz_025_80_M302;

fc = 10;
%fc = 3;
[b,a] = butter(10,fc/(fs/2));
% Zero-phase filter ECG signal with both filters
s1f1 = filtfilt(Hd1.Numerator,1,s1);
s1f2 = filtfilt(b,a,s1);
% Zero-phase filter BP signal with both filters
s2f1 = filtfilt(Hd1.Numerator,1,s2);
s2f2 = filtfilt(b,a,s2);

% FIR filter
[Rxy1,lags1] = xcorr(s1f1,s2f1);
[~,ind_max1] = max(Rxy1);
tau1 = lags1(ind_max1)/fs;

% IRR filter
[Rxy2,lags2] = xcorr(s1f2,s2f2);
[~,ind_max2] = max(Rxy2);
tau2 = lags2(ind_max2)/fs;

%% show the effect of filtering
% FIR
figure;
subplot(211)
plot(t,s1f1);
hold on
plot(t,s2f1,'r')
xlim([0 10])
grid on
xlabel('Time [s]')
ylabel('Normalized Signal Amplitude')
legend('ECG','Blood pulse')
title('ECG and BP after FIR filtering')
subplot(212)
plot(lags1/fs,Rxy1)
xlabel('${\tau}$ [s]')
ylabel('Cross-correlation')
title(['${\tau_1}$ = ' num2str(tau1)])
% IIR
figure;
subplot(211)
plot(t,s1f2);
hold on
plot(t,s2f2,'r')
xlim([0 10])
grid on
xlabel('Time [s]')
ylabel('Normalized Signal Amplitude')
legend('ECG','Blood pulse')
title('ECG and BP after FIR filtering')
subplot(212)
plot(lags1/fs,Rxy2)
xlabel('${\tau}$ [s]')
ylabel('Cross-correlation')
title(['${\tau_2}$ = ' num2str(tau2)])

