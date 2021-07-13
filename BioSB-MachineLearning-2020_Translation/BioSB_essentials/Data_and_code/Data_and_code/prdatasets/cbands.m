%CBANDS 12000 objects with 30 features in 24 classes
%
%	A = CBANDS
%	A = CBANDS(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are resampled human chromosome banding
% profiles, such that each chromosome is represented by 30 samples. Note
% that these techniques are almost not used anymore.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = cbands(M,N);
		prtrace(mfilename);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('cbands',M,N);
a = setname(a,'Chromosome Bands');
