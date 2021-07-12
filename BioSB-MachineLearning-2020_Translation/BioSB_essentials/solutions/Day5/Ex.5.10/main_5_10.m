clc;
clear;
addpath(genpath('../Data and code'));

a = mfeat_kar; [b1,c1] = gendat(a,0.25);
a = mfeat_zer; [b2,c2] = gendat(a,0.25);
a = mfeat_mor; [b3,c3] = gendat(a,0.25);

w1 = nmc(b1)*classc; 
w2 = nmc(b2)*classc;
w3 = nmc(b3)*classc;
v = [w1; w2; w3]*meanc;

c1*w1*testc, c2*w2*testc, c3*w3*testc
[c1 c2 c3]*v*testc

%% section b
a = gendatb(50);
w1 = nmc(a)*classc;
w2 = fisherc(a)*classc;
w3 = qdc(a)*classc;
a_out = [a*w1 a*w2 a*w3];
v1 = [w1 w2 w3]*fisherc(a_out);
testc(a*v1)

%% section c
v_tmp = [nmc*classc fisherc*classc qdc*classc]*fisherc;
v2 = a*v_tmp;
testc(a*v2)

