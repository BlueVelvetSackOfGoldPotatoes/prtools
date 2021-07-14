%GENDDAT Generation of training and testing sets for dissimilarity based data
%
%	[A,B,I,J] = genddat(D,n,k)
%
% D should be a square dissimilarity set with feature labels equal to
% object labels. genddat selects at random n(i) vectors out of class i in D
% and stores them into A. The remaining vectors are stored in B.
% Classes are ordered using renumlab(getlab(X)). If n is a scalar, then
% n objects are selected at random according to the class priors.
% I and J are the indices of the training and testing objects, respectively.
%
% Just the training object are used for representation. If k is given
% the first k training objects per class are used for representation.
% 
% n and k may be vectors with as many components as classes, defining 
% a specific size per class.
%
% Both, A and B are represented by the same sum(k) objects. 
%
% See also datasets, renumlab
%
% $Id: genddat.m,v 1.7 2006/01/19 15:45:19 duin Exp $

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [a,b,Ia,Ib] = genddat(d,n,k);
[m,mk,c] = getsize(d);
nlab = getnlab(d);
discheck(d);
if nargin < 3, 
	k = []; 
else
	if length(k) == 1
		k = k*ones(1,c);
	elseif length(k) == c
		;
	else
		error('Vector length of number of objects should equal number of classes')
	end
	if any(k>n)
		error('Representation set must be smaller than training set')
	end
end  
[ja,jb] = gendat(dataset([1:m]',nlab),n);
J = [];
ja = +ja; jb = +jb;
for j=1:c
	K = find(nlab(ja)==j);
	if ~isempty(k)
		if k(j) > length(K)
			error('Requested size representation set not available')
		end
		K = K(1:k(j));
	end
	J = [J; K(:)];
end
M = [1:length(ja)]';
M(J) = [];

Ia = [ja(J) ja(M)];
Ib = jb;
a  = d(Ia,ja(J));
b  = d(Ib,ja(J));

