%KPSEM Kernel-based Pseudo-Euclidean Linear Embedding
%
%   [W,SIG,L] = KPSEM(K,ALF,KC)
%             OR
%   [W,SIG,L] = KPSEM(W,ALF)
%
% INPUT
%   K   NxN kernel or symmetric similarity matrix (dataset)
%   W   Trained linear embedding into a pseudo-Euclidean space
%   ALF Parameter determining the dimensionality and the mapping (optional, defaulf: Inf)
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
%   KC  1/0 Parameter specifying whether the kernel should be centered (1) or not (0)
%       (optional, default: 1, centering the kernel)
%
% OUTPUT
%   W   Linear embedding into a pseudo-Euclidean space
%   SIG Signature of the pseudo-Euclidean space
%   L   Sorted list of eigenvalues of the embedding
%
% DEFAULTS
%   ALF = Inf
%   KC  = 1
%
% DESCRIPTION
% Finds a linear mapping (projection) onto an M-dimensional pseudo-Euclidean
% subspace based on a kernel or a symmetric similarity matrix K.  M is determined
% by ALF, e.g. such that at least the fraction ALF of the total variance is
% preserved. If KC = 1, then K is centered and the mean vector in the embedded space
% lies at the origin (RECOMMENDED); if K = 0, then the kernel is used as provided.
%
% If X = K*W and W is a perfect embedding, then the following should hold (up
% to numerical accuracy):
%       X*J*X' = Kc,
% where J = diag ([ONES(SIG(1),1);  -ONES(sig(2),1)])
% Note that Kc may be different from K, e.g. when Kc is the centered version of K.
%
% The parameter SIG describes the signature of the subspace. L is a sorted list of
% eigenvalues corrsponding to the variances in the found (pseudo-)Euclidean space.
%
% A trained mapping can be reduced further by:
%   [W,SIG,L] = KPSEM(W,ALF)
%
% SEE ALSO
% MAPPINGS, DATASETS, PCA, PSEM
%
% REFERENCE
% 1. L. Goldfarb, A unified approach to pattern recognition, Pattern Recognition, vol.17, 575-582, 1984.
% 2. E. Pekalska, P. Paclik, and R.P.W. Duin, A Generalized Kernel Approach to Dissimilarity-based
%    Classification, Journal of Machine Learning Research, vol.2, no.2, 175-211, 2002.

% Copyright: Elzbieta Pekalska, e.pekalska@ewi.tudelft.nl
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands


function [W,sig,L,Q,Kcent] = KPSEM(K,alf,kc,prec)

if nargin < 4 | isempty(prec),
  prec = 1e-4;
end
if nargin < 3 | isempty(kc),
  kc = 1;
end
if nargin < 2 | isempty(alf),
  alf = inf;
end
if nargin < 1 | isempty(K),
  W = mapping(mfilename,{alf,kc,prec});
  W = setname(W,'Kernel-based PE Embedding');
  return
end


if (isdataset(K) | isa(K,'double')),
  if ismapping(alf),

    % APPLY MAPPING: project new data using the trained mapping.
    [m,n] = size(K);
    pars  = getdata(alf);

    % Parameters
    Q  = pars{1};  % Eigenvectors
    me = pars{2};  % Vector of the average original kernel values
    L  = pars{3};  % Eigenvalues

    if ~isempty(me),
    % centering kernel
      B = -repmat(1/n,n,n);
      B(1:n+1:end) = B(1:n+1:end) + 1;     % B = eye(n) - ones(n,n)/n
      K = (K - me(ones(m,1),:)) * B;
    end
    W = K * Q * diag(sqrt(abs(L))./L);
    if isdataset(W),
      W.name = ['Projected '  updname(W.name)];
      W.user = pars{4};   % Signature
    end
    return;
  end
end



% REDUCE ALREADY TRAINED MAPPING
if ismapping(K),
  pars  = getdata(K);

  Q  = pars{1};
  L  = pars{3};
  m  = size(Q,1);

  [ll,P] = sort(-abs(L));
  L = L(P);
  Q = Q(:,P);
  [J,sig] = seleigs(L,alf,pars{5}); % J is the index of selected eigenvalues
  Q = Q(:,J);                       % Eigenvectors
  L = L(J);                         % Eigenvalues

  W = mapping(mfilename,'trained',{Q,pars{2},L,sig,pars{5}},[],m,length(J));
  W = setname(W,'Kernel-based PE Embedding');
  return
end




% TRAIN MAPPING

% Tolerance value used in comparisons
if mean(+K(:)) < 1,
  tol = 1e-12;
else
  tol = 1e-10;
end

[n,m] = size(K);

K = +K;
if ~issym(K,tol),
  prwarning(1,'Kernel should be symmetric. It is made so by averaging.')
  K = 0.5 * (K+K');
end

if kc ~= 0 & kc ~= 1,
  error('Wrong third parameter.');
end

me = mean(K,2)';

if kc == 0,
  % Use the kernel as it is
  ;
else
  % Project the data such that the mean lies at the origin
  B = -repmat(1/n,n,n);
  B(1:n+1:end) = B(1:n+1:end)+1;  % B = eye(n) - ones(n,n)/n
  K = B * K * B;            % K is now the centered matrix of inner products
  K = 0.5 * (K+K');         % Make sure that symmetry holds after centering
  clear B;
end

[Q, L] = eig(K);
Q      = real(Q);
l      = diag(real(L));
[lm,Z] = sort(-abs(l));
Q      = Q(:,Z);
l      = l(Z);                % Eigenvalues are sorted by decreasing absolute value

[J,sig] = seleigs(l,alf,prec);% J is the index of selected eigenvalues
L = l(J);                     % Eigenvalues
Q = Q(:,J);                   % Eigenvectors


% Determine the mapping
if kc ==1,
  W = mapping(mfilename,'trained',{Q,me,L,sig,prec},[],m,sum(sig));
else
  W = mapping(mfilename,'trained',{Q,[],L,sig,prec},[],m,sum(sig));
end
W = setname(W,'Kernel-based PE Embedding');
return
