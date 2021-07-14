%POLYPLOT Plotting routine for polygons
%
%	POLYPLOT(C,S)
%
% Plot polygon using plotstring S (default S = '-').
%
% See also POLYGON

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function  f = polyplot(c,s)
if isa(c,'measurement')
	error([mfilename ' is intended for single polygons, not for measurements. use SHOW instead'])
end
if nargin < 2, s = '-'; end

ih = ishold;
if ~isa(c,'cell') c = {c}; end
h = [];
for j=1:length(c)
	cc = c{j};
	h = [h plot(cc(:,1),cc(:,2),s)];
	hold on
end
z = polycell(c);
zmin = min(z);
zmax = max(z);
zz = (zmax-zmin)/20;
axis equal
axis([zmin(1)-zz(1),zmax(1)+zz(1),zmin(2)-zz(2),zmax(2)+zz(2)]);
%V = axis; dx = V(2)-V(1); dy = V(4)-V(3);
%axis(V + [-dx dx -dy dy]*0.02); 
axis ij;
if ~ih, hold off, end

if nargout > 0, f = h; end
