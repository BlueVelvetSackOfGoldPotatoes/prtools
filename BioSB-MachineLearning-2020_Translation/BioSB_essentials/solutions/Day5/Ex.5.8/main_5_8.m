clc;
clear;
addpath(genpath('../Data and code'));

a = gendatb([50 50]);

w1 = nmc(a);
p1 = a*w1*classc;

w2 = fisherc(a);
p2 = a*w2*classc;

p = [p1 p2];

%% 5.8b
scatterd([p(:,1) p(:,3)])


w = w1*w2;
roc_curve = roc(a,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);

testc(a*w);

