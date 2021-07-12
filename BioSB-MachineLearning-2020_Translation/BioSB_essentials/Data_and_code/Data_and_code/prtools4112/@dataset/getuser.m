%GETUSER Get the user field of a dataset
%
%    USERFIELD = GETUSER(A,FIELD)
%
% INPUT
%   A          Dataset
%   FIELD      Character string: name of structure field of USER field of A.
%
% OUTPUT
%   USERFIELD  Requested field
%
% If FIELD is is the empty string ('') the entire user field is returned. 
%
% If the requested field does not exist USERFIELD = [];
%
% Note the the USER field of datasets was originally intended for a user
% defined description of datasets. Later its usage was extended to a field
% for storing general information on datasets. For that reason 'old'
% datasets without a structure in the user field are transformed such that
% this information is stored in a subfield USER in the user field. It can
% be retrieved by GETUSER(A).

% $Id: getuser.m,v 1.4 2009/09/30 15:16:15 duin Exp $

function out = getuser(a,field)

	prtrace(mfilename,2);
	
	user = a.user;
	if ~isstruct(user)    % convert to expected structure if needed
		user.user = user;
	end
	
	if nargin < 2
		field = 'user';
	end
	
	if ~isstr(field)
		error('User field should be given as string')
	end
	
	if strcmp(field,'')               % return everything
		s = user;
	elseif ~isfield(user,field)
		s = [];
	else
		s = getfield(user,field);
	end

	if nargout == 0
		if isstr(s)
			disp(' ')
			disp(strvcat(textwrap({s},80)));
			disp(' ')
		elseif iscellstr(s)
			for j=1:length(s)
				disp(' ')
				disp(strvcat(textwrap(s(j),80)));
				disp(' ')
			end
		else
			out = s;
		end
	else
		out = s;
	end
		
return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/getuser.m
 fn: getuser -------------