eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0); % speed of light
eta0=sqrt(mu0/eps0); % free space
k0 = 2*pi*3e9/c0;
num = 1e6;
time = linspace(-20/3e9,20/3e9,num);
impulse = zeros(1,length(time));
impulse(num/2 + 1) = 1;
[b,a] = butter(10,[.3 .4],'bandpass');
filtered = filter(b,a,impulse);
pos_time = time(num/2+1:end);
microwave = sin(2*pi*3e9*pos_time);
decay = exp(1i*k0*sqrt(1i*49)*pos_time*700000);
pad = zeros(1,length(time) - length(microwave));
signal_with_decay = [pad microwave.*decay];
signal = [pad microwave];
plot(time,real(signal))
figure; plot(time,real(signal_with_decay))
xlabel('time(s)')
ylabel('Amplitude')
title('Exponential decay in a material')
grid on
xlim([min(time) max(time)])
set(gca,'fontsize',16)