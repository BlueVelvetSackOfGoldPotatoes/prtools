%RINGNORM 7400 objects with 20 features in 2 classes
%
%	A = RINGNORM
%	A = RINGNORM(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is an implementation of Leo Breimans ringnorm
% example. It is taken from:
% http://www.cs.toronto.edu/~delve/data/
%
% REFERENCE
% Breiman L. Bias, variance and arcing classifiers. Tech. Report 460, 
% Statistics Department. University of California. April 1996. 
%
% See also DATASETS, PRDATASETS, TWONORM

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = ringnorm(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('ringnorm',M,N);
a = setname(a,'Ringnorm Data');


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ringnorm.m
 fn: ringnorm -------------