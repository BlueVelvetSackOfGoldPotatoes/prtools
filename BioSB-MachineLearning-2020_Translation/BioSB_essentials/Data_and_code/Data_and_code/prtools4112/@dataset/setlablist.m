%SETLABLIST Set names of classes or targets
%
%    A = SETLABLIST(A,LABLIST)
%
% LABLIST should be a column vector of C elements (integers, characters,
% or strings), in which C is the number of classes or targets of A.
% In case of multiple label lists this resets the current label list.
%
%    A = SETLABLIST(A)
%
% Remove entries in the lablist of A to which no objects are assigned,
% i.e. remove empty classes. This command also removes duplicates in the
% lablist. An example of the merge of two classes in a 3-class dataset X
% with class names 'A', 'B' and 'C' can be realized by
%   X = setlablist(X,char('A','B','A'));
%   X = setlablist(X);
%
% SEE ALSO MULTI_LABELING

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: setlablist.m,v 1.10 2007/01/16 16:10:12 duin Exp $

function a = setlablist(a,lablist)

		prtrace(mfilename,2);

  if nargin > 1 & iscell(lablist)
		lablist = char(lablist);
	end

	[a,curn] = addlablist(a);    % set up multi-labels if needed and get current lablist
	c = getsize(a,3);

	if nargin < 2 & islabtype(a,'crisp') 
								% no lablist, so remove empty classes
		if isempty(a), return; end
		a = setlabels(a,getlabels(a));
		J = classsizes(a);
		N = find(J~=0);
		cc = length(N);
		lablista = a.lablist{curn,1};
		
		%PJ in a case max(a.nlab)=1 and cc =1 e.g. [10 0 0 0]
		if cc ~= c
			n = 0;
			for j = N
				n = n+1;
				L = find(a.nlab(:,curn)==j);
				a.nlab(L,curn) = repmat(n,length(L),1);
			end
			lablista = lablista(N,:);			
			if ~isempty(a.prior)
				priora = a.prior(N);
				priora = priora/sum(priora);
				a.prior = priora;
			end
		end
		
	elseif nargin < 2 & islabtype(a,'targets','soft')
		;  % don't do a thing, any label (i.e. target column) might be relevant
		return; %DXD
	else
		cc = size(lablist,1);
		%maxnlab = max(a.nlab(:,curn));
		%if cc < maxnlab
		%	error(['The label list should have at least ' num2str(maxnlab) ' elements'])
    %end
		lablista = lablist;

	end
	
	if (islabtype(a,'crisp','soft') & (cc > length(a.prior)))
		if ~isempty(a.prior)
			a.prior = [];
			prwarning(10,'Prior field of dataset reset to default')
		end
		if ~isempty(a.cost)
			a.cost = [];
			prwarning(10,'Cost field of dataset reset to default')
		end
	end

	a.lablist{curn,1} = lablista;
	a.lablist{curn,2} = a.prior;
	a.lablist{curn,3} = a.cost;
	
return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/setlablist.m
 fn: setlablist -------------
