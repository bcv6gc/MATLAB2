% Problems 7.3 Jackson

n = 1.5;
theta1 = 30/180*pi;
theta2 = 45/180*pi;
theta3 = 60/180*pi;
x = linspace(0,2,500)*(2*pi);
gamma30 = -(n .* cos(theta1))./(sqrt(n^2.*sin(theta1).^2) -1);
eta30 = x.*(sqrt(n^2.*sin(theta1).^2) -1);
R30 = (4.*gamma30.^2)./(4*gamma30.^2+(1+gamma30.^2).^2.*sinh(eta30).^2);
gamma45 = -(n .* cos(theta2))./(sqrt(n^2.*sin(theta2).^2) -1);
eta45 = x.*(sqrt(n^2.*sin(theta2).^2) -1);
R45 = (4.*gamma45.^2)./(4*gamma45.^2+(1+gamma45.^2).^2.*sinh(eta45).^2);
gamma60 = -(n .* cos(theta3))./(sqrt(n^2.*sin(theta3).^2) -1);
eta60 = x.*(sqrt(n^2.*sin(theta3).^2) -1);
R60 = (4.*gamma60.^2)./(4*gamma60.^2+(1+gamma60.^2).^2.*sinh(eta60).^2);
plot(x/(2*pi),R30,x/(2*pi),R45,x/(2*pi),R60)
xlabel('Width (d\omega)')
ylabel('Transmission')
legend('30^{\circ}','45^{\circ}','60^{\circ}')
legend('boxoff')
grid on
set(gca,'FontSize',14)
print('7p3','-dpng')
%%
n1 = 2;
n2 = 4;
n3 = 1;
kd = linspace(0,2,1000);
R1 = (n2^2*(n1 - n3)^2+(n2^2-n3^2)*(n2^2-n1^2)*sin(n2*kd).^2)./...
    (n2^2*(n1 + n3)^2+(n2^2-n3^2)*(n2^2-n1^2)*sin(n2*kd).^2);
T1 = (4*n1*n2^2*n3)./...
    (n2^2*(n1 + n3)^2+(n2^2-n3^2)*(n2^2-n1^2)*sin(n2*kd).^2);
plot(kd,R1,kd,T1)
legend('Reflection','Transmission')
legend('boxoff')
xlabel('width (d \omega)')
ylabel('Amplitude')
grid on
title('Index (n_1 = 2,  n_2 = 4, n_3 = 1)')
set(gca,'FontSize',14)
print('7p2-241','-dpng')
%%
omega =linspace(0,10,1000);
te = (1 - 1./omega).^(-1/2);
tm = (1 - 1./omega).^(-1/2).*(1+omega);
plot(omega,te,omega,tm)
xlim([1 5])
ylim([0 10])
legend('TE Mode','TM Mode')
legend('boxoff')
xlabel('\omega/\omega_{mn}')
ylabel('\beta_{mn}')
set(gca,'FontSize',14)
grid on
print('8p2','-dpng')
%%
theta = linspace(0,2*pi,1000);
dp = sin(pi*cos(theta)).^2./(sin(theta).^2);
polarplot(theta,dp)
print('9p16','-dpng')
