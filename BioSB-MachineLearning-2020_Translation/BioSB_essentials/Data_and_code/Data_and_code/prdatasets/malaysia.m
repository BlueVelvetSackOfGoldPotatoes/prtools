%MALAYSIA 291 objects with 8 features in 20 classes
%
%	A = MALAYSIA
%	A = MALAYSIA(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This dataset concerns simple measurements on
% segments of utility symbols.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5038, 2600 GA Delft, The Netherlands

function a = malaysia(M,N);
		prtrace(mfilename);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('malaysia',M,N);
a = setname(a,'Malaysia Data');
