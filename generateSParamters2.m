function [s11,s12] = generateSParamters2(epsilon,mu,thickness,frequency)
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
omega = 2*pi*frequency;
gamma = 1i*sqrt(omega.^2*epsilon*mu/c0^2);
gamma0 = 1i*omega/c0;
transmission = exp(-gamma*thickness);
GAMMA = (sqrt(mu*mu0/epsilon/eps0) - 1)./(sqrt(mu*mu0/epsilon/eps0) + 1);
s11 = exp(-1i*gamma0*.3).*(1 - transmission.^2).*GAMMA./(1-transmission.^2.*GAMMA.^2);
s12 = exp(-1i*gamma0*.3).*exp(-1i*gamma0*.7).*(1 - GAMMA.^2).*transmission./(1-transmission.^2.*GAMMA.^2);

end