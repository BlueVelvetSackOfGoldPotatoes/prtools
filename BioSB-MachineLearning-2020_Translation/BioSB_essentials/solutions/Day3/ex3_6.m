clear all
a = gendatdd(100,10)
[w, frac] = pca(a)
v = pca(a,0)
plot(v)