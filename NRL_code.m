% Based on code from Rudolph Scott from NRL

%%% where the data are located %%%
% data = load('C:\Users\rudolph\Documents\MATLAB\Material Parameters\131115-A-85mil-Xband.s2p');
% data = load('Data\Day1\GDSKuband.txt');
%data = load('coax50mmHDPE10mm.s2p');
% data = xlsread('C:\Users\rudolph\Documents\Research\MaterialParameters\GDS-1.csv');

%%% what type of averaging you would like to use %%%
%%% assumes you sample is symmetric at least %%%
avetech = 'algebraic';
% avetech = 's11';
% avetech = 's22';

%%% select the ieee frequency band %%%
freqband = 'fband';

%%% thickness of the sample %%%
t = 10e-3;
%t = 0.024*0.0254;
% t = 0.051*0.0254;
% t = 0.073*0.0254;

%%% data format %%%
format = 'ReIm';
% format = 'MagPhs';

%%% set some boundaries to start %%%
minEr = 3;
maxEr = 7;
minEi = -1;
maxEi = 5;
minMr = 0.8;
maxMr = 1.2;
minMi = -0.1;
maxMi = 1;

%%% How much would you expect each parameter to deviate from the adjacent frequency point %%%
deltaEr = 1;%0.1;
deltaEi = 1;%0.01;
deltaMr = 1;%0.1;
deltaMi = 1;%0.01;

startpts = 11;  %%% first subdivision
subpts = 5;     %%% subsequent subdivisions
iter = 3;       %%% number of iterations

%%% standard waveguide sizes (don't change) %%%
sbandA = 2.84*0.0254;
fbandA = 1.59*0.0254;
hbandA = 1.122*0.0254;
xbandA = 0.9*0.0254;
kubandA = 0.622*0.0254;
kbandA = 0.42*0.0254;
kabandA = 0.28*0.0254;

%%% length of the sample holder %%%
sbandL = 6*0.0254;
fbandL = 0.5*0.0254;
hbandL = 0.35*0.0254;
xbandL = 0.3*0.0254;
kubandL = 0.25*0.0254;
kbandL = 0.175*0.0254;
kabandL = 0.125*0.0254;

switch freqband
    case 'sband'
        a = sbandA;
        deembed = sbandL-t;
    case 'fband'
        a = fbandA;
        deembed = fbandL-t;
    case 'hband'
        a = hbandA;
        deembed = hbandL-t;
    case 'xband'
        a = xbandA;
        deembed = xbandL-t;
    case 'kuband'
        a = kubandA;
        deembed = kubandL-t;
    case 'kband'
        a = kbandA;
        deembed = kbandL-t;
    case 'kaband'
        a = kabandA;
        deembed = kabandL-t;
end
%{
switch format
    case 'ReIm'
        f = data(:,1);
        s11 = data(:,2)+1j.*data(:,3);
        s12 = data(:,4)+1j.*data(:,5);
        s21 = data(:,6)+1j.*data(:,7);
        s22 = data(:,8)+1j.*data(:,9);
    case 'MagPhs'
        f = data(:,1);
        s11 = 10.^(data(:,2)./20).*exp(1j.*data(:,3)./180.*pi);
        s12 = 10.^(data(:,4)./20).*exp(1j.*data(:,5)./180.*pi);
        s21 = 10.^(data(:,6)./20).*exp(1j.*data(:,7)./180.*pi);
        s22 = 10.^(data(:,8)./20).*exp(1j.*data(:,9)./180.*pi);
end
%}
materialFile = 'coax50mmHDPE10mm.s2p';
[s11,s21,s12,s22,f] = s2pToComplexSParam(materialFile,filelength);
a = 1e9;
[num,~] = size(f);
mu0 = 4e-7*pi;
eps0 = 8.85418782e-12;
air = 1.00058986;
ereal = 0.*f./f;
mreal = 0.*f./f;
eimag = 0.*f./f;
mimag = 0.*f./f;

eiguess = 0.1;
miguess = 0.1;

c = 1/sqrt(air*eps0*mu0);
lambda0 = c./f;
k0 = 2*pi./lambda0;

%%% when s11 is commented and s22 is uncommented this deembeds assuming the sample is flush with port 1 %%%
%%% when s22 is commented and s11 is uncommented this deembeds assuming the sample is flush with port 2 %%%
% s11 = s11.*exp(2j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
s12 = s12.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
s21 = s21.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
s22 = s22.*exp(2j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);

%%% this deembeds assuming the sample is in the middle of the holder %%%
% s11 = s11.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
% s12 = s12.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
% s21 = s21.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);
% s22 = s22.*exp(1j.*sqrt(1-(lambda0./2./a).^2).*k0.*deembed);

if 1
    figure (11)
    %     plot(f,20.*log10(abs(s11)),f,20.*log10(abs(s22)))
    plot(f,20.*log10(abs(s11)),f,20.*log10(abs(s22)))
    figure (12)
    plot(f,180/pi.*angle(s11),f,180/pi.*angle(s22))
    figure (13)
    plot(f,20.*log10(abs(s21)),f,20.*log10(abs(s12)))
    figure (14)
    plot(f,180/pi.*angle(s21),f,180/pi.*angle(s12))
    figure (15)
    plot(f,20.*log10(abs(s11).^2+abs(s21).^2))
end

switch avetech
    case 's11'
        color = 'r';
    case 's22'
        s11 = s22;
        s21 = s12;
        color = 'm';
    case 'algebraic'
        s11 = (s11+s22)./2;
        s21 = (s21+s12)./2;
        color = 'b';
    case 'geometric'
        s11 = sqrt(s11.*s22);
        if abs(s11+s22)<abs(s11-s22)
            s11 = -s11;
        end
        s21 = sqrt(s21.*s12);
        if abs(s21+s12)<abs(s21-s12)
            s21 = -s21;
        end
        color = 'g';
end

if 1
    figure (11)
    hold on
    plot(f,20.*log10(abs(s11)),'m')
    hold off
    figure (12)
    hold on
    plot(f,180/pi.*angle(s11),'m')
    hold off
    figure (13)
    hold on
    plot(f,20.*log10(abs(s21)),'m')
    hold off
    figure (14)
    hold on
    plot(f,180/pi.*angle(s21),'m')
    hold off
end

%%

pts = startpts;

figure(10)
RECT = [0.1, 0.2, 0.8, 0.2];  %rectangular box [left, bottom,width, height]
axes('position', RECT);
title('Percent Complete')
xlim([0,100])

for ii = 1:num
    count = 0;
    while count<iter
        clear w x y z
        count = count+1;
        
        w = ones(pts,pts,pts,pts);
        x = ones(pts,pts,pts,pts);
        y = ones(pts,pts,pts,pts);
        z = ones(pts,pts,pts,pts);
        
        for jj = 1:pts
            w(jj,:,:,:) = w(jj,:,:,:).*(minEr+(jj-1)/(pts-1)*(maxEr-minEr));
            x(:,jj,:,:) = x(:,jj,:,:).*(minEi+(jj-1)/(pts-1)*(maxEi-minEi));
            y(:,:,jj,:) = y(:,:,jj,:).*(minMr+(jj-1)/(pts-1)*(maxMr-minMr));
            z(:,:,:,jj) = z(:,:,:,jj).*(minMi+(jj-1)/(pts-1)*(maxMi-minMi));
        end
        
        epsr = w-1j.*x;
        mur = y-1j.*z;
        
        cosx = 2.*sqrt(mur./epsr.*(1-1./(mur.*epsr).*(lambda0(ii)./2./a).^2).*(1-(lambda0(ii)./2./a).^2)).*cos(sqrt(mur.*epsr-(lambda0(ii)./2./a).^2).*k0(ii).*t);
        sinxu = (1+mur./epsr-(mur./epsr+1./(mur.*epsr)).*(lambda0(ii)./2./a).^2).*sin(sqrt(mur.*epsr-(lambda0(ii)./2./a).^2).*k0(ii).*t);
        sinxa = (mur./epsr-1+(1./(mur.*epsr)-mur./epsr).*(lambda0(ii)./2./a).^2).*sin(sqrt(mur.*epsr-(lambda0(ii)./2./a).^2).*k0(ii).*t);
        R = 1j.*sinxa./(cosx+1j.*sinxu);
        T = 2.*sqrt(mur./epsr.*(1-1./(mur.*epsr).*(lambda0(ii)./2./a).^2).*(1-(lambda0(ii)./2./a).^2))./(cosx+1j.*sinxu);
        deltaR = s11(ii)-R;
        deltaT = s21(ii)-T;
        delta = sqrt(abs(deltaR).^2+abs(deltaT).^2);
        [tdelt,tmat] = min(abs(delta));
        [ddelt,dmat] = min(tdelt);
        [mdelt,mmat] = min(ddelt);
        [~,lndex] = min(mdelt);
        kndex = mmat(1,1,1,lndex);
        jndex = dmat(1,1,kndex,lndex);
        index = tmat(1,jndex,kndex,lndex);
        if count<iter
            if (index ~= 1) && (index ~= pts)
                minEr = real(epsr(index-1,jndex,kndex,lndex));
                maxEr = real(epsr(index+1,jndex,kndex,lndex));
            elseif index == 1
                maxEr = real(epsr(index+1,jndex,kndex,lndex));
                minEr = 2*real(epsr(index,jndex,kndex,lndex))-maxEr;
            elseif index == pts
                minEr = real(epsr(index-1,jndex,kndex,lndex));
                maxEr = 2*real(epsr(index,jndex,kndex,lndex))-minEr;
            end
            if (jndex ~= 1) && (jndex ~= pts)
                minEi = -imag(epsr(index,jndex-1,kndex,lndex));
                maxEi = -imag(epsr(index,jndex+1,kndex,lndex));
            elseif jndex == 1
                maxEi = -imag(epsr(index,jndex+1,kndex,lndex));
                minEi = -2*imag(epsr(index,jndex,kndex,lndex))-maxEi;
            elseif jndex == pts
                minEi = -imag(epsr(index,jndex-1,kndex,lndex));
                maxEi = -2*imag(epsr(index,jndex,kndex,lndex))-minEi;
            end
            if (kndex ~= 1) && (kndex ~= pts)
                minMr = real(mur(index,jndex,kndex-1,lndex));
                maxMr = real(mur(index,jndex,kndex+1,lndex));
            elseif kndex == 1
                maxMr = real(mur(index,jndex,kndex+1,lndex));
                minMr = 2*real(mur(index,jndex,kndex,lndex))-maxMr;
            elseif kndex == pts
                minMr = real(mur(index,jndex,kndex-1,lndex));
                maxMr = 2*real(mur(index,jndex,kndex,lndex))-minMr;
            end
            if (lndex ~= 1) && (lndex ~= pts)
                minMi = -imag(mur(index,jndex,kndex,lndex-1));
                maxMi = -imag(mur(index,jndex,kndex,lndex+1));
            elseif lndex == 1
                maxMi = -imag(mur(index,jndex,kndex,lndex+1));
                minMi = -2*imag(mur(index,jndex,kndex,lndex))-maxMi;
            elseif lndex == pts
                minMi = -imag(mur(index,jndex,kndex,lndex-1));
                maxMi = -2*imag(mur(index,jndex,kndex,lndex))-minMi;
            end
            pts = subpts;
            minEr = minEr+(maxEr-minEr)./(pts+1);
            maxEr = maxEr-(maxEr-minEr)./(pts+1);
            minEi = minEi+(maxEi-minEi)./(pts+1);
            maxEi = maxEi-(maxEi-minEi)./(pts+1);
            minMr = minMr+(maxMr-minMr)./(pts+1);
            maxMr = maxMr-(maxMr-minMr)./(pts+1);
            minMi = minMi+(maxMi-minMi)./(pts+1);
            maxMi = maxMi-(maxMi-minMi)./(pts+1);
        else
            ereal(ii) = real(epsr(index,jndex,kndex,lndex));
            mreal(ii) = real(mur(index,jndex,kndex,lndex));
            eimag(ii) = imag(epsr(index,jndex,kndex,lndex));
            mimag(ii) = imag(mur(index,jndex,kndex,lndex));
            pts = startpts;
            if ereal(ii)>deltaEr
                minEr = ereal(ii)-deltaEr;
                maxEr = ereal(ii)+deltaEr;
            else
                minEr = 0;
                maxEr = ereal(ii)+deltaEr;
            end
            if -eimag(ii)>deltaEi
                minEi = -eimag(ii)-deltaEi;
                maxEi = -eimag(ii)+deltaEi;
            else
                minEi = 0;
                maxEi = -eimag(ii)+deltaEi;
            end
            if mreal(ii)>deltaMr
                minMr = mreal(ii)-deltaMr;
                maxMr = mreal(ii)+deltaMr;
            else
                minMr = 0;
                maxMr = mreal(ii)+deltaMr;
            end
            if -mimag(ii)>deltaMi
                minMi = -mimag(ii)-deltaMi;
                maxMi = -mimag(ii)+deltaMi;
            else
                minMi = 0;
                maxMi = -mimag(ii)+deltaMi;
            end
        end
        figure(10)
        barh(100*ii/num)
        xlim([0,100])
    end
end

%%

er = ereal+1j.*eimag;
mr = mreal+1j.*mimag;

xmin = min(f*1e-9);
xmax = max(f*1e-9);

%figure(1)
subplot(221)
hold on
plot(f*1e-9,real(er),color,'linewidth',2)
% plot(f*1e-9,real(er),'color',[0.5 0 0.5],'linewidth',2)
% axis([12 18 13.4 13.7])
xlim([xmin xmax])
xlabel('Frequency (GHz)')
ylabel('Re\{\epsilon_r\}')
xlab = get(gca, 'xlabel');
ylab = get(gca, 'ylabel');
titl = get(gca, 'title');
grid on
set(titl, 'FontName', 'Calibri','fontsize', 20)
set(gca, 'FontName', 'Calibri','fontsize', 20)
set(xlab, 'FontName', 'Calibri','fontsize', 20)
set(ylab, 'FontName', 'Calibri','fontsize', 20)

%figure(2)
subplot(222)
hold on
plot(f*1e-9,imag(er),color,'linewidth',2)
% plot(f*1e-9,imag(er),'color',[0.5 0 0.5],'linewidth',2)
% axis([12 18 -0.06 0.01])
xlim([xmin xmax])
xlabel('Frequency (GHz)')
ylabel('Im\{\epsilon_r\}')
xlab = get(gca, 'xlabel');
ylab = get(gca, 'ylabel');
titl = get(gca, 'title');
grid on
set(titl, 'FontName', 'Calibri','fontsize', 20)
set(gca, 'FontName', 'Calibri','fontsize', 20)
set(xlab, 'FontName', 'Calibri','fontsize', 20)
set(ylab, 'FontName', 'Calibri','fontsize', 20)

%figure(3)
subplot(223)
hold on
plot(f*1e-9,real(mr),color,'linewidth',2)
% plot(f*1e-9,real(mr),'color',[0 0.5 0.5],'linewidth',2)
% axis([12 18 0.9 1])
xlim([xmin xmax])
xlabel('Frequency (GHz)')
ylabel('Re\{\mu_r\}')
xlab = get(gca, 'xlabel');
ylab = get(gca, 'ylabel');
titl = get(gca, 'title');
grid on
set(titl, 'FontName', 'Calibri','fontsize', 20)
set(gca, 'FontName', 'Calibri','fontsize', 20)
set(xlab, 'FontName', 'Calibri','fontsize', 20)
set(ylab, 'FontName', 'Calibri','fontsize', 20)

%figure(4)
subplot(224)
hold on
plot(f*1e-9,imag(mr),color,'linewidth',2)
% plot(f*1e-9,imag(mr),'color',[0 0.5 0.5],'linewidth',2)
% axis([12 18 -0.035 0.002])
xlim([xmin xmax])
xlabel('Frequency (GHz)')
ylabel('Im\{\mu_r\}')
xlab = get(gca, 'xlabel');
ylab = get(gca, 'ylabel');
titl = get(gca, 'title');
grid on
set(titl, 'FontName', 'Calibri','fontsize', 20)
set(gca, 'FontName', 'Calibri','fontsize', 20)
set(xlab, 'FontName', 'Calibri','fontsize', 20)
set(ylab, 'FontName', 'Calibri','fontsize', 20)

%%
% 
% imprt = load('Data/5708_mu.txt');
% ff = imprt(:,1);
% mu_import = imprt(:,2)-1j.*imprt(:,3);
% figure(3)
% plot(ff,real(mu_import),'k','linewidth',2)
% xlim([4 18])
% figure(4)
% plot(ff,imag(mu_import),'k','linewidth',2)
% xlim([4 18])