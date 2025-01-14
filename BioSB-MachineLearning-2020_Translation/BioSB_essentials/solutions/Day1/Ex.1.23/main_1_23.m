clc;
clear;
close all
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));


a = gendats([20 20],1,8);                    % Generate data
hs = [0.01 0.05 0.1 0.25 0.5 1 1.5 2 3 4 5]; % Array of h's to try
for i = 1:length(hs)
    w = parzenm(+a,hs(i));
    LL(i) = sum(log(+(a*w)));
end
plot(hs, LL);

