effective_perm = 2.4;
medium_perm = 2;
volume_fraction = 1-(0:0.001:0.5);
mgperm = MaxwellGarnett(effective_perm,medium_perm,volume_fraction);
bperm = Bruggeman(effective_perm,medium_perm,volume_fraction);
subplot(211)
plot(volume_fraction,mgperm)
subplot(212)
plot(volume_fraction,bperm)
xlabel('Mixture Permittivity')
ylabel('Calculated Permittivity')