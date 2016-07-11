%thickness_calc
p16 = '1p16.s2p';
frequency = dlmread(p16,' ',9,0,[9 0 209 0]);
p16_m11 = dlmread(p16,' ',9,1,[9 1 209 1]);
p23 = '1p23.s2p';
p23_m11 = dlmread(p23,' ',9,1,[9 1 209 1]);
p30 = '1p30.s2p';
p30_m11 = dlmread(p30,' ',9,1,[9 1 209 1]);
p37 = '1p37.s2p';
p37_m11 = dlmread(p37,' ',9,1,[9 1 209 1]);
p44 = '1p44.s2p';
p44_m11 = dlmread(p44,' ',9,1,[9 1 209 1]);
frequency = frequency/1e9;
plot(frequency, p16_m11,frequency, p23_m11,frequency, p30_m11,frequency, p37_m11,frequency, p44_m11)
%plot(frequency, 10.^(p16_m11/10),frequency, 10.^(p23_m11/10),frequency, 10.^(p30_m11/10),frequency, 10.^(p37_m11/10),frequency, 10.^(p44_m11/10))
xlabel('Frequency (GHz)')
ylabel('Magnitude (dB)')
%ylabel('Magnitude')
legend({'1.16','1.23','1.30','1.37','1.44'},'Location', 'SouthEast')
set(gca,'fontsize', 18);