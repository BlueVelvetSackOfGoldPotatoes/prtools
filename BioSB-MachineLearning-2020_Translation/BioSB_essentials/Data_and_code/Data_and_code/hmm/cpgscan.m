% log-odds score of a sequence - testing for CpG islands 
% first a global test than a sliding window
%
% PM271108

function score=cpgscan(filename)
  
echo on;

% transition probability matrices are taken from Durbin et al., p.50
trprob_c  = [0.18 0.274 0.426 0.12;0.171 0.368 0.274 0.187;0.161 0.339 0.375 0.125;0.079 0.355 0.384 0.182];
trprob_nc = [0.30 0.205 0.285 0.21;0.322 0.298 0.078 0.302; 0.248 0.246 0.298 0.208; 0.177 0.239 0.292 0.292];

% invariant distributions
inv_c  = mcinv(trprob_c');
inv_nc = mcinv(trprob_nc');

% calculate log-lik matrix
logliks = logent(trprob_c./trprob_nc);

% log-lik matrix from Durbin et al., p.51
logliks = [-0.74 0.419 0.580 -0.803;-0.913 0.302 1.812 -0.685;-0.624 0.461 0.331 -0.730;-1.169 0.573 0.393 -0.679];

% read in sequence
fid = fopen(filename);
seq = fscanf(fid,'%s',inf);

% and transform it: aA=1/cC=2/gG=3/tT=4
seq = (seq=='a') + (seq=='A') + 2*(seq=='c') + 2*(seq=='C') + 3*(seq=='g') + 3*(seq=='G') +4*(seq =='t') + 4*(seq=='T');

% log-odds
score = mcscore(logliks,seq,length(seq))*length(seq);
% sliding window
mcslide(logliks,seq,filename);

%clc;
