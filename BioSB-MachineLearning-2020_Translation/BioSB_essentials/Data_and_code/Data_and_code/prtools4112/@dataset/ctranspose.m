%CTRANSPOSE Dataset overload 
%
% Just returns the complex conjugate transpose of the data matrix.

% $Id: ctranspose.m,v 1.3 2007/03/22 07:45:54 duin Exp $

function data = ctranspose(a)

	prtrace(mfilename,2);

	nodatafile(a);
	data = a.data';

return

