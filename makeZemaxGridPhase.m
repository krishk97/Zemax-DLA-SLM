function [outputArg1,outputArg2] = makeZemaxDat(phases,ex_res,ex_pitch,unitflag,dec)
%MAKEZEMAXDAT
% This function makes a Zemax Grid Phase Dat file for use in Zemax
%   INPUTS:
%   phases - phase mask image to be converted into zemax grid phase file
%   ex_res - resolution of grid phase image
%   ex_pitch - pixel size in mm
%   unitflag - scale the delx, dely, and derivative values
%   dec - decenter coordinates decenter of the grid points relative to the
%   base surface in x and y.
%   OUTPUTS:
%   no outputs

% Initialization
nx = ex_res(2); ny = ex_res(1);
delx = ex_pitch(2); dely = ex_pitch(1); 
xdec = dec(2); ydec = dec(1); 
filename = "zemaxGridPhase.dat";

% Open file and enter first set of parameters
fileID = fopen(filename, "wt");
fprintf(fileID, "%i %i %.9E %.9E %i %.9E %.9E\n", nx, ny, delx, dely,unitflag,xdec,ydec);

% Vectorize phases img
vec_phases = reshape(phases.',[1 nx*ny]);

% Enter phase values into file 
fprintf(fileID, "%.9E 0 0 0 0\n",vec_phases);

% Close file
fclose(fileID); 


end

