%IONOSPHERE 351 objects, 34 features, 2 classes
%           Johns Hopkins University ionosphere dataset
%
%	A = IONOSPHERE
%	A = IONOSPHERE(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is the Johns Hopkins University ionosphere
% dataset from the UCI Machine Learning Repository, 
% //www.ics.uci.edu/~mlearn/MLRepository.html
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = ionosphere(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('ionosphere',M,N);
a = setname(a,'Ionosphere Dataset');
a = setlablist(a,str2mat('good','bad'));


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/ionosphere.m
 fn: ionosphere -------------
