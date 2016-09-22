function [s11,s12] = generateSParamters2(epsilon,mu,device_length,material_thickness,frequency)
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
omega = 2*pi*frequency;
gamma = 1i*omega./c0.*sqrt(epsilon.*mu);
gamma0 = 1i*omega/c0;
material_depth = (device_length - material_thickness)/2;
R1 = exp(-gamma0.*material_depth);
%assumes material centered in device
transmission = exp(-gamma.*material_thickness);
GAMMA = (sqrt(mu./epsilon) - 1)./(sqrt(mu./epsilon) + 1);
s11 = R1.^2.*(1 - transmission.^2).*GAMMA./(1-transmission.^2.*GAMMA.^2);
s12 = R1.^2.*(1 - GAMMA.^2).*transmission./(1-transmission.^2.*GAMMA.^2);

end