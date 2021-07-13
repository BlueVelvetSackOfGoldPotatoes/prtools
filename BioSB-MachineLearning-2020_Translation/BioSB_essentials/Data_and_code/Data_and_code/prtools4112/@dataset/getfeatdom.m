%GETFEATDOM Get feature domain of a dataset
%
%	FEATDOM = GETFEATDOM(A)
%
% Returns the cell array with the feature domains of the dataset A.

% $Id: getfeatdom.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function featdom = getfeatdom(a)

	prtrace(mfilename,2);

	featdom = a.featdom;

return;
