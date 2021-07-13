%GETRAW Get datafile RAW field
%
%	   R = GETRAW(A)

function r = getraw(a)

	prtrace(mfilename,2);
	
  r = a.raw;
  
return