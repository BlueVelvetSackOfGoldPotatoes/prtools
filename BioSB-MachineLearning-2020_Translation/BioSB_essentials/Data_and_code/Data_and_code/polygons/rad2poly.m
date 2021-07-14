%RAD2POLY Reconstruct polygons from radial description
%
%		P = RAD2POLY(R)
%
% The closure error is distributed over the polygon.
% The length of the returned polygon is 1.
%
% See also POLYGONS, POLY2RAD, RAD2RAD

function c = rad2poly(c)

if ~iscell(c), c = {c}; end

for i=1:length(c)
	r = c{i};
	r = r(:);
	n = size(r,1);
	s = [1:n]';
	r(:,1) = r(:,1) + s*2*pi/n;
	r(:,2) = s/n;
	r(2:end,:) = r(2:end,:) - r(1:end-1,:);
	p = zeros(n+1,2);
	p(1,:) = [0 0];
	alf = 0;
	for j=1:n
		alf = alf + r(j,1);
		p(j+1,1) = p(j,1) + r(j,2)*sin(alf);
		p(j+1,2) = p(j,2) + r(j,2)*cos(alf);
	end
	c{i} = p;
end
c = polyclose(c,1);