%ACROSSVAL Cross validation, classifier error and stability
% 
%   [ERR,CERR] = ACROSSVAL(DATA,CLASSF,N,FID)
%
% INPUT
%   A          Input dataset
%   CLASSF     The untrained classifier to be tested.
%   N          Number of dataset divisions (default: N==number of
%              samples, leave-one-out)
%   FID        File descriptor for progress report file (default: 0)
%
% OUTPUT
%   ERR        Average test error weighted by class frequencies.
%   CERR       Unweighted test errors per class
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
% dataset i. In this case CERR is not returned.
% 
% Progress is reported in file FID, default FID=0: no report.  Use FID=1
% for report in the command window
% 
% See also DATASETS, MAPPINGS, TESTC

% Copyright: D.M.J. Tax, R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: crossval.m,v 1.4 2003/10/19 14:41:59 bob Exp $

function [err,cerr] = acrossval(data,classf,n,fid)

	prtrace(mfilename);

	if nargin < 4, fid = 0; end
	if nargin < 3, n = []; end

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


		fprintf(fid,['\n%i-fold crossvalidation: ' ...
			     '%i classifiers, %i datasets\n'],n,numc,numd);

		e = zeros(numd,numc);

		for jc = 1:numc

			fprintf(fid,'  %s\n',getname(classf{jc}));
			for jd = 1:numd

				fprintf(fid,'    %s',getname(data{jd}));

				rand('state',seed);
				e(jd,jc) = feval(mfilename,data{jd},classf{jc},n,fid);

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
		elseif n < 1
			error('Wrong size for number of batches')
		end
		if ~isuntrained(classf)
			error('Classifier should be untrained')
		end
		J = randperm(m);
		lab1 = data*(data*classf)*classd;

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
%n
%K
thiserr = zeros(1,n);
		for i = 1:n
			OUT = find(K==i);
			JOUT=J(OUT);
			JIN = J; JIN(OUT) = [];
%JIN
%JOUT
			w = data(JIN,:)*classf;

			[mx,nlabout(JOUT)] = max(+(data(JOUT,:)*w),[],2);
			fprintf(fid,'.');
		end
		fprintf(fid,'\n');
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