%% Code for the exercises of the BioSB course on Machine Learning
%% October 2020 - Perry D Moerland

%% Day 4

%% 4.1(a)
load hall;
scatterd(a);

%% 4.2(a,b)
load rnd;
scatterd(a);
interactclust(a,'c');
%% 4.2 (c)
interactclust(a,'s');
interactclust(a,'a');

%% 4.3
load hall;
scatterd(a);
interactclust(a,'c');

%% 4.4(a)
interactclust(a,'s');
%%  4.4(b)
interactclust(a,'a');

%% 4.5(a)
load cigars;
scatterd(a);
%% 4.5 (b)
interactclust(a,'s');
%% 4.5(c)
interactclust(a,'c');

%% 4.6(a)
load messy;
scatterd(a);
interactclust(a,'c');
%% 4.6(b) 
interactclust(a,'s');

%% 4.7: optional - still to be worked out in more detail
% The fusion level plot indicated by setting the 3rd argument to 1 has not
% yet been explained.
load golub;
interactclust(a,'a',1);

a = a(:,[1413 738]);
interactclust(a,'a',1);

%% 4.8(b)
load cigars;
kmclust(a,2,1,1);

load messy;
kmclust(a,2,1,1);

%% 4.9(a)
load triclust;
scatterd(a);

%% 4.9(b)
kmclust(a,3,1,1);

%% 4.11(a)
load triclust;
interactclust(a,'s',1);

%% 4.11(b)
interactclust(a,'c',1);

%% 4.12(a)
load hall;
interactclust(a,'s',1);

%% 4.13(a)
load messy;
interactclust(a,'s',1);

%% 4.13 (c)
interactclust(a,'c',1);

%% 4.14(a)
a = +gendats([50,50],2,10);
scatterd(a);

%% 4.14(b): ignore possible warnings
g = [1 2 3 5 10 20 40 50 100];
nreps = 10;
for i=1:length(g)
  for j=1:nreps
  [p,labs,ws(i,j)] = kmclust(a,g(i),0,0);
  end
end

WS_mean = mean(ws,2);
WS_std  = std(ws,0,2);
errorbar(g,WS_mean/WS_mean(1),WS_std/WS_mean(1));

% Actually this is the correct way to normalize but on this dataset the
% differences are negligible
ws = ws ./ ws(1);
WS_mean = mean(ws,2);
WS_std  = std(ws,0,2);
hold on;
errorbar(g,WS_mean,WS_std,'red');

%% 4.14(d)
a = +gendats([50,50],2,5);
%% and now run the code of 4.14(b)

%% 4.15
a = gendats([50 50],2,0);
%% and now run the code of 4.14(b)

%% 4.16(b)
load triclust;
scatterd(a)

%% 4.16(c)
hdb(a,'c','e',10);

%% 4.16(d)
load hall;
hdb(a,'c','e',20);

%% 4.16(e)
load cigars;
hdb(a,'c','e',20);

%% 4.17(a)
load triclust;
em(a,3,'circular',0,1,0);

%% 4.17(b)
load cigars;
em(a,1,'gauss',0,1,0);
em(a,2,'gauss',0,1,0);
em(a,5,'gauss',0,1,0);

%% 4.17(c)
ncomp = [1:5]
nreps = 20;
for i=ncomp
  for j=1:nreps
  lik(j) = em(a,i,'gauss',0,0,0);
  end
  L_mean(i) = mean(lik);
  L_std(i)  = std(lik);
end
errorbar(ncomp,L_mean,L_std);

%% 4.17(d)
load rnd;
scatterd(a);
%% and now run the code of 4.17(c)

%% 4.17(e)
load messy;
scatterd(a);

ncomp = [1:5];
nreps = 20;
for i=ncomp
  for j=1:nreps
  lik(j) = em(a,i,'circular',0,0,0);
  end
  L_mean(i) = mean(lik);
  L_std(i)  = std(lik);
end
errorbar(ncomp,L_mean,L_std);

%% 4.19(c,d)
cpgislands;

%% 4.19(e)
load 'seq_a.results'
plot(seq_a(:,1),seq_a(:,2))
cpgstretches;

%% 4.20
profile_vit;
