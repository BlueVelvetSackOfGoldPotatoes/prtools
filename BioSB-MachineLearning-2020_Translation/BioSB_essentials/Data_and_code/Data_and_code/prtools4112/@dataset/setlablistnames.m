%SETLABLISTNAMES Reset the names of label lists
%
%       A = SETLABLISTNAMES(A,NEW_NAMES,J)
%       A = SETLABLISTNAMES(A,NEW_NAMES,OLD_NAMES)
%
% INPUT
%   A          - Dataset
%   NEW_NAMES  - String or character array
%   J          - Vector identifying lablist numbers
%   OLD_NAMES  - String or character array
%
% OUTPUT
%   A          - Dataset
%
% DESCRIPTION
% One or more names of the label lists are reset.
% J should have as many elements as names stored in NEW_NAMES.
% Default J=1, in which case NEW_NAMES should be a string.
% In case existing names are identified by OLD_NAMES, this
% charater array should have as many names as NEW_NAMES.
%
% SEE ALSO
% DATASETS, MULTI_LABELING, ADDLABELS, ADDLABLIST, CHANGELABLIST,
% CURLABLIST, GETLABLISTNAMES

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = setlablistnames(a,new,old)
	prtrace(mfilename,2)

if nargin < 3, old = 1; end

if ~isstr(new)
	error('Names should be given as strings')
end


if ~iscell(a.lablist)  % Multi-labels not yet set up, do it
	lablista = a.lablist;
	a.lablist = cell(2,3);
	a.lablist{1,1} = lablista;
	a.lablist{1,2} = a.prior;
	a.lablist{1,3} = a.cost;
	a.lablist{2,1} = 'default';
	a.lablist{2,2} = 1;
end


if isstr(old)
	if size(new,1) ~= size(old,1)
		error('Numbers of old and new names should be equal')
	end
	for j=1:size(old,1)
		ll = getlablistnames(a);
		n = strmatch(old(j,:),ll,'exact');
		%n = strmatch(old(j,:),a.lablist{end,1},'exact');
		if isempty(n)
			error('Desired label list not found')
		end
		a.lablist{end,1} = char(a.lablist{end,1},new(j,:));
		a.lablist{end,1}(n,:) = a.lablist{end,1}(end,:);
		a.lablist{end,1}(end,:) = [];
	end

else

	J = old;
	if size(new,1) ~= length(J)
		error('Numbers of new names should be equal to number of indices')
	end
	for j=1:length(J)
		n = J(j);
		if n >= size(a.lablist,1) | n < 1
			error('Wrong label list number')
		end
		a.lablist{end,1} = char(a.lablist{end,1},new(j,:));
		a.lablist{end,1}(n,:) = a.lablist{end,1}(end,:);
		a.lablist{end,1}(end,:) = [];
	end

end
