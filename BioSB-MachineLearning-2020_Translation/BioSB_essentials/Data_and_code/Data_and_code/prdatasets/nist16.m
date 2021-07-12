%NIST16 2000 normalised digits given by 16x16 pixels (features) in 10 classes
%
%	A = NIST16
%	A = NIST16(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is a subset of the NIST handprinted digits,
% normalised and sampled on 16x16 pixels.
%
% See also DATASETS, PRDATASETS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = nist16(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('nist16',M,N);
a = setname(a,'NIST16 Normalised Digits');


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/nist16.m
 fn: nist16 -------------
