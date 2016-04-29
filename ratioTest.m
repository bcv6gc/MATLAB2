width = 1e-4; % m thickness
frequency = 18e9; % 10GHz
omega = 2*pi*frequency;
numpoints = 100;
ratioPoints = 100;
e0 = 8.854e-12;
m0 = 1.256e-6;
%controls
rptRel = logspace(0,4,numpoints);
conductivity = logspace(-6,6,numpoints);
iptRel = conductivity/(omega*e0*100);
rpmRel = logspace(0,4,numpoints);
ipmRel = 1e-6;
rpt = rptRel*e0;
ipt = iptRel*e0;
rpm = rpmRel*m0;
ipm = ipmRel*m0;
ratioRange = logspace(-4,4,ratioPoints);
transmission = zeros(numpoints,numpoints,numpoints);
reflection = zeros(size(transmission));
absorption = zeros(size(transmission));
ratioMapping = zeros(numpoints, numpoints);
for a = 1:length(rpt)
    for b = 1:length(rpm)
        [~,r] = min(abs(ratioRange - rpmRel(b)/rptRel(a)));
        ratioMapping(a,b) = ratioRange(r);
        for c = 1:length(ipt)
            n = sqrt((rpmRel(b) + 1i*ipmRel)/(rptRel(a) + 1i*iptRel(c)));
            tempReflect = abs((n - 1)/(n + 1))^2;
            cc = rpt(a)*rpm(b) - ipt(c)*ipm;
            s = sqrt(1 + ((rpm(b)*ipt(c)+ipm*rpt(a))/cc)^2);
            alpha = omega*sqrt(2)*(cc * (s - 1))^(1/2);
            reflection(a,b,c) = tempReflect;
            absorption(a,b,c) = exp(-alpha*width);
            transmission(a,b,c) = (1-tempReflect)*exp(-alpha*width);
        end
    end
end
transmission(isnan(transmission)) = 0;
ratioReflMean = zeros(ratioPoints,numpoints);
ratioReflSTD = zeros(size(ratioReflMean));
ratioAbsMean = zeros(size(ratioReflMean));
ratioAbsSTD = zeros(size(ratioReflMean));
ratioTranMean = zeros(size(ratioReflMean));
ratioTranSTD = zeros(size(ratioReflMean));
for r = 1:length(ratioRange)
    ratioReflMean(r,:) = mean(reshape(reflection(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
    ratioReflSTD(r,:) = std(reshape(reflection(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
    ratioAbsMean(r,:) = mean(reshape(absorption(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
    ratioAbsSTD(r,:) = std(reshape(absorption(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
    ratioTranMean(r,:) = mean(reshape(transmission(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
    ratioTranSTD(r,:) = std(reshape(transmission(repmat((ratioMapping == ratioRange(r)),1,1,ratioPoints)),[],ratioPoints),1);
end

%ratioReflect = (abs(ratioReflMean) > .8) - (abs(ratioReflMean) < .1);
%ratioAbsorb = (abs(ratioTranMean) > .8) - (abs(ratioTranMean) < .1);
fs = 16;
figure;
%subplot(2,3,1)
contourf(log10(conductivity), log10(ratioRange), abs(ratioReflMean))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/cm)','FontSize',fs)
title('R, due to \mu\prime/\epsilon\prime and \sigma, f=18Ghz, \mu\prime\prime = 1e-6, thickness = 100\mu m','FontSize',fs)
caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
grid on
print('Reflection_mudp_1e-6_f_18Ghz_1e-4thick', '-dpng')
%
figure;
%subplot(2,3,2)
contourf(log10(conductivity), log10(ratioRange), abs(ratioAbsMean))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/cm)','FontSize',fs)
title('A, due to \mu\prime/\epsilon\prime and \sigma, f=18Ghz, \mu\prime\prime = 1e-6, thickness = 100\mu m','FontSize',fs)
caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
grid on
print('Absoprtion_mudp_1e-6_f_18Ghz_1e-4thick', '-dpng')

figure;
%subplot(2,3,3)
contourf(log10(conductivity), log10(ratioRange), abs(ratioTranMean))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/cm)','FontSize',fs)
title('T, due to \mu\prime/\epsilon\prime and \sigma, f=18Ghz, \mu\prime\prime = 1e-6, thickness = 100\mu m','FontSize',fs)
caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
grid on
print('Transmission_mudp_1e-6_f_18Ghz_1e-4thick', '-dpng')
%{
figure;
%subplot(2,3,4)
contourf(log10(conductivity), log10(ratioRange), abs(ratioReflSTD))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/m)','FontSize',fs)
title('\Delta R, due to \mu\prime/\epsilon\prime and \sigma, f=1Ghz, \mu\prime\prime = 1e-2, thickness = 1e-4','FontSize',fs)
%caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-8','1e-6','1e-4','1e-2','0','1e2','1e4'};
grid on
print('Refelction_error_mu_imagp01_f_1Ghz', '-dpng')

figure
%subplot(2,3,5)
contourf(log10(conductivity), log10(ratioRange), abs(ratioAbsSTD))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/m)','FontSize',fs)
title('\Delta A, due to \mu\prime/\epsilon\prime and \sigma, f=1Ghz, \mu\prime\prime = 1e-2, thickness = 1e-4','FontSize',fs)
%caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-8','1e-6','1e-4','1e-2','0','1e2','1e4'};
grid on
print('Absorption_error_mu_imagp01_f_1Ghz', '-dpng')

figure;
%subplot(2,3,6)
contourf(log10(conductivity), log10(ratioRange), abs(ratioTranSTD))
colorbar
ylabel('\mu\prime/\epsilon\prime ratio','FontSize',fs)
xlabel('Conductivity \sigma (S/m)','FontSize',fs)
title('\Delta T, due to \mu\prime/\epsilon\prime and \sigma, f=1Ghz, \mu\prime\prime = 1e-2, thickness = 1e-4','FontSize',fs)
%caxis([0,1])
ax = gca;
ax.YTickLabel = {'1e-4','1e-3','1e-2','1e-1','0','1e1','1e2','1e3','1e4'};
ax.XTickLabel = {'1e-8','1e-6','1e-4','1e-2','0','1e2','1e4'};
grid on
print('Transmission_error_mu_imagp01_f_1Ghz', '-dpng')
%[ax4,h3]=suplabel('Reflection, Absorption, Transmission with \mu^{\prime\prime} = 0', 't');
%}