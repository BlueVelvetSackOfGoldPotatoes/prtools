clc
clear;
addpath(genpath('../../Data and code/prtools4112'));

%% Ex.1.13a
a = gauss(1000, 0, 1);
scatterd(a);

w = gaussm(a, 1);
hold on
plotm(w, 1);

b = gauss(1000, [0 0], [1 0;0 4]);
scatterd(b);
w = gaussm(b, 1);
hold on
plotm(w, 2);

c = gauss(1000, [0 0], [1 0;0 4]);
scatterd(c);
w = gaussm(c, 1);
hold on
plotm(w, 4);