%%
%NRW from ASTM paper
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
epsilon = beta.^2.*inverse_square_delta./(mu.*-inverse_square_delta);
figure
subplot(211)
plot(frequency, real(epsilon), frequency, imag(epsilon))
subplot(212)
plot(frequency, real(mu), frequency, imag(mu))