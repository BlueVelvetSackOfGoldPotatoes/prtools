%GETTYPE Get datafile TYPE field
%
%	   R = GETTYPE(A)

function r = gettype(a)

	prtrace(mfilename,2);
	
  r = a.type;
  
return