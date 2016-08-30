% code based on Walter Barry paper for stripline, is effective for coax
% airlines as well.
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
material_width = 6.6e-3;
device_length = 50e-3;
epsT = 2.4;%5 + 0.1*1i;
muT = 1;%2+ 0.1*1i;
l = device_length;
t = material_width;
%%
airFile = 'Coax75mm_air_6-22.s2p';
filelength = 209;
[a11,a21,a12,a22,frequency] = s2pToComplexSParam(airFile,filelength);
a11 = (a11 + a22)/2;
a21 = (a21 + a12)/2;
materialFile = 'Coax75mm_10mm_hdpe_6-22.s2p';
[s11,s21,s12,s22,~] = s2pToComplexSParam(materialFile,filelength);
s11 = (s11 + s22)/2;
s21 = (s21 + s12)/2;
%%
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
filtered_s21=temp_s21(1:201);
filtered_a21=temp_a21(1:201);
%%
%
time_air11=ifft(a11,8000);
time_med11=ifft(s11,8000);
[tt,c2]=max(abs(time_med11));
t_win11=exp(-(time-c2).^2/(win_length*2));
time_s11_filter=t_win11.*time_med11;
time_a11_filter=t_win11.*time_air11;
temp_s11=fft(time_s21_filter);
temp_a11=fft(time_a11_filter);
filtered_s11=temp_s11(1:201);
filtered_a11=temp_a11(1:201);

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
beta=2*pi*frequency/c0;
%filtered_s11=filtered_s11./filtered_a11;
%filtered_s21 = filtered_s21./filtered_a21.*exp(-1i*beta*material_width);
k0 = 2*pi*frequency/c0;
arg = (exp(-1i*4*k0*l) + s21.^2 - s11.^2)./(2*exp(-1i*2*k0*l).*s21);
filt_arg = (exp(-1i*4*k0*l) + filtered_s21.^2 - filtered_s11.^2)./(2*exp(-1i*2*k0*l).*filtered_s21);
theta = atan(imag(arg + sqrt(arg.^2 - 1))./real(arg + sqrt(arg.^2 - 1)));
filt_theta = atan(imag(filt_arg + sqrt(filt_arg.^2 - 1))./real(filt_arg + sqrt(filt_arg.^2 - 1)));
g = sqrt(real(arg + sqrt(arg.^2 - 1)).^2 + imag(arg + sqrt(arg.^2 - 1)).^2);
filt_g = sqrt(real(filt_arg + sqrt(filt_arg.^2 - 1)).^2 + imag(filt_arg + sqrt(filt_arg.^2 - 1)).^2);
kt = theta + 1i*g;
filt_kt = filt_theta + 1i*filt_g;
theoryKt = k0*sqrt(epsT*muT)*t;
[theory11,theory12,theory21,theory22] = generateSParamters(epsT,muT,t,frequency);
%
figure;
subplot(211)
plot(frequency/1e9,abs(s11),frequency/1e9, abs(theory11))%,frequency/1e9, abs(filtered_s11))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory')%,'filtered')
title('Reflections')
xlim([1 10])
grid on
subplot(212)
plot(frequency/1e9,abs(s21),frequency/1e9,abs(theory21))%,frequency/1e9,abs(filtered_s21))
xlabel('Frequency')
ylabel('Magnitude')
legend('measured', 'theory')%,'filtered')
title('Transmission')
xlim([1 10])
grid on
%}
expanded_R = s11./(exp(-1i*2*k0*l) - s21.*exp(-1i*kt));
expanded_epsilon = kt./(t*k0).*(1 - expanded_R)./(1 + expanded_R);
expanded_mu = kt./(t*k0).*(1 + expanded_R)./(1 - expanded_R);

filt_R = filtered_s11./(exp(-1i*2*k0*l) - filtered_s21.*exp(-1i*filt_kt));
filt_epsilon = filt_kt./(t*k0).*(1 - filt_R)./(1 + filt_R);
filt_mu = filt_kt./(t*k0).*(1 + filt_R)./(1 - filt_R);
%%
figure;
subplot(311)
plot(frequency/1e9, real(theoryKt), frequency/1e9, imag(kt))%, frequency/1e9, imag(filt_kt))
xlabel('frequency (GHz)')
ylabel('Magnitude')
legend('theory','experiment')%,'filtered')
title('Propagation Constant X material thickness (kt)')
grid on
subplot(312)
plot(frequency/1e9, real(expanded_epsilon), frequency/1e9, imag(expanded_epsilon))%, frequency/1e9, real(filt_epsilon), frequency/1e9, imag(filt_epsilon))
xlabel('frequency (GHz)')
ylabel('Magnitude')
legend('\epsilon\prime', '\epsilon\prime\prime')%,'filtered \epsilon\prime', 'filtered \epsilon\prime\prime')
title('Permittivity')
grid on
subplot(313)
plot(frequency/1e9, real(expanded_mu), frequency/1e9, imag(expanded_mu))%, frequency/1e9, real(filt_mu), frequency/1e9, imag(filt_mu))
xlabel('frequency (GHz)')
ylabel('Magnitude')
legend('\mu\prime', '\mu\prime\prime')%,'filtered \mu\prime', 'filtered \mu\prime\prime')
title('Permeability')
grid on
