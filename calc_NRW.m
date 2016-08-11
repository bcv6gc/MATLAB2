function [epsilon, mu] = calc_NRW(frequency,s11,s21)
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
% Assumes S21 length corrected
beta=2*pi*frequency/c0;
xi = (s11.^2 - s21.^2 + 1)./(2*s11);
gamma_minus = xi - sqrt(xi.^2 - 1);
gamma_plus = xi + sqrt(xi.^2 - 1);
gamma = zeros(size(gamma_plus));
gamma(abs(gamma_minus) <= 1) = gamma_minus(abs(gamma_minus) < 1);
gamma(abs(gamma_plus) <= 1) = gamma_plus(abs(gamma_plus) < 1);
trans = (s11 + s21 - gamma)./(1 - (s11 + s21).*gamma);
inverse_square_delta = -(log(1./trans)./(2*pi*material_width)).^2;
inverse_delta = sqrt(inverse_square_delta);
mu = (1+gamma)./(1-gamma).*inverse_delta./sqrt(beta.^2);
epsilon = 4*pi^2.*inverse_square_delta./(mu.*beta.^2);
end