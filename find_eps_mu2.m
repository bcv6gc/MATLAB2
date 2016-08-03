% process_stripline
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
material_width = 20e-3;
%%
air_file = 'Calibrated_coax_air-7-28-16.s2p';
frequency = dlmread(air_file,' ',9,0,[9 0 209 0])/1e9;
air_mag11 = dlmread(air_file,' ',9,1,[9 1 209 1]);
air_phase11 = dlmread(air_file,' ',9,2,[9 2 209 2]);
air_mag21 = dlmread(air_file,' ',9,3,[9 3 209 3]);
air_phase21 = dlmread(air_file,' ',9,4,[9 4 209 4]);
air_mag12 = dlmread(air_file,' ',9,5,[9 5 209 5]);
air_phase12 = dlmread(air_file,' ',9,6,[9 6 209 6]);
air_mag22 = dlmread(air_file,' ',9,7,[9 7 209 7]);
air_phase22 = dlmread(air_file,' ',9,8,[9 8 209 8]);
air11=complex((10.^(air_mag11/20)).*exp(1i*air_phase11/180*pi));
air21=complex((10.^(air_mag21/20)).*exp(1i*air_phase21/180*pi));
air12=complex((10.^(air_mag12/20)).*exp(1i*air_phase12/180*pi));

medium_file = 'Calibrated_coax_20mmHDPE-7-28-16.s2p';
%medium_file = 'Calibrated_coax_5mmCoZn-7-28-16.s2p';
med_mag11 = dlmread(medium_file,' ',9,1,[9 1 209 1]);
med_phase11 = dlmread(medium_file,' ',9,2,[9 2 209 2]);
med_mag21 = dlmread(medium_file,' ',9,3,[9 3 209 3]);
med_phase21 = dlmread(medium_file,' ',9,4,[9 4 209 4]);
med_mag12 = dlmread(medium_file,' ',9,5,[9 5 209 5]);
med_phase12 = dlmread(medium_file,' ',9,6,[9 6 209 6]);
med_mag22 = dlmread(medium_file,' ',9,7,[9 7 209 7]);
med_phase22 = dlmread(medium_file,' ',9,8,[9 8 209 8]);
med11=complex((10.^(med_mag11/20)).*exp(1i*med_phase11/180*pi));
med21=complex((10.^(med_mag21/20)).*exp(1i*med_phase21/180*pi));
med12=complex((10.^(med_mag12/20)).*exp(1i*med_phase12/180*pi));

time_air11=ifft(air11,8000);
time_air21=ifft(air21,8000);
time_air12=ifft(air12,8000);
time_med11=ifft(med11,8000);
time_med21=ifft(med21,8000);
time_med12=ifft(med12,8000);
%% Time gating
[tt,c1]=max(abs(time_air21));
t=zeros(length(time_air21),1);
t(:,1)=1:1:length(t);
win_length = 25000;
t_win=exp(-(t-c1).^2/win_length);
%{
figure(2)
plot(t_win*tt,'g--','linewidth',2)
hold on
plot(t,abs(time_air21),t,abs(time_med21))
legend('air','material')
xlim([(c1 - 1000) (c1 + 1000)])
%}
time_air11_filter=t_win.*time_air11;
time_air21_filter=t_win.*time_air21;
time_air12_filter=t_win.*time_air12;
time_med11_filter=t_win.*time_med21;
time_med21_filter=t_win.*time_med21;
time_med12_filter=t_win.*time_med12;

temp_air11=fft(time_air11_filter);
temp_air21=fft(time_air21_filter);
temp_air12=fft(time_air12_filter);
temp_med11=fft(time_med11_filter);
temp_med21=fft(time_med21_filter);
temp_med12=fft(time_med12_filter);

filtered_air11=temp_air11(1:201);
filtered_air21=temp_air21(1:201);
filtered_air12=temp_air12(1:201);
filtered_med11=temp_med11(1:201);
filtered_med21=temp_med21(1:201);
filtered_med12=temp_med12(1:201);

beta=2*pi*frequency*1e9/c0;
s11=filtered_med11./filtered_air11.*exp(-1i*beta*material_width);
s21=filtered_med21./filtered_air21.*exp(-1i*beta*material_width);
s12=filtered_med12./filtered_air12.*exp(-1i*beta*material_width);
freq2 = frequency*1e9;
Nf=length(freq2);
%*****************************************
% freqyency loop begin
Fr = freq2;
Fghz = frequency;
fghz = frequency;
R = s11;
T = s21;
for it=1:Nf
%{
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
%}
Z0=eta0; W=2*pi*Fr(it); beta0=W/c;
Max=1; % ---------m value set up
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
plot(Fghz,abs(n2));
xlabel('Frequency in GHz')
ylabel('Re(n)')
subplot(122)
plot(Fghz,angle(n2));
xlabel('Frequency in GHz')
ylabel('Im(n)')
figure(4)
subplot(121);
plot(Fghz,abs(Z2));
xlabel('Frequency in GHz')
ylabel('Re(Z)')
subplot(122)
plot(Fghz,angle(Z2));
xlabel('Frequency in GHz')
ylabel('Im(Z)');
