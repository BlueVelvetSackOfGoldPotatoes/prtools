%MFEAT_PIX 2000 objects with 240 features in 10 classes
%
%	A = MFEAT_PIX
%	A = MFEAT_PIX(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are averages of groups of 2x3 pixels.
% The original images can be roughly reconstructed from them.
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_pix(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-pix',M,N);
a = setname(a,'MFEAT Pixel Features');
