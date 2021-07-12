clc;
clear;
addpath(genpath('../Data and code'));

a = mfeat_zer; 
[tr, te] = gendat(a, 0.25);
tr = setprior(tr, getprior(tr));
te = setprior(te, getprior(te));

w1 = nmc(tr)*classc;
testc(te*w1)

w2 = ldc(tr)*classc;
testc(te*w2)

w3 = qdc(tr)*classc;
testc(te*w3)

w4 = knnc(tr,3)*classc;
testc(te*w4)

w5 = treec(tr)*classc;
testc(te*w5);

v = [w1; w2; w3; w4]*votec;
testc([te te te te]*v)
