% 3.1.a
load('biomed')
[w1,list1] = fsel(a, 'individual', 'maha-s', 2);
[w2,list2] = fsel(a, 'forward', 'maha-s', 2);
[w3,list3] = fsel(a, 'backward', 'maha-s', 2);
[w4,list4] = fsel(a, '+l-r', 'maha-s', 2);
[w5,list5] = fsel(a, 'b&b', 'maha-s', 2);

figure;
scatterd (a*w1)
figure;
scatterd (a*w2)
figure;
scatterd (a*w3)
figure;
scatterd (a*w4)
figure;
scatterd (a*w5)

% 3.1.b
load('iris')
[w1,list1] = fsel(a, 'individual', 'maha-s', 2);
[w2,list2] = fsel(a, 'forward', 'maha-s', 2);
[w3,list3] = fsel(a, 'backward', 'maha-s', 2);
[w4,list4] = fsel(a, '+l-r', 'maha-s', 2);
% List returned for 'b&b' is in reverse order. Probably a bug in PRTools?
[w5,list5] = fsel(a, 'b&b', 'maha-s', 2);

figure;
scatterd (a*w1)
figure;
scatterd (a*w2)
figure;
scatterd (a*w3)
figure;
scatterd (a*w4)
figure;
scatterd (a*w5)