x = -5:0.01:5;
y = randn(size(x));
plot(x,(-tanh(5*x)+y/50)/2 + 0.5,'b',[-5 5], [0.99 0.99],'r--',[-5 5], [0.01 0.01],'r--',[0 0],[-0.2 1.2],'r--')
set(gca,'XTick',[-5 0 5])
set(gca,'XTickLabel',{'Low','Order of kW/m^2','High'})
set(gca,'YTick',[0 1])
%set(gca,'XTickLabel',{'Low','Order of kW/m^2','High'})
ylabel('Transmission')
xlabel('Field Strength')
text(2.5,0.94,'\uparrow T \approx 99%','FontSize',16)
text(-2.5,0.07,'\downarrow T \approx 1%','FontSize',16)
set(gca,'fontsize',14)