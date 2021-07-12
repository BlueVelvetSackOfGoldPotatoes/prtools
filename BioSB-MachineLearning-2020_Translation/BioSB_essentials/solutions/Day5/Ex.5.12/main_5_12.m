clc;
clear;
addpath(genpath('../Data and code'));

a = mfeat_kar; rand('seed',1); [b1,c1] = gendat(a,0.5);
w1 = nmc(b1); 
testc(c1*w1);

a = mfeat_zer; rand('seed',1); [b2,c2] = gendat(a,0.5);
w2 = nmc(b2); 
testc(c2*w2);

a = mfeat_mor; rand('seed',1); [b3,c3] = gendat(a,0.5);
w3 = nmc(b3); 
testc(c3*w3);

v = [w1; w2; w3]*votec;
testc([c1 c2 c3]*v)