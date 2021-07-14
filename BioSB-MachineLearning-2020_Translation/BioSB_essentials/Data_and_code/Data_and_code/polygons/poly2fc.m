%POLY2FC Conversion of a polygon to a Freeman code string
%
%   [F,IM] = POLY2FC(P,CON)
%
% The polygon P is converted to a Freeman code F.
% Note that the Freeman code is computed w.r.t. the grid defined
% by rouning the coordinates in P to integers.
% CON is the desired connectivity, it should be either 8 (default)
% or 4. In the latter case only even codes are reurned (see below) and
% the sequence F = POLY2FC(IM2POLY(A),4) yields an exact description of
% the object contour in A on the pixel level.
%
% The Freeman code is here defined as:
% decrease_x decrease_y : 1
% nochange_x decrease_y : 2
% increase_x decrease_y : 3
% increase_x nochange_y : 4
% increase_x increase_y : 5
% nochange_x increase_y : 6
% decrease_x increase_y : 7
% decrease_x nochange_y : 0
%
% IM is an image showing the contour described by F.
%
% If P is a cell array of polygons then F is a cell array of code strings.
%
% See POLYGONS, POLYGON

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [c,im] = poly2fc(c,con)
if nargin < 2, con = 8; end
	if ~iscell(c), c = {c}; end
	[cc,L] = polycell(c);
	imsize = ceil(max(cc)) - floor(min(cc));
	imstart = floor(min(cc))';
	im = zeros(imsize+1);
	if min(imsize) <= 1
		error('Polygons too small for converting to image and Freeman code string')
	end
	code = [7 0 1; 6 8 2; 5 4 3];
	n = length(c);
	for j = 1:n
		d = c{j}';
		if con == 4
			x = poly2im(d);
			x = imresize(x,2*size(x));
			[a,im] = poly2fc(floor(im2poly(x)/2));
			c{j} = a;
		else
			startpos = floor(min(d,[],2));
			d = d - repmat(floor(min(d,[],2)),1,size(d,2)) + 1;
			z = [];
			for i = 1:size(d,2)-1
				p = d(:,i+1) - d(:,i);
				zz = [];
				if d(1,i) <= d(1,i+1)
					xk = ceil(d(1,i)):floor(d(1,i+1));
				elseif d(1,i) > d(1,i+1)
					xk = ceil(d(1,i+1)):floor(d(1,i));
					xk = fliplr(xk);
				else
					xk = [];
				end
				if ~isempty(xk) & p(1) ~= 0
					if p(1) == 0
						y = d(2,i);  % will not happen
					else
						y = p(2)*(xk-d(1,i))/p(1) + d(2,i);
					end
					if p(2) == 0
						alf = zeros(1,length(xk));
					else
						alf = abs((y-d(2,i))/p(2));
					end
					if p(1) <= 0 
						yk = ceil(y);
					else
						yk = floor(y);
					end
					zz = [zz [alf;xk;yk]];
				end
				if d(2,i) <= d(2,i+1)
					yk = ceil(d(2,i)):floor(d(2,i+1));
				elseif d(2,i) > d(2,i+1)
					yk = ceil(d(2,i+1)):floor(d(2,i));
					yk = fliplr(yk);
				else
					yk = [];
				end
				if ~isempty(yk) & p(2) ~= 0
					if p(2) == 0
						x = d(1,i);  % will not happen
					else
						x = p(1)*(yk-d(2,i))/p(2) + d(1,i);
					end
					if p(1) == 0
						alf = zeros(1,length(yk));;
					else
						alf = abs((x-d(1,i))/p(1));
					end
					if p(2) <= 0
						xk = floor(x);
					else
						xk = ceil(x);
					end
					zz = [zz [alf;xk;yk]];
				end
				if ~isempty(zz)
					[zzz,J] = sort(zz(1,:));
					z = [z zz([2 3],J)];
				end
			end
		% z codes the difference w.r.t. min_x, min_y
			for jj=1:size(z,2)
				im(z(2,jj)+startpos(2),z(1,jj)+startpos(1)) = 1;
			end
			J = 1:size(z,2)-1;
			z = z(:,J) - z(:,J+1) + 2;
		% z = 1 : decrease
		% z = 2 : equal
		% z = 3 : increase
		% look in table for Freeman code
			a = code(z(1,J) + 3*z(2,J) -3);
		% where nothing happend (due to round off), delete
			a(find(a==8)) = [];
			c{j} = a;
		end
	end
  if length(c) == 1
		c = c{1};
	end
