function [epsilon,diffepsilon]=PlotPowerMUT(airfile,matfile,mat180,matwidth,matpowers,mediafile,mediafile180,medwidth,activevolume,medpowers,title_words)
% This function has inputs: files which is a struct of files inculding the
% air file, material file, and the material 180 file. These are passed with
% the range of powers that these air and material files are tested under.
%@@@ I just copied over PlotPowerDependent, the idea is to take away the
%effects of both power and media
lengthMat = 301;
matepsilon = zeros(lengthMat,length(matpowers));
for pow = 1:length(matpowers)
    a_file = sprintf(airfile,matpowers(pow));
    m_file = sprintf(matfile,matpowers(pow));
    m_file180 = sprintf(mat180,matpowers(pow));
    mat_dat = HighPowerNonMag('coax75','wax',matwidth,a_file,m_file,m_file180,' ');
    matepsilon(:,pow) = mat_dat.epsilon;
    legenddata{pow} = sprintf('Power = %d dBm',powers(pow)); %#ok<AGROW>
end
lengthMed = 301;
medepsilon = zeros(lengthMat,length(medpowers));
for pow = 1:length(medpowers)
    a_file = sprintf(airfile,medpowers(pow));
    m_file = sprintf(mediafile,medpowers(pow));
    m_file180 = sprintf(mediafile180,medpowers(pow));
    med_dat = HighPowerNonMag('coax75','wax',medwidth,a_file,m_file,m_file180,' ');
    if lengthMed == lengthMat
        medepsilon(:,pow) = med_dat.epsilon;
    else
        medepsilon(:,pow) = interp1(med_dat.frequency,med_dat.epsilon,mat_dat.frequency);
    end
    legenddata{pow} = sprintf('Power = %d dBm',powers(pow));
end
if matpowers ~= medpowers
    medepsilon = interp1(medpowers,medepsilon,matpowers);
end
epsilon = Bruggeman(matepsilon, medepsilon, activevolume);

diffepsilon = epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(powers)-1]);
%%
figure;
subplot(211)
plot(mat_dat.frequency/1e9,real(matepsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
title(title_words)
legend(legenddata)
legend('Location','eastoutside')
grid on
subplot(212)
plot(mat_dat.frequency/1e9,-imag(matepsilon))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
legend(legenddata)
legend('Location','eastoutside')
grid on
%set(gca,'FontSize',14)
%%
figure;
contourf(powers(2:end),mat_dat.frequency/1e9,real(diffepsilon)) %#ok<*COLND>
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Real permittivity %s',title_words))
figure;
contourf(powers(2:end),mat_dat.frequency/1e9,-imag(diffepsilon))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Imaginary Permittivity %s',title_words))
