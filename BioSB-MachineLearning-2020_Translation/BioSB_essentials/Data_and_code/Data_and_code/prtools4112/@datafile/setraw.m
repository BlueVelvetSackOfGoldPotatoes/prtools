%SETTYPE Set TYPE datafile field

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = settype(a,s)

	prtrace(mfilename,2);
  
  a.type = s;
  
 return
