% process_stripline
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
%%
frequency = dlmread('SL_HDPE.s2p',' ',9,0,[9 0 209 0]);
g0=1i*sqrt(omega.*omega*1*1/c0/c0);
%s11_mag = dlmread('SL_HDPE.s2p',' ',9,1,[9 1 209 1]);
%s11_phase = dlmread('SL_HDPE.s2p',' ',9,2,[9 2 209 2]);
s21_mag = dlmread('SL_HDPE.s2p',' ',9,3,[9 3 209 3]);
s21_phase = dlmread('SL_HDPE.s2p',' ',9,1,[9 2 209 2]);
s21_mag_value=10.^(s21_mag./20);
s21_phase_radians=s21_phase/180*pi;
s21=s21_mag_value.*exp(1i*s21_phase_radians).*exp(-g0*thickness);
figure(1)
plot(frequency/1e9,real(s21(:,1)))
hold on
plot(frequency/1e9,imag(s21(:,1)))
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21(xx,f,thickness,s21(i),s12(i)),[1;0]);
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