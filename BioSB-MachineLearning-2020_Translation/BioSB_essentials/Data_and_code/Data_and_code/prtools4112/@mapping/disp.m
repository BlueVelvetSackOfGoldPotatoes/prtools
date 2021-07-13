%DISP Display mapping
%
%	  DISP(W)
% 
% INPUT 
%   W   Mapping
%
% DESCRIPTION
% Display mapping W and its data field.

% $Id: disp.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function disp(w)

	prtrace(mfilename,2);

	w
	disp(w.data)

return
