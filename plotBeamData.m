
folderloc = 'C:\\Users\\krish\\Documents\\ZEMAX\\dla_slm\\simulation_data';
filename = '\\phasedata_SLMon.txt';
lineSkip = 16;
% x data
fid = fopen([folderloc filename]);
for i=1:lineSkip
    fgetl(fid);
end

beamdata = imresize(fscanf(fid,'%f'),[256 256]);

figure
imagesc(beamdata)

fclose(fid); 