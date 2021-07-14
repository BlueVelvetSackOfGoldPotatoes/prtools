%MCLASSDC Multi-class dissimilarity based classifier from 2-class discriminants
%
%  W = MCLASSDC(A,CLASSF,MODE)
%
% INPUT
%   A       Dissimilarity based dataset
%   CLASSF  Untrained dissimilarity based classifier
%   MODE    Type of handling multi-class problems (optional; default: 'single')
%
% OUTPUT
%   W       Combined classifier
%
% DESCRIPTION
% For default MODE = 'single', the untrained classifier CLASSF is called to
% compute C classifiers between each of the C classes in the dataset A and
% the remaining C-1 classes. The result is stored into the combined
% classifier W. There is no combining rule added. The default rule, MAXC
% might be replaced by adding one, e.g. W = W*MEANC.
%
% For MODE = 'multi' the untrained classifier CLASSF is trained between all
% pairs of classes as well as between each class and all other classes.
% This total set of C^2 classes is combined by MINC.  The use of soft labels
% is supported.
% The pair-wise classifiers are trained using a representation set based
% on the traing objects of the corresponding classes only (just in case of
% crisp labels). This is the only difference with the use of MCLASSC. 
%
% EXAMPLES
% W = MCLASSDC(DISTM(GENDATM(100)),QDC,'MULTI');
%
% SEE ALSO
% DATASETS, MAPPINGS, MAXC, MINC.

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: mclassdc.m,v 1.2 2004/08/06 14:34:34 duin Exp $

function varargout = mclassc(a,classf,mode);
	prtrace(mfilename);
	if nargin < 3, mode = 'single'; end
	if nargin < 2, classf = []; end
	if nargin < 1 | isempty(a)
		w = mapping(mfilename,{classf,mode});
		return
	end
	
	if ~isa(classf,'mapping') | ~isuntrained(classf)
		error('Second parameter should be untrained mapping')
	end

	islabtype(a,'crisp','soft');
	isvaldset(a,1,2); % at least 1 object per class, 2 classes

	[m,k,c] = getsize(a);
	
	varout = {};
	if c == 2
		varargout = map(a,classf);
		return
	end

	lablist = getlablist(a);

	switch mode

	 case 'single'
	  w = [];
	  %	lablist = getlablist(a);
	  for i=1:c
		  if islabtype(a,'crisp')
			  mlab = 2 - (getnlab(a) == i);
			  aa = setlabels(a,mlab);
		  elseif islabtype(a,'soft')
			  atargets = gettargets(a);
			  targets = [atargets(:,i) 1-atargets(:,i)]; %assumes soft labels sum to one???
			  aa = dataset(+a,mlab,targets,'lablist',[1 2]');
		  end
			if nargout(classf.mapping_file) > 1
		 	 	[v,varo] = map(aa,classf);
				varout = [varout {varo}];
			else
				v = map(aa,classf);
			end
			w = [w,setlabels(v(:,1),lablist(i,:))];
	  end

	 case 'multi'
	  w = [];

	  nlab = getnlab(a);
		[nl,clab,list] = renumlab(getlablist(a),getfeatlab(a));
	  for i1=1:c
		  lab = lablist(i1,:);
		  
		  J1 = find(nlab==i1);
		  L1 = find(clab==i1);
		  if islabtype(a,'crisp')
			  mlab = ones(m,1);
			  mlab(J1) = zeros(length(J1),1);
			  aa = setlabels(a,mlab);
		  else
			  problab = gettargets(a);
			  mlab = [problab(:,i1) sum(problab,2)-problab(:,i1)];
			  aa = settargets(a,mlab,[1 2]');
		  end		
		  I1 = [1:c]; I1(i1) = [];
			if nargout(classf.mapping_file) > 1
		 	 	[v,varo] = map(aa,classf);
				varout = [varout {varo}];
			else
				v = map(aa,classf);
			end
			w = [w,setlabels(v(:,1),lab)];

		  for i2 = I1 
			  if islabtype(a,'crisp')
				  J2 = find(nlab==i2);
				  L2 = find(clab==i2);
				  v = featsel(k,[L1;L2])*(aa([J1;J2],[L1;L2])*classf);
					disp([i1,i2])
					parsc(v)
			  else
				  mlab2 = problab(:,[i1 i2]);
				  v = setlabels(aa,mlab2)*classf;
			  end
			  w = [w,setlabels(v(:,1),lab)];
		  end
	  end
	  w = minc(w);

	 otherwise
	  error('Unknown mode')
	end

	w = setname(w,getname(classf));
	w = setsize(w,[k,c]);
	w = setcost(w,a);

	varargout = {w varout};

	return
