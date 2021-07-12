%SETPOSTPROC (Re)set POSTPROC field of a datafile
%
%   A = SETPOSTPROC(A,MAPPING)
%   A = SETPOSTPROC(A)
%
% INPUT
%   A        - Datafile
%   POSTPROC - cell containing postprocessing mapping command
%
% OUTPUT
%   A       - Datafile
%
% DESCRIPTION
% Sets the mappings stored in A.POSTPROC. The size of the datafile
% A is set to the output size of MAPPING.
% A call without MAPPING clears A.POSTPROC. The size of the datafile
% A is reset to undefined (0).
%
% The mappings in A.POSTPROC may be extended by ADDPOSTPROC.
%
% Mappings in A.POSTPROC are stored only and executed just 
% after A is converted from a DATAFILE into a DATASET.
%
% SEE ALSO
% DATAFILES, SETPREPROC, ADDPOSTPROC.

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = setpostproc(a,mapp)
		prtrace(mfilename,2);
		
s = getfeatsize(a);
k = prod(s);
if nargin < 2
	a.postproc = setsize_in(mapping([]),k); % Resset to unity mapping
	a.postproc = setsize_out(a.postproc,s); 
  a.dataset = setfeatsize(a.dataset,s);
elseif ismapping(mapp) | (iscell(mapp) & ismapping(mapp{1}))
  % dirty programming needed to avoid that this command has to be 
  % executed in the mapping directory
  if iscell(mapp)
    mapp = mapp{1};
  end
	if size(mapp,1) == 0
		mapp = setsize_in(mapp,k);
	end
	if size(mapp,1) ~= k
		error('Input size postprocessing mapping does not match feature size datafile')
  end
	a.postproc = mapp;
  s = getsize_out(mapp);
  if isempty(s) | s == 0
    s = getfeatsize(a);
  end
	if isfixed(a.postproc)
		a.postproc = setmapping_type(a.postproc,'trained');
	end
  a.dataset = setfeatsize(a.dataset,s);
else
	error('Mapping expected')
end

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/setpostproc.m
 fn: setpostproc -------------