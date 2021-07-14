%PAIRWISEKM Pairwise kernel mapping
% 
%  W = PAIRWISEKM(A,SKERNEL,TYPE)
%  W = A*PAIRWISEKM([],SKERNEL,TYPE)
% 
% INPUT
%  A       Dataset on pairs, with user field containing in the rows the id's for 
%              the objects that make up the corresponding pair in the dataset.
%              These id's should map to the rows/columns of the source kernel (SKERNEL);
%  SKERNEL Kernel on objects that make up the pairs in dataset A
%  TYPE    Type (normalized ('n') or default ('')) (default: '')
%
% OUTPUT
%  W       Proximity mapping
%
% SEE ALSO
% MAPPINGS, DATASETS


function W = pairwisekm(A,skernel,type)

	prtrace(mfilename);
	
	if (nargin < 3) | (isempty(type))
      type = 'd';
   end
   if ((nargin < 2) | isempty(skernel))
      skernel = [];
   end
	

	% No data, return an untrained mapping.
	if (nargin < 1) | (isempty(A))
		W = mapping(mfilename,{skernel,type});
		W = setname(W,'Pairwise kernel mapping');
		return;
	end
      
   [m,k] = size(A);

   if(isempty(A.user) | size(A.user,2) ~= 2 | size(A.user,1) ~= m)
      error('A should contain a non-empty user field with two columns and as many rows as there are objects in the dataset');
   end;

  
	if (isfloat(skernel))
		% Definition of the mapping, just store parameters.
	   A = cdats(A,1);
		[m,k] = size(A);
		W = mapping(mfilename,'trained',{A,skernel,type},getlab(A));
		W = setname(W,'Pairwise kernel mapping');
										   
	elseif isa(skernel,'mapping')   

		% Execution of the mapping: compute a proximity matrix
		% between the input data A and B; output stored in W.
		w = skernel;
		[B,skernel,type] = deal(w.data{1},w.data{2},w.data{3});
		[n,k2] = size(B);

      D = zeros(m,n);
      idxA = A.user;
      idxB = B.user;
      for i = 1:m
         for j = 1:n
            D(i,j) = skernel(idxA(i,1),idxB(j,1)) * skernel(idxA(i,2),idxB(j,2)) + skernel(idxA(i,1),idxB(j,2)) * skernel(idxA(i,2),idxB(j,1)); 
         end;
      end;

      if(type == 'n')
         lAs = zeros(m,1);
         for i = 1:m
            lAs(i) = skernel(idxA(i,1),idxA(i,1)) * skernel(idxA(i,2),idxA(i,2)) + skernel(idxA(i,1),idxA(i,2)) * skernel(idxA(i,2),idxA(i,1));
         end;
         lBs = zeros(n,1);
         for i = 1:n
            lBs(i) = skernel(idxB(i,1),idxB(i,1)) * skernel(idxB(i,2),idxB(i,2)) + skernel(idxB(i,1),idxB(i,2)) * skernel(idxB(i,2),idxB(i,1));
         end;
         D = D .* (1 ./ sqrt(lAs * lBs'));
      end;
      W = setdat(A,D);	
		
	else
		error('Illegal SKERNEL argument.')
	end

return;



