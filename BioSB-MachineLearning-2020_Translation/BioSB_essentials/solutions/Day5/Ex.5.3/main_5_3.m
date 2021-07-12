clc;
clear all
addpath(genpath('../prtools4112'));

% load golub.mat
load khan

[d, n] = size(a);
labels = getlabels(a);
for i=1:d
    f_score(i) = abs(corr(labels, +a(:,i)));
end
[~, rank] = sort(f_score, 'descend');

% w = featsel(a, rank(1:5));
% tr_data = w*a;
% te_data = featsel(b, rank(1:5));
tr_data = a(:, rank(1:5));
tr_data = setprior(tr_data, getprior(tr_data)); 
te_data = b(:, rank(1:5));
te_data = setprior(te_data, getprior(te_data));

w_nn=[];
for i = 1:20
    w_nn = lmnc(tr_data, [3],5, w_nn);
%     figure(1); clf; scatterd(a); plotc(w); drawnow;
end
testc(te_data*w_nn)

w_nmc = nmc(tr_data);
testc(te_data*w_nmc);

w_ldc = ldc(tr_data);
testc(te_data*w_ldc);

w_qdc = qdc(tr_data);
testc(te_data*w_qdc);

w_knnc = knnc(tr_data);
testc(te_data*w_knnc);

