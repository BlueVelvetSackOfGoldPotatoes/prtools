%GETLABELS Get labels field in mapping
%
%	    LABELS = GETLABELS(W)
%
% LABELS will be used for assigning feature labels (FEATLAB) to the
% output dataset D of a mapping D = A*W, or D = MAP(A,W). Note that
% the labels of D are the labels of the dataset A in this example.

% $Id: getlabels.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function labels = getlabels(w)
		prtrace(mfilename,2);
labels = w.labels;
return
