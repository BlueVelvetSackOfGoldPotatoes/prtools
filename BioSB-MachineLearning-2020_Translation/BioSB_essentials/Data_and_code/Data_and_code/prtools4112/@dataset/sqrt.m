%SQRT Dataset overload

% $Id: sqrt.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = sqrt(a)
		prtrace(mfilename,2);
	d = sqrt(a.data);
	c = setdata(a,d);
return
