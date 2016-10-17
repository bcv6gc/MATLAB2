%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for using functions

% Create a device object. 
deviceObj = icdevice('matlab_rsspecan_driver.mdd', 'TCPIP::10.85.0.94::INSTR');
 
% Connect device object to hardware.
connect(deviceObj);
 
% Execute device object function(s).
groupObj = get(deviceObj, 'Configuration');
groupObj = groupObj(1);
invoke(groupObj, 'configurefrequencycenter', 1, 1.12E+9);

% Disconnect device object from hardware.
disconnect(deviceObj);
% Delete object
delete(deviceObj);