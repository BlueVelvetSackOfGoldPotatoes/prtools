%GENDATLIN Generation of linear regression data
%
%      A = GENDATLIN(N,B0,B1,SIGMA)
%
% INPUT
%   N       Number of objects to generate
%   B0      Offset
%   B1      Slope
%   SIGMA   Standard deviation of the noise
%
% OUTPUT
%   A       Regression dataset
%
% DESCRIPTION
% Generate regression data A, containing N (x,y)-pairs according to :
%      y = B0 + B1^T*x + N(0,SIGMA)
% Data x is distributed uniformly between 0 and 1.
%
% SEE ALSO
%  GENDATSIN, GENDATSINC

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands
function a = gendatlin(n,b0,b1,sig)

if nargin<4
	sig = 0.1;
end
if nargin<3
	b1 = -1;
end
if nargin<2
	b0 = 2;
end
if nargin<1
	n = 25;
end
% check the size of beta1
b1 = b1(:);
dim = size(b1,1);

% generate the data:
x = rand(n,dim);
y = x*b1 + b0 + sig(1).*randn(n,1);

% store it in the dataset:
a = gendatr(x,y);

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/gendatlin.m
 fn: gendatlin -------------
