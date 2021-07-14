%PAM_MAP - Prediction analysis for microarrays (shrunken nearest mean) 
%
%   F = PAM_MAP(A,W)
%
% INPUT
%   A      Dataset
%   W      Trained PAMC classifier
%
% OUTPUT
%   F      Posterior probabilities
%
% DESCRIPTION
% Applies a nearest mean classifier, based on d-statistics, in which all
% distances smaller than a certain DELTA are set to 0 (see PAMC).
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

function F = pam_map(a,w)

	prtrace(mfilename);

	% Extract mapping parameters.

	data = getdata(w); 
	centroid = data{1}; s = data{2}; s0 = data{3}; pi = data{4};
  [n_arrays,n_genes] = size(a); n_classes = size(centroid,1);

	% Calculate distance D to centroids and posterior probabilities PP.

	D = zeros(n_arrays,n_classes);
  for c = 1:n_classes
		D(:,c) = sum(((+a-repmat(+centroid(c,:),n_arrays,1)).^2) ./ ...
								repmat(((s+s0).^2),n_arrays,1),2) - 2*log(pi(c));
  end;

	% Just to protect against underflow... #(!)(*&$%)!#(&%!$)@*!

	D = D ./ n_genes;

  pp = exp(-0.5*D) ./ (sum(exp(-0.5*D),2)*ones(1,c) + realmin);

	% Enter posterior probabilities into dataset.

	if (~isdataset(a)), a = dataset(a); end;
	F = setdata(a,pp,getlabels(w));

return


