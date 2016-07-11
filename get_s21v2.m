function FUN = get_s21v2( x,f,d,s21,s12)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);

w=2*pi*f;
e1=x(1)+1i*x(2);
g=1i*sqrt(w*w*e1*1/c0/c0);
g0=1i*sqrt(w*w*1*1/c0/c0);
F=(g0-g)./(g0+g);
z=exp(-g*d);
fs21=(z.*(1-F.*F))./(1-F.*F.*z.*z)-0.5*(s21+s12);
% fs21
FUN(1)=real(fs21);
FUN(2)=imag(fs21);
