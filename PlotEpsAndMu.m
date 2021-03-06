function PlotEpsAndMu(dd20,dd25,dd30,dd35,dd40,dd45,dd50,material_width,material)
%{
figure;
plot(dd20.t_frequency/1e9,real(dd20.epsilont),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,real(dd20.epsilon),...
    dd20.frequency/1e9,real(dd25.epsilon),...
    dd20.frequency/1e9,real(dd30.epsilon),...
    dd20.frequency/1e9,real(dd35.epsilon),...
    dd20.frequency/1e9,real(dd40.epsilon),...
    dd20.frequency/1e9,real(dd45.epsilon),...
    dd20.frequency/1e9,real(dd50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity \epsilon\prime')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Real permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured real \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.t_frequency/1e9,real(dd20.mut),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,real(dd20.mu),...
    dd20.frequency/1e9,real(dd25.mu),...
    dd20.frequency/1e9,real(dd30.mu),...
    dd20.frequency/1e9,real(dd35.mu),...
    dd20.frequency/1e9,real(dd40.mu),...
    dd20.frequency/1e9,real(dd45.mu),...
    dd20.frequency/1e9,real(dd50.mu))
xlabel('frequency (GHz)')
ylabel('relative permeability \mu\prime')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Real permeability (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured real \mu at different power levels for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.t_frequency/1e9,imag(dd20.epsilont),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,imag(dd20.epsilon),...
    dd20.frequency/1e9,imag(dd25.epsilon),...
    dd20.frequency/1e9,imag(dd30.epsilon),...
    dd20.frequency/1e9,imag(dd35.epsilon),...
    dd20.frequency/1e9,imag(dd40.epsilon),...
    dd20.frequency/1e9,imag(dd45.epsilon),...
    dd20.frequency/1e9,imag(dd50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Imaginary permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Power dependence of \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.t_frequency/1e9,imag(dd20.mut),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,imag(dd20.mu),...
    dd20.frequency/1e9,imag(dd25.mu),...
    dd20.frequency/1e9,imag(dd30.mu),...
    dd20.frequency/1e9,imag(dd35.mu),...
    dd20.frequency/1e9,imag(dd40.mu),...
    dd20.frequency/1e9,imag(dd45.mu),...
    dd20.frequency/1e9,imag(dd50.mu))
xlabel('frequency (GHz)')
ylabel('relative permeability')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Imaginary permeability (%0.2g mm %s sample)',material_width*1e3,material))
%title('Power dependence of \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.t_frequency/1e9,real(dd20.epsilont),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,real(dd20.epsilon),...
    dd20.frequency/1e9,real(dd25.epsilon),...
    dd20.frequency/1e9,real(dd30.epsilon),...
    dd20.frequency/1e9,real(dd35.epsilon),...
    dd20.frequency/1e9,real(dd40.epsilon),...
    dd20.frequency/1e9,real(dd45.epsilon),...
    dd20.frequency/1e9,real(dd50.epsilon))
plot(dd20.t_frequency/1e9,imag(dd20.epsilont),'k','LineWidth',2)
plot(dd20.frequency/1e9,imag(dd20.epsilon),...
    dd20.frequency/1e9,imag(dd25.epsilon),...
    dd20.frequency/1e9,imag(dd30.epsilon),...
    dd20.frequency/1e9,imag(dd35.epsilon),...
    dd20.frequency/1e9,imag(dd40.epsilon),...
    dd20.frequency/1e9,imag(dd45.epsilon),...
    dd20.frequency/1e9,imag(dd50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','east')
legend('boxoff')
title(sprintf('Permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
figure;
plot(dd20.t_frequency/1e9,real(dd20.mut),'k','LineWidth',2)
hold on
plot(dd20.frequency/1e9,real(dd20.mu),...
    dd20.frequency/1e9,real(dd25.mu),...
    dd20.frequency/1e9,real(dd30.mu),...
    dd20.frequency/1e9,real(dd35.mu),...
    dd20.frequency/1e9,real(dd40.mu),...
    dd20.frequency/1e9,real(dd45.mu),...
    dd20.frequency/1e9,real(dd50.mu))
plot(dd20.t_frequency/1e9,imag(dd20.mut),'k','LineWidth',2)
plot(dd20.frequency/1e9,imag(dd20.mu),...
    dd20.frequency/1e9,imag(dd25.mu),...
    dd20.frequency/1e9,imag(dd30.mu),...
    dd20.frequency/1e9,imag(dd35.mu),...
    dd20.frequency/1e9,imag(dd40.mu),...
    dd20.frequency/1e9,imag(dd45.mu),...
    dd20.frequency/1e9,imag(dd50.mu))
xlabel('frequency (GHz)')
ylabel('relative permeability')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','east')
legend('boxoff')
title(sprintf('Permeability (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured \mu at different power levels for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.frequency/1e9,(real(dd25.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100,...
    dd20.frequency/1e9,(real(dd30.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100,...
    dd20.frequency/1e9,(real(dd35.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100,...
    dd20.frequency/1e9,(real(dd40.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100,...
    dd20.frequency/1e9,(real(dd45.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100,...
    dd20.frequency/1e9,(real(dd50.epsilon)- real(dd20.epsilon))./real(dd20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%ylim([0 4])
figure;
plot(dd20.frequency/1e9,(imag(dd25.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100,...
    dd20.frequency/1e9,(imag(dd30.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100,...
    dd20.frequency/1e9,(imag(dd35.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100,...
    dd20.frequency/1e9,(imag(dd40.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100,...
    dd20.frequency/1e9,(imag(dd45.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100,...
    dd20.frequency/1e9,(imag(dd50.epsilon)- imag(dd20.epsilon))./imag(dd20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.frequency/1e9,(real(dd25.mu)- real(dd20.mu))./real(dd20.mu)*100,...
    dd20.frequency/1e9,(real(dd30.mu)- real(dd20.mu))./real(dd20.mu)*100,...
    dd20.frequency/1e9,(real(dd35.mu)- real(dd20.mu))./real(dd20.mu)*100,...
    dd20.frequency/1e9,(real(dd40.mu)- real(dd20.mu))./real(dd20.mu)*100,...
    dd20.frequency/1e9,(real(dd45.mu)- real(dd20.mu))./real(dd20.mu)*100,...
    dd20.frequency/1e9,(real(dd50.mu)- real(dd20.mu))./real(dd20.mu)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\mu\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \mu\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%ylim([0 4])
%%
figure;
plot(dd20.frequency/1e9,(real(dd20.epsilon)- real(dd25.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd30.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd35.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd40.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd45.epsilon)),...
    dd20.frequency/1e9,(real(dd20.epsilon)- real(dd50.epsilon)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\epsilon\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \mu\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd25.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd30.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd35.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd40.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd45.epsilon)),...
    dd20.frequency/1e9,(imag(dd20.epsilon)- imag(dd50.epsilon)))
xlabel('frequency (GHz)')
ylabel('\epsilon\prime\prime change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\epsilon\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \mu\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
%}
figure;
plot(dd20.frequency/1e9,(real(dd20.mu)- real(dd25.mu)),...
    dd20.frequency/1e9,(real(dd20.mu)- real(dd30.mu)),...
    dd20.frequency/1e9,(real(dd20.mu)- real(dd35.mu)),...
    dd20.frequency/1e9,(real(dd20.mu)- real(dd40.mu)),...
    dd20.frequency/1e9,(real(dd20.mu)- real(dd45.mu)),...
    dd20.frequency/1e9,(real(dd20.mu)- real(dd50.mu)))
xlabel('frequency (GHz)')
ylabel('\mu\prime change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\mu\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \mu\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(dd20.frequency/1e9,(imag(dd20.mu)- imag(dd25.mu)),...
    dd20.frequency/1e9,(imag(dd20.mu)- imag(dd30.mu)),...
    dd20.frequency/1e9,(imag(dd20.mu)- imag(dd35.mu)),...
    dd20.frequency/1e9,(imag(dd20.mu)- imag(dd40.mu)),...
    dd20.frequency/1e9,(imag(dd20.mu)- imag(dd45.mu)),...
    dd20.frequency/1e9,(imag(dd20.mu)- imag(dd50.mu)))
xlabel('frequency (GHz)')
ylabel('\mu\prime\prime change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Change in \\mu\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \mu\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(dd20.frequency/1e9) max(dd20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
end