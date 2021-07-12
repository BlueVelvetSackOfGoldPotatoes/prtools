% 3.8.a
clear all;
load nistdigs
[n,p] = size(a);
a = (a - ones(n,1)*mean(a)) ./ (ones(n,1)*std(a));
v = pca(a,0)
figure;
plot(v)
grid;

% 3.8.b
w = pca(a)
show(w(:,1:50))