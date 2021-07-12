clc;
clear;
addpath(genpath('../Data and code/prtools4112'));
addpath(genpath('../Data and code/biodata/'));

load khan
a = setprior(a,getprior(a));

[d, n] = size(a);
labels = getlabels(a);
for i=1:d
    f_score(i) = abs(corr(labels, +a(:,i)));
end
[~, rank] = sort(f_score, 'descend');

tr_data = a(:, rank(1:5));
tr_data = setprior(tr_data, getprior(tr_data)); 
te_data = b(:, rank(1:5));
te_data = setprior(te_data, getprior(te_data));

figure(1);
e = cleval(tr_data, {nmc, ldc, qdc, parzenc}, [2 3 5 10 25 50 100], 3);
plote(e)


figure(2);
e = cleval(tr_data, {nmc, ldc, qdc, parzenc}, [2 3 5 10 25 50 100], 3, te_data);
plote(e)