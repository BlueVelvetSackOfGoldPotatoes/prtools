%UMINUS Dataset overload

% $Id: uminus.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = uminus(a)

	prtrace(mfilename,2);

	c = setdata(a,-(a.data));

return
