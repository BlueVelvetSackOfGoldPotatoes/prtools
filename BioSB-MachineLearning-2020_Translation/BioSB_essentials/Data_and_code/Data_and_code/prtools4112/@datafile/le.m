%LE Datafile overload

function c = le(a,b)
	prtrace(mfilename,2);
  
	[check,a,b] = check12(a,b);
	
	switch check
		case 'both'
			c = dyadic(a,'le',b);
		case 'first'
			c = a*filtm([],'le',b);
    case 'last'
      c = b*filtm([],'gt',a);
  end
		
return;
 