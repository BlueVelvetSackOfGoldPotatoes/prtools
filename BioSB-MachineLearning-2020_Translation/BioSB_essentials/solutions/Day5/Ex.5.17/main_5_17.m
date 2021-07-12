clc;
clear;
addpath(genpath('../Data and code'));

a = gendath(100);
% [tr, te] = gendat(a,0.5);

v1 = weakc([],0.5,1,0); v1 = setname(v1,'weak0-1');
v2 = weakc([],0.5,3,0); v2 = setname(v2,'weak0-3');
v3 = weakc([],0.5,20,0); v3 = setname(v3,'weak0-20');
w = {nmc,v1,v2,v3};

figure(1);
e = cleval(a, w, [5,10,15,20,30,50], 5);
plote(e)

%% 5.17b
b = gendatc(100);
v1 = weakc([],0.5,1,1); v1 = setname(v1,'weak0-1');
v2 = weakc([],0.5,3,1); v2 = setname(v2,'weak0-3');
v3 = weakc([],0.5,20,1); v3 = setname(v3,'weak0-20');
w = {qdc,v1,v2,v3};

figure(1);
e = cleval(b, w, [5,10,15,20,30,50], 5);
plote(e)