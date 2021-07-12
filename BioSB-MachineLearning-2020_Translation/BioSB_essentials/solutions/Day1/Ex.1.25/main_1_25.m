clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

a = gendats([20 20],1,8);
hs=[0.1 0.25 0.5 1 1.5 2 3 4 5];
w = parzenm(+a);
h = parzenml(+a)


