clc;
clear
addpath(genpath('../Data and code/'));
load vanberlo.mat
load hulsman.mat

feat_std = std(a);
bar(feat_std);