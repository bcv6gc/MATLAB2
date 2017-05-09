sl20 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_20dbm_1-25-17.dat','Steve_dep311_0p15_stripline_20dbm_1-25-17.dat','Steve_dep311_0p15_stripline_20dbm_1-25-17.dat',' ');
sl25 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_25dbm_1-25-17.dat','Steve_dep311_0p15_stripline_25dbm_1-25-17.dat','Steve_dep311_0p15_stripline_25dbm_1-25-17.dat',' ');
sl30 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_30dbm_1-25-17.dat','Steve_dep311_0p15_stripline_30dbm_1-25-17.dat','Steve_dep311_0p15_stripline_30dbm_1-25-17.dat',' ');
sl35 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_35dbm_1-25-17.dat','Steve_dep311_0p15_stripline_35dbm_1-25-17.dat','Steve_dep311_0p15_stripline_35dbm_1-25-17.dat',' ');
sl40 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_40dbm_1-25-17.dat','Steve_dep311_0p15_stripline_40dbm_1-25-17.dat','Steve_dep311_0p15_stripline_40dbm_1-25-17.dat',' ');
sl45 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_45dbm_1-25-17.dat','Steve_dep311_0p15_stripline_45dbm_1-25-17.dat','Steve_dep311_0p15_stripline_45dbm_1-25-17.dat',' ');
sl50 = HighPowerNonMag('coax75',' ',0.0015,'75mm_coax_air_50dbm_1-25-17.dat','Steve_dep311_0p15_stripline_50dbm_1-25-17.dat','Steve_dep311_0p15_stripline_50dbm_1-25-17.dat',' ');
%%
PlotEpsilonTimeDomain(sl20,sl25,sl30,sl35,sl40,sl45,sl50,0.00015,'PZT')