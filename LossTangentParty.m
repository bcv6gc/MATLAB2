width = 1e-2; % m thickness
frequency = 10e9; % 10 GHz
omega = 2*pi*frequency;
numpoints = 50; % This are the knobs to turn 100
ratioPoints = numpoints;
e0 = 8.854e-12;
m0 = 1.256e-6;
%--------------------------------------------------------------------------
% controls
rptRel = logspace(0,4,numpoints);
conductivity = logspace(-10,10,numpoints);
iptRel = conductivity/(omega*e0);
rpmRel = logspace(0,4,numpoints);
ipmRel = logspace(-10,10,numpoints)/omega;
rpt = rptRel*e0;
ipt = iptRel*e0;
rpm = rpmRel*m0;
ipm = ipmRel*m0;
ratioRange = logspace(-10,6,ratioPoints);
reflection = zeros(ratioPoints,ratioPoints,1000);
absorption = reflection;
transmission = reflection;
maxReflect = zeros(ratioPoints,ratioPoints);
maxAbsorb = maxReflect;
for a = 1:length(ipt)
    for b = 1:length(rpt)
        [~,epsilon] = min(abs(ratioRange - ipt(b)/rpt(a)));
        for c = 1:length(ipm)
            for d = 1:length(rpm)
                [~,mu] = min(abs(ratioRange - ipm(c)/rpm(b)));
                n = sqrt((rpmRel(b) + 1i*ipmRel(d))/(rptRel(a) + 1i*iptRel(c)));
                tempReflect = abs((n - 1)/(n + 1))^2;
                cc = rpt(a)*rpm(b) - ipt(c)*ipm(d) + eps;
                s = sqrt(1 + ((rpm(b)*ipt(c)+ipm(d)*rpt(a))/cc)^2);
                alpha = omega*sqrt(2)*(cc * (s - 1))^(1/2);
                tempAbsorb = abs(exp(-alpha*width));
                reflNonZero = nnz(reflection(epsilon,mu,:));
                absNonZero = nnz(absorption(epsilon,mu,:));
                reflection(epsilon,mu,reflNonZero + 1) = tempReflect;
                absorption(epsilon,mu,absNonZero + 1) = tempAbsorb;
                maxReflect(epsilon,mu) = reflNonZero;
                maxAbsorb(epsilon,mu) = absNonZero;
            end
        end
    end
end
meanReflection = zeros(ratioPoints,ratioPoints);
meanAbsorption = meanReflection;
meanTransmission = meanReflection;
errorReflection = meanReflection;
errorAbsorption = meanReflection;
errorTransmission = meanReflection;
for a = 1:ratioPoints
    for b = 1:ratioPoints
        tempRefl = mean(nonzeros(reflection(a,b,:)));
        errorReflection(a,b) = std(nonzeros(reflection(a,b,:)));
        if isnan(tempRefl)
            tempRefl = 0;
        end
        if isnan(errorReflection(a,b))
            errorReflection(a,b) = 0;
        end
        meanReflection(a,b) = tempRefl;
        
        tempAbsorb = mean(nonzeros(absorption(a,b,:)));
        errorAbsorption(a,b) = std(nonzeros(absorption(a,b,:)));
        if isnan(tempAbsorb)
            tempAbsorb = 0;
        end
        if isnan(errorAbsorption(a,b))
            errorAbsorption(a,b) = 0;
        end
        meanAbsorption(a,b) = tempAbsorb;
    end
end

load('LossTangent.mat')

%{
subplot(2,2,1)
contourf(log10(ratioRange),log10(ratioRange),meanReflection)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Reflection due to \delta_e and \delta_m')

subplot(2,2,2)
contourf(log10(ratioRange),log10(ratioRange),meanAbsorption)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Absorption due to \delta_e and \delta_m')

subplot(2,2,3)
contourf(log10(ratioRange),log10(ratioRange),errorReflection)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Error in reflection due to \delta_e and \delta_m')

subplot(2,2,4)
contourf(log10(ratioRange),log10(ratioRange),errorAbsorption)
colorbar
ylabel('Electric Loss Tangent (\delta_e)')
xlabel('Magnetic Loss Tangent (\delta_m)')
title('Error in absorption due to \delta_e and \delta_m')
%}