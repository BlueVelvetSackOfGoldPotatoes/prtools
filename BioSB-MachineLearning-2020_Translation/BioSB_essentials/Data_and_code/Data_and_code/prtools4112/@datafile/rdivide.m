%RDIVIDE Datafile overload

function c = rdivide(aa,bb)
	prtrace(mfilename,2);
  
	[check,a,b] = check12(aa,bb);
	
	switch check
		case 'both'
			c = dyadic(a,'rdivide',b);
		case 'first'
			c = a*filtm([],'rdivide',b);
    case 'last'
			c = b*filtm([],'ldivide',a);
  end
		
return;
 