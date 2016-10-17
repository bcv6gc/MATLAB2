%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for custom rsspecan 2.7.1 Spectrum Analyzer Instrument Driver
% custom_matlab_rsspecan_driver_2.7.1.mdd
% This example uses custom built MATLAB mdd driver which will be provided with
% rsspecan VXI plug&play driver

% Differences to MATLAB makemid driver:
% - No group object, only device object is used for accessing all functions
% - Function names are exactly the same as in rsspecan_vxi.chm driver help
% (simply copy and paste), but the prefix rsspecan_ is removed
% - all new R&S VXIpnp drivers: help files will contain snippets of
% MATLAB code for functions and properties
% - Accessing properties is easier with more possibilities to find and address them
% - rsspecan_vxi.chm help file is intended to be used, so mdd file contains no help fields
% - R&S custom rsspecan mdd driver is cca 8x smaller than output file from makemid

% The example configures spectrum analyzer, performs the sweep, 
% reads the trace data from one sweep and then from 5 maxhold / minhold
% faster sweeps from 2 different traces. Then, makes a screenshot of the
% analyzer screen, copies it to the PC and displays it.
% Author: Miloslav Macko miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com

%% Establishing connection
% Clean-up possible open connections
%instrreset;

% Try to open the instrument driver session

try
    % Create a device object.
     %deviceObj = icdevice('matlab_custom_rsspecan_driver32.mdd', 'TCPIP::10.85.0.94::INSTR');
     deviceObj = icdevice('custom_matlab_rsspecan_driver_2.7.1.mdd', 'TCPIP::10.85.0.94::INSTR');

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
        
    % Preparing group object for setting / getting direct properties
    set(deviceObj, 'RepCapIdentifier', SPArepcap);
        
    %% Direct write / read functions for retrieving IDN string
    BufferLen = 512; %buffer size for the response
    ActualReadLen = -1;
    %SPAreadBuffer = char (zeros (1, BufferLen));
    SPAwriteBuffer = ['*IDN?' 10]; %line feed character at the end is required by instrument
    
    invoke(deviceObj, 'WriteInstrData', SPAwriteBuffer);
    [SPAreadBuffer, ActualReadLen] = invoke(deviceObj, 'ReadInstrData', BufferLen);
    
    % for 'ReadInstrData':
    % input param BufferLen is non-mandatory, default value is 1024
    % output param ActualReadLen can be skipped if not needed
    invoke(deviceObj, 'WriteInstrData', SPAwriteBuffer);
    SPAreadBuffer = invoke(deviceObj, 'ReadInstrData');
    
    % Using query function for retrieving *IDN? response
    SPAwriteBuffer = '*IDN?'; %line feed character at the end will be added by the function
    SPAreadBuffer = invoke(deviceObj, 'QueryViString', SPAwriteBuffer);
    
    %% Setting Center frequency and Span using direct attribute setting function
    SPAfrequencyCenter = 2E+9;
    SPAfrequencySpan = 500E+6;
    
    % Using High-level function
    invoke(deviceObj, 'ConfigureFrequencyCenterSpan', SPAwindow, SPAfrequencyCenter, SPAfrequencySpan);
    
    % Or properties settings
    
    %property identificator can be:
    % 'Center Frequency' or 'Center_Frequency'
    % or 'RSSPECAN_ATTR_FREQUENCY_CENTER' or 'ATTR_FREQUENCY_CENTER' which can be found in rsspecan_vxi.chm file
    % Search for the property is case insensitive
    invoke(deviceObj, 'SetProperty', 'ATTR_FREQUENCY_CENTER', SPAfrequencyCenter);
    invoke(deviceObj, 'SetProperty', 'RSSPECAN_Attr_FrequencY_SpaN', SPAfrequencySpan);
            
    %% Reading Frequency Start and Frequency Stop - only possible with properties
    SPAfrequencyStart = invoke(deviceObj, 'GetProperty', 'ATTR_FREQUENCY_START');
    SPAfrequencyStart = invoke(deviceObj, 'GetProperty', 'ATTR_FREQUENCY_STOP');
             
    %% Set instrument to single sweep
    SPAsweepModeCont = 0;
    SPAnumOfSweeps   = 1;
    invoke(deviceObj, 'ConfigureAcquisition', SPAwindow, SPAsweepModeCont, SPAnumOfSweeps);
  
    %% Set and get sweep points
    SPAsweepPoints = 501;
    % Using High-level function
    invoke(deviceObj, 'ConfigureSweepPoints', SPAwindow, SPAsweepPoints);
    % Or properties settings
    invoke(deviceObj, 'SetProperty', 'Sweep Points', SPAsweepPoints);
    SPAsweepPoints = invoke(deviceObj, 'GetProperty', 'Sweep Points');
    
    %% Configure Ref Level and Range
    SPArefLevel = 10;
    SPAyRange = 140;
    invoke(deviceObj, 'ConfigureReferenceLevel', SPAwindow, SPArefLevel);
    invoke(deviceObj, 'ConfigureDisplayLogRange', SPAwindow, SPAyRange);   
    
    %% Configure RBW
    SPA_RBW = 1E+3;
    % Using High-level function
    invoke(deviceObj, 'ConfigureSweepCoupling', SPAwindow, 0, SPA_RBW);
    % Or properties settings
    invoke(deviceObj, 'SetProperty', 'Resolution_Bandwidth', SPA_RBW);
        
    %% Configure VBW
    SPA_VBW = 10E+3;
    % Using High-level function
    invoke(deviceObj, 'Configuresweepcoupling', SPAwindow, 1, SPA_VBW);
    % Or properties settings
    invoke(deviceObj, 'SetProperty', 'Video_Bandwidth', SPA_VBW);
           
    %% Perform the sweep, wait for the end and read trace data all in one
    SPAtrace          = 1;
    SPAtimeoutMs      = 5000;
    SPAarrayLen       = SPAsweepPoints;
    SPAarrayActualLen = -1;
    SPAcoorsX = 0;
    SPAcoorsX = zeros(SPAarrayLen, 1);
    SPAcoorsY = zeros(SPAarrayLen, 1);
    [SPAarrayActualLen, SPAcoorsY] = invoke(deviceObj, 'ReadYTrace', SPAwindow, SPAtrace, SPAtimeoutMs, SPAarrayLen, SPAcoorsY);
    [SPAarrayActualLen, SPAcoorsX] = invoke(deviceObj, 'FetchXTrace', SPAtrace, SPAarrayLen, SPAcoorsX);
     
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
       
    invoke(deviceObj, 'SetProperty', 'Resolution_Bandwidth', SPA_RBW);
    invoke(deviceObj, 'SetProperty', 'Number_of_Sweeps', SPAnumOfSweeps);
    
    % Set trace 1 set to Minhold
    set(deviceObj, 'RepCapIdentifier', SPArepcapWinTrace1);
    invoke(deviceObj, 'SetProperty', 'Trace_Type', SPAtrace1Type);
    %or with one command:
    invoke(deviceObj, 'SetProperty', 'Trace_Type', SPAtrace1Type, SPArepcapWinTrace1);
    
    % Set trace 2 set to Maxhold
    set(deviceObj, 'RepCapIdentifier', SPArepcapWinTrace2);
    invoke(deviceObj, 'SetProperty', 'Trace_Type', SPAtrace2Type);
    %or with one command:
    invoke(deviceObj, 'SetProperty', 'Trace_Type', SPAtrace2Type, SPArepcapWinTrace2);
    
    % Initiate the single sweep, wait for it to finish
    SPAtimeoutMs = 15000;
    invoke(deviceObj, 'Initiate', SPAwindow, SPAtimeoutMs);
    
    % Read trace data 1, no sweeping
    [SPAarrayActualLen, SPAcoorsY] = invoke(deviceObj, 'FetchYTrace', SPAwindow, SPAtrace, SPAarrayLen, SPAcoorsY);
    
    % plot 2nd curve to the same graph
    plot(SPAcoorsX, SPAcoorsY);
    hold all;
    
    % Read trace data 2, no sweeping
    [SPAarrayActualLen, SPAcoorsY] = invoke(deviceObj, 'FetchYTrace', SPAwindow, SPAtrace2, SPAarrayLen, SPAcoorsY);
    
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
    invoke(deviceObj, 'HardcopySetFileName', SPAinstrumentFilePath);
        
    % Add a comment string to the SPA screenshot
    invoke(deviceObj, 'HardcopyComment', SPAreadBuffer); %comment will be *IDN? response string
        
    % Take the screenshot of the SPA screen now
    invoke(deviceObj, 'HardcopyPrint', SPAhcopyDevice, SPAhcopyItems);
          
    % Transfer the file content to the PC
    invoke(deviceObj, 'ReadToFileFromInstrument', SPAinstrumentFilePath, SPApcFilePath);
        
    % Showing the screenshot in 2nd Plot
    [imdata] = imread(SPApcFilePath);
    subplot(1, 2, 2);
    imagesc(imdata);
    
catch ME
    %% Evaluate error
    errLen  = 1024;
    errCode = -1;
    errMsg  = zeros(errLen, 1);
    [errCode, errMsg] = invoke(deviceObj, 'error_query');
    errMsg = char(errMsg);
    
    %% Clean-up driver session
    disconnect(deviceObj);
    % Delete object
    if exist ('deviceObj')
        delete(deviceObj);
    end
    
    if (errCode == 0)
        error('Exception: %s\n', ME.message);
    else
        error('Exception: %s\nInstrument Error: %d: %s\n', ME.message, errCode, errMsg);
    end
end

%% Clean-up driver session
disconnect(deviceObj);
% Delete object
if exist ('deviceObj')
    % Disconnect device object from hardware.
    disconnect(deviceObj);
    % Delete object
    delete(deviceObj);
end
 
% Clean-up driver session
clear all;