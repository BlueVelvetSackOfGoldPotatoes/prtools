%SETVERSION Set the version field of a dataset
%
%   A = SETVERSION(A,S)
%
% INPUT
%   A      Dataset
%   S      String to be stored in the version field 
%
% OUTPUT
%   A      Updated dataset
%
% DESCRIPTION
% Set or reset the version field of A by S.

function a = setversion(a,s)

	prtrace(mfilename,2);
	
	a.version = s;
	
return
