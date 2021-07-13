%UPLUS Datafile overload

function c = uplus(a)

	prtrace(mfilename,2);
	
	if nargout > 0
		error('Command not implemented for datafile. Convert to dataset first')
	else
		a = dataset(a);
		c = getdata(a);
	end

return
