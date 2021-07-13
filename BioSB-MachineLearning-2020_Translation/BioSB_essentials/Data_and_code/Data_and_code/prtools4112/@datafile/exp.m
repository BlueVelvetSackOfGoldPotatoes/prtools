%EXP Datafile overload

function c = exp(a)
	
	prtrace(mfilename,2);
	
	c = a*filtm([],'exp');

return
