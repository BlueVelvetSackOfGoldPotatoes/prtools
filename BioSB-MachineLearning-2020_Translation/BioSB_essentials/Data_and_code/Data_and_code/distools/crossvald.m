%CROSSVALD Cross validation error assuming dissimilarity
%representation
% 
%   [ERR,STD_ERR] = CROSSVAL(DATA,CLASSF,N,K,ITER,FID)
%   [ERR,CERR,NLAB_OUT] = CROSSVAL(DATA,CLASSF,N,K,1,FID)
%
% INPUT
%   A          Input dataset
%   CLASSF     The untrained classifier to be tested.
%   N          Number of dataset divisions (default: N==number of
%              samples, leave-one-out)
%   K          Desired size of the representation set (default: use all)
%   ITER       Number of iterations
%   FID        File descriptor for progress report file (default: 0)
%
% OUTPUT
%   ERR        Average test error weighted by class priors.
%   CERR       Unweighted test errors per class
%   STD_ERR    Standard deviation in the error
%   NLAB_OUT   Assigned numeric labels
%
% DESCRIPTION
% Cross validation estimation of the error and the instability of the
% untrained classifier CLASSF using the dataset A. The set is randomly
% permutated and divided in N (almost) equally sized parts. The classifier
% is trained on N-1 parts and the remaining part is used for testing.  This
% is rotated over all parts. ERR is their weighted avarage over the class
% priors. CERR are the class error frequencies.  A and/or CLASSF may be
% cell arrays of datasets and classifiers. In that case ERR is an array
% with errors with on position ERR(i,j) the error of classifier j for
% dataset i. In this mode CERR and NLAB_OUT are returned in cell arrays.
%
% If ITER > 1 the routine is run ITER times and results are averaged. The
% standard deviation of the error is returned in STD_ERR.
%
% This version assumes that A is a square dissimilarity matrix for which the
% representation set has to be reduced to a subset of size K out of the training
% set. This is done by random selection. If K is not set the entire training set
% is used. 
% 
% Progress is reported in file FID, default FID=0: no report.  Use FID=1
% for report in the command window
% 
% See also DATASETS, MAPPINGS, TESTC

% Copyright: D.M.J. Tax, R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands


function [err,cerr,nlabout] = crossvald(data,classf,n,kred,iter,fid)

	prtrace(mfilename);

	if nargin < 6, fid = []; end
	if nargin < 5, iter = 1; end
	if nargin < 4, kred = []; end
	if nargin < 3, n = []; end

	if iter ~= 1
		eer = cell(1,iter);
		for j = 1:iter
			eer{j} = feval(mfilename,data,classf,n,kred,1,fid);
		end
		fe = zeros(size(eer{1},1),size(eer{1},2),iter);
		for j=1:iter
			fe(:,:,j) = eer{j};
		end
		err = mean(fe,3);
		std_err = std(fe,[],3);
		cerr = std_err;
		return
	end
	
			
			% datasets or classifiers are cell arrays
	if iscell(classf) | iscell(data)

		seed = rand('state');
		if ~iscell(classf), classf = {classf}; end
		if ~iscell(data), data = {data}; end
		if isdataset(classf{1}) & ismapping(data{1}) % correct for old order
			dd = data; data = classf; classf = dd;
		end
		numc = length(classf);
		numd = length(data);
		cerr = cell(numd,numc);
		nlab_out = cell(numd,numc);

		prprogress(fid,['\n%i-fold crossvalidation: ' ...
			     '%i classifiers, %i datasets\n'],n,numc,numd);

		e = zeros(numd,numc);

		for jc = 1:numc

			prprogress(fid,'  %s\n',getname(classf{jc}));
			for jd = 1:numd

				prprogress(fid,'    %s',getname(data{jd}));

				rand('state',seed);
				[ee,cc,nn] = feval(mfilename,data{jd},classf{jc},n,kred,1,fid);
				e(jd,jc) = ee;
				cerr(jd,jc) = {cc};
				nlabout(jd,jc) = {nn};

			end
			%fprintf(fid,'\n');

		end
		if nargout == 0
			fprintf('\n  %i-fold cross validation result for',n);
			disperror(data,classf,e);
		else
			err = e;
		end

	else

		if isdataset(classf) & ismapping(data) % correct for old order
			dd = data; data = classf; classf = dd;
		end
		isdataset(data);
		ismapping(classf); 	
		[m,k,c] = getsize(data);
		lab = getlab(data);
		if isempty(n), n = m; end

		if n > m
			warning('Number of batches too large: reset to leave-one-out')
			n = m;
		elseif n <= 1
			error('Wrong size for number of batches')
		end
		if ~isuntrained(classf)
			error('Classifier should be untrained')
		end
		J = randperm(m);
		N = classsizes(data);

		% attempt to find an more equal distribution over the classes
		if all(N > n)

			K = zeros(1,m);

			for i = 1:length(N)

				L = findnlab(data(J,:),i);

				M = mod(0:N(i)-1,n)+1;

				K(L) = M;

			end

		else
            
			K = mod(1:m,n)+1;

		end
        
		nlabout = zeros(m,1);
		rstate2 = rand('state');
        prprogress(fid,'%5.0f      ',n);
		for i = 1:n
			OUT = find(K==i);
			JOUT=J(OUT);
			JIN = J; JIN(OUT) = [];
			if ~isempty(kred)
				if length(JIN) < kred
					error('Training set too small for desired size representation set')
				end
				rstate1 = rand('state');
				rand('state',rstate2);
				RED = randperm(length(JIN));
				rstate2 = rand('state');
				rand('state',rstate1);
				RED = RED(1:kred); %here we reduce the rep set but dont take care of an equal distr over classes
				JINF = JIN(RED);
				JINR = JINF;
			else
				JINF = JIN;
			end
			if (iscell(classf.data) & length(classf.data) > 0 ...
					& isparallel(classf.data{1}))
				m = size(data,1);
				k = size(data,2)/m;
				if (k ~= floor(k))
					error('Dataset should be a concatenation of square matrices')
				end
				JINF = repmat(JINF(:),1,k) + repmat([0:k-1]*m,kred,1);
				JINF = JINF(:);
			end
			dlearn = data(JIN,JINF); %
			dtest  = data(JOUT,JINF);
			w = dlearn*classf; % training
			                        % testing
			[mx,nlabout(JOUT)] = max(+(dtest*w),[],2);
                              % nlabout contains class assignments
            s = sprintf('\b\b\b\b\b%5.0f',i);
			prprogress(fid,s);
		end
        prprogress(fid,'\b\b\b\b\b\b\b\b\b\b\b',n);
        L = matchlablist(getlablist(data),getlabels(w));
        
		for j=1:c
			J = findnlab(data,j);
			f(j) = sum(nlabout(J)~=j)/length(J);
		end
		e = f*getprior(data)';
		if nargout > 0
			err  = e;
			cerr = f;
		else
			disp([num2str(n) '-fold cross validation error on ' num2str(size(data,1)) ' objects: ' num2str(e)])
		end

	end

	return
