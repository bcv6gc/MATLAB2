%thickness_calc
p16 = '1p16_thick.s2p';
frequency = dlmread(p16,' ',9,0,[9 0 209 0]);
p16_m11 = dlmread(p16,' ',9,1,[9 1 209 1]);
p38 = '1p23_thick.s2p';
p23_m11 = dlmread(p38,' ',9,1,[9 1 209 1]);
p44_2 = '1p30_thick.s2p';
p30_m11 = dlmread(p44_2,' ',9,1,[9 1 209 1]);
p52 = '1p37_thick.s2p';
p37_m11 = dlmread(p52,' ',9,1,[9 1 209 1]);
p60 = '1p44_thick.s2p';
p44_m11 = dlmread(p60,' ',9,1,[9 1 209 1]);
%%
p32 = '1p32_thin.s2p';
p32_m11 = dlmread(p32,' ',9,1,[9 1 209 1]);
p38 = '1p38_thin.s2p';
p38_m11 = dlmread(p38,' ',9,1,[9 1 209 1]);
p44_2 = '1p44_thin.s2p';
p44_2_m11 = dlmread(p44_2,' ',9,1,[9 1 209 1]);
p52 = '1p52_thin.s2p';
p52_m11 = dlmread(p52,' ',9,1,[9 1 209 1]);
p60 = '1p60_thin.s2p';
p60_m11 = dlmread(p60,' ',9,1,[9 1 209 1]);
og = 'OG.s2p';
og_m11 = dlmread(og,' ',9,1,[9 1 209 1]);
wire = 'wire.s2p';
wire_m11 = dlmread(wire,' ',9,1,[9 1 209 1]);
%%
pcalc = 'post_cal.s2p';
post_calc_m11 = dlmread(pcalc,' ',9,1,[9 1 209 1]);
hdpe = 'wide_HDPE.s2p';
hdpe_m11 = dlmread(hdpe,' ',9,1,[9 1 209 1]);
frequency = frequency/1e9;
subplot(2,1,1)
plot(frequency, p16_m11,frequency, p23_m11,frequency, p30_m11,frequency, p37_m11,frequency, p44_m11,frequency, og_m11,frequency, wire_m11)
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
ylim([-30 0])
line([7 7],[-30 0])
xlim([0 12])
title('Conductor width')
grid on
%ylabel('Magnitude')
legend({'1.16 cm','1.23 cm','1.30 cm','1.37 cm','1.44 cm','Original','wire'},'Location', 'eastoutside')
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
subplot(2,1,2)
plot(frequency, post_calc_m11,frequency, hdpe_m11)
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
title('Inline Calibration')
ylim([-45 0])
xlim([0 12])
%ylabel('Magnitude')
legend({'Post Cal','w/ HDPE'},'Location', 'eastoutside')
grid on
%set(gca,'fontsize', 18);
%}