%SETBATCH Enables/diasables execution in batch mode of mappings
%
%    W = SETBATCH(W,FLAG)
%
%Mappings might be executed in batch mode in case of large datasets.
%This is done by default. For some mappings this results in problems.
%SETBATCH(W,0) prevents execution in batch mode. SETBATCH(W,1) restores this
%
%SEE ALSO
%MAPPINGS, GETBATCH

function w = setbatch(w,n)

	prtrace(mfilename,2);
	if all([0,1] ~= n)
		error('Flag should be 0 or 1')
	end
	
	w.user.batch = n;

	return
