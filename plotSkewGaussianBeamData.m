clear all;
%% Load data in 
folderloc = 'D:\\Documents\\ZEMAX\\Zemax-DLA-SLM\\simulation_data';
xbeamOn_filename = '\\x_beamdata_slmON.txt';
xbeamfilename = '\\x_beamdata.txt';
ybeamfilename = '\\y_beamdata_slmON.txt';
lineSkip = 28;
% x data
fid = fopen([folderloc xbeamfilename]);
for i=1:lineSkip
    fgetl(fid);
end
table_x_header = textscan(fid, '%s %s %s %s %s %s %s',1);
table_x = textscan(fid, '%s %f %f %f %f %f %f');
fclose(fid);
% x data SLM on
fid = fopen([folderloc xbeamOn_filename]);
for i=1:lineSkip
    fgetl(fid);
end
table_xOn_header = textscan(fid, '%s %s %s %s %s %s %s',1);
table_xOn = textscan(fid, '%s %f %f %f %f %f %f');
fclose(fid);

% y data
fid = fopen([folderloc ybeamfilename]);
for i=1:lineSkip
    fgetl(fid);
end
table_y_header = textscan(fid, '%s %s %s %s %s %s %s',1);
table_y = textscan(fid, '%s %f %f %f %f %f %f');
fclose(fid);

%% format data
x_beam = formatBeamData(table_x_header, table_x);
xOn_beam = formatBeamData(table_xOn_header, table_xOn);
y_beam = formatBeamData(table_y_header, table_y);

%% plot data
Z = [0 1202.43 1368.42 1478.42 1602.17 1719.87 1747.87 2069.97 2425.87 2845.23];
X = [x_beam.Size(3) x_beam.Size(6) x_beam.Size(10) x_beam.Size(14) x_beam.Size(15)...
    x_beam.Size(17) x_beam.Size(21) x_beam.Size(25) x_beam.Size(26) x_beam.Size(29)];
X_On = [xOn_beam.Size(3) xOn_beam.Size(6) xOn_beam.Size(10) xOn_beam.Size(14) xOn_beam.Size(15)...
    xOn_beam.Size(17) xOn_beam.Size(21) xOn_beam.Size(25) xOn_beam.Size(26) xOn_beam.Size(29)];
Y = [y_beam.Size(3) y_beam.Size(6) y_beam.Size(10) y_beam.Size(14) y_beam.Size(15)...
    y_beam.Size(17) y_beam.Size(21) y_beam.Size(25) y_beam.Size(26) y_beam.Size(29)];

figure(1)
    plot(Z,X,'--')
 
hold on
    plot(Z,X_On,'-x')
    plot(Z,Y,'-x')
    legend('0th','perp', 'accel')
    title('Spot-sizes')
    xlabel('z [mm]') % x-axis label
    ylabel('Size (waist) [mm]') % y-axis label
hold off
