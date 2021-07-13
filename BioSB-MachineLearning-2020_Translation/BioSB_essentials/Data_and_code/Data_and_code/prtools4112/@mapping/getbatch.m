%GETBATCH Test on possible execution of mapping in batch mode
%
%    I = GETBATCH(W)
%
%I is set (1) in case batch mode is allowed (default).
%Use SETBATCH todisable batch processing of mappings
%
%SEE ALSO
%MAPPINGS, SETBATCH

function I = nobatch(w)

	prtrace(mfilename,2);
	
	I = 1;
	if isfield(w.user,'batch') & w.user.batch == 0
		I = 0;
	end

	return
