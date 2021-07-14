%SVC_KERNEL Support Vector Classifier for Precomputed kernels
% 
% 	W = SVC_KERNEL(A,C)
%
% INPUT
%   A	    Kernel dataset (i.e. nr of features is equal to nr of objects)
%   C     Regularization parameter (optional; default: 1)
%
% OUTPUT
%   W     Mapping: Support Vector Classifier
%
% DESCRIPTION
% Optimizes a support vector classifier for the kernel A using 
% sequential minimal optimization (SMO).
%
% See also MAPPINGS, DATASETS, PROXM

% Copyright: M.Hulsman, D. de Ridder, D. Tax, R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

function [W] = svc(a,C)
		prtrace(mfilename);
if nargin < 2 | isempty(C)
	C = 1;
	prwarning(3,'Regularization parameter C set to 1\n');
end
if nargin < 1 | isempty(a)
	W = mapping(mfilename,{C});
	W = setname(W,'Support Vector Classifier');
	return;
end

if ~isa(C,'mapping') % training
	
	islabtype(a,'crisp');
	isvaldset(a,1,2); % at least 1 object per class, 2 classes
	[m,k,c] = getsize(a);
	nlab = getnlab(a);
	
	% The SVC is basically a 2-class classifier. More classes are
	% handled by mclassc.
	if c == 2   % two-class classifier
      nlab = getnlab(a);
      K = [(1:length(nlab))' +a];
      model = svmtrain(nlab,K,sprintf('-t 4 -c %d',C));
			% Store the results:
		W = mapping(mfilename,'trained',{model},getlablist(a),k,2);
		%W = cnormc(W,a);
		W = setname(W,'Support Vector Classifier');
		W = setcost(W,a);
	else   % multi-class classifier:
		[W,J] = mclassc(a,mapping(mfilename,{type,par,C}));
	end

else % execution
	w = +C;
	[m,n] = size(a);
   K = [n+(1:m)' +a];
%DR   [cl,ac,pe] = svmpredict(getnlab(a),K,w{1});
   [cl,ac,pe] = svmpredict(getnlab(a),K,w);

	% Data is mapped by the kernel, now we just have a linear
	% classifier  w*x+b:

   d = sigm([pe -pe]);
	W = setdat(a,d);
   W.featlab = getlablist(a);
	
end
	
return;
