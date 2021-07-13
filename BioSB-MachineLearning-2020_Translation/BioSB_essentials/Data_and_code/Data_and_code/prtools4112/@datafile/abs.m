%ABS Datafile overload

function a = abs(a)

	prtrace(mfilename,2);
	
	isdatafile(a);
	a = a*filtm([],'abs');
	
return;
 