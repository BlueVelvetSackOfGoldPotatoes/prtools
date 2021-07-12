clear all
load nederland
opt.q = 0;
d = 1:5;
stress = zeros(1,5);
for i = d
    [~,~,currStress] = mds(D,d(i), opt);
    stress(i) = currStress(end)
end
figure;
plot(stress)