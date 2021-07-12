% 3.5.a    
clear all;
load golub;
prwarning(0);
% The last parameter is a flag indicating if pamc should plot results and
% is not mentioned in the help file
% The first figure doesn't show a legend (CV error vs. Training error). This is an issue in Windows only
w = pamc(a,0:0.25:5,[],10,true);
testc(b*w)

% 3.5.b
clear all;
load golub;
prwarning(0);
w = pamc(a,2.25,[],10,true);
testc(b*w)