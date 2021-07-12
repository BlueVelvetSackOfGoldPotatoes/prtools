% 3.10.b
clear all
load nistdigs; % Generate difficult data
c = length(a.lablist);
[n,p] = size(a);
a = (a - ones(n,1)*mean(a)) ./ (ones(n,1)*std(a));
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    w = fisherm(trn); % rank features in list
    for d = 1:(c-1) % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
errorbar(1:(c-1),mean(error),std(error));

% 3.10.c
clear all
load nistdigs; % Generate difficult data
c = length(a.lablist);
[n,p] = size(a);
a = (a - ones(n,1)*mean(a)) ./ (ones(n,1)*std(a));
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.1); % split into trn and tst
    w = fisherm(trn); % rank features in list
    for d = 1:(c-1) % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
errorbar(1:(c-1),mean(error),std(error));

% 3.10.d
figure;
scatterd(trn*w(:,1:2))

% 3.10.e
figure;
scatterd(tst*w(:,1:2))

