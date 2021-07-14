%INTRDIM Estimate Intrinsic dimensionality from dissimilarity data
%
%		K = INTRDIM(D)
%
% DESCRIPTION
% It is assumed that the data is generated from a normal distribution
% in K dimensions and that the Eulcidean distance measure has been used.
% Do not supply squared distances! They will definitely generate the wrong
% result.

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function k = intrdim(d)

d = +d.^2;
[m,n] = size(d);

if m==n & all(diag(+d) == 0)  % assume selfreflecting dissim matrix
	d(1:n+1:n*n) = [];
end

k = round(2*(mean(d(:)).^2)/var(d(:))); % based on Chi square distribution