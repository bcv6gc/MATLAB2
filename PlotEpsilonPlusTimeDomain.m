function PlotEpsilonPlusTimeDomain(wb20,wb25,wb30,wb35,wb40,wb45,wb50,td20,td25,td30,td35,td40,td45,td50,material_width,material)
%%
figure;
plot(wb20.t_frequency/1e9,real(wb20.epsilont),'k','LineWidth',2)
hold on
plot(td20.frequency/1e9,real(td20.epsilon),...
    td20.frequency/1e9,real(td25.epsilon),...
    td20.frequency/1e9,real(td30.epsilon),...
    td20.frequency/1e9,real(td35.epsilon),...
    td20.frequency/1e9,real(td40.epsilon),...
    td20.frequency/1e9,real(td45.epsilon),...
    td20.frequency/1e9,real(td50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity \epsilon\prime')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Real permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured real \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(wb20.t_frequency/1e9,imag(wb20.epsilont),'k','LineWidth',2)
hold on
plot(td20.frequency/1e9,imag(td20.epsilon),...
    td20.frequency/1e9,imag(td25.epsilon),...
    td20.frequency/1e9,imag(td30.epsilon),...
    td20.frequency/1e9,imag(td35.epsilon),...
    td20.frequency/1e9,imag(td40.epsilon),...
    td20.frequency/1e9,imag(td45.epsilon),...
    td20.frequency/1e9,imag(td50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Imaginary permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Power dependence of \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(wb20.t_frequency/1e9,real(wb20.epsilont),'k','LineWidth',2)
hold on
plot(td20.frequency/1e9,real(td20.epsilon),...
    td20.frequency/1e9,real(td25.epsilon),...
    td20.frequency/1e9,real(td30.epsilon),...
    td20.frequency/1e9,real(td35.epsilon),...
    td20.frequency/1e9,real(td40.epsilon),...
    td20.frequency/1e9,real(td45.epsilon),...
    td20.frequency/1e9,real(td50.epsilon))
plot(wb20.t_frequency/1e9,imag(wb20.epsilont),'k','LineWidth',2)
plot(td20.frequency/1e9,imag(td20.epsilon),...
    td20.frequency/1e9,imag(td25.epsilon),...
    td20.frequency/1e9,imag(td30.epsilon),...
    td20.frequency/1e9,imag(td35.epsilon),...
    td20.frequency/1e9,imag(td40.epsilon),...
    td20.frequency/1e9,imag(td45.epsilon),...
    td20.frequency/1e9,imag(td50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','east')
legend('boxoff')
title(sprintf('Permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
%%
figure;
plot(wb20.t_frequency/1e9,real(wb20.epsilont),'k','LineWidth',2)
hold on
plot(wb20.frequency/1e9,real(wb20.epsilon),...
    wb20.frequency/1e9,real(wb25.epsilon),...
    wb20.frequency/1e9,real(wb30.epsilon),...
    wb20.frequency/1e9,real(wb35.epsilon),...
    wb20.frequency/1e9,real(wb40.epsilon),...
    wb20.frequency/1e9,real(wb45.epsilon),...
    wb20.frequency/1e9,real(wb50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity \epsilon\prime')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Real permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured real \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(wb20.t_frequency/1e9,imag(wb20.epsilont),'k','LineWidth',2)
hold on
plot(wb20.frequency/1e9,imag(wb20.epsilon),...
    wb20.frequency/1e9,imag(wb25.epsilon),...
    wb20.frequency/1e9,imag(wb30.epsilon),...
    wb20.frequency/1e9,imag(wb35.epsilon),...
    wb20.frequency/1e9,imag(wb40.epsilon),...
    wb20.frequency/1e9,imag(wb45.epsilon),...
    wb20.frequency/1e9,imag(wb50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Imaginary permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Power dependence of \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(wb20.t_frequency/1e9,real(wb20.epsilont),'k','LineWidth',2)
hold on
plot(wb20.frequency/1e9,real(wb20.epsilon),...
    wb20.frequency/1e9,real(wb25.epsilon),...
    wb20.frequency/1e9,real(wb30.epsilon),...
    wb20.frequency/1e9,real(wb35.epsilon),...
    wb20.frequency/1e9,real(wb40.epsilon),...
    wb20.frequency/1e9,real(wb45.epsilon),...
    wb20.frequency/1e9,real(wb50.epsilon))
plot(wb20.t_frequency/1e9,imag(wb20.epsilont),'k','LineWidth',2)
plot(wb20.frequency/1e9,imag(wb20.epsilon),...
    wb20.frequency/1e9,imag(wb25.epsilon),...
    wb20.frequency/1e9,imag(wb30.epsilon),...
    wb20.frequency/1e9,imag(wb35.epsilon),...
    wb20.frequency/1e9,imag(wb40.epsilon),...
    wb20.frequency/1e9,imag(wb45.epsilon),...
    wb20.frequency/1e9,imag(wb50.epsilon))
xlabel('frequency (GHz)')
ylabel('relative permittivity')
legend('reference','20dBm','25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','east')
legend('boxoff')
title(sprintf('Permittivity (%0.2g mm %s sample)',material_width*1e3,material))
%title('Measured \epsilon at different power levels for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
%%
figure;
plot(wb20.frequency/1e9,(real(wb25.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100,...
    wb20.frequency/1e9,(real(wb30.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100,...
    wb20.frequency/1e9,(real(wb35.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100,...
    wb20.frequency/1e9,(real(wb40.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100,...
    wb20.frequency/1e9,(real(wb45.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100,...
    wb20.frequency/1e9,(real(wb50.epsilon)- real(wb20.epsilon))./real(wb20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%ylim([0 4])
%%
figure;
plot(wb20.frequency/1e9,(imag(wb25.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100,...
    wb20.frequency/1e9,(imag(wb30.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100,...
    wb20.frequency/1e9,(imag(wb35.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100,...
    wb20.frequency/1e9,(imag(wb40.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100,...
    wb20.frequency/1e9,(imag(wb45.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100,...
    wb20.frequency/1e9,(imag(wb50.epsilon)- imag(wb20.epsilon))./imag(wb20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%%
figure;
plot(td20.frequency/1e9,(real(td25.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100,...
    td20.frequency/1e9,(real(td30.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100,...
    td20.frequency/1e9,(real(td35.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100,...
    td20.frequency/1e9,(real(td40.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100,...
    td20.frequency/1e9,(real(td45.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100,...
    td20.frequency/1e9,(real(td50.epsilon)- real(td20.epsilon))./real(td20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
%ylim([0 4])
%%
figure;
plot(td20.frequency/1e9,(imag(td25.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100,...
    td20.frequency/1e9,(imag(td30.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100,...
    td20.frequency/1e9,(imag(td35.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100,...
    td20.frequency/1e9,(imag(td40.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100,...
    td20.frequency/1e9,(imag(td45.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100,...
    td20.frequency/1e9,(imag(td50.epsilon)- imag(td20.epsilon))./imag(td20.epsilon)*100)
xlabel('frequency (GHz)')
ylabel('percent change from 20dBm')
legend('25dBm','30dBm','35dBm','40dBm','45dBm','50dBm','Location','best')
legend('boxoff')
title(sprintf('Percent change \\epsilon\\prime\\prime (%0.2g mm %s sample)',material_width*1e3,material))
%title('Percent change \epsilon\prime\prime for a 1.5mm DD-13490 sample')
xlim([min(wb20.frequency/1e9) max(wb20.frequency/1e9)])
set(gca,'FontSize',12)
grid on
end