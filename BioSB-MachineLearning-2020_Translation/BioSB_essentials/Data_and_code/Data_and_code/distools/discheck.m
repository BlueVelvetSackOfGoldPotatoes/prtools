%DISCHECK Dissimilarity matrix check
%
%	discheck(D)
%
% Error return if D is not a square dissimilarity matrix with
% feature labels equal to object labels.
%
%	discheck(D,lablist)
%
% Error return if feature labels of D are not in lablist
%
% $Id: discheck.m,v 1.3 2004/03/19 07:54:01 duin Exp $

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function discheck(d,lablist)
if nargin < 2
%	[nlab,lablist,m,k,c,prob,featlist] = dataset(d);
	[m,k,c] = getsize(d);
	lablist = getlablist(d);
	featlist = getfeatlab(d);
	if m ~= k
		error('Dissimilarity matrix should be square')
	end
else
	featlist = getfeat(d);
	c = size(lablist,1);
end
[nn,nf,fl] = renumlab(lablist,featlist);
if max(nf) > c
        error('Feature labels of dataset do not match with class labels')
end
