%POLYAREA Area of polygons
%
% 	A = POLYAREA(P,ACC)
%
% The area of the polygons stored in P is returned in the column vector A.
% The computation is based on counting the number of grid points inside
% a polygon if a grid is used for which the smalles x- or y-domain of the
% polygon contains ACC points. Default ACC = 100;
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function ar = polylength(p,acc)

if nargin < 2, acc = 100; end
if ~iscell(p), p = {p}; end
ar = zeros(length(p),1);
for j=1:length(p)
	%c = polyclose(p{j});
	c = p{j};
	cm = min(max(c) - min(c));
	scale = acc / cm;
	d = scale * c';
	% polygon is now scaled such that smalles x- or y-domain is acc
	J = find(ceil(d(1,:)) == floor(d(1,:)));
	d(1,J) = d(1,J) + 0.00001; % for correct rounding
	xcont = []; ycont = [];
	[xs,jx] = sort([d(1,1:end-1);d(1,2:end)]); % starting points first
	ys = [d(2,[1:size(d,2)-1]+jx(1,:)-1) ; d(2,[1:size(d,2)-1]+jx(2,:)-1)];
		% We now have the xs(:,i),ys(:,i) trajectories
	for i=1:size(xs,2) % integer values
		x = ceil(xs(1,i)):floor(xs(2,i));
		if ~isempty(x) & xs(1,i) ~= xs(2,i)
			y = (ys(2,i)-ys(1,i))*(x - xs(1,i))/(xs(2,i)-xs(1,i)) + ys(1,i);
			xcont = [xcont x];
			ycont = [ycont y];
		end
	end
	if isempty(xcont) | isempty(ycont)
		error('Image empty, probably polygon wrongly scaled')
	end
		% These are the contour pixels
	xu = unique(xcont);
	area = 0;
	xall = []; yall = [];
	for x = xu      % Take each unique contour x and find all y's on that line
		J = find(xcont == x);
		ys = sort(ycont(J));
		K = [1:2:length(ys)-1];
		area = area + sum(abs(ys(K) - ys(K+1)));
	end
	ar(j) = area / (scale*scale);
end
	
