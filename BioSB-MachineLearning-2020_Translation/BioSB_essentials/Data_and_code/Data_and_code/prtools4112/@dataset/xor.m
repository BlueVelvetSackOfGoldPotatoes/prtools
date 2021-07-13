%XOR Dataset overload

% $Id: xor.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = xor(a,b)
		prtrace(mfilename,2);
	if isa(a,'dataset') & ~isa(b,'dataset')
		c = a;
		d = xor(a.data,b);
	elseif ~isa(a,'dataset') & isa(b,'dataset')
		c = b;
		d = xor(a,b.data);
	else
		c = a;
		d = xor(a.data,b.data);
	end
	c = setdata(c,d);
return
