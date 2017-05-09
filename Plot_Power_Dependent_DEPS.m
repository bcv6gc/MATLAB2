fs = sqrt(10.^(powers/10)/1e3*50)/0.004;
yyaxis right
plot(powers,real(y5v_power_epsilon(75,:)),powers,real(pb_power_epsilon(75,:)),'--',powers,real(yig_power_epsilon(75,:)),'*-')
yyaxis left
plot(sqrt(powers/50),imag(y5v_power_epsilon(75,:)),powers,imag(pb_power_epsilon(75,:)),'--',powers,imag(yig_power_epsilon(75,:)),'*-')