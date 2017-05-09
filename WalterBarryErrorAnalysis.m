syms k0 l s12 s11
k(l) = acos((exp(-1i*2*k0*l)+ (s12^2-s11^2)*exp(1i*2*k0*l))/(2*s12));
R(l) = s11/(exp(-1i*2*k0*l)-s12*exp(-1i*k(l)));
epsilon(l) = k(l)/k0*((1-R(l))/(1+R(l)));
mu(l) = k(l)/k0*((1-R(l))/(1+R(l)));
val1 = diff(epsilon,l);
val2 = diff(mu,l);
pretty(val1)
pretty(val2)