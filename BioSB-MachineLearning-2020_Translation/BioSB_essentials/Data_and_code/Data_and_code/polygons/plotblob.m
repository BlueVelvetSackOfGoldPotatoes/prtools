%PLOTBLOB Plot polygon and fill
%
%	h = plotblob(c,s)
%
% Plot the polygon c and fill it with the colour s
% Axes are suppressed.
% Default color white: s = [1 1 1];

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function h = plotblob(c,s,lab)
if nargin < 2, s = {[1 1 1]}; end
if ~iscell(s), s = {s}; end

if ~iscell(c)
	c = {c};
end

if nargin < 3, lab = ones(length(c)); end
	
hh = [];
ih = ishold;
for j = 1:length(c)
	p = c{j};
	hh = [hh fill(p(:,1),p(:,2),s{lab(j)})];
	hold on
end
hold off
axis ij;
set(gca,'position',[0.05 0.05 0.9 0.9])
axis off
if ~ih, hold off, end

if nargout > 0, h = hh; end
