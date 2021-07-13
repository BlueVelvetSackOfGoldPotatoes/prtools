%SIGN Dataset overload

% $Id: sign.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = sign(a)

	prtrace(mfilename,2);
	
	c = sign(a.data);

	return

