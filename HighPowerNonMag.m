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
    case {'coax75','COAX75'}
        device_length = 50e-3;
end
%%
if strcmpi(plots,'all')
    plots = {'perms','params','debug'};
end
%%
% Air measurement
[a11,a21,a_frequency] = s2pToComplexSParam_v4(airFile);
ak0 = 2*pi*a_frequency/c0;
correction_length = device_length + median(unwrap(angle(a21))./ak0);
l = (device_length - correction_length - material_width)/2;
theory_l = (device_length - material_width)/2;
t = material_width;
%%
[s11,s21,~] = s2pToComplexSParam_v4(materialFile);
[s22,s12,m_frequency] = s2pToComplexSParam_v4(materialFile2);
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2;
meanFudge = mean(fudgeFactor);
if (meanFudge > pi)
    n = floor(meanFudge/pi);
    if (mean(unwrap(angle(s11))) > mean(unwrap(angle(s22))))
        fudgeFactor = (unwrap(angle(s11)) + 2*n*pi  - unwrap(angle(s22)))/2;
    elseif(mean(unwrap(angle(s22))) > mean(unwrap(angle(s11))))
        fudgeFactor = (unwrap(angle(s11)) - 2*n*pi  - unwrap(angle(s22)))/2;
    end
end
s11 = s11.*exp(1i*fudgeFactor);
s22 = s22.*exp(-1i*fudgeFactor);
% The above corrections are sparam*offset due to connectors * offset from
% directional coupler * offset from reflect standard used to correct
m11 = (s11 + s22)/2;
m21 = s21;
m12 = s12;
k0 = 2*pi*m_frequency/c0;
% Get material data, electrically center the material in the device
%{
[m11,m21,~] = s2pToComplexSParam_v4(materialFile);
[~,m12,m_frequency] = s2pToComplexSParam_v4(materialFile2);
m11 = m11*10^(-5.04);
k0 = 2*pi*m_frequency/c0;
%}
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
time_air21=ifft(a21,8000);
time_med21=ifft(m21,8000);
time_med12=ifft(m12,8000);
%% Time gating
[tt,c1]=max(abs(time_air21));
t=zeros(length(time_air21),1);
t(:,1)=1:1:length(t);
win_length = 10000;
t_win=exp(-(t-c1).^2/win_length);
%{
figure(2)
plot(t_win*tt,'g--','linewidth',2)
hold on
plot(t,abs(time_air21),t,abs(time_med21)/10)
legend('window','air21','mat21')
xlim([(c1 - 1000) (c1 + 1000)])
%}
time_air21_filter=t_win.*time_air21;
time_med21_filter=t_win.*time_med21;
time_med12_filter=t_win.*time_med12;

temp_air21=fft(time_air21_filter);
temp_med21=fft(time_med21_filter);
temp_med12=fft(time_med12_filter);

filtered_air21=temp_air21(1:length(m_frequency));
filtered_med21=temp_med21(1:length(m_frequency));
filtered_med12=temp_med12(1:length(m_frequency));

s11=m11-a11;
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
    %tt = fsolve(@(xx) get_s21v3(xx,f,material_width,s11(i),s21(i),s12(i),s11(i)),[2.5;0]);
    tt = fsolve(@(xx) get_s21v2(xx,f,material_width,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
end
%{
figure(5)
plot(m_frequency/1e9,real(erx),m_frequency/1e9,imag(erx))
xlabel('Frequency (GHz)')
ylabel('Relative Permittivity')
title(sprintf('%s (%0.2g mm width) Permittivity',material,material_width*1e3))
legend('Real(\epsilon_r)','Imag(\epsilon_r)')
legend('boxoff')
grid on
%}
results.frequency = m_frequency;
results.epsilon = erx;

%%
if any(strcmpi(plots,'debug'))
    figure;
    subplot(221)
    %yyaxis left
    plot(m_frequency/1e9,abs(a11),m_frequency/1e9,abs(m11))
    ylabel('Magnitude')
    %yyaxis right
    %plot(m_frequency/1e9,unwrap(angle(s11)))
    %ylabel('Measured Phase')
    xlabel('Frequency')
    legend('air','s11 w/ mut','Location','best')
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
    plot(m_frequency/1e9,abs(m11))
    xlabel('Frequency')
    ylabel('Magnitude')
    yyaxis right
    plot(m_frequency/1e9,abs(s11))
    ylabel('Magnitude')
    legend('medium','corrected','Location','best')%,'Orientation','horizontal')
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
end