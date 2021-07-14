%POLYINT Polygon interpolation
%
% 	P = POLYINT(C,N)
%
% All polygons in the cell array C are equidistantly interpolated at N points
% (default N = 64).
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = polyint(c,n)
if nargin < 2, n = 64; end

	[c,L] = polycell(c);
	p = {};
	for j=1:length(L)
		if j==1, n1 = 1; else n1 = L(j-1)+1; end
		n2 = L(j);
		x = c(n1:n2,1);
		y = c(n1:n2,2);
		I = [1:(n2-n1)]';
		len = sqrt([x(I)-x(I+1)].^2 + [y(I)-y(I+1)].^2);
		len = len / sum(len);
		clen = [0;cumsum(len)];
		J = find(clen(I) >= clen(I+1));
		clen(J) = []; x(J) = []; y(J) = [];
		x = interp1(clen*(n+0.000001),x,[0:n]');
		y = interp1(clen*(n+0.000001),y,[0:n]');
		x(n+1) = x(1);
		y(n+1) = y(1);
		p = {p{:} [x y]};
	end
	if length(p) == 1, p = p{1}; end

