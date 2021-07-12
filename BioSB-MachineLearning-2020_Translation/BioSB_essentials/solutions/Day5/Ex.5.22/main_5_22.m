clc;
clear;
addpath(genpath('../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/biodata/'));
addpath(genpath('../../Data and code/coursedata/'));

%% 5.22a
n = 25; deg = 1;
a = genregres(n,0.1);
ya = gettargets(a);
plot(+a, ya, '*');
hold on
w = linearr(a, [], deg);
plot(+a, +(a*w))

%% 5.22b
gx = (0:0.05:1)';
ftrue = genregres(gx,0);
ytrue = gettargets(ftrue);
for i = 1:100
     x = genregres(n);
     w = linearr(x,[], deg);
     f(i,:) = +(gx*w)';
end
f = f';
bias2    = (mean(f,2)-ytrue).^2;
variance = mean((f-repmat(mean(f,2),1,100).^2),2);
err      = sum(bias2+variance);
figure(2); clf; scatterr(ftrue,'b-'); hold on;
plot(gx,bias2,'g-'); plot(gx,variance,'r-');
legend('Function','Bias','Variance');
title(['Total error:' num2str(err)]);