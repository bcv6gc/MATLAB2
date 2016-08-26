% code based on Walter Barry paper for stripline, is effective for coax
% airlines as well.
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
material_width = 10e-3;
t = material_width;
device_length = 75e-3;
l = device_length;
%%
airFile = 'Coax75mm_air_6-22.s2p';
filelength = 209;
[a11,a21,a12,a22,frequency] = s2pToComplexSParam(airFile,filelength);
materialFile = 'Coax75mm_10mm_hdpe_6-22.s2p';
[s11,s21,s12,s22,~] = s2pToComplexSParam(airFile,filelength);
k0 = 2*pi*frequency*c0;
arg = (exp(-1i*4*k0*l) + s12.^2 - s11.^2)./(2*exp(-1i*2*k0*l).*s12);
naiveKt = acos(arg);
theta = atan(imag(arg + sqrt(arg.^2 - 1))./real(arg + sqrt(arg.^2 + 1)));
g = sqrt(real(arg + sqrt(arg.^2 - 1)).^2 + imag(arg + sqrt(arg.^2 - 1)).^2);
otherKt = theta + 1i*g;
theoryK = k0*sqrt(2.4);
%
subplot(211)
plot(frequency, real(otherKt)/t, frequency, real(naiveKt)/t, frequency, theoryK)
xlabel('Frequency')
ylabel('Magnitude')
title('Real k')
legend('expanded','naive')
subplot(212)
plot(frequency, imag(otherKt)/t, frequency, imag(naiveKt)/t, [frequency(1) frequency(end)], [0 0])
xlabel('Frequency')
ylabel('Magnitude')
title('Imag k')
legend('expanded','naive')
%}
R = s11./(exp(-1i*2*k0*l) - s12.*exp(-1i*naiveKt));
epsilon = naiveKt./(t*k0).*(1 - R)./(1 + R);
mu = naiveKt./(t*k0).*(1 + R)./(1 - R);
%%
figure
subplot(211)
plot(frequency, real(epsilon), frequency, imag(epsilon))
xlabel('Frequency')
ylabel('Magnitude')
title('Complex Permittivity')
legend('real \epsilon','imaginary \epsilon')
subplot(212)
plot(frequency, real(mu), frequency, imag(mu))
xlabel('Frequency')
ylabel('Magnitude')
title('Complex Permeability')
legend('real \mu','imaginary \mu')