%TEXTUREL 128 x 640 objects (pixels) with 7 features in 5 classes
%
%	A = TEXTUREL
%	A = TEXTUREL(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. The dataset TEXTURET deals with a similar texture
% image given by the same texture features.
%
% See also DATASETS, PRDATASETS, TEXTURET

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = texturel(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('texturel',M,N);
a = setname(a,'Texture Learning Set');
