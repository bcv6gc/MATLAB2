function filestruct = MakeFileStruct(folder,airfile,mutfile,mut180,width,powers)
filestruct.airfile = fullfile(folder,airfile);
filestruct.mutfile = fullfile(folder,mutfile);
filestruct.mut180 = fullfile(folder,mut180);
filestruct.width = width;
filestruct.powers = powers;
end