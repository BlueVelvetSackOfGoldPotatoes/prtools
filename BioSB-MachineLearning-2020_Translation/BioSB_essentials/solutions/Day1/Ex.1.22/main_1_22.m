clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

a = gendats([20 20],1,8);
h = 0.5;

w = parzenm(+a,h);

gridsize(100);
scatterd(+a); plotm(w,1);

% saveas(gcf,'figparzen','m');
