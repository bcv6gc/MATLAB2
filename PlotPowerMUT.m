function [matout,medout,diffout]=PlotPowerMUT(matfilestruct,medfilestruct,activevolume,title_words)
% This function has inputs: files which is a struct of files inculding the
% air file, material file, and the material 180 file. These are passed with
% the range of powers that these air and material files are tested under.
%@@@ I just copied over PlotPowerDependent, the idea is to take away the
%effects of both power and media
lengthMat = 301;
matepsilon = zeros(lengthMat,length(matfilestruct.powers));
for pow = 1:length(matfilestruct.powers)
    a_file = sprintf(matfilestruct.airfile,matfilestruct.powers(pow));
    m_file = sprintf(matfilestruct.mutfile,matfilestruct.powers(pow));
    m_file180 = sprintf(matfilestruct.mut180,matfilestruct.powers(pow));
    mat_dat = HighPowerNonMag('coax75','wax',matfilestruct.width,a_file,m_file,m_file180,' ');
    matepsilon(:,pow) = mat_dat.epsilon;
    legenddata{pow} = sprintf('Power = %d dBm',matfilestruct.powers(pow)); %#ok<AGROW>
end
matout.epsilon = matepsilon;
matout.legend = legenddata;
matout.frequency = mat_dat.frequency;
matout.powers = matfilestruct.powers;
lengthMed = 301;
medepsilon = zeros(lengthMat,length(medfilestruct.powers));

for pow = 1:length(medfilestruct.powers)
    a_file_2 = sprintf(medfilestruct.airfile,medfilestruct.powers(pow));
    m_file_2 = sprintf(medfilestruct.mutfile,medfilestruct.powers(pow));
    m_file180_2 = sprintf(medfilestruct.mut180,medfilestruct.powers(pow));
    med_dat = HighPowerNonMag('coax75','wax',medfilestruct.width,a_file_2,m_file_2,m_file180_2,' ');
    medepsilon(:,pow) = med_dat.epsilon;
    legenddata{pow} = sprintf('Power = %d dBm',medfilestruct.powers(pow));
end

medout.epsilon = medepsilon;
medout.legend = legenddata;
medout.frequency = med_dat.frequency;
medout.powers = medfilestruct.powers;
%diffout.epsilon = Bruggeman(matepsilon, medepsilon, 1-activevolume);
%diffout.epsilon = MaxwellGarnett(matepsilon, medepsilon, activevolume);
diffout.epsilon = InversePowerLaw(real(matepsilon), real(medepsilon), activevolume)...
    + 1i*InversePowerLaw(imag(matepsilon), imag(medepsilon), activevolume);


%%
%{
figure;
subplot(211)
plot(mat_dat.frequency/1e9,real(matepsilon)-real(medepsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
title(title_words)
legend(legenddata)
legend('Location','eastoutside')
grid on
subplot(212)
plot(mat_dat.frequency/1e9,-(imag(medepsilon)-imag(matepsilon)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
legend(legenddata)
legend('Location','eastoutside')
grid on
%}
%%
figure;
subplot(211)
plot(mat_dat.frequency/1e9,real(matepsilon(:,1)),mat_dat.frequency/1e9,real(medepsilon(:,1)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
title(title_words)
legend('BaTiO_3 + Wax','Wax')
legend('Location','eastoutside')
grid on
subplot(212)
plot(mat_dat.frequency/1e9,imag(matepsilon(:,1)),mat_dat.frequency/1e9,imag(medepsilon(:,1)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
legend('BaTiO_3 + Wax','Wax')
legend('Location','eastoutside')
grid on
%set(gca,'FontSize',14)
%%
%{
figure;
contourf(matfilestruct.powers,mat_dat.frequency(50:end,:)/1e9,real(diffout.epsilon(50:end,:)))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Real permittivity %s',title_words))
figure;
contourf(matfilestruct.powers,mat_dat.frequency(50:end,:)/1e9,-imag(diffout.epsilon(50:end,:)))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Imaginary Permittivity %s',title_words))
%}
figure;
contourf(matfilestruct.powers,mat_dat.frequency(50:end,:)/1e9,real(matepsilon(50:end,:))-real(medepsilon(50:end,:)))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Real permittivity %s',title_words))
figure;
contourf(matfilestruct.powers,mat_dat.frequency(50:end,:)/1e9,-(imag(matepsilon(50:end,:))-imag(medepsilon(50:end,:))))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Imaginary Permittivity %s',title_words))
