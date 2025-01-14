function [e, thr] = dd_prc(a,w)
%DD_PRC Precision Recall curve 
%
%        E = DD_PRC(A,W)
%        E = DD_PRC(A*W)
%        E = A*W*DD_PRC
%
% Find for a (data description) method W the Precision Recall curve over
% dataset A.  The results are returned in a structure E, containing two
% fields. E.err contains the classification errors, E.thr contains the
% trhesholds for the different operating points. The curve can be
% plotted using PLOTROC.
%
% See also: plotroc, dd_auc, dd_error, simpleroc, dd_eer.
%

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% Use the same setup as testc

% When no input arguments are given, return an empty mapping
if nargin==0
	
	e = mapping(mfilename,'fixed');

elseif nargin == 1

	% Now we should have a mapped dataset, so the real work is done!

	% store the fact that we are making a Precision Recall curve
	e.type = 'prc';

	% for evaluation, we need both target and outlier objects:
	if ~isocset(a)
		error('I need an OC dataset for computing the Precision Recall curve.');
	end
	[It,Io] = find_target(a);
	if isempty(It)
		error('Dataset A does not contain target objects');
	end
	if isempty(Io)
		error('Dataset A does not contain outlier objects');
	end

	% get the labels of A:
	truelab = zeros(size(a,1),1);
	truelab(It) = 1;

	% check if we have sane results:
	if ~all(isfinite(+a))
		warning('dd_tools:NonfiniteOutputs',...
			'Some strange (non-finite) classifier outputs: can you check your classifier?');
		% only keep the outputs which have finite values:
		I = all(isfinite(+a),2);
		a = a(I,:);
	end
	% store the operating poiont for later:
	% First check if we are dealing with a mapping, or a classifier:
	fl = getfeatlab(a);
	% we don't have an operating point right now
	%DXD:  should we define it one time?? 
	e.op = [];

	% first find out where the output for the target objects are stored:
	tcolumn = [];
	if ~isempty(fl) % we can only find the target feature when feature
		             % labels are defined
		tcolumn = strmatch('target ',fl);
	end
	if isempty(tcolumn)
		warning('dd_tools:NoTargetFeature',...
				  'dd_roc cannot find the target feature, using feature 1.');
		tcolumn = 1;
	end
	% and now extract the required column 'resemblance to target set':
	a = +a(:,tcolumn);

	% now the real computation is done:
	[err,thr] = simpleprc(a,truelab);
	e.err = err;

	% Find the errors and the thresholds between the points on the curve:
	derr = diff(err)/2;
	e.thrcoords = [err(1,:); err(1:(end-1),:)+derr; err(end,:)];
	dthr = diff(thr)/2;
	if ~isempty(dthr) % in some cases there is just 1 threshold value
		               % defined :-( (sigh)
		e.thresholds = [thr(1); thr(1:(end-1))+dthr; thr(end)];
	else
		e.thresholds = [thr(1); thr(end)];
	end

else

	% Separate mapping and dataset are given, so we have to map the data
	% first:
	ismapping(w);
	istrained(w);

	e = feval(mfilename,a*w);

end

return
