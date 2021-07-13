%CLASSSIZES Get sizes of classes in a dataset
%
%   [N,LABLIST] = CLASSSIZES(A)
%
% INPUT
%   A        Dataset
%
% OUTPUT
%   N        Vector of the class cardinalities
%   LABLIST  Label list 
%
% DESCRIPTION
% Returns class cardinalities of the dataset A. The order of the classes
% is identical to the list of class labels returned in LABLIST.

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Physics, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: classsizes.m,v 1.3 2006/09/26 12:49:54 duin Exp $

function [n,lablist] = classsizes(a)
	prtrace(mfilename,2);
	
	lablist = getlablist(a);
	c = size(lablist,1); % Get the number of classes
	if islabtype(a,'targets')
		n = size(a,1);
	else
		n = zeros(1,c);
		curn = curlablist(a);
		for j=1:c
			n(j) = sum(a.nlab(:,curn)==j);
		end
	end
	lablist = getlablist(a);
return;
