%POLYBOX Size of box around polygons
%
% 	B = POLYBOX(P)
%
% The box sizes of the N polygons stored in P is returned in the 
% N x 2 array B.
%
% See POLYGONS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function b = polybox(p)

if ~iscell(p), p = {p}; end
b = zeros(length(p),2);
for j=1:length(p)
	c = p{j};
	b(j,:) = [max(c(:,1))-min(c(:,1)) max(c(:,2))-min(c(:,2))];
end
