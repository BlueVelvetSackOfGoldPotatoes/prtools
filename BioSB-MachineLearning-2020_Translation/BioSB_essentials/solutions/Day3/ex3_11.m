clear all;
a = circles3d();
scatterd(a, 3);

% 3.11.a
scatterd(a*pca(a,2))

% 3.11.b
opt.q = 0
mds(sqrt(distm(a)),2, opt)

% 3.11.c
opt.q = -2
mds(sqrt(distm(a)),2, opt)
opt.q = +2
mds(sqrt(distm(a)),2, opt)

% 3.11.d
clear all;
rng('shuffle');
a = circles3d();

r = 2*rand(100,2);
opt.q = 0;
mds(sqrt(distm(a)),r, opt)

% 3.11.e
clear all;
a = lines5d();
scatterd(a, 3);

% 3.11.e1
scatterd(a*pca(a,2))

% 3.11.e2
opt.q = 0
mds(sqrt(distm(a)),2, opt)

% 3.11.e3
opt.q = -2
mds(sqrt(distm(a)),2, opt)
opt.q = +2
mds(sqrt(distm(a)),2, opt)

% 3.11.e4
clear all;
rng('shuffle');
a = lines5d();

r = 2*rand(150,2);
opt.q = 0;
mds(sqrt(distm(a)),r, opt)