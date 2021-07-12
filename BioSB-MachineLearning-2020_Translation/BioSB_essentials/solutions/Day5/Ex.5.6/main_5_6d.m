clc;
clear
rmpath(genpath([matlabroot '/toolbox/stats/']));
addpath(genpath('../Data and code/'));
addpath('../Data and code/prtools4112');
load vanberlo.mat
load hulsman.mat

wk = pairwise_km(a,Kp{1},'n'); 
Kpwa = a*wk;
Kpwb = b*wk;

Kca = combine_kernels({Ka,Kpwa},[0.5 0.5]);
Kcb = combine_kernels({Kb,Kpwb},[0.5 0.5]);
w = svc_kernel(Kca);

%% Training
figure(1);
roc_curve = roc(Kca,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);

%% Test
figure(2);
roc_curve = roc(Kcb,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);
