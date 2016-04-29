a = [2 -1 0 0 0 0; -1 2 -1 0 0 0; 0 -1 2 -1 0 0; 0 0 -1 2 -1 0; 0 0 0 -1 2 -1; 0 0 0 0 -1 2];
[v, d] = eig(a);
figure;
for i = 1:6
    subplot(3,2,i)
    stem(v(:,i))
    v2 = interp1(1:6,v(:,i),1:.125:6,'spline');
    hold on
    plot(1:.125:6,v2)
    title(sprintf('Nearest Neighbor \\omega^2 = %g', d(i,i)))
    xlabel('oscillator')
end