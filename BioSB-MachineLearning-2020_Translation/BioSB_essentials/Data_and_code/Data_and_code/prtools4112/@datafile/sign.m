%SIGN Datafile overload

function a = sign(a)
	
	prtrace(mfilename,2);
  
	a = a*filtm([],'sign');
		
return
