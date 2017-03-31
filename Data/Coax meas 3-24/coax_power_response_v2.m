s11 = zeros(201,41);
s21 = s11;
for pow = 10:50
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',pow);
    [s_11,s_21,frequency] = s2pToComplexSParam_v4(airfile);
    s11(:,pow-9) = s_11;
    s21(:,pow-9) = s_21;
end
subplot(211)
plot(frequency/1e9,angle(s21))
xlabel('frequency (GHz)')
ylabel('magnitude')
title('Phase S21')
subplot(212)
plot(frequency/1e9,abs(s21))
xlabel('frequency (GHz)')
ylabel('magnitude')
title('Amplitude S21')
figure;
contourf(10:50,frequency/1e9,abs(s11))
colorbar
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('S11 Power response of empty coax')
figure;
contourf(10:50,frequency/1e9,abs(s21))
colorbar
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('S21 Power response of empty coax')