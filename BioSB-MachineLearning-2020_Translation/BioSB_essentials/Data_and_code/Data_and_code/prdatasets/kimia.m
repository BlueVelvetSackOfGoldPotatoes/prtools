%KIMIA 216 objects given by 64 x 64 pixels (features) in 18 classes
%
%	A = KIMIA
%	A = KIMIA(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This set consists of 64 x 64  0/1 images (i.e.
% 4096 binary features). It was converted from a dataset taken from:
% http://www.lems.brown.edu/vision/researchAreas/SIID/
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = kimia(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('kimia',M,N);
a = setname(a,'Kimia Dataset');

