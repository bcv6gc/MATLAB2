close all
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0); % speed of light
eta0=sqrt(mu0/eps0); % free space
k0 = 2*pi*3e9/c0;
num = 1e6;
time = linspace(0,50/3e9,num);
time2 = linspace(-50/3e9,50/3e9,2*num);
dt = mean(diff(time));
Fs = 1/dt;
microwave = sin(2*pi*3e9*time);
decay = exp(-time*Fs/2e5);
signal_with_decay = microwave.*decay;
signal2 = [-fliplr(signal_with_decay) signal_with_decay];
[b,a] = butter(10,0.1);
signal3 = [fliplr(signal_with_decay) signal_with_decay];
figure; plot(time,real(signal_with_decay))
xlabel('time(s)')
ylabel('Amplitude')
title('3 GHz with exponential decay')
grid on
set(gca,'fontsize',14)
%%
figure; plot(time2,real(signal2))
xlabel('time(s)')
ylabel('Amplitude')
title('Noncausal Odd Function')
grid on
set(gca,'fontsize',14)
xlim([-max(time)/2 max(time)/2])
%%
figure; plot(time2,real(signal3))
xlabel('time(s)')
ylabel('Amplitude')
title('Noncausal Even Function')
grid on
set(gca,'fontsize',14)
xlim([-max(time)/2 max(time)/2])
%%
num = num*2;
frequency = Fs*(0:(num/2-1))/num;
swd_freq = 2*fft([signal_with_decay zeros(size(signal_with_decay))])/num;
figure;
plot(frequency,real(swd_freq(1:num/2)),frequency,imag(swd_freq(1:num/2)))
grid on
xlabel('frequency(Hz)')
ylabel('amplitude')
legend('real', 'imaginary')
title('3 GHz with exponential decay')
xlim([1.5e9 4.5e9])
set(gca,'fontsize',14)
%%
swd_freq2 = 2*fft(signal2);
swd_freq2 = filtfilt(b,a,swd_freq2)/3e4;
figure;
plot(frequency,real(swd_freq2(1:num/2)),frequency,imag(swd_freq2(1:num/2)))
grid on
xlabel('frequency(Hz)')
ylabel('amplitude')
legend('real', 'imaginary')
title('Noncausal Odd Function')
xlim([1.5e9 4.5e9])
set(gca,'fontsize',14)
%%
%frequency = Fs*(0:(num/2-1))/num;
swd_freq3 = 2*fft(signal3);
swd_freq3 = filtfilt(b,a,swd_freq3)/3e4;
figure;
plot(frequency,-real(swd_freq3(1:num/2)),frequency,imag(swd_freq3(1:num/2)))
grid on
xlabel('frequency(Hz)')
ylabel('amplitude')
legend('real', 'imaginary')
title('Noncausal Even Function')
xlim([1.5e9 4.5e9])
set(gca,'fontsize',14)
%%
figure;
plot(frequency,-real(swd_freq3(1:num/2)),frequency,imag(swd_freq2(1:num/2)))
grid on
xlabel('frequency(Hz)')
ylabel('amplitude')
legend('real', 'imaginary')
title('Even and Odd combined')
xlim([1.5e9 4.5e9])
set(gca,'fontsize',14)