dd20 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_20dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_20bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_20bdm_1-25-17.dat',' ');
dd25 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_25dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_25bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_25bdm_1-25-17.dat',' ');
dd30 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_30dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_30bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_30bdm_1-25-17.dat',' ');
dd35 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_35dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_35bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_35bdm_1-25-17.dat',' ');
dd40 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_40dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_40bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_40bdm_1-25-17.dat',' ');
dd45 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_45dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_45bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_45bdm_1-25-17.dat',' ');
dd50 = HighPowerPerms2('coax75','DD-13490',0.0015,'75mm_coax_air_50dbm_1-25-17.dat','75mm_coax_dd-13490_1p5mm_50bdm_1-25-17.dat','75mm_coax_flipped_dd-13490_1p5mm_50bdm_1-25-17.dat',' ');
%%
%PlotEpsAndMu(dd20,dd25,dd30,dd35,dd40,dd45,dd50,0.0015,'DD-13490')
num_frequencies = length(dd20.epsilon);
dd_power_epsilon = zeros(num_frequencies,7);
dd_power_epsilon(:,1) = ones(num_frequencies,1)*mean(dd20.epsilon);
dd_power_epsilon(:,2) = (dd25.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_epsilon(:,3) = (dd30.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_epsilon(:,4) = (dd35.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_epsilon(:,5) = (dd40.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_epsilon(:,6) = (dd45.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_epsilon(:,7) = (dd50.epsilon - dd20.epsilon) + mean(dd20.epsilon);
dd_power_mu = zeros(num_frequencies,7);
dd_power_mu(:,1) = ones(num_frequencies,1)*mean(dd20.mu);
dd_power_mu(:,2) = (dd25.mu - dd20.mu) + mean(dd20.mu);
dd_power_mu(:,3) = (dd30.mu - dd20.mu) + mean(dd20.mu);
dd_power_mu(:,4) = (dd35.mu - dd20.mu) + mean(dd20.mu);
dd_power_mu(:,5) = (dd40.mu - dd20.mu) + mean(dd20.mu);
dd_power_mu(:,6) = (dd45.mu - dd20.mu) + mean(dd20.mu);
dd_power_mu(:,7) = (dd50.mu - dd20.mu) + mean(dd20.mu);