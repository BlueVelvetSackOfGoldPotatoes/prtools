% 3.7.a-c
clear all
load housing; % Generate difficult data
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    w = pca(trn); % rank features in list
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
errorbar(1:10,mean(error),std(error));

% 3.7.d
v = pca(a,0)
figure;
plot(v)

% 3.7.e
w.data.rot(:,1)
var(a)

% 3.7.f
clear all
load housing; % Generate difficult data
[n,p] = size(a);
a = (a - ones(n,1)*mean(a)) ./ (ones(n,1)*std(a));
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    w = pca(trn); % rank features in list
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
errorbar(1:10,mean(error),std(error));

v = pca(a,0)
figure;
plot(v)

w.data.rot(:,1)
var(a)
