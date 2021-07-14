%RAD2RAD Smooth radial polygon description
%
%		R = RAD2RAD(R,N)
%
% Smooth all polygons given in a radial description (see POLY2RAD) by a
% uniform filter of width 2N+1.
%
% See also POLYGONS, POLY2RAD, RAD2POLY

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function r = rad2rad(r,n)

if ~iscell(r), r = {r}; end
if nargin < 2, n = 1; end

for j=1:length(r)
	s = r{j};
	if n > length(s)
		error('Smoothing filter wider than size of polygon');
	end
	if n > 0
		s = [s(end-n+1:end); s; s(1:n)];
		s = conv(s,ones(2*n+1,1)/(2*n+1));
		s = s(2*n+1:end-2*n);
	end
	r{j} = s;
end
if length(r) == 1, r = r{j}; end
