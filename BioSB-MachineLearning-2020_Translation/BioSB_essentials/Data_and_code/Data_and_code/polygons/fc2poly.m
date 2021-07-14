%FC2POLY2F Conversion of a Freeman code string to a polygon
%
%   P = FC2POLY2F(F)
%
% The Freeman code string F is converted to a polygon.
%
% See POLYGONS, POLYGON

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = fc2poly(f)

	code = [1 0; 1 -1; 0 -1; -1 -1; -1 0; -1 1; 0 1; 1 1];
	if ~iscell(f)
		f = {f};
	end
	p = {};
	for j = 1:length(f)
		c = f{j};
		n = length(c);
		x = zeros(n+1,2);
		x(2:n+1,:) = code(c(1:n)+1,:);
		x = cumsum(x);
		x = x - repmat(min(x),n+1,1) + 1;
		x = polyclose(x);
		if length(f) > 1
			p = {p{:} x};
		else
			p = x;
		end
	end
