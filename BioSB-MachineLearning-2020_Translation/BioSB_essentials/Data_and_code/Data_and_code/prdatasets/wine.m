%WINE Wine recognition dataset 178 objects with 13 features in 3 classes
%
%	A = WINE
%	A = WINE(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This dataset is taken from the UCI
% Machine Learning Repository, //www.ics.uci.edu/~mlearn/MLRepository.html.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = wine(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end

user.desc = 'These data are the results of a chemical analysis of wines grown in the same region in Italy but derived from three different cultivars.  The analysis determined the quantities of 13 constituents found in each of the three types of wines.';
user.link = '';

a = load('wine.dat');
a = dataset(a(:,2:end),a(:,1));
a = setname(a,'Wine recognition data');
a = setlablist(a,str2mat('cultivar 1','cultivar 2','cultivar 3'));
a = setfeatlab(a,str2mat(...
        'alcohol', ...
        'malic acid', ...
        'ash', ...
	'alcalinity of ash', ...
	'magnesium', ...
	'total phenols', ...
	'flavanoids', ...
	'nonflavanoid phenols', ...    
	'proanthocyanine', ...    
	'color intensity', ...        
	'hue', ...    
	'OD280/OD315 of diluted wines', ...        
        'proline'));
a = setuser(a,user);


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/wine.m
 fn: wine -------------