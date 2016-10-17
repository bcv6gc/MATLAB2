%% Rohde & Schwarz GmbH & Co. KG
% MATLAB calllib example for loading x64 dll library and showing the function prototypes

p1= 'c:\Program Files\IVI Foundation\VISA\Win64\Include';
p2= 'c:\Program Files\IVI Foundation\VISA\Win64\Bin';
addpath(p1);
addpath(p2);

vxipnpLib    = 'rsspecan_64';
vxipnpLibDll = 'rsspecan_64.dll';
vxipnpHeader = 'workaround_rsspecan_64bit.h';

if ~libisloaded (vxipnpLib)
    [notfound,warnings]=loadlibrary(vxipnpLibDll, vxipnpHeader, 'includepath', p1, 'includepath', p2, 'addheader', 'rsspecan.h');
end

libfunctions (vxipnpLib, '-full');
libfunctionsview (vxipnpLib);

%% DLL clean-up
unloadlibrary(vxipnpLib);
clear all