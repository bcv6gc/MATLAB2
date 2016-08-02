function y=filter_sii_jbl(x,c1,w1)
fft_length = 2001;
t1=ifft(x,fft_length);

figure
plot(abs(t1)/max(abs(t1)));
hold on

%t=zeros(length(t1),1);
%t(:,1)=1:1:length(t);
%t_win=exp(-(t-c1).^2/w1);
if c1 > w1/2
    temp_win = window(@chebwin,2*c1);
    t_win = [temp_win;zeros(fft_length - 2*c1,1)];
else
    temp_win = window(@chebwin,w1);
    t_win = [zeros(c1 - w1/2,1);temp_win;zeros(fft_length - (c1 + w1/2),1)];
end

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

%{
tv=1:length(t1);
jan_file=[transpose(tv) abs(t1)/max(abs(t1)) t_win*1.1];
save timg_gating_plot
%}