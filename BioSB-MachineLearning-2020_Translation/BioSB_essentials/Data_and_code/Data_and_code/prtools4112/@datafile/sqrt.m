%SQRT Datafile overload

function a = sqrt(a)
	
	prtrace(mfilename,2);
  
	a = a*filtm([],'sqrt');
		
return
