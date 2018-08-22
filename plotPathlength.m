clear 

% load and initialize data 
pathname = 'C:\\Users\\krish\\Documents\\ZEMAX\\dla_slm\\simulation_data';
filename = '\\pathlength_drift394.txt';
data = load([pathname filename]);
wave1 = data(data(:,3)==1,1:2);
wave2 = data(data(:,3)==2,1:2);
wave3 = data(data(:,3)==3,1:2);

% fitting parameters
p = polyfit(wave1(:,1),wave1(:,2),1);
beta = - p(1)*0.3;
plotlabel = sprintf('electron beta = %.3f',beta);

figure(1)
    scatter(wave1(:,1),wave1(:,2),'g')
   
hold on
    scatter(wave2(:,1),wave2(:,2),'b')
    scatter(wave3(:,1),wave3(:,2),'r')
    plot(wave1(:,1),polyval(p,wave1(:,1)))
    xlabel('Radial height [mm]');
    ylabel('Time [ps]');
    legend('800nm','780nm','820nm',plotlabel);
hold off
