clc;
clear;
addpath(genpath('../../Data and code/prtools4112'));

a = gauss(1000, [0 0], eye(2));

c = cov(+a);
[E, D] = eig(c);




