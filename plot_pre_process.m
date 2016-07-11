
[temp1,freq1] = pre_process_jbl(1);
[temp2,freq2] = pre_process_jbl(2);
[temp3,freq3] = pre_process_jbl(3);
[temp4,freq4] = pre_process_jbl(4);
figure;
plot(freq1/1e9,real(temp1),'r',freq2/1e9,real(temp2),'b',freq3/1e9,real(temp3),'g',freq4/1e9,real(temp4),'k','linewidth',3)
hold on
plot(freq1/1e9,imag(temp1),'r-.',freq2/1e9,imag(temp2),'b-.',freq3/1e9,imag(temp3),'g-.',freq4/1e9,imag(temp4),'k-.','linewidth',3)
legend({'LDPE12mm WR284','LDPE 32mm WR284','HDPE 32mm WR284', 'HDPE 12mm WR430'},'Location','east','FontSize',14,'FontWeight','bold')
xlabel('Frequency (GHz)','FontSize',20)
ylabel('Relative Permittivity \epsilon','FontSize',20)
ax = gca;
ax.FontSize = 16;