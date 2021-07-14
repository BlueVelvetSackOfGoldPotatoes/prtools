%EUCLNESS Euclideaness of a square dissimilarity matrix
%
%   C = EUCLNESS(D,N)
%
% Computes how well the square dissimilarity matrix D can be 
% embedded in an Euclidean space: 0 < C <= 1
%
% C is computed by performing the Pseudo-Euclidean embedding.
% The sum of all positive eigenvalues divided by the sum of
% the absolute values of all variances is defined as C.
%
% SEEALSO
% GOLDFARBM

% Copyright: R.P.W. Duin, r.p.w.duin@ewi.tudelft.nl
% Faculty of Electr. Eng., Mathematics and Computer Science
% TU Delft, P.O. Box 5038, 2600 GA Delft, The Netherlands

function C = euclness(D,N)

if nargin < 2
    [W,S,L] = goldfarbm(D);
    C = sum(L(find(L > 0)))/sum(abs(L));
else
    [m,k] = size(D);
    if m ~= k
        error('Dissimilarity matrix should be square')
    end
    C = 0;
    J = randperm(m);
    J = J(1:min(round(25*m/N),m));
    for j=J
        [DD,K] = sort(D(j,:));
        K = K(1:N);
        E = D(K,K);
        C = C + euclness(E);
    end
    C = C/length(J);
end

    