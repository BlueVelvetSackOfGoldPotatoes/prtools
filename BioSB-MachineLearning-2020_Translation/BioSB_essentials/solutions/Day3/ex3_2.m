a = gendatdd(100,10)

[w1,list1] = fsel(a, 'individual', 'maha-s', 9);
[w2,list2] = fsel(a, 'forward', 'maha-s', 9);
[w3,list3] = fsel(a, 'backward', 'maha-s', 9);
[w4,list4] = fsel(a, '+l-r', 'maha-s', 9);
[w5,list5] = fsel(a, 'b&b', 'maha-s', 9);

figure;
b = a*w5(:,[end-1, end]);
scatterd(b)