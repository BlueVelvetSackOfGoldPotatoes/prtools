clear all;
close all;
load nistdigs;

a = a(randperm(2000,200),:);

w1 = pca(a,0.7);
figure;
scatterd(a*w1,'both')

opt.q = 2;
figure;
w2 = mds(sqrt(distm(a)),2, opt);
figure;
scatterd(sqrt(distm(a))*w2,'both')