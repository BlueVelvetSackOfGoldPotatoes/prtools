clc;
clear;
addpath(genpath('../Data and code'));

a = gendatd([110 110], 2);
[tr, te] = gendat(a,0.1);

w0 = baggingc(tr, nmc, 5);
testc(te*w0)

w1 = baggingc(tr, nmc, 10);
testc(te*w1)

w2 = baggingc(tr, nmc, 30);
testc(te*w2)

w3 = baggingc(tr, nmc, 70);
testc(te*w3)

w4 = baggingc(tr, nmc, 100);
testc(te*w4)

w5 = baggingc(tr, nmc, 130);
testc(te*w5)