%Constants
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
eta0 = sqrt(mu0/eps0);
width1 = 0.005; %1/2 cm
width2 = 0.01; % 1 cm
width3 = 0.02; % 2 cm
%% Get data
air_file = 'Brandon(1)emptycoax.s2p';
frequency = dlmread(air_file,' ',9,0,[9 0 209 0])/1e9;
air_m11 = dlmread(air_file,' ',9,1,[9 1 209 1]);
air_p11 = dlmread(air_file,' ',9,2,[9 2 209 2]);
air_m21 = dlmread(air_file,' ',9,3,[9 3 209 3]);
air_p21 = dlmread(air_file,' ',9,4,[9 4 209 4]);
air_m12 = dlmread(air_file,' ',9,5,[9 5 209 5]);
air_p12 = dlmread(air_file,' ',9,6,[9 6 209 6]);
amp21=10.^(air_m21/20);
phase21=unwrap(air_p21/180*pi);
amp12=10.^(air_m12/20);
phase12=unwrap(air_p12/180*pi);
s21_a=amp21.*exp(1i*phase21);
s12_a=amp12.*exp(1i*phase12);

thin_file = 'Brandon(4)thinhdpecoax.s2p';
thin_m11 = dlmread(thin_file,' ',9,1,[9 1 209 1]);
thin_p11 = dlmread(thin_file,' ',9,2,[9 2 209 2]);
thin_m21 = dlmread(thin_file,' ',9,3,[9 3 209 3]);
thin_p21 = dlmread(thin_file,' ',9,4,[9 4 209 4]);
thin_m12 = dlmread(thin_file,' ',9,5,[9 5 209 5]);
thin_p12 = dlmread(thin_file,' ',9,6,[9 6 209 6]);
thin_amp21=10.^(thin_m21/20);
thin_phase21=unwrap(thin_p21/180*pi);
thin_amp12=10.^(thin_m12/20);
thin_phase12=unwrap(thin_p12/180*pi);
s21_thin=thin_amp21.*exp(1i*thin_phase21);
s12_thin=thin_amp12.*exp(1i*thin_phase12);

medium_file = 'Brandon(3)medhdpecoax.s2p';
med_m11 = dlmread(medium_file,' ',9,1,[9 1 209 1]);
med_p11 = dlmread(medium_file,' ',9,2,[9 2 209 2]);
med_m21 = dlmread(medium_file,' ',9,3,[9 3 209 3]);
med_p21 = dlmread(medium_file,' ',9,4,[9 4 209 4]);
med_m12 = dlmread(medium_file,' ',9,5,[9 5 209 5]);
med_p12 = dlmread(medium_file,' ',9,6,[9 6 209 6]);
med_amp21=10.^(med_m21/20);
med_phase21=unwrap(med_p21/180*pi);
med_amp12=10.^(med_m12/20);
med_phase12=unwrap(med_p12/180*pi);
s21_med=med_amp21.*exp(1i*med_phase21);
s12_med=med_amp12.*exp(1i*med_phase12);

thick_file = 'Brandon(2)thickhdpecoax.s2p';
thick_m11 = dlmread(thick_file,' ',9,1,[9 1 209 1]);
thick_p11 = dlmread(thick_file,' ',9,2,[9 2 209 2]);
thick_m21 = dlmread(thick_file,' ',9,3,[9 3 209 3]);
thick_p21 = dlmread(thick_file,' ',9,4,[9 4 209 4]);
thick_m12 = dlmread(thick_file,' ',9,5,[9 5 209 5]);
thick_p12 = dlmread(thick_file,' ',9,6,[9 6 209 6]);
thick_amp21=10.^(thick_m21/20);
thick_phase21=unwrap(thick_p21/180*pi);
thick_amp12=10.^(thick_m12/20);
thick_phase12=unwrap(thick_p12/180*pi);
s21_thick=thick_amp21.*exp(1i*thick_phase21);
s12_thick=thick_amp12.*exp(1i*thick_phase12);

%waveguide propagation factor in air (no sample)
omega21=2*pi*air_p21;
g021=1i*sqrt(omega21.*omega21*1*1/c0/c0);
omega12=2*pi*air_p12;
g012=1i*sqrt(omega12.*omega12*1*1/c0/c0);
time21=abs(ifft(s21_a(:,1),2001));
time12=abs(ifft(s21_med(:,1),2001));

%{
thin_s21=s21_thin.*exp(-g021*width1);
thin_s12=s12_thin.*exp(-g012*width1);
%thin_s21=s21_thin./s21_a.*exp(-g021*width1);
%thin_s12=s12_thin./s12_a.*exp(-g012*width1);
thin_erx = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,width1,thin_s21(i),thin_s12(i)),[1;0]);
    thin_erx(i)=tt(1)+1i*tt(2);
    
end

med_s21=s21_med./s21_a.*exp(-g021*width2);
med_s12=s12_med./s12_a.*exp(-g012*width2);
med_erx = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,width2,med_s21(i),med_s12(i)),[1;0]);
    med_erx(i)=tt(1)+1i*tt(2);
    
end

thick_s21=s21_thick./s21_a.*exp(-g021*width3);
thick_s12=s12_thick./s12_a.*exp(-g012*width3);
thick_erx = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,width3,thick_s21(i),thick_s12(i)),[1;0]);
    thick_erx(i)=tt(1)+1i*tt(2);
    
end
%}
subplot(2,2,1)
plot(frequency, air_m11, frequency, thin_m11, frequency, med_m11, frequency, thick_m11)
%legend({'air','thin','medium','thick'},'Location', 'southeast')
title('Reflection Magnitude')
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
ylim([-70 0])
xlim([0 12])
grid on
subplot(2,2,2)
plot(frequency, (air_p11), frequency, (thin_p11), frequency, (med_p11), frequency, (thick_p11))
%legend({'air','thin','medium','thick'},'Location', 'southeast')
title('Reflection Phase')
xlabel('Frequency (GHz)')
ylabel('Phase (degrees)')
xlim([0 12])
grid on
subplot(2,2,3)
plot(frequency, air_m21, frequency, thin_m21, frequency, med_m21, frequency, thick_m21)
legend({'air','thin','medium','thick'},'Location', 'southwest')
title('Transmission Magnitude')
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
ylim([-7 2])
xlim([0 12])
grid on
subplot(2,2,4)
plot(frequency, (air_p21), frequency, (thin_p21), frequency, (med_p21), frequency, (thick_p21))
%legend({'air','thin','medium','thick'},'Location', 'southwest')
title('Transmission Phase')
xlabel('Frequency (GHz)')
ylabel('Phase (degrees)')
xlim([0 12])
grid on
%set(gca,'fontsize', 12);
figure;
subplot(2,1,1)
plot(real(time21))
subplot(2,1,2)
plot(real(time12))
%{
figure;
subplot(2,1,1)
plot(frequency, real(thick_erx), frequency, real(med_erx), frequency, real(thin_erx))
legend('thick','medium','thin')
title('Real Permittivity')
subplot(2,1,2)
plot(frequency, imag(thick_erx), frequency, imag(med_erx), frequency, imag(thin_erx))
legend('thick','medium','thin')
title('Imaginary   Permittivity')
%}