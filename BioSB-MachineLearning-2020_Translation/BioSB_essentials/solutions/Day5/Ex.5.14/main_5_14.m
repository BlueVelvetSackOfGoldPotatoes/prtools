clc;
clear;
addpath(genpath('../Data and code'));

a = gendatd([110 110], 2);

[tr, te] = gendat(a,0.1);

w0 = nmc(tr);
testc(te*w0)

w1 = baggingc(tr, nmc, 20);
testc(te*w1)

figure(1); 
scatterd(a); 
plotc(w0);
hold on
plotc(w1);


