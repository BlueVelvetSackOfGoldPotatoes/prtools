clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));

a2 = gauss(10, zeros(1,2));
a5 = gauss(10, zeros(1,5));
a10 = gauss(10, zeros(1,10));


cn = [cond(cov(+a2)) cond(cov(+a5)) cond(cov(+a10))];
plot([2 5 10], cn);