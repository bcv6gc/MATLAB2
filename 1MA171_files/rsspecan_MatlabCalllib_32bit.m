%% Rohde & Schwarz GmbH & Co. KG
% MATLAB calllib example for loading dll library and showing the function prototypes

addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Include';
addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin';

vxipnpLib    = 'rsspecan_32';
vxipnpLibDll = 'rsspecan_32.dll';
vxipnpHeader = 'rsspecan.h';
if ~libisloaded (vxipnpLib)
    loadlibrary (vxipnpLibDll, vxipnpHeader);
end

libfunctions (vxipnpLib, '-full');
libfunctionsview (vxipnpLib);

%% DLL clean-up
unloadlibrary(vxipnpLib);
clear all