%FINDFEATLAB Determine indices of features having specific labels
%
%   J = FINDFEATLAB(A,LABELS)
%
% J is a column vector of indices to the features that have the label
% stored in LABELS. When a label is not present, the index will be 0.
% The parameter LABELS can be a cell-array with string labels.

function J = findfeatlab(a,labels)

if isa(labels,'char')
	labels = cellstr(labels);
end

n = length(labels);
J = zeros(n,1);
fl = getfeatlab(a);

if isa(labels,'double')
	for i=1:n
		id = find(fl == labels(i));
  	if ~isempty(id)
	  	J(i) = id;
  	end
	end
else
	for i=1:n
 	 id = strmatch(labels{i},fl);
  	if ~isempty(id)
	  	J(i) = id;
  	end
	end
end


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findfeatlab.m
 fn: findfeatlab -------------
