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
%%
% Data inputs
airFile = 'coax_50mm_air_11-7.dat';
materialFile = 'coax_50mm_100%paraffin-wax_6.44mm_11-7.dat';
filename = 'DD-13490_data';
material_width = 6.44e-3;
material = 'Wax';
%device_length = 120e-3;
device_length = 50e-3;
%%
% use airfile to calibrate the phase and account for connectors
filelength = 303;
[a11,a21,a12,a22,a_frequency] = s2pToComplexSParam_v2(airFile,filelength);
ak0 = 2*pi*a_frequency/c0;
correction_length = device_length + median(unwrap(angle(a21))./ak0);
l = (device_length - correction_length - material_width)/2;
theory_l = (device_length - material_width)/2;
t = material_width;
%%
% get material file and correct for placement in the device

%materialFile = '50mm_coax_5mm_hdpe_10_6.dat';
[s11,s21,s12,s22,m_frequency] = s2pToComplexSParam_v2(materialFile,filelength);
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2;
meanFudge = mean(fudgeFactor);
if (meanFudge > pi)
    n = floor(meanFudge/pi)
    if (mean(unwrap(angle(s11))) > mean(unwrap(angle(s22))))
        fudgeFactor = (unwrap(angle(s11)) - 2*n*pi - unwrap(angle(s22)))/2;
    elseif(mean(unwrap(angle(s22))) > mean(unwrap(angle(s11))))
        fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)) + 2*n*pi)/2;
    end
end
%s11 = s11.*exp(-1i*fudgeFactor - 1i*pi);
s11 = s11.*exp(-1i*fudgeFactor);
s22 = s22.*exp(1i*fudgeFactor);
s21 = (s21 + s12)/2;
%%
%frequency dependent case
%%
%%
%{
load(sprintf('%s\\Materials\\dd13490_data.mat',pwd))
permittivity = real_mittiv - 1i*imag_mittiv;
permeability = real_meab - 1i*imag_meab;
t_frequency = frequency*1e9;
[t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
%}
%%
%{
data = xlsread(sprintf('%s\\Materials\\%s.xlsx',pwd,filename),'Sheet1');
t_frequency = data(:,1)*1e9;
permittivity = data(:,2) - 1i*data(:,3);
permeability = data(:,4) - 1i*data(:,5);
[t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
%}
%static case
%%
%
epsT = 2.1;
permittivity = epsT;
muT = 1;
permeability = muT;
t_frequency = m_frequency;
[t11,t21] = generateSParamters2(epsT,muT,device_length,material_width,t_frequency);
%}
%%
beta=2*pi*m_frequency/c0;
k0 = 2*pi*m_frequency/c0;
tk0 = 2*pi*t_frequency/c0;
%time gating
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
%calculating parameters for epsilon and mu
arg = (exp(-1i*4*k0*l) + s21.^2 - s11.^2)./(2*exp(-1i*2*k0*l).*s21);
kt = acos(arg);
%%
%calculate epsilon and mu for theory values
theoryKt = tk0.*sqrt(permittivity.*permeability).*t;
tArg = (exp(-1i*4*tk0*theory_l) + t21.^2 - t11.^2)./(2*exp(-1i*2*tk0*theory_l).*t21);
tKt = acos(tArg);
%
figure;
subplot(221)
yyaxis left
plot(m_frequency/1e9,unwrap(angle(s11))- correction_length.*k0,t_frequency/1e9, unwrap(angle(t11)))
ylabel('Phase')
yyaxis right
plot(m_frequency/1e9,unwrap(angle(s11))./k0 - correction_length + device_length,t_frequency/1e9, unwrap(angle(t11))./tk0 + device_length)
ylim([-0.2 0.2])
ylabel('Offset (m)')
xlabel('Frequency')
%ylabel('Offset \pi')
%legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title(sprintf('%s (%0.2g mm width) S11 Phase',material,material_width*1e3))
%xlim([1 10])
grid on
subplot(222)
yyaxis left
plot(m_frequency/1e9,unwrap(angle(s21)) - correction_length.*k0,t_frequency/1e9, unwrap(angle(t21)))
ylabel('Phase')
yyaxis right
plot(m_frequency/1e9,unwrap(angle(s21))./k0 - correction_length + device_length,t_frequency/1e9, unwrap(angle(t21))./tk0 + device_length)
ylim([-0.01 0])
ylabel('Offset (m)')
xlabel('Frequency')
%ylabel('Offset \pi')
xlabel('Frequency')
legend('measured', 'theory','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) S21 Phase',material,material_width*1e3))
%xlim([1 10])
grid on
subplot(223)
plot(m_frequency/1e9,abs(s11),t_frequency/1e9, abs(t11))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) S11 Magnitude',material,material_width*1e3))
%xlim([1 10])
grid on
subplot(224)
plot(m_frequency/1e9,abs(s21),t_frequency/1e9, abs(t21))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory','Location','best')%,'Orientation','horizontal')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) S21 Magnitude',material,material_width*1e3))
%xlim([1 10])
grid on
%tightfig;
%}

R = s11./(exp(-1i*2*k0*l) - s21.*exp(-1i*kt));
epsilon = kt./(t*k0).*(1 - R)./(1 + R);
mu = kt./(t*k0).*(1 + R)./(1 - R);

Rt = t11./(exp(-1i*2*tk0*theory_l) - t21.*exp(-1i*tKt));
epsilont = tKt./(t*tk0).*(1 - Rt)./(1 + Rt);
mut = tKt./(t*tk0).*(1 + Rt)./(1 - Rt);

%%
%
figure;
subplot(221)
yyaxis left
plot(t_frequency/1e9, abs(theoryKt), m_frequency/1e9, abs(kt))%, t_frequency/1e9, abs(tKt))
ylabel('Magnitude')
yyaxis right
plot(t_frequency/1e9, angle(theoryKt), m_frequency/1e9, angle(kt))%, t_frequency/1e9, angle(tKt))
xlabel('Frequency (GHz)')
ylabel('Phase')
legend('theory','experiment','Location','best')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) kt',material,material_width*1e3))
%title('Propagation Constant X material thickness (kt)')
grid on
subplot(222)
plot(m_frequency/1e9, real(R), t_frequency/1e9, real(Rt))
%ylim([0 10])
xlabel('Frequency (GHz)')
ylabel('Magnitude')
legend('experiment','theory derived','Location','best')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) Reflection Coeff.',material,material_width*1e3))
%title('Reflection Coefficient')
ylim([-1 1])
grid on
subplot(223)
plot(m_frequency/1e9, real(epsilon), m_frequency/1e9, imag(epsilon)...
    , t_frequency/1e9, real(epsilont), t_frequency/1e9, imag(epsilont))
xlabel('Frequency (GHz)')
ylabel('Magnitude')
legend('\epsilon\prime', '\epsilon\prime\prime','theory \epsilon\prime',...
    'theory \epsilon\prime\prime')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) Permittivity',material,material_width*1e3))
%title('Permittivity')
ylim([1.5*min(min(real(epsilont)),min(imag(epsilont)))-0.5 1.5*max(max(real(epsilont)),max(imag(epsilont)))+ 0.5])
grid on
subplot(224)
plot(m_frequency/1e9, real(mu), m_frequency/1e9, imag(mu),...
    t_frequency/1e9, real(mut), t_frequency/1e9, imag(mut))
xlabel('Frequency (GHz)')
ylabel('Magnitude')
ylim([1.5*min(min(real(mut)),min(imag(mut)))- 0.5 1.5*max(max(real(mut)),max(imag(mut))) + 0.5])
legend('\mu\prime', '\mu\prime\prime','theory \mu\prime', 'theory \mu\prime\prime')
legend('boxoff')
title(sprintf('%s (%0.2g mm width) Permeability',material,material_width*1e3))
%title('Permeability')
grid on

%}