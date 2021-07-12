clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));

a = gauss(1000, [0 0], [3 1.5;1.5 2]);

n = [10 50 100 250 500];
for i = 1:length(n)
    for j = 1:1000
        a = gauss(n(i),0,1);
        m(j) = mean(a); 
        v(j) = var(a);
    end;
    mean_m(i) = mean(m); std_m(i) = std(m); 
    mean_v(i) = mean(v); std_v(i) = std(v);
end;
figure(1); 
errorbar(n,mean_m,std_m); 
figure(2); 
errorbar(n,mean_v,std_v);