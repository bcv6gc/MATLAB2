[reflect11,reflect21,r_frequency] = s2pToComplexSParam_v4('C:\Users\jl3y9\Documents\MATLAB\Data\Calibration\Airline_50mm_30dBm_1-20-17.dat');
[air11,air21,a_frequency] = s2pToComplexSParam_v4('C:\Users\jl3y9\Documents\MATLAB\Data\Calibration\Airline_reflect_30dBm_1-20-17.dat');
[mut11,mut21,m_frequency] = s2pToComplexSParam_v4('C:\Users\jl3y9\Documents\MATLAB\Data\HighPower\50mm_coax_5mm_HDPE_30dBm_1-16.dat');
plot(r_frequency/1e9, unwrap(angle(reflect11)),a_frequency/1e9, unwrap(angle(air11)),m_frequency/1e9, unwrap(angle(mut11)))
xlabel('frequency (GHz)')
ylabel('Phase (radian)')
legend('reflect','air','hdpe')
figure;
plot(r_frequency/1e9, unwrap(angle(mut11)) - unwrap(angle(reflect11)))
xlabel('frequency (GHz)')
ylabel('Phase (radian)')
legend('hdpe - reflect')