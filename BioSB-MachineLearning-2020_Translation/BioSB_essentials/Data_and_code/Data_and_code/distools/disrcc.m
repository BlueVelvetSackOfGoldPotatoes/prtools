%DISRCC Dissimilarity based random combiner
%
%	W = disrcc(A,base,r,n,rule)
%
% A     - Representation set
% base  - base classifier
% r     - Desired number of representation objects per class
% n     - number of base classifiers to be generated
% crule - combining rule
%
% $Id: disrcc.m,v 1.2 2001/07/10 16:35:58 pavel Exp $

% Copyright: R.P.W. Duin, duin@@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function W = disrcc(a,base,r,n,rule)
if nargin < 5, rule = maxc; end
if nargin < 4, n = 10; end
if nargin < 3, r = 2; end
if nargin < 2, base = nmc; end
if nargin < 1 | isempty(a)
	W = mapping('disrcc',{base,r,n,rule});
	return
end
[nlab,lablist,m,k,c,p] = dataset(a);
[flab,featlist] = renumlab(getfeat(a));
c = size(featlist,1);
W = [];
for j = 1:n
	R = genreps(flab,r);	
	W = [W a*(cmapm(k,R)*base)];
end
W = traincc(a,W,rule);
	

function R = genreps(nlab,n)
%
% Generate n objects per class

c = max(nlab);
R = [];
for j = 1:c
	J = find(nlab==j)'; 
	L = randperm(length(J));
	R = [R J(L(1:n))]; 
end

