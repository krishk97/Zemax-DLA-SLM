clear all;
%% MAIN
folderloc = 'C:\\Users\\krish\\Documents\\ZEMAX\\Zemax-DLA-SLM\\simulation_data\\lens_xf651_yf295';
filename_power_SLMoff = '\\powerdata_SLMoff.txt';
filename_phase_SLMoff = '\\phasedata_SLMoff.txt';
filename_power_SLMon = '\\powerdata_SLMon.txt';
filename_phase_SLMon = '\\phasedata_SLMon.txt';
path_power_SLMoff = [folderloc filename_power_SLMoff];
path_phase_SLMoff = [folderloc filename_phase_SLMoff];
path_power_SLMon = [folderloc filename_power_SLMon];
path_phase_SLMon = [folderloc filename_phase_SLMon];

% format beam profiles
[x_SLMoff, y_SLMoff, power_SLMoff] = formatZemaxPOP(path_power_SLMoff); 
[~, ~, phase_SLMoff] = formatZemaxPOP(path_phase_SLMoff); 
[x_on, y_on, power_SLMon] = formatZemaxPOP(path_power_SLMon); 
[~, ~, phase_SLMon] = formatZemaxPOP(path_phase_SLMon); 

% find beam edges
BW_SLMoff = im2bw(power_SLMoff,0.7);
BW_SLMon = im2bw(power_SLMon,0.7);
stats_SLMoff = regionprops(BW_SLMoff, 'BoundingBox');
stats_SLMon = regionprops(BW_SLMon, 'BoundingBox');

figure(1)
    imagesc(power_SLMoff)
    colorbar
hold on 
    rectangle('Position', stats_SLMoff(1).BoundingBox, 'Linewidth', 3, ...
        'EdgeColor', 'r', 'LineStyle', '-');
    title('Beam edge finding, SLM OFF'); 
hold off

figure(2)
    imagesc(power_SLMon)
    colorbar
hold on 
    rectangle('Position', stats_SLMon(1).BoundingBox, 'Linewidth', 3, ...
        'EdgeColor', 'r', 'LineStyle', '-');
    title('Beam edge finding, SLM ON'); 
hold off

% show phase data
phase_SLMoff = imcrop(phase_SLMoff, stats_SLMoff(1).BoundingBox);
figure(3),
    imagesc(phase_SLMoff)
    colorbar
    title('Phase profile, SLM OFF')
    
phase_SLMon = imcrop(phase_SLMon, stats_SLMon(1).BoundingBox);
figure(4),
    imagesc(phase_SLMon)
    colorbar
    title('Phase profile, SLM ON')

 % show lens
 lens = load([folderloc '\\lens_xf651_yf295.txt']);
 figure(5); 
    imagesc(lens)

%% FORMATZEMAXPOP
function [X Y beam] = formatZemaxPOP(path)
%FORMATZEMAXPOP Formats data from Zemax Physical Optics Propogation (POP)
% into X, Y structs and beam matrix
%   Inputs: 
% path - path to Zemax POP data text file 
%   Outputs: 
% X, Y - struct with fields: 
%   pixnum - number of pixels
%   pixsize - size of each pixel
%   size - (waist) size at surface
%   waist - waist (w0) size of beam
%   pos - z location of X waist
%   rayleigh - rayleigh range (zR) of beam 
% beam - matrix containing main data from POP text file

    lineSkip = 16; 
    fid = fopen(path);
    for i=1:lineSkip
        fgetl(fid);
    end

    X.pixnum = 0; Y.pixnum = 0;
    X.pixsize = 0; Y.pixsize = 0;
    X.size = 0; Y.size = 0;

    beamdata = fscanf(fid,'%f');
    beam = reshape(beamdata',[1024 1024]);

end

