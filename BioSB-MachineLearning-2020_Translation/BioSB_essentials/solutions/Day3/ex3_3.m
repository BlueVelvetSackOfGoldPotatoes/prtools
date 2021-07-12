a = gendatdd(200,10); % Generate difficult data
for r = 1:5 % For 5 repetitions...
    [trn,tst] = gendat(a,0.5); % split into trn and tst
    [w,list] = fsel(trn,'forward','NN'); % rank features in list
    for d = 1:10 % for each number of features...
        mapped_trn = trn*w(:,1:d); % create a training set
        mapped_tst = tst*w(:,1:d); % create a test set
        classifier = knnc(mapped_trn,1); % train a 1-NN classifier
        error(r,d) = testc(mapped_tst, classifier); % and test it
    end;
end;
errorbar(1:10,mean(error),std(error)); % Plot the results