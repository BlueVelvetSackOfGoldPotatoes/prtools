%POLYPOSITION Position of polygons
%
% 	[C,B] = POLYPOSITION(P)
%
% The centers and top left corners of the enclosing boxes of the
% N polygons stored in P is returned in the N x 2 arrays C and B.
%
% See POLYGONS, POLYBOX

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [c,b] = polypositions(p)

if ~iscell(p), p = {p}; end
c = zeros(length(p),2);
b = zeros(length(p),2);
for j=1:length(p)
	q = p{j};
	c(j,:) = [(max(q(:,1))+ min(q(:,1)))/2 (max(q(:,2))+min(q(:,2)))/2];
	b(j,:) = [min(q(:,1)) min(q(:,2))];
end
