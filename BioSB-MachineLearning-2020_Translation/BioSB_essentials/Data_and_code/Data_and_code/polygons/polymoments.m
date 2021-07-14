%POLYMOMENTS Compute moments of polygon blob
%
%		M = POLYMOMENTS(P,MOMENTS)
%
% If P is a cell array of N polygons then M is an NxK array of K scale
% and translation invariant moments for each of the polygons. 
% MOMENTS is a Kx2 array, specifying for each moment the desired powers 
% in the horizontal, respectively verticsal direction. 
% Default MOMENTS = [2 0; 1 1; 0 2].
% Note that such moments are not rotation invariant. 
%
% Alternatively, if MOMENTS == 'hu', the so-called 7 Hu-moments are
% computed (K=7), which are scale and rotation invariant.
%
% All computed moments are translation invariant and thereby insensitive
% for the original position of a polygon in an image.
% The computations are performed using images of at least 100x100 pixels.
% Still the accuracy is thereby limited.
%
% After: M. Sonka et al., Image processing, analysis and machine vision.

% Copyright: D. de Ridder, R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function m = polymoments(p,moments)

if nargin < 2, moments = [2 0; 1 1; 0 2]; end
if ~iscell(p), p = {p}; end

if isstr(moments) & (strcmp(moments,'hu') | strcmp(moments,'Hu'))
	m = zeros(length(p),7);
	for j=1:length(p)
		im = poly2im(p{j},100);
		size(im)
		m(j,:) = hu_moments(im);
	end
	
elseif isstr(moments)
	
	error('Unrecognised string specifying moments')
	
else
	
	if size(moments,2) ~= 2
		error('Moments should be specified in an array with 2 columns')
	end
	
	for j=1:length(p)
		im = poly2im(p{j},100);
		m(j,:) = smoments(im,moments(:,1)',moments(:,2)',1,1);
	end
	
end

return
				
		
% M = HU_MOMENTS (IM)
%
% Calculates 7 moments of Hu on image IM, invariant to translation, 
% rotation and scale.
%
% After: M. Sonka et al., Image processing, analysis and machine vision.

function m = hu_moments (im)

	p = [ 1 0 2 1 2 0 3 ];
	q = [ 1 2 0 2 1 3 0 ];

  n = smoments(im,p,q,1,1);
   
  m(1) = n(2) + n(3);
  m(2) = (n(3) - n(2))^2   + 4*n(1)^2;
  m(3) = (n(7) - 3*n(4))^2 + (3*n(5) - n(6))^2;
  m(4) = (n(7) +   n(4))^2 + (  n(5) + n(6))^2;
  m(5) = (  n(7) - 3*n(4)) * (n(7) + n(4)) * ...
           (  (n(7) + n(4))^2 - 3*(n(5) + n(6))^2) + ...
         (3*n(5) -   n(6)) * (n(5) + n(6)) * ...
           (3*(n(7) + n(4))^2 -   (n(5) + n(6))^2);
  m(6) = (n(3) - n(2)) * ((n(7) + n(4))^2 - (n(5) + n(6))^2) + ...
          4*n(1) * (n(7)+n(4)) * (n(5)+n(6));      
  m(7) = (3*n(5) -   n(6)) * (n(7) + n(4)) * ...
           (  (n(7) + n(4))^2 - 3*(n(5) + n(6))^2) - ...
         (  n(7) - 3*n(4)) * (n(5) + n(6)) * ...
           (3*(n(7) + n(4))^2 -   (n(5) + n(6))^2);
           
return;

function m = smoments (im,p,q,central,scaled)

	if (nargin < 5), scaled = 0; 	end;
	if (nargin < 4), central = 0; end;
  if (nargin < 3)
  	error ('Insufficient number of parameters.');
  end;
   
	if (length(p) ~= length(q))
  	error ('Arrays P and Q should have equal length.');
  end;
   
  if (scaled & ~central)
  	error ('Scale-invariant moments should always be central.');
  end;

  % xx, yy are grids with co-ordinates
  [xs,ys] = size(im);
  [xx,yy] = meshgrid(-(ys-1)/2:1:(ys-1)/2,-(xs-1)/2:1:(xs-1)/2);
   
	if (central)
      
  	% Calculate zeroth and first order moments
	  m00 = sum(sum(im));
	  m10 = sum(sum(im.*xx));
	  m01 = sum(sum(im.*yy));
      
    % This gives the center of gravity
    xc  = m10/m00;
    yc  = m01/m00;
      
    % Subtract this from the grids to center the object
    xx  = xx - xc;
    yy  = yy - yc;
      
  end;
   
  % Calculate moment(s) (p,q).
  for i = 1:length(p)
		m(i) = sum(sum((xx.^p(i)).*(yy.^q(i)).*im));
  end;
   
  if (scaled)
      
  	c = 1 + (p+q)/2;
      
    % m00 should be known, as scaled moments are always central
    m = m ./ (m00.^c);
      
	end;
	      
return;