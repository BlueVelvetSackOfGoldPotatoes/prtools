%MPOWER Dataset overload

% $Id: mpower.m,v 1.3 2007/03/22 07:45:54 duin Exp $

function c = mpower(a,b)

	prtrace(mfilename,2);
	
	if (isa(a,'dataset')) & (~isa(b,'dataset'))
		c = a;
		data = a.data ^ b;
	elseif (~isa(a,'dataset')) & (isa(b,'dataset'))
		c = b;
		data = a ^ b.data;
	else
		c = a;
		data = a.data ^ b.data;
	end
	c = setdata(c,data);

return
