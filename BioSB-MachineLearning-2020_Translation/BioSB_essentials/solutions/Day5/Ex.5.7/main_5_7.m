clc;
clear all
% addpath(genpath('../prtools4112'));
addpath(genpath('../Data and code'));

load golub.mat
% load khan

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

w = proxm(tr_data, 'radial_basis', 2);
trK = tr_data*w;
teK = te_data*w;

w_svm = svc_kernel(trK, 50);

testc(trK*w_svm)
testc(teK*w_svm)


