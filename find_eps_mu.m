%######################################################
% multiple frequency for plane wave incident on a panel
% sample has thickness d, free space case
%######################################################
clear
clc
%***************************************************
% constants
rad=pi/180;
eps0=8.85e-12;
mu0=4*pi*1e-7;
eta0=sqrt(mu0/eps0); % free space
c=1/sqrt(eps0*mu0);
%***************************************************
% variables
d=2e-2; % thickness of the sample
f1=2e9; df=18e6; f2=20e9; Nf=floor((f2-f1)/df)+1; % frequency range and
%***************************************************
% load raw data
%{
M1r=load('S11_mag.txt');
M2r=load('S21_mag.txt');
P1r=load('S11_ph.txt');
P2r=load('S21_ph.txt');
%}
thin_file = 'Calibrated_coax_20mmHDPE-7-28-16.s2p';
frequency = dlmread(thin_file,' ',9,0,[9 0 209 0])/1e9;
M1r = dlmread(thin_file,' ',9,1,[9 1 209 1]);
P1r = dlmread(thin_file,' ',9,2,[9 2 209 2]);
M2r = dlmread(thin_file,' ',9,3,[9 3 209 3]);
P2r = dlmread(thin_file,' ',9,4,[9 4 209 4]);
%{
Mag1=M1r(:,2);
Mag2=M2r(:,2);
Ph1=-unwrap(P1r(:,2),180);
Ph2=-unwrap(P2r(:,2),180);
f2=M1r(:,1)*1e9;
Nf=length(f2);
%}
Mag1 = M1r; Mag2 = M2r; Ph1 = -unwrap(P1r,180); Ph2 = -unwrap(P2r,180);
f2 = frequency*1e9; Nf = length(f2);
%*****************************************
% freqyency loop begin
for it=1:Nf
f=f2(it);
Fr(it)=f;
Fghz(it)=f/1e9;
fghz=f/1e9;
Z0=eta0; W=2*pi*Fr(it); beta0=W/c;
%*******************************************
% combine magnitude and phase of the S11 and S21
R(it)=Mag1(it)*exp(1i*Ph1(it)*rad);
T(it)=Mag2(it)*exp(1i*Ph2(it)*rad);
%*******************************************
% m loop begin
Max=0; % ---------m value set up
itt=0;
for m=-Max:Max
itt=itt+1;
%***************************************************
% using formulas from Robust method
Tp=T(it);
Z21(it)=sqrt(((1+R(it))^2-Tp^2)/((1-R(it))^2-Tp^2));
Z22(it)=-sqrt(((1+R(it))^2-Tp^2)/((1-R(it))^2-Tp^2));
expinkd1(it)=Tp/(1-R(it)*(Z21(it)-1)/(Z21(it)+1));
expinkd2(it)=Tp/(1-R(it)*(Z22(it)-1)/(Z22(it)+1));
if abs(real(Z21(it)))>=0.005 && real(Z21(it))>=0
expinkd(it)=expinkd1(it);
Z2(it)=Z21(it);
end
if abs(real(Z21(it)))>=0.005 && real(Z21(it))<0
expinkd(it)=expinkd2(it);
Z2(it)=Z22(it);
end
if abs(real(Z21(it)))<0.005 && abs(expinkd1(it))<=1
expinkd(it)=expinkd1(it);
Z2(it)=Z21(it);
end
if abs(real(Z21(it)))<0.005 && abs(expinkd1(it))>1
expinkd(it)=expinkd2(it);
Z2(it)=Z22(it);
end
ni(it)=-1/(beta0*d)*1i*real(log(expinkd(it))); % imag of n
nr(it,itt)=1/(beta0*d)*(imag(log(expinkd(it)))+2*m*pi); %real of n
n2(it,itt)=nr(it,itt)+ni(it);
Er2(it,itt)=n2(it,itt)/Z2(it);
Mr2(it,itt)=n2(it,itt)*Z2(it);
end % end of m loop
end % end of frequency loop
figure(1)
subplot(121);
plot(Fghz,real(Mr2));
xlabel('Frequency in GHz')
ylabel('Re(\mu)')
subplot(122)
plot(Fghz,imag(Mr2));
xlabel('Frequency in GHz')
ylabel('Im(\mu)')
figure(2)
subplot(121);
plot(Fghz,real(Er2));
xlabel('Frequency in GHz')
ylabel('Re(\epsilon)')
subplot(122)
plot(Fghz,imag(Er2));
xlabel('Frequency in GHz')
ylabel('Im(\epsilon)');
figure(3)
subplot(121);
plot(Fghz,real(n2));
xlabel('Frequency in GHz')
ylabel('Re(n)')
subplot(122)
plot(Fghz,imag(n2));
xlabel('Frequency in GHz')
ylabel('Im(n)')
figure(4)
subplot(121);
plot(Fghz,real(Z2));
xlabel('Frequency in GHz')
ylabel('Re(Z)')
subplot(122)
plot(Fghz,imag(Z2));
xlabel('Frequency in GHz')
ylabel('Im(Z)');
