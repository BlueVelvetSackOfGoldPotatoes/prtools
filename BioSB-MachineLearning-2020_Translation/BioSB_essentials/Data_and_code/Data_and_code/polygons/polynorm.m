%POLYNORM Polygon normalisation
%
%	D = POLYNORM(C)
%
% The polygon description of C is normalized: rotated to eigenvectors,
% center at [0.5 0.5] and fitting in the [0 0 1 1] box.
% In addition, polygons are made rotating clockwise.
%
% See also POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = polynorm(p)
	
if ~iscell(p), p = {p}; end

for j=1:length(p)
	c = p{j};
	[v,d] = eig(cov(c));
	if (d(1,1) < d(2,2)), v = fliplr(v); end
	c = c*v;
	c = c - repmat(min(c),length(c),1);
	c = c / max(max(c));
	cm = (1-max(c))/2;
	c =  c + repmat(cm,length(c),1);
	r = sum(poly2rad(c));
	if r(1) < 0
		c = flipud(c);
	end
	p{j} = c;
end

if length(p) == 1, p = p{1}; end


