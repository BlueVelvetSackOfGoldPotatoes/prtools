% simple Markov models for CpG islands
% Warning: not robust for low counts, you might want to add
% pseudocounts 
% Coding used: A - 1, C - 2, G - 3, T - 4
%
% PM271108

close all;
clear all; 
clc;
echo on;

% transition probability matrices are taken from Durbin et al., p.50
trprob_c  = [0.18 0.274 0.426 0.12;0.171 0.368 0.274 0.187;0.161 0.339 0.375 0.125;0.079 0.355 0.384 0.182];
trprob_nc = [0.30 0.205 0.285 0.21;0.322 0.298 0.078 0.302; 0.248 0.246 0.298 0.208; 0.177 0.239 0.292 0.292];

echo off;

% invariant distributions
inv_c  = mcinv(trprob_c');
inv_nc = mcinv(trprob_nc');

% calculate log-lik matrix
logliks = logent(trprob_c./trprob_nc);

echo on;

pause; % press a key to continue with part c) of the exercise
clc;

echo off;

% generate sequences
nseq   = 50;
nbases = 1000;

% CpG islands
clengths = ceil(nbases*rand(nseq,1));
CpGseq  = mcgen(trprob_c,nseq,clengths,inv_c);

% non-islands
nclengths    = ceil(nbases*rand(nseq,1));
nonCpGseq  = mcgen(trprob_nc,nseq,nclengths,inv_nc);

echo on;

% likelihood estimates of transition probability matrices 
% estimated transition probability matrix for CpG islands (M+)
trprob = mcest(CpGseq,clengths)
% estimated transition probability matrix for non-CpG islands (M-)
trprob = mcest(nonCpGseq,nclengths)

pause;  % press a key to continue with part d) of the exercise
clc;

echo off;

% noisy versions of the original transition probability matrices
% to be used for generating test data
trprob_c  = 0.02*randn(4,4) + trprob_c;
trprob_nc = 0.02*randn(4,4) + trprob_nc;

total    = sum(trprob_c,2);
trprob_c = trprob_c./total(:,ones(1,4));
total    = sum(trprob_nc,2);
trprob_nc = trprob_nc./total(:,ones(1,4));

% generate sequences
nseq   = 50;
nbases = 1000;

% CpG islands
clengths = ceil(nbases*rand(nseq,1));
CpGseq  = mcgen(trprob_c,nseq,clengths,inv_c);

% non-islands
nclengths    = ceil(nbases*rand(nseq,1));
nonCpGseq  = mcgen(trprob_nc,nseq,nclengths,inv_nc);

% scoring
% CpG islands
cscore  = mcscore(logliks,CpGseq,clengths);
% non-CpG islands
ncscore = mcscore(logliks,nonCpGseq,nclengths);

echo on;

% the log-likelihood matrix used for scoring the sequences
logliks

pause; %press key to plot sequence scores

% plotting 
echo off;
hist(cscore,-0.4:0.05:0.4);
h = findobj(gcf,'Type','patch');
set(h,'FaceColor','y');
hold on;
colormap('hsv');
hist(ncscore,-0.4:0.05:0.4);
legend('CpG','non-CpG');
xlabel('bits');
hold off;
shg;

echo on;
pause  % Press a key to continue with part e) of the exercise

% sliding window
score=cpgscan('seq_a.fasta');

% Results are in seq_a.results

pause; % Press a key to end

clear all;
close all;
clc;
echo off;
