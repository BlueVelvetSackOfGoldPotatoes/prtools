%XOR Datafile overload

function c = xor(a,b)
	prtrace(mfilename,2);
  
	[check,a,b] = check12(a,b);
	
	switch check
		case 'both'
			c = dyadic(a,'xor',b);
		case 'first'
			c = a*filtm([],'xor',b);
    case 'last'
      c = b*filtm([],'xor',a);
  end
		
return;
 