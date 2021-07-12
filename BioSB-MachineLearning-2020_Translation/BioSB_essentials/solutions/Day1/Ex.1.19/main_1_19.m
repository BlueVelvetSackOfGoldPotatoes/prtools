clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));

a = gauss(1000, zeros(1,2), [1 0;0 4]);
scatterd(a);

figure()
a = gauss(1000, zeros(1,2), [1 1;1 4]);
scatterd(a);

figure()
a = gauss(1000, zeros(1,2), [1 0;0 1000]);
scatterd(a);
axis equal