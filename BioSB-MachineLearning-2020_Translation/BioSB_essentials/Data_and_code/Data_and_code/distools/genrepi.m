%GENREPI Generates indices for sets for representation, learning and training. 
%
%	[R,L,T] = genrepi(A,r,n)
%
% Generation of r indices for a representation set R and n for a learning set L.
% L contains R (r <= n). Indices of the remaining objects are stored in T.
% Default n = r.
%
% $Id: genrepi.m,v 1.3 2004/04/14 09:34:47 duin Exp $

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [R,L,T] = genrepi(a,r,n)
if nargin < 3, n = r; end
R = []; L = []; T = [];
S = classsizes(a);
[m,k,c] = getsize(a);
for j = 1:c
	J = findnlab(a,j); 
	LL = randperm(S(j)); LL = LL(1:n); 
	RR = LL(1:r);
	R = [R;J(RR)]; L = [L;J(LL)];
end
R = R(:);
L = L(:);
T = [1:m];
T(L) = [];
	
