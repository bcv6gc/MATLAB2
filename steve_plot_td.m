%pzt25 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_25dBm_1-25-17.dat','Steve_loaded_stripline_25dbm_1-25-17.dat','Steve_loaded_stripline_25dbm_1-25-17.dat',' ');
%pzt30 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_30dBm_1-25-17.dat','Steve_loaded_stripline_30dbm_1-25-17.dat','Steve_loaded_stripline_30dbm_1-25-17.dat',' ');
%pzt35 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_35dBm_1-25-17.dat','Steve_loaded_stripline_35dbm_1-25-17.dat','Steve_loaded_stripline_35dbm_1-25-17.dat',' ');
pzt40 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_40dBm_1-25-17.dat','Steve_loaded_stripline_40dbm_1-25-17.dat','Steve_loaded_stripline_40dbm_1-25-17.dat',' ');
pzt45 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_45dBm_1-25-17.dat','Steve_loaded_stripline_45dbm_1-25-17.dat','Steve_loaded_stripline_45dbm_1-25-17.dat',' ');
pzt50 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_50dBm_1-25-17.dat','Steve_loaded_stripline_50dbm_1-25-17.dat','Steve_loaded_stripline_50dbm_1-25-17.dat',' ');
%pzt2_25 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_25dBm_1-25-17.dat','Steve_dep311_0p15_stripline_25dbm_1-25-17.dat','Steve_dep311_0p15_stripline_25dbm_1-25-17.dat',' ');
%pzt2_30 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_30dBm_1-25-17.dat','Steve_dep311_0p15_stripline_30dbm_1-25-17.dat','Steve_dep311_0p15_stripline_30dbm_1-25-17.dat',' ');
%pzt2_35 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_35dBm_1-25-17.dat','Steve_dep311_0p15_stripline_35dbm_1-25-17.dat','Steve_dep311_0p15_stripline_35dbm_1-25-17.dat',' ');
pzt2_40 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_40dBm_1-25-17.dat','Steve_dep311_0p15_stripline_40dbm_1-25-17.dat','Steve_dep311_0p15_stripline_40dbm_1-25-17.dat',' ');
pzt2_45 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_45dBm_1-25-17.dat','Steve_dep311_0p15_stripline_45dbm_1-25-17.dat','Steve_dep311_0p15_stripline_45dbm_1-25-17.dat',' ');
pzt2_50 = HighPowerNonMag('stripline','PZT',0.001,'stripline_air_50dBm_1-25-17.dat','Steve_dep311_0p15_stripline_50dbm_1-25-17.dat','Steve_dep311_0p15_stripline_50dbm_1-25-17.dat',' ');
freq = pzt25.frequency/1e9;
figure;
plot(freq,real(pzt40.epsilon),'r',freq,real(pzt2_40.epsilon),'r--',...
    freq,real(pzt45.epsilon),'b',freq,real(pzt2_45.epsilon),'b--',freq,real(pzt50.epsilon),'k',freq,real(pzt2_50.epsilon),'k--')
xlabel('frequency (GHz)')
ylabel('real permittivity')
title('Graphene on Polarized and Depolarized PZT')
legend('40dBm P','40dBm D','45dBm P','25dBm D','50dBm P','50dBm D','Location','northwest')
legend('boxoff')
grid on
%%
figure;
plot(freq,imag(pzt40.epsilon),'r',freq,imag(pzt2_40.epsilon),'r--',...
    freq,imag(pzt45.epsilon),'b',freq,imag(pzt2_45.epsilon),'b--',freq,imag(pzt50.epsilon),'k',freq,imag(pzt2_50.epsilon),'k--')
xlabel('frequency (GHz)')
ylabel('imaginary permittivity')
title('Graphene on Polarized and Depolarized PZT')
legend('40dBm P','40dBm D','45dBm P','25dBm D','50dBm P','50dBm D','Location','northwest')
legend('boxoff')
grid on
%%
figure;
plot(freq,real(pzt25.epsilon - pzt2_25.epsilon),freq,real(pzt30.epsilon - pzt2_30.epsilon),...
    freq,real(pzt35.epsilon - pzt2_35.epsilon),freq,real(pzt40.epsilon - pzt2_40.epsilon),...
    freq,real(pzt45.epsilon - pzt2_45.epsilon),freq,real(pzt50.epsilon - pzt2_50.epsilon))
xlabel('frequency (GHz)')
ylabel('real permittivity')
title('Polarized - Depolarized')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','northwest')
legend('boxoff')
grid on
%%
%{
figure;
plot(freq,imag(pzt25.mu),'r',freq,imag(pzt2_25.mu),'r--',freq,imag(pzt30.mu),'y',freq,imag(pzt2_30.mu),'y--',...
    freq,imag(pzt35.mu),'g',freq,imag(pzt2_35.mu),'g--',freq,imag(pzt40.mu),'c',freq,imag(pzt2_40.mu),'c--',...
    freq,imag(pzt45.mu),'b',freq,imag(pzt2_45.mu),'b--',freq,imag(pzt50.mu),'k',freq,imag(pzt2_50.mu),'k--')
xlabel('frequency (GHz)')
ylabel('imaginary permittivity')
title('Polarized and Depolarized')
legend('25dBm P','25dBm D','30dBm P','30dBm D','35dBm P','35dBm D','40dBm P','40dBm D','45dBm P','25dBm D','50dBm P','50dBm D','Location','northwest')
legend('boxoff')
grid on
%}
figure;
plot(freq,imag(pzt40.epsilon - pzt2_40.epsilon),...
    freq,imag(pzt45.epsilon - pzt2_45.epsilon),freq,imag(pzt50.epsilon - pzt2_50.epsilon))
xlabel('frequency (GHz)')
ylabel('imaginary permittivity')
title('Polarized - Depolarized')
legend('40dBm','45dBm','50dBm','Location','northwest')
legend('boxoff')
grid on
%%
%{
figure;
plot(freq,real(pzt25.epsilon),freq,real(pzt2_25.epsilon))
xlabel('frequency (GHz)')
ylabel('real permittivity')
title('Polarized and Depolarized PZT')
legend('Polarized','Depolarized','Location','northwest')
legend('boxoff')
grid on
figure;
plot(freq,imag(pzt25.epsilon),freq,imag(pzt2_25.epsilon))
xlabel('frequency (GHz)')
ylabel('imaginary permittivity')
title('Polarized and Depolarized PZT')
legend('Polarized','Depolarized','Location','northwest')
legend('boxoff')
grid on
%}
