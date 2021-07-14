%GENREP Generate representation set
%
%	R = genrep(D,r,'include')
%	R = genrep(D,r,'exclude')
%
% A representation set of r objects per class is generated for the square 
% (dis)similarity matrix D. D should be a dataset. R has c*r columns if D 
% has c classes. If r is a vector of length c, its elements are used for 
% setting the size of the number of representation objects of the corresponding
% class. If r is a scalar then for each class r objects are selected. 
% Default r = 1.
% If desired, the objects used for the representation set are excluded from R.
% By default the objects are included.
%
%	[R,T] = genrep(D,r)
%
% Generates r representation objects per class and selects these objects
% for R (thereby a rxr matrix). The remaining objects are given the same
% representation and are stored in T.
%
% $Id: genrep.m,v 1.4 2004/03/19 07:54:01 duin Exp $

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function [R,T] = genrep(a,r,s)
if nargin < 3, s = 'include'; end
if nargin < 2, r = 1; end
%[nlab,lablist,m,k,c,p] = dataset(a);
nlab = getnlab(a);
[m,k,c] = getsize(a);
labels = getlab(a);
if size(r) == 1
	r = r*ones(1,c);
end
if length(r) ~= c
	error('Number of classes does not match of vector length')
end
R = [];
for j = 1:c
	J = find(nlab==j);
	if length(J) < r(j)
		error('More objects requested than supplied')
	end
	L = randperm(length(J));
	R = [R J(L(1:r(j)))];
end
if nargout == 1
	L = [1:m];
	if strcmp(s,'exclude')
		L(R) = [];
	elseif ~strcmp(s,'include')
		error(['Unknown option demanded: ' s])
	end
	R = dataset(a(L,R),labels(L,:),'featlab',labels(R,:));
else
	if strcmp(s,'exclude')
		error('not supported yet')
	elseif strcmp(s,'include')
		L = R;
		T = [1:m];
		T(R) = [];
	else
		error(['Unknown option demanded: ' s])
	end
	T = dataset(a(T,R),labels(T,:),labels(R,:));
	R = dataset(a(L,R),labels(L,:),labels(R,:));
end
return
