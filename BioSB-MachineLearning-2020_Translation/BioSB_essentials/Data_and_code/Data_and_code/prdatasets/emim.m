%EMIM 128 x 128 objects (pixels) with 8 features 
%
%	A = EMIM
%	A = EMIM(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are 8 spectral bands of an EM image.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5038, 2600 GA Delft, The Netherlands

function a = emim(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('emim',M,N);
a = setname(a,'EM Image Delft');

