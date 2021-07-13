%END Dataset overload

function m = end(a,k,n);

	prtrace(mfilename,2);
	
	if n == 1
		error('Two-dimensional subscript expected')
	elseif n == 2
		m = size(a,k);
	else
		error('Datafile should be 2-dimensional')
	end

	return
