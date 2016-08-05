striplineAir = 'stripline11mmAir.s2p';
stripline20mmHDPE = 'stripline11mmHDPE20mm.s2p';
thick20 = 20e-3;
thick10 = 10e-3;
coaxAir = 'coax60mmAir.s2p';
coax10mmHDPE = 'coax60mmHDPE10mm.s2p';
coax20mmHDPE = 'coax60mmHDPE20mm.s2p';
filelength = 209;
[~,sa21,~,~,frequency] = s2pToComplexSParam(striplineAir,filelength);
[~,sh21,~,~,~] = s2pToComplexSParam(stripline20mmHDPE,filelength);
[~,ca21,~,~,~] = s2pToComplexSParam(coaxAir,filelength);
[~,co21,~,~,~] = s2pToComplexSParam(coax10mmHDPE,filelength);
[~,ct21,~,~,~] = s2pToComplexSParam(coax20mmHDPE,filelength);
lengthoffft = 8000;
time_strip_air21=ifft(sa21,lengthoffft);
time_strip_hdpe21=ifft(sh21,lengthoffft);
time_coax_air21=ifft(ca21,lengthoffft);
time_coax_ten21=ifft(co21,lengthoffft);
time_coax_twenty21=ifft(ct21,lengthoffft);

[~,stripline_delay]=max(abs(time_strip_air21));
t=1:1:length(t);
win_length = 25000;
t_win_stripline=exp(-(t-stripline_delay).^2/win_length)';

[~,coax_delay]=max(abs(time_coax_air21));
t_win_coax=exp(-(t-stripline_delay).^2/win_length)';

filter_time_strip_air21=t_win_stripline.*time_strip_air21;
filter_time_strip_hdpe21=t_win_stripline.*time_strip_hdpe21;
filter_time_coax_air21=t_win_coax.*time_coax_air21;
filter_time_coax_ten21=t_win_coax.*time_coax_ten21;
filter_time_coax_twenty21=t_win_coax.*time_coax_twenty21;

temp_time_strip_air21=fft(filter_time_strip_air21);
temp_time_strip_hdpe21=fft(filter_time_strip_hdpe21);
temp_time_coax_air21=fft(filter_time_coax_air21);
temp_time_coax_ten21=fft(filter_time_coax_ten21);
temp_time_coax_twenty21=fft(filter_time_coax_twenty21);

time_strip_air21=temp_time_strip_air21(1:lengthofdata);
time_strip_hdpe21=temp_time_strip_hdpe21(1:lengthofdata);
time_coax_air21=temp_time_coax_air21(1:lengthofdata);
time_coax_ten21=temp_time_coax_ten21(1:lengthofdata);
time_coax_twenty21=temp_time_coax_twenty21(1:lengthofdata);

beta=2*pi*frequency/c0;
stripline=time_strip_hdpe21./time_strip_air21.*exp(-1i*beta*thick20);
coax10mm=time_coax_ten21./time_coax_air21.*exp(-1i*beta*thick10);
coax20mm=time_coax_twenty21./time_coax_air21.*exp(-1i*beta*thick20);

eps_stripline = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,thick20,stripline(i),stripline(i)),[1;0]);
    eps_stripline(i)=tt(1)+1i*tt(2);
end

eps_coax_10mm = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,thick10,coax10mm(i),coax10mm(i)),[1;0]);
    eps_coax_10mm(i)=tt(1)+1i*tt(2);
end

eps_coax_20mm = zeros(size(frequency));
for i=1:length(frequency)
    f=frequency(i);
    tt = fsolve(@(xx) get_s21v2(xx,f,thick20,coax20mm(i),coax20mm(i)),[1;0]);
    eps_coax_20mm(i)=tt(1)+1i*tt(2);
end
subplot(2,1,1)
plot(frequency/1e9,real(eps_stripline),frequency/1e9,real(eps_coax_10mm),frequency/1e9,real(eps_coax_20mm))
hold on
plot([1 13.5],[2.07 2.07],'k--','linewidth',2)
plot([1 13.5],[2.53 2.53],'k--','linewidth',2)
xlabel('frequency (Ghz)')
ylabel('Real Relative \epsilon')
legend('stripline','coax 10mm', 'coax 20mm','Location','eastoutside')
ylim([0 3])
xlim([2 12])
grid on
hold off
subplot(2,1,2)
plot(frequency/1e9,imag(eps_stripline),frequency/1e9,imag(eps_coax_10mm),frequency/1e9,imag(eps_coax_20mm))
xlabel('frequency (Ghz)')
ylabel('Imaginary Relative \epsilon')
legend('stripline','coax 10mm', 'coax 20mm','Location','eastoutside')
xlim([2 12])
grid on