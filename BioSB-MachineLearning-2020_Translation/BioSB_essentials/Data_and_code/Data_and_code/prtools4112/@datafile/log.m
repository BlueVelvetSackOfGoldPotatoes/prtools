%LOG Datafile overload

function c = log(a)
	
	prtrace(mfilename,2);
	
	c = a*filtm([],'log');

return
