%SETDATA Set data field in mapping or dataset
%
% 	W = SETDATA(W,DATA,FIELD)
% 	W = SETDATA(W,DATA,N)
%
%   A = SETDATA(A,DATA,FEATLAB)
%
% INPUT
%   W        Mapping
%   DATA     Data to be put in the data field.
%   FIELD    String, name of data field structure to be used for DATA
%            (optional)
%   N        Index of cell array to be used for DATA (optional)
%
%   A        Dataset
%   FEATLAB  Desired feature labels for dataset (optional)
%
% OUTPUT
%   W        Mapping
%   A        Dataset
%
% DESCRIPTION
% This routine can be used to store data in the data fields of either a
% mapping W or a dataset A.
%
% The data field of a mapping consists of a matrix, cell array or a structure. 
% In case nor FIELD neither N are given the entire dats field is replaced by 
% DATA. In case the data field is a structure DATA is assigned to field FIELD.
% In case the datafield is a cell array, DATA is assigned to cell N.
% DATA cannot be a structure in case of untrained or fixed mappings.
%
% The data field of a dataset A is an array of doubles. It is replaced by 
% DATA which may be doubles or another dataset, which will be converted to 
% doubles. The numbers of objects in A and DATA should be equal. The feature 
% labels of A are replaced by FEATLAB, or, if not supplied and DATA is a 
% dataset by the feature labels of DATA.  Labels and class probabilities of 
% A are preserved.
%
% SEE ALSO
% MAPPINGS, DATASETS

% $Id: setdata.m,v 1.8 2008/10/29 16:39:22 duin Exp $

function a = setdata(a,b,featlab)

	prtrace(mfilename,2);
	
	nodatafile(a);
	
	if size(a,1) ~= size(b,1)
		error('Numbers of objects not equal')
	end
	%if size(a.data,2) ~= size(b,2)
	if size(a,2) ~= size(b,2)
		bsize = size(b);
		a.featsize = bsize(2:end);
		a.featlab = [];
%		a.featlab = [1:size(b,2)]';
		a.featdom = {};
%		a.featdom = cell(1,prod(bsize(2:end)));
		b = reshape(+b,bsize(1),prod(bsize(2:end)));
		prwarning(3,'Feature labels are removed');
	end
	
	a.data = +b;
	
	if nargin > 2 & ~isempty(featlab)
		if size(featlab,1) < size(b,2)
			error('Wrong number of features supplied')
		end
		a.featlab = featlab;
		%a.featdom = cell(1,size(b,2));
		a.featdom = {};
	elseif isa(b,'dataset')
		% no featlab given, use that of b
		a.featlab = b.featlab;
		a.featdom = b.featdom;
		prwarning(3,'Feature labels are reset according to input dataset')
	else
		;
	end
	
	return
