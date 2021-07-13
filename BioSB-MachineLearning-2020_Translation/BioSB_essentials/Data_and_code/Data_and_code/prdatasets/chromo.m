%CHROMO 1143 objects with 8 features in 24 classes
%
%	A = CHROMO
%	A = CHROMO(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. The features are blob characteristics of
% thresholded chromosomes. This technique is outdated.

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = chromo(M,N);
		prtrace(mfilename);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('chromo',M,N);
a = setname(a,'Chromosome Features');
