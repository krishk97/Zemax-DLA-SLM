clear all;

folderloc = 'D:\\Documents\\ZEMAX\\Zemax-DLA-SLM\\simulation_data';
filename = '\\powerdata_SLMon.txt';
lineSkip = 16;
% x data
fid = fopen([folderloc filename]);
for i=1:lineSkip
    fgetl(fid);
end

beamdata = fscanf(fid,'%f');
beam = reshape(beamdata',[256 256])';

figure 
imagesc(beam)
