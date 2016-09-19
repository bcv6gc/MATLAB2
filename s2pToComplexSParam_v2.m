function [s11,s21,s12,s22,frequency] = s2pToComplexSParam_v2(filename,filelength)
headerOffset = 3;
smat = dlmread(filename,',',[headerOffset 0 filelength 8]);
frequency = smat(:,1);
s11=smat(:,2) + 1i*smat(:,3);
s21=smat(:,4) + 1i*smat(:,5);
s12=smat(:,6) + 1i*smat(:,7);
s22=smat(:,8) + 1i*smat(:,9);
end