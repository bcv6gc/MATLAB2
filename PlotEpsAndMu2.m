function PlotEpsAndMu2(dd20,dd30,dd35,dd40,dd45,dd50,material_width,material)
figure;
plot(dd20.frequency/1e9,(real(dd20.epsilon)- real(dd30.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd35.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd40.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd45.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd50.epsilon)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime change from 20dBm')
legend('30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\epsilon\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd30.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd35.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd40.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd45.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd50.epsilon)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime change from 20dBm')
legend('30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\epsilon\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on