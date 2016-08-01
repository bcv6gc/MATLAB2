close all
clc
clear

eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);

medium_file = '7-14-thick.s2p';
frequency = dlmread(medium_file,' ',9,0,[9 0 209 0])/1e9;
med_mag11 = dlmread(medium_file,' ',9,1,[9 1 209 1]);
med_phase11 = dlmread(medium_file,' ',9,2,[9 2 209 2]);
med_mag21 = dlmread(medium_file,' ',9,3,[9 3 209 3]);
med_phase21 = dlmread(medium_file,' ',9,4,[9 4 209 4]);
med_mag12 = dlmread(medium_file,' ',9,5,[9 5 209 5]);
med_phase12 = dlmread(medium_file,' ',9,6,[9 6 209 6]);
med_mag22 = dlmread(medium_file,' ',9,7,[9 7 209 7]);
med_phase22 = dlmread(medium_file,' ',9,8,[9 8 209 8]);
med=complex((10.^(med_mag21/20)).*exp(1i*med_phase21/180*pi));




air_file = '7-14-air.s2p';
frequency = dlmread(air_file,' ',9,0,[9 0 209 0])/1e9;
air_mag11 = dlmread(air_file,' ',9,1,[9 1 209 1]);
air_phase11 = dlmread(air_file,' ',9,2,[9 2 209 2]);
air_mag21 = dlmread(air_file,' ',9,3,[9 3 209 3]);
air_phase21 = dlmread(air_file,' ',9,4,[9 4 209 4]);
air_mag12 = dlmread(air_file,' ',9,5,[9 5 209 5]);
air_phase12 = dlmread(air_file,' ',9,6,[9 6 209 6]);
air_mag22 = dlmread(air_file,' ',9,7,[9 7 209 7]);
air_phase22 = dlmread(air_file,' ',9,8,[9 8 209 8]);
air=complex((10.^(air_mag21/20)).*exp(1i*air_phase21/180*pi));





% plot(10.^(air_mag21/20))
% hold on
% plot(10.^(med_mag21/20))
% 
% figure
% plot(frequency,(10.^(med_mag21/20))./(10.^(air_mag21/20)))

% plot(real(air))
% hold on
% plot(imag(air))
% plot(real(med))
% plot(imag(med))

figure(1)
plot(frequency,abs(med./air))
hold on
grid on
time_air=ifft(air,8000);
time_med=ifft(med,8000);

figure(2)
plot(abs(time_air))
hold on
plot(abs(time_med))
xlim([1 2001])

[tt,c1]=max(abs(time_air));
t=zeros(length(time_air),1);
t(:,1)=1:1:length(t);
t_win=exp(-(t-c1).^2/25000);
figure(2)
plot(t_win*tt,'g--','linewidth',2)
xlim([1 500])



time_air_filter=t_win.*time_air;
time_med_filter=t_win.*time_med;
figure(3)
plot(abs(time_air_filter))
hold on
plot(abs(time_med_filter))
xlim([1 2001])


air2=fft(time_air_filter);
med2=fft(time_med_filter);

air3=air2(1:201);
med3=med2(1:201);

beta=2*pi*frequency*1e9/c0;
med4=med3./air3.*exp(-1i*beta*20e-3);

figure(1)
plot(frequency,abs(med4))
hold on

figure(5)
plot(frequency,angle(med4)/pi*180)
hold on

d=20e-3;
fa=frequency*1e9
for iy=1:length(fa)
    
    z=0;
    f=fa(iy);
    w=2*pi*f;
    
    e0=1;
    
e1=(2.3-1i*0);
% e1=900;
    e2=1;
    
    n0=1;
    n1=sqrt(e1);
    n2=1;
    
    th0=0;
    th1=asin(1/n1*n0*sin(th0));
    th2=asin(1/n2*n0*sin(th0));
    
    neta0=sqrt(mu0/eps0)/n0;
    neta1=sqrt(mu0/eps0)/n1;
    neta2=sqrt(mu0/eps0)/n2;
    
    F01=(neta1/cos(th1)-neta0/cos(th0))./(neta1/cos(th1)+neta0/cos(th0));
    F10=-F01;
    F12=(neta2/cos(th2)-neta1/cos(th1))./(neta2/cos(th2)+neta1/cos(th1));
    T01=1+F01;
    T10=1-F01;
    T12=1+F12;
    
    
    L0=c0/f/n0;
    L1=L0/n1;
    L2=L0/n2;
    
    B0=2*pi/L0;
    BB0(iy)=B0;

    
    B1=2*pi/L1;
    B2=2*pi/L2;
    E0r(iy)=exp(1i*B0*z*cos(th0))*(F01+T01*F12*T10*exp(-1i*2*B1*d*cos(th1))/(1-F12*F10*exp(-1i*2*B1*d*cos(th1))));
    E0t(iy)=T01*T12*exp(-1i*B1*d*cos(th1))*exp(-1i*B0*(d-d)*cos(th0))/(1-F12*F10*exp(-1i*2*B1*d*cos(th1)));
    exp(-1i*B1*d*cos(th1));
    t12_a(iy,1)=exp(-1i*B0*230e-3);
    t21_a(iy,1)=exp(-1i*B0*230e-3);
    t11_a(iy,1)=0;
    t22_a(iy,1)=0;
%     
% 

% 
% 
% 
t11_true(iy,1)=E0r(iy);
t11_true2(iy,1)= F01;
t11_true3(iy,1)= F01-F01*(1-F01*F01)*exp(-1i*2*BB0(iy)*n1*d);

t12_true(iy,1)=E0t(iy);
t21_true(iy,1)=E0t(iy);    
t22_true(iy,1)=E0r(iy);    
end

figure(1)
plot(frequency,abs(t21_true))
grid on

figure(5)
plot(frequency,angle(t21_true)/pi*180)



grid on