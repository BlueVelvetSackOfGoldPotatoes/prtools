% VAT  Visual Assessment of cluster Tendency for distance matrices
%
%   DN = VAT(D)
%
% INPUT
%   D   NxN symmetric dissimilarity matrix (dataset)
%
% OUTPUT
%   DN  Reorded dissimilarity matrix
%
% DESCRIPTION
% Visualization of the distance matrix to emphasize cluster tendencies
% by reordering the rows and columns in the distance matrix.
%
% REFERENCE
% R.J.Hathaway, J.C.Bezdek, J.M.Huband, "Scalable visual assessment of
% cluster tendency for large data sets", Pattern Recognition, vol. 39,
% no. 7, 2006.
%

% Copyright: Pavel Paclik, Elzbieta Pekalska, ela.pekalska@googlemail.com
% Faculty EWI, Delft University of Technology and
% School of Computer Science, University of Manchester


function DN = vat(D)

n = size(D,1);
K = 1:n;
I = [];
J = [];
P = [];

[i,j] = mmind(D,'max');

P(1) = i(1);
I    = i(1);
J    = setdiff(K,I);

for r=2:n
  [i,j] = mmind(D(I,J),'min');
  i     = I(i(1));
  j     = J(j(1));

  P = [P j'];
  I = [I j'];
  J = setdiff(J,j);
end
DN = D(P,P);

% make linear stretch
mi = min(min(D));
ma = max(max(D));
k  = 256/(ma-mi);
DN = floor(k*DN-mi*k);
return




function [i,j] = mmind(R,FUNC)
% Return all indices that are maximum (minimum) in the matrix.
% Function is specified by the FUNC string.

eval(['[m,ind]=' FUNC '(' FUNC '(R));']);
ind   = find(R==m(1));
[i,j] = ind2sub(size(R),ind);
return
