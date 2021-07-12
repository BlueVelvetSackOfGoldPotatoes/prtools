clc;
clear
rmpath(genpath([matlabroot '/toolbox/stats/']));
addpath(genpath('../Data and code/'));
addpath('../Data and code/prtools4112');
load vanberlo.mat
load hulsman.mat

wk = proxm(a,'homogeneous');
Ka = a*wk;
Kb = b*wk;
w = svc_kernel(Ka,1);
roc_curve = roc(Ka,w);
plot(roc_curve.xvalues, roc_curve.error);
xlabel(roc_curve.xlabel);
ylabel(roc_curve.ylabel);
% legend({roc_curve.names});
