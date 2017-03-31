epsilon = zeros(201,41);
mu = epsilon;
for pow = 10:50
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',pow);
    matfile = sprintf('75mm_coax_BTO-5%%-300nm-flipped_5p75mm_%ddbm_3-23-17.dat',pow);
    matfile180 = sprintf('75mm_coax_BTO-5%%-300nm-flipped_5p75mm_%ddbm_3-23-17.dat',pow);
    width = 0.00575;
    %}
    %
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',pow);
    matfile = sprintf('75mm_coax_BTO-5%%-500nm_5p43mm_%ddbm_3-23-17.dat',pow);
    matfile180 = sprintf('75mm_coax_BTO-5%%-500nm-flipped_5p43mm_%ddbm_3-23-17.dat',pow);
    width = 0.00543;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',pow);
    matfile = sprintf('75mm_coax_STO-5%%-100nm_5p80%ddbm_3-23-17.dat',pow);
    matfile180 = sprintf('75mm_coax_STO-5%%-100nm-flipped_5p80%ddbm_3-23-17.dat',pow);
    width = 0.0058;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',pow);
    matfile = sprintf('75mm_coax_10_p_YIG_6p03mm_%ddbm_3-24-17.dat',pow);
    matfile180 = sprintf('75mm_coax_10_p_YIG-flipped_6p03mm_%ddbm_3-24-17.dat',pow);
    width = 0.00603;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',pow);
    matfile = sprintf('75mm_coax_20_p_z5u_4p54%ddbm_3-24-17.dat',pow);
    matfile180 = sprintf('75mm_coax_20_p_z5u-flipped_4p54_%ddbm_3-24-17.dat',pow);
    width = 0.00564;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',pow);
    matfile = sprintf('75mm_coax_1_p_Y5V_5p00mm_%ddbm_3-24-17.dat',pow);
    matfile180 = sprintf('75mm_coax_1_p_Y5V-flipped_5p00mm_%ddbm_3-24-17.dat',pow);
    width = 0.005;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',pow);
    matfile = sprintf('75mm_coax_1_p_Y5V_5p00mm_%ddbm_3-24-17.dat',pow);
    matfile180 = sprintf('75mm_coax_1_p_Y5V-flipped_5p00mm_%ddbm_3-24-17.dat',pow);
    width = 0.005;
    %}
    %
    bto_dat = HighPowerPerms2('coax75','wax',width,airfile,matfile,matfile180,' ');
    %bto_dat = HighPowerNonMag('coax75','wax',width,airfile,matfile,matfile180,' ');
    epsilon(:,pow-9) = bto_dat.epsilon;
    mu(:,pow-9) = bto_dat.mu;    
end
diffEpsilon = diff(epsilon,1,2);
diffMu = diff(mu,1,2);
figure;
subplot(211)
plot(bto_dat.frequency/1e9,real(diffEpsilon(:,30:end)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
grid on
subplot(212)
plot(bto_dat.frequency/1e9,imag(diffEpsilon(:,30:end)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
grid on
%
figure;
subplot(211)
plot(bto_dat.frequency/1e9,real(diffMu))
xlabel('frequency (GHz)')
ylabel('\mu\prime_r')
subplot(212)
plot(bto_dat.frequency/1e9,imag(diffMu))
xlabel('frequency (GHz)')
ylabel('\mu\prime\prime_r')
%}
figure;
contourf(40:50,bto_dat.frequency/1e9,real(diffEpsilon(:,30:end)))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('Power response of \epsilon\prime')
colorbar
figure;
contourf(40:50,bto_dat.frequency/1e9,imag(diffEpsilon(:,30:end)))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('Power response of \epsilon\prime\prime')
colorbar
