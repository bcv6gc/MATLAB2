eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
width1 = 0.2;
width2 = 0.1;
%get air data
air_file = 'Brandon(1)emptystrip.s2p';
frequency = dlmread(air_file,' ',9,0,[9 0 209 0]);
air_m21 = dlmread(air_file,' ',9,3,[9 3 209 3]);
air_p21 = dlmread(air_file,' ',9,4,[9 4 209 4]);
air_m12 = dlmread(air_file,' ',9,5,[9 5 209 5]);
air_p12 = dlmread(air_file,' ',9,6,[9 6 209 6]);
amp21=10.^(air_m21/20);
phase21=air_p21/180*pi;
amp12=10.^(air_m12/20);
phase12=air_p12/180*pi;
s21_a=amp21.*exp(1i*phase21);
s12_a=amp12.*exp(1i*phase12);
%get mut data
thin_file = 'Brandon(3)thinhdpe.s2p';
thin_m21 = dlmread(thin_file,' ',9,3,[9 3 209 3]);
thin_p21 = dlmread(thin_file,' ',9,4,[9 4 209 4]);
thin_m12 = dlmread(thin_file,' ',9,5,[9 5 209 5]);
thin_p12 = dlmread(thin_file,' ',9,6,[9 6 209 6]);
thin_amp21=10.^(thin_m21/20);
thin_phase21=thin_p21/180*pi;
thin_amp12=10.^(thin_m12/20);
thin_phase12=thin_p12/180*pi;
s21_thin=thin_amp21.*exp(1i*thin_phase21);
s12_thin=thin_amp12.*exp(1i*thin_phase12);
%get mut data
thick_file = 'Brandon(2)thickhdpe.s2p';
thick_m21 = dlmread(thick_file,' ',9,3,[9 3 209 3]);
thick_p21 = dlmread(thick_file,' ',9,4,[9 4 209 4]);
thick_m12 = dlmread(thick_file,' ',9,5,[9 5 209 5]);
thick_p12 = dlmread(thick_file,' ',9,6,[9 6 209 6]);
thick_amp21=10.^(thick_m21/20);
thick_phase21=thick_p21/180*pi;
thick_amp12=10.^(thick_m12/20);
thick_phase12=thick_p12/180*pi;
s21_thick=thick_amp21.*exp(1i*thick_phase21);
s12_thick=thick_amp12.*exp(1i*thick_phase12);
%waveguide propagation factor in air (no sample)
omega21=2*pi*air_p21;
g021=1i*sqrt(omega21.*omega21*1*1/c0/c0);
omega12=2*pi*air_p12;
g012=1i*sqrt(omega12.*omega12*1*1/c0/c0);

thin_s21=s21_thin./s21_a.*exp(-g021*width1);
thin_s12=s12_thin./s12_a.*exp(-g012*width1);
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,width1,thin_s21(i),thin_s12(i)),[1;0]);
    thin_erx(i)=tt(1)+1i*tt(2);
    
end

thick_s21=s21_thick./s21_a.*exp(-g021*width2);
thick_s12=s12_thick./s12_a.*exp(-g012*width2);
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,width2,thick_s21(i),thick_s12(i)),[1;0]);
    thick_erx(i)=tt(1)+1i*tt(2);
    
end
figure;
%{
subplot(3,1,1)
yyaxis left
plot(frequency/1e9, 10*log10(abs(thick_s12)),frequency/1e9, 10*log10(abs(thin_s12)))
ylabel('Amplitude (dB)')
hold on
yyaxis right
plot(frequency/1e9, angle(thick_s12),frequency/1e9, angle(thin_s12))
ylabel('Phase (radians)')
grid on
xlabel('frequency (GHz)')
hold off
%legend('Thick HDPE','Thin HDPE')
title('S21')
%}
subplot(2,1,1)
plot(frequency/1e9, real(thick_erx),frequency/1e9, imag(thick_erx),frequency/1e9, real(thin_erx),frequency/1e9, imag(thin_erx))
grid on
ylim([-1 5])
ylabel('\epsilon_r (relative)')
legend('Thick \epsilon\prime','Thick \epsilon\prime\prime','Thin \epsilon\prime','Thin \epsilon\prime\prime')
xlabel('frequency (GHz)')
title('Calculated permittivity')
title('Permittivity for different thickeness of HDPE')
subplot(2,1,2)
plot(frequency/1e9, (real(thick_erx) + real(thin_erx))/2,frequency/1e9, (imag(thin_erx) + imag(thick_erx))/2)
grid on
ylim([-1 5])
ylabel('\epsilon_r (relative)')
legend('\epsilon\prime','\epsilon\prime\prime')
xlabel('frequency (GHz)')
title('Average permittivity')