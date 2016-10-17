%% Rohde & Schwarz GmbH & Co. KG
% MATLAB example for direct composing a TMTOOL script using functions
% The example configures spectrum analyzer center frequency, sets single
% sweep, queries *IDN? string, % performs the sweep and reads the trace data.

% Create a device object. 
deviceObj = icdevice('matlab_rsspecan_driver.mdd', 'TCPIP::10.85.0.94::INSTR');
 
% Connect device object to hardware.
connect(deviceObj);
 
% Configuring the center frequency.
invoke(get(deviceObj, 'Configuration'), 'configurefrequencycenter', 1, 1.12E+9);

% Querying the device IDN string.
[data] = invoke(get(deviceObj, 'Utilityfunctionsinstrumentio'), 'queryvistring', '*IDN?', 200)

% Setting single sweep.
invoke(get(deviceObj, 'Configuration'), 'configureacquisition', 1, 0, 1);
 
% Initiate the measurement.
invoke(get(deviceObj, 'Measurementlowlevelmeasurement'), 'initiate', 1, 5000);
 
% Querying sweep point to allocate the appropriate array.
[ArrayLength] = invoke(get(deviceObj, 'Configuration'), 'QuerySweepPoints', 1);
Amplitude = zeros(ArrayLength, 1); %initialize array with zeroes

% Fetching the trace Y points.
[ActualPoints, Amplitude] = invoke(get(deviceObj, 'Measurement'), 'fetchytrace', 1, 1, ArrayLength, Amplitude)
 
% Disconnect device object from hardware.
disconnect(deviceObj);
 
% Delete the  device object.
delete (deviceObj);