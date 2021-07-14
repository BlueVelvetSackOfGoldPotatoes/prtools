%KNNDC K-Nearest Neighbor Classifier for dissimilarity matrices
%
%	[W,k,e] = knndc(D,k,par,edit,par1,par2,par3)
%	[W,k,e] = D*knndc([],k,par,edit,par1,par2,par3)
%
% Compute k-nearest neigbor classifier for the dissimilarity set D by 
% optimizing k (if on input k = []), the error on D is returned in e.
%
% rows of D    : training objects for optimizing k
% columns of D : representation objects
% 
% par = 'loo' - (default) compute leave-one-out optimization for k
%               it is assumed that the first objects in the training set
%               constitute the representation set.
%       'all' - include all dissimilarities for optimization of k
%               (representation set should not be included in training set)
%
% A dissimilarity set E for a set of test objects defined by the same 
% representation set can now be mapped by C = E*W:
% C        - estimated class confidences
% C*labeld - assigned class labels
% C*testc  - classification error
%
% This routine is mainly intended to be used in consistent sets of
% experiments with other dissimilarity based classifiers, e.g. in
% CROSSVALD. Note that NN errors for dissimilarity data can be directly
% estimated by TESTKD.
%
% If edit = 'org' editting and condensing is done by EDICON_ORG using 
% k = par1 and n = par2. knn is set to 1. This only effects the
% representation set. During testing the reduced representation set is used.
%
% If edit = 'DandK', editting and condensing is done by EDICON using 
% nsets = par1, niters = par2 and ntries = par3. knn is set to 1. This only
% effects the representation set. During testing the reduced representation
% set is used.
%
% SEE ALSO
% DATASETS, MAPPINGS, TESTKD, CROSSVALD, EDICON
%
% $Id: knndc.m,v 1.3 2006/01/01 21:06:11 duin Exp $

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [W,knn,e] = knndc(d,knn,par,edit,par1,par2,par3)

if nargin < 7, par3 = []; end
if nargin < 6, par2 = []; end
if nargin < 5, par1 = []; end
if nargin < 4, edit = ''; end
if nargin < 3 | isempty(par), par = 'loo'; end
if nargin < 2,	knn = []; end

			% empty call, to handle d*knnd, or d*knnd([],par)
			
if nargin < 1 | isempty(d)
	W = mapping(mfilename,'untrained',knn,par);
	W = setname(W,'KNND');
	return
end

nlab     = getnlab(d);
lablist  = getlablist(d);
featlist = getfeat(d);
[m,k,c]  = getsize(d);
p        = getprior(d);

%[nlab,lablist,m,k,c,p,featlist] = dataset(d);
[clab,classlist] = renumlab(featlist);
[cl,nc] = renumlab(classlist,lablist);

if size(nc,1) > c
	error('Object labels do not match representation set')
end
                   % correct for different classlist - lablist orders
J = matchlablist(classlist,lablist);
classlist = lablist;
clab = J(clab);

if ~ismapping(knn)  % training (find knn)
			
	if strcmp(par,'loo')
		% get rid of leave-one-out problems
		km = min(k,m);
		dmax=max(max(+d))*2;
		d(1:km,1:km) = d(1:km,1:km) + dmax*eye(km);
	elseif ~strcmp(par,'all')
		error(['Unknown option ''' par ''''])
	end

	switch edit
		case 'org'
			if isempty(par1) & isempty(par2)
				JJ = edicon_org(d); 
			elseif isempty(par2)
				JJ = edicon_org(d,par1); 
			else
				JJ = edicon_org(d,par,par2); 
			end
			knn = 1;
		case 'DandK'
			JJ = edicon(d,par1,par2,par3);
			knn = 1;
		otherwise
			JJ = [1:k];
	end
	if isempty(knn) % optimize knn
		[Y,L] = sort(+d,2);
		L = clab(L);
		Ymax = zeros(m,k);
		Yc = zeros(m,k);
		for j = 1:c
			Y = double(L == j);
			for n = 2:k
				Y(:,n) = Y(:,n-1) + Y(:,n);
			end
			J = Y > Ymax;
			Ymax(J) = Y(J);
			Yc(J) = j*ones(size(Yc(J)));
		end
		z = sum(Yc == nlab*ones(1,k),1);
		[e,knn]=max(z);
		e = 1 - e/m;
		z = 1 - z/m;
	elseif nargout == 3
		e = testkd(d,knn,par);
	end
	
	W = mapping(mfilename,'trained',{knn,JJ},lablist,k,c);
	W = setname(W,'KNND');
	
else        % testing for given mapping or knn

	w = knn; % mapping stored in knn
  wdata  = getdata(w); 
	knn = wdata{1};
	J = wdata{2};
  classlist = getlab(w);
  c = size(w,2);
  [nn,nf,fl] = renumlab(classlist,lablist);
	if max(nf) > c
		error('Representation set labels do not match with classifier')
	end
	[e,q] = testkd(d(:,J),knn);
	W = q;
	
end
