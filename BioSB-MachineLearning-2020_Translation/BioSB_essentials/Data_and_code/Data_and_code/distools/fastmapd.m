%FASTMAPD   FastMap (linear map of Euclidean distances)
%
%  W = fastmapd(D,K)
%
% An implementation of the FastMap algorithm. D is assumed to be a square 
% Euclidean distance matrix and K is the desired dimensionality of the 
% projection. However, if the dimensionality k of the original data is
% smaller than K, then only a mapping to a k-dimensional space is returned.
%
% This procedure might behave badly  for non-Euclidean distances.
%
% SEE
% Faloutsos, C. and Lin, K.-I., 'FastMap: A Fast Algorithm for Indexing, Data-Mining 
% and Visualization of Tradditional and Multimedia Datasets', Proc. ACM SIGMOD, 
% International Conference on Management of Data, 163-174, California, 1995.
%

function [W,P] = fastmapd(D,K)

if nargin < 2, K = 1; end
if nargin < 1 | isempty(D)
   W = mapping(mfilename,K); 
   W = setname(W,'Fastmapd');
   return
end


if (isdataset(D) | isa(D,'double')) 
  if ismapping(K),
    pars  = getdata(K);
    P    = pars{1};
    dd   = pars{2}; 
    X    = pars{3}; 
    K    = pars{4}; 

		nlab2   = getnlab(D);
		[nr,nc] = size(D);
    D       = +D.^2;
    if all(diag(D) == 0) & issym(D),
      Y = X;
    else
      for k=1:K
        Y(:,k) = (D(:,P(k,1)) + dd(k)*ones(nr,1) - D(:,P(k,2)))./(2*sqrt(dd(k)));
        D      = (D - distm(Y(:,k),X(:,k)));
      end
    end
    W = dataset(Y,nlab2);
    return
  end
end




% Training the mapping

if isdataset(D) 
	nlab = getnlab(D);
end
[nr,nc] = size(D);

if nr ~= nc,
  error('A square dissimilarity matrix is expected.')
end

D = +D.^2;
if any(diag(D) ~= 0),
  error('The diagonal should be zero.')
end

k      = 0;     % current dimensionality
Z      = 1:nr;  % index of points
thr    = 1e-11; % threshold to stop, when the distances become close to zero 
finito = 0;
noneuclid = 0;
while ~finito,
  k = k+1;
  [mm,O] = max((D(Z,Z)),[],2);
  [mm,i] = max(mm);
 	P(k,1) = Z(O(i));		%      P is the index of pivots
  P(k,2) = Z(i);
  Z([O(i) i]) = [];
	dd(k)  = D(P(k,1),P(k,2));

	if ~noneuclid,
		noneuclid = noneuclid | any(D(:) < -thr);
		if noneuclid,
			KKe = k-1;
		end 
	end

  if dd(k) >= thr,
    X(:,k) = (D(:,P(k,1)) + dd(k)*ones(nr,1) - D(:,P(k,2)))./(2*sqrt(dd(k)));
    D      = (D - distm(X(:,k)));    
	else
		P(k,:) = [];
	end

  finito = (k >= K) | (dd(k) <= thr); 
end
KK = k-1;


if noneuclid,
  disp('NOTE: the distances are not Euclidean.');
	disp(['The mapping is done to ' num2str(KK) 'D, but the Euclidean part of the distances is explained in ' num2str(KKe) 'D.']);
else
	if KK < K, 
  	disp(['The mapping is done to ' num2str(KK) 'D, since the distances are perfectly explained in ' num2str(KK) 'D.']);
	end
end

W = mapping(mfilename,'trained',{P,dd,X,K},[],nr,K);
W = setname(W,'Fastmapd');
return



