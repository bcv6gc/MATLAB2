function [complexPermittivity,frequency] = pre_process_jbl(measurement)
%close all
%clearvars -except frequency284 frequency430 HDPE_32_284 LDPE_12_284 LDPE_32_284 HDPE_12_430

%WR430 109.22 x 54.61
%WR284 72.136 x 34.036
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);

%a=109.22e-3; %dimension for WR430
%a=72.136e-3; %dimension for WR284
%lamc=2*a;

dataFile = '021016 Measurements Broad Cal';
%% Material Measurements Pick One Matching the Standard above
if measurement == 1
    thickness= 12e-3;
    width = 70;
    currentMeasurement = 'LDPE 12mm 284';
    phaseMeasured = '1_284_Phase_S%d%d.csv';
    magMeasured = '1_284_MAG_S%d%d.csv';
    standard = 284;
elseif measurement == 2
    thickness= 32e-3;
    width = 70;
    currentMeasurement = 'LDPE 32mm 284';
    phaseMeasured = '2_284_Phase_S%d%d.csv';
    magMeasured = '2_284_MAG_S%d%d.csv';
    standard = 284;
elseif measurement == 3
    thickness= 32e-3;
    width = 70;
    currentMeasurement = 'HDPE 32mm 284';
    phaseMeasured = '3_284_Phase_S%d%d.csv';
    magMeasured = '3_284_MAG_S%d%d.csv';
    standard = 284;
elseif measurement == 4
    thickness= 12e-3;
    width = 99;
    currentMeasurement = 'HDPE 12mm 430';
    phaseMeasured = '1_430_Phase_S%d%d.csv';
    magMeasured = '1_430_MAG_S%d%d.csv';
    standard = 430;
end
if standard == 284
    airStandard = 'AIR 284';
    airPhase = 'AIR_284_Phase_S%d%d.csv';
    airMag = 'AIR_284_MAG_S%d%d.csv';
    lowF = 2.6e9;
    highF = 3.95e9;
    a=72.136e-3; %dimension for WR284
    lamc=2*a;
elseif standard == 430
    airStandard = 'AIR 430 (invalid comments)';
    airPhase = 'AIR_430_Phase_S%d%d.csv';
    airMag = 'AIR_430_MAG_S%d%d.csv';
    lowF = 1.7e9;
    highF = 2.6e9;
    a=109.22e-3; %dimension for WR430
    lamc=2*a;
end
%@@@ file handling assumes you are in the running code in same folder as data 
%% read air measurements
fileAirPhaseS21 = fullfile(pwd,dataFile,airStandard,sprintf(airPhase,2,1));
fileAirMagS21 = fullfile(pwd,dataFile,airStandard,sprintf(airMag,2,1));
%fileAirS1 = fullfile('air_S21.xlsx');
airPhase21Data = csvread(fileAirPhaseS21,9,0);
airMag21Data = csvread(fileAirMagS21,10,0);
%a=importdata('air_S21.xlsx');
[~,lowIndex] = min(abs(airPhase21Data(:,1) - lowF));
[~,highIndex] = min(abs(airPhase21Data(:,1) - highF));
frequency=airPhase21Data(lowIndex:highIndex,1);
omega=2*pi*airPhase21Data(lowIndex:highIndex,1);

hold on
a2=10.^(airMag21Data(lowIndex:highIndex,2)/20);
a3=airPhase21Data(lowIndex:highIndex,2)/180*pi;
s21_a(:,1)=a2.*exp(1i*a3);
figure(1)
plot(frequency/1e9,real(s21_a(:,1)))
hold on
plot(frequency/1e9,imag(s21_a(:,1)))

%a=importdata('air_S11.xlsx');
fileAirPhaseS11 = fullfile(pwd,dataFile,airStandard,sprintf(airPhase,1,1));
fileAirMagS11 = fullfile(pwd,dataFile,airStandard,sprintf(airMag,1,1));
airPhase11Data = csvread(fileAirPhaseS11,9,0);
airMag11Data = csvread(fileAirMagS11,10,0);
hold on
a2=10.^(airMag11Data(lowIndex:highIndex,2)/20);
a3=airPhase11Data(lowIndex:highIndex,2)/180*pi;
s11_a(:,1)=a2.*exp(1i*a3);
%plot(frequency/1e9,real(s11_a(:,1)))
hold on
%plot(frequency/1e9,imag(s11_a(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)
legend('real(L21)','imag(L21)','real(L11)','imag(L11)')
xlabel('frequency (GHz)')
title('Raw air measurements')



%a=importdata('air_S12.xlsx');
fileAirPhaseS12 = fullfile(pwd,dataFile,airStandard,sprintf(airPhase,1,2));
fileAirMagS12 = fullfile(pwd,dataFile,airStandard,sprintf(airMag,1,2));
airPhase12Data = csvread(fileAirPhaseS12,9,0);
airMag12Data = csvread(fileAirMagS12,10,0);
hold on
a2=10.^(airMag12Data(lowIndex:highIndex,2)/20);
a3=airPhase12Data(lowIndex:highIndex,2)/180*pi;
s12_a(:,1)=a2.*exp(1i*a3);
% plot(a.data(:,1)/1e9,real(s12_a(:,1)))
hold on
% plot(a.data(:,1)/1e9,imag(s12_a(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)


%a=importdata('air_S22.xlsx');
fileAirPhaseS22 = fullfile(pwd,dataFile,airStandard,sprintf(airPhase,2,2));
fileAirMagS22 = fullfile(pwd,dataFile,airStandard,sprintf(airMag,2,2));
airPhase22Data = csvread(fileAirPhaseS22,9,0);
airMag22Data = csvread(fileAirMagS22,10,0);
%hold on
a2=10.^(airMag22Data(lowIndex:highIndex,2)/20);
a3=airPhase22Data(lowIndex:highIndex,2)/180*pi;
s22_a(:,1)=a2.*exp(1i*a3);
% plot(a.data(:,1)/1e9,real(s22_a(:,1)))
hold on
% plot(a.data(:,1)/1e9,imag(s22_a(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)




%% read sample measurements
figure(2)
%a=importdata('T_S21.xlsx');
fileMatPhaseS21 = fullfile(pwd,dataFile,currentMeasurement,sprintf(phaseMeasured,2,1));
fileMatMagS21 = fullfile(pwd,dataFile,currentMeasurement,sprintf(magMeasured,2,1));
matPhase21Data = csvread(fileMatPhaseS21,9,0);
matMag21Data = csvread(fileMatMagS21,9,0);
hold on
a2=10.^(matMag21Data(lowIndex:highIndex,2)/20);
a3=matPhase21Data(lowIndex:highIndex,2)/180*pi;
s21_t(:,1)=a2.*exp(1i*a3);
plot(frequency/1e9,real(s21_t(:,1)))
hold on
plot(frequency/1e9,imag(s21_t(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)


%a=importdata('T_S11.xlsx');
fileMatPhaseS11 = fullfile(pwd,dataFile,currentMeasurement,sprintf(phaseMeasured,1,1));
fileMatMagS11 = fullfile(pwd,dataFile,currentMeasurement,sprintf(magMeasured,1,1));
matPhase11Data = csvread(fileMatPhaseS11,9,0);
matMag11Data = csvread(fileMatMagS11,9,0);
hold on
a2=10.^(matMag11Data(lowIndex:highIndex,2)/20);
a3=matPhase11Data(lowIndex:highIndex,2)/180*pi;
s11_t(:,1)=a2.*exp(1i*a3);
%plot(frequency/1e9,real(s11_t(:,1)))
hold on
%plot(frequency/1e9,imag(s11_t(:,1)))


%a=importdata('T_S12.xlsx');
fileMatPhaseS12 = fullfile(pwd,dataFile,currentMeasurement,sprintf(phaseMeasured,1,2));
fileMatMagS12 = fullfile(pwd,dataFile,currentMeasurement,sprintf(magMeasured,1,2));
matPhase12Data = csvread(fileMatPhaseS12,9,0);
matMag12Data = csvread(fileMatMagS12,9,0);
hold on
a2=10.^(matMag12Data(lowIndex:highIndex,2)/20);
a3=matPhase12Data(lowIndex:highIndex,2)/180*pi;
s12_t(:,1)=a2.*exp(1i*a3);
% plot(a.data(:,1)/1e9,real(s12_t(:,1)))
hold on
% plot(a.data(:,1)/1e9,imag(s12_t(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)


%a=importdata('T_S22.xlsx');
fileMatPhaseS22 = fullfile(pwd,dataFile,currentMeasurement,sprintf(phaseMeasured,2,2));
fileMatMagS22 = fullfile(pwd,dataFile,currentMeasurement,sprintf(magMeasured,2,2));
matPhase22Data = csvread(fileMatPhaseS22,9,0);
matMag22Data = csvread(fileMatMagS22,9,0);
hold on
a2=10.^(matMag22Data(lowIndex:highIndex,2)/20);
a3=matPhase22Data(lowIndex:highIndex,2)/180*pi;
s22_t(:,1)=a2.*exp(1i*a3);
% plot(a.data(:,1)/1e9,real(s22_t(:,1)))
hold on
% plot(a.data(:,1)/1e9,imag(s22_t(:,1)))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)
legend('real(T21)','imag(T21)','real(T11)','imag(T11)')
xlabel('frequency (GHz)')
title('Raw sample measurements')







%% Time gating
am=abs(ifft(s21_a(:,1),2001));
[~,c21]=max(am);

am=abs(ifft(s12_a(:,1),2001));
[~,c12]=max(am);

am=abs(ifft(s21_t(:,1),2001));
[~,t21]=max(am);

am=abs(ifft(s12_t(:,1),2001));
[~,t12]=max(am);

% pt_11=filter_sii_gaussian_8001_plot(s11_t,c1m,300);
%
pa_21=filter_sii_gaussian_8001_plot(s21_a,c21,3000);
pt_21=filter_sii_gaussian_8001_plot(s21_t,t21,3000);

pa_12=filter_sii_gaussian_8001_plot(s12_a,c12,3000);
pt_12=filter_sii_gaussian_8001_plot(s12_t,t12,3000);
%}
%{
pa_21=filter_sii_jbl(s21_a,c21,width);
pt_21=filter_sii_jbl(s21_t,t21,width);

pa_12=filter_sii_jbl(s12_a,c12,width);
pt_12=filter_sii_jbl(s12_t,t12,width);
%}
%
figure(3)
plot(frequency/1e9,abs(pa_21(1:length(frequency))))
hold on
plot(frequency/1e9,abs(pt_21(1:length(frequency))))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)
xlabel('frequency (GHz)')
title('Time Gated measurements')
legend('G[L_2_1]','G[T_2_1]')



%waveguide propagation factor in air (no sample)
g0=1i*sqrt(omega.*omega*1*1/c0/c0-2*pi*2*pi/lamc/lamc);

%final calibrated s21 and s12
s21=pt_21(1:length(frequency))./pa_21(1:length(frequency)).*exp(-g0*thickness);
s12=pt_12(1:length(frequency))./pa_12(1:length(frequency)).*exp(-g0*thickness);

figure(4)
plot(frequency/1e9,abs(s21(1:length(frequency))))
hold on
plot(frequency/1e9,abs(s12(1:length(frequency))))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)
xlabel('frequency (GHz)')
title('Calibrated S21 and S12')
legend('S_2_1','S_1_2')

for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21(xx,f,thickness,a,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
    
end

figure(5)
plot(frequency/1e9,real(erx))
hold on
plot(frequency/1e9,imag(erx))
%xlim([1.7 2.6])
xlim([lowF highF]/1e9)
xlabel('frequency (GHz)')
title('Extracted complex relative dielectric permittivity')
legend('Real(\epsilon_r)','Imag(\epsilon_r)')

complexPermittivity = erx;
