%POLYGEN Generate polygon
%
%	C = POLYGEN(N)
%
% Generate a regular polygon of N points on a [0,0] - [1,1] grid.
%
%	C = POLYGEN(N,S,K)
%
% Generate K irregular polygons of N points.
% Each point deviates randomly from a circle by s standard deviation S.
% Default S = 0.
%
% See POLYGON

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function c = polygen(n,s,k)
if nargin < 3, k = 1; end
if nargin < 2, s = []; end
if nargin < 1, n = 100; end

if k > 1
	c = cell(1,k);
	for j=1:k
		c{j} = polygen(n,s);
	end
	return
end

if isempty(s)
    i = [0:n-1]'/n;
    x = sin(i*2*pi);
    y = cos(i*2*pi);
    c = [x y]/2 + 0.5;
    c = [[x;x(1)] [y;y(1)]]/2 + 0.5;
else
    i = sort(rand(n,1));
    r = 1+randn(n,1)*s;
    x = r.*sin(i*2*pi);
    y = r.*cos(i*2*pi);
    c = [[x;x(1)] [y;y(1)]];
end
