%GETDATA Get data field in mapping
%
%    DATA = GETDATA(W)
%
% Get content of data field of W
%
%    DATA = GETDATA(W,N)
%
% Get content of N-th cell in W.DATA.
%
%    DATA = GETDATA(W,FIELD)
%
% Get content of desired field if W.DATA is structure


% $Id: getdata.m,v 1.7 2009/09/30 13:43:17 duin Exp $

function data = getdata(w,n)
		prtrace(mfilename,2);
		
		if nargin > 1
			if iscell(w.data) & is_scalar(n)
				data = w.data{n};
			elseif isstruct(w.data) & isstr(n)
				data = w.data.(n);
      elseif length(w.data) >= n
        data = w.data(n);
      else
				error('Illegal item request')
			end
		else
			data = w.data;
		end
		
return
