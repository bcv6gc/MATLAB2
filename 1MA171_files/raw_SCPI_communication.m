%% Rohde & Schwarz GmbH & Co. KG
% MATLAB TMTOOL example for raw SCPI communication over VISA

% Find a VISA-TCPIP object.
obj1 = instrfind('Type', 'visa-tcpip', 'RsrcName', 'TCPIP::10.85.0.94::INSTR', 'Tag', '');
 
% Create the VISA-TCPIP object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = visa('NI', 'TCPIP::10.85.0.94::INSTR');
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Configure instrument object for input/output buffers size
set(obj1, 'InputBufferSize', 2048);
set(obj1, 'OutputBufferSize', 4096);

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
data1 = query(obj1, '*IDN?')
 
% Disconnect from instrument object, obj1.
fclose(obj1);