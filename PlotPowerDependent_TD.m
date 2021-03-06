function [perms,diffPerms]=PlotPowerDependent_TD(airfile,matfile,mat180,powers,width,title_words)
% This function has inputs: files which is a struct of files inculding the
% air file, material file, and the material 180 file. These are passed with
% the range of powers that these air and material files are tested under.
epsilon = zeros(301,length(powers));
mu = epsilon;
for pow = 1:length(powers)
    a_file = sprintf(airfile,powers(pow));
    m_file = sprintf(matfile,powers(pow));
    m_file180 = sprintf(mat180,powers(pow));
    mat_dat = HighPowerNonMag('coax75','wax',width,a_file,m_file,m_file180,' ');
    epsilon(:,pow) = mat_dat.epsilon;
    legenddata{pow} = sprintf('Power = %d dBm',powers(pow)); %#ok<AGROW>
end
perms.epsilon = epsilon;
perms.mu = mu;
diffEpsilon = diff(epsilon,1,2);
diffMu = diff(mu,1,2);
diffPerms.epsilon = diffEpsilon;
diffPerms.mu = diffMu;
%%
figure;
subplot(211)
plot(mat_dat.frequency/1e9,real(epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(powers)-1])))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime_r')
title(title_words)
legend(legenddata{2:end})
legend('Location','eastoutside')
grid on
subplot(212)
plot(mat_dat.frequency/1e9,-imag(epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(powers)-1])))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime_r')
legend(legenddata{2:end})
legend('Location','eastoutside')
grid on
%set(gca,'FontSize',14)
%%
figure;
contourf(powers(2:end),mat_dat.frequency/1e9,real(epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(powers)-1])))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Real permittivity %s',title_words))
figure;
contourf(powers(2:end),mat_dat.frequency/1e9,-imag(epsilon(:,2:end) - repmat(epsilon(:,1),[1,length(powers)-1])))
xlabel('power (dBm)')
ylabel('frequency (GHz)')
colorbar
title(sprintf('Imaginary permittivity %s',title_words))
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
