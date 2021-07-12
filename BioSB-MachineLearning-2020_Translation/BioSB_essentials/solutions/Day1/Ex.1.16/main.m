clc;
clear;
addpath(genpath('../../Data and code/prtools4112'));

a = gauss(1000, [0 0], [3 1.5;1.5 2]);

[E,D] = eig(cov(+a)); 
b = a*E*(inv(sqrt(D)));

scatterd(b);
hold on; 
% Draw the axes of a
plot([0 E(1,1)*D(1,1)],[0 E(2,1)*D(1,1)],'r-', 'linewidth', 3)
plot([0 E(1,2)*D(2,2)],[0 E(2,2)*D(2,2)],'g-', 'linewidth', 3)
