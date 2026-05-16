x1 = data(:,1);
x2 = data(:,2);
x3 = data(:,3);
x4 = data(:,4);
y  = data(:,5);

figure
plot(x1, y, 'o-')
grid on

xlabel('Temperature, ^\circC')
ylabel('Ethylene fraction concentration, %')
title('Dependence of concentration on temperature')