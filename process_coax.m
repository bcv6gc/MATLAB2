% process_stripline
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
material_width = 5.1e-3;
material = 'HDPE';
%%
air_file = 'coax_50mm_air_11-7.dat';
[a11,a21,a12,a22,a_frequency] = s2pToComplexSParam_v3(air_file);

medium_file = 'coax_50mm_HDPE_5.10mm_11-7.dat';
[m11,m21,m12,m22,m_frequency] = s2pToComplexSParam_v3(medium_file);

time_air11=ifft(a11,8000);
time_air21=ifft(a21,8000);
time_air12=ifft(a12,8000);
time_med11=ifft(m11,8000);
time_med21=ifft(m21,8000);
time_med12=ifft(m12,8000);
%% Time gating
[tt,c1]=max(abs(time_air21));
t=zeros(length(time_air21),1);
t(:,1)=1:1:length(t);
win_length = 25000;
t_win=exp(-(t-c1).^2/win_length);
%
figure(2)
plot(t_win*tt,'g--','linewidth',2)
hold on
plot(t,abs(time_air21),t,abs(time_med21))
legend('air','material')
xlim([(c1 - 1000) (c1 + 1000)])
%}
time_air11_filter=t_win.*time_air11;
time_air21_filter=t_win.*time_air21;
time_air12_filter=t_win.*time_air12;
time_med11_filter=t_win.*time_med21;
time_med21_filter=t_win.*time_med21;
time_med12_filter=t_win.*time_med12;

temp_air11=fft(time_air11_filter);
temp_air21=fft(time_air21_filter);
temp_air12=fft(time_air12_filter);
temp_med11=fft(time_med11_filter);
temp_med21=fft(time_med21_filter);
temp_med12=fft(time_med12_filter);

fileLen = length(m11);
filtered_air11=temp_air11(1:fileLen);
filtered_air21=temp_air21(1:fileLen);
filtered_air12=temp_air12(1:fileLen);
filtered_med11=temp_med11(1:fileLen);
filtered_med21=temp_med21(1:fileLen);
filtered_med12=temp_med12(1:fileLen);

beta=2*pi*m_frequency/c0;
s11=filtered_med11./filtered_air11.*exp(-1i*beta*material_width);
s21=filtered_med21./filtered_air21.*exp(-1i*beta*material_width);
s12=filtered_med12./filtered_air12.*exp(-1i*beta*material_width);
freq2 = m_frequency;
erx = zeros(size(m_frequency));
for i=1:length(freq2)
    f=freq2(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,material_width,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
end
figure(5)
plot(m_frequency,real(erx),m_frequency,imag(erx))
xlabel('Frequency (GHz)')
title(sprintf('%s (%0.2g mm width) S11 Magnitude',material,material_width*1e3))
legend('Real(\epsilon_r)','Imag(\epsilon_r)')
grid on

figure;
subplot(221)
%yyaxis left
plot(m_frequency/1e9,abs(a11),m_frequency/1e9,abs(filtered_air11))
ylabel('Magnitude')
%yyaxis right
%plot(m_frequency/1e9,unwrap(angle(s11)))
%ylabel('Measured Phase')
xlabel('Frequency')
legend('air','time filt air','Location','best')
legend('boxoff')
title('Air s11 magnitude')
%ylim([0 0.02])
grid on
subplot(222)
%yyaxis left
plot(m_frequency/1e9,abs(a21),m_frequency/1e9,abs(filtered_air21))
ylabel('Magnitude')
%yyaxis right
%plot(m_frequency/1e9,unwrap(angle(s11))./k0 - correction_length + device_length)
%ylabel('Offset (m)')
xlabel('Frequency')
legend( 'air','time filt air','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title('Air s21 magnitude')
grid on
subplot(223)
yyaxis left
plot(m_frequency/1e9,abs(m11),m_frequency/1e9,abs(filtered_med11))
xlabel('Frequency')
ylabel('Magnitude')
yyaxis right
plot(m_frequency/1e9,abs(s11))
ylabel('Magnitude')
legend('medium','medium time filt','corrected','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) S11 Magnitude',material,material_width*1e3))
grid on
subplot(224)
yyaxis left
plot(m_frequency/1e9,abs(m21),m_frequency/1e9,abs(filtered_med21))
xlabel('Frequency')
ylabel('Magnitude')
yyaxis right
plot(m_frequency/1e9,abs(s21))
ylabel('Magnitude')
legend('medium','medium time filt','corrected','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) S21 Magnitude',material,material_width*1e3))
grid on