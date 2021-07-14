%POLYLENGTH Lengths of polygons
%
% 	L = POLYLENGTH(P)
%
% The lengths of the polygons stored in P is returned in the column vector L.
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function len = polylength(p)

if ~iscell(p), p = {p}; end
len = zeros(length(p),1);
for j=1:length(p)
	c = polyclose(p{j});
	J = 1:size(c,1)-1;
	len(j) = sum(sqrt(sum((c(J+1,:) - c(J,:)).^2,2)));
end
