% 3.4.b and c
load('housing')
list = zeros(5,13);
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    [w,currList] = fsel(trn,'forward','NN'); % rank features in list
    list(r,:) = currList;
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
figure
errorbar(1:10,mean(error),std(error)); % Plot the results

% 3.4.d
load('housing')
list = zeros(5,13);
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    [w,currList] = fsel(trn,'backward','NN'); % rank features in list
    list(r,:) = currList;
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
figure;
errorbar(1:10,mean(error),std(error)); % Plot the results


% 3.4.e
load('housing')
list = zeros(5,13);
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.7); % split into trn and tst
    [w,currList] = fsel(trn,'forward','maha-s'); % rank features in list
    list(r,:) = currList;
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
figure;
errorbar(1:10,mean(error),std(error)); % Plot the results
