%AND Dataset overload

% $Id: and.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = and(a,b)
	prtrace(mfilename,2);
	if (isa(a,'dataset')) & (~isa(b,'dataset'))
		c = a;
		d = (a.data & b);
	elseif (~isa(a,'dataset')) & (isa(b,'dataset'))
		c = b;
		d = a & b.data;
	else
		c = a;
		d = a.data & b.data;
	end
	c = setdata(c,d);
return;
