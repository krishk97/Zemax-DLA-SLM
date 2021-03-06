clear;
%% Script to make single images for the exulus
%(I)Initializations + definitions
%(II) Define mask(s)
%(III) Display mask(s)

%% (I) Initializations + definitions
	%Exculus stats
		ex_res=[1079,1919]; %height, width
        ex_pitch = 6.4e-6; % exulus pixel pitch [m]

	%PBPL measured stats
		ex_max_phase=2*pi;%(black-white) goes (0 to ex_max_phase) at 800nm
		l_cx=ex_res(2)/2 + 0; % where the center of the laser hits the exulus (in px)
		l_cy=ex_res(1)/2 + 0;  % where the center of the laser hits the exulus (in px)

	%physics constants
		speedLight=2.99792456*(10^8); %m/s


	%laser stats
		l_lambda=800e-9;
		l_k0=2*pi/l_lambda;
		l_omega=speedLight*l_k0;
        
	%initialize image;
		im=zeros(ex_res);

	%initialize coordinates
		ys=1:ex_res(1);
		    ys=ys-l_cy;
		xs=1:ex_res(2);
		    xs=xs-l_cx;
		[X,Y]=meshgrid(xs,ys);

	%convert to m
		X=X*ex_pitch; Y=Y*ex_pitch;
		
%% (II) Define phase profiles
	%to combine add the "phases" (instead of re-writing each time)

	%Mask (only applies phase in a particular region)
		mask_xc=0.5; %units fracition (i.e. 0 to 1)
		mask_yc=0.5;
		mask_xL=0.99;
		mask_yL=0.99;
		
		
		s=size(im);
		mask=zeros(s);
		mask(round(s(1)*(mask_xc-mask_xL/2)):round(s(1)*(mask_xc+mask_xL/2)),round(s(2)*(mask_yc-mask_yL/2)):round(s(2)*(mask_yc+mask_yL/2)))=1;

	%Cylindrical lens
		xf=651e-3; %x focal length (m)
		yf=295e-3; %y focal length (m)
		phases=0;
        phases=l_k0/2*((X.^2/xf)+(Y.^2/yf));
        
        %phases=phases+0.5*sin(2*pi*(Y)/(700*0.8e-6));
		%		taper=@(z)-3.147137282755701e7*z + 2.356194490192345e15*(-1.0225662495144752e-10 + 3.3333333333333334e-9*sqrt(0.0009410775611814901 + 0.2461778150009442*z + 16.*z.^2));
        %phases=phases+fliplr(taper(Y-min(Y(:))-0.8e-3));
        
	%Tilt(s)  *should steer and disperse the beam, a lot like a prism
		xtilt=0e-3; %rad
		ytilt=0e-3; %rad
        
		phases=phases+sin(xtilt)*l_k0*X+sin(ytilt)*l_k0*Y;
		%phases = mod(phases,2*pi);
    figure(1)
        imagesc(phases)
        colorbar
        title("Phase retardance mask") 
    
    filename = "zemaxGridPhase_lens_xf651_yf651.dat";
    makeZemaxGridPhase(phases,ex_res,[ex_pitch*10^3 ex_pitch*10^3],0,[0 0],filename);
    
    
%% MAKEZEMAXGRIDPHASE
function makeZemaxGridPhase(phases,ex_res,ex_pitch,unitflag,dec,filename)
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