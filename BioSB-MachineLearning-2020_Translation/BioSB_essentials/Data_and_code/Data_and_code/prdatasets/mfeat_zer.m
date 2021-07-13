%MFEAT_ZER 2000 objects with 47 features in 10 classes
%
%	A = MFEAT_ZER
%	A = MFEAT_ZER(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are the Zernike moments.
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_zer(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-zer',M,N);
a = setname(a,'MFEAT Zernike Moments');
