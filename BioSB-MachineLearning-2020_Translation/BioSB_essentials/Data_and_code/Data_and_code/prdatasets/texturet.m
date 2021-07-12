%TEXTURET 256 x 256 objects (pixels) with 7 features in 5 classes
%
%	A = TEXTURET
%	A = TEXTURET(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. The dataset TEXTUREL deals with a similar texture
% image given by the same texture features.
%
% See also DATASETS, PRDATASETS, TEXTUREL

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = texturet(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('texturet',M,N);
a = setname(a,'Texture Test Set');

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/texturet.m
 fn: texturet -------------
