function [s11,s21,s12,s22] = generateSParamters(epsilon,mu,thickness,frequency)
d = thickness;
eps0=8.85418782e-12;
mu0=1.2566370614e-6;
c0=1/sqrt(eps0*mu0);
for iy=1:length(frequency)
    
    z=0;
    f=frequency(iy);
    w=2*pi*f;
    
    e0=1;
    mu0 = 1;
    e1=epsilon;
    mu1 = mu;
    e2=1;
    mu2 = 1;
    
    n0=1;
    n1=sqrt(e1*mu1);
    n2=1;
    
    th0=0;
    th1=asin(1/n1*n0*sin(th0));
    th2=asin(1/n2*n0*sin(th0));
    
    neta0=sqrt(mu0/eps0)/n0;
    neta1=sqrt(mu0/eps0)/n1;
    neta2=sqrt(mu0/eps0)/n2;
    
    F01=(neta1/cos(th1)-neta0/cos(th0))./(neta1/cos(th1)+neta0/cos(th0));
    F10=-F01;
    F12=(neta2/cos(th2)-neta1/cos(th1))./(neta2/cos(th2)+neta1/cos(th1));
    T01=1+F01;
    T10=1-F01;
    T12=1+F12;
    
    
    L0=c0/f/n0;
    L1=L0/n1;
    L2=L0/n2;
    
    B0=2*pi/L0;
    BB0(iy)=B0;

    
    B1=2*pi/L1;
    B2=2*pi/L2;
    E0r(iy)=exp(1i*B0*z*cos(th0))*(F01+T01*F12*T10*exp(-1i*2*B1*d*cos(th1))/(1-F12*F10*exp(-1i*2*B1*d*cos(th1))));
    E0t(iy)=T01*T12*exp(-1i*B1*d*cos(th1))*exp(-1i*B0*(d-d)*cos(th0))/(1-F12*F10*exp(-1i*2*B1*d*cos(th1)));
    exp(-1i*B1*d*cos(th1));
    t12_a(iy,1)=exp(-1i*B0*230e-3);
    t21_a(iy,1)=exp(-1i*B0*230e-3);
    t11_a(iy,1)=0;
    t22_a(iy,1)=0;
%     
% 

% 
% 
% 
t11_true(iy,1)=E0r(iy);
t11_true2(iy,1)= F01;
t11_true3(iy,1)= F01-F01*(1-F01*F01)*exp(-1i*2*BB0(iy)*n1*d);
s11 = t11_true;
s12(iy,1)=E0t(iy);
s21(iy,1)=E0t(iy);    
s22(iy,1)=E0r(iy);  
end