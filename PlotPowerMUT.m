function [epsilon,diffepsilon]=PlotPowerMUT(matfilestruct,medfilestruct,activevolume,title_words)
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
lengthMed = 301;
medepsilon = zeros(lengthMat,length(medfilestruct.powers));
medepsilon2 = zeros(size(matepsilon));
for pow = 1:length(medfilestruct.powers)
    a_file_2 = sprintf(medfilestruct.airfile,medfilestruct.powers(pow));
    m_file_2 = sprintf(medfilestruct.mutfile,medfilestruct.powers(pow));
    m_file180_2 = sprintf(medfilestruct.mut180,medfilestruct.powers(pow));
    med_dat = HighPowerNonMag('coax75','wax',medfilestruct.width,a_file_2,m_file_2,m_file180_2,' ');
    if lengthMed == lengthMat
        medepsilon(:,pow) = med_dat.epsilon;
    else
        medepsilon2(:,pow) = interp1(med_dat.frequency,med_dat.epsilon,mat_dat.frequency);
    end
    legenddata{pow} = sprintf('Power = %d dBm',medfilestruct.powers(pow));
end
if lengthMed == lengthMat
    medepsilon=medepsilon2;
end
if matfilestruct.powers ~= medfilestruct.powers
    medepsilon = interp1(medfilestruct.powers,medepsilon,matfilestruct.powers);
end
%epsilon = Bruggeman(matepsilon, medepsilon, 1-activevolume);
epsilon = MaxwellGarnett(matepsilon, medepsilon, activevolume);

diffepsilon = epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(matfilestruct.powers)-1]);
%%
figure;
subplot(211)
plot(mat_dat.frequency/1e9,real(epsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
title(title_words)
legend(legenddata)
legend('Location','eastoutside')
grid on
subplot(212)
plot(mat_dat.frequency/1e9,-imag(epsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
legend(legenddata)
legend('Location','eastoutside')
grid on
%set(gca,'FontSize',14)
%%
figure;
contourf(matfilestruct.powers(2:end),mat_dat.frequency/1e9,real(diffepsilon)) %#ok<*COLND>
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Real permittivity %s',title_words))
figure;
contourf(matfilestruct.powers(2:end),mat_dat.frequency/1e9,-imag(diffepsilon))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Imaginary Permittivity %s',title_words))
