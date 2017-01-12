[a11,a21,a_frequency] = s2pToComplexSParam_v4('50mm_coax_eccosorb_20dBm_1-10.dat');
[b11,b21,b_frequency] = s2pToComplexSParam_v4('50mm_coax_eccosorb_30dBm_1-10.dat');
[c11,c21,c_frequency] = s2pToComplexSParam_v4('50mm_coax_eccosorb_40dBm_1-10.dat');
[d11,d21,d_frequency] = s2pToComplexSParam_v4('50mm_coax_eccosorb_45dBm_1-10.dat');
[e11,e21,e_frequency] = s2pToComplexSParam_v4('50mm_coax_eccosorb_50dBm_1-10.dat');
subplot(211)
plot(a_frequency/1e9, (abs(a11) - abs(a11))./abs(a11)*100,b_frequency/1e9, (abs(b11) - abs(a11))./abs(a11)*100,...
    c_frequency/1e9, (abs(c11) - abs(a11))./abs(a11)*100,d_frequency/1e9, (abs(d11) - abs(a11))./abs(a11)*100,...
    e_frequency/1e9, (abs(e11) - abs(a11))./abs(a11)*100,'linewidth',2)
ylabel('Percent Change')
xlabel('Frequency (GHz)')
grid on
title('Eccosorb S11 scattering paramter')
set(gca,'fontsize',11)
subplot(212)
plot(a_frequency/1e9, (abs(a21) - abs(a21))./abs(a21)*100,b_frequency/1e9, (abs(b21) - abs(a21))./abs(a21)*100,...
    c_frequency/1e9, (abs(c21) - abs(a21))./abs(a21)*100,d_frequency/1e9, (abs(d21) - abs(a21))./abs(a21)*100,...
    e_frequency/1e9, (abs(e21) - abs(a21))./abs(a21)*100,'linewidth',2)
%legend('35dBm','40dBm','45dBm','47dBm','50dBm','Location','best')
legend('20dBm','30dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
ylabel('Percent Change')
xlabel('Frequency (GHz)')
grid on
title('Eccosorb Blue S21 scattering parameter')
set(gca,'fontsize',11)