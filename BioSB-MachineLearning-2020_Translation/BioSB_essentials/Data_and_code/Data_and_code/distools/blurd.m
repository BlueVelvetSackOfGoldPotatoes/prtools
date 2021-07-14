%BLURD Blur-distance between blobs
%
%	D = blurd(A,B,ra,rb,fid)
%
% Computes a distance matrix between the sets of binary images A and B.
% Progress is reported in fid (fid = 1: on the sreen).
%
% size(A) : [may,max,na])
% size(B) : [mby,mbx,nb])
% 
% D is the blur distance matrix, size(D) = [na,nb] between these sets.
% Images are first uniformly blurred with size ra*ra or rb*rb.
% Default rb = ra, ra = 1 (no blurring).
% Next they are rescaled to square images with size max([may,max,mby,mbx])
% using bilinear interpolation. Finally the Euclidean distance is computed.
% 
% Preferably na <= nb (faster)
%
% $Id: blurd.m,v 1.2 2001/07/10 16:35:58 pavel Exp $

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function d = blurd(A,B,ra,rb,fid)
if nargin < 3, ra = 1; end
if nargin < 4, rb = ra; end
if nargin < 5, fid = 0; end
[ma1,ma2,na] = size(A);
[mb1,mb2,nb] = size(B);
m = max([ma1,ma2,mb1,mb2]);
d = zeros(na,nb);
filta = exp(-[-ra:ra].^2/(0.5*ra*ra));
filta = filta./sum(filta);
filtb = exp(-[-rb:rb].^2/(0.5*rb*rb));
filtb = filtb./sum(filtb);
figure(1); clf;
figure(2); clf;
for i=1:na
	a = A(:,:,i); 
	J = find(any(a));
	J = [min(J):max(J)];
	K = find(any(a'));
	K = [min(K):max(K)];
	a = double(a(K,J));
%	figure(1); imagesc(a); drawnow
	a = bord(a,0,ra);
	a = conv2(filta,filta,a,'same');
	a = a(ra:end-ra,ra:end-ra);
	a = imresize(a,[32 32],'bilnear');
	if fid > 0
		figure(1); imagesc(a); drawnow
	end
	for j = 1:nb
		b = B(:,:,j);
		J = find(any(b));
		J = [min(J):max(J)];
		K = find(any(b'));
		K = [min(K):max(K)];
		b = double(b(K,J));
		b = bord(b,0,rb);
		b = conv2(filtb,filtb,b,'same');
		b = b(rb:end-rb,rb:end-rb);
		b = imresize(b,[32 32],'bilnear');
		d(i,j) = sqrt(sum((a(:)-b(:)).^2));
		if fid > 0
			fprintf(fid,'%5d %5d %10.3f \n',i,j,d(i,j));
			figure(2); imagesc(b); drawnow;
		end
	end
end
	
