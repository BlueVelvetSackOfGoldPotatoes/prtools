%GETLABTYPE Get label type of dataset
%
%    LABTYPE = GETLABTYPE(A)
%
% Returns the label type of dataset A.

% $Id: getlabtype.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function labtype = getlabtype(a)

	prtrace(mfilename,2);
	
	labtype = a.labtype;
	
	return
