[s11_20,s21_20,frequency] = s2pToComplexSParam_v4('75mm_coax_air_20dbm_1-25-17.dat');
[s11_25,s21_25,~] = s2pToComplexSParam_v4('75mm_coax_air_25dbm_1-25-17.dat');
[s11_30,s21_30,~] = s2pToComplexSParam_v4('75mm_coax_air_30dbm_1-25-17.dat');
[s11_35,s21_35,~] = s2pToComplexSParam_v4('75mm_coax_air_35dbm_1-25-17.dat');
[s11_40,s21_40,~] = s2pToComplexSParam_v4('75mm_coax_air_40dbm_1-25-17.dat');
[s11_45,s21_45,~] = s2pToComplexSParam_v4('75mm_coax_air_45dbm_1-25-17.dat');
[s11_50,s21_50,~] = s2pToComplexSParam_v4('75mm_coax_air_50dbm_1-25-17.dat');
figure;
plot(frequency/1e9,abs(s11_20),frequency/1e9,abs(s11_25),frequency/1e9,abs(s11_30),...
    frequency/1e9,abs(s11_35),frequency/1e9,abs(s11_40),frequency/1e9,abs(s11_45),...
    frequency/1e9,abs(s11_50),'LineWidth',2)
xlabel('frequency (GHz)')
ylabel('amplitude')
legend('20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Coax airline S11 power response')
set(gca,'FontSize',14)
grid on
figure;
plot(frequency/1e9,abs(s21_20),frequency/1e9,abs(s21_25),frequency/1e9,abs(s21_30),...
    frequency/1e9,abs(s21_35),frequency/1e9,abs(s21_40),frequency/1e9,abs(s21_45),...
    frequency/1e9,abs(s21_50),'LineWidth',2)
xlabel('frequency (GHz)')
ylabel('amplitude')
legend('20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title('Coax airline S21 power response')
set(gca,'FontSize',14)
grid on
