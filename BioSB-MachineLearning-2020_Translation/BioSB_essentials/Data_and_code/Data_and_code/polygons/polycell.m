%POLYCELL Concatenate polygons in a cell
%
%	[P,L] = POLYCELL(C)
%
% If C is a cell array of polygons all of them are vertically concatenated
% and returned in P. If C is a single polygon then P = C.
% In the vector L the cumulative lengths of the building polygons are returned.
% Polygons are always closed if needed.
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [c,L] = polycell(c)
if isa(c,'cell')
	d = [];
	L = zeros(1,length(c));
	for j = 1:length(c)
		e = polyclose(c{j});
		L(j) = size(e,1);
		d = [d; e];
	end
	c = d;
else
	c = polyclose(c);
	L = size(c,1);
end
L = cumsum(L);
