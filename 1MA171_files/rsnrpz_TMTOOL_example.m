%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for rsnrpz Powersensors driver
% Follow the http://www.rohde-schwarz.com/appnote/1GP69 - Powersensor Programming guide application note
% Author: Miloslav Macko  miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com

%% Establishing connection
% Clean-up possible open connections
instrreset;

% Try to open the instrument driver session
try
    % Create a device object.
    % USB::0x0aad::0x000c::100001 – NRP-Z11 with Serial Number 100001
    % USB::0x0aad::0x021::* - first available NRP-Z91 Powersensor
    % USB::0xaad::* - first available Powersensor
    deviceObj = icdevice('matlab_rsnrpz_driver.mdd', 'USB::0xaad::*');
 
    % Connect device object to hardware.
    connect(deviceObj);
    
catch ME 
    % Clean-up driver session
    % Delete object
    if exist ('deviceObj')
        delete(deviceObj);
    end
    
    error('Connection to instrument failed:\n%s', ME.message)
end

%% Constants
Channel = 1; %powersensor channel is always 1, more sensors are handled with different objects
TriggerSource = 3; % Immediate trigger
MeasurementMode = 0; % Continue average mode
Count = 5; % Continue averaging of 5 values
Frequency = 50E+6; % Correction frequency 50MHz
Timeoutms = 5000; % Timeout 5000ms

%% Commonly used group objects
UtilityObj = get(deviceObj, 'Utility');
ChannelsObj = get(deviceObj, 'Channels');
ChannelObj = get(deviceObj, 'Channelschannel');
ChannelAvgObj = get(deviceObj, 'Channelschannelaveraging');
TriggerObj = get(deviceObj, 'Channelschanneltrigger');
TriggerllObj = get(deviceObj, 'Channelschanneltriggerlowlevel');
ChannelCorrObj = get(deviceObj, 'Channelschannelcorrections');
ChannelScopellObj = get(deviceObj, 'Channelschannelscopelowlevel');
StatusObj = get(deviceObj, 'Status');
MeasObj = get(deviceObj, 'Measurement');

%% Reading sensor info
[SensorName, SensorType, SensorSerial] = invoke(UtilityObj, 'getsensorinfo', Channel)
[InstrumentDriverRevision, FirmwareRevision] = invoke(UtilityObj, 'revisionquery')

%% Abort any measurement that might be running
invoke(ChannelsObj, 'chansabort');

%% Single shot measurement settings
% Immediate average mode of 5 averaged samples
invoke(TriggerllObj, 'triggersetsource', Channel, TriggerSource);
invoke(ChannelObj, 'chanmode', Channel, MeasurementMode);
invoke(ChannelAvgObj, 'avgconfigureavgmanual' , Channel, Count);
invoke(ChannelCorrObj, 'chansetcorrectionfrequency', Channel, Frequency);
invoke(TriggerObj, 'triggerimmediate' , Channel);

% Single shot measurement
[Measurement] = invoke(MeasObj, 'meassreadmeasurement', Channel, Timeoutms);
disp (sprintf ('Single shot measurement 1: %g W (%0.3f dBm)', Measurement, 10 * log10(Measurement) + 30));

[Measurement] = invoke(MeasObj, 'meassreadmeasurement', Channel, Timeoutms);
disp (sprintf ('Single shot measurement 2: %g W (%0.3f dBm)', Measurement, 10 * log10(Measurement) + 30));

%% Trace measurement - 500 points, immediate trigger
MeasurementMode = 4; % Scope measurment mode
ScopePoints = 500; % 500 points
ScopeTime = 0.1; % 100ms measurement time
Timeoutms = 10000; % Timeout 10s
invoke(ChannelObj, 'chanmode', Channel, MeasurementMode); % Scope mode must be supported by powersensor type
invoke(ChannelScopellObj, 'scopesetpoints', Channel, ScopePoints); % Scope points might differ by powersensor type
invoke(ChannelScopellObj, 'scopesetoffsettime', Channel, 0);
invoke(ChannelScopellObj, 'scopesettime', Channel, ScopeTime); % Scope times might differ by powersensor type

% Starting the scope, waiting for the end and reading the result
MeasurementArrayW = zeros(ScopePoints, 1);
[MeasurementArrayW, ScopePoints] = invoke(MeasObj, 'meassreadbuffermeasurement', Channel, Timeoutms, ScopePoints, MeasurementArrayW);

% Calculating the dBm values out of Watts, coerce values < 0 to 1E-10 (-90dBm)
CoerceArray = (MeasurementArrayW < 0);
MeasurementArrayW(CoerceArray) = 1E-12; % coerce to -90dBm
MeasurementArrayDBM = (10 * log10(MeasurementArrayW) + 30);

% Plotting the result
TimeStamps = linspace(0, ScopeTime, ScopePoints);
plot(TimeStamps, MeasurementArrayDBM);
disp ('Scope measurement plotted to Figure 1');

%% Clean-up driver session
if exist ('deviceObj')
    % Disconnect device object from hardware.
    disconnect(deviceObj);
    % Delete object
    delete(deviceObj);
end