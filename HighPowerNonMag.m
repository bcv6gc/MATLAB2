function results = HighPowerNonMag(device,material,material_width,airFile,materialFile,materialFile2,plots)
% constants
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
%%
% device
switch device
    case {'stripline', 'STRIPLINE', 'Stripline', 'strip-line', 'Strip-line'}
        device_length = 120e-3;
    case {'coax','COAX','airline'}
        device_length = 50e-3;
end
%%
if strcmpi(plots,'all')
    plots = {'perms','params','debug'};
end
%%
% Air measurement
[a11,a21,~] = s2pToComplexSParam_v4(airFile);

%%
% Get material data, electrically center the material in the device
[m11,m21,~] = s2pToComplexSParam_v4(materialFile);
[~,m12,m_frequency] = s2pToComplexSParam_v4(materialFile2);
k0 = 2*pi*m_frequency/c0;
%%
% load material file if it exists
matfiles = dir(sprintf('%s\\Materials\\%s*.dat',pwd));
matfile = matfiles(~cellfun(@isempty,regexpi({matfiles.name}, sprintf('%s*',material),'match')));
if length(matfile) == 1
    data = xlsread(sprintf('%s\\Materials\\%s',pwd,matfile.name),'Sheet1');
    t_frequency = data(:,1)*1e9;
    permittivity = data(:,2) - 1i*data(:,3);
    permeability = data(:,4) - 1i*data(:,5);
    [t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
else
    if strcmpi(material,'hdpe')
        permittivity = 2.4; permeability = 1;
        [t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,m_frequency);
    elseif strcmpi(material, 'wax')
        permittivity = 2.1; permeability = 1;
        [t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,m_frequency);
    else
        permittivity = [];
        t11 = []; t21 = [];
    end
    t_frequency = m_frequency;
end
%%
%
time_air11=ifft(a11,8000);
time_air21=ifft(a21,8000);
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
plot(t,abs(time_air21),t,abs(time_med21)/10)
legend('air','material')
xlim([(c1 - 1000) (c1 + 1000)])
%
time_air11_filter=t_win.*time_air11;
time_air21_filter=t_win.*time_air21;
time_med11_filter=t_win.*time_med11;
time_med21_filter=t_win.*time_med21;
time_med12_filter=t_win.*time_med12;

temp_air11=fft(time_air11_filter);
temp_air21=fft(time_air21_filter);
temp_med11=fft(time_med11_filter);
temp_med21=fft(time_med21_filter);
temp_med12=fft(time_med12_filter);

filtered_air11=temp_air11(1:length(m_frequency));
filtered_air21=temp_air21(1:length(m_frequency));
filtered_med11=temp_med11(1:length(m_frequency));
filtered_med21=temp_med21(1:length(m_frequency));
filtered_med12=temp_med12(1:length(m_frequency));

s11=filtered_med11./filtered_air11.*exp(-1i*k0*material_width);
s21=filtered_med21./filtered_air21.*exp(-1i*k0*material_width);
s12=filtered_med12./filtered_air21.*exp(-1i*k0*material_width);
%{
s11=m11./a11.*exp(-1i*k0*material_width);
s21=m21./a21.*exp(-1i*k0*material_width);
s12=m12./a21.*exp(-1i*k0*material_width);
%}
erx = zeros(size(m_frequency));
for i=1:length(m_frequency)
    f=m_frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,material_width,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
end
figure(5)
plot(m_frequency,real(erx),m_frequency,imag(erx))
xlabel('Frequency (GHz)')
title('Coax Airline - 5mm HDPE Sample')
legend('Real(\epsilon_r)','Imag(\epsilon_r)')
legend('boxoff')
grid on
results.frequency = m_frequency;
results.epsilon = erx;

%%
if any(strcmpi(plots,'debug'))
    figure;
    subplot(221)
    %yyaxis left
    plot(m_frequency/1e9,unwrap(angle(t11)),m_frequency/1e9,unwrap(angle(s11)))
    ylabel('Phase')
    %yyaxis right
    %plot(m_frequency/1e9,unwrap(angle(s11)))
    %ylabel('Measured Phase')
    xlabel('Frequency')
    legend('theory','measured','Location','best')
    %legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S11 Phase',material,material_width*1e3))
    grid on
    subplot(222)
    %yyaxis left
    plot(m_frequency/1e9,unwrap(angle(t21)),m_frequency/1e9,unwrap(angle(s21)),m_frequency/1e9,unwrap(angle(s12)))
    ylabel('Phase')
    %yyaxis right
    %plot(m_frequency/1e9,unwrap(angle(s11))./k0 - correction_length + device_length)
    %ylabel('Offset (m)')
    xlabel('Frequency')
    legend('theory', 'measured','Location','best')%,'Orientation','horizontal')
    %legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S21 Phase',material,material_width*1e3))
    grid on
    subplot(223)
    plot(m_frequency/1e9,abs(t11) ,m_frequency/1e9, abs(s11))
    xlabel('Frequency')
    ylabel('Magnitude')
    legend('theory','measured','Location','best')%,'Orientation','horizontal')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S11 Magnitude',material,material_width*1e3))
    grid on
    subplot(224)
    plot(m_frequency/1e9,abs(t21) ,m_frequency/1e9, abs(s21))
    xlabel('Frequency')
    ylabel('Magnitude')
    legend('theory','measured','Location','best')%,'Orientation','horizontal')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S21 Magnitude',material,material_width*1e3))
    grid on
end
%%
if any(strcmpi(plots,'params'))
    figure;
    subplot(221)
    yyaxis left
    plot(m_frequency/1e9,unwrap(angle(s11))- correction_length.*k0)
    ylabel('Phase')
    yyaxis right
    plot(m_frequency/1e9,unwrap(angle(s11))./k0 - correction_length + device_length)
    %ylim([-0.2 0.2])
    ylabel('Offset (m)')
    xlabel('Frequency')
    title(sprintf('%s (%0.2g mm width) S11 Phase',material,material_width*1e3))
    grid on
    subplot(222)
    yyaxis left
    plot(m_frequency/1e9,unwrap(angle(s21)) - correction_length.*k0)
    ylabel('Phase')
    yyaxis right
    plot(m_frequency/1e9,unwrap(angle(s21))./k0 - correction_length + device_length)
    %ylim([-0.01 0])
    ylabel('Offset (m)')
    xlabel('Frequency')
    xlabel('Frequency')
    %legend('measured', 'theory','Location','best')%,'Orientation','horizontal')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S21 Phase',material,material_width*1e3))
    grid on
    subplot(223)
    plot(m_frequency/1e9,abs(s11))
    xlabel('Frequency')
    ylabel('Magnitude')
    %legend('measured','Location','best')%,'Orientation','horizontal')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S11 Magnitude',material,material_width*1e3))
    grid on
    subplot(224)
    plot(m_frequency/1e9,abs(s21))
    xlabel('Frequency')
    ylabel('Magnitude')
    %legend('measured','Location','best')%,'Orientation','horizontal')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) S21 Magnitude',material,material_width*1e3))
    grid on
end
%%
if any(strcmpi(plots,'perms'))
    figure;
    subplot(221)
    yyaxis left
    plot(m_frequency/1e9, abs(kt), t_frequency/1e9, abs(tKt))
    ylabel('Magnitude')
    yyaxis right
    plot(m_frequency/1e9, angle(kt), t_frequency/1e9, angle(tKt))
    xlabel('Frequency (GHz)')
    ylabel('Phase')
    legend('measured','theory','Location','best')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) kt',material,material_width*1e3))
    grid on
    subplot(222)
    plot(m_frequency/1e9, real(R),m_frequency/1e9, real(Rt))
    xlabel('Frequency (GHz)')
    ylabel('Magnitude')
    legend('measured','theory','Location','best')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) Reflection Coeff.',material,material_width*1e3))
    ylim([-1 1])
    grid on
    subplot(223)
    plot(m_frequency/1e9, real(epsilon), m_frequency/1e9, imag(epsilon),m_frequency/1e9, real(epsilont), m_frequency/1e9, imag(epsilont))
    xlabel('Frequency (GHz)')
    ylabel('Magnitude')
    legend('\epsilon\prime_m', '\epsilon\prime\prime_m','\epsilon\prime_t', '\epsilon\prime\prime_t')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) Permittivity',material,material_width*1e3))
    %ylim([1.5*min(min(real(epsilon)),min(imag(epsilon)))-0.5 1.5*max(max(real(epsilon)),max(imag(epsilon)))+ 0.5])
    grid on
    subplot(224)
    plot(m_frequency/1e9, real(mu), m_frequency/1e9, imag(mu),m_frequency/1e9, real(mut), m_frequency/1e9, imag(mut))
    xlabel('Frequency (GHz)')
    ylabel('Magnitude')
    %ylim([1.5*min(min(real(mu)),min(imag(mu)))- 0.5 1.5*max(max(real(mu)),max(imag(mu))) + 0.5])
    legend('\mu\prime_m', '\mu\prime\prime_m','\mu\prime_t', '\mu\prime\prime_t')
    legend('boxoff')
    title(sprintf('%s (%0.2g mm width) Permeability',material,material_width*1e3))
    grid on
end
end