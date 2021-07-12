clc;
clear;

prprogress on; 
w = []; 
u = [10 10];
rand('state',99);
randn('state',99);
a = gendatb(100);

w = rbnc(a, 50);
figure(1); 
clf; 
scatterd(a); 
plotc(w); 
drawnow;