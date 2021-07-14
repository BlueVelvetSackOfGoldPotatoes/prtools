%POLYCLOSE Close polygon
%
%	C = POLYCLOSE(C,OPT)
%
% Check whether the polygon C is closed. If it is not, it is closed.
% If OPT == 0 (default) the polygon is closed by adding a point identical
% to the starting point.
% If OPT == 1 the closing error is distributed over the polygon, such that
% the end point equals the starting point.
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = polyclose(p,opt)
if nargin < 2, opt = 0; end
if ~iscell(p), p = {p}; end

for j=1:length(p)
	c = p{j};
	if size(c,1) == 2
		c = c';
	end
	if size(c,2) ~= 2
		error('Input cannot be converted to polygon')
	end
	if any(c(1,:) ~= c(end,:))
		if opt
			delta = c(1,:) - c(end,:);
			J = 1:size(c,1)-1;
			len = sqrt(sum((c(J+1,:) - c(J,:)).^2,2));
			cor = [0; cumsum(len)/sum(len)];
			c = c + [cor cor].*repmat(delta,size(c,1),1);
		else
			c = [c;c(1,:)];
		end
	end
	p{j} = c;
end
if length(p) == 1, p = p{1}; end

