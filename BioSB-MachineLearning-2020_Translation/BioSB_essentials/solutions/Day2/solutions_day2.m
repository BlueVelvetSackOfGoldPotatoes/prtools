%% Code for the exercises of the BioSB course on Machine Learning
%% October 2020 - Perry D Moerland

%% Day 2

%% 2.1(a)
load golub
a = a(:,[1413 738]);
b = b(:,[1413 738]);
scatterd(a);
scatterd(b);

%% 2.1(b)
%% function for 2.1(b): see extractClass.m
%function [data] = extractClass(data,class)
% lab = getlab(data);
% I = find(lab==class);
% data = +data(I,:);
%end
%% remember to set the path to be able to find user-defined functions
addpath('./')
a1 = extractClass(a,1);
a2 = extractClass(a,2);

%% 2.1(c) (PM): option 'legend' does not work with Matlab2020b 
w1=gaussm(dataset(a1)); 
w2=gaussm(dataset(a2)); 
scatterd(a,'legend');
plotm(w1,2);
plotm(w2,2);

%% 2.1(d)
phat1 = +(b*w1); 
phat2 = +(b*w2);
[getlab(b) +phat1 +phat2]

%% 2.1(e) You can also use getprior(a)
size(a1,1)/size(a,1)
size(a2,1)/size(a,1)

%% 2.1(f)
P = [(27/38)*phat1 (11/38)*phat2]; 
[dummy, lab2] = max(P,[],2);

%% 2.3
sum(getlab(b) ~= lab2)

%% 2.4(a)
w = qdc(a);
testc({a,b}*w);

%% 2.4(b)
crossval(a,qdc,10,1);
crossval(a,qdc,20,1);

%% 2.4(c) throws an error with Matlab2020b when not specifying 'nolegend'
plote(roc(a,w),'nolegend');
plote(roc(b,w),'nolegend');

%% 2.5: Still to be worked out in more detail
load khan;
% If the Statistics and Machine Learning toolbox is available you can use anova1
anova1(+a(:,1),getlab(a),'off')
plotf(a(:,1:5))
% Interestingly 'a' contains four classes (1:4) and 'b' five classes (0:4). 
% You might have to leave class 0 out in 'b' to get everything working ('roc' for example) 

%% 2.7(a)
a = gendats([50 50],2,1);
scatterd(a);

%% 2.7(b)
w = loglc(a);
plotm(w);
%% What does the next plot actually show? Looks like bug??
%plotm(w,3);
testc(a*w);

%% 2.7(c)
a = gendats([50 50],2,5)
scatterd(a);
w = loglc(a);
plotm(w);
testc(a*w);

%% 2.8(a)
a = gendatb([20 20]);
scatterd(a);

%% 2.8(b)
w1 = qdc(a);
w2 = parzenc(a);
w3 = knnc(a);
w  = {w1,w2,w3};

% Throws an error related to 'legend' with Matlab2020b
%plotc(w);
plotc(w1);
plotc(w2,'red');
plotc(w3,'blue');
testc(a*w);

%% 2.10(a)
figure();
a = gendats([10 10],2,2);
scatterd(a);
figure();
b = gendats([1000 1000],2,2);
scatterd(b);

%% 2.10(b)
w1 = knnc(a,1);
testc({a,b}*w1);

%% 2.10(c)
a = gendats([10 10],5,2);
b = gendats([1000 1000],5,2);

%% 2.10(d)
w1 = knnc(a,1);
testc({a,b}*w1);

%% 2.10(e)
err = [];
dims = [2 3 5 10 25 100];
nrepeats = 25;
for i=dims 
  total = 0;
  for j=1:nrepeats
    a =  gendats([10 10],i,2);
    b = gendats([1000 1000],i,2);
    w1 = knnc(a,1);
    total = total + +testc(b*w1);
  end
  err= [err total/nrepeats];
end
plot(dims,err);

%% 2.14(a)
load cigars;
scatterd(a)

wq = qdc(a);
wl = ldc(a);
% Throws an error related to 'legend' with Matlab2020b
%plotc({wq,wl});
plotc(wq);
plotc(wl,'red');

%% 2.14(b)
testc(a*{wq,wl});

%% 2.15
a = gendatb([100 100]);
scatterd(a);

wq = qdc(a);
wl = ldc(a);
% Throws an error related to 'legend' with Matlab2020b
%plotc({wq,wl});
plotc(wq);
plotc(wl,'red');
testc(a*{wq,wl});

%% 2.16
a = gendats([10,10],2,3);
b = gendats([100,100],2,3);
scatterd(a);

wf = fisherc(a);
plotc(wf);
testc({a,b}*wf);

%% 2.17
wl = ldc(a);
plotc(wl,'red');
testc(a*wl); testc(b*wl);

%% 2.18(a)
a = gendath;
scatterd(a);

w = fisherc(a);
figure(1);
plotc(w);

c = a*w;
d = c(:,1)*invsigm;

figure(2);
plotf(d,1)

%% 2.18(b)
mu1 = mean(seldat(d,1));
mu2 = mean(seldat(d,2)); 
crit = (abs(mu1 - mu2)^2)/(sum((seldat(d,1)-mu1).^2)+sum((seldat(d,2)-mu2).^2))

%% 2.18(c)
w = nmc(a);
figure(1);
plotc(w);

c = a*w
d = c(:,1)*invsigm;

mu1 = mean(seldat(d,1));
mu2 = mean(seldat(d,2));
crit = (abs(mu1 - mu2)^2)/(sum((seldat(d,1)-mu1).^2)+sum((seldat(d,2)-mu2).^2))

%% 2.19(a)
load golub
a = a(:,[1413 738]);
b = b(:,[1413 738]);

%% 2.19(b)
w = treec(a);
testc({a,b}*w);

%% 2.19(c)
scatterd(a);
plotc(w);

%% 2.19(d)
for i=0:5
  %w= treec(a,'infcrit',i);
  w= treec(a,'maxcrit',i);
  %w= treec(a,'fishcrit',i);  
  testc(b*w);
end

plotc(w)

%% 2.19(e)
load golub;
for i=0:5
  %w= treec(a,'infcrit',i);
  %w= treec(a,'maxcrit',i);
  w= treec(a,'fishcrit',i);   
  testc(a*w);
  testc(b*w);
end

%% 2.20(a)
train = gendatb([10 10]);

w1 = nmc(train);
w2 = ldc(train); 
w3 = qdc(train);
w4 = fisherc(train);
w5 = parzenc(train);
w6 = knnc(train,1);
w7 = treec(train);
W = {w1,w2,w3,w4,w5,w6,w7};
testc(train*W);

scatterd(train); 
% Throws an error related to 'legend' with Matlab2020b
%plotc(W);
plotc(w1);
plotc(w2,'red');
plotc(w3,'blue');
plotc(w4,'green');
plotc(w5,'yellow');
plotc(w6,'magenta');
plotc(w7,'cyan');

%% 2.20(b)
newtrain = train;
newtrain(:,2) = 10*newtrain(:,2);

w1 = nmc(newtrain);
w2 = ldc(newtrain); 
w3 = qdc(newtrain);
w4 = fisherc(newtrain);
w5 = parzenc(newtrain);
w6 = knnc(newtrain,1);
w7 = treec(newtrain);
W = {w1,w2,w3,w4,w5,w6,w7};
testc(newtrain*W);

scatterd(newtrain); 
% Throws an error related to 'legend' with Matlab2020b
%plotc(W);
plotc(w1);
plotc(w2,'red');
plotc(w3,'blue');
plotc(w4,'green');
plotc(w5,'yellow');
plotc(w6,'magenta');
plotc(w7,'cyan');
