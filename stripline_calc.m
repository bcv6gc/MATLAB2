eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
thickness = 0.1;
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
mat_file = 'Brandon(3)thinhdpe.s2p';
mut_m21 = dlmread(mat_file,' ',9,3,[9 3 209 3]);
mut_p21 = dlmread(mat_file,' ',9,4,[9 4 209 4]);
mut_m12 = dlmread(mat_file,' ',9,5,[9 5 209 5]);
mut_p12 = dlmread(mat_file,' ',9,6,[9 6 209 6]);
amp21=10.^(mut_m21/20);
phase21=mut_p21/180*pi;
amp12=10.^(mut_m12/20);
phase12=mut_p12/180*pi;
s21_m=amp21.*exp(1i*phase21);
s12_m=amp12.*exp(1i*phase12);
%waveguide propagation factor in air (no sample)
omega21=2*pi*air_p21;
g021=1i*sqrt(omega21.*omega21*1*1/c0/c0);
omega12=2*pi*air_p12;
g012=1i*sqrt(omega12.*omega12*1*1/c0/c0);

s21=s21_m./s21_a.*exp(-g021*thickness);
s12=s12_m./s12_a.*exp(-g012*thickness);
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,thickness,s21(i),s12(i)),[1;0]);
    erx(i)=tt(1)+1i*tt(2);
    
end
figure;
subplot(2,1,1)
yyaxis left
plot(frequency/1e9, 10*log10(abs(s12)))
ylabel('Amplitude (dB)')
hold on
yyaxis right
plot(frequency/1e9, angle(s12))
ylabel('Phase (radians)')
grid on
xlabel('frequency (GHz)')
hold off
%legend('Phase S12','Phase S21')
title('S21')
subplot(2,1,2)
plot(frequency/1e9, real(erx),frequency/1e9, imag(erx))
grid on
ylabel('\epsilon_r (relative)')
legend('\epsilon\prime','\epsilon\prime\prime')
xlabel('frequency (GHz)')
title('Calculated permittivity')