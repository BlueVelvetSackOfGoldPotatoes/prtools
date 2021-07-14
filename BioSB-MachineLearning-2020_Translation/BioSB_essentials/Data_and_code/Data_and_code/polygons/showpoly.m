%SHOWPOLY Show all polygons
%
%		H = SHOWPOLY(P,N)
%
% Plot all polygons in the cell array P. The polygons are ranked
% in horizontal rows of N polygons.
%
% See also POLYGONS, PLOTPOLY

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function h = showpoly(p,n)

if ~iscell(p), 
	f = plotpoly(p);
	if nargout > 0, h = f; end
	return
end

m = length(p);

if nargin < 2, 
	n1 = ceil(sqrt(m)); 
	n2 = n1;
else
	n1 = ceil(m/n);
	n2 = n;
end

s = polybox(p);
t = max(s(:))*1.1;
c = polyposition(p);

for j1=1:n1
	for j2=1:n2
		i = (j1-1)*n2+j2;
		if i > m, break; end
		p{i} = p{i} - repmat((c(i,:)-[t*j2,t*j1]),size(p{i},1),1);
	end
end

f = plotpoly(p);
if nargout >0, h = f; end