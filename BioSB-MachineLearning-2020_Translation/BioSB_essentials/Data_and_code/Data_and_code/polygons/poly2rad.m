%POLY2RAD Radial description of polygons
%
%	D = POLY2RAD(P,N)
%
% The polygon P is transformed into a radial description D.
% First the polygon is equidistantly sampled using N points. In the vector
% D with length N, the cumulative normalized outer angles are stored between
% consequtive edges. In this way D is suitable for a Fourier analysis.
%
% Multiple polygons stored in a cell array are supported.
% Default value for N is 32.
% The inverse transform is RAD2POLY.
%
% See also POLYGONS, RAD2RAD, RAD2POLY
 
% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function d = poly2rad(cont,n,s)
if nargin < 2, s = []; end
if nargin < 2, n = 32; end

	if iscell(cont)
		d = {};
		for j=1:length(cont)
			c = cont{j};
      r = prad(c,n);
			d = {d{:} r};
		end
	else
    c = cont;
    d = prad(c,n);
	end

function r = prad(c,k);
c = polyint(c,k);
n = size(c,1)-1;
c = [c(end-1,:); c]';
I = 2:n+1;
		% compute for each point two difference vectors
d1 = c(:,I-1) - c(:,I);
d2 = c(:,I) - c(:,I+1);
		% compute angle according to cos
norm = sqrt(sum(d1.^2)).*sqrt(sum(d2.^2));
alf = zeros(1,n); bet = zeros(1,n); dd = zeros(2,n); 
K = find(norm~=0);
if length(K) > 0
	alf(K) = acos(sum(d1(:,K).*d2(:,K),1)./norm(K));
		% compute angle according to sin
	dd(:,K) = [d1(2,K);-d1(1,K)];
	norm(K) = sqrt(sum(dd(:,K).^2,1)).*sqrt(sum(d2(:,K).^2,1));
	bet(K) = asin(sum(dd(:,K).*d2(:,K),1)./norm(K));
		% compute correct angle (no smarter way??)
	J = find(bet<0);
	alf(J) = - alf(J);
end
alf = real(alf);
		% compute contour length and normalize
d2 = sqrt(sum(d2.^2));
%p = [[alf; d2] [alf(1); d2(1)]]';
r = [alf; d2]';
r = cumsum(r);
if r(end,1) < 0
    r = flipud([-alf; d2]');
    r = cumsum(r);
end
r = r(:,1) - r(:,2)*2*pi/r(end,2);

