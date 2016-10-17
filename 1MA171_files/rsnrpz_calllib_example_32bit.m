%% Rohde & Schwarz GmbH & Co. KG
% 32bit MATLAB calllib example for R&S NRPZ Instrument Driver rsnrpz
% Follow the http://www.rohde-schwarz.com/appnote/1GP69 - Powersensor Programming guide application note
% Author: Miloslav Macko  miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com

%% Add library path
% Check VXIPNPPATH environment variable on your system
addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Include';
addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin';

vxipnpLib    = 'rsnrpz_32';
vxipnpLibDll = 'rsnrpz_32.dll';
vxipnpHeader = 'rsnrpz.h';

if ~libisloaded (vxipnpLib)
    warning off MATLAB:loadlibrary:TypeNotFound
    warning off MATLAB:loadlibrary:functionnotfound
    loadlibrary(vxipnpLibDll, vxipnpHeader);
end

% You can use these functions to get information on the functions available in a library that you have loaded:
% libfunctions(vxipnpLib, '-full'); 
% libfunctionsview(vxipnpLib);
 
%% Open propietary session
if (exist('NRPZsession','var'))
    if (NRPZsession > 0)
        calllib(vxipnpLib, 'rsnrpz_close', NRPZsession); %close in case it was left opened before
    end
else
    NRPZsession = -1;
end

% Declare pointer to NRPZresource to pass the string to the dll

% USB::0x0aad::0x000c::100001 – NRP-Z11 with Serial Number 100001
% USB::0x0aad::0x021::* - first available NRP-Z91 Powersensor
% USB::0xaad::* - first available Powersensor
NRPZresource = 'USB::0xaad::*';
pNRPZresource = libpointer( 'int8Ptr', [int8( NRPZresource ) 0] );
NRPZidQuery   = 1;
NRPZreset     = 1;
 
%% Set up connection
Channel = 1; %powersensor channel is always 1, more sensors are handled with different NRPZsession handles
[err, ~, NRPZsession] = calllib(vxipnpLib, 'rsnrpz_init', pNRPZresource, NRPZidQuery, NRPZreset, NRPZsession);

if (err)
    errMsg  = zeros(1024,1);
    [err, errMsg] = calllib( vxipnpLib, 'rsnrpz_error_message', NRPZsession, err, errMsg);
    
    Idx = find (errMsg == 0);
    errMsg = char (errMsg (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero
    sprintf('Instrument init error: "%s"', char(errMsg));
end

% Use try - catch construct to always close the sessions, otherwise MATLAB crashes when unloading the dll while some session is still opened
try

    while (true) % Loop to break from in case of error

        %% Reading sensor info
        BufferLen = 1024; %increase if you expect longer response

        SensorName = char (zeros (1, BufferLen));
        pSensorName = libpointer( 'int8Ptr', [int8(SensorName) 0] );

        SensorType = char (zeros (1, BufferLen));
        pSensorType = libpointer( 'int8Ptr', [int8(SensorType) 0] );

        SensorSerial = char (zeros (1, BufferLen));
        pSensorSerial = libpointer( 'int8Ptr', [int8(SensorSerial) 0] );

        [err, SensorName, SensorType, SensorSerial] = calllib(vxipnpLib, 'rsnrpz_GetSensorInfo', NRPZsession, Channel, pSensorName, pSensorType, pSensorSerial);
        if (err) break;  end

        Idx = find (SensorName == 0);
        SensorName = char (SensorName (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero

        Idx = find (SensorType == 0);
        SensorType = char (SensorType (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero

        Idx = find (SensorSerial == 0);
        SensorSerial = char (SensorSerial (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero

        InstrumentDriverRevision = char (zeros (1, BufferLen));
        pInstrumentDriverRevision = libpointer( 'int8Ptr', [int8(InstrumentDriverRevision) 0] );

        FirmwareRevision = char (zeros (1, BufferLen));
        pFirmwareRevision = libpointer( 'int8Ptr', [int8(FirmwareRevision) 0] );

        [err, InstrumentDriverRevision, FirmwareRevision] = calllib(vxipnpLib, 'rsnrpz_revision_query', NRPZsession, pInstrumentDriverRevision, pFirmwareRevision);
        if (err < 0) break;  end %WARNING: Revision Query not supported might occur

        Idx = find (InstrumentDriverRevision == 0);
        InstrumentDriverRevision = char (InstrumentDriverRevision (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero

        Idx = find (FirmwareRevision == 0);
        FirmwareRevision = char (FirmwareRevision (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero

        %% Abort any measurement that might be running
        err = calllib(vxipnpLib, 'rsnrpz_chans_abort', NRPZsession);
        if (err) break;  end

        %% Single shot measurement settings

        % Constants
        TriggerSource = 3; % Immediate trigger
        MeasurementMode = 0; % Continue average mode
        Count = 5; % Continue averaging of 5 values
        Frequency = 50E+6; % Correction frequency 50MHz
        Timeoutms = 5000; % Timeout 5000ms 

        % Immediate average mode of 5 averaged samples
        err = calllib(vxipnpLib, 'rsnrpz_trigger_setSource', NRPZsession, Channel, TriggerSource);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_chan_mode', NRPZsession, Channel, MeasurementMode);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_avg_configureAvgManual', NRPZsession, Channel, Count);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_chan_setCorrectionFrequency', NRPZsession, Channel, Frequency);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_trigger_immediate', NRPZsession, Channel);
        if (err) break;  end

        % Single shot measurement
        Measurement = -Inf;
        [err, Measurement] = calllib(vxipnpLib, 'rsnrpz_meass_readMeasurement', NRPZsession, Channel, Timeoutms, Measurement);
        if (err) break;  end
        disp (sprintf ('Single shot measurement: %g W (%0.3f dBm)', Measurement, 10 * log10(Measurement) + 30));

        %% Trace measurement - 500 points, immediate trigger
        MeasurementMode = 4; % Scope measurment mode
        ScopePoints = 500; % 500 points
        ReadPoints = -1;
        ScopeTime = 0.1; % 100ms measurement time
        Timeoutms = 10000; % Timeout 10s

        err = calllib(vxipnpLib, 'rsnrpz_chan_mode', NRPZsession, Channel, MeasurementMode);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_scope_setPoints', NRPZsession, Channel, ScopePoints); % Scope points might differ by powersensor type
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_scope_setOffsetTime', NRPZsession, Channel, 0);
        if (err) break;  end
        err = calllib(vxipnpLib, 'rsnrpz_scope_setTime', NRPZsession, Channel, ScopeTime); % Scope times might differ by powersensor type
        if (err) break;  end

        % Starting the scope, waiting for the end and reading the result
        MeasurementArrayW = zeros(ScopePoints, 1);
        [err, MeasurementArrayW, ReadPoints] = calllib(vxipnpLib, 'rsnrpz_meass_readBufferMeasurement', NRPZsession, Channel, Timeoutms, ScopePoints, MeasurementArrayW, ReadPoints);
        if (err) break;  end

        % Calculating the dBm values out of Watts, coerce values < 0 to 1E-10 (-90dBm)
        CoerceArray = (MeasurementArrayW < 0);
        MeasurementArrayW(CoerceArray) = 1E-12; % coerce to -90dBm
        MeasurementArrayDBM = (10 * log10(MeasurementArrayW) + 30);

        % Plotting the result
        TimeStamps = linspace(0, ScopeTime, ScopePoints);
        plot(TimeStamps, MeasurementArrayDBM);
        disp ('Scope measurement plotted to Figure 1');


        %% Connection close
        err = calllib(vxipnpLib, 'rsnrpz_close', NRPZsession);
        if (err) break;  end

        % Exit loop, it should perform only once
        break    
    end
    
catch MException
    err = calllib(vxipnpLib, 'rsnrpz_close', NRPZsession);
    disp (sprintf ('Error Occured at file "%s", line %d :"%s"', MException.stack.file, MException.stack.line, MException.message));
end
 
%% Evaluate error
if (err)
   
    errCode = err;
    errLen  = 1024; 
         
    disp( '*** Error occured' );
    
    % In the case that a session got created we evaluate the error further
    if (NRPZsession ~= 0)
        errMsg  = zeros(errLen,1);
        [err, errMsg] = calllib( vxipnpLib, 'rsnrpz_error_message', NRPZsession, err, errMsg);
        Idx = find (errMsg == 0);
        errMsgTrimmed = errMsg (1:Idx(1) - 1); %trim the string to 1st zero
        errString = sprintf('%s', char (errMsgTrimmed));
        disp(errString);
        
        errMsg  = zeros(errLen,1);
        [err, errCode, errMsg] = calllib( vxipnpLib, 'rsnrpz_error_query', NRPZsession, errCode, errMsg);
        Idx = find (errMsg == 0);
        errMsgTrimmed = errMsg (1:Idx(1) - 1); %trim the string to 1st zero
        errString = sprintf('Instrument Error queue: "%d: %s"', errCode, char(errMsgTrimmed));
                
        disp(errString);
        
        % Disconnect from the device
        err = calllib(vxipnpLib, 'rsnrpz_close', NRPZsession);
    end
end

%% DLL clean-up
% Always close all sessions, otherwise MATLAB crashes when unloading the library
unloadlibrary(vxipnpLib);
clear all