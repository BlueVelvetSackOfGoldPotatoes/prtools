clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

n = 1000;
for i = 1:10
    a = gauss(n,0);
    h(i,:) = hist(+a,-5:5);
end
errorbar (-5:5, mean(h), std(h));


for i = 1:10
    a = laplace(n,1);
    h(i,:) = hist(+a,-5:5);
end
figure();
errorbar (-5:5, mean(h), std(h));
