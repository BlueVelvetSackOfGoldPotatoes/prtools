%ISTYPE Check datafile type
%
%   I = ISTYPE(A,TYPE)

function n = istype(a,type)

	prtrace(mfilename,2);
	
	n = strcmp(a.type,type);

