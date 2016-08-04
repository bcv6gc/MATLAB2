air_file = '7-14-air.s2p';
mut_file = '7-14-thick.s2p';
epsilon = 2.4;
mu = 1;
thickness = 20e-3;

[a11,a21,a12,a22,frequency] = s2pToComplexSParam(air_file,209);
[m11,m21,m12,m22,~] = s2pToComplexSParam(mut_file,209);
lengthofdata = length(frequency);
lengthoffft = 8000;
time_air11=ifft(a11,lengthoffft);
time_air21=ifft(a21,lengthoffft);
time_air12=ifft(a12,lengthoffft);
time_air22=ifft(a22,lengthoffft);

time_mut11=ifft(m11,lengthoffft);
time_mut21=ifft(m21,lengthoffft);
time_mut12=ifft(m12,lengthoffft);
time_mut22=ifft(m22,lengthoffft);
%% Time gating
[tt,c1]=max(abs(time_air21));
t=zeros(length(time_air21),1);
t(:,1)=1:1:length(t);
win_length = 250000;
t_win=exp(-(t-c1).^2/win_length);
%{
figure(2)
plot(t,t_win,'k--','linewidth',2)
hold on
plot(t,abs(time_air11)/max(abs(time_air11)),t,abs(time_air21)/max(abs(time_air21)))
legend('window','air11','air21')
xlim([(c1 - 1000) (c1 + 1000)])
%}
time_air11_filter=t_win.*time_air11;
time_air21_filter=t_win.*time_air21;
time_air12_filter=t_win.*time_air12;
time_air22_filter=t_win.*time_air22;
time_med11_filter=t_win.*time_mut11;
time_med21_filter=t_win.*time_mut21;
time_med12_filter=t_win.*time_mut12;
time_med22_filter=t_win.*time_mut22;

temp_air11=fft(time_air11_filter);
temp_air21=fft(time_air21_filter);
temp_air12=fft(time_air12_filter);
temp_air22=fft(time_air22_filter);

temp_med11=fft(time_med11_filter);
temp_med21=fft(time_med21_filter);
temp_med12=fft(time_med12_filter);
temp_med22=fft(time_med22_filter);

filtered_air11=temp_air11(1:lengthofdata);
filtered_air21=temp_air21(1:lengthofdata);
filtered_air12=temp_air12(1:lengthofdata);
filtered_air22=temp_air22(1:lengthofdata);
filtered_med11=temp_med11(1:lengthofdata);
filtered_med21=temp_med21(1:lengthofdata);
filtered_med12=temp_med12(1:lengthofdata);
filtered_med22=temp_med22(1:lengthofdata);
beta=2*pi*frequency/c0;
s11=filtered_med11./filtered_air11.*exp(-1i*beta*thickness);
s21=filtered_med21./filtered_air21.*exp(-1i*beta*thickness);
s12=filtered_med12./filtered_air12.*exp(-1i*beta*thickness);
s22=filtered_med22./filtered_air22.*exp(-1i*beta*thickness);

[theory11,theory21,theory12,theory22] = generateSParamters(epsilon,mu,thickness,frequency);
%[theory11,theory12] = generateSParamters2(epsilon,mu,thickness,frequency);
figure
subplot(2,2,1)
%yyaxis left
plot(frequency/1e9, abs(a11),frequency/1e9, abs(filtered_air11))%,frequency/1e9, abs(s11))
xlabel('frequency')
%legend('measured', 'filtered','final')
title('Air S11')
grid on
subplot(2,2,2)
%yyaxis left
plot(frequency/1e9, abs(m11),frequency/1e9, abs(filtered_med11))%,frequency/1e9, angle(s11))
xlabel('frequency')
legend('measured', 'filtered','Location','eastoutside')
title('HDPE S11')
grid on
subplot(2,2,3)
%yyaxis left
plot(frequency/1e9, abs(a12),frequency/1e9, abs(filtered_air12))%,frequency/1e9, abs(s12))
xlabel('frequency')
title('Air S12')
grid on
subplot(2,2,4)
%yyaxis left
plot(frequency/1e9, abs(m12),frequency/1e9, abs(filtered_med12))%,frequency/1e9, abs(s12))
legend('measured', 'filtered','Location','eastoutside')
xlabel('frequency')
title('HDPE S12')
grid on