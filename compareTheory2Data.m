%compareTheory2data
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
material_width = 1.78e-3;
device_length = 50e-3;
l = (device_length - material_width)/2;
t = material_width;
%%
%Theoretical values
load(sprintf('%s\\Materials\\dd13490_data.mat',pwd))
permittivity = rs_real_mittiv - 1i*rs_imag_mittiv;
permeability = rs_real_meab - 1i*rs_imag_meab;
[t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,frequency*1e9);
%%
% Measured Values
airFile = 'coax_50mm_air_9-15.s2p';
filelength = 203;
fftlength = 801;
[a11,a21,a12,a22,a_frequency] = s2pToComplexSParam(airFile,filelength);
materialFile = 'coax_50mm_dd13490_1p78mm_9-20_RS.dat';
[s11,s21,s12,s22,m_frequency] = s2pToComplexSParam_v2(materialFile,filelength);
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2;
s11 = s11.*exp(-1i*fudgeFactor);
s22 = s22.*exp(1i*fudgeFactor);
