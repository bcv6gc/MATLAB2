powers = 20:5:50;
fs = sqrt(10.^(powers/10-3)*50)/0.4/100; %field strength values
fs2 = 2:5:100;
%%
fselect = 75; %1.5 GHz
%polynomial fits
y5v_poly_eps = polyfit(fs,y5v_power_epsilon(fselect,:) + 0.65,2);
yig_poly_eps = polyfit(fs,yig_power_epsilon(fselect,:),1);
pb_poly_eps = polyfit(fs,pb_power_epsilon(fselect,:),1);
y5v_poly_mu = polyfit(fs,y5v_power_mu(fselect,:) - 0.9,2);
yig_poly_mu = polyfit(fs,yig_power_mu(fselect,:),2);
pb_poly_mu = polyfit(fs,pb_power_mu(fselect,:),2);

figure;
plot(fs,real(y5v_power_epsilon(fselect,:))+0.65,fs,real(pb_power_epsilon(fselect,:)),'--',fs,real(yig_power_epsilon(fselect,:)),'*-','LineWidth',1.5)
ylabel('\epsilon\prime')
xlabel('Field Strength (kV/cm)')
title('Real permittivity response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure
plot(fs,-imag(y5v_power_epsilon(fselect,:)),fs,-imag(pb_power_epsilon(fselect,:)),'--',fs,-imag(yig_power_epsilon(fselect,:)),'*-','LineWidth',1.5)
ylabel('\epsilon\prime\prime')
xlabel('Field Strength (kV/cm)')
title('Real permittivity response to field strength')
title('Imaginary permittivity response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure
plot(fs,real(y5v_power_mu(fselect,:))-0.9,fs,real(pb_power_mu(fselect,:)),'--',fs,real(yig_power_mu(fselect,:)),'*-','LineWidth',1.5)
ylabel('\mu\prime')
xlabel('Field Strength (kV/cm)')
title('Real permeability response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure
plot(fs,-imag(y5v_power_mu(fselect,:)),fs,-imag(pb_power_mu(fselect,:)),'--',fs,-imag(yig_power_mu(fselect,:)),'*-','LineWidth',1.5)
ylabel('\mu\prime\prime')
xlabel('Field Strength (kV/cm)')
title('Imaginary permeability response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure;
loglog(fs,-imag(y5v_power_epsilon(fselect,:)),fs,-imag(pb_power_epsilon(fselect,:)),'--',fs,-imag(yig_power_epsilon(fselect,:)),'*-','LineWidth',1.5)
hold on
loglog(fs2,-polyval(imag(y5v_poly_mu),fs2),fs2,-polyval(imag(pb_poly_mu),fs2),'--',fs2,-polyval(imag(yig_poly_mu),fs2),'*-','LineWidth',1.5)
ylabel('\mu\prime\prime')
xlabel('Field Strength (kV/cm)')
title('Expected imaginary permeability response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure;
plot(fs2,polyval(real(y5v_poly_mu),fs2),fs2,polyval(real(pb_poly_mu),fs2),'--',fs2,polyval(real(yig_poly_mu),fs2),'*-','LineWidth',1.5)
ylabel('\mu\prime')
xlabel('Field Strength (kV/cm)')
title('Expected real permeability response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure;
plot(fs2,polyval(real(y5v_poly_eps),fs2),fs2,polyval(real(pb_poly_eps),fs2),'--',fs2,polyval(real(yig_poly_eps),fs2),'*-','LineWidth',1.5)
ylabel('\epsilon\prime')
xlabel('Field Strength (kV/cm)')
title('Expected real permittivity response to field strength')
set(gca,'FontSize',13)
legend('BaTiO_3','Prussian Blue','YIG','Location','NorthWest')
legend('boxoff')
grid on
%%
figure
contourf(fs,pb20.frequency/1e9,-imag(yig_power_mu))
colorbar
xlabel('Field strength (kV/cm)')
ylabel('Frequency (GHz)')
title('YIG \mu\prime\prime')