%PROXM Proximity mapping
% 
%  W = PROXM(A,TYPE,P,WEIGHTS)
%  W = A*PROXM([],TYPE,P,WEIGHTS)
% 
% INPUT
%  A       Dataset
%  TYPE    Type of the proximity (optional; default: 'distance')
%  P       Parameter of the proximity (optional; default: 1)
%  WEIGHTS Weights (optional; default: all 1)
%
% OUTPUT
%  W       Proximity mapping
%
% DESCRIPTION  
% Computation of the [K x M] proximity mapping (or kernel) defined by 
% the [M x K] dataset A. Unlabeled objects in A are neglected.
% If B is an [N x K] dataset, then D=B*W is the [N x M] proximity matrix
% between B and A. The proximities can be defined by the following types: 
% 
%
%  Kernel (similarity) mappings
%  -----------------------------------
%  'homogeneous'  | 'h': SIGN(A*B').*(A*B').^P
% 	'polynomial'   | 'p': SIGN(A*B'+1).*(A*B'+1).^P
% 	'exponential'  | 'e': EXP(-(||A-B||)/P)
% 	'radial_basis' | 'r': EXP(-(||A-B||.^2)/(P*P))
% 	'sigmoid'      | 's': SIGM((SIGN(A*B').*(A*B'))/P)
%
%  Kernel normalization
%  -------------------
%  If 'n' is added to the type, kernel normalization is performed.
%  k(x,y) = k(x,y) ./ sqrt(k(x,x) * k(y,y));
%
%  Distance (dissimilarity) mappings
%  -----------------
% 	'distance'     | 'd': ||A-B||.^P
% 	'minkowski'    | 'm': SUM(|A-B|^P).^(1/P)
% 	'city-block'   | 'c': SUM(|A-B|)
%  'cosine'       | 'o': 1 - (A*B')/||A||*||B||
% 
% In the polynomial case for a non-integer P, the proximity is computed 
% as D = SIGN(S+1).*ABS(S+1).^P, in order to avoid problems with negative
% inner products S = A*B'. The features of the objects in A and B may be 
% weighted by the weights in the vector WEIGHTS.
% 
% SEE ALSO
% MAPPINGS, DATASETS

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: proxm.m,v 1.12 2005/02/01 16:10:53 duin Exp $


function W = proxm(A,type,s,weights)

	prtrace(mfilename);
	
	if (nargin < 4)
		weights = [];
		prwarning(4,'Weights are not supplied, assuming all 1.');
	end

	if (nargin < 3) | (isempty(s))
      s = 1;
      prwarning(4,'The proximity parameter is not supplied, assuming 1.');
   end

	if (nargin < 2) | (isempty(type))
      type = 'd';
      prwarning(4,'Type of the proximity is not supplied, assuming ''DISTANCE''.');
   end

	% No data, return an untrained mapping.
	if (nargin < 1) | (isempty(A))
		W = mapping(mfilename,{type,s,weights});
		W = setname(W,'Proximity mapping');
		return;
	end

	[m,k] = size(A);
  
	if (isstr(type))
		% Definition of the mapping, just store parameters.

		all = char('polynomial','polynomialn','p','pn','exponential','exponentialn', ...
                 'e','en','radial_basis','radial_basisn','r', 'rn','sigmoid','sigmoidn', ...
                 's','sn','distance','d','minkowski','m','city-block','c','cosine','o', ...
                 'homogeneous','h','homogeneousn','hn');
		if (~any(strcmp(cellstr(all),type)))
			error(['Unknown proximity type: ' type])
		end
		A = cdats(A,1);
		[m,k] = size(A);
		if (isa(A,'dataset'))
			W = mapping(mfilename,'trained',{A,type,s,weights},getlab(A), ...
                            getfeatsize(A),getobjsize(A));
		else
			W = mapping(mfilename,'trained',{A,type,s,weights},[],k,m);
		end
		W = setname(W,'Proximity mapping');
										   
	elseif isa(type,'mapping')   

		% Execution of the mapping: compute a proximity matrix
		% between the input data A and B; output stored in W.
		w = type
		[B,type,s,weights] = deal(w.data{1},w.data{2},w.data{3},w.data{4});
		[kk,n] = size(w);
		if (k ~= kk)
			error('Mismatch in sizes between the mapping and its data stored internally.'); 
		end
		if (~isempty(weights))		
			if (length(weights) ~= k), 
				error('Weight vector has a wrong length.'); 
			end
			A = A.*(ones(m,1)*weights(:)');
			B = B.*(ones(n,1)*weights(:)');
		end
		
		switch type
			case {'polynomial','p','polynomialn','pn'}
				D = +(A*B');

				D = D + ones(m,n);
				if (s ~= round(s))
					D = sign(D).*abs(D).^s;
				elseif (s ~= 1)
					D = D.^s;
				end
            if(type(end) == 'n')  %perform kernel normalization?
               lA = sum(A.*A,2) + 1;
               lB = sum(B.*B,2) + 1;
               s = 0.5 * s;  %perform square root simultaneously
               if(s ~= 1)
                  lA = lA.^s;
                  lB = lB.^s;
               end;
               D = D ./ (lA * lB');
            end;
	
			case {'homogeneous','h','homogeneousn','hn'}
				D = +(A*B');
				lA = sqrt(sum(A.*A,2));
				lB = sqrt(sum(B.*B,2));

				if (s ~= round(s))
					D = sign(D).*abs(D).^s;
				elseif (s ~= 1)
					D = D.^s;
				end
            if(type(end) == 'n')  %perform kernel normalization?
               lA = sum(A.*A,2);
               lB = sum(B.*B,2);
               s = 0.5 * s;  %perform square root simultaneously
               if(s ~= 1)
                  lA = lA.^s;
                  lB = lB.^s;
               end;
               D = D ./ (lA * lB');
            end;
	
			case {'sigmoid','s','sigmoidn','sn'}
				D = +(A*B'); 
				D = sigm(D/s);

            if(type(end) == 'n')  %perform kernel normalization?
               lA = sqrt(sigm(sum(A.*A,2)/s));
               lB = sqrt(sigm(sum(B.*B,2)/s));
               D = D ./ (lA * lB');
            end;
		
		
			case {'exponential','e','exponentialn','en'}
				%normalized kernel is same as non-normalized kernel
            D = dist2(B,A);
				D = exp(-sqrt(D)/s);
		
			case {'radial_basis','r','radial_basisn','rn'}
				%normalized kernel is same as non-normalized kernel
				D = dist2(B,A);
				D = exp(-D/(s*s));

         case {'city-block','c'}
				D = zeros(m,n);
				for j=1:n
				D(:,j) = sum(abs(A - repmat(+B(j,:),m,1)),2);
			end
		
			case {'minkowski','m'}
				D = zeros(m,n);
				for j=1:n
	   			D(:,j) = sum(abs(A - repmat(+B(j,:),m,1)).^s,2).^(1/s);
   			end
		
			case {'distance','d'}
				D = dist2(B,A);
				if s ~= 2
					D = sqrt(D).^s;
				end
                
			case {'cosine','o'}
				D = +(A*B'); 
				lA = sqrt(sum(A.*A,2));
				lB = sqrt(sum(B.*B,2));
				D = 1 - D./(lA*lB');
                
			otherwise
				error('Unknown proximity type')
		end
		W = setdat(A,D,w);	
		
	else
		error('Illegal TYPE argument.')
	end

return;



function D = dist2(B,A)
% Computes square Euclidean distance, avoiding large matrices for a high 
% dimensionality data
	m = size(A,1);
	n = size(B,1);
	D = ones(m,1)*sum(B'.*B',1); 
	D = D + sum(A'.*A',1)'*ones(1,n); 
	D = D - 2 .* (+A)*(+B)';
	% Clean result.
	J = find(D<0);
	D(J) = zeros(size(J));
return
