%Md Gaffar
% 3:48 PM
%email: gaffarm@purdue.edu


%#######################################################################
% multiple frequency in a waveguide environment
% sample has thickness delta, total length of the waveguide is d1+delta+d2
%#######################################################################
clear
clc
a=8e-3;
delta=2.274e-3;
d1=1e-3;
d2=1e-3;
eps0=8.85e-12;
mu0=4*pi*1e-7;
c=1/sqrt(eps0*mu0);
rad=pi/180;
Z0=377;
%*************************************************
M1r=load('S11_mag.txt');
M2r=load('S21_mag.txt');
P1r=load('S11_ph.txt');
P2r=load('S21_ph.txt');
Mag1=M1r(:,2);
Mag2=M2r(:,2);
Ph1=-unwrap(P1r(:,2),180);
Ph2=-unwrap(P2r(:,2),180);
%*************************************************
it=0;
f1=14e9; df=4e6; f2=18e9; Nf=floor((f2-f1)/df)+1;
f2=M1r(:,1)*1e9;
Nf=length(f2);
for it=1:Nf
f=f2(it); % must higher than the cut-off frequency in free space
Fr(it)=f;
w=2*pi*Fr(it); wave=c/f;
Rm(it)=Mag1(it)*exp(1i*Ph1(it)*rad);
Tm(it)=Mag2(it)*exp(1i*Ph2(it)*rad);
beta0(it)=sqrt((w/c)^2-(pi/a)^2);
end
%*********************************************************
% make use of equation from Thomas
nfreq=it;
for it=1:nfreq
Tt(it)=Tm(it)*exp(-1i*beta0(it)*(d1+d2)); %---T
Rr(it)=Rm(it)*exp(-1i*2*beta0(it)*d1); %---R
%*****************************************************
% to get Z2
b=(Rr(it)^2-Tt(it)^2+1)/(2*Rr(it));
R21=b+(sqrt(b^2-1));
R22=b-(sqrt(b^2-1));
Rn=nan;
if abs(R21)<=1
RR=R21; Rn=RR; %---R2
end
if abs(R22)<=1
RR=R22; Rn=RR;
end
if (abs(R21)<1 && abs(R22)<1) || (abs(R21)==1 && abs(R22)==1)
disp(['both solutions give |R|<1 for fghz = ',num2str(fghz)])
end
Z=(1+RR)/(1-RR);
sgn=1; if real(Z)<0, sgn=-1; end
Z2(it)=Z*sgn;
%------------------------------------------------------------------
k=0; % need to be determined
%------------------------------------------------------------------
K=Rr(it)^2-Tt(it)^2+1;
r1=(K+sqrt(K^2-4*Rr(it)^2))/2/Rr(it);
r2=(K-sqrt(K^2-4*Rr(it)^2))/2/Rr(it);
if abs(r1)<=1
r=r1;
end
if abs(r2)<=1
r=r2;
end
t=(Rr(it)+Tt(it)-r)/(1-r*(Rr(it)+Tt(it)));
gamma=(1i*2*k*pi-log(t))/delta;
gamma0=-1i*2*pi*sqrt(Fr(it)^2*mu0*eps0-(1/2/a)^2);
Mr(it)=mu0*(gamma*(1+r)/gamma0/(1-r));
Er(it)=(((1/2/a)^2-(gamma/2/pi)^2)/Mr(it)/Fr(it)^2);
Mre(it)=Mr(it)/mu0;
Ere(it)=Er(it)/eps0;
n2(it)=Mre(it)/Z2(it);
end % end of frequency loop
figure(1)
subplot(121);
plot(Fr/1e9,real(Mre));
xlabel('Frequency in GHz')
ylabel('Re(\mu)')
subplot(122)
plot(Fr/1e9,imag(Mre));
xlabel('Frequency in GHz')
ylabel('Im(\mu)')
figure(2)
subplot(121);
plot(Fr/1e9,real(Ere));
xlabel('Frequency in GHz')
ylabel('Re(\epsilon)')
subplot(122)
plot(Fr/1e9,imag(Ere));
xlabel('Frequency in GHz')
ylabel('Im(\epsilon)')
figure(3)
subplot(121);
plot(Fr/1e9,real(n2));
xlabel('Frequency in GHz')
ylabel('Re(n)')
subplot(122)
plot(Fr/1e9,imag(n2));
xlabel('Frequency in GHz')
ylabel('Im(n)')
figure(4)
subplot(121);
plot(Fr/1e9,real(Z2));
xlabel('Frequency in GHz')
ylabel('Re(Z)')
subplot(122)
plot(Fr/1e9,imag(Z2));
xlabel('Frequency in GHz')
ylabel('Im(Z)')