%SETFEATSIZE Set featsize of datafile
%
%   A = SETFEATSIZE(A,FEATSIZE)
%
% INPUT
%   A        - Datafile
%   FEATSIZE - Neglected
%
% OUTPUT
%   A       - Datafile
%
% DESCRIPTION
% If A is a dataset, its featsize is set. The featsize of a datafile
% is unclear as objects may have different sizes. For that reason
% the feature sizes of datafiles are set to 0.
%
% SEE ALSO
% DATAFILES

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = setfeatsize(a,featsize)

  a.dataset = setfeatsize(a.dataset,0);
	
return
