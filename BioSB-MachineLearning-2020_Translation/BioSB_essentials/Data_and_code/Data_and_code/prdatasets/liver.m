%LIVER Liver disorder dataset, 345 objects, 6 features, 2 classes
%
%	A = LIVER
%	A = LIVER(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is the Liver-disorders database from the UCI
% Machine Learning Repository, //www.ics.uci.edu/~mlearn/MLRepository.html
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = liver(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('liver',M,N);
a = setname(a,'Liver disorder dataset');

a = setlablist(a,str2mat('healthy','disorder'));
a = setfeatlab(a,str2mat(...
        'mean corpuscular volume', ...
        'alkaline phosphotase', ...
        'alamine aminotransferase', ...
		'aspartate aminotransferase', ...
		'gamma-glutamyl transpeptidase', ...
		'half-pint equivalents'));

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/liver.m
 fn: liver -------------
