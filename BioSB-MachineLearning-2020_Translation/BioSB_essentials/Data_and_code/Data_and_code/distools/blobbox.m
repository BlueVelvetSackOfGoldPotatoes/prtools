%BLOBBOX Find box around binary blob and resample
%
%	B = blobbox(A,ny,nx);
%
% Computes for a set of n binary images A (size [my,mx,n])
% the bounding boxes around the blobs and resample these
% with nx * ny pixels, resulting in a set of n images B
% with size [ny,nx,n].
% Default nx = ny, ny = 16
%
% $Id: blobbox.m,v 1.2 2001/07/10 16:35:58 pavel Exp $

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function b = blobbox(a,ny,nx);
if nargin < 2, ny = 16; end
if nargin < 3, nx = ny; end

[mx,my,n] = size(a);
b = zeros(nx,ny,n);

for i=1:n
	c = a(:,:,i);
	J = find(any(c));
	J = [min(J):max(J)];
	K = find(any(c'));
	K = [min(K):max(K)];
	c = double(c(K,J));
	if length(c(:)) > 0
		c = bord(c,0);
		b(:,:,i) = imresize(c,[ny,nx]);
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

