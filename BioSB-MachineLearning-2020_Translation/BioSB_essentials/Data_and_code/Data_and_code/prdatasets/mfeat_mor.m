%MFEAT_MOR 2000 objects with 6 features in 10 classes
%
%	A = MFEAT_MOR
%	A = MFEAT_MOR(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are some morphological features.
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_mor(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-mor',M,N);
a = setname(a,'MFEAT Morphological Features');
