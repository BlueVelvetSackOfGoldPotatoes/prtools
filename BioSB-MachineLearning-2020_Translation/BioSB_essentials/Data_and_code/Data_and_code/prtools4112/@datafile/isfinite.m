%ISFINITE Datafile overload

function n = isfinite(a)

	prtrace(mfilename,2);
  
	a = a*filtm([],'isfinite');
	n = +a;

