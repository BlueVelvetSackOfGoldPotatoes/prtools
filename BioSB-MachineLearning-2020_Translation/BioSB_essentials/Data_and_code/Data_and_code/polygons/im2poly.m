%IM2POLY Image conversion into polygons
%
%	P = IM2POLY(A,T)
%
% The image A is converted to a set of polygons at threshold level T.
% Default T is half way minimum and maximum of the image A.
%
% Note that IM2POLY is not the inverse of POLY2IM as pixel positions
% are rounded to the image grid.
%
% If thresholding A results into a set of polygons (e.g. if A consists of
% a set of blobs), they are combined into a cell array.
%
% See POLYGONS, POLY2IM

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = im2poly(a,t,opt)
	if nargin < 3, opt = 1; end
  if nargin < 2, t = []; end
	if isstr(a)
		if exist(a) == 2
			a = imread(a); 
		elseif exist(a) == 7
			fnames = dirlist(a);
			p = {};
			for j= 1:size(fnames,1)
				im = imread(fullfile(a,deblank(fnames(j,:))));
				q = im2poly(im,t,opt);
				p = {p{:} q{:}};
			end
			return
		else
			error('File not found')
		end
	end
	a = double(a);
	[m,n] = size(a);
	if isempty(t), t = (max(a(:)) + min(a(:)))/2; end
	J = find(any(a));
	JJ = [min(J):max(J)];
	K = find(any(a'));
	KK = [min(K):max(K)];
	a = double(a(KK,JJ));
	if length(a(:)) > 0
		a = bord(a,0);
		b = 1;
	else 
		b = 0;
	end
	c = contourc(a,[t t]);
	p = polygon(c);
			% correct for shifts
	if iscell(p)
		for j =length(p):-1:1
			q = p{j};
			pj = q + repmat([min(J)-1,min(K)-1]-b,size(q,1),1);
			p(j) = {pj};
			if (any(pj(:,1) == 1) | any(pj(:,1) == n) | ...
					     any(pj(:,2) == 1) | any(pj(:,2) == m)) & opt
				p(j) = [];
			end
		end
	else
		p = p + repmat([min(J)-1,min(K)-1]-b,size(p,1),1);
		if (any(p(:,1) == 1) | any(p(:,1) == n) | ...
		    any(p(:,2) == 1) | any(p(:,2) == m)) & opt
				p = [];
		end
	end

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

function filenames = dirlist(dirpath)
% get filenames in directory
		dirpath = deblank(dirpath);
	% remove all .-files / dirs
		ddir = dir(dirpath);
		names = char(ddir.name);
	% remove all .-files / dirs
		J = find(names(:,1) == '.');
		names(J,:) = [];
		ddir(J) = [];

	% split in filenames and dirnames
		dirs = [ddir.isdir];
		J = find(dirs==1);
		dirnames = names(J,:);
		J = find(dirs~=1);
		filenames = names(J,:);