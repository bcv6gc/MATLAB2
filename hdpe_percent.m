hdpe20 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat',' ');
hdpe25 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat',' ');
hdpe30 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat',' ');
hdpe35 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat',' ');
hdpe40 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat',' ');
hdpe45 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat',' ');
hdpe50 = HighPowerPerms2('coax75','wax',0.005,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
%%
%{
hdpe20td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_20dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe25td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_25dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe30td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_30dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe35td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_35dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe40td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_40dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe45td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_45dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
hdpe50td = HighPowerNonMag('coax','hdpe',0.005,'50mm_coax_air_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat','50mm_coax_5p1mm_hdpe_50dbm_1-24-17.dat',' ');
%%
%}
%PlotEpsilonPlusTimeDomain(hdpe20,hdpe25,hdpe30,hdpe35,hdpe40,hdpe45,hdpe50,hdpe20td,hdpe25td,hdpe30td,hdpe35td,hdpe40td,hdpe45td,hdpe50td,0.0032,'BaTi0_3')
num_frequencies = length(hdpe20.epsilon);
hdpe_power_epsilon = zeros(num_frequencies,7);
hdpe_power_epsilon(:,1) = ones(num_frequencies,1)*mean(hdpe20.epsilon);
hdpe_power_epsilon(:,2) = (hdpe25.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_epsilon(:,3) = (hdpe30.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_epsilon(:,4) = (hdpe35.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_epsilon(:,5) = (hdpe40.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_epsilon(:,6) = (hdpe45.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_epsilon(:,7) = (hdpe50.epsilon - hdpe20.epsilon) + mean(hdpe20.epsilon);
hdpe_power_mu = zeros(num_frequencies,7);
hdpe_power_mu(:,1) = ones(num_frequencies,1)*mean(hdpe20.mu);
hdpe_power_mu(:,2) = (hdpe25.mu - hdpe20.mu) + mean(hdpe20.mu);
hdpe_power_mu(:,3) = (hdpe30.mu - hdpe20.mu) + mean(hdpe20.mu);
hdpe_power_mu(:,4) = (hdpe35.mu - hdpe20.mu) + mean(hdpe20.mu);
hdpe_power_mu(:,5) = (hdpe40.mu - hdpe20.mu) + mean(hdpe20.mu);
hdpe_power_mu(:,6) = (hdpe45.mu - hdpe20.mu) + mean(hdpe20.mu);
hdpe_power_mu(:,7) = (hdpe50.mu - hdpe20.mu) + mean(hdpe20.mu);