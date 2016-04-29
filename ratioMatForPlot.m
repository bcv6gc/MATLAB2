function ratMat = ratioMatForPlot(imaginaryPermeability)
width = 1e-5; % 1 mm thickness
frequency = 10e9; % 10 GHz
omega = 2*pi*frequency;
numpoints = 1e2;
numControl = 1e2;
ratioPoints = 20;
%controls
rpt = logspace(0,4,numpoints);
ipt = logspace(0,4,numControl);
rpm = logspace(0,4,numpoints);
ipm = 1;
ratioRange = logspace(-4,4,ratioPoints);
%imagPermeability = linspace(1,100,numpoints);
transmission = zeros(numpoints,numpoints,numpoints);
reflection = zeros(size(transmission));
absorption = zeros(size(transmission));
ratioMapping = zeros(numpoints, numpoints);
for a = 1:length(rpt)
    for b = 1:length(rpm)
        [~,r] = min(abs(ratioRange - rpm(b)/rpt(a)));
        ratioMapping(a,b) = ratioRange(r);
        for c = 1:length(ipt)
            tempReflect = (((rpm(b) + 1i*ipm)/(rpt(a) + 1i*ipt(c)) - 1)/((rpm(b) + 1i*ipm)/(rpt(a) + 1i*ipt(c)) + 1))^2;
            alpha = omega*sqrt(2)*{(rpt(a)*rpm(b) - ipt(c)*ipm) * ...
                sqrt(1 + ((rpm(b)*ipt(c)+ipm*rpt(a))/(rpm(b)*rpt(a)-ipt(c)*ipm))^2)...
                - 1}^(1/2);
            reflection(a,b,c) = tempReflect;
            absTemp = exp(-alpha*width);
            absorption(a,b,c) = absTemp;
            transmission(a,b,c) = (1-tempReflect)*absTemp;
        end
    end
end
ratioReflMean = zeros(ratioPoints,numControl);
ratioTranMean = zeros(size(ratioReflMean));
for r = 1:length(ratioRange)
    ratioReflMean(r,:) = mean(reshape(reflection(repmat((ratioMapping == ratioRange(r)),1,1,numControl)),[],numControl),1);
    ratioTranMean(r,:) = mean(reshape(transmission(repmat((ratioMapping == ratioRange(r)),1,1,numControl)),[],numControl),1);
end
ratioReflect = (abs(ratioReflMean) > .8) - (abs(ratioReflMean) < .1);
ratioAbsorb = (abs(ratioTranMean) > .8) - (abs(ratioTranMean) < .1);
contourf(log(ipt), log(ratioRange), abs(ratioReflMean))
colorbar
ylabel('log of \mu/\epsilon ratio')
xlabel('Log of conductivity \sigma')
title('Reflection due to \mu/\epsilon and conductivity')
figure;
contourf(log(ipt), log(ratioRange), ratioReflect)
colorbar
ylabel('log of \mu/\epsilon ratio')
xlabel('Log of conductivity \sigma')
title('Reflection due to \mu/\epsilon and conductivity')