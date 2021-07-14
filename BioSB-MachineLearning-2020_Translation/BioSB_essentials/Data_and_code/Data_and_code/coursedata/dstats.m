%TSTATS - Compute D-statistics
%
%   D = DSTATS(A)
%
% INPUT
%   A   A two-class dataset
%
% OUTPUT
%   D   D-statistics of the features in A
%
% DESCRIPTION
% Calculates D-statistics as used in PAM.
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
% PAM, SAM

% (c) Dick de Ridder, 2003
% Information & Communication Theory Group
% Faculty of Electrical Engineering, Mathematics and Computer Science
% Delft University of Technology, Mekelweg 4, 2628 CD Delft, The Netherlands

function [dval,r,s] = dstats (a)

	% Check input.

	if (~isdataset(a))
		error ('input should be a dataset');
	end;

	[n_arrays,n_genes,n_classes] = getsize(a);

	nlab = getnlab(a); nlablist = unique(nlab);

	for c = 1:n_classes
		ind{c} = find(nlab==nlablist(c));
		n(c)   = length(ind{c});
	end;
	
	if (any(n<1))
		error ('need at least one sample per class');
	end;

	% Calculate two-tailed D-statistics.

	mna = mean(+a);

	s2 = zeros(1,n_genes);
	for c = 1:n_classes
		m(c)      = sqrt((1/n(c))+(1/n_arrays));
		if (n(c)>1)
			mnac(c,:) = mean(+a(ind{c},:));
		else
			mnac(c,:) = +a(ind{c},:);
		end;
		s2        = s2 + sum((+a(ind{c},:)-ones(n(c),1)*mnac(c,:)).^2);
	end;
	s = sqrt(s2 ./ (n_arrays-n_classes));

	for c = 1:n_classes
		r(c,:)    = (mnac(c,:) - mna) ./ m(c);
		dval(c,:) = r(c,:) ./ s;
	end;

return
