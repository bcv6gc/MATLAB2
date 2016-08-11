function filtered_sparm = calc_time_filter(sparam,fft_length)
time_sparam=ifft(sparam,fft_length);
[~,c1]=max(abs(time_sparam));
t=zeros(fft_length,1);
t(:,1)=1:1:fft_length;
win_length = 25000;
t_win=exp(-(t-c1).^2/win_length);
time_sparam_filter=t_win.*time_sparam;
temp_sparam=fft(time_sparam_filter);
filtered_sparm=temp_sparam(1:201);
end