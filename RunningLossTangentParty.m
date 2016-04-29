width = 1e-5; % m thickness
frequency = 10e9; % 10 GHz
omega = 2*pi*frequency;
numpoints = 50; 
ratioPoints = 50;
%--------------------------------------------------------------------------
% controls
realmax = 4;
imagmax = 4;
rpt = logspace(-4,realmax,numpoints);
ipt = logspace(-4,imagmax,numpoints);
rpm = rpt;
ipm = ipt;
ratioRange = logspace(-3,3,ratioPoints);
meanReflection = zeros(ratioPoints,ratioPoints);
meanAbsorption = meanReflection;
errorReflection = meanReflection;
errorAbsorption = meanReflection;
maxReflect = reflection;
maxAbsorb = maxReflect;
% Need to do first case
for a = 1:length(ipt)
    for b = 1:length(rpt)
        [~,epsilon] = min(abs(ratioRange - ipt(b)/rpt(a)));
        for c = 1:length(ipm)
            for d = 1:length(rpm)
                [~,mu] = min(abs(ratioRange - ipm(c)/rpm(b)));
                n = sqrt((rpm(b) + 1i*ipm(d))/(rpt(a) + 1i*ipt(c)));
                tempReflect = abs((n - 1)/(n + 1))^2;
                cc = rpt(a)*rpm(b) - ipt(c)*ipm(d) + eps;
                s = sqrt(1 + ((rpm(b)*ipt(c)+ipm(d)*rpt(a))/cc)^2);
                alpha = omega*sqrt(2)*(cc * (s - 1))^(1/2);
                tempAbsorb = abs(exp(-alpha*width));
                
                maxReflect(epsilon,mu) = reflNonZero;
                maxAbsorb(epsilon,mu) = absNonZero;
            end
        end
    end
end


subplot(2,2,1)
contourf(log(ratioRange),log(ratioRange),meanReflection)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Reflection due to \delta_e and \delta_m')
ax = gca;
ax.YTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
ax.YAxis.TickLabelFormat = '%2.0e';
ax.XTickLabel = {'1e-5','0','1e5'};
ax.XAxis.TickLabelFormat = '%2.0e';

subplot(2,2,2)
contourf(log(ratioRange),log(ratioRange),meanAbsorption)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Absorption due to \delta_e and \delta_m')
%caxis([0,0.4])
bx = gca;
bx.YTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
bx.YAxis.TickLabelFormat = '%2.0e';
bx.XTickLabel = {'1e-5','0','1e5'};
bx.XAxis.TickLabelFormat = '%2.0e';


subplot(2,2,3)
contourf(log(ratioRange),log(ratioRange),errorReflection)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Error in reflection due to \delta_e and \delta_m')
%caxis([0,0.6])
cx = gca;
cx.YTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
cx.YAxis.TickLabelFormat = '%2.0e';
cx.XTickLabel = {'1e-5','0','1e5'};
cx.XAxis.TickLabelFormat = '%2.0e';


subplot(2,2,4)
contourf(log(ratioRange),log(ratioRange),errorAbsorption)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Error in absorption due to \delta_e and \delta_m')
dx = gca;
dx.YTickLabel = {'1e-6','1e-4','1e-2','0','1e2','1e4','1e6'};
dx.YAxis.TickLabelFormat = '%2.0e';
dx.XTickLabel = {'1e-5','0','1e5'};
dx.XAxis.TickLabelFormat = '%2.0e';
