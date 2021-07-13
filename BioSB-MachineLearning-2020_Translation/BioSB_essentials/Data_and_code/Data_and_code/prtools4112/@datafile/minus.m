%MINUS Dataset overload

function c = minus(a,b)

	prtrace(mfilename,2);

	[check,a,b] = check12(a,b);
	
	switch check
		case 'both'
			c = dyadic(a,1,b,-1);
		case 'first'
			c = a*filtm([],'minus',b);
    case 'last'
      b = -b;
      c = b*filtm([],'plus',a);
  end
  
return