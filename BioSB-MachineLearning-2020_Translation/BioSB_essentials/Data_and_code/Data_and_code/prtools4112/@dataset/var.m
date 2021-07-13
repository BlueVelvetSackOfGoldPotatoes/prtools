%VAR Dataset overload
%
%   [V,U] = VAR(A,W)
%
% Computes variance V and mean U in a single run for consistency with datafile overload.

function [s,u] = var(a,w)
	
	prtrace(mfilename,2);

	if nargin == 1
		s = var(a.data);
    u = mean(a.data);
	else
    w = w/sum(w);
		s = var(a.data,w);
    u = a.data*w(:)';
	end

return
