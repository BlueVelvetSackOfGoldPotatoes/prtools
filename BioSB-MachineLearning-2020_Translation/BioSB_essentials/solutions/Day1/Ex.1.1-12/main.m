clc;
clear;
addpath(genpath('../../../Data and code/prtools4112'));
addpath(genpath('../../Data and code/coursedata'));

data = rand(10,5);
a = dataset(data);
labs = genlab([4 2 4],char('apple','pear','banana'));
a = dataset(a,labs);

classnames = getlablist(a)

%% Ex.1.1
a = seldat(a, 2);
+a
getlablist(a)

%% Ex.1.2
b = dataset(rand(6,5)); 
labs = genlab([3 3],char('apple','pear')); 
b = dataset(b, labs); 
a=[a;b]


%% Ex.1.3
a = [a rand(10,1)]

%% Ex.1.4 (PM): option 'legend' does not work with Matlab2020b (at least on Windows computers)
a1 = a(:, [2 5]);
scatterd(a1, 'legend');

%% Ex.1.5
scatterdui(a);

%% Ex.1.6
scatterd(a,3);

%% Ex.1.7 (PM): option 'legend' does not work with Matlab2020b 
b1 = gendatb(100);
scatterd(b1, 'legend');

b2 = gendatc(100);
scatterd(b2, 'legend');

b3 = gendatd(100);
scatterd(b3, 'legend');

b4 = gendath(100);
scatterd(b4, 'legend');

%% Ex.1.8
a = iris
scatterd(a, 'gridded');

figure();
scatterdui(a);

figure();
plotf(a)
% petal length and petal width
b = a(:, [3 4]);
figure();
scatterd(b);

%% Ex.1.9
c11 = rand(50, 1);
c11 = c11 - min(c11);
c11 = c11 / max(c11);
c11 = c11 * 2;
c12 = rand(50, 1);
c12 = c12 - min(c12);
c12 = c12 / max(c12);
c12 = c12 * 2 - 1;

c21 = rand(50, 1);
c21 = c21 - min(c21);
c21 = c21 / max(c21);
c21 = c21 * 2 + 1;
c22 = rand(50, 1);
c22 = c22 - min(c22);
c22 = c22 / max(c22);
c22 = c22 * 2 + 1.5;

labs = genlab([50 50],char('class1','class2'));
c = dataset([c11 c12;c21 c22],labs);
c = setfeatlab(c,char('area','perimeter'))
scatterd(c)

%% Ex.1.10
d = gendatb([10 10]); % or d = gendatb(20);
d1 = [d; gendatk(d, [45 45]); gendatp(d, [45 45])];

d2 = gendatb([100 100]);

figure(1)
scatterd(d1);
figure(2)
scatterd(d2);

%% Ex.1.11
a = gauss(1000, 0, 1);
scatterd(a);

b = gauss(1000, 5, 2);
scatterd(b);

%% Ex.1.12
mean(rand(100,1));

n = 100;
for i = 1:1000
    x(i) = mean(rand(n,1));
end;
hist(+x);
[mean(+x) var(+x)]
% or simply [mean(x) var(x)]

n = 1000;
for i = 1:1000
    x(i) = mean(rand(n,1));
end;
hist(+x);
[mean(+x) var(+x)]

n = 1000;
for i = 1:10000
    x(i) = mean(rand(n,1));
end;
hist(+x);
[mean(+x) var(+x)]