%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for R&S Spectrum Analyzer Instrument Driver rsspecan
% The example configures spectrum analyzer, performs the sweep, 
% reads the trace data from one sweep and then from 5 maxhold / minhold
% faster sweeps from 2 different traces. Then, makes a screenshot of the
% analyzer screen, copies it to the PC and displays it.
% Author: Miloslav Macko  miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com
 
%% Establishing connection
% Clean-up possible open connections
instrreset;

% Try to open the instrument driver session
try
    % Create a device object.
     deviceObj = icdevice('matlab_rsspecan_driver.mdd', 'TCPIP::10.85.0.94::INSTR');

    % Connect device object to hardware.
    connect(deviceObj)
    
    % Reset instrument
    devicereset(deviceObj);
catch ME 
    % Clean-up driver session
    % Delete object
    if exist ('deviceObj')
        delete(deviceObj);
    end
    
    error('Connection to instrument failed:\n%s', ME.message)
end

try
    % Common variables
    SPAwindow = 0; %repeated capability Window 0 (actual window)
    SPArepcap = 'Win0'; %repcap Window 0 (actual window)
    SPArepcapWinTrace1 = 'Win0,TR1'; %repcap Window 0, trace 1
    SPArepcapWinTrace2 = 'Win0,TR2'; %repcap Window 0, trace 2
        
    %% Commonly used group objects
    SetPropObj = get(deviceObj, 'ConfigurationSetGetCheckAttributeSetAttribute');
    GetPropObj = get(deviceObj, 'ConfigurationSetGetCheckAttributeGetAttribute');
    ConfObj = get(deviceObj, 'Configuration');
    ConfDispObj = get(deviceObj, 'Configurationdisplaycontrol');
    ConfHcopyObj = get(deviceObj, 'Configurationhardcopy');
    
    MeasObj = get(deviceObj, 'Measurement');
    MeasLowLevelObj = get(deviceObj, 'Measurementlowlevelmeasurement');
    UtilsObj = get(deviceObj, 'Utility');
    UtilsInstrioObj = get(deviceObj, 'Utilityfunctionsinstrumentio');
    
    % Preparing group object for setting / getting direct properties
    set(deviceObj, 'RepCapIdentifier', SPArepcap);
        
    %% Direct write / read functions for retrieving IDN string
    BufferLen = 1024; %increase if you expect longer response
    ActualReadLen = -1;
    SPAreadBuffer = char (zeros (1, BufferLen));
    SPAwriteBuffer = ['*IDN?' 10]; %line feed character at the end is required by instrument
    
    invoke(UtilsInstrioObj, 'WriteInstrData', SPAwriteBuffer);
    [SPAreadBuffer, ActualReadLen] = invoke(UtilsInstrioObj, 'ReadInstrData', BufferLen, SPAreadBuffer, ActualReadLen);
    
    % Using query function for retrieving *IDN? response
    SPAwriteBuffer = '*IDN?'; %line feed character at the end will be added by the function
    SPAreadBuffer = invoke(UtilsInstrioObj, 'QueryViString', SPAwriteBuffer, BufferLen, SPAreadBuffer);
    
    %% Setting Center frequency and Span using direct attribute setting function
    SPAfrequencyCenter = 2E+9;
    SPAfrequencySpan = 500E+6;
    
    % Using High-level function
    invoke(ConfObj, 'ConfigureFrequencyCenterSpan', SPAwindow, SPAfrequencyCenter, SPAfrequencySpan);
    
    % Or properties settings
    set(deviceObj.Basicoperation, 'Center_Frequency',SPAfrequencyCenter);
    set(deviceObj.Basicoperation, 'Frequency_Span', SPAfrequencySpan);
    % Or alternative properties settings
    invoke(SetPropObj, 'setattributevireal64', SPArepcap, 1150009, SPAfrequencyCenter);
    invoke(SetPropObj, 'setattributevireal64', SPArepcap, 1150014, SPAfrequencySpan);
    
    %% Reading Frequency Start and Frequency Stop - only possible with properties
    SPAfrequencyStart = get(deviceObj.Basicoperation, 'Frequency_Start');
    SPAfrequencyStop = get(deviceObj.Basicoperation, 'Frequency_Stop');
    % Or alternative properties settings
    SPAfrequencyStart = invoke(GetPropObj, 'getattributevireal64', SPArepcap, 1150006);
    SPAfrequencyStop = invoke(GetPropObj, 'getattributevireal64', SPArepcap, 1150007);
         
    %% Set instrument to single sweep
    SPAsweepModeCont = 0;
    SPAnumOfSweeps   = 1;
    invoke(ConfObj, 'configureacquisition', SPAwindow, SPAsweepModeCont, SPAnumOfSweeps);
  
    %% Set and get sweep points
    SPAsweepPoints = 501;
    % Using High-level function
    invoke(ConfObj, 'configuresweeppoints', SPAwindow, SPAsweepPoints);
    % Or properties settings
    set(deviceObj.Basicoperation, 'Sweep_Points', SPAsweepPoints);
    SPAsweepPoints = get(deviceObj.Basicoperation, 'Sweep_Points');
    
    %% Configure Ref Level and Range
    SPArefLevel = 10;
    SPAyRange = 140;
    invoke(ConfObj, 'configurereferencelevel', SPAwindow, SPArefLevel);
    invoke(ConfDispObj, 'configuredisplaylogrange', SPAwindow, SPAyRange);   
    
    %% Configure RBW
    SPA_RBW = 1E+3;
    % Using High-level function
    invoke(ConfObj, 'Configuresweepcoupling', SPAwindow, 0, SPA_RBW);
    % Or properties settings
    set(deviceObj.Basicoperation, 'Resolution_Bandwidth', SPA_RBW);
    % Or alternative properties settings
    invoke(SetPropObj, 'setattributevireal64', SPArepcap, 1150024, SPA_RBW);
    
    %% Configure VBW
    SPA_VBW = 10E+3;
    % Using High-level function
    invoke(ConfObj, 'Configuresweepcoupling', SPAwindow, 1, SPA_VBW);
    % Or properties settings
    set(deviceObj.Basicoperation, 'Video_Bandwidth', SPA_VBW);
    % Or alternative properties settings
    invoke(SetPropObj, 'setattributevireal64', SPArepcap, 1150035, SPA_VBW);
        
    %% Perform the sweep, wait for the end and read trace data all in one
    SPAtrace          = 1;
    SPAtimeoutMs      = 5000;
    SPAarrayLen       = SPAsweepPoints;
    SPAarrayActualLen = -1;
    SPAcoorsX = zeros(SPAarrayLen, 1);
    SPAcoorsY = zeros(SPAarrayLen, 1);
    [SPAarrayActualLen, SPAcoorsY] = invoke(MeasObj, 'readytrace', SPAwindow, SPAtrace, SPAtimeoutMs, SPAarrayLen, SPAcoorsY);
    [SPAarrayActualLen, SPAcoorsX] = invoke(MeasObj, 'fetchxtrace', SPAtrace, SPAarrayLen, SPAcoorsX);
     
    subplot(1, 2, 1);
    hold off;
    plot(SPAcoorsX, SPAcoorsY);
    hold all;
    
    %% Switch Trace 1 to Minhold, Trace 2 to Maxhold and make 5 faster sweeps
    SPA_RBW = 20E+3;
    SPAnumOfSweeps = 5;
    SPAtrace2 = 2; %index for Trace 2
    SPAtrace1Type = 4; %Minhold
    SPAtrace2Type = 3; %Maxhold
       
    set(deviceObj.Basicoperation, 'Resolution_Bandwidth', SPA_RBW);
    set(deviceObj.Basicoperation, 'Number_of_Sweeps', SPAnumOfSweeps);
    
    % Set trace 1 set to Minhold
    set(deviceObj, 'RepCapIdentifier', SPArepcapWinTrace1);
    set(deviceObj.Basicoperationtrace, 'Trace_Type', SPAtrace1Type);
    
    % Set trace 2 set to Maxhold
    set(deviceObj, 'RepCapIdentifier', SPArepcapWinTrace2);
    set(deviceObj.Basicoperationtrace, 'Trace_Type', SPAtrace2Type);
    
    % Initiate the single sweep, wait for it to finish
    SPAtimeoutMs = 15000;
    invoke(MeasLowLevelObj, 'initiate', SPAwindow, SPAtimeoutMs);
    
    % Read trace data 1, no sweeping
    [SPAarrayActualLen, SPAcoorsY] = invoke(MeasObj, 'fetchytrace', SPAwindow, SPAtrace, SPAarrayLen, SPAcoorsY);
    
    % plot 2nd curve to the same graph
    plot(SPAcoorsX, SPAcoorsY);
    hold all;
    
    % Read trace data 2, no sweeping
    [SPAarrayActualLen, SPAcoorsY] = invoke(MeasObj, 'fetchytrace', SPAwindow, SPAtrace2, SPAarrayLen, SPAcoorsY);
    
    % plot 3rd curve to the same graph
    plot(SPAcoorsX, SPAcoorsY);
    hold all;
    
    %% Hardcopy and file transfer to PC
    % Take screenshot of the analyzer screen, store it to the instrument
    % path "c:\matlab_screenshot.png" and copy it to the PC to
    % path "c:\matlab_screenshot.png"
    SPAhcopyDevice = 1;
    SPAhcopyItems = 0; %screenshot of all items
    SPAinstrumentFilePath = 'c:\matlab_screenshot.png';
    SPApcFilePath = 'c:\matlab_screenshot.png';
       
    % Set up the instrument file path
    invoke(ConfHcopyObj, 'HardcopySetFileName', SPAinstrumentFilePath);
        
    % Add a comment string to the SPA screenshot
    invoke(ConfHcopyObj, 'HardcopyComment', SPAreadBuffer); %comment will be *IDN? response string
        
    % Take the screenshot of the SPA screen now
    invoke(ConfHcopyObj, 'HardcopyPrint', SPAhcopyDevice, SPAhcopyItems);
          
    % Transfer the file content to the PC
    invoke(UtilsInstrioObj, 'ReadToFileFromInstrument', SPAinstrumentFilePath, SPApcFilePath);
        
    % Showing the screenshot in 2nd Plot
    [imdata] = imread(SPApcFilePath);
    subplot(1, 2, 2);
    imagesc(imdata);
    
catch ME
    
    %% Evaluate error
    errLen  = 1024;
    errCode = -1;
    errMsg  = zeros(errLen, 1);
    [errCode, errMsg] = invoke(UtilsObj, 'errorquery');
    
    % Disconnect device object from hardware
    disconnect(deviceObj);
    % Delete object
    delete(deviceObj);
       
    error('Exception: %s\nInstrument Error: %d: %s\n', ME.message, errCode, char(errMsg));
    
end

%% Clean-up driver session
if exist ('deviceObj')
    % Disconnect device object from hardware.
    disconnect(deviceObj);
    % Delete object
    delete(deviceObj);
end