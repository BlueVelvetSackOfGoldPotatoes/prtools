%FINDLABELS Determine indices of objects having specified labels
%
%    J = FINDLABELS(A,LABELS)
%
% J is a column vector of indices to the objects in A that have one of the labels
% stored in LABELS.

% $Id: findlabels.m,v 1.3 2006/09/26 12:49:54 duin Exp $

function J = findlabels(a,labels)
		prtrace(mfilename,2);
if strcmp(a.labtype,'targets')
	error('No labels defined for dataset with label type ''targets''')
end
J = [];
lablista = getlablist(a);
[nl,nll] = renumlab(lablista,labels);
curn = curlablist(a);
for j = 1:length(nll)
	k = find(nl == nll(j));
	if ~isempty(k)
		J = [J; find(a.nlab(:,curn) == nl(k))];
	end
end
return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/findlabels.m
 fn: findlabels -------------
