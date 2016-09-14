syms kt R s11 s21 k0l
eqn1 = s21 == (1-R^2)*exp(-1i*2*k0l)/(exp(-1i*kt) - R^2*exp(1i*kt));
eqn2 = s11 == 1i*R*exp(-1i*k0l)*sin(kt)/(exp(1i*kt) - R^2*exp(-1i*kt));
solu = solve(eqn2, R, 'ReturnConditions', true);