clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

a = gendats([20 20],1,8);

k = 1;
w = knnm(a,k);

scatterd(a); 
plotm(w,1);

%% 1.27b
gridsize(500);
scatterd(a); 
plotm(w,1);


%% 1.27c
for k=[1 5 15]
    figure();
    w = knnm(a,k);
    scatterd(a); 
    plotm(w,1);
end




