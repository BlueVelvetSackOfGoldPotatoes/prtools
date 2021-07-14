%PAMC - Prediction analysis for microarrays (shrunken nearest mean) classifier
%
%   [W,DELTA,THETA,NZ,CVE,CVNZ] = PAMC(A,DELTA,THETA,CV)
%
% INPUT
%   A		   Training dataset
%   DELTA  Array of thresholds for d-statistic (default: 0, no shrinkage)
%   THETA  Array of per-class scaling factors (default: [], adaptive by PAMT)
%   CV     Number of crossvalidations for determining DELTA and THETA (def: 10)
% 
% OUTPUT
%   W      PAM classifier
%   DELTA  Threshold actually used
%   THETA  Array of per-class scaling factors actually used
%   NZ     Indices of nonzero genes
%   CVE    Cross-validation error, per threshold tested
%   CVNZ   Indices of nonzero genes, per threshold tested
% 
% DESCRIPTION
% Trains a scaled nearest mean classifier, based on d-statistics, in which all
% distances smaller than DELTA are set to 0. If the scaling factors THETA are 
% not given, they are optimised using PAMT.
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
% PAMT, PAM_MAP, DSTATS, SAM

% (c) Dick de Ridder, 2003
% Information & Communication Theory Group
% Faculty of Electrical Engineering, Mathematics and Computer Science
% Delft University of Technology, Mekelweg 4, 2628 CD Delft, The Netherlands

function [w,odelta,theta,nz,cv_e,cv_nz] = pamc(a,delta,theta,cv,plotit)

	prtrace(mfilename);
	
	if (nargin < 5), plotit = 0; end;
	if (nargin < 4), cv    = 10; end;
	if (nargin < 3), theta = []; end;
	if (nargin < 2), delta = 0;  end;

	if (nargin < 1) | (isempty(a))
		w = mapping(mfilename,{delta,theta,cv});
    w = setname(w,'PAM');
    return;
  end;

	% If an array of delta's is given, find the optimal one.

	if (length(delta) > 1)

		prwarning(10,'Cross-validating to find optimal threshold DELTA');
		delta = sort(delta);
		for di = 1:length(delta)
			fprintf (1,'D = %2.2f ',delta(di));
			cv_e(di) = acrossval(a,pamc([],delta(di),theta,cv),cv,1);
			if (plotit)
				[tw,tdelta,ttheta,nz] = pamc(a,delta(di));
				tr_nz(di) = length(nz);
				tr_e(di)  = testc(a*tw);
			end;
		end;	

		% Find maximum delta that gives minimal error.
		mine = min(cv_e); mme = find(cv_e==mine); mme = mme(end);
		
		odelta = delta(mme); 		

	else

		odelta = delta;
		cv_e	 = [];

	end;

	% Extract classes.

  [n_arrays,n_genes,n_classes] = getsize(a); 
	[nlab,nlablist] = getnlab(a); pi = getprior(a); 
	mna = mean(a); 

  for c = 1:n_classes
    ind{c}    = find(nlab==nlablist(c));
    n(c)      = length(ind{c});
    m(c)      = sqrt((1/n(c))+(1/n_arrays));
  end;

	% Calculate original statistics.

	[d,r,s] = dstats(a); s0 = median(s); 
	d = r ./ (ones(n_classes,1)*(s+s0));

	% Scale by theta.
	
	if (isempty(theta))
		prwarning(10,'Calculating optimal scaling factors THETA');
		theta = pamt(a,odelta,cv);
	end;

	if (max(size(theta))==1), theta = ones(c,1)*theta; end;
	d = d ./ (theta * ones(1,n_genes));

	% Return array of non-zero genes.
		
	for di = 1:length(delta)
	  dn = sign(d) .* max((abs(d) - delta(di)),0);
	  cv_nz{di} = find(max(abs(dn))>0);
	end;	

  % Soft threshold.

  dn = sign(d) .* max((abs(d) - odelta),0);
  nz = find(max(abs(dn))>0);

	% Calculate centroids.

	for c = 1:n_classes
		centroid(c,:) = mna + m(c).*(s+s0).*dn(c,:);
	end;

	if (plotit)
		if (length(delta)>1)
			figure; clf;
			subplot(2,1,1);
			plot(delta,tr_e,'bo-'); hold on;
			plot(delta,cv_e,'r*-'); hold on;
			legend('Training error','CV error');
			ylabel('Error'); title ('PAM');
			subplot(2,1,2);
			plot(delta,tr_nz,'ks-'); hold on;
			xlabel('\Delta'); ylabel('Number of genes');
		end;
		figure; clf;
		for c = 1:n_classes
			subplot(1,n_classes,c);
			h1 = barh(1:length(mna),mna,1,'y'); hold on; 
			h2 = barh(nz,centroid(c,nz),1,'r'); 
			set(h1,'EdgeColor',[0.7 0.7 0.7]);
			set(h1,'FaceColor',[0.7 0.7 0.7]); 
			set(h2,'EdgeColor',get(h2,'FaceColor'));
			title(sprintf('Class %d centroid (%d genes)',c,length(nz)));
			if (c==1), ylabel('Gene'); end;
			ax = axis; axis([ax(1) ax(2) 1 length(mna)]);
		end;
	end;

	% Create mapping.

  w = mapping('pam_map','trained',{centroid,s,s0,pi},getlablist(a),n_genes,n_classes);
  w = setname(w,'PAM');

return
