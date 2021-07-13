%LT Datafile overload

function c = lt(a,b)
	prtrace(mfilename,2);
  
	[check,a,b] = check12(a,b);
	
	switch check
		case 'both'
			c = dyadic(a,'lt',b);
		case 'first'
			c = a*filtm([],'lt',b);
    case 'last'
      c = b*filtm([],'ge',a);
  end
		
return;
 