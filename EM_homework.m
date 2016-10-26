%e_and_m_homeworkplot
x = linspace(0,6,1e4);
y1 = -1/pi*(1./((x-2).^2 +1) - 1./((x+2).^2 +1));
y2 = -1/pi*(1./((x-1).^2 +1) - 1./((x+1).^2 +1));
y3 = -2/pi*(1./((x-1).^2 +4) - 1./((x+1).^2 +4));
subplot(3,1,1)
plot(x,y1)
ylabel('\sigma / \lambda')
xlabel('x')
grid on
title('x_o = 2, y_0=1')
subplot(3,1,2)
plot(x,y2)
ylabel('\sigma / \lambda')
xlabel('x')
grid on
title('x_o = 1, y_0=1')
subplot(3,1,3)
plot(x,y3)
ylabel('\sigma / \lambda')
xlabel('x')
grid on
title('x_o = 1, y_0=2')