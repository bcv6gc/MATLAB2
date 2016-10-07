%different_coax_widths
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
eta0=sqrt(mu0/eps0); % free space
material_width = 1.78e-3;
device_length = 41e-3;
l = (device_length - material_width)/2;
t = material_width;
%%
filelength = 209;
connectorFile = '50mm_coax_10-6.s2p';
[c11,c21,c12,c22,c_frequency] = s2pToComplexSParam(connectorFile,filelength);
ck0 = 2*pi*c_frequency/c0;
%fudgeFactor = (unwrap(angle(c11)) - unwrap(angle(c22)))/2;
%c11 = c11.*exp(-1i*fudgeFactor);
%c22 = c22.*exp(1i*fudgeFactor);

filelength = 809;
shortFile = '50mm_coax_air_10-5.s2p';
[s11,s21,s12,s22,s_frequency] = s2pToComplexSParam(shortFile,filelength);
sk0 = 2*pi*s_frequency/c0;
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2;
s11 = s11.*exp(-1i*fudgeFactor);
s22 = s22.*exp(1i*fudgeFactor);

longFile = '75mm_coax_air_10-5.s2p';
[l11,l21,l12,l22,l_frequency] = s2pToComplexSParam(longFile,filelength);
lk0 = 2*pi*l_frequency/c0;
fudgeFactor = (unwrap(angle(l11)) - unwrap(angle(l22)))/2;
l11 = l11.*exp(-1i*fudgeFactor);
l22 = l22.*exp(1i*fudgeFactor);

figure;
subplot(221)
%yyaxis left
plot(c_frequency/1e9,unwrap(angle(c11))./ck0, s_frequency/1e9,unwrap(angle(s11))./sk0, l_frequency/1e9,unwrap(angle(l11))./lk0)
ylabel('distance(m)')
%yyaxis right
%plot(c_frequency/1e9,unwrap(angle(s11)),s_frequency, unwrap(angle(t11)))
%ylim([-0.1 0.15])
xlabel('Frequency')
%ylabel('Offset \pi')
%legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('Agilent S11 Phase')
%xlim([1 10])
grid on
subplot(222)
%yyaxis left
plot(c_frequency/1e9,unwrap(angle(c21))./ck0,s_frequency/1e9, unwrap(angle(s21))./sk0,l_frequency/1e9,unwrap(angle(l21))./lk0)
ylabel('distance(m)')
%yyaxis right
%plot(m_frequency(2:end)/1e9,diff(unwrap(angle(s21))),frequency(2:end), diff(unwrap(angle(t21))))
%ylim([-0.08 0.08])
xlabel('Frequency')
%ylabel('Offset \pi')
xlabel('Frequency')
%legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('Agilent S21 Phase')
%xlim([1 10])
grid on
subplot(223)
plot(c_frequency/1e9,abs(c11),s_frequency/1e9, abs(s11),l_frequency/1e9,abs(l11))
xlabel('Frequency')
ylabel('Magnitude')
%legend('measured', 'theory','Location','northeast','Orientation','horizontal')
title('S11 Magnitude')
%xlim([1 10])
grid on
subplot(224)
plot(c_frequency/1e9,abs(c21),s_frequency/1e9, abs(s21),l_frequency/1e9,abs(l21))
xlabel('Frequency')
ylabel('Magnitude')
legend('straight', '50mm', '75mm','Location','northeast','Orientation','horizontal')
title('S21 Magnitude')
%xlim([1 10])
grid on