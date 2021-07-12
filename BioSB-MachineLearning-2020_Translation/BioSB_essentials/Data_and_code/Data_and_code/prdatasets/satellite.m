%SATELLITE Satellite dataset 6435 objects with 36 features in 6 classes
%
%	A = SATELLITE
%	A = SATELLITE(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is the Satellite dataset from the UCI
% Machine Learning Repository, //www.ics.uci.edu/~mlearn/MLRepository.html.
% As the samples are taken from related neighborhoods, it is better to
% avoid cross-validation. Use the first 4435 samples for training and the
% remaining 2000 for testing.
%
% See also DATASETS, PRDATASETS, SOYBEAN1

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = satellite(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('satellite',M,N);
a = setname(a,'Satellite dataset');
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/satellite.m
 fn: satellite -------------
