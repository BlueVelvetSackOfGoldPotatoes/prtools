%KPCA Kernel Principal Component Analysis
%
%   [W,SIG] = KPCA(K,ALF)
%             OR
%   [W,SIG] = KPCA(W,ALF)
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
%
% OUTPUT
%   W   Kernel PCA mapping
%   SIG Signature of the kernel Pseudo-Euclidean space
%
% DEFAULTS
%   ALF = Inf
%
% DESCRIPTION
% Performs principal component analysis in a kernel space (either Hilbert or Krein
% space) by finding M significant directions. M is determined by ALF, e.g. such that
% at least the fraction ALF of the total variance is preserved.
%
% A trained mapping can be reduced further by:
%   [W,SIG] = KPCA(W,ALF)
%
% SEE ALSO
% MAPPINGS, DATASETS, PCA, PSEM
%
% REFERENCE
% B. Schölkopf, A. Smola, and K.-R. Müller. Kernel principal component analysis.
% in Advances in Kernel Methods - SV Learning, pages 327-352. MIT Press, Cambridge, MA, 1999.

% Copyright: Elzbieta Pekalska, e.pekalska@ewi.tudelft.nl
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function [W,sig] = kpca (K,alf)

if nargin < 2 | isempty(alf),
  alf = inf;
end
if nargin < 1 | isempty(K),
  W = mapping(mfilename,alf);
  W = setname(W,'Kernel PCA');
  return
end


if (isdataset(K) | isa(K,'double')),

  if ismapping(alf),
    % APPLY MAPPING: project new data using the trained mapping.
    [m,n] = size(K);
    pars  = getdata(alf);

    % Parameters
    Q  = pars{1};  % eigenvectors
    me = pars{2};  % vector of the average original kernel values

    % Centering the kernel
    B = -repmat(1/n,n,n);
    B(1:n+1:end) = B(1:n+1:end) + 1;     % B = eye(n) - ones(n,n)/n
    K = (K - me(ones(m,1),:)) * B;
    W = K*Q;
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
  [J,sig] = seleigs(L,alf);    % J is the index of selected eigenvalues
  Q = Q(:,J);                  % Eigenvectors
  L = L(J);                    % Eigenvalues

  W = mapping(mfilename,'trained',{Q,pars{2},L,pars{4}},[],m,length(J));
  W = setname(W,'Kernel PCA');
  return
end




% TRAIN MAPPING
K  = +K;
[n,m] = size(K);

if ~issym(K,1e-10),
  prwarning(1,'Kernel should be symmetric. It is made so by averaging.')
  K  = 0.5 * (K+K');
end

me = mean(K,2)';

% Project the data such that the mean lies at the origin
B = -repmat(1/n,n,n);
B(1:n+1:end) = B(1:n+1:end) + 1;  % B = eye(n) - ones(n,n)/n
K  = B * K * B;            % K is now the centered kernel
K  = 0.5 * (K+K');         % Make sure that K is symmetric after centering

[Q, L] = eig(K);
Q      = real(Q);
l      = diag(real(L));
[lm,Z] = sort(-abs(l));
Q      = Q(:,Z);
l      = l(Z);             % Eigenvalues are sorted by decreasing absolute value


[J,sig] = seleigs(l,alf);  % J is the index of selected eigenvalues
L = l(J);                  % eigenvalues
Q = Q(:,J);                % eigenvectors

% Normalize Q such that the eignevectors of the covariance
% matrix are orthonormal
Q = Q* diag(1./sqrt(abs(diag(Q'*K*Q))));

% Determine the mapping
W = mapping(mfilename,'trained',{Q,me,L,sig},[],m,sum(sig));
W = setname(W,'Kernel PCA');
return
