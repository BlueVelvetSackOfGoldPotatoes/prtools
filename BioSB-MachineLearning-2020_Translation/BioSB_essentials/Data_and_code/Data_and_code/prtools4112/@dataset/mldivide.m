%MLDIVIDE Dataset overload

% $Id: mldivide.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = mldivide(a,b)

	prtrace(mfilename,2);

	if (isa(a,'dataset')) & (~isa(b,'dataset'))
		c = a.data \ b;
	elseif (~isa(a,'dataset') & isa(b,'dataset'))
		c = a \ b.data;
	else
		c = a.data \ b.data;
	end

return
