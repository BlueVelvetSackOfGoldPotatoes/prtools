clc;
clear;
addpath(genpath('../../Data and code/prtools4112'));

a = gauss(1000, [0 0], [3 0;0 1]);
c = cov(+a);
[E, D] = eig(c);

scatterd(a);
hold on; 
plot([0 E(1,1)],[0 E(2,1)],'r-', 'linewidth', 3)
plot([0 E(1,2)],[0 E(2,2)],'g-', 'linewidth', 3)
plot([0 E(1,1)*D(1,1)],[0 E(2,1)*D(1,1)],'r-', 'linewidth', 3)
plot([0 E(1,2)*D(2,2)],[0 E(2,2)*D(2,2)],'g-', 'linewidth', 3)

clf;
a = gauss(1000, [0 0], [3 -1.5;-1.5 2]);
c = cov(+a);
[E, D] = eig(c);
scatterd(a);
hold on; 
plot([0 E(1,1)*D(1,1)],[0 E(2,1)*D(1,1)],'r-', 'linewidth', 3)
plot([0 E(1,2)*D(2,2)],[0 E(2,2)*D(2,2)],'g-', 'linewidth', 3)


