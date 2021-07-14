%COMBINEKERNELS linear kernel combination
% 
%  C = COMBINEKERNELS({K1,K2,..},WEIGHTS)
% 
% INPUT
%  KERNELS Cell array with datasets containing kernels of the same size
%  WEIGHTS Weights with which the kernels will be combined (default: ones(length(kernels),1))
%
% OUTPUT
%  C       Combined kernel dataset
%
% SEE ALSO
% MAPPINGS, DATASETS


function ck = combinekernels(kernels,weights)

if(~iscell(kernels))
   error('Parameter ''kernels'' should be an cell array containing the kernel datasets');
end;

if(nargin < 2 | isempty(weights))
   weights = ones(length(kernels),1);
else
   if(length(weights) ~= length(kernels))
      error('Number of weights should correspond with number of kernels');
   end;
end;

ck = weights(1) * kernels{1};
for i = 2:length(kernels)
   ck = ck + weights(i) * kernels{i};
end;


