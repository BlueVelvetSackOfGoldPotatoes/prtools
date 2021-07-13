%PLUS Plus. Mapping overload

% $Id: plus.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function c = plus(a,b)
		prtrace(mfilename,2);
sa = size(a);
sb = size(b);
if ~isa(a,'mapping')
	c = b+a;
	return
end
if ~isaffine(a)
	error('Operationed defined for affine mappings only')
end
if isa(b,'mapping')
	if ~isaffine(b)
		error('Operationed defined for affine mappings only')
	end
	if any(sa ~= sb)
		error('Mappings should have equal size')
	else
		c = a;
		c.data.rot = c.data.rot + b.data.rot;
		c.data.offset = c.data.offset + b.data.offset;
	end
elseif isa(b,'double')
	c = a;
	if length(b) == 1
		c.data.offset = c.data.offset + b;
	elseif all(size(b) == size(c.data.offset))
		c.data.offset = c.data.offset + b;
	elseif any(size(b) ~= size(c.data.rot))
		error('Mappings should have equal size')
	else
		c.data.rot = c.data.rot + b;
	end
end
return
