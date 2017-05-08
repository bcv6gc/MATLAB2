wavelength = 0.85; %um
d = 9.83; % um
n1 = 1.5;
n2 = 1.49;
%theta = linspace(0,2*pi,1e3);
theta = linspace(0,pi,1e3);
thetac = asin(n2/n1);
y = sqrt((sin(thetac))^2./(sin(theta)).^2 - 1);
x = zeros(12,1e2);
theta1 = x;
plot(theta,y)
hold on
for m = 0:33
    theta1(m+1,:) = linspace(wavelength/(2*d)*m,wavelength/(2*d)*(m+1)-1/1000,1e2);
    x(m+1,:) = tan(pi*d*theta1(m+1,:)/wavelength - m*pi/2);
    plot(theta1(m+1,:),x(m+1,:))
    plot([max(theta1(m+1,:)) max(theta1(m+1,:))], [0 10],'k--')
end
%plot(theta1(1,:),x(1,:),theta1(2,:),x(2,:),theta,y) 
ylim([0 10])
xlim([0 1.5])
xlabel('sin \theta')
title('Number of TE modes')
