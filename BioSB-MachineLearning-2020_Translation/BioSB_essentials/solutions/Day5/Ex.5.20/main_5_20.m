clc;
clear;
close all

addpath(genpath('../Data and code/prtools4112'));

a = gendatb([200 200]);
a = setprior(a,getprior(a));

figure(1);
e = cleval(a, {nmc, ldc, qdc, parzenc}, [2 3 5 10 25 50 100], 3);
% throws an error when not specifying 'nolegend'
plote(e,'nolegend')