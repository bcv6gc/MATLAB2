function impedance = WireStriplineCalc(diameter,height)
mu_r = 1; %relative permeability
epsilon_r =1; %relative permittivity
R = (pi*diameter)/(4*height);
x = 1 + 2* sinh(R).^2;
y = 1 - 2* sin(R).^2;
impedance = 59.952*sqrt(mu_r/epsilon_r).*(log((sqrt(x) + sqrt(y))./(sqrt(x - y)))-R.^4/3 + 0.014*R.^8);
end