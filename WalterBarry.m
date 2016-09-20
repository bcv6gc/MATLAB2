% code based on Walter Barry paper for stripline, is effective for coax
% airlines as well.
%{
close all
clc
clear
%}
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
material_width = 20e-3;
device_length = 50e-3;
epsT = 2.4;%5 + 0.1*1i;
muT = 1;%2+ 0.1*1i;
l = (device_length + 8.8e-3 - material_width)/2;
t = material_width;
%%
airFile = 'coax_50mm_air_9-15.s2p';
filelength = 809;
fftlength = 801;
%[a11,a21,a12,a22,frequency] = s2pToComplexSParam(airFile,filelength);
%a11 = (a11 + a22)/2;
%a21 = (a21 + a12)/2;
materialFile = 'coax_50mm_HDPE_20mm_9-15.s2p';
%[s11,s21,s12,s22,frequency] = s2pToComplexSParam_v2(materialFile,filelength);
[s11,s21,s12,s22,frequency] = s2pToComplexSParam(materialFile,filelength);
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2 - pi;
% @@@ if initially greater than pi/2 subtract by pi
s11 = s11.*exp(-1i*fudgeFactor);
s22 = s22.*exp(1i*fudgeFactor);
s21 = (s21 + s12)/2;
%%
beta=2*pi*frequency/c0;
k0 = 2*pi*frequency/c0;
%{
time_air21=ifft(a21,8000);
time_med21=ifft(s21,8000);
[~,c1]=max(abs(time_air21));
time(:,1)=1:1:length(time_air21);
win_length = 25000;
t_win21=exp(-(time-c1).^2/win_length);
time_s21_filter=t_win21.*time_med21;
time_a21_filter= t_win21.*time_air21;
temp_s21=fft(time_s21_filter);
temp_a21=fft(time_a21_filter);
filtered_s21=temp_s21(1:fftlength);
filtered_a21=temp_a21(1:fftlength);
%}
%%
%{
time_air11=ifft(a11,8000);
time_med11=ifft(s11,8000);
[tt,c2]=max(abs(time_med11));
t_win11=exp(-(time-c2).^2/(win_length*2));
time_s11_filter=t_win11.*time_med11;
time_a11_filter=t_win11.*time_air11;
temp_s11=fft(time_s21_filter);
temp_a11=fft(time_a11_filter);
filtered_s11=temp_s11(1:fftlength);
filtered_a11=temp_a11(1:fftlength);
%}
%{
figure(5)
plot(t_win11*tt,'g--','linewidth',2)
legend('window')
hold on
plot(time,abs(time_air11),time,abs(time_med11))
legend('window','air','material')
xlim([(c1 - 1000) (c1 + 1000)])
title('S11 Time gating based on MUT')
xlabel('Time Position')
%}
%%
%filtered_s11=filtered_s11./filtered_a11;
%filtered_s21 = filtered_s21./filtered_a21.*exp(-1i*beta*material_width);
arg = (exp(-1i*4*k0*l) + s21.^2 - s11.^2)./(2*exp(-1i*2*k0*l).*s21);
%filt_arg = (exp(-1i*4*k0*l) + filtered_s21.^2 - filtered_s11.^2)./(2*exp(-1i*2*k0*l).*filtered_s21);
%theta = atan(imag(arg + sqrt(arg.^2 - 1))./real(arg + sqrt(arg.^2 - 1)));
theta = atan2(imag(arg + sqrt(arg.^2 - 1)),real(arg + sqrt(arg.^2 - 1)));
%filt_theta = atan(imag(filt_arg + sqrt(filt_arg.^2 - 1))./real(filt_arg + sqrt(filt_arg.^2 - 1)));
%g = sqrt(real(arg + sqrt(arg.^2 - 1)).^2 + imag(arg + sqrt(arg.^2 - 1)).^2);
g = abs(arg + sqrt(arg.^2 - 1));
%filt_g = sqrt(real(filt_arg + sqrt(filt_arg.^2 - 1)).^2 + imag(filt_arg + sqrt(filt_arg.^2 - 1)).^2);
%kt = theta + 1i*log(g); %@@@ made change, not quite sure of
kt = acos(arg);
%%
theoryKt = k0*sqrt(epsT*muT)*t;
[theory11,theory12,theory21,theory22] = generateSParamters(epsT,muT,t,frequency);
%[theory11,theory12] = generateSParamters(epsT,muT,t,frequency);
t11 = theory11.*exp(-1i*2*k0*l);
t21 = theory21.*exp(-1i*2*k0*l);
tArg = (exp(-1i*4*k0*l) + t21.^2 - t11.^2)./(2*exp(-1i*2*k0*l).*t21);
tTheta = atan2(imag(tArg + sqrt(tArg.^2 - 1)),real(tArg + sqrt(tArg.^2 - 1)));
tG = abs(tArg + sqrt(tArg.^2 - 1));
%tKt = tTheta + 1i*tG;
tKt = acos(tArg);
%
figure;
subplot(221)
yyaxis left
plot(frequency/1e9,unwrap(angle(s11)),frequency/1e9, unwrap(angle(t11)))
ylabel('Phase')
yyaxis right
plot(frequency/1e9,(unwrap(angle(s11))- unwrap(angle(t11)))./pi)
ylim([-2 2])
xlabel('Frequency')
ylabel('Offset \pi')
legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('S11 Phase')
%xlim([1 10])
grid on
subplot(222)
yyaxis left
plot(frequency/1e9,unwrap(angle(s21)),frequency/1e9, unwrap(angle(t21)))
ylabel('Phase')
yyaxis right
plot(frequency/1e9,(unwrap(angle(s21))- unwrap(angle(t21)))/pi)
ylim([-2 2])
xlabel('Frequency')
ylabel('Offset \pi')
xlabel('Frequency')
legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('S21 Phase')
%xlim([1 10])
grid on
subplot(223)
plot(frequency/1e9,abs(s11),frequency/1e9, abs(t11))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('S11 Magnitude')
%xlim([1 10])
grid on
subplot(224)
plot(frequency/1e9,abs(s21),frequency/1e9, abs(t21))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('S21 Magnitude')
%xlim([1 10])
grid on
%}

expanded_R = s11./(exp(-1i*2*k0*l) - s21.*exp(-1i*kt));
expanded_epsilon = kt./(t*k0).*(1 - expanded_R)./(1 + expanded_R);
expanded_mu = kt./(t*k0).*(1 + expanded_R)./(1 - expanded_R);

expanded_Rt = t11./(exp(-1i*2*k0*l) - t21.*exp(-1i*tKt));
expanded_epsilont = tKt./(t*k0).*(1 - expanded_Rt)./(1 + expanded_Rt);
expanded_mut = tKt./(t*k0).*(1 + expanded_Rt)./(1 - expanded_Rt);

%%
%
figure;
subplot(221)
yyaxis left
plot(frequency/1e9, abs(theoryKt), frequency/1e9, abs(kt), frequency/1e9, abs(tKt))
ylabel('Magnitude')
yyaxis right
plot(frequency/1e9, angle(theoryKt), frequency/1e9, angle(kt), frequency/1e9, angle(tKt))
xlabel('frequency (GHz)')
ylabel('Phase')
legend('theory','experiment','theory derived')
title('Propagation Constant X material thickness (kt)')
grid on
subplot(222)
plot(frequency/1e9, abs(expanded_R), frequency/1e9, abs(expanded_Rt))
%ylim([0 10])
xlabel('frequency (GHz)')
ylabel('Magnitude')
legend('experiment','theory derived')
title('Reflection Coefficient')
%ylim([0 5])
grid on
subplot(223)
plot(frequency/1e9, real(expanded_epsilon), frequency/1e9, imag(expanded_epsilon)...
    , frequency/1e9, real(expanded_epsilont), frequency/1e9, imag(expanded_epsilont))
xlabel('frequency (GHz)')
ylabel('Magnitude')
legend('\epsilon\prime', '\epsilon\prime\prime','theory \epsilon\prime',...
    'theory \epsilon\prime\prime')
title('Permittivity')
ylim([-5 5])
grid on
subplot(224)
plot(frequency/1e9, real(expanded_mu), frequency/1e9, imag(expanded_mu),...
    frequency/1e9, real(expanded_mut), frequency/1e9, imag(expanded_mut))
xlabel('frequency (GHz)')
ylabel('Magnitude')
ylim([-5 5])
legend('\mu\prime', '\mu\prime\prime','theory \mu\prime', 'theory \mu\prime\prime')
title('Permeability')
grid on
%}