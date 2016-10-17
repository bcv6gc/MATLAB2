%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for custom rsnrpz 2.3.2 Powersensor Instrument Driver
% matlab_custom_rsnrpz_3.20.0_driver.mdd
% This example uses custom built MATLAB mdd driver which will be provided with
% rsnrpz VXI plug&play driver
% Follow the http://www.rohde-schwarz.com/appnote/1GP69 - Powersensor Programming guide application note

% Differences to MATLAB makemid driver:
% - No group object, only device object is used for accessing all functions
% - rsnrpz_vxi.chm help file is intended to be used, so mdd file contains no help fields
% - Function names are exactly the same as in rsnrpz_vxi.chm driver help
% (simply copy and paste), but the prefix rsnrpz_ is removed
% - all new R&S VXIpnp drivers: help files will contain snippets of
% MATLAB code for functions and properties

% The example does one shot measurements and scope measurement according
% the http://www.rohde-schwarz.com/appnote/1GP69 Powersensor Programming guide application note
% Author: Miloslav Macko miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com

%% Establishing connection
% Clean-up possible open connections
instrreset;

% Try to open the instrument driver session
try
    % Create a device object.
    % USB::0x0aad::0x000c::100001 – NRP-Z11 with Serial Number 100001
    % USB::0x0aad::0x021::* - first available NRP-Z91 Powersensor
    % USB::0xaad::* - first available Powersensor
    deviceObj = icdevice('custom_matlab_rsnrpz_driver_2.3.2.mdd', 'USB::0xaad::*');
 
    % Connect device object to hardware.
    connect(deviceObj);
    
catch ME
    % Clean-up driver session
    % Delete object
    if exist ('deviceObj')
        delete(deviceObj);
    end

    error('Connection to instrument failed\n%s', ME.message)
end

%% Constants
Channel = 1; %powersensor channel is always 1, more sensors are handled with different objects
TriggerSource = 3; % Immediate trigger
MeasurementMode = 0; % Continue average mode
Count = 5; % Continue averaging of 5 values
Frequency = 50E+6; % Correction frequency 50MHz
Timeoutms = 5000; % Timeout 5000ms

%% Reading sensor info
[SensorName, SensorType, SensorSerial] = invoke(deviceObj, 'GetSensorInfo', Channel)
[InstrumentDriverRevision, FirmwareRevision] = invoke(deviceObj, 'revision_query')

%% Abort any measurement that might be running
invoke(deviceObj, 'chans_abort');

%% Single shot measurement settings
% Immediate average mode of 5 averaged samples
invoke(deviceObj, 'trigger_setSource', Channel, TriggerSource);
invoke(deviceObj, 'chan_mode', Channel, MeasurementMode);
invoke(deviceObj, 'avg_configureAvgManual' , Channel, Count);
invoke(deviceObj, 'chan_setCorrectionFrequency', Channel, Frequency);
invoke(deviceObj, 'trigger_immediate' , Channel);

% Single shot measurement
[Measurement] = invoke(deviceObj, 'meass_readMeasurement', Channel, Timeoutms);
disp (sprintf ('Single shot measurement 1: %g W (%0.3f dBm)', Measurement, 10 * log10(Measurement) + 30));

[Measurement] = invoke(deviceObj, 'meass_readMeasurement', Channel, Timeoutms);
disp (sprintf ('Single shot measurement 2: %g W (%0.3f dBm)', Measurement, 10 * log10(Measurement) + 30));

%% Trace measurement - 500 points, immediate trigger
MeasurementMode = 4; % Scope measurment mode
ScopePoints = 500; % 500 points
ScopeTime = 0.1; % 100ms measurement time
Timeoutms = 10000; % Timeout 10s
invoke(deviceObj, 'chan_mode', Channel, MeasurementMode); % Scope mode must be supported by powersensor type
invoke(deviceObj, 'scope_setPoints', Channel, ScopePoints); % Scope points might differ by powersensor type
invoke(deviceObj, 'scope_setOffsetTime', Channel, 0);
invoke(deviceObj, 'scope_setTime', Channel, ScopeTime); % Scope times might differ by powersensor type

% Starting the scope, waiting for the end and reading the result
MeasurementArrayW = zeros(ScopePoints, 1);
[MeasurementArrayW, ScopePoints] = invoke(deviceObj, 'meass_readBufferMeasurement', Channel, Timeoutms, ScopePoints, MeasurementArrayW);

% Calculating the dBm values out of Watts, coerce values < 0 to 1E-10 (-90dBm)
CoerceArray = (MeasurementArrayW < 0);
MeasurementArrayW(CoerceArray) = 1E-12; % coerce to -90dBm
MeasurementArrayDBM = (10 * log10(MeasurementArrayW) + 30);

% Plotting the result
TimeStamps = linspace(0, ScopeTime, ScopePoints);
plot(TimeStamps, MeasurementArrayDBM);
disp ('Scope measurement plotted to Figure 1');

if exist ('deviceObj')
    % Disconnect device object from hardware.
    disconnect(deviceObj);
    % Delete object
    delete(deviceObj);
end