clc;
clear;
addpath(genpath('../Data and code'));

a = gendatb(100);
[tra, tea] = gendat(a,0.5);

b = gendath(100);
[trb, teb] = gendat(b,0.5);

v1 = weakc([],0.5,1,0); v1 = setname(v1,'weak0-1');
v2 = weakc([],0.5,3,0); v2 = setname(v2,'weak0-3');
v3 = weakc([],0.5,20,0); v3 = setname(v3,'weak0-20');
w = {nmc,v1,v2,v3};

v = a*w;
scatterd(a);
plotc(v);
