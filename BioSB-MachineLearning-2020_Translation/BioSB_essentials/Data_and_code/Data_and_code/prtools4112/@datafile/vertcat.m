%VERTCAT Vertical concatenation of datafiles (object extension)
%
%    C = [A;B]
%
% The datafiles A and B are vertically concatenated, i.e. the
% objects of B are added to the dataset A. This is consistent with 
% the vertical concatenation of datasets.
%
% The datafiles should be of the same type. It is assumed that
% the preprocessing and postprocessing fields are equal. If not, a
% warning is generated and those of A are used.
%
% See also DATAFILES

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = vertcat(varargin)
		prtrace(mfilename,2);

	a = varargin{1}; start = 2;
	if nargin == 1, return, end          % a call like A = [B]
	if isempty(a) | prod(size(a))==0     % a call like A = [ []; B ...]
		a = varargin{2};
		isdatafile(a);
		if length(varargin) == 2, return; end
		start = 3;
	end
		
	while length(varargin) >= start
		b = varargin{start};
		isdatafile(b);
    
		if b.type ~= a.type
			error('Datafiles should be of the same type to be concatenated')
		end
    
    if ~isequal(a.preproc,b.preproc) | ~isequal(a.postproc,b.postproc)
      prwarning(1,'Preprocessing or postprocessing fields are not equal')
    end
		
		objsize = size(a,1)+size(b,1);
		
		if ~isequal(a.files,b.files)
			file_indexa = getident(a.dataset,'file_index');
			file_indexb = getident(b.dataset,'file_index');
			nfilesa = size(a.files,1);
			file_indexb(:,1) = file_indexb(:,1) + repmat(nfilesa,size(file_indexb,1),1);
			a.files = [a.files; b.files];
			a.dataset = [a.dataset; b.dataset];
			a.dataset = setident(a.dataset,[file_indexa; file_indexb],'file_index');
		else
			a.dataset = [a.dataset; b.dataset];
		end
		a.dataset = setobjsize(a.dataset,objsize);
		start = start+1;
	end
		
return
