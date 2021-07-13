%CUMSUM Dataset overload

% $Id: cumsum.m,v 1.3 2007/03/22 07:45:54 duin Exp $

function s = cumsum(a,dim)

	prtrace(mfilename,2);
	
	a = datasetconv(a);
	if (nargin == 1)
		s = cumsum(a.data);
	else
		s = cumsum(a.data,dim);
	end
return;
