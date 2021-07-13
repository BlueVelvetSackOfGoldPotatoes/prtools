%NOT Logical NOT. Datafile overload

function a = not(a)
		prtrace(mfilename,2);
		a = a*filtm([],'not');
return
