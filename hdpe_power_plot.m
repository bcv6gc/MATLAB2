hdpe20 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat',' ');
hdpe25 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat',' ');
hdpe30 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat',' ');
hdpe35 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat',' ');
hdpe40 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat',' ');
hdpe45 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat',' ');
hdpe50 = HighPowerPerms2('coax','hdpe',0.005,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
%%
hdpetd20 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd25 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd30 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd35 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd40 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd45 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpetd50 = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
%%
PlotEpsilonPlusTimeDomain(hdpe20,hdpe25,hdpe30,hdpe35,hdpe40,hdpe45,hdpe50,hdpetd20,hdpetd25,hdpetd30,hdpetd35,hdpetd40,hdpetd45,hdpetd50,0.005,'HDPE')
%{
figure;
plot(dd20.t_frequency/1e9,real(dd20.epsilont),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,real(dd20.epsilon),...
    dd20.frequency/1e9,real(dd25.epsilon),...
    dd20.frequency/1e9,real(dd30.epsilon),...
    dd20.frequency/1e9,real(dd35.epsilon),...
    dd20.frequency/1e9,real(dd40.epsilon),...
    dd20.frequency/1e9,real(dd45.epsilon),...
    dd20.frequency/1e9,real(dd50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Measured real \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
figure;
plot(hdpe20.t_frequency/1e9,imag(hdpe20.epsilont),hdpe20.frequency/1e9,...
    imag(hdpe20.epsilon),hdpe25.frequency/1e9,imag(hdpe25.epsilon),...
    hdpe30.frequency/1e9,imag(hdpe30.epsilon),hdpe35.frequency/1e9,...
    imag(hdpe35.epsilon),hdpe40.frequency/1e9,imag(hdpe40.epsilon),...
    hdpe45.frequency/1e9,imag(hdpe45.epsilon),hdpe50.frequency/1e9,...
    imag(hdpe50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('theory','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime\prime for a 5mm HDPE sample')
xlim([min(hdpe20.frequency/1e9) max(hdpe20.frequency/1e9)])
set(gca,'FontSize',12)
ylim([-2 2])
%}