%REAL Complex real part. Dataset overload

% $Id: real.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function a = real(a)
		prtrace(mfilename,2);
isdataset(a);
d= real(a.data);
c = setdata(a,d);
return
