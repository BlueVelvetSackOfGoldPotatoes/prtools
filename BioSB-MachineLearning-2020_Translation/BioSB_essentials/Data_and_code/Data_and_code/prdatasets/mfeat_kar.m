%MFEAT_KAR 2000 objects with 64 features in 10 classes
%
%	A = MFEAT_KAR
%	A = MFEAT_KAR(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are the Karhunen-Loeve moments.
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_kar(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-kar',M,N);
a = setname(a,'MFEAT KL Features');
