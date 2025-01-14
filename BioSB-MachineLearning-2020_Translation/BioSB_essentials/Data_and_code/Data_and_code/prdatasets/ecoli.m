%ECOLI 336 objects with 7 features in 8 classes
%
%      X = ECOLI
%
% Predict the localization site of protein in a cell, by Kenta Nakai
% Institue of Molecular and Cellular Biology Osaka, University
% 
function x = ecoli

user.desc='The Ecoli database from UCI. Goal is to Predict the localization site of protein in a cell, by Kenta Nakai Institue of Molecular and Cellular Biology Osaka, University.';
user.link = 'ftp://ftp.ics.uci.edu/pub/machine-learning-databases/ecoli/';
cl = {'cytoplasm' 'inner membrane without signal sequence' ...
'periplasm' 'inner membrane, uncleavable signal sequence' ...
'outer membrane' 'outer membrane lipoprotein' ...
'inner membrane lipoprotein' 'inner membrane, cleavable signal sequence'};
fl = {'mcg' 'gvh' 'lip' 'chg' 'aac' 'alm1' 'alm2'};

a = load('ecoli.dat');
x = dataset(a(:,1:(end-1)),cl(a(:,end)));
x = setfeatlab(x,fl);
x = setname(x,'Ecoli');
x = setuser(x,user);

return
