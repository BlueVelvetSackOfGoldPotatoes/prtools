clc;
clear
close all

addpath(genpath('../prtools4112'));

a=gendatb([30 30]);

%% 5.5a
[w,I] = svc(a,'p',1);
figure(1); 
clf; 
scatterd(a); 
plotc(w); 
drawnow;
hold on
scatterd(a(I, :), 'go');

%% 5.5b
[w,I] = svc(a,'p',2);
figure(2); 
clf; 
scatterd(a); 
plotc(w); 
hold on
scatterd(a(I, :), 'go');

%% 5.5c
w = rbnc(a, 4);
figure(3); 
clf; 
scatterd(a); 
plotc(w); 

