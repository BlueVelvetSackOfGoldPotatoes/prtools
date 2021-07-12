clc;
clear;
addpath(genpath('../Data and code'));

a = gendatb([50 50]);
b = gendatb([50 50]);

w1 = nmc(a)*classc;
testc(b*w1);

w2 = fisherc(a)*classc;
testc(b*w2);

w3 = qdc(a)*classc;
testc(b*w3);

v = [w1, w2, w3]*meanc;
testc(b*v);
parsc(v)
