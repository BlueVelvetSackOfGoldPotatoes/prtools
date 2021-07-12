clc;
clear;

prprogress on; w = []; u = [10 10];
rand('state',99);
randn('state',99);
a = gendatb(100);

for i = 1:20
w = lmnc(a,u,5,w);
figure(1); clf; scatterd(a); plotc(w); drawnow;
end;
