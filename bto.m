powers = 20:2:50;
epsilon = zeros(201,length(powers));
mu = epsilon;
for pow = 1:length(powers)
    %
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_BTO-5%%-300nm-flipped_5p75mm_%ddbm_3-23-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_BTO-5%%-300nm-flipped_5p75mm_%ddbm_3-23-17.dat',powers(pow));
    width = 0.00575;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_BTO-5%%-500nm_5p43mm_%ddbm_3-23-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_BTO-5%%-500nm-flipped_5p43mm_%ddbm_3-23-17.dat',powers(pow));
    width = 0.00543;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-23-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_STO-5%%-100nm_5p80%ddbm_3-23-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_STO-5%%-100nm-flipped_5p80%ddbm_3-23-17.dat',powers(pow));
    width = 0.0058;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_10_p_YIG_6p03mm_%ddbm_3-24-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_10_p_YIG-flipped_6p03mm_%ddbm_3-24-17.dat',powers(pow));
    width = 0.00603;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_20_p_z5u_4p54%ddbm_3-24-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_20_p_z5u-flipped_4p54_%ddbm_3-24-17.dat',powers(pow));
    width = 0.00564;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_1_p_Y5V_5p00mm_%ddbm_3-24-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_1_p_Y5V-flipped_5p00mm_%ddbm_3-24-17.dat',powers(pow));
    width = 0.005;
    %}
    %{
    airfile = sprintf('75mm_coax_air_%ddbm_3-24-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_1_p_Y5V_5p00mm_%ddbm_3-24-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_1_p_Y5V-flipped_5p00mm_%ddbm_3-24-17.dat',powers(pow));
    width = 0.005;
    %}
    %{
    airfile = sprintf('75mm_coax_airline_NA_mm_%ddbm_4-5-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_BTO_300nm_10p_4p17_mm_%ddbm_4-5-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_BTO_300nm_10p_180_4p17_mm_%ddbm_4-5-17.dat',powers(pow));
    width = 0.00417;
    %}
    %{
    airfile = sprintf('75mm_coax_airline_NA_mm_%ddbm_4-5-17.dat',powers(pow));
    matfile = sprintf('75mm_coax_BTO_300nm_20p_4p95_mm_%ddbm_4-5-17.dat',powers(pow));
    matfile180 = sprintf('75mm_coax_BTO_300nm_20p_180_4p95_mm_%ddbm_4-5-17.dat',powers(pow));
    width = 0.00495;
    %}
    %
    bto_dat = HighPowerPerms2('coax75','wax',width,airfile,matfile,matfile180,' ');
    epsilon(:,pow) = bto_dat.epsilon;
    mu(:,pow) = bto_dat.mu; 
    %}
    %{
    bto_dat = HighPowerNonMag('coax75','wax',width,airfile,matfile,matfile180,' ');
    epsilon(:,pow) = bto_dat.epsilon;
    %}
end
diffEpsilon = diff(epsilon,1,2);
figure;
subplot(211)
plot(bto_dat.frequency/1e9,real(diffEpsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
%title(matfile)
grid on
subplot(212)
plot(bto_dat.frequency/1e9,imag(diffEpsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
grid on
%{
diffMu = diff(mu,1,2);
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
contourf(powers(2:end),bto_dat.frequency/1e9,real(diffEpsilon))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('Power response of \epsilon\prime')
colorbar
figure;
contourf(powers(2:end),bto_dat.frequency/1e9,-imag(diffEpsilon))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
title('Power response of \epsilon\prime\prime')
caxis([0 0.025])
colorbar
