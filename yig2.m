yig20 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_20dbm_2-7-17.dat',' ');
yig25 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_25dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_25dbm_2-7-17.dat',' ');
yig30 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_30dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_30dbm_2-7-17.dat',' ');
yig35 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_35dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_35dbm_2-7-17.dat',' ');
yig40 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_40dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_40dbm_2-7-17.dat',' ');
yig45 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_45dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_45dbm_2-7-17.dat',' ');
yig50 = HighPowerPerms2('coax75','wax',0.00388,'coax_75mm_air_75mm_20dbm_2-7-17.dat','coax_75mm_YIG_10%_3p88mm_50dbm_2-7-17.dat','coax_75mm_YIG_10%_rev_3p88mm_50dbm_2-7-17.dat',' ');
%%
%PlotEpsAndMu(yig20,yig25,yig30,yig35,yig40,yig45,yig50,0.00388,'10% YIG in wax')
num_frequencies = length(yig20.epsilon);
yig_power_epsilon = zeros(num_frequencies,7);
yig_power_epsilon(:,1) = ones(num_frequencies,1)*mean(yig20.epsilon);
yig_power_epsilon(:,2) = (yig25.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_epsilon(:,3) = (yig30.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_epsilon(:,4) = (yig35.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_epsilon(:,5) = (yig40.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_epsilon(:,6) = (yig45.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_epsilon(:,7) = (yig50.epsilon - yig20.epsilon) + mean(yig20.epsilon);
yig_power_mu = zeros(num_frequencies,7);
yig_power_mu(:,1) = ones(num_frequencies,1)*mean(yig20.mu);
yig_power_mu(:,2) = (yig25.mu - yig20.mu) + mean(yig20.mu);
yig_power_mu(:,3) = (yig30.mu - yig20.mu) + mean(yig20.mu);
yig_power_mu(:,4) = (yig35.mu - yig20.mu) + mean(yig20.mu);
yig_power_mu(:,5) = (yig40.mu - yig20.mu) + mean(yig20.mu);
yig_power_mu(:,6) = (yig45.mu - yig20.mu) + mean(yig20.mu);
yig_power_mu(:,7) = (yig50.mu - yig20.mu) + mean(yig20.mu);