%NNERROR Exact computation of the expected NN error from dissimilarity matrix
%
%	e = nnerror(D,n)
%
% D should be a dataset containing a labeled square dissimilarity matrix.
% An exact computation is made of the expected NN error for a random selection
% of n objects per class for training. 
% Default n: minimum class size minus 1.
%
% $Id: nnerror.m,v 1.3 2005/10/09 15:25:19 duin Exp $

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function e = nnerror(d,n)

isdataset(d);
nlab = getnlab(d);
[m,mm,c] = getsize(d);

%[nlab,lablist,m,mm,c] = dataset(d);
if m ~= mm, error('distance matrix should be square'); end
		% number of objects per class
nc = zeros(1,c);
for j = 1:c
	J = find(nlab==j);
	nc(j) = length(J);
end

		% compute for all training set sizes
if nargin < 2
	n = min(nc)-1;
end

if length(n) > 1
	e = zeros(1,length(n));
	for j=1:length(n)
		e(j) = nnerror(d,n(j));
	end
else
	if n >= min(nc)
		error('Requested size training set is too large')
	end
				% call for given sample size	
	[d,S] = sort(d);
	S = reshape(nlab(S),m,m);	% order objects according to their distances
	ee = zeros(1,m);
						% loop over all classes
	for j = 1:c
						% find prob's Q objects of other classes are not selected
		Q = ones(m,m);
		for i = 1:c
			if i~=j
				[p,q] = nnprob(nc(i),n); q = [1,q];
				C = cumsum(S==i)+1;
				Q = Q.*reshape(q(C),m,m);
			end
		end
						% find prob's P for objects of this class to be the first
		[p,q] = nnprob(nc(j),n); p = [0,p];
		C = cumsum(S==j)+1;
		P = reshape(p(C),m,m);
						% now estimate the prob EC it is really the NN
		J = find(S==j);
		EC = zeros(m,m);
		EC(J) = P(J).*Q(J);
						% determine its error contribution
		L = find(nlab==j);
		ee(L) = 1-sum(EC(2:m,L))./(1-EC(1,L)); % correct for size training set
	end
		% average for final result
	e = abs(mean(ee));
end

%NNPROB Probability of selection as the nearest neighbor
%
%	[p,q] = nnprob(m,k)
%
%If k objects are selected out of m, then p(i) is the probability
%that object i is the nearest neigbor and q(i) is the probability
%that this object is not selected.

function [p,q] = nnprob(m,k)
p = zeros(1,m);
q = zeros(1,m);
q(1) = (m-k)/m;
p(1) = k/m;
for i=2:(m-k+1)
	q(i) = q(i-1)*(m-k-i+1)/(m-i+1);
	p(i) = q(i-1)*k/(m-i+1);
end

