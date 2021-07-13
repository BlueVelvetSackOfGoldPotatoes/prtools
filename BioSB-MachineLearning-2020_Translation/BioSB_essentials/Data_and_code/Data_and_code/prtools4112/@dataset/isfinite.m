%ISFINITE Dataset overload

% $Id: isfinite.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function n = isfinite(a)
		prtrace(mfilename,2);
n = isfinite(a.data);

