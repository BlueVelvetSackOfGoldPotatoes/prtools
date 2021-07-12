%HORZCAT Dataset overload: horizontal concatenation, extended for features

% $Id: horzcat.m,v 1.7 2009/01/20 17:27:51 davidt Exp $

function a = horzcat(varargin)

	prtrace(mfilename,2);

	% STARTS contains the position of the second dataset to concatenate.

	a = varargin{1}; start = 2;

	% A call like A = [B]:    
	if (nargin == 1), return; end       
    
	% A call like A = [ [] B ... ]:
	if (isempty(a)) | (prod(size(a)) == 0) 
		a = varargin{2}; start = 3;
	end

  if (~isa(a,'dataset'))
  	error('First argument should be a dataset.');
  end

  [ma,ka] = size(a);

	% Extend dataset A by the other datasets given.

  for i = start:length(varargin)  

  	b = varargin{i}; [mb,kb] = size(b);

		% Check whether sizes correspond.
  	if (ma ~= mb)
  		error('Datasets should have equal numbers of objects.');
  	end
		
  	if (isa(b,'dataset'))         				% Update fields if B is dataset.
      a.data = [a.data b.data];           % The data itself,
			if isempty(a.featlab) ~= isempty(b.featlab)
				a.featlab = [];
				prwarning(1,'Inconsistent feature labels: reset to []')
			elseif (isstr(a.featlab))               %   the feature labels and
				if isempty(b.featlab)
					b.featlab = repmat(' ',kb,1);
				end
  			a.featlab = char(a.featlab,b.featlab);
  		else
  			a.featlab = [a.featlab; b.featlab];
  		end
			if isempty(a.featdom) & ~isempty(b.featdom)
  			a.featdom = [cell(1,size(a,2))  b.featdom];
			elseif ~isempty(a.featdom) & isempty(b.featdom)
  			a.featdom = [a.featdom cell(1,size(b,2))];
			else
				a.featdom = [a.featdom b.featdom];
			end
  		if (~strcmp(a.name,b.name))         % Clear dataset name, unless equal.
  			a.name = [];
  		end
  	else             				             	% Update fields if B is a matrix.
  		a.data = [a.data b];              	% The data itself,
		if ~isempty(a.featlab)
			if (isstr(a.featlab))
				a.featlab = char(a.featlab,repmat(' ',kb,1));
			else
				a.featlab = [a.featlab; repmat(-inf,kb,1)];
			end
		end
			if ~isempty(a.featdom)
  			a.featdom = [a.featdom cell(1,size(b,2))]; % default feature domains.
			end
	  end
	end

	% Re-calculate number of features.

  a.featsize = size(a.data,2);

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/horzcat.m
 fn: horzcat -------------