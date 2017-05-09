%compare_calibration
trl_file = 'TRL_cal_with_5_7p5mm_lengths.dat';
trl_file2 = 'TRL_cal_with_5_7p5_10mm_lengths.dat';
tosm_file = 'TOSM_calibration_50mm_airline_added.dat';
brandon_air = 'coax_50mm_air_10-19.dat';
[s11,s21,s12,s22,freq] = s2pToComplexSParam_v3(trl_file);
[r11,r21,r12,r22,~] = s2pToComplexSParam_v3(trl_file2);
[t11,t21,t12,t22,~] = s2pToComplexSParam_v3(tosm_file);
[u11,u21,u12,u22,f2] = s2pToComplexSParam_v3(brandon_air);
subplot(221)
plot(freq/1e9,abs(r11),f2/1e9,abs(u11))
%plot(freq,abs(s11),freq,abs(r11),freq,abs(t11),f2,abs(u11))
%legend('TRL 5 & 7.5mm','TRL 5, 7.5, 10mm','TOSM','air')
legend('TRL 5, 7.5, 10mm','TOSM')
legend('boxoff')
ylim([0 0.2])
ylabel('amplitude')
xlabel('frequency (GHz)')
grid on
title('S11 amplitude')
subplot(222)
plot(freq/1e9,abs(r21),f2/1e9,abs(u21))
%plot(freq,abs(s21),freq,abs(r21),freq,abs(t21),f2,abs(u21))
ylim([0.8 1.2])
ylabel('amplitude')
xlabel('frequency (GHz)')
grid on
title('S21 amplitude')
subplot(223)
%plot(freq,unwrap(angle(s11)),freq,unwrap(angle(r11)),freq,unwrap(angle(t11)),f2,unwrap(angle(u11)))
plot(freq/1e9,angle(r11)/pi,f2/1e9,angle(u11)/pi)
ylabel('angle/\pi')
xlabel('frequency (GHz)')
title('S11 angle')
grid on
subplot(224)
%plot(freq,unwrap(angle(s11)),freq,unwrap(angle(r11)),freq,unwrap(angle(t11)),f2,unwrap(angle(u21)))
plot(freq/1e9,angle(r11)/pi,f2/1e9,angle(u21)/pi)
ylabel('angle/\pi')
xlabel('frequency (GHz)')
title('S21 angle')
grid on