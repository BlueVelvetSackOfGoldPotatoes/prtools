clc;
clear;
addpath(genpath('../Data and code/prtools4112'));
addpath(genpath('../Data and code/biodata/'));
addpath(genpath('../Data and code/coursedata/'));

%% 5.22f
n = 25;
for rep=1:10
    for deg=1:6
        fprintf('rep:%d, deg:%d\n', rep, deg);
        f=[];
        gx = (0:0.05:1)';
        ftrue = genregres(gx,0);
        ytrue = gettargets(ftrue);
        for i = 1:100
            x = genregres(n);
            w = linearr(x, [], deg);
            f(i,:) = +(gx*w)';
        end
        f = f';
        bias2    = (mean(f,2)-ytrue).^2;
        variance = mean((f-repmat(mean(f,2),1,100).^2),2);
        err(rep, deg) = sum(bias2+variance);
    end
end
errorbar(1:6,mean(err,1), std(err,0, 1))


