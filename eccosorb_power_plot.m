ecco20 = HighPowerPerms2('coax','eccosorb',0.001,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_eccosorb_20dbm_1-24-17.dat','50mm_coax_eccosorb_20dbm_180_1-24-17.dat',' ');
ecco30 = HighPowerPerms2('coax','eccosorb',0.001,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_eccosorb_30dbm_1-24-17.dat','50mm_coax_eccosorb_30dbm_180_1-24-17.dat',' ');
ecco40 = HighPowerPerms2('coax','eccosorb',0.001,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_eccosorb_40dbm_1-24-17.dat','50mm_coax_eccosorb_40dbm_180_1-24-17.dat',' ');
ecco50 = HighPowerPerms2('coax','eccosorb',0.001,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_eccosorb_50dbm_1-24-17.dat','50mm_coax_eccosorb_50dbm_180_1-24-17.dat',' ');
figure;
plot(ecco20.t_frequency/1e9,real(ecco20.epsilont),ecco20.frequency/1e9,real(ecco20.epsilon),ecco30.frequency/1e9,real(ecco30.epsilon),ecco40.frequency/1e9,real(ecco40.epsilon),...
    ecco50.frequency/1e9,real(ecco50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('theory','20dBm','30dBm','40dBm','50dBm','Location','best')
legend('boxoff')
title('Power dependence of \epsilon\prime for a 1mm eccosorb sample')
xlim([min(ecco20.frequency/1e9) max(ecco20.frequency/1e9)])
set(gca,'FontSize',12)
figure;
plot(ecco20.t_frequency/1e9,imag(ecco20.epsilont),ecco20.frequency/1e9,imag(ecco20.epsilon),ecco30.frequency/1e9,imag(ecco30.epsilon),ecco40.frequency/1e9,imag(ecco40.epsilon),...
    ecco50.frequency/1e9,imag(ecco50.epsilon))
xlabel('frequency')
ylabel('relative permittivity')
legend('theory','20dBm','30dBm','40dBm','50dBm','Location','northeast')
legend('boxoff')
xlim([min(ecco20.frequency/1e9) max(ecco20.frequency/1e9)])
title('Power dependence of \epsilon\prime\prime for a 1mm eccosorb sample')
set(gca,'FontSize',12)
figure;
plot(ecco20.t_frequency/1e9,real(ecco20.mut),ecco20.frequency/1e9,real(ecco20.mu),ecco30.frequency/1e9,real(ecco30.mu),ecco40.frequency/1e9,real(ecco40.mu),...
    ecco50.frequency/1e9,real(ecco50.mu))
xlabel('frequency')
ylabel('relative permittivity')
legend('theory','20dBm','30dBm','40dBm','50dBm','Location','northwest')
legend('boxoff')
xlim([min(ecco20.frequency/1e9) max(ecco20.frequency/1e9)])
title('Power dependence of \mu\prime for a 1mm eccosorb sample')
set(gca,'FontSize',12)
figure;
plot(ecco20.t_frequency/1e9,imag(ecco20.mut),ecco20.frequency/1e9,imag(ecco20.mu),ecco30.frequency/1e9,imag(ecco30.mu),ecco40.frequency/1e9,imag(ecco40.mu),...
    ecco50.frequency/1e9,imag(ecco50.mu))
xlabel('frequency')
ylabel('relative permittivity')
legend('theory','20dBm','30dBm','40dBm','50dBm','Location','northeast')
legend('boxoff')
xlim([min(ecco20.frequency/1e9) max(ecco20.frequency/1e9)])
title('Power dependence of \mu\prime\prime for a 1mm eccosorb sample')
set(gca,'FontSize',12)
