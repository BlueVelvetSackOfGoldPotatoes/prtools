clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

a = gendats([100 100],1,8);
[trn,tst] = gendat(a,0.5); hs=[0.1 0.25 0.5 1 1.5 2 3 4 5];
for i = 1:length(hs)
  w = parzenm(+trn,hs(i));
  Ltrn(i) = sum(log(+(trn*w)));
  Ltst(i) = sum(log(+(tst*w)));
end;
plot(hs,Ltrn,'b-'); 
hold on;
plot(hs,Ltst,'r-');


