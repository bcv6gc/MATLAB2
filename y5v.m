y5v20 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v25 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_25dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v30 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_30dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v35 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_35dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v40 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_40dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v45 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_45dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v50 = HighPowerPerms2('coax75','wax',0.0032,'75mm_coax_air_50dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
%%
%{
y5v20td = HighPowerNonMag('coax75','Y5v',0.0032,'75mm_coax_air_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v25td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_25dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v30td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_30dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v35td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_35dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v40td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_40dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v45td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_45dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
y5v50td = HighPowerNonMag('coax75','Y5V',0.0032,'75mm_coax_air_50dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_1-25-17.dat','75mm_coax_10%Y5V_3p2mm_20dbm_180_1-25-17.dat',' ');
%%
PlotEpsilonPlusTimeDomain(y5v20,y5v25,y5v30,y5v35,y5v40,y5v45,y5v50,y5v20td,y5v25td,y5v30td,y5v35td,y5v40td,y5v45td,y5v50td,0.0032,'BaTi0_3')
%}
num_frequencies = length(y5v20.epsilon);
y5v_power_epsilon = zeros(num_frequencies,7);
y5v_power_epsilon(:,1) = ones(num_frequencies,1)*mean(y5v20.epsilon);
y5v_power_epsilon(:,2) = (y5v25.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_epsilon(:,3) = (y5v30.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_epsilon(:,4) = (y5v35.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_epsilon(:,5) = (y5v40.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_epsilon(:,6) = (y5v45.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_epsilon(:,7) = (y5v50.epsilon - y5v20.epsilon) + mean(y5v20.epsilon);
y5v_power_mu = zeros(num_frequencies,7);
y5v_power_mu(:,1) = ones(num_frequencies,1)*mean(y5v20.mu);
y5v_power_mu(:,2) = (y5v25.mu - y5v20.mu) + mean(y5v20.mu);
y5v_power_mu(:,3) = (y5v30.mu - y5v20.mu) + mean(y5v20.mu);
y5v_power_mu(:,4) = (y5v35.mu - y5v20.mu) + mean(y5v20.mu);
y5v_power_mu(:,5) = (y5v40.mu - y5v20.mu) + mean(y5v20.mu);
y5v_power_mu(:,6) = (y5v45.mu - y5v20.mu) + mean(y5v20.mu);
y5v_power_mu(:,7) = (y5v50.mu - y5v20.mu) + mean(y5v20.mu);