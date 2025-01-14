%LENA 256 x 256 objects (pixels) with 3 features (red, green, blue)
%
%	A = LENA
%	A = LENA(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is a reduced version of the original Lena
% image in PRTools format. Pixels are objects and colors are features.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = lena(M,N);
		prtrace(mfilename);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
s = warning;
a = prdataset('lena');
a = setfeatlab(a,['red  ';'green';'blue ']);
a = setname(a,'Lena');
