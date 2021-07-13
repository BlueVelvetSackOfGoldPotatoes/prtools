%REAL Datafile overload

function a = real(a)
	
	prtrace(mfilename,2);
  
	a = a*filtm([],'real');
		
return
