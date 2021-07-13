%SETDATA Set data field in mapping
%
% 	W = SETDATA(W,DATA,FIELD)
% 	W = SETDATA(W,DATA,N)
%
% INPUT
%   W     Mapping
%   DATA  Data to be put in data field.
%   FIELD String, name of natafield to be used for DATA
%   N     Index of cell array to be used for DATA
%
% OUTPUT
%   W     Mapping
%
% DESCRIPTION
% The datafield of a mapping consists of a matrix, cell array or a structure. 
% In case FIELD nor N are given the entire datafield is replaced by DATA.
% In case the datafield is a structure DATA is assigned to field FIELD.
% In case the datafield is a cell array, DATA is assigned to cell N.
% DATA cannot be a structure in case of untrained or fixed mappings.

% $Id: setdata.m,v 1.6 2009/09/09 12:45:55 duin Exp $

function w = setdata(w,data,f)

	prtrace(mfilename,2);
  
  if nargin < 3
    if isstruct(w.data)
      w.data = data;
    elseif isstruct(data)      
      if isuntrained(w) | isfixed(w)
        error('Structures not allowed for the datafield of untrained or fixed mappings');
      end
      w.data = data;
    elseif iscell(data)
      w.data = data;
 %   else, w.data = {data}; 
    else
      if istrained(w)
        w.data = data;
      else
        w.data = {data};
      end
    end
  else
    if isstr(f)
      if isstruct(w.data) | isempty(w.data)
        w.data = setfield(w.data,f,data);
      else
        error('Datafield of mapping is not a structure')
      end
    else
      w.data{f} = data;
    end
  end
% 
% 	% Convert DATA to a cell, if W is not trained yet, as for untrained
% 	% mappings the data field contains the parameters as set by the user, 
% 	% needed for training. If there is just a single parameter he may
% 	% forget the cell construct. This is corrected here, for consistency.
% 
% 	if (~strcmp(w.mapping_type,'trained')) & (~iscell(data)) & (~isstruct(data))
% 		w.data = {data};
% 	else
% 		w.data = data;
% 	end

return
