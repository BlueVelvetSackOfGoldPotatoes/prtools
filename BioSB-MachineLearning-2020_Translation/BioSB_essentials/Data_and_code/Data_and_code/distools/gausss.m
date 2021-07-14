%GAUSSS  A Gaussian function
%
%   f = gausss(D,s)
%
% D is assumed to be a distance value or matrix. 
% The values of f are in (0,1] for positive D.
%

function K = gausss(d,s)
if nargin < 2,
  s = 1;
end

K = exp(-d.^2/(2*s^2));
