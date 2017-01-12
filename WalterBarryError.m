eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
numFrequency = 1e4;
frequency = linspace(1,18,numFrequency)*1e9;%*exp(1)/2.7;
numError = 1e3;
error = linspace(1e-6,1e-3,numError);%*pi/3;
k0 = 2*pi*frequency/c0;
device_length = 0.05;
material_width = 0.001;
permittivity = 2.4;
permeability = 1;
[t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,frequency);
t = material_width;
l = device_length;
e21 = t21;
epsilonErr = zeros(numError,numFrequency);
muErr = epsilonErr;

%%
for i=1:numError
    e11 = t11.*exp(1i.*error(i)*k0);
    arg = (exp(-1i*4*k0*l) + t21.^2 - t11.^2)./(2*exp(-1i*2*k0*l).*t21);
    errArg = (exp(-1i*4*k0*l) + e21.^2 - e11.^2)./(2*exp(-1i*2*k0*l).*e21);
    kt = acos(arg);
    errKt = acos(errArg);
    R = t11./(exp(-1i*2*k0*l) - t21.*exp(-1i*kt));
    errR = e11./(exp(-1i*2*k0*l) - e21.*exp(-1i*kt));
    epsilon = kt./(t*k0).*(1 - R)./(1 + R);
    errEpsilon = errKt./(t*k0).*(1 - errR)./(1 + errR);
    mu = kt./(t*k0).*(1 + R)./(1 - R);
    errMu = errKt./(t*k0).*(1 + errR)./(1 - errR);
    %epsilonErr(i) = min((epsilon - errEpsilon)./epsilon);
    epsilonErr(i,:) = (epsilon - errEpsilon)./epsilon;
    %muErr(i) = min((mu - errMu)./mu);
    muErr(i,:) = (mu - errMu)./mu;
end
figure;
contour3(frequency/1e9,error*100,real(epsilonErr));
xlabel('frequency (GHz)')
ylabel('shift (cm)')
title('\epsilon percent error')
colorbar
figure
contour3(frequency/1e9,error*100,real(muErr));
title('\mu percent error')
xlabel('frequency (GHz)')
ylabel('shift (cm)')
colorbar