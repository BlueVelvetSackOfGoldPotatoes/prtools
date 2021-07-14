%PAMT - Find adaptive threshold for prediction analysis for PAMC
%
%   THETA = PAMT(A,DELTA,CV)
%
% INPUT
%   A		   Training dataset
%   DELTA  Array of thresholds for d-statistic (default: 0)
%   CV     Number of cross-validations (default: 10)
% 
% OUTPUT
%   THETA  Array of per-class scaling factors
%
% DESCRIPTION
% Finds optimal adaptive thresholds THETA for PAMC, averaged over the grid
% of DELTA values used as threshold.
%
% REFERENCES
% [1] Tibshirani, R., Hastie, T., Narasimhan, B. and Chu, G., "Diagnosis of
%     multiple cancer types by shrunken centroids of gene expression", PNAS 99,
%     pp. 6567-6572, 2002.
% [2] Tusher, V., Tibshirani, R. and Chu, G., "Significance analysis of
%     microarrays applied to the ionizing radiation response", PNAS 98,
%     pp. 5116-5124, 2001.
%
% SEE ALSO
% PAMC, DSTATS, SAM

% (c) Dick de Ridder, 2003
% Information & Communication Theory Group
% Faculty of Electrical Engineering, Mathematics and Computer Science
% Delft University of Technology, Mekelweg 4, 2628 CD Delft, The Netherlands

function theta = pamt(a,delta,cv)

	prtrace(mfilename);

	if (nargin < 3)
		prwarning(4,'number of crossvalidations not given, assuming 10');
		cv = 10; 
	end;
	if (nargin < 2)
		prwarning(4,'array of thresholds DELTA not given, assuming 0');
		delta = 0;  
	end;

	if (nargin < 1) | (isempty(a))
		error('require a dataset');
  end;

	[n_arrays,n_genes,n_classes] = getsize(a);
	theta = ones(n_classes,1);

	for i = 1:10
		th{i} = theta;
		for di = 1:length(delta)
%			[e(di,i),ce] = acrossval(a,pamc([],delta(di),theta),cv);
			w = pamc(a,delta(di),theta,cv);
			[e(di,i),ce] = testc(a,w);
		end;
		[dummy,ind] = max(mean(ce));
		theta(ind) = 0.9 * theta(ind); theta = theta ./ min(theta);
	end;

	[dummy,ind] = min(mean(e')); 
	theta = th{ind};

return

