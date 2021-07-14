%POLY2IM Conversion of polygon to binary image (blob)
%
%   A = POLY2IM(P,N,M)
%
% The polygon P is converted to a binary image of size N*M.
% Default: M=N, N such that the coordinates of the polygon fit.
%
% Note that IM2POLY is not exactly the inverse of POLY2IM
%
% This terrible routine may need some debugging!
%
% See POLYGONS, IM2POLY

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = poly2im(p,m,n)

	if nargin < 3, n = []; end
	if nargin < 2, m = []; end
	[c,L] = polycell(p);
	if isempty(n) & isempty(m) % default image size: determine from the polygon.
		cmin1 = floor(min(c(:,1)));
		cmin2 = floor(min(c(:,2)));
		if cmin1 < 1, c(:,1) = c(:,1) - repmat(cmin1-1,size(c,1),1); end
		if cmin2 < 1, c(:,2) = c(:,2) - repmat(cmin2-1,size(c,1),1); end
		d = c;
		m = ceil(max(d(:,1)));
		n = ceil(max(d(:,2)));
	elseif isempty(n) % minimum size given only.
		cmin = min(c,[],1);
		cmax = max(c,[],1);
		r = min(cmax-cmin);
		c = c - repmat(cmin,size(c,1),1);
		d = 0.99999 * m * c / r +0.5;
		m = floor(max(d(:,1)));
		n = floor(max(d(:,2)));
	else               % total image size given
		cmin = min(c,[],1);
		cmax = max(c,[],1);
		cm = cmax-cmin;
		c = c - repmat(cmin,size(c,1),1);
		c = c/max(cm);
		d = c*max(m,n);
		if any(max(d) > [n,m])
			d = c*min(m,n);
		end
		d = 0.99999 * d + 0.5;
	end
	a = zeros(n,m); 
	e = d';
	for j=1:length(L)
		if j == 1
			d = e(:,1:L(j));
		else
			d = e(:,L(j-1)+1:L(j));
		end
		xcont = [];
		ycont = [];
		[xs,jx] = sort([d(1,1:end-1);d(1,2:end)]); % starting points first
		ys = [d(2,[1:size(d,2)-1]+jx(1,:)-1) ; d(2,[1:size(d,2)-1]+jx(2,:)-1)];
                % We now have the xs(:,i),ys(:,i) trajectories to be
                % filled.
		for i=1:size(xs,2) % integer values (i.e. pixels) inside the blob are contour pixels
			x = ceil(xs(1,i)):floor(xs(2,i));
			if (~isempty(x) & i>1 & x(1) == xs(1,i))
				x(1) = [];
			end
			if ~isempty(x) & xs(1,i) ~= xs(2,i)
				y = (ys(2,i)-ys(1,i))*(x - xs(1,i))/(xs(2,i)-xs(1,i)) + ys(1,i);
				xcont = [xcont x];
				ycont = [ycont y];
			end
		end
		% These are the contour pixels	
		xu = unique(xcont);
		xall = [];
		yall = [];
		for x = xu      % Take each unique contour x and find all y's on that line
			J = find(xcont == x);
			if length(J) == 1 % take care of end pixels (no x-pair)
				J = [J J];
			end
			ys = sort(ycont(J));
			for i=1:2:length(J)-1
				ya = ceil(ys(i)):floor(ys(i+1)); % fill between odds and evens
				if ~isempty(ya)
					xall = [xall repmat(x,1,length(ya))];
					yall = [yall ya];
				end
			end
		end
		a(yall+(xall-1)*n) = ones(1,length(xall));
	end
	a = bord(a,0);


% C = bord(A,n,m)
% Puts a border of width m (default m=1) around image A
% and gives it value n. If n = NaN: mirror image values.
function C = bord(A,n,m);
if nargin == 2; m=1; end
[x,y] = size(A);
if m > min(x,y)
        mm = min(x,y);
        C = bord(A,n,mm);
        C = bord(C,n,m-mm);
        return
end
if isnan(n)
   C = [A(:,m:-1:1),A,A(:,y:-1:y-m+1)];
   C = [C(m:-1:1,:);C;C(x:-1:x-m+1,:)];
else
   bx = ones(x,m)*n;
   by = ones(m,y+2*m)*n;
   C = [by;[bx,A,bx];by];
end
return

