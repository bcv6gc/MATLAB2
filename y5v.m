y5v20 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v25 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_25dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v30 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_30dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v35 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_35dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v40 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_40dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v45 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_45dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v50 = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_50dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
%%
figure;
plot(y5v20.frequency/1e9,(real(y5v25.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(real(y5v30.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(real(y5v35.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(real(y5v40.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(real(y5v45.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(real(y5v50.epsilon)- real(y5v20.epsilon))./real(y5v20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('relative real permittivity % change')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime for a 3.2mm BaTiO_3 sample')
xlim([min(y5v20.frequency/1e9) max(y5v20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%ylim([0 4])
figure;
plot(y5v20.frequency/1e9,(imag(y5v25.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(imag(y5v30.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(imag(y5v35.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(imag(y5v40.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(imag(y5v45.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100,...
    y5v20.frequency/1e9,(imag(y5v50.epsilon)- imag(y5v20.epsilon))./imag(y5v20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('relative imaginary permittivity % change')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime\prime for a 3.2mm BaTiO_3 sample')
xlim([min(y5v20.frequency/1e9) max(y5v20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%}