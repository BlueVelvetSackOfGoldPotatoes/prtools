%RBNC Radial basis function neural network classifier
% 
% 	W = RBNC(A,UNITS)
%
% INPUT
%   A       Dataset
%   UNITS   Number of RBF units in hidden layer
%
% OUTPUT
%   W       Radial basis neural network mapping
%	 
% DESCRIPTION
% A feed-forward neural network classifier with one hidden layer with 
% UNITS radial basis units is computed for labeled dataset A. 
% Default UNITS is number of objects * 0.2, but not more than 100.
% Uses the Mathworks' Neural Network toolbox.
%
% If UNITS is NaN it is optimised by REGOPTC. This may take a long
% computing time and is often not significantly better than the default.
%
% This routine calls MathWork's SOLVERB routine (Neural Network toolbox) 
% as SOLVB.
%
% SEE ALSO
% MAPPINGS, DATASETS, LMNC, BPXNC, NEURC, RNNC, REGOPTC

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: rbnc.m,v 1.4 2007/06/19 11:45:08 duin Exp $

function w = rbnc(a,units)

	prtrace(mfilename);
	
	if exist('nnet') ~= 7
		error('Neural network toolbox not found')
	end
	
	if nargin < 2, units = []; end
	
	if (nargin <1) | isempty(a)
		% Create an empty mapping:
		w = mapping(mfilename,units);
		w = setname(w,'RBF Neural Network');
		return
	end
	
	if isempty(units)
		units = min(ceil(size(a,1)/5),100);
    prwarning(2,['no number of hidden units specified, assuming ' num2str(units)]);
	end
	

  if isnan(units) % optimize complexity parameter: number of neurons
		defs = {[]};
		parmin_max = [1,30];
		w = regoptc(a,mfilename,{units},defs,[1],parmin_max,testc([],'soft'),0);
		return
 	end

	if units > size(a,1)
		error('Number of hidden units should not increase datasize')
	end
	
	% Training target values.
	target_low  = 0.1;
	target_high = 0.9;

	islabtype(a,'crisp');
	isvaldfile(a,2,2); % at least 2 objects per class, 2 classes
	a = testdatasize(a);
	[m,k,c] = getsize(a); nlab = getnlab(a);

	% Set standard training parameters.
	disp_freq = inf;			% Display interval: switch off
	err_goal = 0.005*m;	  % Sum squared error goal, stop if reached
	sigma	   = 0.5;		    % RBF kernel width

	% Create target matrix: row C contains a high value at position C,
	% the correct class, and a low one for the incorrect ones (place coding).
	target = target_low * ones(c,c) + (target_high - target_low) * eye(c);
	target = target(nlab,:)';

	% Shift and scale the training set to zero mean, unit variance.
	ws = scalem(a,'variance');

	% Add noise to training set, as SOLVB sometimes has problems with
	% identical inputs.
	r = randn(m,k) * 1e-6; 

	% Compute RBF network.
	% RD I changed the below call from NEWRBE() to NEWRB() and added
	%    the number of units as parameter. NEWRBE always uses M units
	% net     = newrb(+(a*ws)'+r',target,sigma);
    % net     = newrb(+(a*ws)'+r',target,0,sigma,units,inf);
    % Amin: last parameter changed to 1e10 to work with new matlab versions
	net     = newrb(+(a*ws)'+r',target,0,sigma,units, 1e10);
	weight1 = net.IW{1,1}; weight2 = net.LW{2,1};
	bias1   = net.b{1}; bias2 = net.b{2};

	n_hidden_units = length(bias1);

	% Construct resulting map. First apply the shift and scale mapping WS.
	% The first layer then calculates EXP(-D), where D are the squared
	% distances to RBF kernel centers, scaled by the biases.
	w = ws*proxm(weight1,'distance',2);				% RBF distance map
	w = w*cmapm(bias1'.^(-2),'scale');				% Multiply by scale (sq. bias)
	w = w*cmapm(n_hidden_units,'nexp');				% Take negative exponential

	% Second layer is affine mapping on output of first layer, followed
	% by a sigmoid mapping.
	w = nodatafile*w*affine(weight2',bias2',[],getlablist(a))*sigm;

	w = setname(w,'RBF Neural Classf');

return
