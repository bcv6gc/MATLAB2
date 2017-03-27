powerdBm = 0:50;
powerWatts = 10.^(powerdBm/10 - 3);
voltage = sqrt(50*powerWatts);
device1 = voltage/0.25; % 0.25 centimeter gap for stripline
device2 = voltage/0.4; % 0.4 centimeter gap for coax airline
device3 = sqrt(4*401.5*powerWatts/(7.21*3.4)); %WR284 equation in notebook
device4 = sqrt(4*401.5*powerWatts/(10.9*5.4)); %WR430
device5 = sqrt(30*powerWatts*10^1.1)/100; % 11 dB gain antenna at 1 meter
%https://www.semtech.com/images/promo/Semtech_ACS_Rad_Pwr_Field_Strength.pdf 
semilogy(powerdBm,device1,powerdBm,device2,powerdBm,device3,powerdBm,device4,powerdBm,device5)
legend('5mm Stripline','7mm Coax', 'WR284 rectangular waveguide', 'WR430 rectangular waveguide','11 dB gain antenna @ 1m','Location','NorthWest')
hold on
%plot([50 50],[1 1e4],'k','LineWidth',2)
plot([0 50],[1e2 1e2],'k--','LineWidth',2)
plot([0 50],[20 20],'k--','LineWidth',2)
hold off
xlabel('Amplifier Power (dBm)')
ylabel('Field Strength (V/cm)')
grid on
text(50,device1(51),sprintf('%0.1f V/cm \\rightarrow',device1(51)),'HorizontalAlignment','right','FontSize',12);
text(50,device2(51),sprintf('%0.1f V/cm \\rightarrow',device2(51)),'HorizontalAlignment','right','FontSize',12);
text(50,device3(51),sprintf('%0.1f V/cm \\rightarrow',device3(51)),'HorizontalAlignment','right','FontSize',12);
text(50,device4(51),sprintf('%0.1f V/cm \\rightarrow',device4(51)),'HorizontalAlignment','right','FontSize',12);
text(50,device5(51),sprintf('%0.1f V/cm \\rightarrow',device5(51)),'HorizontalAlignment','right','FontSize',12);
text(2,85,'Damage to electronic equipment \uparrow','HorizontalAlignment','left','FontSize',12);
text(50,10,'Maximum output of amplifier \rightarrow','HorizontalAlignment','right','FontSize',12);
set(gca,'FontSize',13)
ylim([1 1e3])
legend('boxoff')