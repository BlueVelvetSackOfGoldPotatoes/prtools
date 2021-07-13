%SETUSER Set user field in mapping
%
%	W = SETUSER(W,USER)

% $Id: setuser.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function w = setuser(w,user)
		prtrace(mfilename,2);
w.user = user;
return
