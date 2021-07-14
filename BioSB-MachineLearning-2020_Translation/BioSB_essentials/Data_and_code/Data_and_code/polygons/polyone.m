%POLYONE Select the largest polygon in cell array of polygons
%
%	P = POLYONE(C)
%
% Returns the largest polygon in the cell array C.
%
% See POLYGONS, MEASUREMENT, PRFILTER

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function p = polyone(c)

	if iscell(c) & length(c) == 1
		p = c{1};
	elseif iscell(c)
		n = length(c);
		jmax = 1;
		sizmax = 0;
		for j=1:n
			p = c{j};
			siz = prod(max(p) - min(p));
			if siz > sizmax
				jmax = j; sizmax = siz;
			end
		end
		p = c{jmax};
	else
		p = c;
	end
