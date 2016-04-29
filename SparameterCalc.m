total_length = 23;
material_length = 1; % cm
line_length = (total_length - material_length)/2;
frequency = 1e8:1e8:1e10;
tx1 = rfckt.parallelplate('width',1.316,'Separation',1.000,'LineLength',total_length,'SigmaCond',6e7,'EpsilonR',1);
tx2 = rfckt.parallelplate('width',1.316,'Separation',1.000,'LineLength',total_length,'SigmaCond',6e7,'EpsilonR',3);
%tx3 = rfckt.parallelplate('width',1.316,'Separation',1.000,'LineLength',line_length,'SigmaCond',6e7);
%tx4 = rfckt.cascade('Ckts',{tx2,tx3,tx2});
analyze(tx1,frequency)
[airS21,~,~] = calculate(tx1,'S21','dB');
analyze(tx2, frequency)
[dutS21,~,~] = calculate(tx2,'S21','dB');
plot(frequency, airS21{:}, frequency, dutS21{:})