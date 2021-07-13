%DET Dataset overload
%
%Computes determinant of data, a.data must be square 

% $Id: det.m,v 1.3 2007/03/22 07:45:54 duin Exp $


function c = det(a)

		prtrace(mfilename,2);
		
	a = datasetconv(a);
	c = det(a.data);
	
return
