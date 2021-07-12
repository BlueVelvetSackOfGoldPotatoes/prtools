clc;
clear;
close all

addpath(genpath('../Data and code'));

% a = gendatb(100);
a = gendatc(100);


[w,v] = adaboostc(a, stumpc, 10);

figure();
scatterd(a);
hold on
% gridsize(300);
plotc(w, 'r', 3);
plotc(v*votec,'g',3);
plotc(a*(v*fisherc),'b',3);



