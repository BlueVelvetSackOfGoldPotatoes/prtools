clc;
clear;
addpath(genpath('../Data and code'));

a = gendatb(100);
[tr, te] = gendat(a,0.9);

w0 = stumpc(tr, 'maxcrit', 1);
testc(te*w0)

w1 = stumpc(tr, 'maxcrit', 2);
testc(te*w1)

w2 = stumpc(tr, 'maxcrit', 3);
testc(te*w2)

w3 = treec(tr)*classc;
testc(te*w3);

figure(1); 
scatterd(a); 
plotc(w0, 'k-');
hold on
plotc(w1, 'b--');
plotc(w2, 'r:');
plotc(w3, 'g');