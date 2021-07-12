% figure;
% nlkaart
% 3.12.a
clear all
load nederland
opt.q = 0;
[w, ~, stress] = mds(D,2, opt);
scatterd(D*w,'both')
rotate3d;


opt.q = -2;
[w, ~, stress] = mds(D,2, opt);
figure;
scatterd(D*w,'both')
rotate3d;

opt.q = +2;
[w, ~, stress] = mds(D,2, opt);
figure;
scatterd(D*w,'both')
rotate3d;

% 3.12.b
opt.q = 0;
[w, ~, stress] = mds(D,3, opt);
scatterd(D*w,3,'both')
rotate3d;

% 3.12.c
opt.q = -2;
r = rand(12,2);
[w, ~, stress] = mds(D,r, opt);

opt.q = 2;
r = rand(12,2);
[w, ~, stress] = mds(D,r, opt);
