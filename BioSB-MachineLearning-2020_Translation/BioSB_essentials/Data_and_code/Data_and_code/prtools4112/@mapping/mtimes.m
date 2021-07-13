%MTIMES Mapping overload
%
%  D = MTIMES(A,W)
%  D = A*W
%
% These calls are identical to D = MAP(A,W).

% $Id: mtimes.m,v 1.3 2007/03/22 07:43:42 duin Exp $

function d = mtimes(a,b)

	prtrace(mfilename,2);

	if (nargout > 0)
		d = map(a,b);
	else
		map(a,b)
	end

return
