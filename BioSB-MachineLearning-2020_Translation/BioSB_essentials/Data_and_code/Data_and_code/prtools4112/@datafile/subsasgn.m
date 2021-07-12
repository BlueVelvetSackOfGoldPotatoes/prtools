%SUBSASGN Datafile overload

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: subsasgn.m,v 1.3 2009/11/27 08:56:47 duin Exp $

function a = subsasgn(a,s,b)

	prtrace(mfilename,2);

  if (strcmp(s(1).type,'.'))  		        % Assignments of type A.PRIOR = B;
		if (length(s) > 1)
			error('Nested subscripted assigns not implemented for datasets')
		end
    if isfield(struct(a),s(1).subs)               % real datafile field
      a.(s(1).subs) = b; 		        
    else                                  % try dataset
      a.dataset.(s(1).subs) = b;
    end
	elseif strcmp(s(1).type,'()') & isempty(b)
		% statement like a(N,:) = []; tricky!!
		L = [1:size(a,1)];
		L(s(1).subs{1}) = [];
		a.dataset = a.dataset(L,:);
		a.dataset = setident(a.dataset,[1:length(L)]');
  else
    error('Assignment operation not defined for datafiles')
  end
  
 return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/subsasgn.m
 fn: subsasgn -------------
