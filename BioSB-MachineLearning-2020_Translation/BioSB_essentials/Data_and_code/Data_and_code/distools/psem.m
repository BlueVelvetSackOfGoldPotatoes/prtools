%PSEM Pseudo-Euclidean Linear Embedding
%
%       [W,SIG,L] = PSEM(D,ALF,P)
%                 OR
%       [W,SIG,L] = PSEM(W,ALF)
%
% INPUT
%   D   NxN symmetric dissimilarity matrix (dataset)
%   W   Trained linear embedding into a pseudo-Euclidean space
%   ALF Parameter determining the dimensionality and the mapping (optional, default: Inf)
%       (0,1)   - fraction of the total (absolute value) preserved variance
%        Inf    - no dimensionality reduction, keeping all dimensions (it's noisy)
%       'p'     - projection into a Euclidean space based on positive eigenvalues only
%       'PARp'  - projection into a Euclidean space based on the PAR fraction of
%                 positive eigenvalues; e.g. ALF = '0.9p'
%       'n'     - projection into a Euclidean space based on negative eigenvalues only
%       'PARn'  - projection into a (negative) Euclidean space based on the PAR fraction
%                 of negative eigenvalues; e.g. ALF = '0.7n'
%       'P1pP2n'- projection into a Euclidean space based on the P1 positive eigenvalues
%                 and P2 negative eigenvalues; e.g. ALF = '0.7p0.1n', ALF = '7p2n'
%       1 .. N  - number of dimensions in total
%       [P1 P2] - P1 dimensions or preserved fraction of variance in the positive subspace
%                 and P2 dimensions or preserved fraction of variance in the negative
%                 subspace; e.g. ALF = [5 10], ALF = [0.9 0.1]
%   P   Integer between 0 and N specifying which object is mapped at the origin;
%       0 stands for the mean; (optional, default: 0)
%
% OUTPUT
%   W   Linear embedding into a pseudo-Euclidean space
%   SIG Signature of the space
%   L   List of eigenvalues
%
% DEFAULT
%   P   = 0
%   ALF = INF
%
% DESCRIPTION
% Linear mapping W onto an M-dimensional pseudo-Euclidean subspace from a symmetric,
% square dissimilarity matrix D such that the dissimilarities are preserved. M
% M is determined by ALF. E.g., the subspace is found such that at least a fraction
% ALF of the total variance is preserved for ALF in (0,1). The resulting X is found
% by D*W. The parameter SIG describes the signature of the subspace. L is a sorted
% list of eigenvalues describing the variances in the (pseudo-)Euclidean space.
%
% A trained mapping can be reduced further by:
%   [W,SIG,L] = PSEM(D,ALF)
%
% SEE ALSO
% MAPPINGS, DATASETS, AUGPSEM, PCA
%
% LITERATURE
% 1. L. Goldfarb, A unified approach to pattern recognition, Pattern Recognition, vol.17,
% 575-582, 1984.
% 2. E. Pekalska, P. Paclik, and R.P.W. Duin, A Generalized Kernel Approach to
% Dissimilarity-based Classification, Journal of Machine Learning Research,
% vol.2, no.2, 175-211, 2002.
%

% Copyright: Elzbieta Pekalska, ela.pekalska@googlemail.com
% Faculty EWI, Delft University of Technology and
% School of Computer Science, University of Manchester



function [W,sig,L,Q] = psem(d,alf,pzero,prec)

if nargin < 4 | isempty(prec), prec = 1e-4; end
if nargin < 3 | isempty(pzero), pzero = 0; end
if nargin < 2 | isempty(alf), alf = inf; end
if nargin < 1 | isempty(d),
  W = mapping(mfilename,{alf,pzero,prec});
  W = setname(W,'PE embedding');
  return
end



if (isdataset(d) | isa(d,'double'))
  if ismapping(alf)

    % APPLY THE MAPPING
    pars  = getdata(alf);
    [m,n] = size(d);
    d     = d.^2;

    Q   = pars{1};  % Eigenvectors
    me  = pars{2};  % Vector of the average square original dissimilarities
    p   = pars{3};  % p=0 -> the mean of the embedded configuration lies at 0, otherwise, it lies at pzero
    L   = pars{4};  % Eigenvalues

    % Project new data depending on p
    % (whether the mean or other object lies at the origin)
    if p == 0,
      B = -repmat(1,n,n)/n;
      B(1:n+1:end) = B(1:n+1:end) + 1;     % B = eye(n) - ones(n,n)/n
      W = -0.5 * (d - me(ones(m,1),:)) * B * Q * diag(sqrt(abs(L))./L);
    else
      W =  0.5 * (d(:,p) * ones(1,n) + me(ones(m,1),:) - d) * Q * diag(sqrt(abs(L))./L);
    end

    % Store signature in the USER field
    if isdataset(W),
      W.user = pars{5};   % Signature
      W.name = ['Projected '  updname(W.name)];
    end
    return
  end
end



% REDUCE A TRAINED MAPPING
if ismapping(d)
  pars = getdata(d);
  Q    = pars{1};
  L    = pars{4};
  m    = size(Q,1);

  [ll,K] = sort(-abs(L));
  L = L(K);
  Q = Q(:,K);
  [J,sig] = seleigs(L,alf,pars{6});
  Q = Q(:,J);        % Eigenvectors
  L = L(J);          % Eigenvalues

  W = mapping(mfilename,'trained',{Q, pars{2},pars{3},L,pars{5},pars{6}},[],m,length(J));
  W = setname(W,'PE embedding');
  return
end



% TRAIN THE MAPPING
% Tolerance value used in comparisons
if mean(+d(:)) < 1,
  tol = 1e-12;
else
  tol = 1e-10;
end

[n,m] = size(d);
if ~issym(d,tol),
  prwarning(1,'Matrix should be symmetric. It is made symmetric by averaging.')
  d = 0.5*(d+d');
end

if pzero > n,
  error('Wrong third parameter.');
end

d = (+d).^2;

if pzero == 0,
  % Project the data such that the mean lies at the origin
  B = -repmat(1/n,n,n);
  B(1:n+1:end) = B(1:n+1:end) + 1; % B = eye(n) - ones(n,n)/n
  B = -0.5 * B * d * B;            % B is now the matrix of inner products
else
  % Project the data such that pzero's object lies at the origin
  B = 0.5 * (d(:,pzero) * ones(1,n) + ones(n,1) * d(:,pzero)' - d);
end
B = 0.5*(B+B');                    % Make sure B is symmetric

[Q, L] = eig(B);
Q      = real(Q);
l      = diag(real(L));
[lm,Z] = sort(-abs(l));
Q      = Q(:,Z);
l      = l(Z);                     % Eigenvalues are sorted by decreasing absolute value

[J,sig] = seleigs(l,alf,prec);     % J is the index of the selected eigenvalues
L = l(J);                          % Eigenvalues
Q = Q(:,J);                        % Eigenvectors

%A  = Q * diag(sqrt(abs(L)));      % Data in a pseudo-Euclidean space

% Determine the mapping depending on pzero
if pzero == 0,
  W = mapping(mfilename,'trained',{Q,mean(+d,2)',pzero,L,sig,prec},[],m,sum(sig));
else
  W = mapping(mfilename,'trained',{Q,+d(:,pzero)',pzero,L,sig,prec},[],m,sum(sig));
end
W = setname(W,'PE embedding');
return
