hdpe20 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat',' ');
hdpe25 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat',' ');
hdpe30 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat',' ');
hdpe35 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat',' ');
hdpe40 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat',' ');
hdpe45 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat',' ');
hdpe50 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
figure;
plot([0 3],[2.4 2.4],hdpe20.frequency/1e9,...
    real(hdpe20.epsilon),hdpe25.frequency/1e9,real(hdpe25.epsilon),...
    hdpe30.frequency/1e9,real(hdpe30.epsilon),hdpe35.frequency/1e9,...
    real(hdpe35.epsilon),hdpe40.frequency/1e9,real(hdpe40.epsilon),...
    hdpe45.frequency/1e9,real(hdpe45.epsilon),hdpe50.frequency/1e9,real(hdpe50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('theory','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime for a 5mm HDPE sample')
xlim([min(hdpe20.frequency/1e9) max(hdpe20.frequency/1e9)])
set(gca,'FontSize',12)
ylim([0 4])
figure;
plot([0 3],[0 0],hdpe20.frequency/1e9,imag(hdpe20.epsilon),hdpe25.frequency/1e9,imag(hdpe25.epsilon),...
    hdpe30.frequency/1e9,imag(hdpe30.epsilon),hdpe35.frequency/1e9,imag(hdpe35.epsilon),hdpe40.frequency/1e9,imag(hdpe40.epsilon),...
    hdpe45.frequency/1e9,imag(hdpe45.epsilon),hdpe50.frequency/1e9,imag(hdpe50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('theory','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime\prime for a 5mm HDPE sample')
xlim([min(hdpe20.frequency/1e9) max(hdpe20.frequency/1e9)])
set(gca,'FontSize',12)
ylim([-2 2])