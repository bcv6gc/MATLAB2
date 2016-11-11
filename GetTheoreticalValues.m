function [s11,s21,s12,s22,frequency] = GetTheoreticalValues(material,frequency)
%%
case switch
        %find if material is in the list of known materials
data = xlsread(sprintf('%s\\Materials\\%s.xlsx',pwd,filename),'Sheet1');
t_frequency = data(:,1)*1e9;
permittivity = data(:,2) - 1i*data(:,3);
permeability = data(:,4) - 1i*data(:,5);
[t11,t21] = generateSParamters2(permittivity,permeability,device_length,material_width,t_frequency);
%}
%static case
%%
%
epsT = 2.4;
permittivity = epsT;
muT = 1;
permeability = muT;
t_frequency = m_frequency;
[t11,t21] = generateSParamters2(epsT,muT,device_length,material_width,t_frequency);
%}
end