%thickness_calc
b12 = 'Brandon_beveled_(1.2).s2p';
frequency = dlmread(b12,' ',9,0,[9 0 209 0])/1e9;
b12_m11 = dlmread(b12,' ',9,1,[9 1 209 1]);
b13 = 'Brandon_beveled_(1.3).s2p';
b13_m11 = dlmread(b13,' ',9,1,[9 1 209 1]);
b14 = 'Brandon_beveled_(1.4).s2p';
b14_m11 = dlmread(b14,' ',9,1,[9 1 209 1]);
b15 = 'Brandon_beveled_(1.5).s2p';
b15_m11 = dlmread(b15,' ',9,1,[9 1 209 1]);
b16 = 'Brandon_beveled_(1.6).s2p';
b16_m11 = dlmread(b16,' ',9,1,[9 1 209 1]);
b17 = 'Brandon_beveled_(1.7).s2p';
b17_m11 = dlmread(b17,' ',9,1,[9 1 209 1]);
%%
f12 = 'Brandon_flat_(1.2).s2p';
f12_m11 = dlmread(f12,' ',9,1,[9 1 209 1]);
f13 = 'Brandon_flat_(1.3).s2p';
f13_m11 = dlmread(f13,' ',9,1,[9 1 209 1]);
f14 = 'Brandon_flat_(1.4).s2p';
f14_m11 = dlmread(f14,' ',9,1,[9 1 209 1]);
f15 = 'Brandon_flat_(1.5).s2p';
f15_m11 = dlmread(f15,' ',9,1,[9 1 209 1]);
f16 = 'Brandon_flat_(1.6).s2p';
f16_m11 = dlmread(f16,' ',9,1,[9 1 209 1]);
f17 = 'Brandon_flat_(1.7).s2p';
f17_m11 = dlmread(f17,' ',9,1,[9 1 209 1]);
%%
og = 'OG.s2p';
og_m11 = dlmread(og,' ',9,1,[9 1 209 1]);
subplot(2,2,1)
plot(frequency, b12_m11,frequency, b13_m11,frequency, b14_m11,frequency, b15_m11,frequency, b16_m11,frequency, b17_m11,frequency,og_m11,'k.')
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
%ylim([-30 0])
%line([7 7],[-30 0])
xlim([0 12])
title('Beveled End')
grid on
%ylabel('Magnitude')
legend({'1.2 cm','1.3 cm','1.4 cm','1.5 cm','1.6 cm','1.7 cm','Original'},'Location', 'eastoutside')
%{
subplot(2,1,2)
plot(frequency, p32_m11,frequency, p38_m11,frequency, p44_2_m11,frequency, p52_m11,frequency, p60_m11,frequency, og_m11,frequency, wire_m11)
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
ylim([-30 0])
%ylabel('Magnitude')
legend({'1.32','1.38','1.44','1.52','1.60','Original','wire'},'Location', 'eastoutside')
title('Thin Conductor')
grid on
%}
%
subplot(2,2,2)
plot(frequency, f12_m11,frequency, f13_m11,frequency, f14_m11,frequency, f15_m11,frequency, f16_m11,frequency, f17_m11,frequency,og_m11,'k.')
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
title('Flat Ended')
%ylim([-45 0])
xlim([0 12])
%ylabel('Magnitude')
legend({'1.2 cm','1.3 cm','1.4 cm','1.5 cm','1.6 cm','1.7 cm','Original'},'Location', 'eastoutside')
grid on
subplot(2,2,3)
plot(frequency, b12_m11,frequency, f12_m11,frequency,og_m11,'k.')
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
title('Bevel vs. flat 1.2 cm')
%ylim([-45 0])
xlim([0 12])
%ylabel('Magnitude')
legend({'beveled','flat','Original'},'Location', 'eastoutside')
grid on
subplot(2,2,4)
plot(frequency, b17_m11,frequency, f17_m11,frequency,og_m11,'k.')
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
title('Bevel vs. flat 1.7 cm')
%ylim([-45 0])
xlim([0 12])
%ylabel('Magnitude')
legend({'beveled','flat','Original'},'Location', 'eastoutside')
grid on
%set(gca,'fontsize', 18);
%}