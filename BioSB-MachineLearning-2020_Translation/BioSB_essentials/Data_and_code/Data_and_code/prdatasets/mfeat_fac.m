%MFEAT_FAC 2000 objects with 216 features in 10 classes
%
%	A = MFEAT_FAC
%	A = MFEAT_FAC(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are the face features (projection on
% horizontal and vertical axes).
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_fac(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-fac',M,N);
a = setname(a,'MFEAT Face Features');
