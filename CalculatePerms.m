function results = CalculatePerms(device,material,material_width,airFile,materialFile,plots)
% constants
eps0=8.85418782e-12; % F/m
mu0=1.2566370614e-6; % H/m
c0=1/sqrt(eps0*mu0);
%%
% device
switch device
    case {'stripline', 'STRIPLINE', 'Stripline', 'strip-line', 'Strip-line'}
        device_length = 120e-3;
    case {'coax','COAX','airline'}
        device_length = 50e-3;
end
%%
% Use air measurements to correct offset from connectors
[a11,a21,a12,a22,a_frequency] = s2pToComplexSParam_v3(airFile);
ak0 = 2*pi*a_frequency/c0;
correction_length = device_length + median(unwrap(angle(a21))./ak0);
l = (device_length - correction_length - material_width)/2;
theory_l = (device_length - material_width)/2;
t = material_width;
%%
% Get material data, electrically center the material in the device
[s11,s21,s12,s22,m_frequency] = s2pToComplexSParam_v3(materialFile);
fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)))/2;
meanFudge = mean(fudgeFactor);
if (meanFudge > pi)
    n = floor(meanFudge/pi);
    if (mean(unwrap(angle(s11))) > mean(unwrap(angle(s22))))
        fudgeFactor = (unwrap(angle(s11)) - 2*n*pi - unwrap(angle(s22)))/2;
    elseif(mean(unwrap(angle(s22))) > mean(unwrap(angle(s11))))
        fudgeFactor = (unwrap(angle(s11)) - unwrap(angle(s22)) + 2*n*pi)/2;
    end
end
s11 = s11.*exp(-1i*fudgeFactor);
s22 = s22.*exp(1i*fudgeFactor);
s21 = (s21 + s12)/2;
%%
% load material file if it exists
matfiles = dir(sprintf('%s\\Materials\\%s*.dat',pwd));
matfile = matfiles(~cellfun(@isempty,regexpi({matfiles.name}, sprintf('%s*',material),'match')));
if length(matfile) == 1
    data = xlsread(sprintf('%s\\Materials\\%s',pwd,matfile.name),'Sheet1');
    t_frequency = data(:,1)*1e9;
    permittivity = data(:,2) - 1i*data(:,3);
    permeability = data(:,4) - 1i*data(:,5);
    [t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
else
    if strcmpi(material,'hdpe')
        permittivity = 2.4; permeability = 1;
    elseif strcmpi(material, 'wax')
        permittivity = 2.1; permeability = 1;
    else
        permittivity = []; permeability = [];
    end
    t_frequency = m_frequency;
    [t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
end
%%
%calculate some values
k0 = 2*pi*m_frequency/c0;
tk0 = 2*pi*t_frequency/c0;
arg = (exp(-1i*4*k0*l) + s21.^2 - s11.^2)./(2*exp(-1i*2*k0*l).*s21);
kt = acos(arg);
results.kt = kt;
R = s11./(exp(-1i*2*k0*l) - s21.*exp(-1i*kt));
results.R = R;
results.epsilon = kt./(t*k0).*(1 - R)./(1 + R);
results.mu = kt./(t*k0).*(1 + R)./(1 - R);
results.frequency = m_frequency;
if ~isempty(permittivity)
    tArg = (exp(-1i*4*tk0*theory_l) + t21.^2 - t11.^2)./(2*exp(-1i*2*tk0*theory_l).*t21);
    tKt = acos(tArg);
    results.tKt = tKt;
    Rt = t11./(exp(-1i*2*tk0*theory_l) - t21.*exp(-1i*tKt));
    results.Rt = Rt;
    results.t_frequency = t_frequency;
    results.epsilont = tKt./(t*tk0).*(1 - Rt)./(1 + Rt);
    results.mut = tKt./(t*tk0).*(1 + Rt)./(1 - Rt);
end
end