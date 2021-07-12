%GETNAME Get dataset name
%
%   NAME = GETNAME(A,N)
%
% INPUT
%   A    Dataset
%   N    Number of characters in NAME (default: all)
%
% OUTPUT
%   NAME  Dataset name
%
% DESCRIPTION
% If N given, the return string has exactly N characters. This is done by
% truncation or by padding with blanks. This is useful for display purposes.

% $Id: getname.m,v 1.5 2009/03/01 16:58:32 duin Exp $

function name = getname(w,n)

	prtrace(mfilename,2);

	%DXD: expand the sequential mappings and collect the names in one
	%large string:
	if strcmp(w.mapping_file,'sequential') & isempty(w.name)
		% (recursion is cool:)
		name1 = getname(w.data{1});
		if isempty(name1)
			name = getname(w.data{2});
		else
			name = [name1,'+',getname(w.data{2})];
		end
	else
		% otherwise just return its own name:
		name = w.name;
	end

	% If requested, truncate name or add spaces.

	if (nargin > 1)
		if (length(name) > n)
			name = name(1:n);
		else
			name = [name,repmat(' ',1,n-length(name))];
		end
	end

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@mapping/getname.m
 fn: getname -------------