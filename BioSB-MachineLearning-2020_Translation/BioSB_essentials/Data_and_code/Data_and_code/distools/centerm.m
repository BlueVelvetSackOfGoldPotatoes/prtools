%CENTERM Centering of the similarity matrix S
%
%       [W,sig,L] = centerm(S,alf)
%                 or 
%       [W,sig,L] = centerm(S,n)
%
%  Linear mapping (projection) onto an n-dimensional pseudo-Euclidean 
%  subspace from a symmetric, square similarity matrix S. If alf is given, 
%  the subspace is found such that at least a fraction alf of the total 
%  variance is preserved.  
%
%  alf is a parameter:
%    (0,1)   - fraction of the total (absolute value) preserved variance
%    Inf     - no dimensionality reduction, i.e. keep all dimensions 
%
%  When alf equals to 'p' (or 'n'), the projection is based only on 
%  positive (or negative) eigenvalues, giving the result in an Euclidean 
%  space.    
%
%  The parameter sig describes the signature of the subspace.  
%  L is the sorted list of eigenvalues describing the variances
%  in the (pseudo-)Euclidean space. 
%
%  Once found mapping can be still reduced by:  
%
%       [V,sig,L] = centerm(W,alf)
%                 or 
%       [V,sig,L] = centerm(W,n)
%
%
%  See also 
%  mappings, datasets, pca, goldfarbm
%

% Elzbieta Pekalska, e.pekalska@ewi.tudelft.nl
% Faculty of Electrical Engineering, Mathematics and Computer Science, 
% Delft University of Technology, The Netherlands




function [W,sig,L] = centerm(s,alf,pzero)

if nargin < 3 | isempty(pzero), pzero = 0; end
if nargin < 2 | isempty(alf), alf = inf; end
if nargin < 1 | isempty(s)
   W = mapping(mfilename,alf,pzero); 
   W = setname(W,'centerm');
   return
end



if (isdataset(s) | isa(s,'double')) 
  if ismapping(alf)

%    [w,classlist,map,k,c,vscale,L] = mapping(alf);
    [m,n] = size(s);
    pars  = getdata(alf); 
    
    Q  = pars{1}; 
    me = pars{2};
    p  = pars{3};
    L  = pars{4};

    if p == 0,
			Z = -repmat(1/n,n,n);                 
			Z(1:n+1:end) = Z(1:n+1:end) + 1;     % Z = eye(n) - ones(n,n)/n
      W  = (s - me(ones(m,1),:)) * Z * Q * diag(sqrt(abs(L))./L);          
    else
      W  = -(s(:,p) * ones(1,n) + me(ones(m,1),:) - s) * Q * diag(sqrt(abs(L))./L);          
    end
    return; 
  end
end



if ismapping(s)
  pars  = getdata(s); 
  Q  = pars{1}; 
  L  = pars{4};
  m  = size(Q,1);  

  [ll,K] = sort(-abs(L));
  L = L(K); 
  Q = Q(:,K); 
  [J,sig] = indeigs(L,alf,m);         % J - index of selected eigenvalues

  L = L(J);                           % EIGENVALUES!!!
  W = mapping(mfilename,'trained',{Q(:,J), pars{2}, pars{3},L},[],m,length(J));
  W = setname(W,'centerm');
  return
end




lab      = getlab(s);
lablist  = getlablist(s);
[n,m,c]  = getsize(s);

if ~issym(s),
  error('Matrix should be symmetric.')
end

if pzero > n,
  error('Wrong third parameter.');
end

S = +s;

if pzero == 0,
  B = -repmat(1/n,n,n);               
  B(1:n+1:end) = B(1:n+1:end) + 1;    % B = eye(n) - ones(n,n)/n
  B = B * S * B;               % B is now the matrix of inner products 
else
  B = (S - S(:,pzero) * ones(1,n) + ones(n,1) * S(:,pzero)');
end

[Q, L] = eig(B);
Q      = real(Q);
l      = diag(real(L));
[lm,Z] = sort(-abs(l));
Q      = Q(:,Z);
l      = l(Z);                      % l - vector of eigenvalues sorted; 
                                    % decreasing absolute value 

[J,sig] = indeigs(l,alf,n);         % J - index of selected eigenvalues
L = l(J);                           % EIGENVALUES!!!

len =  length(J);


if pzero == 0,
  W = mapping(mfilename,'trained',{Q(:,J), mean(+s,2)', pzero, L},[],m,len);
else
  W = mapping(mfilename,'trained',{Q(:,J), +s(:,pzero)', pzero, L},[],m,len);
end
W = setname(W,'centerm');
return






function [J,sig] = indeigs(l,alf,n)

if strcmp(alf,'p'),                 % only positive eigenvalues
  J = find (l > 0);
elseif strcmp(alf,'n'),             % only negative eigenvalues
  J = find (l < 0);
elseif alf > 1,                     % alf = number of eigenvalues 
  if alf == inf,
	 cs = cumsum(abs(l));
	 nn = min(find(cs./cs(end) == 1));
	 J  = (1:nn)';      
  elseif alf > n,
    error('The second parameter is too large.')
  else
    J  = (1:alf)';
  end 
elseif alf > 0,                     % alf in (0,1), percentage 
  cs = cumsum(abs(l));
  nn = min(find (cs./cs(end) >= alf));
  J  = (1:nn)';  
else  
  error('Wrong second parameter.');
end

if isempty(J),
  error('Wrong choice of alf or n, the subspace cannot be found.');
end

I1  = find(l(J) > 0);
I2  = find(l(J) < 0);
sig = [length(I1) length(I2)];

[ll,K1] = sort(-l(J(I1)));              
[ll,K2] = sort(l(J(I2)));
J       = [J(I1(K1)); J(I2(K2))];   % J - index of selected eigenvalues; SORTED;
                                    % first decreasing positive, then increasing negative
return
