%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for setting and reading the properties

% Create a device object.
deviceObj = icdevice('matlab_rsspecan_driver.mdd', 'TCPIP::10.85.0.94::INSTR');
 
% Connect device object to hardware.
connect(deviceObj);
 
% Configure Repeated Capability
set(deviceObj, 'RepCapIdentifier', 'Win1');
 
% Configure property value(s).
set(deviceObj.Basicoperation, 'Center_Frequency', 1.12E+9);
 
% Query property value(s).
Value = get(deviceObj.Basicoperation, 'Center_Frequency')
 
% Alternative way to set the property.
SetPropObj = get(deviceObj, 'ConfigurationSetGetCheckAttributeSetAttribute');
invoke (SetPropObj, 'setattributevireal64', 'Win1', 1150009 , 1.12E+9);
 
% Alternative way to get the property.
GetPropObj = get(deviceObj, 'ConfigurationSetGetCheckAttributeGetAttribute');
Value = invoke (GetPropObj, 'getattributevireal64', 'Win1', 1150009 , 1.12E+9)
 
% Disconnect device object from hardware.
disconnect(deviceObj);
% Delete object
delete(deviceObj);