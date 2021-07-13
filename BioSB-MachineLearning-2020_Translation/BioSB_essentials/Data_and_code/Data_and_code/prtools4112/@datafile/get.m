%GET Get datafile parameter fields 
%
%   [VALUE1,VALUE2,...] = GET(A,FIELD1,FIELD2,...)
%
% INPUT 
%   A       Datafile
%   FIELDx  Field names (strings)
%
% OUTPUT
%   VALUEx  Field values
%
% SEE ALSO
% DATAFILE, SET

% $Id: get.m,v 1.4 2007/04/26 08:47:26 duin Exp $

function varargout = get(a,varargin)

	prtrace(mfilename,2);

	if (isempty(varargin)), return, end

	if (nargout > 0) & (length(varargin) ~= nargout)
		error('Wrong number of output parameters')
	end

	% Print or return all requested fields.

  for j = 1:length(varargin)

  	name = varargin{j};

  	switch (name)
    	case {'ROOTPATH','rootpath'}
    		v = a.rootpath;
    	case {'FILES','files'}
    		v = a.files;
    	case {'TYPE','type'}
    		v = a.type;
    	case {'PREPROC','preproc'}
    		v = a.preproc;
			case {'POSTPROC','postproc'}
    		v = a.postproc;
			case {'DATASET','dataset'}
				v = a.dataset;
    	otherwise
				v = get(a.dataset,name);
  	end

		% If no output argument is specified, display the value.

  	if (nargout == 0)
  		disp(' ')
  		disp(v)
  		if (isempty(v))
  			disp('[]')
  		end
		else
  		varargout{j} = v;
  	end

  end

return
