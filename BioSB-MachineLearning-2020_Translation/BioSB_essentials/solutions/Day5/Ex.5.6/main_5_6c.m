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
w = svc_kernel(Kpwa);

%% Training
roc_curve = roc(Kpwa,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);
% legend({roc_curve.names});


%% Test
roc_curve = roc(Kpwb,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);

