%CONJ Dataset overload

% $Id: conj.m,v 1.3 2007/03/22 07:45:54 duin Exp $

function c = conj(a)

	prtrace(mfilename,2);
		
	a = datasetconv(a);
	c = setdata(a,conj(a.data));

return

