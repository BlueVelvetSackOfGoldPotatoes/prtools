%NNE Nearest neighbor error and classification from a distance matrix
%
%   [E,LAB] = NNE(D)
%
% INPUT
%   D   NxN symmetric dissimilarity dataset
%
% OUTPUT
%   E   Leave-one-out error
%   LAB Nearest neighbor labels
%
% DESCRIPTION
% Estimates the leave-one-out error of the 1-nearest neighbor rule
% on the givven symmetric dissimilairy data.
%

function [e,NNlab] = nne(D)

[m,n] = size(D);
if m ~= n,
  error('Distance matrix should be square.');
end

lab = getlab(D);
[nlab,lablist] = renumlab(lab);
D(1:m+1:end) = inf;
[d,M] = min(D');
e     = mean(nlab(M) ~= nlab);
NNlab = lablist(nlab(M),:);
return
