%ISNAN Datafile overload

function n = isnan(a)

	prtrace(mfilename,2);
  
	a = a*filtm([],'isnan');
	n = +a;

