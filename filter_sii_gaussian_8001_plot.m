function y=filter_sii_gaussian_8001_plot(x,c1,w1)

t1=ifft(x,2001);

figure(44)
plot(abs(t1)/max(abs(t1)));
hold on




%t=zeros(length(t1),1);
%t(:,1)=1:1:length(t);
%t_win=exp(-(t-c1).^2/w1);
temp_win = hann(2*c1);
t_win = [temp_win - temp_win(1);zeros(2001 - 2*c1,1)];
%t_win = circshift(t_win,round(-c1/2)); @@@ used for window of 3X
plot(t_win*1.1,'g--')
xlim([1 500])

t2=t1.*t_win;
y=fft(t2);
xlim([1 1400])
set(gca,'fontsize',14)
set(gcf,'color',[1 1 1])
xlabel('IFFT time steps')
ylabel('Normalized magnitude')
title('time domain data')


tv=1:length(t1);
jan_file=[transpose(tv) abs(t1)/max(abs(t1)) t_win*1.1];
save timg_gating_plot