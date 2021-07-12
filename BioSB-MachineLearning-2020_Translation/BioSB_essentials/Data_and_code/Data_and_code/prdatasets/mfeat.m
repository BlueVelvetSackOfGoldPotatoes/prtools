%MFEAT 2000 objects with 649 features in 10 classes
%
%	A = MFEAT
%	A = MFEAT(M,N)
%
% Load all MFEAT datasets in A, select the objects and features according to
% the index vectors M and N. This dataset consists of features of handwritten
% numerals (`0'--`9') extracted from a collection of Dutch utility maps.
% Six different feature sets are extracted and stored separately.
% This command loads them all, in the following order:
%
% MFEAT_FAC, MFEAT_FOU, MFEAT_KAR, MFEAT_MOR, MFEAT_PIX, MFEAT_ZER.
%
% REFERENCES
% [1] A.K. Jain, R.P.W. Duin, and J. Mao, Statistical Pattern Recognition:
% A Review, IEEE Transactions on Pattern Analysis and Machine Intelligence,
% vol. 22, no. 1, 2000, 4-37.
% [2] R.P.W. Duin and D.M.J. Tax, Experiments with Classifier Combining
% Rules, in: J. Kittler, F. Roli (eds.), Multiple Classifier Systems ,
% LNCS, vol. 1857, Springer, Berlin, 2000, 16-29.
%
% See also DATASETS, PRDATASETS, 

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_zer(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-fac');
a = [a prdataset('mfeat-fou')];
a = [a prdataset('mfeat-kar')];
a = [a prdataset('mfeat-mor')];
a = [a prdataset('mfeat-pix')];
a = [a prdataset('mfeat-zer')];

if isempty(M)
	if isempty(N)
		;
	else
		a = a(:,N);
	end
else
	if isempty(N)
		a = a(M,:);
	else
		a = a(M,N);
	end
end

a = setname(a,'MFEAT Combined Features');

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat.m
 fn: mfeat -------------
