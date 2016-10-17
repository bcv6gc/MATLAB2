%% Rohde & Schwarz GmbH & Co. KG
% 32bit MATLAB calllib example for R&S Spectrum Analyzer Instrument Driver rsspecan
% The example configures spectrum analyzer, performs the sweep, 
% reads the trace data from one sweep and then from 5 maxhold / minhold
% faster sweeps from 2 different traces. Then, makes a screenshot of the
% analyzer screen, copies it to the PC and displays it.
% Author: Miloslav Macko  miloslav.macko@rohde-schwarz.com or TM-Applications@rohde-schwarz.com

%% Add library path
% Check VXIPNPPATH environment variable on your system
addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Include';
addpath 'c:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin';
 
%% Load library of R&S driver
vxipnpLib       = 'rsspecan_32';
vxipnpLibDll    = 'rsspecan_32.dll';
vxipnpHeader    = 'rsspecan.h';
if ~libisloaded (vxipnpLib)
    loadlibrary(vxipnpLibDll, vxipnpHeader);
end
 
% You can use these functions to get information on the functions available in a library that you have loaded:
%libfunctions(vxipnpLib, '-full'); 
%libfunctionsview(vxipnpLib);
 
%% Open VISA session
SPAsession   = -1;
% Declare pointer to SPAresource to pass the string to the dll
SPAresource = 'TCPIP::10.85.0.94::INSTR';
pSPAresource = libpointer( 'int8Ptr', [int8( SPAresource ) 0] );
SPAidQuery   = 1;
SPAreset     = 1;
 
%% Set up connection
[err, ~, SPAsession] = calllib(vxipnpLib, 'rsspecan_init', pSPAresource, SPAidQuery, SPAreset, SPAsession);
if (err) error ('Connection to instrument failed'); end
 
while (true) % Loop to break from in case of error
 
    %% Common variables declaration
    SPAwindow = 0; %repeated capability Window 0 (actual window)
    SPAtrace = 1; %repeated capability Trace 1
    SPArepcap = 'Win0'; %repcap Window 0 (actual window)
    pSPArepcap = libpointer( 'int8Ptr', [int8( SPArepcap ) 0] );
    SPArepcapWinTrace = 'Win0,TR1'; %repcap Window 0, trace 1
    pSPArepcapWinTrace = libpointer( 'int8Ptr', [int8( SPArepcapWinTrace ) 0] );
    RS_SPECIFIC_PUBLIC_ATTR_BASE = 1000000 + 150000; %base offset for attributes number taken from rsidr_core.h
    
    %% Direct write / read functions for retrieving IDN string
    BufferLen = 1024; %increase if you expect longer response
    ActualReadLen = -1;
    SPAreadBuffer = char (zeros (1, BufferLen));
    pSPAreadBuffer = libpointer( 'int8Ptr', [int8(SPAreadBuffer) 0] );
    
    SPAwriteBuffer = ['*IDN?' 10]; %line feed character at the end is required by instrument
    pSPAwriteBuffer = libpointer( 'int8Ptr', [int8(SPAwriteBuffer) 0] );
    
    % Using write + read functions for retrieving *IDN? response
    err = calllib(vxipnpLib, 'rsspecan_WriteInstrData', SPAsession, pSPAwriteBuffer);
    if (err < 0) break;  end %rsspecan_WriteInstrData always returns positive value as warning
    
    [err, SPAreadBuffer, ActualReadLen] = calllib(vxipnpLib, 'rsspecan_ReadInstrData', SPAsession, BufferLen, pSPAreadBuffer, ActualReadLen);
    if (err) break;  end
    
    SPAreadBuffer = char (SPAreadBuffer (1:ActualReadLen - 1)); %trimming the response to ActualReadLen length
    
    % Using query function for retrieving *IDN? response
    SPAwriteBuffer = '*IDN?'; %line feed character at the end will be added by the function
    pSPAwriteBuffer = libpointer( 'int8Ptr', [int8(SPAwriteBuffer) 0] );
    [err, ~, SPAreadBuffer] = calllib(vxipnpLib, 'rsspecan_QueryViString', SPAsession, pSPAwriteBuffer, BufferLen, pSPAreadBuffer);
    if (err) break;  end
    
    Idx = find (SPAreadBuffer == 0);
    SPAreadBuffer = char (SPAreadBuffer (1:Idx - 1)); %trimming the string to proper length by searching for 1st zero
        
    %% Setting Center frequency and Span
    SPAfrequencyCenter = 2E+9;
    SPAfrequencySpan = 500E+6;
    
    % Using High-level function
    [err] = calllib(vxipnpLib, 'rsspecan_ConfigureFrequencyCenterSpan', SPAsession, SPAwindow, SPAfrequencyCenter, SPAfrequencySpan);
    if (err) break;  end
    
    % Or using attributes
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 9; %RSSPECAN_ATTR_FREQUENCY_CENTER taken from rsspecan.h
    [err] = calllib(vxipnpLib, 'rsspecan_SetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPAfrequencyCenter);
    if (err) break;  end
    
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 14; %RSSPECAN_ATTR_FREQUENCY_SPAN taken from rsspecan.h
    [err] = calllib(vxipnpLib, 'rsspecan_SetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPAfrequencySpan);
    if (err) break;  end
        
    %% Reading Frequency Start and Frequency Stop - only possible with attributes
    SPAfrequencyStart = -1;
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 6; %RSSPECAN_ATTR_FREQUENCY_START taken from rsspecan.h
    [err, ~, SPAfrequencyStart] = calllib(vxipnpLib, 'rsspecan_GetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPAfrequencyStart);
    if (err) break;  end
    
    SPAfrequencyStop = -1;
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 7; %RSSPECAN_ATTR_FREQUENCY_STOP taken from rsspecan.h
    [err, ~, SPAfrequencyStop] = calllib(vxipnpLib, 'rsspecan_GetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPAfrequencyStop);
    if (err) break;  end
    
    %% Set instrument to single sweep
    SPAsweepModeCont = 0;
    SPAnumOfSweeps   = 1;
    err = calllib(vxipnpLib, 'rsspecan_ConfigureAcquisition', SPAsession, SPAwindow, SPAsweepModeCont, SPAnumOfSweeps);
    if (err) break;  end
        
    %% Set and get sweep points
    SPAsweepPoints = 501;
    err = calllib(vxipnpLib, 'rsspecan_ConfigureSweepPoints', SPAsession, SPAwindow, SPAsweepPoints);
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 31; %RSSPECAN_ATTR_SWEEP_POINTS taken from rsspecan.h
    [err, ~, SPAsweepPoints] = calllib(vxipnpLib, 'rsspecan_GetAttributeViInt32', SPAsession, pSPArepcap, SPAattr, SPAsweepPoints);
     
    %% Configure Ref Level and Range
    SPArefLevel = 10;
    SPAyRange = 140;
    err = calllib(vxipnpLib, 'rsspecan_ConfigureReferenceLevel', SPAsession, SPAwindow, SPArefLevel);
    if (err) break;  end
    
    err = calllib(vxipnpLib, 'rsspecan_ConfigureDisplayLogRange', SPAsession, SPAwindow, SPAyRange);
    if (err) break;  end
    
    %% Configure RBW
    SPA_RBW = 1E+3;
    % Using High-level function
    err = calllib(vxipnpLib, 'rsspecan_ConfigureSweepCoupling', SPAsession, SPAwindow, 0, SPA_RBW);
    if (err) break;  end
    
    % Or using attribute
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 24; %RSSPECAN_ATTR_RESOLUTION_BANDWIDTH taken from rsspecan.h
    err = calllib(vxipnpLib, 'rsspecan_SetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPA_RBW);
    if (err) break;  end
          
    %% Configure VBW
    SPA_VBW = 10E+3;
    % Using High-level function
    err = calllib(vxipnpLib, 'rsspecan_ConfigureSweepCoupling', SPAsession, SPAwindow, 1, SPA_VBW);
    if (err) break;  end

    % Or using attribute
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 35; %RSSPECAN_ATTR_VIDEO_BANDWIDTH taken from rsspecan.h
    err = calllib(vxipnpLib, 'rsspecan_SetAttributeViReal64', SPAsession, pSPArepcap, SPAattr, SPA_VBW);
    if (err) break;  end
    
    %% Perform the sweep, wait for the end and read trace data all in one
    SPAtrace          = 1;
    SPAtimeoutMs      = 5000;
    SPAarrayLen       = SPAsweepPoints;
    SPAarrayActualLen = -1;
    SPAcoorsX = zeros(SPAarrayLen, 1);
    SPAcoorsY = zeros(SPAarrayLen, 1);
    [err, SPAarrayActualLen, SPAcoorsY] = calllib(vxipnpLib, 'rsspecan_ReadYTrace', SPAsession, SPAwindow, SPAtrace, SPAtimeoutMs, SPAarrayLen, SPAarrayActualLen, SPAcoorsY);
    if (err) break;  end
    
    [err, SPAarrayActualLen, SPAcoorsX] = calllib(vxipnpLib, 'rsspecan_FetchXTrace', SPAsession, SPAtrace, SPAarrayLen, SPAarrayActualLen, SPAcoorsX);
    if (err) break;  end
    
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
    err = calllib(vxipnpLib, 'rsspecan_ConfigureSweepCoupling', SPAsession, SPAwindow, 0, SPA_RBW);
    SPAattr = RS_SPECIFIC_PUBLIC_ATTR_BASE + 21; %RSSPECAN_ATTR_NUMBER_OF_SWEEPS taken from rsspecan.h
    err = calllib(vxipnpLib, 'rsspecan_SetAttributeViInt32', SPAsession, pSPArepcap, SPAattr, SPAnumOfSweeps);
    if (err) break;  end
    
    % Set trace 1 set to Minhold
    err = calllib(vxipnpLib, 'rsspecan_ConfigureTrace', SPAsession, SPAwindow, SPAtrace, SPAtrace1Type);
    if (err) break;  end
    
    % Set trace 2 set to Maxhold
    err = calllib(vxipnpLib, 'rsspecan_ConfigureTrace', SPAsession, SPAwindow, SPAtrace2, SPAtrace2Type);
    if (err) break;  end

    % Initiate the single sweep, wait for it to finish
    SPAtimeoutMs = 15000;
    err = calllib(vxipnpLib, 'rsspecan_Initiate', SPAsession, SPAwindow, SPAtimeoutMs);
    if (err) break;  end
    
    % Read trace data 1, no sweeping
	[err, SPAarrayActualLen, SPAcoorsY] = calllib(vxipnpLib, 'rsspecan_FetchYTrace', SPAsession, SPAwindow, SPAtrace, SPAarrayLen, SPAarrayActualLen, SPAcoorsY);
    if (err) break;  end
	
	% plot 2nd curve to the same graph
	plot(SPAcoorsX, SPAcoorsY);
	
	% Read trace data 2, no sweeping
	[err, SPAarrayActualLen, SPAcoorsY] = calllib(vxipnpLib, 'rsspecan_FetchYTrace', SPAsession, SPAwindow, SPAtrace2, SPAarrayLen, SPAarrayActualLen, SPAcoorsY);
    if (err) break;  end
    
    % plot 3rd curve to the same graph
    plot(SPAcoorsX, SPAcoorsY);
    hold all;
    
    %% Hardcopy and file transfer to PC
    % Take screenshot of the analyzer screen, store it to the instrument
    % path "c:\matlab_screenshot.png" and copy it to the PC to
    % path "c:\matlab_screenshot.png"
    SPAhcopyDevice = 1;
    SPAhcopyColor = 1; %colored picture, 0 means monochromatic
    SPAhcopyDfltSettings = 1; %screen colors, but background white
    SPAhcopyItems = 0; %screenshot of all items
    pSPAinstrumentFilePath = libpointer( 'int8Ptr', [int8('c:\matlab_screenshot.png') 0] );
    SPApcFilePath = 'c:\matlab_screenshot.png';
    pSPApcFilePath = libpointer( 'int8Ptr', [int8(SPApcFilePath) 0] );
    
    % Set up the instrument file path
    err = calllib(vxipnpLib, 'rsspecan_HardcopySetFileName', SPAsession, pSPAinstrumentFilePath);
    if (err) break;  end
    
    % Add a comment string to the SPA screenshot
    err = calllib(vxipnpLib, 'rsspecan_HardcopyComment', SPAsession, pSPAreadBuffer); %comment will be *IDN? response string
    if (err) break;  end
    
    % Take the screenshot of the SPA screen now
    err = calllib(vxipnpLib, 'rsspecan_HardcopyPrint', SPAsession, SPAhcopyDevice, SPAhcopyItems);
    if (err) break;  end
      
    % Transfer the file content to the PC
    err = calllib(vxipnpLib, 'rsspecan_ReadToFileFromInstrument', SPAsession, pSPAinstrumentFilePath, pSPApcFilePath);
    
    % Showing the screenshot in 2nd Plot
    [imdata] = imread(SPApcFilePath);
    subplot(1, 2, 2);
    imagesc(imdata);
    
    %% Connection clean-up
    err = calllib(vxipnpLib, 'rsspecan_close', SPAsession);
    if (err) break;  end
    
    % Exit loop, it should perform only once
    break    
end
 
%% Evaluate error
if (err)
   
    errCode = err;
    errLen  = 1024; 
         
    disp( '*** Error occured' );
    
    % In the case that a session got created we evaluate the error further
    if (SPAsession ~= 0)
        errMsg  = zeros(errLen,1);
        [err, errMsg] = calllib( vxipnpLib, 'rsspecan_error_message', SPAsession, err, errMsg);
        Idx = find (errMsg == 0);
        errMsgTrimmed = errMsg (1:Idx(1) - 1); %trim the string to 1st zero
        errString = sprintf('%s', char (errMsgTrimmed));
        disp(errString);
        
        errMsg  = zeros(errLen,1);
        [err, errCode, errMsg] = calllib( vxipnpLib, 'rsspecan_error_query', SPAsession, errCode, errMsg);
        Idx = find (errMsg == 0);
        errMsgTrimmed = errMsg (1:Idx(1) - 1); %trim the string to 1st zero
        errString = sprintf('Instrument Error queue: "%d: %s"', errCode, char(errMsgTrimmed));
                
        disp(errString);
        
        % Disconnect from the device
        calllib(vxipnpLib, 'rsspecan_close', SPAsession);

    end
    
end
 
%% DLL clean-up
unloadlibrary(vxipnpLib);
clear all