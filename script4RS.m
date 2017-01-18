[lp11,lp21,~,~,lp_frequency] = s2pToComplexSParam_v3('C:\Users\jl3y9\Documents\MATLAB\Data\newdata\50mm_coax_5mm_hdpe_10_6.dat');
[hp11,hp21,hp_frequency] = s2pToComplexSParam_v4('C:\Users\jl3y9\Documents\MATLAB\Data\HighPower\50mm_coax_5mm_HDPE_40dBm_1-16.dat');
plot(hp_frequency/1e9,unwrap(angle(hp11)),lp_frequency/1e9,unwrap(angle(lp11)))
ylabel('Unwrapped phase (radians)')
xlabel('Frequency (GHz)')
legend('S11 high power','S11 low power','Location','best')
title('Phase difference between high and low power setups')
legend('boxoff')
xlim([0 3])