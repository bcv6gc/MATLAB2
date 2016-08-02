% process_stripline
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
material_width = 20e-3;
%%
air_file = 'Calibrated_coax_air-7-28-16.s2p';
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

medium_file = 'Calibrated_coax_20mmHDPE-7-28-16.s2p';
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
%
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
s11=filtered_med11./filtered_air11.*exp(-1i*beta*material_width);
s21=filtered_med21./filtered_air21.*exp(-1i*beta*material_width);
s12=filtered_med12./filtered_air12.*exp(-1i*beta*material_width);
freq2 = frequency*1e9;
erx = zeros(size(frequency));
for i=1:length(freq2)
    f=freq2(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,material_width,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
end
figure(5)
plot(frequency,real(erx),frequency,imag(erx))
xlabel('Frequency (GHz)')
title('Complex Permittivity 20mm HDPE Sample')
legend('Real(\epsilon_r)','Imag(\epsilon_r)')