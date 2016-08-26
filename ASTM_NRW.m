%%
%NRW from ASTM paper
% process_stripline
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
c=1/sqrt(eps0*mu0);
material_width = 10e-3;
d = material_width;
%%
air_file = 'coax60mmAir.s2p';
frequency = dlmread(air_file,' ',9,0,[9 0 209 0])/1e9;
air_mag11 = dlmread(air_file,' ',9,1,[9 1 209 1]);
air_phase11 = dlmread(air_file,' ',9,2,[9 2 209 2]);
air_mag21 = dlmread(air_file,' ',9,3,[9 3 209 3]);
air_phase21 = dlmread(air_file,' ',9,4,[9 4 209 4]);
air_mag12 = dlmread(air_file,' ',9,5,[9 5 209 5]);
air_phase12 = dlmread(air_file,' ',9,6,[9 6 209 6]);
air_mag22 = dlmread(air_file,' ',9,7,[9 7 209 7]);
air_phase22 = dlmread(air_file,' ',9,8,[9 8 209 8]);
air11=complex((10.^(air_mag11/20)).*exp(1i*air_phase11/180*pi));
air21=complex((10.^(air_mag21/20)).*exp(1i*air_phase21/180*pi));
air12=complex((10.^(air_mag12/20)).*exp(1i*air_phase12/180*pi));

medium_file = 'coax60mmHDPE10mm.s2p';
%medium_file = 'Calibrated_coax_5mmCoZn-7-28-16.s2p';
med_mag11 = dlmread(medium_file,' ',9,1,[9 1 209 1]);
med_phase11 = dlmread(medium_file,' ',9,2,[9 2 209 2]);
med_mag21 = dlmread(medium_file,' ',9,3,[9 3 209 3]);
med_phase21 = dlmread(medium_file,' ',9,4,[9 4 209 4]);
med_mag12 = dlmread(medium_file,' ',9,5,[9 5 209 5]);
med_phase12 = dlmread(medium_file,' ',9,6,[9 6 209 6]);
med_mag22 = dlmread(medium_file,' ',9,7,[9 7 209 7]);
med_phase22 = dlmread(medium_file,' ',9,8,[9 8 209 8]);
med11=complex((10.^(med_mag11/20)).*exp(1i*med_phase11/180*pi));
med21=complex((10.^(med_mag21/20)).*exp(1i*med_phase21/180*pi));
med12=complex((10.^(med_mag12/20)).*exp(1i*med_phase12/180*pi));

time_air11=ifft(air11,8000);
time_air21=ifft(air21,8000);
time_air12=ifft(air12,8000);
time_med11=ifft(med11,8000);
time_med21=ifft(med21,8000);
time_med12=ifft(med12,8000);
%% Time gating
[tt,c1]=max(abs(time_air21));
t=zeros(length(time_air21),1);
t(:,1)=1:1:length(t);
win_length = 25000;
t_win=exp(-(t-c1).^2/win_length);
%{
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

filtered_air11=temp_air11(1:201);
filtered_air21=temp_air21(1:201);
filtered_air12=temp_air12(1:201);
filtered_med11=temp_med11(1:201);
filtered_med21=temp_med21(1:201);
filtered_med12=temp_med12(1:201);

beta=2*pi*frequency*1e9/c0;
s11=med11./air11;
s21 = med21./air21.*exp(-1i*beta*material_width);
%s21=filtered_med21./filtered_air21.*exp(-1i*beta*material_width);
%s12=filtered_med12./filtered_air12.*exp(-1i*beta*material_width);
freq2 = frequency*1e9;
xi = (s11.^2 - s21.^2 + 1)./(2*s11);
gamma_minus = xi - sqrt(xi.^2 - 1);
gamma_plus = xi + sqrt(xi.^2 - 1);
gamma = zeros(size(gamma_plus));
gamma(abs(gamma_minus) <= 1) = gamma_minus(abs(gamma_minus) < 1);
gamma(abs(gamma_plus) <= 1) = gamma_plus(abs(gamma_plus) < 1);
trans = (s11 + s21 - gamma)./(1 - (s11 + s21).*gamma);
inverse_square_delta = -(log(1./trans)./(2*pi*material_width)).^2;
inverse_delta = sqrt(inverse_square_delta);
mu = (1+gamma)./(1-gamma).*inverse_delta./sqrt(beta.^2);
epsilon = 4*pi^2.*inverse_square_delta./(mu.*beta.^2);
fs = 14;
figure
subplot(211)
plot(frequency, real(epsilon), frequency, imag(epsilon))
legend('real \epsilon','imaginary \epsilon','Location','northeast')
title('10mm HDPE in 50 mm coax Complex Permittivity')
ax = gca; ax.FontSize = 12;
grid on
%xlim([2 12])
%ylim([-10 10])
subplot(212)
plot(frequency, real(mu), frequency, imag(mu))
legend('real \mu','imaginary \mu','Location','northeast')
title('10mm HDPE in 50 mm coax Complex Permeability')
grid on
bx = gca; bx.FontSize = 12;
%ylim([-1 1])
%xlim([2 12])