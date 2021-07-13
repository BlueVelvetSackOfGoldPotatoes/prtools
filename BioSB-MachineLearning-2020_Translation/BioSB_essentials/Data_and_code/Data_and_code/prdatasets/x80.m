%X80 Handwritten character dataset, 45 objects with 8 features in 3 classes
%
%	A = X80
%	A = X80(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is the 80X dataset. The features are the
% distances from a bounding box to the pixels of a set of handwritten
% characters 'X', '8' and '0', measured form the corners along the
% diagnoals and from the edge midpoints along the horizontal and vertical
% central axes.
%
% See also DATASETS, PRDATASETS, IMOX

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = x80(M,N);
		prtrace(mfilename);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('80x',M,N);
a = setname(a,'80X Dataset');
a = setlablist(a,str2mat('8','0','X'));
a = setfeatlab(a,str2mat(...
        'diagonal from top-left', ...
        'vertical from top-center', ...
        'diagonal from top-right', ...
		'horizontal from right-center', ...
		'diagonal from bottom-right', ...
		'vertical from bottom-center', ...
		'diagonal from bottom-left', ...
		'horizontal from left-center'));
