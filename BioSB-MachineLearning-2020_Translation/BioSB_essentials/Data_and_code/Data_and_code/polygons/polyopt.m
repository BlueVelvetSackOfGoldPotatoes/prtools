%POLYOPT Find optimum polygon approximation
%
%   P = polopt(Q,N)
%
% For a given polygon Q an approximation by a new polygon P
% with N vertices is computed. P is such that it uses a subset of
% N of the vertices of Q in such a way that its total length is
% maximum.

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = polyopt(p,k)
if nargin < 2, k = []; end
if ~iscell(p), p = {p}; end
for j=1:length(p)
	q = p{j};
	n = size(q,1);
	if isempty(k) | k >= n
		p{j} = q;
	else
		J = randperm(n);
		J = sort(J(1:k));
		J = [J(k),J,J(1)];
		D = sqrt(distm(q,q));
		E = [1:k+1];
		dmax = 0;
		d = sum(diag(D(J(E),J(E+1))));
		while d > dmax
			dmax = d;
			for i = 2:k+1;
				if J(i-1) > J(i+1)
					I = [J(i-1):n,1:J(i+1)];
				else
					I = [J(i-1):J(i+1)];
				end
				[dd,ii] = max(D(J(i-1),I) + D(J(i+1),I)); 
				J(i) = I(ii); J(1) = J(k+1); J(k+2) = J(2);
			end
			d = sum(diag(D(J(E),J(E+1))));
		end
		p{j} = q(J(E),:);
	end
end

if length(p) == 1, p = p{1}; end

