function [s11,s21,s12,s22,frequency] = s2pToComplexSParam_v3(filename)
delimiter = ',';
startRow = 4;
formatSpec = '%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
frequency = dataArray{:, 1};
s11 = dataArray{:, 2} + 1i*dataArray{:, 3};
s21 = dataArray{:, 4} + 1i*dataArray{:, 5};
s12 = dataArray{:, 6} + 1i*dataArray{:, 7};
s22 = dataArray{:, 8} + 1i*dataArray{:, 9};
end