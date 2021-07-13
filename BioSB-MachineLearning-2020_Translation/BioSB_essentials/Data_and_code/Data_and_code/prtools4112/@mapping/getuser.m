%GETUSER Return the user field of a mapping
%
%   USERFIELD = GETUSER(W)

% $Id: getuser.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function user = getuser(w)

	prtrace(mfilename,2);

	user = w.user;

return;
