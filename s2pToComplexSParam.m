function [s11,s21,s12,s22,frequency] = s2pToComplexSParam(filename,filelength)
headerOffset = 9;
frequency = dlmread(filename,' ',headerOffset,0,[headerOffset 0 filelength 0]);
mag11 = dlmread(filename,' ',headerOffset,1,[headerOffset 1 filelength 1]);
phase11 = dlmread(filename,' ',headerOffset,2,[headerOffset 2 filelength 2]);
mag21 = dlmread(filename,' ',headerOffset,3,[headerOffset 3 filelength 3]);
phase21 = dlmread(filename,' ',headerOffset,4,[headerOffset 4 filelength 4]);
mag12 = dlmread(filename,' ',headerOffset,5,[headerOffset 5 filelength 5]);
phase12 = dlmread(filename,' ',headerOffset,6,[headerOffset 6 filelength 6]);
mag22 = dlmread(filename,' ',headerOffset,7,[headerOffset 7 filelength 7]);
phase22 = dlmread(filename,' ',headerOffset,8,[headerOffset 8 filelength 8]);
s11=complex((10.^(mag11/20)).*exp(1i*phase11/180*pi));
s21=complex((10.^(mag21/20)).*exp(1i*phase21/180*pi));
s12=complex((10.^(mag12/20)).*exp(1i*phase12/180*pi));
s22=complex((10.^(mag22/20)).*exp(1i*phase22/180*pi));
end