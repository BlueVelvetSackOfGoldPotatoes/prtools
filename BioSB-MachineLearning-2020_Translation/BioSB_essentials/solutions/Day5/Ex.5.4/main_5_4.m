clc;
clear all
addpath(genpath('../prtools4112'));

a=gendats([20 20],2,5);

[w,I] = svc(a,'p',1);

figure(1); 
clf; 
scatterd(a); 
plotc(w); 
drawnow;

hold on
scatterd(a(I, :), 'go');