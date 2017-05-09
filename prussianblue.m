pb20 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_20dbm_2-7-17.dat',' ');
pb25 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_25dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_25dbm_2-7-17.dat',' ');
pb30 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_30dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_30dbm_2-7-17.dat',' ');
pb35 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_35dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_35dbm_2-7-17.dat',' ');
pb40 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_40dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_40dbm_2-7-17.dat',' ');
pb45 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_45dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_45dbm_2-7-17.dat',' ');
pb50 = HighPowerPerms2('coax75','wax',0.00411,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_P-Blue_5%_4p11mm_50dbm_2-7-17.dat','coax_75mm_P-Blue_5%_rev_4p11mm_50dbm_2-7-17.dat',' ');
%%
%PlotEpsAndMu(pb20,pb25,pb30,pb35,pb40,pb45,pb50,0.00411,'5% Prussian Blue in wax')
num_frequencies = length(pb20.epsilon);
pb_power_epsilon = zeros(num_frequencies,7);
pb_power_epsilon(:,1) = ones(num_frequencies,1)*mean(pb20.epsilon);
pb_power_epsilon(:,2) = (pb25.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_epsilon(:,3) = (pb30.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_epsilon(:,4) = (pb35.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_epsilon(:,5) = (pb40.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_epsilon(:,6) = (pb45.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_epsilon(:,7) = (pb50.epsilon - pb20.epsilon) + mean(pb20.epsilon);
pb_power_mu = zeros(num_frequencies,7);
pb_power_mu(:,1) = ones(num_frequencies,1)*mean(pb20.mu);
pb_power_mu(:,2) = (pb25.mu - pb20.mu) + mean(pb20.mu);
pb_power_mu(:,3) = (pb30.mu - pb20.mu) + mean(pb20.mu);
pb_power_mu(:,4) = (pb35.mu - pb20.mu) + mean(pb20.mu);
pb_power_mu(:,5) = (pb40.mu - pb20.mu) + mean(pb20.mu);
pb_power_mu(:,6) = (pb45.mu - pb20.mu) + mean(pb20.mu);
pb_power_mu(:,7) = (pb50.mu - pb20.mu) + mean(pb20.mu);
