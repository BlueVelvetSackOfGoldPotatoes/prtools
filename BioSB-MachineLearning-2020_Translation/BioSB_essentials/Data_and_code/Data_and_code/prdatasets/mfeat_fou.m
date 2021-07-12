%MFEAT_FOU 2000 objects with 76 features in 10 classes
%
%	A = MFEAT_FOU
%	A = MFEAT_FOU(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. These are the Fourier features.
%
% See also DATASETS, PRDATASETS, MFEAT

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = mfeat_fou(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('mfeat-fou',M,N);
a = setname(a,'MFEAT Fourier Features');

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/mfeat_fou.m
 fn: mfeat_fou -------------
