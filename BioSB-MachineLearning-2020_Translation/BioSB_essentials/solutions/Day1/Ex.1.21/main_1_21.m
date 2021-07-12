clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

a = gauss(100, [0 0]);
hist2(a);

figure();
b = gauss(10000, [0 0]);
hist2(b);

figure();
b = gauss(1000, [0 0]);
hist2(b, 5);

hist2(b, 20);
