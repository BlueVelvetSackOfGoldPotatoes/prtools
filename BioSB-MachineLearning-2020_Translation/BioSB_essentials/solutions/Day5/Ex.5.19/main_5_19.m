clc;
clear;
close all

addpath(genpath('../Data and code'));

load sonar
a = setprior(a,getprior(a));

v = weakc([],0.5,1, stumpc); v = setname(v,'weak0-1');

e1 = cleval(a, v, 5:20:100, 5);
e2 = cleval(a, v, 5:20:100, 20);

plote(e1)
plote(e2)