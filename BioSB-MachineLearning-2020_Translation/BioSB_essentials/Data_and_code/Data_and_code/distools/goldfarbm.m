%GOLDFARBM Goldfarb's mapping
%
%       [W,sig,L] = goldfarbm(D,alf)
%                 or
%       [W,sig,L] = goldfarbm(D,n)
%
%  Linear mapping W onto an n-dimensional pseudo-Euclidean subspace
%  X from a symmetric, square distance matrix D. X is determined later
%  by D*W. If alf is given, the subspace is found such that at least
%  a fraction alf of the total variance is preserved.
%
%  alf is a parameter:
%    (0,1)   - fraction of the total (absolute value) preserved variance
%    Inf     - no dimensionality reduction, i.e. keep all dimensions
%  When alf equals to 'p' (or 'n'), the projection is based on positive
%  (or negative) eigenvalues only, giving the result in a Euclidean space.
%  Note that alf can also be in the form of '0.8p', '9p','0.5n'. The
%  letter 'n' or 'p' is interpreted as above, while the number corresponds
%  either to the wanted dimensionality or to the variance preserved w.r.t.
%  the positive/negative eigenvalues only.
%
%  The parameter sig describes the signature of the subspace.
%  L is the sorted list of eigenvalues describing the variances
%  in the (pseudo-)Euclidean space.
%
%  Once found mapping can still be reduced by:
%
%       [V,sig,L] = goldfarbm(W,alf)
%                 or
%       [V,sig,L] = goldfarbm(W,n)
%
%
%  SEE ALSO
%  MAPPINGS, DATASETS, PCA, CENTERM
%
%
%  See also Goldfarb, L., A unified approach to pattern recognition,
%  Pattern Recognition, vol. 17, 1984, 575-582.
%


% Elzbieta Pekalska, e.pekalska@ewi.tudelft.nl
% Faculty of Electrical Engineering, Mathematics and Computer Science,
% Delft University of Technology, The Netherlands





function [W,sig,L,Q] = goldfarbm(d,alf,pzero)

if nargin < 3 | isempty(pzero), pzero = 0; end
if nargin < 2 | isempty(alf), alf = inf; end
if nargin < 1 | isempty(d)
   W = mapping(mfilename,alf,pzero);
   W = setname(W,'Goldfarbm');
   return
end



if (isdataset(d) | isa(d,'double'))
  if ismapping(alf)
    % APPLY MAPPING
    pars  = getdata(alf);
    [m,n] = size(d);
    d     = d.^2;

    Q  = pars{1};  % eigenvectors
    me = pars{2};  % vector of the average square original dissimilarities
    p  = pars{3};  % p = 0 - the mean of the embedded configuration lies at 0, otherwise lies at pzero
    L  = pars{4};  % eigenvalues

    if p == 0,
      Z = -repmat(1,n,n)/n;
      Z(1:n+1:end) = Z(1:n+1:end) + 1;     % Z = eye(n) - ones(n,n)/n
      W  = -0.5 * (d - me(ones(m,1),:)) * Z * Q * diag(sqrt(abs(L))./L);
    else
      W  =  0.5 * (d(:,p) * ones(1,n) + me(ones(m,1),:) - d) * Q * diag(sqrt(abs(L))./L);
    end
    if isdataset(W)
      sig = [length(find(L>=0)) length(find(L<0))];
      W   = setuser(W,sig);
    end
    return;
  end
end



% REDUCE ALREADY TRAINED MAPPING
if ismapping(d)
  pars  = getdata(d);
  Q  = pars{1};
  L  = pars{4};
  m  = size(Q,1);

  [ll,K] = sort(-abs(L));
  L = L(K);
  Q = Q(:,K);
  [J,sig] = seleigs(L,alf);           % J - index of selected eigenvalues
  Q = Q(:,J);

  L = L(J);                           % EIGENVALUES!!!
  W = mapping(mfilename,'trained',{Q, pars{2}, pars{3},L},[],m,length(J));
  W = setname(W,'Goldfarbm');
  return
end



% TRAIN MAPPING
[n,m] = size(d);

if ~issym(d,1e-12),
  prwarning(1,'Matrix should be symmetric. It is made symmetric by averaging.')
  d = 0.5*(d+d');
end


if pzero > n,
  error('Wrong third parameter.');
end

d = +d.^2;

if pzero == 0,
  B = -repmat(1/n,n,n);
  B(1:n+1:end) = B(1:n+1:end) + 1;    % B = eye(n) - ones(n,n)/n
  B = -0.5 * B * d * B;               % B is now the matrix of inner products
else
  B = 0.5 * (d(:,pzero) * ones(1,n) + ones(n,1) * d(:,pzero)' - d);
end

[Q, L] = eig(B);
Q      = real(Q);
l      = diag(real(L));
[lm,Z] = sort(-abs(l));
Q      = Q(:,Z);
l      = l(Z);                % l - vector of eigenvalues sorted;
                              % decreasing absolute value

[J,sig] = seleigs(l,alf);     % J - index of selected eigenvalues
L = l(J);                     % eigenvalues
Q = Q(:,J);                   % eigenvectors

%A  = Q * diag(sqrt(abs(L))); % data in a pseudo-Euclidean space

if pzero == 0,
  W = mapping(mfilename,'trained',{Q, mean(+d,2)', pzero, L},[],m,sum(sig));
else
  W = mapping(mfilename,'trained',{Q, +d(:,pzero)', pzero, L},[],m,sum(sig));
end
W = setname(W,'Goldfarbm');
return
