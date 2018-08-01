% load and initialize data 
data = load("pathlength_ON.txt");
wave1 = data(data(:,3)==1,1:2);
wave2 = data(data(:,3)==2,1:2);
wave3 = data(data(:,3)==3,1:2);

figure(1)
    scatter(wave1(:,1),wave1(:,2),'b')

hold on
    scatter(wave2(:,1),wave2(:,2),'g')
    scatter(wave3(:,1),wave3(:,2),'r')
    xlabel('yf - yc');
    ylabel('(pl+(k-4)*chirp-pl0)/0.3');
    legend('800nm','780nm','820nm');
hold off
