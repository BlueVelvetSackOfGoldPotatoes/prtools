%GETFEATLAB Get feature labels of dataset
%
%   FEATLAB = GETFEATLAB(A,STRING)
%
% INPUT
%   A        Dataset
%   STRING   Indicate whether feature labels should be returned as strings
%            (if 'string' or 1), or not (default).
%
% OUTPUT
%   FEATLAB  Feature labels
%
% DESCRIPTION
% Returns the labels of the features of dataset A. If STRING equals 'string'
% or 1, the label list is converted to characters, which may be useful for
% display purposes and annotation of graphs.

% $Id: getfeatlab.m,v 1.4 2008/11/28 15:45:47 duin Exp $

function featlab = getfeatlab(a,string)

	prtrace(mfilename,2)

	featlab = a.featlab;
	
	%if isempty(featlab)   % return default if not set
	%	featlab = [1:size(a,2)]';
	%end

	% If requested, convert to characters.

	if (nargin > 1) & (string == 1 | strcmp(string,'string')) & (~isstr(featlab))
			featlab = num2str(featlab);
	end

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getfeatlab.m
 fn: getfeatlab -------------
